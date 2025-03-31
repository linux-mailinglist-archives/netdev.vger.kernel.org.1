Return-Path: <netdev+bounces-178282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676A5A76528
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0307D16A00F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD401E231E;
	Mon, 31 Mar 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcAanLoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECE1E2606
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421671; cv=none; b=o4EuaqCYPXvONkLMj+vsi+zQY8/x28UKY4g+9MqE+lrAw1ww8NinEk0HogFMbSjGpTfwwflaEaisTDAapEDrUdYXQfcmTO/uYkd7ypFkAXQLXSmBPkGeWud35ovrFawpC4S9XayXDR4oEQrE0Yj0P9PSZpAnbw2r54RSg32Zi1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421671; c=relaxed/simple;
	bh=Yp98BEMmfV0aV+1XYNJ/Ze8aeTlxxODQGNGJtipo8II=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1Gt/HZ7WuN2OGunLmzrwCPwlKvaFBVaQoP3WojR7chNDpKt22WXgmhZXlwY0QJOang8Z39iHGIVWMAxeTq+WxBzjASfEy+rb5Sp5ymb3r0DUTEte/1p1py7I7QdQTuKDkEuMQRzBj0Gt3AmuLsmZQjT31AZ1ge/aXgf6gW5rDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcAanLoR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso2920775ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743421668; x=1744026468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHxUAW1IFHUNL/RVjwX/2+Id2rI2QYvGCmmhl8D2/Qo=;
        b=dcAanLoRf87N5j0qvAxwRPSV385fia9oMFoOuuI4H2YIEDDEGGFp90G619s4NLD/aS
         IhaqSA7qkRt4nx7V2kp54QnJviaKBb//yhM1Cn792bcqcI1B5KThacL85KakxWif4eFQ
         ZYnwSqYJHMgfgwJU3FiEpgTwYAKYr889YOuT71h9yOrqMPkW0nknb2Y233oai9lo4uO6
         pPCektQITZtxG9QCZVeVjSTGE1PDO3fZcmu9fUfjjL1hrkBC1L7Fl4ISQ33m5yFkUki0
         2p/Io+EDU1rSwTfRlNNEuRyRqT3EBa4Vzo72HGNOMsPE2JbygYXvi+tUycnia3fuuyVl
         1DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743421668; x=1744026468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHxUAW1IFHUNL/RVjwX/2+Id2rI2QYvGCmmhl8D2/Qo=;
        b=nkmggx7cE0uWnSAkWmyu8i5owDGoI8YR8aW3XXgwY7gjJj1qVTwlBLFY/EkQIFN8BT
         uyp3P8WLy8rAMb6OADpBM3vQ/v/UUrcpDKcqcT5s9HFCUls4QujisGKKrvCkW+eCORMr
         koBgObK+lRaeF913W+WX6HWkbXVPpfo4/A0szx7p6D1rFH4ToAFjhS+w7hlm/UfLa6QX
         uy4UKv93nAiKBuCQbaowrtqKYF0K2BzujseYEtqwX3T81jcZ+x/4WPA/nsgMEmscVBnf
         Jvjax7IA51owNxpIU898LxMLCVBXiwBKprXT/oGi6iTg7ZSbM0p1buwidMd0Y0QJNRvk
         LOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmgARb+gZ2q3HTXZF7FqgCu42gS6pXq2kmpOkMfxMZ5M5xUuqhbX0uCA5knzBdWkbZ3sCJGLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy5q6RDqD3Pg9JI2qlIlBVAVgmaiomEWDp5GADwc8xNpYDLGyi
	yX170h6NYHzIA9lSRnnL891Sm1giCNMI0KFWCbMB4d8U4YET7/vm
X-Gm-Gg: ASbGncuowp0QWulv2eqiYGxfqYtQN3k5jSljxgekCj+IeuYZH9s+uqo2qUgmZlCcKHW
	mklFjmnbiCgy9yPC2UD7LazdYViOXnIVG91b3kluHIBsjlyDfF/2I1KXt8k8yDUsZx4+2rkmXt9
	aTojt7nrguWZtiRJlaDeyLRxeQLJJROukhHfRCjnVpYtxvm+ymouGWlBnCpSak3GoBZkdBZVlEo
	+X7E9WQhcFfwV0URve9Q2D3uDCmwvWVgK/Na777AI9mNPP7vJLgyZwtibxjickdm2Iuj9Ajhs87
	ZlMbQnbXvI0E1UxU+Au5oEoVJ4816tD8ZkG5S4iWOk5S
X-Google-Smtp-Source: AGHT+IEBd0VazM/6u4S6TR9B+emuK4hyGGODjg5wNB6dZ+jOMjgolcrHHXvFuw5EVWQ2qbHU6ZhWuw==
X-Received: by 2002:aa7:8890:0:b0:736:52d7:daca with SMTP id d2e1a72fcca58-7398042a376mr14572608b3a.18.1743421667664;
        Mon, 31 Mar 2025 04:47:47 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e222f4sm6724881b3a.41.2025.03.31.04.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 04:47:46 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ilias.apalodimas@linaro.org,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	kuniyu@amazon.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com
Subject: [RFC net-next 2/2] eth: bnxt: add support rx side device memory TCP
Date: Mon, 31 Mar 2025 11:47:29 +0000
Message-Id: <20250331114729.594603-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331114729.594603-1-ap420073@gmail.com>
References: <20250331114729.594603-1-ap420073@gmail.com>
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
`struct page` for rx-size are changed to `netmem_ref netmem` and
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

Tested-by: David Wei <dw@davidwei.uk>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 407 ++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  18 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  26 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   4 +-
 include/linux/netdevice.h                     |   1 +
 include/net/page_pool/helpers.h               |   6 +
 net/core/dev.c                                |   6 +
 8 files changed, 258 insertions(+), 212 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 198a42da3015..b3b4836862d3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -893,46 +893,48 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		bnapi->events &= ~BNXT_TX_CMP_EVENT;
 }
 
