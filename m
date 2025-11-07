Return-Path: <netdev+bounces-236552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D6C3DF2C
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A28188B470
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499851F0994;
	Fri,  7 Nov 2025 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty4TiV4M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255531EEA55
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474150; cv=none; b=GzpVGzuglqcn4wHKuq3U2O7XzyLT5F4tsjiTbdrvh6lr8d0q9sf/po+Zk5RuH4+EEPwiHvtPFlOkHSw+G70aFbFrHY505f/ZxL011fKyvpIY5+I3tLfFIUKUXyhYsw0KaXpVL+LvDZZar7/DTC8Tz5GZdEkw2zTm4dmk/uYHBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474150; c=relaxed/simple;
	bh=HvDn0ugRscE4byDt68PYDJAQQd8P7wziLVKaWjosbww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnGm+3Gmdo7aU3C+0qQb5nuG+y/DW2NIxkTPtelojOCZaS3UO6MFjn0vRL9LYX6vcQpzy6cbYFL5oWW3VW7iPuncH5EyNWX25HbBZn+sfNfci1r6nsXVVcuVurYBKrTNtdK27SHFQ01KKW4tzfqByPcHXN/t2PrrBM4vatS9vUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty4TiV4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C15DC4CEF7;
	Fri,  7 Nov 2025 00:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762474149;
	bh=HvDn0ugRscE4byDt68PYDJAQQd8P7wziLVKaWjosbww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ty4TiV4MvAnwKaqOERNhmGts6PjM8tzFld7LG4vRNZ72GkA6wT8KvwEBjQPO9M7dV
	 ktiBJtMD4gLbd+0k5JxsWB4Hzkgu4IoE2e2ECQfqAtOhP+AuArosH2dvcedFZPzbRe
	 gj/vW6zxZEIKN8fBaxckkcwLpAS8xI/76u78LeppQQMXPGoHYU10uPz61B7GeNIBMg
	 +9RVyE6VObrjBi9W3NJpA6/cM7+e6esrL+atztQ4GqEUsi57MqitYqYt8G+MBT3B0u
	 hf0OaBZITGaGLWLhb/UYe+QIiRxdxjohx9rzPpPJkcuk3dFCSb6+j3xT+V+FSKdqTg
	 VKeUkhoq4+ZWA==
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
	Jiri Pirko <jiri@nvidia.com>,
	mbloch@nvidia.com,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: [PATCH net-next V2 3/3] net/mlx5: E-Switch, support eswitch inactive mode
Date: Thu,  6 Nov 2025 16:08:31 -0800
Message-ID: <20251107000831.157375-4-saeed@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107000831.157375-1-saeed@kernel.org>
References: <20251107000831.157375-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Add support for eswitch switchdev inactive mode

Inactive mode: Drop all traffic going to FDB, Remove
mpfs l2 rules and disconnect adjacent vports.

Active mode: Traffic flows through FDB, mpfs table populated, and
adjacent vports are connected.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 .../mellanox/mlx5/core/esw/adj_vport.c        |  15 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   6 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 194 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   5 +
 .../ethernet/mellanox/mlx5/core/lib/mpfs.c    |   2 +-
 include/linux/mlx5/fs.h                       |   1 +
 6 files changed, 202 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
index 0091ba697bae..250af09b5af2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c
@@ -4,13 +4,8 @@
 #include "fs_core.h"
 #include "eswitch.h"
 
