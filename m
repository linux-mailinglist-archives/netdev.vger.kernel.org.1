Return-Path: <netdev+bounces-91303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D398B221F
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 14:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F4DB24F7D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17B149C56;
	Thu, 25 Apr 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oSFiUltY"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AB149C4C
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049946; cv=none; b=l+27D0f/4baIunnCmrYp/LLKRTLqxIilgdqtZ88EmUcOkGxwLKCYtLki1uDph7SO3ivEn6gK0qGo9yn2UrVvrBNrEXg1R3M8xJZeACwawY2S91fFl8z6Tw9oYZi936OrZ34RhmlCkXYNBUm4XHbx4qNsfVUl2H/4FuXUe26sUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049946; c=relaxed/simple;
	bh=8BXeENDikJx2/yejgt+yDxMyJRSJMe9xVX73YK02RfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AB8kes3YG4A0heNHISamEoibe2kKa6Map1h0wiyU8nWJFPbxNSeZLFScMFH8p0spVyUUn1U27BrlLVWLVPU/iVFg1+/mdr+3CYzwtOsMftDYRjkOgZCHyrZv6GvPlpLJz4e4xfxpIkVKcod9ozwnzL5K1tScoxXbx5XDQd+c++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oSFiUltY; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714049941; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1QNj3svvlNE4SI3QLwbE5brlaVr7j0KcHKFTkGq4w/I=;
	b=oSFiUltYME8kG2KwwsbET6rPU0w/vQcgQPsSuKUawKKq/wzEKfSISG3EOzsKkOMlhY/EfUnCFdah8xwmAY+rhzU2NTDl/y4cJXvgmgFGqwICjKOzci0cwgvy5Jr1LT9vzsNmQefiulKqlafUJtNas1+nKKKGe1T+hOyw1e+WQQc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5FZmSN_1714049939;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5FZmSN_1714049939)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 20:59:00 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/3] virtio_net: improve dim command request efficiency
Date: Thu, 25 Apr 2024 20:58:55 +0800
Message-Id: <20240425125855.87025-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240425125855.87025-1-hengqi@linux.alibaba.com>
References: <20240425125855.87025-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, ctrlq processes commands in a synchronous manner,
which increases the delay of dim commands when configuring
multi-queue VMs, which in turn causes the CPU utilization to
increase and interferes with the performance of dim.

Therefore we asynchronously process ctlq's dim commands.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 229 +++++++++++++++++++++++++++++++++++----
 1 file changed, 209 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8f05bcf1d37d..6cd72c0119e6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -138,6 +138,14 @@ struct virtnet_interrupt_coalesce {
 	u32 max_usecs;
 };
 
