Return-Path: <netdev+bounces-148815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC94A9E3341
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD23166ACF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E1418BC20;
	Wed,  4 Dec 2024 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SiQetk/y"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DAD187355;
	Wed,  4 Dec 2024 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291144; cv=fail; b=iqE3EcsbkRyQbEFBf4yrEe9VZtJevNNrnlc8opIKOo8x2GE7I7OzDZkx5U4S3q7SnlejFmv5admeHSlyrCnnWy1I2K1eHaEibKkYFOQ3E5iDYCbJDkngYCONGBBEQmKnvqWYb/I0r+mqLO/YHDw0fSi0fm1Qn34MWsayS1xEQa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291144; c=relaxed/simple;
	bh=5VxzRgwJEDz0xzeiePrQBty7EbxW9uwy9y8bCMC6FKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jaRm/dviWvg2elaPq55V8FR/S4eUt7CRsNxFFeX7JNVy0l5SrfGUi4xiZMQnVlgaN96azMNAe6kv8hvziUJlOWNJi3XmPyHQZUgG7sCRY0lhXjzPeepekjrMtZ3IIXR1xEoTFP98ikJjcXr7d/al/z+qK9oobarLuj6bybdmRSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SiQetk/y; arc=fail smtp.client-ip=40.107.249.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAgkyZrpGjjJorO3xApNpqbavR67Rb1tr5Qp/RckjQLIF+03BZJy9tDurIG6UzoypQshTtTRkmcflXGnhS/eUeiOj08ZdEd9c1BXRrRcC6UXIF+0VEnWF8hSz/Y3kQrPcU2z5zYeikyqevm9R+EscR4vay9eO714ApOXhQkDIBHTImQPKZDkzJWJk5iS2jcoraYlJm+aIS/ZMl8A6Dbn86+mROSO4a/qNyWpwRpYET+hz9HQ2RtE3vy3PqUgsCQbOzDLysQuRHrj5EPi6Msrmf/YhLzFT5VVzDzIc+yWB9+qqm14ZB/2eBrNY1Yt4QqRoElHrWtsZ09pLAINMwVj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfJX/n/XJPUtzt8GKKyfZyCoHCusZJw+fasIC99dtJs=;
 b=WL7G9O9NyO439mEUNgg5xpqlmGEA+Wd/YN4tXTcIf41zAqZ2QbMtEG4r6UK2PTdflbM4A7vAeB7hz4zNNOxOVNnPHvc7m1LJSpWi2goRgrKWES2VoIfkNN4vYf8Rdi7X9PAn0DEJ3We8deHc7DhoNUBSabdzdQztJnH14+9P9+oYFezgo7xSiq6HVsgEJ1lJFJZ9tQM18xbpG7D6U6tT6Hl4vfR+jWfyT+BztdBvpkoN71Lc2O7jz407+y+2xk+HwJquusb56Ai+TC17qj7xzdnKENbMtawdrTEmpBnAwkgnJgHUnZvc7BNxCQhcVJ6C5gjzvAkL/k3AXNLX/R98gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfJX/n/XJPUtzt8GKKyfZyCoHCusZJw+fasIC99dtJs=;
 b=SiQetk/yI1uqCjTioi9pnJIKdpeQvhY1/7HytjaAQt4ejrT8jC5vzTtOwNVMjOt23SCXXGyondejnYAZnz1dmMtPyiqVkL31TxLyq0/QzIYueLT6L9UaDMCPIjwN889DiR7YhmzBzC9Yl6k4KZ9hjBqxYSzLm4JmWfyamm3dzK2PSWQZKLCt6Zoyvkt+DbElsDhrQO3rrauAaU58pJ/PytJq7GxCAkthGeSLPAQTKl1RfSoDDyGxQvUHUnPxMijKo+poPdNlU2WaWRYgyYj95TMMENBGjSojHZaHw+EwK4JEeHVrWvprpR53tA3hH/9ItGiN8kZnFvu+8hn86GZBVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 05:45:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 05:45:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 RESEND net-next 3/5] net: enetc: update max chained Tx BD number for i.MX95 ENETC
