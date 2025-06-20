Return-Path: <netdev+bounces-199715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4EFAE18B5
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083B71BC05EA
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0AD288CBA;
	Fri, 20 Jun 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oWiChC/7"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750428851E;
	Fri, 20 Jun 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414773; cv=fail; b=ENDr4E2br38aOLif+YXE3drPRs5YrTlTXUmCkxcjnG8J9b/cRvRKo1I68MHzdf4sennnxY912pFXEzJtWP7JzTwGFmIV0ViT2t6XjUHVcuRWZHkrAx+wTWa0buSdxHOpAUfi1WPBHo43Iiy3MmqXYb7ZTRd38BL0FAMRmzKPlog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414773; c=relaxed/simple;
	bh=nLYvuS/8Z4wKDVPFPdcPSHelHkPp4YiXLGsK33w85hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eBX8tgvgf2y9QMcZKPyWvOVub+Pern4CSrzmMPaVJUxAx6keTZjomh68+p6NS/zZCUx4+SRWVtRURVnQcncKplc0cTXNEaGUNsiKRnwg5dPr6RbQajQ5N149aXCfVDrLvxxuEQ+46qd4in3MqYosRQTYE04xoAPzDws0572r1Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oWiChC/7; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fU4fr4ZAbl1iZ+UuXWYtV7hiIDEWkuMBYxp5dlMVjBoy1Je3iKj1/6R6Mn0AWEc8NEHXo/Jq0Ms8cC4xibfWZw8Em7q0XnDr6AWgtD2RdazJ5lisCXqnBypSZGggdShgkaOu5lNnfPAyQ0eJFRTkBuLoEHlToYkv/TrZfpdEexAK04JHMOYdRafBS+4LI7TR+4S6R4PDklgBFN2cLwQbOIoQ/J2Kp30smD75CmBBfbGGTQmv7J2JPWDO999DeacsxWehaMRiTHQWtT7TFtlgj/qQBRgJ6HE6beGPEboZyVG9FeLcAMxaylz1/XcJOkHHcYB/1hJ3h17Y6ygukGwpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcokltntwSC1011+pq/4zuZhhRs2XuqhcWiAeaBMyEQ=;
 b=Yd/fkhZy3JtuW863miIPA6qsPOT8+vTBcd4QGpDB3tBPWEs2Ps+/9aJB0pOZZNPI3muHe+NkNNW7u32PtSc2hBHpCb6GsVgnrm4HvMSla+UI7ej1A9c0mvFphKHvCq2cPOEv0ii5fA/Z3KG04yzF+2tUwRk9ujxplxxndeV2Uib3W8FP1qDpEwuenH7CalGJrT4j8RXEhDc6HlIfB8az+iKmR1kz/y+SDlbd88JpFRmrwaEYMidvzYfSPXc2jmLxK/Lb7HqdsZJp1mPVx4XiGx3sBBPACxEpTtZdnqeAoM6AQByUAR/ctZ3SBNUlsR24wsHsiAyY1NDcHNd/ZhANvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcokltntwSC1011+pq/4zuZhhRs2XuqhcWiAeaBMyEQ=;
 b=oWiChC/7QZkutEWwxTFvfj7KOvZaWg2wkykP4ImRfWyG2uZnDAlGxY5hb5BlhuYR+xwEjfA2AWBh36xpcUDaC9VjPLL0K8RkN9EzegQRaBH/pgXbY+KoNB2IB7X6do+NGulp32QDh0vmyEoQI9ayk1wtVEpaLk4omcKOX816ORHGYN85tD4mV3Kj1EiLScfrS6akmoj0ocq6bXxOiU3Q6ujtCQfTEhSHvVRdmLzgrzOv8/HmEBMZaIMzV4Kb4zv/a9EsQJdYE3g55Pu1kX9zsCbYvZPpOZT6Vl8gns4OZHpZhpJTBDniBybf4xiEmgeevP/9WdfYMtnhoKQuGR031Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB11258.eurprd04.prod.outlook.com (2603:10a6:10:5dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 10:19:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 10:19:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 3/3] net: enetc: read 64-bit statistics from port MAC counters
