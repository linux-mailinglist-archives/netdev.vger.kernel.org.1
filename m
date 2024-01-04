Return-Path: <netdev+bounces-61540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6FB82433B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077671F25469
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890422F04;
	Thu,  4 Jan 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aLI1ZOLD"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559122EE2
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd2+o7KmXhQ0uZPKrJUBTChLICVFv/kKD2t6zrYuFbsG2tQ/MFomJllk0GvY2oOnL3VEKWVM+iSi9+jE3nSmrjQweOSJf9vqpWU074WsOENPVOF3fsV3iB5gdEadNyIqqBfHlFGgcgtLAXIFNbyW1B7dsYud6Kso3wLiza4Okgo90d9owpcMsTZ/BID0+zShONmriHV1L/YuORWvd1f9XKXjQRRtMZOjZWp9QHDaXG0Ypope0xJhBo9XWVopFfF7CJ4+4F+s49AcijybBFknjbcnVV/cKddKYksefvF1ogl/4j0kmLMAKNWSy+wS2SEtRK/LOCW2SfDIhEFlzAkHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7FGLUqTvq3wN+++jNFoghG6w8rdFLx9O77G4azmj70=;
 b=T9euQquCqRxkv1ZASA0L3gnxkVQSIiA0hbUqz3wTY8tTMkutL5lP1DmGo/Re4bhEMyI24CfzRRhjCTll6cZdeaXw/J29sHO2w7TugwT2jU1sKp8zqb0GaL8CKN/tOTGII7Cbyhm/xJzJo4jLrA2ON4zga/NnvZhVqvxYpTon4U8Jm+QmL4oiru4L2zxJjYFRXpSN3iWKO3I9dlIIAoa3WG+bUTvEcgEcnk6+Mj0B0LtiLM0omOOqzX6kzPx0jPnKVddo/p389lRpMcHU2flOicwYc7PpzU9KU2wpaRsvducoRwhi3AM3uC3f2f/JyMLmXtw/373sN1o+oqC089aUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7FGLUqTvq3wN+++jNFoghG6w8rdFLx9O77G4azmj70=;
 b=aLI1ZOLD/EGl8MMRTqxj3Aax2R42fq3M9zBMsh4l/G8lIuT/2pTJwEIF698b2duKr9+0iZ7htPnQ/7ZidSU3QiA4oUgcGHQdaAIc6T+fzFMxBE9NnZvsNQXMk9eacg9QMxx/iP9ou/rbCq/zX6MZGO+yd4du1ESZihzl2yHY2kA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
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
Subject: [PATCH net-next 06/10] net: dsa: qca8k: assign ds->user_mii_bus only for the non-OF case
Date: Thu,  4 Jan 2024 16:00:33 +0200
Message-Id: <20240104140037.374166-7-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 19941aa2-b488-40c2-43cf-08dc0d2d9f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ju/3tlxdnq8vTaiu9tmBJsUBAz7P4DXS0dcLCJBUPcqCsovcsmwUux3b33FlVG9OYbMP5BOqLnYHUfcJJq5j5wPkf89D826Tw/E0kx5SAd5a+5hNWNv6Kx+vk/Mqzw5oUWsp1RTdhRo0itGsweyy75kE2hPuMvabKFV+0Fhc5t90bLDTYEmp4GPyBbGA6mfH3J5MdqBcN5uPcULaRTa6gOig40ol1XXfQ/B/56/BOu52X2yPH9Kv3SGwSsio4tNDoK1giSXIsOfdAKNib4s/JEdEs83Q7A5lLqb1esu5oSFXd7/eRGK0biLPgzW4FUgUSFe1H28wFT4wr6WSY1fQNfwG/Mr16tyani/oNSyBwT5xopMo2NnoRL4fkDn6koImD9FIl2lN0fM4l19usshzH+mi1liSkK5/fe+M4/sIeahzBwgvlKUU5XRV++2fsQNNxaX2VOLoAvH+f59b/i34f+EhrInYaG1ATo/Qdy4P3Rg867wZyHB92Oi4USolbWdJ4q8k1cfhS1xrvrsPWLHGcZJvWIjkbm5WkIZjFyXlzXIlQ2/ky+bvUNEIG/YXjksi10D/wQHV7AYuLTltBn1fYVHsqSYM5Wrs2bP3BrR4FD8wuW6HmXMjFysuJWsvJpTijKho4+F+SKsePaGwO3mU7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(7416002)(41300700001)(26005)(2616005)(83380400001)(38100700002)(1076003)(8936002)(8676002)(54906003)(316002)(4326008)(6916009)(2906002)(5660300002)(44832011)(6666004)(66476007)(6506007)(6512007)(52116002)(66946007)(478600001)(66556008)(6486002)(86362001)(38350700005)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bnsd7klnhZS9yl8OcnmwJbW+6qyYTW7rkHwBdYKtve4LKL2RyTSFnb1ZVvqQ?=
 =?us-ascii?Q?JGrijk2WOxWXqx0ZulsiH8SlSz2489DIzH1fj4v7zXHzr5a4LkVecyZeqnRD?=
 =?us-ascii?Q?b34yhieMTdBnkVuuN/RxXFTfJHJPgbiRTmExoCFTzrssEDHRAXwOG6DjYLj4?=
 =?us-ascii?Q?q1Toi6cPCPSOl1iCVCDyxDM10B+06G1pSdgueB+y7M1jC9/WNkT90dYXqHih?=
 =?us-ascii?Q?gW4iWdx2SvuSX4tE0N18mhYpJQcxFifPhpy1e42HgV1Q+vlWdklbgzrW3una?=
 =?us-ascii?Q?pr8l5JY5L5PGHQxWpSsqtVD6iTiVksI/NhZgP/lSVEkUnCZ8vejwt4S/ovkS?=
 =?us-ascii?Q?YE99Pu3tMtQE3enQ6V6r5KWBhfsj8dXso62ex7sTwRy+3990mM+DnhaJ+pYf?=
 =?us-ascii?Q?X77YaxqSlzH3rKO6eHcT9elBRRZm/EGdZhKDTUhADmksmq9xVVjF2KYhiBbR?=
 =?us-ascii?Q?4ImoSK4YQBIsb6p4CZr/EOlkfZY5bw+MS7zZoiExxzjxi+Lp3btigdenDSw3?=
 =?us-ascii?Q?Bw5OdTgejs4wHJ2SkazyjLrGeEqdszvwaLGMuLdJ0NMdCGuCSFjQqvQr/IHu?=
 =?us-ascii?Q?pN+6y81KVs1nWcDNmifXpV9srIDpN/4GQ4Xa3VVMB/6yth4U7p5CTniJGo0l?=
 =?us-ascii?Q?bOjBMJntNr4tVbolyEKe+dI49yM1rQY9frQLVYqWcRbvWsbewamB9ByXuiaN?=
 =?us-ascii?Q?dZJ16m71vbHY/NrHgwZIPRCWq1f/CPGk/XBLgkr9OUrRXhTaJu+1tlX4Ghzn?=
 =?us-ascii?Q?ufiHQPYExYGN2e3ZWOqWkZXPqsIVc7mT0jloMX/34BgDDkED96RCjpWnndA4?=
 =?us-ascii?Q?/sHEtbxwTxcpkxZmPj3LkZvHNRhTwWb/+8D0wmZAvugfdEBwr6RNuOGBO5VI?=
 =?us-ascii?Q?Yz+9Gae82L9s1+npEuuLTkXck0S3uzZRYXmlSa06dSg9v5EetKJuCZuqFwrs?=
 =?us-ascii?Q?PxJ1XFNXL0Wxiv+HkNBkLR0UrVqF0tgB2Iubgls2Dy6gMdVltZZBF+Hi66dv?=
 =?us-ascii?Q?yJ9NGKG9pMtkMepap3O5gLteicunSVADdgRKQkDqHI75bPtuFFtiqp7kO9QF?=
 =?us-ascii?Q?dgKCZFqApMkI4ebt/nHpjFwtuRX+80/524z5KZpbuomMByf0FoKMNaPV2js9?=
 =?us-ascii?Q?SGOb/e7/M8PyxPG4VBWXVd6b9i3zgedi2h+U0bz5V4pC5O0HWUIdjbQQqkBQ?=
 =?us-ascii?Q?n5cq/ivx1//pe3TnHORC/RnWlZ62uOQ+eRqw0JvousX36nf/buqNCvrjwK4P?=
 =?us-ascii?Q?ON+ZzjYoawov/Jj+ZwfeSwGlFPOcnULZLN4xIyK3zV3fSj7Hq8uXk+bav0Cc?=
 =?us-ascii?Q?seMxNfVEhm79uxW5+8VC2cLTVQIW+gmBoo220OOdGhDOwcAFRqunBdHuELBr?=
 =?us-ascii?Q?qGazln6Kr1cLRoHMuWbVsHUr7KbJeYUXqt+FAC5uZF9313C7Lf+Xpl2o1Kz2?=
 =?us-ascii?Q?LQwY5uLMdOIozIOeAKNMMaqp4UTmqEzU2Gd6D9bNtVHCs2t6C1f304pQgnaF?=
 =?us-ascii?Q?aUhIllmHL0B+3tWtpJ+Rr1qc0evwXYcRyBApiOt/tkXMT3T17J78njV4oOB8?=
 =?us-ascii?Q?TG6YfgGzj2XkhbMAe+vNIIDQfVFWXRzK3YKvfgRrJuhW+4q9VWtl9Sq97+Cx?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19941aa2-b488-40c2-43cf-08dc0d2d9f60
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:18.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozvv/tx4t9+fv3aJgeAl5/G+NS4deipy+QIJUCwnUzG8SQWlUg2oE4oLKTu52LQTwoQJ0ookKMDp3G7Nm/YV8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

