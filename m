Return-Path: <netdev+bounces-98639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD438D1EDD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453842842F8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8403417164B;
	Tue, 28 May 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r9uehawX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9317165B
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906609; cv=fail; b=NRU5kKl5yFJiA2jpMPF8u7C02jj1p1/hAfGY1j+x5k9yD8M6Bf46IEd/Y8vRfviLSCAT7Nef+eS21cAyImRp6X85Gbn+dhE88BEVt17+SLSrAqlKixgmTciWvY9CNStONzytxCznFDYZULAKBhx//38tCzh6CHchq7NPY99Ud2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906609; c=relaxed/simple;
	bh=uWwqIYLv+rG22PRchPfy6Li6GxdBO82/K9lsrnKcQ0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fk3wuWOBM/bkFaLSAV9ifilXlZkw5jsdNh34TcqbAbfn/NQ6w/vMl6iCNM0fxpUOq8cEffxt5z1fF04bd8cO7bdS6C4vVO2LQ4fTulEjHT6o7rU1hkIolvPrZ4wWOZkP11JMJfs5ORkcLm+UPli2ZVfDA+E0eYEs3p3+z46lc1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r9uehawX; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP74ZJMYgyYOQ/LXPhxrWMFL84sO6mCfVk9U/yK2uUPAZ5AjxQie7h/ZXngNKESazX54eZf+PLNEtqqX6s/2nDAImEOTJvH0Ucypze+yBYxzo6oOE9lyIhi0nXBE2wPiWIQi0MClCgnWEO10eRbWplR3eP0judk/VOR5jqPv4GC8eXqMvrs6dGprgGMpR4Em+Gixv9o6bcxmyR3a28o+dldyRsHxWqaERaOP4ysUdkvyH5uoYMZuYC6XiH9ze5ujZqT/QR+y47XU8F4fy8mIsMgR9i+Qtb5xiyMNj2sx8HUX6avQoXCjIoeLTYjAln4gff4RGRURtjFF9ETvCixdfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kO60jm1PYnrg8hUh1dB17ev7nelb6Gfqsr+uoWX7BI=;
 b=IrpLMtje7orhYDGUFVnUdbexROc/v8LA6FDLr+ogdJpi2IDyYWhml5CPo8Sj0Wm76Ek7aFcj/rjE5oUVxMxorREyoZMMX6VRtvr9/f/NXWNrCbLKyhMhtUObAz+0DGMqoPm5D9Cw5W0Jm2CoAesCR+YhmeRzXzgY7OZrvrObJH+yQMZDjkdmM96CI7WbPC1FyDi+YWTlJmjmKur0r3h2nnr4cPwV79xtgOD2kLsTaloCt0O/nHwFVm+gf+fpzJxek+0UTUGTs0mLvrzsi/oVXM+27FRoTZUBSuFFmOwxMvcm8DuN2muaqZZngx53PVAk9GM5quzHQOEkhZtbOzORSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kO60jm1PYnrg8hUh1dB17ev7nelb6Gfqsr+uoWX7BI=;
 b=r9uehawXbjr6UtM0ZbvSr9En+F42TucOqYWOWptm9W9MPUPCFJuDa+RYXGXSHco6xoYBZLFjtyAG/Lcy7rvsFyr9/Bol+YaVV2pGd+Js2im+EXYma/3Cb8TZWgsQITvLbx3wYWDXaNCqfDhALi821AXlnfJPPcdHpB21h+nYQn1skcse/i8Dd74edGhBG2+N76L1PLq/tCb4/3cjIkTvqinoNz8PYC1mUiRkfkwLqDzhLgwWsOIL8mtIEbP9N2k6nkftcm9M7xS7mheiw/+emzpEhfDJ1ct8PEJ89fCcSC8UtDRj3Pb94u0ITf4pyAI7KlDFfxPTj+XBSHlVbAdmtw==
Received: from BN0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:408:e4::32)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 14:30:04 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::88) by BN0PR02CA0027.outlook.office365.com
 (2603:10b6:408:e4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 14:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:30:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:44 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 15/15] net/mlx5e: SHAMPO, Coalesce skb fragments to page size
