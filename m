Return-Path: <netdev+bounces-134906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3068F99B8A4
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37DF1F21DFF
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C304513B297;
	Sun, 13 Oct 2024 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hrlmJbO3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0FB3D6A
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802018; cv=fail; b=WIWM1f1imKgVQ2IvWBZTd8Gq4Bd9IB7002ARSNU/eEomBjkD4AVFELBgMMB8Tq6GVSTTDtjSibmBuhHcScjuZdWtCfE/YBI1oZuyBv1Lj8/JhYfANFdRE6SkaAevbgQlaOEgV126akh/jvtcaZYhdt09aGERF0iaO27UR96BTDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802018; c=relaxed/simple;
	bh=DXkK4j9q686b7ef9ZjQgFhRr+rGgg/+Opq/S1Cl1JSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGrIgiaRkWlChCfyU33Yh0PgkzJv8b8ZooOGf3PCLKu+SqWlQydeUaUzdUPCe74h9h2yS/XkLfJdpaFtIZr4Q/QzH9SQTfFt4MFHvM6bqTEqo8dLWxSpDgNKZrwcK/gIDc8yr76USAPaqOId2eNEc+1jraCL05kj3tkB3gDrezU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hrlmJbO3; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnpsgpiPjC8YN1r9x0Gj++JUQ7jrJfMOQClibGtW4GGrY9ckknqowleSSv+mIPc1NeM2S2Mi1eVLFECDYWckWpzC0cqkQ+u9RcpDSwu/cfli5aZq4mpBcvGBdlRC/e/+79egAbyJYOp+g9ni1D02XQjJIVsSIydO+LR+35eOFLeKvZp/SljnvX3+LQxWl26/L7Yc4nat/aKAXybtrvhI5uPAhOrgybf57C77l1OWstBgvJkuiRMa6W++bBMiwE68miRyXDha3azNP3iahIbuQViycjfoo4a4S3crY8XA8noCda/pBQ8H/JDSue+9w4kBvEWRznmJ5OQ8L3b+B8IEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbeDVJdHozwBEsDT900VyLDuGBmKYfVLJD/nBmaUdNw=;
 b=MMpwQj37qQ2pNsf2UJ4vAERuOzQ7mtOTL0CCPqhiS7F98PBjncZqnk+O/L2BH0oElM3M4E00QLwqSgagnu5XoqoWLBSNEYdKii3RaDQ9YHnn8TmD/+OIO4UurBIEMv3jt6h4jD7EY665Q5CHeoGAmYtr3R+bQQF/IkJMHOgaxznICfFtvOneeuW9RmJq5ZTDTqVRl60lNe5uwBJhLhoVZyQ2lpLdlzYfuxXEN0rDUaOMcgdzPk+8KWLYyKfPVvwLn+IeCE8MQXCfP1utkTMbjc3uIJC8lKdpuKVSYAxfw6TBzp89sUkw8a6UNeoUtG2N6CLlqn8OQqzcdzA926YEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbeDVJdHozwBEsDT900VyLDuGBmKYfVLJD/nBmaUdNw=;
 b=hrlmJbO3RKSBZRYyMmkvROOrClgope7JAIqdP+NtRqQnosmAQxaCW081fvLVnU/LjD+irdB0b7AQBzp3L62UshnQhFsa7/ny6JgZ1q3RDZ8DMS1fPNs8KRu3w558fvPW2ydgwWXuGRc8TeTO18wsaNibleLd4NYoF9IzUYACaB9KhNKm+629weRX9cgfWN2LNubmn/ge1QbeEswXVJCFwjOcfeyHbiX0Vbc88g/P437QRf10ry4jlXhpHxq61NvicqnPvq4r8QeErYK2WTuhzQp4ReM8V6if3XGhVKNn9uVttJ/hL5KQ8r0CEkw4ZbWdsIHnY4G++22aFbbL3qEC+w==
Received: from CH5P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::23)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sun, 13 Oct
 2024 06:46:53 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::cf) by CH5P221CA0022.outlook.office365.com
 (2603:10b6:610:1f2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 09/15] net/mlx5: Remove vport QoS enabled flag
