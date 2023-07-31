Return-Path: <netdev+bounces-22800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7FD7694EE
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828D2281697
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434A182A0;
	Mon, 31 Jul 2023 11:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8D18AF3
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334A3C433CB;
	Mon, 31 Jul 2023 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802951;
	bh=y4382DFETtqpri5FI7WpGZ5z7s0wbHkn72khHVt9LB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9vFQixMfVV3xv+PEet0KdaHoxYUGjNZgw+HYbEDCrTrjsM4cSG0UyeI+r4xggYMb
	 t3Nme5BrMJebVlxhodlLjHVs9XbB/wZhKQbDcgyryAXCvg6SVy2P1OMju+4ygdcARd
	 8MeaHtBjFDeZrjllQz9MVSbq7so1MmXzFTiJBJHz9cnSsBGMrIOg5LScza/5Gspvar
	 m6samjwjZ/PHA8iHotcpx1VUPOiYFKm38T1mp0tdS4uyCmciEJLKwaJ/j8DbKQuz0h
	 DG6k6blg3SM0y4rnVxCNTNX2Qk74GpqyDp8K/4c/yBV4ODmjUhGFU8Bk2mzoC9uthz
	 szohIOcWvMotA==
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
Subject: [PATCH net-next v1 08/13] net/mlx5e: Support IPsec packet offload for TX in switchdev mode
Date: Mon, 31 Jul 2023 14:28:19 +0300
Message-ID: <cfd0e6ffaf0b8c55ebaa9fb0649b7c504b6b8ec6.1690802064.git.leon@kernel.org>
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

The IPsec encryption is done at the last, so add new prio for IPsec
offload in FDB, and put it just lower than the slow path prio and
higher than the per-vport prio.
Three levels are added for TX. The first one is for ip xfrm policy.
The sa table is created in the second level for ip xfrm state. The
status table is created at the last to count the number of packets
encrypted.
The rules, which forward packets to uplink, are changed to forward
them to IPsec TX tables first. These rules are restored after those
tables are destroyed, which is done immediately when there is no
reference to them, just as what does in legacy mode. The support for
slow path is added here, by refreshing uplink's channels. But, the
handling for TC fast path, which is more complicated, will be added
later. Besides, reg c4 is used instead to match reqid.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 70 ++++++++++++++++---
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 16 +++++
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  5 ++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  1 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 11 +++
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  6 ++
 include/linux/mlx5/fs.h                       |  1 +
 7 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 6d4d2b824b75..36704c9fce33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -10,6 +10,7 @@
 #include "lib/ipsec_fs_roce.h"
 #include "lib/fs_chains.h"
 #include "esw/ipsec_fs.h"
+#include "en_rep.h"
 
 #define NUM_IPSEC_FTE BIT(15)
 #define MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_SIZE 16
@@ -23,6 +24,7 @@ struct mlx5e_ipsec_fc {
 struct mlx5e_ipsec_tx {
 	struct mlx5e_ipsec_ft ft;
 	struct mlx5e_ipsec_miss pol;
+	struct mlx5e_ipsec_miss sa;
 	struct mlx5e_ipsec_rule status;
 	struct mlx5_flow_namespace *ns;
 	struct mlx5e_ipsec_fc *fc;
@@ -550,7 +552,7 @@ static int ipsec_counter_rule_tx(struct mlx5_core_dev *mdev, struct mlx5e_ipsec_
 }
 
 /* IPsec TX flow steering */
-static void tx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec_tx *tx,
+static void tx_destroy(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 		       struct mlx5_ipsec_fs *roce)
 {
 	mlx5_ipsec_fs_roce_tx_destroy(roce);
@@ -562,9 +564,13 @@ static void tx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec_tx *tx,
 		mlx5_destroy_flow_table(tx->ft.pol);
 	}
 
+	if (tx == ipsec->tx_esw) {
+		mlx5_del_flow_rules(tx->sa.rule);
+		mlx5_destroy_flow_group(tx->sa.group);
+	}
 	mlx5_destroy_flow_table(tx->ft.sa);
 	if (tx->allow_tunnel_mode)
-		mlx5_eswitch_unblock_encap(mdev);
+		mlx5_eswitch_unblock_encap(ipsec->mdev);
 	mlx5_del_flow_rules(tx->status.rule);
 	mlx5_destroy_flow_table(tx->ft.status);
 }
@@ -573,6 +579,11 @@ static void ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				     struct mlx5e_ipsec_tx *tx,
 				     struct mlx5e_ipsec_tx_create_attr *attr)
 {
+	if (tx == ipsec->tx_esw) {
+		mlx5_esw_ipsec_tx_create_attr_set(ipsec, attr);
+		return;
+	}
+
 	attr->prio = 0;
 	attr->pol_level = 0;
 	attr->sa_level = 1;
@@ -611,6 +622,15 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 	}
 	tx->ft.sa = ft;
 
