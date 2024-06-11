Return-Path: <netdev+bounces-102425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC7F902E6E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E081F232DF
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30516F90A;
	Tue, 11 Jun 2024 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="utAkuAuJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854816F8FB
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073210; cv=none; b=ZZOoCB7RziyAFaEz9dySHJSVfroeGgsiH4J0A7c0C+hozAjTx/HHMIvywGDDjn7BU3zV3lfUZvVKAPb5oJt3tzg/2uD0OGzg6afeGod5mnbbb6V9NXrfYEnozw6G2tXUHTF1KcjKah9e1sxp1ei1o4ak/tiB8giTs/K1eyEOdZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073210; c=relaxed/simple;
	bh=QvvWZynXg2rJwpyQ2BI0IxqIaGeVl6ZoRuRh48IoB+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7/XhoTRwPb8svdHf++fA0O6HnxI8hA/0w1xHFpzVDZgKrzvzrYg7NZZt3apZPlZy/hjLscA0EpMG+/Kwd8bsRqR2lp8fI3oljRiIjANABrGf3FBBp/YHLQyba8z3WZmUMe9n0ufoo0wUCAwLr1H/MzXmqER7m4ZXQpmzC+wLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=utAkuAuJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e3741519d7so2373166a12.2
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 19:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718073208; x=1718678008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kCUI5nTpVkeiUtvHwlqgV7WQRDkZZLMq+FzefkfTOM=;
        b=utAkuAuJzZHoj5j1r0HZwNMwt3UNmzaej0W30UAh7wJx/39DAOtD9AMrxbnOzP4Pko
         8Kybp/0qV1LA1EHMJO4Hvl03rlf3q9vpp/O5ry2OnhaB4lqv+LPTtScrTRVY1Mxf9USl
         BCKpvdxWdFxe/JAo+Jfx6hlTOwNDWvuZNqDE5AZXj4IH11SKNo0S4b1+KoTKMujDSRVB
         DEpMsQWHfpeANrDq7xRyCcDgHJfoCqq9aYVmmwP2koc76JKpPlR00BBgbZJrmACsKmzw
         ZWCVRky0VpZNnfuoeMPLcfLVsWx8EtR3WoXXBYP8092fJmhbo2wD6Ka889cZhRBnpn/g
         rLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718073208; x=1718678008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kCUI5nTpVkeiUtvHwlqgV7WQRDkZZLMq+FzefkfTOM=;
        b=tpERDVrOISTadGmtXCUqke5scMnzk1xl8G0Ms2bqIqBgeco/IuRUrLU5Wy4BPKvza8
         SEdcNjidKUTaqn68qivoioEvXLTp1mR2rGT1VqFFXH07r6zvH3HRI2GU1dWortdvTwLk
         srORoN+ZgON7L/aB1++xbCP9NoSzvTNbmHVY3/hFkVXWAdznO18jWp1PwDOQRdJbPco6
         1+K2uVa0GWEwRCiKWX+MdhqHRdDaxgRN9Ig6M6hSA8HiYrRNOMsZnAQK4j4E5W+hlIlA
         jq9G7HO3G4GzBK0zuk3yCh2U3Ut0i4L1rQM7d3wfXPyl3tDsTx0BkzpUzsFCBDPns9LE
         EqwA==
X-Forwarded-Encrypted: i=1; AJvYcCWT7vheXAjXX4OZ4Owxyqh7NOPJ2AcmXcLIB5ZLdwR7wIoPTU+RhpS9eRuPNRWR6LMNlhS2IK/xRnzZcyt4Gsfzl+HSaRI1
X-Gm-Message-State: AOJu0Yyw829aWGCMGXIGGEfR60hZ4918FW+BcRCwBqQUgasq5wczbf5f
	t5XofORKozq7pSLD0MkNXkrjBKkjjaK0k15yX9L6xcWfsYMGZ+xCy6HLBVgsos4=
