Return-Path: <netdev+bounces-16770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2500874EAC5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D012C280D08
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CBE19BC5;
	Tue, 11 Jul 2023 09:30:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F519BC0
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE64C43391;
	Tue, 11 Jul 2023 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689067800;
	bh=A1CzhaQ/PSubC+nxgUa2Zg6N3pljvMw4rnbWqbDLrOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MiKPIPi1gyLL0iwcap7MiTAKN6vxeT/QAAoQctk5e9b7Clo81nSEZ9YRqXu04dWhf
	 +G6G8HseUCmDCLOHOmmcUPzdBXvgKbq965GsXwAK2AGa1A8UMP4JFtvZHligyvoLLq
	 Wy6qrvEJytXzaGuJFXfRgtPRJHMTEPjOJWdzfnik5IUcnt9Z6x1npVVaKBMCCpwEqU
	 EbUdpKUVtTWVEG6TtCpppWdDpWjUHU8impDVnGo43EIzB9xacwpiKwNR1uIqlUwBT0
	 EablHDccNiQU1ATANURWoDgsClHnQNolwgWtcBNYokmPcNlhg6qSIM1GL7g1OX6KZ7
	 HqbeMUSV521LQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next 10/12] net/mlx5e: Make IPsec offload work together with eswitch and TC
Date: Tue, 11 Jul 2023 12:29:08 +0300
Message-ID: <b74dd646b3443e25e80b2e4f173072d7c81f5590.1689064922.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689064922.git.leonro@nvidia.com>
References: <cover.1689064922.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

The eswitch mode is not allowed to change if there are any IPsec rules.
Besides, by using mlx5_esw_try_lock() to get eswitch mode lock, IPsec
rules are not allowed to be offloaded if there are any TC rules.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 59 ++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 14 ++++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 70 +++++++++++++++++++
 3 files changed, 128 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index a2f3ba811af8..2e5eb427f824 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -254,8 +254,6 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	mlx5_del_flow_rules(rx->sa.rule);
 	mlx5_destroy_flow_group(rx->sa.group);
 	mlx5_destroy_flow_table(rx->ft.sa);
-	if (rx->allow_tunnel_mode)
-		mlx5_eswitch_unblock_encap(mdev);
 	if (rx == ipsec->rx_esw) {
 		mlx5_esw_ipsec_rx_status_destroy(ipsec, rx);
 	} else {
@@ -359,8 +357,6 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		goto err_add;
 
 	/* Create FT */
-	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
-		rx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
 	if (rx->allow_tunnel_mode)
 		flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
 	ft = ipsec_ft_create(attr.ns, attr.sa_level, attr.prio, 2, flags);
@@ -415,8 +411,6 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 err_fs:
 	mlx5_destroy_flow_table(rx->ft.sa);
 err_fs_ft:
-	if (rx->allow_tunnel_mode)
-		mlx5_eswitch_unblock_encap(mdev);
 	mlx5_del_flow_rules(rx->status.rule);
 	mlx5_modify_header_dealloc(mdev, rx->status.modify_hdr);
 err_add:
@@ -434,13 +428,26 @@ static int rx_get(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (rx->ft.refcnt)
 		goto skip;
 
+	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
+		rx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
+
+	err = mlx5_eswitch_block_mode_trylock(mdev);
+	if (err)
+		goto err_out;
+
 	err = rx_create(mdev, ipsec, rx, family);
+	mlx5_eswitch_block_mode_unlock(mdev, err);
 	if (err)
-		return err;
+		goto err_out;
 
 skip:
 	rx->ft.refcnt++;
 	return 0;
+
+err_out:
+	if (rx->allow_tunnel_mode)
+		mlx5_eswitch_unblock_encap(mdev);
+	return err;
 }
 
 static void rx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_rx *rx,
@@ -449,7 +456,12 @@ static void rx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_rx *rx,
 	if (--rx->ft.refcnt)
 		return;
 
+	mlx5_eswitch_unblock_mode_lock(ipsec->mdev);
 	rx_destroy(ipsec->mdev, ipsec, rx, family);
+	mlx5_eswitch_unblock_mode_unlock(ipsec->mdev);
+
+	if (rx->allow_tunnel_mode)
+		mlx5_eswitch_unblock_encap(ipsec->mdev);
 }
 
 static struct mlx5e_ipsec_rx *rx_ft_get(struct mlx5_core_dev *mdev,
@@ -569,8 +581,6 @@ static void tx_destroy(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 		mlx5_destroy_flow_group(tx->sa.group);
 	}
 	mlx5_destroy_flow_table(tx->ft.sa);
-	if (tx->allow_tunnel_mode)
-		mlx5_eswitch_unblock_encap(ipsec->mdev);
 	mlx5_del_flow_rules(tx->status.rule);
 	mlx5_destroy_flow_table(tx->ft.status);
 }
@@ -611,8 +621,6 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 	if (err)
 		goto err_status_rule;
 
-	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
-		tx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
 	if (tx->allow_tunnel_mode)
 		flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
 	ft = ipsec_ft_create(tx->ns, attr.sa_level, attr.prio, 4, flags);
@@ -679,8 +687,6 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 err_sa_miss:
 	mlx5_destroy_flow_table(tx->ft.sa);
 err_sa_ft:
-	if (tx->allow_tunnel_mode)
-		mlx5_eswitch_unblock_encap(mdev);
 	mlx5_del_flow_rules(tx->status.rule);
 err_status_rule:
 	mlx5_destroy_flow_table(tx->ft.status);