To simplify reasoning about why the DSA framework provides the
ds->user_mii_bus functionality, drivers should only use it if they
need to. The qca8k driver appears to also use it simply as storage
for a pointer, which is not a good enough reason to make the core
much more difficult to follow.

ds->user_mii_bus is useful for only 2 cases:

1. The driver probes on platform_data (no OF)
2. The driver probes on OF, but there is no OF node for the MDIO bus.

It is unclear if case (1) is supported with qca8k. It might not be:
the driver might crash when of_device_get_match_data() returns NULL
and then it dereferences priv->info without NULL checking.

Anyway, let us limit the ds->user_mii_bus usage only to the above cases,
and not assign it when an OF node is present.

The bus->phy_mask assignment follows along with the movement, because
__of_mdiobus_register() overwrites this bus field anyway. The value set
by the driver only matters for the non-OF code path.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 5 +++--
 drivers/net/dsa/qca/qca8k-leds.c | 4 ++--
 drivers/net/dsa/qca/qca8k.h      | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 21e36bc3c015..8f69b95c894d 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -961,12 +961,11 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 		goto out_put_node;
 	}
 
+	priv->internal_mdio_bus = bus;
 	bus->priv = (void *)priv;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "qca8k-%d.%d",
 		 ds->dst->index, ds->index);
 	bus->parent = ds->dev;
