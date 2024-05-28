Return-Path: <netdev+bounces-98635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F8D8D1ED8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92B0B22020
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46BA16FF30;
	Tue, 28 May 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CH+3SskJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D5171062
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906602; cv=fail; b=uXrvJgx0zvERhUVqHiXbc+KwP8f4oJDIyfL4giZTyzl4nWJHlKcvSVr5dP7k+5nYMSm96gPxNptcf89ZU+FLTQna6KgyfTxSwt5R63Iw+yr3JqEjzdZ5zzbelTd3iMr22LOBkX6x6FUFmcqBfEDYKT3VgmEW22zxaU3ZB2Ivz2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906602; c=relaxed/simple;
	bh=4Or/jdXZFBzUOP3XUwdOABg3kQSE31As/jIQL/72/SQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBx1o3C33n97Tg/qvq/JNKpm4L5VnsoR4BStkX+07syxkvIJMJ8X0dbP/2VGBTpwDDg7gnMj5YgZOXiF6ua7rE326d+ah8BZiD7v+MgxOA0hiCkoR+7CSofHVbJ2rpC9AbAJM3yvbx9tU32CE2Eb1mEgOHPEJpZY/0S8E4T8+0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CH+3SskJ; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrO5iky3D77qIb4y/NasF0+5RDs1xVCRfTgxxTJMLKybwF//bbEEs3xu7Pfity82ay5BWuHAjdy+dzzFmNIAkGQ9GOPbJ9l2a1XoG2BgJey3ze4HpSnwvAn7C5/Q1P8J8rJ/NCMyGsOey+NRuv9HCW+I3DG+9BJwVWu2B7g5KtPTQAJvfZmRaFw+42R4P/xTUslXxmXwzJ+igvo6M01RjdHxl1gvoFNSUpNi+CUc8Wzn65h84KPjJ04saRs2H5SVhqjMtFdj5ARKo/ZyBKFQi6P+FyRUjytYIAcno3J/q8wjupj0/7GUApD9Uqu3N1UzWtJz2z9S8HKZXHkWnVg4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev/bqd6Tj8bFK1oNjS/pXZs8zKvIw2X4e/9j7vWDaE8=;
 b=nzpXVIaR8AdCelYMoT2u+mmTvMm1+m5/ztWrc2+dcotmqh3lgX1j2CiGzEXdY5v5FRd5MZCRBD9DxPpKlC60CYmYHo64AiJos3ircM/mCINzLHD+e4yGpE8CwAR4bFDbOhJOsys1EG359eGi69pAadbjKnotiImRWvzArh1HsjXEROdhVCAjaERG3W60Yu6ioMGdpEY82Pg9s1NRceMFUYtaqlHb5QwChKJMQlyBRcUHWQiq2GC749egf7F/vmK8dVuKBQhbh1b0IlfR/pTn6FxXav8btpR9aA0rPTkBflEy9+t9HX7xxp2HLz5Af6M2D0ocEa4Oo8UF7BZf+sHcUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev/bqd6Tj8bFK1oNjS/pXZs8zKvIw2X4e/9j7vWDaE8=;
 b=CH+3SskJ0ZxC4beKDZwejHbPAGaFDXhWE1dBjgopSrhIrT6/C9q27qgl7D0rQ79vjMPbKXBgSA9FgbyN96xDkytcGcvVzxcq2GgT8p046Xb4nbFeOgYSBf1l4UU9uDte/W92d7sRkzeZ4+SiVZc/LwnmqtpVSrAyWGovZBRgSCHrH7pS5KxIRpnYf3npigqOS8Cz4VXZsQMMOTPk2T1gN5Q5by1IqueAGf2bElPwD+ePQY2dDBFtsndZqqfPpJiE4vpIvij1wdsccywtApLkn0Q/hk7PXuMR03sw6piUv9jnb2hh6Ell66IBdaqz5s5aLbxs9PuJ5vGvKUqinHM+kA==
Received: from BN9PR03CA0167.namprd03.prod.outlook.com (2603:10b6:408:f4::22)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 14:29:57 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::a6) by BN9PR03CA0167.outlook.office365.com
 (2603:10b6:408:f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 14:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 13/15] net/mlx5e: SHAMPO, Use KSMs instead of KLMs
