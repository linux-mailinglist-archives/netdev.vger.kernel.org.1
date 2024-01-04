Return-Path: <netdev+bounces-61533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B864824335
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9530A1F25887
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C04224ED;
	Thu,  4 Jan 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mx82tINq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AC224C2
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf9tpoyGWNZzjPUMjaWoNA8RX1Qc0eACPW2e/j6x8L+LrjWjqFZkaiuH80lHDmWaFvd22j+8E9LkAfGF4sNhQBz519lzZBvDVqZWu6MHIPagIf+4xDXbEJYUJNtAy75MmEXVA7TJNNLhmKS3kWxBpeJKCYAYN1BZca6FAyTElKOBJUXFh7WFJb/VUhPiCeHhNo65nm7vc5KLMs/avebj9yS11ivGTBONWD0UpfMuYHDeakNN3xqTs3If11gfLqhIn0xVT+74kvowRF83IsD2z2IX6WO48zASTGKxRhEjmHhEIQ4t7QxoEtvjBIBgwi3Pyjf7NtpPOatcen5MqGi28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjnYumGemBtjBaHxobK1gNXHwnIIHINEFoaLE5aCFlE=;
 b=kFgEtk3Yt3RfAE2n+Fw2FmEq0ZfCLszqtRTC9IXh0lHZ3i4X2AWrBOXRL3mCVcztYSzSHoe52Dhr3OIwCXfvFr6o1onYCjvruStBGZJqJpRq3xYYLaLKZRlbSDqXEMrq3JDr1Npu9T8DRghIoM5mtMHSSIiWDSg73Y7tlnXKY/HcaYJEKNU6vRXx6gxAgYyYAMj+G3F6MIcVz6snxSaBy7ff1EqpEOxML1Odl+K28G7WwTxSNQL47Hev+5AmeL0LcCB474Zylv6yn875hRvvFk+Oy4/Q867LLn4KCSuiaOgJfs6ETs98kPcSbP1eK+NC6gEDHexrzVhhsgJCJAkXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjnYumGemBtjBaHxobK1gNXHwnIIHINEFoaLE5aCFlE=;
 b=mx82tINqrtpBPOR17lxso9TU7mt0oHxv7RTDoeD9YJBUkIKk1/h3k64BnuymVLw7ogX1ZjXm5CDxQhyvwHtnIMEv0M72rJJzrcdNaTkhZD1Kjxy57VasDt8rMX53Me1Fk7QBoHbaWFA/TnZtQ8skDbb6CzHstuUf9ORVqYTaS6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AS8PR04MB8579.eurprd04.prod.outlook.com (2603:10a6:20b:426::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 14:01:18 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:01:18 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH net-next 07/10] net: dsa: qca8k: consolidate calls to a single devm_of_mdiobus_register()
