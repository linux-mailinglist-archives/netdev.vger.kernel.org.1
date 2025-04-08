Return-Path: <netdev+bounces-180041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C95A7F3A5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 06:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0F83AFFEC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A11A9B32;
	Tue,  8 Apr 2025 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlioDczO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820F35973
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 04:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086959; cv=none; b=la9NYYF3d0tJe10hqi59JzOvDzeldfrOrMmqe9Y+KJfejqYDxg6CAFHbJLHu/VU2OA2Fcesx97mZZ8fgwgeyY4oai9BjwyvyToOkaxC0Bfr9MEuyYr98zanohtT9ku3pXyLkfDfuw319JUzkahmxBmERRTmhfmJO9g9abhsr+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086959; c=relaxed/simple;
	bh=p7znpyQsJBYolsQkgWCPWirjUjFXR0WlMYuovYL2WzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q9GoQ5wk9XP9O2UFXdAsxVNvkizlGeaoqc87uXyx2iD77txQPRfIe/YXhFv3DmzjTQ1xCtmhC433MhhM5Gv3wod1dv7l5CE/D0H9tlZxsFGta+Wjp8wAf6m8MwHWzm3ex2e5z4OrQF/M8rfiFj71Ux8K5lwi+MivuBDkkTR7JXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlioDczO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736a72220edso5208750b3a.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744086957; x=1744691757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6060TdYUNSU4IoMjC3IdfcerNOjp5WlLnv+KjqCOqrg=;
        b=GlioDczO3BOLm6/yTuZQmR725pcqP/Rki8+jvD62EFKoKkdRSa6MKJoy8HgGmXVoTy
         h4p3Pk4snnDpS48K+vto1i9sfJngcQeUuSmU/QDLCkWkH/qVGOTV1SipnWMvv1npRUm7
         fFWIiA7tHSinuB5HasKOubiLHIQdA4MGb7yWzxJUu8S62OOWGwkNTRq6lJz7e1IacITw
         rwoCljCi87ISNUmVFYxisM9o+15dM0Z8c4k06wIp/Ntlt85/cRiiRwoiUsU1l8dcASjM
         Q53ggulRToMm3LkvXG6wSII+f/TQ0A7bYSBZilZbJ8sfyfmyZg+M3mE4vjpLcAo6ecOG
         x8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744086957; x=1744691757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6060TdYUNSU4IoMjC3IdfcerNOjp5WlLnv+KjqCOqrg=;
        b=QF5exjb2nXqhrRc9UIBsuZ7IrfPIyiHov6OMEMkmPbJTK/uiv86O4aVkCz9QRujmdV
         RK8QWS4Pwqlp2hrwVuMkgjDBiYkRAFvMwfY6bFuuNtrYvlR64LCUKaJwyUE+LOgXMcIc
         YiH8CsYGlrSW47OF9Q6SQLNUGpMc7ZJZfDnfZFPRi5m4tyASHg5WtzVGhyWo7GMDdCRh
         k5A5bvuBrU3BP9nOOWDACarqdQaS/N+bcBoHkf3d6t1gViib+9Bc+ttPO112YR0abVQf
         38lSiUNepJSnHtLA9MsS1mwk6cl69U+EZ78ofxdtiyUVWYz9UAt8WZ3TA9LTZaQ0sPjh
         Bzzg==
X-Forwarded-Encrypted: i=1; AJvYcCUNUFihCdKQazi4InGQGzymupxOR5Qx6+K00NgimU9mmAKAUAO9NP70AoihkTCzrfjZtXpIkkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhb6QLTcDQHyJ14WFFuyyzyuJUsLgncFjYivmsDjxWO6cxrp6c
	aAYnUeOfdAOduKO2qyTiOerPb0bU1c34A8XPg9O9zqqER58eQzjQ
