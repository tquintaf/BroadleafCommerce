------------------------
-- DROP TABLE STATEMENTS
------------------------
DROP TABLE blc_id_generation;
DROP TABLE blc_fulfillment_group_item;
DROP TABLE blc_fulfillment_group;
DROP TABLE blc_discrete_order_item;
DROP TABLE blc_bundle_order_item;
DROP TABLE blc_order_item;
DROP TABLE blc_personal_message;
DROP TABLE blc_order;
DROP TABLE blc_phone;
DROP TABLE blc_customer_phone;
DROP TABLE blc_address;
DROP TABLE blc_customer_address;
DROP TABLE blc_customer;
DROP TABLE blc_challenge_question;
DROP TABLE blc_country;
DROP TABLE blc_order_payment;
DROP TABLE blc_gift_card_payment;
DROP TABLE blc_giftwrap_order_item;
DROP TABLE blc_giftwrap_orderitem_xref;
DROP TABLE blc_shipping_rate;


--------------------------
-- CREATE TABLE STATEMENTS
--------------------------
--------------------------
-- blc_challenge_question
--------------------------
CREATE TABLE blc_challenge_question
(
  QUESTION_ID NUMBER(19,0) NOT NULL,
  QUESTION VARCHAR2(255)
  CONSTRAINT PK_BLC_CHALLENGE_QUESTION PRIMARY KEY(QUESTION_ID) USING INDEX TABLESPACE WEB_IDX1
);

--------------------------
-- blc_customer
--------------------------
CREATE TABLE blc_customer
(
  CUSTOMER_ID NUMBER(19,0) NOT NULL,
  CHALLENGE_ANSWER VARCHAR2(255) ,
  CHALLENGE_QUESTION_ID NUMBER(19,0) ,
  EMAIL_ADDRESS VARCHAR2(255) ,
  FIRST_NAME VARCHAR2(255) ,
  LAST_NAME VARCHAR2(255) ,
  PASSWORD VARCHAR2(255) ,
  PASSWORD_CHANGE_REQUIRED NUMBER(1,0) ,
  USER_NAME VARCHAR2(255) ,
  RECEIVE_EMAIL NUMBER(1,0) ,
  IS_REGISTERED NUMBER(1,0) ,
  CONSTRAINT PK_BLC_CUSTOMER PRIMARY KEY(CUSTOMER_ID) USING INDEX TABLESPACE WEB_IDX1,
  CONSTRAINT FK_CUSTOMER_QUESTION FOREIGN KEY (CHALLENGE_QUESTION_ID) REFERENCES blc_challenge_question(QUESTION_ID)
);

CREATE UNIQUE INDEX IX1_BLC_CUSTOMER ON blc_customer (USER_NAME) USING INDEX TABLESPACE WEB_IDX1;

--------------------------
--------------------------
-- blc_address
CREATE TABLE blc_address
(
  ADDRESS_ID NUMBER(19,0) NOT NULL,
  ADDRESS_LINE1 VARCHAR2(255) ,
  ADDRESS_LINE2 VARCHAR2(255) ,
  CITY VARCHAR2(255) ,
  COUNTRY VARCHAR2(255) ,
  POSTAL_CODE VARCHAR2(255) ,
  STANDARDIZED NUMBER(1,0) ,
  STATE_PROV_REGION VARCHAR2(255) ,
  COUNTY VARCHAR2(255) ,
  TOKENIZED_ADDRESS VARCHAR2(255) ,
  ZIP_FOUR VARCHAR2(255) ,
  COMPANY_NAME VARCHAR2(255) ,
  IS_DEFAULT NUMBER(1,0) ,
  IS_ACTIVE NUMBER(1,0) ,
  IS_BUSINESS NUMBER(1,0) ,
  FIRST_NAME VARCHAR2(255) ,
  LAST_NAME VARCHAR2(255) ,
  PRIMARY_PHONE VARCHAR2(255) ,
  SECONDARY_PHONE VARCHAR2(255) ,
  VERIFICATION_LEVEL VARCHAR2(255) ,
  CONSTRAINT PK_BLC_CUSTOMER_ADDRESS PRIMARY KEY(ADDRESS_ID) USING INDEX TABLESPACE WEB_IDX1
);

