Return-Path: <netdev+bounces-90806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDFF8B0409
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39FB1C2400B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 08:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC819158A26;
	Wed, 24 Apr 2024 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NcuFRgnn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D1158A0E
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946607; cv=none; b=Tgu1/vFqiyuYxAdqvXmskLkqZJTDZbna7sXCy08aQFBa9rh3wTxBpYv6M79B50JkS1SuQrV7m5F0Ay34pTvLYVgMhYs0j/QFbdm2pX5YYPBMpLdw8dU+nxtdCwJKzIKQyt/qnFCaqDeO5ynFpbHdo5SVGi4r5eqKZMKa4KFFkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946607; c=relaxed/simple;
	bh=ieRZ3HA2QQivIjLitLmjc/7hOzPAEpdLd/02bb8Yi0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGbSJ0i0GgmHAlDLVifvpPDCHaEZBKMPE93W8frwDk38qEYys0zcCwv9endftJRrc43WdykzC4lXicquK9eUVL5uLXZtAPnQuOE5O1yY0kDpNTDd+3YA4IqrTMEn513OhVDvcVeovZ03jMviurl2XjAqGKErz1oWe4XstnryK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NcuFRgnn; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713946603; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=88XV+Ekx6U1vgQf8/tacAf7IFLrUtHLQPBSapy61THE=;
	b=NcuFRgnnwo3MOu8cjPk8T6hnEQB09JiDLykDgJ/9/FdIlArxMkxDS11dKGgHHUPHO04ZIZnEz+Z/JwVwVNrfeD12Wv393uHtk2oekSwLSjDcODCfklH+OERdu28TJK+ZtndTHen1c/uxMgYEvEWTvE0Ioek45C+IlALywCb/gTw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5BhZ4x_1713946601;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5BhZ4x_1713946601)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 16:16:42 +0800
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
Subject: [PATCH vhost v3 3/4] virtio_net: rx remove premapped failover code
Date: Wed, 24 Apr 2024 16:16:35 +0800
Message-Id: <20240424081636.124029-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
References: <20240424081636.124029-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 55c7001bc45b
Content-Transfer-Encoding: 8bit

Now, the premapped mode can be enabled unconditionally.

So we can remove the failover code for merge and small mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 85 +++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 16d84c95779c..a4b924ba18d3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -213,9 +213,6 @@ struct receive_queue {
 
 	/* Record the last dma info to free after new pages is allocated. */
 	struct virtnet_rq_dma *last_dma;
-
-	/* Do dma by self */
-	bool do_dma;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -707,7 +704,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf && rq->do_dma)
+	if (buf)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -720,11 +717,6 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	u32 offset;
 	void *head;
 
-	if (!rq->do_dma) {
-		sg_init_one(rq->sg, buf, len);
-		return;
-	}
-
 	head = page_address(rq->alloc_frag.page);
 
 	offset = buf - head;
@@ -750,44 +742,42 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
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
@@ -804,12 +794,9 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	if (!vi->mergeable_rx_bufs && vi->big_packets)
 		return;
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
-
-		vi->rq[i].do_dma = true;
-	}
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		/* error never happen */
+		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
@@ -1881,8 +1868,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
-			virtnet_rq_unmap(rq, buf, 0);
+		virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -1996,8 +1982,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
-			virtnet_rq_unmap(rq, buf, 0);
+		virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -4271,7 +4256,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
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


