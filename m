Return-Path: <netdev+bounces-198497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A03ADC6EB
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E771894D59
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3991028F519;
	Tue, 17 Jun 2025 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnSpc5cR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F92135CE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153555; cv=none; b=JwFoSrLNPo+dtYFihSbUoKRZRb/7Y69bXwBMb3W4IJaw8Sy/vlCSsDcxBfCbfkx9QWah4GI4rv906Qm+EMde8+BvLomNhCpmzAEXIl2/OwZ5D54vqltWGaWxizkEMjFwWIwe+37zaLh+AlbRi0p1rk/M2HmHdJUpiKTeizrBIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153555; c=relaxed/simple;
	bh=FTG3vysmZjBSiuhxPTjNxRWCOLBUQueoVeH+pT5jbzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vtl+lojWj/Viaxyv47y40GJAwa/0Yj0I6o8M/MScnM2jrr+L509RAuF0fZqdeSyRvpmXHzFbWd0w38vy9bwRHXssn6cNfitUeo95DisixN8cXCCQsz1eVOw7j4Kqtm7efdQBfSTdnEEZc3OjtIV5NHCaZLVO2L01y2q1rrXN2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnSpc5cR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso5885962b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750153553; x=1750758353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMaKcH2OTjZJu3jxDaO7Jj/PLmOhmTa53JwiymMoy3s=;
        b=FnSpc5cRWZKG3ZycKNTV3Iuw2F5adfwf6O1TYsM+ny7f/UPiFt3P78+sj3gEzs/YV2
         oV0p+CYOKDalnt1agciQEqf0zRofnKPy4wtlMVq7ROh1WEoWm6YFHgxrgq/F50lKL9nl
         dr6wVPLY66YvHaIF3S2FK0fo/DLl2F5H/OJ8ip3otK3HhxBwtwHA5gfF/5XXHMwdsX8g
         Knltjg0DS4uwculynQJgC5/wZxGu6WVeVZ0xC4X0xXxdDMuoMVIgfu0uGzp8Vmqu3umA
         LffDPeXaRq0wuiJeq+WAyjP6aqROI0ffvUsxlpNSs1H8QiCbJTKfEMnYSrW3wkU679nn
         DUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153553; x=1750758353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMaKcH2OTjZJu3jxDaO7Jj/PLmOhmTa53JwiymMoy3s=;
        b=R6XPInfSLLIVgpN1AN7B3R6JMhv/MDbSsPWfa0I1x+T3+QxZyXQb1W3ict7p4kjwVp
         O6vNLOXk8T3HinluU2YY+VNQGYIUoqtf8NwZPILb9xkoCktIqGJo7khgbZoTzkgAj06I
         XXr9wyVve1O9bnHB+Rq9KsSfynt34TVDA/mu9EKCpJuGdIiN1m4eesrb2lgeYmFDR74v
         1eK+9VgmDda0/Idrbk9xKoEhT/nliDkb42rS9E4hbhITOZRFh4M3HXHt5nlGtxmE5llL
         G892E8s006i9FPzwvrQ/MhoUvRcpl3eHl5MMCVWNKKYzVCQ3zpFH0CvjdNE/JjXD7EyZ
         +YzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwpi+ZCQs4eCSPtMd1tt0+ZL3ZiGSzcQEd/2ehSxJpgnIvsEoqxKCFKMeG7xASGy9pzyCtoz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgah+HsUIGwU+RCEChgJE3l5ozWoAx+Giwb1tB2ZcJBpzyQYAC
	hJueLOXO038YskjMMk2FSuWY0/39PUHUs4M6AX+YxQflDjV6g5CNW7PF
X-Gm-Gg: ASbGnctgpnvVwFy70nkh27iV1o/ANgMk+ws5thhMmjtMHufKtOZFKB9gQKCu/hjSuy+
	76xLE1xJTCbYkC1WJcbVS0ryd/q3DqHQKpesv3omcgoeLNNZ7XXuivd/SqK5eS/TCPdLxsWjus/
	vF25Rhe2wCq7LUH7ofuJIITtpTrCg7kNY9iSYPptQETLl9MXwI/TtmrN/67FFQDuS/GYYDCm31Y
	oQGdM2ZCDk2oJcb/fP/1HRF3tZMQAHqk0ARqiWS7H6CI8M/qKt198SBnYg6DW3pzvV2S6TZMnsb
	f3D2CIVnGAGmgktyfYjlnP3MnGdS5EnsUXfqXR3E7BioRNbT4bU=
