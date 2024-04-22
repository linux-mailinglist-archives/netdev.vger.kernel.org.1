Return-Path: <netdev+bounces-89909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E178AC2AA
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B901C20DFB
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 01:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274814400;
	Mon, 22 Apr 2024 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bWjAJIzs"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BB205E37
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 01:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713751171; cv=none; b=J/w0nYcGzCiCLunEwZNjaTb2v23z2ozCzgGFiGIRnd/WVIkmK4hP1W35OAtKxs+IIFf4HGTjt8VzOxtmE0BvGWs3sQ5vvN9Se2IFZVvZwIVwgJfyvesjSIWmoHMH0doMOUDMyA4xw31RYenOh42LhpVVcQNKiake3HSclQD0rG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713751171; c=relaxed/simple;
	bh=I/+Xr4SwTRUKrw6dXxPpOB8kt+CmoEbFuJXC//NNkUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UiHg+PdAemEtfUFyh9BFdQEXT+AvTLLLnUgNRa8kFoRQe2lkk+eAL07dEXXvgw/Jno2dnTLjnkP58Jse0GaSH0yHM8ALYfqXz4ejM1NsKX92sh33foZGN6n2f/dgsKoFDnQefp4ms4zwpFTkzAN36ui8BIF2iV136Mbrv3Q72uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bWjAJIzs; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713751167; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=o/+s6E4oLCFARZjkowI+SIEK/fKiji8BVFsnIAFrzV0=;
	b=bWjAJIzsQlBD+znF7qOC1+dZdQJ2FLtWI1Ggt3mon6vluDLUF3WoSZYd329tgxWQeGWaPC70fiLGlYZldDTanb9+vx6WQ8vPQLi4gbv9PMl/NbL27erRcLmIc6RHECiA6HcySku+uG0Jww5Tz83D6TuCc7SKxolqorpHLwtrdKU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4y5bsl_1713750848;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4y5bsl_1713750848)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 09:54:10 +0800
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
Subject: [PATCH vhost v1 4/7] virtio_net: big mode support premapped
Date: Mon, 22 Apr 2024 09:54:00 +0800
Message-Id: <20240422015403.72526-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240422015403.72526-1-xuanzhuo@linux.alibaba.com>
References: <20240422015403.72526-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 2c089e81de7e
Content-Transfer-Encoding: 8bit

In big mode, pre-mapping DMA is beneficial because if the pages are not
used, we can reuse them without needing to unmap and remap.

We require space to store the DMA address. I use the page.dma_addr to
store the DMA address from the pp structure inside the page.

Every page retrieved from get_a_page() is mapped, and its DMA address is
stored in page.dma_addr. When a page is returned to the chain, we check
the DMA status; if it is not mapped (potentially having been unmapped),
we remap it before returning it to the chain.

Based on the following points, we do not use page pool to manage these
pages:

1. virtio-net uses the DMA APIs wrapped by virtio core. Therefore,
   we can only prevent the page pool from performing DMA operations, and
   let the driver perform DMA operations on the allocated pages.
2. But when the page pool releases the page, we have no chance to
   execute dma unmap.
3. A solution to #2 is to execute dma unmap every time before putting
   the page back to the page pool. (This is actually a waste, we don't
   execute unmap so frequently.)
4. But there is another problem, we still need to use page.dma_addr to
   save the dma address. Using page.dma_addr while using page pool is
   unsafe behavior.

More:
    https://lore.kernel.org/all/CACGkMEu=Aok9z2imB_c5qVuujSh=vjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 123 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 108 insertions(+), 15 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2c7a67ad4789..75f33bbfd5fa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff *skb)
 	return (struct virtio_net_common_hdr *)skb->cb;
 }
 
+static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
+{
+	sg->dma_address = addr;
+	sg->length = len;
+}
+
+/* For pages submitted to the ring, we need to record its dma for unmap.
+ * Here, we use the page.dma_addr and page.pp_magic to store the dma
+ * address.
+ */
+static void page_chain_set_dma(struct page *p, dma_addr_t addr)
+{
+	if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
+		p->dma_addr = lower_32_bits(addr);
+		p->pp_magic = upper_32_bits(addr);
+	} else {
+		p->dma_addr = addr;
+	}
+}
+
+static dma_addr_t page_chain_get_dma(struct page *p)
+{
+	dma_addr_t addr;
+
+	if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
+		addr = p->pp_magic;
+		return (addr << 32) + p->dma_addr;
+	} else {
+		return p->dma_addr;
+	}
+}
+
+static void page_chain_sync_for_cpu(struct receive_queue *rq, struct page *p)
+{
+	virtqueue_dma_sync_single_range_for_cpu(rq->vq, page_chain_get_dma(p),
+						0, PAGE_SIZE, DMA_FROM_DEVICE);
+}
+
+static void page_chain_unmap(struct receive_queue *rq, struct page *p, bool sync)
+{
+	int attr = 0;
+
+	if (!sync)
+		attr = DMA_ATTR_SKIP_CPU_SYNC;
+
+	virtqueue_dma_unmap_page_attrs(rq->vq, page_chain_get_dma(p), PAGE_SIZE,
+				       DMA_FROM_DEVICE, attr);
+}
+
+static int page_chain_map(struct receive_queue *rq, struct page *p)
+{
+	dma_addr_t addr;
+
+	addr = virtqueue_dma_map_page_attrs(rq->vq, p, 0, PAGE_SIZE, DMA_FROM_DEVICE, 0);
+	if (virtqueue_dma_mapping_error(rq->vq, addr))
+		return -ENOMEM;
+
+	page_chain_set_dma(p, addr);
+	return 0;
+}
+
+static void page_chain_release(struct receive_queue *rq)
+{
+	struct page *p, *n;
+
+	for (p = rq->pages; p; p = n) {
+		n = page_chain_next(p);
+
+		page_chain_unmap(rq, p, true);
+		__free_pages(p, 0);
+	}
+
+	rq->pages = NULL;
+}
+
 /*
  * put the whole most recent used list in the beginning for reuse
  */
