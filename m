Return-Path: <netdev+bounces-89904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBB68AC29D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378FDB20A52
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 01:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053974400;
	Mon, 22 Apr 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DPEUzc/O"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB894C65
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713750859; cv=none; b=uJPdaefRNuCnF3PM77IE2pi4tym9WJlDdvFfdUT/KmE3ILlZixHTkbhFN+hV47ZPR6qSqS1jAz8Qa4Zq1kd32jkHYiNaU/y3hVPImzZd9D0qlVmspLoTvF0TPKyQCvWdNGSffIreyibQ6JSNaPO54on4glna/ocM05XkM34vsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713750859; c=relaxed/simple;
	bh=gdHESuJyO226XLT6IWnJgIW1k9TxKZVwRi8aj7P3lAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNtHCbJFjjNJOYTFAPBmEsEUQOlYvgT/xqwqlinDjdkPefRAlrTvcbnKPPHCzV/pl7lDC0y7t3HCnfV6HYleKRgmc3f+Mrh/IoELImsJFApgYZRhldHM/0l08rILu5MCSCU2cnyRnwC4bAy693ggmBOrPMB8VCQJ+37HEA2d3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DPEUzc/O; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713750850; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7vayq+l1KamS3AW4JkAfgCLE++jtcAZ089i7qobCbfQ=;
	b=DPEUzc/Oyk5dKD7iDnlGiS0Ufi6wYyTejVxCUHWspUmPYLQAxW3ch2MfeVlwJdDG/iXF3ORiEEmCF6kxDt0ZpanRcWapHmfbekLZ1Yl7LIg+T4rL21lJhIuLLk04FLGW7hIj56Y4QyR1evyedJNbwKhRR1V7KprUuLJGxnxhsp0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4yCK2S_1713750847;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4yCK2S_1713750847)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 09:54:08 +0800
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
Subject: [PATCH vhost v1 3/7] virtio_net: replace private by pp struct inside page
Date: Mon, 22 Apr 2024 09:53:59 +0800
Message-Id: <20240422015403.72526-4-xuanzhuo@linux.alibaba.com>
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

Now, we chain the pages of big mode by the page's private variable.
But a subsequent patch aims to make the big mode to support
premapped mode. This requires additional space to store the dma addr.

Within the sub-struct that contains the 'private', there is no suitable
variable for storing the DMA addr.

		struct {	/* Page cache and anonymous pages */
			/**
			 * @lru: Pageout list, eg. active_list protected by
			 * lruvec->lru_lock.  Sometimes used as a generic list
			 * by the page owner.
			 */
			union {
				struct list_head lru;

				/* Or, for the Unevictable "LRU list" slot */
				struct {
					/* Always even, to negate PageTail */
					void *__filler;
					/* Count page's or folio's mlocks */
					unsigned int mlock_count;
				};

				/* Or, free page */
				struct list_head buddy_list;
				struct list_head pcp_list;
			};
			/* See page-flags.h for PAGE_MAPPING_FLAGS */
			struct address_space *mapping;
			union {
				pgoff_t index;		/* Our offset within mapping. */
				unsigned long share;	/* share count for fsdax */
			};
			/**
			 * @private: Mapping-private opaque data.
			 * Usually used for buffer_heads if PagePrivate.
			 * Used for swp_entry_t if PageSwapCache.
			 * Indicates order in the buddy system if PageBuddy.
			 */
			unsigned long private;
		};

But within the page pool struct, we have a variable called
dma_addr that is appropriate for storing dma addr.
And that struct is used by netstack. That works to our advantage.

		struct {	/* page_pool used by netstack */
			/**
			 * @pp_magic: magic value to avoid recycling non
			 * page_pool allocated pages.
			 */
			unsigned long pp_magic;
			struct page_pool *pp;
			unsigned long _pp_mapping_pad;
			unsigned long dma_addr;
			atomic_long_t pp_ref_count;
		};

On the other side, we should use variables from the same sub-struct.
So this patch replaces the "private" with "pp".

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..2c7a67ad4789 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -48,6 +48,14 @@ module_param(napi_tx, bool, 0644);
 
 #define VIRTIO_XDP_FLAG	BIT(0)
 
+/* In big mode, we use a page chain to manage multiple pages submitted to the
+ * ring. These pages are connected using page.pp. The following two macros are
+ * used to obtain the next page in a page chain and set the next page in the
+ * page chain.
+ */
+#define page_chain_next(p)	((struct page *)((p)->pp))
+#define page_chain_add(p, n)	((p)->pp = (void *)n)
+
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
  * at once, the weight is chosen so that the EWMA will be insensitive to short-
@@ -191,7 +199,7 @@ struct receive_queue {
 
 	struct virtnet_interrupt_coalesce intr_coal;
 
-	/* Chain pages by the private ptr. */
+	/* Chain pages by the page's pp struct. */
 	struct page *pages;
 
 	/* Average packet length for mergeable receive buffers. */
@@ -432,16 +440,16 @@ skb_vnet_common_hdr(struct sk_buff *skb)
 }
 
 /*
- * private is used to chain pages for big packets, put the whole
- * most recent used list in the beginning for reuse
+ * put the whole most recent used list in the beginning for reuse
  */
 static void give_pages(struct receive_queue *rq, struct page *page)
 {
 	struct page *end;
 
 	/* Find end of list, sew whole thing into vi->rq.pages. */
-	for (end = page; end->private; end = (struct page *)end->private);
-	end->private = (unsigned long)rq->pages;
+	for (end = page; page_chain_next(end); end = page_chain_next(end));
+
+	page_chain_add(end, rq->pages);
 	rq->pages = page;
 }
 
@@ -450,9 +458,9 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 	struct page *p = rq->pages;
 
 	if (p) {
-		rq->pages = (struct page *)p->private;
-		/* clear private here, it is used to chain pages */
-		p->private = 0;
+		rq->pages = page_chain_next(p);
+		/* clear chain here, it is used to chain pages */
+		page_chain_add(p, NULL);
 	} else
 		p = alloc_page(gfp_mask);
 	return p;
@@ -609,7 +617,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		if (unlikely(!skb))
 			return NULL;
 
-		page = (struct page *)page->private;
+		page = page_chain_next(page);
 		if (page)
 			give_pages(rq, page);
 		goto ok;
@@ -657,7 +665,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
 				frag_size, truesize);
 		len -= frag_size;
-		page = (struct page *)page->private;
+		page = page_chain_next(page);
 		offset = 0;
 	}
 
@@ -1909,7 +1917,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 		sg_set_buf(&rq->sg[i], page_address(first), PAGE_SIZE);
 
 		/* chain new page in list head to match sg */
-		first->private = (unsigned long)list;
+		page_chain_add(first, list);
 		list = first;
 	}
 
@@ -1929,7 +1937,7 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
 	sg_set_buf(&rq->sg[1], p + offset, PAGE_SIZE - offset);
 
 	/* chain first in list head */
-	first->private = (unsigned long)list;
+	page_chain_add(first, list);
 	err = virtqueue_add_inbuf(rq->vq, rq->sg, vi->big_packets_num_skbfrags + 2,
 				  first, gfp);
 	if (err < 0)
-- 
2.32.0.3.g01195cf9f