X-Gm-Gg: ASbGncu33YZ/gJrkzVnHvKZO1CwovMFHLyUnoMwDk0QHavTrCliGTXTJaMfLYrntRna
	nIq4FmgYXjcdSXv9AM5iyL6+SqQFyWHNuPOpg2Qr+/cSJJED0xIsOigDWLRv+vBCeisJPu8qmLZ
	sRkqfIkh2XkP0t517GMeXxJej5HH1gDqBUUJ/W+qBLTjSXQJ1y47eS9zsmho6Fpk3B4VxhtPlIf
	2+M4BCuymyLnHW4pRdvWQskEc28aS/kDnzaQdu0lwEDxaocVPar7PXZUWBhVa/RhoYPMj5wDVyx
	xf0WNHC8Rn01Pqj2ewLAZcnizOjhYuC4zw==
X-Google-Smtp-Source: AGHT+IEPRX69ZBWbVLt+JcJ95SJnLezGC7G8HU38FA4nKSypl6MfL7Pr644TnlKBZYDGBiAWetvRMA==
X-Received: by 2002:a05:6a20:c896:b0:1f5:889c:3cbd with SMTP id adf61e73a8af0-20113d5539amr19847636637.35.1744086956869;
        Mon, 07 Apr 2025 21:35:56 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b4317sm9758280b3a.148.2025.04.07.21.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 21:35:56 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	netdev@vger.kernel.org
Cc: dw@davidwei.uk,
	kuniyu@amazon.com,
	sdf@fomichev.me,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	ap420073@gmail.com
Subject: [PATCH net-next] eth: bnxt: add support rx side device memory TCP
Date: Tue,  8 Apr 2025 04:35:45 +0000
Message-Id: <20250408043545.2179381-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bnxt_en driver satisfies the requirements of the Device
memory TCP, which is HDS.
So, it implements rx-side Device memory TCP for bnxt_en driver.
It requires only converting the page API to netmem API.
`struct page` of agg rings are changed to `netmem_ref netmem` and
corresponding functions are changed to a variant of netmem API.

It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of
page_pool.
The netmem will be activated only when a user requests devmem TCP.

When netmem is activated, received data is unreadable and netmem is
disabled, received data is readable.
But drivers don't need to handle both cases because netmem core API will
handle it properly.
So, using proper netmem API is enough for drivers.

Device memory TCP can be tested with
tools/testing/selftests/drivers/net/hw/ncdevmem.
This is tested with BCM57504-N425G and firmware version 232.0.155.8/pkg
232.1.132.8.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

RFC -> PATCH v1:
 - Drop ring buffer descriptor refactoring patch.
 - Do not convert to netmem API for normal ring(non-agg ring).
 - Remove changes of napi_{enable | disable}() to
   napi_{enable | disable}_locked().
 - Relocate a need_head_pool in struct bnxt_rx_ring_info due to
   an alignment hole.
 - Remove *offset parameter of __bnxt_alloc_rx_netmem().
   *offset is always set to 0 in this function. it's unnecessary.
 - Get skb_shared_info outside of loop in __bnxt_rx_agg_netmems().
 - Drop Tested-by tag due to changes of this patch.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 201 +++++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   3 +-
 include/linux/netdevice.h                 |   1 +
 include/net/page_pool/helpers.h           |   6 +
 net/core/dev.c                            |   6 +
 5 files changed, 137 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 28ee12186c37..eb36646d2f8b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -893,9 +893,9 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		bnapi->events &= ~BNXT_TX_CMP_EVENT;
 }
 
-static bool bnxt_separate_head_pool(void)
+static bool bnxt_separate_head_pool(struct bnxt_rx_ring_info *rxr)
 {
-	return PAGE_SIZE > BNXT_RX_PAGE_SIZE;
+	return rxr->need_head_pool || PAGE_SIZE > BNXT_RX_PAGE_SIZE;
 }
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
@@ -919,6 +919,20 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 	return page;
 }
 
+static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *mapping,
+					 struct bnxt_rx_ring_info *rxr,
+					 gfp_t gfp)
+{
+	netmem_ref netmem;
+
+	netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
+	if (!netmem)
+		return 0;
+
+	*mapping = page_pool_get_dma_addr_netmem(netmem);
+	return netmem;
+}
+
 static inline u8 *__bnxt_alloc_rx_frag(struct bnxt *bp, dma_addr_t *mapping,
 				       struct bnxt_rx_ring_info *rxr,
 				       gfp_t gfp)
@@ -999,21 +1013,20 @@ static inline u16 bnxt_find_next_agg_idx(struct bnxt_rx_ring_info *rxr, u16 idx)
 	return next;
 }
 
