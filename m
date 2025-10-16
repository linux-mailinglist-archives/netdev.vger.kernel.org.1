Return-Path: <netdev+bounces-229845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA888BE12D8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3023E2F74
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 01:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B420CCE4;
	Thu, 16 Oct 2025 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBzXI27/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCE4A21
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578621; cv=none; b=W7VlhlRucy2HlK/U6IVig9eiVltONkohpacF18pfengs/8WGsx6rldabUiVhCd/Cxw3bp9rocH+lNSRXVCX9FaP6KXxwshhDHRoSH7nynLYs+D7Tl9ywYg9C1fXtNp9W9a7ISsfo+1nyu+Sk+D+rforj1RlUxKgwMCmoPOtcSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578621; c=relaxed/simple;
	bh=2iGwzhPQJrVmzHGx3nwg9WfQO/vEESo8r4+/gq/i3hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apGGkqC83AZsMMZS8TcwLEqNedCTypDNtdgKnjq8lCrVvKuzX+GZsD7DPS0kWEAaOw+xaG0GzmGNTnBPbyrRpCFOhuLtY/luiVGS9I9S6jr+wenHB85PMGVuZenSdpyYupGD7FlEFq4zTsuHg3FaSJrQx3rMEB1sL7zYSx/YhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBzXI27/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37747C4CEF8;
	Thu, 16 Oct 2025 01:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760578621;
	bh=2iGwzhPQJrVmzHGx3nwg9WfQO/vEESo8r4+/gq/i3hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBzXI27/4A7O9IL8fx3C/u0EOGgFWVEsl/Zg7+8CyvTxF6GtcPiY0wqPTzqBdYaJB
	 Ngiv9jpwlO0g0PKgNyeOeP+r41npP+o7YVUbM7gcMayRSuEepLGOrffUBKQvldrrv0
	 Gvmf1dWBv8Z5MPh6gh6vuyKCeJIyZaVg5GeyvobNEK9ujnfZMVYaNwin2bWAdBgABb
	 4TMto2v7gjQYaDCVLS27YWJ77AVjtB4vV2sOFLl+n7WSbvmKs96pB/OLuInRhMmQuH
	 FliyT/xexoJRt7hur8eH53+UV6bJlrJhrHlVVqo13De44xUKGkKEipX5nfBeDjlKd9
	 owumliVuzcHwg==
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
	mbloch@nvidia.com,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5: E-Switch, support eswitch state
Date: Wed, 15 Oct 2025 18:36:18 -0700
Message-ID: <20251016013618.2030940-4-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016013618.2030940-1-saeed@kernel.org>
References: <20251016013618.2030940-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Support eswitch state:

 - Active State: Allow FDB traffic, Connect adjacent vports and apply l2
mpfs rules.
 - Inactive / Deactivated State: Drop all traffic going to FDB, Remove
mpfs l2 rules and disconnect adjacent vports.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +
 .../mellanox/mlx5/core/esw/adj_vport.c        |  15 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  12 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 157 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   5 +
 include/linux/mlx5/fs.h                       |   1 +
 7 files changed, 182 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index a0b68321355a..32dbb11db94b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -371,6 +371,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 #ifdef CONFIG_MLX5_ESWITCH
 	.eswitch_mode_set = mlx5_devlink_eswitch_mode_set,
 	.eswitch_mode_get = mlx5_devlink_eswitch_mode_get,
+	.eswitch_state_get = mlx5_devlink_eswitch_state_get,
+	.eswitch_state_set = mlx5_devlink_eswitch_state_set,
 	.eswitch_inline_mode_set = mlx5_devlink_eswitch_inline_mode_set,
 	.eswitch_inline_mode_get = mlx5_devlink_eswitch_inline_mode_get,
 	.eswitch_encap_mode_set = mlx5_devlink_eswitch_encap_mode_set,
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index ad6858789e48..b22f270e4859 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2044,6 +2044,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	refcount_set(&esw->qos.refcnt, 0);
 
 	esw->enabled_vports = 0;
