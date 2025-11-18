Return-Path: <netdev+bounces-239688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C73C6B5A1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 245D129EAC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD50364EA5;
	Tue, 18 Nov 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T9hYsU0C"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD9350A2C;
	Tue, 18 Nov 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492768; cv=fail; b=LGpOReHST08P2JOKxcF1xOFy37ORNAyWNFUuGmit/ssNtxTWdiDj+L5Cpz0Me/6qbYK6ZJHtCaUW0pOVFC2+E8imITLJFYqQwT1Ul+az8wrZp/qIkWIxjjWuPbmo3bOWizzMkRuPnq5jlOBh3AlDN8Q1fIal/GcH/rRIywZLORQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492768; c=relaxed/simple;
	bh=0bQjPPkFoC1bZAqNNDdr+79sAx9j4DBJTkaeZOS2ds0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gu6QSfSIHfzjFATTKN1Qn8plfIDjFy3FaqZD0Kny+HtdfG3/W69yixg+YgDgkt54BnKZfzE0nJLkOaEMkYS7PqS5vgkNxHYimzmof/DyukEmPgynRMQcYMaeeSmtWKfLbunBEPHgZ7ckguPA91y5B/MQJFEVJrr6ryv3r2e0kY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T9hYsU0C; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSLRy6FIeUi+64tNguY1dM4KBaNHg/cp0yoAeQmvRkrgCwLjzlEGBhh9KLxMR4dmGAyYaPsZWcF4QvHOVGUp8mPEh3xWPWQuJ10M5Mpv1I0OT0I6eMIaLDPx9+J1NBIVTrV47onO8ySVFwJQRZAemupZle+j+8TeUNaobnIGmcud7u62F6t+q1cL1f4cg3gCjer7ROaAMBytAKuLVLQScDZNTl0NOHrSfvi+jypMLUDdADUYIizVFyjWgI+CEoTnVdZWMdzAQj7GIGUxkW+1j7n3PJZNwEPGT/Zk40D1ROov63CGDRvZstSCSMVTDQrtWBwwJY2bgd/dDNkmFXwmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGdyqB0LpOL6UN/DSl21Piu3Owz5FN2ThQcwdHG53c0=;
 b=COyNlxUlyFdliFGdIvs3K5xtLMCyTMnPlLFeDQBZKpW1QowHVViuSPOhVE3xLVVeQPAzqLH1RRvb0SAi046s8gicf/eGgmVSUogHNO5l5vylPg/dSnAj2m5KZJMG4qFO6zqFK3G0If1Kjecv+Z8YKblUvABsTadx7l5sMIJ47wGCUem9nz4QH/aTAa34N7LrsTqwiQqMsN0dY43wzYXCp5PY33JRkm7ST09722Q1wWJap/gwBH1qM/f5uV239CYGgc2XuY67z4dRkI9oEMbsfklv9oMCB+QYomXzKYadBROw3sn7xLJF6tGFirsPz5GVEIdplsRzeLoVTAlhMSmn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGdyqB0LpOL6UN/DSl21Piu3Owz5FN2ThQcwdHG53c0=;
 b=T9hYsU0CPm1YAGaKuGhy22Iihi/WA+wvPpYo83bgCiB+MSLt9nMYvRGY0co9gXwh5LKTgWVYGxXDHrftUFSwtB2/y5tlKWGaXaTOKlcYUKfgsCEvNjkiUU3JX4lv2OR2R43l8NV7GNXc8RBKGggoYsY9s1Q210gMooXknE+zK2r0ardCdS96fxqPltjzmL1K6GPCHBpU45VHZNk+wW/FIh1Qkzhfh3DdFMmTBerJNWoOtUxmrgtNmUsBw2Vpz3Lbt9lcwK8PX9KeLktNygoIrlIyKKIGcSRodd2scxnfn/+7aFxkCOnOrrJ+PoUWGWLzVah3MtGOSE2MdNAr3NL0Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:56 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:56 +0000
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
	Lee Jones <lee@kernel.org>
