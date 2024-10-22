Return-Path: <netdev+bounces-137956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC99AB3E2
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426A81C20FF1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D041A3049;
	Tue, 22 Oct 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8vPx+yd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA791A7066;
	Tue, 22 Oct 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614338; cv=none; b=HXxHmII2LirEW6FV/R+Y2iVVMHN1Xxxeekp/P65b8FqCcguVu9XGpUVSIcZcqI4rAZxjMviF83V4dw6ebbywSbjgPUr5z/K+EBmnrPYf85hmEUAuYpdRsluUjpQud519w94BiiI8QZ4GxGWoYBuJPxVx2UXUTivEliZJKFqzUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614338; c=relaxed/simple;
	bh=j96oZcqEKsNRKCctTBOl4akz3+l+4hQVY3njXcOE2XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LwxMLsRTpsS/9UjxzwqmB067gJzyOJNLLs2tLGvIAf7x4oakr+WHa/6fnHFfESaQKzoJ9zJetO6suYPi+yY9aPSXbAv4IWl+0yy/qF9l3nVttNrb3vQ9wyajROdGUW7lUr4+PJaNQMZ/UWYowEW1RdSmOiNXsJNvpYd/X04ikgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8vPx+yd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c9978a221so66713435ad.1;
        Tue, 22 Oct 2024 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614336; x=1730219136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0v/wmTaHSYkZlVVyyOyADC8iYOB25lwIi/yh3ZE9a4=;
        b=L8vPx+yd1+Yly/2xrOQZUHs8pKDcRp1CWrlAxO5s+/tkjVf148sJcPW2d8P2XwmM16
         n8/5dU4onlSS4Y8cLa7oRmqfXcPVE3hl17+7MjDuZJ/2lNUzwoqhj/+AfuLm+H8L/0IT
         k3lDTtI3cxtVG9V6Y3HC/c9Xa92EM2BM5oldw99D2EdE5+u21+J1PzXtOqwSi++qq1NT
         VApysu6Xjc+NL88MKiyLRkf4dvUGCYsRB9SD0hwpIDwiir1FutVUpKZy4VpesQB0cQPc
         6tzecipIoAKKh/JZ7VQ+3lE7FpaK94lIpmuzn55gBEcBzs3ShS6Pdgl6wyHVP2XPic8D
         rOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614336; x=1730219136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0v/wmTaHSYkZlVVyyOyADC8iYOB25lwIi/yh3ZE9a4=;
        b=FtmNHYIOlCinLxMTXSWQjfRL6xyNG9cqyfrWWV9TXlJIF9yyajE3grErAlSj9N90gu
         HVmzmoY8DZv7d0kAXJ25hwUYuA6FW5mv1ogjaflbwJ4KY9H0vHOglbuCInqlrNsKB7g8
         wacRUTZjnB0zHMSojOrqNZmWyYIJoiaPJd8cqfIJH6zKahlFwgfflLXMAn7f7seOdWAD
         yo/ak3eQIzZyRG5CWjos6tAuO9YPsONY/3Fw+skWILzLB7a+SVCD+7NtrSlxY47AEqs6
         IT/0iOM8DFHiMtbPPdEmwMR7Ho1oDt/e1f5af+0dk5GWOb/UWG4e+2YV3YeHpJVJz/08
         72IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhA85FNJBX/6Fq3nAIOpW/uxzSvbRJF3tO0UhXWFMbqFXgEwIG4J/Gp/fAnbuHIxpelJpLfSgYEik=@vger.kernel.org, AJvYcCVLpqi7zoUzILXP+OjGm73FDdJgFWPGwk5IR3vPsvaPz03TZkcRlRBLIP55WldPCLch4eYtyDox@vger.kernel.org
X-Gm-Message-State: AOJu0YylqYQ9h9mx7XxYKrmByP1db6liMVBzZYywWWnI3DWEtl/Ax0lL
	qiC0TbqN+PukEJWOdjxSx66A4Cvd6gjTnWcmn7PWZonSxitZ0RqR