Date: Wed,  4 Dec 2024 13:29:30 +0800
Message-Id: <20241204052932.112446-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204052932.112446-1-wei.fang@nxp.com>
References: <20241204052932.112446-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c942a6e-f236-40f6-05b6-08dd1426e1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TpL8X7ZEovj+lLO9M0a9vLpNJjkpc8dXwy5n8SZC7U/vtUTTwUa5m5e5RY6s?=
 =?us-ascii?Q?QmEKYTPepbf85sTPhWUWTwamWFVds9K1Rjacj150LkhfZQVC5dFEDaLXm0+v?=
 =?us-ascii?Q?pMFWF6vao3zAx5mJLFTcvAGCUb2A0yRHeSCLwshlgQyZlcNV7FIoO2+uzNvv?=
 =?us-ascii?Q?ycpQBN9E3qAlhxqwMHayCdEBWgWAQLVNf935UgLoBan/2fv1+BdEQKSkrZGc?=
 =?us-ascii?Q?7W9Eiya5B+ACXiuT7u2CIkQTzJehe06hghGR/fUAJHmcgNcLSDrPRbMhQx61?=
 =?us-ascii?Q?Y/FfgV++sYZMH9zLjKBkrxwhP2OF8bWtOsQYh2bBKo+28Vf6p7H3v5ekBG6w?=
 =?us-ascii?Q?7jSTVDm+znIqV72FM52F+3EhlNYvrozy0EbAPi1RPV8jas5GEkyTgaZPclJG?=
 =?us-ascii?Q?dUOXOjHt54CfrdVEiGwkPSglVKZ7SrET7l2h0NHGYf9sCt+ZPSMXAAgv8SkC?=
 =?us-ascii?Q?U3Q+AR8+0wvgLOOVfcrmFjXn/y+xDwTDlGOwi5R57g+eB3YLbyyC2z9tec/t?=
 =?us-ascii?Q?16dkxJrE7G1W1G1sw+GD8s8pupEuV5vBCUKMg+iWeoXjgzPjxCv3inYpeQYY?=
 =?us-ascii?Q?v0+LELic9T7OBwVgvpCRcBdFhFYsfs3JMOWgnGsG+uhRMhwUt9JzjfQpHbS4?=
 =?us-ascii?Q?V68vrfPRCk0ZDIV4wz7NPhw7YDjMY+UDHuCbRvfllMvSs4wucZAgWRZLoaw7?=
 =?us-ascii?Q?uowhBvN/Czyk/loCQZ5FhmoHDvAkEZOu/3AgkFrM73oG6paEKLBmIclRAfGt?=
 =?us-ascii?Q?r2mRtc+teJHJ32wubYHiezmSRRT+G11RRe9BrMiOljDAXV6Lxp+WhlwQWvcf?=
 =?us-ascii?Q?BkpI2oPD60fLEvrOye5/NxY6GHvYCYazqSFnLDOridn8ephssA4owy+a4H9r?=
 =?us-ascii?Q?w/fIA4fHsnQ1xbq22BSr8lyoP5CDyd+KY5lHQWACVLKLsEQaxrKPPTq5oU1D?=
 =?us-ascii?Q?/EJGWwBgeH1SWD1CiyVgLntGVY8inAGydkviVeaGeFo5x1uckdvsk8qSqRg7?=
 =?us-ascii?Q?0/rU8Qs2YhA5hd1qLlJ4QwbZy43tm3P3NmqV/ytPtssmswmscKJDh3i/oNR4?=
 =?us-ascii?Q?EowyPJLJuSx155wK1nygljWAth0HkYTAzoihZrY11f1pPetCgAiXy27kTuFR?=
 =?us-ascii?Q?IY3E3Tj/jzW5d9WerzC2613vqpv+UV6AV29U1EARUWA0zf8ueQ3cXmMF1gc3?=
 =?us-ascii?Q?vKVcQW1Zkturw3p0ISkLPBQzZwFEdymjIw/cjZ3AtEAOkiPC9HcsBgwFYber?=
 =?us-ascii?Q?66/EcSiuerVw1VWcgrNyRHBL+jdg/ITjT1ohl64hDaZ8mX0AkH2VW18JUFLj?=
 =?us-ascii?Q?6f+Rc+zufbJUXk5KtsvLtSuf32XkfYoegFOEQg9WT6X32+kb8Bqaeq0jPVHR?=
 =?us-ascii?Q?9quzoqyxf6mdck11gwPS1D+8DTb6TiiMS9vf5TShJddhQEWR1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zWSZGM7yaESo8rUj+GpYE+B9RqrEfo9KOayVX3MLqhSz58aY2aESTyTjo3SG?=
 =?us-ascii?Q?hhVvLB51xgWA6DghiWnKXhxcPAXH59phDwqO6kmrDEOoKcQ6fFkXtndJBziH?=
 =?us-ascii?Q?qdN0YZbVemcwL6l1gRbsziKVnYQq6eWM4h0QO7VRtLp4pU0e6UKRWcPHxlTU?=
 =?us-ascii?Q?NsT3Gvqha0IIgsYMJFSE5JSDc0gogupaWnzIt6R19cf/neYdPc/CwRC9qBNT?=
 =?us-ascii?Q?aH1too6kfPGGo7zQD5o1zMD4aJJjJyGjQjhFeN0TaUgIfBHmEmoOuSXi3Dyo?=
 =?us-ascii?Q?nvQ/4NjzwB0tTYeg+rytF5WzYZ4mkZM2CofWXzgY9BT9xsDwSx3wkFXWZE5S?=
 =?us-ascii?Q?TJieOb+z2lqtBkMqli6PtFN/by/nMOawoCJNK0GwvWuoINQnm+vWN8G6olQH?=
 =?us-ascii?Q?IoaV84dh1csHAMJj5SW4ANMvCHFTviYbrDzZHgiJsFf9XfbMhVHsFg7zhyXD?=
 =?us-ascii?Q?F+3OPTrTdSR3OG24GN90YK7irGBAf7DB8VXmiyhqQQKkZ8LtC1YGkg/OTNvP?=
 =?us-ascii?Q?fexeL21jnay+4/0aGlMfpRWhZ1Z1qFyNjTm8yesZClePmYg6g97q8Mv5JnLz?=
 =?us-ascii?Q?tYiufkIJftrF3D3169cu49YkC4ujOgs2Q+1eKvxt4yRYAzi5x3H1mRrQf6LW?=
 =?us-ascii?Q?84WnpuwQe3PgDyGFlNZc0BB4VGkYg6Rqqn4zTYQcO+aK72K3MDbo8QnF7gKj?=
 =?us-ascii?Q?nvNpPSyQU7y+BB8hv2/zKa0TTSBq5C/Nm8BR3sjqk/IQATkdho7t9B8xkApD?=
 =?us-ascii?Q?gYe9rSEr4Rk8ZmasWT08UXERYE6QV9xgXdm2cAt50gqkrwxeRQVF9quOKejl?=
 =?us-ascii?Q?G5m4pcx4gleBN9k7pNYHD4R/1K1k7A21dCTw4a918V0fncMRL+xSttLiCPnn?=
 =?us-ascii?Q?p1jYf5OY35lp8Er2FsLkrcaB2SoXp7ICqBfSX8y7tUbzehi6EhYzINGVdmVC?=
 =?us-ascii?Q?8uS3uBTLojtvZr+VCHLi5JPt47b6D3OSyHshTTCO76QkhAlf8h15380B7FSu?=
 =?us-ascii?Q?irEKfdeoC1EU8THwbzi2PYVMQRFRg+YuEBJL5IJ7CjpqwovLA1C6SyHynUil?=
 =?us-ascii?Q?zeyOdcqP0pK7MYxQ61/cyAhke7roJUeYNEjjTam6olsmxeBRH4wTpPiydR8w?=
 =?us-ascii?Q?M50OUlnGKLETUoKBREyqSSvxhzxrgnhogA3FaxZmwQDEQxP9/IV93/0pkevS?=
 =?us-ascii?Q?5tT3K4uGfLQSi9y0shAqYa5VU2fPwo9EOoik3OQ3VJr4YIDv7zoV/LeWPCB1?=
 =?us-ascii?Q?filtFb0OzFymsvF3VX9R0D77DGsLasHI6tcCbCSD9jVsOmS36SCcTME3Vd8A?=
 =?us-ascii?Q?HQqwNHwo1tsmGMO+ca9ORUD1mp/Ec+xXfVaR93V3Rrab/iTkmOgiY9TvEjQD?=
 =?us-ascii?Q?Gckb3ApcTN6axwRJBIxWPQzNh9g2AP5YnPIQ6dxo3e2WdqoTje3Tjv6wlohS?=
 =?us-ascii?Q?Exagcr/POx8+QDAdU4yUajSiTDh8xGH063CBEGSp3ymUUdPaYZg2AmbQHw9C?=
 =?us-ascii?Q?ke6I6Yn9bNtq63dwn5Ggkecf0o6zVbGxaL5M9shQpbzA/glJMS4nBfyrIf0G?=
 =?us-ascii?Q?/kSvs/ahsIZ/A/vcwPbRwm5AmrWSPMEOr3my7N3w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c942a6e-f236-40f6-05b6-08dd1426e1f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 05:45:39.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOkM09JEWnc3mFmYf22SF2DkewwjMcMN5H0cpOc+nos55D4/kWfgjygOAQHy/uvecjgrFRvBhN9p9/JSCSuznQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

