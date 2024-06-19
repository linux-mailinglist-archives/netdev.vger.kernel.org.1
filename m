Return-Path: <netdev+bounces-104945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3A990F3E1
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D2A1F21494
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB26153812;
	Wed, 19 Jun 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ynpz+qbl"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB6153517
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813959; cv=none; b=rgydw6aqHq18V2Ly2BP5vfK8KtyXlTJKocdpZVI5NDrlVuooBopgA+PBVatLSm/EfJVK2zEVEuHs7ImTkiKn1pcszNQFCmJipiO440V2cuIWJCloKpNcbOdyNQpqSBIGD5IesgKhe/4p97kIn0wwBAgYE0i6iolRSHKE66yepHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813959; c=relaxed/simple;
	bh=mTcvtuNXKLYqNNpz9HH3VkQuCcWXve2g64/UWOHq+aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2bZJS2bS/Bn0hJ5V+lT6P7qaY1XnvZoJS2mB8vQDe637L8EhiqeG/uZC/E/ILSAxgHO/wp6Ng7oVXopJcz6HgddwngamuyX2GP5cBDkorHcY86mQkqJJEDicLaNot0xsXGobxSOBIYHuYtx2EIJD5X/Wr1H1KTYt/mbaBdmJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ynpz+qbl; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718813954; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ITzd3w/WqM0TQWzJVHlTWo29vu31745lICvMHq2EJ+M=;
	b=Ynpz+qblf2yiryhwF1MBwk+ilTtDw0zn/QMQq/OdB8FYbpMmS67Q6XmKIIaIzSiXS2/h9EcJ8u3f95pC7+NLZRTsWeKy0jm9lno4zO+fI8sqIbWXyUBTTJjWHisUAaJBDzeoTeEU/r/4PMfeQgpLimywUJGs2vANLy/Z+1n9520=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8olbkL_1718813953;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8olbkL_1718813953)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 00:19:14 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 5/5] virtio_net: improve dim command request efficiency
Date: Thu, 20 Jun 2024 00:19:08 +0800
Message-Id: <20240619161908.82348-6-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240619161908.82348-1-hengqi@linux.alibaba.com>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, control vq handles commands synchronously,
leading to increased delays for dim commands during multi-queue
VM configuration and directly impacting dim performance.

To address this, we are shifting to asynchronous processing of
ctrlq's dim commands.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 221 +++++++++++++++++++++++++++++++++++----
 1 file changed, 201 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 807724772bcf..bd224e282f9b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -376,6 +376,12 @@ struct control_buf {
 	struct completion completion;
 };
 
+struct virtnet_coal_node {
+	struct control_buf ctrl;
+	struct virtio_net_ctrl_coal_vq coal_vqs;
+	struct list_head list;
+};
+
 struct virtnet_info {
 	struct virtio_device *vdev;
 	struct virtqueue *cvq;
@@ -420,6 +426,12 @@ struct virtnet_info {
 	/* Lock to protect the control VQ */
 	struct mutex cvq_lock;
 
+	/* Work struct for acquisition of cvq processing results. */
+	struct work_struct get_cvq;
+
+	/* OK to queue work getting cvq response? */
+	bool get_cvq_work_enabled;
+
 	/* Host can handle any s/g split between our header and packet data */
 	bool any_header_sg;
 
@@ -464,6 +476,10 @@ struct virtnet_info {
 	struct virtnet_interrupt_coalesce intr_coal_tx;
 	struct virtnet_interrupt_coalesce intr_coal_rx;
 
+	/* Free nodes used for concurrent delivery */
+	struct mutex coal_free_lock;
+	struct list_head coal_free_list;
+
 	unsigned long guest_offloads;
 	unsigned long guest_offloads_capable;
 
@@ -666,11 +682,26 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
 	return false;
 }
 
+static void enable_get_cvq_work(struct virtnet_info *vi)
+{
+	rtnl_lock();
+	vi->get_cvq_work_enabled = true;
+	rtnl_unlock();
+}
+
+static void disable_get_cvq_work(struct virtnet_info *vi)
+{
+	rtnl_lock();
+	vi->get_cvq_work_enabled = false;
+	rtnl_unlock();
+}
+
 static void virtnet_cvq_done(struct virtqueue *cvq)
 {
 	struct virtnet_info *vi = cvq->vdev->priv;
 
-	complete(&vi->ctrl->completion);
+	virtqueue_disable_cb(cvq);
+	schedule_work(&vi->get_cvq);
 }
 
 static void skb_xmit_done(struct virtqueue *vq)
@@ -2730,6 +2761,7 @@ static bool virtnet_add_command_reply(struct virtnet_info *vi,
 		return false;
 	}
 
+	mutex_unlock(&vi->cvq_lock);
 	return true;
 }
 
@@ -2740,10 +2772,8 @@ static bool virtnet_wait_command_response(struct virtnet_info *vi,
 	bool ok;
 
 	wait_for_completion(&ctrl->completion);
-	virtqueue_get_buf(vi->cvq, &tmp);
 
 	ok = ctrl->status == VIRTIO_NET_OK;
-	mutex_unlock(&vi->cvq_lock);
 	return ok;
 }
 
@@ -2772,6 +2802,89 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	return virtnet_send_command_reply(vi, class, cmd, vi->ctrl, out, NULL);
 }
 
