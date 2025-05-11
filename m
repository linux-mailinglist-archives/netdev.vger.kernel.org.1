Return-Path: <netdev+bounces-189600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A48AB2BA6
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 23:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175DA3B67EE
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 21:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28A725C70A;
	Sun, 11 May 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxM2b1hZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5D1E9B0B;
	Sun, 11 May 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746999661; cv=none; b=W70f9yjX8b2a1OmmWv+LnLrxrn7GOqBDm01R/9B/hTnrr1kPuQapB1q12+6Ome2DzN0SB8ku/UCZpv0yMnD0JQlMMoILc4GQwlAY6/0WDOdQ1F6g6YMQYmXmRrp+xQaUHvSEcO9S33Istqy4w5ZqZNamBXBnlK+GsmF7nxW8its=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746999661; c=relaxed/simple;
	bh=m5YqWs3A+JJxDq/2ebw9Aqpwy9KmfxthvlW6q+0Jdko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=toChMjOHLn5zRzvJPQ+njfoVU7R55FGwccGSS/qtczb+pdSbhIWT6SvSNy10vvPAP4Os+eUFKBf7YZ2G5SOuechElbYXKBJp5WwSVUUGlTDyw258i4NRET7sXBHF76cQwwfzKkydTFCo6MlJbAwOiMrYLmM324utUgNe2CAn70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxM2b1hZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad2440926adso155807466b.1;
        Sun, 11 May 2025 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746999658; x=1747604458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CueOPRpV/a77O5bokU3d6RkibO4gTHAeRmkprjLnfVc=;
        b=dxM2b1hZVAT0M7n8hRtt2Uq7ui0+lYznEMPVeNlw7EwfzG2YEeWftJIKftBwZKmYBd
         UE6r2niLZ5eTnz2k399TdT3aA38eEkfGPFNkFlV5eHPYqjqVZZ4VyrKOikZ4Le7zGcb/
         ZGD3ThwO7uKgZyFOhknRKau3x+qXWTo7in9wR8gzr10YKegpJg6L1pK6QANpj0Y+3ZC2
         5ZobuZdX2GQIM4Z7DXD3jMPeT42Hwv9+lCUdKOjTIWPBIax92x2yJYY5p2K+rC/T+kkz
         p9fPiwIVOHmN+T/mKifjz6NKfSRnpH0bT9+gq+h9Gxh91HrZahXNE3H08RcbRiXAT1nP
         bubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746999658; x=1747604458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CueOPRpV/a77O5bokU3d6RkibO4gTHAeRmkprjLnfVc=;
        b=wPrB6qz7QYsTLgLyb38+hOAd4gOS5sfF1DEixqnvP8oXSwEtLxFwHeoOSq6c861W91
         BARh3utsa9jGMYuT+gqyOCv5hfQDPDjP5sexubBhYWOkkOB86Lg2BOafRhiTUUi1A4cO
         iAptkUO+alZ7OfDvlr7eEfshxtNyOCVTmY9GmI1IE5dBYDIpAwUNWqSL+cn/QGom2JkW
         25f27rr5rfmVX/iOWhvQ+pI06d0X32JxBSwGT+eHP5drQMXkISIKs4GL6UQN1g+khrN6
         51cf6pXAlvUgvzAJ3nHAwnBT082/n21HnA9mTu+AbRLvt6reOfMJC46ORZLTB3iI809y
         Qcjg==
X-Forwarded-Encrypted: i=1; AJvYcCURr/fQpA6uI7F6M5eGQV7fk6u10Nn1UdiRvtIwCDqFP/l9VFQnHlcsyXFsoyu4zSSoyFMUmTEV2KW6DVI=@vger.kernel.org, AJvYcCUoye6ziZXkLtzK1+f8wdMouoEL7tlmZGTyD1VQ1KSTPdyHk0g+M2ib1xovbBKRGKe6VvJCeTWG@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+YJPKlKBgbt5BtWUeyoiaUHvmJX6uVhWG65qv8xyJl6d5ia9
	xTZXbx87LkrBevl1/cCN+YOX87ZlgQPr+Daxjp3/uGVupP+iBmlw
