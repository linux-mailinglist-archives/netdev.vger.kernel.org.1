Return-Path: <netdev+bounces-239928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 884D3C6E11E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09A8E358559
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E734D903;
	Wed, 19 Nov 2025 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gt1OOJJ9"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2320A346E6B;
	Wed, 19 Nov 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549341; cv=fail; b=JRSvmi1GpnrRgg2DcLDG4rmBoMK3Dtr7hoM8Iob3cu+ObyOep/Vu0QpFl0otYp8r6SQJiSU89AYN5YZbqDOy+mmdMd4wPxdE4IRpqsYV7u8EDfH5KFhJVeJWz3/8J6lPW3HZVEfoefOnvT5aKDC5JuKf5cyqqt68gM9Ngs7Bmxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549341; c=relaxed/simple;
	bh=H4dhqSFqNUPhbI5Z6YCI1MsEXtxG4N70xlFholhMDAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8dFNJZP2aIMlB3udtHcRDcJREDQZKAjgFDED9ajEHNWtMQY17a2wZD9ZCpGkgyEolhq3SvkTAmw1174Iv6MzXEXk/09bcwoQ/0Zz9tJz/U0nIKAjGWYBxGxb7tQ/jdvytPhzA2ZmHFPdEZHuNSmjZGanmsxbSHN0y67Zaifz8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gt1OOJJ9; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVKsN5iTyP51Q8ZW7+m34W51QRyq82NFcMm8xcY6C+W9MkKeAL/XJwq0PrI1HSmW5sNtHFl/ZSAStNO6GEETharU/HckOmV+MMtQ6o9oeW45J95K/rCX+j7aiYtxJxqfxfo8GtdRo0gSZbsD/WLnd8lV1axa1ERYXSKN50C0OeK8RUvTm5KEjkvsSFIxDiNdpSYV0gap8S5vshmC+xgx2U9O9IhXZH00ZObUXwJyODMcH0C4+HfYsTwm9XGgR+9MkhHaAJP0urvIMAADEvgjLfR7nTU+jlju6phCueomwlfn+XSnzbm2v/aHhZvbE9W0PrAAducHapWC0dVSpMsTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VujCEcUJI806nGdSeJffIBj+lB1VN54zlFZsVtCNXro=;
 b=w1Iet4RYGiZpMf7+XKvXId2/ZBIazE6WBAA7ZUvctfGiEjdhntewx6+uDg6mfCOOwjB1hV3Rl1bjwf5vmZd0RlokogxONeIk5XEPE/pKqBYB27TUrm3JToXLpn8l0xhr7BtJBp4gYcIFaCxzehe8ceQmg3eVLROK7XTapKxyhvlzloYEGurNpzsc5lAtYEmTlwO1WvL8TynGlXANqzzK7UHCPNu6rLT/hWlkV0Dy3Two65AP9aBc8J2I62ETYkBDR1b9vEwpNTWn+a6ZLCRg5dUgf+f4VN6D0PRFtxY0YFB1jErnIwa7XhRp1qwku6Q2yW0IzeWEnRivnKEeXLt8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VujCEcUJI806nGdSeJffIBj+lB1VN54zlFZsVtCNXro=;
 b=Gt1OOJJ9ftbLWGNaMet/c4lmJjiYpNaNHZ/SWR1klYtfB/00LxvfkK7P+SY2hQeHow2J1jZmL1pNGrCL70duUibu0CdeDnMCBuziObWymuqt4IfRuVcbAVLb27OcHF08znC6fQ1dA68LVMiyBO6YN/8eOQfihDUliPJAwwOlcjh/839Ntf0SKZVFF3hTPQf2AkDC8lXy6HhepYbHSekYY/2NhhpSaA6S1szll14/UFJH5vUmjG6yNiAH6y/6CvdEJah+heYSRAcNu+6KLILeg82f4TeS3a2xvMd/m6bTce90yuNc90ZS/uAwxKoEQbysvuPKDrz7kw0hDRuuk6pfQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:48:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:48:53 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: aziz.sellami@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 1/3] net: enetc: set the external PHY address in IERB for port MDIO usage
