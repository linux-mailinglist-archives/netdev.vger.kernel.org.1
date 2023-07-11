Return-Path: <netdev+bounces-16758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880A74EA9A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF021C20E04
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45C18B0E;
	Tue, 11 Jul 2023 09:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7C18B05
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55823C433CA;
	Tue, 11 Jul 2023 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689067784;
	bh=K7ac3CIK5/6fkKFEDYzTTkS3MvjLmfQRkaNX1dbWJjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4L+kXnv9kR8Zh/HvsShDW+iW6EIjeX61nMjgj4S6uqcdDn2OMcsTpL2vi9sYMweQ
	 u7dmyDCoQO0dWhY3T5vCBs1foTwgetNwnQxA9TxMCDJ5PTes/sA3fKv5NM8bfTdaqU
	 5oIuhWrZpu6ymOunWWAFE7dBwBNW2Lryk8K1ELzOzfH0vgSer7N+TuP9h9UFP36GgW
	 jjbhKvElA87o2l965BQJKYAmj/VgeQMnrkJekRM68dXBBRKEU4v1I8XH9oJPx97nzg
	 ELTYtwSQtsBFTRscQtZBwIwwImvXKlFqqWHElgNIh3q0puYPazyfpfxIrfkcz7Wj8+
	 hxQcM89Mz0xtw==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next 03/12] net/mlx5e: Prepare IPsec packet offload for switchdev mode
Date: Tue, 11 Jul 2023 12:29:01 +0300
Message-ID: <c44b5346e8393797be8c48f0431bd971ec64dab7.1689064922.git.leonro@nvidia.com>
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

As the uplink representor is created only in switchdev mode, add a local
variable for IPsec to indicate the device is in this mode.

In this mode, the tables for packet offload are created in FDB,
ipsec->rx_esw and ipsec->tx_esw are added.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   2 +
 .../mellanox/mlx5/core/en_accel/ipsec.h       |   3 +
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 262 ++++++++++++------
 3 files changed, 184 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 891d39b4bfd4..ad62424249e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -40,6 +40,7 @@
 #include "en.h"
 #include "ipsec.h"
 #include "ipsec_rxtx.h"
+#include "en_rep.h"
 
 #define MLX5_IPSEC_RESCHED msecs_to_jiffies(1000)
 #define MLX5E_IPSEC_TUNNEL_SA XA_MARK_1
@@ -835,6 +836,7 @@ void mlx5e_ipsec_init(struct mlx5e_priv *priv)
 			goto clear_aso;
 	}
 
+	ipsec->is_uplink_rep = mlx5e_is_uplink_rep(priv);
 	ret = mlx5e_accel_ipsec_fs_init(ipsec);
 	if (ret)
 		goto err_fs_init;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 4e9887171508..ef64a042191d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -170,11 +170,14 @@ struct mlx5e_ipsec {
 	struct mlx5e_flow_steering *fs;
 	struct mlx5e_ipsec_rx *rx_ipv4;
 	struct mlx5e_ipsec_rx *rx_ipv6;
+	struct mlx5e_ipsec_rx *rx_esw;
 	struct mlx5e_ipsec_tx *tx;
+	struct mlx5e_ipsec_tx *tx_esw;
 	struct mlx5e_ipsec_aso *aso;
 	struct notifier_block nb;
 	struct notifier_block netevent_nb;
 	struct mlx5_ipsec_fs *roce;
+	u8 is_uplink_rep: 1;
 };
 
 struct mlx5e_ipsec_esn_state {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 7976469108de..0c50fcea4797 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -60,14 +60,25 @@ static enum mlx5_traffic_types family2tt(u32 family)
 	return MLX5_TT_IPV6_IPSEC_ESP;
 }
 
