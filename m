Return-Path: <netdev+bounces-151593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2D09F02AE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3544A281175
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300214A627;
	Fri, 13 Dec 2024 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YcQNEZk/"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3904AEE0;
	Fri, 13 Dec 2024 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057222; cv=fail; b=LNJxryRDDbOBrvnUjW8/MMQHB06ELnZZp27loSFukN3Yq/iFcHHMqZQ/+ycASslb9LVxTBD7BycI0WnkYuiNiMgtPhDOHV1oeaFIuAUjsTE2qBWa7lCUWIvEjC5SPuOO2/CSVAKwjPTA2bb7R9d3BQsJPDMywyVBtMsi89ThD04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057222; c=relaxed/simple;
	bh=JcmjQmXYClNk+/LZkkQoOlCYvSTkEKkBFqR9yBlihg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqmXemPYJaaqcuEir9c3zmjQ1mi6os24Rq0ZaaWnCavl1wsf3wFFJSANJGw88bfx3emsa9W9BPudxeUH0VSOH6RRosbzqSmqG5vHA1lrS/zN1gVbKt+snGs/gFI6tbnyzIWLsSCJ3QsYZXalQQgiJXI7dkdfJHtF/EAoiET20OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YcQNEZk/; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xrsiw3Si7pyX6NWJfBuyq/Z7DRt5i5LUJnLAw8KNcxAz0jmqqQToURMmu88fx2sO0v5gwbzbieh8Zy6ddgWyn63AOe/plX7cVKhW4BDScSbBSGo7S2WsvPChW+Tc7ckUX/myvvKB/JN1gpbJ/es5qZk2zy/yd9b26PYwNJ5iaj22jwTwGpNdCQw/FRjyQ43Iq4U8uhUSaWHWxV98iVw/kPiurWStpp7HG1wz4BCTKgIdEKaIaKBtCqaJWXbNZev6tMA3P6a14QKgOUhsH6T67oDtMyz7OD9wxalpZsyrGIJl7x5XuhR24r/h405MTyhwiyCTEPHe57Jwtvphkttl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQwdi+hBf8UlmY5O1W3DFR1o2r1aUrjTHTjBIo2nY7s=;
 b=xII5HBiHctPmbiRHy4rjF0IsEPiwqaVgz+obObUxwRjL3tDXmTE4Ma0PXw3oAGE5TrxspYB4mWc1a5EiFmsiuxQGLKTXwPKWQHGBYuWHPCs5EDuW0iZ6Od9xXTLXa6ErZlcFwf5/+SoJRnvDeCOhHNNpgkdzE3JCLCldRrznh6MgkK1JlBhpwrUq8xKCk4Gt3exUZVl+zKzcsDLGtWoIwn0hntt2nhZ9ijmwzZnOK+ChEUEG1QPCBONNNQjNLSCQLrt4LICd4ENtGrgzY4OXbX47jViHF6NpnGHStZISYpqU08a+bVMISv5KVFgyR9Anv9EZh7SaJmvIdP8peJa2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQwdi+hBf8UlmY5O1W3DFR1o2r1aUrjTHTjBIo2nY7s=;
 b=YcQNEZk/4B52TsI8eVrZcgAh9tI1EiVE/fa/MwmEM0HtdJepSc6oP6y7VMRoDTcZ+yCPCZfaBwDZcdLslXkigvyabLA0qhT+Nye/VS+WeoGCVbCRlJCVa950g7GFwofKrkI+x/fBJ6Uw8sQbSoRPxNDWx2j7bqvmnuW3Jh4vLw7/UE95wuhwb5xfQS13AlrvpSkBhdNBNZnyoag9hakyiIU6csWRpERS/fsfvtH5I8MTRaMcz+lOfdApxOcb560lOEXfq2C4RoYzX12TYsMrRAaqHWnsK2lc6Am+lcaTyenNxjo8lTlsPT0slLhBL0f1w5+kQXsWgbIibyBaIQuZBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 02:33:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 02:33:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v8 net-next 2/4] net: enetc: update max chained Tx BD number for i.MX95 ENETC
