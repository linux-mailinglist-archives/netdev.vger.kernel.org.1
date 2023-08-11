Return-Path: <netdev+bounces-26648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4214B7787BF
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731B61C21548
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C65677;
	Fri, 11 Aug 2023 06:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA65675
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:55:29 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FA31FCF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:55:28 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VpWDMKx_1691736922;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VpWDMKx_1691736922)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 14:55:22 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next 7/8] virtio-net: support tx netdim
Date: Fri, 11 Aug 2023 14:55:11 +0800
Message-Id: <20230811065512.22190-8-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230811065512.22190-1-hengqi@linux.alibaba.com>
References: <20230811065512.22190-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Similar to rx netdim, this patch supports adaptive tx
coalescing moderation for the virtio-net driver.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 128 +++++++++++++++++++++++++++++++++------
 1 file changed, 108 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3fb801a7a785..df7705ca05f0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -147,8 +147,17 @@ struct send_queue {
 
 	struct virtnet_sq_stats stats;
 
+	/* The number of tx notifications */
+	u16 calls;
+
+	/* Is dynamic interrupt moderation enabled? */
+	bool dim_enabled;
+
 	struct virtnet_interrupt_coalesce intr_coal;
 
+	/* Dynamic Iterrupt Moderation */
+	struct dim dim;
+
 	struct napi_struct napi;
 
 	/* Record whether sq is in reset state. */
@@ -443,19 +452,40 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
 	return false;
 }
 
+static void virtnet_tx_dim_work(struct work_struct *work);
+
+static void virtnet_tx_dim_update(struct virtnet_info *vi, struct send_queue *sq)
+{
+	struct virtnet_sq_stats *stats = &sq->stats;
+	struct dim_sample cur_sample = {};
+
+	u64_stats_update_begin(&sq->stats.syncp);
+	dim_update_sample(sq->calls, stats->packets,
+			  stats->bytes, &cur_sample);
+	u64_stats_update_end(&sq->stats.syncp);
+
+	net_dim(&sq->dim, cur_sample);
+}
+
 static void skb_xmit_done(struct virtqueue *vq)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
-	struct napi_struct *napi = &vi->sq[vq2txq(vq)].napi;
+	struct send_queue *sq = &vi->sq[vq2txq(vq)];
+	struct napi_struct *napi = &sq->napi;
+
+	sq->calls++;
 
 	/* Suppress further interrupts. */
 	virtqueue_disable_cb(vq);
 
-	if (napi->weight)
+	if (napi->weight) {
 		virtqueue_napi_schedule(napi, vq);
-	else
+	} else {
+		if (sq->dim_enabled)
+			virtnet_tx_dim_update(vi, sq);
 		/* We were probably waiting for more output buffers. */
 		netif_wake_subqueue(vi->dev, vq2txq(vq));
+	}
 }
 
 #define MRG_CTX_HEADER_SHIFT 22
@@ -2133,6 +2163,7 @@ static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 	napi_disable(&vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 	cancel_work_sync(&vi->rq[qp_index].dim.work);
+	cancel_work_sync(&vi->sq[qp_index].dim.work);
 }
 
 static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
@@ -2152,6 +2183,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 
 	INIT_WORK(&vi->rq[qp_index].dim.work, virtnet_rx_dim_work);
 	vi->rq[qp_index].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+	INIT_WORK(&vi->sq[qp_index].dim.work, virtnet_tx_dim_work);
+	vi->sq[qp_index].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
@@ -2232,6 +2265,9 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 				__netif_tx_unlock(txq);
 				__napi_schedule(napi);
 			}
+		} else {
+			if (sq->dim_enabled)
+				virtnet_tx_dim_update(vi, sq);
 		}
 	}
 
@@ -3196,20 +3232,37 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
 static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	bool tx_ctrl_dim_on = !!ec->use_adaptive_tx_coalesce;
 	struct scatterlist sgs_tx;
+	int i;
 
