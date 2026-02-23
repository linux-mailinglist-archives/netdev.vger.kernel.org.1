Return-Path: <netdev+bounces-259985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GpsFtsqnGloAQQAu9opvQ
	(envelope-from <netdev+bounces-259985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:24:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB84174CEC
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88BA53053DC8
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6B035B649;
	Mon, 23 Feb 2026 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzZsfKG9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA935B65A;
	Mon, 23 Feb 2026 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842175; cv=none; b=KByTJzoJ2ptFXX2/egHFkBerAATVDc+ZNDbAShmtznvB85gYWxcDshrqn7o+21gu+Pu7eLEmJYE2vRMkiI7vgPX/NqnLVBUjwsRG+d9Qn0dEsHpyNtREVKnJ8nfz8Cr71/QtbkXKmOLthVkXswtBB//dvYf/jy3Y1lzRjSelz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842175; c=relaxed/simple;
	bh=ufh1cX6GqRjq3fQDaxosVxUofI6c9/Qxryz3A1avV94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkTwTsIiLfzdQlbHrwEnvgb/KgZ+cFgk+LoosC7DAlSY4W/XWBNT7iJ6suXKwbibwv+InV/cMY9A/eFo4JJ76RN0S3ImlATHCGAtpt7DcSb/yqv/5bxPMYHZYiIMfkJfu2ZsIu78cot76zD5/jYc9UDGjfOgwzhyAOAYYWAYf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzZsfKG9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771842173; x=1803378173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ufh1cX6GqRjq3fQDaxosVxUofI6c9/Qxryz3A1avV94=;
  b=ZzZsfKG9Q4UFTgvSyr+Y9UrpWrEAGmNt6kGWlPbwKFadfh+SlEK7nMMv
   TpW+GYKkYllrFPBtL9xegH5uD251Nx4CFHdQ1sxAG+JDFehynvKE0yAA+
   IMhvTvBotSD1Vx7bf3dMaITtWFfJz9i2yfFWfvIK+nkEz6eBzC6TpNmiT
   3nny/cvQxzxLPCShjUtLtvGKEROH9e4QQZxaNm4ODrSLe50aBlKPRr108
   hEeDQkHtbOWQ8zxwCDoZzEcwY2MOAgy0SIVU9/Tl8I7Z4s3vdCHinhBqD
   7PgSlrW0hW7v830muithuGbkU4Luoh/k4Xh1/O4XFJT/Kn8s87AoM6lpc
   w==;
X-CSE-ConnectionGUID: hWRYCIi/QHerJ2bqocFSrw==
X-CSE-MsgGUID: BxsARQtgTNSr3hm8zCQJiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76444699"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76444699"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 02:22:53 -0800
X-CSE-ConnectionGUID: 6oaf7KMPRXiK+MMTjtyduA==
X-CSE-MsgGUID: AvPAr/QTS/ms8L/rg1CSHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246121730"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 23 Feb 2026 02:22:47 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4CE6028167;
	Mon, 23 Feb 2026 10:22:44 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 02/10] ixgbevf: do not share pages between packets
Date: Mon, 23 Feb 2026 10:52:09 +0100
Message-ID: <20260223095222.3205363-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223095222.3205363-1-larysa.zaremba@intel.com>
References: <20260223095222.3205363-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259985-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDB84174CEC
X-Rspamd-Action: no action

