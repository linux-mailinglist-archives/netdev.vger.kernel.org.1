Return-Path: <netdev+bounces-46156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5667E1BCB
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22B91C209E4
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73240EAD8;
	Mon,  6 Nov 2023 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBCFBFA
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 08:18:39 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BA8B0
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 00:18:37 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VvkMuOG_1699258712;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VvkMuOG_1699258712)
          by smtp.aliyun-inc.com;
          Mon, 06 Nov 2023 16:18:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux-foundation.org
Subject: [PATCH net] virtio_net: fix missing dma unmap for resize
Date: Mon,  6 Nov 2023 16:18:32 +0800
Message-Id: <20231106081832.668-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: af4189b303fe
Content-Transfer-Encoding: 8bit

For rq, we have three cases getting buffers from virtio core:

1. virtqueue_get_buf{,_ctx}
2. virtqueue_detach_unused_buf
3. callback for virtqueue_resize

But in commit 295525e29a5b("virtio_net: merge dma operations when
filling mergeable buffers"), I missed the dma unmap for the #3 case.

That will leak some memory, because I did not release the pages referred
by the unused buffers.

If we do such script, we will make the system OOM.

    while true
    do
            ethtool -G ens4 rx 128
            ethtool -G ens4 rx 256
            free -m
    done

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 43 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d16f592c2061..6423a3a007ce 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -408,6 +408,17 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 	return p;
 }
 
+static void virtnet_rq_free_buf(struct virtnet_info *vi,
+				struct receive_queue *rq, void *buf)
+{
+	if (vi->mergeable_rx_bufs)
+		put_page(virt_to_head_page(buf));
+	else if (vi->big_packets)
+		give_pages(rq, buf);
+	else
+		put_page(virt_to_head_page(buf));
+}
+
 static void enable_delayed_refill(struct virtnet_info *vi)
 {
 	spin_lock_bh(&vi->refill_lock);
@@ -634,17 +645,6 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	return buf;
 }
 
-static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
-{
-	void *buf;
-
-	buf = virtqueue_detach_unused_buf(rq->vq);
-	if (buf && rq->do_dma)
-		virtnet_rq_unmap(rq, buf, 0);
-
-	return buf;
-}
-
 static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 {
 	struct virtnet_rq_dma *dma;
@@ -1764,7 +1764,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
 		DEV_STATS_INC(dev, rx_length_errors);
-		virtnet_rq_free_unused_buf(rq->vq, buf);
+		virtnet_rq_free_buf(vi, rq, buf);
 		return;
 	}
 
@@ -4034,14 +4034,15 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
+	struct receive_queue *rq;
 	int i = vq2rxq(vq);
 
-	if (vi->mergeable_rx_bufs)
-		put_page(virt_to_head_page(buf));
-	else if (vi->big_packets)
-		give_pages(&vi->rq[i], buf);
-	else
-		put_page(virt_to_head_page(buf));
+	rq = &vi->rq[i];
+
+	if (rq->do_dma)
+		virtnet_rq_unmap(rq, buf, 0);
+
+	virtnet_rq_free_buf(vi, rq, buf);
 }
 
 static void free_unused_bufs(struct virtnet_info *vi)
@@ -4057,10 +4058,10 @@ static void free_unused_bufs(struct virtnet_info *vi)
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
+		struct virtqueue *vq = vi->rq[i].vq;
 
-		while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
-			virtnet_rq_free_unused_buf(rq->vq, buf);
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_rq_free_unused_buf(vq, buf);
 		cond_resched();
 	}
 }
-- 
2.32.0.3.g01195cf9f


