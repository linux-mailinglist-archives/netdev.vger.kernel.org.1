Return-Path: <netdev+bounces-267580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEJ0G2twtGm2oAAAu9opvQ
	(envelope-from <netdev+bounces-267580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:15:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1758D289A12
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A8C0312D2CD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D843E3D94;
	Fri, 13 Mar 2026 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C07vzirl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wfc9iU9/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247D3E315F
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432911; cv=none; b=WVaEOivsiinEY/zy0nL9cH9zckSfwMMkXJ2MieTFcYzPr5x4NWKmyY4+c/KnbjwpuklXfjNZZwudqsGxeF6SbaHJlRt4dvf3h5ZAkuthG8jbK/RvdIm52QnWEvatAoR/j+v6VbrpQLhRB4j+Za/uSvI+linwpWVPkzYr8FBPV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432911; c=relaxed/simple;
	bh=t2odyGO+IGLq2B6olqqTh40iwUNoM0qfKhpI/o5ZP34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLnOklPEI0MufWqbdw8/w7sFV771SjS0rs8fmD+4NUt3wZFfDg6dOeI0FT7L0lqjknS17+FNodh3Gl/xSJKYSUXChYUxPMN5puVEjsrLouCAyV16aamsjKVxw+cAjAuBorasDiTmftrQKD3GzX3u0MTYVn84ZDVcbjrRpqnizTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C07vzirl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wfc9iU9/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773432905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xY9hhOht40TInltQRiAigmM9IqsG6IQGoQkoldQ2Bt0=;
	b=C07vzirlP7Md50vrOP+SSvUWUb0EbKjmWmVRzb3rth0muRF28YxUgOkSAkF29WUs/eJE+x
	qV4eekqmDy6LlYoOrds4SHUvdXmSqbreGv6KgcY1RZ6WCV+dP7QFVT32aMI4MCyyiv2C2y
	kd1ogEX5Awq5ZyLB7iyDTOVQIPTmaZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-G1prcQWMNRKyyPFb8y_T4A-1; Fri, 13 Mar 2026 16:15:03 -0400
X-MC-Unique: G1prcQWMNRKyyPFb8y_T4A-1
X-Mimecast-MFC-AGG-ID: G1prcQWMNRKyyPFb8y_T4A_1773432903
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-485355493aeso17664615e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773432902; x=1774037702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY9hhOht40TInltQRiAigmM9IqsG6IQGoQkoldQ2Bt0=;
        b=Wfc9iU9/ZRFk9bbofzXKDmiwZ5hARB5d07f0/MFtpWh47iu6uqPiEnlYATOD5jgo44
         4WfqA1/8QFUWxDRWVKoG++xYdTlMQJsK9OCBM960GIxtcpO8w9+8luS991/OCkhxa5Qp
         oG6IfPEsgY3zCCKKPRZAPDWeaIemx8yrtO1R/2amLjpm2/JrYqFW+PJMJjXKxTdUAlBf
         EOpv73kgH05pFvWsMu+K+aHFPcw1xBKW/6BvP8FQRxaJ7OabR4G7MrKBiuZ7vTkG4N4h
         gbMkI3IB6udtWb5+Jtduupk+CHjNQY405Y/Ftk2oYBvKtGAYF5vUAhf4DLAx5VzWOj57
         gOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773432902; x=1774037702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xY9hhOht40TInltQRiAigmM9IqsG6IQGoQkoldQ2Bt0=;
        b=WTouF7S374fojRo/bLmL3O3c9JtgerWr/vBbAlck0Awx7el1oxl+qx64FLBYRC9uLh
         lSIYMcCn7aFIWxrm/052fF1T6t/zd4aJFi/Uu4SKWk4HEJebx1Zwx87zNKkldYYjX5Vm
         v+vfm9zsu7LdFHe/7Yak3/4OHmbWrgdgmLzIOPlQcUbU8lzO+1rLtHtqn4lu7DrREW+V
         YqMaPfYxKpzySmyn+ZFLqiP6eYlA5s7QMpjittq7XvoVBG2x2q2Bo1BOsqY0HmYvzdkn
         99HktCJ1wEB5drkO1lBrJeA1lDiLt+BSLjizBAYrcB2MIU90OCsDVMpLV2+n52ypzDK5
         zpcw==
X-Gm-Message-State: AOJu0YzSz9uHt291VKIqiyi3JuaVEV28rNSRsi4TWQYPhOxVHMOXmfpW
	KGeQfqr0Afn+dNS5Jh+Rmkc0d5r8wV9FVSkzuV7snrnpdNXUZFRPOptGZe0Im90/MXuUMxSen97
	uGP/BuRrW2hSZkkosy6b5dYOK66zSiIb2eHhu7A4eU81tHMVHaCdVRSPnVHh6VINYEAsgR+6HNt
	3GDqouacmYp/ZHLhTIaSTFZMSZIvHgNMw+pOwYlQ+iOQ==
X-Gm-Gg: ATEYQzx4/oUpaIY8WnE6mE7pMSD8MnTeDaIJPF2tUzZKR/FRnU0fnKumrQttuJggXGD
	tbBenCUf7U/JzJ5NCvPRZJ2wVGO22KYCB+QQcWShLKQ1eDOTjI21zuse2Nj5xdkela2VtpM71H9
	IIRVT3L6PPy7l4AZAiNmEaFiQ/q4LeRPtRuHdhqsmX572o2lKTAzPV61U2v1awP9PVvRvaj+JnM
	7jULRS8JJ2q/lCukbefd7O/pgpBUELXxgApFQ90WggduUTJx6QuqW1Hc+S/dj8rFL3/u4Aydp41
	rJM+Y/zu7zUb78u3Qh+nn8PyKg0x+WbIOPk1wa+3MYQRm5mUEdaP2W7ATtn4yEMdk0bMtXJc3JG
	WfFHS+yWL1S34z2Ew71paYTKgpGrNa9wjwhAlkr/wm1BsGGjX/CyPj7Xuwo8=
X-Received: by 2002:a05:600c:3552:b0:485:4438:6ef6 with SMTP id 5b1f17b1804b1-485566f79bcmr75120555e9.18.1773432901454;
        Fri, 13 Mar 2026 13:15:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3552:b0:485:4438:6ef6 with SMTP id 5b1f17b1804b1-485566f79bcmr75119965e9.18.1773432900818;
        Fri, 13 Mar 2026 13:15:00 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556400f31sm36076075e9.3.2026.03.13.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:14:58 -0700 (PDT)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v5 3/8] net: macb: Add page pool support handle multi-descriptor frame rx
