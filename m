Return-Path: <netdev+bounces-27492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325677C28A
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA91C20BB2
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200F4100CE;
	Mon, 14 Aug 2023 21:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB2100A2
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C334C43391;
	Mon, 14 Aug 2023 21:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049311;
	bh=eaFPvNLC/GnEryTUxCnMV4tl0OExrocZ6AOYp0RykJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXgje10nfb1vIHpC5Yldy0z1gtM4KoFCLD3qxIO6ttxyDodBkvD3qPKm8LKw4i8P0
	 DYx9xpz7yBNelGHE4ZVhYanqz6CwiGT+/apAMBGJavbiqEj2mTWhIq+Si3dZQbjn7c
	 1T6yAe/gC5H4Ylrf6TAazhI1An0wTcx6AHSrAXdfNWyyC0ztnLojOvt/YU8UVaUtfO
	 jOoPCjyFY+5D8ejbyQ0bW07CO/hRhTTcixvXm0ZVulRcfKni8XN5E5ueAvUf0cyRYW
	 qSrebIPyBC1W6js5aJzuQC/t5jOeHug/54tCXA137DN/f6uM/H2oohxdosoZVpRVWv
	 /SU1if7AtezYA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net-next 03/14] net/mlx5e: Add recovery flow for tx devlink health reporter for unhealthy PTP SQ
Date: Mon, 14 Aug 2023 14:41:33 -0700
Message-ID: <20230814214144.159464-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214144.159464-1-saeed@kernel.org>
References: <20230814214144.159464-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

A new check for the tx devlink health reporter is introduced for
determining when the PTP port timestamping SQ is considered unhealthy. If
there are enough CQEs considered never to be delivered, the space that can
be utilized on the SQ decreases significantly, impacting performance and
usability of the SQ. The health reporter is triggered when the number of
likely never delivered port timestamping CQEs that utilize the space of the
PTP SQ is greater than 93.75% of the total capacity of the SQ. A devlink
health reporter recover method is also provided for this specific TX error
context that restarts the PTP SQ.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |  5 +-
 .../ethernet/mellanox/mlx5/core/en/health.h   |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  | 22 +++++++
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h  |  2 +
 .../mellanox/mlx5/core/en/reporter_tx.c       | 65 +++++++++++++++++++
 5 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 196a4bb28df1..702f204a3dbd 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -135,7 +135,7 @@ Health reporters
 
 tx reporter
 -----------
-The tx reporter is responsible for reporting and recovering of the following two error scenarios:
+The tx reporter is responsible for reporting and recovering of the following three error scenarios:
 
 - tx timeout
     Report on kernel tx timeout detection.
@@ -143,6 +143,9 @@ The tx reporter is responsible for reporting and recovering of the following two
 - tx error completion
     Report on error tx completion.
     Recover by flushing the tx queue and reset it.
+- tx PTP port timestamping CQ unhealthy
+    Report too many CQEs never delivered on port ts CQ.
+    Recover by flushing and re-creating all PTP channels.
 
 tx reporter also support on demand diagnose callback, on which it provides
 real time information of its send queues status.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/health.h b/drivers/net/ethernet/mellanox/mlx5/core/en/health.h
index 0107e4e73bb0..415840c3ef84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/health.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/health.h
@@ -18,6 +18,7 @@ void mlx5e_reporter_tx_create(struct mlx5e_priv *priv);
 void mlx5e_reporter_tx_destroy(struct mlx5e_priv *priv);
 void mlx5e_reporter_tx_err_cqe(struct mlx5e_txqsq *sq);
 int mlx5e_reporter_tx_timeout(struct mlx5e_txqsq *sq);
+void mlx5e_reporter_tx_ptpsq_unhealthy(struct mlx5e_ptpsq *ptpsq);
 
 int mlx5e_health_cq_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
 int mlx5e_health_cq_common_diag_fmsg(struct mlx5e_cq *cq, struct devlink_fmsg *fmsg);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 8680d21f3e7b..bb11e644d24f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2020 Mellanox Technologies
 
 #include "en/ptp.h"
