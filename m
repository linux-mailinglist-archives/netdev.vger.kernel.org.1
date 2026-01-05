Return-Path: <netdev+bounces-246903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63293CF231B
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F189E3009FE8
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B064423AB90;
	Mon,  5 Jan 2026 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YIlmCJaK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38127FD6E
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597769; cv=none; b=AVaaSZ0u3y+qjFtr+QIqCChZjqlUK09KwCPbQgv7bSnp4acClgoFHtTI7rV0uTANadhTEk9P7WxRUmGLd7kYiCAccN17ojJVIWjDwnq45owOjaDXdXSXXTvbTSioGcm+3E1OcWHX211pbCy76sW8AKQWhV0IwYbz29fHg+p2gsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597769; c=relaxed/simple;
	bh=gmtPei2Ol3eCWhPEgMT7uXJTaNUhEcv6fwBj0RDqCX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQiEcGZmwROlzsygF+wICyFjj7icRHxdENBMYC8S6SutZKdN5lyoWkqJ/HYC7tZtU7N6/ybo5Prq5s21K9Z+0aA32a65a7iy5/MXZOWmDDj9x1U0sUe9BFVHxGe2S2SfNDCFRMDtBw2bxG3RdgfokiBtLk6UuDwFd+LFRd1+5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YIlmCJaK; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so15317378b3a.1
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597766; x=1768202566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIP7YDddiNEp9WqTDFAqLaGlS7rntNxh9hw66XPiqck=;
        b=ZLpVyJt9OxvUykZP3Gl3BxXuRzShTPV4MZgVqXcLj3dR7+i8dMT/fjn5Z78LJRLNhv
         /o7JlT137vDe+XsVrVybXGwWIp6M6zOIyMl5ZN8hlz39XuFBn18jGs18dwbBdvrmC4Gu
         04zGtb2v9LGfuqRx8tDLwHt+OT2w//gekYIKbakHqkSe4XpDjO1rBViDGbCCsq2LSAAc
         375EGB27wmpZQR4beDSWVjzpkTeNZHFlbsloHW6Kg1UFoHRP9a3BFlICnDmccWvvXYzn
         B91eFMCzlTVZoGRnXNl3x8FPEeWzSdy1iIH6bVYBLKS0HwcFzQoVJCrAfiC/LP2gxxUa
         uDzQ==
X-Gm-Message-State: AOJu0Yzel68/MMvIJ/P9Yw699rpeM7359l5qZun9cuE00FNpKXpqilCI
	Mf5GTcfEfFI9dIBALByDdqPWhAgKAao+zLD8VjWx6HFkq2mxu/3YCX0vjlz+55DiZBtIztv3gyU
	4/NjUsw/r10EqPQrL/ikZqsuzNq++Kr5H1seMmX86pblKS2C5T5JqONkqQCdT30lwfMx0sy3cpI
	aWSPpKgPkiSXg88pWBfBH+al3GtLwbXJEUBEPixIuhM29aK5Hd6ZQL9lu6fXAuxyk6pbGHjTOR3
	rQmtSaTKeD4lyz7Ml/d
X-Gm-Gg: AY/fxX4gmIW2k6cjpONgUEPYAoCAmsZMf46zpQRIjYdegG2w9kv7gg8mi15phlL1jBA
	fGfDEMKZGrk/eu7qz269CuY+SEy6jjsYzYj68oBP6Tmle/V+AMsazdelffbCQr3KWZpv2ciFZaf
	DdFA02FFJKTEHpJOG2jxfWkJ1ScWLMspYi6vIexADKnBN5NAyaDSvhSfEbdK+iYX4uo80Dwh4gw
	fmzyFVl5ePqjwBAD+rbzTvCKVGh0xi3thSiNfasl5tTrJMak6W0Q60CjTcWYPK4qgb78EcxXeIO
	F9f3QBCTTFW1tdoUzqrdnGIrK0bB10fxdC5eG04gngz6MaRI/4ZMQoV2AOOFKWoa5v9x8zd4G7s
	SXRMExo4zD1uuPBqN30RaJy5CoQzQPhui3aQograE/Co+Y8tZeZgi0Apmta3QPRiG/7b5ErvATZ
	+gwRMgmWcAnIlxy9fEsFPqPjmDp6pfqJDvlZcPX0/1KWxuUU5VlRJX8A==
