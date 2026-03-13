Return-Path: <netdev+bounces-267346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OHjLMzXs2mzbgAAu9opvQ
	(envelope-from <netdev+bounces-267346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:24:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 231BD2806CF
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9075D31C16CE
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8D38C41E;
	Fri, 13 Mar 2026 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="fv9patpJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92A1C84C0;
	Fri, 13 Mar 2026 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393691; cv=none; b=WkA2PUclKLbpbaGOrt72thdWbkq9VIz6HO0IQIpUdbcwf1fZUSXveJ+RYhAFaJTgxrZsvaPKqSCdMznk0G6WbmUTuTh38pMNx7IW1+S++3AfmACLSg9kTKux4gcrp9aGbm7yEjbpKuq8oYCBbRvvm52rNZvSPL730nsAHLX+s7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393691; c=relaxed/simple;
	bh=NvfHN+YwB5Uh1b17ClXrK/yAJiY1ImX9zrosgTCVRM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoNOI8Iv0zO79sFrIfY23D0cY2/FwOlI9lnMeaXsdFlR8dRiQmm4WI3kzOSUHin6MbF0nQ+sELjtdoO8Sg/VR05M8N2P4R49mR2rqesJkP+iBwpqxNwKFxdMOPwtxAVCbPzMr32fXx/JaZWnpd9GJ0Q2/iayXxKg6aVEzlRyv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=fv9patpJ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DBCFA5705;
	Fri, 13 Mar 2026 10:21:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773393682; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=JlNTVCCEMpLe+QdV6Hc3TyF9BpdyJ2SM/Cy6iXmvFjA=;
	b=fv9patpJsg3eCa8jIZIvcWWwRH87qJRg3cCD0ytJlVuhF36FQKuZ8qMFbHexYkdROTEZ7Y
	DRu6q2MB9lJ8Ua7JRKxJtDfq6kTuIZqFF7JPwrHU7uqFCCTyxI+9MDm81FiBt2TrsD4Vtb
	ei25C7+LAqdDDY0jVdhErEaUgqW/+2vbJ36nRlJ0cDfiERZE1EnaIZcrfap5AdAGRkHay5
	7TTl0oOQJScFCOanuOOu7vzm5+qn0uHNWci5jGm0azzCMeG6ns8pxOrmE5Qf3iry2qGP6A
	z+jxVrvEDZdz1t95DSVHVhm1qSZ1L+tZPmfHKq2VZrGW11oTT2VPhhdKxRkdCg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Markus=20Bl=C3=B6chl?= <mbloch@rooftopnetworks.de>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 4/6] net: bcmgenet: add XDP_TX support
Date: Fri, 13 Mar 2026 10:20:59 +0100
Message-ID: <20260313092101.1344954-5-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313092101.1344954-1-nb@tipi-net.de>
References: <20260313092101.1344954-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-267346-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,gmail.com,rooftopnetworks.de,arndb.de,vger.kernel.org,tipi-net.de];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: 231BD2806CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement XDP_TX by submitting XDP frames through the default TX ring
(DESC_INDEX). The frame is DMA-mapped and placed into a single TX
descriptor with SOP|EOP|APPEND_CRC flags.

The xdp_frame pointer is stored in the TX control block so that
bcmgenet_free_tx_cb() can call xdp_return_frame() on TX completion,
returning the page to the originating page_pool.

