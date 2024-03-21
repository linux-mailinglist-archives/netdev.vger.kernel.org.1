Return-Path: <netdev+bounces-81022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304DE885889
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546201C21823
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C35F466;
	Thu, 21 Mar 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IJw26sxE"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90359148
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021567; cv=none; b=PP0ai0gR7f/Uw+FxuLJa+takp6zI0Iqt7gu6mE45Mig+fm2PSe+koneue3VIdkA0hz2uaznbNwwTxtYumP8h/Wb/7WlkNKeoX2kR8vWxCSFPtbAcDc0d537sYgwKcSSasL2ATvZrNhdNugamROfP3CPH7Qmx7XMkVjyf/h8qJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021567; c=relaxed/simple;
	bh=jSCAfVC5zxGX+Rxvz2EuB8guVTDQKe5d+rKvKDECHg4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=qI9+pFZmqm6ii/ubucNEjlhCMQtP131aYtiP4540nUCWGq3PR/1KMuwSigjqP1A3XmLku+vKqk4jUMxEjz9eC2LdImP7nVI1xSR/2QPFItTTzOq8nUT2euGASlqO5aHex48GIULUX0a/nH57aPPlStjaZd1i7ACBuV1nKp8e2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IJw26sxE; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711021561; h=From:To:Subject:Date:Message-Id;
	bh=+x97TFd8xWnRJBIeuKiZQYQ97T4nZhUStWpb1DfxRl4=;
	b=IJw26sxEsUCbJ3hztuiuEoNqyECCxANqxD/oV4BdJ6fAbK+H8AnYmv3QK4ffPCwWAwMYKHgtLg/rSAcNzvsCeGABqgDUQgxF7wjEwSDXKOycr8k26kqfKwvt5haOivNpBbfA2hDJqI6cthuTJk2Gwa5WMe8yhaJ9zoDaWxQ11fk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3-bpQT_1711021560;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3-bpQT_1711021560)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 19:46:01 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
Date: Thu, 21 Mar 2024 19:45:57 +0800
Message-Id: <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Currently, ctrlq processes commands in a synchronous manner,
which increases the delay of dim commands when configuring
multi-queue VMs, which in turn causes the CPU utilization to
increase and interferes with the performance of dim.

Therefore we asynchronously process ctlq's dim commands.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 269 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 243 insertions(+), 26 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0ebe322..460fc9e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -138,6 +138,13 @@ struct virtnet_interrupt_coalesce {
 	u32 max_usecs;
 };
 
+struct virtnet_coal_node {
+	struct virtio_net_ctrl_hdr hdr;
+	virtio_net_ctrl_ack status;
+	struct virtio_net_ctrl_coal_vq coal_vqs;
+	struct list_head list;
+};
+
 /* The dma information of pages allocated at a time. */
 struct virtnet_rq_dma {
 	dma_addr_t addr;
@@ -300,6 +307,9 @@ struct virtnet_info {
 	/* Work struct for delayed refilling if we run low on memory. */
 	struct delayed_work refill;
 
+	/* Work struct for delayed acquisition of cvq processing results. */
+	struct delayed_work get_cvq;
+
 	/* Is delayed refill enabled? */
 	bool refill_enabled;
 
@@ -332,6 +342,10 @@ struct virtnet_info {
 	bool rx_dim_enabled;
 
 	/* Interrupt coalescing settings */
+	int cvq_cmd_nums;
+	int batch_dim_nums;
+	int dim_loop_index;
+	struct list_head coal_list;
 	struct virtnet_interrupt_coalesce intr_coal_tx;
 	struct virtnet_interrupt_coalesce intr_coal_rx;
 
@@ -2522,6 +2536,64 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 	return err;
 }
 
+static void virtnet_process_dim_cmd(struct virtnet_info *vi, void *res)
+{
+	struct virtnet_coal_node *coal_node;
+	u16 queue;
+
+	vi->cvq_cmd_nums--;
+
+	coal_node = (struct virtnet_coal_node *)res;
+	list_add(&coal_node->list, &vi->coal_list);
+
+	queue = le16_to_cpu(coal_node->coal_vqs.vqn) / 2;
+	vi->rq[queue].dim.state = DIM_START_MEASURE;
+}
+
+/**
+ * virtnet_cvq_response - get the response for filled ctrlq requests
+ * @poll: keep polling ctrlq when a NULL buffer is obtained.
+ * @dim_oneshot: process a dim cmd then exit, excluding user commands.
+ *
+ * Note that user commands must be processed synchronously
+ *  (poll = true, dim_oneshot = false).
+ */
+static void virtnet_cvq_response(struct virtnet_info *vi,
+				 bool poll,
+				 bool dim_oneshot)
+{
+	unsigned tmp;
+	void *res;
+
+	while (true) {
+		res = virtqueue_get_buf(vi->cvq, &tmp);
+		if (virtqueue_is_broken(vi->cvq)) {
+			dev_warn(&vi->dev->dev, "Control vq is broken.\n");
+			return;
+		}
+
+		if (!res) {
+			if (!poll)
+				return;
+
+			cond_resched();
+			cpu_relax();
+			continue;
+		}
+
+		/* this does not occur inside the process of waiting dim */
+		if (res == ((void *)vi))
+			return;
+
+		virtnet_process_dim_cmd(vi, res);
+		/* When it is a user command, we must wait until the
+		 * processing result is processed synchronously.
+		 */
+		if (dim_oneshot)
+			return;
+	}
+}
+
 /*
  * Send command via the control virtqueue and check status.  Commands
  * supported by the hypervisor, as indicated by feature bits, should
@@ -2531,7 +2603,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 				 struct scatterlist *out)
 {
 	struct scatterlist *sgs[4], hdr, stat;
-	unsigned out_num = 0, tmp;
+	unsigned out_num = 0;
 	int ret;
 
 	/* Caller should know better */
@@ -2552,6 +2624,13 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	sgs[out_num] = &stat;
 
 	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
+
+	/* The additional task (dim) consumes the descriptor asynchronously,
+	 * so we must ensure that there is a location for us.
+	 */
+	if (vi->cvq->num_free <= 3)
+		virtnet_cvq_response(vi, true, true);
+
 	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
 	if (ret < 0) {
 		dev_warn(&vi->vdev->dev,
@@ -2565,11 +2644,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
 	 */
-	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq)) {
-		cond_resched();
-		cpu_relax();
-	}
+	virtnet_cvq_response(vi, true, false);
 
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
@@ -2721,6 +2796,7 @@ static int virtnet_close(struct net_device *dev)
 		cancel_work_sync(&vi->rq[i].dim.work);
 	}
 
+	cancel_delayed_work_sync(&vi->get_cvq);
 	return 0;
 }
 