The max chained Tx BDs of latest ENETC (i.MX95 ENETC, rev 4.1) has been
increased to 63, but since the range of MAX_SKB_FRAGS is 17~45, so for
i.MX95 ENETC and later revision, it is better to set ENETC4_MAX_SKB_FRAGS
to MAX_SKB_FRAGS.

In addition, add max_frags in struct enetc_drvdata to indicate the max
chained BDs supported by device. Because the max number of chained BDs
supported by LS1028A and i.MX95 ENETC is different.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2:
1. Refine the commit message
2. Add Reviewed-by tag
v3: no changes
v4: no changes
v5: no changes
v6: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c        | 13 +++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf_common.c  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  1 +
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 94a78dca86e1..dafe7aeac26b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -525,6 +525,7 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -590,7 +591,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
-			if (unlikely(bd_data_num >= ENETC_MAX_SKB_FRAGS && data_len))
+			if (unlikely(bd_data_num >= priv->max_frags && data_len))
 				goto err_chained_bd;
 		}
 
@@ -651,7 +652,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		count = enetc_map_tx_tso_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
 	} else {
-		if (unlikely(skb_shinfo(skb)->nr_frags > ENETC_MAX_SKB_FRAGS))
+		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
 
@@ -669,7 +670,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	if (unlikely(!count))
 		goto drop_packet_err;
 
-	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED)
+	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED(priv->max_frags))
 		netif_stop_subqueue(ndev, tx_ring->index);
 
 	return NETDEV_TX_OK;
