Return-Path: <netdev+bounces-121169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D8E95C090
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28201F24331
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95E1D1F60;
	Thu, 22 Aug 2024 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="ayQA1A7j"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C608F1D1F50;
	Thu, 22 Aug 2024 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724364087; cv=fail; b=aijsCcrEwyaowcHC3OdY8uPzrD9VWR6Zi+ldZuDEH/an95RDsb8LxnZhpQUWWj6OpYIZGJ6fYeW97AFYJSv+TZxOHCPCrFZwynKBz2q6crko0XAmVB1f/hLmCaPMZLCpuNfsz3DiJJvtHRv3xLMl9pDQ5X6A7BrpochbRtUgcRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724364087; c=relaxed/simple;
	bh=xLbJpuX9HhNR0ZV7nGzIbn+qa8rhRWpmZ/L+/G5WYUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V03nZvHPeBFkcJRZ0xNihKgxNyStbWwePKcXOIqRxPl4016TN48Rr5s9xRK3gz/G/gJvHSsrwTQZE2d3uZ7T4iReBxO8UbR7PUySb+/xbLAvV5D2EtcGjcgJucvQZWFYnjGdFcaf1fwFlm7gjhGnL8Ikwof6GkgLzL08eVT+gfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=ayQA1A7j; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wS0wLU4S35gjUNc4Ad8rTW3NOc5L8KvuFWv8DUERg317HC1mz/VcsIGRlyGXdJFKLqVYWB/3tl6UxXQeEeHV8GMtXbHEt+QpVHavmJQRC+ZXpqNpB5kYPpgN8cEHBMAcnTaat9zeesKTKAe2kOB8tj3+aPsZMl05dyb+VHuMsA78vWINV2ecHkshW2BIh/dH0atJjZkOYcmWgH0pUnfZQWSjLgiaDv3aot0SxlJps5wOdwUpBD6M3hBE1eD0DxpbHsO8iYX8sl7dcCc6nfEnVcNjOwbvyW1ZVz1HhtgbsaVmiMPosdQbDw7NUqx4RV5ftaA8mOWXRzTXZF+aMNyP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1+c90ViFgnoHYXSMmljfEgNQKRL7U0g9sqAaPhSrrc=;
 b=Ia1OZqcQByxkrH5nr2thWr4QESO1fEfMQ4kPdHPGXm2oOg6FPavTprpVNScwn8K9yRKfX357NdtonJaXglLu7c7e2zZ/fHpH16aV2/vsFe2DOh9yA21HO9HwJyz5Wj//S6jutwYSBecbBzFK7LUDNQkDKwMsydAVxTaIG/ZOCg0Og3KvZ7upnj257QuF8XvQn/9+1Gmyui1tSjE+gNSqgYyI+66CjeoFyIZb2bsMwvdzOg0Iss2Yp2c/W8FeaLKNYnFBPshcZKfHa/KEy2Eh+es/7JKeGMNSb+jax9Qv4K9a5kuBM9fBkX6NBUDtILyJTbhpe07rp9Rzgp/cxBrz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1+c90ViFgnoHYXSMmljfEgNQKRL7U0g9sqAaPhSrrc=;
 b=ayQA1A7jihzevWY7lWzsmqAcotYZOUITgYqZXVvo9vxYaxPKdSGI62Ki0rhzpcvu3aysGzpLgYJa193DpUOygFmk2J/msZ1gdf6AMTQKqgVHfmy987LKWbHG/n5EcZBCET66zgrd62euXDmoxvCgpsnnLhKCX4Mpv0H56bYOPeA=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by PRAP189MB1828.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 22:01:22 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 22:01:22 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>, Kyle Swenson
	<kyle.swenson@est.tech>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH net-next v2 2/2] net: pse-pd: tps23881: Support reset-gpios
Thread-Topic: [PATCH net-next v2 2/2] net: pse-pd: tps23881: Support
 reset-gpios
