Return-Path: <netdev+bounces-53818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C44804BA9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448671C20E0C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971F3A8CD;
	Tue,  5 Dec 2023 08:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E14D83
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 00:02:29 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vxtr0Aj_1701763346;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vxtr0Aj_1701763346)
          by smtp.aliyun-inc.com;
          Tue, 05 Dec 2023 16:02:27 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	yinjun.zhang@corigine.com,
	edumazet@google.com,
	davem@davemloft.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ast@kernel.org,
	horms@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v6 5/5] virtio-net: support rx netdim
Date: Tue,  5 Dec 2023 16:02:19 +0800
Message-Id: <dcde158f91bbd6712a452be707f9466d79434ccf.1701762688.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1701762688.git.hengqi@linux.alibaba.com>
References: <cover.1701762688.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By comparing the traffic information in the complete napi processes,
let the virtio-net driver automatically adjust the coalescing
moderation parameters of each receive queue.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
v5->v5:
- Use spin lock and cancel_work_sync to synchronize

v4->v5:
- Fix possible synchronization issues using cancel_work().
- Reduce if/else nesting levels

v2->v3:
- Some minor modifications.

v1->v2:
- Improved the judgment of dim switch conditions.
- Cancel the work when vq reset.

 drivers/net/virtio_net.c | 199 ++++++++++++++++++++++++++++++++-------
 1 file changed, 167 insertions(+), 32 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0dd09c4f8d89..882761c64db4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -19,6 +19,7 @@
 #include <linux/average.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
+#include <linux/dim.h>
 #include <net/route.h>
 #include <net/xdp.h>
 #include <net/net_failover.h>
@@ -172,6 +173,17 @@ struct receive_queue {
 
 	struct virtnet_rq_stats stats;
 
+	/* The number of rx notifications */
+	u16 calls;
+
+	/* Is dynamic interrupt moderation enabled? */
+	bool dim_enabled;
+
+	/* Dynamic Interrupt Moderation */
+	struct dim dim;
+
+	u32 packets_in_napi;
+
 	struct virtnet_interrupt_coalesce intr_coal;
 
 	/* Chain pages by the private ptr. */
@@ -308,6 +320,9 @@ struct virtnet_info {
 	u8 duplex;
 	u32 speed;
 
+	/* Is rx dynamic interrupt moderation enabled? */
+	bool rx_dim_enabled;
+
 	/* Interrupt coalescing settings */
 	struct virtnet_interrupt_coalesce intr_coal_tx;
 	struct virtnet_interrupt_coalesce intr_coal_rx;
@@ -2004,6 +2019,7 @@ static void skb_recv_done(struct virtqueue *rvq)
 	struct virtnet_info *vi = rvq->vdev->priv;
 	struct receive_queue *rq = &vi->rq[vq2rxq(rvq)];
 
+	rq->calls++;
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
@@ -2144,6 +2160,26 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	}
 }
 
+static void virtnet_rx_dim_work(struct work_struct *work);
+
+static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
+{
+	struct dim_sample cur_sample = {};
+
+	if (!rq->packets_in_napi)
+		return;
+
+	u64_stats_update_begin(&rq->stats.syncp);
+	dim_update_sample(rq->calls,
+			  u64_stats_read(&rq->stats.packets),
+			  u64_stats_read(&rq->stats.bytes),
+			  &cur_sample);
+	u64_stats_update_end(&rq->stats.syncp);
+
+	net_dim(&rq->dim, cur_sample);
+	rq->packets_in_napi = 0;
+}
+
 static int virtnet_poll(struct napi_struct *napi, int budget)
 {
 	struct receive_queue *rq =
@@ -2152,17 +2188,22 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	struct send_queue *sq;
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
+	bool napi_complete;
 
 	virtnet_poll_cleantx(rq);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
+	rq->packets_in_napi += received;
 
 	if (xdp_xmit & VIRTIO_XDP_REDIR)
 		xdp_do_flush();
 
 	/* Out of packets? */
-	if (received < budget)
-		virtqueue_napi_complete(napi, rq->vq, received);
+	if (received < budget) {
+		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
+		if (napi_complete && rq->dim_enabled)
+			virtnet_rx_dim_update(vi, rq);
+	}
 
 	if (xdp_xmit & VIRTIO_XDP_TX) {
 		sq = virtnet_xdp_get_sq(vi);
@@ -2233,8 +2274,11 @@ static int virtnet_open(struct net_device *dev)
 	disable_delayed_refill(vi);
 	cancel_delayed_work_sync(&vi->refill);
 
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
 		virtnet_disable_queue_pair(vi, i);
+		cancel_work_sync(&vi->rq[i].dim.work);
+	}
+
 	return err;
 }
 