Date: Thu,  4 Jan 2024 16:00:34 +0200
Message-Id: <20240104140037.374166-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104140037.374166-1-vladimir.oltean@nxp.com>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:802:2::34) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AS8PR04MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 48549e59-8f89-424e-7b9c-08dc0d2d9fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v1XmX8WgPqfTGBzm89zcgzuBG0atIsmatdCyjWpnOK0DfJ2d63BvrBK/ouodLn094/LCprAcux+eB6+PzXqmMjKQvebfIIIzeIim75xDE5DjpDenVc2gS5VPC9MvuWEjBQXh2SsHuHcLyI9G79e/FKi5+WakskY1JKrNz5i8YNSn8YhWovX/AM8bl0O4VprC8igl0jakZ5dOwwJyCsTz5g774FkFst2VUfWLrEETLjovCJy/A/PHULrK1HyjHQ4q7/lfXg162GoesJYmVKbeJ/KNjHExDKmr6TWOEBSAWwHOI3vvPZI0uAG4qh6r51uThXd4aeGkKkcK5efGH+MvUOxnuqtjhQwg03cOP22N1AK7WcH4Xy+KInwRunGRgAI6DzqcX0/aGGNkk0L4nTJmrAZmr9mbZ1m2b/MIjLMquwtfBKgd88D5oJFZywwc5BZo8eLHRgGwZbGju6yo3ukHLg0MgGPEAHLykgzln2Cf45pVqV7ZQ7a9ZVjREnDinWGNIfAnXQmsnxzm7d1f8878MoffJfOPTFd2SOfUZd9R3PAVwvAWsJvPmHLxvdNQFOsajRFSOuFXJhB4F/wfeUEQc/TUqO8lBmiMaemabuqW8ote6m6Z/DvK/ndIBtkzUDBSlnbJEQUDUyHLIPQuzWKc9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(52116002)(26005)(1076003)(2616005)(478600001)(6506007)(6486002)(6512007)(83380400001)(41300700001)(7416002)(2906002)(66476007)(66556008)(66946007)(6916009)(316002)(54906003)(4326008)(44832011)(8676002)(8936002)(5660300002)(86362001)(38100700002)(36756003)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HB10nBEg81nFjw4u1he1Eh9nkvGkLzNB85PSpydHGqeWpl34eup4yDDzpVLK?=
 =?us-ascii?Q?iRZFQ4qRASCwF+uxK7GH4cjzNk96OMAroc5tSIsUItqIAp6VL2jDOoC/iRSe?=
 =?us-ascii?Q?uhmmBvYeT+pwiLPk1yLgrjBgbUF8j4xCwqLbydg+ckuVTK6A8YrZz4IDN5GG?=
 =?us-ascii?Q?t8hZRy9++LZVmd1q5YfFCSbsStclLdvIelqdOVbEkC3PLjWyU+8ML+Pj2htT?=
 =?us-ascii?Q?TxwhLTSBzx0UXLYrPc5rdHRitJFgY5XBSFn8pKwP7reiycWQoBrW9ZNxte0B?=
 =?us-ascii?Q?S/CHb5IUWIm3p5ds/tnAovGpDeN1zrTOBwGZy5VH2Io5gKob29meD+Nuz61O?=
 =?us-ascii?Q?i0oCJes7ZXvDej1N7BdxC7dowgUE7nscRq58POadHxL+c6Ifp94l+/i1Fl0T?=
 =?us-ascii?Q?9bitHpt46flPl1zjykFxBdQorTATrA9V+AZo9iKoKX8CHzk2OqipVOorKLyJ?=
 =?us-ascii?Q?sEXDXeLuosbHYCd1Fw9/1Yxb/1Md+8WDz9zZeGOvndff3YUnIL9Mv/TgX1ep?=
 =?us-ascii?Q?PzeuYFcjJmq1JjbRjP4Wp19bSKijANhwNakxpgC1Gphz7BDMMs4Aa8PJU0xH?=
 =?us-ascii?Q?otOlutE9m1F94kZzVYUf/eFR91txuH6xAbup6KZA1Ml7mcYPb5o8lKdCG9JT?=
 =?us-ascii?Q?TQrUe60BCg82ZQHQ3azbs0W/COByg9M4aTtMB3uzoi7uuyhD4cnm/HgVlt4i?=
 =?us-ascii?Q?ITItPs0zY3DuftGDcvSLsglgDO2xe6PSTBVwMLY3+s1HRT1sBasX6FevzaYH?=
 =?us-ascii?Q?QuvivEpWs1DZ8KMDQ1wFZWu6X/Pp5oVrn/tWRf/2yOm2mak1HeX9tvY+mUdR?=
 =?us-ascii?Q?HU6PLu7D3RrO3ZlHYELaiSqX/2thDpD9s7stq4V31uQ5J4vIcz0xVBEZgZJ+?=
 =?us-ascii?Q?PGyfxjyF+A6PfxAbOQVFzj+Ungd1mgngOvFRdopX4DraNhi2LzG/H4oOUlrs?=
 =?us-ascii?Q?+eEb/bVIPA6+8LYgRqxusnHkwnuWVbHW/Mhe9QcHxwnUbqI4STrs3PB2gdaw?=
 =?us-ascii?Q?3T5lEhZpGnRE54A/CxefPoWTQijckEkKZ2dqfCDEC6GOS2RK5Vb1kI6oPnKr?=
 =?us-ascii?Q?+sIH6C9+1926/tL6jnob4x/dNp6fSZOCkjDMzOxnvdvd3n55tYopjpszyQ4T?=
 =?us-ascii?Q?v/pWyW9+wbLH+pxCjnZ6f+WSzcam5C3JN8sDH0ZI/PhQ6Zrw+4ycz1RdyI90?=
 =?us-ascii?Q?pwm5EXkTOqqXfAAtJJyuQ9h7BaocXeDGVDZDMp0+s35Cud/klqoSjAEE3Fpm?=
 =?us-ascii?Q?eHP88hHClF7dRZ9cEfuOVj9PIfFTqtwLX/jiKwfNZSoPCxbTmyPwqDYULAEY?=
 =?us-ascii?Q?UcWKy0p9YvqCaoRXyrCSwTiXa9X/2XgYqePngqEaB3/s8UNZI8rcMKk+19we?=
 =?us-ascii?Q?/f2IEQOn6VPOpcCNvzjo8Gcsna50h2aBD6ylMmqV2aaSAvZH7jEYQLyI3oQE?=
 =?us-ascii?Q?zdzy1Sut5Gc5YuBCmoKcyskmwSNUFiA2yFKg3gW4yDF+BF99LqpOxXojzd/z?=
 =?us-ascii?Q?PAM8MHouKIrpQwl0+695gs1roz0MgM39gEQy2ozybaA0fBd2Rg8FwMhKmd38?=
 =?us-ascii?Q?mr033ruF+V/sgmeblfVJrKySz4pICUXGd59BPsD74P4aCnCpI4KjuTOV+I1X?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48549e59-8f89-424e-7b9c-08dc0d2d9fd7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:18.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve6ERlq2q5rolXuzzj4KlJBGMX9yOnTdpfhdCmayaHhzk6yEqWyQIISKVdpFjJE80o7sn4AE2rrWtrSrhFmUWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8579