Thread-Index: AQHa9N7ToI4XRfgfPE60nFrdlScw3w==
Date: Thu, 22 Aug 2024 22:01:22 +0000
Message-ID: <20240822220100.3030184-3-kyle.swenson@est.tech>
References: <20240822220100.3030184-1-kyle.swenson@est.tech>
In-Reply-To: <20240822220100.3030184-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|PRAP189MB1828:EE_
x-ms-office365-filtering-correlation-id: 5b9cdd57-2629-4e03-be97-08dcc2f5f593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cSfKsSVSLTnbc+HPT56z0xyKTX4dpyK/YY4dZGb0YqnjaAzyu3OQo8cBEP?=
 =?iso-8859-1?Q?6cfLU57oA37LuQN944wbz5rAELpDrcarLsTZYOzjqjJ39AWbv4SaqtP5AM?=
 =?iso-8859-1?Q?XS3XLm4TRtsomkRHpxHZ1BN7lZ9yVuqjHUjv5ZH0y99yylPe/niGdKiWBj?=
 =?iso-8859-1?Q?zE2l4ZYvf3zRkMSz33FPyvu4dyNPafV9l09s2dERjEkpZI9mZ0cC3ppXoq?=
 =?iso-8859-1?Q?s2Vl9RltpOOP7YpSjWo2THY4Cu3MSrVgZi5q/TAkAWM2oy9NxGmZ6w48x5?=
 =?iso-8859-1?Q?APZvoeLmCHf/Sgq7MSDJ0fL93aUSiTwz/MfObO3lGau35Kqw9mPKZ5Zoqr?=
 =?iso-8859-1?Q?URWJV8FzsNO1RWlr4gTgOXz+XP5wy7TENdnOv4h4K2QgP44fPm4ivpZxcQ?=
 =?iso-8859-1?Q?AqshlcHnHCXlTf+pvlHDr+k4TbsY1Sp0XufZyemPcQsStsJiHZiDX+je+4?=
 =?iso-8859-1?Q?dCLknsg6fZO3n9cYA+Zq4J5NSG06zB26H5fCtXiciIeJbgOea51NAjvKqL?=
 =?iso-8859-1?Q?snRKnaXtpn2IdiT/uUlb/PX6p6LFVDhtWM3GakDe3/MP6nbq2NWeZ4zmy0?=
 =?iso-8859-1?Q?vvhJYsxbG2sLWWGTwl+p8YjFuHBZeu7+OBunff1AQf3JmZxkRyXN1cTxMi?=
 =?iso-8859-1?Q?1H5nVKhgHV3Qab1im+MPuEyKcrlS47iKo6YIHI3tsMijag5wPOAR4zwYc6?=
 =?iso-8859-1?Q?AdSt5IKda/vuNBskT6U+rJkubqXcVF3kvVA+z5jZOLfoa5qtFjsTDocUlZ?=
 =?iso-8859-1?Q?XwEJTxQgl5zJsXbn50/eStvrwtdwEZu9hbv7T0dmnTBsuC9/g1Ui8N7Isr?=
 =?iso-8859-1?Q?NUk8pNNzd77eCXoG8NdIjnn31zYzBt4WL2u53sc4QNh5vb90bOPldIr2QX?=
 =?iso-8859-1?Q?kfpS9JKaPxKe/qeSuvCI8+0n44onUpnx+UDb/SZG/gvIMZ23W/H9I4MH2y?=
 =?iso-8859-1?Q?6KxGFZwdtFrYHhsODPhv6RItnl+7Selvvlgb0GbaLWRqjlv7+n+ijiZLqA?=
 =?iso-8859-1?Q?rfk6DIKl4vIgJg/399MjRygbIObDS6cA7Y72Oip3/8PFV8cjkvQjzzU+QC?=
 =?iso-8859-1?Q?gQONdMDoYSuQT2jStiNAQG8gz/Bb4oFLcDCXm1ufe6WEE3gKi693xAPEpP?=
 =?iso-8859-1?Q?ecPXZS7JQFX8IM2D50s4FxxUrONFhqZkvlkD3YA1/Qzvy4Ig5OQRLSAXGF?=
 =?iso-8859-1?Q?ubwXtfSb+OrxEJh5cvXjU44Vi5hgponhbNHQEIg2c/2IS5NA1gSwyqnhFw?=
 =?iso-8859-1?Q?aiArUUWmVKDZVUXwGN2BywUzB4SgZ9ChtpxBwt2HDYpfIER2WJIlKS7wDZ?=
 =?iso-8859-1?Q?EvuU4qPiJqJ0qQ1PQUJh4cmNvMWp8mlfpAMqextSAHg+Lso1q73c5xO4gV?=
 =?iso-8859-1?Q?SRi09JT2+nIakEC1ovcG9RikfoKInQuLDHomXcKDSRddfSPk93CWugngQ0?=
 =?iso-8859-1?Q?8NNmBcGcLiCDySUiaHBsYu5GvSljKTxu2gvqdw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?k+82PZXaHGHX+C3s/IhKY1byb8xrkzDXg+zqNjqNQcUuRobXZpEjsq0JO+?=
 =?iso-8859-1?Q?5grKBBDP0+qd7WwgiEAu6/kfGlXX0tXdBKHD7lPHJjsZrHGUwQq/IxWSWc?=
 =?iso-8859-1?Q?1p8nQny3B3ZmHYvNyaNMGrCTw0Wy6te07icfCLBhLOId41gxTcWHOrE2vh?=
 =?iso-8859-1?Q?IrbcsYRwIR5Poe14dAMaeKCeHpswAR0mVvN2nD+4YvThFFi054Z13U23jy?=
 =?iso-8859-1?Q?2pipB5vsET2wne6NZ+U+RsuJCOrvXrz6Z9AAknZ4f4weUH6OO2ZwqCUhB/?=
 =?iso-8859-1?Q?GYhybDbgfdw0nHwYZhdKI1as8n5DFDZXcT77bUn+RISFyvCLElVH5a1H9f?=
 =?iso-8859-1?Q?Mr/S1fTYyvRztHyJhvEd0Gi+dpBiDFl0RUqIK5gunmGToK59zK4ooiJsXU?=
 =?iso-8859-1?Q?xoLhHSoaZUrvEVt58TaXXq2bGB5lVbh/ECnJvORqwYel+km1MgJNJ0gUVp?=
 =?iso-8859-1?Q?bKDNkVA/sA9gguG17OUpGs98Wnu8R22PiptoepRV/JAABresGq6JPtK6ZL?=
 =?iso-8859-1?Q?8kSxDILwvcsCYXsnuikhBL6SWeKauuMhx9+2V5y09L2vmZVTQDtZwDFRAD?=
 =?iso-8859-1?Q?C+xxTFe7fsvvdXHNszRa3PWn+2oGQj+XYmcmGac0zbYjpmsutzart0kmfI?=
 =?iso-8859-1?Q?Yjta9jwKVYqwEUaS2N9FqZwWeZzOt1BVBHkHfV6PT7S6AmRZ+gpiHWWbdT?=
 =?iso-8859-1?Q?uR35T+p3BsrbwhPgPrhD7eGmbmvPzRbQaVs4Y7z2KZT1ZURBArRhuLkGCP?=
 =?iso-8859-1?Q?9T71IslIeYqAVIsI/fHFHc4GVm2rJ42D3WY6Kgf/lqe2vUNgV2EhtIsyFo?=
 =?iso-8859-1?Q?x41s38CMxHFynReYYikzjs4DPE25wEFOHI8nu0GVajLf7KyGeSQKtSmgMk?=
 =?iso-8859-1?Q?DHsiZ8zyDlZ5MgmR7y4rwSY4Nj6nFa0TvUZd47qj9QJLGkcxuf3iUm4Iq1?=
 =?iso-8859-1?Q?FEmQObodpezj1Sh4vfCr1cG3KwGc3QLIUKCld63Gk2sRtu02zMkCGN5wXm?=
 =?iso-8859-1?Q?fKeNVOxhEzHcBR1xnPbcqWH5n0L2hApsOb5mowJvWgeg2j8yeD3XS2rZrM?=
 =?iso-8859-1?Q?R51WfBCaWfBcrCJ5XQr+zDwarT2Fu/1NJiNFu2/hM8G6XvxJyMQBq7j2Vm?=
 =?iso-8859-1?Q?I8KAyEbb2XIsxLWyiioocAKTAGYF/s0l8VhMKmlXFiJn6WG6ukvc9Cseuf?=
 =?iso-8859-1?Q?/1z/C5NkVsjcFsvP4eAnWHiJ8cTWJbEE4uekUerqtMPV6mvp8RAXl2hv2c?=
 =?iso-8859-1?Q?BoysHo+QxnGDvWfpODKOZvADdwQ+t9jhDPaaGwFC/PKOhfD7i7700hg3FX?=
 =?iso-8859-1?Q?W5egW541B9QkzgbzNnwKbgV2iUUkXcWvUXIknO5p3PF4/2OwasKXbii1bM?=
 =?iso-8859-1?Q?gE7oPS9mzLqdfCRJ4xLNE2CgPYFHi4OX8MBSBTv2R4xHrZmfsclbDLjqse?=
 =?iso-8859-1?Q?1Caezz2e+04aOPcbxKdM/9gCRwSPgo0Qjncr9zxgL1jMGy4YbKwCfB1sex?=
 =?iso-8859-1?Q?2dayiIuPDoQfvFBTkiLE10I76Ul6vf0TkT5KEC9oTjdpAj4Yew+OhdCc6T?=
 =?iso-8859-1?Q?8If3ldEptszgYsbUkhYY9o8IX1j0Y+0mdceybr+4lS8SOGc4ICLHncoBFR?=
 =?iso-8859-1?Q?5x+CmcyutrLU4VCH7BVApWGywQ0n93SrnjLeBKCrKyV3tWIGjMbuA8zg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9cdd57-2629-4e03-be97-08dcc2f5f593
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 22:01:22.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzAWgKrLxP1K3cgr3M3IAYoAiJL33OrrPJQerKrek7mqH9BTnxfkHtIkT8oucKvA10SksjI/tlxg+HYBmdhhBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP189MB1828

