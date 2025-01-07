Return-Path: <netdev+bounces-155726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4252A037B2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E710F164B7D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255F188583;
	Tue,  7 Jan 2025 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dE2V5vlt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6411DF756
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230147; cv=fail; b=R+Kt7Hsa8bd/4wklEVF6SsyQP6zXRLppuwrFPt2ymNm/bDOMzB/5QvjtIXtiD5SBZJ84cSd9ZT0vpWbPmnzLxw2CztPAJdUy4E3kQFqMzAbBTWyNX5PjHR/4xM0msDJGKSnirn38O6yrq2GYvPez690KjkA9ZPWXOCmpeMmfCjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230147; c=relaxed/simple;
	bh=QOTBDEcHABONaOB1Kvg3quVCCG81AYZ5Bf4yMlxil74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mx/M6uKO9qNvHTntwSQz7fM70Xshy5nybUagxB+ODWh4qZc+kB2SKfw8JHaJXnr01254qAGjHHtkfsV24SWHmDnSPriCWgW01jFp9HAtjz/zpzQ5TCM9FgQFwHSiLxy8RZtPBPiFS8tXKtRf8hYgR1mzt+qSC7hmhsn7NP8RHdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dE2V5vlt; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jak5x0bbiZIURcqzhpebBovsohp645SykRHlQFPeMxmwXrpNk9M7Ndx3z1+qdhfZbju+BMfkYzXagn3W1sktuWyHODCR+h3fB/9XifsO2lVejF6DWJOmsoqd9MnnVG2J8luvxnNKwWaXXN2ZxBW+eecpq91NemsfzL6ob/kesNbVNFr9fH4xCIMFsEly7lSPc+dXRBIxO2miu53VHdaxd4N8RIuXzUNNRjLJLTlb02vy1HXEVVO7xrwKghTrbEH7AdWaeNgPgs5kUg3IWVSlL5g5Y6wwHcdS3dxe/J8bhYmzFiTEylEKUakHbBSnSyE49TaUjAGuOVu9trIOr2TvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YntWqBXOod2aeOIYa9KSopRutzYbFSo0UXnSKkrTv0=;
 b=nkGo0pu91SLMQvFJZ/80UsYG2oSc6ojEVtL09lKY79sM/IL2fwP1rTiOcJr/sBOqfaCTewi4tZkHcahjVauKEKpMDJ6JU5WHu+dpSov8A7XHGsakpluaxCrPAZ8c+L+xFlk8lAcD3WegsamDZ/DDwsCU8XZhgHvOMEeNaZNtSC/gPf+9uGEquTwdE+RIxDIkW1zWO2OBZy5X1jJBx3R/7VZDdLg6qFXORujbystNaom+F4Oldlgvq8z9eQmVDa3zJ6+yozj6T20Kc1qFVl5QN+fxzPqF4NGryqk6zhmpmxBBjWMeBHSXFY3NtGBhGlOmeurNtpPJSFcqHRE4deabsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YntWqBXOod2aeOIYa9KSopRutzYbFSo0UXnSKkrTv0=;
 b=dE2V5vltCJ39P588wi+3MqB2DYrXaSnb9DDKlakx+2g0tDGGSumfYJ3zf0i8DPGPtX4yd9CPIrAw4RNn27zmtUdEQidFT7lufb9bq9xf0oVJ4EKwvZH9m+j5WQVU72qg8XZ6e4RJUOlvBMU9uRP4SSLayAjhRunumcy7q/kyyZCD254iQ4i5UyDl0Il4jSSvg35qHqur7o5R1qSYqXJ5/HSUE48Mkh4wCUQ852ORITj0sOoHjcdnXndf3vmT72nD2mF/pCVrbFzlt+jzQwGXAymzyD6wHOqMzHBB8GUgcxgOeV3VKsgzOnoY086v9U39gtSLj4yro0qnKG7nigfkrw==
Received: from CH0P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::22)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 06:08:57 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::f1) by CH0P221CA0022.outlook.office365.com
 (2603:10b6:610:11c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 06:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:08:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:41 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 07/13] net/mlx5: fs, manage flow counters HWS action sharing by refcount
