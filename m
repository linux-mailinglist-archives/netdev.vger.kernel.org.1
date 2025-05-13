Return-Path: <netdev+bounces-190179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D591AB5768
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D98171FCD
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B30298991;
	Tue, 13 May 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSszfGQs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8B255E2B;
	Tue, 13 May 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147305; cv=none; b=O/FfxvFBCDbDvD9XoWSXJhlDQ6HvcFf+SET1qZwvCM3/S2jVHYI+5bVErF5qg+QXKeWf71FGRsveqOzzEp5g88pngVfajWqn+J646d945XyWbXFWrBZB4537AiN3u/Q3vQ4dv2tBEAOSs0oAz3/p1+wdFUZ41rzHX9y9QRZ6H/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147305; c=relaxed/simple;
	bh=lXIupedkAwdhkbPaYwqYzVsmNDKrY17anDrGj9I0iVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=keCGyE5k7PMB4JHI2ilkJT8rgRo6ktOV7AOcdBw5S8L8e+qcnL4ZaJNvGSlLgqJh8Lp/KyWFi/G8h/x5rLf/KsDd0H4CGbZRV5HTRencOymc6WE11jZ0k+n6MDZ22zfer6XPjLZlO/0hnUoTCOyL8rj0KM8qfJELaUe9cU0Ohys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSszfGQs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad220f139adso741261766b.1;
        Tue, 13 May 2025 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747147301; x=1747752101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXKdZ1JxtICE+bq1htmlKHTvOuap/JS5mHr73NItHeU=;
        b=MSszfGQs1pWC7kaIfeG70QKWBMwBKo0iS8gY1yGI+QLTKP12xDhQic1AaLd3pSuE1f
         X/7Efd4viAFP263dIrUkn/80LuIeLIRebcSHEQuBa1ctDRV3KP0Vgu4gRm7Zeqbg1AOi
         WelaM7r8eOyvQlQqFizN46h+ckXVweetc1txj1RB/yHzGPZZWMkFf2mb8M4tbX0yXGxp
         lG6Vt17id2okiFSl44i+z/9RvWSoKzPLTVKZMAxRO8FOyauQvgSwm3CP34/MIE7XIPh9
         cFon4Z2/zgaeKaeZEPZFRiZ6zo7r3761gGv6XNBg3Zy2yN8uiy1TZYgIog9GwL1nRxfw
         zeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147301; x=1747752101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXKdZ1JxtICE+bq1htmlKHTvOuap/JS5mHr73NItHeU=;
        b=ahPj6BpZ27p+KoA7eWH5vQt0muQxzj5/fMwBMtjewF0I51Qy2W/mK5MnibnW6fw/bu
         +Ip8UvKYlJaIwlblHsinYRWsbS3PJUZryl7b1MFRDxGoxNpJYeDtkYM/ONXsP1qRRbsV
         F7Qe9edGumOhNWEqt0wzP6Rmmek6PaNAGJ1wJl9vFKelPNg34FYzDMc8n+tUecq1/Iju
         Z4epNtV6EVZ1s1qewIQfRanDwV4kRuuU4s6ftiAtpfCWFX7g6j3xs1S60mNEpICc4jD5
         F2eGrMlTsBd6vVS13eLSomlFwMsxDE/O/4beLiHnjD4JPQE2fXIWfigB56DpyCj0JnHn
         AHyw==
X-Forwarded-Encrypted: i=1; AJvYcCV6qrBrsyaOzJD+C1opbK3HQpRI2FiaQBmWJh67SxDa5xwTt4pYkVUUAC2MWVWG9PBjZkKNQF7BUj7uLw0=@vger.kernel.org, AJvYcCWORYxbGe1x8stQNp6tLlC1UUF9PYQMXUfEm40gt3/rjti4CzeJd4wYjWs8U9CbDTooxMe/toJs@vger.kernel.org
X-Gm-Message-State: AOJu0YxWCqbmvLYiUrJu4GBH1/nOlL6a0mHjP6o+w21qnwOlsuoN8WB8
	nybxVkePeBXOEzqfD6LfzjRCkW7NRKrq/Zy9cE+VMIyX5DpklF48
