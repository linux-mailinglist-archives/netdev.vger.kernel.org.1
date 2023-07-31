Return-Path: <netdev+bounces-22799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A407694EC
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252A01C2090F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9191801E;
	Mon, 31 Jul 2023 11:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108318AF3
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7FBC433D9;
	Mon, 31 Jul 2023 11:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802948;
	bh=rsBwsi6FmSr4XW1SExtm6EeA+vc/DCC0RgxmOXLJZQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g9prkFocjzNkppf0RT41coxYPZMMZ3X1k0a7Dkv1mbUw24oQCYoO8wdppmAED1q3m
	 r9sHu8yziaFS/k8xTmR0Qsybr3c3W5NCRjZoKM9nMczceDQ2ZHP4bmqKCusGE3tdIY
	 Vup4Lawkx7SpNkHpEUDPE4mrvj2dBQn0Zgfjxn7BtSyRMWj3nBQsDQFJ+xU/n9O0G1
	 tQBtvGZBP+svyKDI8CAyGLR837hfB7onBKZ4RX4jfCtIT4RzQO+YXzjwL84GgBsRTc
	 iSZsUYGXha5oidfd8tbkZoHR35IwwbGWnXllLQyUpBL2DDPF3Rt3KOv19AViTtJTGg
	 0jKeIAi4xyumA==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v1 11/13] net/mlx5e: Modify and restore TC rules for IPSec TX rules
Date: Mon, 31 Jul 2023 14:28:22 +0300
Message-ID: <7bcb2c7e2ecf0e0d06b095c8dcc6a37ea7f02faf.1690802064.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690802064.git.leon@kernel.org>
References: <cover.1690802064.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

After IPsec policy/state TX rules are added, any TC flow rule, which
forwards packets to uplink, is modified to forward to IPsec TX tables.
As these tables are destroyed dynamically, whenever there is no
reference to them, the destinations of this kind of rules must be
restored to uplink.

There is a special case for packet encapsulation, as the
packet_reformat_id in the extended destination is used to reformat
packets, but only for the VPORT destination. To forward packet to
IPsec table and do encapsulation in one FTE, move the
packet_reformat_id to flow context, instead of using the extended
destination. As a limitation, multiple encapsulations with table
forwarding, and one together with other VPORT destinations, are not
allowed, so add a check when offloading TC rules.

TC rules are not allowed before IPsec TX rule is added, so only need
to restore TC rules after flush IPSec TX rules. As they are saved in
the vport_rep rhashtables, we walk all the rules in the rhashtables,
and find TC rules with destinations pointing to IPsec tables, and
modify them one by one. To avoid concurrent issue, this handling is
done under the protection of eswitch mode_lock.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  4 +-
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 56 +++++++++++
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  3 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 93 ++++++++++++++++++-
 5 files changed, 154 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 7eb926b527da..f635b5f6e886 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -755,8 +755,10 @@ static void tx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx)
 
 	mlx5_eswitch_unblock_mode_lock(ipsec->mdev);
 
-	if (tx == ipsec->tx_esw)
+	if (tx == ipsec->tx_esw) {
+		mlx5_esw_ipsec_restore_dest_uplink(ipsec->mdev);
 		ipsec_esw_tx_ft_policy_set(ipsec->mdev, NULL);
+	}
 
 	tx_destroy(ipsec, tx, ipsec->roce);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index e60cd3dc1b13..455746952260 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -5,6 +5,9 @@
 #include "eswitch.h"
 #include "en_accel/ipsec.h"
 #include "esw/ipsec_fs.h"
+#if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
+#include "en/tc_priv.h"
+#endif
 
 enum {
 	MLX5_ESW_IPSEC_RX_POL_FT_LEVEL,
@@ -267,3 +270,56 @@ void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 	attr->cnt_level = MLX5_ESW_IPSEC_TX_ESP_FT_CNT_LEVEL;
 	attr->chains_ns = MLX5_FLOW_NAMESPACE_FDB;
 }