@@ -2396,8 +2440,10 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	qindex = rq - vi->rq;
 
-	if (running)
+	if (running) {
 		napi_disable(&rq->napi);
+		cancel_work_sync(&rq->dim.work);
+	}
 
 	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
 	if (err)
@@ -2652,8 +2698,10 @@ static int virtnet_close(struct net_device *dev)
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
 
-	for (i = 0; i < vi->max_queue_pairs; i++)
+	for (i = 0; i < vi->max_queue_pairs; i++) {
 		virtnet_disable_queue_pair(vi, i);
+		cancel_work_sync(&vi->rq[i].dim.work);
+	}
 
 	return 0;
 }
@@ -2905,20 +2953,25 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 	return 0;
 }
 
-static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
-					    u16 queue, u32 max_usecs,
-					    u32 max_packets)
+static int virtnet_send_tx_notf_coal_vq_cmds(struct virtnet_info *vi,
+					     u16 queue, u32 max_usecs,
+					     u32 max_packets)
 {
 	int err;
 
+	spin_lock(&vi->ctrl_lock);
 	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
 					    max_usecs, max_packets);
-	if (err)
+	if (err) {
+		spin_unlock(&vi->ctrl_lock);
 		return err;
+	}
 
 	vi->sq[queue].intr_coal.max_usecs = max_usecs;
 	vi->sq[queue].intr_coal.max_packets = max_packets;
 
+	spin_unlock(&vi->ctrl_lock);
+
 	return 0;
 }
 
@@ -2935,9 +2988,6 @@ static void virtnet_get_ringparam(struct net_device *dev,
 	ring->tx_pending = virtqueue_get_vring_size(vi->sq[0].vq);
 }
 
-static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
-					 u16 vqn, u32 max_usecs, u32 max_packets);
-
 static int virtnet_set_ringparam(struct net_device *dev,
 				 struct ethtool_ringparam *ring,
 				 struct kernel_ethtool_ringparam *kernel_ring,
@@ -2979,15 +3029,11 @@ static int virtnet_set_ringparam(struct net_device *dev,
 			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
 			 * did not set any TX coalescing parameters, to 0.
 			 */
-			spin_lock(&vi->ctrl_lock);
-			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
-							       vi->intr_coal_tx.max_usecs,
-							       vi->intr_coal_tx.max_packets);
-			if (err) {
-				spin_unlock(&vi->ctrl_lock);
+			err = virtnet_send_tx_notf_coal_vq_cmds(vi, i,
+								vi->intr_coal_tx.max_usecs,
+								vi->intr_coal_tx.max_packets);
+			if (err)
 				return err;
-			}
-			spin_unlock(&vi->ctrl_lock);
 		}
 
 		if (ring->rx_pending != rx_pending) {
@@ -3379,9 +3425,34 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
 	struct scatterlist sgs_rx;
 	int i;
 
+	if (rx_ctrl_dim_on && !virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return -EOPNOTSUPP;
+
+	if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != vi->intr_coal_rx.max_usecs ||
+			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
+		return -EINVAL;
+
+	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
+		vi->rx_dim_enabled = true;
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			vi->rq[i].dim_enabled = true;
+		return 0;
+	}
+
+	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
+		vi->rx_dim_enabled = false;
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			vi->rq[i].dim_enabled = false;
+	}
+
+	/* Since the per-queue coalescing params can be set,
+	 * we need apply the global new params even if they
+	 * are not updated.
+	 */
 	spin_lock(&vi->ctrl_lock);
 	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
 	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
