Return-Path: <netdev+bounces-200185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B840AE39DF
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 11:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12643A2A54
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C181F4180;
	Mon, 23 Jun 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io6HkQ4a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF192A1C9;
	Mon, 23 Jun 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670528; cv=none; b=cebYUkjAPeAelu420Bzc0+5wAWs4J+P4JfkUyQPz4raOQSDZoyrqAiY6IHHb4WzN0KTyEE8QQGCiaRD5I/Rb5t6ZlSBib7JcnfpKGxupb5VT0xKYpT3beNaUcdS3X9XeBBLx08g0te+ncI5rfKGt/NpkGBHS9MIBYJIZ8sABykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670528; c=relaxed/simple;
	bh=LKOQTHFLkGOEn2/HNDR4sepDciJkKfrXrB/C0bwWauU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=feaUfwKj7E1MYUMK35Id64xg1SbNynD+I4PfGWVztyJ9dgp1GdFBJPSNyJCTI1AtvlGBSn/jRdFWAoEdrA1RmedHiPEXjgwsIpMX4a/FZDaTTtnCmC0z5jcb45Y9w3FAXnrwAuf1SucX2wP3EmB8E6NyGoYRMoGq88Jbyk77jF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io6HkQ4a; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a5828d26e4so622853f8f.0;
        Mon, 23 Jun 2025 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750670524; x=1751275324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdyJ8ZnuU6TNQuoElRBiY5EvytdD44pmPL2MXO1PBwU=;
        b=Io6HkQ4aLcs8uV6A5L/mbn8psXZeUH8oT2P/A9oxgJPsNtIdf4bvBMFEt33+RIGZ3A
         khTJFvSADS5cELjiyJ43lcjg8O+aUPpjuVzW/W1ma4HvlD7g0/UwdhtAD5EzxzJXoVgV
         wBav7j+zd0JxqZjnVnsUlDl/t6/tTCwCKZtRGcDH2Cu9NBb/Fd7r9rkwmx6fDEf6JMkn
         vFvMieqsM/Z8Q8wWRrakjPgBeqx5cjRIJ9+2pyowZf/IG9XKWXvFq4X1ZMOQ0s7QY3Yj
         zsttWx3dE5kApnFQ/HleXMaEh5n/pz+DTwuTcl9p55zsd0rS29XwonjDUoRZ4p7TRZwm
         xtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750670524; x=1751275324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdyJ8ZnuU6TNQuoElRBiY5EvytdD44pmPL2MXO1PBwU=;
        b=Y7CnzY7NMz04GBfRL0gaRPws+4uFhEvNcK9sSaCnRe81TbBaKeXcnzU/zooUNL+U7N
         Y8TP6XrQhDVvLRcaSfoXWZZA/U4Yg1vfbErBJtiRrlfdWH/3+hZJN8ZbqrTunRkk9ogS
         hxYmVW87T2mQdYep71dLFPWGsZWZnAwxAS2ic0UlFiJbJJKVfHS/0cUmtPTPlnfBDKkD
         HO/8nM5A68cImZ5QcdgI/E8Ou1Wk4Uyafyv7S2tpnJBKZeUE27DcVYfy3vcGwdgz4fxa
         icHX6rh14br2IomAjU61c21M6R3JBZ2hAD5vwvxRUwmoSJpWgcz1he6RUpLjLh8NSorY
         6rnw==
X-Forwarded-Encrypted: i=1; AJvYcCVTgJiRr/lHYVmBwBpIrSwQwJ/ZCZh3CVqznmJTjIcQ5wiIO28TVqzPGjSFl4bOxUAuj2p1mBIBflWjqGw=@vger.kernel.org, AJvYcCXXjFedSpfkj5pi5nZyiisOJzoi82HEBngkocZTlTT1D6LFi3XvyGR63pJQxct/YekBxq3uMtVW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/uz8jmCaGMBL9wvV/DL72IpC6Zha41LRns26OaU12erUnmkQu
	Bi83cn5FTr0CG0m0QWoBCPXa6U1TTpgF44E//p6SdFCSNmo/msPe/5h2
X-Gm-Gg: ASbGncv0jgWAuJGCKBbh2259s/8nEDn2XWRuYzOirQ49Gp/QAqQ7nYhu7EQ1iDaLuQz
	FOPR0cXk24IGimAL1yR/c4BxMiIC9eE5sqDN7EdwzgStWLGw2QzLrmH9fCEH/iuE1PG+l6eTvtI
	slM+RnAYTzy/9ZfhtxiwIcgF+zfLZIgAr0Zaf2Fd+JcUOvM3jSj0L0AmxcVGYB13cKCmK9rmiU8
	K2NKO7dNbPx6QEyNU/F54ktRKwgWhXpmfCclEIimRzoUdp859jaCZBJUNzGfsVpyV4Eu5DdTrtL
	ZUZ8G/FUeiim85VQhdThQlEYhGSTd9zuBPdYAEZQ+JZF8Gs894eUSxF0iHQvyL1jfPi7C9hFU7a
	EsyHQ9P2rikJLu8k=
X-Google-Smtp-Source: AGHT+IHI4iJk98aQylTy7xgmiMADjM1C7FONOox53GQ9Z3mCtDzq+VrQVxZf7+pK6pdvcO6dbEs38A==
X-Received: by 2002:a05:6000:40c9:b0:3a4:eeeb:7e70 with SMTP id ffacd0b85a97d-3a6d12dfaf2mr3372304f8f.4.1750670524362;
        Mon, 23 Jun 2025 02:22:04 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:9a26:612f:7b52:ee76])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a6d117c40dsm9121182f8f.65.2025.06.23.02.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:22:03 -0700 (PDT)
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
Subject: [PATCH net v4] ethernet: atl1: Add missing DMA mapping error checks
Date: Mon, 23 Jun 2025 11:20:41 +0200
Message-ID: <20250623092047.71769-1-fourier.thomas@gmail.com>
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
index cfdb546a09e7..5e5bf40e62f6 100644
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
+static bool atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
+			struct tx_packet_desc *ptpd)
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
+	return true;
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
+	return false;
 }
 
 static void atl1_tx_queue(struct atl1_adapter *adapter, u16 count,
@@ -2419,7 +2454,10 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 		}
 	}
 
-	atl1_tx_map(adapter, skb, ptpd);
+	if (!atl1_tx_map(adapter, skb, ptpd)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
 	atl1_tx_queue(adapter, count, ptpd);
 	atl1_update_mailbox(adapter);
 	return NETDEV_TX_OK;
-- 
2.43.0


