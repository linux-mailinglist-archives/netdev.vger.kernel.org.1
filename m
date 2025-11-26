Return-Path: <netdev+bounces-242021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70C8C8BB63
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9D93B7698
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F68343D66;
	Wed, 26 Nov 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eIg/ayiq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8296D343210
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186629; cv=none; b=iw18JsmYItlLMw1g1imW6gJzMCpsuXQmwMVNcYi+4y8+wFx4j72rk9g67NW/FpDZNpTH4rvfOU+y5sT6An8qbaJBYMD/SuMQ2XbBjn6ZPOTbKct+bIl6SEosTb0Wxfd2EQNJQFqHoTLrOQVdye14HaGpgItMp6ZLg3b1v0yDTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186629; c=relaxed/simple;
	bh=YPSL1mgcj6xzfmC4ZziAgv4PZhMPkiaGbY/3iHvop+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9yN3Lou7HMtdDgs1IhR3GgNappHr0/yKU7VkHB0KVE+RklehjP73tNYzhg5WBuaHkMg8MHoLZeSOgh+yrgX5IcSgnxrZHztNJfE7Slimy8yGdDuBnUM7TBGxNqw3k03BgxTsTP0WfHmB2SanBP3AdqQ0JRJ4ycaVUg/4fRz0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eIg/ayiq; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-55ae07cf627so80545e0c.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186626; x=1764791426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7fp5me0oZSx3ZLWm9dZJtiRJ0vWaTMFJ3W4w7RFxlk=;
        b=Tebk2uWsoK00txUa0aViyRwCOeNrd92uJlZP+HROka0ls70ZMK6WkCEzCc20oMs4h2
         Q64dqKEq8pynBHxVde10qVbYyJz6tYpPixfH4UB6Bo/dcrK5yzUhdr4KkZuTg9QsFZiO
         i0lipAmKSVJuinuKOke5wPwnqwLiOabycgcL395OkqIiBEUHSQ9AysKSHvJ+OVaCOiZG
         JZp/7hO2v+XqLxFZOc5ZrAM/jEk4bPeEu511GMW1ctsgsU2gJumlvNoPdKc/88KQWP5O
         p7bRf1O9IOe3qobuUyZK8DHQJE9olMVLDw58j4JiNCmOUNwJJwCY6Nw17sE1Sh8xl5xw
         ospw==
X-Gm-Message-State: AOJu0YyL8m3P2UHkUiE6BLk6vit0C61uRJdZztRTnWpOJB9mC1eo9mSW
	2jLuhT4BT7LgPlUCRkUH6GI/5QoGgUahxfZijeFUcQaUCqc5flDTnYtkHbv2zXpHdj3zoL4ru4a
	QgGIFbMwM/dOSw1jY/7HBj22vi9OnLgpl9IWZGqogjqNSkG2Mt4Uh1dcqHtBNONhBHTI+kU6SnL
	xeGmxKI0Uys12a2C91E0JoKUc31pcR2fNdVLTb+3qpVGOxJ5+YMg0dWECfFPVXBPyinrctl+vg7
	P+fyS5tAE4oOpZ2ZLnH
X-Gm-Gg: ASbGncs+Dor98Js+s/4VPyYPuQEs6HeiK9oKGAyBZSRi290CUnI0iFHi19JqxEW8hfX
	iQ/S+t77YMtB/yfdrgbP4TPH6qNgiPiGTUSBhY0B+JVGNEubyP6COxurakXK+GYYL+2NtJvyx1M
	otyaxl+uz18u1TQSSR0aXDo1RH2+FMsZ6a0h91QSmrzKAyFjFUU7JRqyQx0ZUDHQbDg4V3WvKeb
	XW1Cj14HWBgP/leHr9xeVvQUZxPiIP9QKoIqM4swG00J7QugJd/2Ka9yndfHdWQSIpxmaGuvAn8
	Jok2hEvUwCVtvTHW48zssBQkOkZ4N1TOCCdIYicVeDuBipOTKww3qjtgPyDs3ZIh5qcHjO4lKJO
	fXsIWhgyjDiTUs9VkHvOJiWG4q3U94MdJQTV2d4OzXZuR46CfQXgV52abE3Su9f8jSCdWV7BGGe
	/kiI1MBdv2TiF1JCNOLpl00Xnp1srQMaFY0Nkeu6PAVg/uJvesVe84XQ==
X-Google-Smtp-Source: AGHT+IHc5Ki3zb4OXOJQvE8B0cpQ46Rtskfs7FzylCiUJmHekdR4RktNe1Ao+Mpq1VBPD/uNqwIdlzEo2nxf
X-Received: by 2002:a05:6122:660a:b0:53c:6d68:1cce with SMTP id 71dfb90a1353d-55b8efff034mr7242949e0c.16.1764186626276;
        Wed, 26 Nov 2025 11:50:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-55b7f617cddsm2016142e0c.2.2025.11.26.11.50.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:50:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2982dec5ccbso1860165ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764186625; x=1764791425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7fp5me0oZSx3ZLWm9dZJtiRJ0vWaTMFJ3W4w7RFxlk=;
        b=eIg/ayiqGdTkiHj86lCFohZAi6dFZeDQGI51UALMCOUPwKiDRXVZGlatkukUgBwOeh
         k2XocsNekBkqDXnpK50pdANnc3Zq6My6ZU6JgAMa694q8wMTo3WK8O4UBlSfNZVP0hr4
         534JwqiABgIj9i6xOe44Mveg5ApoboEauOdrc=