@@ -3553,48 +3629,148 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
+static bool virtnet_add_dim_command(struct virtnet_info *vi,
+				    struct virtnet_coal_node *ctrl)
+{
+	struct scatterlist *sgs[4], hdr, stat, out;
+	unsigned out_num = 0;
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
+		return false;
+	}
+
+	virtqueue_kick(vi->cvq);
+
+	vi->cvq_cmd_nums++;
+
+	return true;
+}
+
+static void virtnet_get_cvq_work(struct work_struct *work)
+{
+	struct virtnet_info *vi =
+		container_of(work, struct virtnet_info, get_cvq.work);
+
+	if (!rtnl_trylock()) {
+		schedule_delayed_work(&vi->get_cvq, 1);
+		return;
+	}
+
+	if (!vi->cvq_cmd_nums)
+		goto ret;
+
+	virtnet_cvq_response(vi, false, false);
+
+	if (vi->cvq_cmd_nums)
+		schedule_delayed_work(&vi->get_cvq, 1);
+
+ret:
+	rtnl_unlock();
+}
+
+static int virtnet_config_dim(struct virtnet_info *vi, struct receive_queue *rq,
+			      struct dim *dim)
+{
+	struct virtnet_coal_node *avail_coal;
+	struct dim_cq_moder update_moder;
+	int qnum = rq - vi->rq;
+
+	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+	if (update_moder.usec != rq->intr_coal.max_usecs ||
+	    update_moder.pkts != rq->intr_coal.max_packets) {
+		avail_coal = list_first_entry(&vi->coal_list,
+					      struct virtnet_coal_node, list);
+		avail_coal->coal_vqs.vqn = cpu_to_le16(rxq2vq(qnum));
+		avail_coal->coal_vqs.coal.max_usecs = cpu_to_le32(update_moder.usec);
+		avail_coal->coal_vqs.coal.max_packets = cpu_to_le32(update_moder.pkts);
+		list_del(&avail_coal->list);
+		if (!virtnet_add_dim_command(vi, avail_coal))
+			return -EINVAL;
+
+		rq->intr_coal.max_usecs = update_moder.usec;
+		rq->intr_coal.max_packets = update_moder.pkts;
+	} else if (dim->state == DIM_APPLY_NEW_PROFILE) {
+		dim->state = DIM_START_MEASURE;
+	}
+
+	return 0;
+}
+
 static void virtnet_rx_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
