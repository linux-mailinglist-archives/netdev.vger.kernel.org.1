Return-Path: <netdev+bounces-156769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E8AA07CEB
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0933A3BCF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B5220681;
	Thu,  9 Jan 2025 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qqjMJ/hy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7832206BB
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438879; cv=fail; b=RO//6PSgUYgt7oDNqKhLFOHXEZWkxw1t6lPENUN2/YEetT/crSgVLdOcaZklpezYwEheE4GZDrBmXlStdynJjNFpJxz13x7sMaVAFvJQmFEZqo4f7fhIfHBT5KEsUJ5bj6bF+t5YT5D/jChAu0ToGzie6jGxD7lFG3m7eOgZZn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438879; c=relaxed/simple;
	bh=fWj/sZ+2uXQU1qEL5t8w9rm4ThAtpCaP2J7JO6bE1g4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m83URI+dGvqlobdX2E22vxmaeluxTTys+6JEoiW8HDy1nAxKCfnEWqQBS2RZ7Dr9nUYosVRS3oYodLy4aeoxt+tB5HYTbSSND7HvFofo0WLDnxssqsUB9gwiKxMIGOj6qlORpre41u0y1YebEzx8LLZAOSjO829tlCnny9Q+jsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qqjMJ/hy; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4pdu0kyAc7XViO7JqUHrgEgqSC35WsIdjJHz4IKx2lsucCqSvsPwulmwZJTFpgedhtldLHC7I9l7doMOqabhuJbNm53jtJGubkyhoszEpfI6zMhhAmRMs7rQkG89oo7O7IDGU+JAK6d+5L54j6pEfJdpeVyaszrbNeXSXQmVCgfVhcLTvrjTc469Umlnea9EtoSrI9KG7YnYpJom+m+s1/luGCuZmRP3PuNxR/NQujAuTw0L2T3sxKWDQMqtfJK3ADb/NHhSwss48QMbB4uhxfMD88TI623WO1fGSDpgHCncXspjqGkwyXKTJxs/fOT43s4FB6QVWJHsjFBOHn0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKXIhlRPwEqEtNLbrkEPs86V1jRa5UYG+Ss9vztOKjI=;
 b=GiKvmgnpilJLtOzmJnj1+Zkimg1JAV7WjxsMih/QdesbT2E4bg5BUKuhjUjDixgob+uC0a+QIwEzMTbaLOpqz185vQWyv+wIajolK2/eT/kL6E5oGgZQC32n23t7OOEY8P0ER9OHcRu45y/Ay6zSt1y9eVUmWbhle1b+5/ojMYtOYbTmdlArBkyRPJQqx17QmAIIACPsve3j1k4fEymEOkYJ3EvCHxyZoER0LiKZ0kaoj50q9ET5C+NJKu3d3pJBgBp8BWcBUs1VzUzfxr+d7C1/PG9eLfGTYQs1svYd15jOG0GD0oby7prxGRZrJKhHmnEOukD5maEk5TqJcnhFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKXIhlRPwEqEtNLbrkEPs86V1jRa5UYG+Ss9vztOKjI=;
 b=qqjMJ/hy5ztb+jVujdFDJ5E+jCTnsbKTKOpll0++5/Klrx8tIldc/s8mlERpkrmONEVidMwQUk4AhcSFMLFr2kS7tFreJK/rNdiJmLz4PsSOO3lVu1ahs6O8QPARQdi7Nwn8s8F6GYe68rkDU7d+WmuST8v+P2mELz3SaKAERDtr9bM022W+CU7ilfeaJOWheInJpGZAjVcz6m+31+/iOL3BID+e6VH3V0T/JNXH5PWQ5L/xrFXU62in5QDaIlVaQYlhj46IsL7zvIEJlaM+E0MZ4br+IkI0mlr3FQ88wjuZ0Gw5QfWVPvWAvIwimHX3osszCh0yAgEHzYcf7Qs9Kw==
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Thu, 9 Jan
 2025 16:07:50 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:b4:cafe::f3) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Thu,
 9 Jan 2025 16:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Thu, 9 Jan 2025 16:07:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:29 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:28 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:25 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 10/15] net/mlx5: fs, add support for dest vport HWS action
