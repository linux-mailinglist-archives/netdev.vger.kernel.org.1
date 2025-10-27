Return-Path: <netdev+bounces-233053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB07C0BACB
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA118A4146
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C352C3272;
	Mon, 27 Oct 2025 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fOFNljh2"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4F2C21CC;
	Mon, 27 Oct 2025 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530874; cv=fail; b=ZvDh/CvsmVdzu3bRrWetAYb7TVG3m8AH8zySn63nRaVcoPFtP7tOfFa72OhqfXzquF+tOutLRS6mql0iZ2Y68xzr1LDU9EQ0hIX48Yw6oQjOEbecDbb4GVTpGDllvodGsKVti5ZUxpI8ZA3kLcnzLU4OsjxydbaP/PJzwCFOdro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530874; c=relaxed/simple;
	bh=rfr8GeNVVLoRB4ixzJcWXTx+DfBCKPd1Z03D41nT13Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBshDZU8NQZvFND8fD46xc9pw9mH4M5kLQ4QnjqjC42KyIz2soGTWzONJsDDYK+IyfU2MkKNhZOsQKyF63Aml0lbzhxMykJgOlyh0lavEj8pW+8Ae9VRWxwN/ZwdAqs441zZyy+aVs+mvZg6ZrvJlOMw9rhB78NN0MDWvpRUYdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fOFNljh2; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf09X6Rm1zzE94zrVRzjJcS/za7J5TixYnk8C+yIuwDnKL75ZaddOr6Xb1bmyeQKxIJHzfqmKDAg1ez/Plhr+mh426nejzfsLn7nYNQ7DM+5Pinnc39ZaG7vnU1ueknHsWZ97sHk6Wg0xQBKBnX2dfQcITb4XTM8F3PBsxCx5aWb6H1FLuO2vG67JeCeMi0GzsQ3ufNVZma4gugbLsqZCGjz0lIGVSs+SGxj5eDew683jinjAEsZiXB7EC+uUfOzIl61chxRau8eUQ79001JId3Aclp5jDNMKb3m8yBNsc/YZJ/4jTahHVP8gTlcelD0MPlCwkklZuDZMUaM8qLbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwmEXgHmKMg/slsJK6QcTMlWSfRUQY+eTmhdHFWcgGk=;
 b=X/KJpz+9mLoI3OQHokgsnh6Lnj0JjygMsrmym1WvF+z6foHH5zOmKbGM977M+iljC+xaawqvPkFXBLjBGrUfvS/zLpPq46fuD88jzQ+w/joqlBjcgIT8jFG0y1xfRnJonyOuSs1Dlr96iD5D3MLfA2cjATrD52jOcVxwxWE+lwWaEuDIxewURcXL5ZaWDc5q7B0krBXWEdMhvLgaGtC0NWHxO1G0A9+WoDsiRHOiiCUxnuQbjmt2gHxSTKD0frH6fKpl/JueOwMv/ziG0kkQIXbLl4izxAEXAk75c2Upib9rVv1pXG2uDovfvoDSAfz3HhQQiZV0lBMr64V8L3J+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwmEXgHmKMg/slsJK6QcTMlWSfRUQY+eTmhdHFWcgGk=;
 b=fOFNljh25B4XKwbBCam90xr0rfZPmePsijrXN01qfq0UioGAr+JYNs8utc+HazeEd1ASGvtOXX5ystozcIV7AGUtmfEp7nV1LIK/D9J51ac6MF6YkPOvIiO5lY6OLqevstKJVjIpkC970bhDWbEGlo1gKfvIcMhczJeUsTZvSovD0SnR5vvJLZQTqF7CiwvG8Xag4lpECl4MVT038uxQ5lal1dqUpUSgPaE1hkuSDhqw11yQIkSOrIIV4yKCzwGp76RMufwDsn5bK9ysSiWb0lANbaKE3LBy8nBIA6lzl1Flrok+GYXVI+WMKVoXtiFPz8vHaqXovXPNfGnDXw3UHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8942.eurprd04.prod.outlook.com (2603:10a6:102:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 02:07:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 02:07:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 net-next 3/6] net: enetc: add preliminary i.MX94 NETC blocks control support
