Return-Path: <netdev+bounces-101058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ADA8FD141
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0362855C5
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3B03BBD7;
	Wed,  5 Jun 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s+pwaD+z"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7228DDF
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599348; cv=none; b=OR+3nsQxUoNKsfgD9Hpzdl4Dpchgw27dtudYBK7fyDDRDsQiUTFW5MGcjmqRktscDUD/lCUqP2RYYxtWOiOLVlqDgzC1TAIJy8kW6i4qVEADtE+qX7eQz5eb/6Ad5MXmOX99PB0poaPfWKywV1IPjNV3tedFp0gnK8HtaKOGaIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599348; c=relaxed/simple;
	bh=JCXZHKT3V8mBxuyp9uSbC474XPI6ojntG4/VjLk2S38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZrSu0GvO2sFTJAq5kf2Pbv98UPxE6ywbkdsgr5U/6ljcrG6qkgV+8mfiRKlQebXHgFZUu32MsSqjW7NG64wWhPf6+1nuTiEoem932pRteP9qvaiDlOcSMvEOoHHSnMONcu2c4z7cx8mPVn0OqdamGipZ6ZaT3cmcYndqowiyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s+pwaD+z; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717599337; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wu0MqgvWU6o+dDhtVerJmtCRy0t8kgDaHijzora45jc=;
	b=s+pwaD+zUwszEXRO2biCkQiX3h59Gf4Cs9MVo3p3zekILTUypohmcdZDr/C9H3u7hX4BcZizXigrOfv2dKrc8XHCsWfwMrbfSEbNQqu30MUXfBDiFYg7cAuPdVfxqsLkRi6MWm02v8+R+oWj7iF5B/hp+6PEl0oezt+US2nlJxs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7vW.Un_1717599335;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7vW.Un_1717599335)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 22:55:36 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 2/2] virtio_net: improve dim command request efficiency
Date: Wed,  5 Jun 2024 22:55:33 +0800
Message-Id: <20240605145533.86229-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240605145533.86229-1-hengqi@linux.alibaba.com>
References: <20240605145533.86229-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the control queue (ctrlq) handles commands synchronously,
leading to increased delays for dim commands during multi-queue
VM configuration and directly impacting dim performance.

To address this, we are shifting to asynchronous processing of
ctrlq's dim commands.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 260 +++++++++++++++++++++++++++++++++++----
 1 file changed, 236 insertions(+), 24 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9b556ce89546..7975084052ad 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -270,6 +270,14 @@ struct virtnet_interrupt_coalesce {
 	u32 max_usecs;
 };
 
