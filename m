Return-Path: <netdev+bounces-120783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DCA95AAB5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419051C218DE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 01:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A3014F98;
	Thu, 22 Aug 2024 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RLpXEDI8"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D52032D;
	Thu, 22 Aug 2024 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291511; cv=fail; b=NDzLOQU90fxmZWb8oxJAm9bT13IohfyiE+aNApMOP15wNv5r3eCgaS/507V3sEtrKGl+oBkbw+hpowL1NLuIIBHCTXt7Wyr2otFW7pNORCCcEUS2zge6Cxf2UTlbSK+SIGjDLm7PICPM8WnAEa/Fe8qYP3UooxjVKq4S6dIPB4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291511; c=relaxed/simple;
	bh=c/yjDXb8Xs5wwmu6YO018HRORlCIXvpkVq1sZCfkUME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S3eFqAYRCGJ8WsLhnktaOxZ0b4BECZ2XokfQLRh+dQQmW41DkJTs9cD/9UbgrqIPffoiCyBEfO1bFaGICfVUALK+8NoHu8JYZvBQKnxcNWZiOv2IizCpIb0jfKydA925GCVbwvCmlwM3ijbscV9wcTY876ECRum0znOJkbf9OEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RLpXEDI8; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrtrfbLpTwPOLM++Vis0UOuZXrW2HZN5z2AsE7UBgpOqNJyTQKZn82dBsA+JCw9SPm4tmwmfO0qIeal//nrHc0rgKKkzTpW5CLKAD8rbxFieFAbnXId4yfyhnB/GtjyL7qH1jJvbgqOk325xwHYK9e/GSTkPXZ0jQHtPU7FqoxLNyD1Rp1LOsYJIYUe2QxpxGRQ/dlVZELM6x05hKfsPxCmHShMdFST0wkvVtggGKWikzII1J31+DW6udGYMt04AjTB4PJjelZo8/S7VyuNFYvWlwp4w2jQsPM2Xvwaes99ap17xxps4zYyLK0EqTMjKAjRCDSA4f6oYaWTgF0ArZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfoWWE2Q/v5PSDDXpC+oC6ejzjIYMhpMPaZGDNs6NhA=;
 b=M9H6xxsJzgV8KHvJN1p/M+L8viDlIcMMiBNHYtohbYjr2Zfr5DiK+lFZavR0mJkddmIz9e2quyxhC5tA0/Urfl0QFghSXwEXXY9bt4zNYd3Cdreb1gGleiwTsPLuCZIN5p8XY/sxBb0obo+3niUAdnBUbM0/IzuZkijz0yaHA56D+qu5JwLLj5AG3sf5ptyG9BmEDTDda93vecDhnz5yCnvNEVpSb0d4KgWr/ynHCZh0RjLK42dITDJ3qU6owAg3SXvoVAOwPYXVMWZdlYLG4XR3iPDennYGa7/ha/9bNj35VSl3qbsop85k6/AaYWcmgZtYT94ax5h4CVkevJeirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfoWWE2Q/v5PSDDXpC+oC6ejzjIYMhpMPaZGDNs6NhA=;
 b=RLpXEDI8gYiz+VNmdN2/GzA63MeHK+DfCyrS2a11+qjc8eum89U1uLtvozdgZmaPqgEasepo264sydsf8yYd4ajDL85heqjbQWGPaoZh2x3M4tFUFqtKGaAjz/pF9cW+T78iacofaXsEWvrPp21z51dkpGKc4B3qfgj5HBe6Al9l1wFuQtibuHJ/5AiZSe+v+d8e3XQSd3kl3FOJZ3CDfOP6LODdhsQYsIsZQ5724imKyCZXn/BMA/o3TwHOwDPNx8Sy5V/I25PyvRTQse9MA7PFerW1XFrYotDHpxsxv7C0fdQ5u6Pv5IQUvuDeBO2QJ8AGEwbw9tIrfTd6C8uh2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8755.eurprd04.prod.outlook.com (2603:10a6:20b:42e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 01:51:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 01:51:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 3/3] net: phy: c45-tja11xx: add support for outputing RMII reference clock
