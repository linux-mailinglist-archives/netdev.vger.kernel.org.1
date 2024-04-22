Return-Path: <netdev+bounces-89966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EEA8AC57D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB57B2196A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 07:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DCE51034;
	Mon, 22 Apr 2024 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WsgfDJe4"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6594502B9
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770661; cv=none; b=NGJTR6+kI9Gk1iCpMbEHjGfzI44mb7gdURKwZRRVY3CTZolAEa7OgnF7pVZ5wsXRi3qB+0Uw+YFiaoqrCcwhSc4s2Zfj91Q59PKIhuBCMXbF9e5qTbxTdJmYHpO33kSeHP+qjbY2VstrsXvq88n+7LxEtZKt4nGUzhoShIE4gEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770661; c=relaxed/simple;
	bh=T57i4S+hFuEEJAarRQFX1fCsVPPwIHXeM401eZY6yT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ju+NQx+St3tGVmeNUSgUUh8WJQQIrdx48Np0y+3NvXvzMax+yf+anI7771GlCp7p60pBHRhc/Kw4V0h6/yzNY3tg8nJEtTJlttvEBt6209uRQUiA/ji59oZ2K283GRpZ9TIlmLw+AIVEzSvvz99Vp9g0+QSK7tO6fQRDQA/XJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WsgfDJe4; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713770657; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=T2DlyIjNdC2EZeZRVRT33XXBWFz/h54eq0REapQRDvo=;
	b=WsgfDJe4bcmaQ6bfTJPi+MPkWJi96kW5hS7g3JHP8ZeYTjcp/vRZJsLrV4Ue3wYbk/NGlunqnzLkemgN9wVQR++YtT/8In6qqc4+yC8vDCuRyzuw6GInT1DQ28xfHpbEq/MmswAyZVlI4a8K1mztc3k/FbmwNi3byvxIZSKV0cg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5.r0H-_1713770655;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5.r0H-_1713770655)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 15:24:16 +0800
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
Subject: [PATCH vhost v2 6/7] virtio_net: rx remove premapped failover code
Date: Mon, 22 Apr 2024 15:24:07 +0800
Message-Id: <20240422072408.126821-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aa968d36d784
Content-Transfer-Encoding: 8bit

Now, the premapped mode can be enabled unconditionally.

So we can remove the failover code.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 81 ++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 48 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f04b10426b8f..848e93ccf2ef 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -221,9 +221,6 @@ struct receive_queue {
 
 	/* Record the last dma info to free after new pages is allocated. */
 	struct virtnet_rq_dma *last_dma;
-
-	/* Do dma by self */
-	bool do_dma;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -803,7 +800,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf && rq->do_dma)
+	if (buf)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -816,11 +813,6 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	u32 offset;
 	void *head;
 
-	if (!rq->do_dma) {
-		sg_init_one(rq->sg, buf, len);
-		return;
-	}
-
 	head = page_address(rq->alloc_frag.page);
 
 	offset = buf - head;
@@ -846,44 +838,42 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
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
@@ -896,12 +886,9 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 {
 	int i;
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
+	for (i = 0; i < vi->max_queue_pairs; i++)
 		/* error never happen */
 		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
-
-		vi->rq[i].do_dma = true;
-	}
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
@@ -1978,8 +1965,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
-			virtnet_rq_unmap(rq, buf, 0);
+		virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -2094,8 +2080,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
-			virtnet_rq_unmap(rq, buf, 0);
+		virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -4368,7 +4353,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
+			if (vi->rq[i].last_dma)
 				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
 		}
-- 
2.32.0.3.g01195cf9f