-static inline int bnxt_alloc_rx_page(struct bnxt *bp,
-				     struct bnxt_rx_ring_info *rxr,
-				     u16 prod, gfp_t gfp)
+static inline int bnxt_alloc_rx_netmem(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr,
+				       u16 prod, gfp_t gfp)
 {
 	struct rx_bd *rxbd =
 		&rxr->rx_agg_desc_ring[RX_AGG_RING(bp, prod)][RX_IDX(prod)];
 	struct bnxt_sw_rx_agg_bd *rx_agg_buf;
-	struct page *page;
-	dma_addr_t mapping;
 	u16 sw_prod = rxr->rx_sw_agg_prod;
 	unsigned int offset = 0;
+	dma_addr_t mapping;
+	netmem_ref netmem;
 
-	page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
-
-	if (!page)
+	netmem = __bnxt_alloc_rx_netmem(bp, &mapping, rxr, gfp);
+	if (!netmem)
 		return -ENOMEM;
 
 	if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
@@ -1023,7 +1036,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 	rx_agg_buf = &rxr->rx_agg_ring[sw_prod];
 	rxr->rx_sw_agg_prod = RING_RX_AGG(bp, NEXT_RX_AGG(sw_prod));
 
-	rx_agg_buf->page = page;
+	rx_agg_buf->netmem = netmem;
 	rx_agg_buf->offset = offset;
 	rx_agg_buf->mapping = mapping;
 	rxbd->rx_bd_haddr = cpu_to_le64(mapping);
@@ -1067,11 +1080,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 		p5_tpa = true;
 
 	for (i = 0; i < agg_bufs; i++) {
-		u16 cons;
-		struct rx_agg_cmp *agg;
 		struct bnxt_sw_rx_agg_bd *cons_rx_buf, *prod_rx_buf;
+		struct rx_agg_cmp *agg;
 		struct rx_bd *prod_bd;
-		struct page *page;
+		netmem_ref netmem;
+		u16 cons;
 
 		if (p5_tpa)
 			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, start + i);
@@ -1088,11 +1101,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 		cons_rx_buf = &rxr->rx_agg_ring[cons];
 
 		/* It is possible for sw_prod to be equal to cons, so
-		 * set cons_rx_buf->page to NULL first.
+		 * set cons_rx_buf->netmem to 0 first.
 		 */
-		page = cons_rx_buf->page;
-		cons_rx_buf->page = NULL;
-		prod_rx_buf->page = page;
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
+		prod_rx_buf->netmem = netmem;
 		prod_rx_buf->offset = cons_rx_buf->offset;
 
 		prod_rx_buf->mapping = cons_rx_buf->mapping;
@@ -1218,29 +1231,36 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 	return skb;
 }
 
-static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
-			       struct bnxt_cp_ring_info *cpr,
-			       struct skb_shared_info *shinfo,
-			       u16 idx, u32 agg_bufs, bool tpa,
-			       struct xdp_buff *xdp)
+static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
+				 struct bnxt_cp_ring_info *cpr,
+				 u16 idx, u32 agg_bufs, bool tpa,
+				 struct sk_buff *skb,
+				 struct xdp_buff *xdp)
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
-	struct pci_dev *pdev = bp->pdev;
-	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
-	u16 prod = rxr->rx_agg_prod;
+	struct skb_shared_info *shinfo;
+	struct bnxt_rx_ring_info *rxr;
 	u32 i, total_frag_len = 0;
 	bool p5_tpa = false;
+	u16 prod;
+
+	rxr = bnapi->rx_ring;
+	prod = rxr->rx_agg_prod;
 
 	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && tpa)
 		p5_tpa = true;
 
+	if (skb)
+		shinfo = skb_shinfo(skb);
+	else
+		shinfo = xdp_get_shared_info_from_buff(xdp);
+
 	for (i = 0; i < agg_bufs; i++) {
-		skb_frag_t *frag = &shinfo->frags[i];
-		u16 cons, frag_len;
-		struct rx_agg_cmp *agg;
 		struct bnxt_sw_rx_agg_bd *cons_rx_buf;
-		struct page *page;
+		struct rx_agg_cmp *agg;
+		u16 cons, frag_len;
 		dma_addr_t mapping;
+		netmem_ref netmem;
 
 		if (p5_tpa)
 			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, i);
