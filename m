Return-Path: <netdev+bounces-81542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BE988A1B4
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73E92C59F5
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43610157A55;
	Mon, 25 Mar 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TYgBxgty"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41B15ECD6
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356880; cv=none; b=gUcTtasvAw1L4mnpDITbSx1dIpvdVIKXQzqmW+KgJ9sXL5FFv3zwKak14mg6To0RUesubGssBkptYQCBYvb0TJmElIkl8CsJip0/R//K13r8aFkai4AFA4ia583AjZ5rSJHHNE8tupjXy+S2ky+C+qNkFfcf264fOukPFEO1tPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356880; c=relaxed/simple;
	bh=MmS7ChfI+8BWtZQDMl9bMpseuFcbUuboZ2gKaSLIAR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fEPmWZjMNf/qC/JTzpqdOXFcISu2z341eN0A6Id58CVvdQKr5w2qibzNjDK/QFJoudWD5Lt/Tr3W3PvhAUZVbykuzBdSBZxne6nVT8YW/ol4MiCp4G5jvVPAFS7jEVBD3aK1xpHOjlHz91zyYrxDqCJcoCZZvEVSJbMxGhxCLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TYgBxgty; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711356875; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LYjyA2QM+6eHX+8FCiMjD17IA9KEMA9CxIxZaiQCPsQ=;
	b=TYgBxgtybZaU2bqEAeSXsVGI+ZgMFIkx/yxOm+yuOF8jHePl5F+3GTCXOUhiTUCnkD6r5FQo8HvJw6hAMA/T0W0TGynky66fwN4Txibcdr3n+ZlZW4Ppbeisfj4QQsEE+u3AqyyKcs1x2NzUC6NLxsl9Ep5qQSS4pfHVjTODjdM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3DYiJp_1711356874;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DYiJp_1711356874)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 16:54:35 +0800
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
Subject: [PATCH vhost v5 06/10] virtio_ring: no store dma info when unmap is not needed
Date: Mon, 25 Mar 2024 16:54:24 +0800
Message-Id: <20240325085428.7275-7-xuanzhuo@linux.alibaba.com>
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
index 980f81f5ab76..f67f4ac2d58f 100644
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
 	virtqueue_vring_init_packed(&vring_packed, !!cfg_vq_val(cfg, callbacks));
 
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