X-Gm-Gg: ASbGnctS7OxTv3mayc/bcKs25IwExqap7d1L9o+VGAWqqvguerH3CqP4obdsKFxeyHS
	SajVAhUqjlBaHN33lZiDYXGl9Gnf2qE6srxRLCLpp+7f4hGWg74mT8427gRmlmeDkwdDEC/Qcxg
	RNutaFTZJOwYg1Glwd7U3kuNlyPGd5xPIrUUORKAP3H4L0GVopyZP9lMJQnXYlibKXKRz4Qj5Wk
	/30DPs941yHv8oYgWLPzC1WepUQ2Fry63htkqQwOVzdfuS/55H94hV87mp9C15QXULecs04VBD3
	tiV4Pr2cOJUHO6fOfiefoiRQXFiDPSYz0Sx3YHcxEBbI1XyM8kgxpVwY6flhPQ2Wzhzia+xe
X-Google-Smtp-Source: AGHT+IFzOSoEeWGRpOJcsgbqmkbs930+bArl4UCx4aMPEHw0rGrtM9LCebcTTf+fTyjHXghr7XJLQw==
X-Received: by 2002:a17:906:7309:b0:ad2:4b33:ae67 with SMTP id a640c23a62f3a-ad24b33b891mr938462866b.4.1747147300871;
        Tue, 13 May 2025 07:41:40 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700e56sm7301556a12.57.2025.05.13.07.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:41:40 -0700 (PDT)
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
Subject: [PATCH 1/3] net: bcmgenet: switch to use 64bit statistics
Date: Tue, 13 May 2025 15:41:05 +0100
Message-Id: <20250513144107.1989-2-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250513144107.1989-1-zakkemble@gmail.com>
References: <20250513144107.1989-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the driver to use ndo_get_stats64, rtnl_link_stats64 and
u64_stats_t counters for statistics.

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 235 ++++++++++++------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  32 ++-
 2 files changed, 186 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 73d78dcb7..80ef973e1 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -969,12 +969,13 @@ static int bcmgenet_set_pauseparam(struct net_device *dev,
 
 /* standard ethtool support functions. */
 enum bcmgenet_stat_type {
-	BCMGENET_STAT_NETDEV = -1,
+	BCMGENET_STAT_RTNL = -1,
 	BCMGENET_STAT_MIB_RX,
 	BCMGENET_STAT_MIB_TX,
 	BCMGENET_STAT_RUNT,
 	BCMGENET_STAT_MISC,
 	BCMGENET_STAT_SOFT,
+	BCMGENET_STAT_SOFT64,
 };
 
 struct bcmgenet_stats {
@@ -984,13 +985,15 @@ struct bcmgenet_stats {
 	enum bcmgenet_stat_type type;
 	/* reg offset from UMAC base for misc counters */
 	u16 reg_offset;
+	/* sync for u64 stats counters */
+	int syncp_offset;
 };
 
-#define STAT_NETDEV(m) { \
+#define STAT_RTNL(m) { \
 	.stat_string = __stringify(m), \
-	.stat_sizeof = sizeof(((struct net_device_stats *)0)->m), \
-	.stat_offset = offsetof(struct net_device_stats, m), \
-	.type = BCMGENET_STAT_NETDEV, \
+	.stat_sizeof = sizeof(((struct rtnl_link_stats64 *)0)->m), \
+	.stat_offset = offsetof(struct rtnl_link_stats64, m), \
+	.type = BCMGENET_STAT_RTNL, \
 }
 
 #define STAT_GENET_MIB(str, m, _type) { \
@@ -1000,6 +1003,14 @@ struct bcmgenet_stats {
 	.type = _type, \
 }
 
+#define STAT_GENET_SOFT_MIB64(str, s, m) { \
+	.stat_string = str, \
+	.stat_sizeof = sizeof(((struct bcmgenet_priv *)0)->s.m), \
+	.stat_offset = offsetof(struct bcmgenet_priv, s.m), \
+	.type = BCMGENET_STAT_SOFT64, \
+	.syncp_offset = offsetof(struct bcmgenet_priv, s.syncp), \
+}
+
 #define STAT_GENET_MIB_RX(str, m) STAT_GENET_MIB(str, m, BCMGENET_STAT_MIB_RX)
 #define STAT_GENET_MIB_TX(str, m) STAT_GENET_MIB(str, m, BCMGENET_STAT_MIB_TX)
 #define STAT_GENET_RUNT(str, m) STAT_GENET_MIB(str, m, BCMGENET_STAT_RUNT)