Date: Wed, 19 Nov 2025 18:25:55 +0800
Message-Id: <20251119102557.1041881-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119102557.1041881-1-wei.fang@nxp.com>
References: <20251119102557.1041881-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 7839c4c6-d4e0-457c-1152-08de27593b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GMAyMqg0RjRhVaR7ExzuSmrYZjnHTpJAK6CF3y1v/Fl2OCxYqPAbtcAVKnRE?=
 =?us-ascii?Q?2UBnKffNXPyDMq0kyp6HhyxbjM34v2lkmQ6a/0DwE3NdkvvyoMVM38IqA1RL?=
 =?us-ascii?Q?6lyJKsfOF4ear5yMDy8HefohfZQS7+XdVD9WkmqG61c0Euoc6LxNWWX4rBPS?=
 =?us-ascii?Q?gcvC7xuUzQSfBH9fQZExitUvZF89G9LRruITcZTVWK+LcouFg6OWZIMmjm2Z?=
 =?us-ascii?Q?1lVV5fsqh79ZHnwagkFJR7BpPV0SUvGdqxeOMful/D4mcNkOIJoaOgsG9ju7?=
 =?us-ascii?Q?IsWegJCHeM/gk5FYf37vX52Jl0TYXz2EfpHg0S0VbffH9qQTryuORMp01NlC?=
 =?us-ascii?Q?r58egSPWzDa/i0at2hRNyWv4V8Uw9TTqt77eAZhIqESSmJtI5rYc2SGSxSX/?=
 =?us-ascii?Q?NpQnHDH/iT8XF//i9APyyf0Ua3YfAavB5YHHT0mXSfafHbR71azafulQl/NI?=
 =?us-ascii?Q?Q8jhrD1f79yyGc9P0C0icg8hS7/o5h0/tQxhE5fbA/bytKRRZovbEOjBvvPW?=
 =?us-ascii?Q?YDFN1iAvb71zlv9gBG+47TLmvfbo0VosuaTuyBljIwaTQ5boEcvTI+ewtg5R?=
 =?us-ascii?Q?F8DTEWB1ppmCLpdnfqElpz7fTXbpZWh0SHZUfpCigkJ5XQ5SjHtZXR/hS8D5?=
 =?us-ascii?Q?7TZt9iLvTdApD1X6wWC5WIxVdvdqQD+UoiQ4lA55wMCpxs4uhk8jRktwjhwW?=
 =?us-ascii?Q?9q98z0aHCrBx6ezjkDcaqPo3VOd9M6HU7jH6QUVXPAX3I8vgxvJbJPmVnh4z?=
 =?us-ascii?Q?Y1SvBBo0lBlcPm0C7Mdx/rq7SgyKgaBOLv0gy5ajSUc1ks0QZNZ1vShWgKgu?=
 =?us-ascii?Q?XGLA07QoIQbAf7+fXPr02dGYC2XEbdLdtqyLP3wYqqIxzmesg+sur8PjTWJL?=
 =?us-ascii?Q?UsEJ+nXRA07OQUujfiXi42i0qc3b+QZC/C8e8W5zWcRxW8iCcw8NcCdSWQkQ?=
 =?us-ascii?Q?H4V4jarMmlvEQw/atcXM/EIDVg3kEtY0i7jHEZwIrB53rVzegPeS4MSnqJbH?=
 =?us-ascii?Q?DhVwSeb98xo4IJQnm4+/rQ4T5q1laNPONr9Utbrh5FHBq2S2IsfWPGtv8AOH?=
 =?us-ascii?Q?cPg4issyGtVVxh9HdoXdd8WB4mmVwwXDDY4Due45ROvpKtYkUV07vGZNqqV7?=
 =?us-ascii?Q?jSfLpm9lQaFDZ4vBSIumLTC2QqPnm4cY7Opot74QWxSYfIK26U5buLtjlVXw?=
 =?us-ascii?Q?dzMgjkfD4yR0Ef5HTNc0ZsYbIAVeV98a7DgQCNzqhZU35y/y24XKTHxtBuLt?=
 =?us-ascii?Q?PblPdFkYHBjpjgU2wK+nYIMGfMusxzQcE5wTxQNwtH4BgYOFxAR+ndtBliU/?=
 =?us-ascii?Q?y+8aihzi2Wo09OQhwQAUBxYYbm7ime8IOXen4rgOtxkaKfE46Eg1i+TolaAB?=
 =?us-ascii?Q?+rIe2BsZfnjQzU47H3IaGe5eCH+g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bagduQammEMckBUjATYKMobKlzjmv4sLfzoVDKrBM7C15w0MudaKzJPkORz6?=
 =?us-ascii?Q?SsHc0wVEby7EIahMr9HD43vYcx4cyuFiAuhnxHidGpRpEmHz97KL5JDfNvcl?=
 =?us-ascii?Q?BT+cEJXwFom+JV4trzJibfJYHMhX8uelM+IuhpRpsXgcvw2+g5nGiDBRP0ve?=
 =?us-ascii?Q?ol2XCooE6YHl8ehVu10rY0ahXaM4pw6nvDnfZRoloXq7qiAqimDlGVcFxiry?=
 =?us-ascii?Q?yWP0yCRrEWE6sgrGQ2FQM2jeaQhgFrgzkxNwSPkohwkDHHnUT9mxIDgxVMat?=
 =?us-ascii?Q?1Tspvas+iotiLbyW1uyKmITIoPKXDUoOCkVcKxHLizbIrBrZtq62mwLDF6Kj?=
 =?us-ascii?Q?dNGWcx9/pNtK2lTGNj58zsiZD3D8p3Yij3ir3MwqvE1BqGoSDi+coIPrMX2l?=
 =?us-ascii?Q?gdb4DxgsuSf0AZkLazTARaKymlaNdJx+/q8J1wT2JL6P1IBDT17fUoXaYf67?=
 =?us-ascii?Q?OfKRcQLsX0+yTTuaW+MLMABbpGE8rsa6g2Kv5CO3/DFxhZPxWQ86/xbuThOQ?=
 =?us-ascii?Q?nsUb4t5unUht9sJWoAkSWP3kH6OQUtbBIKwWhgSZndqebGCUgRd5Sqe41LyB?=
 =?us-ascii?Q?bDyrqJ7NJgzacocPoOGKuPsJIzHfXo6ga3C+R98CLSKidGzHlmqLnSIz+4hx?=
 =?us-ascii?Q?BLYw32PnWi+ckYJXDnGEkVdppv1+ja4u3swd1sULkNslq9XVrdVQuCCFqTlQ?=
 =?us-ascii?Q?MbCctBIz2uiZjCXeZ0Jjv38sOEVA5y4V774kSVrqSFaQAjG431bBOMFIOLXm?=
 =?us-ascii?Q?ymuWq35/BZYH6cGAj0FPY/dKIukwjSYOEA7D+l6Gwvg7v/OMONPo5UXGIs21?=
 =?us-ascii?Q?A60F7V10dLz0iGyhU6kXtV5U7WU7S5wo0x4P93b21h/56Phk+0bWO5LRaW37?=
 =?us-ascii?Q?1phG7ntkFdQA3yjRPTwA/8gpYBDkxp+AqmtSADw2bxCyhPxQ70L3TPmpR/OA?=
 =?us-ascii?Q?ZUGj2DpAheK1B/ibucO0JPaNxBsb3qGCtOxPCpI7/I0+UGQiR9pEafSf/xmm?=
 =?us-ascii?Q?TwKrXj/vj1TYxFLJPT5epSjUfla59zvSVdVqTaedd5jacB8RqAgt88WdQjaD?=
 =?us-ascii?Q?1j2pGICTeeqEGCKioGCqL7AMO3MLUiJ9LkOohfZPxZ7FTFLwb9X/SsfVDnW1?=
 =?us-ascii?Q?lpp9ajKZmXki0XIQHHRzvQpjaiiimQxnk+U8Q3lLuW3rJDx2Ds8+KW6cydrK?=
 =?us-ascii?Q?Lai3+vsjyHv8p9UAozKiOSEQSXWwFugXYiwjrSCh1WTKiY13iEy8rfDkC+vj?=
 =?us-ascii?Q?LlP1UXB+A1W0Zh9AqX05HMjrFgtfCIy+872oWkuocqBgPkpKvF3+OTxNPgY3?=
 =?us-ascii?Q?a7BKwq3Y+wY7rg+VZvbnezo1OOgEs0KW/KZnCmGE83GJETld6bUWK75zM7z6?=
 =?us-ascii?Q?ZJsPuzjLoA5z/z2p1QWZ/MH7kB84xWFE5bBJss5lbKiLAy2ML/q07Mm6KYd3?=
 =?us-ascii?Q?v6yKSJ11uXkEquy3PdtVGgPZnmxBfQs+EJuH9a5H0M4q+DkHdzYV8CMIFl5V?=
 =?us-ascii?Q?AWpG05oxMqCwKHdXIHgnC9/2TPpv2Ih6imrWuisAG+kUFWMIzA6aD3COQwz6?=
 =?us-ascii?Q?fnT2BUxpmMbyludHPxvih8+SYVIIPhYtX94MOAbv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7839c4c6-d4e0-457c-1152-08de27593b4e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:48:53.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHxAOZGvwwLMnVX2bYcl1z6GAqD7tvcU3MOW8QclPCKqf8Vl7RVv+G7AQygfsKrODlnCxQYdGNY3vg0Tb1n97g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628

