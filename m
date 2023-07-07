Return-Path: <netdev+bounces-16108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5A474B685
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75D51C2108B
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8717AB5;
	Fri,  7 Jul 2023 18:39:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36511773B
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E23AC433AD;
	Fri,  7 Jul 2023 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755187;
	bh=oOZK2/uAWawUFNipirfKJhooZ2GGqhhTHhAfBQDVBDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ph+qKNmWRFyi5n5qqpLUDUsX+5oKVz7AUnR0LHEMZBsnQLywim6kD2lU5jevTNKOX
	 f6X+twYiKgDaG9myiMWJrxyjOMSLl9rSBARUjRYoU1/jmXHvSWUDiUF6EhFZDb9ZDd
	 n3WR26AIYI1fBIzw0Mr5TcIyvOXnH1Srop+aGdJ0MNXcKl6ADOFYu3jqGw6zROWzFH
	 ep+dnQOEXQ45q7bEUc78zwCTTnuGvOJayumjEZ2NqU48/vl7VK21/cTFi6FtMq48PU
	 6eRGSMx7uQceWrEZBQ4sd1Ou6IuQwfsB0ibMSjyiCHt8PTy7bjLzPk2Dm2n9D+KcUd
	 DnhnPmOvpM8PA==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	edumazet@google.com,
	dsahern@gmail.com,
	michael.chan@broadcom.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 09/12] eth: bnxt: use the page pool for data pages
Date: Fri,  7 Jul 2023 11:39:32 -0700
Message-ID: <20230707183935.997267-10-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707183935.997267-1-kuba@kernel.org>
References: <20230707183935.997267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To benefit from page recycling allocate the agg pages (used by HW-GRO
and jumbo) from the page pool.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 43 ++++++++++++-----------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6512514cd498..734c2c6cad69 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -811,33 +811,27 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 	u16 sw_prod = rxr->rx_sw_agg_prod;
 	unsigned int offset = 0;
 
-	if (BNXT_RX_PAGE_MODE(bp)) {
+	if (PAGE_SIZE <= BNXT_RX_PAGE_SIZE || BNXT_RX_PAGE_MODE(bp)) {
 		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, gfp);
 
 		if (!page)
 			return -ENOMEM;
 
 	} else {
-		if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
-			page = rxr->rx_page;
-			if (!page) {
-				page = alloc_page(gfp);
-				if (!page)
-					return -ENOMEM;
-				rxr->rx_page = page;
-				rxr->rx_page_offset = 0;
-			}
-			offset = rxr->rx_page_offset;
-			rxr->rx_page_offset += BNXT_RX_PAGE_SIZE;
-			if (rxr->rx_page_offset == PAGE_SIZE)
-				rxr->rx_page = NULL;
-			else
-				get_page(page);
-		} else {
+		page = rxr->rx_page;
+		if (!page) {
 			page = alloc_page(gfp);
 			if (!page)
 				return -ENOMEM;
+			rxr->rx_page = page;
+			rxr->rx_page_offset = 0;
 		}
+		offset = rxr->rx_page_offset;
+		rxr->rx_page_offset += BNXT_RX_PAGE_SIZE;
+		if (rxr->rx_page_offset == PAGE_SIZE)
+			rxr->rx_page = NULL;
+		else
+			get_page(page);
 
 		mapping = dma_map_page_attrs(&pdev->dev, page, offset,
 					     BNXT_RX_PAGE_SIZE, DMA_FROM_DEVICE,
@@ -1046,6 +1040,8 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 
 	skb_reserve(skb, bp->rx_offset);
 	skb_put(skb, offset_and_len & 0xffff);
+	skb_mark_for_recycle(skb);
+
 	return skb;
 }
 
@@ -1110,9 +1106,13 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			return 0;
 		}
 
-		dma_unmap_page_attrs(&pdev->dev, mapping, BNXT_RX_PAGE_SIZE,
-				     bp->rx_dir,
-				     DMA_ATTR_WEAK_ORDERING);
+		if (PAGE_SIZE > BNXT_RX_PAGE_SIZE)
+			dma_unmap_page_attrs(&pdev->dev, mapping,
+					     BNXT_RX_PAGE_SIZE, bp->rx_dir,
+					     DMA_ATTR_WEAK_ORDERING);
+		else
+			dma_sync_single_for_cpu(&pdev->dev, mapping,
+						PAGE_SIZE, DMA_BIDIRECTIONAL);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -1754,6 +1754,7 @@ static void bnxt_deliver_skb(struct bnxt *bp, struct bnxt_napi *bnapi,
 		return;
 	}
 	skb_record_rx_queue(skb, bnapi->index);
+	skb_mark_for_recycle(skb);
 	napi_gro_receive(&bnapi->napi, skb);
 }
 
@@ -2960,7 +2961,7 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		if (!page)
 			continue;
 
-		if (BNXT_RX_PAGE_MODE(bp)) {
+		if (PAGE_SIZE <= BNXT_RX_PAGE_SIZE || BNXT_RX_PAGE_MODE(bp)) {
 			rx_agg_buf->page = NULL;
 			__clear_bit(i, rxr->rx_agg_bmap);
 
-- 
2.41.0