@@ -3394,7 +3465,6 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 		return -EINVAL;
 	}
 
-	/* Save parameters */
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
 	for (i = 0; i < vi->max_queue_pairs; i++) {
@@ -3423,13 +3493,36 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
-static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
-					  struct ethtool_coalesce *ec,
-					  u16 queue)
+static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
+					     struct ethtool_coalesce *ec,
+					     u16 queue)
 {
+	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
+	bool cur_rx_dim = vi->rq[queue].dim_enabled;
+	u32 max_usecs, max_packets;
 	int err;
 
 	spin_lock(&vi->ctrl_lock);
+	max_usecs = vi->rq[queue].intr_coal.max_usecs;
+	max_packets = vi->rq[queue].intr_coal.max_packets;
+	if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != max_usecs ||
+			       ec->rx_max_coalesced_frames != max_packets)) {
+		spin_unlock(&vi->ctrl_lock);
+		return -EINVAL;
+	}
+
+	if (rx_ctrl_dim_on && !cur_rx_dim) {
+		vi->rq[queue].dim_enabled = true;
+		spin_unlock(&vi->ctrl_lock);
+		return 0;
+	}
+
+	if (!rx_ctrl_dim_on && cur_rx_dim)
+		vi->rq[queue].dim_enabled = false;
+
+	/* If no params are updated, userspace ethtool will
+	 * reject the modification.
+	 */
 	err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
 					       ec->rx_coalesce_usecs,
 					       ec->rx_max_coalesced_frames);
@@ -3438,19 +3531,56 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 		return err;
 	}
 
-	err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
-					       ec->tx_coalesce_usecs,
-					       ec->tx_max_coalesced_frames);
-	if (err) {
-		spin_unlock(&vi->ctrl_lock);
+	spin_unlock(&vi->ctrl_lock);
+
+	return 0;
+}
+
+static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
+					  struct ethtool_coalesce *ec,
+					  u16 queue)
+{
+	int err;
+
+	err = virtnet_send_rx_notf_coal_vq_cmds(vi, ec, queue);
+	if (err)
 		return err;
-	}
 
-	spin_unlock(&vi->ctrl_lock);
+	err = virtnet_send_tx_notf_coal_vq_cmds(vi, queue,
+						ec->tx_coalesce_usecs,
+						ec->tx_max_coalesced_frames);
+	if (err)
+		return err;
 
 	return 0;
 }
 
+static void virtnet_rx_dim_work(struct work_struct *work)
+{
+	struct dim *dim = container_of(work, struct dim, work);
+	struct receive_queue *rq = container_of(dim,
+			struct receive_queue, dim);
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	struct net_device *dev = vi->dev;
+	struct dim_cq_moder update_moder;
+	int qnum = rq - vi->rq, err;
+
+	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+	spin_lock(&vi->ctrl_lock);
+	if (update_moder.usec != vi->rq[qnum].intr_coal.max_usecs ||
+	    update_moder.pkts != vi->rq[qnum].intr_coal.max_packets) {
+		err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
+						       update_moder.usec,
+						       update_moder.pkts);
+		if (err)
+			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
+				 dev->name, (int)(rq - vi->rq));
+	}
+
+	spin_unlock(&vi->ctrl_lock);
+	dim->state = DIM_START_MEASURE;
+}
+
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
 {
 	/* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
@@ -3532,6 +3662,7 @@ static int virtnet_get_coalesce(struct net_device *dev,
 		ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
 		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
 		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
+		ec->use_adaptive_rx_coalesce = vi->rx_dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3589,6 +3720,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
+		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3714,7 +3846,7 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
@@ -4308,6 +4440,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
 
+		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
+		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
-- 
2.19.1.6.gb485710b


