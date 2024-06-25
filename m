Return-Path: <netdev+bounces-106534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4297916A9F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376F9B21130
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD8116E863;
	Tue, 25 Jun 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl9mgqRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56016B72D
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326189; cv=none; b=UTz5b/W/L2dam/0jT0FgT/Djpg6JvEyofWKxGLAt1Hg6+uKTHNUaHYpy7iIEooYC48ModDBeGKuSzL0HOP8Fl7qEkK2FJVkQIHGXD5gOXIlbCdlMyFhD7JQiFfl/wSLn4CV/mKmVlMZc8ZNguZtgqsb6rgbp46NlkdoW+dinKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326189; c=relaxed/simple;
	bh=sHFTEQUXYC6SYxygJWLZtZXXGVag9Ck6v4mKM6/l13c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDAH0rgl7Uz/3pZRpqH+/KP5Y8BgIsOPPPBZT14NMhu07E0CklzzZAn3iIFLf9GayXg5A4xSkKp/VlRir+8TuJtaR69LX2l7MdOTUB/rbLm3IWuY8iFMCZ57vciTs3NxOWSGmER1pHWQ5xrDz3WXVP2WiNObGf7jafppaCOizr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl9mgqRv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so14684105ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326187; x=1719930987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/+Z14QDcKBE5pt3Nvntp7errpd+MK4gz9H2SE751JF4=;
        b=Jl9mgqRv0IQMn6otMPdB0iN6isDslom8YcyMxPmYQFKnJg3fx3gcU6ZbBoMC6xcPdQ
         pnVfzF8aZyQXIkbOpXUwj2oJ3GXDPPKLTywkzbm5SuegPIYNYis40j7i6RdIL5/DaDOu
         ao9lClChVVBw24nk1zLBKtK8YjApZhAyDfPrIGZZ6aedDtyCNh1ObvbS52YjbGH3165r
         77SnAeb37slANebXblqQGEbtEz4oL20upiCTy/v8mTlMeHsZH//GPRqtQBYW1UajTzfx
         bXKpwJPmOSFiGKhKkiATCdb6xnp7bdX1k1cEoB547vedNH/ZSD3MdBQFfXc8Ricgw9fY
         JxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326187; x=1719930987;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+Z14QDcKBE5pt3Nvntp7errpd+MK4gz9H2SE751JF4=;
        b=oX1foDSdYEyyNOhi/Rs7W7nG4NEfMyIL3OkAG/NN1j1gVdFV7WJVw2oHTKndtg5laa
         ngC6RthVZYmgBg/1RlWmZBQz/H5X4mcSSEx9NIdykV0Zm0oC0CXotjV7oU8VkRm90m0O
         J0SPTwXUCofrrf4tim+kJbZ1BeS++m7dWvGbM2ijb/a9Sye5Q5I9rrxHI+ABvAzeQ04u
         Mu1pJ8c+s4bw0QzhTBqt5t/mc2e5SaPcD5r/j4AVKAE8qDFiwmdDeoaDmF3alXnE9rBm
         W7xaneOn9o3toT/tsU8Ma4/RZCVbk8utQsvq6d2hFVF29UBWMiljqbesSkhC3CYQjKVe
         Bt5w==
X-Gm-Message-State: AOJu0YwtGuqVjPujroWAB0prdxUSJIPNXgu9VNQVBdD8nBhCmAh1wEEH
	5pburD9X5kwOY+X+KZDTsLq4NLfFCw9Uya1VjK0bSCmn38PjKnvM
X-Google-Smtp-Source: AGHT+IGfLJfgqFdCxJJWxB1VFdsJxAabzBIzw/7pDuNrvdK+qXlJUAzSH4/S4leTFpMR8xpM3zUL7A==
X-Received: by 2002:a17:903:32d2:b0:1f7:1931:7a8f with SMTP id d9443c01a7336-1fa15944201mr80168345ad.64.1719326186924;
        Tue, 25 Jun 2024 07:36:26 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb29e7sm81678785ad.261.2024.06.25.07.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:36:26 -0700 (PDT)
Subject: [net-next PATCH v2 13/15] eth: fbnic: Add basic Rx handling
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:36:25 -0700
Message-ID: 
 <171932618549.3072535.13175899786992648336.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Handle Rx packets with basic csum and Rx hash offloads.

