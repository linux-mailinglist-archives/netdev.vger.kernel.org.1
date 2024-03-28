Return-Path: <netdev+bounces-82431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE888DC3A
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08C41C284EF
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1F5730B;
	Wed, 27 Mar 2024 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tt1FeJG+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D256479
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538082; cv=none; b=unrsXpe9DTJIQ0yMsH1fti6gkrwCgeBafBoTq5dQ2qjHmPVk47oMeNaROu2nItDWTdum+zwZIuo5iGvNw0/ECtzycxrlEsBLU1WP+31tlOH0Gtp9LU/QoSio9rmg5Il55K/qdft8RnjTC2KofdamdTKAx9uWJfXUP402VYcbKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538082; c=relaxed/simple;
	bh=F3dXXK16aRHe2MtpxZoRZH1kPBmPFdhSyyAWL7zgTxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kw8U04edb2NcxrSxOpwSkWKipW+N/pnQXUFeU35KCkQxQDzhsTl5PO5TDitOz2u6xI2HslHukrdUYVuvhA9cSl8vSOzxPwwE9eEsoTycVZ2s9pz3GaruyttatNSoaXY3ErYcADFSu2XMlnPSJbC0x884BT3Xdxj9wtHPUnZMBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tt1FeJG+; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711538077; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ywp9jbBQA4G4+tP7D8tCd13O8fQ9Q3qFG9xdcFLtsEs=;
	b=Tt1FeJG+cj2g5FywACxQ6mRrJyEOUDpq/JEjCy1rbdJdr+4dm/uPxSpVvujUbCNwxRjmwTfHkvH1H+aFp27P/h7IEjHEYFXEWR0qv7Aq2htfwYMgrF1eKvHMOV0zG5ItOug0XX3/CUi9nqT+d1dV1Et245oOI5HBcxNLoxKh3iQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3ObwS0_1711538076;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3ObwS0_1711538076)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 19:14:37 +0800
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
Subject: [PATCH vhost v6 06/10] virtio_ring: no store dma info when unmap is not needed
Date: Wed, 27 Mar 2024 19:14:26 +0800
Message-Id: <20240327111430.108787-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e859552de2d6
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
 drivers/virtio/virtio_ring.c | 120 ++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1f7c96543d58..08e4f6e1d722 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -69,23 +69,26 @@
 
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
-	struct vring_desc_extra *indir_desc;	/* Indirect descriptor, if any. */
+	struct vring_desc_dma *indir_desc;	/* Indirect descriptor, if any. */
 };
 
 struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
