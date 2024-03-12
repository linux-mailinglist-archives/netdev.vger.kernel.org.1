Return-Path: <netdev+bounces-79368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0EC878D98
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 04:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7890282B07
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9942AB1;
	Tue, 12 Mar 2024 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qvndnQ2B"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEA7C153
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214571; cv=none; b=fL60OUsF/OND0oa1ww3z8qjXOY5HbB1sudHA9f40Bg9REWi9BZuNBzdhCGfF8tINnFevDYx+kR3Vr6SOsVeAXHo4V6bd1SzaGt+iUyM7gx7lGNCZS/Om/mNv6NYfadpX1+u2DTOXJhPQaq/ywEoRWkCtka/wRV1DzN8jnrNNQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214571; c=relaxed/simple;
	bh=qWqInJHax6+8wLyHy5u8t1VtpLQJ4xDYPG6qHTw+FqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSoxtT/kZwZXNlkBzSPk542w90taamvsA7xw/+SWwmEd0/jsvDKnMGMNwxwDxlO13iQ6ou2gksy6HGG+aLZx4xh5U5S1jRqS250Hmnehk/aAdEhn0yZsIReRAUQq5EGcs1NecIIB9kcNfqXcZik6y8pJ7Icx4HJJ+tSAiCUYwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qvndnQ2B; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710214565; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dboibprrJlM9E4WDnmzJpMZfQxjMOz/XCZ5pDkWRogs=;
	b=qvndnQ2BHZHIw7C1JWXNC9eehBKscroxWoLant/1vvVcYKnMJ/5/lGPiTnVAp1hxVegevvmo/FTpGX//AkbMKSvxwM5NzhHJCOdlvamfqCGz/i/RBxBcuCyPjDa6Q25mME/v67ivZriAtQ81Wqtq/fD6koQWH1IKOBnrJOpqzvY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W2KOie0_1710214563;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2KOie0_1710214563)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 11:36:04 +0800
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
Subject: [PATCH vhost v4 06/10] virtio_ring: no store dma info when unmap is not needed
Date: Tue, 12 Mar 2024 11:35:53 +0800
Message-Id: <20240312033557.6351-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 89bc1d4948eb
Content-Transfer-Encoding: 8bit

As discussed:
http://lore.kernel.org/all/CACGkMEug-=C+VQhkMYSgUKMC==04m7-uem_yC21bgGkKZh845w@mail.gmail.com

When the vq is premapped mode, the driver manages the dma
info is a good way.

So this commit make the virtio core not to store the dma
info and release the memory which is used to store the dma
info.

If the use_dma_api is false, the memory is also not allocated.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 100 ++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 81a8c2b70af1..f5a72d22c838 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -94,12 +94,15 @@ struct vring_desc_state_packed {
 };
 
 struct vring_desc_extra {
-	dma_addr_t addr;		/* Descriptor DMA addr. */
-	u32 len;			/* Descriptor length. */
 	u16 flags;			/* Descriptor flags. */
 	u16 next;			/* The next desc state in a list. */
 };
 
