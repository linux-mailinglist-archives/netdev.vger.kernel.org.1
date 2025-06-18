Return-Path: <netdev+bounces-199100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD7ADEF1C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CD71897CCF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71D2E8E00;
	Wed, 18 Jun 2025 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5InniY9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDC280027;
	Wed, 18 Jun 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256614; cv=none; b=LzMbMWEJ182+UeZfq1fOLZXhwtZVsgOTWlIFAVgTbLlTUT7CEFHoZK01yjy5Xq0pWj0rFyVwG7+VR1cyUIKgLYcPxYkuFryaXOIkYx6n8lBOKaNP5JxgQuXrSMCo2QSIBrWNcZ7SxiW825jYcd9gF6Rd+h/3uYYessPWU9XwZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256614; c=relaxed/simple;
	bh=rrYKoMv7Uk4ch1aZuKLh5PjZvex15SXOuAtOym4MjiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=giGCEI6Ahl9vpyRahWtCKp2/isuSCZ7SaWiZfusG21HxrQ1k1VmzWvCtNWGHBkHy7l+PU0eSpoCjJaFviFAPWCz+OCcZTKNmlHzbOEZ14oOLnKmMkZfm+8hKO/XCSFCgrNiATC1j3i5U9Ilf0x5XVZecuUTwTDwdPe01q4a3l+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5InniY9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4e57d018cso986586f8f.1;
        Wed, 18 Jun 2025 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750256611; x=1750861411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPK0mkTHcO8NLt38PWjFw4lbg65xpQlmO3zLhw4rqDw=;
        b=F5InniY9T7786T4sb5xzV1WNiL8hv1Wspb75EzZiNS25U+87rW08hHh8qOn1tWFCZV
         bEBAXK9VVPuka4ywQnaC0v3XQInjuPrpDnJWpvzPnhCKd3FvbF2rfxASpUrBIFh+JOd2
         o/KjxUu/9JyCCHK/bERNsGiEq/hvgB688P4S6+9rPZ2WfJpDSEqH9mudL1clTO3rBvgz
         5fC+SPg6X91zLdMtzj0NcJPF3PhcjA/lYGLyefo/M8Ro/vOqoSNaW/9LUuyQC5dniAFG
         Et3f1ohuQQa4JSuYIm+QDkgfWyyr//EBgiJ/L0nZqtT+uwO+hvz4zhvGIfSs95eSnIVw
         xP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750256611; x=1750861411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPK0mkTHcO8NLt38PWjFw4lbg65xpQlmO3zLhw4rqDw=;
        b=OnMcPhq1A6cngztTM9qBEPeuyysceVoa4YabjciInBzd7IkLlXB15XepnIllN/iZD4
         LoeoBwSZmgpaXtlfevonQ1OMYGA1Diea3/T/fu9zJKpBOf94ik3nCZ7QmezShmuVAlAt
         3Df/+aK8+RUyGWvWqWmR/dfy1kjgX5M56B+EpiFMtgfs0b+JULc0WiT3Kxg+Il3kbwEd
         SVYK/8Zsa+Fgf6MfdOaY+dHTfN/qicf58GIrRU44VqfcDnIwzFyfG+NeDzWLvLFz3VSe
         60xG7Ka9HgK2Wl+KulDeCe6jE3I5LdbXt6WqGoFyZB0p00nOQ8+/qsNnlqM7RmFgEKKV
         vp8w==
X-Forwarded-Encrypted: i=1; AJvYcCVt/u+AGlPk52lQ23H6IUAYacEB2DA+5ejwxqzy/Dq7H/dDytZjEb3yfhpF7mxCCGjrxhIEH1GqveJDbgc=@vger.kernel.org, AJvYcCVypn1yf8gY6cg71kdUuZSEDvIT9umQFb/iPoB+xmfQdo9wktJR3QhjiZPMkMnbPhnvRHTR7OSw@vger.kernel.org
X-Gm-Message-State: AOJu0YzPkv+rBjj0jmVxTRc6wzMquriodRJG2Zjh2iCHPccAA+BvEvHb
	rhy/jGQVQjNF0e+7o7N9kbNCICjLHhZ8R3V+MvPvFzqOja1AH53trhuy
X-Gm-Gg: ASbGnctRBB6bpjwtrbcWvkwb0KhXgCRIAV9mC3uX9E7Moqgw079rmJq7p/hOfryp3fO
	u3EXxZYqTpLfxd2RBjL3nzzDDFY25wkCgktm+A9IFY40Fnc4kVMV/8DQCK56gACLPFzCJD5J8LU
	Civnx5s1MFDTKZYxQdw9l4TqzRWC9sZzc73GhaUssOMYpYckTgw1qhy7xIwR8b/heE95zlLP7Mn
	22tg+ICEwVa3QpdUGv6hu8cBK328J8Nd81uQ+Al179KSK599bWYW66NV62GHRRmoc3iN90aAWIt
	uKbde0E8m2YjLfNQbrjAa6jLNXehMNmw9lOjXJtG3URiPx5iLwapWLP7dd0/M9aVvNmKdxhReAK
	EXtMA5tXNz7sBhhzH27KF1Tqse3v8w/DDyG4eBb4TKgRhES5odzmLqz1gZrCZPNxnKfBF9tbQBs
	c=
