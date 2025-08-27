Return-Path: <netdev+bounces-217189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0511B37B1A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A8F3668B3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793BD322531;
	Wed, 27 Aug 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kh4bZIIV"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103C321F5C;
	Wed, 27 Aug 2025 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277798; cv=fail; b=FYfzBi5tDsuG8pI99sAubf44wFA+iz9K3ufibxn7QNueCbQkWcuu/XGPAgMz/YymHPMKqKdE5IwzE8LkXjJI3Ul5b5Dh2S10IWjYaDy1gYvUwhEBTagHkfIgWnFlL9tcKaG0ynwhaVbJUFk5Fhz5p+2P3RuaryU7wfgwkaeXLwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277798; c=relaxed/simple;
	bh=XKim+Apovg3ClzFH9GZkEj197hgDaqrgI4nW5tEW1BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sa23NGMGAV8sAsOsvj4jjZ5cTB9GHiZFmGv2Et68SG4I5Mdv1QL893HRRBnQQ2vGzraT/X/WpY0JRsYp5JfCVFkuu8HG3eMvCPDJDfF3dQyUSanglUVB8y5Cbao5vt7T8wTyuYUboupxz5juMXEv6MMvDMiiYFX2rahgyDXu8eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kh4bZIIV; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7HaSHlXidQGUbySj2joWwWl0cIwDvAXcjfxQCU8q7GuJaDk605Lf0uetEyeI5otHACya5H+X00ohXV1y+QumrfyQGFSNbfaiIS5Osbgm6s3/xrHITxQzNSlxJabn3uqKzwMyuF5111Ok+ZgYdyL4OjHBwPt3wGFCkuq1XFTYJhcHmUlH42kVGq2F+feEAI8vXQeMEGChcfdzULDGlSghu5cmpxp/RpQdQYyiuW9nS7dkneigdPP3YrajD7YGnUSOIGH2SZ7hlbHfPI1FWap1xiKNjVTj/r9Vn8LW6Zj8q+3CyVyZwp5O+d8l+x63MHNqLJoViyGHVvaDMZhGnKFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fns7vHhTNw0Yois9nPhia4cGOxAlxUkAeByIM4Ln0oE=;
 b=TVCyDcbI6vHGqSJP3BdIciY6pWKta+xhIAB3bDe3LneXpiFISOdJHsBA+N8ceqanzNpng6dDEzs1Vepx5422bp/cf75tt+TzND8UKeHO2GFgrNBB3eGzTwE9npXr1e6d1DrEhpxNpVnLaPqQVWrqZq2Pews+8ldNCPe4tVSU5llNGnfOqO/nPDNyhBm+udpJ++Y/OFs6DkCjuDMANsiAQUEkT1ycN3+lwLPb3y38Jz6O5fBZOzHLXrAY83e/+lYtJYjz6yEsIwB5o4CTqEFxGvSGQAu+ufbUlq76PTuldIP729npXRpvwGB6pfmFUEgOoKnO4AUBOMF+vpzK97+dPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fns7vHhTNw0Yois9nPhia4cGOxAlxUkAeByIM4Ln0oE=;
 b=kh4bZIIVtERdhhHaJQrwODsGSqzzP3ghtw/TlsGOwj1qNiFfULaj9NEiXMoKp/e+05BzF9hZVGMtn7ftmGQhe3bd1CQ6hdEkWRNKX1Tgf5wwnOHrrZoDTjgpH+kYq+8RM/PNb9LVvGlI6jWw8HAG/W39RGHbTd/qmubHvw1ZBsOEPi95JDifwCQdaZqXS/yDUSbrnAIxzgj3MI/hFF9quKWWKzJbm4l9CcgETErQxwH5vUdEsCn3nN/uHvsO0Y/72Qddkkvi2CDh1dTrZpH8RFvcLQIa2VlUr2w//fEO3JVvQwXgJAq7xz86D+9XJYNu617laoKmd2kOlrwlAh7fag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:56:33 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:56:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 16/17] net: enetc: don't update sync packet checksum if checksum offload is used
