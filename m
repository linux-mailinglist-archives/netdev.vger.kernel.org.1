Return-Path: <netdev+bounces-89535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C218AA9BB
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3ACB23884
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F51452F6B;
	Fri, 19 Apr 2024 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SzZwmjnQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931D4D131
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513993; cv=fail; b=UlVcZSxZOtUyq5k3H8lyHJHAINAh5e3YQejf3lv4AkXnICOrxDrVIbPAGQgCKROfZ0UO6QPR9+l4IBWpl7Qt6Qc0xLTaMxGQ4mHhWEr4RbSckGjtDWJkdlfELw1q0wSDkR8r8lbvw88+P0GaE4ANJDnUf6keIbQaa0u4JVw4p3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513993; c=relaxed/simple;
	bh=doGIljkYm9Ah4CkvY4vnNzihq0Uq/+D5cOgzVM3fLCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a55RXfCEpKQVSH4tnAB2o/4cCSaMkPgNxvpCurOAfSUb3wsCsAZNz4MffQDJ+aTSQbB/sBkA2fgkslrP+ujclKTLhGrkXoUiPQmSuLebhw9oakKVx7Ts1nExb9ilvngEFui+EgY6ePL4ZXAb8yIEwNiSbOy7Xr2vJRvpV1UVFEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SzZwmjnQ; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFBw8V6WKcXuZs2wp7HzYzBiIVrXCce0twJGKW68iRVkD/hB9Fb3DHuNak6+0hva6BYZI2ACC978242QA9R+o40i7z0FhzQloc5sVnMp4lOXC/iTudxk4dTo4dg583t5IyVebTxuYLk/P5vOcbul5GZZdQ+r4zdjGTM/C/jpMErsd+1bZ4PTkTWxu/a/mH2P7hzXbQ5PgTeGeYipDhM44F6LtZIKXXQlmqxs8Ws9yeKR3fXLq/ZcKq9vZzh2BYZQYH+AGe1nXjvHK8+g1C4Y0MZ1UEQ9SKG/G1Scuh49Tmd4Ikx1n/jMYXO33pX7OcCDVF5KK6tpyynvaDVFYGVO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvczYQggUdza0d8raZ8LvfkBL59tg1G/yOKF34OVScM=;
 b=kTnONReEQ9ChTLD3B5B8yPJvHOiQ/geCQfHKuY2tAKcGDzv3a0N/r24HH64tmBqd17v1aFusbfQvkWI+algLVykjQC71ZVdROfPZlhpM4IbdHHc7lhZCSmROUMnIrsmIWDcoOGE0w72uuJbm+j1dZTnn02jAoSt+56QFp1HQtSIifUm9bXWmh8zYYYqhmSvW/G9Ve85Z/JU5IguF0SKle3OWuf0xbYo67107Ck62ADFBWJeRad499Lm9J04U1thSzKi0P2xNQfOOcDrdNOBKYEGSiYMCmkCLuj2zbdJMv9pPcqlkSec323GDkgNBuuFudKoRVsGp/WcLlSkVi0B9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvczYQggUdza0d8raZ8LvfkBL59tg1G/yOKF34OVScM=;
 b=SzZwmjnQ0gpimyC2wXnOLN/9+VS6WAyka4rKwxPWvbKYS/wWlkJy8JqWa8xXVDc8ar1KPooym9OD0sua5t7JsEg32PGZX4RlfixGMPOUsYOBk+uEw0R56kqLYcsI6/ui22X2TpQGpXMbTHalQGxtOtsMmzxwBuOj++vQuPbjfCI90p2ffmX/YgovbqAIArXq4geWzAJMU5OHe49FrdQcnd59FwugiXXsKO1b3Dsr2Lv5sWsc9oNrgCDvurEw/xXOk6SPvoFD8yHo5axjBTr/hODgMcVVxVrfmvm6opzSxPpDUmpJ8e+peEqQMVHdVKY+1ZwTpyeaHIMk7rAjGq+rqw==
Received: from SN6PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:805:106::26) by LV2PR12MB5773.namprd12.prod.outlook.com
 (2603:10b6:408:17b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 08:06:27 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::e2) by SN6PR2101CA0016.outlook.office365.com
 (2603:10b6:805:106::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.16 via Frontend
 Transport; Fri, 19 Apr 2024 08:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 08:06:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 19 Apr
 2024 01:06:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Nabil S . Alramli"
	<dev@nalramli.com>, Joe Damato <jdamato@fastly.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 3/5] net/mlx5e: Dynamically allocate DIM structure for SQs/RQs