Date: Sun, 13 Oct 2024 09:45:34 +0300
Message-ID: <20241013064540.170722-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241013064540.170722-1-tariqt@nvidia.com>
References: <20241013064540.170722-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fde36d-5851-4243-1c2e-08dceb52d1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7mm9BEriLG4afeKVRip2N1dLLj7owQ7waiWiJ4Sd0+K3K4hszZxbBg4kVBP5?=
 =?us-ascii?Q?row6H/AojZNJIpQbC8F1wlfIkez4jbP68lAizpLw7ElOP5atLXMVpu7dN52q?=
 =?us-ascii?Q?bQnkQ1Us7Y7I60jRHOLiscBqyu11KJiowwwDgnZBetIBHkcgamvXc4TayusS?=
 =?us-ascii?Q?PF3uVj6rNvxKmN/gtCB1Ls/DSRJ+KkS/xin8IwRh5SHLGjv1rL1NDO1fWa8/?=
 =?us-ascii?Q?z8rdVXFRSuDIggl7BdGcxKT+XZP7EFimaB7axOoJKAGQTuAwgBM3QFTPzG+N?=
 =?us-ascii?Q?LzZm7iiGr2vertvKWRB7VjWNAtmwlOG/M0C1GiskRLdHIW+EVms4GpBYMJKn?=
 =?us-ascii?Q?nvXlw73iB51LUX6FaaoDec0tUJbJW90CASBVJALY33oG9EyAxigfdKHlqmI+?=
 =?us-ascii?Q?f6MX/LZV8YsJBaHNgUhYx6IRSHjUUOCLUZ09XD99euZFPJt8B9KFJtgv3W/G?=
 =?us-ascii?Q?H7/D0ooX0PEoYHwdmrrB9hqmZQzAs1OmeXpk666glB2z4dFtup0TCX4gxd7D?=
 =?us-ascii?Q?sGoZTTpSRhfpUUjhz5w2J03PFgwP9RYORyu/pqxO9ypi9xvAeSogG+of7NkO?=
 =?us-ascii?Q?coZjXQhK+kLi7x71ULFDoTGKTDGc9W/jTjm/TjohWREUF7kZBx2fJILuSWve?=
 =?us-ascii?Q?J5e/th8eTGGg9jydjWbd+GxZUm3WQhoBJMf0rQbEiW5k1QaVykxvEfesNA7X?=
 =?us-ascii?Q?D5auYG8gTocFdWKW5r5g8ZRnUbpUAInUKiSImnPoxVw2FbP0WIvsb3LiJcVq?=
 =?us-ascii?Q?M9BggJNVymL7q7cEQumb6lJIawlOr0OgBPdCWa/cmGfJj4RKY9OHyuMe5P6V?=
 =?us-ascii?Q?NQPxezPFJlikFp0jmXGuoaIlLd3b2uAANRcf3+fsjYjomdlsXgVaiM2W5ojb?=
 =?us-ascii?Q?3YXbPaP/boRW+otwRWU2I3vL8RRL6pVE10DmE1GQf3NcAt4e+JtEIhS2wmf+?=
 =?us-ascii?Q?5wu1CeeawO6NwUnmC0OpwMqkagzQiWtfiZcxebHnndRalPmb3S8cX41g8alL?=
 =?us-ascii?Q?Z0Mkmq5RrdNFIt5+agjzGtYhR8S/0T7aEMDipjQnqn8uAiTRN0vA3jEmho40?=
 =?us-ascii?Q?qA3fas3YkCtsMsiGiJv/drmWXu54sg7ZDGZ7EhL3l9u0pnq4BJA1ShgEKohb?=
 =?us-ascii?Q?R3xfhLCJ7MC2D6qZXLG1fEl2N69YClLuUtSwyhO/n5snFfh8U2FjCEuzNqzp?=
 =?us-ascii?Q?zSuLIUhQcpxswNSWWx7D4ST/U6O/4FRZqd97uwCqbP4ZMDqd+r/cPx4htyZp?=
 =?us-ascii?Q?MAvLid7wWP9KUTwju4TurWgTAQaxjRfQqcYOKt/exs1MULvtY7a3VD383p4o?=
 =?us-ascii?Q?IahLCHvmvE9+lEfy+2D4qgKyYyyloHBn5FWcUk2QbrW//k0w6FtvKTv3GPYT?=
 =?us-ascii?Q?JiOB1zBW0cTfRhbmsCztDVeW2Iad?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:51.4724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fde36d-5851-4243-1c2e-08dceb52d1a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

From: Carolina Jubran <cjubran@nvidia.com>

Remove the `enabled` flag from the `vport->qos` struct, as QoS now
relies solely on the `sched_node` pointer to determine whether QoS
features are in use.

Currently, the vport `qos` struct consists only of the `sched_node`,
introducing an unnecessary two-level reference. However, the qos struct
is retained as it will be extended in future patches to support new QoS
features.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 13 ++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 --
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 571f7c797968..0f465de4a916 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -742,7 +742,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	int err;
 
 	esw_assert_qos_lock_held(esw);
-	if (vport->qos.enabled)
+	if (vport->qos.sched_node)
 		return 0;
 
 	err = esw_qos_get(esw, extack);
@@ -759,7 +759,6 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	if (!vport->qos.sched_node)
 		goto err_alloc;
 
-	vport->qos.enabled = true;
 	vport->qos.sched_node->vport = vport;
 
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
@@ -785,9 +784,9 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 
 	lockdep_assert_held(&esw->state_lock);
 	esw_qos_lock(esw);
-	if (!vport->qos.enabled)
-		goto unlock;
 	vport_node = vport->qos.sched_node;
+	if (!vport_node)
+		goto unlock;
 	WARN(vport_node->parent != esw->qos.node0,
 	     "Disabling QoS on port before detaching it from node");
 
@@ -834,7 +833,7 @@ bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *m
 	bool enabled;
 
 	esw_qos_lock(esw);
-	enabled = vport->qos.enabled;
+	enabled = !!vport->qos.sched_node;
 	if (enabled) {
 		*max_rate = vport->qos.sched_node->max_rate;
 		*min_rate = vport->qos.sched_node->min_rate;
@@ -931,7 +930,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.enabled) {
+	if (!vport->qos.sched_node) {
 		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
 		err = esw_qos_vport_enable(vport, rate_mbps, vport->qos.sched_node->bw_share, NULL);
 	} else {
@@ -1140,7 +1139,7 @@ int mlx5_esw_qos_vport_update_node(struct mlx5_vport *vport,
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.enabled && !node)
+	if (!vport->qos.sched_node && !node)
 		goto unlock;
 
 	err = esw_qos_vport_enable(vport, 0, 0, extack);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index e77ec82787de..14dd42d44e6f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -214,8 +214,6 @@ struct mlx5_vport {
 
 	/* Protected with the E-Switch qos domain lock. */
 	struct {
-		/* Initially false, set to true whenever any QoS features are used. */
-		bool enabled;
 		/* Vport scheduling element node. */
 		struct mlx5_esw_sched_node *sched_node;
 	} qos;
-- 
2.44.0


