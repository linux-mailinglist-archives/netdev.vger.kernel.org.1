Return-Path: <netdev+bounces-100365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0538DAF54
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1AE1F26895
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E7113C80C;
	Mon,  3 Jun 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hcVB04RO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90213BC38
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449848; cv=fail; b=Y8+owi9EL4HizVpcuIkXe2OI/r8JxL0RKRI57wdBVQzSa7SDZrOtOyqSs8PZh2pWy9TC5VfW0zAQqXhZaWW/Xxq8VboOYnBDcFQSQiJLLvFz+LQWeYZ+1K+jV0rhRyr8860QdzmVKRV+AfJnNex7pZBohlq2J9myndhtVdqfXFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449848; c=relaxed/simple;
	bh=P33gs4Q/+X1SvP8bGKF9t4mcy6oTMvryZAfaCZwUsrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqwodUGsHFDzViYoFJGsB8Go25a4R0ZjjABBx1cm47EF0OUOIE+CePeQLopudbVrlYY1QDbP2TsUg5qAhHqJr6inpNeiwfwPUGFj3NOqaCJ2GA+veYlnzAsTK0KNAr/nOX20iejkIY0x7WQEQSXPoMbdrVLNrUslO3YCH+zVixo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hcVB04RO; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bL8FCYODXLByXT9B0cdfGQf6uPDLQqXuxK9u+tLCfKKGHPUryPnoOBabzkHjfDxyEx7QrXkxAytPJzaz9U9+WHFiEz34t/n/jQNtaRdQZKq79b97JWk2dnVwY2W25EsHA/eOlLRW/9Ndm8ItSXBLVMGDK6p3iTxNVKNtphhUwW4r4FfMFODZYBfAg/Ld3DwnvGCkRQf646mUWrnpH3gJ1862snQ8602wyD3Llygy9LxIBZn2IU3XLbSVBaR0VzHgRcyCc+4s1to/1dSTh99S2Ck8mjhqu7n76tNjfYWrQABJk+m4Awc5kCCy3ZHQaanvcUpaWSCeAT+iVKQwAxbvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zj8xI0FSlqns43waDG5l94hPriKjOpGbw6abQ3uy0JE=;
 b=GZYE7Ec2IrQLtmAHnDcdJMLBR9rM+cz++SxjpBRAQjHxC3eO4uE2QO4Se9m31SEfRLajReVdQlEGFAgw/89qY0or6dYJYHH51gReNZUFfqospbZc+JicFdvyMSyY4tVCCiT04t6KSs8Sn0tMLZOMDF9rSQ1I6SmoSdI+CLjs72LVslsD6t1h/vN2zsgTNP/JAO9uUf0F7i1KpxBr0PrZEVXMjSRPJgPMck+A1PojH8nOz2v+tHeTPGq/ckME0y9q//+UF6wAvo0eW8E1XYHclXlsZ9uHniGUWfopX+FMrFcW5FXWjTKiHJs2Qk02E/7DCxQbnHmr5seZTggp3RYcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj8xI0FSlqns43waDG5l94hPriKjOpGbw6abQ3uy0JE=;
 b=hcVB04RO7EsWDlQKu08ECPubDL32xgDEMp9xz1cDq2GqZv/tRCYq45QhfMslwEIzfp6QMfLGHIoxzTgUIal2dDH7e07dezIkTXChhopZtA7EBAkKCzVXIchnD0wi2mRCTYO48AtGO8PP0dwUUS+puM3MuH/p6q6cNGnAHd7e9znlrnWclWA8B70b9yOPK+Gd8Cd3LbrgBFBRvcmY4CUSYqP8I5ylh56AOIQYYiuwY8nqAZqF9DBZsXN67mTVqm2VPhcS2TwInD2TVeXxulA/KYQSpgm7B1z8/xwR3SGXRghmNqzMxWpxrowp0jZsbGlT+8qzB8SltSyvgb+zhbHfAg==
Received: from MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18) by
 PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Mon, 3 Jun 2024 21:24:04 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::e0) by MW2PR16CA0005.outlook.office365.com
 (2603:10b6:907::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:24:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:56 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 13/14] net/mlx5e: SHAMPO, Re-enable HW-GRO
