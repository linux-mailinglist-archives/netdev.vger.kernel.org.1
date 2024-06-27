Return-Path: <netdev+bounces-107413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C055591AEB9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C36289830
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5692819AA60;
	Thu, 27 Jun 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pMwNkn6o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6419AA57
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511470; cv=fail; b=gcVpLQP9lPTd5FCLkoy8EcG6WepQKEN8A3zHgmVYxzeTb/IXue6uXbjgMDTqYFMheWFxhMEQUD1r57avzy1ycstr6c1hDLab5+06gQUqyfA7wrm9OGlEdv9N+ywM/ch/HFPQPgyocYWiDI5Plgs3IxFzr70LAeAGOip/x1cU6Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511470; c=relaxed/simple;
	bh=kmT7ytZO+/KgbmmtdA/VbzVojfVaE3Fk0xK5Xy+kPP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=en/D43svixOn/Y2SqgfbdtOEX9h0BwQcVMj0t3YJH25NdUYgs6vy0DjdOki0CLZFQhgjpTUldu4l2P4jaMNkgV5z6rf+4YezxuXpVs692Z5Fan/U2A6RA9F2P9OjhcrZ/DTX4PDu0eovIf8lmflDxo3ep6B74UXk7944dviE+U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pMwNkn6o; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCL4MTwfJ7Ro9rqxFO6OzIwMD4XG4eNg4TbY3qNJ1voxJ0bLLzs5zdvq1/or39XzfFI6y67Qd6Kn0btPAaK4F8KXH7pd2jHwjsDF7q+PXl/EF0HGr3WS0R4d4oJwJJn6DEP3mkKpz50OXIgBK1meB2YR+KBb3AXXo8l/1uLyXAL3/F70HRzTwPZXLJzKtjIqhjP24GblGmL8VPnKZ8ZXPJV7v/VF1pFCYcYyhXAftCLh5m2THAQ7iN2SPP6BdxvCQw/y+eXLe5XReeXnrtiQVLa6/YfEKYNB39kGDZblndX0BqEQ4/8r+T+HIG3XN9MeHOBZfYfpCbWaUcG3J71A0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws6SU4j2kUTyyd0n2Empvl9Lqh4uwAzAcWENXzTg070=;
 b=X9teqRtTrhVjLu7Zga5Z7gk4sF4uFPQJrgEs6/0/oxhnUXe1xtXUihRYEIz0saGXCV4Qx/ptUywcUG4q4aAEUai7R09EzJq7ROATJ2joTdIdFKq5nDu7yRogZshmUxQXAR6ttLdc2eJ7lVoRqX6gwimrGbeYYLHwvOQeSRBM/0tZgG4h5OX+ogkptToEV2ylxqV5D8y1b0vBJwz9r1+BFO7O6/6mjz2h9DaSkFvLVCirJX0HEmpmwQw9jouqJ3HJp6rdDIF5QfkgqCsUF0HMX/EGELQVCEHLzKah0jg7YngakYKgUhPVdbSTz47/kqAXA4rMbheOcUfyfJI6GF+sPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws6SU4j2kUTyyd0n2Empvl9Lqh4uwAzAcWENXzTg070=;
 b=pMwNkn6oBq1wem7VN4rgyT9W2BcU+vIckkIFUPYth6EQgOPAeoLr6eJQoaXKV6cWx5T8lvZhlF96yPstaz7yHyiSTU3O8aebvEJNydl2vA8q2GxIWBZSdV6rLBvXlitgP46FURhjKDHXNvH7XUHnu8L242IxJpMl4+u0LszdbjI+kcP+uYVcKaEoUF2iu2SXg+kkFh8Dc/HVr60MG5zJW2ax0VJtRuGxyP24kQIYOo3sCh6anONmQv3nnURAoqLgaPsZNK+TOVOFjQ44gTlHZN122KvuzIQM170RKOtoPjXKA3yMwSnPF1GT/+EXfblUdf5nFdvmglNmmsJ271T9eA==