@@ -1251,27 +1271,42 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
 
 		cons_rx_buf = &rxr->rx_agg_ring[cons];
-		skb_frag_fill_page_desc(frag, cons_rx_buf->page,
-					cons_rx_buf->offset, frag_len);
-		shinfo->nr_frags = i + 1;
+		if (skb) {
+			skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
+					       cons_rx_buf->offset,
+					       frag_len, BNXT_RX_PAGE_SIZE);
+		} else {
+			skb_frag_t *frag = &shinfo->frags[i];
+
+			skb_frag_fill_netmem_desc(frag, cons_rx_buf->netmem,
+						  cons_rx_buf->offset,
+						  frag_len);
+			shinfo->nr_frags = i + 1;
+		}
 		__clear_bit(cons, rxr->rx_agg_bmap);
 
-		/* It is possible for bnxt_alloc_rx_page() to allocate
+		/* It is possible for bnxt_alloc_rx_netmem() to allocate
 		 * a sw_prod index that equals the cons index, so we
 		 * need to clear the cons entry now.
 		 */
 		mapping = cons_rx_buf->mapping;
-		page = cons_rx_buf->page;
-		cons_rx_buf->page = NULL;
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
 
-		if (xdp && page_is_pfmemalloc(page))
+		if (xdp && netmem_is_pfmemalloc(netmem))
 			xdp_buff_set_frag_pfmemalloc(xdp);
 
-		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_ATOMIC) != 0) {
+		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_ATOMIC) != 0) {
+			if (skb) {
+				skb->len -= frag_len;
+				skb->data_len -= frag_len;
+				skb->truesize -= BNXT_RX_PAGE_SIZE;
+			}
+
 			--shinfo->nr_frags;
-			cons_rx_buf->page = page;
+			cons_rx_buf->netmem = netmem;
 
-			/* Update prod since possibly some pages have been
+			/* Update prod since possibly some netmems have been
 			 * allocated already.
 			 */
 			rxr->rx_agg_prod = prod;
@@ -1279,8 +1314,8 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			return 0;
 		}
 
-		dma_sync_single_for_cpu(&pdev->dev, mapping, BNXT_RX_PAGE_SIZE,
-					bp->rx_dir);
+		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
+						  BNXT_RX_PAGE_SIZE);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -1289,32 +1324,28 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 	return total_frag_len;
 }
 
-static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
-					     struct bnxt_cp_ring_info *cpr,
-					     struct sk_buff *skb, u16 idx,
-					     u32 agg_bufs, bool tpa)
+static struct sk_buff *bnxt_rx_agg_netmems_skb(struct bnxt *bp,
+					       struct bnxt_cp_ring_info *cpr,
+					       struct sk_buff *skb, u16 idx,
+					       u32 agg_bufs, bool tpa)
 {
-	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	u32 total_frag_len = 0;
 
-	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo, idx,
-					     agg_bufs, tpa, NULL);
+	total_frag_len = __bnxt_rx_agg_netmems(bp, cpr, idx, agg_bufs, tpa,
+					       skb, NULL);
 	if (!total_frag_len) {
 		skb_mark_for_recycle(skb);
 		dev_kfree_skb(skb);
 		return NULL;
 	}
 
-	skb->data_len += total_frag_len;
-	skb->len += total_frag_len;
-	skb->truesize += BNXT_RX_PAGE_SIZE * agg_bufs;
 	return skb;
 }
 