-static struct mlx5e_ipsec_rx *ipsec_rx(struct mlx5e_ipsec *ipsec, u32 family)
+static struct mlx5e_ipsec_rx *ipsec_rx(struct mlx5e_ipsec *ipsec, u32 family, int type)
 {
+	if (ipsec->is_uplink_rep && type == XFRM_DEV_OFFLOAD_PACKET)
+		return ipsec->rx_esw;
+
 	if (family == AF_INET)
 		return ipsec->rx_ipv4;
 
 	return ipsec->rx_ipv6;
 }
 
+static struct mlx5e_ipsec_tx *ipsec_tx(struct mlx5e_ipsec *ipsec, int type)
+{
+	if (ipsec->is_uplink_rep && type == XFRM_DEV_OFFLOAD_PACKET)
+		return ipsec->tx_esw;
+
+	return ipsec->tx;
+}
+
 static struct mlx5_fs_chains *
 ipsec_chains_create(struct mlx5_core_dev *mdev, struct mlx5_flow_table *miss_ft,
 		    enum mlx5_flow_namespace_type ns, int base_prio,
@@ -406,9 +417,10 @@ static void rx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_rx *rx,
 }
 
 static struct mlx5e_ipsec_rx *rx_ft_get(struct mlx5_core_dev *mdev,
-					struct mlx5e_ipsec *ipsec, u32 family)
+					struct mlx5e_ipsec *ipsec, u32 family,
+					int type)
 {
-	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family);
+	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family, type);
 	int err;
 
 	mutex_lock(&rx->ft.mutex);
@@ -422,9 +434,9 @@ static struct mlx5e_ipsec_rx *rx_ft_get(struct mlx5_core_dev *mdev,
 
 static struct mlx5_flow_table *rx_ft_get_policy(struct mlx5_core_dev *mdev,
 						struct mlx5e_ipsec *ipsec,
-						u32 family, u32 prio)
+						u32 family, u32 prio, int type)
 {
-	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family);
+	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family, type);
 	struct mlx5_flow_table *ft;
 	int err;
 
@@ -449,18 +461,18 @@ static struct mlx5_flow_table *rx_ft_get_policy(struct mlx5_core_dev *mdev,
 	return ERR_PTR(err);
 }
 
-static void rx_ft_put(struct mlx5e_ipsec *ipsec, u32 family)
+static void rx_ft_put(struct mlx5e_ipsec *ipsec, u32 family, int type)
 {
-	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family);
+	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family, type);
 
 	mutex_lock(&rx->ft.mutex);
 	rx_put(ipsec, rx, family);
 	mutex_unlock(&rx->ft.mutex);
 }
 
-static void rx_ft_put_policy(struct mlx5e_ipsec *ipsec, u32 family, u32 prio)
+static void rx_ft_put_policy(struct mlx5e_ipsec *ipsec, u32 family, u32 prio, int type)
 {
-	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family);
+	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family, type);
 
 	mutex_lock(&rx->ft.mutex);
 	if (rx->chains)
