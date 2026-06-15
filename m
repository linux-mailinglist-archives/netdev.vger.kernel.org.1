Return-Path: <netdev+bounces-299449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id whn3OBf4L2o/KgUAu9opvQ
	(envelope-from <netdev+bounces-299449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:03:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2CA686804
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:03:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=B7r75jd7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299449-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299449-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74F6D3009F2D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744D63EDE62;
	Mon, 15 Jun 2026 12:50:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205953EA976
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:50:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527854; cv=none; b=eXLnCEcgQLVoP2aJOf308nl76FagyrSkT3uRl5y3EKruFoTzkGfheM8N/tnnJu/RTdARIcx9EDsvV3UMsk7q0/AirZJq4ucnsJYMEfV8CDVAJj3F3kzIG8qyh/jnQULpoabQLfpBNCGdN8G0a/n3EeRdsHMREcGub8h/cphV+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527854; c=relaxed/simple;
	bh=Z9K5mjkOKE6Wye0HPslSnOc7u9waufbkCEsYLvnRrp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bboPVuTJ+Zaq0xEtCZiNIxpxmOUhOQM2W5qQI8VMPtTTHDRpI5ZirUusH0bvIbKWIegIIYNdysyaXs5N/b37cCVv1rOU9aaI6C+92rltyBDVpZnuYFuIvdLl/nNdTIcpgZAhOUyJKhltDDqvGyXcdZWzu2yrEkBCKdnhHz2ZcAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7r75jd7; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c68190ade4so7010765ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781527852; x=1782132652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xDiB6Z5IIZt5Nu3FM1Eo8fiMvSOcgaswmm43PIkmUs=;
        b=B7r75jd7wnax5j2ZpeQODri0ShRbg+GiPSfSvoi/7liRIBgAzMa5y/mLPzRR9EMLHK
         G4DBAoQwfwaZW6Bwnyw4OUUsW8l/i/UP6+gwtrP05rGIZQad2zFuGslv4/6Oy0TdK/Wd
         0hhW52NwUjEH6/Spvol2kNqkZm/TVSwWiMoNGOJTMSg/WUj+6m4yJNR5KoavauAyvp4v
         6SWdBxcwXaUWTBEUeF6kRzj2+ms6IHwhTyhx7WpKgoTec95eu+ydMr7VjtXAyZqhw1n4
         /a7tvGmtuD3mv7I5wjvYNvTRh2tpfih7xqBcoBx375RxxdURBvhVw9tm1Va6gi6fWimR
         kbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527852; x=1782132652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xDiB6Z5IIZt5Nu3FM1Eo8fiMvSOcgaswmm43PIkmUs=;
        b=R/wT+XeXp5727uUTNu/dKz5w4FYFee7sxclSt2hxsZ00/qQuA7rm69K1n3fIfZWU/D
         bOWM4eATWaqG9ptyLGB5Mi7+5Y8d2y8GKKGAtjztZaZjthboqVTT04tDS6UlItQc/M03
         AKI6JniZV0xTes4t+yG5WQQn+1GTftLynaFFL6CJe4QrA648gKzqjLsJ0jK121R4yUUg
         TuxKHi1JVzbt324Sn26OzOPU0uXldZ628ySqMTUbERHnPxrwtRDQW6i091wAgN/tSKSU
         muODv6+5XXzdqfA2h0GGX/pL0mk1TznYF3RnShNmUp+ls5lsI+ExW9Ugvb4EMFs59Uow
         HbXA==
X-Forwarded-Encrypted: i=1; AFNElJ8eMCU7QxQ0G6xcfXLlzGPHY/1PifpdSkL/SMEPijd/JsJK4uBdH8dnbZ5djtmyo5OZvAH4Sso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvXgIb3UM2cNMjRdBSWcMrmZMy+O4J45eBgTQEPya3Ey2apWU
	44XshnqLjq+UmV9SA7Ulqd3Ozn+CQAJggvmN+J/JXles7twK3xQHP/YZ
X-Gm-Gg: Acq92OHiMQF5BbxGkebItWqpVGnoWWJ5Ntb+9tgQe3xRfPMrT1Ow4o6ZI+OVqi3R1Mr
	LfhhIfM77mJH9FbhaZryQWkHBHsy44xqypGc2+1uKcEy+9to5qwOdf3HFtaPuxW4c9G2sCWyl0L
	61kVDR1iMyw6rj/s6SCInuVXEnJ4uZ1yGldUoT9ZBk14S0dtaeICeOvlJp939cqrt2tanFAeg0P
	yasf8q2WKRBqopEl3ssSTTI7Fy2Dan2ZB8GNBqKqi5xD40UlhRziX9kUFYjYKWU3nWFuLMuDTW0
	dG2rA6Zhv2sg9Bll0CwlMi+a1WpY0zVWPlt6fv6zvc8mtAahQfy1PBoe/xi2Y6OHv7mS1CF52d5
	kAsM5HRGbBxHPn/NsdtzdLIfXxtt9h+4CQmBKyafTko4kz8WyxG586YvYLFJdNSOevwQxWelhmq
	wlbKaGcDOkEd6QcRNxjbx+UcnvtWN/yho6ISPR/utek+I=
X-Received: by 2002:a17:903:3ba5:b0:2c6:8d95:fd7e with SMTP id d9443c01a7336-2c68d96101bmr28736825ad.6.1781527851946;
        Mon, 15 Jun 2026 05:50:51 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:d3ee:77d0:1b59:a4a7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c5dd0sm129277535ad.20.2026.06.15.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:50:51 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Masayuki Ohtake <masa-korg@dsn.okisemi.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net v3] net: pch_gbe: handle TX skb allocation failure
