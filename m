Return-Path: <netdev+bounces-23088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B376AAD6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982FE281888
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B51ED37;
	Tue,  1 Aug 2023 08:22:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC38F1FB40
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:22:47 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D636A0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 01:22:46 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VopSD5s_1690878161;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VopSD5s_1690878161)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 16:22:42 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC PATCH 5/6] virtio-net: support tx netdim
Date: Tue,  1 Aug 2023 16:22:34 +0800
Message-Id: <20230801082235.21634-6-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230801082235.21634-1-hengqi@linux.alibaba.com>
References: <20230801082235.21634-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Similar to rx netdim, this patch supports adaptive tx
coalescing moderation for the virtio-net driver.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 99 ++++++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 069e68a52598..d8e66460e37d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -145,8 +145,14 @@ struct send_queue {
 
 	struct virtnet_sq_stats stats;
 
+	/* The number of tx notifications */
+	u16 calls;
+
 	struct virtnet_interrupt_coalesce intr_coal;
 
+	/* Dynamic Iterrupt Moderation */
+	struct dim dim;
+
 	struct napi_struct napi;
 
 	/* Record whether sq is in reset state. */
@@ -299,6 +305,7 @@ struct virtnet_info {
 
 	/* Is dynamic interrupt moderation enabled? */
 	bool rx_dim_enabled;
+	bool tx_dim_enabled;
 
 	/* Interrupt coalescing settings */
 	struct virtnet_interrupt_coalesce intr_coal_tx;
@@ -435,19 +442,40 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
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
+		if (vi->tx_dim_enabled)
+			virtnet_tx_dim_update(vi, sq);
 		/* We were probably waiting for more output buffers. */
 		netif_wake_subqueue(vi->dev, vq2txq(vq));
+	}
 }
 
 #define MRG_CTX_HEADER_SHIFT 22
@@ -2027,6 +2055,7 @@ static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 	napi_disable(&vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 	cancel_work_sync(&vi->rq[qp_index].dim.work);
+	cancel_work_sync(&vi->sq[qp_index].dim.work);
 }
 
 static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
@@ -2046,6 +2075,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 
 	INIT_WORK(&vi->rq[qp_index].dim.work, virtnet_rx_dim_work);
 	vi->rq[qp_index].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+	INIT_WORK(&vi->sq[qp_index].dim.work, virtnet_tx_dim_work);
+	vi->sq[qp_index].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
@@ -2126,6 +2157,9 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 				__netif_tx_unlock(txq);
 				__napi_schedule(napi);
 			}
+		} else {
+			if (vi->tx_dim_enabled)
+				virtnet_tx_dim_update(vi, sq);
 		}
 	}
 
@@ -3090,20 +3124,33 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
 static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	bool tx_ctrl_dim_on = !!ec->use_adaptive_tx_coalesce;
 	struct scatterlist sgs_tx;
 
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
+			vi->tx_dim_enabled = true;
+		else
+			return -EOPNOTSUPP;
+	} else if (!tx_ctrl_dim_on) {
+		vi->tx_dim_enabled = false;
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
@@ -3194,6 +3241,27 @@ static int virtnet_send_tx_notf_coal_vq_cmd(struct virtnet_info *vi,
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
+				dev->name, (int)(sq - vi->sq));
+
+	dim->state = DIM_START_MEASURE;
+}
+
 static int virtnet_send_rx_notf_coal_vq_cmd(struct virtnet_info *vi,
 					    u16 queue, u32 max_usecs,
 					    u32 max_packets)
@@ -3230,6 +3298,9 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 	}
 
 	if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
+		if (vi->tx_dim_enabled)
+			return -EBUSY;
+
 		err = virtnet_send_tx_notf_coal_vq_cmd(vi, queue,
 						       ec->tx_coalesce_usecs,
 						       ec->tx_max_coalesced_frames);
@@ -3524,7 +3595,7 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
-- 
2.19.1.6.gb485710b