Subject: [PATCH net-next 08/15] net: dsa: sja1105: transition OF-based MDIO drivers to standalone
Date: Tue, 18 Nov 2025 21:05:23 +0200
Message-Id: <20251118190530.580267-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a4195225-fc38-4cdb-f9f0-08de26d580ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0egjuXFt8VSuI6q7VUCzGUnX/xllI30JCesAafA/q2Q/cKtScLtpUDF99CXR?=
 =?us-ascii?Q?DOrjEAD3whvMDAZdnI0dWYyqUag8e8hw+AXj64KDM/fFBsoQpD7XYNcsMvds?=
 =?us-ascii?Q?hqhT4i7I5XudFw/WQkRA3rEVlBCP25/HYLsN9Z739DlukeyN3kTq/SPf8bxk?=
 =?us-ascii?Q?9qch7JHIO/EjX9Gfh1sFczeriEW71LRI09+LejeQ+zREO/OqRUDw6eT6Hoqj?=
 =?us-ascii?Q?kD94Md+eND+7hl4DYj95D/PlzzKeIQKje21MIzC7UZ1r5DLMMAaAeNo6i9tT?=
 =?us-ascii?Q?eqRKWz3ENY2zMg039QaRxhtk5ToAzocKNz9FadZ9Z5Ch3XE2FEmvjTl5TgfE?=
 =?us-ascii?Q?5VnjOyXur2JK/IOUaaAt+PtR0lTDmo3v4sqajrctYz1X/iP2DGwMssKjJ/NM?=
 =?us-ascii?Q?ApBxv6+p56NSihHZYhwrRert/Dx5/9OFrPD20vYbkUC5qrEGaeFbC6u7q5Rk?=
 =?us-ascii?Q?APfIvTn4GdU2/FvFlUhxgATQDbFQqmPaIcadSnbBpWhk/e/lEExX+4TOXdYZ?=
 =?us-ascii?Q?jKAd9SuYNZivEOEkA9prEnES8j2r6GI5mdWZSLftHpqwFMWA/p/mAxUD5JoF?=
 =?us-ascii?Q?TwaHqitTmHKtLQNHvmE1vt8SbpNDTUZ8Ly95Z74BwOP7oqRY3xVlZ3kXsXt/?=
 =?us-ascii?Q?quNSHh2UwplNKxqXzLFSCtIqou9NvO+Q89iAbopn32wacv0N4/G83u+0V+uK?=
 =?us-ascii?Q?c4BqeCNG7gU3JFMr14NUqCNIAo9KaveapOjOs4fMcXSeKj8YA0FVEbh2t7oF?=
 =?us-ascii?Q?OmFGk26BNvg1dLijpXYMg/xDLvEwNgSoypPIpUf33qd+nHICu1bfqa0ayHj7?=
 =?us-ascii?Q?9vul1e/EoZbdSK6IFVzJPBCnNq/KJK3C+PQqrM5aPD3ZCqU2cwyXLe+MBLyG?=
 =?us-ascii?Q?LUp+7eG2tZgkMxhtf7dS4x7RPyFWNGZ1MAxFYx7vsKhewgVTNjX1sWPaDWkj?=
 =?us-ascii?Q?terc1oPKL193jF4E63TSUo3BxQNi6crCaRyzs3mP3905rfjuvHDCfjglAPhT?=
 =?us-ascii?Q?YVRYDQDOqumQGPSvV7dGh0I0vyfjC1hLL6oCn6y3pwiCD1Ugg8Egma68oTx5?=
 =?us-ascii?Q?GsgM03ROmWmFpjWJl2LIIPi+IuT0MLg/OKP/xNWkjHiGDEVBAfe5rorZ1pAi?=
 =?us-ascii?Q?K2YpPz+rs28YLdOB5DtiOHk7Z2cNU+tYwsxd69rLba1zGXZ42FB2EKcS8Xy0?=
 =?us-ascii?Q?46aZpHHgh684BXORda7rdf7MOLnAP4DOKjOvl7lk6K25IvGk1/mQR/Hd3S2e?=
 =?us-ascii?Q?nKaFUMWmKqN36Dbe0EYJ/Mbm65DAmFX0/5Z/STRvwEaIaY3EQRt0lrZp+DO2?=
 =?us-ascii?Q?KGAEQKNogSIj6sOKwHRfWPDW83TtZTDQdXdGWQ9nyxjzEgjtLQI2E2PoueHC?=
 =?us-ascii?Q?1tfbnE8Je/9+iYZ057ICsp6maVE2Edm4UdU4CyGZ6EPHps1d6sr0cEkSSa6S?=
 =?us-ascii?Q?4bBrmWB8VD+fNeh99kq8MG3LY4Kx8aSN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RdAB8+4WFpAF2BPz9IXl1O+v6hXIOYf7eE30wY793w3uAiej4Srq2kJyyYXT?=
 =?us-ascii?Q?Zu15axvYBaISwjo3rfnCz8X1mKPu9mnk5YmYqYX9qhSKj1RhdyvA/Ws/LVr+?=
 =?us-ascii?Q?mBOAVyvzyYWim4VPofklja8fO8lepdzJqFa7SL7C7wZpmmd1UfHYPV6OxUN8?=
 =?us-ascii?Q?zZXP9oNtcz3ZUjW0r/l6I15SwMUuhxxI+ZyirTVXX0Tcn+Spt2E6e8ovDunx?=
 =?us-ascii?Q?FZKrkg9UAFl/PSyRJPOQSW8fWnVPqAUfk4cwi8aUMymAIyjc1LinQFl98fWE?=
 =?us-ascii?Q?yNg7CXiF2wAYSF2YkRBvMI9TbHstSuZcxYGDyOQyRL+WYV/qG30tX5kEAl/K?=
 =?us-ascii?Q?nDwkE4So2EOSLBBczI23E2zl4d6Foe4XPWZhas26hE38rylv7A/dxOWYFraU?=
 =?us-ascii?Q?g62dMiaZwjv7uNZCRLvTr/XHRzwIxlLtj8Hw16nRG7rTXPJNh855YOCLU0aH?=
 =?us-ascii?Q?0Zk1/XlwhyDEQtdSPyZx0HuuG+X4D8+MK9zg4nhZvpMP6owwiMuVcu/Su9zs?=
 =?us-ascii?Q?CMP16rHgPzs4jQzHcRuvDmcUCf5msArFurtsCO8ktmRt+UWF4qqoDzglfH9p?=
 =?us-ascii?Q?0vzq2LDhmfvtPNIBpbW/E+cowvV30t5sgmkSVfo/AEdtrhEC3/5MY/O8oAhy?=
 =?us-ascii?Q?v1i0d4Rz5tjSK2qv8n+ap2OaPxnDw10wOkdmj2+oDcmeIZchTXpybRr/hy/q?=
 =?us-ascii?Q?CVkb3QK+D0Hzr7jWTw7yn+ohc1ZY4zvo9aRVSWpgrhaSDTrH+jQ00EJnXUky?=
 =?us-ascii?Q?EI6HOtBBSaGTDwAELfsoA38ZAhmBFqAuOfyvICDLMT9FutLM7zk06VynKQDL?=
 =?us-ascii?Q?1g3j1ca1DOAWGtw9NyDxa3tEHBa6bUXBNj/1tQvvgqPMOc+24/GsUPzaxE5J?=
 =?us-ascii?Q?jGhkg4NVRrlMIgRm+tjALcoxvRDll6Sh9IjOTc11bOBW38heQClSkiXFVrG6?=
 =?us-ascii?Q?RoMzlZxC4iom9UHg6Ndzt2vNbTadOBR/ijwBU/8P0c8FrMkbkcD2hDJtd5w1?=
 =?us-ascii?Q?5DlZ+f/Z2TKYWKK2mFTSF5WdBxZp7x6ViJyAbHfVp1TZjzbKSmB0ZPls/QNg?=
 =?us-ascii?Q?7eSwuUAZPcMdMYW6GuH/c5gj05Fwx0gc/aHD4RdtOP56YFUQG+YGUXkt0hOD?=
 =?us-ascii?Q?I1p5d0GPcekmDSgnuAw9xXnuIuxiFR8ufuNTEhMvkmD968vgVs6/E4CX1URF?=
 =?us-ascii?Q?IJcKEGxQnipL4ZSeNsIolddPPRSHu21k4pI0YUxrm0NfemqNGJ8cM+n0kKV0?=
 =?us-ascii?Q?T88XaOu0Ormezl0yTEWa0oGi5lA1WqQYruHmSHc3EnZIW1X7jOLyTEqsBMHP?=
 =?us-ascii?Q?QP8WLr67n7ZooxLUQlSIZkWBYaGJR3Pdqplmi2BZ+aSvcPFiYD8eyhwXNm1H?=
 =?us-ascii?Q?Igrfnl8Fwr9o1JUvf7JPh6SThyhbI3EFjEJdXD8GjJ1TBgVAMCm7V8PIix+G?=
 =?us-ascii?Q?2m0nvkmDCizT3PgNZ4y9HjdVBv9NwEsUWky4hHeKPgxqR12YaE/LaLHW7bpo?=
 =?us-ascii?Q?6Ui5uMOGfm5dMpDyIJ1Pk51nU8KvXgTl6Qa8IvcivaQJZxn5TBEFL4fPD/v7?=
 =?us-ascii?Q?YxAL32THbkd1YvuUoHRiELP5XLLpoirBmSXRrLiwt8D5UW59c/cOtAWUsZXp?=
 =?us-ascii?Q?QGd1ke0lckFMU76xPsTQx/4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4195225-fc38-4cdb-f9f0-08de26d580ca
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:56.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aHDvQwHigFj7WzMMULRrEgWf1xn2Hr8Yr7sSZzhQS9VfoO4gDdwVmujNwtEKjyNNqSXY5sGu27mxeA+u8TWsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

