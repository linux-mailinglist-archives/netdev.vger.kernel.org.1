Return-Path: <netdev+bounces-220440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1F0B45FEB
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5EFA4467F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8746330B51C;
	Fri,  5 Sep 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JLQ7Poyc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC41374281
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092843; cv=none; b=uHbDuALRwfXXme2iOdlcon4mxCa3WF3vrBgAmO7oDbT5ay3NhHsWwcQh2Q2ldHhpmNhJfY0MoUrlckjr0HxZO8ZD7nqpTfy5wf0n8KhYOf5JSRTRl85t7NhQcCMtzv5J00xEoPnEGT6RS4AITQw7KhZHLMzWLDE2JK5R7fMoNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092843; c=relaxed/simple;
	bh=zO5AUhiyBcaDn20NMDzr0lBMIQ5fea78M6A8WTV5ik8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cveHyKEHGmRZ0Dg4+g8iJB5yks2vIwv8QV70zhomlfYeDwysNdxYEd6Q7frQzwNz/gPsck7HivxeQs+isaOAdWNv/KSiqAE04Sxujzd1+SwEnGsUxWTiDRcqmEValfg46PGBgu0bhyhO4zU2h0/gRRW1heFy0PRgh3i7u9h0Vyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JLQ7Poyc; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e9d71a04d78so2218983276.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092840; x=1757697640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPtLPCbW9cI52nHjoIxx9FA19cFt1KOBK+vvcRFUVCI=;
        b=tJFOGIVJJa3i4Qg1RIPQZ4sg+5ZlEr+dJSY/3msd42VtFT0eAPVZS7o/3vV6S/Yixk
         K3Ctf9sTKt4LamcNNcw2Aet5p+F1LY7uV5/hZdyHVo8vE6GpHGszvr9CUJOpo3tZaXl5
         9eGs3/HoMWapEHazdGT341lsLrhE16MAEgbTZanV8bZCtyGsn8DyIX5hF2EGpFAA0ZxJ
         EPofuzoZBNCktkir+BTEKRnARjWNOND61y3dox85BDjYOCy9JVzKbxMdbxd7HNA49yfx
         pFLjJKxgbnKBuWDFUGOTuYV7uq478s7EJ2l5H4I5xQTP2RvpVp/8mcHxHmzePYSg6aMO
         z4Qg==
X-Gm-Message-State: AOJu0YzUhcq/k5nU9Zan9uRMMHEb1dp8dYRwjbWxg/jm2n65XGTbJhQM
	KyE8bOy4zVXJA+UHF1rgkksDKZaqyNRujkbEdppVFYweFH7ESkwbanVAgUPXIr/1oI6552lgLrw
	53s8j/m7wne+GlXoFRCdTvlC/hpxDhRSLPgP4RUVNmh8WXQpy99exxDXKi4iISWcp2C5k6ZYunz
	Mr6C9GcKD57zvYbZXRgbrv3rzGTBmKEEGqghA6J6MrOCHEPvAvIEOE9H5e2GkN3+DcSeypuDXda
	BoWJforMBFVWzBAeMnN
X-Gm-Gg: ASbGncttOFCenZE7cOnJasbkBWau3LYmr00CFrlCKkpZXg/vxaCVF7cVkrmr1Q34FAG
	Zt3kfaLQ7vjX9UzMZFzS0BfDkjEIODoxuTMQyOEz3ZUbvcwWq8gtXI8B2/MjUYLqz7Ep2auPtNK
	PaE1yXs/V1HMATotsiZPQ3aO6jYC5tyBfgSbMFTKVHVuc4L5obyDZUDYAD/nr1/BlNpNITOjTJx
	w4/9gQmpSDw1i2QnOor2Awrql9AcoScQ8hwC4GA3K+sh+PBTkNMh7FGeO49DV7rEWdi4W8sAyAJ
	f3Qz+GJ0ZE67ZTZD4BE3UxoTBmuNJ9XqKnQi/qtUooKidQp1TwWVf94zbIQgxb4/P3SqDecvsTR
	5/kTEnXZ0VfVmbaCyM7X2m8tGPcvtkHpPvySxDMKm6nt5/NgqA1GfqOuMAe9b/qaDikNigiHaO0
	/H9yawoWeM
X-Google-Smtp-Source: AGHT+IECLm2wkvXFUvIGVp1R/kooMyHJz1X4BspUUmvsSTYkMj8JAhWiFfA3kZhO+qmtCg9mXy3vFL2uX7xp
X-Received: by 2002:a05:690c:350a:b0:723:bd6c:4f2a with SMTP id 00721157ae682-723bd6c5709mr93624947b3.7.1757092840440;
        Fri, 05 Sep 2025 10:20:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-723a857c5fasm8358207b3.45.2025.09.05.10.20.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:20:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so2384584b3a.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757092839; x=1757697639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPtLPCbW9cI52nHjoIxx9FA19cFt1KOBK+vvcRFUVCI=;
        b=JLQ7PoycZUTQOZu6U9i6erPdgjNgKSMOnnn9GMO3+e7CjiPtnxkQEKJPiyUilFOF2r
         E4Pxdi+L7Koq4VCgRs6QazrsoHkmTGTHgFLVMsr5BYfXRXTASW9h0X7SrqbE2X2PpB/A
         Ivot8qg487HdC1IKGTMD3o+JwIFseGygZ91x0=
X-Received: by 2002:aa7:8895:0:b0:771:fab2:83ca with SMTP id d2e1a72fcca58-7723e21e641mr32004510b3a.4.1757092839117;
        Fri, 05 Sep 2025 10:20:39 -0700 (PDT)
X-Received: by 2002:aa7:8895:0:b0:771:fab2:83ca with SMTP id d2e1a72fcca58-7723e21e641mr32004483b3a.4.1757092838657;
        Fri, 05 Sep 2025 10:20:38 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm22678001b3a.30.2025.09.05.10.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:20:38 -0700 (PDT)
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
Subject: [v6, net-next 06/10] bng_en: Allocate packet buffers
Date: Fri,  5 Sep 2025 22:46:48 +0000
Message-ID: <20250905224652.48692-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
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
index ee0cdea6fc0..a9fd5b242cb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -263,6 +263,76 @@ static bool bnge_separate_head_pool(struct bnge_rx_ring_info *rxr)
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
@@ -733,6 +803,160 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
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
@@ -800,7 +1024,7 @@ static int bnge_init_one_rx_ring(struct bnge_net *bn, int ring_nr)
 
 	bnge_init_one_rx_agg_ring_rxbd(bn, rxr);
 
-	return 0;
+	return bnge_alloc_one_rx_ring(bn, ring_nr);
 }
 
 static int bnge_init_rx_rings(struct bnge_net *bn)
@@ -1149,6 +1373,7 @@ static void bnge_close_core(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_free_pkts_mem(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
 
-- 
2.47.3