+struct virtnet_coal_node {
+	struct virtio_net_ctrl_hdr hdr;
+	virtio_net_ctrl_ack status;
+	struct virtio_net_ctrl_coal_vq coal_vqs;
+	bool is_wait;
+	struct list_head list;
+};
+
 /* The dma information of pages allocated at a time. */
 struct virtnet_rq_dma {
 	dma_addr_t addr;
@@ -337,6 +345,14 @@ struct virtnet_info {
 	struct virtnet_interrupt_coalesce intr_coal_tx;
 	struct virtnet_interrupt_coalesce intr_coal_rx;
 
+	/* Free nodes used for concurrent delivery */
+	struct mutex coal_free_lock;
+	struct list_head coal_free_list;
+
+	/* Filled when there are no free nodes or cvq buffers */
+	struct mutex coal_wait_lock;
+	struct list_head coal_wait_list;
+
 	unsigned long guest_offloads;
 	unsigned long guest_offloads_capable;
 
@@ -2049,17 +2065,108 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 	return !oom;
 }
 
+static void __virtnet_add_dim_command(struct virtnet_info *vi,
+				      struct virtnet_coal_node *ctrl)
+{
+	struct scatterlist *sgs[4], hdr, stat, out;
+	unsigned int out_num = 0;
+	int ret;
+
+	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
+
+	ctrl->hdr.class = VIRTIO_NET_CTRL_NOTF_COAL;
+	ctrl->hdr.cmd = VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET;
+
+	sg_init_one(&hdr, &ctrl->hdr, sizeof(ctrl->hdr));
+	sgs[out_num++] = &hdr;
+
+	sg_init_one(&out, &ctrl->coal_vqs, sizeof(ctrl->coal_vqs));
+	sgs[out_num++] = &out;
+
+	ctrl->status = VIRTIO_NET_OK;
+	sg_init_one(&stat, &ctrl->status, sizeof(ctrl->status));
+	sgs[out_num] = &stat;
+
+	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
+	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, ctrl, GFP_ATOMIC);
+	if (ret < 0) {
+		dev_warn(&vi->vdev->dev, "Failed to add sgs for command vq: %d\n.", ret);
+		return;
+	}
+
+	virtqueue_kick(vi->cvq);
+}
+
+static void virtnet_add_dim_command(struct virtnet_info *vi,
+				    struct virtnet_coal_node *ctrl)
+{
+	mutex_lock(&vi->cvq_lock);
+	__virtnet_add_dim_command(vi, ctrl);
+	mutex_unlock(&vi->cvq_lock);
+}
+
+static void virtnet_process_dim_cmd(struct virtnet_info *vi, void *res)
+{
+	struct virtnet_coal_node *node;
+	u16 qnum;
+
+	node = (struct virtnet_coal_node *)res;
+	qnum = le16_to_cpu(node->coal_vqs.vqn) / 2;
+
+	mutex_lock(&vi->rq[qnum].dim_lock);
+	vi->rq[qnum].intr_coal.max_usecs =
+		le32_to_cpu(node->coal_vqs.coal.max_usecs);
+	vi->rq[qnum].intr_coal.max_packets =
+		le32_to_cpu(node->coal_vqs.coal.max_packets);
+	vi->rq[qnum].dim.state = DIM_START_MEASURE;
+	mutex_unlock(&vi->rq[qnum].dim_lock);
+
+	if (!node->is_wait) {
+		mutex_lock(&vi->coal_free_lock);
+		list_add(&node->list, &vi->coal_free_list);
+		mutex_unlock(&vi->coal_free_lock);
+	} else {
+		kfree(node);
+	}
+}
+
 static void virtnet_get_cvq_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
 		container_of(work, struct virtnet_info, get_cvq);
+	struct virtnet_coal_node *wait_coal;
+	bool valid = false;
 	unsigned int tmp;
 	void *res;
 
 	mutex_lock(&vi->cvq_lock);
-	res = virtqueue_get_buf(vi->cvq, &tmp);
-	if (res)
-		complete(&vi->completion);
+	while ((res = virtqueue_get_buf(vi->cvq, &tmp)) != NULL) {
+		if (res == ((void *)vi))
+			complete(&vi->completion);
+		else
+			virtnet_process_dim_cmd(vi, res);
+
+		valid = true;
+	}
+
+	if (!valid) {
+		mutex_unlock(&vi->cvq_lock);
+		return;
+	}
+
+	mutex_lock(&vi->coal_wait_lock);
+	while (!list_empty(&vi->coal_wait_list)) {
+		if (vi->cvq->num_free < 3)
+			goto out_get_cvq;
+
+		wait_coal = list_first_entry(&vi->coal_wait_list,
+					     struct virtnet_coal_node, list);
+		list_del(&wait_coal->list);
+		__virtnet_add_dim_command(vi, wait_coal);
+	}
+
+out_get_cvq:
+	mutex_unlock(&vi->coal_wait_lock);
 	mutex_unlock(&vi->cvq_lock);
 }
 
@@ -3625,35 +3732,73 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
+static void virtnet_put_wait_coal(struct virtnet_info *vi,
+				  struct receive_queue *rq,
+				  struct dim_cq_moder moder)
+{
+	struct virtnet_coal_node *wait_node;
+
+	wait_node = kzalloc(sizeof(*wait_node), GFP_KERNEL);
+	if (!wait_node) {
+		rq->dim.state = DIM_START_MEASURE;
+		return;
+	}
+
+	wait_node->is_wait = true;
+	wait_node->coal_vqs.vqn = cpu_to_le16(rxq2vq(rq - vi->rq));
+	wait_node->coal_vqs.coal.max_usecs = cpu_to_le32(moder.usec);
+	wait_node->coal_vqs.coal.max_packets = cpu_to_le32(moder.pkts);
+	mutex_lock(&vi->coal_wait_lock);
+	list_add_tail(&wait_node->list, &vi->coal_wait_list);
+	mutex_unlock(&vi->coal_wait_lock);
+}
+
 static void virtnet_rx_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
 	struct receive_queue *rq = container_of(dim,
 			struct receive_queue, dim);
 	struct virtnet_info *vi = rq->vq->vdev->priv;
