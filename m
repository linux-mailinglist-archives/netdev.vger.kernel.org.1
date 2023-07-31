Return-Path: <netdev+bounces-22794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1D67694DA
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021092809E5
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296BD18014;
	Mon, 31 Jul 2023 11:28:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CE182A1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE4BC433A9;
	Mon, 31 Jul 2023 11:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802929;
	bh=1HDoMZ0MiBwlGZ8A3Ms52shahgVYGgwkv+NpRUfKlO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnNgTc//fGGrX+ppd07wiQq7+CXTbbNbRGaa7VFoLleGj2WSYI7h3pCIWMMubpr6/
	 vy3xsolmRJLMVsNn5nLmK56r6qz/uazN1eH9i++kMXAhnQJL9prwu1KOhwHFk2XvH8
	 OW5fHdZMwAFAFu2JxAlsBgEEAT4gQUsWGFTBbmXUCvlEiMmZxV7gqf5V1l+VgSyyVe
	 QBTfhqgOgBAV87N8v8SmuBi4sKhpH8U74FU4YX+5OU3uF3rfIZ710rP2+tUdY+HTOO
	 MZV+EWQ3wmlEAzvhgOGrieNK7wRZiK4L22isNzYV4PusoledhR5VRxjU23SVOIWnkM
	 5z6tG8JX24hBw==
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
Subject: [PATCH net-next v1 06/13] net/mlx5e: Handle IPsec offload for RX datapath in switchdev mode
Date: Mon, 31 Jul 2023 14:28:17 +0300
Message-ID: <43d60fbcc9cd672a97d7e2a2f7fe6a3d9e9a776d.1690802064.git.leon@kernel.org>
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

Reuse tun opts bits in reg c1, to pass IPsec obj id to datapath.
As this is only for RX SA and there are only 11 bits, xarray is used
to map IPsec obj id to an index, which is between 1 and 0x7ff, and
replace obj id to write to reg c1.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/rep/tc.c   | 17 ++++-
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  2 +
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  7 ++
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c  | 22 ++++++
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |  2 +
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 69 +++++++++++++++++++
 .../mellanox/mlx5/core/esw/ipsec_fs.h         | 20 ++++++
 include/linux/mlx5/eswitch.h                  |  3 +
 8 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
index b5c773ffc763..b12fe3c5a258 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
@@ -715,9 +715,20 @@ void mlx5e_rep_tc_receive(struct mlx5_cqe64 *cqe, struct mlx5e_rq *rq,
 	uplink_priv = &uplink_rpriv->uplink_priv;
 	ct_priv = uplink_priv->ct_priv;
 
-	if (!mlx5_ipsec_is_rx_flow(cqe) &&
-	    !mlx5e_tc_update_skb(cqe, skb, mapping_ctx, reg_c0, ct_priv, zone_restore_id, tunnel_id,
-				 &tc_priv))
+#ifdef CONFIG_MLX5_EN_IPSEC
+	if (!(tunnel_id >> ESW_TUN_OPTS_BITS)) {
+		u32 mapped_id;
+		u32 metadata;
+
+		mapped_id = tunnel_id & ESW_IPSEC_RX_MAPPED_ID_MASK;
+		if (mapped_id &&
+		    !mlx5_esw_ipsec_rx_make_metadata(priv, mapped_id, &metadata))
+			mlx5e_ipsec_offload_handle_rx_skb(priv->netdev, skb, metadata);
+	}
+#endif
+
+	if (!mlx5e_tc_update_skb(cqe, skb, mapping_ctx, reg_c0, ct_priv,
+				 zone_restore_id, tunnel_id, &tc_priv))
 		goto free_skb;
 
 forward:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 578af9d7aef3..168b9600bde3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -210,6 +210,7 @@ struct mlx5e_ipsec_rx {
 	struct mlx5e_ipsec_fc *fc;
 	struct mlx5_fs_chains *chains;
 	u8 allow_tunnel_mode : 1;
+	struct xarray ipsec_obj_id_map;
 };
 
 struct mlx5e_ipsec {
@@ -256,6 +257,7 @@ struct mlx5e_ipsec_sa_entry {
 	struct mlx5e_ipsec_work *work;
 	struct mlx5e_ipsec_dwork *dwork;
 	struct mlx5e_ipsec_limits limits;
+	u32 rx_mapped_id;
 };
 
 struct mlx5_accel_pol_xfrm_attrs {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 2db16e49abc1..84322e85cd23 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1153,6 +1153,9 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		err = setup_modify_header(ipsec, attrs->type,
 					  sa_entry->ipsec_obj_id | BIT(31),
 					  XFRM_DEV_OFFLOAD_IN, &flow_act);
+	else
+		err = mlx5_esw_ipsec_rx_setup_modify_header(sa_entry, &flow_act);
+
 	if (err)
 		goto err_mod_header;
 
@@ -1641,6 +1644,7 @@ void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	}
 
 	mlx5_modify_header_dealloc(mdev, ipsec_rule->modify_hdr);
+	mlx5_esw_ipsec_rx_id_mapping_remove(sa_entry);
 	rx_ft_put(sa_entry->ipsec, sa_entry->attrs.family, sa_entry->attrs.type);
 }
 
@@ -1693,6 +1697,8 @@ void mlx5e_accel_ipsec_fs_cleanup(struct mlx5e_ipsec *ipsec)
 	kfree(ipsec->rx_ipv6);
 
 	if (ipsec->is_uplink_rep) {
+		xa_destroy(&ipsec->rx_esw->ipsec_obj_id_map);
+
 		mutex_destroy(&ipsec->tx_esw->ft.mutex);
 		WARN_ON(ipsec->tx_esw->ft.refcnt);
 		kfree(ipsec->tx_esw);
@@ -1753,6 +1759,7 @@ int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec)
 		mutex_init(&ipsec->tx_esw->ft.mutex);
 		mutex_init(&ipsec->rx_esw->ft.mutex);
 		ipsec->tx_esw->ns = ns_esw;
+		xa_init_flags(&ipsec->rx_esw->ipsec_obj_id_map, XA_FLAGS_ALLOC1);
 	} else if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_ROCE) {
 		ipsec->roce = mlx5_ipsec_fs_roce_init(mdev);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index 8d6379ac4574..c00fe0d5ea11 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -37,6 +37,7 @@
 #include "ipsec.h"
 #include "ipsec_rxtx.h"
 #include "en.h"
+#include "esw/ipsec_fs.h"
 
 enum {
 	MLX5E_IPSEC_TX_SYNDROME_OFFLOAD = 0x8,
@@ -355,3 +356,24 @@ void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 		atomic64_inc(&ipsec->sw_stats.ipsec_rx_drop_syndrome);
 	}
 }