Delete the duplicated drivers for 100base-T1 and 100base-TX from the DSA
driver, and use devm_mfd_add_devices() to platform devices which probe
on the dedicated drivers from drivers/net/mdio/. This makes the switch
act as a sort of bus driver for devices in the "mdios" subnode.

We can use mfd because the switch driver interacts with the PHYs from
these MDIO buses exclusively using phylink, which follows "phy-handle"
fwnode references to them.

Cc: Lee Jones <lee@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/Kconfig        |   1 +
 drivers/net/dsa/sja1105/Makefile       |   1 +
 drivers/net/dsa/sja1105/sja1105.h      |   4 -
 drivers/net/dsa/sja1105/sja1105_main.c |  13 ++
 drivers/net/dsa/sja1105/sja1105_mdio.c | 270 +------------------------
 drivers/net/dsa/sja1105/sja1105_mfd.c  |  69 +++++++
 drivers/net/dsa/sja1105/sja1105_mfd.h  |   9 +
 drivers/net/dsa/sja1105/sja1105_spi.c  |   6 -
 8 files changed, 94 insertions(+), 279 deletions(-)
 create mode 100644 drivers/net/dsa/sja1105/sja1105_mfd.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_mfd.h

diff --git a/drivers/net/dsa/sja1105/Kconfig b/drivers/net/dsa/sja1105/Kconfig
index 1291bba3f3b6..932bca545d69 100644
--- a/drivers/net/dsa/sja1105/Kconfig
+++ b/drivers/net/dsa/sja1105/Kconfig
@@ -7,6 +7,7 @@ tristate "NXP SJA1105 Ethernet switch family support"
 	select PCS_XPCS
 	select PACKING
 	select CRC32
