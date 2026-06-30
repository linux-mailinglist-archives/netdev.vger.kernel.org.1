Return-Path: <netdev+bounces-302947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ukk2CZBDQ2r8WAoAu9opvQ
	(envelope-from <netdev+bounces-302947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:18:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B228E6E0381
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:18:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kyjRGb4k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302947-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302947-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08C0D3020E02
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A43E451A;
	Tue, 30 Jun 2026 04:16:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D63E00BB
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793009; cv=none; b=fCmsiyJ25j5qEHirD/x7AAHc16g7IbgZ/61HM88sQUqbVi+f1Tj/VCBw9GUFHWEmn32rmMGTCdGawuaZKRrveKoKDO2EUO58HdCECLcWQw+2gnGjyJUJs1obyiXeAUMjSwtQQDuzpzq8sH7AXqGNUsY68PxMxURmVfc+z45dJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793009; c=relaxed/simple;
	bh=+KMMLLeJHPzxU9rjXDpAmQkyyda4k9VxW6bqScIbZfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuPqQdKZoBxcicwL/H1B+D3kGZxmCNBtf862KYQK5y62sgpI4CuzztuuwkbOYXDMbZ6wTvqKiCpjF+Wt0EVE22a9xWvdzq/r1sPZ92XXgnnkFxzDVqMdYiyJ+F9XIGDTXZlWO5bN/g2NFxCe/SOZAYH3vrfvo1hRSgXEplUHzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyjRGb4k; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37e11438c66so1606453a91.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793006; x=1783397806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1cJ/QE4aKjgxV/YGWLnWsPu8P+Qfp1CRzkjxh9J7ro=;
        b=kyjRGb4kzOpTBtHpcW1zuWEbgx9Dze7Oq2/ueofrVnSicZamhe+F2RtaKXvTqgQN21
         FZC2V5cv+21XvDumz4oCQyeSW4CVYFH4mZyhdR89Sx8SAgH+T0XlLLplTqzMbXUYSDlq
         vyTavlq5nC8xbFlXHV5+uCAbhTxONmoqPTtLhnFZhH8N5TQKfPmwbA8SDbDpsNgLCGO+
         X8xd98pFAKl8MaNmvTG5MlEEGMF/RGDrfNyWJXWYJiLpjCGI3UXVfjVB796DsV5ujxsW
         HDa3Y2Rq+rWmvFhpgujU+iz6HaR4GcDvLrjDo9AVy6oMrPt5YYQ5eU3sTd89V/nvvUQE
         Zvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793006; x=1783397806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F1cJ/QE4aKjgxV/YGWLnWsPu8P+Qfp1CRzkjxh9J7ro=;
        b=EsdfUbeOrEXAD4FJWVDr1owGzojqJVQBYz/3VKUnElbhildxC5mLa/qBCny9S+22pv
         ib4R+269LY4y1CkV0gE+k528JKGWO8oLZ1OwCaUPvKFv7auSw+tSWVniFDSFl5u8gW4Y
         j7iQlLu8UVlShadJe1onKb6UJQnzJdMDLyKor8SwrYSr3CTNHI6OWxwOX1XVlFE4yhbS
         QR04wdu6VH1/n2NOg0v69JjqQfwupuah2r00NQZuHT4ioT4BaASfjkcebwluKd+GKXOi
         /kzReF05XiIHTSf/a95FJ8ku/Ca1DFGfhw4myWgPscZE2stbBZr/4COpjRzw+j8vpFdt
         LnNA==
X-Gm-Message-State: AOJu0YzyaRnLMJrYPMVDryU3eNUcHSlSQSu237JQQvSxfo4ATsC9G4Vd
	uL74NK73/geAerLoyR6arG0iMJj5/cEVyoDhqypRbnClVkTf+nhlqiHDnyfJB3BY
X-Gm-Gg: AfdE7cmf7A4lqdnS4KWyaFC3kFQ+EHNvnFB1u0VZBu3PYdwddCdUi3psOK66AFLBsqN
	W+uVE/oiDqoYUoQGyexkLVQWaHNmcN0zkSooJKpmH3NeGaLej9waX4wpHA4pjJ/RZcI5bnoIWuE
	am8kwYdRL28BqASV9Bt7Q1P0Bsay1jKFWOmwqsjxXkdBNzZgnmne9XN74+vmwm1jod7xFuXTzgx
	5NgnnH5uzb0PMWBMmUdvmw5BhJTWFRmFfkhTRgXLAKPYQwW6NR7uZi4Gl2/Ne78XHzUOHRx7snA
	zNeus4M750EHmTlflpuzsnk6mgBtJ74RzX25Xe5JHHYl0lr1WlKLS6fMTnI6ZPrd3OZx6VAAXQY
	4F0ho6j2XWI8dOPwdfItW3XcOqHb6VR6j1Rr3NfKecARCInJvoB0krk8mlqNOBfxL0Yj8UyEklD
	HOcXYyoFLZK/9QiJLdaw8PO2lk5nC71Xttj//OU37oziQRXjxQ962WWEUii1PTk34HJob2VpqkR
	Vo+XO3DPw==
X-Received: by 2002:a05:6a21:7a86:b0:3bf:6c08:fb81 with SMTP id adf61e73a8af0-3bfc52ece44mr1632662637.49.1782793006310;
        Mon, 29 Jun 2026 21:16:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 07/10] net: emac: fix DMA API mapping and unmapping correctness
