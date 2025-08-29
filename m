Return-Path: <netdev+bounces-218076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B13B3B063
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AE7583A88
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294120C48A;
	Fri, 29 Aug 2025 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNgB7/Jc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE361F4192
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430596; cv=none; b=lSRn5GWoUvgjdoCFck18OV6Lmqm+HHMypIG0u4+5NZ41xctBsVexyudkUIfBoGcDqncGPDtFKITX2d9SVUk9NJ7iJXyduupHnAdzOyvyuyxHa8pderXybGzgOUScuXkyAJQJtxkjannJJbHpeCO4IV5FAMKzJRMi4qAEcpu8Xw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430596; c=relaxed/simple;
	bh=Atci4EtrWuRi82yU3Q6XPPxfY1EGmkEaXpdS1mUnqZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvQmLSI58sz99R3ILEg87OJn93BsQS5+uxfmAGXb0L6v5SMTS3YOEaY6sV+vQHLFBqJPrBNU72lgevCCoG7jM2Xl3i0wlNzUCw2qkP8dHce8ebVDUXkVsLP9Le4NQjCQduFH4V72HhEXa6+tSKFav+i1XlF4Eb6mTIc65EwoVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNgB7/Jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5D1C4CEF4;
	Fri, 29 Aug 2025 01:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430594;
	bh=Atci4EtrWuRi82yU3Q6XPPxfY1EGmkEaXpdS1mUnqZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNgB7/JcCa/haTxwwxI6Vo+VyEUJUCM8/txmEz2sRIDY4c2v/gNGUXsg05rmCd9V4
	 cosksCUnQdjREtN12MgOMYxuE7quGxaewbS2YDvJUPynDPDHfrisr5xUtBd3IbU23e
	 bfix0eyyboD0TMusKNJnnIcEavUnWgOTpDaaR4+c40ibHoOPTHOnZY+2jM1i4J+Soo
	 LpRhyCj+dj/5eS1+V9E2bjXWPPpagmUOF8A/b3QN9H6FH8zyJmC/TqUY752aXQxzpd
	 ornzYCg9qT8raWN/qiMePOgaPl8ZgTrfNfHDQVUe1k2tB+AP4sWgYlNkQSo6WODxvz
	 qMx6O9xKhEG7A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 04/14] eth: fbnic: use netmem_ref where applicable
Date: Thu, 28 Aug 2025 18:22:54 -0700
Message-ID: <20250829012304.4146195-5-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829012304.4146195-1-kuba@kernel.org>
References: <20250829012304.4146195-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netmem_ref instead of struct page pointer in prep for
unreadable memory. fbnic has separate free buffer submission
queues for headers and for data. Refactor the helper which
returns page pointer for a submission buffer to take the
high level queue container, create a separate handler
for header and payload rings. This ties the "upcast" from
netmem to system page to use of sub0 which we know has
system pages.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 65 ++++++++++++--------
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index a935a1acfb3e..58ae7f9c8f54 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -100,7 +100,7 @@ struct fbnic_queue_stats {
 #define FBNIC_PAGECNT_BIAS_MAX	PAGE_SIZE
 
 struct fbnic_rx_buf {
-	struct page *page;
+	netmem_ref netmem;
 	long pagecnt_bias;
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 15ebbaa0bed2..8dbe83bc2be1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -715,35 +715,47 @@ static void fbnic_clean_tsq(struct fbnic_napi_vector *nv,
 }
 
 static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
-				 struct page *page)
+				 netmem_ref netmem)
 {
 	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
 
-	page_pool_fragment_page(page, FBNIC_PAGECNT_BIAS_MAX);
+	page_pool_fragment_netmem(netmem, FBNIC_PAGECNT_BIAS_MAX);
 	rx_buf->pagecnt_bias = FBNIC_PAGECNT_BIAS_MAX;
-	rx_buf->page = page;
+	rx_buf->netmem = netmem;
 }
 
