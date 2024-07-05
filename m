Return-Path: <netdev+bounces-109367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F8292828F
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7F41F226EF
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CA31448ED;
	Fri,  5 Jul 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eP0GjmaG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6AF139D1B
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163750; cv=fail; b=DpXP9hu5+eyMVVALc4cEqFAEwMq7YsIpDLKcqokV8xjHdCtAYS+2RxHeVLm0uZhA+TRI91PVbw85vJWJ5lV+ooEZ2icXi0IBGivzmSKPayHoto5V4vFer1oMU4HomKvHC2DRS2ldZTDU0Hrh8oPODa4yuXSvs6c4WKxqM56Zi8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163750; c=relaxed/simple;
	bh=RHQjAuhoiRjirbAejjQCFA+AM7yT/z88prJmKI/O3Mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQ2VcUTWkXbNNhIikrr7zy4ivWcYiqDT5xn2BdI2gjBvksYW2SwXm/g79HkFw7lWRAS50n6oo1T5y277bFcpYLI6x17Nuev7gquanqWNMU5a28BY2zr9Msz8KoXpTYcHhzuedf6d8gl2iKy1t39w+xz5uely8DU50y3fhsgwiQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eP0GjmaG; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivyZg62uOcoGB8dZx71jSR7HyfWxSYFiUxvn+JMJa1NHGOCOXa4wGMh37rlcE6RhSdsgTn9SwpF4dXKnbbewFd2by/Fo7naAWf3aSuJpvKGucroAbrQhOSB/LdXaupjIqa7Ix4I7QXD2CsShQSKm4JL0IZ5c8vUK5lVZMfvGu8iTEdMuUFWwm2waQny8vGefBj+GEJp4DGwXLdBp6a9FZaXX26R9sdIlsT3YOY3/kpCF48nnjbTbJx8cj3Aaj97gOQkKQjjObkx4r+PoWYK7PFV+mR6XlxKbqz0gaIeP/MAUM+S2JibVzDn80HsMegYSM6hyYCdi4p0vGQ/fAoVNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuYqxYkF9oZSSWu4pQ18JRkHhlg2fhpxMOzB+47uMLk=;
 b=GUoF4ZQyQSQMjESfGnuIbu4QPHUM90UH2qFnI+wAFXSRHliwQV0k5HEVvF9CFth8dEYMzwfmaS7r1W4EFn8nLFksb0pXiJ7p35HNa4EEpnKAELcdeNfePUP+s5FsYQWJItlgHnETMQRblygtF6Q63hSaylX77pG71/qsRtWQXbW8HKPwsWMPS7CmijFeDsXigAZ5v8Kd8AL45mfqY9/xqxBLvZ8iTL/sLfdLct3l1KhgGlrQmY5udLHyVM2KrgGUNp48Y2NvYCxFHqZqL6zkU1/falK5fvvaNeawDrPvGkeoJ9f34vn3NEes/xrklFBdG5Zgqqvo+18TEl2a+dG+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuYqxYkF9oZSSWu4pQ18JRkHhlg2fhpxMOzB+47uMLk=;
 b=eP0GjmaGbVGtkmrDXhYVT21UYJKh5wERrIOyVVoSGFQ6GERyVnlkYQmWq4y0aLHjqfIWtN9SoPfFKSEdgFUlyJ5SwxCZcteLr2vrR5u/FCbiiUOmHD3nVKDPYGUzsW/HNi0Iks86XBnLTCCHPdwyChePyUA1lQG8GHoYjMpj93CZTuG+0AKzspVMeQbthCJv+kwq1AkNjTCWHXIK2IFDVnYtUUuUziFZAXCAMPGeqJGkrif69tYQT9j/CaNSkKsSfiRCW2a5JTDz5PK5BgQhe0lz89KvWXoeFPC6it+jMuzr34Al8CXupURFlTHStNdB1tG2uReCZ07D9Bz82d1TLQ==
Received: from PH7P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::6)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 07:15:42 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::1e) by PH7P222CA0011.outlook.office365.com
 (2603:10b6:510:33a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, William Tu <witu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 04/10] net/mlx5: Use set number of max EQs
