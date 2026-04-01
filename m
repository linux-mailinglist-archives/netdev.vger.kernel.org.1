Return-Path: <netdev+bounces-274274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EPEIw2tzWlRfwYAu9opvQ
	(envelope-from <netdev+bounces-274274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:41:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37863381BC3
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50280306AB69
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8438A3F0752;
	Wed,  1 Apr 2026 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="pzadqI+x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F33F0A81
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086685; cv=none; b=p9H79JtZOOZHB11D7Xdq40zfsBQhuafUuDNVc3SH7nsep8P8tn/x9Vr8gFBZqwyw5RMkPhmAhj4R19S+UXRokigMheSM1yXrF5XeyLLIDLfZ/j4ePOOoLBysVXfK3bVioyqKLMxYK73S7hbEiwpMO+8GO++v+d6+Gzhb59KSBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086685; c=relaxed/simple;
	bh=/QG4rq6stvRVzMtzKT515AeU34mX0x35NxKPcHuNDVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQsg7MdcwR/561c/EvHrLNAKqUgI7pt1wBWxxoPDdQOxOBXVfyIFl1f11fikiuu5NYMbePCWRDeFGfFilN+ITuu2I5hdgLyV6yHi0thMmSDF4+AogND74cEUTVO/4e7+DZvrhpfRS3jXpee2jZWFm/lD6/24Gc6iGko6f7QdwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=pzadqI+x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aae4816912so1454575ad.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775086681; x=1775691481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvCUZz78UoCDWGO4l29n8jMLaU+MzNVlLAG9l7O/Ufo=;
        b=pzadqI+x+pxNtLLILzI2seV+tNyFyg3rbUvpuaFSGrp1CfWKlANLc6KNz0KNDfbPns
         004lNWl+YdwV5EVWt0kBkKqNGKF3nvXMui/MyQ/yTSajNxIflGSnVx9EGcuy+gWvfDRV
         UeNO1uGZUka4SxE1OuDR+W7JoYviQf0rAtT1EgX24tTeEV7Fv+LF2L+PEVnHjEO92CcY
         H/hZE1b+uOlzIgWia+BSiIzcdJF9+UF45SCt+oEVLCCEwKsnJREt6OZrImwlh70Mz/ME
         nKzK6iM9+8vDy6zT6RSxCDOXqJVUqO3iH7X27w7hcgn+kY5m4GPwTDH4oOnjKUwj8FAE
         SiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086681; x=1775691481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvCUZz78UoCDWGO4l29n8jMLaU+MzNVlLAG9l7O/Ufo=;
        b=cVkvuzeq3XWAXs+IZIandpMxEhRci2aMMi119tY+IgUB71CdSt6mvce9vi1bmTc8O2
         ar5PFMOrDGvrHtEIg6DwP/sm/X5Jw/AY3ImPeiYM1QyBqiO33CbEOjflL8Q9EMjLPl4e
         oyzHkILnB0t/eTY5Rx79C7T7qGLoB1fL74iLdJtgJHHjwfCao6qHEOJQm5Comfb9Ox3I
         ySG6HlbMmu2xs0mpvYaYeQExqjTjvKFNoSJntRVeHDORpD4hpFaKxTt8Ax5BQUoB34PH
         SfUJ05KSH0Xq/7SVQ9Y4O65M3gdIYJSC+atSflAQVNvFmPf7jzGSCcApBJKjY4mxCaD2
         XyEw==
X-Gm-Message-State: AOJu0YyG08bQPSuIuiDhkQ2+eAbeOOF1/Qq2UsEMcDIampIiKAv8GGNL
	nx022az081sgcw/lIbWr1ocfFBvJBMa0g9p7ObrXz33HoJ5HNGC2kjNxay4KIfMK4ltt4+XaKR4
	9/koGjcE=
X-Gm-Gg: ATEYQzw+L31HXlNme9OZi/y2Y55X+C3TyYXQ5aEFqzcWVvTw0BtFM8n2aNVuo44Sv/e
	7+ie4RukXvo0VrhO6DZou6p7EXZpIW3BQF403XPaYu7GWGod15XmwJZtMSbVMcRk/bhnCeDgHJx
	E/xAnEn9jH+AMJZNXPzQEcxEV5LN6M7jau6FiRBmZuvPtxbmLd7v+Q1ZBKx4vOViJV5kGAw29UW
	gpSM2EED34EIDKFTk7+Hzf/B3xiVmk2PRJQ+F+KhvVjSwXjKwRyJGREuXLvVCui1YSdMBFU6sts
	MZWu8ecC2AHvpPIe/lOQUQ7PuiedgzzBDc4awDKX68WJ0e9jdB2n5l4hCTSnYkllVRSyIoj4wdy
	B8EO5Y9k3B8ZIT8+N+IWjJxUdhkqhmxXHau2tybcu5TCSQakPuxKGtn2HJJlV1OjE/p1CeaUIbZ
	lypWpwK1oX4xZcWTM=
X-Received: by 2002:a17:902:c945:b0:2b2:5503:1b8d with SMTP id d9443c01a7336-2b269a8c563mr58851845ad.6.1775086681354;
        Wed, 01 Apr 2026 16:38:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749b2423sm9869335ad.67.2026.04.01.16.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 16:38:00 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v7 04/10] net: bnxt: Use dma_unmap_len for TX completion unmapping
Date: Wed,  1 Apr 2026 16:37:32 -0700
Message-ID: <20260401233745.2333858-5-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401233745.2333858-1-joe@dama.to>
References: <20260401233745.2333858-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274274-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,dama-to.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 37863381BC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Store the DMA mapping length in each TX buffer descriptor via
dma_unmap_len_set at submit time, and use dma_unmap_len at completion
time.

This is a no-op for normal packets but prepares for software USO,
where header BDs set dma_unmap_len to 0 because the header buffer
is unmapped collectively rather than per-segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 rfcv2:
   - Use some local variables to shorten long lines. No functional change from
     rfcv1.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 63 ++++++++++++++---------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6abe4bef8afd..acd76d9bf403 100644
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
@@ -3394,6 +3405,8 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 {
 	int i, max_idx;
 	struct pci_dev *pdev = bp->pdev;
+	unsigned int dma_len;
+	dma_addr_t dma_addr;
 
 	max_idx = bp->tx_nr_pages * TX_DESC_CNT;
 
@@ -3404,10 +3417,10 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
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
@@ -3429,23 +3442,27 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
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


