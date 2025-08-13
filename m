Return-Path: <netdev+bounces-213234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A5BB24303
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72C67266D8
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302082D0617;
	Wed, 13 Aug 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mR2plhep"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013052.outbound.protection.outlook.com [52.101.83.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A742D321F;
	Wed, 13 Aug 2025 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071121; cv=fail; b=aVyOkIF0XN0C6W3TSfF0ovONzRLPVOCv8eDwLzpDwtUVrWARoeFa8VQ7H+3Xvk07FhrCCzQyXNV+lTTH0IycJ3tVz+cGuD8rYZSLfmZzMT7pCJMvbNldXAuoGpFjheSgEV9AvMSLzrlfJVmip+/xHXSBvjxreuE7+i4Tk0pzPtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071121; c=relaxed/simple;
	bh=WWPIFoPc9CUA0siiaflQPq37zw+T5yxDBT/rbc1UPsw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JnLowomSFci3+BddGlZloi7dOWZQtPP3wF5b3pK5yKrpam5cLQO9r7BCIP6xguxr8O13ILetQEMGDn8wiKv0abiH7p3zmWakLECirZOGI2+nC8fgsalg4rUXRoCsRrc7d6DFSphbGKnDzXEoc1bdb5DwlZFrUvt0ivgZxfuAAnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mR2plhep; arc=fail smtp.client-ip=52.101.83.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgICFWY62JZ7GYSxG3tyzC6UWGbFhTHmpaSohT9/Tbh5pGNo+VHQWNmfcK0H4RWsDuxPfE9FKhrfeXeVUEzMsbni5hyTnh+Xz71/qkAc5o5ldmGYD8PDGSuqlB6OYWojzN6ykcs9hF02eakdiTMHgCcBfea0yug7yjHELlmdNitYmAC+RrrlVdtQQOa2mvgrU7oW1SbEK5yypP+Oguk3X4wygmXyC0URohlKIHiQsIkbkCRWCLS8/Veqjg8u2PzZW8/HhZeu5S1gE61ufrdgPwFDdL5+W4v0f3h89EgIi48iwkKa58HHmJYuW/gsNf9FUDVGhe8J0I+DBm3pZrXRwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0nMO3s6jdWMDGodeS0h+3IQfMLq/I/NOxayztyEuHg=;
 b=Dux6dHCKAH9C6+mlxP4Xar6ChhSbjnb8N4IhrRrHZZFOKene8YUJYwsobXCWA30k9FZjLyzIOnDX5dcqJ9duDxm3sHfVykjm4e+q6MYfIR1agMU5B8qFMYBDgxi7FhRUASBTG+TgeI7Pvtx1P8uUhBYVS3MInzzJPrfhR4hJSM31cI+zNEMSHSCfV42DJOD2cRkSXhCri2pYuQ06f/Gvgt6FCcyznLRmjsYvsiKEaNvcg6X9eDo8ojl79ev+UD+RMbuztxnMpkzFDmgff+nzMdiTfIZRwwjda8BSASKHX6+Rkk3bEIUCl5m69wn3L9sfneoeAUO8kdosXSQNHYAUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0nMO3s6jdWMDGodeS0h+3IQfMLq/I/NOxayztyEuHg=;
 b=mR2plhepnKJhWgrCoGKuaYxdUvMAwok8cDos4IoZpRBR/2odCmQ4zItFAknfZ7xrEPF4+CjMW7dJc/d6YShCIVjk0KVzU35jdjqq5rLIu/t/0vRPGNAoZs7yTmxNshyopQZfU2y/dlVSHU8omyCOioVXTWAgKKCJWOwVyMmyWfrxZySM/aojHne6Nohy6PtmxSupGjP090mx86GaQviXLIDjvgUyNORlibLbYgNFFxRoLZ/NZ8PbgPzmrqjkjXor/vv3ML+6aL4fo4k3y7fYGMWcrdAakQ0i9qmD569snIsuvs5py3U2JwItU6G/xtH3ZFtXRE6gKLtP8SVMzuT60g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 07:45:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 07:45:13 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: mscc: report and configure in-band auto-negotiation for SGMII/QSGMII
