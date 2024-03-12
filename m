Return-Path: <netdev+bounces-79363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25AC878D8F
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 04:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39622B22233
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3023B658;
	Tue, 12 Mar 2024 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jd/Fjbn+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AECB645
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214566; cv=none; b=Civ/8wuZjGRmWDDVnB6VZXHc+miZELSobNIWG1L7jZkFZT+1U47vkgDbYbpfeZQH5kreQZvwvMZCBVHSPn2iHaI2MQI1GNNWkqiHT/sBsxKX9nsKWWP7KKEpGCiUGKDGTZW/XB2owvEuk9gb2upAG4bkakHvKsdax84tYtKelJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214566; c=relaxed/simple;
	bh=oKaobnFGEhReSZ3PYYLfgA442K2CGRadmdTwEQPZg5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnO7zd8K1u4mfkdt5bi2mk73eQg5W7/hVkUCRDexgc7aSwIBEXg1m6olZ8CW8FXoXpnkLv7r33Gg+nKZaX4qWsN1/vjVIXNBOb62y27hPj+RsC+MQbfETeHcIt9os9l/lJIvYfNS+ERmZNyPmoAldEJ8nHDYSF9n5mqQ84BB9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jd/Fjbn+; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710214562; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/cKTbFhqjH8eVqyngV6I0VXH761bF1chZCIBwHJnGgI=;
	b=jd/Fjbn+Z8qB4tKW71fRTPP56aQ2k+1A4TyOgp6NMIuLBGuM4EiBA5AWPODmkPmJW9UoFHnYaQOTBOdeYhqZElY6jWZlashUprVkBb5EIldLw3y9HbHCO1IshFji8QUtIxtsNG6+4MwKyXWzjfeS1qVcGVioF3nzqd7ZOpb4les=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W2KMV3Z_1710214560;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2KMV3Z_1710214560)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 11:36:01 +0800
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
Subject: [PATCH vhost v4 03/10] virtio_ring: packed: structure the indirect desc table
Date: Tue, 12 Mar 2024 11:35:50 +0800
Message-Id: <20240312033557.6351-4-xuanzhuo@linux.alibaba.com>
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

This commit structure the indirect desc table.
Then we can get the desc num directly when doing unmap.

And save the dma info to the struct, then the indirect
will not use the dma fields of the desc_extra. The subsequent
commits will make the dma fields are optional. But for
the indirect case, we must record the dma info.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 66 +++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0dfbd17e5a87..22a588bba166 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -72,9 +72,16 @@ struct vring_desc_state_split {
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
 };
 
+struct vring_packed_desc_indir {
+	dma_addr_t addr;		/* Descriptor Array DMA addr. */
+	u32 len;			/* Descriptor Array length. */
+	u32 num;
+	struct vring_packed_desc desc[];
+};
+
 struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
-	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
+	struct vring_packed_desc_indir *indir_desc; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
 };
@@ -1243,10 +1250,13 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
+static struct vring_packed_desc_indir *alloc_indirect_packed(unsigned int total_sg,
 						       gfp_t gfp)
 {
-	struct vring_packed_desc *desc;
+	struct vring_packed_desc_indir *in_desc;
+	u32 size;
+
+	size = struct_size(in_desc, desc, total_sg);
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -1255,9 +1265,10 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_packed_desc), gfp);
 
-	return desc;
+	in_desc = kmalloc(size, gfp);
+
+	return in_desc;
 }
 
 static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
@@ -1268,6 +1279,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 void *data,
 					 gfp_t gfp)
 {
+	struct vring_packed_desc_indir *in_desc;
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
@@ -1275,10 +1287,12 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	dma_addr_t addr;
 
 	head = vq->packed.next_avail_idx;
-	desc = alloc_indirect_packed(total_sg, gfp);
-	if (!desc)
+	in_desc = alloc_indirect_packed(total_sg, gfp);
+	if (!in_desc)
 		return -ENOMEM;
 
+	desc = in_desc->desc;
+
 	if (unlikely(vq->vq.num_free < 1)) {
 		pr_debug("Can't add buf len 1 - avail = 0\n");
 		kfree(desc);
@@ -1315,17 +1329,19 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		goto unmap_release;
 	}
 
+	if (vring_need_unmap_buffer(vq))
+		in_desc->num = i;
+
+	if (vq->use_dma_api) {
+		in_desc->addr = addr;
+		in_desc->len = total_sg * sizeof(struct vring_packed_desc);
+	}
+
 	vq->packed.vring.desc[head].addr = cpu_to_le64(addr);
 	vq->packed.vring.desc[head].len = cpu_to_le32(total_sg *
 				sizeof(struct vring_packed_desc));
 	vq->packed.vring.desc[head].id = cpu_to_le16(id);
 
-	if (vq->use_dma_api) {
-		vq->packed.desc_extra[id].addr = addr;
-		vq->packed.desc_extra[id].len = total_sg *
-				sizeof(struct vring_packed_desc);
-	}
-
 	vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
 		vq->packed.avail_used_flags;
 
@@ -1356,7 +1372,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
 	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = desc;
+	vq->packed.desc_state[id].indir_desc = in_desc;
 	vq->packed.desc_state[id].last = id;
 
 	vq->num_added += 1;
@@ -1375,7 +1391,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		vring_unmap_desc_packed(vq, &desc[i]);
 
 free_desc:
-	kfree(desc);
+	kfree(in_desc);
 
 	END_USE(vq);
 	return -ENOMEM;
@@ -1589,7 +1605,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 			      unsigned int id, void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
-	struct vring_packed_desc *desc;
 	unsigned int i, curr;
 	u16 flags;
 
@@ -1616,27 +1631,22 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (ctx)
 			*ctx = state->indir_desc;
 	} else {
-		const struct vring_desc_extra *extra;
-		u32 len;
+		struct vring_packed_desc_indir *in_desc;
+
+		in_desc = state->indir_desc;
 
 		if (vq->use_dma_api) {
-			extra = &vq->packed.desc_extra[id];
 			dma_unmap_single(vring_dma_dev(vq),
-					 extra->addr, extra->len,
+					 in_desc->addr, in_desc->len,
 					 (flags & VRING_DESC_F_WRITE) ?
 					 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 		}
 
-		/* Free the indirect table, if any, now that it's unmapped. */
-		desc = state->indir_desc;
-
 		if (vring_need_unmap_buffer(vq)) {
-			len = vq->packed.desc_extra[id].len;
-			for (i = 0; i < len / sizeof(struct vring_packed_desc);
-					i++)
-				vring_unmap_desc_packed(vq, &desc[i]);
+			for (i = 0; i < in_desc->num; i++)
+				vring_unmap_desc_packed(vq, &in_desc->desc[i]);
 		}
-		kfree(desc);
+		kfree(in_desc);
 		state->indir_desc = NULL;
 	}
 }
-- 
2.32.0.3.g01195cf9f


