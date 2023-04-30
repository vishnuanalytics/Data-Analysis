# DATA EXPLORATION

# sales by product
SELECT product, format(SUM(total_sales),2) AS total_sales
FROM adidas
GROUP BY product
ORDER BY total_sales DESC;

# sales by region
SELECT region, format(SUM(total_sales),2) AS total_sales
FROM adidas
GROUP BY region
ORDER BY total_sales DESC;

# sales by retailer
SELECT retailer, format(SUM(total_sales),2) AS total_sales
FROM adidas
GROUP BY retailer
ORDER BY total_sales DESC;

# sales by month
select date_format(invoice_date,'%y-%m') as month,
		format(sum(total_sales),2) as revenue
from adidas
group by month
order by month;

# sales by year
select year, sum(total_sales) as total_sales
from adidas
group by year
order by year desc;

# sales by state and city
SELECT state, city, 
		SUM(total_sales) AS total_sales,
        sum(profit) as total_profit
FROM adidas
GROUP BY state,city
ORDER BY total_sales DESC;

# Profit by product category and region for a specific year:
SELECT product, region, SUM(profit) AS total_profit
FROM adidas
WHERE year = 2020
GROUP BY product, region
ORDER BY profit DESC;

# Retailers with sales above a certain threshold:
SELECT retailer, region, total_sales
FROM adidas
GROUP BY retailer, region
HAVING total_sales > 200000
ORDER BY total_sales DESC;

# Sales by region, gender, and sales method:
SELECT region, gender, sales_method, SUM(total_sales) AS total_sales
FROM adidas
GROUP BY region, gender, sales_method
HAVING total_sales > 50000000
ORDER BY region, gender, total_sales DESC;

# Average profit per month by product category:
SELECT product, 
		MONTH(invoice_date) AS month, 
		YEAR(invoice_date) AS year,
        AVG(profit) AS avg_profit
FROM adidas
GROUP BY product, year, month
ORDER BY product, year, month;

# Quarterly sales by region in year 2020:
SELECT region, 
		YEAR(invoice_date) AS year,
		QUARTER(invoice_date) AS quarter, 
        SUM(total_sales) AS total_sales
FROM adidas
where year = 2020
GROUP BY region, quarter
ORDER BY region, year, quarter;

# PREDICTIVE ANALYSIS
/* Select a set of features- First, identify the key features that can impact future sales
 as PRODUCT you can use the following query to obtain the total sales by product category and year.
*/

select product,
		year(invoice_date),
		sum(total_sales) as total_sales
from adidas
group by product, year
order by product, year;

SELECT product, YEAR(invoice_date) AS year, SUM(total_sales) AS total_sales,
       AVG(price) AS avg_price, SUM(units_sold) AS total_units_sold
FROM adidas
GROUP BY product, year
ORDER BY product, year;

SELECT AVG(total_sales) AS moving_average
FROM adidas
WHERE invoice_date BETWEEN '2021-01-01' AND '2021-03-31';

CREATE TABLE time_series_data (
    date DATE PRIMARY KEY,
    total_sales DECIMAL(10, 2)
);

INSERT INTO time_series_data (date, total_sales)
SELECT DATE(invoice_date), SUM(total_sales)
FROM adidas
GROUP BY DATE(invoice_date)
ORDER BY DATE(invoice_date);

SELECT ACF(total_sales, @max_lag:=20) AS acf, @max_lag AS max_lag
FROM time_series_data
LIMIT 21;

SELECT PACF(total_sales, @max_lag:=20) AS pacf, @max_lag AS max_lag
FROM time_series_data
LIMIT 21;









