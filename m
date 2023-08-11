Return-Path: <netdev+bounces-26646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5787787B9
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5EE1C21423
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDAB5230;
	Fri, 11 Aug 2023 06:55:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D741872
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:55:27 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E702127
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:55:25 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VpWEtDE_1691736920;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VpWEtDE_1691736920)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 14:55:21 +0800
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
Subject: [PATCH net-next 6/8] virtio-net: support rx netdim
Date: Fri, 11 Aug 2023 14:55:10 +0800
Message-Id: <20230811065512.22190-7-hengqi@linux.alibaba.com>
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

By comparing the traffic information in the complete napi processes,
let the virtio-net driver automatically adjust the coalescing
moderation parameters of each receive queue.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 124 +++++++++++++++++++++++++++++++++------
 1 file changed, 106 insertions(+), 18 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0318113bd8c2..3fb801a7a785 100644
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
@@ -168,8 +169,17 @@ struct receive_queue {
 
 	struct virtnet_rq_stats stats;
 
+	/* The number of rx notifications */
+	u16 calls;
+
+	/* Is dynamic interrupt moderation enabled? */
+	bool dim_enabled;
+
 	struct virtnet_interrupt_coalesce intr_coal;
 
+	/* Dynamic Iterrupt Moderation */
+	struct dim dim;
+
 	/* Chain pages by the private ptr. */
 	struct page *pages;
 
@@ -1927,6 +1937,7 @@ static void skb_recv_done(struct virtqueue *rvq)
 	struct virtnet_info *vi = rvq->vdev->priv;
 	struct receive_queue *rq = &vi->rq[vq2rxq(rvq)];
 
+	rq->calls++;
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
@@ -2064,6 +2075,21 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	}
 }
 
+static void virtnet_rx_dim_work(struct work_struct *work);
+
+static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
+{
+	struct virtnet_rq_stats *stats = &rq->stats;
+	struct dim_sample cur_sample = {};
+
+	u64_stats_update_begin(&rq->stats.syncp);
+	dim_update_sample(rq->calls, stats->packets,
+			  stats->bytes, &cur_sample);
+	u64_stats_update_end(&rq->stats.syncp);
+
+	net_dim(&rq->dim, cur_sample);
+}
+
 static int virtnet_poll(struct napi_struct *napi, int budget)
 {
 	struct receive_queue *rq =
@@ -2072,6 +2098,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	struct send_queue *sq;
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
+	bool napi_complete;
 
 	virtnet_poll_cleantx(rq);
 
@@ -2081,8 +2108,11 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
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
@@ -2102,6 +2132,7 @@ static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
 	napi_disable(&vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
+	cancel_work_sync(&vi->rq[qp_index].dim.work);
 }
 
 static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
@@ -2119,6 +2150,9 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
+	INIT_WORK(&vi->rq[qp_index].dim.work, virtnet_rx_dim_work);
+	vi->rq[qp_index].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
 
@@ -3183,20 +3217,37 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
 	struct scatterlist sgs_rx;
+	int i;
 
-	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
-	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
-	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
-
-	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
-				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-				  &sgs_rx))
+	if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != vi->intr_coal_rx.max_usecs ||
+			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
 		return -EINVAL;
 
-	/* Save parameters */
-	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
-	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
+	if (rx_ctrl_dim_on) {
+		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+			for (i = 0; i < vi->max_queue_pairs; i++)
+				vi->rq[i].dim_enabled = true;
+		else
+			return -EOPNOTSUPP;
+	} else {
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			vi->rq[i].dim_enabled = false;
+
+		vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
+		vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
+		sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
+
+		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
+					  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
+					  &sgs_rx))
+			return -EINVAL;
+
+		/* Save parameters */
+		vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
+		vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
+	}
 
 	return 0;
 }
@@ -3275,14 +3326,28 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec,
 					  u16 queue)
 {
+	bool rx_ctrl_dim_on;
+	u32 max_usecs, max_packets;
 	int err;
 
 	if (ec->rx_coalesce_usecs || ec->rx_max_coalesced_frames) {
-		err = virtnet_send_rx_notf_coal_vq_cmd(vi, queue,
-						       ec->rx_coalesce_usecs,
-						       ec->rx_max_coalesced_frames);
-		if (err)
-			return err;
+		rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
+		max_usecs = vi->rq[queue].intr_coal.max_usecs;
+		max_packets = vi->rq[queue].intr_coal.max_packets;
+		if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != max_usecs ||
+				       ec->rx_max_coalesced_frames != max_packets))
+			return -EINVAL;
+
+		if (rx_ctrl_dim_on) {
+			vi->rq[queue].dim_enabled = true;
+		} else {
+			vi->rq[queue].dim_enabled = false;
+			err = virtnet_send_rx_notf_coal_vq_cmd(vi, queue,
+							       ec->rx_coalesce_usecs,
+							       ec->rx_max_coalesced_frames);
+			if (err)
+				return err;
+		}
 	}
 
 	if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
@@ -3296,6 +3361,27 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
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
+	err = virtnet_send_rx_notf_coal_vq_cmd(vi, qnum,
+					       update_moder.usec,
+					       update_moder.pkts);
+	if (err)
+		pr_debug("%s: Failed to send dim parameters on rxq%d\n",
+			 dev->name, (int)(rq - vi->rq));
+
+	dim->state = DIM_START_MEASURE;
+}
+
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
 {
 	/* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
@@ -3377,6 +3463,7 @@ static int virtnet_get_coalesce(struct net_device *dev,
 		ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
 		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
 		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
+		ec->use_adaptive_rx_coalesce = vi->rq[0].dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3434,6 +3521,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
+		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3559,7 +3647,7 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
-- 
2.19.1.6.gb485710b