+	select MFD_CORE
 	help
 	  This is the driver for the NXP SJA1105 (5-port) and SJA1110 (10-port)
 	  automotive Ethernet switch family. These are managed over an SPI
diff --git a/drivers/net/dsa/sja1105/Makefile b/drivers/net/dsa/sja1105/Makefile
index 40d69e6c0bae..3ac2d77dbe6c 100644
--- a/drivers/net/dsa/sja1105/Makefile
+++ b/drivers/net/dsa/sja1105/Makefile
@@ -5,6 +5,7 @@ sja1105-objs := \
     sja1105_spi.o \
     sja1105_main.o \
     sja1105_mdio.o \
+    sja1105_mfd.o \
     sja1105_flower.o \
     sja1105_ethtool.o \
     sja1105_devlink.o \
diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 4fd6121bd07f..ff6b69663851 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -91,8 +91,6 @@ struct sja1105_regs {
 	u64 rmii_ref_clk[SJA1105_MAX_NUM_PORTS];
 	u64 rmii_ext_tx_clk[SJA1105_MAX_NUM_PORTS];
 	u64 stats[__MAX_SJA1105_STATS_AREA][SJA1105_MAX_NUM_PORTS];
-	u64 mdio_100base_tx;
-	u64 mdio_100base_t1;
 	u64 pcs_base[SJA1105_MAX_NUM_PORTS];
 };
 