-static bool bnxt_separate_head_pool(void)
+static bool bnxt_separate_head_pool(struct bnxt_rx_ring_info *rxr)
 {
-	return PAGE_SIZE > BNXT_RX_PAGE_SIZE;
+	return rxr->need_head_pool || PAGE_SIZE > BNXT_RX_PAGE_SIZE;
 }
 
-static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
+static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *mapping,
 					 struct bnxt_rx_ring_info *rxr,
 					 unsigned int *offset,
 					 gfp_t gfp)
 {
-	struct page *page;
+	netmem_ref netmem;
 
 	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
-		page = page_pool_dev_alloc_frag(rxr->page_pool, offset,
-						BNXT_RX_PAGE_SIZE);
+		netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset,
+						     BNXT_RX_PAGE_SIZE, gfp);
 	} else {
-		page = page_pool_dev_alloc_pages(rxr->page_pool);
+		netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
 		*offset = 0;
 	}
-	if (!page)
-		return NULL;
+	if (!netmem)
+		return 0;
 
-	*mapping = page_pool_get_dma_addr(page) + bp->rx_dma_offset + *offset;
-	return page;
+	*mapping = page_pool_get_dma_addr_netmem(netmem) + bp->rx_dma_offset +
+		   *offset;
+	return netmem;
 }
 
-static struct page *__bnxt_alloc_rx_frag(struct bnxt *bp, dma_addr_t *mapping,
-					 struct bnxt_rx_ring_info *rxr,
-					 unsigned int *offset,
-					 gfp_t gfp)
+static netmem_ref __bnxt_alloc_rx_frag(struct bnxt *bp, dma_addr_t *mapping,
+				       struct bnxt_rx_ring_info *rxr,
+				       unsigned int *offset,
+				       gfp_t gfp)
 {
-	struct page *page;
+	netmem_ref netmem;
 
-	page = page_pool_alloc_frag(rxr->head_pool, offset,
-				    bp->rx_buf_size, gfp);
-	if (!page)
-		return NULL;
+	netmem = page_pool_alloc_frag_netmem(rxr->head_pool, offset,
+					     bp->rx_buf_size, gfp);
+	if (!netmem)
+		return 0;
 
-	*mapping = page_pool_get_dma_addr(page) + bp->rx_dma_offset + *offset;
-	return page;
+	*mapping = page_pool_get_dma_addr_netmem(netmem) + bp->rx_dma_offset +
+		   *offset;
+	return netmem;
 }
 
 int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
@@ -942,16 +944,17 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	struct bnxt_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[RING_RX(bp, prod)];
 	unsigned int offset;
 	dma_addr_t mapping;
-	struct page *page;
+	netmem_ref netmem;
 
 	if (BNXT_RX_PAGE_MODE(bp))
-		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
+		netmem = __bnxt_alloc_rx_netmem(bp, &mapping, rxr, &offset,
+						gfp);
 	else
-		page = __bnxt_alloc_rx_frag(bp, &mapping, rxr, &offset, gfp);
-	if (!page)
+		netmem = __bnxt_alloc_rx_frag(bp, &mapping, rxr, &offset, gfp);
+	if (!netmem)
 		return -ENOMEM;
 
-	rx_buf->page = page;
+	rx_buf->netmem = netmem;
 	rx_buf->offset = offset;
 	rx_buf->mapping = mapping;
 
@@ -959,8 +962,8 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	return 0;
 }
 
-void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons,
-			struct page *page)
+void bnxt_reuse_rx_netmem(struct bnxt_rx_ring_info *rxr, u16 cons,
+			  netmem_ref netmem)
 {
 	u16 prod = rxr->rx_prod;
 	struct bnxt_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
@@ -970,7 +973,7 @@ void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons,
 	prod_rx_buf = &rxr->rx_buf_ring[RING_RX(bp, prod)];
 	cons_rx_buf = &rxr->rx_buf_ring[cons];
 
-	prod_rx_buf->page = page;
+	prod_rx_buf->netmem = netmem;
 	prod_rx_buf->offset = cons_rx_buf->offset;
 
 	prod_rx_buf->mapping = cons_rx_buf->mapping;
@@ -991,9 +994,9 @@ static inline u16 bnxt_find_next_agg_idx(struct bnxt_rx_ring_info *rxr, u16 idx)
 	return next;
 }
 
