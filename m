Return-Path: <netdev+bounces-21641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9412764144
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090E61C21480
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D331DA42;
	Wed, 26 Jul 2023 21:32:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C731C9F3
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F20FC433CC;
	Wed, 26 Jul 2023 21:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407142;
	bh=i9kIGFKr0Oj2DQvNrLnkCRfufzuu+128jOrTX4rpEvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dmoLkWUXnItfphxlqgos7cUGj0zgn0oEDBrv74me5wc7j74J1+urHBXFKHK04Y/Jm
	 zz97dqqrorLRnPNmuFaT6Gr+Fem84TtCBHzxDkiH+22DvqUQj86rM94v9t0ch5Kv47
	 u6osWTi8ksQaBsHT8jWq1vVSJij7QE9Pgg21b+SyDeIz2mrYBO1sOP9gHVxgqjk1/Z
	 EY0POPmdDUjbZO6+exixdZhVUcoamTx7XoMlv1oohPEAN+qW1Wdkz+rjp8m8gvHsno
	 Rc6UirOiC6+2bKAC1T/PUsf9t8vWake80+sjob1RM6XiVespQM5WFgwFGxozZs9hY+
	 K8B5UUX+8kdtA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net 14/15] net/mlx5: DR, Fix peer domain namespace setting
Date: Wed, 26 Jul 2023 14:32:05 -0700
Message-ID: <20230726213206.47022-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

The offending patch is based on the assumption that for PFs,
mlx5_get_dev_index() is the same as vhca_id. However, this assumption
is wrong in case of DPU (ECPF).
Fix it by using vhca_id directly, and switch the array of peers to
xarray.