Date: Tue, 7 Jan 2025 08:07:02 +0200
Message-ID: <20250107060708.1610882-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250107060708.1610882-1-tariqt@nvidia.com>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: eef99e0d-a689-4842-de5e-08dd2ee1c581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t7EuO4p1SU/9eJqh5XFmt+TonTouOU6LPZop7c7HdkrzG+ILkDME/0F6EZnJ?=
 =?us-ascii?Q?3vnmLsQHWTOZKtA9efCVXDXUa4HpI5p1fpLv8dR2AJ+c3qFm3Np3k+T8uZ1i?=
 =?us-ascii?Q?7lhLqo2x1+S7XBV1AvaS/Sk7rL3JaZQjh7jCq9TzEKWFnZ+rUxbSORPKjD2s?=
 =?us-ascii?Q?loxv3b1zVskRLPq4Me9D8ySQnqm7h3Mi7QkBfkb0F4IsVSezf+hSInc6aGD/?=
 =?us-ascii?Q?rYVhnUw72u/ZD3+BHSKJSu4wNoZUsVABKIjuRD4XOSiRk9e4SKuTmhBgg4aA?=
 =?us-ascii?Q?5JGjAf4xwSd/MDUIXaRi7e4TmAJm/J6KkGfbZlDxJwIrD2tNDOW2tyFZQCsu?=
 =?us-ascii?Q?TNYtR8/W3TT3mWe9H3exXMiLtOUMBqACK2Rbwdjx/h5UxGlDEFUJrfjOOX9c?=
 =?us-ascii?Q?NLhBDyXCYOj2jPFbDd4PAjfGzCswrtc5nqdKcgL36ws7B9dWJY6UMcVp1Jk6?=
 =?us-ascii?Q?1nOhL2WygjlNSNT5T3AwLmXQAdXtmKozjUi+ERkEVnwk9+T5Zo/JJrSJs/+Q?=
 =?us-ascii?Q?lo7cEIOCseK0j88S48yuCzk5XugfSbVvhRqzIzatDA+duEsDq1NFlZta7nL+?=
 =?us-ascii?Q?Jt7Gqk3I+b48bmK3kYmK2CBuXGzUO6o3uOQAQccMnPMq9l4He3VwHtvYEGFE?=
 =?us-ascii?Q?U7u936K286MDzz54m1K2K+7a5PfJoHzE72bBykc4uBc+LIGfoxdXg3ynfpWr?=
 =?us-ascii?Q?KoTO8d3HWJzyf5FqOr9BjKkuw6mxnB8kZftLB9yRQvpYDaTcb8sX4yCzPfbV?=
 =?us-ascii?Q?J5M5NY2dA6lF+NeaKCKcMZ6y85OOeBbSR3J19t7QzOeip/KUvSynge7cGC6b?=
 =?us-ascii?Q?uSiVCFCau8Es0ebSfW7ooIsEKjNjaRjRQ5gMNPGn1Z2vb11aDa6dSW6e6rpa?=
 =?us-ascii?Q?pWd0K2VjyI0uTR+OJ0MZ6uhfeilhlZoy54pv6LzT0NrUEYQtkBW/UfaraXBV?=
 =?us-ascii?Q?GuH914qOUWYzVWkrdMRan/LgrmzW7NXnCzKbbIFkko3Pu6A8IB9YRNkZM7wU?=
 =?us-ascii?Q?5WJcbhHcdJtEavNc/+QjCFMa+ndhILHv/PVubFDLmKAltG8rKDNJ5sZ4SeL1?=
 =?us-ascii?Q?DpArmI2HAxTeLLVZ84pJbkbZcAiKLDgbPCUDE8/yPNlkHuGB6AiHS3Tg+Xsh?=
 =?us-ascii?Q?vC0Rdn9d4Av9orPTc39B+VxHz7JpZzsWlJ6sUTDSDg87HEvd9lMVWfnEeoiX?=
 =?us-ascii?Q?vsZJhzaWpFIfp/1Z7M4oZfMP6LHUrFyrOU3/+hosFiCqEGI7s2RSd0VcbwMt?=
 =?us-ascii?Q?TEJiKC/Df9E8/IRLYT+3boBszyrn6p3Db40KDgg650+1HQ1riievefPBc1L3?=
 =?us-ascii?Q?0oW8uh9hqvX4mh2TsjfgYJVmfqd+LUAcagrm0rXz/Q3vzxJ0MVG3jKhW6NRB?=
 =?us-ascii?Q?o48RijTGXT0tm6vft+f4E5DlL7PJunr6RhebcMIbYjWq800ZTJMrT6+1XV8U?=
 =?us-ascii?Q?s6ORbT0tKCTEiSztdLoP1/DSE8EiHwR0/OgmUcqJxy8I4RMgr8okRqyLFIL6?=
 =?us-ascii?Q?oh74nImxyDoYn3g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:08:57.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef99e0d-a689-4842-de5e-08dd2ee1c581
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462