+static bool virtnet_process_dim_cmd(struct virtnet_info *vi,
+				    struct virtnet_coal_node *node)
+{
+	u16 qnum = le16_to_cpu(node->coal_vqs.vqn) / 2;
+	bool ret;
+
+	ret = virtnet_wait_command_response(vi, &node->ctrl);
+	if (ret) {
+		mutex_lock(&vi->rq[qnum].dim_lock);
+		vi->rq[qnum].intr_coal.max_usecs =
+			le32_to_cpu(node->coal_vqs.coal.max_usecs);
+		vi->rq[qnum].intr_coal.max_packets =
+			le32_to_cpu(node->coal_vqs.coal.max_packets);
+		mutex_unlock(&vi->rq[qnum].dim_lock);
+	}
+
+	vi->rq[qnum].dim.state = DIM_START_MEASURE;
+
+	mutex_lock(&vi->coal_free_lock);
+	list_add(&node->list, &vi->coal_free_list);
+	mutex_unlock(&vi->coal_free_lock);
+	return ret;
+}
+
+static bool virtnet_add_dim_command(struct virtnet_info *vi,
+				    struct receive_queue *rq,
+				    struct dim_cq_moder update_moder,
+				    struct virtnet_coal_node **avail_coal)
+{
+	struct virtnet_coal_node *node;
+	struct scatterlist sg;
+	bool ret;
+
+	mutex_lock(&vi->coal_free_lock);
+	if (list_empty(&vi->coal_free_list)) {
+		mutex_unlock(&vi->coal_free_lock);
+		return false;
+	}
+
+	node = list_first_entry(&vi->coal_free_list,
+				struct virtnet_coal_node, list);
+	node->coal_vqs.vqn = cpu_to_le16(rxq2vq(rq - vi->rq));
+	node->coal_vqs.coal.max_usecs = cpu_to_le32(update_moder.usec);
+	node->coal_vqs.coal.max_packets = cpu_to_le32(update_moder.pkts);
+
+	sg_init_one(&sg, &node->coal_vqs, sizeof(node->coal_vqs));
+	ret = virtnet_add_command_reply(vi, VIRTIO_NET_CTRL_NOTF_COAL,
+					VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
+					&node->ctrl, &sg, NULL);
+	if (!ret) {
+		dev_warn(&vi->dev->dev,
+			 "Failed to change coalescing params.\n");
+		mutex_unlock(&vi->coal_free_lock);
+		return ret;
+	}
+
+	*avail_coal = node;
+	list_del(&node->list);
+	mutex_unlock(&vi->coal_free_lock);
+
+	return true;
+}
+
+static void virtnet_get_cvq_work(struct work_struct *work)
+{
+	struct virtnet_info *vi =
+		container_of(work, struct virtnet_info, get_cvq);
+	unsigned int tmp;
+	int opaque;
+	void *res;
+
+again:
+	mutex_lock(&vi->cvq_lock);
+	while ((res = virtqueue_get_buf(vi->cvq, &tmp)) != NULL)
+		complete((struct completion *)res);
+	mutex_unlock(&vi->cvq_lock);
+
+	opaque = virtqueue_enable_cb_prepare(vi->cvq);
+	if (unlikely(virtqueue_poll(vi->cvq, opaque))) {
+		virtqueue_disable_cb(vi->cvq);
+		goto again;
+	}
+}
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -4419,35 +4532,54 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
+static void virtnet_wait_space(struct virtnet_info *vi)
+{
+	bool no_coal_free = true;
+
+	while (READ_ONCE(vi->cvq->num_free) < 3)
+		usleep_range(1000, 2000);
+
+	while (no_coal_free) {
+		mutex_lock(&vi->coal_free_lock);
+		if (!list_empty(&vi->coal_free_list))
+			no_coal_free = false;
+		mutex_unlock(&vi->coal_free_lock);
+		if (no_coal_free)
+			usleep_range(1000, 2000);
+	}
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
+again:
+	virtnet_wait_space(vi);
+
+	if (!virtnet_add_dim_command(vi, rq, update_moder, &avail_coal)) {
+		if (virtqueue_is_broken(vi->cvq))
+			return;
+		goto again;
+	}
+
+	virtnet_process_dim_cmd(vi, avail_coal);
 }
 
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
@@ -4860,6 +4992,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
 	flush_work(&vi->rx_mode_work);
+	disable_get_cvq_work(vi);
+	flush_work(&vi->get_cvq);
 
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
@@ -4883,6 +5017,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	enable_delayed_refill(vi);
 	enable_rx_mode_work(vi);
+	enable_get_cvq_work(vi);
 
 	if (netif_running(vi->dev)) {
 		err = virtnet_open(vi->dev);
@@ -5633,6 +5768,43 @@ static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
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
+		init_completion(&coal_node->ctrl.completion);
+		list_add(&coal_node->list, &vi->coal_free_list);
+	}
+
+	return 0;
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -5818,6 +5990,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (err)
 		goto free;
 
+	if (virtnet_init_coal_list(vi))
+		goto free;
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
 		vi->intr_coal_rx.max_usecs = 0;
 		vi->intr_coal_tx.max_usecs = 0;
@@ -5859,7 +6034,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
 	init_completion(&vi->ctrl->completion);
+	enable_get_cvq_work(vi);
 	enable_rx_mode_work(vi);
 
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
@@ -5988,11 +6165,15 @@ static void virtnet_remove(struct virtio_device *vdev)
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
 	flush_work(&vi->rx_mode_work);
+	disable_get_cvq_work(vi);
+	flush_work(&vi->get_cvq);
 
 	unregister_netdev(vi->dev);
 
 	net_failover_destroy(vi->failover);
 
+	virtnet_del_coal_free_list(vi);
+
 	remove_vq_common(vi);
 
 	free_netdev(vi->dev);
-- 
2.32.0.3.g01195cf9f