+
+int mlx5_esw_ipsec_rx_make_metadata(struct mlx5e_priv *priv, u32 id, u32 *metadata)
+{
+	struct mlx5e_ipsec *ipsec = priv->ipsec;
+	u32 ipsec_obj_id;
+	int err;
+
+	if (!ipsec || !ipsec->is_uplink_rep)
+		return -EINVAL;
+
+	err = mlx5_esw_ipsec_rx_ipsec_obj_id_search(priv, id, &ipsec_obj_id);
+	if (err) {
+		atomic64_inc(&ipsec->sw_stats.ipsec_rx_drop_sadb_miss);
+		return err;
+	}
+
+	*metadata = MLX5_IPSEC_METADATA_CREATE(ipsec_obj_id,
+					       MLX5E_IPSEC_OFFLOAD_RX_SYNDROME_DECRYPTED);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 436e9a8a32d3..9ee014a8ad24 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -43,6 +43,7 @@
 #define MLX5_IPSEC_METADATA_MARKER(metadata)  (((metadata) >> 31) & 0x1)
 #define MLX5_IPSEC_METADATA_SYNDROM(metadata) (((metadata) >> 24) & GENMASK(5, 0))
 #define MLX5_IPSEC_METADATA_HANDLE(metadata)  ((metadata) & GENMASK(23, 0))
+#define MLX5_IPSEC_METADATA_CREATE(id, syndrome) ((id) | ((syndrome) << 24))
 
 struct mlx5e_accel_tx_ipsec_state {
 	struct xfrm_offload *xo;
@@ -67,6 +68,7 @@ void mlx5e_ipsec_handle_tx_wqe(struct mlx5e_tx_wqe *wqe,
 void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 				       struct sk_buff *skb,
 				       u32 ipsec_meta_data);
+int mlx5_esw_ipsec_rx_make_metadata(struct mlx5e_priv *priv, u32 id, u32 *metadata);
 static inline unsigned int mlx5e_ipsec_tx_ids_len(struct mlx5e_accel_tx_ipsec_state *ipsec_st)
 {
 	return ipsec_st->tailen;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 7df7a8b0a6a0..0675587c1a79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -182,3 +182,72 @@ int mlx5_esw_ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
 
 	return 0;
 }
+
+int mlx5_esw_ipsec_rx_setup_modify_header(struct mlx5e_ipsec_sa_entry *sa_entry,
+					  struct mlx5_flow_act *flow_act)
+{
+	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
+	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5_modify_hdr *modify_hdr;
+	u32 mapped_id;
+	int err;
+
+	err = xa_alloc_bh(&ipsec->rx_esw->ipsec_obj_id_map, &mapped_id,
+			  xa_mk_value(sa_entry->ipsec_obj_id),
+			  XA_LIMIT(1, ESW_IPSEC_RX_MAPPED_ID_MASK), 0);
+	if (err)
+		return err;
+
+	/* reuse tunnel bits for ipsec,
+	 * tun_id is always 0 and tun_opts is mapped to ipsec_obj_id.
+	 */
+	MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
+	MLX5_SET(set_action_in, action, field,
+		 MLX5_ACTION_IN_FIELD_METADATA_REG_C_1);
+	MLX5_SET(set_action_in, action, offset, ESW_ZONE_ID_BITS);
+	MLX5_SET(set_action_in, action, length,
+		 ESW_TUN_ID_BITS + ESW_TUN_OPTS_BITS);
+	MLX5_SET(set_action_in, action, data, mapped_id);
+
+	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_FDB,
+					      1, action);
+	if (IS_ERR(modify_hdr)) {
+		err = PTR_ERR(modify_hdr);
+		goto err_header_alloc;
+	}
+
+	sa_entry->rx_mapped_id = mapped_id;
+	flow_act->modify_hdr = modify_hdr;
+	flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
+
+	return 0;
+
+err_header_alloc:
+	xa_erase_bh(&ipsec->rx_esw->ipsec_obj_id_map, mapped_id);
+	return err;
+}
+
+void mlx5_esw_ipsec_rx_id_mapping_remove(struct mlx5e_ipsec_sa_entry *sa_entry)
+{
+	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
+
+	if (sa_entry->rx_mapped_id)
+		xa_erase_bh(&ipsec->rx_esw->ipsec_obj_id_map,
+			    sa_entry->rx_mapped_id);
+}
+
+int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv, u32 id,
+					  u32 *ipsec_obj_id)
+{
+	struct mlx5e_ipsec *ipsec = priv->ipsec;
+	void *val;
+
+	val = xa_load(&ipsec->rx_esw->ipsec_obj_id_map, id);
+	if (!val)
+		return -ENOENT;
+
+	*ipsec_obj_id = xa_to_value(val);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
index 1d6104648d32..44df34032d1e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
@@ -5,6 +5,7 @@
 #define __MLX5_ESW_IPSEC_FS_H__
 
 struct mlx5e_ipsec;
+struct mlx5e_ipsec_sa_entry;
 
 #ifdef CONFIG_MLX5_ESWITCH
 void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
@@ -16,6 +17,11 @@ void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_rx_create_attr *attr);
 int mlx5_esw_ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
 					   struct mlx5_flow_destination *dest);
