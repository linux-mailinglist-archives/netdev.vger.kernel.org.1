Return-Path: <netdev+bounces-55841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7480C6C1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CB4281732
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FED2D612;
	Mon, 11 Dec 2023 10:36:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B493D6
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 02:36:15 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyFoSVN_1702290972;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VyFoSVN_1702290972)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 18:36:13 +0800
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
Subject: [PATCH net-next v8 4/4] virtio-net: support rx netdim
Date: Mon, 11 Dec 2023 18:36:07 +0800
Message-Id: <7088f3a6ec9ca8d71a43ad93e14698c9bf4933bf.1702275514.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1702275514.git.hengqi@linux.alibaba.com>
References: <cover.1702275514.git.hengqi@linux.alibaba.com>
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
v7->v8:
- Add select DIMLIB

v6->v7:
- Drop the patch titled "spin lock for ctrl cmd access"
- Use rtnl_trylock to avoid the deadlock.

v5->v6:
- Use spin lock and cancel_work_sync to synchronize

v4->v5:
- Fix possible synchronization issues using cancel_work().
- Reduce if/else nesting levels

v2->v3:
- Some minor modifications.

v1->v2:
- Improved the judgment of dim switch conditions.
- Cancel the work when vq reset.

 drivers/net/Kconfig      |   1 +
 drivers/net/virtio_net.c | 176 +++++++++++++++++++++++++++++++++++----
 2 files changed, 163 insertions(+), 14 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index af0da4bb429b..8ca0bc223b30 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -434,6 +434,7 @@ config VIRTIO_NET
 	tristate "Virtio network driver"
 	depends on VIRTIO
 	select NET_FAILOVER
+	select DIMLIB
 	help
 	  This is the virtual network driver for virtio.  It can be used with
 	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 69fe09e99b3c..10614e9f7cad 100644
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
@@ -305,6 +317,9 @@ struct virtnet_info {
 	u8 duplex;
 	u32 speed;
 
+	/* Is rx dynamic interrupt moderation enabled? */
+	bool rx_dim_enabled;
+
 	/* Interrupt coalescing settings */
 	struct virtnet_interrupt_coalesce intr_coal_tx;
 	struct virtnet_interrupt_coalesce intr_coal_rx;
@@ -2001,6 +2016,7 @@ static void skb_recv_done(struct virtqueue *rvq)
 	struct virtnet_info *vi = rvq->vdev->priv;
 	struct receive_queue *rq = &vi->rq[vq2rxq(rvq)];
 
+	rq->calls++;
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
@@ -2141,6 +2157,24 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	}
 }
 
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
@@ -2149,17 +2183,22 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
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
@@ -2230,8 +2269,11 @@ static int virtnet_open(struct net_device *dev)
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
 
@@ -2393,8 +2435,10 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	qindex = rq - vi->rq;
 
-	if (running)
+	if (running) {
 		napi_disable(&rq->napi);
+		cancel_work_sync(&rq->dim.work);
+	}
 
 	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
 	if (err)
@@ -2641,8 +2685,10 @@ static int virtnet_close(struct net_device *dev)
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
 
-	for (i = 0; i < vi->max_queue_pairs; i++)
+	for (i = 0; i < vi->max_queue_pairs; i++) {
 		virtnet_disable_queue_pair(vi, i);
+		cancel_work_sync(&vi->rq[i].dim.work);
+	}
 
 	return 0;
 }
@@ -2914,9 +2960,6 @@ static void virtnet_get_ringparam(struct net_device *dev,
 	ring->tx_pending = virtqueue_get_vring_size(vi->sq[0].vq);
 }
 
-static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
-					 u16 vqn, u32 max_usecs, u32 max_packets);
-
 static int virtnet_set_ringparam(struct net_device *dev,
 				 struct ethtool_ringparam *ring,
 				 struct kernel_ethtool_ringparam *kernel_ring,
@@ -3327,7 +3370,6 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 				  &sgs_tx))
 		return -EINVAL;
 
-	/* Save parameters */
 	vi->intr_coal_tx.max_usecs = ec->tx_coalesce_usecs;
 	vi->intr_coal_tx.max_packets = ec->tx_max_coalesced_frames;
 	for (i = 0; i < vi->max_queue_pairs; i++) {
@@ -3341,9 +3383,34 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
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
 	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
 	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
 	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
@@ -3353,7 +3420,6 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 				  &sgs_rx))
 		return -EINVAL;
 
-	/* Save parameters */
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
 	for (i = 0; i < vi->max_queue_pairs; i++) {
@@ -3380,18 +3446,52 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
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
 
+	max_usecs = vi->rq[queue].intr_coal.max_usecs;
+	max_packets = vi->rq[queue].intr_coal.max_packets;
+
+	if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != max_usecs ||
+			       ec->rx_max_coalesced_frames != max_packets))
+		return -EINVAL;
+
+	if (rx_ctrl_dim_on && !cur_rx_dim) {
+		vi->rq[queue].dim_enabled = true;
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
 	if (err)
 		return err;
 
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
+		return err;
+
 	err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
 					       ec->tx_coalesce_usecs,
 					       ec->tx_max_coalesced_frames);
@@ -3401,6 +3501,49 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
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
+	int i, qnum, err;
+
+	if (!rtnl_trylock())
+		return;
+
+	/* Each rxq's work is queued by "net_dim()->schedule_work()"
+	 * in response to NAPI traffic changes. Note that dim->profile_ix
+	 * for each rxq is updated prior to the queuing action.
+	 * So we only need to traverse and update profiles for all rxqs
+	 * in the work which is holding rtnl_lock.
+	 */
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		rq = &vi->rq[i];
+		dim = &rq->dim;
+		qnum = rq - vi->rq;
+
+		if (!rq->dim_enabled)
+			continue;
+
+		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+		if (update_moder.usec != rq->intr_coal.max_usecs ||
+		    update_moder.pkts != rq->intr_coal.max_packets) {
+			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
+							       update_moder.usec,
+							       update_moder.pkts);
+			if (err)
+				pr_debug("%s: Failed to send dim parameters on rxq%d\n",
+					 dev->name, qnum);
+			dim->state = DIM_START_MEASURE;
+		}
+	}
+
+	rtnl_unlock();
+}
+
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
 {
 	/* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
@@ -3482,6 +3625,7 @@ static int virtnet_get_coalesce(struct net_device *dev,
 		ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
 		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
 		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
+		ec->use_adaptive_rx_coalesce = vi->rx_dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3539,6 +3683,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
+		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3664,7 +3809,7 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
@@ -4254,6 +4399,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
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