Date: Fri, 19 Apr 2024 11:04:43 +0300
Message-ID: <20240419080445.417574-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419080445.417574-1-tariqt@nvidia.com>
References: <20240419080445.417574-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: bb64d671-b5ce-4132-97e7-08dc60479c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lq/Q4DMx1HqhcLNSuHTKPda/wIbX6Unvn/kaoJTprO5yEpd/k4Eg4tcbIg6Ib3X0d+QZutxUGNwgT4ZYikgCOSe9o395/mX7OLDgzcka1njgESllMk11ZNG5Uuxnhy/Jg054n/UtlfXSC44doIXGn4A2/i6yoN8fYcfiTUd91jl2wFs2jp+J+sqyajcUZwlxnKjJCo62ykZMzlS/CIZbUIIS9nBs54Np5fVxyz5kbsuyPvTsJlJu1JhIdfwsBNFStKlqwNNb39uYsSJxvY9R8XcT4tH4FqVZsIGfcWV8CYiWWLW4Bmy9xtI2o582AvVSijmG6r42/Re5aizSsDEgrrITlE13TO97SruKMdhn9WVQPMjDXnZ5ktm0FRe1yYXc7E7L2recXV5vKGmUN0kVMWzYSKjDRkEHUHPz7kaNyBym99bezqgx5lNtRcmChf0SskgsE9GSWFVyMKhpZz3X3FrscXvgc549t0f+6yGOBQKYPQIDdJR8jv6yKYxewKIndsbNkBQBvSXrUtHWhvK9clw0ZhiVTpkZ/W2nl/9xn/tCGFd3C96s6wz2Wn5bKMLyFMsu/enx+fJ9VBrW8smt0RIWHeRueuKRbhMLMfMa2cSqwY5t3VfltJdIzCULQBmlCLTnsjH41u5s/GlxdMRJX39iLXaK4owokxrkULFi/43X0pPL0VSMXCwwgpktj5C+1pwIyPimu8eDCfTt9xiY/e03fC5G9NFfIG0pr6tnuJjKcH6QXsQKB53/AU8PMMxX
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 08:06:26.2520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb64d671-b5ce-4132-97e7-08dc60479c79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Make it possible for the DIM structure to be torn down while an SQ or RQ is
still active. Changing the CQ period mode is an example where the previous
sampling done with the DIM structure would need to be invalidated.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +--
 .../net/ethernet/mellanox/mlx5/core/en_dim.c  |  4 +--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 31 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  4 +--
 4 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 1c98199b5267..c8c0a0614e7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -430,7 +430,7 @@ struct mlx5e_txqsq {
 	u16                        cc;
 	u16                        skb_fifo_cc;
 	u32                        dma_fifo_cc;
-	struct dim                 dim; /* Adaptive Moderation */
+	struct dim                *dim; /* Adaptive Moderation */
 
 	/* dirtied @xmit */
 	u16                        pc ____cacheline_aligned_in_smp;
@@ -722,7 +722,7 @@ struct mlx5e_rq {
 	int                    ix;
 	unsigned int           hw_mtu;
 
-	struct dim         dim; /* Dynamic Interrupt Moderation */
+	struct dim            *dim; /* Dynamic Interrupt Moderation */
 
 	/* XDP */
 	struct bpf_prog __rcu *xdp_prog;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
index df692e29ab8a..106a1f70dd9a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -44,7 +44,7 @@ mlx5e_complete_dim_work(struct dim *dim, struct dim_cq_moder moder,
 void mlx5e_rx_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
-	struct mlx5e_rq *rq = container_of(dim, struct mlx5e_rq, dim);
+	struct mlx5e_rq *rq = dim->priv;
 	struct dim_cq_moder cur_moder =
 		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 
@@ -54,7 +54,7 @@ void mlx5e_rx_dim_work(struct work_struct *work)
 void mlx5e_tx_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
-	struct mlx5e_txqsq *sq = container_of(dim, struct mlx5e_txqsq, dim);
+	struct mlx5e_txqsq *sq = dim->priv;
 	struct dim_cq_moder cur_moder =
 		net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 12d1f4548343..8b4ecae0fd9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -962,11 +962,20 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		}
 	}
 
-	INIT_WORK(&rq->dim.work, mlx5e_rx_dim_work);
-	rq->dim.mode = params->rx_cq_moderation.cq_period_mode;
+	rq->dim = kvzalloc_node(sizeof(*rq->dim), GFP_KERNEL, node);
+	if (!rq->dim) {
+		err = -ENOMEM;
+		goto err_unreg_xdp_rxq_info;
+	}
+
+	rq->dim->priv = rq;
+	INIT_WORK(&rq->dim->work, mlx5e_rx_dim_work);
+	rq->dim->mode = params->rx_cq_moderation.cq_period_mode;
 
 	return 0;
 
+err_unreg_xdp_rxq_info:
+	xdp_rxq_info_unreg(&rq->xdp_rxq);
 err_destroy_page_pool:
 	page_pool_destroy(rq->page_pool);
 err_free_by_rq_type:
@@ -1014,6 +1023,7 @@ static void mlx5e_free_rq(struct mlx5e_rq *rq)
 		mlx5e_free_wqe_alloc_info(rq);
 	}
 
