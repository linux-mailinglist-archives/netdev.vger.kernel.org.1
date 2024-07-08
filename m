Return-Path: <netdev+bounces-109762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A072929DDF
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39875284649
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994343D38E;
	Mon,  8 Jul 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QYk+VQMq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823D38FA5
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425723; cv=fail; b=bnlCMrcz3hFtW80quHvPmShvnQAdHtnKyQ6oD0ea6B96nxPHYs3+HCZx4/8h6C3JqGXU/+5A+vAFlthoeNARAMpMBB9jbPHVM2Hl2PKfajULiIT9QV+TUAbPS7Kjfg+zEgk+pv81O5dem0z3yaMtWrNoUebC230rbzYbCIKRcDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425723; c=relaxed/simple;
	bh=RHQjAuhoiRjirbAejjQCFA+AM7yT/z88prJmKI/O3Mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVju1xcLEpDgk0meGQRt1Gfm2H67xJPSSPW5qktgTEySuZtsSPuz7pntPAaajSTD4s45iRiwsTC00EtDtA3d20Spk1IRnO9gEZvlx1VMVt/B84rBoxKDMvI7Ib8Fx6vvu4ujU95Jo3eq1Rc5JBsYBid2yTc4NUXdTjp4MZQpTgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QYk+VQMq; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD1wy4nT1rKwvsWruLpPVIY8M2+RjEP349FS6jMmjuEOlDwJMYHqt2rd6HHvZlNR+WlDvDb8cOxZWaUiabaooTFTRUyZFpqf2TYqukPnl2gtTnWoU2iqmYIgpoPxu3Ri/7ha7qn47x5vE84gxDb1jDTInbdL4ZCtKg2m+Hu1H3NRb1dQuAyMtsux8LOSMm+Pvz5Lc7V+hhtWEHEtNgcZ14WbVnO2uc5kobMJttW7Iq9kV2kFzzlJrk+64K3R5m1k5NQ9luFV8sDMh6mNJjxK/DluL+JloQH/eJmhAdpHSGj3fTtpIUSb1pJmQXxJW5uBw8xmGvBNTdo+IS5bSFeaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuYqxYkF9oZSSWu4pQ18JRkHhlg2fhpxMOzB+47uMLk=;
 b=VWvRXXosdUznFdtPMqVCNi/U5XIYHyMAFHgApsvV/fTtyPJIJdgDlFFRiBdANC15WS67IoDFyLxrPzBnMLHdFA+D4q6i04JDp6z2kfGDfqwipyj0OxQ/cNx0DZTWz82QLuMTyS5hAjEr1BP3moo+LHc9d+6LHRawp+Jx5CzEewuy2eC3DLA2JggvRXnme0lI4kfEesMFeDKPfgj2mUEzTm3Q9NQkTD52lHR7bNsaIYqB2qpGXhQzYkDcmiRmVeKohlDbZ3j7yoHbGOMYrkt5ctC+Ls/MRWygmaZiGtKSTsd9T/843cXAosnKpAs9VkSLlIOyBBctQcms4oRyKS7VKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuYqxYkF9oZSSWu4pQ18JRkHhlg2fhpxMOzB+47uMLk=;
 b=QYk+VQMqCJa2Ru1zbwShEsmE0yEz4xNhCDJTzp/q5NBkED1ePxrq8Orm+WQEtGYBcaPIkQluFR/Y92rGjnueeZpxyQGBdbnLP4U60dyBK2/bn8vj6RD+wz0G2EA/Owh5EdakBtESfwMpRtBl1aoGmW26i9Vxu7Lfa3sts9Cjbcl5mWrXPzuZ47eMlu/9OC/LiHDrQRSZmUlPZTHjrncdJ5nhJAQSu/qQe/YI/6RrKF8QtqDaZ2zabu0r7eFbIlnxMDnu79WT38syA8EF59/FCLvCRMxLCWYmBlIcdffCqS61F7mj4FaiLg8txpBQ7pmaG3WUDNtOiiXc6AS9y/DAew==
Received: from SJ0PR03CA0124.namprd03.prod.outlook.com (2603:10b6:a03:33c::9)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:01:58 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::16) by SJ0PR03CA0124.outlook.office365.com
 (2603:10b6:a03:33c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 08:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:01:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:01:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, William Tu <witu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 04/10] net/mlx5: Use set number of max EQs
