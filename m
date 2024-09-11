Return-Path: <netdev+bounces-127547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F20975B8C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7681F23482
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4219A1BB6A7;
	Wed, 11 Sep 2024 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOXzw1R6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8AD1BB6A3
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085883; cv=none; b=kzWfxoNNLIsDeco2ahGRUDNDGLx4IKQnbt+Ii5tk6nnhptjOisztJMn9YyNjwe1JU0GUM7W2wMMCiX7CQzzTLjimOP7muHcjEqc2f4ngcab9LhuEAizS9q1SuulntmzLRu0muRn3fh0NSDEN931JPfZlnadyBZOqD726RS8z5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085883; c=relaxed/simple;
	bh=ee+P0FxBP1RKQQ0qKPtlAHTqufqpBeNmaRPPK4O4W2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX/r8b4TXsGTSuNhpxysgwiHHPbvQH2YFUD0Pc0g73FDRMdSUu01OJRawXVcMKq7um3bDEcd4CM0duVS/qxtTn+/j6uGGzwSe5RkPYDl9nVdaoydEfxFNOqqIxOfYBMgwIKJQm4n01sZCAVTG/QMKs2Nc9k5X5JsHRfHEfvYCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOXzw1R6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A610AC4CECD;
	Wed, 11 Sep 2024 20:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085882;
	bh=ee+P0FxBP1RKQQ0qKPtlAHTqufqpBeNmaRPPK4O4W2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOXzw1R6A+l6E8ncmZTboEAmIADNsdqAw/isiE/D6qnrVS5Gehjsw5Cm4w+vk7psy
	 z1KMfTWPYJLG/rKW1xG4gxMVhTAev2F4a2r+QRQ9AK4ntdJDsUs3TVLz4tbEx9R8Tu
	 UHT8ZZ7IKhlc+sqCW12bM18pZM6Iall7G4h4zZKm+nTgORMvhmQ6W7MYmSFetDTfF4
	 W/zIt8MNz0tUQO8kM75M4kilG5/W88zokbDtRf/bWg5LNi3ErNpuG18kKkpv0jGAMq
	 07YyMJTXsQFhPSVbYfwRPc0AkR6L9ANqnikIkRxkSapnaWc9oxNd94og01oyt/Tuz5
	 7G/ik45r1UM3g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net-next 03/15] net/mlx5: fs, move steering common function to fs_cmd.h
Date: Wed, 11 Sep 2024 13:17:45 -0700
Message-ID: <20240911201757.1505453-4-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

As preparation for HW steering support in fs core level, move SW
steering helper function that can be reused by HW steering to fs_cmd.h.
The function mlx5_fs_cmd_is_fw_term_table() checks if a flow table is a
flow steering termination table and so should be handled by FW steering.

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.h  |  8 +++++++
 .../mellanox/mlx5/core/steering/fs_dr.c       | 24 +++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
index 53e0e5137d3f..7eb7b3ffe3d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
@@ -124,4 +124,12 @@ const struct mlx5_flow_cmds *mlx5_fs_cmd_get_fw_cmds(void);
 
 int mlx5_fs_cmd_set_l2table_entry_silent(struct mlx5_core_dev *dev, u8 silent_mode);
 int mlx5_fs_cmd_set_tx_flow_table_root(struct mlx5_core_dev *dev, u32 ft_id, bool disconnect);
+
+static inline bool mlx5_fs_cmd_is_fw_term_table(struct mlx5_flow_table *ft)
+{
+	if (ft->flags & MLX5_FLOW_TABLE_TERMINATION)
+		return true;
+
+	return false;
+}
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
index 50c2554c9ccf..40d06051cdc6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
@@ -9,14 +9,6 @@
 #include "fs_dr.h"
 #include "dr_types.h"
 
-static bool dr_is_fw_term_table(struct mlx5_flow_table *ft)
-{
-	if (ft->flags & MLX5_FLOW_TABLE_TERMINATION)
-		return true;
-
-	return false;
-}
-
 static int mlx5_cmd_dr_update_root_ft(struct mlx5_flow_root_namespace *ns,
 				      struct mlx5_flow_table *ft,
 				      u32 underlay_qpn,
@@ -70,7 +62,7 @@ static int mlx5_cmd_dr_create_flow_table(struct mlx5_flow_root_namespace *ns,
 	u32 flags;
 	int err;
 
-	if (dr_is_fw_term_table(ft))
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->create_flow_table(ns, ft,
 								    ft_attr,
 								    next_ft);
@@ -110,7 +102,7 @@ static int mlx5_cmd_dr_destroy_flow_table(struct mlx5_flow_root_namespace *ns,
 	struct mlx5dr_action *action = ft->fs_dr_table.miss_action;
 	int err;
 
-	if (dr_is_fw_term_table(ft))
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->destroy_flow_table(ns, ft);
 
 	err = mlx5dr_table_destroy(ft->fs_dr_table.dr_table);
@@ -135,7 +127,7 @@ static int mlx5_cmd_dr_modify_flow_table(struct mlx5_flow_root_namespace *ns,
 					 struct mlx5_flow_table *ft,
 					 struct mlx5_flow_table *next_ft)
 {
-	if (dr_is_fw_term_table(ft))
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->modify_flow_table(ns, ft, next_ft);
 
 	return set_miss_action(ns, ft, next_ft);
@@ -154,7 +146,7 @@ static int mlx5_cmd_dr_create_flow_group(struct mlx5_flow_root_namespace *ns,
 					    match_criteria_enable);
 	struct mlx5dr_match_parameters mask;
 
-	if (dr_is_fw_term_table(ft))
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->create_flow_group(ns, ft, in,
 								    fg);
 
@@ -179,7 +171,7 @@ static int mlx5_cmd_dr_destroy_flow_group(struct mlx5_flow_root_namespace *ns,
 					  struct mlx5_flow_table *ft,
 					  struct mlx5_flow_group *fg)
 {
-	if (dr_is_fw_term_table(ft))
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->destroy_flow_group(ns, ft, fg);
 
 	return mlx5dr_matcher_destroy(fg->fs_dr_matcher.dr_matcher);
@@ -279,7 +271,7 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 	int err = 0;
 	int i;
 
-	if (dr_is_fw_term_table(ft))
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->create_fte(ns, ft, group, fte);
 
 	actions = kcalloc(MLX5_FLOW_CONTEXT_ACTION_MAX, sizeof(*actions),
@@ -740,7 +732,7 @@ static int mlx5_cmd_dr_delete_fte(struct mlx5_flow_root_namespace *ns,
 	int err;
 	int i;
 
-	if (dr_is_fw_term_table(ft))
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->delete_fte(ns, ft, fte);
 
 	err = mlx5dr_rule_destroy(rule->dr_rule);
@@ -765,7 +757,7 @@ static int mlx5_cmd_dr_update_fte(struct mlx5_flow_root_namespace *ns,
 	struct fs_fte fte_tmp = {};
 	int ret;
 
-	if (dr_is_fw_term_table(ft))
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->update_fte(ns, ft, group, modify_mask, fte);
 
 	/* Backup current dr rule details */
-- 
2.46.0


