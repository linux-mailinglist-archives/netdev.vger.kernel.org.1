Return-Path: <netdev+bounces-22801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F49D7694F0
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A1E1C20C27
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C2818AF3;
	Mon, 31 Jul 2023 11:29:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F131C3B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71719C43391;
	Mon, 31 Jul 2023 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802956;
	bh=wd15Y1IdhrmKiQUFUfiXbFurkFSJ768Twwqeh0etB30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UU71biXSAVBALwW8SZ1rp3LIhqX2HJvAcOTt5vSY7q9qQc1xlnP7qI+iOLys4MpVd
	 znuremXJquyrcmHfYw9UDOZkbcMl7+fnTt0jVB5+OUEhGRfLOnNLmNRc8iaT4Glbhj
	 dy88sWxoTqmztnGUZgX9Gd/qAkXTGBzk8mk86Ns8nEKCrAQ6ifreIIkZBlytR/hIxA
	 FngdikcaE3ZaG4KObR5XVcSZ+yksYuJV/EpBLQYMhKaWwkxHKwf5Jkd/CgjxE1DATT
	 is0iRBBpE4jnyMtYhf7RANgkr5a7MDBqklmiAdu6LXsJh/4fVPCQoiyLThZIb0cPN0
	 IDAk1D3mwzEsw==
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
Subject: [PATCH net-next v1 13/13] net/mlx5e: Make TC and IPsec offloads mutually exclusive on a netdev
Date: Mon, 31 Jul 2023 14:28:24 +0300
Message-ID: <8e2e5e3b0984d785066e8663aaf97b3ba1bb873f.1690802064.git.leon@kernel.org>
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

For IPsec packet offload mode, the order of TC offload and IPsec
offload on the same netdevice is not aligned with the order in the
non-offload software. For example, for RX, the software performs TC
first and then IPsec transformation, but the implementation for
offload does that in the opposite way.

To resolve the difference for now, either IPsec offload or TC offload,
not both, is allowed for a specific interface.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 84 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 47 +++++++++++
 include/linux/mlx5/driver.h                   |  2 +
 3 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index f635b5f6e886..9a5b67344277 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1717,12 +1717,68 @@ void mlx5e_accel_ipsec_fs_read_stats(struct mlx5e_priv *priv, void *ipsec_stats)
 	}
 }
 
