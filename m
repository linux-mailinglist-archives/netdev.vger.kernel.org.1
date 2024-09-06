Return-Path: <netdev+bounces-125921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F215396F459
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D25C1C243B0
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87861A4E6E;
	Fri,  6 Sep 2024 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MyFIM6Pw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59F1CC8B7
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625910; cv=none; b=HCXVRQGyW4HpRVRnJO53e7bdDnFw7+HdduHTPW+RveRmzyT2EYGnV4IXNsHFSS3LHKiDKM+yJJwqV53q2s89oy+SCNggCeHBZEIc6AK6h32M9adPBsi/ADUFeKuELDzNnEaX36N65ONeS0BiO/CbJkFy3I9LPQaGetnZ0Gp6hyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625910; c=relaxed/simple;
	bh=cvsi0uFkpQ+U556Mwb5danntP4uMXdWjwFaw/Q68ohw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uktKNiFCDXKGunxYx58OIPcC3CdHemmxc68+nICS8H16LrOwMNYXnGS67TLgNHyhGp5JlL4eaoo4K4EkM+ER6U3sy52Laes9M6RUGFl0M02yCd/y2rG7+qpcBReJnkuLLAS/KvUOiE0+Xn53oOtloFuK2oVfKYOJfbw8yoyA954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MyFIM6Pw; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725625900; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7bAxaP5PLluKM5b7edB1EQQ3ZESyVVe4USeV4Iqfw/g=;
	b=MyFIM6PwPmIXdOTJCT6VtKkb4CMSjEY/P9UYnXuuVaLlqVJY42O4ZP5uNFTBkdoYR2rNqoP9R4QYEuD41hpIQLfdxD2JsxVJeAbYj3P4M3DgmDhplN66cPrvbne8VBLvGqIVOn/x2YX/Cquqr7fci9ixUGHQOILOH1SQZg2o1xE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEPZH3I_1725625898)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 20:31:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Darren Kenny <darren.kenny@oracle.com>,
	"Si-Wei Liu" <si-wei.liu@oracle.com>
Subject: [PATCH 1/3] Revert "virtio_net: rx remove premapped failover code"
Date: Fri,  6 Sep 2024 20:31:35 +0800
Message-Id: <20240906123137.108741-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: ccfd5e625b8b
Content-Transfer-Encoding: 8bit

This reverts commit defd28aa5acb0fd7c15adc6bc40a8ac277d04dea.

Recover the code to disable premapped mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 85 +++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f1f83d8ddbd4..36a7781979b7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -356,6 +356,9 @@ struct receive_queue {
 	struct xdp_rxq_info xsk_rxq_info;
 
 	struct xdp_buff **xsk_buffs;
+
+	/* Do dma by self */
+	bool do_dma;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -887,7 +890,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf)
+	if (buf && rq->do_dma)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -900,6 +903,11 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	u32 offset;
 	void *head;
 
+	if (!rq->do_dma) {
+		sg_init_one(rq->sg, buf, len);
+		return;
+	}
+
 	head = page_address(rq->alloc_frag.page);
 
 	offset = buf - head;
@@ -925,42 +933,44 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
 	head = page_address(alloc_frag->page);
 
-	dma = head;
+	if (rq->do_dma) {
+		dma = head;
+
+		/* new pages */
+		if (!alloc_frag->offset) {
+			if (rq->last_dma) {
+				/* Now, the new page is allocated, the last dma
+				 * will not be used. So the dma can be unmapped
+				 * if the ref is 0.
+				 */
+				virtnet_rq_unmap(rq, rq->last_dma, 0);
+				rq->last_dma = NULL;
+			}
 
-	/* new pages */
-	if (!alloc_frag->offset) {
-		if (rq->last_dma) {
-			/* Now, the new page is allocated, the last dma
-			 * will not be used. So the dma can be unmapped
-			 * if the ref is 0.
-			 */
-			virtnet_rq_unmap(rq, rq->last_dma, 0);
-			rq->last_dma = NULL;
-		}
+			dma->len = alloc_frag->size - sizeof(*dma);
 
-		dma->len = alloc_frag->size - sizeof(*dma);
+			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
+							      dma->len, DMA_FROM_DEVICE, 0);
+			if (virtqueue_dma_mapping_error(rq->vq, addr))
+				return NULL;
 
-		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
-						      dma->len, DMA_FROM_DEVICE, 0);
-		if (virtqueue_dma_mapping_error(rq->vq, addr))
-			return NULL;
+			dma->addr = addr;
+			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
 
-		dma->addr = addr;
-		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
+			/* Add a reference to dma to prevent the entire dma from
+			 * being released during error handling. This reference
+			 * will be freed after the pages are no longer used.
+			 */
+			get_page(alloc_frag->page);
+			dma->ref = 1;
+			alloc_frag->offset = sizeof(*dma);
 
-		/* Add a reference to dma to prevent the entire dma from
-		 * being released during error handling. This reference
-		 * will be freed after the pages are no longer used.
-		 */
-		get_page(alloc_frag->page);
-		dma->ref = 1;
-		alloc_frag->offset = sizeof(*dma);
+			rq->last_dma = dma;
+		}
 
-		rq->last_dma = dma;
+		++dma->ref;
 	}
 
-	++dma->ref;
-
 	buf = head + alloc_frag->offset;
 
 	get_page(alloc_frag->page);
@@ -977,9 +987,12 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	if (!vi->mergeable_rx_bufs && vi->big_packets)
 		return;
 
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		/* error should never happen */
-		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
+			continue;
+
+		vi->rq[i].do_dma = true;
+	}
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
@@ -2432,7 +2445,8 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -2546,7 +2560,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -5913,7 +5928,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].last_dma)
+			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
 				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
 		}
-- 
2.32.0.3.g01195cf9f