Date: Tue, 28 May 2024 17:28:05 +0300
Message-ID: <20240528142807.903965-14-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5c0d64-696d-44d1-4f25-08dc7f22a5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s2hMxMbR1I6toiHrinl7iAVlLE33Z4Gg8nMXkUvNCTeD7wrOxjuwSs9OjvZm?=
 =?us-ascii?Q?V06QN9sWZYs44MJxPruYRnHzw8cnAihYJWgd1TTThUkRm/x7/iXoz7onWRh4?=
 =?us-ascii?Q?ECskBhUcz1Z5b1XGBkKNE/NNwP/g5o03zKwE7VWkM5m+Utg5EftTejsX9Dvq?=
 =?us-ascii?Q?lJqyd/78EL7EKQ1OH7S64gN0lxNBRMS7D3h4+XEUdosIQOtNTqzApoFlRpNd?=
 =?us-ascii?Q?cD1DO/UV3Zn/27gyY8JbWPUTuihVTlityipeVADudUsNsEIuf57LhordnbML?=
 =?us-ascii?Q?oZf5ValRkaBB+yrTtPDOFKUMbGJ24B/7tbTkUvYSeUygg9f8vDGN0/pqrMwD?=
 =?us-ascii?Q?eSqD6OotGQlqvKpveGA1HOlZFCUw0rRZpVBCR4hPciCEtYrLzkm2ypl6kYuU?=
 =?us-ascii?Q?uGlVEBQ9v+zLqF+7mt+TfhSuQjzPMWGOO6HIzTIStQtz9CoJeXz+XuND+Z89?=
 =?us-ascii?Q?mz7KPlMl13JIzC1Cg9+e558cuMgr1IIMfocj+6fxoMWsnY0fNcesgG/W2VCX?=
 =?us-ascii?Q?3vpKld3Q8ZijgHWiaMAYddsDXGqRHQmIFQlihzLWhmfTeg4Jiu9kiESM25e8?=
 =?us-ascii?Q?B1txweM7H231pYIYI67EN+Bv2hn7t2MpH2wmp7RfuoyAZmYKBX0Nm9Y7aIGq?=
 =?us-ascii?Q?a6/vqZreVbD5EeQ1uPBJKDR1jK3IdDDKunRi4beCWxgWZ7qLVAvbZzDBjhEH?=
 =?us-ascii?Q?PYkqG0OAmdifFlbUKbLnnK0xfXq7JorIJEZUhHRBYiaxgtktwX7fmvPFXBBk?=
 =?us-ascii?Q?6dYZHS69wsiHFjIENCkWlgNr6P05x2nlJJ14kTth1O3P+Wwka47jkteULSVY?=
 =?us-ascii?Q?cS7Tl1Am+dMtyRHEX34SEkWLBfaqu8MfJunVD066SX4KWzZ7l9eF80qPNZQB?=
 =?us-ascii?Q?SRpV9CfuVhUWoZp4uOJfiXlC3G2SpmquHjLQclwGN3jdCueicZNtvWciawfU?=
 =?us-ascii?Q?SOC7gZWLYjQUwEjHxdPj+dJxMm+sRzYyi26LS9x7cUs3cPh5F6hGzY+/K8nB?=
 =?us-ascii?Q?+SzIPAcXptxSX0UCLJz3pQJsfounQraxjtfVR+RiZEqchlvs6Hq6AdpY24Yd?=
 =?us-ascii?Q?5ZirTxzkZ1WgshNuS0ZstM4CjaZafeFLN3GJPfgzzPGzIsv0IqgUmx6WhkgY?=
 =?us-ascii?Q?k77DGAGwqHZhSvW6TzhjJ4jYeL/YMeTVouv9ej+a+92PB3r89O50RrQay+7e?=
 =?us-ascii?Q?z1SDDpfc0XsnU5g5oSpjrEiaQoZ+0PG9tZQkU8QUmlrWoPPxlL2cYF0akkLH?=
 =?us-ascii?Q?ycLdQVXurM7AIjuev+zXwa8/A7pXckQmeCG6Yw3aoJ3WQ/bf/Aa7hO7++tah?=
 =?us-ascii?Q?RDgWMU+7trCLmsfpk+RQCc//VdCWH2ZJxK/x58+WQIiKe/ORTDtxKHhYTm/i?=
 =?us-ascii?Q?EFoqxZemk6XpkytTRVpM6K5bBK22?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:56.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5c0d64-696d-44d1-4f25-08dc7f22a5fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

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
index 1b08995b8022..913cc0275871 100644
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
index 834428ed45ee..e6987bd467d7 100644
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
2.31.1


