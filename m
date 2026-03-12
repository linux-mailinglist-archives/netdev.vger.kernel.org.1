Return-Path: <netdev+bounces-267221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLWBIjBAs2l6TgAAu9opvQ
	(envelope-from <netdev+bounces-267221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:37:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E288327AF7E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00D5F31F3317
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E720A3B47C0;
	Thu, 12 Mar 2026 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="uueeTmGF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262D397E80
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354917; cv=none; b=jvmOEVTv5Cu+su9zeRMDyMZX9FdtsXUveL+d9fw/3hvvuurW09kqBNCKZeaEQroXXfHuawzgvPYRqnhrcm/whCoIrMPhHvVmn1t/TazKXi4uzpsPOw/yn3j48duxZHOFjpmVVHGqFShFxEN0EJDhKvcajWUkwSIzEbF2YTw7+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354917; c=relaxed/simple;
	bh=LFxmYubxtvxESGJkaDDD8TLr9mfsBvvJI9Y6f+WIXHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpT9MB52R2bGETr8nJLxbQRh8u1DG/CMd90KBKRD4/2eRXU3UpkCJDlGKGUyh/ORZ0ID+z0eTxVxLtZx+zRecVB4zQvv2UwFfF8p5G4InR8tJqVZZ5qNxTxrEgihFp6T/kXejiYh81U5cSL7DzaGPszoXlu4sw2pkW3xf+6hH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=uueeTmGF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae8177446fso12038345ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354915; x=1773959715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJyTxUd6u+yzwsu9Uzqyo58WkKimIItw6uQu3GFh36E=;
        b=uueeTmGFNiBHKvYXC5I4xLGzHOfiRKSlgHB16afLePG2WYlAgCK//WO8ohO7JrsP9H
         hQDugfk/RC8MzL12JvXkvrlcgDbIUxmh3tKCEQ3xDlmJzw0z/oWACPqZyhZKeIAMw7AD
         OIdvmqATrEkWgadjBtg4zJUqjqKBR9ceH60I083OS9Pz3hEZqeyQFjYSHyek7V0LN/rC
         CikXdad3y/WxfI5lF/xPdyoVO2W12tuPZqIfwmsYQ853yzqViqoKGUH6tyop2+DsOVV8
         zrEk/MyQAiZwgdAXhIcNfbmndPFQaDvgnYW90biEThFr0Xk6mWWyBMCwLWDIDsRZ49un
         vryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354915; x=1773959715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJyTxUd6u+yzwsu9Uzqyo58WkKimIItw6uQu3GFh36E=;
        b=MqgY7/IacQE+nAHvyqqyMf7vFfb1dKSlWiAR+AH88B03BsSjEB8oi/bUYslJO8rxSB
         sz6wTyHMcHEBlSG0/mgN89XE+xrJnGE01VO4Iina2PnSDQ81r4eFWAIOYITIki+q1OJB
         RVBejTeMueATxau4K/V0HRt5I6XWRERDlJnEp11x6hshCQ0qYj0A6WGTTe+nOZqj77r5
         rJ4XRp3eoS0PnzCnvNG3qgTFnkaqieoN+8BnHppaE4ywN69uyIbGr2mFZS0JpeSo5de8
         G+kFWbMpH7r2u0rS4mTVyBd9CckxtTa3s0gtwiAdNrs3vZRnHIPWaocKpf+JzREndE1j
         GKMw==
X-Gm-Message-State: AOJu0Yyli5gUMzzDjBe8EDM+quYiXoiS+dPNZz96ms8gsAmgzlT3/38c
	M211x2dMI65nKUKUpG7qjf8+1xaA1IIECq+1qGvMtq8a5pkRjSHt6NcObyXOQyX9SN8s2TT6Uf4
	fKPkBBfc=
X-Gm-Gg: ATEYQzx0zQaVcUodNN4FnJxOESL9I1eIar5T0xyxlhGv/SXkdWZ1c9pSqym6j7vH/Xv
	Y4i1q+RYStaI3uzTEq5pMA1H6xsQYhvfipZYvQobajB8nNXen6DhCy+blX4X8Qjt2Z69vjK75yt
	Jdqdb8meiMi7j9bwWNHPnDMHEk4cyOSYeVYN2RmH6XSEK/NO8vcb58OUosYKwKLHBNtxxNYqqS/
	SabGkWoCVEQ2MW3mCEuuPu4VvR0x+NuOM5NbAWO4AFpSBE1x9+8SO8AX/zqOt7sJOVP66fLGmfy
	3WSHRmiheOVo4FlxQtAnioHZXZe74pdoG9b3O5c16hZzdBoBY35pa4UhHx7yH6P4bZKuByo6f7B
	CYMFKmIVcArXS/v8Bjhh8wiWnTTtkxtFzwxk/bUv15O4gw1OM9hMMtOJnRnLMkB/ocA/XW3JFql
	WZO10p
X-Received: by 2002:a17:902:d490:b0:2ad:6e26:abbb with SMTP id d9443c01a7336-2aecacc3272mr9078945ad.54.1773354915571;
        Thu, 12 Mar 2026 15:35:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eba9e183sm25897a12.14.2026.03.12.15.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:15 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next v2 05/12] net: bnxt: Use dma_unmap_len for TX completion unmapping