-	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
-	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
-	sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
-
-	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
-				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
-				  &sgs_tx))
+	if (tx_ctrl_dim_on && (ec->tx_coalesce_usecs != vi->intr_coal_tx.max_usecs ||
+			       ec->tx_max_coalesced_frames != vi->intr_coal_tx.max_packets))
 		return -EINVAL;
 
-	/* Save parameters */
-	vi->intr_coal_tx.max_usecs = ec->tx_coalesce_usecs;
-	vi->intr_coal_tx.max_packets = ec->tx_max_coalesced_frames;
+	if (tx_ctrl_dim_on) {
+		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+			for (i = 0; i < vi->max_queue_pairs; i++)
+				vi->sq[i].dim_enabled = true;
+		else
+			return -EOPNOTSUPP;
+	} else {
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			vi->sq[i].dim_enabled = false;
+
+		vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
+		vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
+		sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
+
+		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
+					  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
+					  &sgs_tx))
+			return -EINVAL;
+
+		/* Save parameters */
+		vi->intr_coal_tx.max_usecs = ec->tx_coalesce_usecs;
+		vi->intr_coal_tx.max_packets = ec->tx_max_coalesced_frames;
+	}
 
 	return 0;
 }
@@ -3304,6 +3357,27 @@ static int virtnet_send_tx_notf_coal_vq_cmd(struct virtnet_info *vi,
 	return 0;
 }
 
+static void virtnet_tx_dim_work(struct work_struct *work)
+{
+	struct dim *dim = container_of(work, struct dim, work);
+	struct send_queue *sq = container_of(dim,
+			struct send_queue, dim);
+	struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct net_device *dev = vi->dev;
+	struct dim_cq_moder update_moder;
+	int qnum = sq - vi->sq, err;
+
+	update_moder = net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
+	err = virtnet_send_tx_notf_coal_vq_cmd(vi, qnum,
+					       update_moder.usec,
+					       update_moder.pkts);
+	if (err)
+		pr_debug("%s: Failed to send dim parameters on txq%d\n",
+			 dev->name, (int)(sq - vi->sq));
+
+	dim->state = DIM_START_MEASURE;
+}
+
 static int virtnet_send_rx_notf_coal_vq_cmd(struct virtnet_info *vi,
 					    u16 queue, u32 max_usecs,
 					    u32 max_packets)
@@ -3326,7 +3400,7 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec,
 					  u16 queue)
 {
-	bool rx_ctrl_dim_on;
+	bool rx_ctrl_dim_on, tx_ctrl_dim_on;
 	u32 max_usecs, max_packets;
 	int err;
 
@@ -3351,11 +3425,23 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 	}
 
 	if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
-		err = virtnet_send_tx_notf_coal_vq_cmd(vi, queue,
-						       ec->tx_coalesce_usecs,
-						       ec->tx_max_coalesced_frames);
-		if (err)
-			return err;
+		tx_ctrl_dim_on = !!ec->use_adaptive_tx_coalesce;
+		max_usecs = vi->sq[queue].intr_coal.max_usecs;
+		max_packets = vi->sq[queue].intr_coal.max_packets;
+		if (tx_ctrl_dim_on && (ec->tx_coalesce_usecs != max_usecs ||
+				       ec->tx_max_coalesced_frames != max_packets))
+			return -EINVAL;
+
+		if (tx_ctrl_dim_on) {
+			vi->sq[queue].dim_enabled = true;
+		} else {
+			vi->sq[queue].dim_enabled = false;
+			err = virtnet_send_tx_notf_coal_vq_cmd(vi, queue,
+							       ec->tx_coalesce_usecs,
+							       ec->tx_max_coalesced_frames);
+			if (err)
+				return err;
+		}
 	}
 
 	return 0;
@@ -3464,6 +3550,7 @@ static int virtnet_get_coalesce(struct net_device *dev,
 		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
 		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
 		ec->use_adaptive_rx_coalesce = vi->rq[0].dim_enabled;
+		ec->use_adaptive_tx_coalesce = vi->sq[0].dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3522,6 +3609,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
 		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
+		ec->use_adaptive_tx_coalesce = vi->sq[queue].dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3647,7 +3735,7 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
-- 
2.19.1.6.gb485710b