@@ -279,8 +277,6 @@ struct sja1105_private {
 	struct regmap *regmap;
 	struct devlink_region **regions;
 	struct sja1105_cbs_entry *cbs;
-	struct mii_bus *mdio_base_t1;
-	struct mii_bus *mdio_base_tx;
 	struct mii_bus *mdio_pcs;
 	struct phylink_pcs *pcs[SJA1105_MAX_NUM_PORTS];
 	struct sja1105_ptp_data ptp_data;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 622264c13fdb..6da5c655dae7 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -23,6 +23,7 @@
 #include <linux/units.h>
 
 #include "sja1105.h"
+#include "sja1105_mfd.h"
 #include "sja1105_tas.h"
 
 #define SJA1105_UNKNOWN_MULTICAST	0x010000000000ull
@@ -3316,6 +3317,11 @@ static int sja1105_probe(struct spi_device *spi)
 	if (priv->max_xfer_len > max_msg - SJA1105_SIZE_SPI_MSG_HEADER)
 		priv->max_xfer_len = max_msg - SJA1105_SIZE_SPI_MSG_HEADER;
 
+	/* Explicitly advertise "no DMA" support, to suppress
+	 * "DMA mask not set" warning in MFD children
+	 */
+	dev->dma_mask = &dev->coherent_dma_mask;
+
 	priv->info = of_device_get_match_data(dev);
 
 	rc = sja1105_create_regmap(priv);
@@ -3356,6 +3362,13 @@ static int sja1105_probe(struct spi_device *spi)
 		return rc;
 	}
 
+	rc = sja1105_mfd_add_devices(ds);
+	if (rc) {
+		dev_err(ds->dev, "Failed to create child devices: %pe\n",
+			ERR_PTR(rc));
+		return rc;
+	}
+
 	if (IS_ENABLED(CONFIG_NET_SCH_CBS)) {
 		priv->cbs = devm_kcalloc(dev, priv->info->num_cbs_shapers,
 					 sizeof(struct sja1105_cbs_entry),
diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
index 8d535c033cef..b803ce71f5cc 100644
--- a/drivers/net/dsa/sja1105/sja1105_mdio.c
+++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
@@ -133,238 +133,6 @@ int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
 				&tmp, NULL);
 }
 