Date: Thu, 12 Mar 2026 15:34:42 -0700
Message-ID: <20260312223457.1999489-6-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-267221-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,dama.to:email,dama.to:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E288327AF7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Store the DMA mapping length in each TX buffer descriptor via
dma_unmap_len_set at submit time, and use dma_unmap_len at completion
time.

This is a no-op for normal packets but prepares for software USO,
where header BDs set dma_unmap_len to 0 because the header buffer
is unmapped collectively rather than per-segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
rfcv2:
 - Use some local variables to shortern long lines. No functional change from
   rfcv1.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 63 ++++++++++++++---------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d12e4fcd5063..ea8081aeb5ae 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -656,6 +656,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto tx_free;
 
 	dma_unmap_addr_set(tx_buf, mapping, mapping);
+	dma_unmap_len_set(tx_buf, len, len);
 	flags = (len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_LONG_TX_BD |
 		TX_BD_CNT(last_frag + 2);
 
@@ -720,6 +721,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), tx_buf,
 					  mapping, mapping);
+		dma_unmap_len_set(tx_buf, len, len);
 
 		txbd->tx_bd_haddr = cpu_to_le64(mapping);
 
@@ -809,7 +811,8 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	u16 hw_cons = txr->tx_hw_cons;
 	unsigned int tx_bytes = 0;
 	u16 cons = txr->tx_cons;
-	skb_frag_t *frag;
+	unsigned int dma_len;
+	dma_addr_t dma_addr;
 	int tx_pkts = 0;
 	bool rc = false;
 
@@ -844,19 +847,27 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			goto next_tx_int;
 		}
 
-		dma_unmap_single(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
-				 skb_headlen(skb), DMA_TO_DEVICE);
+		if (dma_unmap_len(tx_buf, len)) {
+			dma_addr = dma_unmap_addr(tx_buf, mapping);
+			dma_len = dma_unmap_len(tx_buf, len);
+
+			dma_unmap_single(&pdev->dev, dma_addr, dma_len,
+					 DMA_TO_DEVICE);
+		}
+
 		last = tx_buf->nr_frags;
 
 		for (j = 0; j < last; j++) {
-			frag = &skb_shinfo(skb)->frags[j];
 			cons = NEXT_TX(cons);
 			tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
-			netmem_dma_unmap_page_attrs(&pdev->dev,
-						    dma_unmap_addr(tx_buf,
-								   mapping),
-						    skb_frag_size(frag),
-						    DMA_TO_DEVICE, 0);
+			if (dma_unmap_len(tx_buf, len)) {
+				dma_addr = dma_unmap_addr(tx_buf, mapping);
+				dma_len = dma_unmap_len(tx_buf, len);
+
+				netmem_dma_unmap_page_attrs(&pdev->dev,
+							    dma_addr, dma_len,
+							    DMA_TO_DEVICE, 0);
+			}
 		}
 		if (unlikely(is_ts_pkt)) {
 			if (BNXT_CHIP_P5(bp)) {
@@ -3400,6 +3411,8 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 {
 	int i, max_idx;
 	struct pci_dev *pdev = bp->pdev;
+	unsigned int dma_len;
+	dma_addr_t dma_addr;
 
 	max_idx = bp->tx_nr_pages * TX_DESC_CNT;
 
@@ -3410,10 +3423,10 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 		if (idx  < bp->tx_nr_rings_xdp &&
 		    tx_buf->action == XDP_REDIRECT) {
-			dma_unmap_single(&pdev->dev,
-					 dma_unmap_addr(tx_buf, mapping),
-					 dma_unmap_len(tx_buf, len),
-					 DMA_TO_DEVICE);
+			dma_addr = dma_unmap_addr(tx_buf, mapping);
+			dma_len = dma_unmap_len(tx_buf, len);
+
+			dma_unmap_single(&pdev->dev, dma_addr, dma_len, DMA_TO_DEVICE);
 			xdp_return_frame(tx_buf->xdpf);
 			tx_buf->action = 0;
 			tx_buf->xdpf = NULL;
@@ -3435,23 +3448,27 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 			continue;
 		}
 
-		dma_unmap_single(&pdev->dev,
-				 dma_unmap_addr(tx_buf, mapping),
-				 skb_headlen(skb),
-				 DMA_TO_DEVICE);
+		if (dma_unmap_len(tx_buf, len)) {
+			dma_addr = dma_unmap_addr(tx_buf, mapping);
+			dma_len = dma_unmap_len(tx_buf, len);
+
+			dma_unmap_single(&pdev->dev, dma_addr, dma_len, DMA_TO_DEVICE);
+		}
 
 		last = tx_buf->nr_frags;
 		i += 2;
 		for (j = 0; j < last; j++, i++) {
 			int ring_idx = i & bp->tx_ring_mask;
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
 
 			tx_buf = &txr->tx_buf_ring[ring_idx];
-			netmem_dma_unmap_page_attrs(&pdev->dev,
-						    dma_unmap_addr(tx_buf,
-								   mapping),
-						    skb_frag_size(frag),
-						    DMA_TO_DEVICE, 0);
+			if (dma_unmap_len(tx_buf, len)) {
+				dma_addr = dma_unmap_addr(tx_buf, mapping);
+				dma_len = dma_unmap_len(tx_buf, len);
+
+				netmem_dma_unmap_page_attrs(&pdev->dev,
+							    dma_addr, dma_len,
+							    DMA_TO_DEVICE, 0);
+			}
 		}
 		dev_kfree_skb(skb);
 	}
-- 
2.52.0