From: Moshe Shemesh <moshe@nvidia.com>

Multiple flow counters can utilize a single Hardware Steering (HWS)
action for Hardware Steering rules. Given that these counter bulks are
not exclusively created for Hardware Steering, but also serve purposes
such as statistics gathering and other steering modes, it's more
efficient to create the HWS action only when it's first needed by a
Hardware Steering rule. This approach allows for better resource
management through the use of a reference count, rather than
automatically creating an HWS action for every bulk of flow counters.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h | 36 ++++++++++++++
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 37 ++++-----------
 .../mlx5/core/steering/hws/fs_hws_pools.c     | 47 +++++++++++++++++++
 .../mlx5/core/steering/hws/fs_hws_pools.h     |  3 ++
 4 files changed, 94 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 06ec48f51b6d..b6543a53d7c3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -316,6 +316,42 @@ struct mlx5_flow_root_namespace {
 	const struct mlx5_flow_cmds	*cmds;
 };
 
+enum mlx5_fc_type {
+	MLX5_FC_TYPE_ACQUIRED = 0,
+	MLX5_FC_TYPE_LOCAL,
+};
+
+struct mlx5_fc_cache {
+	u64 packets;
+	u64 bytes;
+	u64 lastuse;
+};
+
+struct mlx5_fc {
+	u32 id;
+	bool aging;
+	enum mlx5_fc_type type;
+	struct mlx5_fc_bulk *bulk;
+	struct mlx5_fc_cache cache;
+	/* last{packets,bytes} are used for calculating deltas since last reading. */
+	u64 lastpackets;
+	u64 lastbytes;
+};
+
+struct mlx5_fc_bulk_hws_data {
+	struct mlx5hws_action *hws_action;
+	struct mutex lock; /* protects hws_action */
+	refcount_t hws_action_refcount;
+};
+
+struct mlx5_fc_bulk {
+	struct mlx5_fs_bulk fs_bulk;
+	u32 base_id;
+	struct mlx5_fc_bulk_hws_data hws_data;
+	struct mlx5_fc fcs[];
+};
+
+u32 mlx5_fc_get_base_id(struct mlx5_fc *counter);
 int mlx5_init_fc_stats(struct mlx5_core_dev *dev);
 void mlx5_cleanup_fc_stats(struct mlx5_core_dev *dev);
 void mlx5_fc_queue_stats_work(struct mlx5_core_dev *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 94d9caacd50f..492775d3d193 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -44,28 +44,6 @@
 #define MLX5_FC_POOL_MAX_THRESHOLD BIT(18)
 #define MLX5_FC_POOL_USED_BUFF_RATIO 10
 
-enum mlx5_fc_type {
-	MLX5_FC_TYPE_ACQUIRED = 0,
-	MLX5_FC_TYPE_LOCAL,
-};
-
-struct mlx5_fc_cache {
-	u64 packets;
-	u64 bytes;
-	u64 lastuse;
-};
-
-struct mlx5_fc {
-	u32 id;
-	bool aging;
-	enum mlx5_fc_type type;
-	struct mlx5_fc_bulk *bulk;
-	struct mlx5_fc_cache cache;
-	/* last{packets,bytes} are used for calculating deltas since last reading. */
-	u64 lastpackets;
-	u64 lastbytes;
-};
-
 struct mlx5_fc_stats {
 	struct xarray counters;
 
@@ -434,13 +412,7 @@ void mlx5_fc_update_sampling_interval(struct mlx5_core_dev *dev,
 					    fc_stats->sampling_interval);
 }
 
-/* Flow counter bluks */
-
-struct mlx5_fc_bulk {
-	struct mlx5_fs_bulk fs_bulk;
-	u32 base_id;
-	struct mlx5_fc fcs[];
-};
+/* Flow counter bulks */
 
 static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
 			 u32 id)