__of_mdiobus_register() already calls __mdiobus_register() if the
OF node provided as argument is NULL. We can take advantage of that
and simplify the 2 code path, calling devm_of_mdiobus_register() only
once for both cases.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 8f69b95c894d..f12bdb30796f 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -967,25 +967,23 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 		 ds->dst->index, ds->index);
 	bus->parent = ds->dev;
 
-	/* Check if the devicetree declare the port:phy mapping */
 	if (mdio) {
+		/* Check if the device tree declares the port:phy mapping */
 		bus->name = "qca8k user mii";
 		bus->read = qca8k_internal_mdio_read;
 		bus->write = qca8k_internal_mdio_write;
-		err = devm_of_mdiobus_register(priv->dev, bus, mdio);
-		goto out_put_node;
+	} else {
+		/* If a mapping can't be found, the legacy mapping is used,
+		 * using qca8k_port_to_phy()
+		 */
+		ds->user_mii_bus = bus;
+		bus->phy_mask = ~ds->phys_mii_mask;
+		bus->name = "qca8k-legacy user mii";
+		bus->read = qca8k_legacy_mdio_read;
+		bus->write = qca8k_legacy_mdio_write;
 	}
 
-	/* If a mapping can't be found the legacy mapping is used,
-	 * using the qca8k_port_to_phy function
-	 */
-	ds->user_mii_bus = bus;
-	bus->phy_mask = ~ds->phys_mii_mask;
-	bus->name = "qca8k-legacy user mii";
-	bus->read = qca8k_legacy_mdio_read;
-	bus->write = qca8k_legacy_mdio_write;
-
-	err = devm_mdiobus_register(priv->dev, bus);
+	err = devm_of_mdiobus_register(priv->dev, bus, mdio);
 
 out_put_node:
 	of_node_put(mdio);
-- 
2.34.1