Date: Wed, 13 Aug 2025 10:44:54 +0300
Message-Id: <20250813074454.63224-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0040.eurprd03.prod.outlook.com (2603:10a6:208::17)
 To AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 044d8c93-a858-42a3-5bd8-08ddda3d5692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTXlYlrQ7s4+qGE9DPgkOkvcNyJCrIndWlwfwjUoRLmUhbchytKXFrXdqi71?=
 =?us-ascii?Q?wSK3qFsNAp9+qWFFXNO8ly0ohFLs+GokfD667nM6+H6E+odAj3LCNzQchLvb?=
 =?us-ascii?Q?tBpQotkQJAS52Rp3OuqNrsY2645f+sDCVpuz0bDgyPZPzfXFF3iej5JYkUZX?=
 =?us-ascii?Q?ms7dCdAvfmwFSVJUHOIbXeLyk2mRN529DQfq9emjDI+7YqlazqUEvnVZZBcz?=
 =?us-ascii?Q?dY/yK7iuvpp9c3+bRbuE57UjuWv4Yzd1DLOw/x4dNdfM2r76kpVCLktVrEdn?=
 =?us-ascii?Q?RsVDz8UGnqkCZZePu7Kidb+hqjWZxZRTVDkL1IgSa5Pmi92T9OCd0SoDEIhV?=
 =?us-ascii?Q?pke51cwdiRDMdjbBlFEyr4UaPJ711FnBEVwd47GWsZNi2HD2e2bVwrXx+GiP?=
 =?us-ascii?Q?Ro0VfDKRTNiscL8/WDWIauK0WOC7KfHsicN+Oirg5EHJro2RPyk7AkK4UT8C?=
 =?us-ascii?Q?ujRuVYdrqbR8+JZGxOJiTEnko93ZvUvnFqG2DoKAAhfhQalVkNnaolxpe203?=
 =?us-ascii?Q?RouS8iAAbnyGf9z739+nBzC6v3eEcyEbFQp/naXybv1hJQAYHqvpniGsHDY8?=
 =?us-ascii?Q?HwVjlrluw1KE1oHTmNGlywRC4VBT2U8KDmmXQlfBsbIAP2hnQfET+Kj8REQE?=
 =?us-ascii?Q?x6RClNsSTsgiqXYgRfuksaXQcL5c86fJopsX5u7/K30YQ73cj9Mgupx6o69Z?=
 =?us-ascii?Q?TiA2oBhGKsJb4y1toL51mB9zghREfCTut38hhr5KyVbpU3/3l9WrObTiwlsO?=
 =?us-ascii?Q?eW2VwWS2sTjfg5x0T3j1PC15n0ENrBswh0wSVjfDMmFk82s81xAN5n27ur2v?=
 =?us-ascii?Q?5McBf+GnZ271kLbwsE3nac4OGHy/JbjPQnGdIH+cKYw04zcMPskcIJWsCf6z?=
 =?us-ascii?Q?3WKiLi/RPHobIEekUKl7siVAE5NDZ2QBxwOwsC2kM42VxIEEXYkga+qqrWx3?=
 =?us-ascii?Q?zrF5fiYwk5CFLl/TnIrWw0c/kpzI0qVwCW/6jITDZiQYrzZEMhPq1JU7fJbz?=
 =?us-ascii?Q?8zeAvbsrLvq7+DaZrs9OfoxNV//h//rgecakbGzRJ6zmpCayyPYcnNTUFZVL?=
 =?us-ascii?Q?mYjRrwkNVSpe2Lbul6qcnt3tZew9Ewc/skw1D8opTb6+Sl93gZHStJEUqBnY?=
 =?us-ascii?Q?3q+z+4+vfEFtxI074WbJE6lW7bBFwYIHef8ErWwFKgaRJrSFVgM6Qk4e1afC?=
 =?us-ascii?Q?c9Ncl4aJ1rTfP4vR7t/o8Dw5R9Of1NYPrIM7fGP3845dgiYFu3puk/CFgZTT?=
 =?us-ascii?Q?c9eAlaJLezHef2HWMyMut/oktVJbBBLi3AGsSqhZ4PtJypOmMU8nKXQYVkM9?=
 =?us-ascii?Q?UzSsoB73WBT8jnvkYX9A1liMhQqBmYFejmNU7jfL0S+kBXs2kxjgyps6dO3Z?=
 =?us-ascii?Q?rc4x1SWlzCsaF+3R8aPYyP+Kc/p9XflviPF3DZqyxjvyaOPAXig8aXPCQGBG?=
 =?us-ascii?Q?5wj2XWYx+OdVMMFsNML1CoAszymGlLVJ4zpjjEoI/R1UKX7Zw2AMmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPaZ/9kE59dwKAmJ7KBCS9UV8uYlNN+D4TUJFRZbDKyFTSyFnNRwjfk/MpET?=
 =?us-ascii?Q?x3w/F3eMSaeQ2D5SUlgcQMTVjAoVaUmuJ56KxpTHsHhUoSfWPzScL6gtRm56?=
 =?us-ascii?Q?HjYzx/w7+34F16MQOUfiXKIh1UJ9Ndh0ryoaCxV0kGH/WphCptM0n74ZWzB6?=
 =?us-ascii?Q?+0d8dN+O8mKaUJGISEzQ7NMzdKHD93yJXEN/o9vhK3BvAKAN/dvOPzXzETRN?=
 =?us-ascii?Q?BZYhEWRl4Q1+n3KqiFFaT4o/SYjd/Z1bTF9+2ziSw6KG5Dk+4ienyFUUv9Ey?=
 =?us-ascii?Q?9TqfPhfD+PEB1A7tkShuqVhoDAKQcW36sIFuOF8a5nIH/7wVzUKtXTNfHzxy?=
 =?us-ascii?Q?NBD+txPIDVdWyVDrl8SY+pRUqF57vL5Awygtgk625pN1jUprDM13yFiSSOX1?=
 =?us-ascii?Q?9g1xNu1D/gnhrAylov1P06UrtujOiBrcNrAW2MXIMS2d9mt7l3TTlMv1rEWs?=
 =?us-ascii?Q?I36q+4NxfgAO/lbEYn8DYlGe6jmDgt7HOGR5CyG0z72kW40p667OJcuNlYIZ?=
 =?us-ascii?Q?22hXMIW2UKFuA+50iKFlkUhB5R2nMYVbhlcPrUGWTjXYTsK68zU+Tqrndren?=
 =?us-ascii?Q?JRMHIn4+TwmGZB1kxJKX/cYNybfYQx0wT5oqHvTagW6iZr7rHjIdMnL0vEHO?=
 =?us-ascii?Q?/H57Z/bqE6CKU4syvYIkk5bseA5cxhsK7M3dTt8wr+1h86OATKebqRjkxPc5?=
 =?us-ascii?Q?N5m4Yupmwf7ZPzGiuoRo4slh8Qk0dBYRpohjjdOHRDtfo7+plAdlMLdR2CwF?=
 =?us-ascii?Q?++8uRSrMNaDkdhBK+08AXRJFp7sfJhAGFZ76suKPnaJ7xUNTXtiRQFmd2R9h?=
 =?us-ascii?Q?PJOXNgrFO4Twg6imtfMAS7lGwPnGtNA6okpEMyj4dlhq8dRsDfBman3p6Zeb?=
 =?us-ascii?Q?bRXe1MooF8EfxhZo51WT6KwYj0rvryuXQSs2OvGkZj3o3+pcU2+vnfhQxgps?=
 =?us-ascii?Q?p6WeZtg9IiYF0K1jF0zfAtWBKqiwNzAf7DGMjL5w4WwpBl5H0owz11TacDHP?=
 =?us-ascii?Q?qYwqlJ0c+Sh/mpVPgzpfBqVdjrLFNcNeCmNyq8UYeevJEk/mfnygoboJX3QO?=
 =?us-ascii?Q?hePqmaZfQiel5oC6QhHFV5v2ZdE8ADgeOxdEGATvbhctM0VnrWpfyohpk85X?=
 =?us-ascii?Q?6vPwTLVXu7FoBIE8bqzCg/XQGKj8cda8lV3p6oNwlQ4ybOxRe95jN3x2AMTm?=
 =?us-ascii?Q?Q73PCUFlMgjKvlJ7CSzmC4rtO80LSQPWnqGxIsCaYUXruwWsN4I6zwIOiAhV?=
 =?us-ascii?Q?7hDSkzMYR/AP81Uv4YuoiXf5gC8R6gwf19n637Q79Y0jrKyE83A6bhtmsZih?=
 =?us-ascii?Q?o5wgH23fHB628puGngFOdrcYzAw+T+DRFuwk60I8QIdRgfJg3JaghAlXwDYV?=
 =?us-ascii?Q?+fBTRVQz2mJ9lOXkL+S6OUuxblcEpC3ZoD3ruZEWoSaBaZdOr64oWmR17ahn?=
 =?us-ascii?Q?hB71cK6GvNFv9FdY7Gy2v39lN8qJXkXhO1JMs2ysmF/OLUI8/bbJAA+prxNP?=
 =?us-ascii?Q?YOHonuqe6nmKsloid+N3iEKUUjpOzPTaw3cQh6wBgz7XrY2SJbnCH8P4DhFe?=
 =?us-ascii?Q?liaYEJwWdr0qTbk34PlzBwL7u2VmceZ828zWQy4g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044d8c93-a858-42a3-5bd8-08ddda3d5692
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 07:45:13.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS4gLOCBhXWzvEd1gLDINMt91u8ldA2hI9+zuVu6W4mq0Rcu0Hq3P1uvfGgmhC+A9JUTgqqPzhUXh5inpJcBOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583

