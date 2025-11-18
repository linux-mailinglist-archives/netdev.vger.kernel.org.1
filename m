Return-Path: <netdev+bounces-239684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 108A3C6B598
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 7F3D429069
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B382EDD78;
	Tue, 18 Nov 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OJtl2lZl"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADCF2DF147;
	Tue, 18 Nov 2025 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492762; cv=fail; b=WW/SMipBJ8WsYAo5C9nQvFOjH2P++lW32G/6KPLRY8D6RyHrmEfKk8GNN5/Blu+rUg/XjoTdEXomkyWqmu/tD2vkBsNvKZTY5Ztwyl5JmIiAMjLtbTXWy/DhVgIoCUGRDDM9quZGLlI0Gw37BEHIVFyux+PfvHvqjNKelnzEJuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492762; c=relaxed/simple;
	bh=2apFSyZ8qU3T9F2bSBCDBqDeAgQook38N1FNDoTPyQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBHHQL9Bw/zo/I4ObDCmihC66CiJvjEiAYG3eH9HHfknTh44Q7O0bgER/gMv2mQYK95+8WSNiYWwpVaRqNSNLMyQhKDI2v2wbdpWj+pr+iy5Ufn2p36lWKh5N5rdzMMaTyghwTZ+nvtxHWeRE0PzQ8DK2Ha8cP6d2rdPHJ4a8jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OJtl2lZl; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpGoVBIDyWl5IE686DxETWb+A0j8fcz9F44EqTs4HE1bSjc3I9l6sbYS0eAZGOnyb2WsjReP8CBj5gCTTeeWvaY/XDb1MjLY+Oh6D9cJUGGXydlWziJ62CRBus8GpMZTse3GZc4iGM/LsLzT+2s81b9c6a/bJyZrdVB0nBHaz2HB/zUL++5T60Bh1wnwmmK6/mACjY+P737EkI6UZK9UnyDA1qAZ69zhAJBz7RfhZWMew6QxDLaRxw8RrG3vqI4ExqZoPw65ACk0tNsg4fVtDGQr0LGEnt0YnbjLpqEWB28lvesuioVS+G9qWVWqSgHvNTdxBd/mgrAuJnlKMTTjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYt6SZTUZkfXQX6MoUfX4qJ7Y1PZWVp/l4LSDtzvP2w=;
 b=sdgobAoCv8ChgSYuiX/D2TVuX7Of+RLHo4UuMJzxIi20tDgfzLDmFzEYcr8BIVOXyEPFPZlgdLH14NtN2rrVx7/IkCO0/UIm3eD3svkykQN4/Db4OiZY8M4ZtHg03Bb8AzFsrSmnvfGXHgKY7Hjn6JI8ePCYNh2c9uV7bqJVk+sVWmUCOl7G2LgO/eg8KoOsbCJ6oAmhawod9359Gwi3EbcQBYP83RhT1ZLxTLPvORS8O5n7F3NomQNRq7LkYuLC0jv3hCewInaQ0N2wArQFpO5BUQoa8VTcvd5Dpiwo8FXZY4qbXsSto2SLe/NU7/PQxB2R//5BxxBE3aGLiCZIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYt6SZTUZkfXQX6MoUfX4qJ7Y1PZWVp/l4LSDtzvP2w=;
 b=OJtl2lZlZkyZQYikaf8FrxfyyYsiqaFDIop8WNDxtTZBgWHLF0anHia0N9SBiZ1Fpx7ZnLPMp2SG1r2uES79fD+i24koOns/nkrG88uUiNvu6uz0BQAhrjNMjCouLD4traxOTaYuo8S9IAekW0rKB8+wBoKPA5DAHpqEuQPOr3xKcbOvrgIwUe4+fot2eHFHWhtr7M0ZQ1KEzNyj7YRNrIyiZ3/qp/OPvyDlG6/IMow0+Vb+YcGIWQ5z9LC5hI+9XLosSuiEfkZDyWC++x2uvoVygtYtnNW3XEvO0wxAsdd4jkuHQ8lijiTQeHRIBlPYSN5wToczt/gWv4nAdjWFPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:52 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:52 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 04/15] net: mdio: add generic driver for NXP SJA1110 100BASE-TX embedded PHYs