+	esw->state = DEVLINK_ESWITCH_STATE_ACTIVE;
 	esw->offloads.inline_mode = MLX5_INLINE_MODE_NONE;
 	if (MLX5_CAP_ESW_FLOWTABLE_FDB(dev, reformat) &&
 	    MLX5_CAP_ESW_FLOWTABLE_FDB(dev, decap))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 4fe285ce32aa..5fd70bd8fb8c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -264,6 +264,10 @@ struct mlx5_eswitch_fdb {
 
 		struct offloads_fdb {
 			struct mlx5_flow_namespace *ns;
+			struct mlx5_flow_table *drop_root;
+			struct mlx5_flow_handle *drop_root_rule;
+			struct mlx5_fc *drop_root_counter;
+			struct dentry *drop_root_dbgfs;
 			struct mlx5_flow_table *tc_miss_table;
 			struct mlx5_flow_table *slow_fdb;
 			struct mlx5_flow_group *send_to_vport_grp;
@@ -392,6 +396,7 @@ struct mlx5_eswitch {
 	struct mlx5_esw_offload offloads;
 	u32 last_vport_idx;
 	int                     mode;
+	u8                      state;
 	u16                     manager_vport;
 	u16                     first_host_vport;
 	u8			num_peers;
@@ -569,6 +574,11 @@ int mlx5_devlink_eswitch_encap_mode_set(struct devlink *devlink,
 					struct netlink_ext_ack *extack);
 int mlx5_devlink_eswitch_encap_mode_get(struct devlink *devlink,
 					enum devlink_eswitch_encap_mode *encap);
+int mlx5_devlink_eswitch_state_get(struct devlink *devlink,
+				   enum devlink_eswitch_state *state);
+int mlx5_devlink_eswitch_state_set(struct devlink *devlink,
+				   enum devlink_eswitch_state state,
+				   struct netlink_ext_ack *extack);
 int mlx5_devlink_port_fn_hw_addr_get(struct devlink_port *port,
 				     u8 *hw_addr, int *hw_addr_len,
 				     struct netlink_ext_ack *extack);
@@ -633,6 +643,8 @@ const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev);
 
 void mlx5_esw_adjacent_vhcas_setup(struct mlx5_eswitch *esw);
 void mlx5_esw_adjacent_vhcas_cleanup(struct mlx5_eswitch *esw);
+int mlx5_esw_adj_vport_modify(struct mlx5_core_dev *dev, u16 vport,
+			      bool connect);
 
 #define MLX5_DEBUG_ESWITCH_MASK BIT(3)
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index f289e846ea3a..326f1e33799c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1577,6 +1577,7 @@ esw_chains_create(struct mlx5_eswitch *esw, struct mlx5_flow_table *miss_fdb)
 	attr.max_grp_num = esw->params.large_group_num;
 	attr.default_ft = miss_fdb;
 	attr.mapping = esw->offloads.reg_c0_obj_pool;
+	attr.fs_base_prio = FDB_BYPASS_PATH;
 
 	chains = mlx5_chains_create(dev, &attr);
 	if (IS_ERR(chains)) {
@@ -2354,6 +2355,115 @@ static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
 	mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
 }
 
+static void mlx5_esw_fdb_drop_destroy(struct mlx5_eswitch *esw)
+{
+	if (!esw->fdb_table.offloads.drop_root)
+		return;
+
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
+		/* connect vport to this esw */
+		mlx5_esw_adj_vport_modify(esw->dev, vport->vport, true);
+	}
+
+	esw->state = DEVLINK_ESWITCH_STATE_ACTIVE;
+	esw_warn(esw->dev, "MPFS/FDB activated\n");
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
+		 /* disconnect vport from this esw */
+		mlx5_esw_adj_vport_modify(esw->dev, vport->vport, false);
+	}
+
+	esw->state = DEVLINK_ESWITCH_STATE_INACTIVE;
+	esw_warn(esw->dev, "MPFS/FDB de-activated\n");
+}
+
 static int esw_offloads_start(struct mlx5_eswitch *esw,
 			      struct netlink_ext_ack *extack)
 {
@@ -3656,6 +3766,10 @@ void esw_offloads_disable(struct mlx5_eswitch *esw)
 {
 	mlx5_eswitch_disable_pf_vf_vports(esw);
 	mlx5_esw_offloads_rep_unload(esw, MLX5_VPORT_UPLINK);
+
+	if (esw->state == DEVLINK_ESWITCH_STATE_INACTIVE)
+		mlx5_esw_fdb_active(esw); /* legacy mode always active */
+
 	esw_set_passing_vport_metadata(esw, false);
 	esw_offloads_steering_cleanup(esw);
 	mapping_destroy(esw->offloads.reg_c0_obj_pool);
@@ -3851,6 +3965,49 @@ int mlx5_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 	return esw_mode_to_devlink(esw->mode, mode);
 }
 
+int mlx5_devlink_eswitch_state_get(struct devlink *devlink,
+				   enum devlink_eswitch_state *state)
+{
+	struct mlx5_eswitch *esw;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	*state = esw->state;
+	return 0;
+}
+
+int mlx5_devlink_eswitch_state_set(struct devlink *devlink,
+				   enum devlink_eswitch_state state,
+				   struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw)) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to query eswitch");
+		return PTR_ERR(esw);
+	}
+
+	if (esw->mode == MLX5_ESWITCH_LEGACY) {
+		if (state != DEVLINK_ESWITCH_STATE_ACTIVE) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "legacy mode only supports active state");
+			return -EOPNOTSUPP;
+		}
+		return 0;
+	}
+
+	if (state == DEVLINK_ESWITCH_STATE_ACTIVE)
+		mlx5_esw_fdb_active(esw);
+	else
+		mlx5_esw_fdb_inactive(esw);
+
+	esw->state = state;
+	return 0;
+}
+
 static int mlx5_esw_vports_inline_set(struct mlx5_eswitch *esw, u8 mlx5_mode,
 				      struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 4308e89802f3..c8cfcf939d08 100644
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
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 86055d55836d..f1fe56e7efdb 100644
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
2.51.0