-enum {
-	MLX5_ADJ_VPORT_DISCONNECT = 0x0,
-	MLX5_ADJ_VPORT_CONNECT = 0x1,
-};
-
-static int mlx5_esw_adj_vport_modify(struct mlx5_core_dev *dev,
-				     u16 vport, bool connect)
+int mlx5_esw_adj_vport_modify(struct mlx5_core_dev *dev, u16 vport,
+			      bool connect)
 {
 	u32 in[MLX5_ST_SZ_DW(modify_vport_state_in)] = {};
 
@@ -24,7 +19,7 @@ static int mlx5_esw_adj_vport_modify(struct mlx5_core_dev *dev,
 	MLX5_SET(modify_vport_state_in, in, egress_connect_valid, 1);
 	MLX5_SET(modify_vport_state_in, in, ingress_connect, connect);
 	MLX5_SET(modify_vport_state_in, in, egress_connect, connect);
-
+	MLX5_SET(modify_vport_state_in, in, admin_state, connect);
 	return mlx5_cmd_exec_in(dev, modify_vport_state, in);
 }
 
@@ -96,7 +91,6 @@ static int mlx5_esw_adj_vport_create(struct mlx5_eswitch *esw, u16 vhca_id,
 	if (err)
 		goto acl_ns_remove;
 
-	mlx5_esw_adj_vport_modify(esw->dev, vport_num, MLX5_ADJ_VPORT_CONNECT);
 	return 0;
 
 acl_ns_remove:
@@ -117,8 +111,7 @@ static void mlx5_esw_adj_vport_destroy(struct mlx5_eswitch *esw,
 
 	esw_debug(esw->dev, "Destroying adjacent vport %d for vhca_id 0x%x\n",
 		  vport_num, vport->vhca_id);
-	mlx5_esw_adj_vport_modify(esw->dev, vport_num,
-				  MLX5_ADJ_VPORT_DISCONNECT);
+
 	mlx5_esw_offloads_rep_remove(esw, vport);
 	mlx5_fs_vport_egress_acl_ns_remove(esw->dev->priv.steering,
 					   vport->index);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 16eb99aba2a7..368ef2032825 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -264,6 +264,9 @@ struct mlx5_eswitch_fdb {
 
 		struct offloads_fdb {
 			struct mlx5_flow_namespace *ns;
+			struct mlx5_flow_table *drop_root;
+			struct mlx5_flow_handle *drop_root_rule;
+			struct mlx5_fc *drop_root_counter;
 			struct mlx5_flow_table *tc_miss_table;
 			struct mlx5_flow_table *slow_fdb;
 			struct mlx5_flow_group *send_to_vport_grp;
@@ -392,6 +395,7 @@ struct mlx5_eswitch {
 	struct mlx5_esw_offload offloads;
 	u32 last_vport_idx;
 	int                     mode;
+	bool                    offloads_inactive;
 	u16                     manager_vport;
 	u16                     first_host_vport;
 	u8			num_peers;
@@ -634,6 +638,8 @@ const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev);
 
 void mlx5_esw_adjacent_vhcas_setup(struct mlx5_eswitch *esw);
 void mlx5_esw_adjacent_vhcas_cleanup(struct mlx5_eswitch *esw);
+int mlx5_esw_adj_vport_modify(struct mlx5_core_dev *dev, u16 vport,
+			      bool connect);
 
 #define MLX5_DEBUG_ESWITCH_MASK BIT(3)
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 4092ea29c630..d0da2ed979f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1577,6 +1577,7 @@ esw_chains_create(struct mlx5_eswitch *esw, struct mlx5_flow_table *miss_fdb)
 	attr.max_grp_num = esw->params.large_group_num;
 	attr.default_ft = miss_fdb;
 	attr.mapping = esw->offloads.reg_c0_obj_pool;
+	attr.fs_base_prio = FDB_BYPASS_PATH;
 
 	chains = mlx5_chains_create(dev, &attr);
 	if (IS_ERR(chains)) {
@@ -2355,6 +2356,123 @@ static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
 	mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
 }
 
+static void mlx5_esw_fdb_drop_destroy(struct mlx5_eswitch *esw)
+{
+	if (!esw->fdb_table.offloads.drop_root)
+		return;
+
+	esw_debug(esw->dev, "Destroying FDB drop root table %#x fc %#x\n",
+		  esw->fdb_table.offloads.drop_root->id,
+		  esw->fdb_table.offloads.drop_root_counter->id);
+	mlx5_del_flow_rules(esw->fdb_table.offloads.drop_root_rule);
+	mlx5_fc_destroy(esw->dev, esw->fdb_table.offloads.drop_root_counter);
+	mlx5_destroy_flow_table(esw->fdb_table.offloads.drop_root);
+	esw->fdb_table.offloads.drop_root_counter = NULL;
+	esw->fdb_table.offloads.drop_root_rule = NULL;
+	esw->fdb_table.offloads.drop_root = NULL;
+}
+
+static int mlx5_esw_fdb_drop_create(struct mlx5_eswitch *esw)
+{
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_destination dst = {};
+	struct mlx5_core_dev *dev = esw->dev;
+	struct mlx5_flow_namespace *root_ns;
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *flow_rule;
+	struct mlx5_flow_table *table;
+	int err = 0;
+
+	if (esw->fdb_table.offloads.drop_root)
+		return 0;
+
+	root_ns = esw->fdb_table.offloads.ns;
+
+	ft_attr.prio = FDB_DROP_ROOT;
+	ft_attr.max_fte = 1;
+	ft_attr.autogroup.max_num_groups = 1;
+	table = mlx5_create_auto_grouped_flow_table(root_ns, &ft_attr);
+	if (IS_ERR(table)) {
+		esw_warn(dev, "Failed to create fdb drop root table, err %ld\n",
+			 PTR_ERR(table));
+		return PTR_ERR(table);
+	}
+
+	dst.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dst.counter = mlx5_fc_create(dev, 0);
+	err = PTR_ERR_OR_ZERO(dst.counter);
+	if (err) {
+		esw_warn(dev, "Failed to create fdb drop counter, err %d\n",
+			 err);
+		goto err_counter;
+	}
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP |
+			 MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	flow_rule = mlx5_add_flow_rules(table, NULL, &flow_act, &dst, 1);
+	err = PTR_ERR_OR_ZERO(flow_rule);
+	if (err) {
+		esw_warn(esw->dev,
+			 "fs offloads: Failed to add vport rx drop rule err %d\n",
+			 err);
+		goto err_flow_rule;
+	}
+
+	esw->fdb_table.offloads.drop_root = table;
+	esw->fdb_table.offloads.drop_root_rule = flow_rule;
+	esw->fdb_table.offloads.drop_root_counter = dst.counter;
+	esw_debug(esw->dev, "Created FDB drop root table %#x fc %#x\n",
+		  table->id, dst.counter->id);
+	return 0;
+
+err_flow_rule:
+	mlx5_fc_destroy(dev, dst.counter);
+err_counter:
+	mlx5_destroy_flow_table(table);
+	return err;
+}
+
+static void mlx5_esw_fdb_active(struct mlx5_eswitch *esw)
+{
+	struct mlx5_vport *vport;
+	unsigned long i;
+
+	mlx5_esw_fdb_drop_destroy(esw);
+	mlx5_mpfs_enable(esw->dev);
+
+	mlx5_esw_for_each_vf_vport(esw, i, vport, U16_MAX) {
+		if (!vport->adjacent)
+			continue;
+		esw_debug(esw->dev, "Connecting vport %d to eswitch\n",
+			  vport->vport);
+		mlx5_esw_adj_vport_modify(esw->dev, vport->vport, true);
+	}
+
+	esw->offloads_inactive = false;
+	esw_warn(esw->dev, "MPFS/FDB active\n");
+}
+
+static void mlx5_esw_fdb_inactive(struct mlx5_eswitch *esw)
+{
+	struct mlx5_vport *vport;
+	unsigned long i;
+
+	mlx5_mpfs_disable(esw->dev);
+	mlx5_esw_fdb_drop_create(esw);
+
+	mlx5_esw_for_each_vf_vport(esw, i, vport, U16_MAX) {
+		if (!vport->adjacent)
+			continue;
+		esw_debug(esw->dev, "Disconnecting vport %u from eswitch\n",
+			  vport->vport);
+
+		mlx5_esw_adj_vport_modify(esw->dev, vport->vport, false);
+	}
+
+	esw->offloads_inactive = true;
+	esw_warn(esw->dev, "MPFS/FDB inactive\n");
+}
+
 static int esw_offloads_start(struct mlx5_eswitch *esw,
 			      struct netlink_ext_ack *extack)
 {
@@ -3438,6 +3556,7 @@ static int esw_offloads_steering_init(struct mlx5_eswitch *esw)
 
 static void esw_offloads_steering_cleanup(struct mlx5_eswitch *esw)
 {
+	mlx5_esw_fdb_drop_destroy(esw);
 	esw_destroy_vport_rx_drop_rule(esw);
 	esw_destroy_vport_rx_drop_group(esw);
 	esw_destroy_vport_rx_group(esw);
@@ -3600,6 +3719,11 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	if (err)
 		goto err_steering_init;
 
+	if (esw->offloads_inactive)
+		mlx5_esw_fdb_inactive(esw);
+	else
+		mlx5_esw_fdb_active(esw);
+
 	/* Representor will control the vport link state */
 	mlx5_esw_for_each_vf_vport(esw, i, vport, esw->esw_funcs.num_vfs)
 		vport->info.link_state = MLX5_VPORT_ADMIN_STATE_DOWN;
@@ -3666,6 +3790,9 @@ void esw_offloads_disable(struct mlx5_eswitch *esw)
 	esw_offloads_metadata_uninit(esw);
 	mlx5_rdma_disable_roce(esw->dev);
 	mlx5_esw_adjacent_vhcas_cleanup(esw);
+	/* must be done after vhcas cleanup to avoid adjacent vports connect */
+	if (esw->offloads_inactive)
+		mlx5_esw_fdb_active(esw); /* legacy mode always active */
 	mutex_destroy(&esw->offloads.termtbl_mutex);
 }
 
@@ -3676,6 +3803,7 @@ static int esw_mode_from_devlink(u16 mode, u16 *mlx5_mode)
 		*mlx5_mode = MLX5_ESWITCH_LEGACY;
 		break;
 	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
+	case DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE:
 		*mlx5_mode = MLX5_ESWITCH_OFFLOADS;
 		break;
 	default:
@@ -3685,14 +3813,17 @@ static int esw_mode_from_devlink(u16 mode, u16 *mlx5_mode)
 	return 0;
 }
 
-static int esw_mode_to_devlink(u16 mlx5_mode, u16 *mode)
+static int esw_mode_to_devlink(struct mlx5_eswitch *esw, u16 *mode)
 {
-	switch (mlx5_mode) {
+	switch (esw->mode) {
 	case MLX5_ESWITCH_LEGACY:
 		*mode = DEVLINK_ESWITCH_MODE_LEGACY;
 		break;
 	case MLX5_ESWITCH_OFFLOADS:
-		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
+		if (esw->offloads_inactive)
+			*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE;
+		else
+			*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
 		break;
 	default:
 		return -EINVAL;
@@ -3798,6 +3929,45 @@ static bool mlx5_devlink_netdev_netns_immutable_set(struct devlink *devlink,
 	return ret;
 }
 
+/* Returns true when only changing between active and inactive switchdev mode */
+static bool mlx5_devlink_switchdev_active_mode_change(struct mlx5_eswitch *esw,
+						      u16 devlink_mode)
+{
+	/* current mode is not switchdev */
+	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
+		return false;
+
+	/* new mode is not switchdev */
+	if (devlink_mode != DEVLINK_ESWITCH_MODE_SWITCHDEV &&
+	    devlink_mode != DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE)
+		return false;
+
+	/* already inactive: no change in current state */
+	if (devlink_mode == DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE &&
+	    esw->offloads_inactive)
+		return false;
+
+	/* already active: no change in current state */
+	if (devlink_mode == DEVLINK_ESWITCH_MODE_SWITCHDEV &&
+	    !esw->offloads_inactive)
+		return false;
+
+	down_write(&esw->mode_lock);
+	esw->offloads_inactive = !esw->offloads_inactive;
+	esw->eswitch_operation_in_progress = true;
+	up_write(&esw->mode_lock);
+
+	if (esw->offloads_inactive)
+		mlx5_esw_fdb_inactive(esw);
+	else
+		mlx5_esw_fdb_active(esw);
+
+	down_write(&esw->mode_lock);
+	esw->eswitch_operation_in_progress = false;
+	up_write(&esw->mode_lock);
+	return true;
+}
+
 int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 				  struct netlink_ext_ack *extack)
 {
@@ -3812,12 +3982,16 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
-	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV && mlx5_get_sd(esw->dev)) {
+	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS && mlx5_get_sd(esw->dev)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Can't change E-Switch mode to switchdev when multi-PF netdev (Socket Direct) is configured.");
 		return -EPERM;
 	}
 
+	/* Avoid try_lock, active/inactive mode change is not restricted */
+	if (mlx5_devlink_switchdev_active_mode_change(esw, mode))
+		return 0;
+
 	mlx5_lag_disable_change(esw->dev);
 	err = mlx5_esw_try_lock(esw);
 	if (err < 0) {
@@ -3840,7 +4014,7 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	esw->eswitch_operation_in_progress = true;
 	up_write(&esw->mode_lock);
 
-	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV &&
+	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS &&
 	    !mlx5_devlink_netdev_netns_immutable_set(devlink, true)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Can't change E-Switch mode to switchdev when netdev net namespace has diverged from the devlink's.");
@@ -3848,18 +4022,20 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		goto skip;
 	}
 
-	if (mode == DEVLINK_ESWITCH_MODE_LEGACY)
+	if (mlx5_mode == MLX5_ESWITCH_LEGACY)
 		esw->dev->priv.flags |= MLX5_PRIV_FLAGS_SWITCH_LEGACY;
 	mlx5_eswitch_disable_locked(esw);
-	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV) {
+	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS) {
 		if (mlx5_devlink_trap_get_num_active(esw->dev)) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "Can't change mode while devlink traps are active");
 			err = -EOPNOTSUPP;
 			goto skip;
 		}
+		esw->offloads_inactive =
+			(mode == DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE);
 		err = esw_offloads_start(esw, extack);
-	} else if (mode == DEVLINK_ESWITCH_MODE_LEGACY) {
+	} else if (mlx5_mode == MLX5_ESWITCH_LEGACY) {
 		err = esw_offloads_stop(esw, extack);
 	} else {
 		err = -EINVAL;
@@ -3885,7 +4061,7 @@ int mlx5_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
-	return esw_mode_to_devlink(esw->mode, mode);
+	return esw_mode_to_devlink(esw, mode);
 }
 
 static int mlx5_esw_vports_inline_set(struct mlx5_eswitch *esw, u8 mlx5_mode,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2db3ffb0a2b2..2ca3bddbdf05 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3520,6 +3520,11 @@ static int init_fdb_root_ns(struct mlx5_flow_steering *steering)
 	if (!steering->fdb_root_ns)
 		return -ENOMEM;
 
+	maj_prio = fs_create_prio(&steering->fdb_root_ns->ns, FDB_DROP_ROOT, 1);
+	err = PTR_ERR_OR_ZERO(maj_prio);
+	if (err)
+		goto out_err;
+
 	err = create_fdb_bypass(steering);
 	if (err)
 		goto out_err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
index f27b5adb9606..3777aef600d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
@@ -167,7 +167,7 @@ int mlx5_mpfs_add_mac(struct mlx5_core_dev *dev, u8 *mac)
 		if (err)
 			goto free_l2table_index;
 		mlx5_core_dbg(dev, "MPFS entry %pM, set @index (%d)\n",
-			      l2addr->node.addr, l2addr->index);
+			      l2addr->node.addr, index);
 	}
 
 	l2addr->index = index;
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 6ac76a0c3827..7bf2449c53b2 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -116,6 +116,7 @@ enum mlx5_flow_namespace_type {
 };
 
 enum {
+	FDB_DROP_ROOT,
 	FDB_BYPASS_PATH,
 	FDB_CRYPTO_INGRESS,
 	FDB_TC_OFFLOAD,
-- 
2.51.1