@@ -1014,18 +1025,18 @@ struct bcmgenet_stats {
 }
 
 #define STAT_GENET_Q(num) \
-	STAT_GENET_SOFT_MIB("txq" __stringify(num) "_packets", \
-			tx_rings[num].packets), \
-	STAT_GENET_SOFT_MIB("txq" __stringify(num) "_bytes", \
-			tx_rings[num].bytes), \
-	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_bytes", \
-			rx_rings[num].bytes),	 \
-	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_packets", \
-			rx_rings[num].packets), \
-	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_errors", \
-			rx_rings[num].errors), \
-	STAT_GENET_SOFT_MIB("rxq" __stringify(num) "_dropped", \
-			rx_rings[num].dropped)
+	STAT_GENET_SOFT_MIB64("txq" __stringify(num) "_packets", \
+			tx_rings[num].stats64, packets), \
+	STAT_GENET_SOFT_MIB64("txq" __stringify(num) "_bytes", \
+			tx_rings[num].stats64, bytes), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_bytes", \
+			rx_rings[num].stats64, bytes),	 \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_packets", \
+			rx_rings[num].stats64, packets), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_errors", \
+			rx_rings[num].stats64, errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_dropped", \
+			rx_rings[num].stats64, dropped)
 
 /* There is a 0xC gap between the end of RX and beginning of TX stats and then
  * between the end of TX stats and the beginning of the RX RUNT
@@ -1037,15 +1048,15 @@ struct bcmgenet_stats {
  */
 static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
 	/* general stats */
-	STAT_NETDEV(rx_packets),
-	STAT_NETDEV(tx_packets),
-	STAT_NETDEV(rx_bytes),
-	STAT_NETDEV(tx_bytes),
-	STAT_NETDEV(rx_errors),
-	STAT_NETDEV(tx_errors),
-	STAT_NETDEV(rx_dropped),
-	STAT_NETDEV(tx_dropped),
-	STAT_NETDEV(multicast),
+	STAT_RTNL(rx_packets),
+	STAT_RTNL(tx_packets),
+	STAT_RTNL(rx_bytes),
+	STAT_RTNL(tx_bytes),
+	STAT_RTNL(rx_errors),
+	STAT_RTNL(tx_errors),
+	STAT_RTNL(rx_dropped),
+	STAT_RTNL(tx_dropped),
+	STAT_RTNL(multicast),
 	/* UniMAC RSV counters */
 	STAT_GENET_MIB_RX("rx_64_octets", mib.rx.pkt_cnt.cnt_64),
 	STAT_GENET_MIB_RX("rx_65_127_oct", mib.rx.pkt_cnt.cnt_127),
@@ -1216,8 +1227,9 @@ static void bcmgenet_update_mib_counters(struct bcmgenet_priv *priv)
 
 		s = &bcmgenet_gstrings_stats[i];
 		switch (s->type) {
-		case BCMGENET_STAT_NETDEV:
+		case BCMGENET_STAT_RTNL:
 		case BCMGENET_STAT_SOFT:
+		case BCMGENET_STAT_SOFT64:
 			continue;
 		case BCMGENET_STAT_RUNT:
 			offset += BCMGENET_STAT_OFFSET;
@@ -1250,29 +1262,41 @@ static void bcmgenet_update_mib_counters(struct bcmgenet_priv *priv)
 	}
 }
 
