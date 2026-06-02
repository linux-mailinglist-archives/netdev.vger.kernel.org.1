Return-Path: <netdev+bounces-294125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNSxLdunHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:52:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D63362BEDF
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2296230053E2
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980137F011;
	Tue,  2 Jun 2026 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="DHzZ6wan"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE137F007;
	Tue,  2 Jun 2026 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393523; cv=none; b=oFOmPI0bF+x+3/UfiwRrcJLnPyJYFRbeIVo4L1RPuYQ0Umfp46gj5ZmIEXldczmBQXptAlRGm47xYvdOi6bqO/t91afJKvI8vT6zDdlJLNJOC0DlVdxIitFygalxcwW6RpIeVz6a9DCBFhhlI3sy19ZQHS2yE5sw3jTGtCw2r/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393523; c=relaxed/simple;
	bh=6076gICBBQ5JrU/wFnejmG0ObYnml34OvyJavVCfM1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzYGDlrkGwqNOfvuaMNuDq9G40bR3Zynp74CGAlxqGxkZ3x1tbpcfFz+ZG1ATrcX+QfN1lSe7pPjiLyXSam7ePa8X2SZih10quB2Jb0vG/2BLzyA4hGnlttKMhs1+IX5XXpvUL+T2oGtFrgR6xYiYG+IW+JDi75IF3VPcFq6uvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=DHzZ6wan; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD8B4A03C2;
	Tue,  2 Jun 2026 11:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780393507; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=nTeQAIQ2QBgStDqa1p/0yNqfi1++3j0sDc50/43Jor0=;
	b=DHzZ6wanQFuCrYYJojmgj4XjYBeIvhIlVKKCfxg5mHTVaHNmAFlGpVhsGrTPv9ag/VthmO
	lMAzrf7YAuyVCK4wcC3EsYlhQaEgQ9Bb4oN02eAoq1dqawKCGMQPR7xIagwhEmcTX2UhgZ
	JikVl1GxyKurhAxgi5CxhhcW4/AeNxECeIgvYNJs+79F19grb6rfomqVbXKGgiY9edB0lS
	l1Nx51OfvzK9aCHhvOP/5y68aDZriiog+J2LCdRJxqx8u0tdcmoNUQ/w4ArQVLolyz5Rz6
	5g2B9SsZQsGwX5qosgSZjCygZsECcohT3SZdfnu0hOL5UDcyJghaqzGxtZAGVw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Markus=20Bl=C3=B6chl?= <markus@blochl.de>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: bcmgenet: convert RX path to page_pool
Date: Tue,  2 Jun 2026 11:42:31 +0200
Message-ID: <20260602094248.4130712-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 1D63362BEDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-294125-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,tipi-net.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,suse.de,blochl.de,arndb.de,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email]
X-Rspamd-Action: no action

Replace the per-packet __netdev_alloc_skb() + dma_map_single() in the
RX path with page_pool. SKBs are built from pool pages via
napi_build_skb() with skb_mark_for_recycle() so the network stack
returns pages to the pool, and DMA mapping happens once per page
instead of once per packet.

Reject HW-reported lengths smaller than RSB + minimum Ethernet frame
(+ FCS if crc_fwd_en) so a runt cannot underflow the SKB build path.

Drop the now-unused priv->rx_buf_len field and the rx_dma_failed soft
MIB counter (nothing increments it after the conversion).

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
This is the page_pool conversion patch from my bcmgenet XDP series
[1], pulled out as a standalone submission. The XDP series has had
several review rounds, and page_pool is the part that has taken the
most discussion. Getting it in on its own should hopefully make the
rest of the XDP work easier to review later, and it is also the
API new RX paths are expected to use anyway.

Tested on a Raspberry Pi CM4 (BCM2711, 1 Gbps). Ran the benchmarks
at the default 1.5 GHz and again with the CPU pinned to 600 MHz to
push the RX path harder. No regressions either way.

[1] https://lore.kernel.org/netdev/20260506095553.55357-2-nb@tipi-net.de/

 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 229 +++++++++++-------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   6 +-
 3 files changed, 150 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 4287edc7ddd6..f0bac0dd1439 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -78,6 +78,7 @@ config BCMGENET
 	select BCM7XXX_PHY
 	select MDIO_BCM_UNIMAC
 	select DIMLIB