+struct vring_desc_dma {
+	dma_addr_t addr;		/* Descriptor DMA addr. */
+	u32 len;			/* Descriptor length. */
+};
+
 struct vring_virtqueue_split {
 	/* Actual memory layout for this queue. */
 	struct vring vring;
@@ -116,6 +119,7 @@ struct vring_virtqueue_split {
 	/* Per-descriptor state. */
 	struct vring_desc_state_split *desc_state;
 	struct vring_desc_extra *desc_extra;
+	struct vring_desc_dma *desc_dma;
 
 	/* DMA address and size information */
 	dma_addr_t queue_dma_addr;
@@ -156,6 +160,7 @@ struct vring_virtqueue_packed {
 	/* Per-descriptor state. */
 	struct vring_desc_state_packed *desc_state;
 	struct vring_desc_extra *desc_extra;
+	struct vring_desc_dma *desc_dma;
 
 	/* DMA address and size information */
 	dma_addr_t ring_dma_addr;
@@ -470,13 +475,14 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 					  unsigned int i)
 {
 	struct vring_desc_extra *extra = vq->split.desc_extra;
+	struct vring_desc_dma *dma = vq->split.desc_dma;
 	u16 flags;
 
 	flags = extra[i].flags;
 
 	dma_unmap_page(vring_dma_dev(vq),
-		       extra[i].addr,
-		       extra[i].len,
+		       dma[i].addr,
+		       dma[i].len,
 		       (flags & VRING_DESC_F_WRITE) ?
 		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 
@@ -533,8 +539,11 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 		next = extra[i].next;
 		desc[i].next = cpu_to_virtio16(vq->vdev, next);
 
-		extra[i].addr = addr;
-		extra[i].len = len;
+		if (vring->split.desc_dma) {
+			vring->split.desc_dma[i].addr = addr;
+			vring->split.desc_dma[i].len = len;
+		}
+
 		extra[i].flags = flags;
 	} else
 		next = virtio16_to_cpu(vq->vdev, desc[i].next);
@@ -1070,6 +1079,23 @@ static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
 	vq->free_head = 0;
 }
 
+static int vring_alloc_dma_split(struct vring_virtqueue_split *vring_split,
+				  bool need_unmap)
+{
+	u32 num = vring_split->vring.num;
+	struct vring_desc_dma *dma;
+
+	if (!need_unmap)
+		return 0;
+
+	dma = kmalloc_array(num, sizeof(struct vring_desc_dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	vring_split->desc_dma = dma;
+	return 0;
+}
+
 static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_split)
 {
 	struct vring_desc_state_split *state;
@@ -1106,6 +1132,7 @@ static void vring_free_split(struct vring_virtqueue_split *vring_split,
 
 	kfree(vring_split->desc_state);
 	kfree(vring_split->desc_extra);
+	kfree(vring_split->desc_dma);
 }
 
 static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
@@ -1207,6 +1234,10 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 	if (err)
 		goto err_state_extra;
 
+	err = vring_alloc_dma_split(&vring_split, vring_need_unmap_buffer(vq));
+	if (err)
+		goto err_state_extra;
+
 	vring_free(&vq->vq);
 
 	virtqueue_vring_init_split(&vring_split, vq);
@@ -1239,14 +1270,16 @@ static u16 packed_last_used(u16 last_used_idx)
 
 /* caller must check vring_need_unmap_buffer() */
 static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
-				     const struct vring_desc_extra *extra)
+				     unsigned int i)
 {
+	const struct vring_desc_extra *extra = &vq->packed.desc_extra[i];
+	const struct vring_desc_dma *dma = &vq->packed.desc_dma[i];
 	u16 flags;
 
 	flags = extra->flags;
 
 	dma_unmap_page(vring_dma_dev(vq),
-		       extra->addr, extra->len,
+		       dma->addr, dma->len,
 		       (flags & VRING_DESC_F_WRITE) ?
 		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
@@ -1497,8 +1530,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			desc[i].id = cpu_to_le16(id);
 
 			if (vring_need_unmap_buffer(vq)) {
-				vq->packed.desc_extra[curr].addr = addr;
-				vq->packed.desc_extra[curr].len = sg->length;
+				vq->packed.desc_dma[curr].addr = addr;
+				vq->packed.desc_dma[curr].len = sg->length;
 			}
 
 			vq->packed.desc_extra[curr].flags = le16_to_cpu(flags);
@@ -1557,7 +1590,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
+		vring_unmap_extra_packed(vq, curr);
 		curr = vq->packed.desc_extra[curr].next;
 		i++;
 		if (i >= vq->packed.vring.num)
@@ -1638,8 +1671,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (vring_need_unmap_buffer(vq)) {
 			curr = id;
 			for (i = 0; i < state->num; i++) {
-				vring_unmap_extra_packed(vq,
-							 &vq->packed.desc_extra[curr]);
+				vring_unmap_extra_packed(vq, curr);
 				curr = vq->packed.desc_extra[curr].next;
 			}
 		}
@@ -1952,6 +1984,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 
 	kfree(vring_packed->desc_state);
 	kfree(vring_packed->desc_extra);
+	kfree(vring_packed->desc_dma);
 }
 
 static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
@@ -2008,6 +2041,23 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	return -ENOMEM;
 }
 
+static int vring_alloc_dma_packed(struct vring_virtqueue_packed *vring_packed,
+				  bool need_unmap)
+{
+	u32 num = vring_packed->vring.num;
+	struct vring_desc_dma *dma;
+
+	if (!need_unmap)
+		return 0;
+
+	dma = kmalloc_array(num, sizeof(struct vring_desc_dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	vring_packed->desc_dma = dma;
+	return 0;
+}
+
 static int vring_alloc_state_extra_packed(struct vring_virtqueue_packed *vring_packed)
 {
 	struct vring_desc_state_packed *state;
@@ -2120,6 +2170,10 @@ static struct virtqueue *vring_create_virtqueue_packed(struct virtio_device *vde
 	if (err)
 		goto err_state_extra;
 
+	err = vring_alloc_dma_packed(&vring_packed, vring_need_unmap_buffer(vq));
+	if (err)
+		goto err_state_extra;
+
 	virtqueue_vring_init_packed(&vring_packed, !!cfg_vq_val(cfg, callbacks));
 
 	virtqueue_init(vq, tp_cfg->num);
@@ -2152,6 +2206,10 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	if (err)
 		goto err_state_extra;
 
+	err = vring_alloc_dma_packed(&vring_packed, vring_need_unmap_buffer(vq));
+	if (err)
+		goto err_state_extra;
+
 	vring_free(&vq->vq);
 
 	virtqueue_vring_init_packed(&vring_packed, !!vq->vq.callback);
@@ -2662,6 +2720,12 @@ static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
 		return NULL;
 	}
 
+	err = vring_alloc_dma_split(vring_split, vring_need_unmap_buffer(vq));
+	if (err) {
+		kfree(vq);
+		return NULL;
+	}
+
 	virtqueue_vring_init_split(vring_split, vq);
 
 	virtqueue_init(vq, vring_split->vring.num);
@@ -2779,6 +2843,14 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 
 	vq->premapped = true;
 
+	if (vq->packed_ring) {
+		kfree(vq->packed.desc_dma);
+		vq->packed.desc_dma = NULL;
+	} else {
+		kfree(vq->split.desc_dma);
+		vq->split.desc_dma = NULL;
+	}
+
 	END_USE(vq);
 
 	return 0;
@@ -2863,6 +2935,7 @@ static void vring_free(struct virtqueue *_vq)
 
 			kfree(vq->packed.desc_state);
 			kfree(vq->packed.desc_extra);
+			kfree(vq->packed.desc_dma);
 		} else {
 			vring_free_queue(vq->vq.vdev,
 					 vq->split.queue_size_in_bytes,
@@ -2874,6 +2947,7 @@ static void vring_free(struct virtqueue *_vq)
 	if (!vq->packed_ring) {
 		kfree(vq->split.desc_state);
 		kfree(vq->split.desc_extra);
+		kfree(vq->split.desc_dma);
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


