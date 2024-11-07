Return-Path: <netdev+bounces-143039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E759C0F3C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F65DB22647
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF8E216A20;
	Thu,  7 Nov 2024 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YEXsZ0KN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4D7E782
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008749; cv=fail; b=FHiKtmIMUv9cQyuETevTDxhATCYN8oHsatTXwC6EY7tAgsrwZrs4KT+mEwM3czRDNmgoe90wOyA6F8qO+S2Wo2eR1MYIWsjtWBws9ydwY19tfOAsPsTHfoDw+LgDL0zlHaA2opFSlYSuWnemhliHB97iFDDH2uMy5m11Zhi1U3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008749; c=relaxed/simple;
	bh=VwjpZtJLTTcDj6QyQJZMTNKuQviHKVT0mo2LERR5QPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTTJKuUGjcWFJFz8K9ujOJYEjTya6UWbA29eRS68D+Syk23S5RLV7G/pol4ZjourSsGQLeC4KWKd44AN0yz+A9yWKCLpUfez+IGS0kYGKZRE3DGxkNH3LlOykhCCWx8g52TW+orb0yhxn9aS1MxPtwVIO59Yu5zwmc6TyLZf2M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YEXsZ0KN; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on6Y6CP7aDKOUCyVngOXkeHQ9zzHko/QSQmFf7Tn6saKk++U5Gz/Cwvw9RBkvR2RG1xpO3mHA24r8TPjjql3cXEsqjLoXx4JymIgxhxF9JcFOupNyoKvd0IZDwyCIe8+6ZiqWmsGjtickMS00t/9z96FguL7HU9Bp2wxUU+XL5nNqw1TETAwpJyysJx6K+jnadIUchPxh/ATcfCL5m2osfkiY3K15lxFEz+i6Kj7djNU5Etw+GHfhEDoN5yEOjPXNWjOZCj46UrDH1bA0vU8WcY4WyRf4lSqs1mRkVuuyNCpsCQe9OS83vjg5/4CE60IbEimATbgrB20DSs6WBKX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaOfMqMUhECreXoQENGXNP8i7MzGTL+Gni2FqI1RND4=;
 b=m3ux7RHDyBNAbLm469Fn9QBIePcX4hbn4c8/j3cMrac5d3NaxRMPYMCEeTZmp/puv7MTXvxAytZvmsa9QaP+V3JVUYmwPTrT0kheNPSj66isUlVuX93eA2cLElklkvADKKxjpU9Me8XM2kx6mJMea+W9wpG6DYUHwagFPaQhGwauJhyy3jSFQAJARHCCtymepF8frjZNoKEzI19EMaLtexrh4mj5pYiebfo4jd5N8VRekass+vAshqbJr1oglzwOJ6mAZC2VMznRH+8HFxycGdWqMZelqt9H1g3q2PDVbw9ItPdQJkOUS/vODPaQfWkAdBO3gUWmGIUemFaAeeVR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaOfMqMUhECreXoQENGXNP8i7MzGTL+Gni2FqI1RND4=;
 b=YEXsZ0KNwNAJJBQ+dkqJk2bukSpbYu0ySVyMyKKpL2iCbSOwnHRGiYJOwASNL48XHM8/+3qQdYxENSVIWf+Bytlt+aGM9zPtV0c0fkKMS1oIkzKbsoOPv76B95pbNVruKavGYF+kWHKIcGXeQP4Yifp2N2469Kq8PPq3HpOiSTZyG1hVQIg9noo5FznI+QgXg0dxgyVP6s707TmhTtNIs0Rc1UYg1dfP3dCZ3eKT0oK+Pv1mCPnMPV5IDuByQQ5CIEn6Kycj0+omjjA1UL4eTD/yRlV/vAgfK7D6K9XohOJdiUZoc/kxEvLDaOT4/gQ5CIiAqAi2TKy6A0Nh7h0UfA==
Received: from SJ0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:a03:3a1::18)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:45:43 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::4a) by SJ0PR03CA0373.outlook.office365.com
 (2603:10b6:a03:3a1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:45:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:21 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:21 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:45:18 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 08/12] net/mlx5e: SHAMPO, Simplify UMR allocation for headers