Date: Mon, 8 Jul 2024 11:00:19 +0300
Message-ID: <20240708080025.1593555-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e32fdc3-dcdb-4847-d1f5-08dc9f243d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oNuynEDcPvASU18uemaDjGXYiKKVwykg17+QmC0/bWrvr7PzRtbtQ+EltOdr?=
 =?us-ascii?Q?xdG3FKaKSNDHEC73D8RWqUI3Zkt5iJPluJH9F8Bmr+BS4mG8fmeVtP1zCivu?=
 =?us-ascii?Q?Pv8GTS2TkdWOXF/6IGHs8Y0BIZimZnF7QeyVomX3welkUQvXYPkPHNKrWHhu?=
 =?us-ascii?Q?4lbu2ZubUJczKTMCy87v2HmJrPZ7u/tTgY6qKLLGjOXcDXCKnw85FMt6dR1f?=
 =?us-ascii?Q?X4NSu1LYVNuakwjzP9CKsjMs0VekypVNyhbg85D18Gtr7tcdgbR2LPGNbu/4?=
 =?us-ascii?Q?G0WDUq2n9T4chqqMvQPHwgYncnr5QMC8W4O0g7UQXjZ+6+8xwTvDEbeCoC7r?=
 =?us-ascii?Q?jbjjGzSqYrXwa83EW/qqPWRD8MJbYUq+ZNhKpqw+xkjBirQkX31K5+dcHMSS?=
 =?us-ascii?Q?PHZlj2DHVJWJ53aPG0lqXWrbWcoj4iplk5Sb1UEXotfzmwZY+rO+mggPFClU?=
 =?us-ascii?Q?/O1CEhox0nwfqfh5Tvu//pNEVr08jjGce8iHeC8rVPRne7TXXE3ZhWqIJpPL?=
 =?us-ascii?Q?G1n0WVG5U0c2fJKYm741Nb2JYkaXJJTXGzp0p1IIzS+WC+hLPf0cyF1q3061?=
 =?us-ascii?Q?eCHuxQLFzQngYtphcdLx2rXFutqBkhtFi+AmCtV5Ia+Rb6aD7pqHVkEUDvEr?=
 =?us-ascii?Q?yEJKe3IP7Pn/rk9FP2pmsfdlZI6Uu4klNG5E4RwJeJ9TMuzI/P/NDM5ISmUK?=
 =?us-ascii?Q?IvW7D+bSpng6VyO6C3VFSxI18F+FxEZ6C/f3QSF8in56in1HPlAflYM/pTt1?=
 =?us-ascii?Q?Uo0p2XNmTPO/nBBD8mhPIgSqH4uBREFuviomeDnv5QE6ARiyqWJIej6agoA0?=
 =?us-ascii?Q?RYz1LWHU3AmWbekryeI2dF3eVc3WKSU4aagvOJdF3VmvER67YnfhLYxjwLSF?=
 =?us-ascii?Q?LDUUPj0pcBL8zBSQSB+D0p0er/pDcF9Pk/oWAHYKoJgUu8+gIbOgjSN3atBc?=
 =?us-ascii?Q?cAUWtQLbC0LVfiSMjvtP1dXOVAppSeGP5BkCG9SR9sVcKwfcEG6EgBOTupKi?=
 =?us-ascii?Q?1JBtf8iEyBmOO2uBlOvTwZ2Vx/HUnFvBIQCVEhDvhpx2wJmQQ0eZ5UiEbDJT?=
 =?us-ascii?Q?E4WtRxn5rFNFIPe1RlyLq0z3DVHY/THx98FAdvRjRNsx12EbediWCx7XpGEz?=
 =?us-ascii?Q?P/KAgjAB4W9KjvY+c/QYG7bBkKuQzpkhicOzgyp2/EkWEARMWUvJXIvz/uzN?=
 =?us-ascii?Q?rPcNfYYl7f3eE0lGOMm9sBh4kKvkpHPngywaSRYIWlEsjOsoFcYxNtcbjf/w?=
 =?us-ascii?Q?6rP6LGEy0CQACdEqHm8kzzh7GdJSEybnOXodK/uEuNM3AdMSs0RMVgY5E5f/?=
 =?us-ascii?Q?5Lfz/0VlBohAOQtQb7dUs0c60R0iZQVcPC+83Gz+o0k9EbfT6vL/MH8YmgGx?=
 =?us-ascii?Q?M9q8NrFhCOlpF3ewIT87pFDxE2JM9ZGxcDswAsNqd8gA2X5MNByIkaOYAQx4?=
 =?us-ascii?Q?rOV9r4snjzvapEXSoIDvCyz5+5DFqluJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:01:58.0912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e32fdc3-dcdb-4847-d1f5-08dc9f243d9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263

