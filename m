Return-Path: <netdev+bounces-81541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD4C88A1BB
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33221F3B625
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF621156F45;
	Mon, 25 Mar 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FGE5gLQu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F915E5C8
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356879; cv=none; b=l1xQfRJaefqETvpZkyEUBWSpSkRntfDFHrgba3SshVjm3tOdqScS7FstQ55KeyaYZm0tXERpMSRvbAeFbaVKp7aN8oG1LwcHO+vKg0eivmUr0MaOghHjhcE4UGHS3VATh0rujVIFejHE9Vk1UU2AUnG/NO0EhVIsKyFB37b71Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356879; c=relaxed/simple;
	bh=xAX0TjsOTrHXWZQghtpcGx2zNI8rDk13MpT0U8GUG/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rY0oZb6j/0juVa0HZqOEsCiCIQXb3C+hmPEROWAtiSQ2ylbYxY5chwAOUC0j4esS3wsVnU+mBhYI1PORsJDalkipkQUshLpWKn4Uh4uuT9zJ54JFhmg/wrRxygfQiR2BapuVZxa9bGdh2Po97mZH9f+qL+xs0Ybert24YQ9xikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FGE5gLQu; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711356874; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9IavLU2HzxoOaeP6Cs1b2C3W+Phxe68GTnVSjDF9qsE=;
	b=FGE5gLQufEgpvt3YFWbqZu+jsD3IvGQVm2gpjI+6cloH/L8NaT6u8MAgRWULAJuQ2WxRSgfjMt4vqr7/WvxSILY6hAoOcH+pNv5HwwlhVXlcJgEn9cI3y77Jdvcm75fWjpTlAn7gjuVtxm+AbmXlYoZg7VgP2PCQuXqWHLdgOGs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3DVfuI_1711356873;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DVfuI_1711356873)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 16:54:34 +0800
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
Subject: [PATCH vhost v5 05/10] virtio_ring: split: structure the indirect desc table
Date: Mon, 25 Mar 2024 16:54:23 +0800
Message-Id: <20240325085428.7275-6-xuanzhuo@linux.alibaba.com>
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

This commit structure the indirect desc table.
Then we can get the desc num directly when doing unmap.

And save the dma info to the struct, then the indirect
will not use the dma fields of the desc_extra. The subsequent
commits will make the dma fields are optional. But for
the indirect case, we must record the dma info.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 87 +++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 36 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a8d176abc9ea..980f81f5ab76 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -69,7 +69,7 @@
 
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
-	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	struct vring_desc_extra *indir_desc;	/* Indirect descriptor, if any. */
 };
 
 struct vring_desc_state_packed {
@@ -469,12 +469,16 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	return extra[i].next;
 }
 
-static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
-					       unsigned int total_sg,
-					       gfp_t gfp)
+static struct vring_desc_extra *alloc_indirect_split(struct virtqueue *_vq,
+						     unsigned int total_sg,
+						     gfp_t gfp)
 {
+	struct vring_desc_extra *in_extra;
 	struct vring_desc *desc;
 	unsigned int i;
+	u32 size;
+
+	size = sizeof(*in_extra) + sizeof(struct vring_desc) * total_sg;
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -483,13 +487,16 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
-	if (!desc)
+	in_extra = kmalloc(size, gfp);
+	if (!in_extra)
 		return NULL;
 
+	desc = (struct vring_desc *)(in_extra + 1);
+
 	for (i = 0; i < total_sg; i++)
 		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
-	return desc;
+
+	return in_extra;
 }
 
 static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
@@ -531,6 +538,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_desc_extra *in_extra;
 	struct scatterlist *sg;
 	struct vring_desc *desc;
 	unsigned int i, n, avail, descs_used, prev, err_idx;
@@ -553,9 +561,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	head = vq->free_head;
 