Date: Thu, 7 Nov 2024 21:43:53 +0200
Message-ID: <20241107194357.683732-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107194357.683732-1-tariqt@nvidia.com>
References: <20241107194357.683732-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed324ad-061a-4bc4-ac6b-08dcff64c42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8bRkFubldjk2Fd4CxwvHrp+BBYFgURH0I3PjCpdYN47VQFNyQlFNX1emFTAP?=
 =?us-ascii?Q?bOM7mMoufB4JsJGHUqCHmAPth0TwcnM2xk7kZRQmr3G8IkeY0SqE/ELiTk6b?=
 =?us-ascii?Q?G2LKFghoZqDCn8a68y9n0Pthl3u020FaWAfisz9WOzzcOtcGRIUCmUtB1kPY?=
 =?us-ascii?Q?ylPF5GQtLY8X/KcDALEDvauTUYhF5TfEv5DzUEcbUEi0brxNjAOcbymLuwcX?=
 =?us-ascii?Q?1wYOXwoXCfFH39NvPaYmypIBjIWg6oFIRmWN1pqfzC75SCo38sIgoDt95KWg?=
 =?us-ascii?Q?uokoRFEwqySvcaYjAhmUxPF/mRB2c0qBAPKnspPIJzwgSBURB5+j6aQDGw7K?=
 =?us-ascii?Q?AOMDKdG4h/nJkNcYVqc75FbOjPDUFOMkTT3lmsk5EDGaKS4hL9B5Gm/+rRx6?=
 =?us-ascii?Q?1b7w+SSbyrDv/m6+C4nMWa2FDWmjijDGDIORHXkeR8bHenQjvHOc6lmbz7VV?=
 =?us-ascii?Q?Ugx1xqTNqiBQxpNbGWGpZhPbJECRjKP4Oz/sIhwLPnpKZ85q8xyI75o1epdC?=
 =?us-ascii?Q?ArlZijloHubjivltEtM0NqsNCzlxwZgtQo36Pdq0zmKYSSn99HvKN+lNtkG1?=
 =?us-ascii?Q?XJFUMh/w28kx++rdMwZL2hH8QnjxwnfStKfbistkgT2Q2K3WhCLqro0tKns2?=
 =?us-ascii?Q?avqh7mEgk8Suzm2yLbIbFcFToV6ZFTxl8zQ1zTwuDkzMW8GiCU5PD0bduExG?=
 =?us-ascii?Q?rQTB8Yecj8Eel3CO8W6C0t55fXOTPLBcj9onGlEeLU3RhJMIEfWzYWaWGdfD?=
 =?us-ascii?Q?W/6lndu0hpURpSgXnb1t2VYKgRF/Tckr2tn8mr9SLFviNVa274wkov55sYnx?=
 =?us-ascii?Q?gi4kwEw9+s+hFSQzwDQGwoaQ9WVQAUdRyTjRmnPZgiNsJ+HajzgkYAKN2Uh0?=
 =?us-ascii?Q?X3Yr/RrFaMvTQTOSVjeqgsZfsi082lSjjjqZ46Ad0t8/tCiooHO6Wv220/Pn?=
 =?us-ascii?Q?kY3x/K/pujptiz6g8LSWfnxGRVh3adrHYjL35zoL9zplK0QS3XrTbGjldZYs?=
 =?us-ascii?Q?8OdhuZMN5qGWem1mECz3oyRhGrImuBAoYMYALgE9rVCqvFuc98DtIlYSJE2F?=
 =?us-ascii?Q?CARd6A+XRJEVS7w3mbaZnnyWjmK9F1EQGUxAQZLREeqz/0gQ4wSm17TFtZi7?=
 =?us-ascii?Q?Cb1Ef8j9AZBhkwuRUOz5vgdjsB80qk/mFNeTZwIKOczFX48qvFQ3spJ6PdxA?=
 =?us-ascii?Q?LcEhhZ6D/JYo3BA0l3i+xWTbfnJ+R3VgDlTLdY/Celu6Xs/Th7FlEBZgDWrQ?=
 =?us-ascii?Q?0oiVa/J3eYD5H9rb9dlji9/Rc9ahgEXro904GypH61XdD3Fh36HYcYlV3SNe?=
 =?us-ascii?Q?GHJs1gdQXHQbFSwU8sf9yfaEQImf5vHVo+59c2oUBP1kQOOOiQsH5tKSaPmH?=
 =?us-ascii?Q?wwze02lvPOIqblJQ9nL1BRrzryuoWH0YMtFgrzseZ7nX2Y+vwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:43.2101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed324ad-061a-4bc4-ac6b-08dcff64c42f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040

From: Dragos Tatulea <dtatulea@nvidia.com>

Allocating page fragments for header data split is currently
more complicated than it should be. That's because the number
of KSM entries allocated is not aligned to the number of headers
per page. This leads to having leftovers in the next allocation
which require additional accounting and needlessly complicated
code.

This patch aligns (down) the number of KSM entries in the
UMR WQE to the number of headers per page by:

1) Aligning the max number of entries allocated per UMR WQE
   (max_ksm_entries) to MLX5E_SHAMPO_WQ_HEADER_PER_PAGE.

2) Aligning the total number of free headers to
   MLX5E_SHAMPO_WQ_HEADER_PER_PAGE.