-static inline int bnxt_alloc_rx_agg_page(struct bnxt *bp,
-					 struct bnxt_rx_ring_info *rxr,
-					 u16 prod, gfp_t gfp)
+static inline int bnxt_alloc_rx_agg_netmem(struct bnxt *bp,
+					   struct bnxt_rx_ring_info *rxr,
+					   u16 prod, gfp_t gfp)
 {
 	struct rx_bd *rxbd =
 		&rxr->rx_agg_desc_ring[RX_AGG_RING(bp, prod)][RX_IDX(prod)];
@@ -1001,10 +1004,10 @@ static inline int bnxt_alloc_rx_agg_page(struct bnxt *bp,
 	struct bnxt_sw_rx_bd *rx_agg_buf;
 	unsigned int offset = 0;
 	dma_addr_t mapping;
-	struct page *page;
+	netmem_ref netmem;
 
-	page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
-	if (!page)
+	netmem = __bnxt_alloc_rx_netmem(bp, &mapping, rxr, &offset, gfp);
+	if (!netmem)
 		return -ENOMEM;
 	mapping -= bp->rx_dma_offset;
 
@@ -1015,7 +1018,7 @@ static inline int bnxt_alloc_rx_agg_page(struct bnxt *bp,
 	rx_agg_buf = &rxr->rx_agg_ring[sw_prod];
 	rxr->rx_sw_agg_prod = RING_RX_AGG(bp, NEXT_RX_AGG(sw_prod));
 
-	rx_agg_buf->page = page;
+	rx_agg_buf->netmem = netmem;
 	rx_agg_buf->offset = offset;
 	rx_agg_buf->mapping = mapping;
 	rxbd->rx_bd_haddr = cpu_to_le64(mapping);
@@ -1062,7 +1065,7 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 		struct bnxt_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
 		struct rx_agg_cmp *agg;
 		struct rx_bd *prod_bd;
-		struct page *page;
+		netmem_ref netmem;
 		u16 cons;
 
 		if (p5_tpa)
@@ -1080,11 +1083,11 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
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
@@ -1101,12 +1104,12 @@ static void bnxt_reuse_rx_agg_bufs(struct bnxt_cp_ring_info *cpr, u16 idx,
 	rxr->rx_sw_agg_prod = sw_prod;
 }
 
-static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
-					      struct bnxt_rx_ring_info *rxr,
-					      u16 cons, struct page *page,
-					      unsigned int offset,
-					      dma_addr_t dma_addr,
-					      unsigned int offset_and_len)
+static struct sk_buff *bnxt_rx_multi_netmem_skb(struct bnxt *bp,
+						struct bnxt_rx_ring_info *rxr,
+						u16 cons, netmem_ref netmem,
+						unsigned int offset,
+						dma_addr_t dma_addr,
+						unsigned int offset_and_len)
 {
 	unsigned int len = offset_and_len & 0xffff;
 	u16 prod = rxr->rx_prod;
@@ -1115,14 +1118,15 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 
 	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
 	if (unlikely(err)) {
-		bnxt_reuse_rx_data(rxr, cons, page);
+		bnxt_reuse_rx_netmem(rxr, cons, netmem);
 		return NULL;
 	}
-	page_pool_dma_sync_for_cpu(rxr->page_pool, page, 0, BNXT_RX_PAGE_SIZE);
+	page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
+					  BNXT_RX_PAGE_SIZE);
 
-	skb = napi_build_skb(bnxt_data(page, offset), BNXT_RX_PAGE_SIZE);
+	skb = napi_build_skb(bnxt_data(netmem, offset), BNXT_RX_PAGE_SIZE);
 	if (!skb) {
-		page_pool_recycle_direct(rxr->page_pool, page);
+		page_pool_recycle_direct_netmem(rxr->head_pool, netmem);
 		return NULL;
 	}
 	skb_mark_for_recycle(skb);
@@ -1132,12 +1136,12 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 	return skb;
 }
 
-static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
-					struct bnxt_rx_ring_info *rxr,
-					u16 cons, struct page *page,
-					unsigned int offset,
-					dma_addr_t dma_addr,
-					unsigned int offset_and_len)
+static struct sk_buff *bnxt_rx_netmem_skb(struct bnxt *bp,
+					  struct bnxt_rx_ring_info *rxr,
+					  u16 cons, netmem_ref netmem,
+					  unsigned int offset,
+					  dma_addr_t dma_addr,
+					  unsigned int offset_and_len)
 {
 	unsigned int payload = offset_and_len >> 16;
 	unsigned int len = offset_and_len & 0xffff;
@@ -1149,24 +1153,25 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
 	if (unlikely(err)) {
-		bnxt_reuse_rx_data(rxr, cons, page);
+		bnxt_reuse_rx_netmem(rxr, cons, netmem);
 		return NULL;
 	}
-	data_ptr = bnxt_data_ptr(bp, page, offset);
-	page_pool_dma_sync_for_cpu(rxr->page_pool, page, 0, BNXT_RX_PAGE_SIZE);
+	data_ptr = bnxt_data_ptr(bp, netmem, offset);
+	page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
+					  BNXT_RX_PAGE_SIZE);
 
 	if (unlikely(!payload))
 		payload = eth_get_headlen(bp->dev, data_ptr, len);
 
 	skb = napi_alloc_skb(&rxr->bnapi->napi, payload);
 	if (!skb) {
-		page_pool_recycle_direct(rxr->page_pool, page);
+		page_pool_recycle_direct_netmem(rxr->head_pool, netmem);
 		return NULL;
 	}
 
 	skb_mark_for_recycle(skb);
-	skb_add_rx_frag(skb, 0, page, bp->rx_offset + offset, len,
-			BNXT_RX_PAGE_SIZE);
+	skb_add_rx_frag_netmem(skb, 0, netmem, bp->rx_offset + offset, len,
+			       BNXT_RX_PAGE_SIZE);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1181,7 +1186,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr, u16 cons,
-				   struct page *page, unsigned int offset,
+				   netmem_ref netmem, unsigned int offset,
 				   dma_addr_t dma_addr,
 				   unsigned int offset_and_len)
 {
@@ -1191,16 +1196,17 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 
 	err = bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
 	if (unlikely(err)) {
-		bnxt_reuse_rx_data(rxr, cons, page);
+		bnxt_reuse_rx_netmem(rxr, cons, netmem);
 		return NULL;
 	}
 
-	skb = napi_build_skb(bnxt_data(page, offset), bp->rx_buf_size);
-	page_pool_dma_sync_for_cpu(rxr->head_pool, page,
-				   offset + bp->rx_dma_offset,
-				   bp->rx_buf_use_size);
+	skb = napi_build_skb(bnxt_data(netmem, offset), bp->rx_buf_size);
+	page_pool_dma_sync_netmem_for_cpu(rxr->head_pool, netmem,
+					  offset + bp->rx_dma_offset,
+					  bp->rx_buf_use_size);
+
 	if (!skb) {
-		page_pool_recycle_direct(rxr->head_pool, page);
+		page_pool_recycle_direct_netmem(rxr->head_pool, netmem);
 		return NULL;
 	}
 
@@ -1210,13 +1216,14 @@ static struct sk_buff *bnxt_rx_skb(struct bnxt *bp,
 	return skb;
 }
 
-static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
-			       struct bnxt_cp_ring_info *cpr,
-			       struct skb_shared_info *shinfo,
-			       u16 idx, u32 agg_bufs, bool tpa,
-			       struct xdp_buff *xdp)
+static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
+				 struct bnxt_cp_ring_info *cpr,
+				 struct sk_buff *skb,
+				 u16 idx, u32 agg_bufs, bool tpa,
+				 struct xdp_buff *xdp)
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
+	struct skb_shared_info *shinfo;
 	struct bnxt_rx_ring_info *rxr;
 	u32 i, total_frag_len = 0;
 	bool p5_tpa = false;