X-Google-Smtp-Source: AGHT+IGdxurnhSmKkn1cxMQ1wonJRWc4qfkWWmdb7CX7vHUA4yErvAG6YRS4nSQWyvhI8Uo/+fLO1SxBw/Nr
X-Received: by 2002:a05:7022:428b:b0:119:e569:fb96 with SMTP id a92af1059eb24-121722ab2c3mr49196151c88.5.1767597766366;
        Sun, 04 Jan 2026 23:22:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121724cc9dasm9692858c88.2.2026.01.04.23.22.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jan 2026 23:22:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7dd05696910so20165873b3a.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767597764; x=1768202564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIP7YDddiNEp9WqTDFAqLaGlS7rntNxh9hw66XPiqck=;
        b=YIlmCJaKf2Emo9599NAkiOB70tf6SBc7ICFzLFbMzVs22b93fqqMyqUm023x5dy1kw
         KgQcgJ8ADiM6JQmS4+KeUkVgbS5dfPrEvrztcrwbbgiRmeC068z57G5s1fpXhHmMSLb4
         iWZNu/4dXcQu3NbMoN/9c1JXuRFW5Q0LUcCsY=
X-Received: by 2002:a05:6a00:2907:b0:7e8:450c:61b3 with SMTP id d2e1a72fcca58-7ff6607e34dmr43942524b3a.35.1767597764383;
        Sun, 04 Jan 2026 23:22:44 -0800 (PST)
X-Received: by 2002:a05:6a00:2907:b0:7e8:450c:61b3 with SMTP id d2e1a72fcca58-7ff6607e34dmr43942498b3a.35.1767597763898;
        Sun, 04 Jan 2026 23:22:43 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab836sm47293293b3a.36.2026.01.04.23.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:22:43 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v4, net-next 4/7] bng_en: Add TX support
Date: Mon,  5 Jan 2026 12:51:40 +0530
Message-ID: <20260105072143.19447-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add functions to support xmit along with TSO/GSO.
Also, add functions to handle TX completion events in the NAPI context.
This commit introduces the fundamental transmit data path

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 100 ++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   3 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 389 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  34 ++
 4 files changed, 516 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index ad29c489cc88..54b487204f17 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -393,9 +393,60 @@ static void bnge_free_rx_ring_pair_bufs(struct bnge_net *bn)
 		bnge_free_one_rx_ring_pair_bufs(bn, &bn->rx_ring[i]);
 }
 
+static void bnge_free_tx_skbs(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	u16 max_idx;
+	int i;
+
+	max_idx = bn->tx_nr_pages * TX_DESC_CNT;
+	for (i = 0; i < bd->tx_nr_rings; i++) {
+		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
+		int j;
+
+		if (!txr->tx_buf_ring)
+			continue;
+
+		for (j = 0; j < max_idx;) {
+			struct bnge_sw_tx_bd *tx_buf = &txr->tx_buf_ring[j];
+			struct sk_buff *skb;
+			int k, last;
+
+			skb = tx_buf->skb;
+			if (!skb) {
+				j++;
+				continue;
+			}
+
+			tx_buf->skb = NULL;
+
+			dma_unmap_single(bd->dev,
+					 dma_unmap_addr(tx_buf, mapping),
+					 skb_headlen(skb),
+					 DMA_TO_DEVICE);
+
+			last = tx_buf->nr_frags;
+			j += 2;
+			for (k = 0; k < last; k++, j++) {
+				int ring_idx = j & bn->tx_ring_mask;
+				skb_frag_t *frag = &skb_shinfo(skb)->frags[k];
+
+				tx_buf = &txr->tx_buf_ring[ring_idx];
+				dma_unmap_page(bd->dev,
+					       dma_unmap_addr(tx_buf, mapping),
+					       skb_frag_size(frag),
+					       DMA_TO_DEVICE);
+			}
+			dev_kfree_skb(skb);
+		}
+		netdev_tx_reset_queue(netdev_get_tx_queue(bd->netdev, i));
+	}
+}
+
 static void bnge_free_all_rings_bufs(struct bnge_net *bn)
 {
 	bnge_free_rx_ring_pair_bufs(bn);
+	bnge_free_tx_skbs(bn);
 }
 
 static void bnge_free_rx_rings(struct bnge_net *bn)
