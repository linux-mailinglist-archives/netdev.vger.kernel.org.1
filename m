Return-Path: <netdev+bounces-217819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E553FB39E9D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2581C83345
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE8C42056;
	Thu, 28 Aug 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EKfcC2pT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B103148D7
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387160; cv=none; b=OjpPGTBpx7i4B32HIDXVRqEjBXLX/kluhSIDmPjc2sw1qXhrwr9NUiD9ehPVzEWY8lwo5cHO3MYIcmfi+RQxD/CKbERZYlqt8OTh1e1L+St3k+1V0ZF7/4mkKrKDoRsvPLtTuB2pAZZF4Fm4u6G4I9n28LiZ4tEjPh7A3peLzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387160; c=relaxed/simple;
	bh=54bqou4YjfblAvVbrPMbCIUxuvWl+YXO38AaB8aFbx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwOnftjbDuk8eOsdaIZNVId41WZvUWM3mZFvnkH/cZa/IlhC2nvN80zTXJA5E4KznJVzZmt1xMGHJzL97jQCvPthEnIrNN34OqhbjlW9kt84BL3SQUcen+qXQEuuPCO8kSI1/1ZM6uwOANGlyjid1SxGLd42b6L9e4ymiEwuSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EKfcC2pT; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2445806e03cso10157575ad.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387158; x=1756991958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PtpeW3HaTZ+8WHjiapTbySUQ7qWF0T9l6H0l3UPwm0=;
        b=CpY4VVUHr3MoW96BlpeC5l9Az9FQXpzGu9IKaSDn3Xxu36kn3tBTKUuAOnDQPL7Gbo
         vU5fnalCNJfNPoyvZ716vbZxpH9WEPWe32U0ClOpwjKWXzN2itCakMpC55zdga7CZ2zX
         B4Xdmsd+otTeTONgJ7GmWy1aPx9/GNQj0x1gNzM0sYAfmkgTbtjwjoAKSYAU4bGUdm8H
         dQWF/waGhKuVR96QqX/wJ8jZvI29Sib5/Jge+48qXPmDc5slnMpO9pbIZwVHRI1uVVfc
         udx76w7vGr+td3mofCwkGgPWX0Zc4jhyC4+RyPzJbNemUC0+bqccESaHTsX2rBna/Y6Y
         c08w==
X-Gm-Message-State: AOJu0YyFDu6rVPVXE7PjqzLnR+QC9EMI/Neu/H7ZbL2L+7XluTaKxOLH
	DQfExy86I9adV+fvgZEYBQ6hew9YUVH5VznO3MTPejJiWCbbnlrEjck9nBgc1NzPtkwUMtPa89U
	3jggraTmUDdqDUf/C4ekosXSN7Y3QhMYPebCzPGK/7e6Osu6xYW7Xe8/XoC+OfQC6WPuxxj55th
	KculLYmamhsH6vQnL1kyH2ElKkjv9uDNAbN0q+cpOO1XMcUgqPo3RSB//yGvhQgAX59HvqEtiW1
	xgCjhhF1R17qAV+pD5l
X-Gm-Gg: ASbGncueCX8mtPfYcvXNfwwKKtRNZJNbfFudJ+pdgYvCNFyabMojaH0TzhXZ3eIkNAM
	546weQEzVfyVMb7t+3yCURPxerlt9A2pXA5F9n8n5HS79FKFUZ7RNALdD0URnoUehbjN9CCgK/M
	Xy+kKFlHdY89GI0yqVROiy7956WqrvmXnj+KUVp9XGLrER/3Aws305/VcILxLve8ZqqBBfHKw8q
	9P9AkwEf3HDgQdh/dCATpnlwZ5JG0RRCarVxsDoKtcm0oiiXYY1JqmYhmMYdBzSb/UT0xp9NL+3
	tT+ybshwQsWxzM+B3n7QBZb+sZt69aJJWDbC4Nn3bauIAMpH1RaalmxCFIybs2Fdxv6m/5UT3l2
	uhHqBX9dFzlNVOZH8wtLc4yxhYuUjOBtgZl/53ll6hw9SQ1Sg7x0Om3TLPkmmwyxn5bAZ4gglaz
	HO65+4GBR3
X-Google-Smtp-Source: AGHT+IF/Z9Dgsj8WDWGdM+UDbCnDj8SKAhyBEf+pq9KCAXXjNMmeaKtUfIa1I3ZB9jthYK51Ngj5UE7tSRIG
X-Received: by 2002:a17:902:720a:b0:246:61c:a67c with SMTP id d9443c01a7336-2462efd6233mr222595255ad.59.1756387157856;
        Thu, 28 Aug 2025 06:19:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2466886d3c3sm14378955ad.43.2025.08.28.06.19.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:19:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-325ce1082bcso1557277a91.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756387156; x=1756991956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PtpeW3HaTZ+8WHjiapTbySUQ7qWF0T9l6H0l3UPwm0=;
        b=EKfcC2pT8BmzgNfqE0zoqdYcaU5oDFWfjcPWwyEnkV7LomfUgrK1oNNNlS8U1Pz9Mh
         mr3/MmyTm8fyFlsDF+uWvr+1OwWk5z9uJtK/pUj7uIgwDDQj94FjNwUs/hf3z/L4ad8E
         DRcfDhqz8YtxXr2OE+N3+rEa5UPn0PzHHL0Hg=
