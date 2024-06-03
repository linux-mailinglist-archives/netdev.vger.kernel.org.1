Return-Path: <netdev+bounces-100364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B48DAF53
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B71F2682B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF713BC39;
	Mon,  3 Jun 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GA2+DodM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEDD13C68E
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449846; cv=fail; b=SgsTIBnEDgJaVO9sr3zaKN1ZRK7ZlzQRCBma79qATpK0JNnEXPsucYp2pVH3xza/bmdUjfVFakEAsIYlgRCCIkvNRg9qEaanwf9gjYtC0uENRA+1/kfcVT2O7W9RLa9vFevGkqhdKWGX/Y82kK4HQo6R4+81jwK5CIPhLki/rL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449846; c=relaxed/simple;
	bh=LbSZ4Nn8VkIv0WEi3Kbv02IDSh+wLXTOWd+MXP+wV+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGc/q/RNU6h3Ddsq7UBBOBrFRqoGmMRProeABFzuAYueZT3KVcyNjB3e1fwuRMpOh+0iySMpjEZqhqsSAAEDIvPQ74POeVBsbJfyyaT6pFMiDFHOoeXUJGAeSNjZsEUdIueLhTHnuTzTXSdrVeJ+GL2Uunmp7zwezsU0cPlZGBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GA2+DodM; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioKgM+wNPfnmRVgrRMd8+5aXfikOiJDqv1HCB8DeHinWlNnCnqQXOuP5VzquHv3Z2YU9MFJbVLRfPEBKhiIjCKkigtj/87uBJksp0JslUUI8gSsEu4yf4dbuc0Y6m4yzLqHbLLZKEj0XXPqFDk02tpOeSY5mei9mgDRufXx6okt2eOkO8+SVDgSrD4nL+sgt6YX+4AuW3GcCxqCcyBCN40sGmYD5SMgjBAvXyavgv+LG6+TS2AqUjXZzKiC8HC+XDvKhNd+A7dCJBfWL9IGmqOcqsz7+jezMjPY6Lv5p5Q4sN0BDLqaAhCG3FsWuYQ2ODHDjfZNFzG6R5N4JgTZiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgYzK6sBKKl4i/xQPr6oi7+1RrdMF8OwB0W8bq7t/so=;
 b=UWtZWPMOYB9NWSu98B0wGfAaa3mLwfvt1jPDotRwKmeWvS888sYHyWujnV+9P2umjFZLfg/C28PDIldzESRfJCnU2pxz5kSPE8UjG8FGvz/FinAlPOt7ck8PDRaOiQY43H780789dUjGT929oxVIZg8kxl1+Y+IrA+Nk8LywLciS444gkfFOv/nG+53w5G86gf7GVTeJ8MKfyr5B8wTyRoRGFFJOiVp0ULdLSO6iDNADDh+I9vUWV4zvCmSrXLe/6ZRe+nxKjwp+IFYSFWKU9PyL8ehzWMNGt/r1zg7FW8VVfp9Q9R2r6mMw0zAvOW85eJDNXW/LpJtfiCcrupDFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgYzK6sBKKl4i/xQPr6oi7+1RrdMF8OwB0W8bq7t/so=;
 b=GA2+DodMg3jxEHmEgilt3sqX83vTWfdQ/h5wHD+J7LX9KKGTSWsn3mVewkmNyA0GHN6kKARP8a3ScUD4tCxPlJEblttsob6VNFjS/4FthBlaJ1zRJg0qYPLGYqZGJWCeD9R/k7jB0FcwcpOTrHKeOz+q2S1KMf8e9zhoDL7wEJrIwhu3yAO9sPp0CftR9doAStisv8XIp5gxIjsKf0r76rCKZ2r2D/HI4fWj7lySe7Gn7gZmbM7CzqxmIKaSatPXC/LALp2Z6WAiBzG26ALiO8yvLR60wU/o5pJZdkJtR9E1FGmWnspoHR7Hs9JN7+D/MWRcTED+xn2ZSPF+ul8TRQ==
Received: from MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38) by
 DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Mon, 3 Jun 2024 21:24:01 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::b0) by MW2PR16CA0025.outlook.office365.com
 (2603:10b6:907::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:24:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:53 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 12/14] net/mlx5e: SHAMPO, Use KSMs instead of KLMs