Date: Mon, 27 Oct 2025 09:45:00 +0800
Message-Id: <20251027014503.176237-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027014503.176237-1-wei.fang@nxp.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bab8148-b3d1-4e9b-9ed9-08de14fd9f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PHC9MwDYMyqB0OkBdQSnEXPPEznUWnZ5AxeRpRuQ0PinPF7oZmB8HHRLqibo?=
 =?us-ascii?Q?xRu/zbSqXMN6kiVKmjn6g0GAXJMrrN8OM9kazDrkY0lSOfvWsF/uYaJ3w9nz?=
 =?us-ascii?Q?nhqm4Q2+uSFrBppRJdCrvWzyju/PPY2KXPkIiuvpL2KTOZbgy1UP+wIdPzRz?=
 =?us-ascii?Q?7x4D8YHCFR6OLgUi4Dg6dEMLemvWqmyU0bVNsV8TuSxZoUMIB5kn/qhk1Sdj?=
 =?us-ascii?Q?tb1VCaDN+aNMBvb/y6V07O74eUSte4Ulg9NGDK9Qubrwkqjz3zaeAOMTw22K?=
 =?us-ascii?Q?QyxPh05mbEqtveFln9aiJ52t2VDug4OsSibkQuMoMpg3nBdfzQ3jP9yMO1Ay?=
 =?us-ascii?Q?2LJ3bSF5LbkvRwCrpxgbsnT6j1xc5GCA2WuEa80AV1bH4fSoSf8/qVEaKG68?=
 =?us-ascii?Q?eieRHsyqW5Iw1bIggMGjff1kUGrDIpqTNulJ7k2sBH5ZSv23/JW+NGWALl4W?=
 =?us-ascii?Q?/n+CkWpQ83RPtztVyVyco7MRKiOzCygjLt/PIlyN4bGiPT0In+mn5eysOYyA?=
 =?us-ascii?Q?or838rFaeDH6NgVFEydUAcuJcJqck8RzS63xZZP7+KUemyz6LaO2zLpHN8x+?=
 =?us-ascii?Q?Wy1g2mgiFImK3J6m2BLjhBNWZQtk7znqBVqqSMJ8wTpa16k9k/sn9JNi8pBr?=
 =?us-ascii?Q?X7a8dy8z+JxQLg7N1MFRSD2P4cWIk4dD/4Rdr+UWLPulcFd3+wAdSqbNAqVq?=
 =?us-ascii?Q?CQnZdmsWJQNqXMHFy86+/69XefMv1Tpl3ffJD2+qOLwB0Vjh0gd1vILyQ6yZ?=
 =?us-ascii?Q?GLlMF9gKZkZNacc9IEXdBvN/iTgr0tc+pw6a9Qe8NV5K6eNiYHUJ2wrdQLn7?=
 =?us-ascii?Q?zv9XxftIMG/pfmmz2L0KKtOG5dDF3bmox4EdZKYqNNcF7Q7xxItqZhfYshl3?=
 =?us-ascii?Q?vtyEt2wAgXdFmsv5I4vgqXibV8340poGuHA7PbmxYd1g+KT3kOpNaYmH8izv?=
 =?us-ascii?Q?rFj7BKrBH8pzcpwCCFsJcw2mM+2wQLDU7kIamMdlZF1lbsg8SgUaTUPqTmMJ?=
 =?us-ascii?Q?sGjgUYnoJ5LUnHsDd1pZ3I5fyBc0wkmrFtpZKHuwJc2mz9Ne3bAJ4rbMscoe?=
 =?us-ascii?Q?eq4YcFMDUdfZZ79hB+CMwQJ20qF5bSya8rohZBwu7qOaJBqL/uuqI/MpagH9?=
 =?us-ascii?Q?0V2TRWbTyBV5aEh1wZKMPMEPFKIck24c0CdVhGH7HjBZBURl1TcbPYpTjDTO?=
 =?us-ascii?Q?h1LF340UbqAvlEIivGLeuSym56ie6Z77F150zUP9V+YCUs9cToj4iffMJxx9?=
 =?us-ascii?Q?nS50rtOSGDXOJUiTZOnQuvPIX4XPa7EKFpA4I5AGeAtojgSpUzEmJ8b2MxOK?=
 =?us-ascii?Q?b91OgUpqC55NqSI7rpacLZR7TyMTICFRCHHOw97sOjxA8PZ8VSmvRYugaf5M?=
 =?us-ascii?Q?ZcaT6b6KtLMNYJ9CmAcM5usGo+BEIe7+36TeNb+AhTpsLGH0zOp+7tYhDxSD?=
 =?us-ascii?Q?m/t2v+/0rSmwC88O31VEMWUvmRwBd86u0VX35qdB1FNyogA1+d/Gri1wpuql?=
 =?us-ascii?Q?2TXqENAvoTangwHUzX8cNUMOgU68T9TP1sQLAuvfAqJY4hT5R2t5vq4lLA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nddX/bTklMpjg5J/ZNIG6ugZd1zSOoc0z04mvICvkVnNcMpxaf485vXyHY+U?=
 =?us-ascii?Q?9CmPCiCGW4yCgQv6vcHA8zG8jmRPpFmJiOcE18LimnTJDD8Egy51Sp/aagWT?=
 =?us-ascii?Q?zoau4OJ1zyoL6+AUuPVo5GtSZ/N7tWKqQ8etXjfTdzJVRv9/gwH0pJMFKwWe?=
 =?us-ascii?Q?PMo4327Xd7rJppXMo0dtK+NIzrtKMVKwJ4fBr4xmLeJJbGim+6nSMtDBVjeg?=
 =?us-ascii?Q?VkvE2pa27VpiPnnqt8k5S2pUjF2WiShVJPyJiHu2OJEB8P7D492irCyGU1/j?=
 =?us-ascii?Q?6/lr5LyxljEIOjbJ/UyOiWJEqS1UH9DW5AC0hfD9huGP4OSiAwNx06FX+f6o?=
 =?us-ascii?Q?wm7kiAu6A7uGIPTUs55bcqzxkPXlVc73xy5HGYsj/vi+/GB7P+JYC82NYI3t?=
 =?us-ascii?Q?5UL4DNHtwAK3Q8wJFivHQufmFuDG4slIyx+zQnW7c3b4YRhJuPX7JSRyO/yO?=
 =?us-ascii?Q?CEbRJCHpqvuTTBb+/5NdtPqUQhG9CAyoe/XWurs5YTdtagiVqTKKwW2lhfOC?=
 =?us-ascii?Q?+n2kT1FhTeuRw32ANt8RyKiNZXTLNDanu7E9oOz5NqkCLDWnjrEVVezI1Az0?=
 =?us-ascii?Q?joRTegkfQiqdzpw+YriAGENGbafpJG/J+4OdCiivrVr6wZSKPPYkL4C1u/C8?=
 =?us-ascii?Q?oYNhDqPdJOrzlspOVHFUGTEtq+3U9dedZ7IuDfWGWgPEeChEgy+Rwm+bidIp?=
 =?us-ascii?Q?b6KU9RfElLBodnzxS4dTIv1dWbttiDB/7NiQfEEk17HjqbArw016ZH4XXQk0?=
 =?us-ascii?Q?Two63cEQz7rk8vZC1dvkNZ2CiFQXGLJ2jIDZA9CyvmcMqpD5F6Vv0B3R6Dry?=
 =?us-ascii?Q?OKGi4ObPyN0Tg1SkRZE0Pt1XIS2Wcjt97Q02R0fo7kYqt7uXCKpA94yAhOLa?=
 =?us-ascii?Q?nZ+5EAWhxJ/LrRDknomQxgDuhKaXbvm5hoE/hk3L5SfaU43JQoWHOXPk2MtT?=
 =?us-ascii?Q?8uiuwRJy13J8ehNBUUhg11r9T3CevAOK5vVb/U4exta7ctH9MH3OASQDChP/?=
 =?us-ascii?Q?a2SOotrj9qlLCMF0GztSLeCkz7dJ83KmqQ8/OsDv1Od4nVKC+1dXH7MVSE3P?=
 =?us-ascii?Q?Yirv+qbt37j5bthw2W/lZr8QNFoCu5ipya3fxEhbBaeq2znMwDhkV6LpdQzA?=
 =?us-ascii?Q?4Hp874cIQ97TXSH0S4tEck2tnlekzifToNKnpJAqHb678wpvxFPl7QOFP9Fc?=
 =?us-ascii?Q?HH7hetyff99zSugqGIfk08aQ8j3C1ATNKs02LPoAWO4BL2d8EuOhzKzBVTS5?=
 =?us-ascii?Q?+FIZi+NRzSPlDhZO3RGLobryyHXsvNAIDwjfapS39q7h+DBKRcZd6rJBojVQ?=
 =?us-ascii?Q?n8cNTWZOuCVqBwMtCTH6zWfMDYA+m/p6K5foFJCKRsFRJE8RPESEfuwRk09s?=
 =?us-ascii?Q?SP8tsxp2v00znAXGmbGYQsiNCQvaStYK72PCOVlBW+tPWVlapO+HCfvCs5Ec?=
 =?us-ascii?Q?BW4KeIkLTxeGJioyCrFhxOsVugSt5xaDeXvDcxL2RuvUBFVY/u9mDBdisbSy?=
 =?us-ascii?Q?THPev7zteWtZiPSQKcBaYPKvykPizixdzP6yMw/B6oP1NQYV3o7PZVPD/i5m?=
 =?us-ascii?Q?Ek5RVCq1fl1BHLagYponr6mP2w8h3go291r9nw9w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bab8148-b3d1-4e9b-9ed9-08de14fd9f6c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:07:46.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6cBlZmaMHnva84EymHTf9USMNBCbXtv+TNqyG/2i4510uN1KTd4Z+FFbYLSjNaU1lyu6eBReYTMpfEj7v2lXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8942