Date: Thu, 22 Aug 2024 09:37:21 +0800
Message-Id: <20240822013721.203161-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822013721.203161-1-wei.fang@nxp.com>
References: <20240822013721.203161-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: a96e6682-c8a2-402c-b294-08dcc24cfb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rGCyhcjU5m0S8ioaMChgtUDDSsZD5DBl7mFjwhjsSr1zUdQUpB36+NNhasK0?=
 =?us-ascii?Q?YVqFEmVxAAe8qGym6ObE34PzOcszL4CfLZTwJdAYm0/VChgKFVfQ2KJJluKN?=
 =?us-ascii?Q?b5toLmLAf9w/8uPJM/hNnUzRX4ism8fOT/fKZ7+adCSoKBsjjKIIP3SSxykp?=
 =?us-ascii?Q?z+49xIbeSeyyDzEUMZi5gMINyhkhxoT1LMlnnVc1uMOs91jdaoWlw0HLrPG6?=
 =?us-ascii?Q?5MIINqOeOhKzkI7AZBibVxLeMkq9twZwXmb0lGfi2KG9hWvlXz+BVzaERpkS?=
 =?us-ascii?Q?dWPVv1jYcrhyk2adVVyh+p+BU4BPRgYcD2Tg0Tn7ljqHaqSDjFaVWHntOQ71?=
 =?us-ascii?Q?KQHlpwNFNKOUhtAn5A3GX9myEzgcOK4PEHLWk69EK3Golu1pEFzI4bp06ZL+?=
 =?us-ascii?Q?XBJ5Yhps/O/mcJbVu6OfCFabz/0ZVMZCpL80wOECpqfgtBjpOO1fjAG1pw99?=
 =?us-ascii?Q?7IIJo7JyLqQWm4EweKcn0+6Kg6YAcpGY19wxhKaU5Jtia1QJpYmePAVtt8sx?=
 =?us-ascii?Q?6QOqj2yul1jbkK01oMLniQ1d4cXmHuA1NXTNlNP27JxzzExpFx+4/Ax8PSTa?=
 =?us-ascii?Q?bRiljpE7e9azhr6xA2QHVX/3uYpWtSBflntKSln0+K7fZnfK48aXqkKV/fEe?=
 =?us-ascii?Q?Ho4nvAwWfXbkmVx82o9IG53JtS+Ki3VR25BuqfMzMAOmwI1UxfTdivBDYBtF?=
 =?us-ascii?Q?WLAQlbw4+UVL8TWmWWM7AfpOFjwbl1nYl9tlO/cCTlQhW5RabrbDMRzFeBsA?=
 =?us-ascii?Q?n4ufKD+juCMWsnl04hPMFPrwgNuWPXGoxJfPwpkjSwOz5XrxehAwkaKwntqI?=
 =?us-ascii?Q?4HyLwqZldVD81vzca90O/ujKbh29DGPRza3JKcsdwVuGXWXQKIWuQZ3ba8jR?=
 =?us-ascii?Q?1mN5mTnQ+Mmm4l2TUpkfHmDT11ekfUX+zW8bZ4IDfGQSFq+hqfHpH42U8FYD?=
 =?us-ascii?Q?VQ6b/D+q+i1g8TJ4DVW5JVg5Cg6DSr9qto87ni/JBSbw8i3UuhTIosZlteFe?=
 =?us-ascii?Q?SpDqf5LPVsmcreCj+vEkSM7S7A0USN9eiTQ4XJwPwD/gfO0/2njJsZ+4YbYS?=
 =?us-ascii?Q?kZpFUzaRz4cLGXVi/1Cf9nDkZnS36jbaD2zhYXV5VNzGDPyaidjNxrS8pdP9?=
 =?us-ascii?Q?qMY8xu9paAZUEThzeaVbkKpWK1KSRDLRV18TP6dSXd1bovYYX9mHhqZRQMwk?=
 =?us-ascii?Q?OGzFL7C+TE9w1WMb+70sbqcOi72nV3XoaEPos+mnOfrMeD7JW9XvdMrF0ptG?=
 =?us-ascii?Q?EPV2e2vV4l4tq14BndCQCk44HTVRjsTC4E2cuGEyNy4ksgTCzSd+G67/EFij?=
 =?us-ascii?Q?QSN4nS5/NNonjcT86MQrwBNdUh+Cuf8MikS8K7dJ8qidVCBBucIO3ZxBmnX4?=
 =?us-ascii?Q?oC7Ir3ZH8KayLndFHbR4vNbuD1APapUDSBjjeo0GJtrI5tQAjGeMkC5ePjWx?=
 =?us-ascii?Q?tFLwWM7Veto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vpUuN6CM98HwkSS64MbLF99zQKJoQcBFS20Hdkd3cTVlPDKcjnddPvvxgWXf?=
 =?us-ascii?Q?+BBvDPlMY6B+JHL9tGMrf3AJq6fgjQgppOm6pbM2pvMOHP7W6nI7z/Zrsvzx?=
 =?us-ascii?Q?gC81cXgbyo8L6BhdBp++oTur4W0nnKKGTNGYlzRwM5bdzuCzDiy/OEsSeVcN?=
 =?us-ascii?Q?0EHt0/Xmy81V09Izf2L+PQafooNRjkViSYYMK+icTRCs/M8rSEVnqLxLwYah?=
 =?us-ascii?Q?iqvReH1o/FYN45s+SH6NuyUT/R+94EQo7jA1jlLGmcY8Q2KYBhq5snKTyjjb?=
 =?us-ascii?Q?/OUrzd3Yb3/MYVr/DrLxWpVtqsOvZHI50laz8FQqwPWuOrlQkjb0a8K5yRRS?=
 =?us-ascii?Q?B52gI+d8YFavmZaBpCFKAeqQyYkGdZ/6c+9lCQ0Gbf78SqJc9Ek7NeZz0hOw?=
 =?us-ascii?Q?chVxux9S1PzNWIFJ15UB9XXRCdCXLMIXSijG/CR7B5NehivXzPNcNvTyCaum?=
 =?us-ascii?Q?JdJrwZvlSNYcBXcdGhzuTWcogHole6CszRruD9ErW10fbLK1wEMQKD5WBYKu?=
 =?us-ascii?Q?NQVjFOEWxDWc8jPNPORBIOpixJ6aRDZ28NuQHi/IVsr3WFfSJMj8lFp/+G9j?=
 =?us-ascii?Q?o74D46kg71GztUqemrj5A5/tBDAXjKAOMpWNotUYaZUd0YM41bypt3S1DbC0?=
 =?us-ascii?Q?/HXCvz4mhvsTJ8LBqFBdEElAB1V1erdA+cAoC6y8a3usFwGI4T30YWUUEXrI?=
 =?us-ascii?Q?TBJWgtYuWFWhlaT1iLJEvrC8PiCGqzzdNtRoV1ziHzSoJ5t6yL/8o3erpCSy?=
 =?us-ascii?Q?8N+eLsIeQOt0pP3eSH8YgHqiec0sg11srQN3d6CUKbfUNmf2wYAVke5Ctvd/?=
 =?us-ascii?Q?WGqm8dKL+Rzxx1ZQ1oLZHE3hSmsFOKIbotPMpmzJdeOaysbB1zWhnbqRjbns?=
 =?us-ascii?Q?4YudDxcqwn1OSD0PbCj6f3hHkqgLAYL/VZYyYmI+GCNJnmMPCjyR7ndyKWjm?=
 =?us-ascii?Q?WdvzMVQT6PStfuHb+ejcIbbJTlNKdVVhlkNdPziLXv+kHhOYLSNRhPBHFhFi?=
 =?us-ascii?Q?I6lyV3jfzFRgHALbOqiAT+BRpHoa4MicsqNF6j0aU5ndPhi5uvMOpW5liMuO?=
 =?us-ascii?Q?yfd8sXKyESmPH7z9VxoCdl8YTCHetGLdeUh9Y3RUQ2Y5LCnpVKJd3NTupHWS?=
 =?us-ascii?Q?J8A9pZoZBYnqBifHD6Xq7jBPgC9tMZOg19XlnjVkiEH4r5RUKcYxy3j+0Ot9?=
 =?us-ascii?Q?adZAEeBD1y0zzk7+WzOcaZpgkaYTL+ljCp0vBouArvx8S4OHEuUu2+FUx1kl?=
 =?us-ascii?Q?YQOzOaoMVlGcorwmyFM1yNtru5fI2W9t6cd533fPIovguV3UKxIzHxS55mUv?=
 =?us-ascii?Q?VvIY1hSjH0sRQUq+nIYbjUHa8th0HfEtyHCHImzfIGaz5lBiiFg6ZdcriGpC?=
 =?us-ascii?Q?vapezcdspdZCqL6Y1hH6KRRb0P09wEZM1H/1CErR2YcYKn/e8SBZsUJEwCH8?=
 =?us-ascii?Q?lVacyJQ85lkkdn7p3ohuklsZfv5b4jC0yS0lp1kGp2ICYj/s1oOsvddKYisS?=
 =?us-ascii?Q?GAnmwiDydabftAFwVw2+P/lmlOxG+EShTsGt0i+4ugcOfI2bNxRn3Oy7tiVo?=
 =?us-ascii?Q?EmAapd3BIlByyCSN1pe5EysvxMgugrQ+bkgxPHUU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96e6682-c8a2-402c-b294-08dcc24cfb0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:51:46.8631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/+ZurlV2RpXel2Txc8+vlIn0uHVQP4CmcjC5uYfS9dtv317Fe9iZM5+K/f1sznsAWPuLF2r4Cj/526T18W70A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8755