@@ -449,6 +421,11 @@ static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
 	counter->id = id;
 }
 
+u32 mlx5_fc_get_base_id(struct mlx5_fc *counter)
+{
+	return counter->bulk->base_id;
+}
+
 static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev,
 						void *pool_ctx)
 {
@@ -474,6 +451,8 @@ static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev,
 	for (i = 0; i < bulk_len; i++)
 		mlx5_fc_init(&fc_bulk->fcs[i], fc_bulk, base_id + i);
 
+	refcount_set(&fc_bulk->hws_data.hws_action_refcount, 0);
+	mutex_init(&fc_bulk->hws_data.lock);
 	return &fc_bulk->fs_bulk;
 
 fs_bulk_cleanup:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
index 60dc0aaccbba..692fd2d2c0ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
@@ -400,3 +400,50 @@ bool mlx5_fs_hws_mh_pool_match(struct mlx5_fs_pool *mh_pool,
 			return false;
 	return true;
 }
+
+struct mlx5hws_action *mlx5_fc_get_hws_action(struct mlx5hws_context *ctx,
+					      struct mlx5_fc *counter)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5_fc_bulk *fc_bulk = counter->bulk;
+	struct mlx5_fc_bulk_hws_data *fc_bulk_hws;
+
+	fc_bulk_hws = &fc_bulk->hws_data;
+	/* try avoid locking if not necessary */
+	if (refcount_inc_not_zero(&fc_bulk_hws->hws_action_refcount))
+		return fc_bulk_hws->hws_action;
+
+	mutex_lock(&fc_bulk_hws->lock);
+	if (refcount_inc_not_zero(&fc_bulk_hws->hws_action_refcount)) {
+		mutex_unlock(&fc_bulk_hws->lock);
+		return fc_bulk_hws->hws_action;
+	}
+	fc_bulk_hws->hws_action =
+		mlx5hws_action_create_counter(ctx, fc_bulk->base_id, flags);
+	if (!fc_bulk_hws->hws_action) {
+		mutex_unlock(&fc_bulk_hws->lock);
+		return NULL;
+	}
+	refcount_set(&fc_bulk_hws->hws_action_refcount, 1);
+	mutex_unlock(&fc_bulk_hws->lock);
+
+	return fc_bulk_hws->hws_action;
+}
+
+void mlx5_fc_put_hws_action(struct mlx5_fc *counter)
+{
+	struct mlx5_fc_bulk_hws_data *fc_bulk_hws = &counter->bulk->hws_data;
+
+	/* try avoid locking if not necessary */
+	if (refcount_dec_not_one(&fc_bulk_hws->hws_action_refcount))
+		return;
+
+	mutex_lock(&fc_bulk_hws->lock);
+	if (!refcount_dec_and_test(&fc_bulk_hws->hws_action_refcount)) {
+		mutex_unlock(&fc_bulk_hws->lock);
+		return;
+	}
+	mlx5hws_action_destroy(fc_bulk_hws->hws_action);
+	fc_bulk_hws->hws_action = NULL;
+	mutex_unlock(&fc_bulk_hws->lock);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
index eda17031aef0..cde8176c981a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
@@ -67,4 +67,7 @@ void mlx5_fs_hws_mh_pool_release_mh(struct mlx5_fs_pool *mh_pool,
 				    struct mlx5_fs_hws_mh *mh_data);
 bool mlx5_fs_hws_mh_pool_match(struct mlx5_fs_pool *mh_pool,
 			       struct mlx5hws_action_mh_pattern *pattern);
+struct mlx5hws_action *mlx5_fc_get_hws_action(struct mlx5hws_context *ctx,
+					      struct mlx5_fc *counter);
+void mlx5_fc_put_hws_action(struct mlx5_fc *counter);
 #endif /* __MLX5_FS_HWS_POOLS_H__ */
-- 
2.45.0