Received: from MN2PR20CA0044.namprd20.prod.outlook.com (2603:10b6:208:235::13)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 18:04:18 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::a) by MN2PR20CA0044.outlook.office365.com
 (2603:10b6:208:235::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 18:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 18:04:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 11:03:57 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 11:03:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Jun 2024 11:03:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu
	<witu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 2/7] net/mlx5: Use max_num_eqs_24b capability if set
Date: Thu, 27 Jun 2024 21:02:35 +0300
Message-ID: <20240627180240.1224975-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240627180240.1224975-1-tariqt@nvidia.com>
References: <20240627180240.1224975-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a0ad8e-ab59-47e6-6bd2-08dc96d3907b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NLrSiHe7Wp1DEYY+7S50lDfISn++MGYKHg2udVHwSIjxCi4re/umUFyZwHBv?=
 =?us-ascii?Q?B0929wYpjcQsNoe1kk8llRfbFi2CQlgO/TnyxJxfdvRk5ubqCML/cg4X6Bkx?=
 =?us-ascii?Q?mIpIL6bp7QaOdjsws6ncjcXLZgqwQxX6VPGGPOuiJjD2KdOf/krAbcQUNAJ+?=
 =?us-ascii?Q?6Mq6tqVwNrrcGLVUOh+QjiBB5j2oHp8qTB+3C5B5I8IlB64JmK2FjJhDzhwS?=
 =?us-ascii?Q?xzZeBRIP5GEot5CXeePNTuY6OnqCe5U+yM7kAA8LrVoO926n8a47SxfNwE+W?=
 =?us-ascii?Q?5TgvEyV1h96Z44Hq5Q2cLAIA27q8aNcOnB1eePi5o3cx1g2qWcsLU41/D+Zg?=
 =?us-ascii?Q?bT2RxEcT+ZelOde6tYpZ/co+gYRrq6vPrw5aDUKEHNn5GFhODE9CmFJzTgTJ?=
 =?us-ascii?Q?aaeV2pBFLphbfjTrEaAcAjiAcsOmZv8puXBw/Ps0qJ93JMT5NiaQNvAC069b?=
 =?us-ascii?Q?UpjBUdQD1LLm+ivQp7eSLx9rdxu70g2vsY6yOC/qhLMnOJH+hjIx6CPrCt5n?=
 =?us-ascii?Q?QA2sImmCn6MOsgTqsy5H68KfsEln6B/RC5E8/1pToDWeG7vhMrqt7Oyra1mt?=
 =?us-ascii?Q?V4xynsdEsxtgquAQ/+kK5PzB+of4AxVqPyfUbA1Zc4yrnbo969s5egkVtByu?=
 =?us-ascii?Q?Vr968PB05RiZYpjnxhLBSMEDqqP+bI6gZ4ixLWAfgZXYB6q/b8mz82zyPs7e?=
 =?us-ascii?Q?WuGvxgAx0E6H7LvN+iPuOW1v1kdKPvMPanRBcLrsnzHN5J3In/4+VbTWVYIs?=
 =?us-ascii?Q?HKyLVaoQuftNXqOGnafdbHeMl9Eqp0VIFgo9f6vPqza/VUcnx8d+JrpgHir5?=
 =?us-ascii?Q?L4ygH6+fJelN/knpQcYT32glIIjw8yPqSuD2VwqpcyHrpppXu1Z/QeC1JI8l?=
 =?us-ascii?Q?IUnLeDbm3cswdR92t4b6Y0MjVdr2aI/zKyplTr2+7CX/1PRrvsmxr4VY1aMJ?=
 =?us-ascii?Q?KJj1KH3i94BUUpmQqg88CFuIkPSraAXSSxIkjwXU44p5L/yH06LUq8LrqDvt?=
 =?us-ascii?Q?WcFYpKvYqcBfY0yieihLl8m+F8cRQYQ2yFjWb8HN8mxwGa34u2qt0zmrX/y5?=
 =?us-ascii?Q?6IccRmWYkT/9PUemkOJ6es3YssXzg71/woJm14FTaXuQ4yb18iDg9IMEkPJx?=
 =?us-ascii?Q?xVAevPGQAg7CHMYPpa/pjBKf89CxWJ1INvcO+sGTP/soLZh+9PLFEMB3qiXw?=
 =?us-ascii?Q?GQS2W6FNbGUwpobl6BPGTdcZodz0CkFsjuQB7MfxdguRfR/kXc2em4kBUh53?=
 =?us-ascii?Q?E5ffxxid8fuArZY3g+3xZTsqHemhrPFxuCewFu9cSy64l92+1umsZyeH20rs?=
 =?us-ascii?Q?JK2o0T82/7etl6wHUDXbmL6qvJIes1hDl0yDUrIeAVqKjOXnamOyNt1NyIVz?=
 =?us-ascii?Q?V32bNBSRphlvtMbbLDWb1lub/eLKOn1KoLdohbCeST0Q/d7CTEGhmErXq81c?=
 =?us-ascii?Q?GF+Qquu0PflvYeiZFXez9I+aEjLqKt8G?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:04:18.4166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a0ad8e-ab59-47e6-6bd2-08dc96d3907b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301

