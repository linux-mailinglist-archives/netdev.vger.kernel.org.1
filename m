Return-Path: <netdev+bounces-98632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5235C8D1ED5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91AAB224AB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789EF17085C;
	Tue, 28 May 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzM0rPtG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB75170829
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906596; cv=fail; b=ip0Vb71EV7C2cXmf+HF8Kt1OzR1OffNTbwmIeJ1uyBa0yA+vM5FOEulNzuQZICmUr1XoCKeXsHp/88YQLRy++OTyhQ96hWeQlbNdfa9CRgKdQo/numU6xyjv1JhSKcbHn5CxobB/XqirYYHbwVPyULPg1aqVd5b2dYe5zFXTBgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906596; c=relaxed/simple;
	bh=oJNpJMayAKO0d0ELkKS0eGil9awYNl6aE+oc0a5m53A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWi70SaKKvcklJ3euDgAqmZiL7dwjE8rcSDBeHhN1BR1tZmLf4iUUiYqNTYxCcGMjaIGerUz939sFpmXDVln06Bnb1F5aLkeCdk/jBdq810Jor8Yi/3Pd1nXFsGkA7+zeT1R9kIwSNHu2GX1CBzr53Fg9qqMeNPiSfwoJhCp2N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lzM0rPtG; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcMGyAwjhaCt05MhdE40z3oopbklDTiwkkowkAp9qvYv2kgTqcVvCKU/BEH3X2AuhG1OooecZ4YU2tnjv6nTC4sWNPOnSOJsZrYuxh3JJHdLrSFRqoIrZJVm/TS8oOeX5605LiB6/SWLaLUlIBiWU1u8YSyD7uBqyk5hal6IkqqBY57nW//99ltuN7BiRk6VEE5GkZNJrTo/rgyHHgc32eoTw2NV0QGdJuYI/EhTp5h7kwYj/myQDSZOrnwvWgKqSrmz4Ip4OaucfQkDtGn6KXD708OUcONXcD0mC3bP9XUjVyzrioitDeXS7OfjqqMOb4g0MFFDZ/9Y4tICZy1pVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmtYY/oCyQ0LId6zzQDu53s57+h3r7utMoJwcmOToPc=;
 b=IM+NvAAhdZRuK5VpHt6moWRYPN9UhsqGC/UONiXe62gWNBeWuu8NPhGKlNCxj1SE9uqsWzcNIZQbn42aMzAVJlMBN8fcv2CrrPISFKxh2lBkMZ3cpZLV9SowzmIRhGob84gRSN8xiptwLjvLRC29AncO7wVgPzyxFoO7+xHT8SQt0XU/Ep2sOplioBukWAEu9ViFjeyKHnywzYpV8358nDFgXgr2Nr+dAuR5H+NejzeWWiicsyCTiASoLmgwpDlyDTRzKb0HIKYLWPbScArA+3qeF2LcTD9NyyrVhMwgGFv6kLC0A8f+UFJ9ktK3tf92lWBHC7maThLNevdQq2fW4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmtYY/oCyQ0LId6zzQDu53s57+h3r7utMoJwcmOToPc=;
 b=lzM0rPtGnGwkehet19DylykkFyJLMT3SBcBBoqh37l619D4dMSQxTw+u+PfNv4F0r7IjHgWcnSGU9KKlze6TYzgAh+d95rgj3vS7nc5FSLdx+NtgofQ6pNQt9KkNVo5S7b3/MB7iExzycFFbesD2B27Jm2a5IP9qG6/fNBb8pWfWJhnqrLxEJYC1LvXRCyJpBXoC4t0cE2YTSVv4+fzjk/r7vV6pZnvDGo5SslZsu76t7aCyWvfScRRh5ZaGcx0fWMpZUkao6//MH0iLUy6pawp7xB4AERtD27oxNochup+oN4OpFLj1d2LphcMwIXSKqqo6Zzarm5XF51w4pdFuCw==
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Tue, 28 May
 2024 14:29:49 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com (2603:10b6:408:e4::4)
 by BN0PR02CA0014.outlook.office365.com (2603:10b6:408:e4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30 via Frontend Transport; Tue, 28 May 2024 14:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:22 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 09/15] net/mlx5e: SHAMPO, Make GRO counters more precise