+	select PAGE_POOL
 	select BROADCOM_PHY if ARCH_BCM2835
 	help
 	  This driver supports the built-in Ethernet MACs found in the
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 7c11cf916762..80dbfba9fa88 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -52,6 +52,12 @@
 #define RX_BUF_LENGTH		2048
 #define SKB_ALIGNMENT		32
 
+/* Page pool RX buffer layout:
+ * RSB(64) + pad(2) | frame data | skb_shared_info
+ * The HW writes the 64B RSB + 2B alignment padding before the frame.
+ */
+#define GENET_RSB_PAD		(sizeof(struct status_64) + 2)
+
 /* Tx/Rx DMA register offset, skip 256 descriptors */
 #define WORDS_PER_BD(p)		(p->hw_params->words_per_bd)
 #define DMA_DESC_SIZE		(WORDS_PER_BD(priv) * sizeof(u32))
@@ -1153,7 +1159,6 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
 			UMAC_RBUF_ERR_CNT_V1),
 	STAT_GENET_MISC("mdf_err_cnt", mib.mdf_err_cnt, UMAC_MDF_ERR_CNT),
 	STAT_GENET_SOFT_MIB("alloc_rx_buff_failed", mib.alloc_rx_buff_failed),
-	STAT_GENET_SOFT_MIB("rx_dma_failed", mib.rx_dma_failed),
 	STAT_GENET_SOFT_MIB("tx_dma_failed", mib.tx_dma_failed),
 	STAT_GENET_SOFT_MIB("tx_realloc_tsb", mib.tx_realloc_tsb),
 	STAT_GENET_SOFT_MIB("tx_realloc_tsb_failed",
@@ -1894,21 +1899,13 @@ static struct sk_buff *bcmgenet_free_tx_cb(struct device *dev,
 }
 
 /* Simple helper to free a receive control block's resources */
-static struct sk_buff *bcmgenet_free_rx_cb(struct device *dev,
-					   struct enet_cb *cb)
+static void bcmgenet_free_rx_cb(struct enet_cb *cb,
+				struct page_pool *pool)
 {
-	struct sk_buff *skb;
-
-	skb = cb->skb;
-	cb->skb = NULL;
-
-	if (dma_unmap_addr(cb, dma_addr)) {
-		dma_unmap_single(dev, dma_unmap_addr(cb, dma_addr),
-				 dma_unmap_len(cb, dma_len), DMA_FROM_DEVICE);
-		dma_unmap_addr_set(cb, dma_addr, 0);
+	if (cb->rx_page) {
+		page_pool_put_full_page(pool, cb->rx_page, false);
+		cb->rx_page = NULL;
 	}
-
-	return skb;
 }
 
 /* Unlocked version of the reclaim routine */
@@ -2249,46 +2246,30 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	goto out;
 }
 
-static struct sk_buff *bcmgenet_rx_refill(struct bcmgenet_priv *priv,
-					  struct enet_cb *cb)
+static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
+			      struct enet_cb *cb)
 {
-	struct device *kdev = &priv->pdev->dev;
-	struct sk_buff *skb;
-	struct sk_buff *rx_skb;
+	struct bcmgenet_priv *priv = ring->priv;
 	dma_addr_t mapping;
+	struct page *page;
 
-	/* Allocate a new Rx skb */
-	skb = __netdev_alloc_skb(priv->dev, priv->rx_buf_len + SKB_ALIGNMENT,
-				 GFP_ATOMIC | __GFP_NOWARN);
-	if (!skb) {
+	page = page_pool_alloc_pages(ring->page_pool,
+				     GFP_ATOMIC);
+	if (!page) {
 		priv->mib.alloc_rx_buff_failed++;
 		netif_err(priv, rx_err, priv->dev,
-			  "%s: Rx skb allocation failed\n", __func__);
-		return NULL;
-	}
-
-	/* DMA-map the new Rx skb */
-	mapping = dma_map_single(kdev, skb->data, priv->rx_buf_len,
-				 DMA_FROM_DEVICE);
-	if (dma_mapping_error(kdev, mapping)) {
-		priv->mib.rx_dma_failed++;
-		dev_kfree_skb_any(skb);
-		netif_err(priv, rx_err, priv->dev,
-			  "%s: Rx skb DMA mapping failed\n", __func__);
-		return NULL;
+			  "%s: Rx page allocation failed\n", __func__);
+		return -ENOMEM;
 	}
 
-	/* Grab the current Rx skb from the ring and DMA-unmap it */
-	rx_skb = bcmgenet_free_rx_cb(kdev, cb);
+	/* page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
+	mapping = page_pool_get_dma_addr(page);
 
-	/* Put the new Rx skb on the ring */
-	cb->skb = skb;
-	dma_unmap_addr_set(cb, dma_addr, mapping);
-	dma_unmap_len_set(cb, dma_len, priv->rx_buf_len);
+	cb->rx_page = page;
+	cb->rx_page_offset = 0;
 	dmadesc_set_addr(priv, cb->bd_addr, mapping);
 
-	/* Return the current Rx skb to caller */
-	return rx_skb;
+	return 0;
 }
 
 /* bcmgenet_desc_rx - descriptor based rx process.
@@ -2304,7 +2285,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	struct sk_buff *skb;
 	u32 dma_length_status;
 	unsigned long dma_flag;
-	int len;
+	int len, min_len;
 	unsigned int rxpktprocessed = 0, rxpkttoprocess;
 	unsigned int bytes_processed = 0;
 	unsigned int p_index, mask;
@@ -2340,25 +2321,31 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	while ((rxpktprocessed < rxpkttoprocess) &&
 	       (rxpktprocessed < budget)) {
 		struct status_64 *status;
+		struct page *rx_page;
+		unsigned int rx_off;
+		void *hard_start;
 		__be16 rx_csum;
 
 		cb = &priv->rx_cbs[ring->read_ptr];
-		skb = bcmgenet_rx_refill(priv, cb);
 
-		if (unlikely(!skb)) {
+		/* Save the received page before refilling */
+		rx_page = cb->rx_page;
+		rx_off = cb->rx_page_offset;
+
+		if (bcmgenet_rx_refill(ring, cb)) {
 			BCMGENET_STATS64_INC(stats, dropped);
 			goto next;
 		}
 
