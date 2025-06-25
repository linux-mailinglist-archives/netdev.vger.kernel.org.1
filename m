Return-Path: <netdev+bounces-201189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98751AE860A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC5A6A0C58
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EDA2673BD;
	Wed, 25 Jun 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7L142gl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC02265CB2;
	Wed, 25 Jun 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861042; cv=none; b=Mo9iBfTLD12TWrMp9uRd2FMSOZbTXnK5rIsyrYJxtYHzL2kIVQHvHw5bFY5jF1z6DydhZduEIY0Utet3xHJauq46WXNiYIQGI7MMmZbT4DGvypvojz1dmmNntygfT3HOVxTqTV6292E7VEPE2PQKGz1RY68CPKqn2fLxHNLaIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861042; c=relaxed/simple;
	bh=+GfldJ4gZJGB6dPyzVGJSpSltBFxK3fT2SzfzSOPozM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJXLyUSUvevweCC1hOobbgWPVVZsb7yomJlmSOUYiZiHtBWOlAKNWLHXONdoFi2eyMAX+sY5cyy60szXU5ZzVDWRRtKTsO7Gv0t+gbzn3X+ZFtgVJDmh/HIglCrw5v/l5zCF2h+IijovE/JE+qPsJmsU+pB7TsAfgSIlsY84pFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7L142gl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4eb4dfd8eso986257f8f.2;
        Wed, 25 Jun 2025 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750861038; x=1751465838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r3IMo45Na8Lp/CTW3S/kof3+wzA6MPWzTKCzK0BuB/8=;
        b=N7L142glfIgXdPiURVsQ8BblaUdYB8dqth41hWQkvkR1OY7Q3ileXdfGssUetPd2H7
         OQdR0uDqaBkowzUDFWvdDTSMoz5SnKOU3JILxkLb177BpiOtcKtLU1QGOjnKjiaWHT+l
         snw4Dqqo+nvdOT3UL4/hKGz2IuCuZmWlZEL6mAH6NG9phGVPw1VEvHXjV8FPUQp1LRTA
         LOmkJW6IW3aWc49wFHNgPtkdrA30UUQtP35hZFyby13C/O2lV0dlkDBYqjX7EX/rLRYq
         3/qM/JgKEVbY1YrUqUI79xxjltdXi1t8qpQWvBEV/bQvfVH/XFqN2sOdsuuLeoOpIWD6
         LmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750861038; x=1751465838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3IMo45Na8Lp/CTW3S/kof3+wzA6MPWzTKCzK0BuB/8=;
        b=N4v2xIY+jIcQSZ1P3S4Boc2xnjkOea8R9A08g0tdtBmssgjljk+lY8zf0UOao6X18d
         +HQsWBqxP4/zoQcWWYK7VC/JiSl3yMp6CeNu8VgPnYPxj8+aQcgeJFs7qbF00ODq69rf
         iI7tuv9Njtxu5CRU2dM+fYAEg8N/H4QxycPMcjSwu+L8ZlPhVhNG5zOP7IH5hQYpeRoO
         +cCs47RfnODc4psuVwe7SeTH/OTb3egKUueDvQPWOk9u/Fh1XmaWYSOmymv0n9Xy1VgX
         m9BchJRLYSW4QASk9H7RWJmEKf+X/Dj1lsZn4HJp5z3zZsGHawdb0sFqyOjxyewhT6gz
         gnUg==
X-Forwarded-Encrypted: i=1; AJvYcCUsxZ6UY/snOMnU7r5uMa35MtnugHP6LwWLYpfk3qMZjx2aVhVofBMCGCDl7LdIZS/w6ln4NvgZ@vger.kernel.org, AJvYcCV1SxJ/gu9ByQER/p/RiKer/tUXhsCUSPjPvpfrcevaiiBQbmiTkNUZi1Lc0BV4voNlSM5iIIIIgYKl20E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIeugh0ZsTuQAHlf/vmUTz+SQAvXemSpescWBKtPxky2x3GIEF
	A7E5iR5RkB5c3Xf9zjDk1IZLR/IPa7fOBapcWTUS2XrrbOdHp1prsa9Q