@@ -629,9 +641,9 @@ static void tx_put(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx)
 
 static struct mlx5_flow_table *tx_ft_get_policy(struct mlx5_core_dev *mdev,
 						struct mlx5e_ipsec *ipsec,
-						u32 prio)
+						u32 prio, int type)
 {
-	struct mlx5e_ipsec_tx *tx = ipsec->tx;
+	struct mlx5e_ipsec_tx *tx = ipsec_tx(ipsec, type);
 	struct mlx5_flow_table *ft;
 	int err;
 
@@ -657,9 +669,9 @@ static struct mlx5_flow_table *tx_ft_get_policy(struct mlx5_core_dev *mdev,
 }
 
 static struct mlx5e_ipsec_tx *tx_ft_get(struct mlx5_core_dev *mdev,
-					struct mlx5e_ipsec *ipsec)
+					struct mlx5e_ipsec *ipsec, int type)
 {
-	struct mlx5e_ipsec_tx *tx = ipsec->tx;
+	struct mlx5e_ipsec_tx *tx = ipsec_tx(ipsec, type);
 	int err;
 
 	mutex_lock(&tx->ft.mutex);
@@ -671,18 +683,18 @@ static struct mlx5e_ipsec_tx *tx_ft_get(struct mlx5_core_dev *mdev,
 	return tx;
 }
 
-static void tx_ft_put(struct mlx5e_ipsec *ipsec)
+static void tx_ft_put(struct mlx5e_ipsec *ipsec, int type)
 {
-	struct mlx5e_ipsec_tx *tx = ipsec->tx;
+	struct mlx5e_ipsec_tx *tx = ipsec_tx(ipsec, type);
 
 	mutex_lock(&tx->ft.mutex);
 	tx_put(ipsec, tx);
 	mutex_unlock(&tx->ft.mutex);
 }
 
-static void tx_ft_put_policy(struct mlx5e_ipsec *ipsec, u32 prio)
+static void tx_ft_put_policy(struct mlx5e_ipsec *ipsec, u32 prio, int type)
 {
-	struct mlx5e_ipsec_tx *tx = ipsec->tx;
+	struct mlx5e_ipsec_tx *tx = ipsec_tx(ipsec, type);
 
 	mutex_lock(&tx->ft.mutex);
 	if (tx->chains)
@@ -1046,7 +1058,7 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	struct mlx5_fc *counter;
 	int err;
 
-	rx = rx_ft_get(mdev, ipsec, attrs->family);
+	rx = rx_ft_get(mdev, ipsec, attrs->family, attrs->type);
 	if (IS_ERR(rx))
 		return PTR_ERR(rx);
 
@@ -1122,7 +1134,7 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 err_mod_header:
 	kvfree(spec);
 err_alloc:
-	rx_ft_put(ipsec, attrs->family);
+	rx_ft_put(ipsec, attrs->family, attrs->type);
 	return err;
 }
 
@@ -1139,7 +1151,7 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	struct mlx5_fc *counter;
 	int err;
 
-	tx = tx_ft_get(mdev, ipsec);
+	tx = tx_ft_get(mdev, ipsec, attrs->type);
 	if (IS_ERR(tx))
 		return PTR_ERR(tx);
 
@@ -1215,7 +1227,7 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 err_pkt_reformat:
 	kvfree(spec);
 err_alloc:
-	tx_ft_put(ipsec);
+	tx_ft_put(ipsec, attrs->type);
 	return err;
 }
 
@@ -1225,14 +1237,14 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 	struct mlx5_core_dev *mdev = mlx5e_ipsec_pol2dev(pol_entry);
 	struct mlx5e_ipsec *ipsec = pol_entry->ipsec;
 	struct mlx5_flow_destination dest[2] = {};
-	struct mlx5e_ipsec_tx *tx = ipsec->tx;
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
 	struct mlx5_flow_table *ft;
+	struct mlx5e_ipsec_tx *tx;
 	int err, dstn = 0;
 
-	ft = tx_ft_get_policy(mdev, ipsec, attrs->prio);
+	ft = tx_ft_get_policy(mdev, ipsec, attrs->prio, attrs->type);
 	if (IS_ERR(ft))
 		return PTR_ERR(ft);
 
@@ -1242,6 +1254,7 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 		goto err_alloc;
 	}
 
+	tx = ipsec_tx(ipsec, attrs->type);
 	if (attrs->family == AF_INET)
 		setup_fte_addr4(spec, &attrs->saddr.a4, &attrs->daddr.a4);
 	else
@@ -1296,7 +1309,7 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 err_mod_header:
 	kvfree(spec);
 err_alloc:
-	tx_ft_put_policy(ipsec, attrs->prio);
+	tx_ft_put_policy(ipsec, attrs->prio, attrs->type);
 	return err;
 }
 
@@ -1312,11 +1325,12 @@ static int rx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 	struct mlx5e_ipsec_rx *rx;
 	int err, dstn = 0;
 