Date: Fri, 5 Jul 2024 10:13:51 +0300
Message-ID: <20240705071357.1331313-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705071357.1331313-1-tariqt@nvidia.com>
References: <20240705071357.1331313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdc846b-a366-4f96-94e4-08dc9cc24748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zOoE3dhh10LtFVJjZVXKRy4vaJGvJnUHhCCxyX8igAWyuJVUR3YoLRYssSUN?=
 =?us-ascii?Q?+IyCvbmPR5kPtBgOgrYLdZ94O/GXJt0I+XyRDpktsA8pfxT3SleWzSacR/w8?=
 =?us-ascii?Q?2eb9tpvAB8Vo2ygd2EMaM7S3Fe0GVyckwrvGRl0QeNJ3HNZ7vz7qRJWrU55t?=
 =?us-ascii?Q?BxgC6wzMhlBpR+o+fP3p4Cf6723noxLjTpvd9QjvwtJvcIQ6yuZ7DBRn7kE5?=
 =?us-ascii?Q?1Rx/uOhjtRwJDaH5VXmhNt5yU61E4TEugCnKEZLPBmXNL26Eh2f1Vbs4Yr7h?=
 =?us-ascii?Q?0q0V09ku+zQ1S5IprrnlM8wdVWU+w8UhqZy83oWTJHCN/++1S+VyGdCYOBAI?=
 =?us-ascii?Q?e7QFmjcP4dF7wlUkM5KQk38fzhA9YDyYsFOIzJXm3klmmvjhPVMthLaGHeSi?=
 =?us-ascii?Q?tYuGHmF/DA8245yjCG4RGu6lZn6LFb3c0MeJVh/XB3mU+626qWPy+Ik182rj?=
 =?us-ascii?Q?6dDkMtwcgvgfN5WEg/OB2oQgvG8Mpnz56YJlQ4eYHE+KurwtjaeJ2ddQZGm+?=
 =?us-ascii?Q?lRaGc9k+9G971oG1FjpVEcTHRhGk7bJAkvwgsNQBRUbomICyewmN+mQdzkoP?=
 =?us-ascii?Q?ij22W5443HN+eAHsECFb2QK/g44MMOOFdRzBN56uRSmzwQwpfNhWTvTqnYkp?=
 =?us-ascii?Q?JmfKCZvzNogCNLz9rF+G36dvCXQdbcL0HDTY3apO2AVUQ3+wowOKI64N9YBY?=
 =?us-ascii?Q?Kk1owh8w/5Pqyn6jMtj4OZeNwXfy/nH9dm+5daoIREytf+dG9awKxQ+ZSo3A?=
 =?us-ascii?Q?PxG6znHeoVObMa4W/ZW7xk1LYjS0s+SiWThut/zN6Tao6d/dKaoGliqU1ouH?=
 =?us-ascii?Q?5aLtOpXCuKDpxphkZKqxBa73kUDfcR9uxTERrrDcbpsDeXnB6C0dpLI2KPkD?=
 =?us-ascii?Q?kj+uxfbHcq1djcWFjVfZu6U43hyyO80WpIkBEXgfh5O+koDbUzf2SdI11152?=
 =?us-ascii?Q?WL5pVVMllf0py/QzDGGNdTK1tDaB4iGncyhQ5yiuyiySxm5J1V3Aein1/1re?=
 =?us-ascii?Q?DO5hWtoVexssL57+sk1om4uEi5JphqkzjrXq2vkNzWe2MyQI8/kMGD3Uu+2h?=
 =?us-ascii?Q?YsZfxia71aCsCnlzxPxcEMvVeXbkxtwBJ+YTLFrzbcgs5wMjkV0tPLM51lLq?=
 =?us-ascii?Q?gZ+ybRR0CX6aaU8BvTzoqzViE1kFqY4dYSxip0/Gads9e0gwN2Kd2qbmZB6E?=
 =?us-ascii?Q?mV/8YL+0fXDPusvOaphgpALadj7fAZyn6hMGipXL1rGPqTtcIQG4DvrLaTSZ?=
 =?us-ascii?Q?VwV1RaCqKuKD7ykcAuFPSSbuZC1JqW9Z/d3m7mdgLxMc4kNsID2aH26IdtNZ?=
 =?us-ascii?Q?Xnv9h3eW0CzGZX69VwqA4RgGSaHz9IRDVCJXR0Y09W3tp2C0QK8m/aAtA42o?=
 =?us-ascii?Q?YUds1hpcvfJSYg1GfJPX/7uSBq4Cn4/a71u2OKRW1PMPGAvD9MJTQLtUIv1n?=
 =?us-ascii?Q?bfikr2FEJcHIPptnJE9NPJtAWupjB87J?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:41.2201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdc846b-a366-4f96-94e4-08dc9cc24748
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875

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