@@ -714,16 +720,32 @@ static int tx_get(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (tx->ft.refcnt)
 		goto skip;
 
-	err = tx_create(ipsec, tx, ipsec->roce);
+	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
+		tx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
+
+	err = mlx5_eswitch_block_mode_trylock(mdev);
 	if (err)
-		return err;
+		goto err_out;
+
+	err = tx_create(ipsec, tx, ipsec->roce);
+	if (err) {
+		mlx5_eswitch_block_mode_unlock(mdev, err);
+		goto err_out;
+	}
 
 	if (tx == ipsec->tx_esw)
 		ipsec_esw_tx_ft_policy_set(mdev, tx->ft.pol);
 
+	mlx5_eswitch_block_mode_unlock(mdev, err);
+
 skip:
 	tx->ft.refcnt++;
 	return 0;
+
+err_out:
+	if (tx->allow_tunnel_mode)
+		mlx5_eswitch_unblock_encap(mdev);
+	return err;
 }
 
 static void tx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx)
@@ -731,10 +753,17 @@ static void tx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx)
 	if (--tx->ft.refcnt)
 		return;
 
+	mlx5_eswitch_unblock_mode_lock(ipsec->mdev);
+
 	if (tx == ipsec->tx_esw)
 		ipsec_esw_tx_ft_policy_set(ipsec->mdev, NULL);
 
 	tx_destroy(ipsec, tx, ipsec->roce);
+
+	mlx5_eswitch_unblock_mode_unlock(ipsec->mdev);
+
+	if (tx->allow_tunnel_mode)
+		mlx5_eswitch_unblock_encap(ipsec->mdev);
 }
 
 static struct mlx5_flow_table *tx_ft_get_policy(struct mlx5_core_dev *mdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 1070cfa72678..ddd16fd4a3a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -270,6 +270,7 @@ struct mlx5_esw_offload {
 	u8 inline_mode;
 	atomic64_t num_flows;
 	u64 num_block_encap;
+	u64 num_block_mode;
 	enum devlink_eswitch_encap_mode encap;
 	struct ida vport_metadata_ida;
 	unsigned int host_number; /* ECPF supports one external host */
@@ -789,6 +790,11 @@ int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw);
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev);
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
 
+int mlx5_eswitch_block_mode_trylock(struct mlx5_core_dev *dev);
+void mlx5_eswitch_block_mode_unlock(struct mlx5_core_dev *dev, int err);
+void mlx5_eswitch_unblock_mode_lock(struct mlx5_core_dev *dev);
+void mlx5_eswitch_unblock_mode_unlock(struct mlx5_core_dev *dev);
+
 static inline int mlx5_eswitch_num_vfs(struct mlx5_eswitch *esw)
 {
 	if (mlx5_esw_allowed(esw))
@@ -867,6 +873,14 @@ static inline bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev)
 static inline void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev)
 {
 }
+
+static inline int mlx5_eswitch_block_mode_trylock(struct mlx5_core_dev *dev) { return 0; }
+
+static inline void mlx5_eswitch_block_mode_unlock(struct mlx5_core_dev *dev, int err) {}
+
+static inline void mlx5_eswitch_unblock_mode_lock(struct mlx5_core_dev *dev) {}
+
+static inline void mlx5_eswitch_unblock_mode_unlock(struct mlx5_core_dev *dev) {}
 #endif /* CONFIG_MLX5_ESWITCH */
 
 #endif /* __MLX5_ESWITCH_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index e8bf18098203..52e974e2d74a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3513,6 +3513,69 @@ static bool esw_offloads_devlink_ns_eq_netdev_ns(struct devlink *devlink)
 	return net_eq(devl_net, netdev_net);
 }
 
+int mlx5_eswitch_block_mode_trylock(struct mlx5_core_dev *dev)
+{
+	struct devlink *devlink = priv_to_devlink(dev);
+	struct mlx5_eswitch *esw;
+	int err;
+
+	devl_lock(devlink);
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw)) {
+		/* Failure means no eswitch => not possible to change eswitch mode */
+		devl_unlock(devlink);
+		return 0;
+	}
+
+	err = mlx5_esw_try_lock(esw);
+	if (err < 0) {
+		devl_unlock(devlink);
+		return err;
+	}
+
+	return 0;
+}
+
+void mlx5_eswitch_block_mode_unlock(struct mlx5_core_dev *dev, int err)
+{
+	struct devlink *devlink = priv_to_devlink(dev);
+	struct mlx5_eswitch *esw;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return;
+
+	if (!err)
+		esw->offloads.num_block_mode++;
+	mlx5_esw_unlock(esw);
+	devl_unlock(devlink);
+}
+
+void mlx5_eswitch_unblock_mode_lock(struct mlx5_core_dev *dev)
+{
+	struct devlink *devlink = priv_to_devlink(dev);
+	struct mlx5_eswitch *esw;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return;
+
+	down_write(&esw->mode_lock);
+}
+
+void mlx5_eswitch_unblock_mode_unlock(struct mlx5_core_dev *dev)
+{
+	struct devlink *devlink = priv_to_devlink(dev);
+	struct mlx5_eswitch *esw;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return;
+
+	esw->offloads.num_block_mode--;
+	up_write(&esw->mode_lock);
+}
+
 int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 				  struct netlink_ext_ack *extack)
 {
@@ -3546,6 +3609,13 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (cur_mlx5_mode == mlx5_mode)
 		goto unlock;
 
+	if (esw->offloads.num_block_mode) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't change eswitch mode when IPsec SA and/or policies are configured");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
 	mlx5_eswitch_disable_locked(esw);
 	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV) {
 		if (mlx5_devlink_trap_get_num_active(esw->dev)) {
-- 
2.41.0


