Return-Path: <netdev+bounces-145738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A661B9D0984
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E31B21160
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582A71494DB;
	Mon, 18 Nov 2024 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q9mH5bBi"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADCD14830C;
	Mon, 18 Nov 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910943; cv=fail; b=BVOayY2OknA+I1YgxZmGEh0Hrv+/e4HFYv/Drurqsz7YqwBKvon8g2RxaP1l5sxWrpUy/4CDEEvsSaRdGnx3mkMICCJk29rwdBIbDi0oxTnSyDiwt890lhYbRV9aA0+fr3cdrOiBN8UJ0qGbtYT8W1RmnukemykRv3NIyHq9PM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910943; c=relaxed/simple;
	bh=aqhWNWDIxxhXGramADdKy+U88193GWHDHuY/Dhqm4tM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ts+Cn2+O/UdZq8yTMsujlYztMAGjxBAqUyZJ83QO7MHi420dPIZ18bc/TRNeq8lTCiLz3G+kTvQqlHwaPc04133SkfWmkg6TT5V4NJ6A+eHh94GIuGsxs5P0VotjRFhGX16aO2iZvHcn52XorJNvRegdSR3avoshsHdBLrEFP/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q9mH5bBi; arc=fail smtp.client-ip=40.107.105.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KorvlBMy7YcbkxzpGmf5BFUiDaM38vzfeHGqyPY69DYjDi2ytfPv/E4ELwaYewhYNcv6vUaosQPQFxyr1AmlM5RNupyJrMExC5uwoNWK7xT3cI+ojboib3Nl9hSYrBpPLbs5W3Pcd5G7LFc7bhRINELzKSDyYvcNsDetZPJCCUfHB1ifosAeC4FUF43ogc2xciZBtKvZixWsBkzfoY6vW25yJ1KxzBSrwLO1TPoaTsUH2uXw/UbDnfx2po/NodiHoxvxA436Ed/OhYrILba4wm538+RrWU42hir/6wOuWC3aDOlvWEO1fI9kFBE5rIVbMgvsTCuHu5Di+lPrHzEWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFRKqyrcnNeg/ky4xnpikrrjOl8BV/aWrWZ3k4bHFp0=;
 b=y0bzKeT3NW/CjQpV4t3hn65wvfEzwfjyb2fYcynGBKd0IX5m3r4MrA5hWZW4uaRCa8nfYSOYD/Df2FGNWD1ipkS8SBuG0DpSb8l4gibtTGLXF5tVTq3hDu2jLDQn3tCLhOuokvtxlFzKZskIDLmWXZPWIQr7SOrhaXoczkd/W8lzSbRid80mRBtiYAVOMsrQM4JgBKhhe/djO5kUenKWOLkWmJk4+O+BTxWA09MBJkAQtphdGsNRjZv3127C4SF5HtDnjpIIJuua3wKNlr+z1DwnqBaCeIwljgp6v5WYRwdjy6FZyQpmKNBiJTmCxC+vuhIsqR5rgGnckbXDRNrJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFRKqyrcnNeg/ky4xnpikrrjOl8BV/aWrWZ3k4bHFp0=;
 b=Q9mH5bBiUGsz29D1rAGlYHr6MoxkdPR6fOG6XpCtWm0F0EAkWOBMtN4xO6cFn3VpCq72nJkRaW1hWChMfRQ0hShwS0+b2y0QPVO//wg4KQbQuPJD9Lxkl1m4j26qb2jrbxkWtmSNny7rd4OhH9Q/2UvSDVB3U75Nu6z2bxNdLpsu5ug1rwX5xwCr6GvnN+LZPUPeJY/RVFaFqcBpX75insL7SB33Wxp1augq65A3sTdddLNnPpDhwuNkeojM39LJfRvOrpfgvKD6QcdizoLlWT/nW/Fe9rKBwPfDM0UdheOnr+vFVBQfH4M8dynwnqbYVt3dqdFyBF0C2RzQA0x3xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 06:22:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 06:22:18 +0000
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
Subject: [PATCH v5 net-next 1/5] net: enetc: add Rx checksum offload for i.MX95 ENETC
Date: Mon, 18 Nov 2024 14:06:26 +0800
Message-Id: <20241118060630.1956134-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118060630.1956134-1-wei.fang@nxp.com>
References: <20241118060630.1956134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 692365a2-fa28-4e63-5bea-08dd07995a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wDNpCRTcA1OwS9jDDcdxdDtGbOQ8aN64fZcl4Jubn7GiaM7EjJoKuMQRyQVQ?=
 =?us-ascii?Q?+W2N42NdTSe1S34wWyfe4JEpYTCRzpkjk+NIbrMb+CURFFIPf04H9eyVoNEK?=
 =?us-ascii?Q?ZAhQsrwMV4IuedyYFJrwWSmi3Kc7JhfvcvQiOYe1J/LkXNtAwz7G5CyPua71?=
 =?us-ascii?Q?0NoZoVovAxc1ux4fkp2YVjekAqjU+H8xTLxQyahpOuZ7eOImbAQ/LTnzcbEX?=
 =?us-ascii?Q?pMZlmMJYQU3ljTa5KCPuuGpBDrzPwayIgjHNZ4Jai4zGIKvbItePqdAAKHTA?=
 =?us-ascii?Q?NRloW9VxXQRAXaU/lLzBdaE9JyvReZc7srLh6rcknc+J7+9yN1dGYqGYBmXp?=
 =?us-ascii?Q?6laPVcxyTdx7fFwJR2uXz+QpXmsw3URlZM//r7mThZYW1lCm0Em0b/jVzmay?=
 =?us-ascii?Q?eF5S2EYoUC++yIiKQpV1+qdK+OAFgiVDBQlzUwrWMD+FGQSNF44OI8kpd3WI?=
 =?us-ascii?Q?a4zEIzPHSc5MP6anRj2gOSHYtgYP+i1YpA20MUeankGjBzag1dsqGHUTU2kE?=
 =?us-ascii?Q?t3MKhPxD5orvb/yYzcaK8h/f99n60zN0+DRHEFnSsWK+H6xcyzCnapFEhex6?=
 =?us-ascii?Q?ppWxcWaaAHSqxx/iQGCVw/b1Tr80dLcYqa+kNA0g+2r4Yd15f4ymHC2vVkVP?=
 =?us-ascii?Q?/84sDi9GtvuRWxBzmMx36U1OpV3P0nG24pWfxG2Dc+Y1Is9NvfL4qv1zkcxx?=
 =?us-ascii?Q?QBW/SL7BRybTsXR3AkAwcHqhnnbRKdZMQhhpDrWMplYhQIMc/+seLIz3hQ9A?=
 =?us-ascii?Q?rJlNJUP0TwLD2oMWARGgL5g3pP5p07k/XWygB+Z+HoTfOK0SoDfFkfrWrkGu?=
 =?us-ascii?Q?jlOZq6NbFgYkPqjXg4HOd9oAQGqsQiTreUDbVGcKtcY04sBH0nBosoNaabTs?=
 =?us-ascii?Q?gC6ZJ+cUaQfv16MOPybjHA/HY1eR/FXBWEo4aeXcdUcSH3niRQ+zPNxuqSiL?=
 =?us-ascii?Q?PhKc6Y9pGTprDuMpszIB0ylSUUQ/pfMW4DrYXK8uX/4+0a+hT2laA02lqtRK?=
 =?us-ascii?Q?z12jL2zoWOAybIYI8CK5KLw7vz/4mraaW3iGgT4cjcf7g/1uugUZow6n/1MF?=
 =?us-ascii?Q?JkP+sIc3h9lHznb7TZx1/5LvgkzfjNENrXLSlGsxCnawelqJY430SYbZYqhe?=
 =?us-ascii?Q?Dv+K6p1PymcHOuxAhRBBKT0+lrhWJvMSzOGvWVwp6etjjAsUHd9Vhm68rch5?=
 =?us-ascii?Q?Caac/ax8/53j2t8IOVDIX9t3RIC/g5EbXhY9SisPddz1OFeen+alNApTSoJ5?=
 =?us-ascii?Q?Bw3CoBM/fva9F2BOLAxy1c6TH9/rEkLP1oA2MRu98qEFMS29KEXUaXdYPB/y?=
 =?us-ascii?Q?G0FwtRecL0GxYDMo1+uHanyKEemy4cIgK1XN3508gJUmo9ooqtaymxsacokK?=
 =?us-ascii?Q?XeNmAPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GjB0ESlT+6HxjSYZVOZ4q0MbPtjuSG3MTjtmSZplTj77CN19WUyV919y13qA?=
 =?us-ascii?Q?IBHA+1CxxW9vvTbpGceBOGfc5WSTUE+UoBEXwJV9+f/qVg82xQex0UxufdA9?=
 =?us-ascii?Q?1nwWTSj9WdZPJe0Zy6/7K0rIw/rE8Zi3j4tuq/+JeMzHfDPt2jI48j+yCzBv?=
 =?us-ascii?Q?XAX/GHo2ViFrWks80PXzQ6EWakv28z35xMAnLIIDPuoI1sIBx0CHsbcbpMlO?=
 =?us-ascii?Q?32Vk/W1GCpnmx1DvEcADx0m4DjLQ4W7exuUtbq54w9M8+MB1I4ByGmQe7p/T?=
 =?us-ascii?Q?x+HLKxc9tNfuiNSYvceMgSyIQePYXEW6QBZdM/6lExTMOgthqe2Cdb/fDVK7?=
 =?us-ascii?Q?/AVJhS0gzY6ffv1w/LV0VHw0RmpiPrVzlvEPlL9PRwi6e+HoeUCErs2/vFHn?=
 =?us-ascii?Q?lp4UkK6yERCY+ZkVsLwieW1W9+G58nqJ4q7eXE7FYerSQXBqH1FBIROdagAJ?=
 =?us-ascii?Q?xSo5xQsYOKiH7X/yy1iTOOAZiEy8F7whgOUg5Qu5CoZh+CQSn+IK9GhevAIL?=
 =?us-ascii?Q?hXBvt77PgFwf7VRqlxONBjs0AHn2NhVMKaqoR2xr6FmRuvIl0O0k11rzoABB?=
 =?us-ascii?Q?7PuPWl6lalQ0vcLZMbnRfaBlSpyppbqsID6Cvt6m9HV25REks7uKwbsI3ePE?=
 =?us-ascii?Q?dAxLqVyq9tKZx3D9QFjckZpHrCUcxPXe8jpd1IEw4Xju9D5bffJm0xzRWXH3?=
 =?us-ascii?Q?i8cj4KnEc5G/bOr+nU5vTDA21acojc5yJWdGzBizGOezzDIHB5XqHUsjuH61?=
 =?us-ascii?Q?h45VPorG/bqlVn6uU09SlKgd3qEWu4x8ySwhrgkrOmlwNN/YkuvcOQ9Cj/uz?=
 =?us-ascii?Q?e9W7WtexdLlfEJXrwCu5Z/I3TkVRv44jKfErzUYDCqlhGW436qC0IMlAWnXS?=
 =?us-ascii?Q?PFnvkH8oRhfH+DljuSPWJcrkvz1f2FxaiU1JKYTY81xsMu3R6pw1rpAy4pzg?=
 =?us-ascii?Q?jLHYTZSQc7llf3ySnfBvXCIOUv4ve+yzttksZi8ghOSEpZYDLJ5/pMSuz+bN?=
 =?us-ascii?Q?L7G8ILb1WtL6pNNNqgVvrS3hLjG9c7m1tv8RsKFdgf2sZq+x+kEXE+G8qKvY?=
 =?us-ascii?Q?+GL3qe0ldgufu7FmgacfGIhzeU5u+yfC+CZHziw022ebFSzfrBmRigxb7xtW?=
 =?us-ascii?Q?b+SpizxD4LffwGYqmXss0S9K+IeC0K0ov/mrO1UXUTTcPKk20qTntA1mIX7r?=
 =?us-ascii?Q?1QRWa/vWaud03TBVQlHHsCKn2BtUW5Lv6dlCGxyjrqLdrjp7w6PldbrUQRHK?=
 =?us-ascii?Q?ow0qY3M/ykbV65PuxKNOIabzMxGCUM35Av4EEDHUSDRidwBUFSGh4sFgmmEB?=
 =?us-ascii?Q?iN2BZ6483mWVy68wilB3tuqq9YmNj57DbWumt3IambM7ByYW9jWHKvX49G3W?=
 =?us-ascii?Q?2HLRBeqTRPNPnbl6umDHCwuATRNFUve7+2hiasICPg+iBee86N7SIxtYi4pk?=
 =?us-ascii?Q?x0VK4l7AhimlorlE0NlAOCDg96QsMYAJmaoP2SXwWkud38Jt9ajMDQKbV70U?=
 =?us-ascii?Q?AKl7uQrK5yPQI2Z0I7m3Co1CdRTDROcfjuzRbCgvR4LdtSCaoEL6ZIfIVhkK?=
 =?us-ascii?Q?Nbd4TOc9OLG27mN6jLX1BXfnktur3iQ62eVvtY0x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692365a2-fa28-4e63-5bea-08dd07995a1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 06:22:18.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAptnOMA4hJ9eIlAS0SGUFG8H5VP1uUFguluD2Fh+UCW8mtdy4mHpi2lU/VOpM7ah8yRTFnGajEazJNDQJduNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739

ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
this capability is not defined in register, the rx_csum bit is added to
struct enetc_drvdata to indicate whether the device supports Rx checksum
offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: no changes
v4: no changes
v5: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c       | 14 ++++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 35634c516e26..3137b6ee62d3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 
 	/* TODO: hashing */
 	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
