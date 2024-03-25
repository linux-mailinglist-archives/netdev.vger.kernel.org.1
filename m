Return-Path: <netdev+bounces-81546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B088A1B9
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02132C66A1
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB22615AACC;
	Mon, 25 Mar 2024 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Reu5Fd2q"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101C13A89D
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356876; cv=none; b=tcWMB6VYAjIgHfwUYawJxvngVxfHfkZ+n3HyJuAQceC8yrjv/a/3IgEpFD9EgGoqy9OkfSEzZyGGsNqpyQOXuCTVvxLRyHnZXaMEhba+enjDH5l7jOKTW3cVKe1lmiYEIbe6E7QSOci4XW/LdlgF/lGzVf0PcpjFKZS4aWR/7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356876; c=relaxed/simple;
	bh=xhUTpnaeeKlUpCSXtJ7jvRZyUUTaLoA2azCYJmvZLgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZJUrkuNPON+sI/YkZxzw7WZuCC/TO7wNLuA1WxqTbEsCQwR4QmN7yrlSJ01zoClz+YnzQ88Z3wjMSu8WsmhGKyt+DbRMM5VUo/r68Zhat9th37QpU1PLzEEKwdEqmrROw57Fpyi3pm09xCVpx9NEkJ1eAIFkzwc7hjcw7Vf5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Reu5Fd2q; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711356871; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=51uP+XzVf6qKOPVOKjRFKoVdSryMstnzgYrhBOj0Uqo=;
	b=Reu5Fd2qu+N8Qd7bVJ/hZOC48mQ1vCrm2GJmqCn7M1SlcEG8C5e1Mhe89JP0H+OEr4EGxkybruHlBO1EyU3PlYtErNUYUY3vi9mE+Zk7JkPY0gQSKl5JPh2sTc6041SIJS7Jw7ZMZ7BKB62x3oHLSG/j0ZfcyViNf9/7Ao83IgY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3DYiHr_1711356870;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DYiHr_1711356870)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 16:54:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost v5 01/10] virtio_ring: introduce vring_need_unmap_buffer
Date: Mon, 25 Mar 2024 16:54:19 +0800
Message-Id: <20240325085428.7275-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 630d711f51f7
Content-Transfer-Encoding: 8bit

To make the code readable, introduce vring_need_unmap_buffer() to
replace do_unmap.

   use_dma_api premapped -> vring_need_unmap_buffer()
1. false       false        false
2. true        false        true
3. true        true         false

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 94c442ba844f..c2779e34aac7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -175,11 +175,6 @@ struct vring_virtqueue {
 	/* Do DMA mapping by driver */
 	bool premapped;
 
-	/* Do unmap or not for desc. Just when premapped is False and
-	 * use_dma_api is true, this is true.
-	 */
-	bool do_unmap;
-
 	/* Head of free buffer list. */
 	unsigned int free_head;
 	/* Number we've added since last sync. */
@@ -295,6 +290,11 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
 	return false;
 }
 
+static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring)
+{
+	return vring->use_dma_api && !vring->premapped;
+}
+
 size_t virtio_max_dma_size(const struct virtio_device *vdev)
 {
 	size_t max_segment_size = SIZE_MAX;
@@ -443,7 +443,7 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 {
 	u16 flags;
 
-	if (!vq->do_unmap)
+	if (!vring_need_unmap_buffer(vq))
 		return;
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
@@ -473,7 +473,7 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		if (!vq->do_unmap)
+		if (!vring_need_unmap_buffer(vq))
 			goto out;
 
 		dma_unmap_page(vring_dma_dev(vq),
@@ -641,7 +641,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	}
 	/* Last one doesn't continue. */
 	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
-	if (!indirect && vq->do_unmap)
+	if (!indirect && vring_need_unmap_buffer(vq))
 		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
 			~VRING_DESC_F_NEXT;
 
@@ -800,7 +800,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
-		if (vq->do_unmap) {
+		if (vring_need_unmap_buffer(vq)) {
 			for (j = 0; j < len / sizeof(struct vring_desc); j++)
 				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
 		}
@@ -1230,7 +1230,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		if (!vq->do_unmap)
+		if (!vring_need_unmap_buffer(vq))
 			return;
 
 		dma_unmap_page(vring_dma_dev(vq),
@@ -1245,7 +1245,7 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 {
 	u16 flags;
 
-	if (!vq->do_unmap)
+	if (!vring_need_unmap_buffer(vq))
 		return;
 
 	flags = le16_to_cpu(desc->flags);
@@ -1626,7 +1626,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->do_unmap) {
+		if (vring_need_unmap_buffer(vq)) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
@@ -2080,7 +2080,6 @@ static struct virtqueue *vring_create_virtqueue_packed(struct virtio_device *vde
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
 	vq->premapped = false;
-	vq->do_unmap = vq->use_dma_api;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
@@ -2621,7 +2620,6 @@ static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
 	vq->dma_dev = tp_cfg->dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
 	vq->premapped = false;
-	vq->do_unmap = vq->use_dma_api;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
@@ -2752,7 +2750,6 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 	}
 
 	vq->premapped = true;
-	vq->do_unmap = false;
 
 	END_USE(vq);
 
-- 
2.32.0.3.g01195cf9f