-static struct page *fbnic_page_pool_get(struct fbnic_ring *ring,
-					unsigned int idx)
+static struct page *
+fbnic_page_pool_get_head(struct fbnic_q_triad *qt, unsigned int idx)
 {
-	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
+	struct fbnic_rx_buf *rx_buf = &qt->sub0.rx_buf[idx];
 
 	rx_buf->pagecnt_bias--;
 
-	return rx_buf->page;
+	/* sub0 is always fed system pages, from the NAPI-level page_pool */
+	return netmem_to_page(rx_buf->netmem);
+}
+
+static netmem_ref
+fbnic_page_pool_get_data(struct fbnic_q_triad *qt, unsigned int idx)
+{
+	struct fbnic_rx_buf *rx_buf = &qt->sub1.rx_buf[idx];
+
+	rx_buf->pagecnt_bias--;
+
+	return rx_buf->netmem;
 }
 
 static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
 				  int budget)
 {
 	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
-	struct page *page = rx_buf->page;
+	netmem_ref netmem = rx_buf->netmem;
 
-	if (!page_pool_unref_page(page, rx_buf->pagecnt_bias))
-		page_pool_put_unrefed_page(ring->page_pool, page, -1, !!budget);
+	if (!page_pool_unref_netmem(netmem, rx_buf->pagecnt_bias))
+		page_pool_put_unrefed_netmem(ring->page_pool, netmem, -1,
+					     !!budget);
 
-	rx_buf->page = NULL;
+	rx_buf->netmem = 0;
 }
 
 static void fbnic_clean_twq(struct fbnic_napi_vector *nv, int napi_budget,
@@ -844,10 +856,10 @@ static void fbnic_clean_bdq(struct fbnic_ring *ring, unsigned int hw_head,
 	ring->head = head;
 }
 
-static void fbnic_bd_prep(struct fbnic_ring *bdq, u16 id, struct page *page)
+static void fbnic_bd_prep(struct fbnic_ring *bdq, u16 id, netmem_ref netmem)
 {
 	__le64 *bdq_desc = &bdq->desc[id * FBNIC_BD_FRAG_COUNT];
-	dma_addr_t dma = page_pool_get_dma_addr(page);
+	dma_addr_t dma = page_pool_get_dma_addr_netmem(netmem);
 	u64 bd, i = FBNIC_BD_FRAG_COUNT;
 
 	bd = (FBNIC_BD_PAGE_ADDR_MASK & dma) |
@@ -874,10 +886,10 @@ static void fbnic_fill_bdq(struct fbnic_ring *bdq)
 		return;
 
 	do {
-		struct page *page;
+		netmem_ref netmem;
 
-		page = page_pool_dev_alloc_pages(bdq->page_pool);
-		if (!page) {
+		netmem = page_pool_dev_alloc_netmems(bdq->page_pool);
+		if (!netmem) {
 			u64_stats_update_begin(&bdq->stats.syncp);
 			bdq->stats.rx.alloc_failed++;
 			u64_stats_update_end(&bdq->stats.syncp);
@@ -885,8 +897,8 @@ static void fbnic_fill_bdq(struct fbnic_ring *bdq)
 			break;
 		}
 
-		fbnic_page_pool_init(bdq, i, page);
-		fbnic_bd_prep(bdq, i, page);
+		fbnic_page_pool_init(bdq, i, netmem);
+		fbnic_bd_prep(bdq, i, netmem);
 
 		i++;
 		i &= bdq->size_mask;
@@ -933,7 +945,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 {
 	unsigned int hdr_pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
 	unsigned int hdr_pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
-	struct page *page = fbnic_page_pool_get(&qt->sub0, hdr_pg_idx);
+	struct page *page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
 	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
 	unsigned int frame_sz, hdr_pg_start, hdr_pg_end, headroom;
 	unsigned char *hdr_start;
@@ -974,7 +986,7 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	unsigned int pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
 	unsigned int pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
 	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
-	struct page *page = fbnic_page_pool_get(&qt->sub1, pg_idx);
+	netmem_ref netmem = fbnic_page_pool_get_data(qt, pg_idx);
 	unsigned int truesize;
 	bool added;
 
@@ -985,11 +997,11 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 		  FBNIC_BD_FRAG_SIZE;
 
 	/* Sync DMA buffer */
-	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
+	dma_sync_single_range_for_cpu(nv->dev,
+				      page_pool_get_dma_addr_netmem(netmem),
 				      pg_off, truesize, DMA_BIDIRECTIONAL);
 
-	added = xdp_buff_add_frag(&pkt->buff, page_to_netmem(page), pg_off, len,
-				  truesize);
+	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
 	if (unlikely(!added)) {
 		pkt->add_frag_failed = true;
 		netdev_err_once(nv->napi.dev,
@@ -1007,15 +1019,16 @@ static void fbnic_put_pkt_buff(struct fbnic_q_triad *qt,
 
 	if (xdp_buff_has_frags(&pkt->buff)) {
 		struct skb_shared_info *shinfo;
+		netmem_ref netmem;
 		int nr_frags;
 
 		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
 		nr_frags = shinfo->nr_frags;
 
 		while (nr_frags--) {
-			page = skb_frag_page(&shinfo->frags[nr_frags]);
-			page_pool_put_full_page(qt->sub1.page_pool, page,
-						!!budget);
+			netmem = skb_frag_netmem(&shinfo->frags[nr_frags]);
+			page_pool_put_full_netmem(qt->sub1.page_pool, netmem,
+						  !!budget);
 		}
 	}
 
-- 
2.51.0