+
+
 static void bcmgenet_get_ethtool_stats(struct net_device *dev,
 				       struct ethtool_stats *stats,
 				       u64 *data)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct u64_stats_sync *syncp;
+	struct rtnl_link_stats64 stats64;
+	unsigned int start;
 	int i;
 
 	if (netif_running(dev))
 		bcmgenet_update_mib_counters(priv);
 
-	dev->netdev_ops->ndo_get_stats(dev);
+	dev_get_stats(dev, &stats64);
 
 	for (i = 0; i < BCMGENET_STATS_LEN; i++) {
 		const struct bcmgenet_stats *s;
 		char *p;
 
 		s = &bcmgenet_gstrings_stats[i];
-		if (s->type == BCMGENET_STAT_NETDEV)
-			p = (char *)&dev->stats;
+		if (s->type == BCMGENET_STAT_RTNL)
+			p = (char *)&stats64;
 		else
 			p = (char *)priv;
 		p += s->stat_offset;
-		if (sizeof(unsigned long) != sizeof(u32) &&
+		if (s->type == BCMGENET_STAT_SOFT64) {
+			syncp = (struct u64_stats_sync *)(p - s->stat_offset +
+											  s->syncp_offset);
+			do {
+				start = u64_stats_fetch_begin(syncp);
+				data[i] = u64_stats_read((u64_stats_t *)p);
+			} while (u64_stats_fetch_retry(syncp, start));
+		} else if (sizeof(unsigned long) != sizeof(u32) &&
 		    s->stat_sizeof == sizeof(unsigned long))
 			data[i] = *(unsigned long *)p;
 		else
@@ -1857,6 +1881,7 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
 					  struct bcmgenet_tx_ring *ring)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct bcmgenet_tx_stats64 *stats = &ring->stats64;
 	unsigned int txbds_processed = 0;
 	unsigned int bytes_compl = 0;
 	unsigned int pkts_compl = 0;
@@ -1896,8 +1921,10 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
 	ring->free_bds += txbds_processed;
 	ring->c_index = c_index;
 
-	ring->packets += pkts_compl;
-	ring->bytes += bytes_compl;
+	u64_stats_update_begin(&stats->syncp);
+	u64_stats_add(&stats->packets, pkts_compl);
+	u64_stats_add(&stats->bytes, bytes_compl);
+	u64_stats_update_end(&stats->syncp);
 
 	netdev_tx_completed_queue(netdev_get_tx_queue(dev, ring->index),
 				  pkts_compl, bytes_compl);
@@ -1983,9 +2010,11 @@ static void bcmgenet_tx_reclaim_all(struct net_device *dev)
  * the transmit checksum offsets in the descriptors
  */
 static struct sk_buff *bcmgenet_add_tsb(struct net_device *dev,
-					struct sk_buff *skb)
+					struct sk_buff *skb,
+					struct bcmgenet_tx_ring *ring)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct bcmgenet_tx_stats64 *stats = &ring->stats64;
 	struct status_64 *status = NULL;
 	struct sk_buff *new_skb;
 	u16 offset;
@@ -2001,7 +2030,9 @@ static struct sk_buff *bcmgenet_add_tsb(struct net_device *dev,
 		if (!new_skb) {
 			dev_kfree_skb_any(skb);
 			priv->mib.tx_realloc_tsb_failed++;
-			dev->stats.tx_dropped++;
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->dropped);
+			u64_stats_update_end(&stats->syncp);
 			return NULL;
 		}
 		dev_consume_skb_any(skb);
@@ -2089,7 +2120,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	GENET_CB(skb)->bytes_sent = skb->len;
 
 	/* add the Transmit Status Block */