@@ -461,8 +536,15 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 		rq->pages = page_chain_next(p);
 		/* clear chain here, it is used to chain pages */
 		page_chain_add(p, NULL);
-	} else
+	} else {
 		p = alloc_page(gfp_mask);
+
+		if (page_chain_map(rq, p)) {
+			__free_pages(p, 0);
+			return NULL;
+		}
+	}
+
 	return p;
 }
 
@@ -617,9 +699,12 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		if (unlikely(!skb))
 			return NULL;
 
-		page = page_chain_next(page);
-		if (page)
-			give_pages(rq, page);
+		if (!vi->mergeable_rx_bufs) {
+			page_chain_unmap(rq, page, false);
+			page = page_chain_next(page);
+			if (page)
+				give_pages(rq, page);
+		}
 		goto ok;
 	}
 
@@ -662,6 +747,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	BUG_ON(offset >= PAGE_SIZE);
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
+
+		page_chain_unmap(rq, page, !offset);
+
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
 				frag_size, truesize);
 		len -= frag_size;
@@ -828,7 +916,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (rq->do_dma)
+	/* Skip the unmap for big mode. */
+	if (!vi->big_packets || vi->mergeable_rx_bufs)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -1351,8 +1440,12 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
-	struct sk_buff *skb =
-		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
+	struct sk_buff *skb;
+
+	/* sync first page. The follow code may read this page. */
+	page_chain_sync_for_cpu(rq, page);
+
+	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
 
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 	if (unlikely(!skb))
@@ -1901,7 +1994,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 			   gfp_t gfp)
 {
 	struct page *first, *list = NULL;
-	char *p;
+	dma_addr_t p;
 	int i, err, offset;
 
 	sg_init_table(rq->sg, vi->big_packets_num_skbfrags + 2);
@@ -1914,7 +2007,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 				give_pages(rq, list);
 			return -ENOMEM;
 		}
-		sg_set_buf(&rq->sg[i], page_address(first), PAGE_SIZE);
+		sg_fill_dma(&rq->sg[i], page_chain_get_dma(first), PAGE_SIZE);
 
 		/* chain new page in list head to match sg */
 		page_chain_add(first, list);
@@ -1926,15 +2019,16 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 		give_pages(rq, list);
 		return -ENOMEM;
 	}
-	p = page_address(first);
+
+	p = page_chain_get_dma(first);
 
 	/* rq->sg[0], rq->sg[1] share the same page */
 	/* a separated rq->sg[0] for header - required in case !any_header_sg */
-	sg_set_buf(&rq->sg[0], p, vi->hdr_len);
+	sg_fill_dma(&rq->sg[0], p, vi->hdr_len);
 
 	/* rq->sg[1] for data packet, from offset */
 	offset = sizeof(struct padded_vnet_hdr);
-	sg_set_buf(&rq->sg[1], p + offset, PAGE_SIZE - offset);
+	sg_fill_dma(&rq->sg[1], p + offset, PAGE_SIZE - offset);
 
 	/* chain first in list head */
 	page_chain_add(first, list);
@@ -2136,7 +2230,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		}
 	} else {
 		while (packets < budget &&
-		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
+		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
 			packets++;
 		}
@@ -4257,8 +4351,7 @@ static void _free_receive_bufs(struct virtnet_info *vi)
 	int i;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		while (vi->rq[i].pages)
-			__free_pages(get_a_page(&vi->rq[i], GFP_KERNEL), 0);
+		page_chain_release(&vi->rq[i]);
 
 		old_prog = rtnl_dereference(vi->rq[i].xdp_prog);
 		RCU_INIT_POINTER(vi->rq[i].xdp_prog, NULL);
-- 
2.32.0.3.g01195cf9f