-		status = (struct status_64 *)skb->data;
+		/* Sync the full buffer; the HW may have written anywhere
+		 * up to RX_BUF_LENGTH.
+		 */
+		page_pool_dma_sync_for_cpu(ring->page_pool, rx_page, 0,
+					   RX_BUF_LENGTH);
+
+		hard_start = page_address(rx_page) + rx_off;
+		status = (struct status_64 *)hard_start;
 		dma_length_status = status->length_status;
-		if (dev->features & NETIF_F_RXCSUM) {
-			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
-			if (rx_csum) {
-				skb->csum = (__force __wsum)ntohs(rx_csum);
-				skb->ip_summed = CHECKSUM_COMPLETE;
-			}
-		}
 
 		/* DMA flags and length are still valid no matter how
 		 * we got the Receive Status Vector (64B RSB or register)
@@ -2371,10 +2358,17 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 			  __func__, p_index, ring->c_index,
 			  ring->read_ptr, dma_length_status);
 
-		if (unlikely(len > RX_BUF_LENGTH)) {
-			netif_err(priv, rx_status, dev, "oversized packet\n");
+		/* Reject obviously bogus lengths to keep the SKB build path
+		 * safe against runt frames.
+		 */
+		min_len = GENET_RSB_PAD + ETH_ZLEN +
+			  (priv->crc_fwd_en ? ETH_FCS_LEN : 0);
+		if (unlikely(len > RX_BUF_LENGTH || len < min_len)) {
+			netif_err(priv, rx_status, dev,
+				  "invalid packet length %d\n", len);
 			BCMGENET_STATS64_INC(stats, length_errors);
-			dev_kfree_skb_any(skb);
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
 			goto next;
 		}
 
@@ -2382,7 +2376,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 			netif_err(priv, rx_status, dev,
 				  "dropping fragmented packet!\n");
 			BCMGENET_STATS64_INC(stats, fragmented_errors);
-			dev_kfree_skb_any(skb);
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
 			goto next;
 		}
 
@@ -2410,21 +2405,42 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 						DMA_RX_RXER)) == DMA_RX_RXER)
 				u64_stats_inc(&stats->errors);
 			u64_stats_update_end(&stats->syncp);
-			dev_kfree_skb_any(skb);
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
 			goto next;
 		} /* error packet */
 