Date: Thu, 9 Jan 2025 18:05:41 +0200
Message-ID: <20250109160546.1733647-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109160546.1733647-1-tariqt@nvidia.com>
References: <20250109160546.1733647-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a08226f-8b27-44ff-f158-08dd30c7c43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cPp8/Y5YBssMGYuSmePJ3y2orkMpDK6D5TUvOqEaeF7t6bk+lwokyGK8sx6V?=
 =?us-ascii?Q?bthit1D/1RR6eWNwRzJORt5XIey5k1PQ64Lef0gVk8aLCqDFQwRj7NDMTaLy?=
 =?us-ascii?Q?mcGBc/0/MZuaidjk2CioJShv8gS3AXmm/neR8lRgWYIChtXOwQuwJz5E25wP?=
 =?us-ascii?Q?FyqLgHMZPvF2RLDUu2TjkqQJ2Kj8M9xHK6ppa/B+0j0ftattxFv82PoZAWEr?=
 =?us-ascii?Q?yXO+TevBgPdUQ34LuBx8yvLYgJFxEbEAmViW3DpzoByAGuiCiizWs4dROddV?=
 =?us-ascii?Q?RucH0zaiy2qdhaoe/pCzgCqEgnFK7SYo/2EZbXmX03CM6M/ygF5AVveDl+7M?=
 =?us-ascii?Q?jF0E4wOaqI7UE/SeVHxIhaX8f4UpIIoMTKd7gueCTd0ZR3Nmp794vxEHZhD5?=
 =?us-ascii?Q?80SWWAxF+QGXi4wwObfmRRQhjMdJjW2yc+JF5YMWlewnSRKR62gGSaMgmG80?=
 =?us-ascii?Q?EEq1qX5BtH1HMJMpAO5avie64x7lL63ZA0LMDtaNtkHpTri+K7WdeJQZ6c2w?=
 =?us-ascii?Q?rCyaS1cL4y2Ts6a5lWGjbFneXX4/9IijVKERq+gS/t/QzdXDzionrA/l0WeU?=
 =?us-ascii?Q?46DDYdfq+4UPLy7PF3ya2q6TV0wE7gNl0nXtsCSYyKy6u3aN02zCudm3ckZf?=
 =?us-ascii?Q?LlRKAjkUlGj9Mj9xNWBpDY3D/EHqqMK2xABAB2I33xXkJ8rRErcs0zfy2+bF?=
 =?us-ascii?Q?p8Wo9ErAVg4J010948aKsOWau7MzbX/YtF0IjDGek05JZWmhDqWFOmFOPyEQ?=
 =?us-ascii?Q?7stfciVfhx2K5QJ/CdkJOOMZZUveN9pDFCGXcYJcQ7Td+l72nQ7kmvTkTgbX?=
 =?us-ascii?Q?T2We8cjoDFOMpmR5jS/+6BHpWW2vXYHXMPL7qcrqHdTxXotKWbFcP1GwsWWc?=
 =?us-ascii?Q?9TU/fd341ZyqdFKjDPoMN12HIvaiskmFjucO9Z65uUdCyCLBzjB0j1FZOs59?=
 =?us-ascii?Q?jQtRkbi5Hu/t0oi7GkexbXywHGg+7EOSgBI4CqzFBMwCuDREf7XQJMeMASpY?=
 =?us-ascii?Q?GmC6knEJ2wzOh/35X3966GmVNncjJATA+T49B0PIqBokv03hBfiUD0d7EAqh?=
 =?us-ascii?Q?gBGsMR40XayIBHZyj2w7gMLoCTpiWsK0ypcFAUQR72BczwG93SPychLUEdDE?=
 =?us-ascii?Q?rfQbXdKa4OH7Hw/aSKcB5uZouXKTG4oKtmAhYcCI8Y9qucctYdy1PoQXl2tz?=
 =?us-ascii?Q?3S3v+onHGGZ97nQwUowUin06fp5p3BICVBGLEUmSfPw1jswkhUCtQ2/ctxk3?=
 =?us-ascii?Q?d592mxMZ7voIzxD75pOVzY2qnJyAeu/dVpoGF3KtmWvC9IikW+lCoyb2UUez?=
 =?us-ascii?Q?zyq6F0kDz1Wdw2A57FtAP186qbTxZiQjExPLxcBlyJoLDw1oe6hkUH2ZQXSb?=
 =?us-ascii?Q?YVx0vR0LyTQ4jtPaH5Um+LQjOx1emdmG7hCIM6abJhF0Dhs/5msWmg4iyPeX?=
 =?us-ascii?Q?96VigBamo+c6ZB5jqpTPVxse1hjG8uD+qkGo+GIcdoPW4PfplisnaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:50.4000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a08226f-8b27-44ff-f158-08dd30c7c43e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

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
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 63 +++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  2 +
 2 files changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 6a552b3b6e16..58a9c03e6ef9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2025 NVIDIA Corporation & Affiliates */
 