For TJA11xx PHYs, they have the capability to output 50MHz reference
clock on REF_CLK pin in RMII mode, which is called "revRMII" mode in
the PHY data sheet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Changed the property name.
2. Modified the subject and commit message.
---
 drivers/net/phy/nxp-c45-tja11xx.c | 29 +++++++++++++++++++++++++++--
 drivers/net/phy/nxp-c45-tja11xx.h |  1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 5af5ade4fc64..880d4ca883a8 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/processor.h>
 #include <linux/property.h>
@@ -185,6 +186,8 @@
 
 #define NXP_C45_SKB_CB(skb)	((struct nxp_c45_skb_cb *)(skb)->cb)
 
+#define TJA11XX_REVERSE_MODE		BIT(0)
+
 struct nxp_c45_phy;
 
 struct nxp_c45_skb_cb {
@@ -1510,6 +1513,7 @@ static int nxp_c45_get_delays(struct phy_device *phydev)
 
 static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 {
+	struct nxp_c45_phy *priv = phydev->priv;
 	int ret;
 
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_ABILITIES);
@@ -1561,8 +1565,13 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 			phydev_err(phydev, "rmii mode not supported\n");
 			return -EINVAL;
 		}
-		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
-			      MII_BASIC_CONFIG_RMII);
+
+		if (priv->flags & TJA11XX_REVERSE_MODE)
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
+				      MII_BASIC_CONFIG_RMII | MII_BASIC_CONFIG_REV);
+		else
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
+				      MII_BASIC_CONFIG_RMII);
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 		if (!(ret & SGMII_ABILITY)) {
@@ -1623,6 +1632,20 @@ static int nxp_c45_get_features(struct phy_device *phydev)
 	return genphy_c45_pma_read_abilities(phydev);
 }
 
+static int nxp_c45_parse_dt(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct nxp_c45_phy *priv = phydev->priv;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return 0;
+
+	if (of_property_read_bool(node, "nxp,phy-output-refclk"))
+		priv->flags |= TJA11XX_REVERSE_MODE;
+
+	return 0;
+}
+
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
@@ -1642,6 +1665,8 @@ static int nxp_c45_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	nxp_c45_parse_dt(phydev);
+
 	mutex_init(&priv->ptp_lock);
 
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
diff --git a/drivers/net/phy/nxp-c45-tja11xx.h b/drivers/net/phy/nxp-c45-tja11xx.h
index f364fca68f0b..8b5fc383752b 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.h
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -28,6 +28,7 @@ struct nxp_c45_phy {
 	int extts_index;
 	bool extts;
 	struct nxp_c45_macsec *macsec;
+	u32 flags;
 };
 
 #if IS_ENABLED(CONFIG_MACSEC)
-- 
2.34.1