Date: Wed, 27 Aug 2025 14:33:31 +0800
Message-Id: <20250827063332.1217664-17-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbd4427-8c85-4a2a-ed23-08dde536db08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Rc1Q29LyHrrUwzHEc+gPaBmXycCr18IO1WbPUvnV3QuCFjzn7vI/2X4F7mF?=
 =?us-ascii?Q?2hfrShngbgND3kaUiaqhNUC58eNW0GZmpSv8jORLMEXXuPaPkbFCXpTSeHlY?=
 =?us-ascii?Q?06jmSQ/HbhYfaHr5+KtHx+6Sh31rBPpwt/+O4IrqBAyGvE7e3vRy8w/CYL2g?=
 =?us-ascii?Q?q3Eid93qNAUewcsIwx1XCxs59KoD/5iXZZleuVaMaS11QvJ3pa0pU6LPVBy3?=
 =?us-ascii?Q?mretOYRI3JjwXSlucotgtEMIfEX+n/KqUYRcRkJuvgXkpFnmI1sGiuH3RoSg?=
 =?us-ascii?Q?LZtcPZ4uxVc0JFf0cfmwPYiHQDXeKwXbqRKrMuG43mvaCMc3YyogekO69hEg?=
 =?us-ascii?Q?cfKbPPqQNfflbn+nSksvAZ7z4TqI+fububZG2m4aLx1pzXpFndAYC5G+Rm7w?=
 =?us-ascii?Q?BNC6rrqyuNBFEIh6wfWAfpyzrorP8XVujkmFjv8GYoo07AgPn+eXcq06I7A2?=
 =?us-ascii?Q?Kg11gNXunsLs1RwNb1LpJoedpyd7/xzIspYTXi5jIRG+JqUlPUq5hQe1dbNb?=
 =?us-ascii?Q?WBUmPoA8/ZGSehx+75iH8mHI2KZtEsH7+j0e8kDv0sO5wmbyclFV9jm7HMFN?=
 =?us-ascii?Q?Ol8RLqyzgEnrahUUv+yUSbe3KziXOsMZBUzWjvVL7kyARIM7eH8ofIu4Wys/?=
 =?us-ascii?Q?dvjWuJBFavjMyLG9IKi3l/4fA+jARmLshy0aksxu+mzNzGJ3b2J6e3Tir9Y2?=
 =?us-ascii?Q?eYkHw/ZeyWIM4uZ6x2mQAb9IOZg3qmu//qhVOQOXUKAj/CICnUQhZVTUnBN1?=
 =?us-ascii?Q?3h+JOsKKuncHf/SstAFnVyheG0xLeyLPu62ftTgP1Az/YG4okInBIoiKJksW?=
 =?us-ascii?Q?kMuiiCSgpK55aYhjBVI657LT0KaW4MIV61fGxdiac8jbqhuJKu6BvjBsHx2r?=
 =?us-ascii?Q?847syR/L3WYOTR0pTU01GawdgvkjtxgFNPAk84SKP0vKSBCXXlq6Avsq7Kkg?=
 =?us-ascii?Q?sTC1IGGdIKCURysnzCQz8uf7LTbQmT9svxmvUP6yDtGfQ0Ghe+iAOyAtjwqR?=
 =?us-ascii?Q?cHCu74nz4/7fFq3/pfU6s0qHoFtqebhzoTOhvGDblrp75Nyy0oSIyMALwTtS?=
 =?us-ascii?Q?JHnq5fvgbOGvB5UjzMdd1s9Ed+6A3/dmEJiwwF+KhHaKO9ilKGRz6ajKdPCv?=
 =?us-ascii?Q?qv7jRsmSqYzMXQlqvkZKxX0bv4kIfLXkP90rHRXqhHWNG3DB2QHTQw/7Pp29?=
 =?us-ascii?Q?tXa8VFRTaEWCQUqV269rXI9xTGjWVKz48e0w00dePnAVFQJ+MxQbBceBPFIa?=
 =?us-ascii?Q?162kFwvHnQUJcOxpmnFUHz5G9wO86tr24SoW8PmNb2zVoYnnWKgVprOsMBAU?=
 =?us-ascii?Q?Zu4zePO/ShQIcRDVeHaeYjn3rLt+jRhI198OU2rXquCJuD6xykXt8tGaI3Et?=
 =?us-ascii?Q?AOAbjCL2fdGbX00bUWcTyQBBG7oK6/RBhp6f8mbbGl8Qpg9ZbTuLe0uKFnvS?=
 =?us-ascii?Q?+RtWQpeHC2Fii6orNJEBMJAMF1tTMnfm48+wtnVWGpIRPJbiglJr7zhE8gqZ?=
 =?us-ascii?Q?PUPPOten8G18nwA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mq+1Lqtiku9NkSRF1X0gqROZfNG3s2UB2ZDQMiRGoVPVBP5x8t8tifIk+ypx?=
 =?us-ascii?Q?YYsZ9yhHWLiM/aAn0V8kVH7Dwxxo9Nu4hvcN6JACpDKoTsuKs7HDf7GZu3Ia?=
 =?us-ascii?Q?n3H5DZgDEM9opH8DZtxfDUk9t8j+TWKLTbZymKXZwC+YqpbWJ77Dgl/VmJBt?=
 =?us-ascii?Q?l4+gFLTdq9Rv8BkgsIWeOUa3DxQFZLkFFMn9Z74zkRDjNOAUtPAgAfhVJQE5?=
 =?us-ascii?Q?ac6fyathxSWY1vfsTXW6MOKCdx/nyyW4Fp9GkQNo9iW4mVTXT4QKWIxr7M9t?=
 =?us-ascii?Q?H77dbV2OO7LZg4IfM5bw0sQGgk+2EwcXbKthNpRc1wGINdixVj6Hx+SaqqtO?=
 =?us-ascii?Q?8j9eel+qh6Vgrp64Wa8x3mujI3FJxlhB1G6Rf54cThhoT8mfHi2pjwdjh+aC?=
 =?us-ascii?Q?oszSqfploJ83sUe+6IerKa5lz7ZjYvi1LkzspF7H0DxRroV17Af5x+3/ukEt?=
 =?us-ascii?Q?MMWKPq1KnSUj/AfMeZGRGM7ynGb5KJGYpTUuH6/An9mp29ScnFHnaHsFZN5L?=
 =?us-ascii?Q?cuUHgu/K2au7QHcxU2TkoHqr2gUEepFPNpXevxeQlx4ydassXhenVVWmHm+E?=
 =?us-ascii?Q?yJiZ/h++g/DcQqoIlEM8c/FVNyFfpcyG2hBDD0YRREvZ+XggZAhB1eeK22v6?=
 =?us-ascii?Q?OjXsNwCu9RNARlwJx1ISK8oyarglxNexjfxtXfL5efyFdLiER7phGVtAy7A+?=
 =?us-ascii?Q?QXQa/ZezJl7yf1QL0vX3NJzG4VpKT7UaVIIvf7GFiMm/YJxRWeDpO/v3rEgD?=
 =?us-ascii?Q?3TxnwMrf9PBxYh0qm3AjkEbdlLFuo08XjnljYBSkI9Ze6Or+8Kw3HV0DTRLh?=
 =?us-ascii?Q?W3xQRuaQpqSaqSMCCc+sZMK6gOkJ3SKvvYPTXRTJy01+5etT6raw0NtG3K59?=
 =?us-ascii?Q?/3mm8v2zfUCMO3QweEYObkuWuX3TYZMo/uZE2sqFC21SSExMNTn7Km2tkZxH?=
 =?us-ascii?Q?Gi4ycG9NYr1V7s5zZ4dR9GaB8mKaoFiRYFZtTcTFHg2yV5fHG0f3P5LoMDdv?=
 =?us-ascii?Q?ZtomwTwLtY2vK9BVJ9ExcRH/rNmGZadl/kuiidfVEgIOn/pbQwQi3/AxxfPT?=
 =?us-ascii?Q?c/LABjwu/jrEbPUOXLvgD+5FYXbD8PG9HuqBgwYEOWC7BLUE1D/BVW5oZgNx?=
 =?us-ascii?Q?Q9l/BEv5U8D7yyy8V9v08tT1Id5LOnxiDlrxHB0I/cqv4vfbDsKndfBESX1s?=
 =?us-ascii?Q?ErolCk2mPGgEVbIafnmXAhNrqW/VrenkLOZqAVDSz71IA4nY9wkS2vdLp1lo?=
 =?us-ascii?Q?tt8OSB2LEUeENhD5Dh3OYL3YWz2hPNB9c0OZ35mAU6mVPaxk4Lwmp5oDFsMf?=
 =?us-ascii?Q?omna+d1T2SvS0Og/OSuvXHOrfOmIfrHyRpnBeIxzqhdXsUsZp3jH4bbu4Mxh?=
 =?us-ascii?Q?HKCH8KpUGptpzVpWqd/hYnWB+jCn0AXZi2nIxsChZcgejWWqmoTJt3Qbin+l?=
 =?us-ascii?Q?nBq5E8pcbKQcKdhVpnqVjTwWWX7PtSJP3K01WrFeYMmIfsVkLA3B0ond3oCm?=
 =?us-ascii?Q?fnHLomsav4GJQMa+AmlRuIHB2mmKBa++pZ5DZdm3q6Fp2ZygaLV4bMLnA94k?=
 =?us-ascii?Q?E6BOi1PbYVpcWL3tBSsJXiphUbNDpDj/tDrU9XgQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbd4427-8c85-4a2a-ed23-08dde536db08
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:56:32.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsNUj4mqO4Pxp+69erX841jf+Yf3On12bAifVO5jOGugfDITyCmz+4gWQxEIKWtoDUoB9489CGChIEuY6dPuAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

