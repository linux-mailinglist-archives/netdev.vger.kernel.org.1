Return-Path: <netdev+bounces-78286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099FD8749F4
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0A41C21D98
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BC583A1C;
	Thu,  7 Mar 2024 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4cgg8rs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116283A18
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800967; cv=none; b=kMkm/NeQmR5aSLVMH3xhAVbRUjP8J05dMdDC+cn+3dMyOKXpZ5RzF15VnwPIrYfCR5SQJ05daStiwRfCUzbAj4Gwn3J36/XQ0Cf87FhM3EJO8UCc70ylHpcZDtcI7qSpwCqmkPiJ3O9/SLLwtbPo3tvcmuVAkhJQ5JgGVIbpB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800967; c=relaxed/simple;
	bh=pRQ/ud/bi13jrPzSsbQnDkNT+BxMdS3THrbWri/f57w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVmKzLfunIjkKkHZNVSRKhOjWARy9+xzIJ2E22MQYBM8YP6HlQW/VTsxFe9iUyDnixM8unpqbnWfHa2zuxEhyNATuw20XbpaDBTOlcYc0svVVImNurvcOMzN+pSrcHVwaD3qkkATZShBlUUtCPZAZNaWd3hEKNZ1E8iiMbUtNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4cgg8rs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB82EC43394;
	Thu,  7 Mar 2024 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709800966;
	bh=pRQ/ud/bi13jrPzSsbQnDkNT+BxMdS3THrbWri/f57w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4cgg8rstTUxlHuMZfXL9RS6AR8OasW8hRDwj+3NURD6mgtHJ260RTuS61WGWLT6y
	 TMyZnl1boca1/C3pAERyu3cElf/uutaPfsDf5kuKEPB58GVsG0TRojRAoa84QxTl4/
	 rQOtakIgj1CVLvnYxFBEcbxhhLGFldYDGucn5J5ODC9Ou3jWJOxvpIq9jzD/QFG4eH
	 6NEthRRMhjBN+HgbeBS6iKnh8fCiSym9b3jgM4WVYSiMy0AcfBn2i6jQSjPQtHdEHC
	 5TMjzKo4nt5lfBaKu/qqH65vHLNlG7Pl4ReUdXaj6S4XrCahgiZNsCTBPabp/7GH8B
	 Q+zlJ5SQlLwuw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V6 10/15] net/mlx5e: Let channels be SD-aware
Date: Thu,  7 Mar 2024 00:42:24 -0800
Message-ID: <20240307084229.500776-11-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307084229.500776-1-saeed@kernel.org>
References: <20240307084229.500776-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Distribute the channels between the different SD-devices to acheive
local numa node performance on multiple numas.

Each channel works against one specific mdev, creating all datapath
queues against it.

We distribute channels to mdevs in a round-robin policy.

Example for 2 mdevs and 6 channels:
+-------+---------+
| ch ix | mdev ix |
+-------+---------+
|   0   |    0    |
|   1   |    1    |
|   2   |    0    |
|   3   |    1    |
|   4   |    0    |
|   5   |    1    |
+-------+---------+

This round-robin distribution policy is preferred over another suggested
intuitive distribution, in which we first distribute one half of the
channels to mdev #0 and then the second half to mdev #1.

We prefer round-robin for a reason: it is less influenced by changes in
the number of channels. The mapping between channel index and mdev is
fixed, no matter how many channels the user configures. As the channel
stats are persistent to channels closure, changing the mapping every
single time would turn the accumulative stats less representing of the
channel's history.