The following Vitesse/Microsemi/Microchip PHYs, among those supported by
this driver, have the host interface configurable as SGMII or QSGMII:
- VSC8504
- VSC8514
- VSC8552
- VSC8562
- VSC8572
- VSC8574
- VSC8575
- VSC8582
- VSC8584

All these PHYs are documented to have bit 7 of "MAC SerDes PCS Control"
as "MAC SerDes ANEG enable".

Out of these, I could test the VSC8514 quad PHY in QSGMII. This works
both with the in-band autoneg on and off, on the NXP LS1028A-RDB and
T1040-RDB boards.

Notably, the bit is sticky (survives soft resets), so giving Linux the
tools to read and modify this settings makes it robust to changes made
to it by previous boot layers (U-Boot).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/mscc/mscc.h      |  3 +++
 drivers/net/phy/mscc/mscc_main.c | 40 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 6a3d8a754eb8..138355f1ab0b 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -196,6 +196,9 @@ enum rgmii_clock_delay {
 #define MSCC_PHY_EXTENDED_INT_MS_EGR	  BIT(9)
 
 /* Extended Page 3 Registers */
+#define MSCC_PHY_SERDES_PCS_CTRL	  16
+#define MSCC_PHY_SERDES_ANEG		  BIT(7)
+
 #define MSCC_PHY_SERDES_TX_VALID_CNT	  21
 #define MSCC_PHY_SERDES_TX_CRC_ERR_CNT	  22
 #define MSCC_PHY_SERDES_RX_VALID_CNT	  28
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 7ed6522fb0ef..3bcf48febb1f 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2202,6 +2202,28 @@ static int vsc85xx_read_status(struct phy_device *phydev)
 	return genphy_read_status(phydev);
 }
 