Date: Tue, 4 Jun 2024 00:22:17 +0300
Message-ID: <20240603212219.1037656-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 09691c02-4555-4c40-868f-08dc84137cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RvPdXweb2VIYeiZTdOHFFE/7w4y/igORmIxjvf78nAwbA7d+Gk4DeK7wUKjO?=
 =?us-ascii?Q?5gCDsLG2NtXMrbWb5Kro0LXm1V0RH5a/iHuI3n+8N3wCAvemTBSwwEx15Bnc?=
 =?us-ascii?Q?2PhO6vtrW+fyxeM5Pdq57unkvJjYqcaz1ALK5ib75TejagftYv/OVQ85Pzsx?=
 =?us-ascii?Q?8A2O5T0sC6BGTc6Yldg+7ajp8bWieVgBiqD/uNZ7wUvULHHrFdM2PbvTcv9f?=
 =?us-ascii?Q?9p6Oxgd3LA3S1mHhMtctlptp7WJEwRzhFRTfI3U0Jk8nHsdGabQKAqWhoTYf?=
 =?us-ascii?Q?RFM/VxBSnvSruYL1upLiVTaSMk+KU/g+B/qAQB+C+8CAOgxvOchI0PPa9RBK?=
 =?us-ascii?Q?dHU3g+8zg2ZK+KNiCr0UXTnAdnQbVVY5lMqE7fK39gneYAUIdSyaxmxaD82N?=
 =?us-ascii?Q?stnMBVc8CXj8todhKjGjoG9l1j5QMF4unICFXZ7fLzNnu/ElD/pRE4jyH6xS?=
 =?us-ascii?Q?NUxygLrDuNlDRzL9+zSzGctngeSIR3RUI2uwNt10nW1U0Auj3uM2FTEvUYwC?=
 =?us-ascii?Q?EBLTZNVUIy7Ln21V09w1e+vM3pu5rMnqiq0W11DM9bvWeKM/DeIo9qh5kOBy?=
 =?us-ascii?Q?Y23tCjwQ+VoZLxYvjWTU0QfNOSFxpkuKvC8ESHg6JGNCVuCF5Cshvk8cNk7M?=
 =?us-ascii?Q?jFKM4U5S5MCPz2zCjy+zVQ2J9W6tyn6YnFpo2MzqfjGr6oelgyiunK/IiF5H?=
 =?us-ascii?Q?LXgQubC7bxr/avzg5fRv97XKJLkmnl7JCF8XQ5p6tH4nPNicrKlGAxfT7FL+?=
 =?us-ascii?Q?VKVgTkj81nhmcuGbkceFWh4GxRIgZZ0TKCr4GjS0qq43U3wVxQ9vRVoziAZ1?=
 =?us-ascii?Q?fowlzdxjSoj6DiMb05NB/R1d27lxJOioezjgToHXeJaLeti7XE28Y04DcRSs?=
 =?us-ascii?Q?fcMYOHwxMMZMN1Zom05/D+3REK/Gyo55iNTIiMGcg8/loEooNn+BoPmJNf+D?=
 =?us-ascii?Q?IV/yYUjm/iC9udrE0oadvIiuPK8G0ET9SHs2ZFGhrCyBVMl1vF3vFrxLaJA9?=
 =?us-ascii?Q?KyXUiq9PC8qviOvLRexQ8guGxesA8V6DmI8ix3XaIWUi7yJJiqAQt+A2/fps?=
 =?us-ascii?Q?iq5pnTCjrbZb10cEt8hcSG1hkDnQwxnMxFYqQ6uAdScF/Ady7pPfe/PWcW1C?=
 =?us-ascii?Q?qa+GpzrO0O41CGhn9sObf38QcuO55z8JO3lQpdcbV/faRkBe72ESdssvPkbs?=
 =?us-ascii?Q?DchSFjpTIXgufp3GIVZDRNwJXFOHWYXtAYIFAiRqBP/E76fXcLr4LRIkZRy7?=
 =?us-ascii?Q?TKgFZkBtCiIJnEwRJoXPBik5LlDMIoTvvA9Gdykme6Al7sw0C0j5P3PvoyBv?=
 =?us-ascii?Q?+Fjq93DlBmpvfrz4JLZSKSd0MqWmcGmXa1uYKPq8Zn2IjoOi9Gk/3rmsbr4v?=
 =?us-ascii?Q?0i1ssJdqJN4xwmJ24r0+c+IoTe/D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:24:01.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09691c02-4555-4c40-868f-08dc84137cd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695