NETC blocks control is used for warm reset and pre-boot initialization.
Different versions of NETC blocks control are not exactly the same. We
need to add corresponding netc_devinfo data for each version. The NETC
version of i.MX94 is v4.3, which is different from i.MX95. Currently,
the patch adds the following configurations for ENETCs.

1. Set the link's MII protocol.
2. ENETC 0 (MAC 3) and the switch port 2 (MAC 2) share the same parallel
interface, but due to SoC constraint, they cannot be used simultaneously.
Since the switch is not supported yet, so the interface is assigned to
ENETC 0 by default.

The switch configuration will be added separately in a subsequent patch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index bcb8eefeb93c..5978ea096e80 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -47,6 +47,13 @@
 #define PCS_PROT_SFI			BIT(4)
 #define PCS_PROT_10G_SXGMII		BIT(6)
 
+#define IMX94_EXT_PIN_CONTROL		0x10
+#define  MAC2_MAC3_SEL			BIT(1)
+
+#define IMX94_NETC_LINK_CFG(a)		(0x4c + (a) * 4)
+#define  NETC_LINK_CFG_MII_PROT		GENMASK(3, 0)
+#define  NETC_LINK_CFG_IO_VAR		GENMASK(19, 16)
+
 /* NETC privileged register block register */
 #define PRB_NETCRR			0x100
 #define  NETCRR_SR			BIT(0)