Date: Mon, 29 Jun 2026 21:16:31 -0700
Message-ID: <20260630041634.284127-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630041634.284127-1-rosenp@gmail.com>
References: <20260630041634.284127-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302947-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B228E6E0381

Add missing dma_mapping_error() checks after every dma_map_single()
and skb_frag_dma_map() call. Without these, CONFIG_DMA_API_DEBUG
emits:

  DMA-API: emac ... device driver failed to check map error

Also fix emac_recycle_rx_skb() which called dma_map_single() but
discarded the returned DMA address -- the descriptor kept a stale
(unmapped) address after the old mapping was freed.

The RX descriptors are allocated in coherent (uncached) DMA memory.
Add a shadow rx_dma[] array in regular cached memory to store the
raw DMA address of each RX slot, avoiding a slow uncached read of
dev->rx_desc[slot].data_ptr on the per-packet hot path.  This
prevents a measurable throughput regression on non-coherent PowerPC
platforms where the original fix added such a read.

In emac_recycle_rx_skb(), use dma_sync_single_for_device() with the
actual received length (cache-line-aligned) instead of destroying
and recreating the mapping.  The mapping is long-lived; only the
bytes touched by skb_copy_from_linear_data_offset() need
synchronization.

- __emac_prepare_rx_skb: check map error, free skb on failure
- emac_resize_rx_ring: check map error, invalidate slot on failure
- emac_recycle_rx_skb: map first, check error, then unmap old;
  use dma_sync_single_for_device() with SKB_DATA_ALIGN(len + NET_IP_ALIGN)
- emac_start_xmit: check map error, free skb on failure
- emac_start_xmit_sg: check map error on both data and frag maps,
  undo partial descriptor setup on frag failure
- emac_poll_rx: use rx_dma[] shadow array, unmap old skb before
  passing to napi_gro_receive
- emac_clean_rx_ring: use rx_dma[] shadow array for consistency

There's a small performance decrease tested with iperf3

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   574 MBytes   481 Mbits/sec    1            sender
[  5]   0.00-10.00  sec   572 MBytes   479 Mbits/sec                  receiver

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   558 MBytes   468 Mbits/sec    0            sender
[  5]   0.00-10.00  sec   556 MBytes   466 Mbits/sec                  receiver