-	ft = rx_ft_get_policy(mdev, pol_entry->ipsec, attrs->family, attrs->prio);
+	ft = rx_ft_get_policy(mdev, pol_entry->ipsec, attrs->family, attrs->prio,
+			      attrs->type);
 	if (IS_ERR(ft))
 		return PTR_ERR(ft);
 
-	rx = ipsec_rx(pol_entry->ipsec, attrs->family);
+	rx = ipsec_rx(pol_entry->ipsec, attrs->family, attrs->type);
 
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec) {
@@ -1365,88 +1379,110 @@ static int rx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 err_action:
 	kvfree(spec);
 err_alloc:
-	rx_ft_put_policy(pol_entry->ipsec, attrs->family, attrs->prio);
+	rx_ft_put_policy(pol_entry->ipsec, attrs->family, attrs->prio, attrs->type);
 	return err;
 }
 
+static void ipsec_fs_destroy_single_counter(struct mlx5_core_dev *mdev,
+					    struct mlx5e_ipsec_fc *fc)
+{
+	mlx5_fc_destroy(mdev, fc->drop);
+	mlx5_fc_destroy(mdev, fc->cnt);
+	kfree(fc);
+}
+
 static void ipsec_fs_destroy_counters(struct mlx5e_ipsec *ipsec)
 {
-	struct mlx5e_ipsec_rx *rx_ipv4 = ipsec->rx_ipv4;
 	struct mlx5_core_dev *mdev = ipsec->mdev;
-	struct mlx5e_ipsec_tx *tx = ipsec->tx;
-
-	mlx5_fc_destroy(mdev, tx->fc->drop);
-	mlx5_fc_destroy(mdev, tx->fc->cnt);
-	kfree(tx->fc);
-	mlx5_fc_destroy(mdev, rx_ipv4->fc->drop);
-	mlx5_fc_destroy(mdev, rx_ipv4->fc->cnt);
-	kfree(rx_ipv4->fc);
+
+	ipsec_fs_destroy_single_counter(mdev, ipsec->tx->fc);
+	ipsec_fs_destroy_single_counter(mdev, ipsec->rx_ipv4->fc);
+	if (ipsec->is_uplink_rep) {
+		ipsec_fs_destroy_single_counter(mdev, ipsec->tx_esw->fc);
+		ipsec_fs_destroy_single_counter(mdev, ipsec->rx_esw->fc);
+	}
 }
 