Date: Tue, 18 Nov 2025 21:05:19 +0200
Message-Id: <20251118190530.580267-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de494ab-eb38-4ca9-5c8d-08de26d57e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|52116014|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i0kunheWziooAN46wQhFHcN4QJjrBJakUkPZhGE6kE72psBL6fZg72bih88K?=
 =?us-ascii?Q?cENLka0SjgOwwVJlMZEsi7ZPBYpbJzsggoDlbIme0n1XzRJP7ki1fqBpYTvx?=
 =?us-ascii?Q?vssh9PsL+9l3zoABIK5JvnLURLEAZxjlOoqix4iZQwHPZqcP36ogChtpN1uk?=
 =?us-ascii?Q?XjLp7Bnot/VGAghIJas4O8kc1Lrbb8fPpzImvgTWWnT3PAeEJj3wT68pNpQA?=
 =?us-ascii?Q?HGUQlJZ+vfS5V4M/HqdBTzDmoipi3gA+uklgIJRqH5g8Q5ZRrLEWzbN4GPiN?=
 =?us-ascii?Q?TMpfm0+24W3bvrqvmTzcN3LIGRzZ8J4F9aypcslmxYVXF7prMji6KtN1a6hG?=
 =?us-ascii?Q?Ubh5EKTZPFoLFNfHMt2IpPLiTYPHkGWVnIC/SMctcYT8cDY8pkKLJGlSXXWv?=
 =?us-ascii?Q?b41hSDajQBRHQ2F4htpKNQUWT2BfZnI2jVmVkJcwVkvFsP3ffQanj5l9CNXh?=
 =?us-ascii?Q?MoYfQkYz7AKAsGTIrSUSGlGcbErkeiNERBCtvu+GtdlEU4m5oaG4r16aVdnQ?=
 =?us-ascii?Q?D4l79YCYN88UArlOPEJ6X+H1XWbJOmenuZIuSK3Xw0cXItYyFqx0yByqf+lE?=
 =?us-ascii?Q?mRuonrQNx7jeZI5iEsuD4oQKTwVgyjbLs2VDxYLnUZtN1JER9JGiaYrktWzT?=
 =?us-ascii?Q?atLbmGUymC135Udp5TIBWjTFthZLzzrOUuR5ZlOx4xFKSKgxGi0gMYQKEEBU?=
 =?us-ascii?Q?TYIMiPpuanq3AjVePw8L5L9qBuNFNifFa/d06noYowm7HIqXZcXXZ1JuDJIL?=
 =?us-ascii?Q?Q3O79HgpSaCOy1LtUw+izWKIlRIJQiyNfeX+HDRHzt3HMIqlupqBV88WIoDs?=
 =?us-ascii?Q?rEiGlsEBlnhgBgybdvqO7ljY8nL0IlzGPiDM4U4JoJRsi6UTBdSXn9gd83r4?=
 =?us-ascii?Q?UMzw0mGoqzN2VVMOi1/QyZbuWGO1LG8fv3eTULYTgZ5dXlZfi0anepeLsG0q?=
 =?us-ascii?Q?RlngikyvwtNXknMHtgR1NdQCZ7Ho7FYoUjbYFrvT+T6FyECzViFbiKE8KgqO?=
 =?us-ascii?Q?NmOMST6iFwOvV1ytrnFmqvVlDI++DHuL/6eGGoez2LQI3pRS7jSJ8dLe+zGp?=
 =?us-ascii?Q?ZVskFU7FkXBT8QRmSm9LZwvrr03ea/CP4tWbPA9MXT4ljlWaaWdzttChaUNq?=
 =?us-ascii?Q?rAHlY/tqlglsh5pypwtYAIquEu5zamFihZwLIuIfqmLxj/A5BkUFDfrGwRKW?=
 =?us-ascii?Q?Q5rhfvT6IZAQ/ktwz1MBqqnLjYci9VspIaDucsHQ+VSsszd1IfmdntgN3J3u?=
 =?us-ascii?Q?hIhYs3FHbIJn5Wc1FGIzP4RM1RpSP6Y7pEBuVan6x32qdml6kEtlxGyVQ6rn?=
 =?us-ascii?Q?phkkWDmjzKUdCLezlRtJSTFGKgembLqWw664wnx+i/MlSBeHVPcRfO/H/RJ6?=
 =?us-ascii?Q?5edZ7oKxcquzW+O8Xbyn1TMaGTRbYzr/+jYPmxAFYlv7DjaDsG9P6tUI6js9?=
 =?us-ascii?Q?SGC5MjyE4EmCzqM2K5SO0ejLdSnm1sRk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(52116014)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hrTet+83dXhRLNqfClDlPxE6lBuNDTF+aAgt/Wb9wQhpCE3jFuWo1RGxhDbf?=
 =?us-ascii?Q?6h4MR6w+XjT3Rr976YgOnEbeqjgfp6XKSPQV5OCrMl97MU5ahfMu7DeE4zGG?=
 =?us-ascii?Q?mAAjJHKczpjZbRL3cHBh0h7SCTfQDLSIq3uokF6qqueloPj7V8aVbeXNGqFX?=
 =?us-ascii?Q?ms0UXq3AsBqa47g6R1rSX3xLgRdMUhqReSuH9vAMrdxYXN0MXs4+gPhn+7jo?=
 =?us-ascii?Q?jsBPB5rU5AlaFovZxgZMVOHXCVMHj4T9CoCkE7XT5FyX2RB3PS43O58AKZEG?=
 =?us-ascii?Q?ifCha0hw0s+wSucaA6RIosQmJhC5tIPEnOOy3nSr23dpOjjyQlIg3P9p6qol?=
 =?us-ascii?Q?JWdI6KZTwLgmDTdlAPud0Nptb/wdQxaFKOzWHgdeoEoqgSLQkhiny07i73VN?=
 =?us-ascii?Q?rvbT5usFVEKa3JmtC/+P8nKml9/SYyosgcjKZy98bX+69qQfCNyyyyw2Vapv?=
 =?us-ascii?Q?YNrIu3HB6RV2kp8iNpFG/6qxA26MtQn5ihn6r+6yOJF2MSHHQ2/yVXR9kC1e?=
 =?us-ascii?Q?uClG8YhkTL12BRHZViGzx065hfP3eMnFC7+jPg0cM2QIF/AD/yvvAg+L0td5?=
 =?us-ascii?Q?t82Trpx/KpckFP4fphhW5d+Pb8OHdLXJbXj9TO3mCXLpNwSKwmQXYiisAT/0?=
 =?us-ascii?Q?OrnQg2VCV5zk8C/o00kvDot2nv6hT6o1ei2pe+X1d0I5z+gN6o4u01yefAI1?=
 =?us-ascii?Q?YsA1LmapFbb8PzLye7mr5kiJRIUqDGb5kD75FHH26bo426F5rJNrRs4ipUoq?=
 =?us-ascii?Q?18mFVrqMgL4Z5Bt3flrwoKcu77itutwGRFyGvI16JV4SCaEJRCHHXFdnPL3y?=
 =?us-ascii?Q?KgV/t9FJvW7zI8xrZfAzWM8xATdUDFfrsRloiOYwAvvU2klbD0LJ3z6q7Dbp?=
 =?us-ascii?Q?ZrljKIm3JK9N3AaBHjM7U0SoO67AiXW8rXop1uQCUQUjlaCOqnGVlOcCwTNz?=
 =?us-ascii?Q?7LcOXW9qGkY1PBVgIu9XVfrp8CZRsqDWSi4jjunFbWD7MvsgIP7D2hkFpb0F?=
 =?us-ascii?Q?Jyi75OO9w0NlBs6WgX5kBFxC6Q3CfuJgwr/WQl0C/GnqsWvBNWrjXf6gx3yb?=
 =?us-ascii?Q?Gvi9oZY41jkRl4T0793W3rynV6Mrfx0o0KDnzhw6kJTzO0F5wk0Re+s7sAy+?=
 =?us-ascii?Q?OSaDzt4pDmkpG0PBWiuvUM0cvxZqvkXdC0VH2AU9CES+I8OsaM3to4ia8MU+?=
 =?us-ascii?Q?dTqKHvhbzh3zkb6nyuf7gmZqTbhGpLgiT0O0R/fyV5aJzbx6fZTBxlrkLzmd?=
 =?us-ascii?Q?m8WS92/pcd9Jy1YGGvtrieC8NSRw7dR8vRFCbPsL7wAlUu0dIzMhONZNaY0r?=
 =?us-ascii?Q?9jJe/C1SgopRll7zsCt2fhqan4PD/JJlBhN2RuAp5Que0XSSInBkE3zhBQ6+?=
 =?us-ascii?Q?sTADZS53HUnoiqMWb430lazyW2hcotgTy3IId12UcjxzQrhvIulwNbJ9wyMW?=
 =?us-ascii?Q?PhhORiSGA+uFaNZ7BT4ZAsawVEqAelLVnJGY0I+p1qyaOmI13r2o0M8dgRmk?=
 =?us-ascii?Q?q19At4Lu6+sw6kNBDHISrjO1I9rAyoYKlbyT0Tks7yOEJb5AaNCGBZKLSgo3?=
 =?us-ascii?Q?6vNkxGovj6H2C5XB9Ow3El1whc4dxi9kaMH+uxDGGQyD0ixxxEeMBmPX4b5Q?=
 =?us-ascii?Q?Rc8WDUMmM6qCvKagJpLsMPk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de494ab-eb38-4ca9-5c8d-08de26d57e20
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:52.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Guz/OXxqLOS7VHJuIKEh3Ny4IUMvh6F8pDvd5jKC/7DWhsrd+0wV0P524YiuNNS2jtw23uAxyuafyAAedfVcZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