Again, same as in the related iavf commit 920d86f3c552 ("iavf: drop page
splitting and recycling"), as an intermediate step, drop the page sharing
and recycling logic in a preparation to offload it to page_pool.

Instead of the previous sharing and recycling, just allocate a new page
every time.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |  37 +--
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 231 ++----------------
 2 files changed, 23 insertions(+), 245 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index ae2763fea2be..5885756a21d0 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -45,12 +45,7 @@ struct ixgbevf_tx_buffer {
 struct ixgbevf_rx_buffer {
 	dma_addr_t dma;
 	struct page *page;
-#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
 	__u32 page_offset;
-#else
-	__u16 page_offset;
-#endif
-	__u16 pagecnt_bias;
 };
 
 struct ixgbevf_stats {
@@ -143,8 +138,7 @@ struct ixgbevf_ring {
 #define IXGBEVF_MIN_RXD		64
 
 /* Supported Rx Buffer Sizes */
-#define IXGBEVF_RXBUFFER_256	256    /* Used for packet split */
-#define IXGBEVF_RXBUFFER_2048	2048
+#define IXGBEVF_RXBUFFER_256	256
 #define IXGBEVF_RXBUFFER_3072	3072
 
 #define IXGBEVF_RX_HDR_SIZE	IXGBEVF_RXBUFFER_256
@@ -168,35 +162,6 @@ struct ixgbevf_ring {
 #define IXGBE_TX_FLAGS_VLAN_PRIO_MASK	0x0000e000
 #define IXGBE_TX_FLAGS_VLAN_SHIFT	16
 
-#define ring_uses_large_buffer(ring) \
-	test_bit(__IXGBEVF_RX_3K_BUFFER, &(ring)->state)
-#define set_ring_uses_large_buffer(ring) \
-	set_bit(__IXGBEVF_RX_3K_BUFFER, &(ring)->state)
-#define clear_ring_uses_large_buffer(ring) \
-	clear_bit(__IXGBEVF_RX_3K_BUFFER, &(ring)->state)
-
-static inline unsigned int ixgbevf_rx_bufsz(struct ixgbevf_ring *ring)
-{
-#if (PAGE_SIZE < 8192)
-	if (ring_uses_large_buffer(ring))
-		return IXGBEVF_RXBUFFER_3072;
-
-	return IXGBEVF_MAX_FRAME_BUILD_SKB;
-#endif
-	return IXGBEVF_RXBUFFER_2048;
-}
-
-static inline unsigned int ixgbevf_rx_pg_order(struct ixgbevf_ring *ring)
-{
-#if (PAGE_SIZE < 8192)
-	if (ring_uses_large_buffer(ring))
-		return 1;
-#endif
-	return 0;
-}
-
-#define ixgbevf_rx_pg_size(_ring) (PAGE_SIZE << ixgbevf_rx_pg_order(_ring))
-
 #define check_for_tx_hang(ring) \
 	test_bit(__IXGBEVF_TX_DETECT_HANG, &(ring)->state)
 #define set_check_for_tx_hang(ring) \
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index fc48c89c7bb8..f5a7dd37084f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -112,9 +112,6 @@ static void ixgbevf_service_event_complete(struct ixgbevf_adapter *adapter)
 static void ixgbevf_queue_reset_subtask(struct ixgbevf_adapter *adapter);
 static void ixgbevf_set_itr(struct ixgbevf_q_vector *q_vector);
 static void ixgbevf_free_all_rx_resources(struct ixgbevf_adapter *adapter);
-static bool ixgbevf_can_reuse_rx_page(struct ixgbevf_rx_buffer *rx_buffer);
-static void ixgbevf_reuse_rx_page(struct ixgbevf_ring *rx_ring,
-				  struct ixgbevf_rx_buffer *old_buff);
 
 static void ixgbevf_remove_adapter(struct ixgbe_hw *hw)
 {
@@ -544,32 +541,14 @@ struct ixgbevf_rx_buffer *ixgbevf_get_rx_buffer(struct ixgbevf_ring *rx_ring,
 				      size,
 				      DMA_FROM_DEVICE);
 
-	rx_buffer->pagecnt_bias--;
-
 	return rx_buffer;
 }
 
 static void ixgbevf_put_rx_buffer(struct ixgbevf_ring *rx_ring,
-				  struct ixgbevf_rx_buffer *rx_buffer,
-				  struct sk_buff *skb)
+				  struct ixgbevf_rx_buffer *rx_buffer)
 {
-	if (ixgbevf_can_reuse_rx_page(rx_buffer)) {
-		/* hand second half of page back to the ring */
-		ixgbevf_reuse_rx_page(rx_ring, rx_buffer);
-	} else {
-		if (IS_ERR(skb))
-			/* We are not reusing the buffer so unmap it and free
-			 * any references we are holding to it
-			 */
-			dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
-					     ixgbevf_rx_pg_size(rx_ring),
-					     DMA_FROM_DEVICE,
-					     IXGBEVF_RX_DMA_ATTR);
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
-	}
-
-	/* clear contents of rx_buffer */
+	dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
+			     DMA_FROM_DEVICE, IXGBEVF_RX_DMA_ATTR);
 	rx_buffer->page = NULL;
 }
 
@@ -600,38 +579,28 @@ static bool ixgbevf_is_non_eop(struct ixgbevf_ring *rx_ring,
 	return true;
 }
 
-static inline unsigned int ixgbevf_rx_offset(struct ixgbevf_ring *rx_ring)
-{
-	return IXGBEVF_SKB_PAD;
-}
-
 static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
 				      struct ixgbevf_rx_buffer *bi)
 {
 	struct page *page = bi->page;
 	dma_addr_t dma;
 
-	/* since we are recycling buffers we should seldom need to alloc */
-	if (likely(page))
-		return true;
-
 	/* alloc new page for storage */
-	page = dev_alloc_pages(ixgbevf_rx_pg_order(rx_ring));
+	page = dev_alloc_page();
 	if (unlikely(!page)) {
 		rx_ring->rx_stats.alloc_rx_page_failed++;
 		return false;
 	}
 
 	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
-				 ixgbevf_rx_pg_size(rx_ring),
+	dma = dma_map_page_attrs(rx_ring->dev, page, 0, PAGE_SIZE,
 				 DMA_FROM_DEVICE, IXGBEVF_RX_DMA_ATTR);
 
 	/* if mapping failed free memory back to system since
 	 * there isn't much point in holding memory we can't use
 	 */
 	if (dma_mapping_error(rx_ring->dev, dma)) {
-		__free_pages(page, ixgbevf_rx_pg_order(rx_ring));
+		__free_page(page);
 
 		rx_ring->rx_stats.alloc_rx_page_failed++;
 		return false;
@@ -639,8 +608,7 @@ static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
 
 	bi->dma = dma;
 	bi->page = page;
-	bi->page_offset = ixgbevf_rx_offset(rx_ring);
-	bi->pagecnt_bias = 1;
+	bi->page_offset = IXGBEVF_SKB_PAD;
 	rx_ring->rx_stats.alloc_rx_page++;
 
 	return true;
@@ -673,7 +641,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
 		/* sync the buffer for use by the device */
 		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
 						 bi->page_offset,
-						 ixgbevf_rx_bufsz(rx_ring),
+						 IXGBEVF_RXBUFFER_3072,
 						 DMA_FROM_DEVICE);
 
 		/* Refresh the desc even if pkt_addr didn't change
@@ -755,66 +723,6 @@ static bool ixgbevf_cleanup_headers(struct ixgbevf_ring *rx_ring,
 	return false;
 }
 
-/**
- * ixgbevf_reuse_rx_page - page flip buffer and store it back on the ring
- * @rx_ring: rx descriptor ring to store buffers on
- * @old_buff: donor buffer to have page reused
- *
- * Synchronizes page for reuse by the adapter
- **/
-static void ixgbevf_reuse_rx_page(struct ixgbevf_ring *rx_ring,
-				  struct ixgbevf_rx_buffer *old_buff)
-{
-	struct ixgbevf_rx_buffer *new_buff;
-	u16 nta = rx_ring->next_to_alloc;
-
-	new_buff = &rx_ring->rx_buffer_info[nta];
-
-	/* update, and store next to alloc */
-	nta++;
-	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
-
-	/* transfer page from old buffer to new buffer */
-	new_buff->page = old_buff->page;
-	new_buff->dma = old_buff->dma;
-	new_buff->page_offset = old_buff->page_offset;
-	new_buff->pagecnt_bias = old_buff->pagecnt_bias;
-}
-
-static bool ixgbevf_can_reuse_rx_page(struct ixgbevf_rx_buffer *rx_buffer)
-{
-	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias;
-	struct page *page = rx_buffer->page;
-
-	/* avoid re-using remote and pfmemalloc pages */
-	if (!dev_page_is_reusable(page))
-		return false;
-
-#if (PAGE_SIZE < 8192)
-	/* if we are only owner of page we can reuse it */
-	if (unlikely((page_ref_count(page) - pagecnt_bias) > 1))
-		return false;
-#else
-#define IXGBEVF_LAST_OFFSET \
-	(SKB_WITH_OVERHEAD(PAGE_SIZE) - IXGBEVF_RXBUFFER_2048)
-
-	if (rx_buffer->page_offset > IXGBEVF_LAST_OFFSET)
-		return false;
-
-#endif
-
-	/* If we have drained the page fragment pool we need to update
-	 * the pagecnt_bias and page count so that we fully restock the
-	 * number of references the driver holds.
-	 */
-	if (unlikely(!pagecnt_bias)) {
-		page_ref_add(page, USHRT_MAX);
-		rx_buffer->pagecnt_bias = USHRT_MAX;
-	}
-
-	return true;
-}
-
 /**
  * ixgbevf_add_rx_frag - Add contents of Rx buffer to sk_buff
  * @rx_ring: rx descriptor ring to transact packets on
@@ -829,18 +737,10 @@ static void ixgbevf_add_rx_frag(struct ixgbevf_ring *rx_ring,
 				struct sk_buff *skb,
 				unsigned int size)
 {
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
-#else
 	unsigned int truesize = SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size);
-#endif
+
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
 			rx_buffer->page_offset, size, truesize);
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
 }
 
 static inline void ixgbevf_irq_enable_queues(struct ixgbevf_adapter *adapter,
@@ -857,13 +757,9 @@ static struct sk_buff *ixgbevf_build_skb(struct ixgbevf_ring *rx_ring,
 					 union ixgbe_adv_rx_desc *rx_desc)
 {
 	unsigned int metasize = xdp->data - xdp->data_meta;
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
-#else
 	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
 				SKB_DATA_ALIGN(xdp->data_end -
 					       xdp->data_hard_start);
-#endif
 	struct sk_buff *skb;
 
 	/* Prefetch first cache line of first page. If xdp->data_meta
@@ -884,13 +780,6 @@ static struct sk_buff *ixgbevf_build_skb(struct ixgbevf_ring *rx_ring,
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
-	/* update buffer offset */
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
-
 	return skb;
 }
 
@@ -1014,38 +903,11 @@ static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 	return result;
 }
 