NIC writes back to the completion ring a head buffer descriptor
(data buffer allocated from header pages), variable number of payload
descriptors (data buffers in payload pages), an optional metadata
descriptor (type 2) and finally the primary metadata descriptor
(type 3).

This format makes scatter support fairly easy - start gathering
the pages when we see head page, gather until we see the primary
metadata descriptor, do the processing. Use XDP infra to collect
the packet fragments as we traverse the descriptors. XDP itself
is not supported yet, but it will be soon.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |   63 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |    3 
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   |  328 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h   |    2 
 5 files changed, 397 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 3ebb392c3099..261e13edcb69 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -121,6 +121,69 @@ enum {
 #define FBNIC_BD_PAGE_ID_MASK \
 	(FBNIC_BD_DESC_ID_MASK & ~FBNIC_BD_FRAG_ID_MASK)
 
+/* Rx Completion Queue Descriptors */
+#define FBNIC_RCD_TYPE_MASK			DESC_GENMASK(62, 61)
+enum {
+	FBNIC_RCD_TYPE_HDR_AL	= 0,
+	FBNIC_RCD_TYPE_PAY_AL	= 1,
+	FBNIC_RCD_TYPE_OPT_META	= 2,
+	FBNIC_RCD_TYPE_META	= 3,
+};
+
+#define FBNIC_RCD_DONE				DESC_BIT(63)
+
+/* Address/Length Completion Descriptors */
+#define FBNIC_RCD_AL_BUFF_ID_MASK		DESC_GENMASK(15, 0)
+#define FBNIC_RCD_AL_BUFF_FRAG_MASK		(FBNIC_BD_FRAG_COUNT - 1)
+#define FBNIC_RCD_AL_BUFF_PAGE_MASK \
+	(FBNIC_RCD_AL_BUFF_ID_MASK & ~FBNIC_RCD_AL_BUFF_FRAG_MASK)
+#define FBNIC_RCD_AL_BUFF_LEN_MASK		DESC_GENMASK(28, 16)
+#define FBNIC_RCD_AL_BUFF_OFF_MASK		DESC_GENMASK(43, 32)
+#define FBNIC_RCD_AL_PAGE_FIN			DESC_BIT(60)
+
+/* Header AL specific values */
+#define FBNIC_RCD_HDR_AL_OVERFLOW		DESC_BIT(53)
+#define FBNIC_RCD_HDR_AL_DMA_HINT_MASK		DESC_GENMASK(59, 54)
+enum {
+	FBNIC_RCD_HDR_AL_DMA_HINT_NONE  = 0,
+	FBNIC_RCD_HDR_AL_DMA_HINT_L2	= 1,
+	FBNIC_RCD_HDR_AL_DMA_HINT_L3	= 2,
+	FBNIC_RCD_HDR_AL_DMA_HINT_L4	= 4,
+};
+
+/* Optional Metadata Completion Descriptors */
+#define FBNIC_RCD_OPT_META_TS_MASK		DESC_GENMASK(39, 0)
+#define FBNIC_RCD_OPT_META_ACTION_MASK		DESC_GENMASK(45, 40)
+#define FBNIC_RCD_OPT_META_ACTION		DESC_BIT(57)
+#define FBNIC_RCD_OPT_META_TS			DESC_BIT(58)
+#define FBNIC_RCD_OPT_META_TYPE_MASK		DESC_GENMASK(60, 59)
+
+/* Metadata Completion Descriptors */
+#define FBNIC_RCD_META_RSS_HASH_MASK		DESC_GENMASK(31, 0)
+#define FBNIC_RCD_META_L2_CSUM_MASK		DESC_GENMASK(47, 32)
+#define FBNIC_RCD_META_L3_TYPE_MASK		DESC_GENMASK(49, 48)
+enum {
+	FBNIC_RCD_META_L3_TYPE_OTHER	= 0,
+	FBNIC_RCD_META_L3_TYPE_IPV4	= 1,
+	FBNIC_RCD_META_L3_TYPE_IPV6	= 2,
+	FBNIC_RCD_META_L3_TYPE_V6V6	= 3,
+};
+
+#define FBNIC_RCD_META_L4_TYPE_MASK		DESC_GENMASK(51, 50)
+enum {
+	FBNIC_RCD_META_L4_TYPE_OTHER	= 0,
+	FBNIC_RCD_META_L4_TYPE_TCP	= 1,
+	FBNIC_RCD_META_L4_TYPE_UDP	= 2,
+};
+
+#define FBNIC_RCD_META_L4_CSUM_UNNECESSARY	DESC_BIT(52)
+#define FBNIC_RCD_META_ERR_MAC_EOP		DESC_BIT(53)
+#define FBNIC_RCD_META_ERR_TRUNCATED_FRAME	DESC_BIT(54)
+#define FBNIC_RCD_META_ERR_PARSER		DESC_BIT(55)
+#define FBNIC_RCD_META_UNCORRECTABLE_ERR_MASK	\
+	(FBNIC_RCD_META_ERR_MAC_EOP | FBNIC_RCD_META_ERR_TRUNCATED_FRAME)
+#define FBNIC_RCD_META_ECN			DESC_BIT(60)
+
 /* Register Definitions
  *
  * The registers are laid as indexes into an le32 array. As such the actual
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 8032f87e5351..cc7e2f38c7c2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -169,8 +169,10 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	fbnic_reset_queues(fbn, default_queues, default_queues);
 
 	netdev->features |=
+		NETIF_F_RXHASH |
 		NETIF_F_SG |
-		NETIF_F_HW_CSUM;
+		NETIF_F_HW_CSUM |
+		NETIF_F_RXCSUM;
 
 	netdev->hw_features |= netdev->features;
 	netdev->vlan_features |= netdev->features;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 1c0194ca8864..5bca1e83a608 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -195,6 +195,9 @@ static void fbnic_service_task(struct work_struct *work)
 
 	fbnic_health_check(fbd);
 
+	if (netif_carrier_ok(fbd->netdev))
+		fbnic_napi_depletion_check(fbd->netdev);
+
 	if (netif_running(fbd->netdev))
 		schedule_delayed_work(&fbd->service_task, HZ);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index fce38429ccf0..d04b66bf10ca 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -8,6 +8,7 @@
 #include <net/page_pool/helpers.h>
 
 #include "fbnic.h"
+#include "fbnic_csr.h"
 #include "fbnic_netdev.h"
 #include "fbnic_txrx.h"
 
@@ -131,6 +132,24 @@ fbnic_tx_offloads(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 	return false;
 }
 
+static void
+fbnic_rx_csum(u64 rcd, struct sk_buff *skb, struct fbnic_ring *rcq)
+{
+	skb_checksum_none_assert(skb);
+
+	if (unlikely(!(skb->dev->features & NETIF_F_RXCSUM)))
+		return;
+
+	if (FIELD_GET(FBNIC_RCD_META_L4_CSUM_UNNECESSARY, rcd)) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	} else {
+		u16 csum = FIELD_GET(FBNIC_RCD_META_L2_CSUM_MASK, rcd);
+
+		skb->ip_summed = CHECKSUM_COMPLETE;
+		skb->csum = (__force __wsum)csum;
+	}
+}
+
 static bool
 fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 {
@@ -364,6 +383,16 @@ static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
 	rx_buf->page = page;
 }
 
+static struct page *fbnic_page_pool_get(struct fbnic_ring *ring,
+					unsigned int idx)
+{
+	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
+
+	rx_buf->pagecnt_bias--;
+
+	return rx_buf->page;
+}
+
 static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
 				  struct fbnic_napi_vector *nv, int budget)
 {
@@ -508,6 +537,103 @@ static void fbnic_fill_bdq(struct fbnic_napi_vector *nv, struct fbnic_ring *bdq)
 	}
 }
 
+static unsigned int fbnic_hdr_pg_start(unsigned int pg_off)
+{
+	/* The headroom of the first header may be larger than FBNIC_RX_HROOM
+	 * due to alignment. So account for that by just making the page
+	 * offset 0 if we are starting at the first header.
+	 */
+	if (ALIGN(FBNIC_RX_HROOM, 128) > FBNIC_RX_HROOM &&
+	    pg_off == ALIGN(FBNIC_RX_HROOM, 128))
+		return 0;
+
+	return pg_off - FBNIC_RX_HROOM;
+}
+
+static unsigned int fbnic_hdr_pg_end(unsigned int pg_off, unsigned int len)
+{
+	/* Determine the end of the buffer by finding the start of the next
+	 * and then subtracting the headroom from that frame.
+	 */
+	pg_off += len + FBNIC_RX_TROOM + FBNIC_RX_HROOM;
+
+	return ALIGN(pg_off, 128) - FBNIC_RX_HROOM;
+}
+
+static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
+			      struct fbnic_pkt_buff *pkt,
+			      struct fbnic_q_triad *qt)
+{
+	unsigned int hdr_pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+	unsigned int hdr_pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
+	struct page *page = fbnic_page_pool_get(&qt->sub0, hdr_pg_idx);
+	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
+	unsigned int frame_sz, hdr_pg_start, hdr_pg_end, headroom;
+	unsigned char *hdr_start;
+
+	/* data_hard_start should always be NULL when this is called */
+	WARN_ON_ONCE(pkt->buff.data_hard_start);
+
+	/* Short-cut the end calculation if we know page is fully consumed */
+	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
+		     FBNIC_BD_FRAG_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
+	hdr_pg_start = fbnic_hdr_pg_start(hdr_pg_off);
+
+	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
+	frame_sz = hdr_pg_end - hdr_pg_start;
+	xdp_init_buff(&pkt->buff, frame_sz, NULL);
+	hdr_pg_start += (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
+			FBNIC_BD_FRAG_SIZE;
+
+	/* Sync DMA buffer */
+	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
+				      hdr_pg_start, frame_sz,
+				      DMA_BIDIRECTIONAL);
+
+	/* Build frame around buffer */
+	hdr_start = page_address(page) + hdr_pg_start;
+
+	xdp_prepare_buff(&pkt->buff, hdr_start, headroom,
+			 len - FBNIC_RX_PAD, true);
+
+	pkt->data_truesize = 0;
+	pkt->data_len = 0;
+	pkt->nr_frags = 0;
+}
+
+static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
+			      struct fbnic_pkt_buff *pkt,
+			      struct fbnic_q_triad *qt)
+{
+	unsigned int pg_idx = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+	unsigned int pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
+	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
+	struct page *page = fbnic_page_pool_get(&qt->sub1, pg_idx);
+	struct skb_shared_info *shinfo;
+	unsigned int truesize;
+
+	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
+		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
+
+	pg_off += (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
+		  FBNIC_BD_FRAG_SIZE;
+
+	/* Sync DMA buffer */
+	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
+				      pg_off, truesize, DMA_BIDIRECTIONAL);
+
+	/* Add page to xdp shared info */
+	shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
+
+	/* We use gso_segs to store truesize */
+	pkt->data_truesize += truesize;
+
+	__skb_fill_page_desc_noacc(shinfo, pkt->nr_frags++, page, pg_off, len);
+
+	/* Store data_len in gso_size */
+	pkt->data_len += len;
+}
+
 static void fbnic_put_pkt_buff(struct fbnic_napi_vector *nv,
 			       struct fbnic_pkt_buff *pkt, int budget)
 {
@@ -530,6 +656,168 @@ static void fbnic_put_pkt_buff(struct fbnic_napi_vector *nv,
 	page_pool_put_full_page(nv->page_pool, page, !!budget);
 }
 
+static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
+				       struct fbnic_pkt_buff *pkt)
+{
+	unsigned int nr_frags = pkt->nr_frags;
+	struct skb_shared_info *shinfo;
+	unsigned int truesize;
+	struct sk_buff *skb;
+
+	truesize = xdp_data_hard_end(&pkt->buff) + FBNIC_RX_TROOM -
+		   pkt->buff.data_hard_start;
+
+	/* Build frame around buffer */
+	skb = napi_build_skb(pkt->buff.data_hard_start, truesize);
+	if (unlikely(!skb))
+		return NULL;
+
+	/* Push data pointer to start of data, put tail to end of data */
+	skb_reserve(skb, pkt->buff.data - pkt->buff.data_hard_start);
+	__skb_put(skb, pkt->buff.data_end - pkt->buff.data);
+
+	/* Add tracking for metadata at the start of the frame */
+	skb_metadata_set(skb, pkt->buff.data - pkt->buff.data_meta);
+
+	/* Add Rx frags */
+	if (nr_frags) {
+		/* Verify that shared info didn't move */
+		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
+		WARN_ON(skb_shinfo(skb) != shinfo);
+
+		skb->truesize += pkt->data_truesize;
+		skb->data_len += pkt->data_len;
+		shinfo->nr_frags = nr_frags;
+		skb->len += pkt->data_len;
+	}
+
+	skb_mark_for_recycle(skb);
+
+	/* Set MAC header specific fields */
+	skb->protocol = eth_type_trans(skb, nv->napi.dev);
+
+	return skb;
+}
+
+static enum pkt_hash_types fbnic_skb_hash_type(u64 rcd)
+{
+	return (FBNIC_RCD_META_L4_TYPE_MASK & rcd) ? PKT_HASH_TYPE_L4 :
+	       (FBNIC_RCD_META_L3_TYPE_MASK & rcd) ? PKT_HASH_TYPE_L3 :
+						     PKT_HASH_TYPE_L2;
+}
+
+static void fbnic_populate_skb_fields(struct fbnic_napi_vector *nv,
+				      u64 rcd, struct sk_buff *skb,
+				      struct fbnic_q_triad *qt)
+{
+	struct net_device *netdev = nv->napi.dev;
+	struct fbnic_ring *rcq = &qt->cmpl;
+
+	fbnic_rx_csum(rcd, skb, rcq);
+
+	if (netdev->features & NETIF_F_RXHASH)
+		skb_set_hash(skb,
+			     FIELD_GET(FBNIC_RCD_META_RSS_HASH_MASK, rcd),
+			     fbnic_skb_hash_type(rcd));
+
+	skb_record_rx_queue(skb, rcq->q_idx);
+}
+
+static bool fbnic_rcd_metadata_err(u64 rcd)
+{
+	return !!(FBNIC_RCD_META_UNCORRECTABLE_ERR_MASK & rcd);
+}
+
+static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
+			   struct fbnic_q_triad *qt, int budget)
+{
+	struct fbnic_ring *rcq = &qt->cmpl;
+	struct fbnic_pkt_buff *pkt;
+	s32 head0 = -1, head1 = -1;
+	__le64 *raw_rcd, done;
+	u32 head = rcq->head;
+	u64 packets = 0;
+
+	done = (head & (rcq->size_mask + 1)) ? cpu_to_le64(FBNIC_RCD_DONE) : 0;
+	raw_rcd = &rcq->desc[head & rcq->size_mask];
+	pkt = rcq->pkt;
+
+	/* Walk the completion queue collecting the heads reported by NIC */
+	while (likely(packets < budget)) {
+		struct sk_buff *skb = ERR_PTR(-EINVAL);
+		u64 rcd;
+
+		if ((*raw_rcd & cpu_to_le64(FBNIC_RCD_DONE)) == done)
+			break;
+
+		dma_rmb();
+
+		rcd = le64_to_cpu(*raw_rcd);
+
+		switch (FIELD_GET(FBNIC_RCD_TYPE_MASK, rcd)) {
+		case FBNIC_RCD_TYPE_HDR_AL:
+			head0 = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+			fbnic_pkt_prepare(nv, rcd, pkt, qt);
+
+			break;
+		case FBNIC_RCD_TYPE_PAY_AL:
+			head1 = FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
+			fbnic_add_rx_frag(nv, rcd, pkt, qt);
+
+			break;
+		case FBNIC_RCD_TYPE_OPT_META:
+			/* Only type 0 is currently supported */
+			if (FIELD_GET(FBNIC_RCD_OPT_META_TYPE_MASK, rcd))
+				break;
+
+			/* We currently ignore the action table index */
+			break;
+		case FBNIC_RCD_TYPE_META:
+			if (likely(!fbnic_rcd_metadata_err(rcd)))
+				skb = fbnic_build_skb(nv, pkt);
+
+			/* Populate skb and invalidate XDP */
+			if (!IS_ERR_OR_NULL(skb)) {
+				fbnic_populate_skb_fields(nv, rcd, skb, qt);
+
+				packets++;
+
+				napi_gro_receive(&nv->napi, skb);
+			} else {
+				fbnic_put_pkt_buff(nv, pkt, 1);
+			}
+
+			pkt->buff.data_hard_start = NULL;
+
+			break;
+		}
+
+		raw_rcd++;
+		head++;
+		if (!(head & rcq->size_mask)) {
+			done ^= cpu_to_le64(FBNIC_RCD_DONE);
+			raw_rcd = &rcq->desc[0];
+		}
+	}
+
+	/* Unmap and free processed buffers */
+	if (head0 >= 0)
+		fbnic_clean_bdq(nv, budget, &qt->sub0, head0);
+	fbnic_fill_bdq(nv, &qt->sub0);
+
+	if (head1 >= 0)
+		fbnic_clean_bdq(nv, budget, &qt->sub1, head1);
+	fbnic_fill_bdq(nv, &qt->sub1);
+
+	/* Record the current head/tail of the queue */
+	if (rcq->head != head) {
+		rcq->head = head;
+		writel(head & rcq->size_mask, rcq->doorbell);
+	}
+
+	return packets;
+}
+
 static void fbnic_nv_irq_disable(struct fbnic_napi_vector *nv)
 {
 	struct fbnic_dev *fbd = nv->fbd;
@@ -552,12 +840,18 @@ static int fbnic_poll(struct napi_struct *napi, int budget)
 	struct fbnic_napi_vector *nv = container_of(napi,
 						    struct fbnic_napi_vector,
 						    napi);
-	int i;
+	int i, j, work_done = 0;
 
 	for (i = 0; i < nv->txt_count; i++)
 		fbnic_clean_tcq(nv, &nv->qt[i], budget);
 
-	if (likely(napi_complete_done(napi, 0)))
+	for (j = 0; j < nv->rxt_count; j++, i++)
+		work_done += fbnic_clean_rcq(nv, &nv->qt[i], budget);
+
+	if (work_done >= budget)
+		return budget;
+
+	if (likely(napi_complete_done(napi, work_done)))
 		fbnic_nv_irq_rearm(nv);
 
 	return 0;
@@ -1553,3 +1847,33 @@ void fbnic_napi_enable(struct fbnic_net *fbn)
 
 	fbnic_wrfl(fbd);
 }