X-Received: by 2002:a17:902:cf4b:b0:295:7b8c:6611 with SMTP id d9443c01a7336-29b6c404112mr220840985ad.15.1764186624440;
        Wed, 26 Nov 2025 11:50:24 -0800 (PST)
X-Received: by 2002:a17:902:cf4b:b0:295:7b8c:6611 with SMTP id d9443c01a7336-29b6c404112mr220840835ad.15.1764186624018;
        Wed, 26 Nov 2025 11:50:24 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e638sm206782375ad.58.2025.11.26.11.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:50:23 -0800 (PST)
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
Subject: [v3, net-next 05/12] bng_en: Add TX support
Date: Thu, 27 Nov 2025 01:19:24 +0530
Message-ID: <20251126194931.455830-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  99 ++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   2 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 370 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  34 ++
 4 files changed, 495 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index bb9223a00b5..1af2c4e29c6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -394,9 +394,60 @@ static void bnge_free_rx_ring_pair_bufs(struct bnge_net *bn)
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
@@ -2232,6 +2283,44 @@ static int bnge_init_nic(struct bnge_net *bn)
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
+	if (BNGE_LINK_IS_UP(bn->bd))
+		netif_carrier_on(bn->netdev);
+}
+
 static int bnge_open_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2281,6 +2370,7 @@ static int bnge_open_core(struct bnge_net *bn)
 	set_bit(BNGE_STATE_OPEN, &bd->state);
 
 	bnge_enable_int(bn);
+	bnge_tx_enable(bn);
 	/* Poll link status and check for SFP+ module status */
 	mutex_lock(&bd->link_lock);
 	bnge_get_port_module_status(bn);
@@ -2295,13 +2385,6 @@ static int bnge_open_core(struct bnge_net *bn)
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
@@ -2324,6 +2407,8 @@ static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 
+	bnge_tx_disable(bn);
+
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 3c8fffb5e2d..94d03d1e76b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -246,6 +246,8 @@ struct bnge_net {
 
 	unsigned long		state;
 #define BNGE_STATE_NAPI_DISABLED	0
+
+	u32			msg_enable;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index c8e9b96aa1c..7470a705aae 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -386,9 +386,83 @@ static int bnge_force_rx_discard(struct bnge_net *bn,
 	return rc;
 }
 
+static bool __bnge_tx_int(struct bnge_net *bn, struct bnge_tx_ring_info *txr,
+			  int budget)
+{
+	u16 hw_cons = txr->tx_hw_cons;
+	struct bnge_dev *bd = bn->bd;
+	unsigned int tx_bytes = 0;
+	unsigned int tx_pkts = 0;
+	struct netdev_queue *txq;
+	u16 cons = txr->tx_cons;
+	skb_frag_t *frag;
+	bool rc = false;
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
+		dev_consume_skb_any(skb);
+	}
+
+	WRITE_ONCE(txr->tx_cons, cons);
+
+	__netif_txq_completed_wake(txq, tx_pkts, tx_bytes,
+				   bnge_tx_avail(bn, txr), bn->tx_wake_thresh,
+				   (READ_ONCE(txr->dev_state) ==
+				    BNGE_DEV_STATE_CLOSING));
+
+	return rc;
+}
+
+static void bnge_tx_int(struct bnge_net *bn, struct bnge_napi *bnapi,
+			int budget)
+{
+	struct bnge_tx_ring_info *txr;
+	bool more = false;
+	int i;
+
+	bnge_for_each_napi_tx(i, bnapi, txr) {
+		if (txr->tx_hw_cons != RING_TX(bn, txr->tx_cons))
+			more |= __bnge_tx_int(bn, txr, budget);
+	}
+	if (!more)
+		bnapi->events &= ~BNGE_TX_CMP_EVENT;
+}
+
 static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
 				  int budget)
 {
+	if ((bnapi->events & BNGE_TX_CMP_EVENT))
+		bnge_tx_int(bn, bnapi, budget);
 	if ((bnapi->events & BNGE_RX_EVENT)) {
 		struct bnge_rx_ring_info *rxr = bnapi->rx_ring;
 
@@ -463,9 +537,26 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
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
@@ -619,3 +710,276 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
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
+				   "bnxt: ring busy w/ flush pending!\n");
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
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index 9cd6c7ae65e..38d82cfda46 100644
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
+				       volatile void __iomem *addr)
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
@@ -78,6 +111,7 @@
 #define RING_CMP(bn, idx)	((idx) & (bn)->cp_ring_mask)
 
 irqreturn_t bnge_msix(int irq, void *dev_instance);
+netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev);
 void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data);
 int bnge_napi_poll(struct napi_struct *napi, int budget);
 #endif /* _BNGE_TXRX_H_ */
-- 
2.47.3