-	skb = bcmgenet_add_tsb(dev, skb);
+	skb = bcmgenet_add_tsb(dev, skb, ring);
 	if (!skb) {
 		ret = NETDEV_TX_OK;
 		goto out;
@@ -2233,6 +2264,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 {
 	struct bcmgenet_priv *priv = ring->priv;
 	struct net_device *dev = priv->dev;
+	struct bcmgenet_rx_stats64 *stats = &ring->stats64;
 	struct enet_cb *cb;
 	struct sk_buff *skb;
 	u32 dma_length_status;
@@ -2253,7 +2285,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		   DMA_P_INDEX_DISCARD_CNT_MASK;
 	if (discards > ring->old_discards) {
 		discards = discards - ring->old_discards;
-		ring->errors += discards;
+		u64_stats_update_begin(&stats->syncp);
+		u64_stats_add(&stats->errors, discards);
+		u64_stats_update_end(&stats->syncp);
 		ring->old_discards += discards;
 
 		/* Clear HW register when we reach 75% of maximum 0xFFFF */
@@ -2279,7 +2313,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		skb = bcmgenet_rx_refill(priv, cb);
 
 		if (unlikely(!skb)) {
-			ring->dropped++;
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->dropped);
+			u64_stats_update_end(&stats->syncp);
 			goto next;
 		}
 
@@ -2306,8 +2342,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 
 		if (unlikely(len > RX_BUF_LENGTH)) {
 			netif_err(priv, rx_status, dev, "oversized packet\n");
-			dev->stats.rx_length_errors++;
-			dev->stats.rx_errors++;
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->length_errors);
+			u64_stats_update_end(&stats->syncp);
 			dev_kfree_skb_any(skb);
 			goto next;
 		}
@@ -2315,7 +2352,9 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		if (unlikely(!(dma_flag & DMA_EOP) || !(dma_flag & DMA_SOP))) {
 			netif_err(priv, rx_status, dev,
 				  "dropping fragmented packet!\n");
-			ring->errors++;
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->fragmented_errors);
+			u64_stats_update_end(&stats->syncp);
 			dev_kfree_skb_any(skb);
 			goto next;
 		}
@@ -2328,15 +2367,22 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 						DMA_RX_RXER))) {
 			netif_err(priv, rx_status, dev, "dma_flag=0x%x\n",
 				  (unsigned int)dma_flag);
+			u64_stats_update_begin(&stats->syncp);
 			if (dma_flag & DMA_RX_CRC_ERROR)
-				dev->stats.rx_crc_errors++;
+				u64_stats_inc(&stats->crc_errors);
 			if (dma_flag & DMA_RX_OV)
-				dev->stats.rx_over_errors++;
+				u64_stats_inc(&stats->over_errors);
 			if (dma_flag & DMA_RX_NO)
-				dev->stats.rx_frame_errors++;
+				u64_stats_inc(&stats->frame_errors);
 			if (dma_flag & DMA_RX_LG)
-				dev->stats.rx_length_errors++;
-			dev->stats.rx_errors++;
+				u64_stats_inc(&stats->length_errors);
+			if ((dma_flag & (DMA_RX_CRC_ERROR |
+						DMA_RX_OV |
+						DMA_RX_NO |
+						DMA_RX_LG |
+						DMA_RX_RXER)) == DMA_RX_RXER)
+				u64_stats_inc(&stats->errors);
+			u64_stats_update_end(&stats->syncp);
 			dev_kfree_skb_any(skb);
 			goto next;
 		} /* error packet */
@@ -2356,10 +2402,13 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 
 		/*Finish setting up the received SKB and send it to the kernel*/
 		skb->protocol = eth_type_trans(skb, priv->dev);
-		ring->packets++;
-		ring->bytes += len;
+
+		u64_stats_update_begin(&stats->syncp);
+		u64_stats_inc(&stats->packets);
+		u64_stats_add(&stats->bytes, len);
 		if (dma_flag & DMA_RX_MULT)