+	if (tx == ipsec->tx_esw) {
+		dest.type = MLX5_FLOW_DESTINATION_TYPE_VPORT;
+		dest.vport.num = MLX5_VPORT_UPLINK;
+		err = ipsec_miss_create(mdev, tx->ft.sa, &tx->sa, &dest);
+		if (err)
+			goto err_sa_miss;
+		memset(&dest, 0, sizeof(dest));
+	}
+
 	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_PRIO) {
 		tx->chains = ipsec_chains_create(
 			mdev, tx->ft.sa, attr.chains_ns, attr.prio, attr.pol_level,
@@ -652,6 +672,11 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 		mlx5_destroy_flow_table(tx->ft.pol);
 	}
 err_pol_ft:
+	if (tx == ipsec->tx_esw) {
+		mlx5_del_flow_rules(tx->sa.rule);
+		mlx5_destroy_flow_group(tx->sa.group);
+	}
+err_sa_miss:
 	mlx5_destroy_flow_table(tx->ft.sa);
 err_sa_ft:
 	if (tx->allow_tunnel_mode)
@@ -662,6 +687,25 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 	return err;
 }
 
+static void ipsec_esw_tx_ft_policy_set(struct mlx5_core_dev *mdev,
+				       struct mlx5_flow_table *ft)
+{
+#ifdef CONFIG_MLX5_ESWITCH
+	struct mlx5_eswitch *esw = mdev->priv.eswitch;
+	struct mlx5e_rep_priv *uplink_rpriv;
+	struct mlx5e_priv *priv;
+
+	esw->offloads.ft_ipsec_tx_pol = ft;
+	uplink_rpriv = mlx5_eswitch_get_uplink_priv(esw, REP_ETH);
+	priv = netdev_priv(uplink_rpriv->netdev);
+	if (!priv->channels.num)
+		return;
+
+	mlx5e_rep_deactivate_channels(priv);
+	mlx5e_rep_activate_channels(priv);
+#endif
+}
+
 static int tx_get(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		  struct mlx5e_ipsec_tx *tx)
 {
@@ -674,6 +718,9 @@ static int tx_get(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (err)
 		return err;
 
+	if (tx == ipsec->tx_esw)
+		ipsec_esw_tx_ft_policy_set(mdev, tx->ft.pol);
+
 skip:
 	tx->ft.refcnt++;
 	return 0;
@@ -684,7 +731,10 @@ static void tx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx)
 	if (--tx->ft.refcnt)
 		return;
 
-	tx_destroy(ipsec->mdev, tx, ipsec->roce);
+	if (tx == ipsec->tx_esw)
+		ipsec_esw_tx_ft_policy_set(ipsec->mdev, NULL);
+
+	tx_destroy(ipsec, tx, ipsec->roce);
 }
 
 static struct mlx5_flow_table *tx_ft_get_policy(struct mlx5_core_dev *mdev,
@@ -842,15 +892,15 @@ static void setup_fte_reg_a(struct mlx5_flow_spec *spec)
 		 misc_parameters_2.metadata_reg_a, MLX5_ETH_WQE_FT_META_IPSEC);
 }
 
-static void setup_fte_reg_c0(struct mlx5_flow_spec *spec, u32 reqid)
+static void setup_fte_reg_c4(struct mlx5_flow_spec *spec, u32 reqid)
 {
 	/* Pass policy check before choosing this SA */
 	spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
 
-	MLX5_SET(fte_match_param, spec->match_criteria,
-		 misc_parameters_2.metadata_reg_c_0, reqid);
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 misc_parameters_2.metadata_reg_c_4);
 	MLX5_SET(fte_match_param, spec->match_value,
-		 misc_parameters_2.metadata_reg_c_0, reqid);
+		 misc_parameters_2.metadata_reg_c_4, reqid);
 }
 
 static void setup_fte_upper_proto_match(struct mlx5_flow_spec *spec, struct upspec *upspec)
@@ -902,7 +952,7 @@ static int setup_modify_header(struct mlx5e_ipsec *ipsec, int type, u32 val, u8
 		break;
 	case XFRM_DEV_OFFLOAD_OUT:
 		MLX5_SET(set_action_in, action, field,
-			 MLX5_ACTION_IN_FIELD_METADATA_REG_C_0);
+			 MLX5_ACTION_IN_FIELD_METADATA_REG_C_4);
 		break;
 	default:
 		return -EINVAL;
@@ -1268,7 +1318,7 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		break;
 	case XFRM_DEV_OFFLOAD_PACKET:
 		if (attrs->reqid)
-			setup_fte_reg_c0(spec, attrs->reqid);
+			setup_fte_reg_c4(spec, attrs->reqid);
 		err = setup_pkt_reformat(ipsec, attrs, &flow_act);
 		if (err)
 			goto err_pkt_reformat;
@@ -1379,6 +1429,8 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 	}
 
 	flow_act.flags |= FLOW_ACT_NO_APPEND;