+int mlx5_esw_ipsec_rx_setup_modify_header(struct mlx5e_ipsec_sa_entry *sa_entry,
+					  struct mlx5_flow_act *flow_act);
+void mlx5_esw_ipsec_rx_id_mapping_remove(struct mlx5e_ipsec_sa_entry *sa_entry);
+int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv, u32 id,
+					  u32 *ipsec_obj_id);
 #else
 static inline void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
 						    struct mlx5e_ipsec_rx *rx) {}
@@ -35,5 +41,19 @@ static inline int mlx5_esw_ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ips
 {
 	return -EINVAL;
 }
+
+static inline int mlx5_esw_ipsec_rx_setup_modify_header(struct mlx5e_ipsec_sa_entry *sa_entry,
+							struct mlx5_flow_act *flow_act)
+{
+	return -EINVAL;
+}
+
+static inline void mlx5_esw_ipsec_rx_id_mapping_remove(struct mlx5e_ipsec_sa_entry *sa_entry) {}
+
+static inline int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv, u32 id,
+							u32 *ipsec_obj_id)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_MLX5_ESWITCH */
 #endif /* __MLX5_ESW_IPSEC_FS_H__ */
diff --git a/include/linux/mlx5/eswitch.h b/include/linux/mlx5/eswitch.h
index e2701ed0200e..950d2431a53c 100644
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@ -144,6 +144,9 @@ u32 mlx5_eswitch_get_vport_metadata_for_set(struct mlx5_eswitch *esw,
 	GENMASK(31 - ESW_TUN_ID_BITS - ESW_RESERVED_BITS, \
 		ESW_TUN_OPTS_OFFSET + 1)
 
+/* reuse tun_opts for the mapped ipsec obj id when tun_id is 0 (invalid) */
+#define ESW_IPSEC_RX_MAPPED_ID_MASK GENMASK(ESW_TUN_OPTS_BITS - 1, 0)
+
 u8 mlx5_eswitch_mode(const struct mlx5_core_dev *dev);
 u16 mlx5_eswitch_get_total_vports(const struct mlx5_core_dev *dev);
 struct mlx5_core_dev *mlx5_eswitch_get_core_dev(struct mlx5_eswitch *esw);
-- 
2.41.0