@@ -1825,6 +1876,8 @@ static void bnge_enable_napi(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
+		bnapi->tx_fault = 0;
+
 		napi_enable_locked(&bnapi->napi);
 	}
 }
@@ -2231,6 +2284,42 @@ static int bnge_init_nic(struct bnge_net *bn)
 	return rc;
 }
 
+static void bnge_tx_disable(struct bnge_net *bn)
+{
+	struct bnge_tx_ring_info *txr;
+	int i;
+
+	if (bn->tx_ring) {
+		for (i = 0; i < bn->bd->tx_nr_rings; i++) {
+			txr = &bn->tx_ring[i];
+			WRITE_ONCE(txr->dev_state, BNGE_DEV_STATE_CLOSING);
+		}
+	}
+	/* Make sure napi polls see @dev_state change */
+	synchronize_net();
+
+	if (!bn->netdev)
+		return;
+	/* Drop carrier first to prevent TX timeout */
+	netif_carrier_off(bn->netdev);
+	/* Stop all TX queues */
+	netif_tx_disable(bn->netdev);
+}
+
+static void bnge_tx_enable(struct bnge_net *bn)
+{
+	struct bnge_tx_ring_info *txr;
+	int i;
+
+	for (i = 0; i < bn->bd->tx_nr_rings; i++) {
+		txr = &bn->tx_ring[i];
+		WRITE_ONCE(txr->dev_state, 0);
+	}
+	/* Make sure napi polls see @dev_state change */
+	synchronize_net();
+	netif_tx_wake_all_queues(bn->netdev);
+}
+
 static int bnge_open_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2268,6 +2357,8 @@ static int bnge_open_core(struct bnge_net *bn)
 	set_bit(BNGE_STATE_OPEN, &bd->state);
 
 	bnge_enable_int(bn);
+
+	bnge_tx_enable(bn);
 	return 0;
 
 err_free_irq:
@@ -2278,13 +2369,6 @@ static int bnge_open_core(struct bnge_net *bn)
 	return rc;
 }
 
