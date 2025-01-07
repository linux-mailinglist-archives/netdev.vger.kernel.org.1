Return-Path: <netdev+bounces-155728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5440A037B3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 099067A2428
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD241DEFC8;
	Tue,  7 Jan 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebFXdSrA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9CD1C3BFE
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230162; cv=fail; b=ezEEPe61IJdX4FsP3DnZaPIfBIZGRxPWc4vmEUGLx0sNCUS5GS5wCtQFgKHpU5DQth4h8FdZLTUOf/ZlNCaTtT9c/8Z5kByjGL55AL+0qQMELNqHT99vsU25G2j75yJzoFxNh2/DvtApgMknoYkzPGSfzOc9XFgicHtRd0jK0fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230162; c=relaxed/simple;
	bh=z8EYEPyodgg8WiVRZl9VFlf+BGTAUf5pN81rzDbFqio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUpoXPadkv//95PBTMBvNgDb3pQpgXMeEmLth2eJ17euYBXvVn+kei+XZ8GC1BX/BpF+zhY/4yipjmMwNWEvLVGe2Qo5tkV8k6SnUksLI9JbCb8zknrA/p4phdCpCdADRMByYWgvR+FcMeogOZ3JD/RXXFlLiRTfoLylG1fLZS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebFXdSrA; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6d7WgGcWrU8WSzwR6XpC+rqGOQcuqv+C7d2CM9/gfO+0So+3NISDX2JcTK/kT/RnzCp8sNkFspXtR0tyN06xYH7LF8xkzGDsmxXNBiCYAYGoDR2DGmaAmabQXWY+nWmHlTaIRQbTxURmZk64JP/FbGAYidPG/lDBbVbAOgQ1cQld1X0hCMKgzR23wisQguJV4PUK+AoZdOofWeFSIBoAhUArrsadGELzqU4FN+4rjYz9z2UribNhBoBCHtLeKzNqKslSLDOrc8fHWTC8xNUSW9nlIYqSkoCva6iJwIXmfPMvwa0K5fY13w88mmAgFS9mArwiauLXn05XfVLCivgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0jNjf1s7HPnIgu0v+ZTsOnR3srafQtwiMvKElaw/vQ=;
 b=fa42geAcY62wJld7/hTio2UIF0SbyNZUfi386i9lr/s8N5e0LPXYwff7lJqNGYZC1Gy/AcAmgA6zJpdzpBc+26V4TJwd2Ik97TdLfTVdjm9jDfHJWySfqbGfVP0+GIXmqDf9OuhH7PK2YDZbU7KLqHEuutFVgz0ZxOukF6AbfxmGgnBhPixtttz/yB0AZVE63R/Gbm1pJ7nD7JjkBxp+SNFsFhwRrgPBUf3ihgx2dXy4F90f9keqgBEtlef9QpUF102YrbxaiTVTUkuTQMHibQoaSxobVWIghpMQrTp4KGmcUks/kVZGyYtM4ZqYvxtw1hTmd4ly77dGZvP4hoKHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0jNjf1s7HPnIgu0v+ZTsOnR3srafQtwiMvKElaw/vQ=;
 b=ebFXdSrAeIMW+vkjP1y5JlkaB3kUHe+LN8QFpkOWcJOoDH7aV+l3HGtM1biomVXchYcCSNXEIhtgFO0QMBzHDGnvbhp3bjrXRFvcSSTFFwoShPyTYpdyzusdfBC8smVy95k30+glGjqNqTAqNzhHpg1MdgW25uSBa5XFDZpu703tbI5unGyOHl1ho0lREXp/4C3ZSFz6oRuwRGlmebcjk1K3W6SorhMfY5gegh4cSxyL2EjGfXIZCOYMxuFKFCQ2ZdD6wiNU4DHEvcSbRVpGt8H3Urw9RVmSsgKuNsP/fudf9852RkzpX4ljAIQd7Md23pO0+2ekCSgMECgFm2EyZg==
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:09:13 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::45) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 06:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:09:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:57 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 10/13] net/mlx5: fs, add support for dest vport HWS action
Date: Tue, 7 Jan 2025 08:07:05 +0200
Message-ID: <20250107060708.1610882-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e5efdf-c609-4e71-ddf3-08dd2ee1cee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pmnX4q/ibDr/7KaZmnp+13CvEkOmKUKZGZ62m89fE/jm+ryD49Lehnp/I0IS?=
 =?us-ascii?Q?Jztco+5eUOtxbJEe2vpoTSn7/yZUvEE30lTlWX/6+zkpw1FPkNfXamyMBFrG?=
 =?us-ascii?Q?i88pZx90vfjwi0r9TuTM9p8k4LP33LxGxXIARJFahzS9+M/gdQdwxIq5WkE2?=
 =?us-ascii?Q?aVHNdMwem72/ETFnpyEf1XS7o9t57DropG4MqxY//vUqmxS8k1JIY0xT7bHa?=
 =?us-ascii?Q?WKuVqCrFcViss7Diy8vSk+BqdUyzxR1gUCL25vxUm2nES3qeQ90F4qtjqkVL?=
 =?us-ascii?Q?ZZxg2MLxhfYnNUQJJFKyksI7Lx/RBm23pSa+wni6y+cvkQcAiZZ54SrPJaNP?=
 =?us-ascii?Q?tZ1XGHBHyao/09lyKhNIy8e0aQwYDdgIol81wI5He6X3pcHVUOpZPkJEmDfv?=
 =?us-ascii?Q?llBJGF+NvMRriBQrpL9Upw7AJu1hajYlm6KatIGzLd3doP8FYHFUNMLGJG++?=
 =?us-ascii?Q?2yy4qrI6YTXfCyzlaP+JnBiW++RnlRxx1wsxO/oT7jN4rUgI5mRqj9fq9+dG?=
 =?us-ascii?Q?W/3nRbY5yCPcRHRmmB3BOVLgSmOkn1GGIdzUhu8//oVwA34yn1GUI2juzBJR?=
 =?us-ascii?Q?mTtigpPWlPlsTxLjPQp/hzlzyPIlU76if1glsSRdKqNS0nLwA2IWrLz4s97x?=
 =?us-ascii?Q?Fj+CmxoU/Brz1G7zA3X+XBbuCr+lkEZ0CJ+eKGhH04aAxlTrWkR6KC6P+IYP?=
 =?us-ascii?Q?ecIVS4qW4yB7gxzdvScH0+tdwYmQRhXf2NzQhi2uTsZeyhDy0hulR4aLsbN2?=
 =?us-ascii?Q?hF3cOnoUchlWBqXAjQNAr6L4ceXSWykpf5v/6PLXq/lVMmZbJCboRNy6CZTf?=
 =?us-ascii?Q?VWBMnqJKumFcgLzK/89FLNMD/E2l/RlwRdAWHG6UieocVt7QUdS9lH9husq7?=
 =?us-ascii?Q?WGYEoaiEgRBqdCBUDG9NAfzlstVOqYSVFmJpZvXNlOCoLJk2dUEp0K9g7GPN?=
 =?us-ascii?Q?5enR0ra/cLSVBtvPJQrPGCGSSjKzb45IAkiITkSHEYLF5JRFxKVOzhJRdAJ6?=
 =?us-ascii?Q?sF4GeKg0e+Sz34AIWGcktxlIlSi8JRHuJUneyy7Yr8GCAIrwyCzarimBfa9R?=
 =?us-ascii?Q?yrWYwck6cP065DA7zfMo/V0xzVLYCOC+ySJR9SxC2ZrTdv0h3IxsmONrKpOA?=
 =?us-ascii?Q?BL577TJNoxF2RdVem9qtiiTW0DsSUVzUPgpVRFa/IO7T38OJ2FAq5S3/kuSd?=
 =?us-ascii?Q?zkD7qMbTcH1jCnOg/qgThz4bGn+CxPC78c1iAKcdGOOmycOzZvPNE9LpTmxK?=
 =?us-ascii?Q?2q5pcx9DafGI0F4RJxJKlteusCca2WjTX7xjg/U7BdAWhS99EuLiFnK73GRt?=
 =?us-ascii?Q?AM56SQPvU3nX7NvrR3G1Px6RH5onmnvhopPA7mHY8ydRaYw9gfokK7WyOrX1?=
 =?us-ascii?Q?jk+J1rAfLpl1llXK3ww2jwhbNRL+VfqhoQikr+4QTsdvPguPdM5stos2ulM+?=
 =?us-ascii?Q?z7IykjVHdd91JUfrgG9hKvqy4yvQIB6DTe46KP8Pt42lu1tU7w33Ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:09:12.8646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e5efdf-c609-4e71-ddf3-08dd2ee1cee8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791

