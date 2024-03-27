Return-Path: <netdev+bounces-82429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112C88DC35
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E472A436B
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5B56741;
	Wed, 27 Mar 2024 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GZr7N57H"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997B55E7E
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538079; cv=none; b=o7NwnLtQ2VokS4PTF9QRk3hpAiJwaLV6gE6B0NLVU/1UxmWpLozLctZ78dHEnITMbBnrz2quyvZ0Qv8yRsRb758j6pPQ9HcO8bwZp4c8sEu5MLd+wKHkX1MRgGMdkiS2rRG9qd53pf2llXmoTmw1zTdLoDf2SR9MlAfTLf8XbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538079; c=relaxed/simple;
	bh=5uP8KFOvK406RMHSrdyzwJ6dqoHFrQVr8zyvunT2EKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXD9Ex0FOWGeOTQHwPCtYJmQZlnKHutiOaamlQ7LrKgoKXN14I9Jzs3SYwnSSOCcesH28C5jAwXeFz8tGu00ACiMlyAjYSlatYFUqcNjDMYEAukHFKABtxNUCA28bg9rDWqJG7U1dLqqu9Lg+UTQZh0LSKGOT18NMpjCwH6aRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GZr7N57H; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711538075; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=enPNcEXtfQSff5GHS5bKVLYi8CQt1bf7FpeaAMOd7sU=;
	b=GZr7N57H+CZWAJlUOKcnGjyczfuwqL0LMDlYtCfvOkui4O132xO+h078JzL8wEoLf7jpExv0H0kDG1EkdkzdhZD5WVjAmpMW9/4o6vviJklEahHNKa6SVL0zKDavQAeqbm/PbHMoBCLZJVKaSHx/CplHcDa8WdLnGFNmEw3xvhY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3OcItR_1711538074;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3OcItR_1711538074)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 19:14:35 +0800
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
Subject: [PATCH vhost v6 04/10] virtio_ring: split: remove double check of the unmap ops
Date: Wed, 27 Mar 2024 19:14:24 +0800
Message-Id: <20240327111430.108787-5-xuanzhuo@linux.alibaba.com>
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

In the functions vring_unmap_one_split and
vring_unmap_one_split_indirect,
multiple checks are made whether unmap is performed and whether it is
INDIRECT.

These two functions are usually called in a loop, and we should put the
check outside the loop.

And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
other descs, that make the thing more complex. If we distinguish the
descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.

For desc with VRING_DESC_F_INDIRECT flag:
1. only one desc of the desc table is used, we do not need the loop
    Theoretically, indirect descriptors could be chained.
    But now, that is not supported by "add", so we ignore this case.
2. the called unmap api is difference from the other desc
3. the vq->premapped is not needed to check
4. the vq->indirect is not needed to check
5. the state->indir_desc must not be null

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 79 +++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e3343cf55774..8170761ab25e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -443,9 +443,6 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 {
 	u16 flags;
 
-	if (!vring_need_unmap_buffer(vq))
-		return;
-
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
 	dma_unmap_page(vring_dma_dev(vq),
@@ -463,27 +460,12 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 
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
 
@@ -651,7 +633,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			vq, desc, total_sg * sizeof(struct vring_desc),
 			DMA_TO_DEVICE);
 		if (vring_mapping_error(vq, addr)) {
-			if (vq->premapped)
+			if (!vring_need_unmap_buffer(vq))
 				goto free_indirect;
 
 			goto unmap_release;
@@ -704,6 +686,9 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return 0;
 
 unmap_release:
+
+	WARN_ON(!vring_need_unmap_buffer(vq));
+
 	err_idx = i;
 
 	if (indirect)
@@ -765,34 +750,42 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
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
 
@@ -807,9 +800,13 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
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