From: Daniel Jurgens <danielj@nvidia.com>

If a maximum number of EQs has been set for an SF, use that amount.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c      |  7 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 12 ++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index ac1565c0c8af..4326aa42bf2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -1187,7 +1187,6 @@ static int get_num_eqs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *eq_table = dev->priv.eq_table;
 	int max_dev_eqs;
-	int max_eqs_sf;
 	int num_eqs;
 
 	/* If ethernet is disabled we use just a single completion vector to
@@ -1202,7 +1201,11 @@ static int get_num_eqs(struct mlx5_core_dev *dev)
 	num_eqs = min_t(int, mlx5_irq_table_get_num_comp(eq_table->irq_table),
 			max_dev_eqs - MLX5_MAX_ASYNC_EQS);
 	if (mlx5_core_is_sf(dev)) {
-		max_eqs_sf = min_t(int, MLX5_COMP_EQS_PER_SF,
+		int max_eqs_sf = MLX5_CAP_GEN_2(dev, sf_eq_usage) ?
+				 MLX5_CAP_GEN_2(dev, max_num_eqs_24b) :
+				 MLX5_COMP_EQS_PER_SF;
+
+		max_eqs_sf = min_t(int, max_eqs_sf,
 				   mlx5_irq_table_get_sfs_vec(eq_table->irq_table));
 		num_eqs = min_t(int, num_eqs, max_eqs_sf);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 401d39069680..86208b86eea8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -16,6 +16,7 @@
 #endif
 
 #define MLX5_SFS_PER_CTRL_IRQ 64
+#define MLX5_MAX_MSIX_PER_SF 256
 #define MLX5_IRQ_CTRL_SF_MAX 8
 /* min num of vectors for SFs to be enabled */
 #define MLX5_IRQ_VEC_COMP_BASE_SF 2
@@ -589,8 +590,6 @@ static void irq_pool_free(struct mlx5_irq_pool *pool)
 static int irq_pools_init(struct mlx5_core_dev *dev, int sf_vec, int pcif_vec)
 {
 	struct mlx5_irq_table *table = dev->priv.irq_table;
-	int num_sf_ctrl_by_msix;
-	int num_sf_ctrl_by_sfs;
 	int num_sf_ctrl;
 	int err;
 
@@ -608,10 +607,8 @@ static int irq_pools_init(struct mlx5_core_dev *dev, int sf_vec, int pcif_vec)
 	}
 
 	/* init sf_ctrl_pool */
-	num_sf_ctrl_by_msix = DIV_ROUND_UP(sf_vec, MLX5_COMP_EQS_PER_SF);
-	num_sf_ctrl_by_sfs = DIV_ROUND_UP(mlx5_sf_max_functions(dev),
-					  MLX5_SFS_PER_CTRL_IRQ);
-	num_sf_ctrl = min_t(int, num_sf_ctrl_by_msix, num_sf_ctrl_by_sfs);
+	num_sf_ctrl = DIV_ROUND_UP(mlx5_sf_max_functions(dev),
+				   MLX5_SFS_PER_CTRL_IRQ);
 	num_sf_ctrl = min_t(int, MLX5_IRQ_CTRL_SF_MAX, num_sf_ctrl);
 	table->sf_ctrl_pool = irq_pool_alloc(dev, pcif_vec, num_sf_ctrl,
 					     "mlx5_sf_ctrl",
@@ -726,8 +723,7 @@ int mlx5_irq_table_create(struct mlx5_core_dev *dev)
 
 	total_vec = pcif_vec;
 	if (mlx5_sf_max_functions(dev))
-		total_vec += MLX5_IRQ_CTRL_SF_MAX +
-			MLX5_COMP_EQS_PER_SF * mlx5_sf_max_functions(dev);
+		total_vec += MLX5_MAX_MSIX_PER_SF * mlx5_sf_max_functions(dev);
 	total_vec = min_t(int, total_vec, pci_msix_vec_count(dev->pdev));
 	pcif_vec = min_t(int, pcif_vec, pci_msix_vec_count(dev->pdev));
 
-- 
2.44.0