X-Google-Smtp-Source: AGHT+IGZr/lD9DPEfawFKhjvRJcVCGun4RGRf1h6Y+sxIZIa2QJsujQiBq2MVNirLFsEZM2gk4Zc5w==
X-Received: by 2002:a05:6a20:9143:b0:1b5:d172:91e4 with SMTP id adf61e73a8af0-1b5d1729592mr6870043637.37.1718073208388;
        Mon, 10 Jun 2024 19:33:28 -0700 (PDT)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28066d57esm11906351a91.19.2024.06.10.19.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 19:33:28 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 2/3] bnxt_en: split rx ring helpers out from ring helpers
Date: Mon, 10 Jun 2024 19:33:23 -0700
Message-ID: <20240611023324.1485426-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611023324.1485426-1-dw@davidwei.uk>
References: <20240611023324.1485426-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for queue API implementation, split rx ring functions out
from ring helpers. These new helpers will be called from queue API
implementation.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 302 ++++++++++++++--------
 1 file changed, 195 insertions(+), 107 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ebcf393f06dc..b5895e0854d1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3317,37 +3317,12 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
 	}
 }
 
-static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
+static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 {
-	struct bnxt_rx_ring_info *rxr = &bp->rx_ring[ring_nr];
 	struct pci_dev *pdev = bp->pdev;
-	struct bnxt_tpa_idx_map *map;
-	int i, max_idx, max_agg_idx;
+	int i, max_idx;
 
 	max_idx = bp->rx_nr_pages * RX_DESC_CNT;
-	max_agg_idx = bp->rx_agg_nr_pages * RX_DESC_CNT;
-	if (!rxr->rx_tpa)
-		goto skip_rx_tpa_free;
-
-	for (i = 0; i < bp->max_tpa; i++) {
-		struct bnxt_tpa_info *tpa_info = &rxr->rx_tpa[i];
-		u8 *data = tpa_info->data;
-
-		if (!data)
-			continue;
-
-		dma_unmap_single_attrs(&pdev->dev, tpa_info->mapping,
-				       bp->rx_buf_use_size, bp->rx_dir,
-				       DMA_ATTR_WEAK_ORDERING);
-
-		tpa_info->data = NULL;
-
-		skb_free_frag(data);
-	}
-
-skip_rx_tpa_free:
-	if (!rxr->rx_buf_ring)
-		goto skip_rx_buf_free;
 
 	for (i = 0; i < max_idx; i++) {
 		struct bnxt_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[i];
@@ -3367,12 +3342,15 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 			skb_free_frag(data);
 		}
 	}
+}
 