This is the standalone variant of drivers/net/dsa/sja1105/sja1105_mdio.c.
Same kind of differences between this driver and the embedded DSA one
apply: regmap is being used for register access, and addresses are
multiplied by 4 with regmap.

In fact this is so generic that there is nothing NXP SJA1110 specific
about it at all, and just instantiates mdio-regmap. I decided to name it
mdio-regmap-simple.c in the style of drivers/mfd/simple-mfd-i2c.c which
has support for various vendor compatible strings.

Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 MAINTAINERS                           |  1 +
 drivers/net/mdio/Kconfig              | 14 +++--
 drivers/net/mdio/Makefile             |  1 +
 drivers/net/mdio/mdio-regmap-simple.c | 77 +++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/mdio/mdio-regmap-simple.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c41b9d86c144..81c3dba6acd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15473,6 +15473,7 @@ M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/mdio/mdio-regmap.c
+F:	drivers/net/mdio/mdio-regmap-simple.c
 F:	include/linux/mdio/mdio-regmap.h
 
 MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 9819d1dc18de..2f86a438a2a7 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -179,14 +179,22 @@ config MDIO_REALTEK_RTL9300
 config MDIO_REGMAP
 	tristate
 	help
-	  This driver allows using MDIO devices that are not sitting on a
-	  regular MDIO bus, but still exposes the standard 802.3 register
+	  This support module allows using MDIO devices that are not sitting on
+	  a regular MDIO bus, but still exposes the standard 802.3 register
 	  layout. It's regmap-based so that it can be used on integrated,
 	  memory-mapped PHYs, SPI PHYs and so on. A new virtual MDIO bus is
 	  created, and its read/write operations are mapped to the underlying