+#ifdef CONFIG_MLX5_ESWITCH
+static int mlx5e_ipsec_block_tc_offload(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_eswitch *esw = mdev->priv.eswitch;
+	int err = 0;
+
+	if (esw)
+		down_write(&esw->mode_lock);
+
+	if (mdev->num_block_ipsec) {
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	mdev->num_block_tc++;
+
+unlock:
+	if (esw)
+		up_write(&esw->mode_lock);
+
+	return err;
+}
+#else
+static int mlx5e_ipsec_block_tc_offload(struct mlx5_core_dev *mdev)
+{
+	if (mdev->num_block_ipsec)
+		return -EBUSY;
+
+	mdev->num_block_tc++;
+	return 0;
+}
+#endif
+
+static void mlx5e_ipsec_unblock_tc_offload(struct mlx5_core_dev *mdev)
+{
+	mdev->num_block_tc++;
+}
+
 int mlx5e_accel_ipsec_fs_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 {
+	int err;
+
+	if (sa_entry->attrs.type == XFRM_DEV_OFFLOAD_PACKET) {
+		err = mlx5e_ipsec_block_tc_offload(sa_entry->ipsec->mdev);
+		if (err)
+			return err;
+	}
+
 	if (sa_entry->attrs.dir == XFRM_DEV_OFFLOAD_OUT)
-		return tx_add_rule(sa_entry);
+		err = tx_add_rule(sa_entry);
+	else
+		err = rx_add_rule(sa_entry);
+
+	if (err)
+		goto err_out;
+
+	return 0;
 
-	return rx_add_rule(sa_entry);
+err_out:
+	if (sa_entry->attrs.type == XFRM_DEV_OFFLOAD_PACKET)
+		mlx5e_ipsec_unblock_tc_offload(sa_entry->ipsec->mdev);
+	return err;
 }
 
 void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
@@ -1735,6 +1791,9 @@ void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	if (ipsec_rule->pkt_reformat)
 		mlx5_packet_reformat_dealloc(mdev, ipsec_rule->pkt_reformat);
 
+	if (sa_entry->attrs.type == XFRM_DEV_OFFLOAD_PACKET)
+		mlx5e_ipsec_unblock_tc_offload(mdev);
+
 	if (sa_entry->attrs.dir == XFRM_DEV_OFFLOAD_OUT) {
 		tx_ft_put(sa_entry->ipsec, sa_entry->attrs.type);
 		return;
@@ -1747,10 +1806,25 @@ void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 int mlx5e_accel_ipsec_fs_add_pol(struct mlx5e_ipsec_pol_entry *pol_entry)
 {
+	int err;
+
+	err = mlx5e_ipsec_block_tc_offload(pol_entry->ipsec->mdev);
+	if (err)
+		return err;
+
 	if (pol_entry->attrs.dir == XFRM_DEV_OFFLOAD_OUT)
-		return tx_add_policy(pol_entry);
+		err = tx_add_policy(pol_entry);
+	else
+		err = rx_add_policy(pol_entry);
+
+	if (err)
+		goto err_out;
+
+	return 0;
 
-	return rx_add_policy(pol_entry);
+err_out:
+	mlx5e_ipsec_unblock_tc_offload(pol_entry->ipsec->mdev);
+	return err;
 }
 
 void mlx5e_accel_ipsec_fs_del_pol(struct mlx5e_ipsec_pol_entry *pol_entry)
@@ -1760,6 +1834,8 @@ void mlx5e_accel_ipsec_fs_del_pol(struct mlx5e_ipsec_pol_entry *pol_entry)
 
 	mlx5_del_flow_rules(ipsec_rule->rule);
 
+	mlx5e_ipsec_unblock_tc_offload(pol_entry->ipsec->mdev);
+
 	if (pol_entry->attrs.dir == XFRM_DEV_OFFLOAD_IN) {
 		rx_ft_put_policy(pol_entry->ipsec, pol_entry->attrs.family,
 				 pol_entry->attrs.prio, pol_entry->attrs.type);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index dfd282319753..7d2a029e0932 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -4606,6 +4606,46 @@ static bool is_flow_rule_duplicate_allowed(struct net_device *dev,
 	return netif_is_lag_port(dev) && rpriv && rpriv->rep->vport != MLX5_VPORT_UPLINK;
 }
 
+/* As IPsec and TC order is not aligned between software and hardware-offload,
+ * either IPsec offload or TC offload, not both, is allowed for a specific interface.
+ */
+static bool is_tc_ipsec_order_check_needed(struct net_device *filter, struct mlx5e_priv *priv)
+{
+	if (!IS_ENABLED(CONFIG_MLX5_EN_IPSEC))
+		return false;
+
+	if (filter != priv->netdev)
+		return false;
+
+	if (mlx5e_eswitch_vf_rep(priv->netdev))
+		return false;
+
+	return true;
+}
+
+static int mlx5e_tc_block_ipsec_offload(struct net_device *filter, struct mlx5e_priv *priv)
+{
+	struct mlx5_core_dev *mdev = priv->mdev;
+
+	if (!is_tc_ipsec_order_check_needed(filter, priv))
+		return 0;
+
+	if (mdev->num_block_tc)
+		return -EBUSY;
+
+	mdev->num_block_ipsec++;
+
+	return 0;
+}
+
+static void mlx5e_tc_unblock_ipsec_offload(struct net_device *filter, struct mlx5e_priv *priv)
+{
+	if (!is_tc_ipsec_order_check_needed(filter, priv))
+		return;
+
+	priv->mdev->num_block_ipsec--;
+}
+
 int mlx5e_configure_flower(struct net_device *dev, struct mlx5e_priv *priv,
 			   struct flow_cls_offload *f, unsigned long flags)
 {
@@ -4618,6 +4658,10 @@ int mlx5e_configure_flower(struct net_device *dev, struct mlx5e_priv *priv,
 	if (!mlx5_esw_hold(priv->mdev))
 		return -EBUSY;
 
+	err = mlx5e_tc_block_ipsec_offload(dev, priv);
+	if (err)
+		goto esw_release;
+
 	mlx5_esw_get(priv->mdev);
 
 	rcu_read_lock();
@@ -4663,7 +4707,9 @@ int mlx5e_configure_flower(struct net_device *dev, struct mlx5e_priv *priv,
 err_free:
 	mlx5e_flow_put(priv, flow);
 out:
+	mlx5e_tc_unblock_ipsec_offload(dev, priv);
 	mlx5_esw_put(priv->mdev);
+esw_release:
 	mlx5_esw_release(priv->mdev);
 	return err;
 }
@@ -4704,6 +4750,7 @@ int mlx5e_delete_flower(struct net_device *dev, struct mlx5e_priv *priv,
 	trace_mlx5e_delete_flower(f);
 	mlx5e_flow_put(priv, flow);
 
+	mlx5e_tc_unblock_ipsec_offload(dev, priv);
 	mlx5_esw_put(priv->mdev);
 	return 0;
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index f21703fb75fd..fa70c25423b2 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -806,6 +806,8 @@ struct mlx5_core_dev {
 	u32                      vsc_addr;
 	struct mlx5_hv_vhca	*hv_vhca;
 	struct mlx5_thermal	*thermal;
+	u64			num_block_tc;
+	u64			num_block_ipsec;
 };
 
 struct mlx5_db {
-- 
2.41.0