--------------------------
-- blc_customer_address
--------------------------
CREATE TABLE blc_customer_address
(
  CUSTOMER_ADDRESS_ID NUMBER(19,0) NOT NULL,
  ADDRESS_NAME VARCHAR2(255) ,
  CUSTOMER_ID NUMBER(19,0) NOT NULL,
  ADDRESS_ID NUMBER(19,0) NOT NULL,
  CONSTRAINT PK_BLC_CUSTOMER_ADDRESS PRIMARY KEY(ADDRESS_ID) USING INDEX TABLESPACE WEB_IDX1,
  CONSTRAINT FK_CUSTOMER_ADDRESS FOREIGN KEY (ADDRESS_ID) REFERENCES blc_address(ADDRESS_ID)
);

--------------------------
--------------------------
-- blc_phone
CREATE TABLE blc_phone
(
  PHONE_ID NUMBER(19,0) NOT NULL,
  PHONE_NUMBER VARCHAR2(255) ,
  IS_DEFAULT NUMBER(1,0) ,
  IS_ACTIVE NUMBER(1,0) ,
  CONSTRAINT PK_BLC_PHONE PRIMARY KEY(PHONE_ID) USING INDEX TABLESPACE WEB_IDX1
);

--------------------------
-- blc_customer_phone
--------------------------
CREATE TABLE blc_customer_phone
(
  CUSTOMER_PHONE_ID NUMBER(19,0) NOT NULL,
  PHONE_NAME VARCHAR2(255) ,
  CUSTOMER_ID NUMBER(19,0) NOT NULL,
  PHONE_ID NUMBER(19,0) NOT NULL,
  CONSTRAINT PK_BLC_CUSTOMER_PHONE PRIMARY KEY(PHONE_ID) USING INDEX TABLESPACE WEB_IDX1,
  CONSTRAINT FK_CUSTOMER_PHONE FOREIGN KEY (PHONE_ID) REFERENCES blc_address(PHONE_ID)
);

--------------------------
-- blc_order_payment
--------------------------
CREATE TABLE blc_order_payment
(
  PAYMENT_ID NUMBER(19,0) NOT NULL,
  ORDER_ID NUMBER(19,0) NOT NULL,
  ADDRESS_ID NUMBER(19,0),
  PHONE_ID NUMBER(19,0),
  AMOUNT NUMBER(12,2),
  REFERENCE_NUMBER VARCHAR2(255),
  PAYMENT_TYPE VARCHAR2(255),
  CONSTRAINT PK_BLC_ORDER_PAYMENT PRIMARY KEY(PAYMENT_ID) USING INDEX TABLESPACE WEB_IDX1,
  CONSTRAINT FK_ORDERPAYMENT_ORDER_fk FOREIGN KEY (ORDER_ID) REFERENCES blc_order(ORDER_ID),
  CONSTRAINT FK_ORDERPAYMENT_ADDRESS_fk FOREIGN KEY (ADDRESS_ID) REFERENCES blc_address(ADDRESS_ID),
  CONSTRAINT FK_ORDERPAYMENT_PHONE_fk FOREIGN KEY (PHONE_ID) REFERENCES blc_phone(PHONE_ID)
);

--------------------------
-- blc_gift_card_payment
--------------------------
CREATE TABLE blc_gift_card_payment
(
  PAYMENT_ID NUMBER(19,0) NOT NULL,
  REFERENCE_NUMBER VARCHAR2(255),
  PAN VARCHAR2(30),
  PIN VARCHAR2(30),
  CONSTRAINT PK_BLC_GIFT_CARD_PAYMENT PRIMARY KEY(PAYMENT_ID) USING INDEX TABLESPACE WEB_IDX1
);