Date: Fri, 13 Mar 2026 21:14:28 +0100
Message-ID: <20260313201433.2346119-4-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313201433.2346119-1-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267580-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1758D289A12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the page pool allocator for the data buffers and enable skb
recycling support, instead of relying on netdev_alloc_skb
allocating the entire skb during the refill.

The patch also add support for receiving network frames that span
multiple DMA descriptors in the Cadence MACB/GEM Ethernet driver.

The patch removes the requirement that limited frame reception to
a single descriptor (RX_SOF && RX_EOF), also avoiding potential
contiguous multi-page allocation for large frames.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/Kconfig     |   1 +
 drivers/net/ethernet/cadence/macb.h      |   5 +
 drivers/net/ethernet/cadence/macb_main.c | 412 ++++++++++++++++-------
 3 files changed, 292 insertions(+), 126 deletions(-)

diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 5b2a461dfd28..ae500f717433 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -25,6 +25,7 @@ config MACB
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select PHYLINK
 	select CRC32
+	select PAGE_POOL
 	help
 	  The Cadence MACB ethernet interface is found on many Atmel AT32 and
 	  AT91 parts.  This driver also supports the Cadence GEM (Gigabit
diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index d84ec528c12f..2c6ba1b63aab 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/phy/phy.h>
 #include <linux/workqueue.h>
+#include <net/page_pool/helpers.h>
 
 #define MACB_GREGS_NBR 16
 #define MACB_GREGS_VERSION 2
@@ -1281,6 +1282,8 @@ struct macb_queue {
 	void			*rx_buffers;
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
+	struct page_pool	*page_pool;
+	struct sk_buff		*skb;
 };
 
 struct ethtool_rx_fs_item {
@@ -1304,6 +1307,8 @@ struct macb {
 	struct macb_dma_desc	*rx_ring_tieoff;
 	dma_addr_t		rx_ring_tieoff_dma;
 	size_t			rx_buffer_size;
+	size_t			rx_headroom;
+	unsigned int		rx_ip_align;
 
 	unsigned int		rx_ring_size;
 	unsigned int		tx_ring_size;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2ed00e200933..06ad8c8ec036 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1474,14 +1474,57 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static int gem_rx_refill(struct macb_queue *queue)
+static int gem_rx_data_len(struct macb *bp, struct macb_queue *queue,
+			   u32 desc_ctrl, bool rx_sof, bool rx_eof)
+{
+	int len;
+
+	if (unlikely(!rx_sof && !queue->skb)) {
+		if (net_ratelimit())
+			netdev_err(bp->dev,
+				   "Received non-starting frame while expecting a starting one\n");
+		return -1;
+	}
+
+	if (rx_eof) {
+		len = desc_ctrl & bp->rx_frm_len_mask;
+	} else {
+		len = bp->rx_buffer_size;
+		/* First frame on !RSC skips NET_IP_ALIGN */
+		if (rx_sof)
+			len -= bp->rx_ip_align;
+	}
+
+	if (rx_eof && !rx_sof) {
+		if (unlikely(queue->skb->len > len)) {
+			if (net_ratelimit())
+				netdev_err(bp->dev,
+					   "Unexpected frame len: %d\n", len);
+			return -1;
+		}
+
+		len -= queue->skb->len;
+	}
+
+	return len;
+}
+
+static unsigned int gem_total_rx_buffer_size(struct macb *bp)
+{
+	return SKB_HEAD_ALIGN(bp->rx_buffer_size + NET_SKB_PAD);
+}
+
+static int gem_rx_refill(struct macb_queue *queue, bool napi)
 {
-	unsigned int		entry;
-	struct sk_buff		*skb;
-	dma_addr_t		paddr;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	unsigned int entry;
+	struct page *page;
+	dma_addr_t paddr;
+	gfp_t gfp_alloc;
 	int err = 0;
+	void *data;
+	int offset;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1493,25 +1536,26 @@ static int gem_rx_refill(struct macb_queue *queue)
 		desc = macb_rx_desc(queue, entry);
 
 		if (!queue->rx_buff[entry]) {
-			/* allocate sk_buff for this free entry in ring */
-			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
-			if (unlikely(!skb)) {
-				netdev_err(bp->dev,
-					   "Unable to allocate sk_buff\n");
+			gfp_alloc = napi ? GFP_ATOMIC : GFP_KERNEL;
+			page = page_pool_alloc_frag(queue->page_pool, &offset,
+						    gem_total_rx_buffer_size(bp),
+						    gfp_alloc | __GFP_NOWARN);
+			if (!page) {
+				if (net_ratelimit())
+					netdev_err(bp->dev,
+						   "Unable to allocate rx buffer\n");
 				err = -ENOMEM;
 				break;
 			}
 
-			/* now fill corresponding descriptor entry */
-			paddr = dma_map_single(&bp->pdev->dev, skb->data,
-					       bp->rx_buffer_size,
-					       DMA_FROM_DEVICE);
-			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
-				dev_kfree_skb(skb);
-				break;
-			}
+			paddr = page_pool_get_dma_addr(page) + NET_SKB_PAD + offset;
+
+			dma_sync_single_for_device(&bp->pdev->dev,
+						   paddr, bp->rx_buffer_size,
+						   page_pool_get_dma_dir(queue->page_pool));
 
-			queue->rx_buff[entry] = skb;
+			data = page_address(page) + offset;
+			queue->rx_buff[entry] = data;
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
@@ -1521,20 +1565,6 @@ static int gem_rx_refill(struct macb_queue *queue)
 			 */
 			dma_wmb();
 			macb_set_addr(bp, desc, paddr);
-
-			/* Properly align Ethernet header.
-			 *
-			 * Hardware can add dummy bytes if asked using the RBOF
-			 * field inside the NCFGR register. That feature isn't
-			 * available if hardware is RSC capable.
-			 *
-			 * We cannot fallback to doing the 2-byte shift before
-			 * DMA mapping because the address field does not allow
-			 * setting the low 2/3 bits.
-			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
-			 */
-			if (!(bp->caps & MACB_CAPS_RSC))
-				skb_reserve(skb, NET_IP_ALIGN);
 		} else {
 			desc->ctrl = 0;
 			dma_wmb();
@@ -1575,17 +1605,21 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
+	struct skb_shared_info *shinfo;
 	struct macb *bp = queue->bp;
-	unsigned int		len;
-	unsigned int		entry;
-	struct sk_buff		*skb;
-	struct macb_dma_desc	*desc;
-	int			count = 0;
+	struct macb_dma_desc *desc;
+	unsigned int entry;
+	struct page *page;
+	void *buff_head;
+	int count = 0;
+	int data_len;
+	int nr_frags;
+
 
 	while (count < budget) {
-		u32 ctrl;
+		bool rxused, first_frame, last_frame;
 		dma_addr_t addr;
-		bool rxused;
+		u32 ctrl;
 
 		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 		desc = macb_rx_desc(queue, entry);
@@ -1607,58 +1641,124 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		queue->rx_tail++;
 		count++;
 
-		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
-			netdev_err(bp->dev,
-				   "not whole frame pointed by descriptor\n");
+		buff_head = queue->rx_buff[entry];
+		if (unlikely(!buff_head)) {
+			if (net_ratelimit())
+				netdev_err(bp->dev,
+					   "inconsistent Rx descriptor chain\n");
 			bp->dev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_buff[entry];
-		if (unlikely(!skb)) {
-			netdev_err(bp->dev,
-				   "inconsistent Rx descriptor chain\n");
-			bp->dev->stats.rx_dropped++;
-			queue->stats.rx_dropped++;
-			break;
+
+		first_frame = ctrl & MACB_BIT(RX_SOF);
+		last_frame = ctrl & MACB_BIT(RX_EOF);
+
+		data_len = gem_rx_data_len(bp, queue, ctrl, first_frame,
+					   last_frame);
+		if (data_len < 0)
+			goto free_frags;
+
+		addr += first_frame ? bp->rx_ip_align : 0;
+
+		dma_sync_single_for_cpu(&bp->pdev->dev,	addr, data_len,
+					page_pool_get_dma_dir(queue->page_pool));
+
+		if (first_frame) {
+			if (unlikely(queue->skb)) {
+				if (net_ratelimit())
+					netdev_warn(bp->dev, "Previous packet incomplete\n");
+				dev_kfree_skb(queue->skb);
+				bp->dev->stats.rx_dropped++;
+				queue->stats.rx_dropped++;
+			}
+
+			queue->skb = napi_build_skb(buff_head, gem_total_rx_buffer_size(bp));
+			if (unlikely(!queue->skb)) {
+				if (net_ratelimit())
+					netdev_err(bp->dev,
+						   "Unable to allocate sk_buff\n");
+				goto free_frags;
+			}
+
+			/* Properly align Ethernet header.
+			 *
+			 * Hardware can add dummy bytes if asked using the RBOF
+			 * field inside the NCFGR register. That feature isn't
+			 * available if hardware is RSC capable.
+			 *
+			 * We cannot fallback to doing the 2-byte shift before
+			 * DMA mapping because the address field does not allow
+			 * setting the low 2/3 bits.
+			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
+			 */
+			skb_reserve(queue->skb, bp->rx_headroom);
+			skb_mark_for_recycle(queue->skb);
+			skb_put(queue->skb, data_len);
+		} else {
+			shinfo = skb_shinfo(queue->skb);
+			page = virt_to_head_page(buff_head);
+			nr_frags = shinfo->nr_frags;
+
+			if (unlikely(nr_frags >= ARRAY_SIZE(shinfo->frags)))
+				goto free_frags;
+
+			skb_add_rx_frag(queue->skb, nr_frags, page,
+					buff_head - page_address(page) + NET_SKB_PAD,
+					data_len, gem_total_rx_buffer_size(bp));
 		}
+
 		/* now everything is ready for receiving packet */
 		queue->rx_buff[entry] = NULL;
-		len = ctrl & bp->rx_frm_len_mask;
-
-		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
 
-		skb_put(skb, len);
-		dma_unmap_single(&bp->pdev->dev, addr,
-				 bp->rx_buffer_size, DMA_FROM_DEVICE);
+		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
 
-		skb->protocol = eth_type_trans(skb, bp->dev);
-		skb_checksum_none_assert(skb);
-		if (bp->dev->features & NETIF_F_RXCSUM &&
-		    !(bp->dev->flags & IFF_PROMISC) &&
-		    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		if (last_frame) {
+			bp->dev->stats.rx_packets++;
+			queue->stats.rx_packets++;
+			bp->dev->stats.rx_bytes += queue->skb->len;
+			queue->stats.rx_bytes += queue->skb->len;
 
-		bp->dev->stats.rx_packets++;
-		queue->stats.rx_packets++;
-		bp->dev->stats.rx_bytes += skb->len;
-		queue->stats.rx_bytes += skb->len;
-
-		gem_ptp_do_rxstamp(bp, skb, desc);
+			queue->skb->protocol = eth_type_trans(queue->skb, bp->dev);
+			skb_checksum_none_assert(queue->skb);
+			if (bp->dev->features & NETIF_F_RXCSUM &&
+			    !(bp->dev->flags & IFF_PROMISC) &&
+			    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
+				queue->skb->ip_summed = CHECKSUM_UNNECESSARY;
 
+			gem_ptp_do_rxstamp(bp, queue->skb, desc);
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
-		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
-			    skb->len, skb->csum);
-		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			       skb_mac_header(skb), 16, true);
-		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			       skb->data, 32, true);
+			netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
+				    queue->skb->len, queue->skb->csum);
+			print_hex_dump_debug(" mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
+					     skb_mac_header(queue->skb), 16, true);
+			print_hex_dump_debug("data: ", DUMP_PREFIX_ADDRESS, 16, 1,
+					     queue->skb->data, 32, true);
 #endif
 
-		napi_gro_receive(napi, skb);
+			napi_gro_receive(napi, queue->skb);
+			queue->skb = NULL;
+		}
+
+		continue;
+
+free_frags:
+		if (queue->skb) {
+			dev_kfree_skb(queue->skb);
+			queue->skb = NULL;
+		}
+
+		if (buff_head)
+			page_pool_put_full_page(queue->page_pool,
+						virt_to_head_page(buff_head),
+						false);
+
+		bp->dev->stats.rx_dropped++;
+		queue->stats.rx_dropped++;
+		queue->rx_buff[entry] = NULL;
 	}
 
-	gem_rx_refill(queue);
+	gem_rx_refill(queue, true);
 
 	return count;
 }
@@ -2593,12 +2693,22 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return ret;
 }
 
-static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
+static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
+	unsigned int overhead;
+	size_t size;
+
 	if (!macb_is_gem(bp)) {
 		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		bp->rx_buffer_size = size;
+		size = mtu + ETH_HLEN + ETH_FCS_LEN;
+		bp->rx_buffer_size = SKB_DATA_ALIGN(size + bp->rx_ip_align);
+		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
+			overhead = bp->rx_headroom +
+				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+			bp->rx_buffer_size = rounddown(PAGE_SIZE - overhead,
+						       RX_BUFFER_MULTIPLE);
+		}
 
 		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
 			netdev_dbg(bp->dev,
@@ -2609,17 +2719,16 @@ static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
 		}
 	}
 
-	netdev_dbg(bp->dev, "mtu [%u] rx_buffer_size [%zu]\n",
-		   bp->dev->mtu, bp->rx_buffer_size);
+	netdev_dbg(bp->dev, "mtu [%u] rx_buffer_size [%zu] rx_headroom [%zu] total [%u]\n",
+		   bp->dev->mtu, bp->rx_buffer_size, bp->rx_headroom,
+		   gem_total_rx_buffer_size(bp));
 }
 
 static void gem_free_rx_buffers(struct macb *bp)
 {
-	struct sk_buff		*skb;
-	struct macb_dma_desc	*desc;
 	struct macb_queue *queue;
-	dma_addr_t		addr;
 	unsigned int q;
+	void *data;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2627,22 +2736,25 @@ static void gem_free_rx_buffers(struct macb *bp)
 			continue;
 
 		for (i = 0; i < bp->rx_ring_size; i++) {
-			skb = queue->rx_buff[i];
-
-			if (!skb)
+			data = queue->rx_buff[i];
+			if (!data)
 				continue;
 
-			desc = macb_rx_desc(queue, i);
-			addr = macb_get_addr(bp, desc);
+			page_pool_put_full_page(queue->page_pool,
+						virt_to_head_page(data),
+						false);
+			queue->rx_buff[i] = NULL;
+		}
 
-			dma_unmap_single(&bp->pdev->dev, addr, bp->rx_buffer_size,
-					DMA_FROM_DEVICE);
-			dev_kfree_skb_any(skb);
-			skb = NULL;
+		if (queue->skb) {
+			dev_kfree_skb(queue->skb);
+			queue->skb = NULL;
 		}
 
 		kfree(queue->rx_buff);
 		queue->rx_buff = NULL;
+		page_pool_destroy(queue->page_pool);
+		queue->page_pool = NULL;
 	}
 }
 