-static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
-				 struct bnxt_cp_ring_info *cpr,
-				 struct xdp_buff *xdp, u16 idx,
-				 u32 agg_bufs, bool tpa)
+static u32 bnxt_rx_agg_netmems_xdp(struct bnxt *bp,
+				   struct bnxt_cp_ring_info *cpr,
+				   struct xdp_buff *xdp, u16 idx,
+				   u32 agg_bufs, bool tpa)
 {
 	struct skb_shared_info *shinfo = xdp_get_shared_info_from_buff(xdp);
 	u32 total_frag_len = 0;
@@ -1322,8 +1353,8 @@ static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
 	if (!xdp_buff_has_frags(xdp))
 		shinfo->nr_frags = 0;
 
-	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo,
-					     idx, agg_bufs, tpa, xdp);
+	total_frag_len = __bnxt_rx_agg_netmems(bp, cpr, idx, agg_bufs, tpa,
+					       NULL, xdp);
 	if (total_frag_len) {
 		xdp_buff_set_frags_flag(xdp);
 		shinfo->nr_frags = agg_bufs;
@@ -1895,7 +1926,8 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 	}
 
 	if (agg_bufs) {
-		skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, idx, agg_bufs, true);
+		skb = bnxt_rx_agg_netmems_skb(bp, cpr, skb, idx, agg_bufs,
+					      true);
 		if (!skb) {
 			/* Page reuse already handled by bnxt_rx_pages(). */
 			cpr->sw_stats->rx.rx_oom_discards += 1;
@@ -2175,9 +2207,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	if (bnxt_xdp_attached(bp, rxr)) {
 		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
 		if (agg_bufs) {
-			u32 frag_len = bnxt_rx_agg_pages_xdp(bp, cpr, &xdp,
-							     cp_cons, agg_bufs,
-							     false);
+			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr, &xdp,
+							       cp_cons,
+							       agg_bufs,
+							       false);
 			if (!frag_len)
 				goto oom_next_rx;
 
@@ -2229,7 +2262,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 	if (agg_bufs) {
 		if (!xdp_active) {
-			skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, cp_cons, agg_bufs, false);
+			skb = bnxt_rx_agg_netmems_skb(bp, cpr, skb, cp_cons,
+						      agg_bufs, false);
 			if (!skb)
 				goto oom_next_rx;
 		} else {
@@ -3445,15 +3479,15 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt *bp, struct bnxt_rx_ring_info
 
 	for (i = 0; i < max_idx; i++) {
 		struct bnxt_sw_rx_agg_bd *rx_agg_buf = &rxr->rx_agg_ring[i];
-		struct page *page = rx_agg_buf->page;
+		netmem_ref netmem = rx_agg_buf->netmem;
 
-		if (!page)
+		if (!netmem)
 			continue;
 
-		rx_agg_buf->page = NULL;
+		rx_agg_buf->netmem = 0;
 		__clear_bit(i, rxr->rx_agg_bmap);
 
-		page_pool_recycle_direct(rxr->page_pool, page);
+		page_pool_recycle_direct_netmem(rxr->page_pool, netmem);
 	}
 }
 
@@ -3746,7 +3780,7 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 			xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 		page_pool_destroy(rxr->page_pool);
-		if (bnxt_separate_head_pool())
+		if (bnxt_separate_head_pool(rxr))
 			page_pool_destroy(rxr->head_pool);
 		rxr->page_pool = rxr->head_pool = NULL;
 
@@ -3777,15 +3811,20 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
 	pp.max_len = PAGE_SIZE;
-	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
+		   PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+	pp.queue_idx = rxr->bnapi->index;
+	pp.order = 0;
 
 	pool = page_pool_create(&pp);
 	if (IS_ERR(pool))
 		return PTR_ERR(pool);
 	rxr->page_pool = pool;
 
-	if (bnxt_separate_head_pool()) {
+	rxr->need_head_pool = dev_is_mp_channel(bp->dev, rxr->bnapi->index);
+	if (bnxt_separate_head_pool(rxr)) {
 		pp.pool_size = max(bp->rx_ring_size, 1024);
+		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pool = page_pool_create(&pp);
 		if (IS_ERR(pool))
 			goto err_destroy_pp;
@@ -4197,6 +4236,8 @@ static void bnxt_reset_rx_ring_struct(struct bnxt *bp,
 
 	rxr->page_pool->p.napi = NULL;
 	rxr->page_pool = NULL;
+	rxr->head_pool->p.napi = NULL;
+	rxr->head_pool = NULL;
 	memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
 
 	ring = &rxr->rx_ring_struct;
@@ -4321,16 +4362,16 @@ static void bnxt_alloc_one_rx_ring_skb(struct bnxt *bp,
 	rxr->rx_prod = prod;
 }
 
-static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
-					struct bnxt_rx_ring_info *rxr,
-					int ring_nr)
+static void bnxt_alloc_one_rx_ring_netmem(struct bnxt *bp,
+					  struct bnxt_rx_ring_info *rxr,
+					  int ring_nr)
 {
 	u32 prod;
 	int i;
 
 	prod = rxr->rx_agg_prod;
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
-		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_KERNEL)) {
+		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_ring_size);
 			break;
@@ -4371,7 +4412,7 @@ static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
 	if (!(bp->flags & BNXT_FLAG_AGG_RINGS))
 		return 0;
 
-	bnxt_alloc_one_rx_ring_page(bp, rxr, ring_nr);
+	bnxt_alloc_one_rx_ring_netmem(bp, rxr, ring_nr);
 
 	if (rxr->rx_tpa) {
 		rc = bnxt_alloc_one_tpa_info_data(bp, rxr);
@@ -15708,6 +15749,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	clone->rx_agg_prod = 0;
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
+	clone->need_head_pool = false;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -15750,7 +15792,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 
 	bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
-		bnxt_alloc_one_rx_ring_page(bp, clone, idx);
+		bnxt_alloc_one_rx_ring_netmem(bp, clone, idx);
 	if (bp->flags & BNXT_FLAG_TPA)
 		bnxt_alloc_one_tpa_info_data(bp, clone);
 
@@ -15766,7 +15808,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	xdp_rxq_info_unreg(&clone->xdp_rxq);
 err_page_pool_destroy:
 	page_pool_destroy(clone->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(rxr))
 		page_pool_destroy(clone->head_pool);
 	clone->page_pool = NULL;
 	clone->head_pool = NULL;
@@ -15785,7 +15827,7 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 	page_pool_destroy(rxr->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(rxr))
 		page_pool_destroy(rxr->head_pool);
 	rxr->page_pool = NULL;
 	rxr->head_pool = NULL;
@@ -15876,6 +15918,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	rxr->page_pool = clone->page_pool;
 	rxr->head_pool = clone->head_pool;
 	rxr->xdp_rxq = clone->xdp_rxq;
+	rxr->need_head_pool = clone->need_head_pool;
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
 
@@ -15961,7 +16004,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	page_pool_disable_direct_recycling(rxr->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(rxr))
 		page_pool_disable_direct_recycling(rxr->head_pool);
 
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 21726cf56586..868a2e5a5b02 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -903,7 +903,7 @@ struct bnxt_sw_rx_bd {
 };
 
 struct bnxt_sw_rx_agg_bd {
-	struct page		*page;
+	netmem_ref		netmem;
 	unsigned int		offset;
 	dma_addr_t		mapping;
 };
@@ -1106,6 +1106,7 @@ struct bnxt_rx_ring_info {
 
 	unsigned long		*rx_agg_bmap;
 	u16			rx_agg_bmap_size;
+	bool                    need_head_pool;
 
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
 	dma_addr_t		rx_agg_desc_mapping[MAX_RX_AGG_PAGES];
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf3b6445817b..80ff25e55279 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4225,6 +4225,7 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
 u32 dev_get_min_mp_channel_count(const struct net_device *dev);
+bool dev_is_mp_channel(struct net_device *dev, int i);
 
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
 int dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 582a3d00cbe2..9b7a3a996bbe 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -395,6 +395,12 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 	page_pool_put_full_page(pool, page, true);
 }
 
+static inline void page_pool_recycle_direct_netmem(struct page_pool *pool,
+						   netmem_ref netmem)
+{
+	page_pool_put_full_netmem(pool, netmem, true);
+}
+
 #define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA	\
 		(sizeof(dma_addr_t) > sizeof(unsigned long))
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 0608605cfc24..5d236a175718 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10372,6 +10372,12 @@ u32 dev_get_min_mp_channel_count(const struct net_device *dev)
 	return 0;
 }
 
+bool dev_is_mp_channel(struct net_device *dev, int i)
+{
+	return !!dev->_rx[i].mp_params.mp_priv;
+}
+EXPORT_SYMBOL(dev_is_mp_channel);
+
 /**
  * dev_index_reserve() - allocate an ifindex in a namespace
  * @net: the applicable net namespace
-- 
2.34.1