X-Gm-Gg: ASbGncuSW8Oa+SGfX2WvLnUsZyfOuHGtkZY+7uhu7iS7Jr6/whniMVb+S1Ie5f4gGvO
	X+G99VaeiKYyd5GbMcqSpHCtd5z/GC674EGbXS3wcNuJswgwWYZl4nS1DuzV6WVPRC1mKowqI+z
	9C+g1DBOij6MtfJnIDrcLois3HseG0Fk5+i4ealebjsfd6uqxShwxGexuAlUV3elYtKRvy2Ci3X
	0TNllZqo+T21Negy0Wpa1Ul7A+vhA+U8oF0/CFL8KN3YTacYLE2GWgCj30PV/LVzPzMBSM9vrTi
	Nt1flGsfpnE4O5z1Ii2Xe5ZBIcmtOj7pUtwZoR4j8I2j5k/v+3g+btbYMAahuCDAgBCnhuRGQv8
	LZ58Lb55Ott/oevk=
X-Google-Smtp-Source: AGHT+IHndLRQxSH8p69eXB2XsYkfjjNACURFNOcBsbmQyvqS2dPyDaLO3LLfqsG7+PNeed4YB0hhtA==
X-Received: by 2002:a05:6000:250d:b0:3a4:f7ae:7801 with SMTP id ffacd0b85a97d-3a6ed612bb7mr943826f8f.8.1750861037746;
        Wed, 25 Jun 2025 07:17:17 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:96fa:351c:3ff5:5a7f])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4538233c4acsm21059925e9.1.2025.06.25.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 07:17:17 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5] ethernet: atl1: Add missing DMA mapping error checks and count errors
Date: Wed, 25 Jun 2025 16:16:24 +0200
Message-ID: <20250625141629.114984-2-fourier.thomas@gmail.com>
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

If `atl1_xmit_frame()` drops the packet, increment the tx_error counter.

Fixes: f3cc28c79760 ("Add Attansic L1 ethernet driver.")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 79 +++++++++++++++++-------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index cfdb546a09e7..98a4d089270e 100644
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
@@ -2355,10 +2390,8 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 
 	len = skb_headlen(skb);
 
-	if (unlikely(skb->len <= 0)) {
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
+	if (unlikely(skb->len <= 0))
+		goto drop_packet;
 
 	nr_frags = skb_shinfo(skb)->nr_frags;
 	for (f = 0; f < nr_frags; f++) {
@@ -2371,10 +2404,9 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 	if (mss) {
 		if (skb->protocol == htons(ETH_P_IP)) {
 			proto_hdr_len = skb_tcp_all_headers(skb);
-			if (unlikely(proto_hdr_len > len)) {
-				dev_kfree_skb_any(skb);
-				return NETDEV_TX_OK;
-			}
+			if (unlikely(proto_hdr_len > len))
+				goto drop_packet;
+
 			/* need additional TPD ? */
 			if (proto_hdr_len != len)
 				count += (len - proto_hdr_len +
@@ -2406,23 +2438,26 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 	}
 
 	tso = atl1_tso(adapter, skb, ptpd);
-	if (tso < 0) {
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
+	if (tso < 0)
+		goto drop_packet;
 
 	if (!tso) {
 		ret_val = atl1_tx_csum(adapter, skb, ptpd);
-		if (ret_val < 0) {
-			dev_kfree_skb_any(skb);
-			return NETDEV_TX_OK;
-		}
+		if (ret_val < 0)
+			goto drop_packet;
 	}
 
-	atl1_tx_map(adapter, skb, ptpd);
+	if (!atl1_tx_map(adapter, skb, ptpd))
+		goto drop_packet;
+
 	atl1_tx_queue(adapter, count, ptpd);
 	atl1_update_mailbox(adapter);
 	return NETDEV_TX_OK;
+
+drop_packet:
+	adapter->soft_stats.tx_errors++;
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
 }
 
 static int atl1_rings_clean(struct napi_struct *napi, int budget)
-- 
2.43.0