X-Google-Smtp-Source: AGHT+IG7GmVSnOGPPkPDurjvfOGF9vV6K0D4X+LTwcXkzNj+v10cCf/8xwwAPYWXD0cqTToIEYGwog==
X-Received: by 2002:a5d:5849:0:b0:3a3:6a3d:163a with SMTP id ffacd0b85a97d-3a5723adb10mr5201477f8f.12.1750256610510;
        Wed, 18 Jun 2025 07:23:30 -0700 (PDT)
Received: from thomas-precision3591.home (2a01cb00014ec30077ebd188a5e29661.ipv6.abo.wanadoo.fr. [2a01:cb00:14e:c300:77eb:d188:a5e2:9661])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4532de8c229sm207823045e9.6.2025.06.18.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:23:30 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] ethernet: atl1: Add missing DMA mapping error checks
Date: Wed, 18 Jun 2025 16:22:16 +0200
Message-ID: <20250618142220.75936-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `dma_map_XXX()` functions can fail and must be checked using
`dma_mapping_error()`.  This patch adds proper error handling for all
DMA mapping calls.

In `atl1_alloc_rx_buffers()`, if DMA mapping fails, the buffer is
deallocated and marked accordingly.

In `atl1_tx_map()`, previously mapped buffers are unmapped and the
packet is dropped on failure.

Fixes: f3cc28c79760 ("Add Attansic L1 ethernet driver.")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 50 +++++++++++++++++++++---
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index cfdb546a09e7..9b53d87bf6ab 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -1861,14 +1861,21 @@ static u16 atl1_alloc_rx_buffers(struct atl1_adapter *adapter)
 			break;
 		}
 
-		buffer_info->alloced = 1;
-		buffer_info->skb = skb;
-		buffer_info->length = (u16) adapter->rx_buffer_len;
 		page = virt_to_page(skb->data);
 		offset = offset_in_page(skb->data);
 		buffer_info->dma = dma_map_page(&pdev->dev, page, offset,
 						adapter->rx_buffer_len,
 						DMA_FROM_DEVICE);
+		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+			kfree_skb(skb);
+			adapter->soft_stats.rx_dropped++;
+			break;
+		}
+
+		buffer_info->alloced = 1;
+		buffer_info->skb = skb;
+		buffer_info->length = (u16)adapter->rx_buffer_len;
+
 		rfd_desc->buffer_addr = cpu_to_le64(buffer_info->dma);
 		rfd_desc->buf_len = cpu_to_le16(adapter->rx_buffer_len);
 		rfd_desc->coalese = 0;
@@ -2183,8 +2190,8 @@ static int atl1_tx_csum(struct atl1_adapter *adapter, struct sk_buff *skb,
 	return 0;
 }
 
-static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
-	struct tx_packet_desc *ptpd)
+static int atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
+		       struct tx_packet_desc *ptpd)
 {
 	struct atl1_tpd_ring *tpd_ring = &adapter->tpd_ring;
 	struct atl1_buffer *buffer_info;
@@ -2194,6 +2201,7 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	unsigned int nr_frags;
 	unsigned int f;
 	int retval;
+	u16 first_mapped;
 	u16 next_to_use;
 	u16 data_len;
 	u8 hdr_len;
@@ -2201,6 +2209,7 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	buf_len -= skb->data_len;
 	nr_frags = skb_shinfo(skb)->nr_frags;
 	next_to_use = atomic_read(&tpd_ring->next_to_use);
+	first_mapped = next_to_use;
 	buffer_info = &tpd_ring->buffer_info[next_to_use];
 	BUG_ON(buffer_info->skb);
 	/* put skb in last TPD */
@@ -2216,6 +2225,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
 						offset, hdr_len,
 						DMA_TO_DEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+			goto dma_err;
 
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
@@ -2242,6 +2253,9 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 								page, offset,
 								buffer_info->length,
 								DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      buffer_info->dma))
+					goto dma_err;
 				if (++next_to_use == tpd_ring->count)
 					next_to_use = 0;
 			}
@@ -2254,6 +2268,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
 						offset, buf_len,
 						DMA_TO_DEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+			goto dma_err;
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
 	}
@@ -2277,6 +2293,9 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 			buffer_info->dma = skb_frag_dma_map(&adapter->pdev->dev,
 				frag, i * ATL1_MAX_TX_BUF_LEN,
 				buffer_info->length, DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev,
+					      buffer_info->dma))
+				goto dma_err;
 
 			if (++next_to_use == tpd_ring->count)
 				next_to_use = 0;
@@ -2285,6 +2304,22 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 
 	/* last tpd's buffer-info */
 	buffer_info->skb = skb;
+
+	return 0;
+
+ dma_err:
+	while (first_mapped != next_to_use) {
+		buffer_info = &tpd_ring->buffer_info[first_mapped];
+		dma_unmap_page(&adapter->pdev->dev,
+			       buffer_info->dma,
+			       buffer_info->length,
+			       DMA_TO_DEVICE);
+		buffer_info->dma = 0;
+
+		if (++first_mapped == tpd_ring->count)
+			first_mapped = 0;
+	}
+	return -ENOMEM;
 }
 
 static void atl1_tx_queue(struct atl1_adapter *adapter, u16 count,
@@ -2419,7 +2454,10 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 		}
 	}
 
-	atl1_tx_map(adapter, skb, ptpd);
+	if (atl1_tx_map(adapter, skb, ptpd)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
 	atl1_tx_queue(adapter, count, ptpd);
 	atl1_update_mailbox(adapter);
 	return NETDEV_TX_OK;
-- 
2.43.0