+#include "en/health.h"
 #include "en/txrx.h"
 #include "en/params.h"
 #include "en/fs_tt_redirect.h"
@@ -140,6 +141,12 @@ mlx5e_ptp_metadata_map_remove(struct mlx5e_ptp_metadata_map *map, u16 metadata)
 	return skb;
 }
 
+static bool mlx5e_ptp_metadata_map_unhealthy(struct mlx5e_ptp_metadata_map *map)
+{
+	/* Considered beginning unhealthy state if size * 15 / 2^4 cannot be reclaimed. */
+	return map->undelivered_counter > (map->capacity >> 4) * 15;
+}
+
 static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 						 ktime_t port_tstamp)
 {
@@ -205,6 +212,9 @@ static void mlx5e_ptp_handle_ts_cqe(struct mlx5e_ptpsq *ptpsq,
 out:
 	napi_consume_skb(skb, budget);
 	mlx5e_ptp_metadata_fifo_push(&ptpsq->metadata_freelist, metadata_id);
+	if (unlikely(mlx5e_ptp_metadata_map_unhealthy(&ptpsq->metadata_map)) &&
+	    !test_and_set_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state))
+		queue_work(ptpsq->txqsq.priv->wq, &ptpsq->report_unhealthy_work);
 }
 
 static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq, int budget)
@@ -422,6 +432,14 @@ static void mlx5e_ptp_free_traffic_db(struct mlx5e_ptpsq *ptpsq)
 	kvfree(ptpsq->ts_cqe_pending_list);
 }
 
+static void mlx5e_ptpsq_unhealthy_work(struct work_struct *work)
+{
+	struct mlx5e_ptpsq *ptpsq =
+		container_of(work, struct mlx5e_ptpsq, report_unhealthy_work);
+
+	mlx5e_reporter_tx_ptpsq_unhealthy(ptpsq);
+}
+
 static int mlx5e_ptp_open_txqsq(struct mlx5e_ptp *c, u32 tisn,
 				int txq_ix, struct mlx5e_ptp_params *cparams,
 				int tc, struct mlx5e_ptpsq *ptpsq)