-enum sja1105_mdio_opcode {
-	SJA1105_C45_ADDR = 0,
-	SJA1105_C22 = 1,
-	SJA1105_C45_DATA = 2,
-	SJA1105_C45_DATA_AUTOINC = 3,
-};
-
-static u64 sja1105_base_t1_encode_addr(struct sja1105_private *priv,
-				       int phy, enum sja1105_mdio_opcode op,
-				       int xad)
-{
-	const struct sja1105_regs *regs = priv->info->regs;
-
-	return regs->mdio_100base_t1 | (phy << 7) | (op << 5) | (xad << 0);
-}
-
-static int sja1105_base_t1_mdio_read_c22(struct mii_bus *bus, int phy, int reg)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C22, reg & 0x1f);
-
-	rc = sja1105_xfer_u32(priv, SPI_READ, addr, &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	return tmp & 0xffff;
-}
-
-static int sja1105_base_t1_mdio_read_c45(struct mii_bus *bus, int phy,
-					 int mmd, int reg)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C45_ADDR, mmd);
-
-	rc = sja1105_xfer_u32(priv, SPI_WRITE, addr, &reg, NULL);
-	if (rc < 0)
-		return rc;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C45_DATA, mmd);
-
-	rc = sja1105_xfer_u32(priv, SPI_READ, addr, &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	return tmp & 0xffff;
-}
-
-static int sja1105_base_t1_mdio_write_c22(struct mii_bus *bus, int phy, int reg,
-					  u16 val)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	u64 addr;
-	u32 tmp;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C22, reg & 0x1f);
-
-	tmp = val & 0xffff;
-
-	return sja1105_xfer_u32(priv, SPI_WRITE, addr, &tmp, NULL);
-}
-
-static int sja1105_base_t1_mdio_write_c45(struct mii_bus *bus, int phy,
-					  int mmd, int reg, u16 val)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C45_ADDR, mmd);
-
-	rc = sja1105_xfer_u32(priv, SPI_WRITE, addr, &reg, NULL);
-	if (rc < 0)
-		return rc;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C45_DATA, mmd);
-
-	tmp = val & 0xffff;
-
-	return sja1105_xfer_u32(priv, SPI_WRITE, addr, &tmp, NULL);
-}
-
-static int sja1105_base_tx_mdio_read(struct mii_bus *bus, int phy, int reg)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	const struct sja1105_regs *regs = priv->info->regs;
-	u32 tmp;
-	int rc;
-
-	rc = sja1105_xfer_u32(priv, SPI_READ, regs->mdio_100base_tx + reg,
-			      &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	return tmp & 0xffff;
-}
-
-static int sja1105_base_tx_mdio_write(struct mii_bus *bus, int phy, int reg,
-				      u16 val)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	const struct sja1105_regs *regs = priv->info->regs;
-	u32 tmp = val;
-
-	return sja1105_xfer_u32(priv, SPI_WRITE, regs->mdio_100base_tx + reg,
-				&tmp, NULL);
-}
-
-static int sja1105_mdiobus_base_tx_register(struct sja1105_private *priv,
-					    struct device_node *mdio_node)
-{
-	struct sja1105_mdio_private *mdio_priv;
-	struct device_node *np;
-	struct mii_bus *bus;
-	int rc = 0;
-
-	np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-tx-mdio");
-	if (!np)
-		return 0;
-
-	if (!of_device_is_available(np))
-		goto out_put_np;
-
-	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
-	if (!bus) {
-		rc = -ENOMEM;
-		goto out_put_np;
-	}
-
-	bus->name = "SJA1110 100base-TX MDIO bus";
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-base-tx",
-		 dev_name(priv->ds->dev));
-	bus->read = sja1105_base_tx_mdio_read;
-	bus->write = sja1105_base_tx_mdio_write;
-	bus->parent = priv->ds->dev;
-	mdio_priv = bus->priv;
-	mdio_priv->priv = priv;
-
-	rc = of_mdiobus_register(bus, np);
-	if (rc) {
-		mdiobus_free(bus);
-		goto out_put_np;
-	}
-
-	priv->mdio_base_tx = bus;
-
-out_put_np:
-	of_node_put(np);
-
-	return rc;
-}
-
-static void sja1105_mdiobus_base_tx_unregister(struct sja1105_private *priv)
-{
-	if (!priv->mdio_base_tx)
-		return;
-
-	mdiobus_unregister(priv->mdio_base_tx);
-	mdiobus_free(priv->mdio_base_tx);
-	priv->mdio_base_tx = NULL;
-}
-
-static int sja1105_mdiobus_base_t1_register(struct sja1105_private *priv,
-					    struct device_node *mdio_node)
-{
-	struct sja1105_mdio_private *mdio_priv;
-	struct device_node *np;
-	struct mii_bus *bus;
-	int rc = 0;
-
-	np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-t1-mdio");
-	if (!np)
-		return 0;
-
-	if (!of_device_is_available(np))
-		goto out_put_np;
-
-	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
-	if (!bus) {
-		rc = -ENOMEM;
-		goto out_put_np;
-	}
-
-	bus->name = "SJA1110 100base-T1 MDIO bus";
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-base-t1",
-		 dev_name(priv->ds->dev));
-	bus->read = sja1105_base_t1_mdio_read_c22;
-	bus->write = sja1105_base_t1_mdio_write_c22;
-	bus->read_c45 = sja1105_base_t1_mdio_read_c45;
-	bus->write_c45 = sja1105_base_t1_mdio_write_c45;
-	bus->parent = priv->ds->dev;
-	mdio_priv = bus->priv;
-	mdio_priv->priv = priv;
-
-	rc = of_mdiobus_register(bus, np);
-	if (rc) {
-		mdiobus_free(bus);
-		goto out_put_np;
-	}
-
-	priv->mdio_base_t1 = bus;
-
-out_put_np:
-	of_node_put(np);
-
-	return rc;
-}
-
-static void sja1105_mdiobus_base_t1_unregister(struct sja1105_private *priv)
-{
-	if (!priv->mdio_base_t1)
-		return;
-
-	mdiobus_unregister(priv->mdio_base_t1);
-	mdiobus_free(priv->mdio_base_t1);
-	priv->mdio_base_t1 = NULL;
-}
-
 static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
 {
 	struct sja1105_mdio_private *mdio_priv;
@@ -459,49 +227,13 @@ static void sja1105_mdiobus_pcs_unregister(struct sja1105_private *priv)
 int sja1105_mdiobus_register(struct dsa_switch *ds)
 {
 	struct sja1105_private *priv = ds->priv;
-	const struct sja1105_regs *regs = priv->info->regs;
-	struct device_node *switch_node = ds->dev->of_node;
-	struct device_node *mdio_node;
-	int rc;
-
-	rc = sja1105_mdiobus_pcs_register(priv);
-	if (rc)
-		return rc;
-
-	mdio_node = of_get_available_child_by_name(switch_node, "mdios");
-	if (!mdio_node)
-		return 0;
 
-	if (regs->mdio_100base_tx != SJA1105_RSV_ADDR) {
-		rc = sja1105_mdiobus_base_tx_register(priv, mdio_node);
-		if (rc)
-			goto err_put_mdio_node;
-	}
-
-	if (regs->mdio_100base_t1 != SJA1105_RSV_ADDR) {
-		rc = sja1105_mdiobus_base_t1_register(priv, mdio_node);
-		if (rc)
-			goto err_free_base_tx_mdiobus;
-	}
-
-	of_node_put(mdio_node);
-
-	return 0;
-
-err_free_base_tx_mdiobus:
-	sja1105_mdiobus_base_tx_unregister(priv);
-err_put_mdio_node:
-	of_node_put(mdio_node);
-	sja1105_mdiobus_pcs_unregister(priv);
-
-	return rc;
+	return sja1105_mdiobus_pcs_register(priv);
 }
 
 void sja1105_mdiobus_unregister(struct dsa_switch *ds)
 {
 	struct sja1105_private *priv = ds->priv;
 
-	sja1105_mdiobus_base_t1_unregister(priv);
-	sja1105_mdiobus_base_tx_unregister(priv);
 	sja1105_mdiobus_pcs_unregister(priv);
 }
diff --git a/drivers/net/dsa/sja1105/sja1105_mfd.c b/drivers/net/dsa/sja1105/sja1105_mfd.c
new file mode 100644
index 000000000000..9e60cd3b5d01
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_mfd.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 NXP
+ */
+#include <linux/ioport.h>
+#include <linux/mfd/core.h>
+
+#include "sja1105.h"
+#include "sja1105_mfd.h"
+
+static const struct resource sja1110_mdio_cbtx_res =
+	DEFINE_RES_REG_NAMED(0x709000, 0x1000, "mdio_cbtx");
+
+static const struct resource sja1110_mdio_cbt1_res =
+	DEFINE_RES_REG_NAMED(0x704000, 0x4000, "mdio_cbt1");
+
+static void sja1105_mfd_add_mdio_cells(struct sja1105_private *priv,
+				       struct device_node *mdio_node,
+				       struct mfd_cell *cells,
+				       int *num_cells)
+{
+	struct device_node *np;
+
+	np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-tx-mdio");
+	if (np && of_device_is_available(np)) {
+		cells[(*num_cells)++] = (struct mfd_cell) {
+			.name = "sja1110-base-tx-mdio",
+			.of_compatible = "nxp,sja1110-base-tx-mdio",
+			.resources = &sja1110_mdio_cbtx_res,
+			.num_resources = 1,
+			.parent_of_node = mdio_node,
+		};
+	}
+	if (np)
+		of_node_put(np);
+
+	np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-t1-mdio");
+	if (np && of_device_is_available(np)) {
+		cells[(*num_cells)++] = (struct mfd_cell) {
+			.name = "sja1110-base-t1-mdio",
+			.of_compatible = "nxp,sja1110-base-t1-mdio",
+			.resources = &sja1110_mdio_cbt1_res,
+			.num_resources = 1,
+			.parent_of_node = mdio_node,
+		};
+	}
+	if (np)
+		of_node_put(np);
+}
+
+int sja1105_mfd_add_devices(struct dsa_switch *ds)
+{
+	struct device_node *switch_node = dev_of_node(ds->dev);
+	struct sja1105_private *priv = ds->priv;
+	struct device_node *mdio_node;
+	struct mfd_cell cells[2] = {};
+	int num_cells = 0;
+	int rc = 0;
+
+	mdio_node = of_get_available_child_by_name(switch_node, "mdios");
+	if (mdio_node)
+		sja1105_mfd_add_mdio_cells(priv, mdio_node, cells, &num_cells);
+
+	if (num_cells > 0)
+		rc = devm_mfd_add_devices(ds->dev, PLATFORM_DEVID_AUTO, cells,
+					  num_cells, NULL, 0, NULL);
+
+	of_node_put(mdio_node);
+	return rc;
+}
diff --git a/drivers/net/dsa/sja1105/sja1105_mfd.h b/drivers/net/dsa/sja1105/sja1105_mfd.h
new file mode 100644
index 000000000000..c33c8ff24e25
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_mfd.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2025 NXP
+ */
+#ifndef _SJA1105_MFD_H
+#define _SJA1105_MFD_H
+
+int sja1105_mfd_add_devices(struct dsa_switch *ds);
+
+#endif
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index cfc76af8a65b..087acded7827 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -498,8 +498,6 @@ static const struct sja1105_regs sja1105et_regs = {
 	.ptpclkval = 0x18, /* Spans 0x18 to 0x19 */
 	.ptpclkrate = 0x1A,
 	.ptpclkcorp = 0x1D,
-	.mdio_100base_tx = SJA1105_RSV_ADDR,
-	.mdio_100base_t1 = SJA1105_RSV_ADDR,
 };
 
 static const struct sja1105_regs sja1105pqrs_regs = {
@@ -537,8 +535,6 @@ static const struct sja1105_regs sja1105pqrs_regs = {
 	.ptpclkrate = 0x1B,
 	.ptpclkcorp = 0x1E,
 	.ptpsyncts = 0x1F,
-	.mdio_100base_tx = SJA1105_RSV_ADDR,
-	.mdio_100base_t1 = SJA1105_RSV_ADDR,
 };
 
 static const struct sja1105_regs sja1110_regs = {
@@ -621,8 +617,6 @@ static const struct sja1105_regs sja1110_regs = {
 	.ptpclkrate = SJA1110_SPI_ADDR(0x74),
 	.ptpclkcorp = SJA1110_SPI_ADDR(0x80),
 	.ptpsyncts = SJA1110_SPI_ADDR(0x84),
-	.mdio_100base_tx = 0x1c2400,
-	.mdio_100base_t1 = 0x1c1000,
 	.pcs_base = {SJA1105_RSV_ADDR, 0x1c1400, 0x1c1800, 0x1c1c00, 0x1c2000,
 		     SJA1105_RSV_ADDR, SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
 		     SJA1105_RSV_ADDR, SJA1105_RSV_ADDR, SJA1105_RSV_ADDR},
-- 
2.34.1