Date: Tue, 28 May 2024 17:28:01 +0300
Message-ID: <20240528142807.903965-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528142807.903965-1-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: d1204822-348b-43fe-de91-08dc7f22a05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?okfUJ1V7k8cEaevHmDBoMLp/LryusKybveHlF/bJ8Hak//fZNCjFq0XiS9wJ?=
 =?us-ascii?Q?zTFaEXYrLDJgo7fyIeATJ/EQHvgfyQ/3viacbWT++jb6c5l683ixLAuLdk9l?=
 =?us-ascii?Q?rKniiSvWwKi+CcLL7nNXMl6ySdyWaJm4rY6p7KdKJFA7pGxfusUSyoW+B6kx?=
 =?us-ascii?Q?eDah0ZlB7wsi8eQZdzmevEhqpgG57HnnhByZehpU4wMRg7P9ENkCHgWvPIzI?=
 =?us-ascii?Q?8HkhM301SX9MQou7RE3LERvRq21ceHxe2s/Ty0b/aGagtNxHE6UhC0NN0PMf?=
 =?us-ascii?Q?sCjcOTzoMPGGwJ+mnGqViRz/ONGFs14Uk/g/97rjBCXYes+q858scNB4qamN?=
 =?us-ascii?Q?Mz0d6Jl54AGrUuc6AJL+sX08S4fArubDzfK7Q6ufBe+YtFmTiq5nANyAASqz?=
 =?us-ascii?Q?nNv4XGIdIes2B7u/Z8MR3Cs+6sR+fG9jhZ/j6pX1LG2okmI8+TqHlOBk1ylm?=
 =?us-ascii?Q?cLU2YKJmWp5VjgJlgZElVv6r8JGs5gxygNqtazDLsVUBLpU7QDt/yrP/7lFK?=
 =?us-ascii?Q?TMDACbr3InlJy/yhZrAXCCF7kK+tZMww9SjvDPAIdkXWaN11fRS9v8XCZLVq?=
 =?us-ascii?Q?oEQaA+RMb1/TS/SxSRJD7a1iehxSHTlo+dO10UnmpOWG6X+raJpqP+e90F0T?=
 =?us-ascii?Q?3gzBOLQAUYdZoGPB2jY5uiZ3J6fvxf79JGnDKmW6QK7ggNAXQesKMlayAVF3?=
 =?us-ascii?Q?tG7foNZLX1slSC4w90g/bcLQ9QXtVjLfk5xr4wh3/VgDRpvzCFP05j31Bw6M?=
 =?us-ascii?Q?Pa4B20xcpWcgIWa9w2GJSpTwbIzArfoQNxMiW679GdGZ8Abcf11IVfKCrGXO?=
 =?us-ascii?Q?J7E5VJ61lcpL8E4H40f3fIpXgmAEo/QEEG1iB5kFdEPoDrXsbaEjUBuDaij1?=
 =?us-ascii?Q?Ov3ufhyDWnBvdHjARex5pZ+3xaohRtGOFrdDV3oHNdNngPGlgJqVX+1GqGKO?=
 =?us-ascii?Q?+l2jJoaNqSn4KGq44vV5yh5gzvWp4GDw5Bldn/ziHzEYXkPLN5amvB9uctQu?=
 =?us-ascii?Q?Pv7nCLiCtIIIfQlnbkzOQtFD43sQKvcOJNq2z0OUP8s+cd2bDzT6xVoiDjKp?=
 =?us-ascii?Q?2hCaZ9rtdLhsDXmR9CevVfJm3z4gr27duQAskmivy1BTObnZWWCCAODi+8dr?=
 =?us-ascii?Q?s4GzvtJM2FDa7xmua8teFSIZ0BANmJB6Xd5XiLYdPSCTbMwRtd/zMy5m8hJM?=
 =?us-ascii?Q?tiP0nefR5KOFZr1acgwErVVqEtW0pVkWHyljBqF6w2v/QvIl2ep7gJcDWew7?=
 =?us-ascii?Q?7K6i3Acs7TPIXpJvqbDsJaMlkrm0J/VXpfo9wu6bxgtwNV0pwnlbTyQbR4/K?=
 =?us-ascii?Q?l/rJhaK9Uv8xbAIwXfkEuwbsu7dPA3Ph0gCj3SesHl6pD3HxDw59+WmQLUl1?=
 =?us-ascii?Q?jbEGlvs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:47.3859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1204822-348b-43fe-de91-08dc7f22a05d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991

From: Dragos Tatulea <dtatulea@nvidia.com>

Don't count non GRO packets. A non GRO packet is a packet with
a GRO cb count of 1.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/counters.rst             | 10 ++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c     | 13 ++++++++-----
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index fed821ef9b09..7ed010dbe469 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -189,17 +189,19 @@ the software port.
 
    * - `rx[i]_gro_packets`
      - Number of received packets processed using hardware-accelerated GRO. The
-       number of hardware GRO offloaded packets received on ring i.
+       number of hardware GRO offloaded packets received on ring i. Only true GRO
+       packets are counted: only packets that are in an SKB with a GRO count > 1.
      - Acceleration
 
    * - `rx[i]_gro_bytes`
      - Number of received bytes processed using hardware-accelerated GRO. The
-       number of hardware GRO offloaded bytes received on ring i.
+       number of hardware GRO offloaded bytes received on ring i. Only true GRO
+       packets are counted: only packets that are in an SKB with a GRO count > 1.
      - Acceleration
 
    * - `rx[i]_gro_skbs`
-     - The number of receive SKBs constructed while performing
-       hardware-accelerated GRO.
+     - The number of GRO SKBs constructed from hardware-accelerated GRO. Only SKBs
+       with a GRO count > 1 are counted.
      - Informative
 
    * - `rx[i]_gro_match_packets`
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 3f76c33aada0..79b486d5475d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1596,9 +1596,7 @@ static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
 	struct mlx5e_rq_stats *stats = rq->stats;
 
 	stats->packets++;
-	stats->gro_packets++;
 	stats->bytes += cqe_bcnt;
-	stats->gro_bytes += cqe_bcnt;
 	if (NAPI_GRO_CB(skb)->count != 1)
 		return;
 	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
@@ -2240,14 +2238,19 @@ mlx5e_shampo_flush_skb(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
 {
 	struct sk_buff *skb = rq->hw_gro_data->skb;
 	struct mlx5e_rq_stats *stats = rq->stats;
+	u16 gro_count = NAPI_GRO_CB(skb)->count;
 
-	stats->gro_skbs++;
 	if (likely(skb_shinfo(skb)->nr_frags))
 		mlx5e_shampo_align_fragment(skb, rq->mpwqe.log_stride_sz);
-	if (NAPI_GRO_CB(skb)->count > 1)
+	if (gro_count > 1) {
+		stats->gro_skbs++;
+		stats->gro_packets += gro_count;
+		stats->gro_bytes += skb->data_len + skb_headlen(skb) * gro_count;
+
 		mlx5e_shampo_update_hdr(rq, cqe, match);
-	else
+	} else {
 		skb_shinfo(skb)->gso_size = 0;
+	}
 	napi_gro_receive(rq->cq.napi, skb);
 	rq->hw_gro_data->skb = NULL;
 }
-- 
2.31.1