From: Yoray Zack <yorayz@nvidia.com>

KSM Mkey is KLM Mkey with a fixed buffer size. Due to this fact,
it is a faster mechanism than KLM.

SHAMPO feature used KLMs Mkeys for memory mappings of its headers buffer.
As it used KLMs with the same buffer size for each entry,
we can use KSMs instead.

This commit changes the Mkeys that map the SHAMPO headers buffer
from KLMs to KSMs.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 20 +-----
 .../ethernet/mellanox/mlx5/core/en/params.c   | 12 ++--
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h | 19 ++++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 21 +++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 65 +++++++++----------
 include/linux/mlx5/device.h                   |  1 +
 6 files changed, 71 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index ff326601d4a4..bec784d25d7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -80,6 +80,7 @@ struct page_pool;
 				 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
 #define MLX5E_RX_MAX_HEAD (256)
+#define MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE (8)
 #define MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE (9)
 #define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE (PAGE_SIZE >> MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
 #define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE (64)
@@ -146,25 +147,6 @@ struct page_pool;
 #define MLX5E_TX_XSK_POLL_BUDGET       64
 #define MLX5E_SQ_RECOVER_MIN_INTERVAL  500 /* msecs */
 
-#define MLX5E_KLM_UMR_WQE_SZ(sgl_len)\
-	(sizeof(struct mlx5e_umr_wqe) +\
-	(sizeof(struct mlx5_klm) * (sgl_len)))
-
-#define MLX5E_KLM_UMR_WQEBBS(klm_entries) \
-	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(klm_entries), MLX5_SEND_WQE_BB))
-
-#define MLX5E_KLM_UMR_DS_CNT(klm_entries)\
-	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(klm_entries), MLX5_SEND_WQE_DS))
-
-#define MLX5E_KLM_MAX_ENTRIES_PER_WQE(wqe_size)\
-	(((wqe_size) - sizeof(struct mlx5e_umr_wqe)) / sizeof(struct mlx5_klm))
-
-#define MLX5E_KLM_ENTRIES_PER_WQE(wqe_size)\
-	ALIGN_DOWN(MLX5E_KLM_MAX_ENTRIES_PER_WQE(wqe_size), MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT)
-
-#define MLX5E_MAX_KLM_PER_WQE(mdev) \
-	MLX5E_KLM_ENTRIES_PER_WQE(MLX5_SEND_WQE_BB * mlx5e_get_max_sq_aligned_wqebbs(mdev))
-
 #define mlx5e_state_dereference(priv, p) \
 	rcu_dereference_protected((p), lockdep_is_held(&(priv)->state_lock))
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index ec819dfc98be..6c9ccccca81e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -1071,18 +1071,18 @@ static u32 mlx5e_shampo_icosq_sz(struct mlx5_core_dev *mdev,
 				 struct mlx5e_params *params,
 				 struct mlx5e_rq_param *rq_param)
 {
-	int max_num_of_umr_per_wqe, max_hd_per_wqe, max_klm_per_umr, rest;
+	int max_num_of_umr_per_wqe, max_hd_per_wqe, max_ksm_per_umr, rest;
 	void *wqc = MLX5_ADDR_OF(rqc, rq_param->rqc, wq);
 	int wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
 	u32 wqebbs;
 
-	max_klm_per_umr = MLX5E_MAX_KLM_PER_WQE(mdev);
+	max_ksm_per_umr = MLX5E_MAX_KSM_PER_WQE(mdev);
 	max_hd_per_wqe = mlx5e_shampo_hd_per_wqe(mdev, params, rq_param);
-	max_num_of_umr_per_wqe = max_hd_per_wqe / max_klm_per_umr;
-	rest = max_hd_per_wqe % max_klm_per_umr;
-	wqebbs = MLX5E_KLM_UMR_WQEBBS(max_klm_per_umr) * max_num_of_umr_per_wqe;
+	max_num_of_umr_per_wqe = max_hd_per_wqe / max_ksm_per_umr;
+	rest = max_hd_per_wqe % max_ksm_per_umr;
+	wqebbs = MLX5E_KSM_UMR_WQEBBS(max_ksm_per_umr) * max_num_of_umr_per_wqe;
 	if (rest)
-		wqebbs += MLX5E_KLM_UMR_WQEBBS(rest);
+		wqebbs += MLX5E_KSM_UMR_WQEBBS(rest);
 	wqebbs *= wq_size;
 	return wqebbs;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 879d698b6119..d1f0f868d494 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -34,6 +34,25 @@
 
 #define MLX5E_RX_ERR_CQE(cqe) (get_cqe_opcode(cqe) != MLX5_CQE_RESP_SEND)
 
+#define MLX5E_KSM_UMR_WQE_SZ(sgl_len)\
+	(sizeof(struct mlx5e_umr_wqe) +\
+	(sizeof(struct mlx5_ksm) * (sgl_len)))
+
+#define MLX5E_KSM_UMR_WQEBBS(ksm_entries) \
+	(DIV_ROUND_UP(MLX5E_KSM_UMR_WQE_SZ(ksm_entries), MLX5_SEND_WQE_BB))
+
+#define MLX5E_KSM_UMR_DS_CNT(ksm_entries)\
+	(DIV_ROUND_UP(MLX5E_KSM_UMR_WQE_SZ(ksm_entries), MLX5_SEND_WQE_DS))
+
+#define MLX5E_KSM_MAX_ENTRIES_PER_WQE(wqe_size)\
+	(((wqe_size) - sizeof(struct mlx5e_umr_wqe)) / sizeof(struct mlx5_ksm))
+
+#define MLX5E_KSM_ENTRIES_PER_WQE(wqe_size)\
+	ALIGN_DOWN(MLX5E_KSM_MAX_ENTRIES_PER_WQE(wqe_size), MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT)
+
+#define MLX5E_MAX_KSM_PER_WQE(mdev) \
+	MLX5E_KSM_ENTRIES_PER_WQE(MLX5_SEND_WQE_BB * mlx5e_get_max_sq_aligned_wqebbs(mdev))
+
 static inline
 ktime_t mlx5e_cqe_ts_to_ns(cqe_ts_to_ns func, struct mlx5_clock *clock, u64 cqe_ts)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index d21a87ddc934..2a3e0de51f0e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -504,8 +504,8 @@ static int mlx5e_create_umr_mkey(struct mlx5_core_dev *mdev,
 	return err;
 }
 
-static int mlx5e_create_umr_klm_mkey(struct mlx5_core_dev *mdev,
-				     u64 nentries,
+static int mlx5e_create_umr_ksm_mkey(struct mlx5_core_dev *mdev,
+				     u64 nentries, u8 log_entry_size,
 				     u32 *umr_mkey)
 {
 	int inlen;
@@ -525,12 +525,13 @@ static int mlx5e_create_umr_klm_mkey(struct mlx5_core_dev *mdev,
 	MLX5_SET(mkc, mkc, umr_en, 1);
 	MLX5_SET(mkc, mkc, lw, 1);
 	MLX5_SET(mkc, mkc, lr, 1);
-	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_KLMS);
+	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_KSM);
 	mlx5e_mkey_set_relaxed_ordering(mdev, mkc);
 	MLX5_SET(mkc, mkc, qpn, 0xffffff);
 	MLX5_SET(mkc, mkc, pd, mdev->mlx5e_res.hw_objs.pdn);
 	MLX5_SET(mkc, mkc, translations_octword_size, nentries);
-	MLX5_SET(mkc, mkc, length64, 1);
+	MLX5_SET(mkc, mkc, log_page_size, log_entry_size);
+	MLX5_SET64(mkc, mkc, len, nentries << log_entry_size);
 	err = mlx5_core_create_mkey(mdev, umr_mkey, in, inlen);
 
 	kvfree(in);
@@ -565,14 +566,16 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
 static int mlx5e_create_rq_hd_umr_mkey(struct mlx5_core_dev *mdev,
 				       struct mlx5e_rq *rq)
 {
-	u32 max_klm_size = BIT(MLX5_CAP_GEN(mdev, log_max_klm_list_size));
+	u32 max_ksm_size = BIT(MLX5_CAP_GEN(mdev, log_max_klm_list_size));
 
-	if (max_klm_size < rq->mpwqe.shampo->hd_per_wq) {
-		mlx5_core_err(mdev, "max klm list size 0x%x is smaller than shampo header buffer list size 0x%x\n",
-			      max_klm_size, rq->mpwqe.shampo->hd_per_wq);
+	if (max_ksm_size < rq->mpwqe.shampo->hd_per_wq) {
+		mlx5_core_err(mdev, "max ksm list size 0x%x is smaller than shampo header buffer list size 0x%x\n",
+			      max_ksm_size, rq->mpwqe.shampo->hd_per_wq);
 		return -EINVAL;
 	}
-	return mlx5e_create_umr_klm_mkey(mdev, rq->mpwqe.shampo->hd_per_wq,
+
+	return mlx5e_create_umr_ksm_mkey(mdev, rq->mpwqe.shampo->hd_per_wq,
+					 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE,
 					 &rq->mpwqe.shampo->mkey);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 3af4f70de334..f1fbf60d0356 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -619,25 +619,25 @@ static int bitmap_find_window(unsigned long *bitmap, int len,
 	return min(len, count);
 }
 
-static void build_klm_umr(struct mlx5e_icosq *sq, struct mlx5e_umr_wqe *umr_wqe,
-			  __be32 key, u16 offset, u16 klm_len, u16 wqe_bbs)
+static void build_ksm_umr(struct mlx5e_icosq *sq, struct mlx5e_umr_wqe *umr_wqe,
+			  __be32 key, u16 offset, u16 ksm_len)
 {
-	memset(umr_wqe, 0, offsetof(struct mlx5e_umr_wqe, inline_klms));
+	memset(umr_wqe, 0, offsetof(struct mlx5e_umr_wqe, inline_ksms));
 	umr_wqe->ctrl.opmod_idx_opcode =
 		cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
 			     MLX5_OPCODE_UMR);
 	umr_wqe->ctrl.umr_mkey = key;
 	umr_wqe->ctrl.qpn_ds = cpu_to_be32((sq->sqn << MLX5_WQE_CTRL_QPN_SHIFT)
-					    | MLX5E_KLM_UMR_DS_CNT(klm_len));
+					    | MLX5E_KSM_UMR_DS_CNT(ksm_len));
 	umr_wqe->uctrl.flags = MLX5_UMR_TRANSLATION_OFFSET_EN | MLX5_UMR_INLINE;
 	umr_wqe->uctrl.xlt_offset = cpu_to_be16(offset);
-	umr_wqe->uctrl.xlt_octowords = cpu_to_be16(klm_len);
+	umr_wqe->uctrl.xlt_octowords = cpu_to_be16(ksm_len);
 	umr_wqe->uctrl.mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
 }
 
 static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 				     struct mlx5e_icosq *sq,
-				     u16 klm_entries, u16 index)
+				     u16 ksm_entries, u16 index)
 {
 	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
 	u16 entries, pi, header_offset, err, wqe_bbs, new_entries;
@@ -650,20 +650,20 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	int headroom, i;
 
 	headroom = rq->buff.headroom;
-	new_entries = klm_entries - (shampo->pi & (MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT - 1));
-	entries = ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT);
-	wqe_bbs = MLX5E_KLM_UMR_WQEBBS(entries);
+	new_entries = ksm_entries - (shampo->pi & (MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT - 1));
+	entries = ALIGN(ksm_entries, MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT);
+	wqe_bbs = MLX5E_KSM_UMR_WQEBBS(entries);
 	pi = mlx5e_icosq_get_next_pi(sq, wqe_bbs);
 	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
-	build_klm_umr(sq, umr_wqe, shampo->key, index, entries, wqe_bbs);
+	build_ksm_umr(sq, umr_wqe, shampo->key, index, entries);
 
 	frag_page = &shampo->pages[page_index];
 
 	for (i = 0; i < entries; i++, index++) {
 		dma_info = &shampo->info[index];
-		if (i >= klm_entries || (index < shampo->pi && shampo->pi - index <
-					 MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT))
-			goto update_klm;
+		if (i >= ksm_entries || (index < shampo->pi && shampo->pi - index <
+					 MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT))
+			goto update_ksm;
 		header_offset = (index & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) <<
 			MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
 		if (!(header_offset & (PAGE_SIZE - 1))) {
@@ -683,12 +683,11 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 			dma_info->frag_page = frag_page;
 		}
 
-update_klm:
-		umr_wqe->inline_klms[i].bcount =
-			cpu_to_be32(MLX5E_RX_MAX_HEAD);
-		umr_wqe->inline_klms[i].key    = cpu_to_be32(lkey);
-		umr_wqe->inline_klms[i].va     =
-			cpu_to_be64(dma_info->addr + headroom);
+update_ksm:
+		umr_wqe->inline_ksms[i] = (struct mlx5_ksm) {
+			.key = cpu_to_be32(lkey),
+			.va  = cpu_to_be64(dma_info->addr + headroom),
+		};
 	}
 
 	sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
@@ -720,37 +719,37 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 static int mlx5e_alloc_rx_hd_mpwqe(struct mlx5e_rq *rq)
 {
 	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	u16 klm_entries, num_wqe, index, entries_before;
+	u16 ksm_entries, num_wqe, index, entries_before;
 	struct mlx5e_icosq *sq = rq->icosq;
-	int i, err, max_klm_entries, len;
+	int i, err, max_ksm_entries, len;
 
-	max_klm_entries = MLX5E_MAX_KLM_PER_WQE(rq->mdev);
-	klm_entries = bitmap_find_window(shampo->bitmap,
+	max_ksm_entries = MLX5E_MAX_KSM_PER_WQE(rq->mdev);
+	ksm_entries = bitmap_find_window(shampo->bitmap,
 					 shampo->hd_per_wqe,
 					 shampo->hd_per_wq, shampo->pi);
-	if (!klm_entries)
+	if (!ksm_entries)
 		return 0;
 
-	klm_entries += (shampo->pi & (MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT - 1));
-	index = ALIGN_DOWN(shampo->pi, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT);
+	ksm_entries += (shampo->pi & (MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT - 1));
+	index = ALIGN_DOWN(shampo->pi, MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT);
 	entries_before = shampo->hd_per_wq - index;
 
-	if (unlikely(entries_before < klm_entries))
-		num_wqe = DIV_ROUND_UP(entries_before, max_klm_entries) +
-			  DIV_ROUND_UP(klm_entries - entries_before, max_klm_entries);
+	if (unlikely(entries_before < ksm_entries))
+		num_wqe = DIV_ROUND_UP(entries_before, max_ksm_entries) +
+			  DIV_ROUND_UP(ksm_entries - entries_before, max_ksm_entries);
 	else
-		num_wqe = DIV_ROUND_UP(klm_entries, max_klm_entries);
+		num_wqe = DIV_ROUND_UP(ksm_entries, max_ksm_entries);
 
 	for (i = 0; i < num_wqe; i++) {
-		len = (klm_entries > max_klm_entries) ? max_klm_entries :
-							klm_entries;
+		len = (ksm_entries > max_ksm_entries) ? max_ksm_entries :
+							ksm_entries;
 		if (unlikely(index + len > shampo->hd_per_wq))
 			len = shampo->hd_per_wq - index;
 		err = mlx5e_build_shampo_hd_umr(rq, sq, len, index);
 		if (unlikely(err))
 			return err;
 		index = (index + len) & (rq->mpwqe.shampo->hd_per_wq - 1);
-		klm_entries -= len;
+		ksm_entries -= len;
 	}
 
 	return 0;
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index d7bb31d9a446..da09bfaa7b81 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -294,6 +294,7 @@ enum {
 #define MLX5_UMR_FLEX_ALIGNMENT 0x40
 #define MLX5_UMR_MTT_NUM_ENTRIES_ALIGNMENT (MLX5_UMR_FLEX_ALIGNMENT / sizeof(struct mlx5_mtt))
 #define MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT (MLX5_UMR_FLEX_ALIGNMENT / sizeof(struct mlx5_klm))
+#define MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT (MLX5_UMR_FLEX_ALIGNMENT / sizeof(struct mlx5_ksm))
 
 #define MLX5_USER_INDEX_LEN (MLX5_FLD_SZ_BYTES(qpc, user_index) * 8)
 
-- 
2.44.0