@@ -1229,12 +1236,11 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 		p5_tpa = true;
 
 	for (i = 0; i < agg_bufs; i++) {
-		skb_frag_t *frag = &shinfo->frags[i];
 		struct bnxt_sw_rx_bd *cons_rx_buf;
 		struct rx_agg_cmp *agg;
 		u16 cons, frag_len;
 		dma_addr_t mapping;
-		struct page *page;
+		netmem_ref netmem;
 
 		if (p5_tpa)
 			agg = bnxt_get_tpa_agg_p5(bp, rxr, idx, i);
@@ -1245,25 +1251,42 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			    RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
 
 		cons_rx_buf = &rxr->rx_agg_ring[cons];
-		skb_frag_fill_page_desc(frag, cons_rx_buf->page,
-					cons_rx_buf->offset, frag_len);
-		shinfo->nr_frags = i + 1;
+		if (skb) {
+			shinfo = skb_shinfo(skb);
+			skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
+					       cons_rx_buf->offset,
+					       frag_len, BNXT_RX_PAGE_SIZE);
+		} else {
+			shinfo = xdp_get_shared_info_from_buff(xdp);
+			skb_frag_t *frag = &shinfo->frags[i];
+
+			skb_frag_fill_netmem_desc(frag, cons_rx_buf->netmem,
+						  cons_rx_buf->offset,
+						  frag_len);
+			shinfo->nr_frags = i + 1;
+		}
+
 		__clear_bit(cons, rxr->rx_agg_bmap);
 