X-Gm-Gg: ASbGncsfH9/IZuQQzrzwdQ/hStE6i8YkG3WbhGHuNkeLupaRC+f88ELZnqaRSUdf4/S
	nTroVit3NgXolQTiYT3MtDSFwTPPke1fLiCPFe7FdtgipuGvpHvtFSFCw/x/Op4JNGSVDoBHGK2
	bKoWN5+LF0x1RYy5uq1RSDujXNAc/VJMFvqJ/qqYkIaytNsEEeS0nEWFIEMvxdg1gqmq0PFUIQ0
	94NsYFIVXVc9TVYTlGoPFyDCgJUov17eUvW0ThEUhJW8nKuN2mh6xmv5tIl2fidMlfzXE3Qvi4t
	qLtDLLskRwbkzVnPqPhOVe6xrIV2x8mhWdxPokqimGLhVraAbTjaOstsIyygc9BmWxRSb+z/
X-Google-Smtp-Source: AGHT+IGyn0ofLXJZjQCGtVxaifRfN0pWuzdUCoxClKekA4d7icx5aqxy2DGVpXDrT6uOJWc9eT5QEw==
X-Received: by 2002:a17:907:8a8f:b0:ad2:313f:f550 with SMTP id a640c23a62f3a-ad23140714emr635144166b.29.1746999657796;
        Sun, 11 May 2025 14:40:57 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cd03:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2193495bdsm523315866b.70.2025.05.11.14.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 14:40:57 -0700 (PDT)
From: zakkemble@gmail.com
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH] net: bcmgenet: tidy up stats, expose more stats in ethtool
Date: Sun, 11 May 2025 22:40:36 +0100
Message-Id: <20250511214037.2805-1-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zak Kemble <zakkemble@gmail.com>

This patch exposes more statistics counters in ethtool and tidies up the
counters so that they are all per-queue. The netdev counters are now only
updated synchronously in bcmgenet_get_stats instead of a mix of sync/async
throughout the driver. Hardware discarded packets are now counted in their
own missed stat instead of being lumped in with general errors.

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 89 +++++++++++++++----
 .../net/ethernet/broadcom/genet/bcmgenet.h    | 10 +++
 2 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 73d78dcb7..c395a071a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1018,6 +1018,8 @@ struct bcmgenet_stats {
 			tx_rings[num].packets), \
 	STAT_GENET_SOFT_MIB("txq" __stringify(num) "_bytes", \
 			tx_rings[num].bytes), \
+	STAT_GENET_SOFT_MIB("txq" __stringify(num) "_errors", \
+			tx_rings[num].errors), \
 	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_bytes", \
 			rx_rings[num].bytes),	 \
 	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_packets", \
@@ -1025,7 +1027,23 @@ struct bcmgenet_stats {
 	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_errors", \
 			rx_rings[num].errors), \
 	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_dropped", \
-			rx_rings[num].dropped)
+			rx_rings[num].dropped), \
+	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_multicast", \
+			rx_rings[num].multicast), \
+	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_missed", \
+			rx_rings[num].missed), \
+	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_length_errors", \
+			rx_rings[num].length_errors), \
+	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_over_errors", \
+			rx_rings[num].over_errors), \
+	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_crc_errors", \
+			rx_rings[num].crc_errors), \
+	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_frame_errors", \
+			rx_rings[num].frame_errors), \
+	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_fragmented_errors", \
+			rx_rings[num].fragmented_errors), \
+	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_broadcast", \
+			rx_rings[num].broadcast)
 
 /* There is a 0xC gap between the end of RX and beginning of TX stats and then
  * between the end of TX stats and the beginning of the RX RUNT
@@ -1046,6 +1064,11 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
 	STAT_NETDEV(rx_dropped),
 	STAT_NETDEV(tx_dropped),
 	STAT_NETDEV(multicast),
+	STAT_NETDEV(rx_missed_errors),
+	STAT_NETDEV(rx_length_errors),
+	STAT_NETDEV(rx_over_errors),
+	STAT_NETDEV(rx_crc_errors),
+	STAT_NETDEV(rx_frame_errors),
 	/* UniMAC RSV counters */
 	STAT_GENET_MIB_RX("rx_64_octets", mib.rx.pkt_cnt.cnt_64),
 	STAT_GENET_MIB_RX("rx_65_127_oct", mib.rx.pkt_cnt.cnt_127),