-static unsigned int ixgbevf_rx_frame_truesize(struct ixgbevf_ring *rx_ring,
-					      unsigned int size)
-{
-	unsigned int truesize;
-
-#if (PAGE_SIZE < 8192)
-	truesize = ixgbevf_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
-#else
-	truesize = SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size) +
-		   SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-#endif
-	return truesize;
-}
-
-static void ixgbevf_rx_buffer_flip(struct ixgbevf_ring *rx_ring,
-				   struct ixgbevf_rx_buffer *rx_buffer,
-				   unsigned int size)
-{
-	unsigned int truesize = ixgbevf_rx_frame_truesize(rx_ring, size);
-
-#if (PAGE_SIZE < 8192)
-	rx_buffer->page_offset ^= truesize;
-#else
-	rx_buffer->page_offset += truesize;
-#endif
-}
-
 static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 				struct ixgbevf_ring *rx_ring,
 				int budget)
 {
-	unsigned int total_rx_bytes = 0, total_rx_packets = 0, frame_sz = 0;
+	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	struct ixgbevf_adapter *adapter = q_vector->adapter;
 	u16 cleaned_count = ixgbevf_desc_unused(rx_ring);
 	struct sk_buff *skb = rx_ring->skb;
@@ -1054,10 +916,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	int xdp_res = 0;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
-#if (PAGE_SIZE < 8192)
-	frame_sz = ixgbevf_rx_frame_truesize(rx_ring, 0);
-#endif
-	xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
+	xdp_init_buff(&xdp, IXGBEVF_RXBUFFER_3072, &rx_ring->xdp_rxq);
 
 	while (likely(total_rx_packets < budget)) {
 		struct ixgbevf_rx_buffer *rx_buffer;
@@ -1081,31 +940,24 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		 */
 		rmb();
 
-		rx_buffer = ixgbevf_get_rx_buffer(rx_ring, size);
+		rx_buffer =
+			ixgbevf_get_rx_buffer(rx_ring, IXGBEVF_RXBUFFER_3072);
 
 		/* retrieve a buffer from the ring */
 		if (!skb) {
-			unsigned int offset = ixgbevf_rx_offset(rx_ring);
+			unsigned int offset = rx_buffer->page_offset;
 			unsigned char *hard_start;
 
 			hard_start = page_address(rx_buffer->page) +
 				     rx_buffer->page_offset - offset;
 			xdp_prepare_buff(&xdp, hard_start, offset, size, true);
-#if (PAGE_SIZE > 4096)
-			/* At larger PAGE_SIZE, frame_sz depend on len size */
-			xdp.frame_sz = ixgbevf_rx_frame_truesize(rx_ring, size);
-#endif
 			xdp_res = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
 		}
 
 		if (xdp_res) {
-			if (xdp_res == IXGBEVF_XDP_TX) {
+			if (xdp_res == IXGBEVF_XDP_TX)
 				xdp_xmit = true;
-				ixgbevf_rx_buffer_flip(rx_ring, rx_buffer,
-						       size);
-			} else {
-				rx_buffer->pagecnt_bias++;
-			}
+
 			total_rx_packets++;
 			total_rx_bytes += size;
 		} else if (skb) {
@@ -1118,11 +970,10 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		/* exit if we failed to retrieve a buffer */
 		if (!xdp_res && !skb) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
-			rx_buffer->pagecnt_bias++;
 			break;
 		}
 
-		ixgbevf_put_rx_buffer(rx_ring, rx_buffer, skb);
+		ixgbevf_put_rx_buffer(rx_ring, rx_buffer);
 		cleaned_count++;
 
 		/* fetch next buffer in frame if non-eop */
@@ -1699,10 +1550,7 @@ static void ixgbevf_configure_srrctl(struct ixgbevf_adapter *adapter,
 	srrctl = IXGBE_SRRCTL_DROP_EN;
 
 	srrctl |= IXGBEVF_RX_HDR_SIZE << IXGBE_SRRCTL_BSIZEHDRSIZE_SHIFT;
-	if (ring_uses_large_buffer(ring))
-		srrctl |= IXGBEVF_RXBUFFER_3072 >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
-	else
-		srrctl |= IXGBEVF_RXBUFFER_2048 >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
+	srrctl |= IXGBEVF_RXBUFFER_3072 >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
 	srrctl |= IXGBE_SRRCTL_DESCTYPE_ADV_ONEBUF;
 
 	IXGBE_WRITE_REG(hw, IXGBE_VFSRRCTL(index), srrctl);
@@ -1880,13 +1728,6 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	if (adapter->hw.mac.type != ixgbe_mac_82599_vf) {
 		rxdctl &= ~(IXGBE_RXDCTL_RLPMLMASK |
 			    IXGBE_RXDCTL_RLPML_EN);
-
-#if (PAGE_SIZE < 8192)
-		/* Limit the maximum frame size so we don't overrun the skb */
-		if (!ring_uses_large_buffer(ring))
-			rxdctl |= IXGBEVF_MAX_FRAME_BUILD_SKB |
-				  IXGBE_RXDCTL_RLPML_EN;
-#endif
 	}
 
 	rxdctl |= IXGBE_RXDCTL_ENABLE | IXGBE_RXDCTL_VME;
@@ -1896,24 +1737,6 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 	ixgbevf_alloc_rx_buffers(ring, ixgbevf_desc_unused(ring));
 }
 
-static void ixgbevf_set_rx_buffer_len(struct ixgbevf_adapter *adapter,
-				      struct ixgbevf_ring *rx_ring)
-{
-	struct net_device *netdev = adapter->netdev;
-	unsigned int max_frame = netdev->mtu + ETH_HLEN + ETH_FCS_LEN;
-
-	/* set buffer size flags */
-	clear_ring_uses_large_buffer(rx_ring);
-
-	if (PAGE_SIZE < 8192)
-		/* 82599 can't rely on RXDCTL.RLPML to restrict
-		 * the size of the frame
-		 */
-		if (max_frame > IXGBEVF_MAX_FRAME_BUILD_SKB ||
-		    adapter->hw.mac.type == ixgbe_mac_82599_vf)
-			set_ring_uses_large_buffer(rx_ring);
-}
-
 /**
  * ixgbevf_configure_rx - Configure 82599 VF Receive Unit after Reset
  * @adapter: board private structure
@@ -1944,7 +1767,6 @@ static void ixgbevf_configure_rx(struct ixgbevf_adapter *adapter)
 	for (i = 0; i < adapter->num_rx_queues; i++) {
 		struct ixgbevf_ring *rx_ring = adapter->rx_ring[i];
 
-		ixgbevf_set_rx_buffer_len(adapter, rx_ring);
 		ixgbevf_configure_rx_ring(adapter, rx_ring);
 	}
 }
@@ -2323,19 +2145,12 @@ static void ixgbevf_clean_rx_ring(struct ixgbevf_ring *rx_ring)
 		dma_sync_single_range_for_cpu(rx_ring->dev,
 					      rx_buffer->dma,
 					      rx_buffer->page_offset,
-					      ixgbevf_rx_bufsz(rx_ring),
+					      IXGBEVF_RXBUFFER_3072,
 					      DMA_FROM_DEVICE);
 
 		/* free resources associated with mapping */
-		dma_unmap_page_attrs(rx_ring->dev,
-				     rx_buffer->dma,
-				     ixgbevf_rx_pg_size(rx_ring),
-				     DMA_FROM_DEVICE,
-				     IXGBEVF_RX_DMA_ATTR);
-
-		__page_frag_cache_drain(rx_buffer->page,
-					rx_buffer->pagecnt_bias);
-
+		ixgbevf_put_rx_buffer(rx_ring, rx_buffer);
+		__free_page(rx_buffer->page);
 		i++;
 		if (i == rx_ring->count)
 			i = 0;
@@ -4394,9 +4209,7 @@ static int ixgbevf_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 
 	/* verify ixgbevf ring attributes are sufficient for XDP */
 	for (i = 0; i < adapter->num_rx_queues; i++) {
-		struct ixgbevf_ring *ring = adapter->rx_ring[i];
-
-		if (frame_size > ixgbevf_rx_bufsz(ring))
+		if (frame_size > IXGBEVF_RXBUFFER_3072)
 			return -EINVAL;
 	}
 
-- 
2.52.0