Date: Fri, 20 Jun 2025 18:21:40 +0800
Message-Id: <20250620102140.2020008-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620102140.2020008-1-wei.fang@nxp.com>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU0PR04MB11258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5037e1-17a2-4bb3-79ba-08ddafe3f085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qepSkhz/MqFC1vPLRBGS6ERaeIyrn6TKVkjS2+GP8hgTBCyN7CwXooENPPVs?=
 =?us-ascii?Q?2gGaodzztwpwd3w4pmkTIyIJKEW0K0jC3P84GX7hTJPKJD5TPLkdnBMN+tO8?=
 =?us-ascii?Q?ZrzncPcs4/SXmTE/MQym6gWUhicy7QG+WA83jxvGrn/Uc+UI8Aoyvm0DaD2O?=
 =?us-ascii?Q?3sZ38ZINj3kPWoNOuG3OCE/oIVgu5ZQPFGtlPfuB99s2i7ai6OyDpFRlud67?=
 =?us-ascii?Q?9swSSbAJLySU6QXx0XeFcr7nbfUr02XnEf6VKGyvxumovP2iy6IGFKdAloTr?=
 =?us-ascii?Q?LHwHcjpoltAcj4CcbPuVr6psMHDeK/89FkrkkViJXDpwzY7q4psR81sUWw8T?=
 =?us-ascii?Q?cW5+u4vo34RdCeKRnw+UA/VPpBgckxKo2/n6ICERlLqo6PSjURE5awKKwVf8?=
 =?us-ascii?Q?0OYV3C2jpX6AJGACJkVLHMPgD4t1VUknXV5If19aErExKllPOXoYPLHbRPAw?=
 =?us-ascii?Q?hOUGnrnU9LLTY51bEiKR957AZndrVmj2zEy14kP459ZfMeSGBFqbD38MhfrG?=
 =?us-ascii?Q?UV6o10t5VfnrNqbQAD2X/PPQHOSaLWGVUGmiIJ9isL0C0tnKfdQJhmvvIa24?=
 =?us-ascii?Q?hlQy5j82t/XNfV0O96hJyqr8GjifFvoUS7S00ysEPWHRWKF8OLXmmE+wnNvi?=
 =?us-ascii?Q?BgLHz55WJjUTYIz5CtmMq93id5dNKoFjWCO8E2Y4UDuHTAUwxiVx5Eirta+E?=
 =?us-ascii?Q?WbvYz1KNoVG6nb7NULEXK4U5+CSHWyXFpNWBLqNsQNdRMMAMStxOGO9XtOsM?=
 =?us-ascii?Q?39+nxS7wbeM7KsxGVZtcPQJbo8vu0z0Afk0lWt4vhtpHZF9/GsN3Nh8vvOOL?=
 =?us-ascii?Q?AVEPaLDeSxYNqv0ffU/3hyp94mEYsOug0qAURXSJqEW8flRFUx5hdnpdThdi?=
 =?us-ascii?Q?bBzfRyl3Cz7Dene3C9fi2Otb07cGHWfN6HS4JWDJK/KMsLRKPkPDapXqGBoD?=
 =?us-ascii?Q?vLIRV1KACUPB2EgGbx40HyvMa0GgyUKyT3jnT3oFuoAKHXLVi7B48Dcw7u6A?=
 =?us-ascii?Q?C08+21eKuz/QoxUxQWNvSqG9usU1LY0USnVD96Yp00yBoSyTbwtSPMUyxTo3?=
 =?us-ascii?Q?C4X3lkTfQqW/iMYT6Y+DkZawlGQKBv4r7o7y0QiRqcNS7Cjlrbr0SvkWEuul?=
 =?us-ascii?Q?sO5oVBCUvNV7Gj8S+dMTATSIgeIqbff1n6BmNmpplOcCw08iZfwge1/PzByk?=
 =?us-ascii?Q?dBqlmA1PcwACRAOaW8rFvamIyLbPh4rIL3/75AkudLWOK3VSEQM+Y4ZXCKZV?=
 =?us-ascii?Q?7d/kMdvPK3OwL2PZwY+8WWRAM/+WV79oeMqCCR3tHUK+ASYTVe2sB8iBDrXF?=
 =?us-ascii?Q?/Fooxpu839eS1J/Yyn7hKcgnVZBmLR04DRxCr/NAf7izc2EkeIXNXQ88i07W?=
 =?us-ascii?Q?v6mcO2uEUlBRyu+KKfi4s3rJJOoo/tj795EVh6U52J3TaPciu5JbxPtuyaoM?=
 =?us-ascii?Q?28lUY4k5aUqT1xXv754UHe1/vqIoBakck+rummDfRGFWfu23R2rHIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3tCcu8TeLQEu9gosSgkpjX9kCJJZEhRbZr6CHZ3Vkld8FN3K/FznJJODZEaA?=
 =?us-ascii?Q?53ndvNOZVv/rweE1SqR6oHS+kkLsMslX7MKkuR0/KcB2W9gfCUHKiHJlqUV5?=
 =?us-ascii?Q?uXHJxCLHq7igGmvmK+Zw89SR+nzrftPLtTzELCfQooAvgxoHyYx4ra7HHR6Y?=
 =?us-ascii?Q?aK+Xq3GSA8hMxmJCoOGBmYKgaAykNplYITRs2vUBLAsJJHZH/ldi2CVSQuVt?=
 =?us-ascii?Q?M29CTyRdg9pY1Et8vrh5TZtWNqYzdeZK0X4Xek2X0JndKoLZIscZktjkTywM?=
 =?us-ascii?Q?I+AG+TUdFu6oKEb7NLrhiP/2zH7quiFb2CDcUi5da/y+0x7picA/9fGkcI2+?=
 =?us-ascii?Q?QQum9A3OR+6SOFb2XDfnPu21KqSgICabc5xZVwPKjfU0YZjp8+YLm/ECNF1g?=
 =?us-ascii?Q?oRcOkTcf3hdpa+3jlKGo2Xi6VDCFSr5Whc5FK2Vxd0hSgg3Ke9VTcxlFTmeV?=
 =?us-ascii?Q?HIwty8PXcdg4F17NkfGY5dcwgGkrFYJV9CSD/tz3uh3M3/IUKJBSep2NOGMc?=
 =?us-ascii?Q?2fzjPrUFOOP9Auqhs0qkODbQ+ME+6iGJ65M6DWS7JBlYC5XBF7sluU8ZybkP?=
 =?us-ascii?Q?Ajv78gtbJBy+Rft6ZC9I7Q7/rXoiUYYTTT28CjeWww6zI/cXmM7D4XoikBmR?=
 =?us-ascii?Q?rUjKVCfuWtxWrYJYRn2oGIG6TXJN3MPQuJ7zJRC+akvj/ok0BXYcbhqOFHTH?=
 =?us-ascii?Q?Wj5CYYgET9Sm1bcG4RaFe2LA8Hdht5UBWS1atehk+FmJ5VGNI3giVajGCDeT?=
 =?us-ascii?Q?tzPFOwmFJCsl7DLctUsHQRrM6mQHIQKFaDiMWlhXivXrmrki659Pz0xV3KMF?=
 =?us-ascii?Q?4o31Nch+6Yq2/4vn8mp2POG16taqHOnXUiHENs3RJW9zYTOplZEi6ISvMaIS?=
 =?us-ascii?Q?hCYUiCVDXp+Yte6yWOcxI16tqNUSs+NZRoWkG2K04NVd1if47qxfq0qbgDoj?=
 =?us-ascii?Q?kE6KMfYnZw6xx9SrgRrLw4sKLW//bkhXLUoQbNFr6a4WoAPk/cv/7CapO2FX?=
 =?us-ascii?Q?s5aTbIoIv/phJCQDCNxO8tPSMnUFfoxMRmLSQsPvs54bD7GobwETIE4DBH0T?=
 =?us-ascii?Q?QKGo+nQ2Bd5sMdWAUrphJf9TPKZW7ONknoI8HSmDlB3Czv1+OicB2jao5j0K?=
 =?us-ascii?Q?SxoAFhh7oQ/XtDUVH6pYDKZv+keFz3sG3kLD9kofYEnIIN10ccCt+B0E/8iQ?=
 =?us-ascii?Q?YPuo5JmTY6AybpLAzgjMC7dh5u6QZhEzEotD1Od9sjfsjnfFRx6MfZobJYni?=
 =?us-ascii?Q?BE+hj0qWoNyu8c03MwZFbAKV6qdM+aNF5oqnvJtgeRp2lzLa46WKMTGIAOeq?=
 =?us-ascii?Q?aO9RSDUrA//piOhw17AJE6hlxTRnJf4iyxINXtfnBxyPyB1JIVuzDJtlQGzN?=
 =?us-ascii?Q?pH3dg/dJZcIo37JEZDNE9ez6oCLsi6v3jHkdLjChhFnZq9r2BexlwikApFgG?=
 =?us-ascii?Q?GpnThWwuUL8w4BCiMODTx5krbGiYwLAnpH7o7fJMjTFzeeQPiehK86ePTPvO?=
 =?us-ascii?Q?zOinqhNImR1MBq8cNnsWhTu5NqlNI4kZ29BywcfOP0+pvajwrwd/MQUcPS7t?=
 =?us-ascii?Q?YGPrHewJgj1Imwxvw4Da/0mWi77+uCKmenQhgShC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5037e1-17a2-4bb3-79ba-08ddafe3f085
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:19:28.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7w3hr4eqzACh4otNiHkOgWFIlOq9wsBjZdI61SqsRobOC+4iMyBe/mMkTILN1r+cQoQgQZVt7v3ms5ptb1TNqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB11258