Date: Tue, 4 Jun 2024 00:22:18 +0300
Message-ID: <20240603212219.1037656-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240603212219.1037656-1-tariqt@nvidia.com>
References: <20240603212219.1037656-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 0937c355-e081-43d9-b1cb-08dc84137e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SwdHDTLn3LtnTawD/UXcXpmzI2ciMLJ2IzAGWZJtxg9TyX7CKdJuOBE69JSp?=
 =?us-ascii?Q?fx7Rv2X+m0/aV7l1lKzmORXeiQPjZm05HL2wjmbTsTHSvcrbM9K92IUM+yIG?=
 =?us-ascii?Q?wna1EIA30vFwuCmJUlPjVU3vLjfCYKgkCD3RgGoAksuRU6cCkZsEBd1PV3fq?=
 =?us-ascii?Q?VgfBuq67C3feflJIKbulUTJrHzt5wG4xUoJMeGLxo8AYcCm3rRgH6r8gmp+1?=
 =?us-ascii?Q?KieRuEkIY+nKbvmbKs4iXLLwNMsMxb8uTDYtDEFyDafAUL/YOeFyd5SAIHQj?=
 =?us-ascii?Q?tgF8DHCi0SvAhTe0pvwrgSDBCI1+jc+3H+fnBXvQMfOaRSXc2sH80gtEJz2+?=
 =?us-ascii?Q?jg5rH21x89R/MXg1D7NKfG+rStKh1Y/355cOlP67wJSq5KAdKBAZF7VYVlhI?=
 =?us-ascii?Q?lpZauRUt84lgdzJV+XESAjqIv9svkwIwdl3H4+kmaHXUD4e7MiBdu88S81wr?=
 =?us-ascii?Q?edRFkrw1aSxW7GstubjWxJBSmuyA3FzGOXm6O0KM/36keQZ/r1cU4JMxP4kh?=
 =?us-ascii?Q?bS2KvOhxj1QOW6CaHKJjBAcvU0czL7SFM0tVMzhQRPt+z6Xnt5EpNCHovv6R?=
 =?us-ascii?Q?1fk/ovi4mYl+b7drtEnfZpRLN6fWK2Nrrxj3dgY0XnxXdy/47n90ocv7vy3E?=
 =?us-ascii?Q?RyZZN+APIuIXRTaAafWD/oSty97WTrRaW3TRDm8zmJUuA7PbuaR5dT/ZrplA?=
 =?us-ascii?Q?FHSBHxvhAHn+fC9xiC/kfcG9EqGdT5IONtDe5fbCpffntyw64iJI/mWxvI6h?=
 =?us-ascii?Q?SuQmA21GE5+UMU987qbYXFAb4Bg+eXmp7IyxOzx2EfVcQn0+yQga8t0TQakW?=
 =?us-ascii?Q?JSzqboGoEu3NN/roR5mNCS6BEuSNh+1GKJscqJKGHl8Qz4gFSklS9YC/MWY4?=
 =?us-ascii?Q?S+iRO3V9y7W6B8M8jDrBtgTpjQQ9kv157rXJQVMjwik1bkPHlw6uMWl9E6OM?=
 =?us-ascii?Q?6nGR7dg+HaUVHbXfHYZVMGFnIIeNPiXKpG0x9TffS+w6Bh1vQ49dep9yMci2?=
 =?us-ascii?Q?4Q7IJUOekAEtADkKMRV//XD1JswBEoetH09x2YEi5tgXDhbXzg/DksqzJ0Hj?=
 =?us-ascii?Q?WDdez6/ddmn552qrstr0gnHGH3sHbKrY5GWJVvFHQ7SPsTalDx3TTGRzKAB1?=
 =?us-ascii?Q?KoBCQWX6a9j7A2VLH0GiueZzowBBne/P5l3LkmObspXyojOtUOvUUVlbu1jx?=
 =?us-ascii?Q?t0vu7AsSVuK2BNc6UMzmZv97DAWflT7d3Pt7MPEHcSfq49NHhA44spqtvGZc?=
 =?us-ascii?Q?SKBkqlV8aFcpPtzdBXnDqQHxS+eDLHHvLgdD0MhxzndRyItLUI8f6aYGWUT6?=
 =?us-ascii?Q?HpWWEmrEKj+Jfafv7t0dH5RpB3Dm0WdQFlk+oZzpQyhIA1GmLNQgVeOni86Z?=
 =?us-ascii?Q?xLFjWxvplkSPQ0hvbV5BB2Rd9wDw?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:24:03.7222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0937c355-e081-43d9-b1cb-08dc84137e43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807

From: Yoray Zack <yorayz@nvidia.com>