+	if (tx == ipsec->tx_esw && tx->chains)
+		flow_act.flags |= FLOW_ACT_IGNORE_FLOW_LEVEL;
 	dest[dstn].ft = tx->ft.sa;
 	dest[dstn].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 	dstn++;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 0675587c1a79..e60cd3dc1b13 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -12,6 +12,12 @@ enum {
 	MLX5_ESW_IPSEC_RX_ESP_FT_CHK_LEVEL,
 };
 
+enum {
+	MLX5_ESW_IPSEC_TX_POL_FT_LEVEL,
+	MLX5_ESW_IPSEC_TX_ESP_FT_LEVEL,
+	MLX5_ESW_IPSEC_TX_ESP_FT_CNT_LEVEL,
+};
+
 static void esw_ipsec_rx_status_drop_destroy(struct mlx5e_ipsec *ipsec,
 					     struct mlx5e_ipsec_rx *rx)
 {
@@ -251,3 +257,13 @@ int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv, u32 id,
 
 	return 0;
 }
+
+void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_tx_create_attr *attr)
+{
+	attr->prio = FDB_CRYPTO_EGRESS;
+	attr->pol_level = MLX5_ESW_IPSEC_TX_POL_FT_LEVEL;
+	attr->sa_level = MLX5_ESW_IPSEC_TX_ESP_FT_LEVEL;
+	attr->cnt_level = MLX5_ESW_IPSEC_TX_ESP_FT_CNT_LEVEL;
+	attr->chains_ns = MLX5_FLOW_NAMESPACE_FDB;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
index 44df34032d1e..275684f99ed3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
@@ -22,6 +22,8 @@ int mlx5_esw_ipsec_rx_setup_modify_header(struct mlx5e_ipsec_sa_entry *sa_entry,
 void mlx5_esw_ipsec_rx_id_mapping_remove(struct mlx5e_ipsec_sa_entry *sa_entry);
 int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv, u32 id,
 					  u32 *ipsec_obj_id);
+void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_tx_create_attr *attr);
 #else
 static inline void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
 						    struct mlx5e_ipsec_rx *rx) {}
@@ -55,5 +57,8 @@ static inline int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv,
 {
 	return -EINVAL;
 }
+
+static inline void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
+						     struct mlx5e_ipsec_tx_create_attr *attr) {}
 #endif /* CONFIG_MLX5_ESWITCH */
 #endif /* __MLX5_ESW_IPSEC_FS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 2944c9207487..c7b5faae20a7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -254,6 +254,7 @@ struct mlx5_esw_offload {
 	struct mlx5_flow_group *vport_rx_group;
 	struct mlx5_flow_group *vport_rx_drop_group;
 	struct mlx5_flow_handle *vport_rx_drop_rule;
+	struct mlx5_flow_table *ft_ipsec_tx_pol;
 	struct xarray vport_reps;
 	struct list_head peer_flows[MLX5_MAX_PORTS];
 	struct mutex peer_mutex;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index f83667b4339e..dc22a7f959e3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -884,6 +884,17 @@ mlx5_eswitch_add_send_to_vport_rule(struct mlx5_eswitch *on_esw,
 	dest.vport.flags |= MLX5_FLOW_DEST_VPORT_VHCA_ID;
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
 
+	if (rep->vport == MLX5_VPORT_UPLINK && on_esw->offloads.ft_ipsec_tx_pol) {
+		dest.ft = on_esw->offloads.ft_ipsec_tx_pol;
+		flow_act.flags = FLOW_ACT_IGNORE_FLOW_LEVEL;
+		dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	} else {
+		dest.type = MLX5_FLOW_DESTINATION_TYPE_VPORT;
+		dest.vport.num = rep->vport;
+		dest.vport.vhca_id = MLX5_CAP_GEN(rep->esw->dev, vhca_id);
+		dest.vport.flags |= MLX5_FLOW_DEST_VPORT_VHCA_ID;
+	}
+
 	if (MLX5_CAP_ESW_FLOWTABLE(on_esw->dev, flow_source) &&
 	    rep->vport == MLX5_VPORT_UPLINK)
 		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_LOCAL_VPORT;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 8ae1854d6b73..830ff8480fe1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3015,6 +3015,12 @@ static int init_fdb_root_ns(struct mlx5_flow_steering *steering)
 		goto out_err;
 	}
 
+	maj_prio = fs_create_prio(&steering->fdb_root_ns->ns, FDB_CRYPTO_EGRESS, 3);
+	if (IS_ERR(maj_prio)) {
+		err = PTR_ERR(maj_prio);
+		goto out_err;
+	}
+
 	/* We put this priority last, knowing that nothing will get here
 	 * unless explicitly forwarded to. This is possible because the
 	 * slow path tables have catch all rules and nothing gets passed
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 6b1fa94f69c8..c302ec34255b 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -115,6 +115,7 @@ enum {
 	FDB_TC_MISS,
 	FDB_BR_OFFLOAD,
 	FDB_SLOW_PATH,
+	FDB_CRYPTO_EGRESS,
 	FDB_PER_VPORT,
 };
 
-- 
2.41.0


