Return-Path: <netdev+bounces-218917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F876B3F05A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196A67A52B5
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED712276051;
	Mon,  1 Sep 2025 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds3pMTKL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1E275B1B
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761140; cv=none; b=ad+URFgNrXGXS9iaQIvn5+Dl7vbgxBKbrwkWu5ulhr21mYkGWVrKZ4zxbnV+/LJCjeG16jxLV9FAo8cC5brAtjJUwGYmyjhtBweZ2EQNs2AyxDnWKmv9Y2DbfQRACjAOOGgylEHFHX0YIG9S80jLo9L5QlRHrz4tr2LCruejlcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761140; c=relaxed/simple;
	bh=Atci4EtrWuRi82yU3Q6XPPxfY1EGmkEaXpdS1mUnqZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxYDYVwyl1QhXnc3AMLewlebPBdkRZn2+DmDFzQBpPvU/p4McIOKjYQtkSb1izdiZMunWpkKFAtnzu2A4/NSLO7XjHhASXOpR3Qxpec142qcYUnyxc33vkB0DrbhKQx8a/PT1qD4fgOWv/hNojMFETHr2gO9QAVMhYVSVfDKE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds3pMTKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C306AC4CEFB;
	Mon,  1 Sep 2025 21:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761140;
	bh=Atci4EtrWuRi82yU3Q6XPPxfY1EGmkEaXpdS1mUnqZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ds3pMTKLok1vITjZdLywpERPw3/kv0701ZfaO9QapEJVccvFNYxbwyhwOD2yFtxKa
	 BWrYi4aNZsz6KaF8CxftlpyBXOO7Hnl1zMB2kQ2z51/LeY3wpJmg500bXtAUwhhFIy
	 TYJB/vA1yaJwIN06VpmFWxCyQ4W2uljDZ3rTumy75wloog/YrJ8YrpfUM/oZEgOQMT
	 5FHB4vrDKisdsT4ioODsjsA9yztS20NGDnSPcD+alcoK10uonDSoTHh4QLNWSNGpOW
	 JCb/5ld8OfFvXtiFM1DdegBSP4Ig4NLnC90gA2otvv6aqhFt1XwL/kYsi//F0UTpQC
	 3jB/q49atBtRQ==
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
Subject: [PATCH net-next v3 04/14] eth: fbnic: use netmem_ref where applicable
Date: Mon,  1 Sep 2025 14:12:04 -0700
Message-ID: <20250901211214.1027927-5-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901211214.1027927-1-kuba@kernel.org>
References: <20250901211214.1027927-1-kuba@kernel.org>
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