Date: Mon, 15 Jun 2026 20:50:42 +0800
Message-ID: <20260615125043.3537046-1-ruoyuw560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,dsn.okisemi.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:masa-korg@dsn.okisemi.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299449-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF2CA686804

pch_gbe_alloc_tx_buffers() allocates an skb for each TX descriptor and
then passes the returned pointer to skb_reserve(). If netdev_alloc_skb()
fails, skb_reserve() dereferences NULL.

Make pch_gbe_alloc_tx_buffers() return an error when an skb allocation
fails. On failure, let pch_gbe_alloc_tx_buffers() clean the partially
allocated TX ring before returning the error. While bringing the device
up, release the RX buffer pool through a shared cleanup helper before
unwinding the IRQ setup.

Fixes: 77555ee72282 ("net: Add Gigabit Ethernet driver of Topcliff PCH")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v3:
- Move the partial TX ring cleanup into pch_gbe_alloc_tx_buffers(), as
  suggested by Simon Horman.

Changes in v2:
- Add the kernel-doc return value description for
  pch_gbe_alloc_tx_buffers().

 .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index e5a6f59..98091fb 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -1411,13 +1411,25 @@ pch_gbe_alloc_rx_buffers_pool(struct pch_gbe_adapter *adapter,
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
+ *
+ * Return: 0 on success, -ENOMEM if a TX skb allocation fails.
  */
-static void pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
-					struct pch_gbe_tx_ring *tx_ring)
+static int pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
+				    struct pch_gbe_tx_ring *tx_ring)
 {
 	struct pch_gbe_buffer *buffer_info;
 	struct sk_buff *skb;
@@ -1431,12 +1443,17 @@ static void pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
 	for (i = 0; i < tx_ring->count; i++) {
 		buffer_info = &tx_ring->buffer_info[i];
 		skb = netdev_alloc_skb(adapter->netdev, bufsz);
+		if (!skb) {
+			pch_gbe_clean_tx_ring(adapter, tx_ring);
+			return -ENOMEM;
+		}
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
@@ -1878,7 +1895,12 @@ int pch_gbe_up(struct pch_gbe_adapter *adapter)
 			   "Error: can't bring device up - alloc rx buffers pool failed\n");
 		goto freeirq;
 	}
-	pch_gbe_alloc_tx_buffers(adapter, tx_ring);
+	err = pch_gbe_alloc_tx_buffers(adapter, tx_ring);
+	if (err) {
+		netdev_err(netdev,
+			   "Error: can't bring device up - alloc tx buffers failed\n");
+		goto freebuf;
+	}
 	pch_gbe_alloc_rx_buffers(adapter, rx_ring, rx_ring->count);
 	adapter->tx_queue_len = netdev->tx_queue_len;
 	pch_gbe_enable_dma_rx(&adapter->hw);
@@ -1892,6 +1914,8 @@ int pch_gbe_up(struct pch_gbe_adapter *adapter)
 
 	return 0;
 
+freebuf:
+	pch_gbe_free_rx_buffers_pool(adapter, rx_ring);
 freeirq:
 	pch_gbe_free_irq(adapter);
 out:
@@ -1927,11 +1951,7 @@ void pch_gbe_down(struct pch_gbe_adapter *adapter)
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