+
+#if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
+static int mlx5_esw_ipsec_modify_flow_dests(struct mlx5_eswitch *esw,
+					    struct mlx5e_tc_flow *flow)
+{
+	struct mlx5_esw_flow_attr *esw_attr;
+	struct mlx5_flow_attr *attr;
+	int err;
+
+	attr = flow->attr;
+	esw_attr = attr->esw_attr;
+	if (esw_attr->out_count - esw_attr->split_count > 1)
+		return 0;
+
+	err = mlx5_eswitch_restore_ipsec_rule(esw, flow->rule[0], esw_attr,
+					      esw_attr->out_count - 1);
+
+	return err;
+}
+#endif
+
+void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
+{
+#if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
+	struct mlx5_eswitch *esw = mdev->priv.eswitch;
+	struct mlx5_eswitch_rep *rep;
+	struct mlx5e_rep_priv *rpriv;
+	struct rhashtable_iter iter;
+	struct mlx5e_tc_flow *flow;
+	unsigned long i;
+	int err;
+
+	xa_for_each(&esw->offloads.vport_reps, i, rep) {
+		rpriv = rep->rep_data[REP_ETH].priv;
+		if (!rpriv || !rpriv->netdev)
+			continue;
+
+		rhashtable_walk_enter(&rpriv->tc_ht, &iter);
+		rhashtable_walk_start(&iter);
+		while ((flow = rhashtable_walk_next(&iter)) != NULL) {
+			if (IS_ERR(flow))
+				continue;
+
+			err = mlx5_esw_ipsec_modify_flow_dests(esw, flow);
+			if (err)
+				mlx5_core_warn_once(mdev,
+						    "Faided to modify flow dests for IPsec");
+		}
+		rhashtable_walk_stop(&iter);
+		rhashtable_walk_exit(&iter);
+	}
+#endif
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
index 275684f99ed3..0c90f7a8b0d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
@@ -24,6 +24,7 @@ int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv, u32 id,
 					  u32 *ipsec_obj_id);
 void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_tx_create_attr *attr);
+void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev);
 #else
 static inline void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
 						    struct mlx5e_ipsec_rx *rx) {}
@@ -60,5 +61,7 @@ static inline int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv,
 
 static inline void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 						     struct mlx5e_ipsec_tx_create_attr *attr) {}
+
+static inline void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev) {}
 #endif /* CONFIG_MLX5_ESWITCH */
 #endif /* __MLX5_ESW_IPSEC_FS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index f4b52ab1ff07..f3a6a1826e00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -811,6 +811,8 @@ mlx5_eswitch_get_slow_fdb(struct mlx5_eswitch *esw)
 	return esw->fdb_table.offloads.slow_fdb;
 }
 
+int mlx5_eswitch_restore_ipsec_rule(struct mlx5_eswitch *esw, struct mlx5_flow_handle *rule,
+				    struct mlx5_esw_flow_attr *esw_attr, int attr_idx);
 #else  /* CONFIG_MLX5_ESWITCH */
 /* eswitch API stubs */
 static inline int  mlx5_eswitch_init(struct mlx5_core_dev *dev) { return 0; }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 6a7e1955eddf..d3bcb632dd44 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -424,10 +424,51 @@ esw_cleanup_chain_dest(struct mlx5_fs_chains *chains, u32 chain, u32 prio, u32 l
 	mlx5_chains_put_table(chains, chain, prio, level);
 }
 
+static bool esw_same_vhca_id(struct mlx5_core_dev *mdev1, struct mlx5_core_dev *mdev2)
+{
+	return MLX5_CAP_GEN(mdev1, vhca_id) == MLX5_CAP_GEN(mdev2, vhca_id);
+}
+
+static bool esw_setup_uplink_fwd_ipsec_needed(struct mlx5_eswitch *esw,
+					      struct mlx5_esw_flow_attr *esw_attr,
+					      int attr_idx)
+{
+	if (esw->offloads.ft_ipsec_tx_pol &&
+	    esw_attr->dests[attr_idx].rep &&
+	    esw_attr->dests[attr_idx].rep->vport == MLX5_VPORT_UPLINK &&
+	    /* To be aligned with software, encryption is needed only for tunnel device */
+	    (esw_attr->dests[attr_idx].flags & MLX5_ESW_DEST_ENCAP_VALID) &&
+	    esw_attr->dests[attr_idx].rep != esw_attr->in_rep &&
+	    esw_same_vhca_id(esw_attr->dests[attr_idx].mdev, esw->dev))
+		return true;
+
+	return false;
+}
+
+static bool esw_flow_dests_fwd_ipsec_check(struct mlx5_eswitch *esw,
+					   struct mlx5_esw_flow_attr *esw_attr)
+{
+	int i;
+
+	if (!esw->offloads.ft_ipsec_tx_pol)
+		return true;
+
+	for (i = 0; i < esw_attr->split_count; i++)
+		if (esw_setup_uplink_fwd_ipsec_needed(esw, esw_attr, i))
+			return false;
+
+	for (i = esw_attr->split_count; i < esw_attr->out_count; i++)
+		if (esw_setup_uplink_fwd_ipsec_needed(esw, esw_attr, i) &&
+		    (esw_attr->out_count - esw_attr->split_count > 1))
+			return false;
+
+	return true;
+}
+
 static void
