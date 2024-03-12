Return-Path: <netdev+bounces-79364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79465878D90
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 04:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E553C1F22BFA
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A5BE6D;
	Tue, 12 Mar 2024 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LSwIkd7P"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C960BA28
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214567; cv=none; b=XYFF2KwZ5A8NnJxka/95R5fwwAhPXG6f0MsoBuwqnZbTzA7bVQ5nlw/5t9UF9d6VQRnny5z34+6VgjldGGrN1OGVWokjqc27aQQSxrFKFtm25CbQpjRcrhli1+o0HDbrfnjQUK9L2O0/2jkVi/Gx6HW9ZcWCLU5A0jsmyU/mi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214567; c=relaxed/simple;
	bh=BcBPOJv7EJTw/xy1tWhrC51xg16GaOnVm8gjoa1LFQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS6ddke0Jmi9uZLq3uEgiy0CBw//LBnn/1IlZ0udtr+TrNwsW3eoWiMydb4dpqExulbOOUnrJW9l85sKEDRGMq8yeJmqaqPjLeLP+3I8bHTl9oHWA3GSsyJI4RgW/4KR8Bu9PjDtx8WxeKNl/M1uFbZ3eWedM3JxKKHnWrmj4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LSwIkd7P; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710214563; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jtACpbxbi0FGq/bRLLdhvqxPTnlqClung9fvyH7Efxk=;
	b=LSwIkd7PpX6YXX3CV8GuI8pT6G34S05dgncyaN32c3lc9BoytQSgVBL49ZOsWoxm8udWRlT5f98uu54NpfXii7Jz5HvPAH+4sou0/vDNR2c2xJtB4/XaQtinv9fFKRVB3tryPUSmbQkTtOS8Tu3HHxJiLe+jxodjdhhoOdTtbiI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W2KFrBx_1710214561;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2KFrBx_1710214561)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 11:36:02 +0800
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
Subject: [PATCH vhost v4 04/10] virtio_ring: split: remove double check of the unmap ops
Date: Tue, 12 Mar 2024 11:35:51 +0800
Message-Id: <20240312033557.6351-5-xuanzhuo@linux.alibaba.com>
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

In the functions vring_unmap_one_split and
vring_unmap_one_split_indirect,
multiple checks are made whether unmap is performed and whether it is
INDIRECT.

These two functions are usually called in a loop, and we should put the
check outside the loop.

And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
other descs, that make the thing more complex. If we distinguish the
descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.

1. only one desc of the desc table is used, we do not need the loop
2. the called unmap api is difference from the other desc
3. the vq->premapped is not needed to check
4. the vq->indirect is not needed to check
5. the state->indir_desc must not be null

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 79 +++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 22a588bba166..9d5a9b907a2e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -450,9 +450,6 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 {
 	u16 flags;
 
-	if (!vring_need_unmap_buffer(vq))
-		return;
-
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
 	dma_unmap_page(vring_dma_dev(vq),
@@ -470,27 +467,12 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 
 	flags = extra[i].flags;
 
-	if (flags & VRING_DESC_F_INDIRECT) {
-		if (!vq->use_dma_api)
-			goto out;
-
-		dma_unmap_single(vring_dma_dev(vq),
-				 extra[i].addr,
-				 extra[i].len,
-				 (flags & VRING_DESC_F_WRITE) ?
-				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		if (!vring_need_unmap_buffer(vq))
-			goto out;
-
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra[i].addr,
-			       extra[i].len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
+	dma_unmap_page(vring_dma_dev(vq),
+		       extra[i].addr,
+		       extra[i].len,
+		       (flags & VRING_DESC_F_WRITE) ?
+		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 
-out:
 	return extra[i].next;
 }
 
@@ -658,7 +640,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			vq, desc, total_sg * sizeof(struct vring_desc),
 			DMA_TO_DEVICE);
 		if (vring_mapping_error(vq, addr)) {
-			if (vq->premapped)
+			if (!vring_need_unmap_buffer(vq))
 				goto free_indirect;
 
 			goto unmap_release;
@@ -711,6 +693,9 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return 0;
 
 unmap_release:
+
+	WARN_ON(!vring_need_unmap_buffer(vq));
+
 	err_idx = i;
 
 	if (indirect)
@@ -772,34 +757,42 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
+	u16 flags;
 
 	/* Clear data ptr. */
 	vq->split.desc_state[head].data = NULL;
+	flags = vq->split.desc_extra[head].flags;
 
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
-	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
-		i = vq->split.desc_extra[i].next;
-		vq->vq.num_free++;
-	}
-
-	vring_unmap_one_split(vq, i);
-	vq->split.desc_extra[i].next = vq->free_head;
-	vq->free_head = head;
+	if (!(flags & VRING_DESC_F_INDIRECT)) {
+		while (vq->split.vring.desc[i].flags & nextflag) {
+			if (vring_need_unmap_buffer(vq))
+				vring_unmap_one_split(vq, i);
+			i = vq->split.desc_extra[i].next;
+			vq->vq.num_free++;
+		}
 
-	/* Plus final descriptor */
-	vq->vq.num_free++;
+		if (vring_need_unmap_buffer(vq))
+			vring_unmap_one_split(vq, i);
 
-	if (vq->indirect) {
+		if (ctx)
+			*ctx = vq->split.desc_state[head].indir_desc;
+	} else {
 		struct vring_desc *indir_desc =
 				vq->split.desc_state[head].indir_desc;
 		u32 len;
 
-		/* Free the indirect table, if any, now that it's unmapped. */
-		if (!indir_desc)
-			return;
+		if (vq->use_dma_api) {
+			struct vring_desc_extra *extra = vq->split.desc_extra;
+
+			dma_unmap_single(vring_dma_dev(vq),
+					 extra[i].addr,
+					 extra[i].len,
+					 (flags & VRING_DESC_F_WRITE) ?
+					 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		}
 
 		len = vq->split.desc_extra[head].len;
 
@@ -814,9 +807,13 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 		kfree(indir_desc);
 		vq->split.desc_state[head].indir_desc = NULL;
-	} else if (ctx) {
-		*ctx = vq->split.desc_state[head].indir_desc;
 	}
+
+	vq->split.desc_extra[i].next = vq->free_head;
+	vq->free_head = head;
+
+	/* Plus final descriptor */
+	vq->vq.num_free++;
 }
 
 static bool more_used_split(const struct vring_virtqueue *vq)
-- 
2.32.0.3.g01195cf9f