Add back HW-GRO to the reported features.

As the current implementation of HW-GRO uses KSMs with a
specific fixed buffer size (256B) to map its headers buffer,
we reported the feature only if the NIC is supporting KSM and
the minimum value for buffer size is below the requested one.

iperf3 bandwidth comparison:
+---------+--------+--------+-----------+
| streams | SW GRO | HW GRO | Unit      |
|---------+--------+--------+-----------|
| 1       | 36     | 42     | Gbits/sec |
| 4       | 34     | 39     | Gbits/sec |
| 8       | 31     | 35     | Gbits/sec |
+---------+--------+--------+-----------+

A downstream patch will add skb fragment coalescing which will improve
performance considerably.

Benchmark details:
VM based setup
CPU: Intel(R) Xeon(R) Platinum 8380 CPU, 24 cores
NIC: ConnectX-7 100GbE
iperf3 and irq running on same CPU over a single receive queue

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 26 +++++++++++++++++++
 include/linux/mlx5/mlx5_ifc.h                 | 16 ++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2a3e0de51f0e..44a64d062e42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -74,6 +74,27 @@
 #include "lib/devcom.h"
 #include "lib/sd.h"
 
+static bool mlx5e_hw_gro_supported(struct mlx5_core_dev *mdev)
+{
+	if (!MLX5_CAP_GEN(mdev, shampo))
+		return false;
+
+	/* Our HW-GRO implementation relies on "KSM Mkey" for
+	 * SHAMPO headers buffer mapping
+	 */
+	if (!MLX5_CAP_GEN(mdev, fixed_buffer_size))
+		return false;
+
+	if (!MLX5_CAP_GEN_2(mdev, min_mkey_log_entity_size_fixed_buffer_valid))
+		return false;
+
+	if (MLX5_CAP_GEN_2(mdev, min_mkey_log_entity_size_fixed_buffer) >
+	    MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE)
+		return false;
+
+	return true;
+}
+
 bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
 					    enum mlx5e_mpwrq_umr_mode umr_mode)
 {
@@ -5331,6 +5352,11 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_STAG_TX;
 
+	if (mlx5e_hw_gro_supported(mdev) &&
+	    mlx5e_check_fragmented_striding_rq_cap(mdev, PAGE_SHIFT,
+						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
+		netdev->hw_features    |= NETIF_F_GRO_HW;
+
 	if (mlx5e_tunnel_any_tx_proto_supported(mdev)) {
 		netdev->hw_enc_features |= NETIF_F_HW_CSUM;
 		netdev->hw_enc_features |= NETIF_F_TSO;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 5df52e15f7d6..17acd0f3ca8e 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1526,8 +1526,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         ts_cqe_to_dest_cqn[0x1];
 	u8         reserved_at_b3[0x6];
 	u8         go_back_n[0x1];
-	u8         shampo[0x1];
-	u8         reserved_at_bb[0x5];
+	u8         reserved_at_ba[0x6];
 
 	u8         max_sgl_for_optimized_performance[0x8];
 	u8         log_max_cq_sz[0x8];
@@ -1744,7 +1743,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_280[0x10];
 	u8         max_wqe_sz_sq[0x10];
 
-	u8         reserved_at_2a0[0x10];
+	u8         reserved_at_2a0[0xb];
+	u8         shampo[0x1];
+	u8         reserved_at_2ac[0x4];
 	u8         max_wqe_sz_rq[0x10];
 
 	u8         max_flow_counter_31_16[0x10];
@@ -2017,7 +2018,8 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   reserved_at_250[0x10];
 
 	u8	   reserved_at_260[0x120];
-	u8	   reserved_at_380[0x10];
+	u8	   reserved_at_380[0xb];
+	u8	   min_mkey_log_entity_size_fixed_buffer[0x5];
 	u8	   ec_vf_vport_base[0x10];
 
 	u8	   reserved_at_3a0[0x10];
@@ -2029,7 +2031,11 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   pcc_ifa2[0x1];
 	u8	   reserved_at_3f1[0xf];
 
-	u8	   reserved_at_400[0x400];
+	u8	   reserved_at_400[0x1];
+	u8	   min_mkey_log_entity_size_fixed_buffer_valid[0x1];
+	u8	   reserved_at_402[0x1e];
+
+	u8	   reserved_at_420[0x3e0];
 };
 
 enum mlx5_ifc_flow_destination_type {
-- 
2.44.0