Date: Fri, 13 Dec 2024 10:17:29 +0800
Message-Id: <20241213021731.1157535-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213021731.1157535-1-wei.fang@nxp.com>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 182bf4f9-276f-4fde-325b-08dd1b1e8c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k5ncF1VwbYf1PDG6atQmVC0pefhZuXlaQshVICXIOYiGXzebHWO60Yv6WR8P?=
 =?us-ascii?Q?QAP2BP07mOrRFJwqod+Essyv1Rd2wL+jQuwP9Y4JXKzXBYqo+yiRL62EWlWZ?=
 =?us-ascii?Q?gpDB/Azo2wjtAOpWHbmakfnvFsi1mVIatoWklLVy3uRz/sJMtlyeoh4wwASd?=
 =?us-ascii?Q?mbdj54aP6R9f9l6R1iw1mtpDRgTTJy+z7ul4A6FaV6uhk89saxhIUyWvGIjT?=
 =?us-ascii?Q?20MMuy92FFkLv6pJOJZY7nvFvezuBgioEXXvZ2QeFY4bo0BiQ07yFbwsm9dB?=
 =?us-ascii?Q?coWZi3453u5acTViNiepKw4dwCxfpA6rCsMOrPSFPOYdkxAQ9YVyxHlpI0g1?=
 =?us-ascii?Q?A3BERcp7iBceumrcu0FlwDfNsPlrQvDFIK5XLAT2HQoFcrChEdNimn+Ery7b?=
 =?us-ascii?Q?rE+uvTO442NSptJTEL5nRTkxRCBRySkX2zEA0XRfJij63XlGVXCa31z2PZNe?=
 =?us-ascii?Q?Ja6679L9EUG9BMKGfO79oK8vpLjalFTNL8MMMWrUpsQm9yv4n7J1+ljWrb31?=
 =?us-ascii?Q?E3H4+bnuUuFlxsUbkQ51EC7JrX59qDRAkxjzxL3UKsj+sYPKD9zvtVvxekSO?=
 =?us-ascii?Q?Yyt6Gjp0ruCybf/ySkNFz9uuFesB7pB/PBdJBqbc8v5fERr43UnE+GwHzlbM?=
 =?us-ascii?Q?dp8zJZHneoGhzQAnVdFcAzozSUZWYmVhzpAQ5YahYaoMG6WU+n8hgkZpE3QU?=
 =?us-ascii?Q?M2iZmUuev7Fs9TnQoavSEVNqFMVytwi4jxMhq4bP7iNXhcFFHjssonN+3G9w?=
 =?us-ascii?Q?0Az7GaWeJRj12uGcg6yrzNbaC+ZNIgcQqi5LhgCUH1CeIW2tUvOYzGgJZ8Xr?=
 =?us-ascii?Q?it6yhjvkAceUMnpnqh4k0RT0svmTz0xCNc1qqJbQchCvMYyoCdV+kmIt07FH?=
 =?us-ascii?Q?Lyso3iQLnEVM+5pC1+FRYTw2BsaDZWn+lSFIqYEedySnAht+OHlEym3BiP+p?=
 =?us-ascii?Q?74xgE8Wgizkw1ax6gL2WNhKxPnlFiuYHIMHLU86Eht0cshyrgguX9bGDK10A?=
 =?us-ascii?Q?g/vXZT0s+LDRVyKiaSHS9uW9BaUd1KQb3yzX+FI6FOZs4RPNmEy8kfuWMaI/?=
 =?us-ascii?Q?rXgBa7oUOR2Y6Q1SbzDfr80O3mnilaSBbTAW+SioxHKE8TBi5natCo4/UKoQ?=
 =?us-ascii?Q?NJxWrTnl64frzqGcnXhe69JhyNpgp+ozVjIaYwxGcD4WHbQgyqPnvOi58kxh?=
 =?us-ascii?Q?XVOvV9EBDkiX0zPymXyIjf406S5jwnKWSrMNHl0IazYntZ6FOfIpNCvrb3cH?=
 =?us-ascii?Q?U6V1e4uJD4qEELNOqONpH3wgKh6Vg89zMf3dwOcBVf84BBI+eMKnXxDTu7sf?=
 =?us-ascii?Q?AIX8a2jhRmyjuj9uYcGMOvv4A4ZrvMG7pD9ehh1CmYK/Rw4C/s9CCbLzr7KR?=
 =?us-ascii?Q?cIUZ8RwbRkNfKsR1eFMKE8mWquXJcZQv1B/y6NJqSCIusq656TNk+KzrUk+C?=
 =?us-ascii?Q?jcPZ59Ab2NI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hYxmIAHiZeKgEcq9fBtRjXzRKMRXdb/vE/mUm+btq50CgkNAUYx3uZCabtf5?=
 =?us-ascii?Q?hexwIuRK65/et/W39enj87oYPxTuuiV2RECYXvzF2ruoPXu3X4spyEIHqaaX?=
 =?us-ascii?Q?HNdy9/i/QVK9iq7ZzdGB7v0MZkT1VyoM9y5CM2XtsJz2s2yAR57yVAChQALb?=
 =?us-ascii?Q?xHb7EsGWNdSsz974tqw7zwUU2J3hO3iVwhr5fmJjTAhNMkRj5rp+gG8FARSr?=
 =?us-ascii?Q?msItCKADzC5R/b0jhcIj9v+4znZ3g+at8tydw9TLCZ2TsKup5CnofsveF2SE?=
 =?us-ascii?Q?/H7DP8r0XiMDYOIMCGp/T0yyyz1BQZtP33iij6xwDeusoDfDsgjE4PsHrrWo?=
 =?us-ascii?Q?n/0sDsDqeUFejCF65Tn+GnGKn/Jh6gjc0gWogvc9vtji9Q0ISszQ4cS2sxHx?=
 =?us-ascii?Q?E0vIz+RHQXhHKAtNAXhYLLAKEZTL2xXYP+YjgGFkmvN4yIcoc7m5pn7Qu7dm?=
 =?us-ascii?Q?V2Si3le12vERzizjwTFNxDlh2Y6tVkkVwmABNo8BVpxwiB5KblSgacqmAwvA?=
 =?us-ascii?Q?qZJwIB8QKHGSUAChhPDvPdk6vUaT6VM4bgmnPKUIMkgmBl809D0aF1L71Uw9?=
 =?us-ascii?Q?OWgTz460fFMwzSkmtgrTcEhYBVzFa2ytRwt49rP+EK2mfZwPu5U4Qibj1xKM?=
 =?us-ascii?Q?bO4oPW4E7lEfju2DjKoB1a6qrZEBALEjX+4de5JYktskJvT9OOFgyu/LZ4UQ?=
 =?us-ascii?Q?QN1U+JBjGC7x5ocS01Iuewx6JDrzvpgsUmN8SA2qjZCwn45PAhCx1KmQ4Beh?=
 =?us-ascii?Q?LhEi1zU3jnpx9Aa7sk7yGrklY26wrBXNlS5pbBn7Yf5RD55FHdYW21Bod5Xj?=
 =?us-ascii?Q?9E4wACGNpCQZ6OcXlsDD4EsoK3h77DJjLZYwqhWOihWElWFsS1mk0/4btJSk?=
 =?us-ascii?Q?k+iWvrdOy+4b+T+lDITotN2KqPiuwgl+2/P3pLoGYKbyqRkJwR7R5Fu0rWHb?=
 =?us-ascii?Q?qJXCw8Ov6bc93OgI/msBC5VEZa2S7H9XQ1xDPEr4xL4aTuEyJGFxiu2419+I?=
 =?us-ascii?Q?zfDVhS/WOniszJgHyRIXXCAHZRf5rOTdFcKJEmYiAa/LiZ7FRLv/mQYFG6gf?=
 =?us-ascii?Q?KLa7c+Z84586Avy7rK5pQhOesC8/FvyBvbgoFpTWkBaX6/mbycRVtv/A++VO?=
 =?us-ascii?Q?RXsBtrBmqgOv+Q3x/dcs32V9kCA4bQxB+4D27FibTS7QltssQwbEixDHZnHa?=
 =?us-ascii?Q?xCbWlMhsVn0mdZmyHjxJDEmOjS74xw6frPOb827zWBrF5dkR9/HtFEbyDyiB?=
 =?us-ascii?Q?2yb/euDg/UlpUJr/HlFcAu6wLXqaLk2p7Kotcz5v/9qMSenHodsbqssinjgv?=
 =?us-ascii?Q?i62IcD4AM3SjHzX4johj0DsoOqxy2wQBbdz+Nl81NlNjjVkkfHMXcNY3xmR7?=
 =?us-ascii?Q?AHLr8gLWsnnHkKrVkIo5gBSHyhNHMXRJk13XKn34H8W7r+Rwi4+7ioG1oMMC?=
 =?us-ascii?Q?h83hFZxNqHCGF0KKgInEVuBrv37pbL5umAoNt6+NZe/y5HUDINRAiVCvFYtz?=
 =?us-ascii?Q?SHzT9IYXds6qyexJ7r7SMSPfKwXmxmYGeO1M6VI2Un16vITLjCdaBoA7Un6Q?=
 =?us-ascii?Q?BqsPmHlPPDrsPMlF3qPcTgedFSlC8ivNtb7KhfI6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182bf4f9-276f-4fde-325b-08dd1b1e8c17
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 02:33:37.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ctx97qrBTNa9bfcad3+4xMHvHmgdWYSq2SXPqjJbfftsTCicAVqOvhbRmPTV3kEeH9mzj2VDHzTzNX/PyZBiPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114

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
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
1. Refine the commit message
2. Add Reviewed-by tag
v3 ~ v8: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c        | 13 +++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf_common.c  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  1 +
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index b8ac680e46bd..09ca4223ff9d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -535,6 +535,7 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -600,7 +601,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
-			if (unlikely(bd_data_num >= ENETC_MAX_SKB_FRAGS && data_len))
+			if (unlikely(bd_data_num >= priv->max_frags && data_len))
 				goto err_chained_bd;
 		}
 