+#include <linux/mlx5/vport.h>
 #include <mlx5_core.h>
 #include <fs_core.h>
 #include <fs_cmd.h>
@@ -63,6 +64,8 @@ static int mlx5_fs_init_hws_actions_pool(struct mlx5_core_dev *dev,
 	xa_init(&hws_pool->el2tol2tnl_pools);
 	xa_init(&hws_pool->mh_pools);
 	xa_init(&hws_pool->table_dests);
+	xa_init(&hws_pool->vport_dests);
+	xa_init(&hws_pool->vport_vhca_dests);
 	return 0;
 
 cleanup_insert_hdr:
@@ -85,9 +88,16 @@ static int mlx5_fs_init_hws_actions_pool(struct mlx5_core_dev *dev,
 static void mlx5_fs_cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
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
 		mlx5_fs_destroy_mh_pool(pool, &hws_pool->mh_pools, i);
@@ -387,6 +397,52 @@ mlx5_fs_create_dest_action_table_num(struct mlx5_fs_hws_context *fs_ctx,
 	return mlx5hws_action_create_dest_table_num(ctx, table_num, flags);
 }
 
+static struct mlx5hws_action *
+mlx5_fs_get_dest_action_vport(struct mlx5_fs_hws_context *fs_ctx,
+			      struct mlx5_flow_rule *dst,
+			      bool is_dest_type_uplink)
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
 mlx5_fs_create_dest_action_range(struct mlx5hws_context *ctx,
 				 struct mlx5_flow_rule *dst)
@@ -695,6 +751,8 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
 		list_for_each_entry(dst, &fte->node.children, node.list) {
 			struct mlx5_flow_destination *attr = &dst->dest_attr;
+			bool type_uplink =
+				attr->type == MLX5_FLOW_DESTINATION_TYPE_UPLINK;
 
 			if (num_fs_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
 			    num_dest_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
@@ -721,6 +779,11 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 				dest_action = mlx5_fs_create_dest_action_range(ctx, dst);
 				fs_actions[num_fs_actions++].action = dest_action;
 				break;
+			case MLX5_FLOW_DESTINATION_TYPE_UPLINK:
+			case MLX5_FLOW_DESTINATION_TYPE_VPORT:
+				dest_action = mlx5_fs_get_dest_action_vport(fs_ctx, dst,
+									    type_uplink);
+				break;
 			default:
 				err = -EOPNOTSUPP;
 				goto free_actions;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index d3f0c2f5026a..9e970ac75d2a 100644
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