Per-channel objects should stop using the primary mdev (priv->mdev)
directly, and instead move to using their own channel's mdev.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en/params.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |  8 ++---
 .../mellanox/mlx5/core/en/reporter_rx.c       |  4 +--
 .../mellanox/mlx5/core/en/reporter_tx.c       |  3 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/pool.c |  6 ++--
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  6 ++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 32 ++++++++++++-------
 8 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 6c143088e247..f6e78c465c7a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -792,6 +792,7 @@ struct mlx5e_channel {
 	struct hwtstamp_config    *tstamp;
 	DECLARE_BITMAP(state, MLX5E_CHANNEL_NUM_STATES);
 	int                        ix;
+	int                        vec_ix;
 	int                        cpu;
 	/* Sync between icosq recovery and XSK enable/disable. */
 	struct mutex               icosq_recovery_lock;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 5757f4f10c12..8b99cc11f138 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -688,7 +688,7 @@ void mlx5e_build_create_cq_param(struct mlx5e_create_cq_param *ccp, struct mlx5e
 		.napi = &c->napi,
 		.ch_stats = c->stats,
 		.node = cpu_to_node(c->cpu),
-		.ix = c->ix,
+		.ix = c->vec_ix,
 	};
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index 34adf8c3f81a..e87e26f2c669 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -122,8 +122,8 @@ int mlx5e_open_qos_sq(struct mlx5e_priv *priv, struct mlx5e_channels *chs,
 
 	memset(&param_sq, 0, sizeof(param_sq));
 	memset(&param_cq, 0, sizeof(param_cq));
-	mlx5e_build_sq_param(priv->mdev, params, &param_sq);
-	mlx5e_build_tx_cq_param(priv->mdev, params, &param_cq);
+	mlx5e_build_sq_param(c->mdev, params, &param_sq);
+	mlx5e_build_tx_cq_param(c->mdev, params, &param_cq);
 	err = mlx5e_open_cq(c->mdev, params->tx_cq_moderation, &param_cq, &ccp, &sq->cq);
 	if (err)
 		goto err_free_sq;
@@ -176,7 +176,7 @@ int mlx5e_activate_qos_sq(void *data, u16 node_qid, u32 hw_id)
 	 */
 	smp_wmb();
 
-	qos_dbg(priv->mdev, "Activate QoS SQ qid %u\n", node_qid);
+	qos_dbg(sq->mdev, "Activate QoS SQ qid %u\n", node_qid);
 	mlx5e_activate_txqsq(sq);
 
 	return 0;
@@ -190,7 +190,7 @@ void mlx5e_deactivate_qos_sq(struct mlx5e_priv *priv, u16 qid)
 	if (!sq) /* Handle the case when the SQ failed to open. */
 		return;
 
-	qos_dbg(priv->mdev, "Deactivate QoS SQ qid %u\n", qid);
+	qos_dbg(sq->mdev, "Deactivate QoS SQ qid %u\n", qid);
 	mlx5e_deactivate_txqsq(sq);
 
 	priv->txq2sq[mlx5e_qid_from_qos(&priv->channels, qid)] = NULL;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 4358798d6ce1..25d751eba99b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -294,8 +294,8 @@ static void mlx5e_rx_reporter_diagnose_generic_rq(struct mlx5e_rq *rq,
 
 	params = &priv->channels.params;
 	rq_sz = mlx5e_rqwq_get_size(rq);
-	real_time =  mlx5_is_real_time_rq(priv->mdev);
-	rq_stride = BIT(mlx5e_mpwqe_get_log_stride_size(priv->mdev, params, NULL));
+	real_time =  mlx5_is_real_time_rq(rq->mdev);
+	rq_stride = BIT(mlx5e_mpwqe_get_log_stride_size(rq->mdev, params, NULL));
 
 	mlx5e_health_fmsg_named_obj_nest_start(fmsg, "RQ");
 	devlink_fmsg_u8_pair_put(fmsg, "type", params->rq_wq_type);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 6b44ddce14e9..0ab9db319530 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -219,7 +219,6 @@ mlx5e_tx_reporter_build_diagnose_output_sq_common(struct devlink_fmsg *fmsg,
 						  struct mlx5e_txqsq *sq, int tc)
 {
 	bool stopped = netif_xmit_stopped(sq->txq);
-	struct mlx5e_priv *priv = sq->priv;
 	u8 state;
 	int err;
 
@@ -227,7 +226,7 @@ mlx5e_tx_reporter_build_diagnose_output_sq_common(struct devlink_fmsg *fmsg,
 	devlink_fmsg_u32_pair_put(fmsg, "txq ix", sq->txq_ix);
 	devlink_fmsg_u32_pair_put(fmsg, "sqn", sq->sqn);
 
-	err = mlx5_core_query_sq_state(priv->mdev, sq->sqn, &state);
+	err = mlx5_core_query_sq_state(sq->mdev, sq->sqn, &state);
 	if (!err)
 		devlink_fmsg_u8_pair_put(fmsg, "HW state", state);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
index ebada0c5af3c..db776e515b6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
@@ -6,10 +6,10 @@
 #include "setup.h"
 #include "en/params.h"
 
-static int mlx5e_xsk_map_pool(struct mlx5e_priv *priv,
+static int mlx5e_xsk_map_pool(struct mlx5_core_dev *mdev,
 			      struct xsk_buff_pool *pool)
 {
-	struct device *dev = mlx5_core_dma_dev(priv->mdev);
+	struct device *dev = mlx5_core_dma_dev(mdev);
 
 	return xsk_pool_dma_map(pool, dev, DMA_ATTR_SKIP_CPU_SYNC);
 }
@@ -89,7 +89,7 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 	if (unlikely(!mlx5e_xsk_is_pool_sane(pool)))
 		return -EINVAL;
 
-	err = mlx5e_xsk_map_pool(priv, pool);
+	err = mlx5e_xsk_map_pool(mlx5_sd_ch_ix_get_dev(priv->mdev, ix), pool);
 	if (unlikely(err))
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 9b597cb24598..65ccb33edafb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -267,7 +267,7 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
 		goto err_out;
 	}
 
-	pdev = mlx5_core_dma_dev(sq->channel->priv->mdev);
+	pdev = mlx5_core_dma_dev(sq->channel->mdev);
 	buf->dma_addr = dma_map_single(pdev, &buf->progress,
 				       PROGRESS_PARAMS_PADDED_SIZE, DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(pdev, buf->dma_addr))) {
@@ -425,14 +425,12 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 {
 	struct mlx5e_ktls_rx_resync_buf *buf = wi->tls_get_params.buf;
 	struct mlx5e_ktls_offload_context_rx *priv_rx;
-	struct mlx5e_ktls_rx_resync_ctx *resync;
 	u8 tracker_state, auth_state, *ctx;
 	struct device *dev;
 	u32 hw_seq;
 
 	priv_rx = buf->priv_rx;
-	resync = &priv_rx->resync;
-	dev = mlx5_core_dma_dev(resync->priv->mdev);
+	dev = mlx5_core_dma_dev(sq->channel->mdev);
 	if (unlikely(test_bit(MLX5E_PRIV_RX_FLAG_DELETING, priv_rx->flags)))
 		goto out;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c6c406c18b54..8d9b0cdb4e01 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2529,14 +2529,20 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 			      struct xsk_buff_pool *xsk_pool,
 			      struct mlx5e_channel **cp)
 {
-	int cpu = mlx5_comp_vector_get_cpu(priv->mdev, ix);
 	struct net_device *netdev = priv->netdev;
+	struct mlx5_core_dev *mdev;
 	struct mlx5e_xsk_param xsk;
 	struct mlx5e_channel *c;
 	unsigned int irq;
+	int vec_ix;
+	int cpu;
 	int err;
 
-	err = mlx5_comp_irqn_get(priv->mdev, ix, &irq);
+	mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, ix);
+	vec_ix = mlx5_sd_ch_ix_get_vec_ix(mdev, ix);
+	cpu = mlx5_comp_vector_get_cpu(mdev, vec_ix);
+
+	err = mlx5_comp_irqn_get(mdev, vec_ix, &irq);
 	if (err)
 		return err;
 
@@ -2549,18 +2555,19 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 		return -ENOMEM;
 
 	c->priv     = priv;
-	c->mdev     = priv->mdev;
+	c->mdev     = mdev;
 	c->tstamp   = &priv->tstamp;
 	c->ix       = ix;
+	c->vec_ix   = vec_ix;
 	c->cpu      = cpu;
-	c->pdev     = mlx5_core_dma_dev(priv->mdev);
+	c->pdev     = mlx5_core_dma_dev(mdev);
 	c->netdev   = priv->netdev;
-	c->mkey_be  = cpu_to_be32(priv->mdev->mlx5e_res.hw_objs.mkey);
+	c->mkey_be  = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey);
 	c->num_tc   = mlx5e_get_dcb_num_tc(params);
 	c->xdp      = !!params->xdp_prog;
 	c->stats    = &priv->channel_stats[ix]->ch;
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
-	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
+	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
 	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
 	netif_napi_set_irq(&c->napi, irq);
@@ -2943,15 +2950,18 @@ static MLX5E_DEFINE_PREACTIVATE_WRAPPER_CTX(mlx5e_update_netdev_queues);
 static void mlx5e_set_default_xps_cpumasks(struct mlx5e_priv *priv,
 					   struct mlx5e_params *params)
 {
-	struct mlx5_core_dev *mdev = priv->mdev;
-	int num_comp_vectors, ix, irq;
-
-	num_comp_vectors = mlx5_comp_vectors_max(mdev);
+	int ix;
 
 	for (ix = 0; ix < params->num_channels; ix++) {
+		int num_comp_vectors, irq, vec_ix;
+		struct mlx5_core_dev *mdev;
+
+		mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, ix);
+		num_comp_vectors = mlx5_comp_vectors_max(mdev);
 		cpumask_clear(priv->scratchpad.cpumask);
+		vec_ix = mlx5_sd_ch_ix_get_vec_ix(mdev, ix);
 
-		for (irq = ix; irq < num_comp_vectors; irq += params->num_channels) {
+		for (irq = vec_ix; irq < num_comp_vectors; irq += params->num_channels) {
 			int cpu = mlx5_comp_vector_get_cpu(mdev, irq);
 
 			cpumask_set_cpu(cpu, priv->scratchpad.cpumask);
-- 
2.44.0