but probably worth it. For whatever reason after this patch, ath9k
stopped throwing DMA errors with CONFIG_DMA_API_DEBUG.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 92 +++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/emac/core.h |  1 +
 2 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index ced9690cddc3..aed1ad21e2ea 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -52,7 +52,15 @@
 #include "core.h"
 
 /*
- * Lack of dma_unmap_???? calls is intentional.
+ * Note on dma_unmap calls:
+ *
+ * RX buffers are properly unmapped before being remapped or passed to the
+ * network stack.  See emac_recycle_rx_skb() and emac_poll_rx().
+ *
+ * TX buffers still lack dma_unmap calls for the reasons explained in the
+ * original note below (a single skb may be split across multiple BDs on
+ * TAH-equipped EMACs, making per-fragment tracking complex).
+ * The original rationale is kept for the TX path only:
  *
  * API-correct usage requires additional support state information to be
  * maintained for every RX and TX buffer descriptor (BD). Unfortunately, due to
@@ -1058,6 +1066,7 @@ static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
 	/* Second pass, allocate new skbs */
 	for (i = 0; i < NUM_RX_BUFF; ++i) {
 		struct sk_buff *skb;
+		dma_addr_t dma;
 
 		skb = netdev_alloc_skb_ip_align(dev->ndev, rx_skb_size);
 		if (!skb) {
@@ -1066,12 +1075,24 @@ static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
 		}
 
 		BUG_ON(!dev->rx_skb[i]);
+		dma_unmap_single(&dev->ofdev->dev,
+				 dev->rx_dma[i],
+				 dev->rx_sync_size, DMA_FROM_DEVICE);
 		dev_kfree_skb(dev->rx_skb[i]);
 
-		dev->rx_desc[i].data_ptr =
-		    dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
-				   rx_sync_size, DMA_FROM_DEVICE)
-				   + NET_IP_ALIGN;
+		dma = dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
+				     rx_sync_size, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&dev->ofdev->dev, dma)) {
+			dev_kfree_skb(skb);
+			dev->rx_skb[i] = NULL;
+			dev->rx_dma[i] = 0;
+			dev->rx_desc[i].data_ptr = 0;
+			dev->rx_desc[i].ctrl = 0;
+			ret = -ENOMEM;
+			goto oom;
+		}
+		dev->rx_desc[i].data_ptr = dma + NET_IP_ALIGN;
+		dev->rx_dma[i] = dma;
 		dev->rx_skb[i] = skb;
 	}
  skip:
@@ -1150,9 +1171,13 @@ static void emac_clean_rx_ring(struct emac_instance *dev)
 
 	for (i = 0; i < NUM_RX_BUFF; ++i)
 		if (dev->rx_skb[i]) {
+			dma_unmap_single(&dev->ofdev->dev,
+					 dev->rx_dma[i],
+					 dev->rx_sync_size, DMA_FROM_DEVICE);
 			dev->rx_desc[i].ctrl = 0;
 			dev_kfree_skb(dev->rx_skb[i]);
 			dev->rx_skb[i] = NULL;
+			dev->rx_dma[i] = 0;
 			dev->rx_desc[i].data_ptr = 0;
 		}
 