X-Received: by 2002:a17:902:eb83:b0:248:f2f0:391c with SMTP id d9443c01a7336-248f2f04221mr10537905ad.23.1756387156246;
        Thu, 28 Aug 2025 06:19:16 -0700 (PDT)
X-Received: by 2002:a17:902:eb83:b0:248:f2f0:391c with SMTP id d9443c01a7336-248f2f04221mr10537555ad.23.1756387155751;
        Thu, 28 Aug 2025 06:19:15 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248b6a16ae3sm36468705ad.137.2025.08.28.06.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:19:15 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v5, net-next 5/9] bng_en: Allocate packet buffers
Date: Thu, 28 Aug 2025 18:45:43 +0000
Message-ID: <20250828184547.242496-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
References: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Populate packet buffers into the RX and AGG rings while these
rings are being initialized.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 227 +++++++++++++++++-
 1 file changed, 226 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 83419c986ebb..4305d02072c6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -251,6 +251,76 @@ static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
 	return rxr->need_head_pool || PAGE_SIZE > BNGE_RX_PAGE_SIZE;
 }
 
+static void bnge_free_one_rx_ring(struct bnge_net *bn,
+				  struct bnge_rx_ring_info *rxr)
+{
+	int i, max_idx;
+
+	if (!rxr->rx_buf_ring)
+		return;
+
+	max_idx = bn->rx_nr_pages * RX_DESC_CNT;
+
+	for (i = 0; i < max_idx; i++) {
+		struct bnge_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[i];
+		void *data = rx_buf->data;
+
+		if (!data)
+			continue;
+
+		rx_buf->data = NULL;
+		page_pool_free_va(rxr->head_pool, data, true);
+	}
+}
+
+static void bnge_free_one_rx_agg_ring(struct bnge_net *bn,
+				      struct bnge_rx_ring_info *rxr)
+{
+	int i, max_idx;
+
+	if (!rxr->rx_agg_buf_ring)
+		return;
+
+	max_idx = bn->rx_agg_nr_pages * RX_DESC_CNT;
+
+	for (i = 0; i < max_idx; i++) {
+		struct bnge_sw_rx_agg_bd *rx_agg_buf = &rxr->rx_agg_buf_ring[i];
+		netmem_ref netmem = rx_agg_buf->netmem;
+
+		if (!netmem)
+			continue;
+
+		rx_agg_buf->netmem = 0;
+		__clear_bit(i, rxr->rx_agg_bmap);
+
+		page_pool_recycle_direct_netmem(rxr->page_pool, netmem);
+	}
+}
+
+static void bnge_free_one_rx_pkt_mem(struct bnge_net *bn,
+				     struct bnge_rx_ring_info *rxr)
+{
+	bnge_free_one_rx_ring(bn, rxr);
+	bnge_free_one_rx_agg_ring(bn, rxr);
+}
+
+static void bnge_free_rx_pkt_bufs(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->rx_ring)
+		return;
+
+	for (i = 0; i < bd->rx_nr_rings; i++)
+		bnge_free_one_rx_pkt_mem(bn, &bn->rx_ring[i]);
+}
+
+static void bnge_free_pkts_mem(struct bnge_net *bn)
+{
+	bnge_free_rx_pkt_bufs(bn);
+}
+
 static void bnge_free_rx_rings(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -727,6 +797,160 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
 	}
 }
 
