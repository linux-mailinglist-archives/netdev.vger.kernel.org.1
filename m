Return-Path: <netdev+bounces-215122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C02B2D232
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA55680F6B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C92D130B;
	Wed, 20 Aug 2025 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzXlRKKP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFA2D0C85
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658639; cv=none; b=RddMkFkNHW0Pleci1VuVOyCeewVcr3zwre9Za/9bKz3UwRVanE5LQeyivWp94auMxpUeBOPSJ5crHR81CHamcJvy3+CHV8syYnsNLqEgoIV4/PrGWqZsiWe/pBmr3oRfzp6YQXhqoNigYb20LX9q3sbBPzWzsn3CksKxgkDcp5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658639; c=relaxed/simple;
	bh=MkFXozhICRFK5Y1tn0v6yuMA/ymp7kxl2L5WBDOIBUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNc5a9PzX5tCZJtUtTjJlrJC1f9XhHBFGH7LCvxEo8CkMlf4NSmuLMekTKEgj1ZipUSX4OS19+Cs8cdaeJHDqTsQlFn8A40HITuDD/a4EJfZjKsXAS2CRGmcXKEbU2v9wysh9TnM+mFBAADreanzELzu+tMrkGJWoTMFgaaELuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzXlRKKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F704C113D0;
	Wed, 20 Aug 2025 02:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658639;
	bh=MkFXozhICRFK5Y1tn0v6yuMA/ymp7kxl2L5WBDOIBUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzXlRKKPqb4QtlQSuw46F20BgANB4wejIwBVgKGsHlTfBkaI5TbRTduJuQOTU3BEW
	 HXWrtWFhoh8M5qg6n1FpgiNMdQbBPm7HjLdTwvF439Twmx7CIXF/oKqLjMkEzPmchI
	 y802qdfRLTR+IqUYdPdtY2XMA3T+lMxus6KP5afoh7fQKd2R0rAEhHGGyWZkW/aV5X
	 dUKTYU9c4wN5At4sy1o7+BSYnhNDnycG6wQK7XY597py4LQ68rqVKN5jMW3F2cs4Up
	 FmKoGYXqkUB608SAJ+nBC/gc35UzUyCZa4Vg6OXlg8KTb+18fJEHFEs1T+UPhPvGVl
	 NRjb+jvNuInYw==
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
Subject: [PATCH net-next 12/15] eth: fbnic: allocate unreadable page pool for the payloads
Date: Tue, 19 Aug 2025 19:57:01 -0700
Message-ID: <20250820025704.166248-13-kuba@kernel.org>
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

Allow allocating a page pool with unreadable memory for the payload
ring (sub1). We need to provide the queue ID so that the memory provider
can match the PP, and use the appropriate page pool DMA sync helper.
While at it remove the define for page pool flags.

The rxq_idx is passed to fbnic_alloc_rx_qt_resources() explicitly
to make it easy to allocate page pools without NAPI (see the patch
after the next).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 31 +++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 7694b25ef77d..44d9f1598820 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -997,9 +997,8 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 		  FBNIC_BD_FRAG_SIZE;
 
 	/* Sync DMA buffer */
-	dma_sync_single_range_for_cpu(nv->dev,
-				      page_pool_get_dma_addr_netmem(netmem),
-				      pg_off, truesize, DMA_BIDIRECTIONAL);
+	page_pool_dma_sync_netmem_for_cpu(qt->sub1.page_pool, netmem,
+					  pg_off, truesize);
 
 	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
 	if (unlikely(!added)) {
@@ -1515,16 +1514,14 @@ void fbnic_free_napi_vectors(struct fbnic_net *fbn)
 			fbnic_free_napi_vector(fbn, fbn->napi[i]);
 }
 
-#define FBNIC_PAGE_POOL_FLAGS \
-	(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
-
 static int
 fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_napi_vector *nv,
-			  struct fbnic_q_triad *qt)
+			  struct fbnic_q_triad *qt, unsigned int rxq_idx)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
-		.flags = FBNIC_PAGE_POOL_FLAGS,
+		.flags = PP_FLAG_DMA_MAP |
+			 PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = fbn->hpq_size + fbn->ppq_size,
 		.nid = NUMA_NO_NODE,
 		.dev = nv->dev,
@@ -1533,6 +1530,7 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_napi_vector *nv,
 		.max_len = PAGE_SIZE,
 		.napi	= &nv->napi,
 		.netdev	= fbn->netdev,
+		.queue_idx = rxq_idx,
 	};
 	struct page_pool *pp;
 
@@ -1553,10 +1551,23 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_napi_vector *nv,
 		return PTR_ERR(pp);
 
 	qt->sub0.page_pool = pp;
-	page_pool_get(pp);
+	if (page_pool_rxq_wants_unreadable(&pp_params)) {
+		pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+		pp_params.dma_dir = DMA_FROM_DEVICE;
+
+		pp = page_pool_create(&pp_params);
+		if (IS_ERR(pp))
+			goto err_destroy_sub0;
+	} else {
+		page_pool_get(pp);
+	}
 	qt->sub1.page_pool = pp;
 
 	return 0;
+
+err_destroy_sub0:
+	page_pool_destroy(pp);
+	return PTR_ERR(pp);
 }
 
 static void fbnic_ring_init(struct fbnic_ring *ring, u32 __iomem *doorbell,
@@ -1961,7 +1972,7 @@ static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
 	struct device *dev = fbn->netdev->dev.parent;
 	int err;
 
-	err = fbnic_alloc_qt_page_pools(fbn, nv, qt);
+	err = fbnic_alloc_qt_page_pools(fbn, nv, qt, qt->cmpl.q_idx);
 	if (err)
 		return err;
 
-- 
2.50.1