From: Daniel Jurgens <danielj@nvidia.com>

A new capability with more bits is added. If it's set use that value as
the maximum number of EQs available.

This cap is also writable by the vhca_resource_manager to allow limiting
the number of EQs available to SFs and VFs.

Fixes: 93197c7c509d ("mlx5/core: Support max_io_eqs for a function")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c        |  4 +---
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h | 10 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c   |  4 +---
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 5693986ae656..ac1565c0c8af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -1197,9 +1197,7 @@ static int get_num_eqs(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_eth_enabled(dev) && mlx5_eth_supported(dev))
 		return 1;
 
-	max_dev_eqs = MLX5_CAP_GEN(dev, max_num_eqs) ?
-		      MLX5_CAP_GEN(dev, max_num_eqs) :
-		      1 << MLX5_CAP_GEN(dev, log_max_eq);
+	max_dev_eqs = mlx5_max_eq_cap_get(dev);
 
 	num_eqs = min_t(int, mlx5_irq_table_get_num_comp(eq_table->irq_table),
 			max_dev_eqs - MLX5_MAX_ASYNC_EQS);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index c38342b9f320..a7fd18888b6e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -383,4 +383,14 @@ static inline int mlx5_vport_to_func_id(const struct mlx5_core_dev *dev, u16 vpo
 			  : vport;
 }
 
+static inline int mlx5_max_eq_cap_get(const struct mlx5_core_dev *dev)
+{
+	if (MLX5_CAP_GEN_2(dev, max_num_eqs_24b))
+		return MLX5_CAP_GEN_2(dev, max_num_eqs_24b);
+
+	if (MLX5_CAP_GEN(dev, max_num_eqs))
+		return MLX5_CAP_GEN(dev, max_num_eqs);
+
+	return 1 << MLX5_CAP_GEN(dev, log_max_eq);
+}
 #endif /* __MLX5_CORE_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index fb8787e30d3f..401d39069680 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -711,9 +711,7 @@ int mlx5_irq_table_get_num_comp(struct mlx5_irq_table *table)
 
 int mlx5_irq_table_create(struct mlx5_core_dev *dev)
 {
-	int num_eqs = MLX5_CAP_GEN(dev, max_num_eqs) ?
-		      MLX5_CAP_GEN(dev, max_num_eqs) :
-		      1 << MLX5_CAP_GEN(dev, log_max_eq);
+	int num_eqs = mlx5_max_eq_cap_get(dev);
 	int total_vec;
 	int pcif_vec;
 	int req_vec;
-- 
2.31.1


