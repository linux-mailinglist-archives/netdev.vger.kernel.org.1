Return-Path: <netdev+bounces-28230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2C977EB3C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A7C1C211A5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316E61AA73;
	Wed, 16 Aug 2023 21:01:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7B198B5
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE51FC43391;
	Wed, 16 Aug 2023 21:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219659;
	bh=wZcCw6YgUCaA6gRMlDz3zQoKHVYFXuk0T2IIcBJL8/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLHBztnW030WdNOJ48E8as3VkGc29f//sFHZsGhqEZR2uu7RQh44uiRuTHIZ6pbJP
	 QXBn0Ew2UNQyLNfBjkRO6VL8yx9Ia5CLMKZKRBwPUcfAgE3etfRLg/JjOrCW8TcdaL
	 1CQ6fvANIU4jH1foXwwpGgKqV5XymGP8zf+PD0sHzr7NI8H+2b7kxbOBQZw+m6syoO
	 bm2/aRkzlA75FOVnzOZZsAijBLWGgSqgPc+DLU94txstsiMayKrGIpQlwEEXk6C/t3
	 nUr+cNFdwBE7WTV2VKX1W1lCMniIPymocYMsvQ5eV6RFVTz95LVm0owyxgMhIJKs3i
	 g/ank711luzZg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 03/15] net/mlx5e: aRFS, Introduce ethtool stats
Date: Wed, 16 Aug 2023 14:00:37 -0700
Message-ID: <20230816210049.54733-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816210049.54733-1-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adham Faris <afaris@nvidia.com>

Improve aRFS observability by adding new set of counters. Each Rx
ring will have this set of counters listed below.
These counters are exposed through ethtool -S.

1) arfs_add: number of times a new rule has been created.
2) arfs_request_in: number of times a rule  was requested to move from
   its current Rx ring to a new Rx ring (incremented on the destination
   Rx ring).
3) arfs_request_out: number of times a rule  was requested to move out
   from its current Rx ring (incremented on source/current Rx ring).
4) arfs_expired: number of times a rule has been expired by the
   kernel and removed from HW.
5) arfs_err: number of times a rule creation or modification has
   failed.

This patch removes rx[i]_xsk_arfs_err counter and its documentation in
mlx5/counters.rst since aRFS activity does not occur in XSK RQ's.