@@ -2704,13 +2816,12 @@ static int gem_alloc_rx_buffers(struct macb *bp)
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = bp->rx_ring_size * sizeof(struct sk_buff *);
+		size = bp->rx_ring_size * sizeof(*queue->rx_buff);
 		queue->rx_buff = kzalloc(size, GFP_KERNEL);
 		if (!queue->rx_buff)
 			return -ENOMEM;
 		else
-			netdev_dbg(bp->dev,
-				   "Allocated %d RX buff entries at %p\n",
+			netdev_dbg(bp->dev, "Allocated %d RX buff entries at %p\n",
 				   bp->rx_ring_size, queue->rx_buff);
 	}
 	return 0;
@@ -2798,6 +2909,40 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
+static int gem_create_page_pool(struct macb_queue *queue)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP,
+		.pool_size = queue->bp->rx_ring_size,
+		.nid = NUMA_NO_NODE,
+		.dma_dir = DMA_FROM_DEVICE,
+		.dev = &queue->bp->pdev->dev,
+		.netdev = queue->bp->dev,
+		.napi = &queue->napi_rx,
+		.max_len = PAGE_SIZE,
+	};
+	struct page_pool *pool;
+	int err = 0;
+
+	/* This can happen in the case of HRESP error.
+	 * Do nothing as page pool is already existing.
+	 */
+	if (queue->page_pool)
+		return err;
+
+	pool = page_pool_create(&pp_params);
+	if (IS_ERR(pool)) {
+		netdev_err(queue->bp->dev, "cannot create rx page pool\n");
+		err = PTR_ERR(pool);
+		pool = NULL;
+	}
+
+	queue->page_pool = pool;
+
+	return err;
+}
+
 static void macb_init_tieoff(struct macb *bp)
 {
 	struct macb_dma_desc *desc = bp->rx_ring_tieoff;
@@ -2833,12 +2978,19 @@ static int gem_init_rings(struct macb *bp, bool fail_early)
 		queue->rx_tail = 0;
 		queue->rx_prepared_head = 0;
 
+		/* This is a hard failure. In case of HRESP error
+		 * recovery we always reuse the existing page pool.
+		 */
+		last_err = gem_create_page_pool(queue);
+		if (last_err)
+			break;
+
 		/* We get called in two cases:
 		 *  - open: we can propagate alloc errors (so fail early),
 		 *  - HRESP error: cannot propagate, we attempt to reinit
 		 *    all queues in case of failure.
 		 */
-		err = gem_rx_refill(queue);
+		err = gem_rx_refill(queue, false);
 		if (err) {
 			last_err = err;
 			if (fail_early)
@@ -2982,39 +3134,40 @@ static void macb_configure_dma(struct macb *bp)
 	unsigned int q;
 	u32 dmacfg;
 
-	buffer_size = bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
-	if (macb_is_gem(bp)) {
-		dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			if (q)
-				queue_writel(queue, RBQS, buffer_size);
-			else
-				dmacfg |= GEM_BF(RXBS, buffer_size);
-		}
-		if (bp->dma_burst_length)
-			dmacfg = GEM_BFINS(FBLDO, bp->dma_burst_length, dmacfg);
-		dmacfg |= GEM_BIT(TXPBMS) | GEM_BF(RXBMS, -1L);
-		dmacfg &= ~GEM_BIT(ENDIA_PKT);
+	if (!macb_is_gem((bp)))
+		return;
 
-		if (bp->native_io)
-			dmacfg &= ~GEM_BIT(ENDIA_DESC);
+	buffer_size = bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
+	dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		if (q)
+			queue_writel(queue, RBQS, buffer_size);
 		else
-			dmacfg |= GEM_BIT(ENDIA_DESC); /* CPU in big endian */
+			dmacfg |= GEM_BF(RXBS, buffer_size);
+	}
+	if (bp->dma_burst_length)
+		dmacfg = GEM_BFINS(FBLDO, bp->dma_burst_length, dmacfg);
+	dmacfg |= GEM_BIT(TXPBMS) | GEM_BF(RXBMS, -1L);
+	dmacfg &= ~GEM_BIT(ENDIA_PKT);
 
-		if (bp->dev->features & NETIF_F_HW_CSUM)
-			dmacfg |= GEM_BIT(TXCOEN);
-		else
-			dmacfg &= ~GEM_BIT(TXCOEN);
+	if (bp->native_io)
+		dmacfg &= ~GEM_BIT(ENDIA_DESC);
+	else
+		dmacfg |= GEM_BIT(ENDIA_DESC); /* CPU in big endian */
 
-		dmacfg &= ~GEM_BIT(ADDR64);
-		if (macb_dma64(bp))
-			dmacfg |= GEM_BIT(ADDR64);
-		if (macb_dma_ptp(bp))
-			dmacfg |= GEM_BIT(RXEXT) | GEM_BIT(TXEXT);
-		netdev_dbg(bp->dev, "Cadence configure DMA with 0x%08x\n",
-			   dmacfg);
-		gem_writel(bp, DMACFG, dmacfg);
-	}
+	if (bp->dev->features & NETIF_F_HW_CSUM)
+		dmacfg |= GEM_BIT(TXCOEN);
+	else
+		dmacfg &= ~GEM_BIT(TXCOEN);
+
+	dmacfg &= ~GEM_BIT(ADDR64);
+	if (macb_dma64(bp))
+		dmacfg |= GEM_BIT(ADDR64);
+	if (macb_dma_ptp(bp))
+		dmacfg |= GEM_BIT(RXEXT) | GEM_BIT(TXEXT);
+	netdev_dbg(bp->dev, "Cadence configure DMA with 0x%08x\n",
+		   dmacfg);
+	gem_writel(bp, DMACFG, dmacfg);
 }
 
 static void macb_init_hw(struct macb *bp)
@@ -3177,7 +3330,6 @@ static void macb_set_rx_mode(struct net_device *dev)
 
 static int macb_open(struct net_device *dev)
 {
-	size_t bufsz = dev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
 	struct macb *bp = netdev_priv(dev);
 	struct macb_queue *queue;
 	unsigned int q;
@@ -3190,7 +3342,7 @@ static int macb_open(struct net_device *dev)
 		return err;
 
 	/* RX buffers initialization */
-	macb_init_rx_buffer_size(bp, bufsz);
+	macb_init_rx_buffer_size(bp, dev->mtu);
 
 	err = macb_alloc_consistent(bp);
 	if (err) {
@@ -5846,6 +5998,14 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		goto err_out_phy_exit;
 
+	if (macb_is_gem(bp)) {
+		bp->rx_headroom = NET_SKB_PAD;
+		if (!(bp->caps & MACB_CAPS_RSC)) {
+			bp->rx_ip_align = NET_IP_ALIGN;
+			bp->rx_headroom += NET_IP_ALIGN;
+		}
+	}
+
 	netif_carrier_off(dev);
 
 	err = register_netdev(dev);
-- 
2.53.0


