Return-Path: <netdev+bounces-152267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7599F34F8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A87162450
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32CF14D2A2;
	Mon, 16 Dec 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tMgyEsFk"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563D1369AE
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364293; cv=none; b=G+xQ3cTkDtsAto2hEgyoYu1RhzzWb7u5XJLcH9Ejfi95p8fp8Awix6y0MtizCsVq9aljPOMdZum7LSH6uTpzKCUVhdqjIGH9H1+ehkpcLyl58fsTSQysO3VpDe3tGM0D/cDwre0c9oP+OuCqoM112LLspRYWvU1nNmbsmdRkK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364293; c=relaxed/simple;
	bh=JWyMlJ42sfYfy6j/XdGv0H+1tzW7mHPoYNqB0He1ijI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OaqGm0anU1RzbH1jm2UZ3smzEWKNg7VJcVImxklQdeTHCByNvhfaQl4wLkYJiRuS0ME/JhyCfSvmP5heqzas2sJc+z+qtH5vYXtr8rA0JVt/RCbD1BDVB8l+qZwkjFNZHt2kxs78pBbiewm+VMSH7ak0R7ErcoadwBP/3Dl9T68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tMgyEsFk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=uErsYTN3fuqgzH3wySCa9nVJafSXiODQbBwQOglZQGA=; b=tMgyEsFkw0A24FaJ1CHiKtL7qX
	Oussf5AD1yKgduMJDSjhvvbvbPdOY+SZOFPGN5Jf2o+G4ZqaB5xVMm8SPzlNDgd+bOeKg3Ru7NaLQ
	vuFwV/lCbz1UzRcm/VkAdsU+JQlZdSDzQc9to/bw08W3cE3fJF56zap4bU0dlwV+Os80CB7k0NQ7A
	iFIErl6FLuKsi8A9xZOt8jgLWfWYs/JreeDiWqyYlRYdxWqiAU2gnixaGd0lw6nLY41yiy925njr9
	huWCJ76ZwoRIvfQoUW8rccSFDaOHdKJi9m1ABWHbIydiZ3ej7Lvqw9GqyX28MapR7BYbSiI4q7WVp
	Gw0JVmHg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDNW-000000000oy-3cOc;
	Mon, 16 Dec 2024 15:51:26 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] niu: Use page->private instead of page->index
Date: Mon, 16 Dec 2024 15:51:22 +0000
Message-ID: <20241216155124.3114-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are close to removing page->index.  Use page->private instead, which
is least likely to be removed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/net/ethernet/sun/niu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index df6d35d41b97..d7459866d24c 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3303,7 +3303,7 @@ static struct page *niu_find_rxpage(struct rx_ring_info *rp, u64 addr,
 	addr &= PAGE_MASK;
 	pp = &rp->rxhash[h];
 	for (; (p = *pp) != NULL; pp = &niu_next_page(p)) {
-		if (p->index == addr) {
+		if (p->private == addr) {
 			*link = pp;
 			goto found;
 		}
@@ -3318,7 +3318,7 @@ static void niu_hash_page(struct rx_ring_info *rp, struct page *page, u64 base)
 {
 	unsigned int h = niu_hash_rxaddr(rp, base);
 
-	page->index = base;
+	page->private = base;
 	niu_next_page(page) = rp->rxhash[h];
 	rp->rxhash[h] = page;
 }
@@ -3400,11 +3400,11 @@ static int niu_rx_pkt_ignore(struct niu *np, struct rx_ring_info *rp)
 
 		rcr_size = rp->rbr_sizes[(val & RCR_ENTRY_PKTBUFSZ) >>
 					 RCR_ENTRY_PKTBUFSZ_SHIFT];
-		if ((page->index + PAGE_SIZE) - rcr_size == addr) {
+		if ((page->private + PAGE_SIZE) - rcr_size == addr) {
 			*link = niu_next_page(page);
-			np->ops->unmap_page(np->device, page->index,
+			np->ops->unmap_page(np->device, page->private,
 					    PAGE_SIZE, DMA_FROM_DEVICE);
-			page->index = 0;
+			page->private = 0;
 			niu_next_page(page) = NULL;
 			__free_page(page);
 			rp->rbr_refill_pending++;
@@ -3469,11 +3469,11 @@ static int niu_process_rx_pkt(struct napi_struct *napi, struct niu *np,
 			append_size = append_size - skb->len;
 
 		niu_rx_skb_append(skb, page, off, append_size, rcr_size);
-		if ((page->index + rp->rbr_block_size) - rcr_size == addr) {
+		if ((page->private + rp->rbr_block_size) - rcr_size == addr) {
 			*link = niu_next_page(page);
-			np->ops->unmap_page(np->device, page->index,
+			np->ops->unmap_page(np->device, page->private,
 					    PAGE_SIZE, DMA_FROM_DEVICE);
-			page->index = 0;
+			page->private = 0;
 			niu_next_page(page) = NULL;
 			rp->rbr_refill_pending++;
 		} else
@@ -3538,11 +3538,11 @@ static void niu_rbr_free(struct niu *np, struct rx_ring_info *rp)
 		page = rp->rxhash[i];
 		while (page) {
 			struct page *next = niu_next_page(page);
-			u64 base = page->index;
+			u64 base = page->private;
 
 			np->ops->unmap_page(np->device, base, PAGE_SIZE,
 					    DMA_FROM_DEVICE);
-			page->index = 0;
+			page->private = 0;
 			niu_next_page(page) = NULL;
 
 			__free_page(page);
@@ -6460,7 +6460,7 @@ static void niu_reset_buffers(struct niu *np)
 				page = rp->rxhash[j];
 				while (page) {
 					struct page *next = niu_next_page(page);
-					u64 base = page->index;
+					u64 base = page->private;
 					base = base >> RBR_DESCR_ADDR_SHIFT;
 					rp->rbr[k++] = cpu_to_le32(base);
 					page = next;
-- 
2.45.2