Signed-off-by: Adham Faris <afaris@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
---
 .../ethernet/mellanox/mlx5/counters.rst       | 23 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_arfs.c | 17 +++++++++++---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 22 ++++++++++++++----
 .../ethernet/mellanox/mlx5/core/en_stats.h    | 13 ++++++++++-
 4 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 008e560e12b5..f69ee1ebee01 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -346,6 +346,24 @@ the software port.
      - The number of receive packets with CQE compression on ring i [#accel]_.
      - Acceleration
 
+   * - `rx[i]_arfs_add`
+     - The number of aRFS flow rules added to the device for direct RQ steering
+       on ring i [#accel]_.
+     - Acceleration
+
+   * - `rx[i]_arfs_request_in`
+     - Number of flow rules that have been requested to move into ring i for
+       direct RQ steering [#accel]_.
+     - Acceleration
+
+   * - `rx[i]_arfs_request_out`
+     - Number of flow rules that have been requested to move out of ring i [#accel]_.
+     - Acceleration
+
+   * - `rx[i]_arfs_expired`
+     - Number of flow rules that have been expired and removed [#accel]_.
+     - Acceleration
+
    * - `rx[i]_arfs_err`
      - Number of flow rules that failed to be added to the flow table.
      - Error
@@ -445,11 +463,6 @@ the software port.
        context.
      - Error
 
-   * - `rx[i]_xsk_arfs_err`
-     - aRFS (accelerated Receive Flow Steering) does not occur in the XSK RQ
-       context, so this counter should never increment.
-     - Error
-
    * - `rx[i]_xdp_tx_xmit`
      - The number of packets forwarded back to the port due to XDP program
        `XDP_TX` action (bouncing). these packets are not counted by other
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index e8b0acf7d454..bb7f86c993e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -432,8 +432,10 @@ static void arfs_may_expire_flow(struct mlx5e_priv *priv)
 	}
 	spin_unlock_bh(&arfs->arfs_lock);
 	hlist_for_each_entry_safe(arfs_rule, htmp, &del_list, hlist) {
-		if (arfs_rule->rule)
+		if (arfs_rule->rule) {
 			mlx5_del_flow_rules(arfs_rule->rule);
+			priv->channel_stats[arfs_rule->rxq]->rq.arfs_expired++;
+		}
 		hlist_del(&arfs_rule->hlist);
 		kfree(arfs_rule);
 	}
@@ -509,6 +511,7 @@ static struct mlx5_flow_handle *arfs_add_rule(struct mlx5e_priv *priv,
 
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec) {
+		priv->channel_stats[arfs_rule->rxq]->rq.arfs_err++;
 		err = -ENOMEM;
 		goto out;
 	}
@@ -602,9 +605,11 @@ static void arfs_modify_rule_rq(struct mlx5e_priv *priv,
 	dst.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
 	dst.tir_num = mlx5e_rx_res_get_tirn_direct(priv->rx_res, rxq);
 	err =  mlx5_modify_rule_destination(rule, &dst, NULL);
-	if (err)
+	if (err) {
+		priv->channel_stats[rxq]->rq.arfs_err++;
 		netdev_warn(priv->netdev,
 			    "Failed to modify aRFS rule destination to rq=%d\n", rxq);
+	}
 }
 
 static void arfs_handle_work(struct work_struct *work)
@@ -634,6 +639,7 @@ static void arfs_handle_work(struct work_struct *work)
 		if (IS_ERR(rule))
 			goto out;
 		arfs_rule->rule = rule;
+		priv->channel_stats[arfs_rule->rxq]->rq.arfs_add++;
 	} else {
 		arfs_modify_rule_rq(priv, arfs_rule->rule,
 				    arfs_rule->rxq);
@@ -652,8 +658,10 @@ static struct arfs_rule *arfs_alloc_rule(struct mlx5e_priv *priv,
 	struct arfs_tuple *tuple;
 
 	rule = kzalloc(sizeof(*rule), GFP_ATOMIC);
-	if (!rule)
+	if (!rule) {
+		priv->channel_stats[rxq]->rq.arfs_err++;
 		return NULL;
+	}
 
 	rule->priv = priv;
 	rule->rxq = rxq;
@@ -746,6 +754,9 @@ int mlx5e_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 			spin_unlock_bh(&arfs->arfs_lock);
 			return arfs_rule->filter_id;
 		}
+
+		priv->channel_stats[rxq_index]->rq.arfs_request_in++;
+		priv->channel_stats[arfs_rule->rxq]->rq.arfs_request_out++;
 		arfs_rule->rxq = rxq_index;
 	} else {
 		arfs_rule = arfs_alloc_rule(priv, arfs_t, &fk, rxq_index, flow_id);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 52141729444e..348fb140858c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -180,7 +180,13 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_cqe_compress_blks) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_cqe_compress_pkts) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_congst_umr) },
+#ifdef CONFIG_MLX5_EN_ARFS
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_arfs_add) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_arfs_request_in) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_arfs_request_out) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_arfs_expired) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_arfs_err) },
+#endif
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_recover) },
 #ifdef CONFIG_PAGE_POOL_STATS
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_fast) },
@@ -231,7 +237,6 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_xsk_cqe_compress_blks) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_xsk_cqe_compress_pkts) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_xsk_congst_umr) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_xsk_arfs_err) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xsk_xmit) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xsk_mpwqe) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xsk_inlnw) },
@@ -321,7 +326,6 @@ static void mlx5e_stats_grp_sw_update_stats_xskrq(struct mlx5e_sw_stats *s,
 	s->rx_xsk_cqe_compress_blks      += xskrq_stats->cqe_compress_blks;
 	s->rx_xsk_cqe_compress_pkts      += xskrq_stats->cqe_compress_pkts;
 	s->rx_xsk_congst_umr             += xskrq_stats->congst_umr;
-	s->rx_xsk_arfs_err               += xskrq_stats->arfs_err;
 }
 
 static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
@@ -354,7 +358,13 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_cqe_compress_blks       += rq_stats->cqe_compress_blks;
 	s->rx_cqe_compress_pkts       += rq_stats->cqe_compress_pkts;
 	s->rx_congst_umr              += rq_stats->congst_umr;