X-Google-Smtp-Source: AGHT+IHC6C3nFx0qOtOXUxWGGw8UP9VrQnXNMQYFKCS+cTaZcf9w6YdAxILm9X0brCNIHw3MEqG9Ag==
X-Received: by 2002:a05:6a21:9991:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-21fbd5d2f85mr18681250637.38.1750153552581;
        Tue, 17 Jun 2025 02:45:52 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c1esm7090505a12.48.2025.06.17.02.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:45:51 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	almasrymina@google.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [PATCH net-next] eth: bnxt: add netmem TX support
Date: Tue, 17 Jun 2025 09:45:40 +0000
Message-Id: <20250617094540.819832-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netmem_dma_*() helpers and declare netmem_tx to support netmem TX.
By this change, all bnxt devices will support the netmem TX.

bnxt_start_xmit() uses memcpy() if a packet is too small. However,
netmem packets are unreadable, so memcpy() is not allowed.
It should check whether an skb is readable, and if an SKB is unreadable,
it is processed by the normal transmission logic.

netmem TX can be tested with ncdevmem.c

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 ++++++++++++++---------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 869580b6f70d..4de9dc123a18 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -477,6 +477,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct bnxt_tx_ring_info *txr;
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
+	skb_frag_t *frag;
 
 	i = skb_get_queue_mapping(skb);
 	if (unlikely(i >= bp->tx_nr_rings)) {
@@ -563,7 +564,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		lflags |= cpu_to_le32(TX_BD_FLAGS_NO_CRC);
 
 	if (free_size == bp->tx_ring_size && length <= bp->tx_push_thresh &&
-	    !lflags) {
+	    skb_frags_readable(skb) && !lflags) {
 		struct tx_push_buffer *tx_push_buf = txr->tx_push;
 		struct tx_push_bd *tx_push = &tx_push_buf->push_bd;
 		struct tx_bd_ext *tx_push1 = &tx_push->txbd2;
@@ -598,9 +599,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_copy_from_linear_data(skb, pdata, len);
 		pdata += len;
 		for (j = 0; j < last_frag; j++) {
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
 			void *fptr;
 
+			frag = &skb_shinfo(skb)->frags[j];
 			fptr = skb_frag_address_safe(frag);
 			if (!fptr)
 				goto normal_tx;
@@ -708,8 +709,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
 	txbd0 = txbd;
 	for (i = 0; i < last_frag; i++) {
-		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-
+		frag = &skb_shinfo(skb)->frags[i];
 		prod = NEXT_TX(prod);
 		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
 
@@ -721,7 +721,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			goto tx_dma_error;
 
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
-		dma_unmap_addr_set(tx_buf, mapping, mapping);
+		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), tx_buf,
+					  mapping, mapping);
 
 		txbd->tx_bd_haddr = cpu_to_le64(mapping);
 
@@ -778,9 +779,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	for (i = 0; i < last_frag; i++) {
 		prod = NEXT_TX(prod);
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
-		dma_unmap_page(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
-			       skb_frag_size(&skb_shinfo(skb)->frags[i]),
-			       DMA_TO_DEVICE);
+		frag = &skb_shinfo(skb)->frags[i];
+		netmem_dma_unmap_page_attrs(&pdev->dev,
+					    dma_unmap_addr(tx_buf, mapping),
+					    skb_frag_size(frag),
+					    DMA_TO_DEVICE, 0);
 	}
 
 tx_free:
@@ -3422,9 +3425,11 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
 
 			tx_buf = &txr->tx_buf_ring[ring_idx];
-			dma_unmap_page(&pdev->dev,
-				       dma_unmap_addr(tx_buf, mapping),
-				       skb_frag_size(frag), DMA_TO_DEVICE);
+			netmem_dma_unmap_page_attrs(&pdev->dev,
+						    dma_unmap_addr(tx_buf,
+								   mapping),
+						    skb_frag_size(frag),
+						    DMA_TO_DEVICE, 0);
 		}
 		dev_kfree_skb(skb);
 	}
@@ -16713,6 +16718,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	dev->request_ops_lock = true;
+	dev->netmem_tx = true;
 
 	rc = register_netdev(dev);
 	if (rc)
-- 
2.34.1