-		/* It is possible for bnxt_alloc_rx_agg_page() to allocate
+		/* It is possible for bnxt_alloc_rx_agg_netmem() to allocate
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
 
-		if (bnxt_alloc_rx_agg_page(bp, rxr, prod, GFP_ATOMIC) != 0) {
+		if (bnxt_alloc_rx_agg_netmem(bp, rxr, prod, GFP_ATOMIC) != 0) {
+			if (skb) {
+				skb->len -= frag_len;
+				skb->data_len -= frag_len;
+				skb->truesize -= BNXT_RX_PAGE_SIZE;
+			}
 			--shinfo->nr_frags;
-			cons_rx_buf->page = page;
+			cons_rx_buf->netmem = netmem;
 
 			/* Update prod since possibly some pages have been
 			 * allocated already.
@@ -1273,8 +1296,8 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			return 0;
 		}
 
-		page_pool_dma_sync_for_cpu(rxr->page_pool, page, 0,
-					   BNXT_RX_PAGE_SIZE);
+		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
+						  BNXT_RX_PAGE_SIZE);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -1283,32 +1306,24 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
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
-	u32 total_frag_len = 0;
-
-	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo, idx,
-					     agg_bufs, tpa, NULL);
-	if (!total_frag_len) {
+	if (!__bnxt_rx_agg_netmems(bp, cpr, skb, idx, agg_bufs, tpa, NULL)) {
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
@@ -1316,8 +1331,8 @@ static u32 bnxt_rx_agg_pages_xdp(struct bnxt *bp,
 	if (!xdp_buff_has_frags(xdp))
 		shinfo->nr_frags = 0;
 
-	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo,
-					     idx, agg_bufs, tpa, xdp);
+	total_frag_len = __bnxt_rx_agg_netmems(bp, cpr, NULL,
+					       idx, agg_bufs, tpa, xdp);
 	if (total_frag_len) {
 		xdp_buff_set_frags_flag(xdp);
 		shinfo->nr_frags = agg_bufs;
@@ -1340,7 +1355,7 @@ static int bnxt_agg_bufs_valid(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 }
 
 static struct sk_buff *bnxt_copy_data(struct bnxt_napi *bnapi,
-				      struct page *page,
+				      netmem_ref netmem,
 				      unsigned int offset,
 				      unsigned int len)
 {
@@ -1352,15 +1367,15 @@ static struct sk_buff *bnxt_copy_data(struct bnxt_napi *bnapi,
 	if (!skb)
 		return NULL;
 
-	page_pool_dma_sync_for_cpu(rxr->head_pool, page,
-				   offset + bp->rx_dma_offset,
-				   bp->rx_copybreak);
+	page_pool_dma_sync_netmem_for_cpu(rxr->head_pool, netmem,
+					  offset + bp->rx_dma_offset,
+					  bp->rx_copybreak);
 
 	memcpy(skb->data - NET_IP_ALIGN,
-	       bnxt_data_ptr(bp, page, offset) - NET_IP_ALIGN,
+	       bnxt_data_ptr(bp, netmem, offset) - NET_IP_ALIGN,
 	       len + NET_IP_ALIGN);
 
-	page_pool_dma_sync_for_device(rxr->head_pool, page_to_netmem(page),
+	page_pool_dma_sync_for_device(rxr->head_pool, netmem,
 				      bp->rx_dma_offset, bp->rx_copybreak);
 	skb_put(skb, len);
 
@@ -1368,15 +1383,15 @@ static struct sk_buff *bnxt_copy_data(struct bnxt_napi *bnapi,
 }
 
 static struct sk_buff *bnxt_copy_skb(struct bnxt_napi *bnapi,
-				     struct page *page,
+				     netmem_ref netmem,
 				     unsigned int offset,
 				     unsigned int len)
 {
-	return bnxt_copy_data(bnapi, page, offset, len);
+	return bnxt_copy_data(bnapi, netmem, offset, len);
 }
 
 static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
-				     struct page *page,
+				     netmem_ref netmem,
 				     unsigned int offset,
 				     struct xdp_buff *xdp,
 				     unsigned int len)
@@ -1389,7 +1404,7 @@ static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
 	metasize = xdp->data - xdp->data_meta;
 	data = xdp->data_meta;
 
-	skb = bnxt_copy_data(bnapi, page, offset, len);
+	skb = bnxt_copy_data(bnapi, netmem, offset, len);
 	if (!skb)
 		return skb;
 
@@ -1519,7 +1534,7 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		bnxt_sched_reset_rxr(bp, rxr);
 		return;
 	}
-	prod_rx_buf->page = tpa_info->bd.page;
+	prod_rx_buf->netmem = tpa_info->bd.netmem;
 	prod_rx_buf->offset = tpa_info->bd.offset;
 
 	mapping = tpa_info->bd.mapping;
@@ -1529,9 +1544,9 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 
 	prod_bd->rx_bd_haddr = cpu_to_le64(mapping);
 
-	tpa_info->bd.page = cons_rx_buf->page;
+	tpa_info->bd.netmem = cons_rx_buf->netmem;
 	tpa_info->bd.offset = cons_rx_buf->offset;
-	cons_rx_buf->page = NULL;
+	cons_rx_buf->netmem = 0;
 	tpa_info->bd.mapping = cons_rx_buf->mapping;
 
 	tpa_info->len =
@@ -1566,9 +1581,9 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	rxr->rx_next_cons = RING_RX(bp, NEXT_RX(cons));
 	cons_rx_buf = &rxr->rx_buf_ring[cons];
 
-	bnxt_reuse_rx_data(rxr, cons, cons_rx_buf->page);
+	bnxt_reuse_rx_netmem(rxr, cons, cons_rx_buf->netmem);
 	rxr->rx_prod = NEXT_RX(rxr->rx_prod);
-	cons_rx_buf->page = NULL;
+	cons_rx_buf->netmem = 0;
 }
 
 static void bnxt_abort_tpa(struct bnxt_cp_ring_info *cpr, u16 idx, u32 agg_bufs)
@@ -1800,7 +1815,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 	struct sk_buff *skb;
 	u16 idx = 0, agg_id;
 	dma_addr_t mapping;
-	struct page *page;
+	netmem_ref netmem;
 	bool gro;
 
 	if (unlikely(bnapi->in_reset)) {
@@ -1840,9 +1855,9 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		}
 		gro = !!TPA_END_GRO(tpa_end);
 	}
-	page = tpa_info->bd.page;
+	netmem = tpa_info->bd.netmem;
 	offset = tpa_info->bd.offset;
-	data_ptr = bnxt_data_ptr(bp, page, offset);
+	data_ptr = bnxt_data_ptr(bp, netmem, offset);
 	prefetch(data_ptr);
 	len = tpa_info->len;
 	mapping = tpa_info->bd.mapping;
@@ -1856,7 +1871,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 	}
 
 	if (len <= bp->rx_copybreak) {
-		skb = bnxt_copy_skb(bnapi, page, offset, len);
+		skb = bnxt_copy_skb(bnapi, netmem, offset, len);
 		if (!skb) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
 			cpr->sw_stats->rx.rx_oom_discards += 1;
@@ -1865,27 +1880,27 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 	} else {
 		unsigned int new_offset;
 		dma_addr_t new_mapping;
-		struct page *new_page;
+		netmem_ref new_netmem;
 
-		new_page = __bnxt_alloc_rx_frag(bp, &new_mapping, rxr,
-						&new_offset, GFP_ATOMIC);
-		if (!new_page) {
+		new_netmem = __bnxt_alloc_rx_frag(bp, &new_mapping, rxr,
+						  &new_offset, GFP_ATOMIC);
+		if (!new_netmem) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
 			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
 		}
 
-		tpa_info->bd.page = new_page;
+		tpa_info->bd.netmem = new_netmem;
 		tpa_info->bd.offset = new_offset;
 		tpa_info->bd.mapping = new_mapping;
 
-		skb = napi_build_skb(bnxt_data(page, offset), bp->rx_buf_size);
-		page_pool_dma_sync_for_cpu(rxr->head_pool, page,
-					   offset + bp->rx_dma_offset,
-					   bp->rx_buf_use_size);
-
+		skb = napi_build_skb(bnxt_data(netmem, offset),
+				     bp->rx_buf_size);
+		page_pool_dma_sync_netmem_for_cpu(rxr->head_pool, netmem,
+						  offset + bp->rx_dma_offset,
+						  bp->rx_buf_use_size);
 		if (!skb) {
-			page_pool_recycle_direct(rxr->head_pool, page);
+			page_pool_recycle_direct_netmem(rxr->head_pool, netmem);
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
 			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
@@ -1896,9 +1911,12 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 	}
 
 	if (agg_bufs) {
-		skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, idx, agg_bufs, true);
+		skb = bnxt_rx_agg_netmems_skb(bp, cpr, skb, idx, agg_bufs,
+					      true);
 		if (!skb) {
-			/* Page reuse already handled by bnxt_rx_pages(). */
+			/* Page reuse already handled by
+			 * bnxt_rx_agg_netmems_skb().
+			 */
 			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
 		}
@@ -2062,7 +2080,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
 	struct xdp_buff xdp;
-	struct page *page;
+	netmem_ref netmem;
 	u32 flags, misc;
 	u32 cmpl_ts;
 	int rc = 0;
@@ -2134,9 +2152,9 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		goto next_rx_no_prod_no_len;
 	}
 	rx_buf = &rxr->rx_buf_ring[cons];
-	page = rx_buf->page;
+	netmem = rx_buf->netmem;
 	offset = rx_buf->offset;
-	data_ptr = bnxt_data_ptr(bp, page, offset);
+	data_ptr = bnxt_data_ptr(bp, netmem, offset);
 	prefetch(data_ptr);
 
 	misc = le32_to_cpu(rxcmp->rx_cmp_misc_v1);