-		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
-
-		skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
-		skb->ip_summed = CHECKSUM_COMPLETE;
+		if (priv->active_offloads & ENETC_F_RXCSUM &&
+		    le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_L4_CSUM_OK) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
+
+			skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
+			skb->ip_summed = CHECKSUM_COMPLETE;
+		}
 	}
 
 	if (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_VLAN) {
@@ -3281,6 +3286,7 @@ static const struct enetc_drvdata enetc_pf_data = {
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
+	.rx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 72fa03dbc2dd..5b65f79e05be 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -234,6 +234,7 @@ enum enetc_errata {
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u8 rx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -341,6 +342,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBV			= BIT(9),
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
+	ENETC_F_RXCSUM			= BIT(12),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7c3285584f8a..4b8fd1879005 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -645,6 +645,8 @@ union enetc_rx_bd {
 #define ENETC_RXBD_LSTATUS(flags)	((flags) << 16)
 #define ENETC_RXBD_FLAG_VLAN	BIT(9)
 #define ENETC_RXBD_FLAG_TSTMP	BIT(10)
+/* UDP and TCP checksum offload, for ENETC 4.1 and later */
+#define ENETC_RXBD_FLAG_L4_CSUM_OK	BIT(12)
 #define ENETC_RXBD_FLAG_TPID	GENMASK(1, 0)
 
 #define ENETC_MAC_ADDR_FILT_CNT	8 /* # of supported entries per port */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 0eecfc833164..91e79582a541 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -119,6 +119,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->priv_flags |= IFF_UNICAST_FLT;
 
+	if (si->drvdata->rx_csum)
+		priv->active_offloads |= ENETC_F_RXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