+static netmem_ref __bnge_alloc_rx_netmem(struct bnge_net *bn,
+					 dma_addr_t *mapping,
+					 struct bnge_rx_ring_info *rxr,
+					 unsigned int *offset,
+					 gfp_t gfp)
+{
+	netmem_ref netmem;
+
+	if (PAGE_SIZE > BNGE_RX_PAGE_SIZE) {
+		netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset,
+						     BNGE_RX_PAGE_SIZE, gfp);
+	} else {
+		netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
+		*offset = 0;
+	}
+	if (!netmem)
+		return 0;
+
+	*mapping = page_pool_get_dma_addr_netmem(netmem) + *offset;
+	return netmem;
+}
+
+static u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
+				struct bnge_rx_ring_info *rxr,
+				gfp_t gfp)
+{
+	unsigned int offset;
+	struct page *page;
+
+	page = page_pool_alloc_frag(rxr->head_pool, &offset,
+				    bn->rx_buf_size, gfp);
+	if (!page)
+		return NULL;
+
+	*mapping = page_pool_get_dma_addr(page) + bn->rx_dma_offset + offset;
+	return page_address(page) + offset;
+}
+
+static int bnge_alloc_rx_data(struct bnge_net *bn,
+			      struct bnge_rx_ring_info *rxr,
+			      u16 prod, gfp_t gfp)
+{
+	struct bnge_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[RING_RX(bn, prod)];
+	struct rx_bd *rxbd;
+	dma_addr_t mapping;
+	u8 *data;
+
+	rxbd = &rxr->rx_desc_ring[RX_RING(bn, prod)][RX_IDX(prod)];
+	data = __bnge_alloc_rx_frag(bn, &mapping, rxr, gfp);
+	if (!data)
+		return -ENOMEM;
+
+	rx_buf->data = data;
+	rx_buf->data_ptr = data + bn->rx_offset;
+	rx_buf->mapping = mapping;
+
+	rxbd->rx_bd_haddr = cpu_to_le64(mapping);
+
+	return 0;
+}
+
+static void bnge_alloc_one_rx_pkt_mem(struct bnge_net *bn,
+				      struct bnge_rx_ring_info *rxr,
+				      int ring_nr)
+{
+	u32 prod;
+	int i;
+
+	prod = rxr->rx_prod;
+	for (i = 0; i < bn->rx_ring_size; i++) {
+		if (bnge_alloc_rx_data(bn, rxr, prod, GFP_KERNEL)) {
+			netdev_warn(bn->netdev, "init'ed rx ring %d with %d/%d skbs only\n",
+				    ring_nr, i, bn->rx_ring_size);
+			break;
+		}
+		prod = NEXT_RX(prod);
+	}
+	rxr->rx_prod = prod;
+}
+
+static u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx)
+{
+	u16 next, max = rxr->rx_agg_bmap_size;
+
+	next = find_next_zero_bit(rxr->rx_agg_bmap, max, idx);
+	if (next >= max)
+		next = find_first_zero_bit(rxr->rx_agg_bmap, max);
+	return next;
+}
+
+static int bnge_alloc_rx_netmem(struct bnge_net *bn,
+				struct bnge_rx_ring_info *rxr,
+				u16 prod, gfp_t gfp)
+{
+	struct bnge_sw_rx_agg_bd *rx_agg_buf;
+	u16 sw_prod = rxr->rx_sw_agg_prod;
+	unsigned int offset = 0;
+	struct rx_bd *rxbd;
+	dma_addr_t mapping;
+	netmem_ref netmem;
+
+	rxbd = &rxr->rx_agg_desc_ring[RX_AGG_RING(bn, prod)][RX_IDX(prod)];
+	netmem = __bnge_alloc_rx_netmem(bn, &mapping, rxr, &offset, gfp);
+	if (!netmem)
+		return -ENOMEM;
+
+	if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
+		sw_prod = bnge_find_next_agg_idx(rxr, sw_prod);
+
+	__set_bit(sw_prod, rxr->rx_agg_bmap);
+	rx_agg_buf = &rxr->rx_agg_buf_ring[sw_prod];
+	rxr->rx_sw_agg_prod = RING_RX_AGG(bn, NEXT_RX_AGG(sw_prod));
+
+	rx_agg_buf->netmem = netmem;
+	rx_agg_buf->offset = offset;
+	rx_agg_buf->mapping = mapping;
+	rxbd->rx_bd_haddr = cpu_to_le64(mapping);
+	rxbd->rx_bd_opaque = sw_prod;
+	return 0;
+}
+
+static void bnge_alloc_one_rx_ring_netmem(struct bnge_net *bn,
+					  struct bnge_rx_ring_info *rxr,
+					  int ring_nr)
+{
+	u32 prod;
+	int i;
+
+	prod = rxr->rx_agg_prod;
+	for (i = 0; i < bn->rx_agg_ring_size; i++) {
+		if (bnge_alloc_rx_netmem(bn, rxr, prod, GFP_KERNEL)) {
+			netdev_warn(bn->netdev, "init'ed rx agg ring %d with %d/%d pages only\n",
+				    ring_nr, i, bn->rx_agg_ring_size);
+			break;
+		}
+		prod = NEXT_RX_AGG(prod);
+	}
+	rxr->rx_agg_prod = prod;
+}
+
+static int bnge_alloc_one_rx_ring(struct bnge_net *bn, int ring_nr)
+{
+	struct bnge_rx_ring_info *rxr = &bn->rx_ring[ring_nr];
+
+	bnge_alloc_one_rx_pkt_mem(bn, rxr, ring_nr);
+
+	if (!(bnge_is_agg_reqd(bn->bd)))
+		return 0;
+
+	bnge_alloc_one_rx_ring_netmem(bn, rxr, ring_nr);
+
+	return 0;
+}
+
 static void bnge_init_rxbd_pages(struct bnge_ring_struct *ring, u32 type)
 {
 	struct rx_bd **rx_desc_ring;
@@ -794,7 +1018,7 @@ static int bnge_init_one_rx_ring(struct bnge_net *bn, int ring_nr)
 
 	bnge_init_one_rx_agg_ring_rxbd(bn, rxr);
 
-	return 0;
+	return bnge_alloc_one_rx_ring(bn, ring_nr);
 }
 
 static int bnge_init_rx_rings(struct bnge_net *bn)
@@ -1147,6 +1371,7 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_pkts_mem(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
 
-- 
2.47.3