-	  regmap. Users willing to use this driver must explicitly select
+	  regmap. Users willing to use this module must explicitly select
 	  REGMAP.
 
+config MDIO_REGMAP_SIMPLE
+	tristate
+	help
+	  Generic platform driver for MDIO buses with a linear address space
+	  that can be directly accessed using the MDIO_REGMAP support code and
+	  need no special handling. The regmap is provided by the parent
+	  device.
+
 config MDIO_THUNDER
 	tristate "ThunderX SOCs MDIO buses"
 	depends on 64BIT
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index 9abf20d1b030..95f201b73a7d 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_MDIO_MVUSB)		+= mdio-mvusb.o
 obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
 obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
 obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
+obj-$(CONFIG_MDIO_REGMAP_SIMPLE)	+= mdio-regmap-simple.o
 obj-$(CONFIG_MDIO_SJA1110_CBT1)		+= mdio-sja1110-cbt1.o
 obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
 obj-$(CONFIG_MDIO_THUNDER)		+= mdio-thunder.o
diff --git a/drivers/net/mdio/mdio-regmap-simple.c b/drivers/net/mdio/mdio-regmap-simple.c
new file mode 100644
index 000000000000..6ac390ec759b
--- /dev/null
+++ b/drivers/net/mdio/mdio-regmap-simple.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 NXP
+ *
+ * Generic MDIO bus driver for simple regmap-based MDIO devices
+ *
+ * This driver creates MDIO buses for devices that expose their internal
+ * PHYs or PCS through a regmap interface. It's intended to be a simple,
+ * generic driver similar to simple-mfd-i2c.c.
+ */
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mdio/mdio-regmap.h>
+
+struct mdio_regmap_simple_data {
+	u8 valid_addr;
+	bool autoscan;
+};
+
+static const struct mdio_regmap_simple_data nxp_sja1110_base_tx = {
+	.valid_addr = 0,
+	.autoscan = false,
+};
+
+static int mdio_regmap_simple_probe(struct platform_device *pdev)
+{
+	const struct mdio_regmap_simple_data *data;
+	struct mdio_regmap_config config = {};
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	struct mii_bus *bus;
+
+	if (!dev->of_node || !dev->parent)
+		return -ENODEV;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	data = device_get_match_data(dev);
+
+	config.regmap = regmap;
+	config.parent = dev;
+	config.name = dev_name(dev);
+	config.resource = platform_get_resource(pdev, IORESOURCE_REG, 0);
+	if (data) {
+		config.valid_addr = data->valid_addr;
+		config.autoscan = data->autoscan;
+	}
+
+	return PTR_ERR_OR_ZERO(devm_mdio_regmap_register(dev, &config));
+}
+
+static const struct of_device_id mdio_regmap_simple_match[] = {
+	{
+		.compatible = "nxp,sja1110-base-tx-mdio",
+		.data = &nxp_sja1110_base_tx,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mdio_regmap_simple_match);
+
+static struct platform_driver mdio_regmap_simple_driver = {
+	.probe = mdio_regmap_simple_probe,
+	.driver = {
+		.name = "mdio-regmap-simple",
+		.of_match_table = mdio_regmap_simple_match,
+	},
+};
+
+module_platform_driver(mdio_regmap_simple_driver);
+
+MODULE_DESCRIPTION("Generic MDIO bus driver for simple regmap-based devices");
+MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1