-static netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	dev_kfree_skb_any(skb);
-
-	return NETDEV_TX_OK;
-}
-
 static int bnge_open(struct net_device *dev)
 {
 	struct bnge_net *bn = netdev_priv(dev);
@@ -2307,6 +2391,8 @@ static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 
+	bnge_tx_disable(bn);
+
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index b5c3284ee0b6..fba758cc8b04 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -243,6 +243,8 @@ struct bnge_net {
 
 	unsigned long		state;
 #define BNGE_STATE_NAPI_DISABLED	0
+
+	u32			msg_enable;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -431,6 +433,7 @@ struct bnge_napi {
 #define BNGE_TX_EVENT			4
 #define BNGE_REDIRECT_EVENT		8
 #define BNGE_TX_CMP_EVENT		0x10
+	u8				tx_fault:1;
 };
 
 #define INVALID_STATS_CTX_ID	-1
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index fb29465f3c72..c7b89b1635a2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -50,6 +50,23 @@ static void bnge_sched_reset_rxr(struct bnge_net *bn,
 	rxr->rx_next_cons = 0xffff;
 }
 
+static void bnge_sched_reset_txr(struct bnge_net *bn,
+				 struct bnge_tx_ring_info *txr,
+				 u16 curr)
+{
+	struct bnge_napi *bnapi = txr->bnapi;
+
+	if (bnapi->tx_fault)
+		return;
+
+	netdev_err(bn->netdev, "Invalid Tx completion (ring:%d tx_hw_cons:%u cons:%u prod:%u curr:%u)",
+		   txr->txq_index, txr->tx_hw_cons,
+		   txr->tx_cons, txr->tx_prod, curr);
+	WARN_ON_ONCE(1);
+	bnapi->tx_fault = 1;
+	/* TODO: Initiate reset task */
+}
+
 void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data)
 {
 	struct bnge_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
@@ -379,11 +396,86 @@ static int bnge_force_rx_discard(struct bnge_net *bn,
 	return rc;
 }
 
+static void __bnge_tx_int(struct bnge_net *bn, struct bnge_tx_ring_info *txr,
+			  int budget)
+{
+	u16 hw_cons = txr->tx_hw_cons;
+	struct bnge_dev *bd = bn->bd;
+	unsigned int tx_bytes = 0;
+	unsigned int tx_pkts = 0;
+	struct netdev_queue *txq;
+	u16 cons = txr->tx_cons;
+	skb_frag_t *frag;
+
+	txq = netdev_get_tx_queue(bn->netdev, txr->txq_index);
+
+	while (RING_TX(bn, cons) != hw_cons) {
+		struct bnge_sw_tx_bd *tx_buf;
+		struct sk_buff *skb;
+		int j, last;
+
+		tx_buf = &txr->tx_buf_ring[RING_TX(bn, cons)];
+		skb = tx_buf->skb;
+		if (unlikely(!skb)) {
+			bnge_sched_reset_txr(bn, txr, cons);
+			return;
+		}
+
+		cons = NEXT_TX(cons);
+		tx_pkts++;
+		tx_bytes += skb->len;
+		tx_buf->skb = NULL;
+
+		dma_unmap_single(bd->dev, dma_unmap_addr(tx_buf, mapping),
+				 skb_headlen(skb), DMA_TO_DEVICE);
+		last = tx_buf->nr_frags;
+
+		for (j = 0; j < last; j++) {
+			frag = &skb_shinfo(skb)->frags[j];
+			cons = NEXT_TX(cons);
+			tx_buf = &txr->tx_buf_ring[RING_TX(bn, cons)];
+			netmem_dma_unmap_page_attrs(bd->dev,
+						    dma_unmap_addr(tx_buf,
+								   mapping),
+						    skb_frag_size(frag),
+						    DMA_TO_DEVICE, 0);
+		}
+
+		cons = NEXT_TX(cons);
+
+		napi_consume_skb(skb, budget);
+	}
+
+	WRITE_ONCE(txr->tx_cons, cons);
+
+	__netif_txq_completed_wake(txq, tx_pkts, tx_bytes,
+				   bnge_tx_avail(bn, txr), bn->tx_wake_thresh,
+				   (READ_ONCE(txr->dev_state) ==
+				    BNGE_DEV_STATE_CLOSING));
+}
+
+static void bnge_tx_int(struct bnge_net *bn, struct bnge_napi *bnapi,
+			int budget)
+{
+	struct bnge_tx_ring_info *txr;
+	int i;
+
+	bnge_for_each_napi_tx(i, bnapi, txr) {
+		if (txr->tx_hw_cons != RING_TX(bn, txr->tx_cons))
+			__bnge_tx_int(bn, txr, budget);
+	}
+
+	bnapi->events &= ~BNGE_TX_CMP_EVENT;
+}
+
 static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
 				  int budget)
 {
 	struct bnge_rx_ring_info *rxr = bnapi->rx_ring;
 
+	if ((bnapi->events & BNGE_TX_CMP_EVENT) && !bnapi->tx_fault)
+		bnge_tx_int(bn, bnapi, budget);
+
 	if ((bnapi->events & BNGE_RX_EVENT)) {
 		bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
 		bnapi->events &= ~BNGE_RX_EVENT;
@@ -456,9 +548,26 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 		cmp_type = TX_CMP_TYPE(txcmp);
 		if (cmp_type == CMP_TYPE_TX_L2_CMP ||
 		    cmp_type == CMP_TYPE_TX_L2_COAL_CMP) {
-			/*
-			 * Tx Compl Processng
-			 */
+			u32 opaque = txcmp->tx_cmp_opaque;
+			struct bnge_tx_ring_info *txr;
+			u16 tx_freed;
+
+			txr = bnapi->tx_ring[TX_OPAQUE_RING(opaque)];
+			event |= BNGE_TX_CMP_EVENT;
+			if (cmp_type == CMP_TYPE_TX_L2_COAL_CMP)
+				txr->tx_hw_cons = TX_CMP_SQ_CONS_IDX(txcmp);
+			else
+				txr->tx_hw_cons = TX_OPAQUE_PROD(bn, opaque);
+			tx_freed = ((txr->tx_hw_cons - txr->tx_cons) &
+				    bn->tx_ring_mask);
+			/* return full budget so NAPI will complete. */
+			if (unlikely(tx_freed >= bn->tx_wake_thresh)) {
+				rx_pkts = budget;
+				raw_cons = NEXT_RAW_CMP(raw_cons);
+				if (budget)
+					cpr->has_more_work = 1;
+				break;
+			}
 		} else if (cmp_type >= CMP_TYPE_RX_L2_CMP &&
 			   cmp_type <= CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
 			if (likely(budget))
@@ -613,3 +722,277 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
 poll_done:
 	return work_done;
 }
+
+static u16 bnge_xmit_get_cfa_action(struct sk_buff *skb)
+{
+	struct metadata_dst *md_dst = skb_metadata_dst(skb);
+
+	if (!md_dst || md_dst->type != METADATA_HW_PORT_MUX)
+		return 0;
+
+	return md_dst->u.port_info.port_id;
+}
+
+static const u16 bnge_lhint_arr[] = {
+	TX_BD_FLAGS_LHINT_512_AND_SMALLER,
+	TX_BD_FLAGS_LHINT_512_TO_1023,
+	TX_BD_FLAGS_LHINT_1024_TO_2047,
+	TX_BD_FLAGS_LHINT_1024_TO_2047,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
+};
+
+static void bnge_txr_db_kick(struct bnge_net *bn, struct bnge_tx_ring_info *txr,
+			     u16 prod)
+{
+	/* Sync BD data before updating doorbell */
+	wmb();
+	bnge_db_write(bn->bd, &txr->tx_db, prod);
+	txr->kick_pending = 0;
+}
+
+netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_tx_ring_info *txr;
+	struct bnge_dev *bd = bn->bd;
+	unsigned int length, pad = 0;
+	struct bnge_sw_tx_bd *tx_buf;
+	struct tx_bd *txbd, *txbd0;
+	struct netdev_queue *txq;
+	struct tx_bd_ext *txbd1;
+	u16 prod, last_frag;
+	dma_addr_t mapping;
+	__le32 lflags = 0;
+	skb_frag_t *frag;
+	int i;
+
+	i = skb_get_queue_mapping(skb);
+	if (unlikely(i >= bd->tx_nr_rings)) {
+		dev_kfree_skb_any(skb);
+		dev_core_stats_tx_dropped_inc(dev);
+		return NETDEV_TX_OK;
+	}
+
+	txq = netdev_get_tx_queue(dev, i);
+	txr = &bn->tx_ring[bn->tx_ring_map[i]];
+	prod = txr->tx_prod;
+
+#if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
+	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
+		netdev_warn_once(dev, "SKB has too many (%d) fragments, max supported is %d.  SKB will be linearized.\n",
+				 skb_shinfo(skb)->nr_frags, TX_MAX_FRAGS);
+		if (skb_linearize(skb)) {
+			dev_kfree_skb_any(skb);
+			dev_core_stats_tx_dropped_inc(dev);
+			return NETDEV_TX_OK;
+		}
+	}
+#endif
+	free_size = bnge_tx_avail(bn, txr);
+	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
+		/* We must have raced with NAPI cleanup */
+		if (net_ratelimit() && txr->kick_pending)
+			netif_warn(bn, tx_err, dev,
+				   "bnge: ring busy w/ flush pending!\n");
+		if (!netif_txq_try_stop(txq, bnge_tx_avail(bn, txr),
+					bn->tx_wake_thresh))
+			return NETDEV_TX_BUSY;
+	}
+
+	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
+		goto tx_free;
+
+	length = skb->len;
+	len = skb_headlen(skb);
+	last_frag = skb_shinfo(skb)->nr_frags;
+
+	txbd = &txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
+
+	tx_buf = &txr->tx_buf_ring[RING_TX(bn, prod)];
+	tx_buf->skb = skb;
+	tx_buf->nr_frags = last_frag;
+
+	vlan_tag_flags = 0;
+	cfa_action = bnge_xmit_get_cfa_action(skb);
+	if (skb_vlan_tag_present(skb)) {
+		vlan_tag_flags = TX_BD_CFA_META_KEY_VLAN |
+				 skb_vlan_tag_get(skb);
+		/* Currently supports 8021Q, 8021AD vlan offloads
+		 * QINQ1, QINQ2, QINQ3 vlan headers are deprecated
+		 */
+		if (skb->vlan_proto == htons(ETH_P_8021Q))
+			vlan_tag_flags |= 1 << TX_BD_CFA_META_TPID_SHIFT;
+	}
+
+	if (unlikely(skb->no_fcs))
+		lflags |= cpu_to_le32(TX_BD_FLAGS_NO_CRC);
+
+	if (length < BNGE_MIN_PKT_SIZE) {
+		pad = BNGE_MIN_PKT_SIZE - length;
+		if (skb_pad(skb, pad))
+			/* SKB already freed. */
+			goto tx_kick_pending;
+		length = BNGE_MIN_PKT_SIZE;
+	}
+
+	mapping = dma_map_single(bd->dev, skb->data, len, DMA_TO_DEVICE);
+
+	if (unlikely(dma_mapping_error(bd->dev, mapping)))
+		goto tx_free;
+
+	dma_unmap_addr_set(tx_buf, mapping, mapping);
+	flags = (len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_LONG_TX_BD |
+		TX_BD_CNT(last_frag + 2);
+
+	txbd->tx_bd_haddr = cpu_to_le64(mapping);
+	txbd->tx_bd_opaque = SET_TX_OPAQUE(bn, txr, prod, 2 + last_frag);
+
+	prod = NEXT_TX(prod);
+	txbd1 = (struct tx_bd_ext *)
+		&txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
+
+	txbd1->tx_bd_hsize_lflags = lflags;
+	if (skb_is_gso(skb)) {
+		bool udp_gso = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4);
+		u32 hdr_len;
+
+		if (skb->encapsulation) {
+			if (udp_gso)
+				hdr_len = skb_inner_transport_offset(skb) +
+					  sizeof(struct udphdr);
+			else
+				hdr_len = skb_inner_tcp_all_headers(skb);
+		} else if (udp_gso) {
+			hdr_len = skb_transport_offset(skb) +
+				  sizeof(struct udphdr);
+		} else {
+			hdr_len = skb_tcp_all_headers(skb);
+		}
+
+		txbd1->tx_bd_hsize_lflags |= cpu_to_le32(TX_BD_FLAGS_LSO |
+					TX_BD_FLAGS_T_IPID |
+					(hdr_len << (TX_BD_HSIZE_SHIFT - 1)));
+		length = skb_shinfo(skb)->gso_size;
+		txbd1->tx_bd_mss = cpu_to_le32(length);
+		length += hdr_len;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		txbd1->tx_bd_hsize_lflags |=
+			cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM);
+		txbd1->tx_bd_mss = 0;
+	}
+
+	length >>= 9;
+	if (unlikely(length >= ARRAY_SIZE(bnge_lhint_arr))) {
+		dev_warn_ratelimited(bd->dev, "Dropped oversize %d bytes TX packet.\n",
+				     skb->len);
+		i = 0;
+		goto tx_dma_error;
+	}
+	flags |= bnge_lhint_arr[length];
+	txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
+
+	txbd1->tx_bd_cfa_meta = cpu_to_le32(vlan_tag_flags);
+	txbd1->tx_bd_cfa_action =
+			cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
+	txbd0 = txbd;
+	for (i = 0; i < last_frag; i++) {
+		frag = &skb_shinfo(skb)->frags[i];
+
+		prod = NEXT_TX(prod);
+		txbd = &txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
+
+		len = skb_frag_size(frag);
+		mapping = skb_frag_dma_map(bd->dev, frag, 0, len,
+					   DMA_TO_DEVICE);
+
+		if (unlikely(dma_mapping_error(bd->dev, mapping)))
+			goto tx_dma_error;
+
+		tx_buf = &txr->tx_buf_ring[RING_TX(bn, prod)];
+		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), tx_buf,
+					  mapping, mapping);
+
+		txbd->tx_bd_haddr = cpu_to_le64(mapping);
+
+		flags = len << TX_BD_LEN_SHIFT;
+		txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
+	}
+
+	flags &= ~TX_BD_LEN;
+	txbd->tx_bd_len_flags_type =
+		cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
+			    TX_BD_FLAGS_PACKET_END);
+
+	netdev_tx_sent_queue(txq, skb->len);
+
+	prod = NEXT_TX(prod);
+	WRITE_ONCE(txr->tx_prod, prod);
+
+	if (!netdev_xmit_more() || netif_xmit_stopped(txq)) {
+		bnge_txr_db_kick(bn, txr, prod);
+	} else {
+		if (free_size >= bn->tx_wake_thresh)
+			txbd0->tx_bd_len_flags_type |=
+				cpu_to_le32(TX_BD_FLAGS_NO_CMPL);
+		txr->kick_pending = 1;
+	}
+
+	if (unlikely(bnge_tx_avail(bn, txr) <= MAX_SKB_FRAGS + 1)) {
+		if (netdev_xmit_more()) {
+			txbd0->tx_bd_len_flags_type &=
+				cpu_to_le32(~TX_BD_FLAGS_NO_CMPL);
+			bnge_txr_db_kick(bn, txr, prod);
+		}
+
+		netif_txq_try_stop(txq, bnge_tx_avail(bn, txr),
+				   bn->tx_wake_thresh);
+	}
+	return NETDEV_TX_OK;
+
+tx_dma_error:
+	last_frag = i;
+
+	/* start back at beginning and unmap skb */
+	prod = txr->tx_prod;
+	tx_buf = &txr->tx_buf_ring[RING_TX(bn, prod)];
+	dma_unmap_single(bd->dev, dma_unmap_addr(tx_buf, mapping),
+			 skb_headlen(skb), DMA_TO_DEVICE);
+	prod = NEXT_TX(prod);
+
+	/* unmap remaining mapped pages */
+	for (i = 0; i < last_frag; i++) {
+		prod = NEXT_TX(prod);
+		tx_buf = &txr->tx_buf_ring[RING_TX(bn, prod)];
+		frag = &skb_shinfo(skb)->frags[i];
+		netmem_dma_unmap_page_attrs(bd->dev,
+					    dma_unmap_addr(tx_buf, mapping),
+					    skb_frag_size(frag),
+					    DMA_TO_DEVICE, 0);
+	}
+
+tx_free:
+	dev_kfree_skb_any(skb);
+
+tx_kick_pending:
+	if (txr->kick_pending)
+		bnge_txr_db_kick(bn, txr, txr->tx_prod);
+	txr->tx_buf_ring[RING_TX(bn, txr->tx_prod)].skb = NULL;
+	dev_core_stats_tx_dropped_inc(dev);
+	return NETDEV_TX_OK;
+}
+
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index b13081b0eb79..8cd980875a3b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -7,6 +7,34 @@
 #include <linux/bnxt/hsi.h>
 #include "bnge_netdev.h"
 