+#ifdef CONFIG_MLX5_EN_ARFS
+	s->rx_arfs_add                += rq_stats->arfs_add;
+	s->rx_arfs_request_in         += rq_stats->arfs_request_in;
+	s->rx_arfs_request_out        += rq_stats->arfs_request_out;
+	s->rx_arfs_expired            += rq_stats->arfs_expired;
 	s->rx_arfs_err                += rq_stats->arfs_err;
+#endif
 	s->rx_recover                 += rq_stats->recover;
 #ifdef CONFIG_PAGE_POOL_STATS
 	s->rx_pp_alloc_fast          += rq_stats->pp_alloc_fast;
@@ -1990,7 +2000,13 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, cqe_compress_blks) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, cqe_compress_pkts) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, congst_umr) },
+#ifdef CONFIG_MLX5_EN_ARFS
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, arfs_add) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, arfs_request_in) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, arfs_request_out) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, arfs_expired) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, arfs_err) },
+#endif
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, recover) },
 #ifdef CONFIG_PAGE_POOL_STATS
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_fast) },
@@ -2092,7 +2108,6 @@ static const struct counter_desc xskrq_stats_desc[] = {
 	{ MLX5E_DECLARE_XSKRQ_STAT(struct mlx5e_rq_stats, cqe_compress_blks) },
 	{ MLX5E_DECLARE_XSKRQ_STAT(struct mlx5e_rq_stats, cqe_compress_pkts) },
 	{ MLX5E_DECLARE_XSKRQ_STAT(struct mlx5e_rq_stats, congst_umr) },
-	{ MLX5E_DECLARE_XSKRQ_STAT(struct mlx5e_rq_stats, arfs_err) },
 };
 
 static const struct counter_desc xsksq_stats_desc[] = {
@@ -2168,7 +2183,6 @@ static const struct counter_desc ptp_rq_stats_desc[] = {
 	{ MLX5E_DECLARE_PTP_RQ_STAT(struct mlx5e_rq_stats, cqe_compress_blks) },
 	{ MLX5E_DECLARE_PTP_RQ_STAT(struct mlx5e_rq_stats, cqe_compress_pkts) },
 	{ MLX5E_DECLARE_PTP_RQ_STAT(struct mlx5e_rq_stats, congst_umr) },
-	{ MLX5E_DECLARE_PTP_RQ_STAT(struct mlx5e_rq_stats, arfs_err) },
 	{ MLX5E_DECLARE_PTP_RQ_STAT(struct mlx5e_rq_stats, recover) },
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 409e9a47e433..176fa5976259 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -194,7 +194,13 @@ struct mlx5e_sw_stats {
 	u64 rx_cqe_compress_blks;
 	u64 rx_cqe_compress_pkts;
 	u64 rx_congst_umr;
+#ifdef CONFIG_MLX5_EN_ARFS
+	u64 rx_arfs_add;
+	u64 rx_arfs_request_in;
+	u64 rx_arfs_request_out;
+	u64 rx_arfs_expired;
 	u64 rx_arfs_err;
+#endif
 	u64 rx_recover;
 	u64 ch_events;
 	u64 ch_poll;
@@ -256,7 +262,6 @@ struct mlx5e_sw_stats {
 	u64 rx_xsk_cqe_compress_blks;
 	u64 rx_xsk_cqe_compress_pkts;
 	u64 rx_xsk_congst_umr;
-	u64 rx_xsk_arfs_err;
 	u64 tx_xsk_xmit;
 	u64 tx_xsk_mpwqe;
 	u64 tx_xsk_inlnw;
@@ -358,7 +363,13 @@ struct mlx5e_rq_stats {
 	u64 cqe_compress_blks;
 	u64 cqe_compress_pkts;
 	u64 congst_umr;
+#ifdef CONFIG_MLX5_EN_ARFS
+	u64 arfs_add;
+	u64 arfs_request_in;
+	u64 arfs_request_out;
+	u64 arfs_expired;
 	u64 arfs_err;
+#endif
 	u64 recover;
 #ifdef CONFIG_PAGE_POOL_STATS
 	u64 pp_alloc_fast;
-- 
2.41.0


