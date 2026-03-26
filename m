Return-Path: <netdev+bounces-272287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEnfGgHIxWmgBgUAu9opvQ
	(envelope-from <netdev+bounces-272287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:57:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF88E33D4EC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DED75303AB44
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9ED35AC3A;
	Thu, 26 Mar 2026 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="TzKfwGeh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8703C060B
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569181; cv=none; b=mKlfoR+9Kqe1f6SWPgQdhZkiq3JEhor2H5srP1eOJRJmAB+dy931LDxxinielMy2XWfCQumY/oDiIB9UxmgOGQT4EXFHbIo/luIjYyAztf5ihuwcjaRTsWxfmb4ztwsc+KHHdQBAqxM52qi9ZZg/uGheqVxnUhYDSLi3ap9wqeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569181; c=relaxed/simple;
	bh=SwJnscTqxPzyr8NelnMCAqCLfGawssCKPE4MNXisLfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1BeIzXtDlMoV+bZagjCWllrWvbtLYDaj0m+bvBJg5+RhaRDVDQzXgh1LQD290kB7vBDHpDQ6eY0jiji2yuxV0vZ6n0HR3Mmaw5C5tIPgEnIpAVRzJCY6FLqiAa3ljwGDMwFqCStJgVW2R/Ga5glUJ/tOysiKrW+u8N/QpXqrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=TzKfwGeh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70f91776fcso681929a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774569179; x=1775173979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRCJMoiMQS5q76rcDSmZShmAqHh8lkp6y+PIztrt728=;
        b=TzKfwGehSgILdO2KmBSzIn69nEo4UUreOqHMqmsnuSDfgVBHHkUQcjDJF/qa+ruhkj
         I+QBbmTUQ5cOTDmGGNOwK2zV1FZQeiU/FXqShDvcTBzNFBv/9ysQ1GxwIY+xEDqJHkuH
         iV+/LVZgEyYS/iaZOl/PznQAJsykbVOSyPxaHaYcDpKeP44h3WxQBCo4f6gJwp3EhaIO
         kmEvdt5vVhruacHF7K/uEKphUXvfw+XM9OGptyuHRK6oAUa8CjhTSgOMQ51xpPzi9GW4
         f30h5iCihp6+k39hFjkKolSv70fvcTNqGPShMc0JLBQYkhBjzFNtSfjUiEskJhODCu4l
         75pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569179; x=1775173979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRCJMoiMQS5q76rcDSmZShmAqHh8lkp6y+PIztrt728=;
        b=i5rSj/48XB5TqSdiV9NW4CSSx+cjhLBxkPxB2AMRax2G5TY7t7vV1PLxxNUf2EXZvA
         RxLY2qGMcmG/QK3HrhSTMn0/AB4uwkx4ECNpLWZ1w9IHPGmd3uoJZVUzrSofFx5UizXl
         JnPln8c+nInw31YZ04h/nU56QXMdJkjKOuLCLet6sUgjf24e74t+wsJ3c1Duve8TiBYF
         Z+AW+94nCRXfahSMnG0sbV3MebzLp9PLI5yoeR4+Ix9X67yoCATXpbKMUuQtMcSIOh6X
         /YzmTlmWZFD+RXQoFDP4V2OTXTmb0wA8aJELhKwSo9o4iQSbjIEbLxTdVN9fltqKrqgz
         oJHg==
X-Gm-Message-State: AOJu0YxuuS8Jo2yy7egXFz7UXc9cEjHE5di/PvrLLlMFtH3poa1lw4gt
	B6Sf1grkA+lPZczoCnPdgAMXjx3OMiAv3MY6v81MNBh74Q1UKVvhJgLAQskJWcD8PPVbTsL7Kr4
	8stkG
X-Gm-Gg: ATEYQzxcTfdhQQgIRMejGNctMxahrF7F30tNYgJGywL3vi56S/6DekTW8tIA9Yiiv8B
	/J09rIjcIHVDivIxt88YtsLyF8rAAJZ9Ao8gGj6vNdu4j1zakoQaFXS+HQdo6+LEBc047S7fPkl
	6Dpqe1MwTbDLLox8EoeBaypnjpqimD7rV5zwIw7gHhc2aq9msTdupESILgAFODYHwZbEy+6Xf2n
	7ZVttsEY0JFI3hQZysS6FRCd+OJFIMffUot0OV7p40UtwyA/sD/FW1t8yBfZwNbckmpNRhBBRYt
	GzxuBypVA4qX5Omko2sZlSOKS7g6kIJUkL1XDoZYMs2bSuwziJ+leoCmJ9VrFNNmhwWItHs9NRK
	wT+L2oF5L+aaklz7MUhMTRq5HZ8vD0SbpcpfrusBUYHtROPiRXLI+gOWir1c6ddRW69fkR70ftQ
	J3xO5ynTZTe2JBidw=
X-Received: by 2002:a05:6a20:6a08:b0:38e:9220:ebbe with SMTP id adf61e73a8af0-39c87951cefmr558778637.23.1774569178920;
        Thu, 26 Mar 2026 16:52:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76739334e6sm3058068a12.18.2026.03.26.16.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:52:58 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v6 05/12] net: bnxt: Use dma_unmap_len for TX completion unmapping
Date: Thu, 26 Mar 2026 16:52:24 -0700
Message-ID: <20260326235238.2940471-6-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326235238.2940471-1-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272287-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,dama.to:email,dama.to:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BF88E33D4EC
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
index 8515cd6e82fc..2ab588f8de84 100644
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
@@ -3402,6 +3413,8 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 {
 	int i, max_idx;
 	struct pci_dev *pdev = bp->pdev;
+	unsigned int dma_len;
+	dma_addr_t dma_addr;
 
 	max_idx = bp->tx_nr_pages * TX_DESC_CNT;
 
@@ -3412,10 +3425,10 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
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
@@ -3437,23 +3450,27 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
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


