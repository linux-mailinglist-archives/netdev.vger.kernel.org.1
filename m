Return-Path: <netdev+bounces-215115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DB4B2D21F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A068567B60
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C072773CC;
	Wed, 20 Aug 2025 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6zCNDlV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF31270ED2
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658634; cv=none; b=ql7Glqd274FlobRVh5TV4G8YecYXudulapI26/VkES66A3cnyPkhJ/61znrdNIMcid9kUh4axKCD5eOA4mrT3kR333pJI+vhKTAdSNF5xIdf0bMN2qDBMVWH0aW67vP1DvWoWCG+uMFbnU4nw5xDHygBjQyneRnkvG9628crZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658634; c=relaxed/simple;
	bh=MIsnZWK47Avp9a6ZCn+fyzTfk3RT/S7cfia2a14TjGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGbCXDFxZZL+WcYyk7FT0YRxWY95UN7z6SMqvpAL44LvAhQeZMixQRFooAJ2lBy5vZgZvk5CrSUWdcwlY7GyO0az17gSP3epxaLGqlY24ZinZOnyiFXiMwpSPag6wAFy30kznS0bHm3HClX5WGO7eiHTalT+1FAgHEdKFkvaO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6zCNDlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0E8C116D0;
	Wed, 20 Aug 2025 02:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658634;
	bh=MIsnZWK47Avp9a6ZCn+fyzTfk3RT/S7cfia2a14TjGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6zCNDlVoNrVbq4yK84FLzr7G7Xyf3F6z4G16ibVrZIkzHIPtLc7D2KHXXMHstirF
	 jF48PZ+VgWo+SpKMAsMBF8W+q8URDxUg9ocKMLHTK6oDql6oWZxpvF8tEN6Eznoy8o
	 zyf9MrprMscJSM92zBxxrJ+e9eEJjtgix3TTUeJ6mAl7aGlVjISZbzDWdNpLMEQAko
	 GQLE3WpLA/zxJMAp9vuTvItA7nriaNw8HC337xfiUzMHVO09uvQ5M0SNyCDVPMjOK8
	 D3FdKWJtlWdd5hWy92zQIxmKG4AMxkrwjgtsnWt15pXAiSFF7w1RyRYWFCjW2DbvWn
	 hDl/ekn5++ZxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/15] eth: fbnic: use netmem_ref where applicable
Date: Tue, 19 Aug 2025 19:56:54 -0700
Message-ID: <20250820025704.166248-6-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820025704.166248-1-kuba@kernel.org>
References: <20250820025704.166248-1-kuba@kernel.org>
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
2.50.1