@@ -661,7 +662,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		count = enetc_map_tx_tso_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
 	} else {
-		if (unlikely(skb_shinfo(skb)->nr_frags > ENETC_MAX_SKB_FRAGS))
+		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
 
@@ -679,7 +680,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	if (unlikely(!count))
 		goto drop_packet_err;
 
-	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED)
+	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED(priv->max_frags))
 		netif_stop_subqueue(ndev, tx_ring->index);
 
 	return NETDEV_TX_OK;
@@ -947,7 +948,8 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
 		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
-		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
+		     (enetc_bd_unused(tx_ring) >=
+		      ENETC_TXBDS_MAX_NEEDED(priv->max_frags)))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
 
@@ -3308,18 +3310,21 @@ EXPORT_SYMBOL_GPL(enetc_pci_remove);
 static const struct enetc_drvdata enetc_pf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.pmac_offset = ENETC_PMAC_OFFSET,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_pf_ethtool_ops,
 };
 
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.tx_csum = 1,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
 static const struct enetc_drvdata enetc_vf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_vf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index e82eb9a9137c..1e680f0f5123 100644
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
@@ -235,6 +242,7 @@ enum enetc_errata {
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 tx_csum:1;
+	u8 max_frags;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -377,6 +385,7 @@ struct enetc_ndev_priv {
 	u16 msg_enable;
 
 	u8 preemptible_tcs;
+	u8 max_frags; /* The maximum number of BDs for fragments */
 
 	enum enetc_active_offloads active_offloads;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 09f2d7ec44eb..00b73a948746 100644
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


