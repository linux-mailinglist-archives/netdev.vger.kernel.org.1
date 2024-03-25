Return-Path: <netdev+bounces-81543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B688A1B6
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517071C38294
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A9158A16;
	Mon, 25 Mar 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n4tJPQbB"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3015E5DF
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356877; cv=none; b=DgXEI9rmnOo/IVXrUTmP915AMMUfFjxeaZqWX9AiC3k1okBgmk87cpZq6uCCT9QsFWFr7n4n9LCHyW2X2sCt6/i+gvstTlwLfHSZH03tNgMRB5YDkeRT4g9+dg+Pk9MTbKjjCq4xnjVcIImXpzgdlGM5IfcPE1gymwmGtpaVY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356877; c=relaxed/simple;
	bh=c4jfFmqYnQggFPQ6Wol/611ygcSvayV7Of1tx0wDmjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ofRGAmlOinZYXp3G62+yWOVWcEtrWoz7zqJ5ZcGg8QHWyRIj8tkZdxmTSxin0EPLPdpGa//a5PAdADgnve1xC0RaTKLR4tkIsGmrqFUYxc8stXYdiKlgyo5ELxcfZi4y5r4SUkBbvHF9U/Za+5KSpsNVqr4yOlRe9y+84cC2wWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n4tJPQbB; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711356873; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IIODulX2bDUS1gdYH0/YfIZG+SUOw6BVT5FYBTh739M=;
	b=n4tJPQbB9ozlPijlt/nog3SbaMXA1H52WhlkIZbY1K5unQj3LapMS0fro16IdP7rK+r07cLgkQ8wC5zvNspt+RdkBgmVyXHAyZZep1mUPraGM8P4PvreqwgT4ZAXMQcK61TXF9elr74k2Pp85+9eMt44AfxHQEY/fMrBq/oK54M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3DYiIv_1711356872;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DYiIv_1711356872)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 16:54:32 +0800
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
Subject: [PATCH vhost v5 03/10] virtio_ring: packed: structure the indirect desc table
Date: Mon, 25 Mar 2024 16:54:21 +0800
Message-Id: <20240325085428.7275-4-xuanzhuo@linux.alibaba.com>
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
 drivers/virtio/virtio_ring.c | 61 +++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0dfbd17e5a87..cf17456f4d95 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -74,7 +74,7 @@ struct vring_desc_state_split {
 
 struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
-	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
+	struct vring_desc_extra *indir_desc; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
 };
@@ -1243,10 +1243,13 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
-						       gfp_t gfp)
+static struct vring_desc_extra *alloc_indirect_packed(unsigned int total_sg,
+						      gfp_t gfp)
 {
-	struct vring_packed_desc *desc;
+	struct vring_desc_extra *in_extra;
+	u32 size;
+
+	size = sizeof(*in_extra) + sizeof(struct vring_packed_desc) * total_sg;
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -1255,9 +1258,10 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_packed_desc), gfp);
 
-	return desc;
+	in_extra = kmalloc(size, gfp);
+
+	return in_extra;
 }
 
 static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
@@ -1268,6 +1272,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 void *data,
 					 gfp_t gfp)
 {
+	struct vring_desc_extra *in_extra;
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
@@ -1275,10 +1280,12 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	dma_addr_t addr;
 
 	head = vq->packed.next_avail_idx;
-	desc = alloc_indirect_packed(total_sg, gfp);
-	if (!desc)
+	in_extra = alloc_indirect_packed(total_sg, gfp);
+	if (!in_extra)
 		return -ENOMEM;
 
+	desc = (struct vring_packed_desc *)(in_extra + 1);
+
 	if (unlikely(vq->vq.num_free < 1)) {
 		pr_debug("Can't add buf len 1 - avail = 0\n");
 		kfree(desc);
@@ -1315,17 +1322,16 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		goto unmap_release;
 	}
 
+	if (vq->use_dma_api) {
+		in_extra->addr = addr;
+		in_extra->len = total_sg * sizeof(struct vring_packed_desc);
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
 
@@ -1356,7 +1362,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
 	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = desc;
+	vq->packed.desc_state[id].indir_desc = in_extra;
 	vq->packed.desc_state[id].last = id;
 
 	vq->num_added += 1;
@@ -1375,7 +1381,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		vring_unmap_desc_packed(vq, &desc[i]);
 
 free_desc:
-	kfree(desc);
+	kfree(in_extra);
 
 	END_USE(vq);
 	return -ENOMEM;
@@ -1589,7 +1595,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 			      unsigned int id, void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
-	struct vring_packed_desc *desc;
 	unsigned int i, curr;
 	u16 flags;
 
@@ -1616,27 +1621,27 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (ctx)
 			*ctx = state->indir_desc;
 	} else {
-		const struct vring_desc_extra *extra;
-		u32 len;
+		struct vring_desc_extra *in_extra;
+		struct vring_packed_desc *desc;
+		u32 num;
+
+		in_extra = state->indir_desc;
 
 		if (vq->use_dma_api) {
-			extra = &vq->packed.desc_extra[id];
 			dma_unmap_single(vring_dma_dev(vq),
-					 extra->addr, extra->len,
+					 in_extra->addr, in_extra->len,
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
+			num = in_extra->len / sizeof(struct vring_packed_desc);
+			desc = (struct vring_packed_desc *)(in_extra + 1);
+
+			for (i = 0; i < num; i++)
 				vring_unmap_desc_packed(vq, &desc[i]);
 		}
-		kfree(desc);
+		kfree(in_extra);
 		state->indir_desc = NULL;
 	}
 }
-- 
2.32.0.3.g01195cf9f


