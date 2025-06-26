Return-Path: <netdev+bounces-201657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A58DAEA3E7
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D4F18956BD
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FCD2EAB7D;
	Thu, 26 Jun 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNITCwgx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCD2E7179
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956883; cv=none; b=IiMAU20qGvhTyo6k6ieS298zf0rPpXl1qtelxyqNUiFSTYCbm2kYWIUjhvlFRk2b/CPlzLqFRJOA6Nz5URN6lovSkusjLtNGqjvXktazmlzvgSN/C6WkrJO41ekxlmZFoWsLhyUIhEO8wyjjq4a2SErjJHY2jLpTXcCYHkSe+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956883; c=relaxed/simple;
	bh=bsxccqjf5fwMXwjYTHfjpl6lBuSTF/V+uMfHf7ud4Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQagg8SBNiBPCu48x8p7nDo2qOr2D88yiCQqcejCHgSr7sYFcZ7QHlOMoQO7VczjhUJgpg/g0i9ZfUDguyu25xFA/KnvXlAK7NBmW8nZZ3qyPNA1tScWhTt1gslFBpvjnaHJ4GOkFHd2//AJKygai8bQJeBah34HMwiO3tBVK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNITCwgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C24C4CEEB;
	Thu, 26 Jun 2025 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750956883;
	bh=bsxccqjf5fwMXwjYTHfjpl6lBuSTF/V+uMfHf7ud4Lg=;
	h=From:To:Cc:Subject:Date:From;
	b=XNITCwgxNXveAyYFcXRvW1u0Jn+wHRYlfVAbcheqUzv/BisVtQJ6SBEqbtP3vnghl
	 fwxWY37rGqzSWVgSC2vwjghanwnlyxLmg9vLXCfLoMuFme+Msu4opzJFggC9Dy80kN
	 r3oY10x1L3xxKEAu7u65Tm4AzRcrI/HFrBwafL31t/O/+w71aunSwGdLUkQEtv3blg
	 5ljEaEZAygIFFr2ldRYOCFQXdyqjakC+Z0qgANyhwMyDftV9bo2QLEbz0KBCT+b2U4
	 k2SYdnPlYSfeSS1MWeQ9JNbntt7r9KkhbqUNtv1TqXg1dB251oULATUONd4R9sRFx+
	 aS9qCRiuF3SOg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next] eth: bnxt: take page size into account for page pool recycling rings
Date: Thu, 26 Jun 2025 09:54:41 -0700
Message-ID: <20250626165441.4125047-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rx rings are filled with Rx buffers. Which are supposed to fit
packet headers (or MTU if HW-GRO is disabled). The aggregation buffers
are filled with "device pages". Adjust the sizes of the page pool
recycling ring appropriately, based on ratio of the size of the
buffer on given ring vs system page size. Otherwise on a system
with 64kB pages we end up with >700MB of memory sitting in every
single page pool cache.

Correct the size calculation for the head_pool. Since the buffers
there are always small I'm pretty sure I meant to cap the size
at 1k, rather than make it the lowest possible size. With 64k pages
1k cache with a 1k ring is 64x larger than we need.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c5026fa7e6e6..1c6a3ebcda16 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3807,12 +3807,14 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr,
 				   int numa_node)
 {
+	const unsigned int agg_size_fac = PAGE_SIZE / BNXT_RX_PAGE_SIZE;
+	const unsigned int rx_size_fac = PAGE_SIZE / SZ_4K;
 	struct page_pool_params pp = { 0 };
 	struct page_pool *pool;
 
-	pp.pool_size = bp->rx_agg_ring_size;
+	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
-		pp.pool_size += bp->rx_ring_size;
+		pp.pool_size += bp->rx_ring_size / rx_size_fac;
 	pp.nid = numa_node;
 	pp.napi = &rxr->bnapi->napi;
 	pp.netdev = bp->dev;
@@ -3830,7 +3832,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 
 	rxr->need_head_pool = page_pool_is_unreadable(pool);
 	if (bnxt_separate_head_pool(rxr)) {
-		pp.pool_size = max(bp->rx_ring_size, 1024);
+		pp.pool_size = min(bp->rx_ring_size / rx_size_fac, 1024);
 		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pool = page_pool_create(&pp);
 		if (IS_ERR(pool))
-- 
2.50.0