-	struct receive_queue *rq = container_of(dim,
+	struct receive_queue *rq, *rq_ = container_of(dim,
 			struct receive_queue, dim);
-	struct virtnet_info *vi = rq->vq->vdev->priv;
-	struct net_device *dev = vi->dev;
-	struct dim_cq_moder update_moder;
-	int i, qnum, err;
+	struct virtnet_info *vi = rq_->vq->vdev->priv;
+	int i = 0, err;
 
 	if (!rtnl_trylock()) {
 		schedule_work(&dim->work);
 		return;
 	}
 
+	if (list_empty(&vi->coal_list) || vi->cvq->num_free <= 3)
+		virtnet_cvq_response(vi, true, true);
+
+	/* The request scheduling the worker must be processed first
+	 * to avoid not having enough descs for ctrlq, causing the
+	 * request to fail, and the parameters of the queue will never
+	 * be updated again in the future.
+	 */
+	err = virtnet_config_dim(vi, rq_, dim);
+	if (err)
+		goto ret;
+
 	/* Each rxq's work is queued by "net_dim()->schedule_work()"
 	 * in response to NAPI traffic changes. Note that dim->profile_ix
 	 * for each rxq is updated prior to the queuing action.
 	 * So we only need to traverse and update profiles for all rxqs
 	 * in the work which is holding rtnl_lock.
 	 */
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
+	for (i = vi->dim_loop_index; i < vi->curr_queue_pairs; i++) {
 		rq = &vi->rq[i];
 		dim = &rq->dim;
-		qnum = rq - vi->rq;
 
-		if (!rq->dim_enabled)
+		if (list_empty(&vi->coal_list) || vi->cvq->num_free <= 3)
+			break;
+
+		if (!rq->dim_enabled || rq == rq_)
 			continue;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
-		if (update_moder.usec != rq->intr_coal.max_usecs ||
-		    update_moder.pkts != rq->intr_coal.max_packets) {
-			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
-							       update_moder.usec,
-							       update_moder.pkts);
-			if (err)
-				pr_debug("%s: Failed to send dim parameters on rxq%d\n",
-					 dev->name, qnum);
-			dim->state = DIM_START_MEASURE;
-		}
+		err = virtnet_config_dim(vi, rq, dim);
+		if (err)
+			goto ret;
+
 	}
 
+	if (vi->cvq_cmd_nums)
+		schedule_delayed_work(&vi->get_cvq, 1);
+
+ret:
+	if (i == vi->curr_queue_pairs)
+		vi->dim_loop_index = 0;
+	else
+		vi->dim_loop_index = i;
+
 	rtnl_unlock();
 }
 
@@ -4439,6 +4615,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 		goto err_rq;
 
 	INIT_DELAYED_WORK(&vi->refill, refill_work);
+	INIT_DELAYED_WORK(&vi->get_cvq, virtnet_get_cvq_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
 		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
@@ -4623,6 +4800,35 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static void virtnet_del_coal_list(struct virtnet_info *vi)
+{
+	struct virtnet_coal_node *coal_node, *tmp;
+
+	list_for_each_entry_safe(coal_node, tmp,  &vi->coal_list, list) {
+		list_del(&coal_node->list);
+		kfree(coal_node);
+	}
+}
+
+static int virtnet_init_coal_list(struct virtnet_info *vi)
+{
+	struct virtnet_coal_node *coal_node;
+	int i;
+
+	vi->batch_dim_nums = min((unsigned int)vi->max_queue_pairs,
+				 virtqueue_get_vring_size(vi->cvq) / 3);
+	for (i = 0; i < vi->batch_dim_nums; i++) {
+		coal_node = kmalloc(sizeof(*coal_node), GFP_KERNEL);
+		if (!coal_node) {
+			virtnet_del_coal_list(vi);
+			return -ENOMEM;
+		}
+		list_add(&coal_node->list, &vi->coal_list);
+	}
+
+	return 0;
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -4816,11 +5022,20 @@ static int virtnet_probe(struct virtio_device *vdev)
 			vi->intr_coal_tx.max_packets = 0;
 	}
 
+	INIT_LIST_HEAD(&vi->coal_list);
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		vi->cvq_cmd_nums = 0;
+		vi->dim_loop_index = 0;
+
+		if (virtnet_init_coal_list(vi))
+			goto free;
+
 		/* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
-		for (i = 0; i < vi->max_queue_pairs; i++)
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			vi->rq[i].packets_in_napi = 0;
 			if (vi->sq[i].napi.weight)
 				vi->sq[i].intr_coal.max_packets = 1;
+		}
 	}
 
 #ifdef CONFIG_SYSFS
@@ -4949,6 +5164,8 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	net_failover_destroy(vi->failover);
 
+	virtnet_del_coal_list(vi);
+
 	remove_vq_common(vi);
 
 	free_netdev(vi->dev);
-- 
1.8.3.1