@@ -2151,11 +2169,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 	*event |= BNXT_RX_EVENT;
 
-	rx_buf->page = NULL;
+	rx_buf->netmem = 0;
 	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
 		u32 rx_err = le32_to_cpu(rxcmp1->rx_cmp_cfa_code_errors_v2);
 
-		bnxt_reuse_rx_data(rxr, cons, page);
+		bnxt_reuse_rx_netmem(rxr, cons, netmem);
 		if (agg_bufs)
 			bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs,
 					       false);
@@ -2178,11 +2196,12 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	dma_addr = rx_buf->mapping;
 
 	if (bnxt_xdp_attached(bp, rxr)) {
-		bnxt_xdp_buff_init(bp, rxr, cons, page, len, &xdp);
+		bnxt_xdp_buff_init(bp, rxr, cons, netmem, len, &xdp);
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
 
@@ -2191,7 +2210,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	if (xdp_active) {
-		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, page, &data_ptr, &len, event)) {
+		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, netmem, &data_ptr, &len, event)) {
 			rc = 1;
 			goto next_rx;
 		}
@@ -2205,10 +2224,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 	if (len <= bp->rx_copybreak) {
 		if (!xdp_active)
-			skb = bnxt_copy_skb(bnapi, page, offset, len);
+			skb = bnxt_copy_skb(bnapi, netmem, offset, len);
 		else
-			skb = bnxt_copy_xdp(bnapi, page, offset, &xdp, len);
-		bnxt_reuse_rx_data(rxr, cons, page);
+			skb = bnxt_copy_xdp(bnapi, netmem, offset, &xdp, len);
+		bnxt_reuse_rx_netmem(rxr, cons, netmem);
 		if (!skb) {
 			if (agg_bufs) {
 				if (!xdp_active)
@@ -2222,11 +2241,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	} else {
 		u32 payload;
 
-		if (bnxt_data_ptr(bp, page, offset) == data_ptr)
+		if (bnxt_data_ptr(bp, netmem, offset) == data_ptr)
 			payload = misc & RX_CMP_PAYLOAD_OFFSET;
 		else
 			payload = 0;
-		skb = bp->rx_skb_func(bp, rxr, cons, page, offset, dma_addr,
+		skb = bp->rx_skb_func(bp, rxr, cons, netmem, offset, dma_addr,
 				      payload | len);
 		if (!skb)
 			goto oom_next_rx;
@@ -2234,7 +2253,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 	if (agg_bufs) {
 		if (!xdp_active) {
-			skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, cp_cons, agg_bufs, false);
+			skb = bnxt_rx_agg_netmems_skb(bp, cpr, skb, cp_cons,
+						      agg_bufs, false);
 			if (!skb)
 				goto oom_next_rx;
 		} else {
@@ -3429,13 +3449,13 @@ static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_info *rxr
 
 	for (i = 0; i < max_idx; i++) {
 		struct bnxt_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[i];
-		struct page *page = rx_buf->page;
+		netmem_ref netmem = rx_buf->netmem;
 
-		if (!page)
+		if (!netmem)
 			continue;
 
-		rx_buf->page = NULL;
-		page_pool_recycle_direct(rxr->page_pool, page);
+		rx_buf->netmem = 0;
+		page_pool_recycle_direct_netmem(rxr->head_pool, netmem);
 	}
 }
 
@@ -3447,15 +3467,15 @@ static void bnxt_free_one_rx_agg_ring(struct bnxt *bp, struct bnxt_rx_ring_info
 
 	for (i = 0; i < max_idx; i++) {
 		struct bnxt_sw_rx_bd *rx_agg_buf = &rxr->rx_agg_ring[i];
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
 
@@ -3466,13 +3486,13 @@ static void bnxt_free_one_tpa_info_data(struct bnxt *bp,
 
 	for (i = 0; i < bp->max_tpa; i++) {
 		struct bnxt_tpa_info *tpa_info = &rxr->rx_tpa[i];
-		struct page *page = tpa_info->bd.page;
+		netmem_ref netmem = tpa_info->bd.netmem;
 
-		if (!page)
+		if (!netmem)
 			continue;
 
-		tpa_info->bd.page = NULL;
-		page_pool_put_full_page(rxr->head_pool, page, false);
+		tpa_info->bd.netmem = 0;
+		page_pool_put_full_netmem(rxr->head_pool, netmem, false);
 	}
 }
 
@@ -3748,7 +3768,7 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 			xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 		page_pool_destroy(rxr->page_pool);
-		if (bnxt_separate_head_pool())
+		if (bnxt_separate_head_pool(rxr))
 			page_pool_destroy(rxr->head_pool);
 		rxr->page_pool = rxr->head_pool = NULL;
 
@@ -3763,9 +3783,9 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 	}
 }
 
-static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
-				   struct bnxt_rx_ring_info *rxr,
-				   int numa_node)
+static int bnxt_alloc_rx_netmem_pool(struct bnxt *bp,
+				     struct bnxt_rx_ring_info *rxr,
+				     int numa_node)
 {
 	struct page_pool_params pp = { 0 };
 	struct page_pool *pool;
@@ -3779,15 +3799,20 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
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
@@ -3837,7 +3862,7 @@ static int bnxt_alloc_rx_rings(struct bnxt *bp)
 		cpu_node = cpu_to_node(cpu);
 		netdev_dbg(bp->dev, "Allocating page pool for rx_ring[%d] on numa_node: %d\n",
 			   i, cpu_node);
-		rc = bnxt_alloc_rx_page_pool(bp, rxr, cpu_node);
+		rc = bnxt_alloc_rx_netmem_pool(bp, rxr, cpu_node);
 		if (rc)
 			return rc;
 
@@ -4199,6 +4224,8 @@ static void bnxt_reset_rx_ring_struct(struct bnxt *bp,
 
 	rxr->page_pool->p.napi = NULL;
 	rxr->page_pool = NULL;
+	rxr->head_pool->p.napi = NULL;
+	rxr->head_pool = NULL;
 	memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
 
 	ring = &rxr->rx_ring_struct;
@@ -4332,7 +4359,7 @@ static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
 
 	prod = rxr->rx_agg_prod;
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
-		if (bnxt_alloc_rx_agg_page(bp, rxr, prod, GFP_KERNEL)) {
+		if (bnxt_alloc_rx_agg_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_ring_size);
 			break;
@@ -4347,16 +4374,16 @@ static int bnxt_alloc_one_tpa_info_data(struct bnxt *bp,
 {
 	unsigned int offset;
 	dma_addr_t mapping;
-	struct page *page;
+	netmem_ref netmem;
 	int i;
 
 	for (i = 0; i < bp->max_tpa; i++) {
-		page = __bnxt_alloc_rx_frag(bp, &mapping, rxr, &offset,
-					    GFP_KERNEL);
-		if (!page)
+		netmem = __bnxt_alloc_rx_frag(bp, &mapping, rxr, &offset,
+					      GFP_KERNEL);
+		if (!netmem)
 			return -ENOMEM;
 
-		rxr->rx_tpa[i].bd.page = page;
+		rxr->rx_tpa[i].bd.netmem = netmem;
 		rxr->rx_tpa[i].bd.offset = offset;
 		rxr->rx_tpa[i].bd.mapping = mapping;
 	}
@@ -4770,10 +4797,10 @@ static void __bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 				min_t(u16, bp->max_mtu, BNXT_MAX_PAGE_MODE_MTU);
 		if (dev->mtu > BNXT_MAX_PAGE_MODE_MTU) {
 			bp->flags |= BNXT_FLAG_JUMBO;
-			bp->rx_skb_func = bnxt_rx_multi_page_skb;
+			bp->rx_skb_func = bnxt_rx_multi_netmem_skb;
 		} else {
 			bp->flags |= BNXT_FLAG_NO_AGG_RINGS;
-			bp->rx_skb_func = bnxt_rx_page_skb;
+			bp->rx_skb_func = bnxt_rx_netmem_skb;
 		}
 		bp->rx_dir = DMA_BIDIRECTIONAL;
 	} else {
@@ -15711,8 +15738,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	clone->rx_agg_prod = 0;
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
+	clone->need_head_pool = false;
 
-	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
+	rc = bnxt_alloc_rx_netmem_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
 		return rc;
 
@@ -15769,7 +15797,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	xdp_rxq_info_unreg(&clone->xdp_rxq);
 err_page_pool_destroy:
 	page_pool_destroy(clone->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(rxr))
 		page_pool_destroy(clone->head_pool);
 	clone->page_pool = NULL;
 	clone->head_pool = NULL;
@@ -15788,7 +15816,7 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
 	page_pool_destroy(rxr->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(rxr))
 		page_pool_destroy(rxr->head_pool);
 	rxr->page_pool = NULL;
 	rxr->head_pool = NULL;
@@ -15879,6 +15907,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	rxr->page_pool = clone->page_pool;
 	rxr->head_pool = clone->head_pool;
 	rxr->xdp_rxq = clone->xdp_rxq;
+	rxr->need_head_pool = clone->need_head_pool;
 
 	bnxt_copy_rx_ring(bp, rxr, clone);
 
@@ -15912,7 +15941,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 			goto err_reset;
 	}
 
-	napi_enable(&bnapi->napi);
+	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
 
 	for (i = 0; i < bp->nr_vnics; i++) {
@@ -15964,7 +15993,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	page_pool_disable_direct_recycling(rxr->page_pool);
-	if (bnxt_separate_head_pool())
+	if (bnxt_separate_head_pool(rxr))
 		page_pool_disable_direct_recycling(rxr->head_pool);
 
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
@@ -15974,7 +16003,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	 * completion is handled in NAPI to guarantee no more DMA on that ring
 	 * after seeing the completion.
 	 */
-	napi_disable(&bnapi->napi);
+	napi_disable_locked(&bnapi->napi);
 
 	if (bp->tph_mode) {
 		bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 13db8b7bd4b7..9917a5e7c57e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -897,7 +897,7 @@ struct bnxt_sw_tx_bd {
 };
 
 struct bnxt_sw_rx_bd {
-	struct page		*page;
+	netmem_ref		netmem;
 	unsigned int		offset;
 	dma_addr_t		mapping;
 };
@@ -1110,6 +1110,7 @@ struct bnxt_rx_ring_info {
 	struct xdp_rxq_info	xdp_rxq;
 	struct page_pool	*page_pool;
 	struct page_pool	*head_pool;
+	bool			need_head_pool;
 };
 
 struct bnxt_rx_sw_stats {
@@ -2342,7 +2343,8 @@ struct bnxt {
 
 	struct sk_buff *	(*rx_skb_func)(struct bnxt *,
 					       struct bnxt_rx_ring_info *,
-					       u16, struct page *, unsigned int,
+					       u16, netmem_ref netmem,
+					       unsigned int,
 					       dma_addr_t,
 					       unsigned int);
 
@@ -2863,15 +2865,15 @@ static inline bool bnxt_sriov_cfg(struct bnxt *bp)
 #endif
 }
 
-static inline u8 *bnxt_data_ptr(struct bnxt *bp, struct page *page,
+static inline u8 *bnxt_data_ptr(struct bnxt *bp, netmem_ref netmem,
 				unsigned int offset)
 {
-	return page_address(page) + offset + bp->rx_offset;
+	return netmem_address(netmem) + offset + bp->rx_offset;
 }
 
-static inline u8 *bnxt_data(struct page *page, unsigned int offset)
+static inline u8 *bnxt_data(netmem_ref netmem, unsigned int offset)
 {
-	return page_address(page) + offset;
+	return netmem_address(netmem) + offset;
 }
 
 extern const u16 bnxt_bstore_to_trace[];
@@ -2879,8 +2881,8 @@ extern const u16 bnxt_lhint_arr[];
 
 int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp);
-void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons,
-			struct page *page);
+void bnxt_reuse_rx_netmem(struct bnxt_rx_ring_info *rxr, u16 cons,
+			  netmem_ref netmem);
 u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_idx);
 bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type);
 void bnxt_set_tpa_flags(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 2938697aa381..949872279f50 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4855,7 +4855,7 @@ static int bnxt_rx_loopback(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		&cpr->cp_desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
 	cons = rxcmp->rx_cmp_opaque;
 	rx_buf = &rxr->rx_buf_ring[cons];
-	data = bnxt_data_ptr(bp, rx_buf->page, rx_buf->offset);
+	data = bnxt_data_ptr(bp, rx_buf->netmem, rx_buf->offset);
 	len = le32_to_cpu(rxcmp->rx_cmp_len_flags_type) >> RX_CMP_LEN_SHIFT;
 	if (len != pkt_size)
 		return -EIO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 1ba2ad7bf4b0..e6f5d2a2bb60 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -180,12 +180,13 @@ bool bnxt_xdp_attached(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 }
 
 void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
-			u16 cons, struct page *page, unsigned int len,
+			u16 cons, netmem_ref netmem, unsigned int len,
 			struct xdp_buff *xdp)
 {
-	page_pool_dma_sync_for_cpu(rxr->page_pool, page, bp->rx_offset, len);
+	page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem,
+					  bp->rx_offset, len);
 	xdp_init_buff(xdp, BNXT_RX_PAGE_SIZE, &rxr->xdp_rxq);
-	xdp_prepare_buff(xdp, page_address(page), bp->rx_offset, len, true);
+	xdp_prepare_buff(xdp, netmem_address(netmem), bp->rx_offset, len, true);
 }
 
 void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
@@ -198,9 +199,9 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 		return;
 	shinfo = xdp_get_shared_info_from_buff(xdp);
 	for (i = 0; i < shinfo->nr_frags; i++) {
-		struct page *page = skb_frag_page(&shinfo->frags[i]);
+		netmem_ref netmem = skb_frag_netmem(&shinfo->frags[i]);
 
-		page_pool_recycle_direct(rxr->page_pool, page);
+		page_pool_recycle_direct_netmem(rxr->page_pool, netmem);
 	}
 	shinfo->nr_frags = 0;
 }
@@ -210,7 +211,7 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
  * false   - packet should be passed to the stack.
  */
 bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
-		 struct xdp_buff *xdp, struct page *page, u8 **data_ptr,
+		 struct xdp_buff *xdp, netmem_ref netmem, u8 **data_ptr,
 		 unsigned int *len, u8 *event)
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(rxr->xdp_prog);
@@ -268,16 +269,17 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		if (tx_avail < tx_needed) {
 			trace_xdp_exception(bp->dev, xdp_prog, act);
 			bnxt_xdp_buff_frags_free(rxr, xdp);
-			bnxt_reuse_rx_data(rxr, cons, page);
+			bnxt_reuse_rx_netmem(rxr, cons, netmem);
 			return true;
 		}
 
-		page_pool_dma_sync_for_cpu(rxr->page_pool, page, offset, *len);
+		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem,
+						  offset, *len);
 
 		*event |= BNXT_TX_EVENT;
 		__bnxt_xmit_xdp(bp, txr, mapping + offset, *len,
 				NEXT_RX(rxr->rx_prod), xdp);
-		bnxt_reuse_rx_data(rxr, cons, page);
+		bnxt_reuse_rx_netmem(rxr, cons, netmem);
 		return true;
 	case XDP_REDIRECT:
 		/* if we are calling this here then we know that the
@@ -289,13 +291,13 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		if (bnxt_alloc_rx_data(bp, rxr, rxr->rx_prod, GFP_ATOMIC)) {
 			trace_xdp_exception(bp->dev, xdp_prog, act);
 			bnxt_xdp_buff_frags_free(rxr, xdp);
-			bnxt_reuse_rx_data(rxr, cons, page);
+			bnxt_reuse_rx_netmem(rxr, cons, netmem);
 			return true;
 		}
 
 		if (xdp_do_redirect(bp->dev, xdp, xdp_prog)) {
 			trace_xdp_exception(bp->dev, xdp_prog, act);
-			page_pool_recycle_direct(rxr->page_pool, page);
+			page_pool_recycle_direct_netmem(rxr->page_pool, netmem);
 			return true;
 		}
 
@@ -309,7 +311,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		fallthrough;
 	case XDP_DROP:
 		bnxt_xdp_buff_frags_free(rxr, xdp);
-		bnxt_reuse_rx_data(rxr, cons, page);
+		bnxt_reuse_rx_netmem(rxr, cons, netmem);
 		break;
 	}
 	return true;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 9592d04e0661..85b6df6a9e7f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -18,7 +18,7 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 				   struct xdp_buff *xdp);
 void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget);
 bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
-		 struct xdp_buff *xdp, struct page *page, u8 **data_ptr,
+		 struct xdp_buff *xdp, netmem_ref netmem, u8 **data_ptr,
 		 unsigned int *len, u8 *event);
 int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp);
 int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
@@ -27,7 +27,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 bool bnxt_xdp_attached(struct bnxt *bp, struct bnxt_rx_ring_info *rxr);
 
 void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
-			u16 cons, struct page *page, unsigned int len,
+			u16 cons, netmem_ref netmem, unsigned int len,
 			struct xdp_buff *xdp);
 void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 			      struct xdp_buff *xdp);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fa79145518d1..08aa6891e17b 100644
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
index be17e0660144..f8cb53782dad 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10367,6 +10367,12 @@ u32 dev_get_min_mp_channel_count(const struct net_device *dev)
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