The counters of port MAC are all 64-bit registers, and the statistics of
ethtool are u64 type, so replace enetc_port_rd() with enetc_port_rd64()
to read 64-bit statistics.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 84 +++++++++----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2c9aa94c8e3d..961e76cd8489 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -320,8 +320,8 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 static void enetc_pause_stats(struct enetc_hw *hw, int mac,
 			      struct ethtool_pause_stats *pause_stats)
 {
-	pause_stats->tx_pause_frames = enetc_port_rd(hw, ENETC_PM_TXPF(mac));
-	pause_stats->rx_pause_frames = enetc_port_rd(hw, ENETC_PM_RXPF(mac));
+	pause_stats->tx_pause_frames = enetc_port_rd64(hw, ENETC_PM_TXPF(mac));
+	pause_stats->rx_pause_frames = enetc_port_rd64(hw, ENETC_PM_RXPF(mac));
 }
 
 static void enetc_get_pause_stats(struct net_device *ndev,
@@ -348,31 +348,31 @@ static void enetc_get_pause_stats(struct net_device *ndev,
 static void enetc_mac_stats(struct enetc_hw *hw, int mac,
 			    struct ethtool_eth_mac_stats *s)
 {
-	s->FramesTransmittedOK = enetc_port_rd(hw, ENETC_PM_TFRM(mac));
-	s->SingleCollisionFrames = enetc_port_rd(hw, ENETC_PM_TSCOL(mac));
-	s->MultipleCollisionFrames = enetc_port_rd(hw, ENETC_PM_TMCOL(mac));
-	s->FramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RFRM(mac));
-	s->FrameCheckSequenceErrors = enetc_port_rd(hw, ENETC_PM_RFCS(mac));
-	s->AlignmentErrors = enetc_port_rd(hw, ENETC_PM_RALN(mac));
-	s->OctetsTransmittedOK = enetc_port_rd(hw, ENETC_PM_TEOCT(mac));
-	s->FramesWithDeferredXmissions = enetc_port_rd(hw, ENETC_PM_TDFR(mac));
-	s->LateCollisions = enetc_port_rd(hw, ENETC_PM_TLCOL(mac));
-	s->FramesAbortedDueToXSColls = enetc_port_rd(hw, ENETC_PM_TECOL(mac));
-	s->FramesLostDueToIntMACXmitError = enetc_port_rd(hw, ENETC_PM_TERR(mac));
-	s->CarrierSenseErrors = enetc_port_rd(hw, ENETC_PM_TCRSE(mac));
-	s->OctetsReceivedOK = enetc_port_rd(hw, ENETC_PM_REOCT(mac));
-	s->FramesLostDueToIntMACRcvError = enetc_port_rd(hw, ENETC_PM_RDRNTP(mac));
-	s->MulticastFramesXmittedOK = enetc_port_rd(hw, ENETC_PM_TMCA(mac));
-	s->BroadcastFramesXmittedOK = enetc_port_rd(hw, ENETC_PM_TBCA(mac));
-	s->MulticastFramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RMCA(mac));
-	s->BroadcastFramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RBCA(mac));
+	s->FramesTransmittedOK = enetc_port_rd64(hw, ENETC_PM_TFRM(mac));
+	s->SingleCollisionFrames = enetc_port_rd64(hw, ENETC_PM_TSCOL(mac));
+	s->MultipleCollisionFrames = enetc_port_rd64(hw, ENETC_PM_TMCOL(mac));
+	s->FramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RFRM(mac));
+	s->FrameCheckSequenceErrors = enetc_port_rd64(hw, ENETC_PM_RFCS(mac));
+	s->AlignmentErrors = enetc_port_rd64(hw, ENETC_PM_RALN(mac));
+	s->OctetsTransmittedOK = enetc_port_rd64(hw, ENETC_PM_TEOCT(mac));
+	s->FramesWithDeferredXmissions = enetc_port_rd64(hw, ENETC_PM_TDFR(mac));
+	s->LateCollisions = enetc_port_rd64(hw, ENETC_PM_TLCOL(mac));
+	s->FramesAbortedDueToXSColls = enetc_port_rd64(hw, ENETC_PM_TECOL(mac));
+	s->FramesLostDueToIntMACXmitError = enetc_port_rd64(hw, ENETC_PM_TERR(mac));
+	s->CarrierSenseErrors = enetc_port_rd64(hw, ENETC_PM_TCRSE(mac));
+	s->OctetsReceivedOK = enetc_port_rd64(hw, ENETC_PM_REOCT(mac));
+	s->FramesLostDueToIntMACRcvError = enetc_port_rd64(hw, ENETC_PM_RDRNTP(mac));
+	s->MulticastFramesXmittedOK = enetc_port_rd64(hw, ENETC_PM_TMCA(mac));
+	s->BroadcastFramesXmittedOK = enetc_port_rd64(hw, ENETC_PM_TBCA(mac));
+	s->MulticastFramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RMCA(mac));
+	s->BroadcastFramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RBCA(mac));
 }
 
 static void enetc_ctrl_stats(struct enetc_hw *hw, int mac,
 			     struct ethtool_eth_ctrl_stats *s)
 {
-	s->MACControlFramesTransmitted = enetc_port_rd(hw, ENETC_PM_TCNP(mac));
-	s->MACControlFramesReceived = enetc_port_rd(hw, ENETC_PM_RCNP(mac));
+	s->MACControlFramesTransmitted = enetc_port_rd64(hw, ENETC_PM_TCNP(mac));
+	s->MACControlFramesReceived = enetc_port_rd64(hw, ENETC_PM_RCNP(mac));
 }
 
 static const struct ethtool_rmon_hist_range enetc_rmon_ranges[] = {
@@ -389,26 +389,26 @@ static const struct ethtool_rmon_hist_range enetc_rmon_ranges[] = {
 static void enetc_rmon_stats(struct enetc_hw *hw, int mac,
 			     struct ethtool_rmon_stats *s)
 {
-	s->undersize_pkts = enetc_port_rd(hw, ENETC_PM_RUND(mac));
-	s->oversize_pkts = enetc_port_rd(hw, ENETC_PM_ROVR(mac));
-	s->fragments = enetc_port_rd(hw, ENETC_PM_RFRG(mac));
-	s->jabbers = enetc_port_rd(hw, ENETC_PM_RJBR(mac));
-
-	s->hist[0] = enetc_port_rd(hw, ENETC_PM_R64(mac));
-	s->hist[1] = enetc_port_rd(hw, ENETC_PM_R127(mac));
-	s->hist[2] = enetc_port_rd(hw, ENETC_PM_R255(mac));
-	s->hist[3] = enetc_port_rd(hw, ENETC_PM_R511(mac));
-	s->hist[4] = enetc_port_rd(hw, ENETC_PM_R1023(mac));
-	s->hist[5] = enetc_port_rd(hw, ENETC_PM_R1522(mac));
-	s->hist[6] = enetc_port_rd(hw, ENETC_PM_R1523X(mac));
-
-	s->hist_tx[0] = enetc_port_rd(hw, ENETC_PM_T64(mac));
-	s->hist_tx[1] = enetc_port_rd(hw, ENETC_PM_T127(mac));
-	s->hist_tx[2] = enetc_port_rd(hw, ENETC_PM_T255(mac));
-	s->hist_tx[3] = enetc_port_rd(hw, ENETC_PM_T511(mac));
-	s->hist_tx[4] = enetc_port_rd(hw, ENETC_PM_T1023(mac));
-	s->hist_tx[5] = enetc_port_rd(hw, ENETC_PM_T1522(mac));
-	s->hist_tx[6] = enetc_port_rd(hw, ENETC_PM_T1523X(mac));
+	s->undersize_pkts = enetc_port_rd64(hw, ENETC_PM_RUND(mac));
+	s->oversize_pkts = enetc_port_rd64(hw, ENETC_PM_ROVR(mac));
+	s->fragments = enetc_port_rd64(hw, ENETC_PM_RFRG(mac));
+	s->jabbers = enetc_port_rd64(hw, ENETC_PM_RJBR(mac));
+
+	s->hist[0] = enetc_port_rd64(hw, ENETC_PM_R64(mac));
+	s->hist[1] = enetc_port_rd64(hw, ENETC_PM_R127(mac));
+	s->hist[2] = enetc_port_rd64(hw, ENETC_PM_R255(mac));
+	s->hist[3] = enetc_port_rd64(hw, ENETC_PM_R511(mac));
+	s->hist[4] = enetc_port_rd64(hw, ENETC_PM_R1023(mac));
+	s->hist[5] = enetc_port_rd64(hw, ENETC_PM_R1522(mac));
+	s->hist[6] = enetc_port_rd64(hw, ENETC_PM_R1523X(mac));
+
+	s->hist_tx[0] = enetc_port_rd64(hw, ENETC_PM_T64(mac));
+	s->hist_tx[1] = enetc_port_rd64(hw, ENETC_PM_T127(mac));
+	s->hist_tx[2] = enetc_port_rd64(hw, ENETC_PM_T255(mac));
+	s->hist_tx[3] = enetc_port_rd64(hw, ENETC_PM_T511(mac));
+	s->hist_tx[4] = enetc_port_rd64(hw, ENETC_PM_T1023(mac));
+	s->hist_tx[5] = enetc_port_rd64(hw, ENETC_PM_T1522(mac));
+	s->hist_tx[6] = enetc_port_rd64(hw, ENETC_PM_T1523X(mac));
 }
 
 static void enetc_get_eth_mac_stats(struct net_device *ndev,
-- 
2.34.1


