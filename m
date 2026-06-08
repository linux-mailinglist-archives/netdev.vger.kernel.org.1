Return-Path: <netdev+bounces-296660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +LESN5nwJmranwIAu9opvQ
	(envelope-from <netdev+bounces-296660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C5658D0B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:40:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="KEegK/u0";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296660-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296660-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EED1330C2F41
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDBF34E763;
	Mon,  8 Jun 2026 16:30:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD533C9897
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:30:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936212; cv=none; b=WHeqnd3aHluEuPc1xzgjRHlWuFRti5Rrv2B9XsPhV8Y61u6//kZDfhcaMA4qIk/oOh9o/klPZ6U1FhOsqVCcgAaeoEH/mcbOHbfi4XL71VZO7k7oVy9vwft8SSzgGNVapddD+Vfa5J01A83HKmX58Plmj51jpDE6vCbKvE8M13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936212; c=relaxed/simple;
	bh=TsI6p8wtyxvP+a9YRkFSvRV130RPT1S7wPr/XXAI2P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REvH14di2rA6GmmtIfQf+LJmvPE7fz9rOqS8ZnJX7Ld3Vqs6vzPNqwzXIvQ7zDIopNjNKofFgwci9Yq9d5Cyqb46C388nFHXWoPou1reKXsx4DxwXqdyBMpEqbnlMuH2NLIKwgvjBQcfsBoVbDq/AT9QeylKFpzqBNFzOoesxXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEegK/u0; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c859a374903so1542810a12.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780936210; x=1781541010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0dDjmrbQmjsQaEwPhaU+hoEwuWnzAMIdsN2wdRKRYY=;
        b=KEegK/u03ds+XdyjO+ADLPntXkRQt+wZBQEDse4yjSccHGpcC1B8Ffxi9s/baaNWW+
         1OJgMwAecvCZR8GVlTACK9T9Tqg0USexGut9BoNzBUeNhMA1ZmrKhL8EAnnfnj4oyyvT
         XY1CAp8Na7sjtdfJ8ggT9OqzvXkUccQ60CbgTkci6KgqFsczPB9BiWpf5w3wdavvLmsG
         KaQta7YMql0WGEUD1qINoN/7X75pCiKH6+YXTnOMPB323xSDofX6HRRSysiO5sebix+b
         hIk34yOHISXDva8B4O/aSp8b2rO1p4Lt3tDaOXrpKGsXNFNMMnPSAZZKaRzxy8dCZHyr
         itVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780936210; x=1781541010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0dDjmrbQmjsQaEwPhaU+hoEwuWnzAMIdsN2wdRKRYY=;
        b=HE1WhcKsmHg3Mr+7G01wUst6SK7xbfF78f+i/Xv19Lux/rTQMgspE8PWsFx9AMGfuy
         waY+UTFrQW2V3CoVnuP5p1ojHsNpVLfrg/Armd9A+bT5kH9hPqzNFNBRksZLiW5ytKxU
         iF1nVu6zAhHvBSDlAhTb60gNgId5x712Vn+JRwyc9Z0bNh/HEzlgMdS6sLtRljosnu70
         F8oKPWFqMkE1QzmXT316M1tXb1tezmThtxQ+aVdSKOMePe6wvjVYL9HGuASn5ajrq1t8
         UxF/A9NIl/DvkLilewbczhU/zcthliM7iQvHWgQ78a6/T0wPvotoKmPhhUcDgtbMCOV+
         febw==
X-Gm-Message-State: AOJu0YzO2gNofqShgFfo1Z7rLCViC0OrEImQyMsMcRntqCPKHvF85a4Z
	/15EIEw91bAk2sg47UHMPA2EBlBbMRTejwWo+WARmu318Wbz9a2ZSVZX1DEf+5v1RiM=
X-Gm-Gg: Acq92OF44vbYp1S9s+gNXiDuHMXVOMUz0QguLuPsqOYkWjFlnup9pPeX2cZYyvpiRl9
	jMKGcLawBiQLyiGxao2IzyuKkKrzFYUYw0xff5K42ZqaDMpwnzKxzKGtdSOcrAmXC4mguBcAqdQ
	RdYBF7Sf2hhlqOfNkHfdVYi9RyaBHOdmEvBChDSHmOmXfI1mYPrPzHPTDru2DX52xM3roVSt4fo
	zi2ArzDcta0MHhVE+cG8RD/NSLz/rLIuLX7gL0nMX5rFdrNeSpNrIbTz92p8mIWyyAyWMxkl+Yn
	aMLOnjQUbKZzuyqPUTc1GI7oiZE8lHNW8KGiCOUiQsYpso6JUAd7CxGg47alOa1sbDkeMr1udFT
	79qltE9cmuUeSyncgyDvUO+vsrVndzjP/s06BJ6VR+aLEXREUgKSty1dIWw0mjyNx8BsQDcVUvM
	/yV0ezKixyRoMBl74OYJ5IzmyZHDHetXYFQLi5wPyv+yhkt3b3GQcoSHJIi1qccJ4=
X-Received: by 2002:a05:6a21:6113:b0:3b3:1c7b:ffb with SMTP id adf61e73a8af0-3b4cd0346b7mr16627988637.34.1780936210327;
        Mon, 08 Jun 2026 09:30:10 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:9a2:954d:67fe:d9c2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a4afdsm18848999a12.19.2026.06.08.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:30:09 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: pch_gbe: handle TX skb allocation failure
Date: Tue,  9 Jun 2026 00:30:05 +0800
Message-ID: <20260608163005.6-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296660-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 563C5658D0B

pch_gbe_alloc_tx_buffers() allocates an skb for each TX descriptor and
then passes the returned pointer to skb_reserve(). If netdev_alloc_skb()
fails, skb_reserve() dereferences NULL.

Make pch_gbe_alloc_tx_buffers() return an error when an skb allocation
fails. On failure while bringing the device up, clean any TX buffers that
were already allocated and release the RX buffer pool through a shared
cleanup helper before unwinding the IRQ setup.

Fixes: 77555ee72282 ("net: Add Gigabit Ethernet driver of Topcliff PCH")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 35 ++++++++++++++-----
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 62f05f4569b10..a426243a5fa34 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -1420,13 +1420,23 @@ pch_gbe_alloc_rx_buffers_pool(struct pch_gbe_adapter *adapter,
 	return 0;
 }
 
+static void pch_gbe_free_rx_buffers_pool(struct pch_gbe_adapter *adapter,
+					 struct pch_gbe_rx_ring *rx_ring)
+{
+	dma_free_coherent(&adapter->pdev->dev, rx_ring->rx_buff_pool_size,
+			  rx_ring->rx_buff_pool, rx_ring->rx_buff_pool_logic);
+	rx_ring->rx_buff_pool_logic = 0;
+	rx_ring->rx_buff_pool_size = 0;
+	rx_ring->rx_buff_pool = NULL;
+}
+
 /**
  * pch_gbe_alloc_tx_buffers - Allocate transmit buffers
  * @adapter:   Board private structure
  * @tx_ring:   Tx descriptor ring
  */
-static void pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
-					struct pch_gbe_tx_ring *tx_ring)
+static int pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
+				    struct pch_gbe_tx_ring *tx_ring)
 {
 	struct pch_gbe_buffer *buffer_info;
 	struct sk_buff *skb;
@@ -1440,12 +1450,15 @@ static void pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
 	for (i = 0; i < tx_ring->count; i++) {
 		buffer_info = &tx_ring->buffer_info[i];
 		skb = netdev_alloc_skb(adapter->netdev, bufsz);
+		if (!skb)
+			return -ENOMEM;
 		skb_reserve(skb, PCH_GBE_DMA_ALIGN);
 		buffer_info->skb = skb;
 		tx_desc = PCH_GBE_TX_DESC(*tx_ring, i);
 		tx_desc->gbec_status = (DSC_INIT16);
 	}
-	return;
+
+	return 0;
 }
 
 /**
@@ -1887,7 +1900,13 @@ int pch_gbe_up(struct pch_gbe_adapter *adapter)
 			   "Error: can't bring device up - alloc rx buffers pool failed\n");
 		goto freeirq;
 	}
-	pch_gbe_alloc_tx_buffers(adapter, tx_ring);
+	err = pch_gbe_alloc_tx_buffers(adapter, tx_ring);
+	if (err) {
+		netdev_err(netdev,
+			   "Error: can't bring device up - alloc tx buffers failed\n");
+		pch_gbe_clean_tx_ring(adapter, tx_ring);
+		goto freebuf;
+	}
 	pch_gbe_alloc_rx_buffers(adapter, rx_ring, rx_ring->count);
 	adapter->tx_queue_len = netdev->tx_queue_len;
 	pch_gbe_enable_dma_rx(&adapter->hw);
@@ -1901,6 +1920,8 @@ int pch_gbe_up(struct pch_gbe_adapter *adapter)
 
 	return 0;
 
+freebuf:
+	pch_gbe_free_rx_buffers_pool(adapter, rx_ring);
 freeirq:
 	pch_gbe_free_irq(adapter);
 out:
@@ -1936,11 +1957,7 @@ void pch_gbe_down(struct pch_gbe_adapter *adapter)
 	pch_gbe_clean_tx_ring(adapter, adapter->tx_ring);
 	pch_gbe_clean_rx_ring(adapter, adapter->rx_ring);
 
-	dma_free_coherent(&adapter->pdev->dev, rx_ring->rx_buff_pool_size,
-			  rx_ring->rx_buff_pool, rx_ring->rx_buff_pool_logic);
-	rx_ring->rx_buff_pool_logic = 0;
-	rx_ring->rx_buff_pool_size = 0;
-	rx_ring->rx_buff_pool = NULL;
+	pch_gbe_free_rx_buffers_pool(adapter, rx_ring);
 }
 
 /**
-- 
2.51.0