-esw_setup_vport_dest(struct mlx5_flow_destination *dest, struct mlx5_flow_act *flow_act,
-		     struct mlx5_eswitch *esw, struct mlx5_esw_flow_attr *esw_attr,
-		     int attr_idx, int dest_idx, bool pkt_reformat)
+esw_setup_dest_fwd_vport(struct mlx5_flow_destination *dest, struct mlx5_flow_act *flow_act,
+			 struct mlx5_eswitch *esw, struct mlx5_esw_flow_attr *esw_attr,
+			 int attr_idx, int dest_idx, bool pkt_reformat)
 {
 	dest[dest_idx].type = MLX5_FLOW_DESTINATION_TYPE_VPORT;
 	dest[dest_idx].vport.num = esw_attr->dests[attr_idx].rep->vport;
@@ -449,6 +490,33 @@ esw_setup_vport_dest(struct mlx5_flow_destination *dest, struct mlx5_flow_act *f
 	}
 }
 
+static void
+esw_setup_dest_fwd_ipsec(struct mlx5_flow_destination *dest, struct mlx5_flow_act *flow_act,
+			 struct mlx5_eswitch *esw, struct mlx5_esw_flow_attr *esw_attr,
+			 int attr_idx, int dest_idx, bool pkt_reformat)
+{
+	dest[dest_idx].ft = esw->offloads.ft_ipsec_tx_pol;
+	dest[dest_idx].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	if (pkt_reformat &&
+	    esw_attr->dests[attr_idx].flags & MLX5_ESW_DEST_ENCAP_VALID) {
+		flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT;
+		flow_act->pkt_reformat = esw_attr->dests[attr_idx].pkt_reformat;
+	}
+}
+
+static void
+esw_setup_vport_dest(struct mlx5_flow_destination *dest, struct mlx5_flow_act *flow_act,
+		     struct mlx5_eswitch *esw, struct mlx5_esw_flow_attr *esw_attr,
+		     int attr_idx, int dest_idx, bool pkt_reformat)
+{
+	if (esw_setup_uplink_fwd_ipsec_needed(esw, esw_attr, attr_idx))
+		esw_setup_dest_fwd_ipsec(dest, flow_act, esw, esw_attr,
+					 attr_idx, dest_idx, pkt_reformat);
+	else
+		esw_setup_dest_fwd_vport(dest, flow_act, esw, esw_attr,
+					 attr_idx, dest_idx, pkt_reformat);
+}
+
 static int
 esw_setup_vport_dests(struct mlx5_flow_destination *dest, struct mlx5_flow_act *flow_act,
 		      struct mlx5_eswitch *esw, struct mlx5_esw_flow_attr *esw_attr,
@@ -575,6 +643,9 @@ mlx5_eswitch_add_offloaded_rule(struct mlx5_eswitch *esw,
 	if (!mlx5_eswitch_vlan_actions_supported(esw->dev, 1))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (!esw_flow_dests_fwd_ipsec_check(esw, esw_attr))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	dest = kcalloc(MLX5_MAX_FLOW_FWD_VPORTS + 1, sizeof(*dest), GFP_KERNEL);
 	if (!dest)
 		return ERR_PTR(-ENOMEM);
@@ -4374,3 +4445,19 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 	mutex_unlock(&esw->state_lock);
 	return err;
 }
+
+int
+mlx5_eswitch_restore_ipsec_rule(struct mlx5_eswitch *esw, struct mlx5_flow_handle *rule,
+				struct mlx5_esw_flow_attr *esw_attr, int attr_idx)
+{
+	struct mlx5_flow_destination new_dest = {};
+	struct mlx5_flow_destination old_dest = {};
+
+	if (!esw_setup_uplink_fwd_ipsec_needed(esw, esw_attr, attr_idx))
+		return 0;
+
+	esw_setup_dest_fwd_ipsec(&old_dest, NULL, esw, esw_attr, attr_idx, 0, false);
+	esw_setup_dest_fwd_vport(&new_dest, NULL, esw, esw_attr, attr_idx, 0, false);
+
+	return mlx5_modify_rule_destination(rule, &new_dest, &old_dest);
+}
-- 
2.41.0