-	if (virtqueue_use_indirect(vq, total_sg))
-		desc = alloc_indirect_split(_vq, total_sg, gfp);
-	else {
+	if (virtqueue_use_indirect(vq, total_sg)) {
+		in_extra = alloc_indirect_split(_vq, total_sg, gfp);
+		if (!in_extra)
+			desc = NULL;
+		else
+			desc = (struct vring_desc *)(in_extra + 1);
+	} else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
 	}
@@ -628,10 +640,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			~VRING_DESC_F_NEXT;
 
 	if (indirect) {
+		u32 size = total_sg * sizeof(struct vring_desc);
+
 		/* Now that the indirect table is filled in, map it. */
-		dma_addr_t addr = vring_map_single(
-			vq, desc, total_sg * sizeof(struct vring_desc),
-			DMA_TO_DEVICE);
+		dma_addr_t addr = vring_map_single(vq, desc, size, DMA_TO_DEVICE);
 		if (vring_mapping_error(vq, addr)) {
 			if (!vring_need_unmap_buffer(vq))
 				goto free_indirect;
@@ -639,11 +651,18 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			goto unmap_release;
 		}
 
-		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
-					 head, addr,
-					 total_sg * sizeof(struct vring_desc),
-					 VRING_DESC_F_INDIRECT,
-					 false);
+		desc = &vq->split.vring.desc[head];
+
+		desc->flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT);
+		desc->addr = cpu_to_virtio64(_vq->vdev, addr);
+		desc->len = cpu_to_virtio32(_vq->vdev, size);
+
+		vq->split.desc_extra[head].flags = VRING_DESC_F_INDIRECT;
+
+		if (vq->use_dma_api) {
+			in_extra->addr = addr;
+			in_extra->len = size;
+		}
 	}
 
 	/* We're using some buffers from the free list. */
@@ -658,7 +677,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* Store token and indirect buffer state. */
 	vq->split.desc_state[head].data = data;
 	if (indirect)
-		vq->split.desc_state[head].indir_desc = desc;
+		vq->split.desc_state[head].indir_desc = in_extra;
 	else
 		vq->split.desc_state[head].indir_desc = ctx;
 
@@ -708,7 +727,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 free_indirect:
 	if (indirect)
-		kfree(desc);
+		kfree(in_extra);
 
 	END_USE(vq);
 	return -ENOMEM;
@@ -773,32 +792,28 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		if (ctx)
 			*ctx = vq->split.desc_state[head].indir_desc;
 	} else {
-		struct vring_desc *indir_desc =
-				vq->split.desc_state[head].indir_desc;
-		u32 len;
+		struct vring_desc_extra *in_extra;
+		struct vring_desc *desc;
+		u32 num;
 
-		if (vq->use_dma_api) {
-			struct vring_desc_extra *extra = vq->split.desc_extra;
+		in_extra = vq->split.desc_state[head].indir_desc;
 
+		if (vq->use_dma_api) {
 			dma_unmap_single(vring_dma_dev(vq),
-					 extra[i].addr,
-					 extra[i].len,
+					 in_extra->addr, in_extra->len,
 					 (flags & VRING_DESC_F_WRITE) ?
 					 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 		}
 
-		len = vq->split.desc_extra[head].len;
-
-		BUG_ON(!(vq->split.desc_extra[head].flags &
-				VRING_DESC_F_INDIRECT));
-		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
-
 		if (vring_need_unmap_buffer(vq)) {
-			for (j = 0; j < len / sizeof(struct vring_desc); j++)
-				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+			num = in_extra->len / sizeof(struct vring_desc);
+			desc = (struct vring_desc *)(in_extra + 1);
+
+			for (j = 0; j < num; j++)
+				vring_unmap_one_split_indirect(vq, &desc[j]);
 		}
 
-		kfree(indir_desc);
+		kfree(in_extra);
 		vq->split.desc_state[head].indir_desc = NULL;
 	}
 
-- 
2.32.0.3.g01195cf9f