Fixes: 6d5b7321d8af ("net/mlx5: DR, handle more than one peer domain")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 14 +++++++-------
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  2 +-
 .../mellanox/mlx5/core/steering/dr_action.c   |  2 +-
 .../mellanox/mlx5/core/steering/dr_domain.c   | 19 +++++++++++++------
 .../mellanox/mlx5/core/steering/dr_ste_v0.c   |  7 ++++---
 .../mellanox/mlx5/core/steering/dr_ste_v1.c   |  7 ++++---
 .../mellanox/mlx5/core/steering/dr_types.h    |  2 +-
 .../mellanox/mlx5/core/steering/fs_dr.c       |  4 ++--
 .../mellanox/mlx5/core/steering/mlx5dr.h      |  2 +-
 12 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index bc04abb31f9c..e59380ee1ead 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2778,9 +2778,9 @@ static int mlx5_esw_offloads_set_ns_peer(struct mlx5_eswitch *esw,
 					 struct mlx5_eswitch *peer_esw,
 					 bool pair)
 {
-	u8 peer_idx = mlx5_get_dev_index(peer_esw->dev);
+	u16 peer_vhca_id = MLX5_CAP_GEN(peer_esw->dev, vhca_id);
+	u16 vhca_id = MLX5_CAP_GEN(esw->dev, vhca_id);
 	struct mlx5_flow_root_namespace *peer_ns;
-	u8 idx = mlx5_get_dev_index(esw->dev);
 	struct mlx5_flow_root_namespace *ns;
 	int err;
 
@@ -2788,18 +2788,18 @@ static int mlx5_esw_offloads_set_ns_peer(struct mlx5_eswitch *esw,
 	ns = esw->dev->priv.steering->fdb_root_ns;
 
 	if (pair) {
-		err = mlx5_flow_namespace_set_peer(ns, peer_ns, peer_idx);
+		err = mlx5_flow_namespace_set_peer(ns, peer_ns, peer_vhca_id);
 		if (err)
 			return err;
 
-		err = mlx5_flow_namespace_set_peer(peer_ns, ns, idx);
+		err = mlx5_flow_namespace_set_peer(peer_ns, ns, vhca_id);
 		if (err) {
-			mlx5_flow_namespace_set_peer(ns, NULL, peer_idx);
+			mlx5_flow_namespace_set_peer(ns, NULL, peer_vhca_id);
 			return err;
 		}
 	} else {
-		mlx5_flow_namespace_set_peer(ns, NULL, peer_idx);
-		mlx5_flow_namespace_set_peer(peer_ns, NULL, idx);
+		mlx5_flow_namespace_set_peer(ns, NULL, peer_vhca_id);
+		mlx5_flow_namespace_set_peer(peer_ns, NULL, vhca_id);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 91dcb0dcad10..aab7059bf6e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -140,7 +140,7 @@ static void mlx5_cmd_stub_modify_header_dealloc(struct mlx5_flow_root_namespace
 
 static int mlx5_cmd_stub_set_peer(struct mlx5_flow_root_namespace *ns,
 				  struct mlx5_flow_root_namespace *peer_ns,
-				  u8 peer_idx)
+				  u16 peer_vhca_id)
 {
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
index b6b9a5a20591..7790ae5531e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
@@ -94,7 +94,7 @@ struct mlx5_flow_cmds {
 
 	int (*set_peer)(struct mlx5_flow_root_namespace *ns,
 			struct mlx5_flow_root_namespace *peer_ns,
-			u8 peer_idx);
+			u16 peer_vhca_id);
 
 	int (*create_ns)(struct mlx5_flow_root_namespace *ns);
 	int (*destroy_ns)(struct mlx5_flow_root_namespace *ns);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 4ef04aa28771..b4eb27e7f28b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3621,7 +3621,7 @@ void mlx5_destroy_match_definer(struct mlx5_core_dev *dev,
 
 int mlx5_flow_namespace_set_peer(struct mlx5_flow_root_namespace *ns,
 				 struct mlx5_flow_root_namespace *peer_ns,
-				 u8 peer_idx)
+				 u16 peer_vhca_id)
 {
 	if (peer_ns && ns->mode != peer_ns->mode) {
 		mlx5_core_err(ns->dev,
@@ -3629,7 +3629,7 @@ int mlx5_flow_namespace_set_peer(struct mlx5_flow_root_namespace *ns,
 		return -EINVAL;
 	}
 
-	return ns->cmds->set_peer(ns, peer_ns, peer_idx);
+	return ns->cmds->set_peer(ns, peer_ns, peer_vhca_id);
 }
 
 /* This function should be called only at init stage of the namespace.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 03e64c4c245d..4aed1768b85f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -303,7 +303,7 @@ const struct mlx5_flow_cmds *mlx5_fs_cmd_get_fw_cmds(void);
 
 int mlx5_flow_namespace_set_peer(struct mlx5_flow_root_namespace *ns,
 				 struct mlx5_flow_root_namespace *peer_ns,
-				 u8 peer_idx);
+				 u16 peer_vhca_id);
 
 int mlx5_flow_namespace_set_mode(struct mlx5_flow_namespace *ns,
 				 enum mlx5_flow_steering_mode mode);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index e739ec6cdf90..54bb0866ed72 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -2079,7 +2079,7 @@ mlx5dr_action_create_dest_vport(struct mlx5dr_domain *dmn,
 
 	peer_vport = vhca_id_valid && mlx5_core_is_pf(dmn->mdev) &&
 		(vhca_id != dmn->info.caps.gvmi);
-	vport_dmn = peer_vport ? dmn->peer_dmn[vhca_id] : dmn;
+	vport_dmn = peer_vport ? xa_load(&dmn->peer_dmn_xa, vhca_id) : dmn;
 	if (!vport_dmn) {
 		mlx5dr_dbg(dmn, "No peer vport domain for given vhca_id\n");
 		return NULL;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
index 75dc85dc24ef..3d74109f8230 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
@@ -475,6 +475,7 @@ mlx5dr_domain_create(struct mlx5_core_dev *mdev, enum mlx5dr_domain_type type)
 	mutex_init(&dmn->info.rx.mutex);
 	mutex_init(&dmn->info.tx.mutex);
 	xa_init(&dmn->definers_xa);
+	xa_init(&dmn->peer_dmn_xa);
 
 	if (dr_domain_caps_init(mdev, dmn)) {
 		mlx5dr_err(dmn, "Failed init domain, no caps\n");
@@ -507,6 +508,7 @@ mlx5dr_domain_create(struct mlx5_core_dev *mdev, enum mlx5dr_domain_type type)
 uninit_caps:
 	dr_domain_caps_uninit(dmn);
 def_xa_destroy:
+	xa_destroy(&dmn->peer_dmn_xa);
 	xa_destroy(&dmn->definers_xa);
 	kfree(dmn);
 	return NULL;
@@ -547,6 +549,7 @@ int mlx5dr_domain_destroy(struct mlx5dr_domain *dmn)
 	dr_domain_uninit_csum_recalc_fts(dmn);
 	dr_domain_uninit_resources(dmn);
 	dr_domain_caps_uninit(dmn);
+	xa_destroy(&dmn->peer_dmn_xa);
 	xa_destroy(&dmn->definers_xa);
 	mutex_destroy(&dmn->info.tx.mutex);
 	mutex_destroy(&dmn->info.rx.mutex);
@@ -556,17 +559,21 @@ int mlx5dr_domain_destroy(struct mlx5dr_domain *dmn)
 
 void mlx5dr_domain_set_peer(struct mlx5dr_domain *dmn,
 			    struct mlx5dr_domain *peer_dmn,
-			    u8 peer_idx)
+			    u16 peer_vhca_id)
 {
+	struct mlx5dr_domain *peer;
+
 	mlx5dr_domain_lock(dmn);
 
-	if (dmn->peer_dmn[peer_idx])
-		refcount_dec(&dmn->peer_dmn[peer_idx]->refcount);
+	peer = xa_load(&dmn->peer_dmn_xa, peer_vhca_id);
+	if (peer)
+		refcount_dec(&peer->refcount);
 
-	dmn->peer_dmn[peer_idx] = peer_dmn;
+	WARN_ON(xa_err(xa_store(&dmn->peer_dmn_xa, peer_vhca_id, peer_dmn, GFP_KERNEL)));
 
-	if (dmn->peer_dmn[peer_idx])
-		refcount_inc(&dmn->peer_dmn[peer_idx]->refcount);
+	peer = xa_load(&dmn->peer_dmn_xa, peer_vhca_id);
+	if (peer)
+		refcount_inc(&peer->refcount);
 
 	mlx5dr_domain_unlock(dmn);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
index 69d7a8f3c402..f708b029425a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
@@ -1652,17 +1652,18 @@ dr_ste_v0_build_src_gvmi_qpn_tag(struct mlx5dr_match_param *value,
 	struct mlx5dr_domain *dmn = sb->dmn;
 	struct mlx5dr_domain *vport_dmn;
 	u8 *bit_mask = sb->bit_mask;
+	struct mlx5dr_domain *peer;
 	bool source_gvmi_set;
 
 	DR_STE_SET_TAG(src_gvmi_qp, tag, source_qp, misc, source_sqn);
 
 	if (sb->vhca_id_valid) {
+		peer = xa_load(&dmn->peer_dmn_xa, id);
 		/* Find port GVMI based on the eswitch_owner_vhca_id */
 		if (id == dmn->info.caps.gvmi)
 			vport_dmn = dmn;
-		else if (id < MLX5_MAX_PORTS && dmn->peer_dmn[id] &&
-			 (id == dmn->peer_dmn[id]->info.caps.gvmi))
-			vport_dmn = dmn->peer_dmn[id];
+		else if (peer && (id == peer->info.caps.gvmi))
+			vport_dmn = peer;
 		else
 			return -EINVAL;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
index f4ef0b22b991..dd856cde188d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
@@ -1984,16 +1984,17 @@ static int dr_ste_v1_build_src_gvmi_qpn_tag(struct mlx5dr_match_param *value,
 	struct mlx5dr_domain *dmn = sb->dmn;
 	struct mlx5dr_domain *vport_dmn;
 	u8 *bit_mask = sb->bit_mask;
+	struct mlx5dr_domain *peer;
 
 	DR_STE_SET_TAG(src_gvmi_qp_v1, tag, source_qp, misc, source_sqn);
 
 	if (sb->vhca_id_valid) {
+		peer = xa_load(&dmn->peer_dmn_xa, id);
 		/* Find port GVMI based on the eswitch_owner_vhca_id */
 		if (id == dmn->info.caps.gvmi)
 			vport_dmn = dmn;
-		else if (id < MLX5_MAX_PORTS && dmn->peer_dmn[id] &&
-			 (id == dmn->peer_dmn[id]->info.caps.gvmi))
-			vport_dmn = dmn->peer_dmn[id];
+		else if (peer && (id == peer->info.caps.gvmi))
+			vport_dmn = peer;
 		else
 			return -EINVAL;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
index 1622dbbe6b97..6c59de3e28f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
@@ -935,7 +935,6 @@ struct mlx5dr_domain_info {
 };
 
 struct mlx5dr_domain {
-	struct mlx5dr_domain *peer_dmn[MLX5_MAX_PORTS];
 	struct mlx5_core_dev *mdev;
 	u32 pdn;
 	struct mlx5_uars_page *uar;
@@ -956,6 +955,7 @@ struct mlx5dr_domain {
 	struct list_head dbg_tbl_list;
 	struct mlx5dr_dbg_dump_info dump_info;
 	struct xarray definers_xa;
+	struct xarray peer_dmn_xa;
 	/* memory management statistics */
 	u32 num_buddies[DR_ICM_TYPE_MAX];
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
index 6aac5f006bf8..feb307fb3440 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
@@ -781,14 +781,14 @@ static int mlx5_cmd_dr_update_fte(struct mlx5_flow_root_namespace *ns,
 
 static int mlx5_cmd_dr_set_peer(struct mlx5_flow_root_namespace *ns,
 				struct mlx5_flow_root_namespace *peer_ns,
-				u8 peer_idx)
+				u16 peer_vhca_id)
 {
 	struct mlx5dr_domain *peer_domain = NULL;
 
 	if (peer_ns)
 		peer_domain = peer_ns->fs_dr_domain.dr_domain;
 	mlx5dr_domain_set_peer(ns->fs_dr_domain.dr_domain,
-			       peer_domain, peer_idx);
+			       peer_domain, peer_vhca_id);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h
index 24cbb33ecd6c..89fced86936f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h
@@ -49,7 +49,7 @@ int mlx5dr_domain_sync(struct mlx5dr_domain *domain, u32 flags);
 
 void mlx5dr_domain_set_peer(struct mlx5dr_domain *dmn,
 			    struct mlx5dr_domain *peer_dmn,
-			    u8 peer_idx);
+			    u16 peer_vhca_id);
 
 struct mlx5dr_table *
 mlx5dr_table_create(struct mlx5dr_domain *domain, u32 level, u32 flags,
-- 
2.41.0