-static int ipsec_fs_init_counters(struct mlx5e_ipsec *ipsec)
+static struct mlx5e_ipsec_fc *ipsec_fs_init_single_counter(struct mlx5_core_dev *mdev)
 {
-	struct mlx5e_ipsec_rx *rx_ipv4 = ipsec->rx_ipv4;
-	struct mlx5e_ipsec_rx *rx_ipv6 = ipsec->rx_ipv6;
-	struct mlx5_core_dev *mdev = ipsec->mdev;
-	struct mlx5e_ipsec_tx *tx = ipsec->tx;
 	struct mlx5e_ipsec_fc *fc;
 	struct mlx5_fc *counter;
 	int err;
 
-	fc = kzalloc(sizeof(*rx_ipv4->fc), GFP_KERNEL);
+	fc = kzalloc(sizeof(*fc), GFP_KERNEL);
 	if (!fc)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	/* Both IPv4 and IPv6 point to same flow counters struct. */
-	rx_ipv4->fc = fc;
-	rx_ipv6->fc = fc;
 	counter = mlx5_fc_create(mdev, false);
 	if (IS_ERR(counter)) {
 		err = PTR_ERR(counter);
-		goto err_rx_cnt;
+		goto err_cnt;
 	}
-
 	fc->cnt = counter;
+
 	counter = mlx5_fc_create(mdev, false);
 	if (IS_ERR(counter)) {
 		err = PTR_ERR(counter);
-		goto err_rx_drop;
+		goto err_drop;
 	}
-
 	fc->drop = counter;
-	fc = kzalloc(sizeof(*tx->fc), GFP_KERNEL);
-	if (!fc) {
-		err = -ENOMEM;
-		goto err_tx_fc;
+
+	return fc;
+
+err_drop:
+	mlx5_fc_destroy(mdev, fc->cnt);
+err_cnt:
+	kfree(fc);
+	return ERR_PTR(err);
+}
+
+static int ipsec_fs_init_counters(struct mlx5e_ipsec *ipsec)
+{
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5e_ipsec_fc *fc;
+	int err;
+
+	fc = ipsec_fs_init_single_counter(mdev);
+	if (IS_ERR(fc)) {
+		err = PTR_ERR(fc);
+		goto err_rx_cnt;
 	}
+	ipsec->rx_ipv4->fc = fc;
 
-	tx->fc = fc;
-	counter = mlx5_fc_create(mdev, false);
-	if (IS_ERR(counter)) {
-		err = PTR_ERR(counter);
+	fc = ipsec_fs_init_single_counter(mdev);
+	if (IS_ERR(fc)) {
+		err = PTR_ERR(fc);
 		goto err_tx_cnt;
 	}
+	ipsec->tx->fc = fc;
 
-	fc->cnt = counter;
-	counter = mlx5_fc_create(mdev, false);
-	if (IS_ERR(counter)) {
-		err = PTR_ERR(counter);
-		goto err_tx_drop;
+	if (ipsec->is_uplink_rep) {
+		fc = ipsec_fs_init_single_counter(mdev);
+		if (IS_ERR(fc)) {
+			err = PTR_ERR(fc);
+			goto err_rx_esw_cnt;
+		}
+		ipsec->rx_esw->fc = fc;
+
+		fc = ipsec_fs_init_single_counter(mdev);
+		if (IS_ERR(fc)) {
+			err = PTR_ERR(fc);
+			goto err_tx_esw_cnt;
+		}
+		ipsec->tx_esw->fc = fc;
 	}
 
-	fc->drop = counter;
+	/* Both IPv4 and IPv6 point to same flow counters struct. */
+	ipsec->rx_ipv6->fc = fc;
 	return 0;
 
-err_tx_drop:
-	mlx5_fc_destroy(mdev, tx->fc->cnt);
+err_tx_esw_cnt:
+	ipsec_fs_destroy_single_counter(mdev, ipsec->rx_esw->fc);
+err_rx_esw_cnt:
+	ipsec_fs_destroy_single_counter(mdev, ipsec->tx->fc);
 err_tx_cnt:
-	kfree(tx->fc);
-err_tx_fc:
-	mlx5_fc_destroy(mdev, rx_ipv4->fc->drop);
-err_rx_drop:
-	mlx5_fc_destroy(mdev, rx_ipv4->fc->cnt);
+	ipsec_fs_destroy_single_counter(mdev, ipsec->rx_ipv4->fc);
 err_rx_cnt:
-	kfree(rx_ipv4->fc);
 	return err;
 }
 
@@ -1456,6 +1492,7 @@ void mlx5e_accel_ipsec_fs_read_stats(struct mlx5e_priv *priv, void *ipsec_stats)
 	struct mlx5e_ipsec *ipsec = priv->ipsec;
 	struct mlx5e_ipsec_hw_stats *stats;
 	struct mlx5e_ipsec_fc *fc;
+	u64 packets, bytes;
 
 	stats = (struct mlx5e_ipsec_hw_stats *)ipsec_stats;
 
@@ -1477,6 +1514,30 @@ void mlx5e_accel_ipsec_fs_read_stats(struct mlx5e_priv *priv, void *ipsec_stats)
 	mlx5_fc_query(mdev, fc->cnt, &stats->ipsec_tx_pkts, &stats->ipsec_tx_bytes);
 	mlx5_fc_query(mdev, fc->drop, &stats->ipsec_tx_drop_pkts,
 		      &stats->ipsec_tx_drop_bytes);
+
+	if (ipsec->is_uplink_rep) {
+		fc = ipsec->rx_esw->fc;
+		if (!mlx5_fc_query(mdev, fc->cnt, &packets, &bytes)) {
+			stats->ipsec_rx_pkts += packets;
+			stats->ipsec_rx_bytes += bytes;
+		}
+
+		if (!mlx5_fc_query(mdev, fc->drop, &packets, &bytes)) {
+			stats->ipsec_rx_drop_pkts += packets;
+			stats->ipsec_rx_drop_bytes += bytes;
+		}
+
+		fc = ipsec->tx_esw->fc;
+		if (!mlx5_fc_query(mdev, fc->cnt, &packets, &bytes)) {
+			stats->ipsec_tx_pkts += packets;
+			stats->ipsec_tx_bytes += bytes;
+		}
+
+		if (!mlx5_fc_query(mdev, fc->drop, &packets, &bytes)) {
+			stats->ipsec_tx_drop_pkts += packets;
+			stats->ipsec_tx_drop_bytes += bytes;
+		}
+	}
 }
 
 int mlx5e_accel_ipsec_fs_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
@@ -1498,12 +1559,12 @@ void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		mlx5_packet_reformat_dealloc(mdev, ipsec_rule->pkt_reformat);
 
 	if (sa_entry->attrs.dir == XFRM_DEV_OFFLOAD_OUT) {
-		tx_ft_put(sa_entry->ipsec);
+		tx_ft_put(sa_entry->ipsec, sa_entry->attrs.type);
 		return;
 	}
 
 	mlx5_modify_header_dealloc(mdev, ipsec_rule->modify_hdr);
-	rx_ft_put(sa_entry->ipsec, sa_entry->attrs.family);
+	rx_ft_put(sa_entry->ipsec, sa_entry->attrs.family, sa_entry->attrs.type);
 }
 
 int mlx5e_accel_ipsec_fs_add_pol(struct mlx5e_ipsec_pol_entry *pol_entry)
@@ -1523,14 +1584,14 @@ void mlx5e_accel_ipsec_fs_del_pol(struct mlx5e_ipsec_pol_entry *pol_entry)
 
 	if (pol_entry->attrs.dir == XFRM_DEV_OFFLOAD_IN) {
 		rx_ft_put_policy(pol_entry->ipsec, pol_entry->attrs.family,
-				 pol_entry->attrs.prio);
+				 pol_entry->attrs.prio, pol_entry->attrs.type);
 		return;
 	}
 
 	if (ipsec_rule->modify_hdr)
 		mlx5_modify_header_dealloc(mdev, ipsec_rule->modify_hdr);
 