--------------------------
-- blc_order
--------------------------
CREATE TABLE blc_order
(
  ORDER_ID NUMBER(19,0) NOT NULL,
  "TYPE" VARCHAR(255),
  CUSTOMER_ID NUMBER(19,0) NOT NULL,
  ORDER_STATUS NUMBER(19,0),
  CITY_TAX NUMBER(12,2),
  COUNTY_TAX NUMBER(12,2),
  STATE_TAX NUMBER(12,2),
  COUNTRY_TAX NUMBER(12,2),
  TOTAL_TAX NUMBER(12,2),
  TOTAL_SHIPPING NUMBER(12,2),
  ORDER_SUBTOTAL NUMBER(12,2),
  ORDER_TOTAL NUMBER(12,2),
  DATE_SUBMITTED DATE,
  DATE_CREATED DATE,
  CREATED_BY VARCHAR(255),
  DATE_UPDATED DATE,
  UPDATED_BY VARCHAR2(255),
  NAME VARCHAR2(255),
  CONSTRAINT PK_BLC_ORDER PRIMARY KEY(ORDER_ID) USING INDEX TABLESPACE WEB_IDX1,
  CONSTRAINT FK_ORDER_CUSTOMER_fk FOREIGN KEY (CUSTOMER_ID) REFERENCES blc_customer(CUSTOMER_ID)
);

--------------------------
-- blc_personal_message
--------------------------
CREATE TABLE blc_personal_message
(
  PERSONAL_MESSAGE_ID NUMBER(19,0) NOT NULL,
  MESSAGE_TO VARCHAR2(255),
  MESSAGE_FROM VARCHAR2(255),
  MESSAGE VARCHAR2(255),
  CONSTRAINT PK_BLC_PERSONAL_MESSAGE PRIMARY KEY(PERSONAL_MESSAGE_ID) USING INDEX TABLESPACE WEB_IDX1
);

--------------------------
-- blc_order_item
--------------------------
CREATE TABLE blc_order_item
(
  ORDER_ITEM_ID NUMBER(19,0) NOT NULL,
  CATEGORY_ID NUMBER(19,0),
  ORDER_ID NUMBER(19,0),
  RETAIL_PRICE NUMBER(12,2),
  SALE_PRICE NUMBER(12,2),
  PRICE NUMBER(12,2),
  QUANTITY NUMBER(10,0),
  PERSONAL_MESSAGE_ID NUMBER(19,0),
  CONSTRAINT PK_BLC_ORDER_ITEM PRIMARY KEY(ORDER_ITEM_ID) USING INDEX TABLESPACE WEB_IDX1,
  CONSTRAINT FK_ORDER_MESSAGE FOREIGN KEY (PERSONAL_MESSAGE_ID) REFERENCES blc_personal_message(PERSONAL_MESSAGE_ID)
);

--------------------------
-- blc_bundle_order_item
--------------------------
CREATE TABLE blc_bundle_order_item
(
  ORDER_ITEM_ID NUMBER(19,0) NOT NULL,
  NAME VARCHAR2(255) NOT NULL,
  CONSTRAINT PK_BLC_BUNDLE_ORDER_ITEM PRIMARY KEY(ORDER_ITEM_ID) USING INDEX TABLESPACE WEB_IDX1
);

--------------------------
-- blc_discrete_order_item
--------------------------
CREATE TABLE blc_discrete_order_item
(
  ORDER_ITEM_ID NUMBER(19,0) NOT NULL,
  SKU_ID NUMBER(19,0) NOT NULL,
  PRODUCT_ID NUMBER(19,0),
  BUNDLE_ORDER_ITEM_ID NUMBER(19,0),
  CONSTRAINT PK_BLC_DISCRETE_ORDER_ITEM PRIMARY KEY(ORDER_ITEM_ID) USING INDEX TABLESPACE WEB_IDX1,
  CONSTRAINT FK_BUNDLE_ORDER_ITEM FOREIGN KEY (BUNDLE_ORDER_ITEM_ID) REFERENCES blc_bundle_order_item(ORDER_ITEM_ID)
);

--------------------------
-- blc_giftwrap_order_item
--------------------------
CREATE TABLE blc_giftwrap_order_item
(
  ORDER_ITEM_ID NUMBER(19,0) NOT NULL,
  CONSTRAINT PK_BLC_GIFTWRAP_ORDER_ITEM PRIMARY KEY(ORDER_ITEM_ID) USING INDEX TABLESPACE WEB_IDX1
);

--------------------------
-- blc_giftwrap_orderitem_xref
--------------------------
CREATE TABLE blc_giftwrap_orderitem_xref
(
  GIFTWRAP_ITEM_ID NUMBER(19,0) NOT NULL,
  ORDER_ITEM_ID NUMBER(19,0) NOT NULL
);