-skip_rx_buf_free:
-	if (!rxr->rx_agg_ring)
-		goto skip_rx_agg_free;
+static void bnxt_free_one_rx_agg_ring(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
+{
+	int i, max_idx;
+
+	max_idx = bp->rx_agg_nr_pages * RX_DESC_CNT;
 
-	for (i = 0; i < max_agg_idx; i++) {
+	for (i = 0; i < max_idx; i++) {
 		struct bnxt_sw_rx_agg_bd *rx_agg_buf = &rxr->rx_agg_ring[i];
 		struct page *page = rx_agg_buf->page;
 
@@ -3384,6 +3362,45 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 
 		page_pool_recycle_direct(rxr->page_pool, page);
 	}
+}
+
+static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
+{
+	struct bnxt_rx_ring_info *rxr = &bp->rx_ring[ring_nr];
+	struct pci_dev *pdev = bp->pdev;
+	struct bnxt_tpa_idx_map *map;
+	int i;
+
+	if (!rxr->rx_tpa)
+		goto skip_rx_tpa_free;
+
+	for (i = 0; i < bp->max_tpa; i++) {
+		struct bnxt_tpa_info *tpa_info = &rxr->rx_tpa[i];
+		u8 *data = tpa_info->data;
+
+		if (!data)
+			continue;
+
+		dma_unmap_single_attrs(&pdev->dev, tpa_info->mapping,
+				       bp->rx_buf_use_size, bp->rx_dir,
+				       DMA_ATTR_WEAK_ORDERING);
+
+		tpa_info->data = NULL;
+
+		skb_free_frag(data);
+	}
+
+skip_rx_tpa_free:
+	if (!rxr->rx_buf_ring)
+		goto skip_rx_buf_free;
+
+	bnxt_free_one_rx_ring(bp, rxr);
+
+skip_rx_buf_free:
+	if (!rxr->rx_agg_ring)
+		goto skip_rx_agg_free;
+
+	bnxt_free_one_rx_agg_ring(bp, rxr);
 
 skip_rx_agg_free:
 	map = rxr->rx_tpa_idx_map;
@@ -4062,37 +4079,55 @@ static void bnxt_init_rxbd_pages(struct bnxt_ring_struct *ring, u32 type)
 	}
 }
 
-static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
+static void bnxt_alloc_one_rx_ring_skb(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr,
+				       int ring_nr)
 {
-	struct bnxt_rx_ring_info *rxr = &bp->rx_ring[ring_nr];
-	struct net_device *dev = bp->dev;
 	u32 prod;
 	int i;
 
 	prod = rxr->rx_prod;
 	for (i = 0; i < bp->rx_ring_size; i++) {
 		if (bnxt_alloc_rx_data(bp, rxr, prod, GFP_KERNEL)) {
-			netdev_warn(dev, "init'ed rx ring %d with %d/%d skbs only\n",
+			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d skbs only\n",
 				    ring_nr, i, bp->rx_ring_size);
 			break;
 		}
 		prod = NEXT_RX(prod);
 	}
 	rxr->rx_prod = prod;
+}
 
-	if (!(bp->flags & BNXT_FLAG_AGG_RINGS))
-		return 0;
+static void bnxt_alloc_one_rx_ring_page(struct bnxt *bp,
+					struct bnxt_rx_ring_info *rxr,
+					int ring_nr)
+{
+	u32 prod;
+	int i;
 
 	prod = rxr->rx_agg_prod;
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
 		if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_KERNEL)) {
-			netdev_warn(dev, "init'ed rx ring %d with %d/%d pages only\n",
+			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
 				    ring_nr, i, bp->rx_ring_size);
 			break;
 		}
 		prod = NEXT_RX_AGG(prod);
 	}
 	rxr->rx_agg_prod = prod;
+}
+
+static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
+{
+	struct bnxt_rx_ring_info *rxr = &bp->rx_ring[ring_nr];
+	int i;
+
+	bnxt_alloc_one_rx_ring_skb(bp, rxr, ring_nr);
+
+	if (!(bp->flags & BNXT_FLAG_AGG_RINGS))
+		return 0;
+
+	bnxt_alloc_one_rx_ring_page(bp, rxr, ring_nr);
 
 	if (rxr->rx_tpa) {
 		dma_addr_t mapping;
@@ -4111,9 +4146,9 @@ static int bnxt_alloc_one_rx_ring(struct bnxt *bp, int ring_nr)
 	return 0;
 }
 
-static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
+static void bnxt_init_one_rx_ring_rxbd(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr)
 {
-	struct bnxt_rx_ring_info *rxr;
 	struct bnxt_ring_struct *ring;
 	u32 type;
 
@@ -4123,28 +4158,45 @@ static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
 	if (NET_IP_ALIGN == 2)
 		type |= RX_BD_FLAGS_SOP;
 
-	rxr = &bp->rx_ring[ring_nr];
 	ring = &rxr->rx_ring_struct;
 	bnxt_init_rxbd_pages(ring, type);
-
-	netif_queue_set_napi(bp->dev, ring_nr, NETDEV_QUEUE_TYPE_RX,
-			     &rxr->bnapi->napi);
-
-	if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
-		bpf_prog_add(bp->xdp_prog, 1);
-		rxr->xdp_prog = bp->xdp_prog;
-	}
 	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
+					   struct bnxt_rx_ring_info *rxr)
+{
+	struct bnxt_ring_struct *ring;
+	u32 type;
 
 	ring = &rxr->rx_agg_ring_struct;
 	ring->fw_ring_id = INVALID_HW_RING_ID;
-
 	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
 		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
 			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
 
 		bnxt_init_rxbd_pages(ring, type);
 	}