For ENETC v4, the hardware has the capability to support Tx checksum
offload. so the enetc driver does not need to update the UDP checksum
of PTP sync packets if Tx checksum offload is enabled.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v3: no changes, just collect Reviewed-by tag
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6dbc9cc811a0..aae462a0cf5a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -247,7 +247,7 @@ static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
 }
 
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
-				     struct sk_buff *skb)
+				     struct sk_buff *skb, bool csum_offload)
 {
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	u16 tstamp_off = enetc_cb->origin_tstamp_off;
@@ -269,18 +269,17 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	 * - 48 bits seconds field
 	 * - 32 bits nanseconds field
 	 *
-	 * In addition, the UDP checksum needs to be updated
-	 * by software after updating originTimestamp field,
-	 * otherwise the hardware will calculate the wrong
-	 * checksum when updating the correction field and
-	 * update it to the packet.
+	 * In addition, if csum_offload is false, the UDP checksum needs
+	 * to be updated by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong checksum when
+	 * updating the correction field and update it to the packet.
 	 */
 
 	data = skb_mac_header(skb);
 	new_sec_h = htons((sec >> 32) & 0xffff);
 	new_sec_l = htonl(sec & 0xffffffff);
 	new_nsec = htonl(nsec);
-	if (enetc_cb->udp) {
+	if (enetc_cb->udp && !csum_offload) {
 		struct udphdr *uh = udp_hdr(skb);
 		__be32 old_sec_l, old_nsec;
 		__be16 old_sec_h;
@@ -319,6 +318,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
+	bool csum_offload = false;
 	union enetc_tx_bd *txbd;
 	int i, count = 0;
 	skb_frag_t *frag;
@@ -345,6 +345,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
 							    ENETC_TXBD_L4T_UDP);
 			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+			csum_offload = true;
 		} else if (skb_checksum_help(skb)) {
 			return 0;
 		}
@@ -352,7 +353,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		do_onestep_tstamp = true;
-		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+		tstamp = enetc_update_ptp_sync_msg(priv, skb, csum_offload);
 	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
 		do_twostep_tstamp = true;
 	}
-- 
2.34.1