-		skb_put(skb, len);
+		/* Build SKB from the page - data starts at hard_start,
+		 * frame begins after RSB(64) + pad(2) = 66 bytes.
+		 */
+		skb = napi_build_skb(hard_start, PAGE_SIZE - rx_off);
+		if (unlikely(!skb)) {
+			BCMGENET_STATS64_INC(stats, dropped);
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
+			goto next;
+		}
+
+		skb_mark_for_recycle(skb);
 
-		/* remove RSB and hardware 2bytes added for IP alignment */
-		skb_pull(skb, 66);
-		len -= 66;
+		/* Reserve the RSB + pad, then set the data length */
+		skb_reserve(skb, GENET_RSB_PAD);
+		__skb_put(skb, len - GENET_RSB_PAD);
 
 		if (priv->crc_fwd_en) {
-			skb_trim(skb, len - ETH_FCS_LEN);
-			len -= ETH_FCS_LEN;
+			skb_trim(skb, skb->len - ETH_FCS_LEN);
 		}
 
+		/* Set up checksum offload */
+		if (dev->features & NETIF_F_RXCSUM) {
+			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
+			if (rx_csum) {
+				skb->csum = (__force __wsum)ntohs(rx_csum);
+				skb->ip_summed = CHECKSUM_COMPLETE;
+			}
+		}
+
+		len = skb->len;
 		bytes_processed += len;
 
 		/*Finish setting up the received SKB and send it to the kernel*/
@@ -2496,12 +2512,11 @@ static void bcmgenet_dim_work(struct work_struct *work)
 	dim->state = DIM_START_MEASURE;
 }
 
-/* Assign skb to RX DMA descriptor. */
+/* Assign page_pool pages to RX DMA descriptors. */
 static int bcmgenet_alloc_rx_buffers(struct bcmgenet_priv *priv,
 				     struct bcmgenet_rx_ring *ring)
 {
 	struct enet_cb *cb;
-	struct sk_buff *skb;
 	int i;
 
 	netif_dbg(priv, hw, priv->dev, "%s\n", __func__);
@@ -2509,10 +2524,7 @@ static int bcmgenet_alloc_rx_buffers(struct bcmgenet_priv *priv,
 	/* loop here for each buffer needing assign */
 	for (i = 0; i < ring->size; i++) {
 		cb = ring->cbs + i;
-		skb = bcmgenet_rx_refill(priv, cb);
-		if (skb)
-			dev_consume_skb_any(skb);
-		if (!cb->skb)
+		if (bcmgenet_rx_refill(ring, cb))
 			return -ENOMEM;
 	}
 
@@ -2521,16 +2533,18 @@ static int bcmgenet_alloc_rx_buffers(struct bcmgenet_priv *priv,
 
 static void bcmgenet_free_rx_buffers(struct bcmgenet_priv *priv)
 {
-	struct sk_buff *skb;
+	struct bcmgenet_rx_ring *ring;
 	struct enet_cb *cb;
-	int i;
-
-	for (i = 0; i < priv->num_rx_bds; i++) {
-		cb = &priv->rx_cbs[i];
+	int q, i;
 
-		skb = bcmgenet_free_rx_cb(&priv->pdev->dev, cb);
-		if (skb)
-			dev_consume_skb_any(skb);
+	for (q = 0; q <= priv->hw_params->rx_queues; q++) {
+		ring = &priv->rx_rings[q];
+		if (!ring->page_pool)
+			continue;
+		for (i = 0; i < ring->size; i++) {
+			cb = ring->cbs + i;
+			bcmgenet_free_rx_cb(cb, ring->page_pool);
+		}
 	}
 }
 
@@ -2748,6 +2762,30 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 	netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
 }
 
+static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
+					struct bcmgenet_rx_ring *ring)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = ring->size,
+		.nid = NUMA_NO_NODE,
+		.dev = &priv->pdev->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.max_len = RX_BUF_LENGTH,
+	};
+	int err;
+
+	ring->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(ring->page_pool)) {
+		err = PTR_ERR(ring->page_pool);
+		ring->page_pool = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
 /* Initialize a RDMA ring */
 static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 				 unsigned int index, unsigned int size,
@@ -2755,7 +2793,7 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 {
 	struct bcmgenet_rx_ring *ring = &priv->rx_rings[index];
 	u32 words_per_bd = WORDS_PER_BD(priv);
-	int ret;
+	int ret, i;
 
 	ring->priv = priv;
 	ring->index = index;
@@ -2766,10 +2804,19 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 	ring->cb_ptr = start_ptr;
 	ring->end_ptr = end_ptr - 1;
 
-	ret = bcmgenet_alloc_rx_buffers(priv, ring);
+	ret = bcmgenet_rx_ring_create_pool(priv, ring);
 	if (ret)
 		return ret;
 
+	ret = bcmgenet_alloc_rx_buffers(priv, ring);
+	if (ret) {
+		for (i = 0; i < ring->size; i++)
+			bcmgenet_free_rx_cb(ring->cbs + i, ring->page_pool);
+		page_pool_destroy(ring->page_pool);
+		ring->page_pool = NULL;
+		return ret;
+	}
+
 	bcmgenet_init_dim(ring, bcmgenet_dim_work);
 	bcmgenet_init_rx_coalesce(ring);
 
@@ -2962,6 +3009,20 @@ static void bcmgenet_fini_rx_napi(struct bcmgenet_priv *priv)
 	}
 }
 