@@ -68,6 +75,13 @@
 #define IMX95_ENETC1_BUS_DEVFN		0x40
 #define IMX95_ENETC2_BUS_DEVFN		0x80
 
+#define IMX94_ENETC0_BUS_DEVFN		0x100
+#define IMX94_ENETC1_BUS_DEVFN		0x140
+#define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_ENETC0_LINK		3
+#define IMX94_ENETC1_LINK		4
+#define IMX94_ENETC2_LINK		5
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -192,6 +206,90 @@ static int imx95_netcmix_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx94_enetc_get_link_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse ENETC link number */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_LINK;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_LINK;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_LINK;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_link_config(struct netc_blk_ctrl *priv,
+			     struct device_node *np, int link_id)
+{
+	phy_interface_t interface;
+	int mii_proto;
+	u32 val;
+
+	/* The node may be disabled and does not have a 'phy-mode'
+	 * or 'phy-connection-type' property.
+	 */
+	if (of_get_phy_mode(np, &interface))
+		return 0;
+
+	mii_proto = netc_get_link_mii_protocol(interface);
+	if (mii_proto < 0)
+		return mii_proto;
+
+	val = mii_proto & NETC_LINK_CFG_MII_PROT;
+	if (val == MII_PROT_SERIAL)
+		val = u32_replace_bits(val, IO_VAR_16FF_16G_SERDES,
+				       NETC_LINK_CFG_IO_VAR);
+
+	netc_reg_write(priv->netcmix, IMX94_NETC_LINK_CFG(link_id), val);
+
+	return 0;
+}
+
+static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
+				   struct device_node *np)
+{
+	int link_id = imx94_enetc_get_link_id(np);
+
+	if (link_id < 0)
+		return link_id;
+
+	return imx94_link_config(priv, np, link_id);
+}
+
+static int imx94_netcmix_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	u32 val;
+	int err;
+
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			err = imx94_enetc_link_config(priv, gchild);
+			if (err)
+				return err;
+		}
+	}
+
+	/* ENETC 0 and switch port 2 share the same parallel interface.
+	 * Currently, the switch is not supported, so this interface is
+	 * used by ENETC 0 by default.
+	 */
+	val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
+	val |= MAC2_MAC3_SEL;
+	netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
+
+	return 0;
+}
+
 static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
 {
 	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
@@ -340,8 +438,14 @@ static const struct netc_devinfo imx95_devinfo = {
 	.ierb_init = imx95_ierb_init,
 };
 
+static const struct netc_devinfo imx94_devinfo = {
+	.flags = NETC_HAS_NETCMIX,
+	.netcmix_init = imx94_netcmix_init,
+};
+
 static const struct of_device_id netc_blk_ctrl_match[] = {
 	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
+	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = &imx94_devinfo },
 	{},
 };
 MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
-- 
2.34.1