@@ -1176,15 +1201,23 @@ static void emac_clear_mal_desc(struct mal_descriptor *desc, int count)
 static int
 __emac_prepare_rx_skb(struct sk_buff *skb, struct emac_instance *dev, int slot)
 {
+	dma_addr_t dma;
+
 	if (unlikely(!skb))
 		return -ENOMEM;
 
 	dev->rx_skb[slot] = skb;
 	dev->rx_desc[slot].data_len = 0;
 
-	dev->rx_desc[slot].data_ptr =
-	    dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
-			   dev->rx_sync_size, DMA_FROM_DEVICE) + NET_IP_ALIGN;
+	dma = dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
+			     dev->rx_sync_size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(&dev->ofdev->dev, dma)) {
+		dev->rx_skb[slot] = NULL;
+		dev_kfree_skb(skb);
+		return -ENOMEM;
+	}
+	dev->rx_desc[slot].data_ptr = dma + NET_IP_ALIGN;
+	dev->rx_dma[slot] = dma;
 	dma_wmb();
 	dev->rx_desc[slot].ctrl = MAL_RX_CTRL_EMPTY |
 	    (slot == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
@@ -1463,6 +1496,12 @@ static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	dev->tx_desc[slot].data_ptr = dma_map_single(&dev->ofdev->dev,
 						     skb->data, len,
 						     DMA_TO_DEVICE);
+	if (dma_mapping_error(&dev->ofdev->dev,
+			      dev->tx_desc[slot].data_ptr)) {
+		dev->tx_skb[slot] = NULL;
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
 	dev->tx_desc[slot].data_len = (u16) len;
 	dma_wmb();
 	dev->tx_desc[slot].ctrl = ctrl;
@@ -1530,8 +1569,12 @@ emac_start_xmit_sg(struct sk_buff *skb, struct net_device *ndev)
 	/* skb data */
 	dev->tx_skb[slot] = NULL;
 	chunk = min(len, MAL_MAX_TX_SIZE);
-	dev->tx_desc[slot].data_ptr = pd =
-	    dma_map_single(&dev->ofdev->dev, skb->data, len, DMA_TO_DEVICE);
+	pd = dma_map_single(&dev->ofdev->dev, skb->data, len, DMA_TO_DEVICE);
+	if (dma_mapping_error(&dev->ofdev->dev, pd)) {
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+	dev->tx_desc[slot].data_ptr = pd;
 	dev->tx_desc[slot].data_len = (u16) chunk;
 	len -= chunk;
 	if (unlikely(len))
@@ -1547,6 +1590,18 @@ emac_start_xmit_sg(struct sk_buff *skb, struct net_device *ndev)
 
 		pd = skb_frag_dma_map(&dev->ofdev->dev, frag, 0, len,
 				      DMA_TO_DEVICE);
+		if (dma_mapping_error(&dev->ofdev->dev, pd)) {
+			/* Undo partial descriptor setup and drop packet */
+			while (slot != dev->tx_slot) {
+				dev->tx_desc[slot].ctrl = 0;
+				--dev->tx_cnt;
+				if (--slot < 0)
+					slot = NUM_TX_BUFF - 1;
+			}
+			++dev->estats.tx_undo;
+			dev_kfree_skb(skb);
+			return NETDEV_TX_OK;
+		}
 
 		slot = emac_xmit_split(dev, slot, pd, len, i == nr_frags - 1,
 				       ctrl);
@@ -1661,14 +1716,14 @@ static void emac_poll_tx(void *param)
 static inline void emac_recycle_rx_skb(struct emac_instance *dev, int slot,
 				       int len)
 {
-	struct sk_buff *skb = dev->rx_skb[slot];
-
 	DBG2(dev, "recycle %d %d" NL, slot, len);
 
-	if (len)
-		dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
-			       SKB_DATA_ALIGN(len + NET_IP_ALIGN),
-			       DMA_FROM_DEVICE);
+	if (len) {
+		dma_sync_single_for_device(&dev->ofdev->dev,
+					    dev->rx_dma[slot],
+					    SKB_DATA_ALIGN(len + NET_IP_ALIGN),
+					    DMA_FROM_DEVICE);
+	}
 
 	dev->rx_desc[slot].data_len = 0;
 	dma_wmb();
@@ -1808,12 +1863,17 @@ static int emac_poll_rx(void *param, int budget)
 		continue;
 	sg:
 		if (ctrl & MAL_RX_CTRL_FIRST) {
+			dma_addr_t old_dma = dev->rx_dma[slot];
+
 			BUG_ON(dev->rx_sg_skb);
 			if (unlikely(emac_alloc_rx_skb_napi(dev, slot))) {
 				DBG(dev, "rx OOM %d" NL, slot);
 				++dev->estats.rx_dropped_oom;
 				emac_recycle_rx_skb(dev, slot, 0);
 			} else {
+				dma_unmap_single(&dev->ofdev->dev, old_dma,
+						 dev->rx_sync_size,
+						 DMA_FROM_DEVICE);
 				dev->rx_sg_skb = skb;
 				skb_put(skb, len);
 			}
diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index 296da4bf3781..0719f98f3325 100644
--- a/drivers/net/ethernet/ibm/emac/core.h
+++ b/drivers/net/ethernet/ibm/emac/core.h
@@ -246,6 +246,7 @@ struct emac_instance {
 
 	struct sk_buff			*tx_skb[NUM_TX_BUFF];
 	struct sk_buff			*rx_skb[NUM_RX_BUFF];
+	dma_addr_t			rx_dma[NUM_RX_BUFF];
 
 	/* Stats
 	 */
-- 
2.54.0