-	tx_ft_put_policy(pol_entry->ipsec, pol_entry->attrs.prio);
+	tx_ft_put_policy(pol_entry->ipsec, pol_entry->attrs.prio, pol_entry->attrs.type);
 }
 
 void mlx5e_accel_ipsec_fs_cleanup(struct mlx5e_ipsec *ipsec)
@@ -1538,7 +1599,7 @@ void mlx5e_accel_ipsec_fs_cleanup(struct mlx5e_ipsec *ipsec)
 	if (!ipsec->tx)
 		return;
 
-	if (mlx5_ipsec_device_caps(ipsec->mdev) & MLX5_IPSEC_CAP_ROCE)
+	if (ipsec->roce)
 		mlx5_ipsec_fs_roce_cleanup(ipsec->roce);
 
 	ipsec_fs_destroy_counters(ipsec);
@@ -1553,12 +1614,22 @@ void mlx5e_accel_ipsec_fs_cleanup(struct mlx5e_ipsec *ipsec)
 	mutex_destroy(&ipsec->rx_ipv6->ft.mutex);
 	WARN_ON(ipsec->rx_ipv6->ft.refcnt);
 	kfree(ipsec->rx_ipv6);
+
+	if (ipsec->is_uplink_rep) {
+		mutex_destroy(&ipsec->tx_esw->ft.mutex);
+		WARN_ON(ipsec->tx_esw->ft.refcnt);
+		kfree(ipsec->tx_esw);
+
+		mutex_destroy(&ipsec->rx_esw->ft.mutex);
+		WARN_ON(ipsec->rx_esw->ft.refcnt);
+		kfree(ipsec->rx_esw);
+	}
 }
 
 int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec)
 {
 	struct mlx5_core_dev *mdev = ipsec->mdev;
-	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_namespace *ns, *ns_esw;
 	int err = -ENOMEM;
 
 	ns = mlx5_get_flow_namespace(ipsec->mdev,
@@ -1566,9 +1637,23 @@ int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec)
 	if (!ns)
 		return -EOPNOTSUPP;
 
+	if (ipsec->is_uplink_rep) {
+		ns_esw = mlx5_get_flow_namespace(mdev, MLX5_FLOW_NAMESPACE_FDB);
+		if (!ns_esw)
+			return -EOPNOTSUPP;
+
+		ipsec->tx_esw = kzalloc(sizeof(*ipsec->tx_esw), GFP_KERNEL);
+		if (!ipsec->tx_esw)
+			return -ENOMEM;
+
+		ipsec->rx_esw = kzalloc(sizeof(*ipsec->rx_esw), GFP_KERNEL);
+		if (!ipsec->rx_esw)
+			goto err_rx_esw;
+	}
+
 	ipsec->tx = kzalloc(sizeof(*ipsec->tx), GFP_KERNEL);
 	if (!ipsec->tx)
-		return -ENOMEM;
+		goto err_tx;
 
 	ipsec->rx_ipv4 = kzalloc(sizeof(*ipsec->rx_ipv4), GFP_KERNEL);
 	if (!ipsec->rx_ipv4)
@@ -1587,8 +1672,13 @@ int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec)
 	mutex_init(&ipsec->rx_ipv6->ft.mutex);
 	ipsec->tx->ns = ns;
 