-	bus->phy_mask = ~ds->phys_mii_mask;
-	ds->user_mii_bus = bus;
 
 	/* Check if the devicetree declare the port:phy mapping */
 	if (mdio) {
@@ -980,6 +979,8 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	/* If a mapping can't be found the legacy mapping is used,
 	 * using the qca8k_port_to_phy function
 	 */
+	ds->user_mii_bus = bus;
+	bus->phy_mask = ~ds->phys_mii_mask;
 	bus->name = "qca8k-legacy user mii";
 	bus->read = qca8k_legacy_mdio_read;
 	bus->write = qca8k_legacy_mdio_write;
diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 90e30c2909e4..811ebeeff4ed 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -366,7 +366,6 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 {
 	struct fwnode_handle *led = NULL, *leds = NULL;
 	struct led_init_data init_data = { };
-	struct dsa_switch *ds = priv->ds;
 	enum led_default_state state;
 	struct qca8k_led *port_led;
 	int led_num, led_index;
@@ -429,7 +428,8 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 		init_data.default_label = ":port";
 		init_data.fwnode = led;
 		init_data.devname_mandatory = true;
-		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d", ds->user_mii_bus->id,
+		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d",
+						 priv->internal_mdio_bus->id,
 						 port_num);
 		if (!init_data.devicename)
 			return -ENOMEM;
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 2ac7e88f8da5..c8785c36c54e 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -454,6 +454,7 @@ struct qca8k_priv {
 	struct qca8k_ports_config ports_config;
 	struct regmap *regmap;
 	struct mii_bus *bus;
+	struct mii_bus *internal_mdio_bus;
 	struct dsa_switch *ds;
 	struct mutex reg_mutex;
 	struct device *dev;
-- 
2.34.1