+static unsigned int vsc85xx_inband_caps(struct phy_device *phydev,
+					phy_interface_t interface)
+{
+	if (interface != PHY_INTERFACE_MODE_SGMII &&
+	    interface != PHY_INTERFACE_MODE_QSGMII)
+		return 0;
+
+	return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+}
+
+static int vsc85xx_config_inband(struct phy_device *phydev, unsigned int modes)
+{
+	u16 reg_val = 0;
+
+	if (modes == LINK_INBAND_ENABLE)
+		reg_val = MSCC_PHY_SERDES_ANEG;
+
+	return phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_3,
+				MSCC_PHY_SERDES_PCS_CTRL, MSCC_PHY_SERDES_ANEG,
+				reg_val);
+}
+
 static int vsc8514_probe(struct phy_device *phydev)
 {
 	struct vsc8531_private *vsc8531;
@@ -2409,6 +2431,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.inband_caps    = vsc85xx_inband_caps,
+	.config_inband  = vsc85xx_config_inband,
 },
 {
 	.phy_id		= PHY_ID_VSC8514,
@@ -2432,6 +2456,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.inband_caps    = vsc85xx_inband_caps,
+	.config_inband  = vsc85xx_config_inband,
 },
 {
 	.phy_id		= PHY_ID_VSC8530,
@@ -2552,6 +2578,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.inband_caps    = vsc85xx_inband_caps,
+	.config_inband  = vsc85xx_config_inband,
 },
 {
 	.phy_id		= PHY_ID_VSC856X,
@@ -2574,6 +2602,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.inband_caps    = vsc85xx_inband_caps,
+	.config_inband  = vsc85xx_config_inband,
 },
 {
 	.phy_id		= PHY_ID_VSC8572,
@@ -2599,6 +2629,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.inband_caps    = vsc85xx_inband_caps,
+	.config_inband  = vsc85xx_config_inband,
 },
 {
 	.phy_id		= PHY_ID_VSC8574,
@@ -2624,6 +2656,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.inband_caps    = vsc85xx_inband_caps,
+	.config_inband  = vsc85xx_config_inband,
 },
 {
 	.phy_id		= PHY_ID_VSC8575,
@@ -2647,6 +2681,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.inband_caps    = vsc85xx_inband_caps,
+	.config_inband  = vsc85xx_config_inband,
 },
 {
 	.phy_id		= PHY_ID_VSC8582,
@@ -2670,6 +2706,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+	.inband_caps    = vsc85xx_inband_caps,
+	.config_inband  = vsc85xx_config_inband,
 },
 {
 	.phy_id		= PHY_ID_VSC8584,
@@ -2694,6 +2732,8 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
 	.link_change_notify = &vsc85xx_link_change_notify,
+	.inband_caps    = vsc85xx_inband_caps,
+	.config_inband  = vsc85xx_config_inband,
 }
 
 };
-- 
2.34.1


