Return-Path: <netdev+bounces-63708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0682EF8B
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 14:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9300DB223D3
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8CA1BDC2;
	Tue, 16 Jan 2024 13:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A211BC35
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W-mBUUS_1705410696;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W-mBUUS_1705410696)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 21:11:37 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next 2/3] virtio-net: batch dim request
Date: Tue, 16 Jan 2024 21:11:32 +0800
Message-Id: <1705410693-118895-3-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Currently, when each time the driver attempts to update the coalescing
parameters for a vq, it needs to kick the device.
The following path is observed:
  1. Driver kicks the device;
  2. After the device receives the kick, CPU scheduling occurs and DMA
     multiple buffers multiple times;
  3. The device completes processing and replies with a response.

When large-queue devices issue multiple requests and kick the device
frequently, this often interrupt the work of the device-side CPU.
In addition, each vq request is processed separately, causing more
delays for the CPU to wait for the DMA request to complete.

These interruptions and overhead will strain the CPU responsible for
controlling the path of the DPU, especially in multi-device and
large-queue scenarios.

To solve the above problems, we internally tried batch request,
which merges requests from multiple queues and sends them at once.
We conservatively tested 8 queue commands and sent them together.
The DPU processing efficiency can be improved by 8 times, which
greatly eases the DPU's support for multi-device and multi-queue DIM.

Suggested-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c        | 54 ++++++++++++++++++++++++++++++++---------
 include/uapi/linux/virtio_net.h |  1 +
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f6ac3e7..e4305ad 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -133,6 +133,11 @@ struct virtnet_interrupt_coalesce {
 	u32 max_usecs;
 };
 
+struct virtnet_batch_coal {
+	__le32 num_entries;
+	struct virtio_net_ctrl_coal_vq coal_vqs[];
+};
+
 /* The dma information of pages allocated at a time. */
 struct virtnet_rq_dma {
 	dma_addr_t addr;
@@ -321,6 +326,7 @@ struct virtnet_info {
 	bool rx_dim_enabled;
 
 	/* Interrupt coalescing settings */
+	struct virtnet_batch_coal *batch_coal;
 	struct virtnet_interrupt_coalesce intr_coal_tx;
 	struct virtnet_interrupt_coalesce intr_coal_rx;
 
@@ -3520,9 +3526,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct receive_queue *rq = container_of(dim,
 			struct receive_queue, dim);
 	struct virtnet_info *vi = rq->vq->vdev->priv;
-	struct net_device *dev = vi->dev;
 	struct dim_cq_moder update_moder;
-	int i, qnum, err;
+	struct virtnet_batch_coal *coal = vi->batch_coal;
+	struct scatterlist sgs;
+	int i, j = 0;
 
 	if (!rtnl_trylock()) {
 		schedule_work(&dim->work);
@@ -3538,7 +3545,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		rq = &vi->rq[i];
 		dim = &rq->dim;
-		qnum = rq - vi->rq;
 
 		if (!rq->dim_enabled)
 			continue;
@@ -3546,16 +3552,32 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 		if (update_moder.usec != rq->intr_coal.max_usecs ||
 		    update_moder.pkts != rq->intr_coal.max_packets) {
-			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
-							       update_moder.usec,
-							       update_moder.pkts);
-			if (err)
-				pr_debug("%s: Failed to send dim parameters on rxq%d\n",
-					 dev->name, qnum);
-			dim->state = DIM_START_MEASURE;
+			coal->coal_vqs[j].vqn = cpu_to_le16(rxq2vq(i));
+			coal->coal_vqs[j].coal.max_usecs = cpu_to_le32(update_moder.usec);
+			coal->coal_vqs[j].coal.max_packets = cpu_to_le32(update_moder.pkts);
+			rq->intr_coal.max_usecs = update_moder.usec;
+			rq->intr_coal.max_packets = update_moder.pkts;
+			j++;
 		}
 	}
 
+	if (!j)
+		goto ret;
+
+	coal->num_entries = cpu_to_le32(j);
+	sg_init_one(&sgs, coal, sizeof(struct virtnet_batch_coal) +
+		    j * sizeof(struct virtio_net_ctrl_coal_vq));
+	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
+				  VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET,
+				  &sgs))
+		dev_warn(&vi->vdev->dev, "Failed to add dim command\n.");
+
+	for (i = 0; i < j; i++) {
+		rq = &vi->rq[(coal->coal_vqs[i].vqn) / 2];
+		rq->dim.state = DIM_START_MEASURE;
+	}
+
+ret:
 	rtnl_unlock();
 }
 
@@ -4380,7 +4402,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 static int virtnet_alloc_queues(struct virtnet_info *vi)
 {
-	int i;
+	int i, len;
 
 	if (vi->has_cvq) {
 		vi->ctrl = kzalloc(sizeof(*vi->ctrl), GFP_KERNEL);
@@ -4396,6 +4418,12 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	if (!vi->rq)
 		goto err_rq;
 
+	len = sizeof(struct virtnet_batch_coal) +
+	      vi->max_queue_pairs * sizeof(struct virtio_net_ctrl_coal_vq);
+	vi->batch_coal = kzalloc(len, GFP_KERNEL);
+	if (!vi->batch_coal)
+		goto err_coal;
+
 	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
@@ -4418,6 +4446,8 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 
 	return 0;
 
+err_coal:
+	kfree(vi->rq);
 err_rq:
 	kfree(vi->sq);
 err_sq:
@@ -4902,6 +4932,8 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	net_failover_destroy(vi->failover);
 
+	kfree(vi->batch_coal);
+
 	remove_vq_common(vi);
 
 	free_netdev(vi->dev);
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index cc65ef0..df6d112 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -394,6 +394,7 @@ struct virtio_net_ctrl_coal_rx {
 #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET		1
 #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET		2
 #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET		3
+#define VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET		4
 
 struct virtio_net_ctrl_coal {
 	__le32 max_packets;
-- 
1.8.3.1


