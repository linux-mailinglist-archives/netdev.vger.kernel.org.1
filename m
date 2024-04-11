Return-Path: <netdev+bounces-86831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DE58A0631
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F629288027
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211EB13B5B4;
	Thu, 11 Apr 2024 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="emG9mFmy"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A013B2B3
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803896; cv=none; b=b69Uo34Hd3QxYcgrmJDY7i+1IH+NlivLBCBFJz4+43jJLB8wyncb004MD1TOfExqxTxCpIxR56S4/5IGc31gfNgRMMd1wfhtpkJIHjF0AoZqdmdomeKG2EBMLj5atnjAmIWj6qcJk4TqYMzDiRK/qAPVLiXcTXIC6ipQ9a6sh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803896; c=relaxed/simple;
	bh=JAH3J0C69RZKF0EMhjHoKSx8Wq93bY+dmK7I8DPYSRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qvG0G4pPz/YlZbkA2KT5FtfEPrA0T3JRCbQafaaD2fOvmmBVmBU7WAyCsQqJpPmu9Ii1RbvagXFHGWsPMri3Pd12C5RiSVfPcUwgjNy7g2iIEFKseE0zs9jpPl61O17tLF4PPXbwkb9tZKeDFxNXSZ7JIqCqhWedzQCawz2peN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=emG9mFmy; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712803891; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SevIxdVrz0XPqWiY6Bt/eDEPF7ARHQIsKtanlmnGz5w=;
	b=emG9mFmyVUSrdmpQuhcl+ZkaSyXsu+fLDnuNBB3wcFOwSvcdyVaSumXevi/lzu3nEN9xW4B4NhRIKS8Ya8Xx3YJJhibjRqkqtmE1ioVTANj/uEkM8C2EgQegZPGbpU9Xc/7DB/2CHSjgX8XufrJ4Iuvgj0v/inNAkV/uwRweV0w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4JcY3O_1712803890;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4JcY3O_1712803890)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 10:51:31 +0800
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
Subject: [PATCH vhost 4/6] virtio_net: big mode support premapped
Date: Thu, 11 Apr 2024 10:51:25 +0800
Message-Id: <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aa9dfb80fb4a
Content-Transfer-Encoding: 8bit

In big mode, pre-mapping DMA is beneficial because if the pages are not
used, we can reuse them without needing to unmap and remap.

We require space to store the DMA address. I use the page.dma_addr to
store the DMA address from the pp structure inside the page.

Every page retrieved from get_a_page() is mapped, and its DMA address is
stored in page.dma_addr. When a page is returned to the chain, we check
the DMA status; if it is not mapped (potentially having been unmapped),
we remap it before returning it to the chain.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4446fb54de6d..7ea7e9bcd5d7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -50,6 +50,7 @@ module_param(napi_tx, bool, 0644);
 
 #define page_chain_next(p)	((struct page *)((p)->pp))
 #define page_chain_add(p, n)	((p)->pp = (void *)n)
+#define page_dma_addr(p)	((p)->dma_addr)
 
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
@@ -434,6 +435,46 @@ skb_vnet_common_hdr(struct sk_buff *skb)
 	return (struct virtio_net_common_hdr *)skb->cb;
 }
 
+static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
+{
+	sg->dma_address = addr;
+	sg->length = len;
+}
+
+static void page_chain_unmap(struct receive_queue *rq, struct page *p)
+{
+	virtqueue_dma_unmap_page_attrs(rq->vq, page_dma_addr(p), PAGE_SIZE,
+				       DMA_FROM_DEVICE, 0);
+
+	page_dma_addr(p) = DMA_MAPPING_ERROR;
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
+	page_dma_addr(p) = addr;
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
+		page_chain_unmap(rq, p);
+		__free_pages(p, 0);
+	}
+
+	rq->pages = NULL;
+}
+
 /*
  * put the whole most recent used list in the beginning for reuse
  */
@@ -441,6 +482,13 @@ static void give_pages(struct receive_queue *rq, struct page *page)
 {
 	struct page *end;
 
+	if (page_dma_addr(page) == DMA_MAPPING_ERROR) {
+		if (page_chain_map(rq, page)) {
+			__free_pages(page, 0);
+			return;
+		}
+	}
+
 	/* Find end of list, sew whole thing into vi->rq.pages. */
 	for (end = page; page_chain_next(end); end = page_chain_next(end));
 
@@ -456,8 +504,15 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
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
 
@@ -613,8 +668,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 			return NULL;
 
 		page = page_chain_next(page);
-		if (page)
-			give_pages(rq, page);
 		goto ok;
 	}
 
@@ -640,6 +693,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 			skb_add_rx_frag(skb, 0, page, offset, len, truesize);
 		else
 			page_to_free = page;
+		page = NULL;
 		goto ok;
 	}
 
@@ -657,6 +711,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	BUG_ON(offset >= PAGE_SIZE);
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
+
+		/* unmap the page before using it. */
+		if (!offset)
+			page_chain_unmap(rq, page);
+
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
 				frag_size, truesize);
 		len -= frag_size;
@@ -664,15 +723,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		offset = 0;
 	}
 
-	if (page)
-		give_pages(rq, page);
-
 ok:
 	hdr = skb_vnet_common_hdr(skb);
 	memcpy(hdr, hdr_p, hdr_len);
 	if (page_to_free)
 		put_page(page_to_free);
 
+	if (page)
+		give_pages(rq, page);
+
 	return skb;
 }
 
@@ -823,7 +882,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (rq->do_dma)
+	/* Skip the unmap for big mode. */
+	if (!vi->big_packets || vi->mergeable_rx_bufs)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -1346,8 +1406,12 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
-	struct sk_buff *skb =
-		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
+	struct sk_buff *skb;
+
+	/* Unmap first page. The follow code may read this page. */
+	page_chain_unmap(rq, page);
+
+	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
 
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 	if (unlikely(!skb))
@@ -1896,7 +1960,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 			   gfp_t gfp)
 {
 	struct page *first, *list = NULL;
-	char *p;
+	dma_addr_t p;
 	int i, err, offset;
 
 	sg_init_table(rq->sg, vi->big_packets_num_skbfrags + 2);
@@ -1909,7 +1973,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 				give_pages(rq, list);
 			return -ENOMEM;
 		}
-		sg_set_buf(&rq->sg[i], page_address(first), PAGE_SIZE);
+		sg_fill_dma(&rq->sg[i], page_dma_addr(first), PAGE_SIZE);
 
 		/* chain new page in list head to match sg */
 		page_chain_add(first, list);
@@ -1921,15 +1985,16 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 		give_pages(rq, list);
 		return -ENOMEM;
 	}
-	p = page_address(first);
+
+	p = page_dma_addr(first);
 
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
@@ -2131,7 +2196,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		}
 	} else {
 		while (packets < budget &&
-		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
+		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
 			packets++;
 		}
@@ -4252,8 +4317,7 @@ static void _free_receive_bufs(struct virtnet_info *vi)
 	int i;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		while (vi->rq[i].pages)
-			__free_pages(get_a_page(&vi->rq[i], GFP_KERNEL), 0);
+		page_chain_release(&vi->rq[i]);
 
 		old_prog = rtnl_dereference(vi->rq[i].xdp_prog);
 		RCU_INIT_POINTER(vi->rq[i].xdp_prog, NULL);
-- 
2.32.0.3.g01195cf9f