+}
+
+static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
+{
+	struct bnxt_rx_ring_info *rxr;
+	struct bnxt_ring_struct *ring;
+
+	rxr = &bp->rx_ring[ring_nr];
+	ring = &rxr->rx_ring_struct;
+	bnxt_init_one_rx_ring_rxbd(bp, rxr);
+
+	netif_queue_set_napi(bp->dev, ring_nr, NETDEV_QUEUE_TYPE_RX,
+			     &rxr->bnapi->napi);
+
+	if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
+		bpf_prog_add(bp->xdp_prog, 1);
+		rxr->xdp_prog = bp->xdp_prog;
+	}
+
+	bnxt_init_one_rx_agg_ring_rxbd(bp, rxr);
 
 	return bnxt_alloc_one_rx_ring(bp, ring_nr);
 }
@@ -6870,6 +6922,48 @@ static void bnxt_set_db(struct bnxt *bp, struct bnxt_db_info *db, u32 ring_type,
 	bnxt_set_db_mask(bp, db, ring_type);
 }
 
+static int bnxt_hwrm_rx_ring_alloc(struct bnxt *bp,
+				   struct bnxt_rx_ring_info *rxr)
+{
+	struct bnxt_ring_struct *ring = &rxr->rx_ring_struct;
+	struct bnxt_napi *bnapi = rxr->bnapi;
+	u32 type = HWRM_RING_ALLOC_RX;
+	u32 map_idx = bnapi->index;
+	int rc;
+
+	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	if (rc)
+		return rc;
+
+	bnxt_set_db(bp, &rxr->rx_db, type, map_idx, ring->fw_ring_id);
+	bp->grp_info[map_idx].rx_fw_ring_id = ring->fw_ring_id;
+
+	return 0;
+}
+
+static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr)
+{
+	struct bnxt_ring_struct *ring = &rxr->rx_agg_ring_struct;
+	u32 type = HWRM_RING_ALLOC_AGG;
+	u32 grp_idx = ring->grp_idx;
+	u32 map_idx;
+	int rc;
+
+	map_idx = grp_idx + bp->rx_nr_rings;
+	rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+	if (rc)
+		return rc;
+
+	bnxt_set_db(bp, &rxr->rx_agg_db, type, map_idx,
+		    ring->fw_ring_id);
+	bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
+	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
+	bp->grp_info[grp_idx].agg_fw_ring_id = ring->fw_ring_id;
+
+	return 0;
+}
+
 static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 {
 	bool agg_rings = !!(bp->flags & BNXT_FLAG_AGG_RINGS);
@@ -6935,24 +7029,21 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 		bnxt_set_db(bp, &txr->tx_db, type, map_idx, ring->fw_ring_id);
 	}
 
-	type = HWRM_RING_ALLOC_RX;
 	for (i = 0; i < bp->rx_nr_rings; i++) {
 		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
-		struct bnxt_ring_struct *ring = &rxr->rx_ring_struct;
-		struct bnxt_napi *bnapi = rxr->bnapi;
-		u32 map_idx = bnapi->index;
 
-		rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+		rc = bnxt_hwrm_rx_ring_alloc(bp, rxr);
 		if (rc)
 			goto err_out;
-		bnxt_set_db(bp, &rxr->rx_db, type, map_idx, ring->fw_ring_id);
 		/* If we have agg rings, post agg buffers first. */
 		if (!agg_rings)
 			bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
-		bp->grp_info[map_idx].rx_fw_ring_id = ring->fw_ring_id;
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 			struct bnxt_cp_ring_info *cpr2 = rxr->rx_cpr;
+			struct bnxt_napi *bnapi = rxr->bnapi;
 			u32 type2 = HWRM_RING_ALLOC_CMPL;
+			struct bnxt_ring_struct *ring;
+			u32 map_idx = bnapi->index;
 
 			ring = &cpr2->cp_ring_struct;
 			ring->handle = BNXT_SET_NQ_HDL(cpr2);
@@ -6966,23 +7057,10 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 	}
 
 	if (agg_rings) {
-		type = HWRM_RING_ALLOC_AGG;
 		for (i = 0; i < bp->rx_nr_rings; i++) {
-			struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
-			struct bnxt_ring_struct *ring =
-						&rxr->rx_agg_ring_struct;
-			u32 grp_idx = ring->grp_idx;
-			u32 map_idx = grp_idx + bp->rx_nr_rings;
-
-			rc = hwrm_ring_alloc_send_msg(bp, ring, type, map_idx);
+			rc = bnxt_hwrm_rx_agg_ring_alloc(bp, &bp->rx_ring[i]);
 			if (rc)
 				goto err_out;
-
-			bnxt_set_db(bp, &rxr->rx_agg_db, type, map_idx,
-				    ring->fw_ring_id);
-			bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
-			bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
-			bp->grp_info[grp_idx].agg_fw_ring_id = ring->fw_ring_id;
 		}
 	}
 err_out:
@@ -7022,6 +7100,50 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
 	return 0;
 }
 
+static void bnxt_hwrm_rx_ring_free(struct bnxt *bp,
+				   struct bnxt_rx_ring_info *rxr,
+				   bool close_path)
+{
+	struct bnxt_ring_struct *ring = &rxr->rx_ring_struct;
+	u32 grp_idx = rxr->bnapi->index;
+	u32 cmpl_ring_id;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	cmpl_ring_id = bnxt_cp_ring_for_rx(bp, rxr);
+	hwrm_ring_free_send_msg(bp, ring,
+				RING_FREE_REQ_RING_TYPE_RX,
+				close_path ? cmpl_ring_id :
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	bp->grp_info[grp_idx].rx_fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
+				       struct bnxt_rx_ring_info *rxr,
+				       bool close_path)
+{
+	struct bnxt_ring_struct *ring = &rxr->rx_agg_ring_struct;
+	u32 grp_idx = rxr->bnapi->index;
+	u32 type, cmpl_ring_id;
+
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+		type = RING_FREE_REQ_RING_TYPE_RX_AGG;
+	else
+		type = RING_FREE_REQ_RING_TYPE_RX;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	cmpl_ring_id = bnxt_cp_ring_for_rx(bp, rxr);
+	hwrm_ring_free_send_msg(bp, ring, type,
+				close_path ? cmpl_ring_id :
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
+}
+
 static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 {
 	u32 type;
@@ -7046,42 +7168,8 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 	}
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
-		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
-		struct bnxt_ring_struct *ring = &rxr->rx_ring_struct;
-		u32 grp_idx = rxr->bnapi->index;
-
-		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
-			u32 cmpl_ring_id = bnxt_cp_ring_for_rx(bp, rxr);
-
-			hwrm_ring_free_send_msg(bp, ring,
-						RING_FREE_REQ_RING_TYPE_RX,
-						close_path ? cmpl_ring_id :
-						INVALID_HW_RING_ID);
-			ring->fw_ring_id = INVALID_HW_RING_ID;
-			bp->grp_info[grp_idx].rx_fw_ring_id =
-				INVALID_HW_RING_ID;
-		}
-	}
-
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		type = RING_FREE_REQ_RING_TYPE_RX_AGG;
-	else
-		type = RING_FREE_REQ_RING_TYPE_RX;
-	for (i = 0; i < bp->rx_nr_rings; i++) {
-		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
-		struct bnxt_ring_struct *ring = &rxr->rx_agg_ring_struct;
-		u32 grp_idx = rxr->bnapi->index;
-
-		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
-			u32 cmpl_ring_id = bnxt_cp_ring_for_rx(bp, rxr);
-
-			hwrm_ring_free_send_msg(bp, ring, type,
-						close_path ? cmpl_ring_id :
-						INVALID_HW_RING_ID);
-			ring->fw_ring_id = INVALID_HW_RING_ID;
-			bp->grp_info[grp_idx].agg_fw_ring_id =
-				INVALID_HW_RING_ID;
-		}
+		bnxt_hwrm_rx_ring_free(bp, &bp->rx_ring[i], close_path);
+		bnxt_hwrm_rx_agg_ring_free(bp, &bp->rx_ring[i], close_path);
 	}
 
 	/* The completion rings are about to be freed.  After that the
-- 
2.43.0


