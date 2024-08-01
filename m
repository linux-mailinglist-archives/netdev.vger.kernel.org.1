Return-Path: <netdev+bounces-114985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C116944D85
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1E51C24F43
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168B41A3BC3;
	Thu,  1 Aug 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U+PTogXN"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732ED184549
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520606; cv=none; b=YbxfZxf6LxoKKeLkK0VdN1OuVpPKTw/uuTm/KX6oWQHdMBCHJJxEqDNqSTPEij+GQ3505/b627xTdcrv5//Wwlq7bu7xQ+krZqgTvTMonr4LUOO1u5Ipw7k6BhjePntlfx7rr6bAX+HIs7jKhhf86SO0ZHhw0FcXwAFOEupxAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520606; c=relaxed/simple;
	bh=/JvjrlmCj9jqSBPQvc90Bn5EqMtxJGAPV4ogxNf5LXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DloYaCTdiv95We6tneW8hHII9k6B6iBmwXBfRLlx+IZLMxfFNJmtAn7FSL6Cl/mh+DUR2uK124Oq+Rerr2WduPfXF4LUDq3F+J+br37Fopsih3Xnzow7ltxJaVkMgTvA6KCS8ZtPTpoIav/pxvSwhInzib+u4Zqv9lob2NKaohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U+PTogXN; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722520601; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eTETyYoKWgigPTTpNjg3CKuYliY8GsuAJU9dx5gVpr4=;
	b=U+PTogXNkKKsMtWIl5skTwYZJl6eKzKW0rlf8kGsP/eqTI4BgSHS59x6lL+zJFAyXfvINRHQwx650AB5mXNLDgArBujyd6jXffIM7pFuhxK1w5uPwxZxJKMA7qAXkZcsUYNlJGv/TXG368Mwp4XukjUK+9NBAZTOd0rQcCBjl0g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WBtsTB4_1722520599;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtsTB4_1722520599)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 21:56:40 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] virtio_net: Prevent misidentified spurious interrupts from killing the irq
Date: Thu,  1 Aug 2024 21:56:39 +0800
Message-Id: <20240801135639.11400-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michael has effectively reduced the number of spurious interrupts in
commit a7766ef18b33 ("virtio_net: disable cb aggressively") by disabling
irq callbacks before cleaning old buffers.

But it is still possible that the irq is killed by mistake:

  When a delayed tx interrupt arrives, old buffers has been cleaned in
  other paths (start_xmit and virtnet_poll_cleantx), then the interrupt is
  mistakenly identified as a spurious interrupt in vring_interrupt.

  We should refrain from labeling it as a spurious interrupt; otherwise,
  note_interrupt may inadvertently kill the legitimate irq.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c     |  9 ++++++
 drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  3 ++
 3 files changed, 65 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0383a3e136d6..6d8739418203 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2769,6 +2769,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 		do {
 			virtqueue_disable_cb(sq->vq);
 			free_old_xmit(sq, txq, !!budget);
+			virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
@@ -3035,6 +3036,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		free_old_xmit(sq, txq, false);
 
+		if (use_napi)
+			virtqueue_set_tx_oldbuf_cleaned(sq->vq, true);
+
 	} while (use_napi && !xmit_more &&
 	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
@@ -3044,6 +3048,11 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Try to transmit */
 	err = xmit_skb(sq, skb, !use_napi);
 
+	if (use_napi) {
+		virtqueue_set_tx_newbuf_sent(sq->vq, true);
+		virtqueue_set_tx_oldbuf_cleaned(sq->vq, false);
+	}
+
 	/* This should not happen! */
 	if (unlikely(err)) {
 		DEV_STATS_INC(dev, tx_fifo_errors);
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..fb2afc716371 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -180,6 +180,11 @@ struct vring_virtqueue {
 	 */
 	bool do_unmap;
 
+	/* Has any new data been sent? */
+	bool is_tx_newbuf_sent;
+	/* Is the old data recently sent cleaned up? */
+	bool is_tx_oldbuf_cleaned;
+
 	/* Head of free buffer list. */
 	unsigned int free_head;
 	/* Number we've added since last sync. */
@@ -2092,6 +2097,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->use_dma_api = vring_use_dma_api(vdev);
 	vq->premapped = false;
 	vq->do_unmap = vq->use_dma_api;
+	vq->is_tx_newbuf_sent = false; /* Initially, no new buffer to send. */
+	vq->is_tx_oldbuf_cleaned = true; /* Initially, no old buffer to clean. */
+
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2375,6 +2383,38 @@ bool virtqueue_notify(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_notify);
 
+/**
+ * virtqueue_set_tx_newbuf_sent - set whether there is new tx buf to send.
+ * @_vq: the struct virtqueue
+ *
+ * If is_tx_newbuf_sent and is_tx_oldbuf_cleaned are both true, the
+ * spurious interrupt is caused by polling TX vq in other paths outside
+ * the tx irq callback.
+ */
+void virtqueue_set_tx_newbuf_sent(struct virtqueue *_vq, bool val)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	vq->is_tx_newbuf_sent = val;
+}
+EXPORT_SYMBOL_GPL(virtqueue_set_tx_newbuf_sent);
+
+/**
+ * virtqueue_set_tx_oldbuf_cleaned - set whether there is old tx buf to clean.
+ * @_vq: the struct virtqueue
+ *
+ * If is_tx_oldbuf_cleaned and is_tx_newbuf_sent are both true, the
+ * spurious interrupt is caused by polling TX vq in other paths outside
+ * the tx irq callback.
+ */
+void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *_vq, bool val)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	vq->is_tx_oldbuf_cleaned = val;
+}
+EXPORT_SYMBOL_GPL(virtqueue_set_tx_oldbuf_cleaned);
+
 /**
  * virtqueue_kick - update after add_buf
  * @vq: the struct virtqueue
@@ -2572,6 +2612,16 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (!more_used(vq)) {
+		/* When the delayed TX interrupt arrives, the old buffers are
+		 * cleaned in other cases(start_xmit and virtnet_poll_cleantx).
+		 * We'd better not identify it as a spurious interrupt,
+		 * otherwise note_interrupt may kill the interrupt.
+		 */
+		if (unlikely(vq->is_tx_newbuf_sent && vq->is_tx_oldbuf_cleaned)) {
+			vq->is_tx_newbuf_sent = false;
+			return IRQ_HANDLED;
+		}
+
 		pr_debug("virtqueue interrupt with no work for %p\n", vq);
 		return IRQ_NONE;
 	}
@@ -2637,6 +2687,9 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->use_dma_api = vring_use_dma_api(vdev);
 	vq->premapped = false;
 	vq->do_unmap = vq->use_dma_api;
+	vq->is_tx_newbuf_sent = false; /* Initially, no new buffer to send. */
+	vq->is_tx_oldbuf_cleaned = true; /* Initially, no old buffer to clean. */
+
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index ecc5cb7b8c91..ba3be9276c09 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -103,6 +103,9 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
 int virtqueue_reset(struct virtqueue *vq,
 		    void (*recycle)(struct virtqueue *vq, void *buf));
 
+void virtqueue_set_tx_newbuf_sent(struct virtqueue *vq, bool val);
+void virtqueue_set_tx_oldbuf_cleaned(struct virtqueue *vq, bool val);
+
 struct virtio_admin_cmd {
 	__le16 opcode;
 	__le16 group_type;
-- 
2.32.0.3.g01195cf9f