+
+void fbnic_napi_depletion_check(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	u32 irqs[FBNIC_MAX_MSIX_VECS / 32] = {};
+	struct fbnic_dev *fbd = fbn->fbd;
+	struct fbnic_napi_vector *nv;
+	int i, j;
+
+	list_for_each_entry(nv, &fbn->napis, napis) {
+		/* Find RQs which are completely out of pages */
+		for (i = nv->txt_count, j = 0; j < nv->rxt_count; j++, i++) {
+			/* Assume 4 pages is always enough to fit a packet
+			 * and therefore generate a completion and an IRQ.
+			 */
+			if (fbnic_desc_used(&nv->qt[i].sub0) < 4 ||
+			    fbnic_desc_used(&nv->qt[i].sub1) < 4)
+				irqs[nv->v_idx / 32] |= BIT(nv->v_idx % 32);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
+		if (!irqs[i])
+			continue;
+		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(i), irqs[i]);
+		fbnic_wr32(fbd, FBNIC_INTR_SET(i), irqs[i]);
+	}
+
+	fbnic_wrfl(fbd);
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index ade502e391b7..4a206c0e7192 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -5,6 +5,7 @@
 #define _FBNIC_TXRX_H_
 
 #include <linux/netdevice.h>
+#include <linux/skbuff.h>
 #include <linux/types.h>
 #include <net/xdp.h>
 
@@ -120,6 +121,7 @@ void fbnic_disable(struct fbnic_net *fbn);
 void fbnic_flush(struct fbnic_net *fbn);
 void fbnic_fill(struct fbnic_net *fbn);
 
+void fbnic_napi_depletion_check(struct net_device *netdev);
 int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail);
 
 #endif /* _FBNIC_TXRX_H_ */