Date: Tue, 28 May 2024 17:28:07 +0300
Message-ID: <20240528142807.903965-16-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0eb6cd-e30e-4d74-a6d9-08dc7f22aa46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VUIbND5lgQXKFiulLEVJRe/HAC74jM4zgBGBM/Tmi1uKYfPsuYX/HLdE0ldz?=
 =?us-ascii?Q?GyvdNmbHh01tAzu7mE95nXfJ2ogIqrAU3yZQJIRN1zuxjjWvVZPH4Dp24i/z?=
 =?us-ascii?Q?sNwbfl78gfpdDVoDPBh+ALth0cDFEwX+kjWECiEAIOSn75uy9pF55EOJ2Sju?=
 =?us-ascii?Q?YNhEWH7gfnXL6e7UAJEtzF3lvj9hzbOtowEPHgLaLUGfzOJwlLBi6BbRtLUP?=
 =?us-ascii?Q?QUV7X8Hjvc6dHyhs9OLRUB/UiCTD8944c8gEIu0F6E7D4rlEZmIVfHs0NuTy?=
 =?us-ascii?Q?j4f2JuZpq7UBKNWmvjF+Y/lv+0eERy7QNRmDNpf8N8AvlYmzs3jqYrrP4tyc?=
 =?us-ascii?Q?Ty9u/EIv/Sdg/Ya0nmBbqCvifTmaB7GSFyF0viP+hMIPRqTbX3U3ybdXgNXC?=
 =?us-ascii?Q?tzIWfqYrZgFVxmj8rGkYl7uWhmWuhlwY1sZ8mmJJoP6wFEip896BOTdjRiE+?=
 =?us-ascii?Q?4Njk8mFFZouDizd2TWuUVDfsZhU6HTNqV3rEpOhDTn2sh+JxqXs22s3m8IQh?=
 =?us-ascii?Q?oGQgJzov9+uXt1fD5xofKppMTYqPClCl7SBhW8/pUawk68mDddkFRJXQNalx?=
 =?us-ascii?Q?+EBQekQbyBsZmDTo572XQDGfuL9mCNJnsfm1Ov8ugS8JvfSvV7HoR3OHvPTc?=
 =?us-ascii?Q?fLvSV4Och9EpM4lzde8mlpCot0/QUZINJ4ETllvktAwNyNG89qO4RXczqo+Z?=
 =?us-ascii?Q?57EnzlQsDpghrORU5+2IrMquvySGzA0TNadMZJVOlcevX/hvu9Ea0CLpxAfZ?=
 =?us-ascii?Q?HsDMn2DDc6Kf67hstJ9mFVT2JSiFb0I6IZiJBWVVWtrCapU/8tKACo+pgLUf?=
 =?us-ascii?Q?lUSk6EOlZnZlip9wpn4ZC0hUvgFEoYkO8FxJ2OqrRI8NrEDFFhcZga76bfMR?=
 =?us-ascii?Q?BaaxaEVqpJOS0PHdpOXvWEqDS47La9OofDJI4bv6+rQbHcTZjg2z+lNnrjod?=
 =?us-ascii?Q?tEvZKyqUTII+8yEBy0ERoKlmoqpQlufOmX9wZgW286lJ1le7dvP+P0b201+Z?=
 =?us-ascii?Q?Egt0VeZVrALO6VrRJ0k7+eWYunsnNFv64sVvpkBpGQ4NnbMNrJRrlMQwVqJc?=
 =?us-ascii?Q?I4xfp+KhMJ8NI9VkZsHcDTFUJ+Fa6JKvE4QqdX+YaZkfTZg8+O3FLGJuyJUA?=
 =?us-ascii?Q?wRKHoiPDVX3vtAN5wiWJahPiG0om7nN3i2z5o1x3qB4r5nkVw7kJ9A02onXk?=
 =?us-ascii?Q?JT1XNL18g9+N8rOE0L6A5QQmcA4pkjcL6oGPPJIWLI62CQgLcHbVNrbrlPVu?=
 =?us-ascii?Q?/a7sEq+3pG5prvlTX6ccB6Sre5BlE02snxqprsO/zsQdhI6QOALI3a38yK42?=
 =?us-ascii?Q?uPVeIN5HnfeyOkcWJ7Y1st1lcjAf4+k8FxoeFLCyETGMfJyn3q+6O3u74c4d?=
 =?us-ascii?Q?J8FuJz8kIMYWQg7YfwB2HxvKh4dp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:30:04.0265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0eb6cd-e30e-4d74-a6d9-08dc7f22aa46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316

From: Dragos Tatulea <dtatulea@nvidia.com>

When doing hardware GRO (SHAMPO), the driver puts each data payload of a
packet from the wire into one skb fragment. TCP Zero-Copy expects page
sized skb fragments to be able to do it's page-flipping magic. With the
current way of arranging fragments by the driver, only specific MTUs
(page sized multiple + header size) will yield such page sized fragments
in a high percentage.

This change improves payload arrangement in the skb for hardware GRO by
coalescing payloads into a single skb fragment when possible.

To demonstrate the fix, running tcp_mmap with a MTU of 1500 yields:
- Before:  0 % bytes mmap'ed
- After : 81 % bytes mmap'ed

More importantly, coalescing considerably improves the HW GRO performance.
Here are the results for a iperf3 bandwidth benchmark:
+---------+--------+--------+------------------------+-----------+
| streams | SW GRO | HW GRO | HW GRO with coalescing | Unit      |
|---------+--------+--------+------------------------+-----------|
| 1       | 36     | 42     | 57                     | Gbits/sec |
| 4       | 34     | 39     | 50                     | Gbits/sec |
| 8       | 31     | 35     | 43                     | Gbits/sec |
+---------+--------+--------+------------------------+-----------+

Benchmark details:
VM based setup
CPU: Intel(R) Xeon(R) Platinum 8380 CPU, 24 cores
NIC: ConnectX-7 100GbE
iperf3 and irq running on same CPU over a single receive queue

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index e6987bd467d7..54edeb8c652e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -523,15 +523,23 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 
 static inline void
 mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
-		   struct page *page, u32 frag_offset, u32 len,
+		   struct mlx5e_frag_page *frag_page,
+		   u32 frag_offset, u32 len,
 		   unsigned int truesize)
 {
-	dma_addr_t addr = page_pool_get_dma_addr(page);
+	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	u8 next_frag = skb_shinfo(skb)->nr_frags;
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
 				rq->buff.map_dir);
-	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-			page, frag_offset, len, truesize);
+
+	if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset)) {
+		skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
+	} else {
+		frag_page->frags++;
+		skb_add_rx_frag(skb, next_frag, frag_page->page,
+				frag_offset, len, truesize);
+	}
 }
 
 static inline void
@@ -1956,8 +1964,7 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - data_offset, data_bcnt);
 		unsigned int truesize = pg_consumed_bytes;
 
-		frag_page->frags++;
-		mlx5e_add_skb_frag(rq, skb, frag_page->page, data_offset,
+		mlx5e_add_skb_frag(rq, skb, frag_page, data_offset,
 				   pg_consumed_bytes, truesize);
 
 		data_bcnt -= pg_consumed_bytes;
-- 
2.31.1