@@ -937,7 +938,8 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
 		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
-		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
+		     (enetc_bd_unused(tx_ring) >=
+		      ENETC_TXBDS_MAX_NEEDED(priv->max_frags)))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
 
@@ -3312,6 +3314,7 @@ EXPORT_SYMBOL_GPL(enetc_pci_remove);
 static const struct enetc_drvdata enetc_pf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.pmac_offset = ENETC_PMAC_OFFSET,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_pf_ethtool_ops,
 };
 
@@ -3320,11 +3323,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.rx_csum = 1,
 	.tx_csum = 1,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
 static const struct enetc_drvdata enetc_vf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_vf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ee11ff97e9ed..a78af4f624e0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -59,9 +59,16 @@ struct enetc_rx_swbd {
 
 /* ENETC overhead: optional extension BD + 1 BD gap */
 #define ENETC_TXBDS_NEEDED(val)	((val) + 2)
-/* max # of chained Tx BDs is 15, including head and extension BD */
+/* For LS1028A, max # of chained Tx BDs is 15, including head and
+ * extension BD.
+ */
 #define ENETC_MAX_SKB_FRAGS	13
-#define ENETC_TXBDS_MAX_NEEDED	ENETC_TXBDS_NEEDED(ENETC_MAX_SKB_FRAGS + 1)
+/* For ENETC v4 and later versions, max # of chained Tx BDs is 63,
+ * including head and extension BD, but the range of MAX_SKB_FRAGS
+ * is 17 ~ 45, so set ENETC4_MAX_SKB_FRAGS to MAX_SKB_FRAGS.
+ */
+#define ENETC4_MAX_SKB_FRAGS		MAX_SKB_FRAGS
+#define ENETC_TXBDS_MAX_NEEDED(x)	ENETC_TXBDS_NEEDED((x) + 1)
 
 struct enetc_ring_stats {
 	unsigned int packets;
@@ -236,6 +243,7 @@ struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 rx_csum:1;
 	u8 tx_csum:1;
+	u8 max_frags;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -379,6 +387,7 @@ struct enetc_ndev_priv {
 	u16 msg_enable;
 
 	u8 preemptible_tcs;
+	u8 max_frags; /* The maximum number of BDs for fragments */
 
 	enum enetc_active_offloads active_offloads;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3a8a5b6d8c26..2c4c6af672e7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -101,6 +101,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
 	priv->sysclk_freq = si->drvdata->sysclk_freq;
+	priv->max_frags = si->drvdata->max_frags;
 	ndev->netdev_ops = ndev_ops;
 	enetc_set_ethtool_ops(ndev);
 	ndev->watchdog_timeo = 5 * HZ;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index a5f8ce576b6e..63d78b2b8670 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -136,6 +136,7 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	priv->msg_enable = (NETIF_MSG_IFUP << 1) - 1;
 	priv->sysclk_freq = si->drvdata->sysclk_freq;
+	priv->max_frags = si->drvdata->max_frags;
 	ndev->netdev_ops = ndev_ops;
 	enetc_set_ethtool_ops(ndev);
 	ndev->watchdog_timeo = 5 * HZ;
-- 
2.34.1