From: Moshe Shemesh <moshe@nvidia.com>

Add support for HW Steering action of vport destination. Add dest vport
actions cache. Hold action in cache per vport / vport and vhca_id. Add
action to cache on demand and remove on namespace closure to reduce
actions creation and destroy.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 62 +++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  2 +
 2 files changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index e142e350160a..337cc3cc6ff6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
+#include <linux/mlx5/vport.h>
 #include <mlx5_core.h>
 #include <fs_core.h>
 #include <fs_cmd.h>
@@ -60,6 +61,8 @@ static int init_hws_actions_pool(struct mlx5_core_dev *dev,
 	xa_init(&hws_pool->el2tol2tnl_pools);
 	xa_init(&hws_pool->mh_pools);
 	xa_init(&hws_pool->table_dests);
+	xa_init(&hws_pool->vport_dests);
+	xa_init(&hws_pool->vport_vhca_dests);
 	return 0;
 
 cleanup_insert_hdr:
@@ -82,9 +85,16 @@ static int init_hws_actions_pool(struct mlx5_core_dev *dev,
 static void cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
 {
 	struct mlx5_fs_hws_actions_pool *hws_pool = &fs_ctx->hws_pool;
+	struct mlx5hws_action *action;
 	struct mlx5_fs_pool *pool;
 	unsigned long i;
 
+	xa_for_each(&hws_pool->vport_vhca_dests, i, action)
+		mlx5hws_action_destroy(action);
+	xa_destroy(&hws_pool->vport_vhca_dests);
+	xa_for_each(&hws_pool->vport_dests, i, action)
+		mlx5hws_action_destroy(action);
+	xa_destroy(&hws_pool->vport_dests);
 	xa_destroy(&hws_pool->table_dests);
 	xa_for_each(&hws_pool->mh_pools, i, pool)
 		destroy_mh_pool(pool, &hws_pool->mh_pools, i);
@@ -384,6 +394,51 @@ create_dest_action_table_num(struct mlx5_fs_hws_context *fs_ctx,
 	return mlx5hws_action_create_dest_table_num(ctx, table_num, flags);
 }
 
+static struct mlx5hws_action *
+get_dest_action_vport(struct mlx5_fs_hws_context *fs_ctx,
+		      struct mlx5_flow_rule *dst, bool is_dest_type_uplink)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5_flow_destination *dest_attr = &dst->dest_attr;
+	struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
+	struct mlx5hws_action *dest;
+	struct xarray *dests_xa;
+	bool vhca_id_valid;
+	unsigned long idx;
+	u16 vport_num;
+	int err;
+
+	vhca_id_valid = is_dest_type_uplink ||
+			(dest_attr->vport.flags & MLX5_FLOW_DEST_VPORT_VHCA_ID);
+	vport_num = is_dest_type_uplink ? MLX5_VPORT_UPLINK : dest_attr->vport.num;
+	if (vhca_id_valid) {
+		dests_xa = &fs_ctx->hws_pool.vport_vhca_dests;
+		idx = dest_attr->vport.vhca_id << 16 | vport_num;
+	} else {
+		dests_xa = &fs_ctx->hws_pool.vport_dests;
+		idx = vport_num;
+	}
+dest_load:
+	dest = xa_load(dests_xa, idx);
+	if (dest)
+		return dest;
+
+	dest = mlx5hws_action_create_dest_vport(ctx, vport_num,	vhca_id_valid,
+						dest_attr->vport.vhca_id, flags);
+
+	err = xa_insert(dests_xa, idx, dest, GFP_KERNEL);
+	if (err) {
+		mlx5hws_action_destroy(dest);
+		dest = NULL;
+
+		if (err == -EBUSY)
+			/* xarray entry was already stored by another thread */
+			goto dest_load;
+	}
+
+	return dest;
+}
+
 static struct mlx5hws_action *
 create_dest_action_range(struct mlx5hws_context *ctx, struct mlx5_flow_rule *dst)
 {
@@ -690,6 +745,8 @@ static int fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
 		list_for_each_entry(dst, &fte->node.children, node.list) {
 			struct mlx5_flow_destination *attr = &dst->dest_attr;
+			bool is_dest_type_uplink =
+				attr->type == MLX5_FLOW_DESTINATION_TYPE_UPLINK;
 
 			if (num_fs_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
 			    num_dest_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
@@ -714,6 +771,11 @@ static int fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 				dest_action = create_dest_action_range(ctx, dst);
 				fs_actions[num_fs_actions++].action = dest_action;
 				break;
+			case MLX5_FLOW_DESTINATION_TYPE_UPLINK:
+			case MLX5_FLOW_DESTINATION_TYPE_VPORT:
+				dest_action = get_dest_action_vport(fs_ctx, dst,
+								    is_dest_type_uplink);
+				break;
 			default:
 				err = -EOPNOTSUPP;
 				goto free_actions;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index d260b14e3963..abc207274d89 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -20,6 +20,8 @@ struct mlx5_fs_hws_actions_pool {
 	struct xarray el2tol2tnl_pools;
 	struct xarray mh_pools;
 	struct xarray table_dests;
+	struct xarray vport_vhca_dests;
+	struct xarray vport_dests;
 };
 
 struct mlx5_fs_hws_context {
-- 
2.45.0