-	struct net_device *dev = vi->dev;
+	struct virtnet_coal_node *avail_coal;
 	struct dim_cq_moder update_moder;
-	int qnum, err;
 
-	qnum = rq - vi->rq;
+	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 
 	mutex_lock(&rq->dim_lock);
-	if (!rq->dim_enabled)
-		goto out;
-
-	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
-	if (update_moder.usec != rq->intr_coal.max_usecs ||
-	    update_moder.pkts != rq->intr_coal.max_packets) {
-		err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
-						       update_moder.usec,
-						       update_moder.pkts);
-		if (err)
-			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
-				 dev->name, qnum);
+	if (!rq->dim_enabled ||
+	    (update_moder.usec == rq->intr_coal.max_usecs &&
+	     update_moder.pkts == rq->intr_coal.max_packets)) {
+		rq->dim.state = DIM_START_MEASURE;
+		mutex_unlock(&rq->dim_lock);
+		return;
 	}
-out:
-	dim->state = DIM_START_MEASURE;
 	mutex_unlock(&rq->dim_lock);
+
+	mutex_lock(&vi->cvq_lock);
+	if (vi->cvq->num_free < 3) {
+		virtnet_put_wait_coal(vi, rq, update_moder);
+		mutex_unlock(&vi->cvq_lock);
+		return;
+	}
+	mutex_unlock(&vi->cvq_lock);
+
+	mutex_lock(&vi->coal_free_lock);
+	if (list_empty(&vi->coal_free_list)) {
+		virtnet_put_wait_coal(vi, rq, update_moder);
+		mutex_unlock(&vi->coal_free_lock);
+		return;
+	}
+
+	avail_coal = list_first_entry(&vi->coal_free_list,
+				      struct virtnet_coal_node, list);
+	avail_coal->coal_vqs.vqn = cpu_to_le16(rxq2vq(rq - vi->rq));
+	avail_coal->coal_vqs.coal.max_usecs = cpu_to_le32(update_moder.usec);
+	avail_coal->coal_vqs.coal.max_packets = cpu_to_le32(update_moder.pkts);
+
+	list_del(&avail_coal->list);
+	mutex_unlock(&vi->coal_free_lock);
+
+	virtnet_add_dim_command(vi, avail_coal);
 }
 
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
@@ -4748,6 +4893,45 @@ static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
 	.xmo_rx_hash			= virtnet_xdp_rx_hash,
 };
 
+static void virtnet_del_coal_free_list(struct virtnet_info *vi)
+{
+	struct virtnet_coal_node *coal_node, *tmp;
+
+	list_for_each_entry_safe(coal_node, tmp,  &vi->coal_free_list, list) {
+		list_del(&coal_node->list);
+		kfree(coal_node);
+	}
+}
+
+static int virtnet_init_coal_list(struct virtnet_info *vi)
+{
+	struct virtnet_coal_node *coal_node;
+	int batch_dim_nums;
+	int i;
+
+	INIT_LIST_HEAD(&vi->coal_free_list);
+	mutex_init(&vi->coal_free_lock);
+
+	INIT_LIST_HEAD(&vi->coal_wait_list);
+	mutex_init(&vi->coal_wait_lock);
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return 0;
+
+	batch_dim_nums = min((unsigned int)vi->max_queue_pairs,
+			     virtqueue_get_vring_size(vi->cvq) / 3);
+	for (i = 0; i < batch_dim_nums; i++) {
+		coal_node = kzalloc(sizeof(*coal_node), GFP_KERNEL);
+		if (!coal_node) {
+			virtnet_del_coal_free_list(vi);
+			return -ENOMEM;
+		}
+		list_add(&coal_node->list, &vi->coal_free_list);
+	}
+
+	return 0;
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -4932,6 +5116,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (err)
 		goto free;
 
+	if (virtnet_init_coal_list(vi))
+		goto free;
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
 		vi->intr_coal_rx.max_usecs = 0;
 		vi->intr_coal_tx.max_usecs = 0;
@@ -5081,6 +5268,8 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	net_failover_destroy(vi->failover);
 
+	virtnet_del_coal_free_list(vi);
+
 	remove_vq_common(vi);
 
 	free_netdev(vi->dev);
-- 
2.32.0.3.g01195cf9f