+static void bcmgenet_destroy_rx_page_pools(struct bcmgenet_priv *priv)
+{
+	struct bcmgenet_rx_ring *ring;
+	unsigned int i;
+
+	for (i = 0; i <= priv->hw_params->rx_queues; ++i) {
+		ring = &priv->rx_rings[i];
+		if (ring->page_pool) {
+			page_pool_destroy(ring->page_pool);
+			ring->page_pool = NULL;
+		}
+	}
+}
+
 /* Initialize Rx queues
  *
  * Queues 0-15 are priority queues. Hardware Filtering Block (HFB) can be
@@ -3033,6 +3094,7 @@ static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 	}
 
 	bcmgenet_free_rx_buffers(priv);
+	bcmgenet_destroy_rx_page_pools(priv);
 	kfree(priv->rx_cbs);
 	kfree(priv->tx_cbs);
 }
@@ -3109,6 +3171,7 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 	if (ret) {
 		netdev_err(priv->dev, "failed to initialize Rx queues\n");
 		bcmgenet_free_rx_buffers(priv);
+		bcmgenet_destroy_rx_page_pools(priv);
 		kfree(priv->rx_cbs);
 		kfree(priv->tx_cbs);
 		return ret;
@@ -4026,8 +4089,6 @@ static int bcmgenet_probe(struct platform_device *pdev)
 
 	/* Mii wait queue */
 	init_waitqueue_head(&priv->wq);
-	/* Always use RX_BUF_LENGTH (2KB) buffer for all chips */
-	priv->rx_buf_len = RX_BUF_LENGTH;
 	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
 
 	priv->clk_wol = devm_clk_get_optional(&priv->pdev->dev, "enet-wol");
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 9e4110c7fdf6..41ceda21c6f3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -15,6 +15,7 @@
 #include <linux/phy.h>
 #include <linux/dim.h>
 #include <linux/ethtool.h>
+#include <net/page_pool/helpers.h>
 
 #include "../unimac.h"
 
@@ -149,7 +150,6 @@ struct bcmgenet_mib_counters {
 	u32	rbuf_err_cnt;
 	u32	mdf_err_cnt;
 	u32	alloc_rx_buff_failed;
-	u32	rx_dma_failed;
 	u32	tx_dma_failed;
 	u32	tx_realloc_tsb;
 	u32	tx_realloc_tsb_failed;
@@ -469,6 +469,8 @@ struct bcmgenet_rx_stats64 {
 
 struct enet_cb {
 	struct sk_buff      *skb;
+	struct page         *rx_page;
+	unsigned int        rx_page_offset;
 	void __iomem *bd_addr;
 	DEFINE_DMA_UNMAP_ADDR(dma_addr);
 	DEFINE_DMA_UNMAP_LEN(dma_len);
@@ -575,6 +577,7 @@ struct bcmgenet_rx_ring {
 	struct bcmgenet_net_dim dim;
 	u32		rx_max_coalesced_frames;
 	u32		rx_coalesce_usecs;
+	struct page_pool *page_pool;
 	struct bcmgenet_priv *priv;
 };
 
@@ -609,7 +612,6 @@ struct bcmgenet_priv {
 	void __iomem *rx_bds;
 	struct enet_cb *rx_cbs;
 	unsigned int num_rx_bds;
-	unsigned int rx_buf_len;
 	struct bcmgenet_rxnfc_rule rxnfc_rules[MAX_NUM_OF_FS_RULES];
 	struct list_head rxnfc_list;
 
-- 
2.53.0