-	struct vring_desc_extra *indir_desc; /* Indirect descriptor, if any. */
+	struct vring_desc_dma *indir_desc; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
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
@@ -102,6 +105,7 @@ struct vring_virtqueue_split {
 	/* Per-descriptor state. */
 	struct vring_desc_state_split *desc_state;
 	struct vring_desc_extra *desc_extra;
+	struct vring_desc_dma *desc_dma;
 
 	/* DMA address and size information */
 	dma_addr_t queue_dma_addr;
@@ -142,6 +146,7 @@ struct vring_virtqueue_packed {
 	/* Per-descriptor state. */
 	struct vring_desc_state_packed *desc_state;
 	struct vring_desc_extra *desc_extra;
+	struct vring_desc_dma *desc_dma;
 
 	/* DMA address and size information */
 	dma_addr_t ring_dma_addr;
@@ -456,24 +461,25 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
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
 
 	return extra[i].next;
 }
 
-static struct vring_desc_extra *alloc_indirect_split(struct virtqueue *_vq,
+static struct vring_desc_dma *alloc_indirect_split(struct virtqueue *_vq,
 						     unsigned int total_sg,
 						     gfp_t gfp)
 {
-	struct vring_desc_extra *in_extra;
+	struct vring_desc_dma *in_extra;
 	struct vring_desc *desc;
 	unsigned int i;
 	u32 size;
@@ -519,8 +525,11 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
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
@@ -538,7 +547,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	struct vring_desc_extra *in_extra;
+	struct vring_desc_dma *in_extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
 	unsigned int i, n, avail, descs_used, prev, err_idx;
@@ -792,7 +801,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		if (ctx)
 			*ctx = vq->split.desc_state[head].indir_desc;
 	} else {
-		struct vring_desc_extra *in_extra;
+		struct vring_desc_dma *in_extra;
 		struct vring_desc *desc;
 		u32 num;
 
@@ -1059,6 +1068,23 @@ static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
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
@@ -1095,6 +1121,7 @@ static void vring_free_split(struct vring_virtqueue_split *vring_split,
 
 	kfree(vring_split->desc_state);
 	kfree(vring_split->desc_extra);
+	kfree(vring_split->desc_dma);
 }
 
 static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
@@ -1196,6 +1223,10 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 	if (err)
 		goto err_state_extra;
 
+	err = vring_alloc_dma_split(&vring_split, vring_need_unmap_buffer(vq));
+	if (err)
+		goto err_state_extra;
+
 	vring_free(&vq->vq);
 
 	virtqueue_vring_init_split(&vring_split, vq);
@@ -1228,14 +1259,16 @@ static u16 packed_last_used(u16 last_used_idx)
 
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
@@ -1255,10 +1288,10 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static struct vring_desc_extra *alloc_indirect_packed(unsigned int total_sg,
+static struct vring_desc_dma *alloc_indirect_packed(unsigned int total_sg,
 						      gfp_t gfp)
 {
-	struct vring_desc_extra *in_extra;
+	struct vring_desc_dma *in_extra;
 	u32 size;
 
 	size = sizeof(*in_extra) + sizeof(struct vring_packed_desc) * total_sg;
@@ -1284,7 +1317,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 void *data,
 					 gfp_t gfp)
 {
-	struct vring_desc_extra *in_extra;
+	struct vring_desc_dma *in_extra;
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
@@ -1483,8 +1516,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			desc[i].id = cpu_to_le16(id);
 
 			if (vring_need_unmap_buffer(vq)) {
-				vq->packed.desc_extra[curr].addr = addr;
-				vq->packed.desc_extra[curr].len = sg->length;
+				vq->packed.desc_dma[curr].addr = addr;
+				vq->packed.desc_dma[curr].len = sg->length;
 			}
 
 			vq->packed.desc_extra[curr].flags = le16_to_cpu(flags);
@@ -1543,7 +1576,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
+		vring_unmap_extra_packed(vq, curr);
 		curr = vq->packed.desc_extra[curr].next;
 		i++;
 		if (i >= vq->packed.vring.num)
@@ -1624,8 +1657,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (vring_need_unmap_buffer(vq)) {
 			curr = id;
 			for (i = 0; i < state->num; i++) {
-				vring_unmap_extra_packed(vq,
-							 &vq->packed.desc_extra[curr]);
+				vring_unmap_extra_packed(vq, curr);
 				curr = vq->packed.desc_extra[curr].next;
 			}
 		}
@@ -1633,7 +1665,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (ctx)
 			*ctx = state->indir_desc;
 	} else {
-		struct vring_desc_extra *in_extra;
+		struct vring_desc_dma *in_extra;
 		struct vring_packed_desc *desc;
 		u32 num;
 
@@ -1943,6 +1975,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 
 	kfree(vring_packed->desc_state);
 	kfree(vring_packed->desc_extra);
+	kfree(vring_packed->desc_dma);
 }
 
 static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
@@ -1999,6 +2032,23 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
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
@@ -2111,6 +2161,10 @@ static struct virtqueue *vring_create_virtqueue_packed(struct virtio_device *vde
 	if (err)
 		goto err_state_extra;
 
+	err = vring_alloc_dma_packed(&vring_packed, vring_need_unmap_buffer(vq));
+	if (err)
+		goto err_state_extra;
+
 	virtqueue_vring_init_packed(&vring_packed, !!cfg_vq_val(cfg, vq, callbacks));
 
 	virtqueue_init(vq, tp_cfg->num);
@@ -2143,6 +2197,10 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	if (err)
 		goto err_state_extra;
 
+	err = vring_alloc_dma_packed(&vring_packed, vring_need_unmap_buffer(vq));
+	if (err)
+		goto err_state_extra;
+
 	vring_free(&vq->vq);
 
 	virtqueue_vring_init_packed(&vring_packed, !!vq->vq.callback);
@@ -2653,6 +2711,12 @@ static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
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
@@ -2770,6 +2834,14 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 
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
@@ -2854,6 +2926,7 @@ static void vring_free(struct virtqueue *_vq)
 
 			kfree(vq->packed.desc_state);
 			kfree(vq->packed.desc_extra);
+			kfree(vq->packed.desc_dma);
 		} else {
 			vring_free_queue(vq->vq.vdev,
 					 vq->split.queue_size_in_bytes,
@@ -2865,6 +2938,7 @@ static void vring_free(struct virtqueue *_vq)
 	if (!vq->packed_ring) {
 		kfree(vq->split.desc_state);
 		kfree(vq->split.desc_extra);
+		kfree(vq->split.desc_dma);
 	}
 }
 
-- 
2.32.0.3.g01195cf9f