+static inline u32 bnge_tx_avail(struct bnge_net *bn,
+				const struct bnge_tx_ring_info *txr)
+{
+	u32 used = READ_ONCE(txr->tx_prod) - READ_ONCE(txr->tx_cons);
+
+	return bn->tx_ring_size - (used & bn->tx_ring_mask);
+}
+
+static inline void bnge_writeq_relaxed(struct bnge_dev *bd, u64 val,
+				       void __iomem *addr)
+{
+#if BITS_PER_LONG == 32
+	spin_lock(&bd->db_lock);
+	lo_hi_writeq_relaxed(val, addr);
+	spin_unlock(&bd->db_lock);
+#else
+	writeq_relaxed(val, addr);
+#endif
+}
+
+/* For TX and RX ring doorbells with no ordering guarantee*/
+static inline void bnge_db_write_relaxed(struct bnge_net *bn,
+					 struct bnge_db_info *db, u32 idx)
+{
+	bnge_writeq_relaxed(bn->bd, db->db_key64 | DB_RING_IDX(db, idx),
+			    db->doorbell);
+}
+
 #define BNGE_MIN_PKT_SIZE	52
 
 #define TX_OPAQUE_IDX_MASK	0x0000ffff
@@ -26,6 +54,11 @@
 				 TX_OPAQUE_BDS_SHIFT)
 #define TX_OPAQUE_PROD(bn, opq)	((TX_OPAQUE_IDX(opq) + TX_OPAQUE_BDS(opq)) &\
 				 (bn)->tx_ring_mask)
+#define TX_BD_CNT(n)	(((n) << TX_BD_FLAGS_BD_CNT_SHIFT) & TX_BD_FLAGS_BD_CNT)
+
+#define TX_MAX_BD_CNT	32
+
+#define TX_MAX_FRAGS		(TX_MAX_BD_CNT - 2)
 
 /* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1.  We need one extra
  * BD because the first TX BD is always a long BD.
@@ -85,6 +118,7 @@
 	  RX_CMPL_CFA_CODE_MASK) >> RX_CMPL_CFA_CODE_SFT)
 
 irqreturn_t bnge_msix(int irq, void *dev_instance);
+netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev);
 void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data);
 int bnge_napi_poll(struct napi_struct *napi, int budget);
 #endif /* _BNGE_TXRX_H_ */
-- 
2.47.3