--------------------------
-- blc_fulfillment_group
--------------------------
CREATE TABLE blc_fulfillment_group
(
  ID NUMBER(19,0) NOT NULL,
  ORDER_ID NUMBER(19,0) NOT NULL,
  REFERENCE_NUMBER VARCHAR(255),
  ADDRESS_ID NUMBER(19,0),
  PHONE_ID NUMBER(19,0),
  METHOD VARCHAR(255),
  RETAIL_PRICE NUMBER(12,2),
  SALE_PRICE NUMBER(12,2),
  PRICE NUMBER(12,2),
  CITY_TAX NUMBER(12,2),
  COUNTY_TAX NUMBER(12,2),
  STATE_TAX NUMBER(12,2),
  COUNTRY_TAX NUMBER(12,2),
  TOTAL_TAX NUMBER(12,2),
  MERCHANDISE_TOTAL NUMBER(12,2),
  TOTAL NUMBER(12,2),
  "TYPE" VARCHAR(255),
  QUANTITY NUMBER(10,0),
  DELIVERY_INSTRUCTION VARCHAR(255),
  PERSONAL_MESSAGE_ID NUMBER(19,0),
  IS_PRIMARY NUMBER(1,0) ,
  CONSTRAINT PK_BLC_FULFILLMENT_GROUP PRIMARY KEY(ID) USING INDEX TABLESPACE WEB_IDX1,
  CONSTRAINT FK_FULFILLMENT_GROUP_MESSAGE FOREIGN KEY (PERSONAL_MESSAGE_ID) REFERENCES blc_personal_message(PERSONAL_MESSAGE_ID)
);

--------------------------
-- blc_target_content
--------------------------
CREATE TABLE blc_target_content
(
  TARGET_CONTENT_ID NUMBER(19,0) NOT NULL,
  PRIORITY  NUMBER(19,0) NOT NULL,
  CONTENT_TYPE VARCHAR(255) NOT NULL,
  CONTENT_NAME VARCHAR(255) NOT NULL,
  URL VARCHAR2(100),
  CONTENT VARCHAR2(2000),
  ONLINE_DATE DATE,
  OFFLINE_DATE DATE,
  CONSTRAINT PK_BLC_TARGET_CONTENT PRIMARY KEY(TARGET_CONTENT_ID) USING INDEX TABLESPACE WEB_IDX1
  );

--------------------------
-- blc_fulfillment_group_item
--------------------------
CREATE TABLE blc_fulfillment_group_item
(
  ID NUMBER(19,0) NOT NULL,
  ORDER_ID NUMBER(19,0) NOT NULL,
  FULFILLMENT_GROUP_ID NUMBER(19,0) NOT NULL,
  QUANTITY NUMBER(10,0),
  RETAIL_PRICE NUMBER(12,2),
  SALE_PRICE NUMBER(12,2),
  PRICE NUMBER(12,2),
  CONSTRAINT PK_BLC_FULFILLMENT_GROUP_ITEM PRIMARY KEY(ID) USING INDEX TABLESPACE WEB_IDX1
);

--------------------------
-- blc_shipping_rate
--------------------------
CREATE TABLE blc_shipping_rate
(
  ID NUMBER(19,0) NOT NULL,
  FEE_TYPE VARCHAR2(255),
  FEE_SUB_TYPE VARCHAR2(255),
  FEE_BAND NUMBER(19,0),
  BAND_UNIT_QTY NUMBER(12,2),
  BAND_RESULT_QTY NUMBER(12,2),
  BAND_RESULT_PCT NUMBER(19,0),
  CONSTRAINT PK_BLC_SHIPPING_RATE PRIMARY KEY(ID) USING INDEX TABLESPACE WEB_IDX1
);


--------------------------
-- blc_id_generation
--------------------------
CREATE TABLE blc_id_generation
(
  ID_TYPE VARCHAR2(255) NOT NULL,
  BATCH_START NUMBER(19,0) ,
  BATCH_SIZE NUMBER(19,0) ,
  CONSTRAINT BLC_ID_GENERATION PRIMARY KEY(ID_TYPE) USING INDEX TABLESPACE WEB_IDX1
);