+	kvfree(rq->dim);
 	xdp_rxq_info_unreg(&rq->xdp_rxq);
 	page_pool_destroy(rq->page_pool);
 	mlx5_wq_destroy(&rq->wq_ctrl);
@@ -1341,7 +1351,7 @@ void mlx5e_deactivate_rq(struct mlx5e_rq *rq)
 
 void mlx5e_close_rq(struct mlx5e_rq *rq)
 {
-	cancel_work_sync(&rq->dim.work);
+	cancel_work_sync(&rq->dim->work);
 	cancel_work_sync(&rq->recover_work);
 	mlx5e_destroy_rq(rq);
 	mlx5e_free_rx_descs(rq);
@@ -1616,12 +1626,20 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 	err = mlx5e_alloc_txqsq_db(sq, cpu_to_node(c->cpu));
 	if (err)
 		goto err_sq_wq_destroy;
+	sq->dim = kvzalloc_node(sizeof(*sq->dim), GFP_KERNEL, cpu_to_node(c->cpu));
+	if (!sq->dim) {
+		err = -ENOMEM;
+		goto err_free_txqsq_db;
+	}
 
-	INIT_WORK(&sq->dim.work, mlx5e_tx_dim_work);
-	sq->dim.mode = params->tx_cq_moderation.cq_period_mode;
+	sq->dim->priv = sq;
+	INIT_WORK(&sq->dim->work, mlx5e_tx_dim_work);
+	sq->dim->mode = params->tx_cq_moderation.cq_period_mode;
 
 	return 0;
 
+err_free_txqsq_db:
+	mlx5e_free_txqsq_db(sq);
 err_sq_wq_destroy:
 	mlx5_wq_destroy(&sq->wq_ctrl);
 
@@ -1630,6 +1648,7 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 
 void mlx5e_free_txqsq(struct mlx5e_txqsq *sq)
 {
+	kvfree(sq->dim);
 	mlx5e_free_txqsq_db(sq);
 	mlx5_wq_destroy(&sq->wq_ctrl);
 }
@@ -1841,7 +1860,7 @@ void mlx5e_close_txqsq(struct mlx5e_txqsq *sq)
 	struct mlx5_core_dev *mdev = sq->mdev;
 	struct mlx5_rate_limit rl = {0};
 
-	cancel_work_sync(&sq->dim.work);
+	cancel_work_sync(&sq->dim->work);
 	cancel_work_sync(&sq->recover_work);
 	mlx5e_destroy_sq(mdev, sq->sqn);
 	if (sq->rate_limit) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index a7d9b7cb4297..5873fde65c2e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -55,7 +55,7 @@ static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
 		return;
 
 	dim_update_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
-	net_dim(&sq->dim, dim_sample);
+	net_dim(sq->dim, dim_sample);
 }
 
 static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
@@ -67,7 +67,7 @@ static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
 		return;
 
 	dim_update_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
-	net_dim(&rq->dim, dim_sample);
+	net_dim(rq->dim, dim_sample);
 }
 
 void mlx5e_trigger_irq(struct mlx5e_icosq *sq)
-- 
2.31.1