-	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_ROCE)
+	if (ipsec->is_uplink_rep) {
+		mutex_init(&ipsec->tx_esw->ft.mutex);
+		mutex_init(&ipsec->rx_esw->ft.mutex);
+		ipsec->tx_esw->ns = ns_esw;
+	} else if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_ROCE) {
 		ipsec->roce = mlx5_ipsec_fs_roce_init(mdev);
+	}
 
 	return 0;
 
@@ -1598,6 +1688,10 @@ int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec)
 	kfree(ipsec->rx_ipv4);
 err_rx_ipv4:
 	kfree(ipsec->tx);
+err_tx:
+	kfree(ipsec->rx_esw);
+err_rx_esw:
+	kfree(ipsec->tx_esw);
 	return err;
 }
 
@@ -1619,10 +1713,12 @@ void mlx5e_accel_ipsec_fs_modify(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 bool mlx5e_ipsec_fs_tunnel_enabled(struct mlx5e_ipsec_sa_entry *sa_entry)
 {
-	struct mlx5e_ipsec_rx *rx =
-		ipsec_rx(sa_entry->ipsec, sa_entry->attrs.family);
-	struct mlx5e_ipsec_tx *tx = sa_entry->ipsec->tx;
+	struct mlx5_accel_esp_xfrm_attrs *attrs = &sa_entry->attrs;
+	struct mlx5e_ipsec_rx *rx;
+	struct mlx5e_ipsec_tx *tx;
 
+	rx = ipsec_rx(sa_entry->ipsec, attrs->family, attrs->type);
+	tx = ipsec_tx(sa_entry->ipsec, attrs->type);
 	if (sa_entry->attrs.dir == XFRM_DEV_OFFLOAD_OUT)
 		return tx->allow_tunnel_mode;
 
-- 
2.41.0


