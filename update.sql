UPDATE payment p
  INNER JOIN orderitem oi
      ON oi.orderitemid=p.orderitemid
	INNER JOIN `order` o
		ON o.orderid=oi.orderid
	INNER JOIN paymentcard pc
		ON pc.repid=o.repid
SET p.cardid=pc.cardid;

ALTER TABLE `orderitem` ADD KEY `subtotal`(subtotal)  ;
ALTER TABLE `order` ADD KEY `subtotal`(subtotal)  ;

select *
from `order`;

UPDATE `order` o
SET o.subtotal = 
(
SELECT sum(oi.subtotal)
FROM orderitem oi
WHERE o.orderid=oi.orderid
GROUP BY oi.orderid
);

UPDATE `order` o
SET o.totaltax = 
(
SELECT sum(oi.tax)
FROM orderitem oi
WHERE o.orderid=oi.orderid
GROUP BY oi.orderid
);

UPDATE `order` o
SET o.totalshippingfee = 
(
SELECT sum(oi.shippingfee)
FROM orderitem oi
WHERE o.orderid=oi.orderid
GROUP BY oi.orderid
);

UPDATE `order` o
SET o.ordertotal = 
(
SELECT sum(oi.grandtotal)
FROM orderitem oi
WHERE o.orderid=oi.orderid
GROUP BY oi.orderid
);

ALTER TABLE payment
DROP COLUMN grandtotal;

SELECT *
FROM payment;