The ENETC supports managing its own external PHY through its port MDIO
functionality. To use this function, the PHY address needs be set in the
corresponding LaBCR register in the Integrated Endpoint Register Block
(IERB), which is used for pre-boot initialization of NETC PCIe functions.
The port MDIO can only work properly when the PHY address accessed by the
port MDIO matches the corresponding LaBCR[MDIO_PHYAD_PRTAD] value.

Because the ENETC driver only registers the MDIO bus (port MDIO bus) when
it detects an MDIO child node in its node, similarly, the netc-blk-ctrl
driver only resolves the PHY address and sets it in the corresponding
LaBCR when it detects an MDIO child node in the ENETC node.

Co-developed-by: Aziz Sellami <aziz.sellami@nxp.com>
Signed-off-by: Aziz Sellami <aziz.sellami@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 141 +++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index d7aee3c934d3..6dd54b0d9616 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -67,6 +67,9 @@
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
 #define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
+#define IERB_LBCR(a)			(0x1010 + 0x40 * (a))
+#define  LBCR_MDIO_PHYAD_PRTAD(addr)	(((addr) & 0x1f) << 8)
+
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -322,6 +325,142 @@ static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
 				 1000, 100000, true, priv->prb, PRB_NETCRR);
 }
 
+static int netc_get_phy_addr(struct device_node *np)
+{
+	struct device_node *mdio_node, *phy_node;
+	u32 addr = 0;
+	int err = 0;
+
+	mdio_node = of_get_child_by_name(np, "mdio");
+	if (!mdio_node)
+		return 0;
+
+	phy_node = of_get_next_child(mdio_node, NULL);
+	if (!phy_node)
+		goto of_put_mdio_node;
+
+	err = of_property_read_u32(phy_node, "reg", &addr);
+	if (err)
+		goto of_put_phy_node;
+
+	if (addr >= PHY_MAX_ADDR)
+		err = -EINVAL;
+
+of_put_phy_node:
+	of_node_put(phy_node);
+
+of_put_mdio_node:
+	of_node_put(mdio_node);
+
+	return err ? err : addr;
+}
+
+static int netc_parse_emdio_phy_mask(struct device_node *np, u32 *phy_mask)
+{
+	u32 mask = 0;
+
+	for_each_child_of_node_scoped(np, child) {
+		u32 addr;
+		int err;
+
+		err = of_property_read_u32(child, "reg", &addr);
+		if (err)
+			return err;
+
+		if (addr >= PHY_MAX_ADDR)
+			return -EINVAL;
+
+		mask |= BIT(addr);
+	}
+
+	*phy_mask = mask;
+
+	return 0;
+}
+
+static int netc_get_emdio_phy_mask(struct device_node *np, u32 *phy_mask)
+{
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,ee00"))
+				continue;
+
+			return netc_parse_emdio_phy_mask(gchild, phy_mask);
+		}
+	}
+
+	return 0;
+}
+
+static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	int bus_devfn, addr, err;
+	u32 phy_mask = 0;
+
+	err = netc_get_emdio_phy_mask(np, &phy_mask);
+	if (err) {
+		dev_err(dev, "Failed to get PHY address mask\n");
+		return err;
+	}
+
+	/* Update the port EMDIO PHY address through parsing phy properties.
+	 * This is needed when using the port EMDIO but it's harmless when
+	 * using the central EMDIO. So apply it on all cases.
+	 */
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0) {
+				dev_err(dev, "Failed to get BDF number\n");
+				return bus_devfn;
+			}
+
+			addr = netc_get_phy_addr(gchild);
+			if (addr < 0) {
+				dev_err(dev, "Failed to get PHY address\n");
+				return addr;
+			}
+
+			if (phy_mask & BIT(addr)) {
+				dev_err(dev,
+					"Find same PHY address in EMDIO and ENETC node\n");
+				return -EINVAL;
+			}
+
+			/* The default value of LaBCR[MDIO_PHYAD_PRTAD ] is
+			 * 0, so no need to set the register.
+			 */
+			if (!addr)
+				continue;
+
+			switch (bus_devfn) {
+			case IMX95_ENETC0_BUS_DEVFN:
+				netc_reg_write(priv->ierb, IERB_LBCR(0),
+					       LBCR_MDIO_PHYAD_PRTAD(addr));
+				break;
+			case IMX95_ENETC1_BUS_DEVFN:
+				netc_reg_write(priv->ierb, IERB_LBCR(1),
+					       LBCR_MDIO_PHYAD_PRTAD(addr));
+				break;
+			case IMX95_ENETC2_BUS_DEVFN:
+				netc_reg_write(priv->ierb, IERB_LBCR(2),
+					       LBCR_MDIO_PHYAD_PRTAD(addr));
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int imx95_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -349,7 +488,7 @@ static int imx95_ierb_init(struct platform_device *pdev)
 	/* NETC TIMER */
 	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
 
-	return 0;
+	return imx95_enetc_mdio_phyaddr_config(pdev);
 }
 
 static int imx94_get_enetc_id(struct device_node *np)
-- 
2.34.1