... and then it drops the extra accounting code from
mlx5e_build_shampo_hd_umr().

Although the number of entries allocated per UMR WQE is slightly
smaller due to aligning down, no performance impact was observed.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 -
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 29 ++++++++-----------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 58f3df784ded..4449a57ba5b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -633,7 +633,6 @@ struct mlx5e_shampo_hd {
 	u16 pi;
 	u16 ci;
 	__be32 key;
-	u64 last_addr;
 };
 
 struct mlx5e_hw_gro_data {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index d81083f4f316..e044e5d11f05 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -648,30 +648,26 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 				     u16 ksm_entries, u16 index)
 {
 	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	u16 entries, pi, header_offset, err, wqe_bbs, new_entries;
+	u16 pi, header_offset, err, wqe_bbs;
 	u32 lkey = rq->mdev->mlx5e_res.hw_objs.mkey;
 	u16 page_index = shampo->curr_page_index;
 	struct mlx5e_frag_page *frag_page;
-	u64 addr = shampo->last_addr;
 	struct mlx5e_dma_info *dma_info;
 	struct mlx5e_umr_wqe *umr_wqe;
 	int headroom, i;
+	u64 addr = 0;
 
 	headroom = rq->buff.headroom;
-	new_entries = ksm_entries - (shampo->pi & (MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT - 1));
-	entries = ALIGN(ksm_entries, MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT);
-	wqe_bbs = MLX5E_KSM_UMR_WQEBBS(entries);
+	wqe_bbs = MLX5E_KSM_UMR_WQEBBS(ksm_entries);
 	pi = mlx5e_icosq_get_next_pi(sq, wqe_bbs);
 	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
-	build_ksm_umr(sq, umr_wqe, shampo->key, index, entries);
+	build_ksm_umr(sq, umr_wqe, shampo->key, index, ksm_entries);
 
 	frag_page = &shampo->pages[page_index];
 
-	for (i = 0; i < entries; i++, index++) {
+	WARN_ON_ONCE(ksm_entries & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1));
+	for (i = 0; i < ksm_entries; i++, index++) {
 		dma_info = &shampo->info[index];
-		if (i >= ksm_entries || (index < shampo->pi && shampo->pi - index <
-					 MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT))
-			goto update_ksm;
 		header_offset = (index & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) <<
 			MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
 		if (!(header_offset & (PAGE_SIZE - 1))) {
@@ -691,7 +687,6 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 			dma_info->frag_page = frag_page;
 		}
 
-update_ksm:
 		umr_wqe->inline_ksms[i] = (struct mlx5_ksm) {
 			.key = cpu_to_be32(lkey),
 			.va  = cpu_to_be64(dma_info->addr + headroom),
@@ -701,12 +696,11 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
 		.wqe_type	= MLX5E_ICOSQ_WQE_SHAMPO_HD_UMR,
 		.num_wqebbs	= wqe_bbs,
-		.shampo.len	= new_entries,
+		.shampo.len	= ksm_entries,
 	};
 
-	shampo->pi = (shampo->pi + new_entries) & (shampo->hd_per_wq - 1);
+	shampo->pi = (shampo->pi + ksm_entries) & (shampo->hd_per_wq - 1);
 	shampo->curr_page_index = page_index;
-	shampo->last_addr = addr;
 	sq->pc += wqe_bbs;
 	sq->doorbell_cseg = &umr_wqe->ctrl;
 
@@ -731,7 +725,8 @@ static int mlx5e_alloc_rx_hd_mpwqe(struct mlx5e_rq *rq)
 	struct mlx5e_icosq *sq = rq->icosq;
 	int i, err, max_ksm_entries, len;
 
-	max_ksm_entries = MLX5E_MAX_KSM_PER_WQE(rq->mdev);
+	max_ksm_entries = ALIGN_DOWN(MLX5E_MAX_KSM_PER_WQE(rq->mdev),
+				     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE);
 	ksm_entries = bitmap_find_window(shampo->bitmap,
 					 shampo->hd_per_wqe,
 					 shampo->hd_per_wq, shampo->pi);
@@ -739,8 +734,8 @@ static int mlx5e_alloc_rx_hd_mpwqe(struct mlx5e_rq *rq)
 	if (!ksm_entries)
 		return 0;
 
-	ksm_entries += (shampo->pi & (MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT - 1));
-	index = ALIGN_DOWN(shampo->pi, MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT);
+	/* pi is aligned to MLX5E_SHAMPO_WQ_HEADER_PER_PAGE */
+	index = shampo->pi;
 	entries_before = shampo->hd_per_wq - index;
 
 	if (unlikely(entries_before < ksm_entries))
-- 
2.44.0


