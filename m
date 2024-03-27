Return-Path: <netdev+bounces-82435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE9088DC41
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311772A47BB
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648595821B;
	Wed, 27 Mar 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BBxPKNTy"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018A5733F
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538084; cv=none; b=DGGqcfR2hdr+XbgdOZL7U3RAqkitXSdG9EL77AW+lgRi/xBV6UuEOnnSr9uRQiNG3qhY4UT6v73OyWejV0K68O6IM+JjXazYQauxQUG4w7c6siyV8kVsBhQ8MdtNhoB2lbhFpKVla9BXTwMljBhqoK09paRFew31I8GlJgn68WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538084; c=relaxed/simple;
	bh=0hR0dxrduViw+gUZ6+Q1O6fw8F4jTJufUStp7q7YSag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPTzNA4dSrEJOKwuFEl8HnHcCmA1D37S2UpReBIWwEPcmXO/qZRazhdzHNjzuiHG2CWVLlfLp4oHn/k9dYHUxkGyfBoODAn4TI0wnPFocnLdxjn584gDC1Pzpwbn6sVDE1vRwAfWfq9kFSSGma+9QJqpPqgFI7x/4vIsrpWxQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BBxPKNTy; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711538080; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fUeFMxF9B79ebTxY7OY1gAipRHkS1VTbWKgD5v9balo=;
	b=BBxPKNTyvSBZtSDnQOZwrvjuESqaB1xbeeChsKNz4MYooIgfXSkDlA54iEXAkcYQXQpkEof4IHu25Z1t2TbWPAmL33GTiJpLFJP6y4zlrDx7Rpz5Aw+e7r8544gI/jnpI4faAWPxzb0y6wPb0GMfnmM9dosf2TtSnWBN2nnIyFQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3OShbX_1711538079;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3OShbX_1711538079)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 19:14:39 +0800
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
Subject: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
Date: Wed, 27 Mar 2024 19:14:29 +0800
Message-Id: <20240327111430.108787-10-xuanzhuo@linux.alibaba.com>
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

Now, the virtio core can set the premapped mode by find_vqs().
If the premapped can be enabled, the dma array will not be
allocated. So virtio-net use the api of find_vqs to enable the
premapped.

Judge the premapped mode by the vq->premapped instead of saving
local variable.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c      | 57 +++++++++++++++++------------------
 include/linux/virtio_config.h | 16 ++--------
 2 files changed, 29 insertions(+), 44 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..107aef2c9458 100644
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
+	if (buf && rq->vq->premapped)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -720,7 +717,7 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	u32 offset;
 	void *head;
 
-	if (!rq->do_dma) {
+	if (!rq->vq->premapped) {
 		sg_init_one(rq->sg, buf, len);
 		return;
 	}
@@ -750,7 +747,7 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
 	head = page_address(alloc_frag->page);
 
-	if (rq->do_dma) {
+	if (rq->vq->premapped) {
 		dma = head;
 
 		/* new pages */
@@ -796,22 +793,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 	return buf;
 }
 
-static void virtnet_rq_set_premapped(struct virtnet_info *vi)
-{
-	int i;
-
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
-
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
-
-		vi->rq[i].do_dma = true;
-	}
-}
-
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
@@ -820,7 +801,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (rq->do_dma)
+	if (rq->vq->premapped)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -1881,7 +1862,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
+		if (rq->vq->premapped)
 			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
@@ -1996,7 +1977,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		if (rq->do_dma)
+		if (rq->vq->premapped)
 			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
@@ -4271,7 +4252,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
+			if (vi->rq[i].vq->premapped && vi->rq[i].last_dma)
 				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
 		}
@@ -4335,11 +4316,13 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
 
 static int virtnet_find_vqs(struct virtnet_info *vi)
 {
+	struct virtio_vq_config cfg = {};
 	vq_callback_t **callbacks;
 	struct virtqueue **vqs;
 	const char **names;
 	int ret = -ENOMEM;
 	int total_vqs;
+	bool *premapped;
 	bool *ctx;
 	u16 i;
 
@@ -4364,8 +4347,13 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 		ctx = kcalloc(total_vqs, sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
 			goto err_ctx;
+
+		premapped = kcalloc(total_vqs, sizeof(*premapped), GFP_KERNEL);
+		if (!ctx)
+			goto err_premapped;
 	} else {
 		ctx = NULL;
+		premapped = NULL;
 	}
 
 	/* Parameters for control virtqueue, if any */
@@ -4384,10 +4372,19 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 		names[txq2vq(i)] = vi->sq[i].name;
 		if (ctx)
 			ctx[rxq2vq(i)] = true;
+
+		if (premapped)
+			premapped[rxq2vq(i)] = true;
 	}
 
-	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
-				  names, ctx, NULL);
+	cfg.nvqs      = total_vqs;
+	cfg.vqs       = vqs;
+	cfg.callbacks = callbacks;
+	cfg.names     = names;
+	cfg.ctx       = ctx;
+	cfg.premapped = premapped;
+
+	ret = virtio_find_vqs_cfg(vi->vdev, &cfg);
 	if (ret)
 		goto err_find;
 
@@ -4407,6 +4404,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 
 err_find:
+	kfree(premapped);
+err_premapped:
 	kfree(ctx);
 err_ctx:
 	kfree(names);
@@ -4479,8 +4478,6 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
-	virtnet_rq_set_premapped(vi);
-
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
 	cpus_read_unlock();
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 80b7974ca9ff..dc7f4067a171 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -267,21 +267,9 @@ int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 }
 
 static inline
-int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
-			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char *names[], const bool *ctx,
-			struct irq_affinity *desc)
+int virtio_find_vqs_cfg(struct virtio_device *vdev, struct virtio_vq_config *cfg)
 {
-	struct virtio_vq_config cfg = {};
-
-	cfg.nvqs = nvqs;
-	cfg.vqs = vqs;
-	cfg.callbacks = callbacks;
-	cfg.names = names;
-	cfg.ctx = ctx;
-	cfg.desc = desc;
-
-	return vdev->config->find_vqs(vdev, &cfg);
+	return vdev->config->find_vqs(vdev, cfg);
 }
 
 /**
-- 
2.32.0.3.g01195cf9f