The TPS23880/1 has an active-low reset pin that some boards connect to
the SoC to control when the TPS23880 is pulled out of reset.

Add support for this via a reset-gpios property in the DTS.

Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
---
 drivers/net/pse-pd/tps23881.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 2ea75686a319..5c4e88be46ee 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -6,10 +6,11 @@
  */
=20
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pse-pd/pse.h>
@@ -735,10 +736,11 @@ static int tps23881_flash_sram_fw(struct i2c_client *=
client)
=20
 static int tps23881_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
 	struct tps23881_priv *priv;
+	struct gpio_desc *reset;
 	int ret;
 	u8 val;
=20
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(dev, "i2c check functionality failed\n");
@@ -747,10 +749,29 @@ static int tps23881_i2c_probe(struct i2c_client *clie=
nt)
=20
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
=20
+	reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return dev_err_probe(&client->dev, PTR_ERR(reset), "Failed to get reset =
GPIO\n");
+
+	if (reset) {
+		/* TPS23880 datasheet (Rev G) indicates minimum reset pulse is 5us */
+		usleep_range(5, 10);
+		gpiod_set_value_cansleep(reset, 0); /* De-assert reset */
+
+		/* TPS23880 datasheet indicates the minimum time after power on reset
+		 * should be 20ms, but the document describing how to load SRAM ("How
+		 * to Load TPS2388x SRAM and Parity Code over I2C" (Rev E))
+		 * indicates we should delay that programming by at least 50ms. So
+		 * we'll wait the entire 50ms here to ensure we're safe to go to the
+		 * SRAM loading proceedure.
+		 */
+		msleep(50);
+	}
+
 	ret =3D i2c_smbus_read_byte_data(client, TPS23881_REG_DEVID);
 	if (ret < 0)
 		return ret;
=20
 	if (FIELD_GET(TPS23881_REG_DEVID_MASK, ret) !=3D TPS23881_DEVICE_ID) {
--=20
2.43.0