X-Google-Smtp-Source: AGHT+IHBoNe4BAn764ooLIwU3QOWtp7XvAr+dnUijIJdGAV5OM+tqnZcaWk80eYtKEU+GIEiAzK4fg==
X-Received: by 2002:a17:902:ec8e:b0:206:aac4:b844 with SMTP id d9443c01a7336-20e5a709796mr243071945ad.6.1729614336027;
        Tue, 22 Oct 2024 09:25:36 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee6602sm44755205ad.1.2024.10.22.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:25:29 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v4 8/8] bnxt_en: add support for device memory tcp
Date: Tue, 22 Oct 2024 16:23:59 +0000
Message-Id: <20241022162359.2713094-9-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022162359.2713094-1-ap420073@gmail.com>
References: <20241022162359.2713094-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bnxt_en driver satisfies the requirements of Device memory
TCP, which is tcp-data-split.
So, it implements Device memory TCP for bnxt_en driver.

From now on, the aggregation ring handles netmem_ref instead of page
regardless of the on/off of netmem.
So, for the aggregation ring, memory will be handled with the netmem
page_pool API instead of generic page_pool API.

If Devmem is enabled, netmem_ref is used as-is and if Devmem is not
enabled, netmem_ref will be converted to page and that is used.

Driver recognizes whether the devmem is set or unset based on the
mp_params.mp_priv is not NULL.
Only if devmem is set, it passes PP_FLAG_ALLOW_UNREADABLE_NETMEM.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v4:
 - Do not select NET_DEVMEM in Kconfig.
 - Pass PP_FLAG_ALLOW_UNREADABLE_NETMEM flag unconditionally.
 - Add __bnxt_rx_agg_pages_xdp().
 - Use gfp flag in __bnxt_alloc_rx_netmem().
 - Do not add *offset in the __bnxt_alloc_rx_netmem().
 - Do not pass queue_idx to bnxt_alloc_rx_page_pool().
 - Add Test tag from Stanislav.
 - Add page_pool_recycle_direct_netmem() helper.

v3:
 - Patch added.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 182 ++++++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   2 +-
 include/net/page_pool/helpers.h           |   6 +
 3 files changed, 142 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7d9da483b867..7924b1da0413 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -55,6 +55,7 @@
 #include <net/page_pool/helpers.h>
 #include <linux/align.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 
 #include "bnxt_hsi.h"
 #include "bnxt.h"
@@ -863,6 +864,22 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		bnapi->events &= ~BNXT_TX_CMP_EVENT;
 }
 
+static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *mapping,
+					 struct bnxt_rx_ring_info *rxr,
+					 unsigned int *offset,
+					 gfp_t gfp)
+{
+	netmem_ref netmem;
+
+	netmem = page_pool_alloc_netmem(rxr->page_pool, gfp);
+	if (!netmem)
+		return 0;
+	*offset = 0;
+
+	*mapping = page_pool_get_dma_addr_netmem(netmem);
+	return netmem;
+}
+
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 					 struct bnxt_rx_ring_info *rxr,
 					 unsigned int *offset,
@@ -972,21 +989,21 @@ static inline u16 bnxt_find_next_agg_idx(struct bnxt_rx_ring_info *rxr, u16 idx)
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
+	netmem = __bnxt_alloc_rx_netmem(bp, &mapping, rxr, &offset, gfp);
 
-	if (!page)
+	if (!netmem)
 		return -ENOMEM;
 
 	if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
@@ -996,7 +1013,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 	rx_agg_buf = &rxr->rx_agg_ring[sw_prod];
 	rxr->rx_sw_agg_prod = RING_RX_AGG(bp, NEXT_RX_AGG(sw_prod));
 
-	rx_agg_buf->page = page;
+	rx_agg_buf->netmem = netmem;
 	rx_agg_buf->offset = offset;
 	rx_agg_buf->mapping = mapping;
 	rxbd->rx_bd_haddr = cpu_to_le64(mapping);
@@ -1044,7 +1061,7 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 		struct rx_agg_cmp *agg;
 		struct bnxt_sw_rx_agg_bd *cons_rx_buf, *prod_rx_buf;
 		struct rx_bd *prod_bd;
-		struct page *page;
+		netmem_ref netmem;
 
 		if (p5_tpa)
 			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, start + i);