@@ -451,6 +469,8 @@ static int mlx5e_ptp_open_txqsq(struct mlx5e_ptp *c, u32 tisn,
 	if (err)
 		goto err_free_txqsq;
 
+	INIT_WORK(&ptpsq->report_unhealthy_work, mlx5e_ptpsq_unhealthy_work);
+
 	return 0;
 
 err_free_txqsq:
@@ -464,6 +484,8 @@ static void mlx5e_ptp_close_txqsq(struct mlx5e_ptpsq *ptpsq)
 	struct mlx5e_txqsq *sq = &ptpsq->txqsq;
 	struct mlx5_core_dev *mdev = sq->mdev;
 
+	if (current_work() != &ptpsq->report_unhealthy_work)
+		cancel_work_sync(&ptpsq->report_unhealthy_work);
 	mlx5e_ptp_free_traffic_db(ptpsq);
 	cancel_work_sync(&sq->recover_work);
 	mlx5e_ptp_destroy_sq(mdev, sq->sqn);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
index 7c5597d4589d..7b700d0f956a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
@@ -10,6 +10,7 @@
 #include <linux/ktime.h>
 #include <linux/ptp_classify.h>
 #include <linux/time64.h>
+#include <linux/workqueue.h>
 
 #define MLX5E_PTP_CHANNEL_IX 0
 #define MLX5E_PTP_MAX_LOG_SQ_SIZE (8U)
@@ -34,6 +35,7 @@ struct mlx5e_ptpsq {
 	struct mlx5e_ptp_cq_stats *cq_stats;
 	u16                      ts_cqe_ctr_mask;
 
+	struct work_struct                 report_unhealthy_work;
 	struct mlx5e_ptp_port_ts_cqe_list  *ts_cqe_pending_list;
 	struct mlx5e_ptp_metadata_fifo     metadata_freelist;
 	struct mlx5e_ptp_metadata_map      metadata_map;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index b35ff289af49..ff8242f67c54 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -164,6 +164,43 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 	return err;
 }
 
+static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
+{
+	struct mlx5e_ptpsq *ptpsq = ctx;
+	struct mlx5e_channels *chs;
+	struct net_device *netdev;
+	struct mlx5e_priv *priv;
+	int carrier_ok;
+	int err;
+
+	if (!test_bit(MLX5E_SQ_STATE_RECOVERING, &ptpsq->txqsq.state))
+		return 0;
+
+	priv = ptpsq->txqsq.priv;
+
+	mutex_lock(&priv->state_lock);
+	chs = &priv->channels;
+	netdev = priv->netdev;
+
+	carrier_ok = netif_carrier_ok(netdev);
+	netif_carrier_off(netdev);
+
+	mlx5e_deactivate_priv_channels(priv);
+
+	mlx5e_ptp_close(chs->ptp);
+	err = mlx5e_ptp_open(priv, &chs->params, chs->c[0]->lag_port, &chs->ptp);
+
+	mlx5e_activate_priv_channels(priv);
+
+	/* return carrier back if needed */
+	if (carrier_ok)
+		netif_carrier_on(netdev);
+
+	mutex_unlock(&priv->state_lock);
+
+	return err;
+}
+
 /* state lock cannot be grabbed within this function.
  * It can cause a dead lock or a read-after-free.
  */
@@ -516,6 +553,15 @@ static int mlx5e_tx_reporter_timeout_dump(struct mlx5e_priv *priv, struct devlin
 	return mlx5e_tx_reporter_dump_sq(priv, fmsg, to_ctx->sq);
 }
 
+static int mlx5e_tx_reporter_ptpsq_unhealthy_dump(struct mlx5e_priv *priv,
+						  struct devlink_fmsg *fmsg,
+						  void *ctx)
+{
+	struct mlx5e_ptpsq *ptpsq = ctx;
+
+	return mlx5e_tx_reporter_dump_sq(priv, fmsg, &ptpsq->txqsq);
+}
+
 static int mlx5e_tx_reporter_dump_all_sqs(struct mlx5e_priv *priv,
 					  struct devlink_fmsg *fmsg)
 {
@@ -621,6 +667,25 @@ int mlx5e_reporter_tx_timeout(struct mlx5e_txqsq *sq)
 	return to_ctx.status;
 }
 
+void mlx5e_reporter_tx_ptpsq_unhealthy(struct mlx5e_ptpsq *ptpsq)
+{
+	struct mlx5e_ptp_metadata_map *map = &ptpsq->metadata_map;
+	char err_str[MLX5E_REPORTER_PER_Q_MAX_LEN];
+	struct mlx5e_txqsq *txqsq = &ptpsq->txqsq;
+	struct mlx5e_cq *ts_cq = &ptpsq->ts_cq;
+	struct mlx5e_priv *priv = txqsq->priv;
+	struct mlx5e_err_ctx err_ctx = {};
+
+	err_ctx.ctx = ptpsq;
+	err_ctx.recover = mlx5e_tx_reporter_ptpsq_unhealthy_recover;
+	err_ctx.dump = mlx5e_tx_reporter_ptpsq_unhealthy_dump;
+	snprintf(err_str, sizeof(err_str),
+		 "Unhealthy TX port TS queue: %d, SQ: 0x%x, CQ: 0x%x, Undelivered CQEs: %u Map Capacity: %u",
+		 txqsq->ch_ix, txqsq->sqn, ts_cq->mcq.cqn, map->undelivered_counter, map->capacity);
+
+	mlx5e_health_report(priv, priv->tx_reporter, err_str, &err_ctx);
+}
+
 static const struct devlink_health_reporter_ops mlx5_tx_reporter_ops = {
 		.name = "tx",
 		.recover = mlx5e_tx_reporter_recover,
-- 
2.41.0