The page_pool DMA direction is changed from DMA_FROM_DEVICE to
DMA_BIDIRECTIONAL to support the TX DMA mapping of received pages.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 73 ++++++++++++++++++-
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  1 +
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index d43729fc2b1b..373ba5878ca1 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1893,6 +1893,12 @@ static struct sk_buff *bcmgenet_free_tx_cb(struct device *dev,
 		if (cb == GENET_CB(skb)->last_cb)
 			return skb;
 
+	} else if (cb->xdpf) {
+		dma_unmap_single(dev, dma_unmap_addr(cb, dma_addr),
+				 dma_unmap_len(cb, dma_len), DMA_TO_DEVICE);
+		dma_unmap_addr_set(cb, dma_addr, 0);
+		xdp_return_frame(cb->xdpf);
+		cb->xdpf = NULL;
 	} else if (dma_unmap_addr(cb, dma_addr)) {
 		dma_unmap_page(dev,
 			       dma_unmap_addr(cb, dma_addr),
@@ -2299,10 +2305,62 @@ static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
 	return skb;
 }
 
+static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
+				     struct xdp_frame *xdpf)
+{
+	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
+	struct device *kdev = &priv->pdev->dev;
+	struct enet_cb *tx_cb_ptr;
+	dma_addr_t mapping;
+	u32 len_stat;
+
+	spin_lock(&ring->lock);
+
+	if (ring->free_bds < 1) {
+		spin_unlock(&ring->lock);
+		return false;
+	}
+
+	tx_cb_ptr = bcmgenet_get_txcb(priv, ring);
+
+	mapping = dma_map_single(kdev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(kdev, mapping)) {
+		tx_cb_ptr->skb = NULL;
+		tx_cb_ptr->xdpf = NULL;
+		bcmgenet_put_txcb(priv, ring);
+		spin_unlock(&ring->lock);
+		return false;
+	}
+
+	dma_unmap_addr_set(tx_cb_ptr, dma_addr, mapping);
+	dma_unmap_len_set(tx_cb_ptr, dma_len, xdpf->len);
+	tx_cb_ptr->skb = NULL;
+	tx_cb_ptr->xdpf = xdpf;
+
+	len_stat = (xdpf->len << DMA_BUFLENGTH_SHIFT) |
+		   (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT) |
+		   DMA_TX_APPEND_CRC | DMA_SOP | DMA_EOP;
+
+	dmadesc_set(priv, tx_cb_ptr->bd_addr, mapping, len_stat);
+
+	ring->free_bds--;
+	ring->prod_index++;
+	ring->prod_index &= DMA_P_INDEX_MASK;
+
+	bcmgenet_tdma_ring_writel(priv, ring->index, ring->prod_index,
+				  TDMA_PROD_INDEX);
+
+	spin_unlock(&ring->lock);
+
+	return true;
+}
+
 static unsigned int
 bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
 		 struct xdp_buff *xdp, struct page *rx_page)
 {
+	struct bcmgenet_priv *priv = ring->priv;
+	struct xdp_frame *xdpf;
 	unsigned int act;
 
 	act = bpf_prog_run_xdp(prog, xdp);
@@ -2310,14 +2368,23 @@ bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring, struct bpf_prog *prog,
 	switch (act) {
 	case XDP_PASS:
 		return XDP_PASS;
+	case XDP_TX:
+		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf) ||
+		    unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf))) {
+			page_pool_put_full_page(ring->page_pool, rx_page,
+						true);
+			return XDP_DROP;
+		}
+		return XDP_TX;
 	case XDP_DROP:
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_DROP;
 	default:
-		bpf_warn_invalid_xdp_action(ring->priv->dev, prog, act);
+		bpf_warn_invalid_xdp_action(priv->dev, prog, act);
 		fallthrough;
 	case XDP_ABORTED:
-		trace_xdp_exception(ring->priv->dev, prog, act);
+		trace_xdp_exception(priv->dev, prog, act);
 		page_pool_put_full_page(ring->page_pool, rx_page, true);
 		return XDP_ABORTED;
 	}
@@ -2846,7 +2913,7 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
 		.pool_size = ring->size,
 		.nid = NUMA_NO_NODE,
 		.dev = &priv->pdev->dev,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = DMA_BIDIRECTIONAL,
 		.offset = GENET_XDP_HEADROOM,
 		.max_len = RX_BUF_LENGTH,
 	};
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 1459473ac1b0..192db0defbfc 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -472,6 +472,7 @@ struct bcmgenet_rx_stats64 {
 
 struct enet_cb {
 	struct sk_buff      *skb;
+	struct xdp_frame    *xdpf;
 	struct page         *rx_page;
 	unsigned int        rx_page_offset;
 	void __iomem *bd_addr;
-- 
2.51.0


