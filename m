Return-Path: <netdev+bounces-40259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03697C669F
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05CC1C20FA4
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3012710949;
	Thu, 12 Oct 2023 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F715EAE
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 07:44:21 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9FAC4
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:44:19 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VtzkV7J_1697096654;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VtzkV7J_1697096654)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 15:44:15 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"Liu, Yujie" <yujie.liu@intel.com>
Subject: [PATCH net-next 4/5] virtio-net: support rx netdim
Date: Thu, 12 Oct 2023 15:44:08 +0800
Message-Id: <b4656b1a14fea432bf8493a7e2f1976c08f2e63c.1697093455.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1697093455.git.hengqi@linux.alibaba.com>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

By comparing the traffic information in the complete napi processes,
let the virtio-net driver automatically adjust the coalescing
moderation parameters of each receive queue.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 147 +++++++++++++++++++++++++++++++++------
 1 file changed, 126 insertions(+), 21 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index caef78bb3963..6ad2890a7909 100644
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
 
@@ -2138,6 +2154,25 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	}
 }
 
+static void virtnet_rx_dim_work(struct work_struct *work);
+
+static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
+{
+	struct virtnet_rq_stats *stats = &rq->stats;
+	struct dim_sample cur_sample = {};
+
+	if (!rq->packets_in_napi)
+		return;
+
+	u64_stats_update_begin(&rq->stats.syncp);
+	dim_update_sample(rq->calls, stats->packets,
+			  stats->bytes, &cur_sample);
+	u64_stats_update_end(&rq->stats.syncp);
+
+	net_dim(&rq->dim, cur_sample);
+	rq->packets_in_napi = 0;
+}
+
 static int virtnet_poll(struct napi_struct *napi, int budget)
 {
 	struct receive_queue *rq =
@@ -2146,17 +2181,22 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
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
@@ -2176,6 +2216,7 @@ static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
 	napi_disable(&vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
+	cancel_work_sync(&vi->rq[qp_index].dim.work);
 }
 
 static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
@@ -2193,6 +2234,9 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
+	INIT_WORK(&vi->rq[qp_index].dim.work, virtnet_rx_dim_work);
+	vi->rq[qp_index].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
 
@@ -3335,23 +3379,42 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
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
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
-		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+	if (rx_ctrl_dim_on) {
+		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+			vi->rx_dim_enabled = true;
+			for (i = 0; i < vi->max_queue_pairs; i++)
+				vi->rq[i].dim_enabled = true;
+		} else {
+			return -EOPNOTSUPP;
+		}
+	} else {
+		vi->rx_dim_enabled = false;
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
+		vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
+		vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
+			vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+		}
 	}
 
 	return 0;
@@ -3377,13 +3440,27 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec,
 					  u16 queue)
 {
+	bool rx_ctrl_dim_on;
+	u32 max_usecs, max_packets;
 	int err;
 
-	err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
-					       ec->rx_coalesce_usecs,
-					       ec->rx_max_coalesced_frames);
-	if (err)
-		return err;
+	rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
+	max_usecs = vi->rq[queue].intr_coal.max_usecs;
+	max_packets = vi->rq[queue].intr_coal.max_packets;
+	if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != max_usecs ||
+			       ec->rx_max_coalesced_frames != max_packets))
+		return -EINVAL;
+
+	if (rx_ctrl_dim_on) {
+		vi->rq[queue].dim_enabled = true;
+	} else {
+		vi->rq[queue].dim_enabled = false;
+		err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
+						       ec->rx_coalesce_usecs,
+						       ec->rx_max_coalesced_frames);
+		if (err)
+			return err;
+	}
 
 	err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
 					       ec->tx_coalesce_usecs,
@@ -3394,6 +3471,32 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
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
@@ -3475,6 +3578,7 @@ static int virtnet_get_coalesce(struct net_device *dev,
 		ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
 		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
 		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
+		ec->use_adaptive_rx_coalesce = vi->rx_dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3532,6 +3636,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
+		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3657,7 +3762,7 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
-- 
2.19.1.6.gb485710b


