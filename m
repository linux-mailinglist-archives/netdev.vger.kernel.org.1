Return-Path: <netdev+bounces-139821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806079B44C3
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D451C20C99
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B26205E00;
	Tue, 29 Oct 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D54Z/dZ0"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC120515D
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191592; cv=none; b=PkbxAxEBdI6w2h8V6s6v6s0L2qe6/bH3SWG8w/wMkq2akeUTUsz1EY681Kgxr+pERFXwGljRcZRMAb1jYC9H/I6d5g0HscVkSgtgdBLxn5od15PD4IGNO6KejVA2Wq5ZekjcjKxqNn83mrZd2ApxnPUxARfxS1LRjIA87EW+h3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191592; c=relaxed/simple;
	bh=91mrumVkdlPqeD2+dSYpUpG+Nn8EK9xVP+MqDJ5HTYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guJMHbokFobufqkJmksi+loDh8rHgXtyxrXfJjqacAj05N1j4wCemGrJGGPZJrI5nOsfEwTJwoBfCCxMsWIUTUniTBb/UvIMh9HswTbZysg42m+4U7nBZwXPu47fO/xq/GppTGunT9zRX0w5Hjwm4g23JuWJfxyiBXEXtIKNcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D54Z/dZ0; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730191580; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VS8UktA8ZNliib/aYi2nR0Q3M7Rj5h7uc2RVDMMm6KU=;
	b=D54Z/dZ0zK3u7vholYtyuJOOg63mZuPOjhHI2HKLgjtlphwh5JFpdl9aqW6WSHEP05obclSNNUEKNlrajI4ikbeM4KcoSpRgRQ9dUUaN6lqQ7yINwoHB6P7uwvc1h6pL8654ingDnuhO2s2Kji2HeQkpCci/CXj0t+ARu+x8H4E=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WI9iIYa_1730191579 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 16:46:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH net-next v1 4/4] virtio_net: rx remove premapped failover code
Date: Tue, 29 Oct 2024 16:46:15 +0800
Message-Id: <20241029084615.91049-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: df8220a5376e
Content-Transfer-Encoding: 8bit

Now, the premapped mode can be enabled unconditionally.

So we can remove the failover code for merge and small mode.

The virtnet_rq_xxx() helper would be only used if the mode is using pre
mapping. A check is added to prevent misusing of these API.

Tested-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 90 ++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ea433e9650eb..169c1aa87da5 100644
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
@@ -856,11 +853,14 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct page *page = virt_to_head_page(buf);
 	struct virtnet_rq_dma *dma;
 	void *head;
 	int offset;
 
+	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
+
 	head = page_address(page);
 
 	dma = head;
@@ -885,10 +885,13 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 
 static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
 	void *buf;
 
+	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
+
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf && rq->do_dma)
+	if (buf)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -896,15 +899,13 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 
 static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct virtnet_rq_dma *dma;
 	dma_addr_t addr;
 	u32 offset;
 	void *head;
 
-	if (!rq->do_dma) {
-		sg_init_one(rq->sg, buf, len);
-		return;
-	}
+	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
 
 	head = page_address(rq->alloc_frag.page);
 
@@ -922,50 +923,51 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 {
 	struct page_frag *alloc_frag = &rq->alloc_frag;
+	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct virtnet_rq_dma *dma;
 	void *buf, *head;
 	dma_addr_t addr;
 
+	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
+
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
@@ -2433,8 +2435,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
-			virtnet_rq_unmap(rq, buf, 0);
+		virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -2554,8 +2555,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
-			virtnet_rq_unmap(rq, buf, 0);
+		virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -5922,7 +5922,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
+			if (vi->rq[i].last_dma)
 				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
 		}
@@ -6111,11 +6111,9 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 {
 	int i;
 
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


