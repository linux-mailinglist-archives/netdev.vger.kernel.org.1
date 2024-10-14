Return-Path: <netdev+bounces-135028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C5099BE13
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 05:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76C21F22929
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 03:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598F137775;
	Mon, 14 Oct 2024 03:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pN8t188d"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC425D8F0
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875569; cv=none; b=Wf4HTfIKZSyXbnw3x1cL7+J/Jc06+XQJKKEBaOjh1kJJLg2GqqBNpmdaz1dH8d3nmYMUPGujVQILcX+AGAQa8sjlaj7qjc3JO8jZqwXSpVMSh4lH6nDyHh8xclZUpO0kIbave+sefao/yMfxt3zYXZdhxd2IIZAV8byHVRzse+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875569; c=relaxed/simple;
	bh=oIhm1daivK/11ogqXkp0GvPygiIMR2q6YNLg9ZQ4x8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXQdRl4vv+pOK3neapHfZOHbYRZLjqzmhFAQEMZrdAqqF2b3I4nY08WTHRNjW1Bqf48y/RzkykZYhcUQsa6Rht/cDKiSJGRJQ3qpy8640tEUKPZUZCXI8T3XtZv+MWi/BsVEKuRtCCL8q0ov+4UTOJ+TdiRtoHqO25o+Y20jJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pN8t188d; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728875560; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ME97rGVXnM1xi7LnckE//Kdi+K7d+GvCGFmbbyMwvVk=;
	b=pN8t188doxzlU4FZRE30vQQ4wH9VTDJPz+4aVV/9rb6EtcS6TcBZWFw7I/kZoB60plpDe5MdIeEZkZ/XG8Js1A1M69ldy7Fr0NExQFp/U/f+27bzgkT//1TorwgyUD0C0yMHRCJZei1H0r9Oy75M02vDapPuYrSwijVGENNpJlo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WH.LEWK_1728875558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 11:12:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 5/5] virtio_net: rx remove premapped failover code
Date: Mon, 14 Oct 2024 11:12:34 +0800
Message-Id: <20241014031234.7659-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: bba499faae26
Content-Transfer-Encoding: 8bit

Now, the premapped mode can be enabled unconditionally.

So we can remove the failover code for merge and small mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 80 +++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 47 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8cf24b7b58bd..4d3e35b02478 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -356,9 +356,6 @@ struct receive_queue {
 	struct xdp_rxq_info xsk_rxq_info;
 
 	struct xdp_buff **xsk_buffs;
-
-	/* Do dma by self */
-	bool do_dma;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -899,7 +896,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf && rq->do_dma)
+	if (buf)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -912,11 +909,6 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	u32 offset;
 	void *head;
 
-	if (!rq->do_dma) {
-		sg_init_one(rq->sg, buf, len);
-		return;
-	}
-
 	head = page_address(rq->alloc_frag.page);
 
 	offset = buf - head;
@@ -939,44 +931,42 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
 	head = page_address(alloc_frag->page);
 
-	if (rq->do_dma) {
-		dma = head;
-
-		/* new pages */
-		if (!alloc_frag->offset) {
-			if (rq->last_dma) {
-				/* Now, the new page is allocated, the last dma
-				 * will not be used. So the dma can be unmapped
-				 * if the ref is 0.
-				 */
-				virtnet_rq_unmap(rq, rq->last_dma, 0);
-				rq->last_dma = NULL;
-			}
+	dma = head;
 
-			dma->len = alloc_frag->size - sizeof(*dma);
+	/* new pages */
+	if (!alloc_frag->offset) {
+		if (rq->last_dma) {
+			/* Now, the new page is allocated, the last dma
+			 * will not be used. So the dma can be unmapped
+			 * if the ref is 0.
+			 */
+			virtnet_rq_unmap(rq, rq->last_dma, 0);
+			rq->last_dma = NULL;
+		}
 
-			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
-							      dma->len, DMA_FROM_DEVICE, 0);
-			if (virtqueue_dma_mapping_error(rq->vq, addr))
-				return NULL;
+		dma->len = alloc_frag->size - sizeof(*dma);
 
-			dma->addr = addr;
-			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
+		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
+						      dma->len, DMA_FROM_DEVICE, 0);
+		if (virtqueue_dma_mapping_error(rq->vq, addr))
+			return NULL;
 
-			/* Add a reference to dma to prevent the entire dma from
-			 * being released during error handling. This reference
-			 * will be freed after the pages are no longer used.
-			 */
-			get_page(alloc_frag->page);
-			dma->ref = 1;
-			alloc_frag->offset = sizeof(*dma);
+		dma->addr = addr;
+		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
 
-			rq->last_dma = dma;
-		}
+		/* Add a reference to dma to prevent the entire dma from
+		 * being released during error handling. This reference
+		 * will be freed after the pages are no longer used.
+		 */
+		get_page(alloc_frag->page);
+		dma->ref = 1;
+		alloc_frag->offset = sizeof(*dma);
 
-		++dma->ref;
+		rq->last_dma = dma;
 	}
 
+	++dma->ref;
+
 	buf = head + alloc_frag->offset;
 
 	get_page(alloc_frag->page);
@@ -2452,8 +2442,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
-			virtnet_rq_unmap(rq, buf, 0);
+		virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -2573,8 +2562,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
-			virtnet_rq_unmap(rq, buf, 0);
+		virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -5948,7 +5936,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
+			if (vi->rq[i].last_dma)
 				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
 		}
@@ -6141,11 +6129,9 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	if (vi->mode == VIRTNET_MODE_BIG)
 		return;
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
+	for (i = 0; i < vi->max_queue_pairs; i++)
 		/* error should never happen */
 		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
-		vi->rq[i].do_dma = true;
-	}
 }
 
 static int init_vqs(struct virtnet_info *vi)
-- 
2.32.0.3.g01195cf9f


