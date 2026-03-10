Return-Path: <netdev+bounces-266337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE0rODCMsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:25:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 679552583BC
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61F553019FCD
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0AB3E8C66;
	Tue, 10 Mar 2026 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="eRUilQAn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588153EB7F4
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177777; cv=none; b=mH8KljJLVj2fmBcCDoka4cpqZbcD8ohPN8EkCr7cM274RIFo9vGUE1g4LG73J/OO++RmfveGo+xJlAveFV2Ow217i5EhwOk9o5PSwkpWuPtE+SjC6eIHJ5p32rVZcyRwt111op78YEYLXs3gacWWUkrE/76EpaJn6jJMsrwNYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177777; c=relaxed/simple;
	bh=DcJ0BGCersFrhp9VNVWRnvjOToN0C6ltP0u8NNPqSUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1zQcGDEiPi+yzNXPAHrGH+qM7JxbNQ1D7MYMLIgMLcwarGZcvinOZPYhKhzSuseFoF00LxqVFFUpMssuMIgUMYozfas+CHEvuQ9tCxkFbJBlRD0uX1MBKD6Eu6XimfrTHxiBFurlxC+S0BKWmzOFdVBZozGqM05NebIRJyd0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=eRUilQAn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824c9da9928so7469339b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177771; x=1773782571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsF+ejVwY/S1YOmLcgZAjHITHgFQNlN9mt3hAKMMsTQ=;
        b=eRUilQAnd3BT2AfN13wpviVz2IcV+OcnRYfCJSOh15m1Qit80Fp1vUU1hPN2sE48tm
         TpEe1Ps4lm6PMxAAukD5bKI5/ydurCeP15KhZDJGYkcgMzLy8wlt2drPP/V/dShozV/H
         rLd0K0s8QBQRagSkMe4p8SgKjdlEqPT22ary5pM6zf7uMZRJzUIj/JA+MoqQYuIuiblu
         wyrJI/6wenxCZLhZQqLEzelu6NLYFzE3d+emhoeqZ7QotBbtdEUNscgKI66BgSawx7bw
         mtESwUM+RYbtxjXN2dJn0Bpwnd36AVsmdM8Ow+ma9RWZZWWiGCNsqdJfYg7oeOFd2Qti
         LJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177771; x=1773782571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsF+ejVwY/S1YOmLcgZAjHITHgFQNlN9mt3hAKMMsTQ=;
        b=Mo+kG8Z3pJM6YguNmzqaj/Dpcb2FTZlQGRu4DBUDFLwm/fTgq/pmNnjvEtysHT8HfW
         adUfN/xUrpTLzh3ZliVOaI+n4tHS1msgf9txRLh2cI2nadZbg11E9Pmehv0SKJoTYRc6
         Bf5EcBayz4ZRmgAfMp3xBtjy3DFgINkSn8wUdip0ML9B/qTFEchAY7vfz3ycK9zKPtWp
         KpUsXAhrjy/8jeXi5sP7pRzAvQPzS0mfeadt3ouDklJF8DpyDv7kpac6fahQcj3LHj+z
         q+A5U7KvfGH7edkuv5YRTts71X4l3tOn3nwuzqIfEhogxFesXOxwkM3bVHmQDhQPNhNH
         KPgg==
X-Gm-Message-State: AOJu0YzFk84oHfqDiewEBRtGctuHQIqe+rbs16aAm+wusatOtvjib74v
	hhLOZzz83vxJSxC60yCLjfnuv831FWYs31pQ+ekmIpk0aHfMsbNOU9sx1/zrrR5ZCao3L3UfZIx
	iqxsWw0w=
X-Gm-Gg: ATEYQzz/R50JhzRSGsIKdZHPSbaphmecSwQ1D40h3dt18/sGNfOecruYU0WQaqDaoEm
	Pc2thLif/Ff80oZcYav9XzzoyQulCktEW9CoPxvuWUE7rjcwPK+4qwHoUZjR57EVCGZOY0PxsV9
	HvzHmlHAI1Pki44Qzo66DALVDIU1jIxlgsiU+fjpi/hN/Gd+tAFD/LCNza9NLUSjB6ye2abxqjk
	Pecy0k3cT1L+ogLAJ1Kg1Si378mCQk/geFPp+vI5h71IO7zA/3rzvBBIkg5mEqYhTelNWBjY1VD
	uHdBva/P4VKvG09h831F2xRgJ8z+YjWviwGaScDVUaYlS3CogtwCLiIiwM08ljK8dXNqrKnq2yl
	knXAb9mRloo7G9rWdmjDGZsTS0H1dmVUUb1QnJNrxDMOQQVZ9zSG2wrUIaQMvizvL/XAT27N6xQ
	NzI1U=
X-Received: by 2002:a05:6a20:729e:b0:398:c1d8:f584 with SMTP id adf61e73a8af0-398c616642dmr51010637.62.1773177771100;
        Tue, 10 Mar 2026 14:22:51 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf24baasm126350a12.8.2026.03.10.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:50 -0700 (PDT)
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
Subject: [RFC net-next 05/10] net: bnxt: Use dma_unmap_len for TX completion unmapping
Date: Tue, 10 Mar 2026 14:21:53 -0700
Message-ID: <20260310212209.2263939-6-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>
References: <20260310212209.2263939-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 679552583BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-266337-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:mid,dama.to:email,dama-to.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Store the DMA mapping length in each TX buffer descriptor via
dma_unmap_len_set at submit time, and use dma_unmap_len at completion
time.

This is a no-op for normal packets but prepares for software USO,
where header BDs set dma_unmap_len to 0 because the header buffer
is unmapped collectively rather than per-segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 51 ++++++++++++++---------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c52db7135ded..b801daf3f328 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -657,6 +657,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto tx_free;
 
 	dma_unmap_addr_set(tx_buf, mapping, mapping);
+	dma_unmap_len_set(tx_buf, len, len);
 	flags = (len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_LONG_TX_BD |
 		TX_BD_CNT(last_frag + 2);
 
@@ -721,6 +722,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), tx_buf,
 					  mapping, mapping);
+		dma_unmap_len_set(tx_buf, len, len);
 
 		txbd->tx_bd_haddr = cpu_to_le64(mapping);
 
@@ -810,7 +812,8 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	u16 hw_cons = txr->tx_hw_cons;
 	unsigned int tx_bytes = 0;
 	u16 cons = txr->tx_cons;
-	skb_frag_t *frag;
+	unsigned int dma_len;
+	dma_addr_t dma_addr;
 	int tx_pkts = 0;
 	bool rc = false;
 
@@ -845,19 +848,27 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
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
@@ -3436,23 +3447,25 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 			continue;
 		}
 
-		dma_unmap_single(&pdev->dev,
-				 dma_unmap_addr(tx_buf, mapping),
-				 skb_headlen(skb),
-				 DMA_TO_DEVICE);
+		if (dma_unmap_len(tx_buf, len))
+			dma_unmap_single(&pdev->dev,
+					 dma_unmap_addr(tx_buf, mapping),
+					 dma_unmap_len(tx_buf, len),
+					 DMA_TO_DEVICE);
 
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
+			if (dma_unmap_len(tx_buf, len))
+				netmem_dma_unmap_page_attrs(&pdev->dev,
+							    dma_unmap_addr(tx_buf,
+									   mapping),
+							    dma_unmap_len(tx_buf,
+									  len),
+							    DMA_TO_DEVICE, 0);
 		}
 		dev_kfree_skb(skb);
 	}
-- 
2.52.0


