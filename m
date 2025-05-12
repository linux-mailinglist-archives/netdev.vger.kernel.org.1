Return-Path: <netdev+bounces-189711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C554AB349D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF64D189C7A5
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D570805;
	Mon, 12 May 2025 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0AVZguy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016136C;
	Mon, 12 May 2025 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044946; cv=none; b=QZ+TQavdD9jqepbikKW2kZRWFJ3KAVZFNG021ZXdBgHdGrXTU9uJVpp1aorNeTdxrGyu/U16+daa27M8Kli82YaDkxw4tHcDtxf2AdAv5Dl613kL0Cp9iK5YDdoME59Og1xlIqjaefApZux5HKlEbN2XQStjiCyTUDi5OdpWvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044946; c=relaxed/simple;
	bh=YEVzF/4RhjzwytVvw9iWfdQD/vyZMyC3yGPu2a4DCkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QNgJDKXL9xmuhNnEShpu/E/B0S7rW3MemoDBJgE5OEfHoii7eCdKDjsAMdwxygzcK7H9/lIRWoBDT8O14byW3QdEthUkXnlJRGlW+Mo3YMEoWiQpx1YX/AgWAXZbhs8duIcEsPXeuTzLZ5DeTk6CoY1fKtH18r+ZojMfccq+IXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0AVZguy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad24ee085a8so164340766b.0;
        Mon, 12 May 2025 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747044943; x=1747649743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlOkLKKLO78ZMSCYDMZCAd10hMDoDs86MSNcBVk2Ats=;
        b=F0AVZguyxmCpmCtrgYijgmXB40/3iKKqKh27pekprEfS13dD6hGhhuZ5V+cvODYVYD
         oySBQvrr0py2s7LIj7+XrNKb9lrmdmrB8Ch1Mq1VdSdyK0nBPvEub+W17kHDnESWC5Y8
         g34Y65pSxYcSDNpL2GhsmnEidDbQ2vsbklwNmJsJS52mupvQKVzUCTF632aabCTVolJv
         19VLaJDIIdoQ1VqHttXw8hnmpGdvrApgGGANecejWGypLtt1Xb3LoCtm0vOzFz1Y1XOM
         G1FJi8XnkH2NbwCqMnlPenwBXsI+3BRg5W5BLg4U2P7Ivj1Of8FFlfHPgiZmcgETSOtP
         JStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747044943; x=1747649743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlOkLKKLO78ZMSCYDMZCAd10hMDoDs86MSNcBVk2Ats=;
        b=wuLBODa/ZFNWgOPCMrYhkhs1L++JziQ7Wy+toliFkL4VWMnsXTTqQIUvkvylFyS0us
         oYFOGbSxRhfwC4JqoUHUFGVkWJlWomrfApUa9w9NGxNLcqglX/vzejnZjKoBDX+AWya3
         eyjgBL+qpHcftqPooOQhS5Q+p5P3ihhQlJ9BbPv57u2K/6yvUo6pJCu1k6b4LsvH2iqO
         S5YtYzYlTAVY2mCg8SsVmnX64AKD6TyxRjgb+ibVWIbEXNxwtfrd+QB1g4yAhJDnXJdb
         xbGGBWZmWx95vpGVPJCc4KfGcWNPFV0BTU4ZtRZG+2ONNGKhMhpGEWbd7vPfQsM8zopI
         yadg==
X-Forwarded-Encrypted: i=1; AJvYcCWBEkbmAySrmalwxLGaInczISo9uesM4ejPn54qwK4/Ez2WLUGnKnPk4bHWuG4f4L86/8cIqBHqYKECHVI=@vger.kernel.org, AJvYcCX2cBRqzTpgVIvVwmb9R1LLDzWGNuO0I8fXgAonC1Lh0jN/m4C9YHeM8ubPIpRbnXpu8ndDN0g3@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2rs+vSVC3u6NDZs5eJqFAibR0ngxH82gHRJP6MWIzb84kPn5
	5ePAMm+yljVGUBhjKhiYoqiLlPmrmq+4bS7wKwGn7/W4JHY9OdNy
X-Gm-Gg: ASbGncu4SC48oxa/JlJyKliNMdJjSUWq2gvTcP7YdcDZ37RzfNJXIjiEc5N+gUIYpds
	HXUZSo5Rjj6G35n8L+7Syh8xzHwvO4WXnB0MQL0DeeC1uGvgu742VfIPbDY98qZeWSl/ehd1yfq
	0Js4Dh3+g4c/nsUr+5YkIAmepQ1gN4TWRgUkoDc9qsecRqndmUZ5VUZlAqXEyqErdpTmtyzXkJc
	mgGwj9nHgMXZba59v1UqCOeszOrixVbmJpDo09wDp6hUSJUNmY4SnnoVHBkHSEY+fKxyVkd0UhM
	F6UJ3b4BQ/QFUYMkprYv95euNIH+mucVwx9tZoaJg4eTKtgXtOQD9aifAKF1iw==
X-Google-Smtp-Source: AGHT+IHl8UycOLOMTfznPcamDojkGMvURWHkUedJ21DOo4ra8aV9W4b6j0uwidMFP5+ZW4JFdQ04jw==
X-Received: by 2002:a17:907:a0ca:b0:acb:7105:61a5 with SMTP id a640c23a62f3a-ad218fef523mr1319402166b.32.1747044942579;
        Mon, 12 May 2025 03:15:42 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cd03:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad22a3a1501sm473051866b.121.2025.05.12.03.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 03:15:42 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
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
Subject: [PATCH v2] net: bcmgenet: tidy up stats, expose more stats in ethtool
Date: Mon, 12 May 2025 11:15:20 +0100
Message-Id: <20250512101521.1350-1-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch exposes more statistics counters in ethtool and tidies up the
counters so that they are all per-queue. The netdev counters are now only
updated synchronously in bcmgenet_get_stats instead of a mix of sync/async
throughout the driver. Hardware discarded packets are now counted in their
own missed stat instead of being lumped in with general errors.

Changes in v2:
- Remove unused variable
- Link to v1: https://lore.kernel.org/all/20250511214037.2805-1-zakkemble%40gmail.com

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 88 +++++++++++++++----
 .../net/ethernet/broadcom/genet/bcmgenet.h    | 10 +++
 2 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 73d78dcb7..77fa08878 100644
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
+	unsigned long multicast = 0;
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
@@ -3532,15 +3569,34 @@ static struct net_device_stats *bcmgenet_get_stats(struct net_device *dev)
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