@@ -1983,7 +2006,8 @@ static void bcmgenet_tx_reclaim_all(struct net_device *dev)
  * the transmit checksum offsets in the descriptors
  */
 static struct sk_buff *bcmgenet_add_tsb(struct net_device *dev,
-					struct sk_buff *skb)
+					struct sk_buff *skb,
+					struct bcmgenet_tx_ring *ring)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct status_64 *status = NULL;
@@ -2001,7 +2025,7 @@ static struct sk_buff *bcmgenet_add_tsb(struct net_device *dev,
 		if (!new_skb) {
 			dev_kfree_skb_any(skb);
 			priv->mib.tx_realloc_tsb_failed++;
-			dev->stats.tx_dropped++;
+			ring->dropped++;
 			return NULL;
 		}
 		dev_consume_skb_any(skb);
@@ -2089,7 +2113,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	GENET_CB(skb)->bytes_sent = skb->len;
 
 	/* add the Transmit Status Block */
-	skb = bcmgenet_add_tsb(dev, skb);
+	skb = bcmgenet_add_tsb(dev, skb, ring);
 	if (!skb) {
 		ret = NETDEV_TX_OK;
 		goto out;
@@ -2253,7 +2277,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		   DMA_P_INDEX_DISCARD_CNT_MASK;
 	if (discards > ring->old_discards) {
 		discards = discards - ring->old_discards;
-		ring->errors += discards;
+		ring->missed += discards;
 		ring->old_discards += discards;
 
 		/* Clear HW register when we reach 75% of maximum 0xFFFF */
@@ -2306,8 +2330,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 
 		if (unlikely(len > RX_BUF_LENGTH)) {
 			netif_err(priv, rx_status, dev, "oversized packet\n");
-			dev->stats.rx_length_errors++;
-			dev->stats.rx_errors++;
+			ring->length_errors++;
 			dev_kfree_skb_any(skb);
 			goto next;
 		}
@@ -2315,7 +2338,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		if (unlikely(!(dma_flag & DMA_EOP) || !(dma_flag & DMA_SOP))) {
 			netif_err(priv, rx_status, dev,
 				  "dropping fragmented packet!\n");
-			ring->errors++;
+			ring->fragmented_errors++;
 			dev_kfree_skb_any(skb);
 			goto next;
 		}
@@ -2329,14 +2352,19 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 			netif_err(priv, rx_status, dev, "dma_flag=0x%x\n",
 				  (unsigned int)dma_flag);
 			if (dma_flag & DMA_RX_CRC_ERROR)
-				dev->stats.rx_crc_errors++;
+				ring->crc_errors++;
 			if (dma_flag & DMA_RX_OV)
-				dev->stats.rx_over_errors++;
+				ring->over_errors++;
 			if (dma_flag & DMA_RX_NO)
-				dev->stats.rx_frame_errors++;
+				ring->frame_errors++;
 			if (dma_flag & DMA_RX_LG)
-				dev->stats.rx_length_errors++;
-			dev->stats.rx_errors++;
+				ring->length_errors++;
+			if ((dma_flag & (DMA_RX_CRC_ERROR |
+						DMA_RX_OV |
+						DMA_RX_NO |
+						DMA_RX_LG |
+						DMA_RX_RXER)) == DMA_RX_RXER)
+				ring->errors++;
 			dev_kfree_skb_any(skb);
 			goto next;
 		} /* error packet */
@@ -2359,7 +2387,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		ring->packets++;
 		ring->bytes += len;
 		if (dma_flag & DMA_RX_MULT)
-			dev->stats.multicast++;
+			ring->multicast++;
+		else if (dma_flag & DMA_RX_BRDCAST)
+			ring->broadcast++;
 
 		/* Notify kernel */
 		napi_gro_receive(&ring->napi, skb);
@@ -3420,7 +3450,7 @@ static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
 
 	netif_trans_update(dev);
 
-	dev->stats.tx_errors++;
+	priv->tx_rings[txqueue].errors++;
 
 	netif_tx_wake_all_queues(dev);
 }
@@ -3513,8 +3543,13 @@ static struct net_device_stats *bcmgenet_get_stats(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	unsigned long tx_bytes = 0, tx_packets = 0;
+	unsigned long tx_errors = 0, tx_dropped = 0;
 	unsigned long rx_bytes = 0, rx_packets = 0;
 	unsigned long rx_errors = 0, rx_dropped = 0;
+	unsigned long rx_missed = 0, rx_length_errors = 0;
+	unsigned long rx_over_errors = 0, rx_crc_errors = 0;
+	unsigned long rx_frame_errors = 0, rx_fragmented_errors = 0;
+	unsigned long multicast = 0, broadcast = 0;
 	struct bcmgenet_tx_ring *tx_ring;
 	struct bcmgenet_rx_ring *rx_ring;
 	unsigned int q;
@@ -3523,6 +3558,8 @@ static struct net_device_stats *bcmgenet_get_stats(struct net_device *dev)
 		tx_ring = &priv->tx_rings[q];
 		tx_bytes += tx_ring->bytes;
 		tx_packets += tx_ring->packets;
+		tx_errors += tx_ring->errors;
+		tx_dropped += tx_ring->dropped;
 	}
 
 	for (q = 0; q <= priv->hw_params->rx_queues; q++) {
@@ -3532,15 +3569,35 @@ static struct net_device_stats *bcmgenet_get_stats(struct net_device *dev)
 		rx_packets += rx_ring->packets;
 		rx_errors += rx_ring->errors;
 		rx_dropped += rx_ring->dropped;
+		rx_missed += rx_ring->missed;
+		rx_length_errors += rx_ring->length_errors;
+		rx_over_errors += rx_ring->over_errors;
+		rx_crc_errors += rx_ring->crc_errors;
+		rx_frame_errors += rx_ring->frame_errors;
+		rx_fragmented_errors += rx_ring->fragmented_errors;
+		multicast += rx_ring->multicast;
+		broadcast += rx_ring->broadcast;
 	}
 
+	rx_errors += rx_length_errors;
+	rx_errors += rx_crc_errors;
+	rx_errors += rx_frame_errors;
+	rx_errors += rx_fragmented_errors;
+
 	dev->stats.tx_bytes = tx_bytes;
 	dev->stats.tx_packets = tx_packets;
+	dev->stats.tx_errors = tx_errors;
+	dev->stats.tx_dropped = tx_dropped;
 	dev->stats.rx_bytes = rx_bytes;
 	dev->stats.rx_packets = rx_packets;
 	dev->stats.rx_errors = rx_errors;
-	dev->stats.rx_missed_errors = rx_errors;
 	dev->stats.rx_dropped = rx_dropped;
+	dev->stats.rx_missed_errors = rx_missed;
+	dev->stats.rx_length_errors = rx_length_errors;
+	dev->stats.rx_over_errors = rx_over_errors;
+	dev->stats.rx_crc_errors = rx_crc_errors;
+	dev->stats.rx_frame_errors = rx_frame_errors;
+	dev->stats.multicast = multicast;
 	return &dev->stats;
 }
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 10c631bbe..429b63cc6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -517,6 +517,8 @@ struct bcmgenet_tx_ring {
 	struct napi_struct napi;	/* NAPI per tx queue */
 	unsigned long	packets;
 	unsigned long	bytes;
+	unsigned long	errors;
+	unsigned long	dropped;
 	unsigned int	index;		/* ring index */
 	struct enet_cb	*cbs;		/* tx ring buffer control block*/
 	unsigned int	size;		/* size of each tx ring */
@@ -544,6 +546,14 @@ struct bcmgenet_rx_ring {
 	unsigned long	packets;
 	unsigned long	errors;
 	unsigned long	dropped;
+	unsigned long	multicast;
+	unsigned long	missed;
+	unsigned long	length_errors;
+	unsigned long	over_errors;
+	unsigned long	crc_errors;
+	unsigned long	frame_errors;
+	unsigned long	fragmented_errors;
+	unsigned long	broadcast;
 	unsigned int	index;		/* Rx ring index */
 	struct enet_cb	*cbs;		/* Rx ring buffer control block */
 	unsigned int	size;		/* Rx ring size */
-- 
2.39.5