@@ -1061,11 +1078,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
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
@@ -1190,29 +1207,104 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 	return skb;
 }
 
-static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
-			       struct bnxt_cp_ring_info *cpr,
-			       struct skb_shared_info *shinfo,
-			       u16 idx, u32 agg_bufs, bool tpa,
-			       struct xdp_buff *xdp)
+static bool __bnxt_rx_agg_pages_skb(struct bnxt *bp,
+				    struct bnxt_cp_ring_info *cpr,
+				    struct sk_buff *skb,
+				    u16 idx, u32 agg_bufs, bool tpa)
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
 	struct pci_dev *pdev = bp->pdev;
-	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
-	u16 prod = rxr->rx_agg_prod;
+	struct bnxt_rx_ring_info *rxr;
 	u32 i, total_frag_len = 0;
 	bool p5_tpa = false;
+	u16 prod;
+
+	rxr = bnapi->rx_ring;
+	prod = rxr->rx_agg_prod;
 
 	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && tpa)
 		p5_tpa = true;
 
 	for (i = 0; i < agg_bufs; i++) {
-		skb_frag_t *frag = &shinfo->frags[i];
-		u16 cons, frag_len;
+		struct bnxt_sw_rx_agg_bd *cons_rx_buf;
 		struct rx_agg_cmp *agg;
+		u16 cons, frag_len;
+		dma_addr_t mapping;
+		netmem_ref netmem;
+
+		if (p5_tpa)
+			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, i);
+		else
+			agg = bnxt_get_agg(bp, cpr, idx, i);
+		cons = agg->rx_agg_cmp_opaque;
+		frag_len = (le32_to_cpu(agg->rx_agg_cmp_len_flags_type) &
+			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
+
+		cons_rx_buf = &rxr->rx_agg_ring[cons];
+		skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
+				       cons_rx_buf->offset, frag_len,
+				       BNXT_RX_PAGE_SIZE);
+		__clear_bit(cons, rxr->rx_agg_bmap);
+
+		/* It is possible for bnxt_alloc_rx_netmem() to allocate
+		 * a sw_prod index that equals the cons index, so we
+		 * need to clear the cons entry now.
+		 */
+		mapping = cons_rx_buf->mapping;
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
+
+		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_ATOMIC) != 0) {
+			skb->len -= frag_len;
+			skb->data_len -= frag_len;
+			skb->truesize -= BNXT_RX_PAGE_SIZE;
+			--skb_shinfo(skb)->nr_frags;
+			cons_rx_buf->netmem = netmem;
+
+			/* Update prod since possibly some pages have been
+			 * allocated already.
+			 */
+			rxr->rx_agg_prod = prod;
+			bnxt_reuse_rx_agg_bufs(cpr, idx, i, agg_bufs - i, tpa);
+			return 0;
+		}
+
+		dma_sync_single_for_cpu(&pdev->dev, mapping, BNXT_RX_PAGE_SIZE,
+					bp->rx_dir);
+
+		total_frag_len += frag_len;
+		prod = NEXT_RX_AGG(prod);
+	}
+	rxr->rx_agg_prod = prod;
+	return total_frag_len;
+}
+
+static u32 __bnxt_rx_agg_pages_xdp(struct bnxt *bp,
+				   struct bnxt_cp_ring_info *cpr,
+				   struct skb_shared_info *shinfo,
+				   u16 idx, u32 agg_bufs, bool tpa,
+				   struct xdp_buff *xdp)
+{
+	struct bnxt_napi *bnapi = cpr->bnapi;
+	struct pci_dev *pdev = bp->pdev;
+	struct bnxt_rx_ring_info *rxr;
+	u32 i, total_frag_len = 0;
+	bool p5_tpa = false;
+	u16 prod;
+
+	rxr = bnapi->rx_ring;
+	prod = rxr->rx_agg_prod;
+
+	if ((bp->flags & BNXT_FLAG_CHIP_P5_PLUS) && tpa)
+		p5_tpa = true;
+
+	for (i = 0; i < agg_bufs; i++) {
 		struct bnxt_sw_rx_agg_bd *cons_rx_buf;
-		struct page *page;
+		skb_frag_t *frag = &shinfo->frags[i];
+		struct rx_agg_cmp *agg;
+		u16 cons, frag_len;
 		dma_addr_t mapping;
+		netmem_ref netmem;
 
 		if (p5_tpa)
 			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, i);
@@ -1223,9 +1315,10 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
 
 		cons_rx_buf = &rxr->rx_agg_ring[cons];
-		skb_frag_fill_page_desc(frag, cons_rx_buf->page,
-					cons_rx_buf->offset, frag_len);
+		skb_frag_fill_netmem_desc(frag, cons_rx_buf->netmem,
+					  cons_rx_buf->offset, frag_len);
 		shinfo->nr_frags = i + 1;
+
 		__clear_bit(cons, rxr->rx_agg_bmap);
 
 		/* It is possible for bnxt_alloc_rx_page() to allocate
@@ -1233,15 +1326,15 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 		 * need to clear the cons entry now.
 		 */
 		mapping = cons_rx_buf->mapping;
-		page = cons_rx_buf->page;
-		cons_rx_buf->page = NULL;
+		netmem = cons_rx_buf->netmem;
+		cons_rx_buf->netmem = 0;
 
-		if (xdp && page_is_pfmemalloc(page))
+		if (netmem_is_pfmemalloc(netmem))
 			xdp_buff_set_frag_pfmemalloc(xdp);
 
-		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_ATOMIC) != 0) {
+		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_ATOMIC) != 0) {
 			--shinfo->nr_frags;
-			cons_rx_buf->page = page;
+			cons_rx_buf->netmem = netmem;
 
 			/* Update prod since possibly some pages have been
 			 * allocated already.
@@ -1266,20 +1359,12 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
 					     struct sk_buff *skb, u16 idx,
 					     u32 agg_bufs, bool tpa)
 {
-	struct skb_shared_info *shinfo = skb_shinfo(skb);
-	u32 total_frag_len = 0;
-
-	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo, idx,
-					     agg_bufs, tpa, NULL);
-	if (!total_frag_len) {
+	if (!__bnxt_rx_agg_pages_skb(bp, cpr, skb, idx, agg_bufs, tpa)) {
 		skb_mark_for_recycle(skb);
 		dev_kfree_skb(skb);
 		return NULL;
 	}
 
-	skb->data_len += total_frag_len;
-	skb->len += total_frag_len;
-	skb->truesize += BNXT_RX_PAGE_SIZE * agg_bufs;
 	return skb;
 }
 
@@ -1294,8 +1379,8 @@ static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
 	if (!xdp_buff_has_frags(xdp))
 		shinfo->nr_frags = 0;
 
-	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo,
-					     idx, agg_bufs, tpa, xdp);
+	total_frag_len = __bnxt_rx_agg_pages_xdp(bp, cpr, shinfo,
+						 idx, agg_bufs, tpa, xdp);
 	if (total_frag_len) {
 		xdp_buff_set_frags_flag(xdp);
 		shinfo->nr_frags = agg_bufs;
@@ -3341,15 +3426,15 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt *bp, struct bnxt_rx_ring_info
 
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
 
@@ -3620,7 +3705,10 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
 	pp.max_len = PAGE_SIZE;
-	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
+		   PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+	pp.queue_idx = rxr->bnapi->index;
+	pp.order = 0;
 
 	rxr->page_pool = page_pool_create(&pp);
 	if (IS_ERR(rxr->page_pool)) {
@@ -4153,7 +4241,7 @@ static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
 
 	prod = rxr->rx_agg_prod;
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
-		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_KERNEL)) {
+		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_ring_size);
 			break;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e467341f1e5b..c38b0a8836e2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -894,7 +894,7 @@ struct bnxt_sw_rx_bd {
 };
 
 struct bnxt_sw_rx_agg_bd {
-	struct page		*page;
+	netmem_ref		netmem;
 	unsigned int		offset;
 	dma_addr_t		mapping;
 };
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 793e6fd78bc5..0149f6f6208f 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -382,6 +382,12 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
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
 
-- 
2.34.1