+struct virtnet_coal_node {
+	struct virtio_net_ctrl_hdr hdr;
+	virtio_net_ctrl_ack status;
+	struct virtio_net_ctrl_coal_vq coal_vqs;
+	bool is_coal_wait;
+	struct list_head list;
+};
+
 /* The dma information of pages allocated at a time. */
 struct virtnet_rq_dma {
 	dma_addr_t addr;
@@ -421,6 +429,9 @@ struct virtnet_info {
 	/* Wait for the device to complete the cvq request. */
 	struct completion completion;
 
+	/* Work struct for acquisition of cvq processing results. */
+	struct work_struct get_cvq;
+
 	/* Host can handle any s/g split between our header and packet data */
 	bool any_header_sg;
 
@@ -465,6 +476,14 @@ struct virtnet_info {
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
 
@@ -671,7 +690,7 @@ static void virtnet_cvq_done(struct virtqueue *cvq)
 {
 	struct virtnet_info *vi = cvq->vdev->priv;
 
-	complete(&vi->completion);
+	schedule_work(&vi->get_cvq);
 }
 
 static void skb_xmit_done(struct virtqueue *vq)
@@ -2183,6 +2202,113 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 	return !oom;
 }
 
+static int __virtnet_add_dim_command(struct virtnet_info *vi,
+				     struct virtnet_coal_node *ctrl)
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
+	ctrl->status = ~0;
+	sg_init_one(&stat, &ctrl->status, sizeof(ctrl->status));
+	sgs[out_num] = &stat;
+
+	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
+	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, ctrl, GFP_ATOMIC);
+	if (ret < 0) {
+		dev_warn(&vi->vdev->dev,
+			 "Failed to add sgs for command vq: %d\n.", ret);
+		return ret;
+	}
+
+	if (unlikely(!virtqueue_kick(vi->cvq)))
+		return -EIO;
+
+	return 0;
+}
+
+static int virtnet_add_dim_command(struct virtnet_info *vi,
+				   struct virtnet_coal_node *ctrl)
+{
+	int ret;
+
+	mutex_lock(&vi->cvq_lock);
+	ret = __virtnet_add_dim_command(vi, ctrl);
+	mutex_unlock(&vi->cvq_lock);
+
+	return ret;
+}
+
+static void virtnet_process_dim_cmd(struct virtnet_info *vi, void *res)
+{
+	struct virtnet_coal_node *node = (struct virtnet_coal_node *)res;
+	u16 qnum = le16_to_cpu(node->coal_vqs.vqn) / 2;
+
+	mutex_lock(&vi->rq[qnum].dim_lock);
+	vi->rq[qnum].intr_coal.max_usecs =
+		le32_to_cpu(node->coal_vqs.coal.max_usecs);
+	vi->rq[qnum].intr_coal.max_packets =
+		le32_to_cpu(node->coal_vqs.coal.max_packets);
+	vi->rq[qnum].dim.state = DIM_START_MEASURE;
+	mutex_unlock(&vi->rq[qnum].dim_lock);
+
+	if (node->is_coal_wait) {
+		kfree(node);
+	} else {
+		mutex_lock(&vi->coal_free_lock);
+		list_add(&node->list, &vi->coal_free_list);
+		mutex_unlock(&vi->coal_free_lock);
+	}
+}
+
+static void virtnet_get_cvq_work(struct work_struct *work)
+{
+	struct virtnet_info *vi =
+		container_of(work, struct virtnet_info, get_cvq);
+	struct virtnet_coal_node *wait_coal;
+	bool valid = false;
+	unsigned int tmp;
+	void *res;
+
+	mutex_lock(&vi->cvq_lock);
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
+		wait_coal = list_first_entry(&vi->coal_wait_list,
+					     struct virtnet_coal_node, list);
+		if (__virtnet_add_dim_command(vi, wait_coal))
+			break;
+		list_del(&wait_coal->list);
+	}
+	mutex_unlock(&vi->coal_wait_lock);
+
+	mutex_unlock(&vi->cvq_lock);
+}
+
 static void skb_recv_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
@@ -2695,7 +2821,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 				       struct scatterlist *in)
 {
 	struct scatterlist *sgs[5], hdr, stat;
-	u32 out_num = 0, tmp, in_num = 0;
+	u32 out_num = 0, in_num = 0;
 	int ret;
 
 	/* Caller should know better */
@@ -2728,14 +2854,15 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 		return false;
 	}
 
-	if (unlikely(!virtqueue_kick(vi->cvq)))
-		goto unlock;
+	if (unlikely(!virtqueue_kick(vi->cvq))) {
+		mutex_unlock(&vi->cvq_lock);
+		return false;
+	}
+
+	mutex_unlock(&vi->cvq_lock);
 
 	wait_for_completion(&vi->completion);
-	virtqueue_get_buf(vi->cvq, &tmp);
 
-unlock:
-	mutex_unlock(&vi->cvq_lock);
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
 
@@ -4396,35 +4523,73 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
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
+	wait_node->is_coal_wait = true;
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
-		dim->state = DIM_START_MEASURE;
+	if (!rq->dim_enabled ||
+	    (update_moder.usec == rq->intr_coal.max_usecs &&
+	     update_moder.pkts == rq->intr_coal.max_packets)) {
+		rq->dim.state = DIM_START_MEASURE;
+		mutex_unlock(&rq->dim_lock);
+		return;
 	}
-out:
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
@@ -4837,6 +5002,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
 	flush_work(&vi->rx_mode_work);
+	flush_work(&vi->get_cvq);
 
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
@@ -5610,6 +5776,45 @@ static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
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
@@ -5795,6 +6000,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (err)
 		goto free;
 
+	if (virtnet_init_coal_list(vi))
+		goto free;
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
 		vi->intr_coal_rx.max_usecs = 0;
 		vi->intr_coal_tx.max_usecs = 0;
@@ -5836,6 +6044,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
 	init_completion(&vi->completion);
 	enable_rx_mode_work(vi);
 
@@ -5965,11 +6174,14 @@ static void virtnet_remove(struct virtio_device *vdev)
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
 	flush_work(&vi->rx_mode_work);
+	flush_work(&vi->get_cvq);
 
 	unregister_netdev(vi->dev);
 
 	net_failover_destroy(vi->failover);
 
+	virtnet_del_coal_free_list(vi);
+
 	remove_vq_common(vi);
 
 	free_netdev(vi->dev);
-- 
2.32.0.3.g01195cf9f