-			dev->stats.multicast++;
+			u64_stats_inc(&stats->multicast);
+		u64_stats_update_end(&stats->syncp);
 
 		/* Notify kernel */
 		napi_gro_receive(&ring->napi, skb);
@@ -3402,6 +3451,7 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
 static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct bcmgenet_tx_stats64 *stats = &priv->tx_rings[txqueue].stats64;
 	u32 int1_enable = 0;
 	unsigned int q;
 
@@ -3420,7 +3470,9 @@ static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
 
 	netif_trans_update(dev);
 
-	dev->stats.tx_errors++;
+	u64_stats_update_begin(&stats->syncp);
+	u64_stats_inc(&stats->errors);
+	u64_stats_update_end(&stats->syncp);
 
 	netif_tx_wake_all_queues(dev);
 }
@@ -3509,39 +3561,72 @@ static int bcmgenet_set_mac_addr(struct net_device *dev, void *p)
 	return 0;
 }
 
-static struct net_device_stats *bcmgenet_get_stats(struct net_device *dev)
+static void bcmgenet_get_stats64(struct net_device *dev,
+								 struct rtnl_link_stats64 *stats)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	unsigned long tx_bytes = 0, tx_packets = 0;
-	unsigned long rx_bytes = 0, rx_packets = 0;
-	unsigned long rx_errors = 0, rx_dropped = 0;
-	struct bcmgenet_tx_ring *tx_ring;
-	struct bcmgenet_rx_ring *rx_ring;
+	u64 tx_bytes = 0, tx_packets = 0;
+	u64 tx_errors = 0, tx_dropped = 0;
+	u64 rx_bytes = 0, rx_packets = 0;
+	u64 rx_errors = 0, rx_dropped = 0;
+	u64 rx_length_errors = 0;
+	u64 rx_over_errors = 0, rx_crc_errors = 0;
+	u64 rx_frame_errors = 0, rx_fragmented_errors = 0;
+	u64 multicast = 0;
+	struct bcmgenet_tx_stats64 *tx_stats;
+	struct bcmgenet_rx_stats64 *rx_stats;
 	unsigned int q;
+	unsigned int start;
 
 	for (q = 0; q <= priv->hw_params->tx_queues; q++) {
-		tx_ring = &priv->tx_rings[q];
-		tx_bytes += tx_ring->bytes;
-		tx_packets += tx_ring->packets;
+		tx_stats = &priv->tx_rings[q].stats64;
+		do {
+			
+			start = u64_stats_fetch_begin(&tx_stats->syncp);
+			tx_bytes = u64_stats_read(&tx_stats->bytes);
+			tx_packets = u64_stats_read(&tx_stats->packets);
+			tx_errors = u64_stats_read(&tx_stats->errors);
+			tx_dropped = u64_stats_read(&tx_stats->dropped);
+		} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
+
+		stats->tx_bytes += tx_bytes;
+		stats->tx_packets += tx_packets;
+		stats->tx_errors += tx_errors;
+		stats->tx_dropped += tx_dropped;
 	}
 
 	for (q = 0; q <= priv->hw_params->rx_queues; q++) {
-		rx_ring = &priv->rx_rings[q];
-
-		rx_bytes += rx_ring->bytes;
-		rx_packets += rx_ring->packets;
-		rx_errors += rx_ring->errors;
-		rx_dropped += rx_ring->dropped;
+		rx_stats = &priv->rx_rings[q].stats64;
+		do {
+			start = u64_stats_fetch_begin(&rx_stats->syncp);
+			rx_bytes = u64_stats_read(&rx_stats->bytes);
+			rx_packets = u64_stats_read(&rx_stats->packets);
+			rx_errors = u64_stats_read(&rx_stats->errors);
+			rx_dropped = u64_stats_read(&rx_stats->dropped);
+			rx_length_errors = u64_stats_read(&rx_stats->length_errors);
+			rx_over_errors = u64_stats_read(&rx_stats->over_errors);
+			rx_crc_errors = u64_stats_read(&rx_stats->crc_errors);
+			rx_frame_errors = u64_stats_read(&rx_stats->frame_errors);
+			rx_fragmented_errors = u64_stats_read(&rx_stats->fragmented_errors);
+			multicast = u64_stats_read(&rx_stats->multicast);
+		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
+
+		rx_errors += rx_length_errors;
+		rx_errors += rx_crc_errors;
+		rx_errors += rx_frame_errors;
+		rx_errors += rx_fragmented_errors;
+
+		stats->rx_bytes += rx_bytes;
+		stats->rx_packets += rx_packets;
+		stats->rx_errors += rx_errors;
+		stats->rx_dropped += rx_dropped;
+		stats->rx_missed_errors += rx_errors;
+		stats->rx_length_errors += rx_length_errors;
+		stats->rx_over_errors += rx_over_errors;
+		stats->rx_crc_errors += rx_crc_errors;
+		stats->rx_frame_errors += rx_frame_errors;
+		stats->multicast += multicast;
 	}
-
-	dev->stats.tx_bytes = tx_bytes;
-	dev->stats.tx_packets = tx_packets;
-	dev->stats.rx_bytes = rx_bytes;
-	dev->stats.rx_packets = rx_packets;
-	dev->stats.rx_errors = rx_errors;
-	dev->stats.rx_missed_errors = rx_errors;
-	dev->stats.rx_dropped = rx_dropped;
-	return &dev->stats;
 }
 
 static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
