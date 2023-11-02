Return-Path: <netdev+bounces-45726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 876797DF345
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 14:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285ABB211DE
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7BC18E31;
	Thu,  2 Nov 2023 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9B79D2
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 13:09:47 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF901112
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 06:09:45 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VvWBy8A_1698930579;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VvWBy8A_1698930579)
          by smtp.aliyun-inc.com;
          Thu, 02 Nov 2023 21:09:39 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Liu, Yujie" <yujie.liu@intel.com>
Subject: [PATCH net-next v2 4/5] virtio-net: support rx netdim
Date: Thu,  2 Nov 2023 21:09:32 +0800
Message-Id: <12c77098b73313eea8fdc88a3d1d20611444827d.1698929590.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1698929590.git.hengqi@linux.alibaba.com>
References: <cover.1698929590.git.hengqi@linux.alibaba.com>
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
v1->v2:
- Improved the judgment of dim switch conditions.
- Fix the safe problem of work thread.

 drivers/net/virtio_net.c | 187 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 165 insertions(+), 22 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 69fe09e99b3c..5473aa1ee5cd 100644
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
 
@@ -2141,6 +2157,26 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
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
@@ -2149,17 +2185,22 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
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
@@ -2179,6 +2220,7 @@ static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
 	napi_disable(&vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
+	cancel_work_sync(&vi->rq[qp_index].dim.work);
 }
 
 static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
@@ -2196,6 +2238,9 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
+	INIT_WORK(&vi->rq[qp_index].dim.work, virtnet_rx_dim_work);
+	vi->rq[qp_index].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
 
@@ -2393,8 +2438,10 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	qindex = rq - vi->rq;
 
-	if (running)
+	if (running) {
 		napi_disable(&rq->napi);
+		cancel_work_sync(&rq->dim.work);
+	}
 
 	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
 	if (err)
@@ -2403,8 +2450,10 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	if (!try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_delayed_work(&vi->refill, 0);
 
-	if (running)
+	if (running) {
+		INIT_WORK(&rq->dim.work, virtnet_rx_dim_work);
 		virtnet_napi_enable(rq->vq, &rq->napi);
+	}
 	return err;
 }
 
@@ -3341,24 +3390,51 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
 	struct scatterlist sgs_rx;
+	bool switch_dim, update;
 	int i;
 
-	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
-	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
-	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
-
-	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
-				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-				  &sgs_rx))
-		return -EINVAL;
+	switch_dim = rx_ctrl_dim_on != vi->rx_dim_enabled;
+	if (switch_dim) {
+		if (rx_ctrl_dim_on) {
+			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+				vi->rx_dim_enabled = true;
+				for (i = 0; i < vi->max_queue_pairs; i++)
+					vi->rq[i].dim_enabled = true;
+			} else {
+				return -EOPNOTSUPP;
+			}
+		} else {
+			vi->rx_dim_enabled = false;
+			for (i = 0; i < vi->max_queue_pairs; i++)
+				vi->rq[i].dim_enabled = false;
+		}
+	} else {
+		if (ec->rx_coalesce_usecs != vi->intr_coal_rx.max_usecs ||
+		    ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets)
+			update = true;
 
-	/* Save parameters */
-	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
-	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
-		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+		if (vi->rx_dim_enabled) {
+			if (update)
+				return -EINVAL;
+		} else {
+			vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
+			vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
+			sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
+
+			if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
+						  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
+						  &sgs_rx))
+				return -EINVAL;
+
+			vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
+			vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
+			for (i = 0; i < vi->max_queue_pairs; i++) {
+				vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
+				vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+			}
+		}
 	}
 
 	return 0;
@@ -3380,15 +3456,54 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
+static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
+					     struct ethtool_coalesce *ec,
+					     u16 queue)
+{
+	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
+	bool cur_rx_dim = vi->rq[queue].dim_enabled;
+	u32 max_usecs, max_packets;
+	bool switch_dim, update;
+	int err;
+
+	switch_dim = rx_ctrl_dim_on != cur_rx_dim;
+	if (switch_dim) {
+		if (rx_ctrl_dim_on)
+			vi->rq[queue].dim_enabled = true;
+		else
+			vi->rq[queue].dim_enabled = false;
+	} else {
+		max_usecs = vi->rq[queue].intr_coal.max_usecs;
+		max_packets = vi->rq[queue].intr_coal.max_packets;
+		if (ec->rx_coalesce_usecs != max_usecs ||
+		    ec->rx_max_coalesced_frames != max_packets)
+			update = true;
+
+		if (cur_rx_dim) {
+			if (update)
+				return -EINVAL;
+		} else {
+			if (!update)
+				return 0;
+
+			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
+							       ec->rx_coalesce_usecs,
+							       ec->rx_max_coalesced_frames);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec,
 					  u16 queue)
 {
 	int err;
 
-	err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
-					       ec->rx_coalesce_usecs,
-					       ec->rx_max_coalesced_frames);
+	err = virtnet_send_rx_notf_coal_vq_cmds(vi, ec, queue);
 	if (err)
 		return err;
 
@@ -3401,6 +3516,32 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
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
+	if (update_moder.usec != vi->rq[qnum].intr_coal.max_usecs ||
+	    update_moder.pkts != vi->rq[qnum].intr_coal.max_packets) {
+		rtnl_lock();
+		err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
+						       update_moder.usec,
+						       update_moder.pkts);
+		if (err)
+			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
+				 dev->name, (int)(rq - vi->rq));
+		rtnl_unlock();
+	}
+
+	dim->state = DIM_START_MEASURE;
+}
+
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
 {
 	/* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
@@ -3482,6 +3623,7 @@ static int virtnet_get_coalesce(struct net_device *dev,
 		ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
 		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
 		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
+		ec->use_adaptive_rx_coalesce = vi->rx_dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3539,6 +3681,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
+		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3664,7 +3807,7 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
-- 
2.19.1.6.gb485710b