--------------------------
-- BLC_COUNTRY
--------------------------
CREATE TABLE BLC_COUNTRY
(
  ABBREVIATION VARCHAR2(2) NOT NULL,
  NAME VARCHAR2(255) ,
  CONSTRAINT PK_BLC_COUNTRY PRIMARY KEY(ABBREVIATION) USING INDEX TABLESPACE WEB_IDX1
);
------------------------
-- INSERT COUNTRIES
------------------------
INSERT INTO BLC_COUNTRY VALUES ( 'US', 'United States' );

------------------------
-- INSERT TEST CHALLENGE QUESTIONS
------------------------
INSERT INTO blc_challenge_question ( QUESTION_ID, QUESTION ) VALUES ( 1, 'What is your place of birth?' );;
INSERT INTO blc_challenge_question ( QUESTION_ID, QUESTION ) VALUES ( 2, 'What is your Mother''s maiden name?' );
INSERT INTO blc_challenge_question ( QUESTION_ID, QUESTION ) VALUES ( 3, 'What is the name of your favorite pet?' );

------------------------
-- INSERT TEST ID GENERATION
------------------------
INSERT INTO BLC_ID_GENERATION ( ID_TYPE, BATCH_START, BATCH_SIZE ) VALUES ( 'org.broadleafcommerce.profile.domain.Customer', 1, 10 );

------------------------
-- INSERT TEST SHIPPING RATES
------------------------
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES()
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(1,'SHIPPING',	'ALL',	1,	29.99,	8.5,	0)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(2,'SHIPPING',	'ALL',	2,	44.99,	10.5,	0)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(3,'SHIPPING',	'ALL',	3,	59.99,	12.5,	0)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(4,'SHIPPING',	'ALL',	4,	74.99,	15.5,	0)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(5,'SHIPPING',	'ALL',	5,	99.99,	18.5,	0)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(6,'SHIPPING',	'ALL',	6,	149.99,	22.5,	0)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(7,'SHIPPING',	'ALL',	7,	199.99,	25.5,	0)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(8,'SHIPPING',	'ALL',	8,	99999999.99,	0,	15)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(9,'SHIPPING',	'ALSK',	1,	85.7,	30,	0)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(10,'SHIPPING',	'ALSK',	2,	99999999.99,	0,	35)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(11,'SHIPPING',	'HAWI',	1,	85.7,	30,	0)
INSERT INTO BLC_SHIPPING_RATE (ID, FEE_TYPE, FEE_SUB_TYPE, FEE_BAND, BAND_UNIT_QTY, BAND_RESULT_QTY, BAND_RESULT_PCT) VALUES(12,'SHIPPING'	'HAWI',	2,	99999999.99,	0,	35)

------------------------
-- INSERT SEQUENCE GENERATOR TABLE
------------------------
CREATE TABLE SEQUENCE_GENERATOR
(
   ID_NAME varchar2(255) PRIMARY KEY NOT NULL,
   ID_VAL decimal(19)
);
CREATE UNIQUE INDEX PK_SEQUENCE_GENERATOR ON SEQUENCE_GENERATOR(ID_NAME);

------------------------
-- INSERT SEQUENCE GENERATOR TABLE DATA
------------------------
INSERT INTO SEQUENCE_GENERATOR (ID_NAME,ID_VAL) VALUES ('CustomerImpl',1);
INSERT INTO SEQUENCE_GENERATOR (ID_NAME,ID_VAL) VALUES ('FulfillmentGroupImpl',1);
INSERT INTO SEQUENCE_GENERATOR (ID_NAME,ID_VAL) VALUES ('FulfillmentGroupItemImpl',1);
INSERT INTO SEQUENCE_GENERATOR (ID_NAME,ID_VAL) VALUES ('OrderImpl',1);
INSERT INTO SEQUENCE_GENERATOR (ID_NAME,ID_VAL) VALUES ('OrderItemImpl',1);
INSERT INTO SEQUENCE_GENERATOR (ID_NAME,ID_VAL) VALUES ('AddressImpl',1);
INSERT INTO SEQUENCE_GENERATOR (ID_NAME,ID_VAL) VALUES ('targetContentImpl',1);
INSERT INTO SEQUENCE_GENERATOR (ID_NAME,ID_VAL) VALUES ('shippingRateImpl',100);