@@ -3569,7 +3654,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_set_mac_address	= bcmgenet_set_mac_addr,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= bcmgenet_set_features,
-	.ndo_get_stats		= bcmgenet_get_stats,
+	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
 };
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 10c631bbe..5ec397977 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -155,6 +155,30 @@ struct bcmgenet_mib_counters {
 	u32	tx_realloc_tsb_failed;
 };
 
+struct bcmgenet_tx_stats64 {
+	struct u64_stats_sync syncp;
+	u64_stats_t	packets;
+	u64_stats_t	bytes;
+	u64_stats_t	errors;
+	u64_stats_t	dropped;
+};
+
+struct bcmgenet_rx_stats64 {
+	struct u64_stats_sync syncp;
+	u64_stats_t	bytes;
+	u64_stats_t	packets;
+	u64_stats_t	errors;
+	u64_stats_t	dropped;
+	u64_stats_t	multicast;
+	u64_stats_t	broadcast;
+	u64_stats_t	missed;
+	u64_stats_t	length_errors;
+	u64_stats_t	over_errors;
+	u64_stats_t	crc_errors;
+	u64_stats_t	frame_errors;
+	u64_stats_t	fragmented_errors;
+};
+
 #define UMAC_MIB_START			0x400
 
 #define UMAC_MDIO_CMD			0x614
@@ -515,8 +539,7 @@ struct bcmgenet_skb_cb {
 struct bcmgenet_tx_ring {
 	spinlock_t	lock;		/* ring lock */
 	struct napi_struct napi;	/* NAPI per tx queue */
-	unsigned long	packets;
-	unsigned long	bytes;
+	struct bcmgenet_tx_stats64 stats64;
 	unsigned int	index;		/* ring index */
 	struct enet_cb	*cbs;		/* tx ring buffer control block*/
 	unsigned int	size;		/* size of each tx ring */
@@ -540,10 +563,7 @@ struct bcmgenet_net_dim {
 
 struct bcmgenet_rx_ring {
 	struct napi_struct napi;	/* Rx NAPI struct */
-	unsigned long	bytes;
-	unsigned long	packets;
-	unsigned long	errors;
-	unsigned long	dropped;
+	struct bcmgenet_rx_stats64 stats64;
 	unsigned int	index;		/* Rx ring index */
 	struct enet_cb	*cbs;		/* Rx ring buffer control block */
 	unsigned int	size;		/* Rx ring size */
-- 
2.39.5


