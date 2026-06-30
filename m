Return-Path: <netdev+bounces-302942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j/4hKGhDQ2r2WAoAu9opvQ
	(envelope-from <netdev+bounces-302942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:17:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B50E6E0368
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:17:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="p/d33csW";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302942-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302942-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16B193029C02
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C33E120D;
	Tue, 30 Jun 2026 04:16:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A503E0223
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793003; cv=none; b=AuX/96Wn0jYMDJ3NB650Q7EMOBm/OdXss/8m/j8MSpGUKIIOLe76jKhh/r4dlfI8UGSRMD2imIJ2GmS2hVQU1iwTO+AylnnVDwbEAVQ3a89tGMlumx/X0ylV1ztSjgw5Z0qT8RjQg17hgLKxq8FnIJ4S9DEv+nnoaGvxOO0J3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793003; c=relaxed/simple;
	bh=0Qt92JgevbJ436NjZb5gOHTxwN/46woj7XC0NRuw4Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/HfLlOannJs8K1cQndFGoo3KJF3wqIGRF1QnDTxQvOaHxcyGqQTdM3Y0S6XNz+dNaY/TzlQYk7MyZNaNkpC601cFA+zOpGB3F3dNIbDRqXYyEJpWtvAnQErz8/TKGVJJRM2pk4B+f7i9hesd2rbFq4DEdyA0pSi9F2Z0FtnbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/d33csW; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c821a50615so20309285ad.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793001; x=1783397801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NU7pPyMnYTsGovaqysWUhk2/+aqNgVpf2yastUWEnZk=;
        b=p/d33csWHIiPkV30npFdXVu8r1srITEejPIQXE3MjYEMVNngaAd+HxZCg6PaOKRVHb
         L3/GmEgtK/+IX3QsxOQJiVXwsC6mWpuO4/r0IoSKFNK5qi9c8qeIuvr6Ai1fwWYffZlM
         QZu1idQwcW4nfMbKk5HFkFX1T4/NhqIPhdg/2Nedxa4ObYytVaaVgl8ovR/JHR5PPqW5
         HEEPe2Mesy/e3ZXGoXvNQ8ALfl8SKDJ5dEAmbDCqoVK5DIdX6iGxVyPnDTzn4D0Xt5D2
         bKBI6Cqe18u2F4z+CfRt5UyYscJWK5Hd6KbFZU/vQIojKq6Fm6To7l4223IucYvhkqR3
         f80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793001; x=1783397801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NU7pPyMnYTsGovaqysWUhk2/+aqNgVpf2yastUWEnZk=;
        b=fGYDu3rJZixYqPW6EcsRtIsnD1T5r6xtWoHcwkh0Ask0IqovQboVwjGV4GHRg7nHqo
         drKXOPnSzpE/HYDKoJxOVEsgRz98F+hlH7LhxkPHlWm6Fb9b7aD7jtOuTTynHxMFJXYQ
         oOjEv8vr/JnB0Yqt2w25rLzXq1MwTYP/VOb4Nz90FQzq1ToFmkkdU5T6ylt0ldzc7ISc
         r8WE55X+n9GYxs6NXGLcM7OYYBOwglWgR7QUTZRcl4hWIAEGhcAxw8uEHuV2dRQ+xxE8
         KkdwXd4ok2B6qV9tNydso0IvIUx0q2vGvj+S76Q98J03FdklY1HNlydsGvrORj8dn1As
         D6jQ==
X-Gm-Message-State: AOJu0YyhctZ5HyN4VdeRVKT2bFf8UToxSiQQKiXb7hfQLIKX1fCJMA+B
	s9+h6Bir1qKFMxaILL9Krjgmc+l/aYeZtMGc3QRCoGbASIpAlyHzTJhT7GaBhjOI
X-Gm-Gg: AfdE7cloBMPvTVm6YcdHeM4wDAfr8pQfsechOAdSmGlkIld86GFuMN2DK+9GEhhmZxE
	PBJqeUz2sM0jt4pDwX6Ukm42iQ842yVDl7YK2m5hd/3QPmB0xLGqnIqMRc7s7nCegvaC4Q5CHJ/
	OzuCvKEM6aiOOMV2+nNhWh+ozYKlDarAjfTbu2Cv88conQ8TXTSyOab6G3Fqkv1tNnRy8XCQcR2
	y5+o+Msv0I/D34ps8g3Wd4UO+xRa2IW6fHVy6GpgbCuSJyLiBwufipi/s9oMdHA0+w+m1ujrDw+
	ABbcMxFxVCuSPLHqiXfKWQLFPMH16pjZ6hfwsNxMFGbG3ZaRVec4Neh9VTgoUvzi1Mx9A39CTHE
	VIyANmFDK8MsybV+WYzdOc/Fyh7kiyx+c/Ia1acG8YuB7yplQFgHnm7EPWX9XN4QnXlVmzkYGxC
	w+md860kkLhoWyYhcWP3ttfUfHCfTe2EXOOAaKXClS6oIkGDrw/rbsbYKdm9tNHNA1ZTCc9eTul
	hsIoPYmtg==
X-Received: by 2002:a17:903:8cd:b0:2c9:854b:d53c with SMTP id d9443c01a7336-2ca2ea1f373mr14812175ad.36.1782793000660;
        Mon, 29 Jun 2026 21:16:40 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/10] net: emac: use DMA-specific and SMP memory barriers
Date: Mon, 29 Jun 2026 21:16:27 -0700
Message-ID: <20260630041634.284127-4-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302942-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B50E6E0368

Replace generic wmb()/mb() barriers with more specific variants:
- dma_wmb() for ordering descriptor field writes before hardware
  ownership bit (ctrl) hand-off in TX/RX paths
- dma_rmb() for ordering descriptor ctrl read after ownership
  observation in the RX poll path
- smp_wmb() for CPU-to-CPU ordering (link_polling flag,
  platform_set_drvdata visibility)
- dma_rmb() for the RX descriptor ownership transfer read

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c  | 16 ++++++++--------
 drivers/net/ethernet/ibm/emac/mal.c   |  2 +-
 drivers/net/ethernet/ibm/emac/rgmii.c |  2 +-
 drivers/net/ethernet/ibm/emac/tah.c   |  2 +-
 drivers/net/ethernet/ibm/emac/zmii.c  |  4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 1d46cf6c2c12..5e7b85d28bde 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1185,7 +1185,7 @@ __emac_prepare_rx_skb(struct sk_buff *skb, struct emac_instance *dev, int slot)
 	dev->rx_desc[slot].data_ptr =
 	    dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
 			   dev->rx_sync_size, DMA_FROM_DEVICE) + NET_IP_ALIGN;
-	wmb();
+	dma_wmb();
 	dev->rx_desc[slot].ctrl = MAL_RX_CTRL_EMPTY |
 	    (slot == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
 
@@ -1263,7 +1263,7 @@ static int emac_open(struct net_device *ndev)
 			link_poll_interval = PHY_POLL_LINK_OFF;
 		}
 		dev->link_polling = 1;
-		wmb();
+		smp_wmb();
 		schedule_delayed_work(&dev->link_work, link_poll_interval);
 		emac_print_link_status(dev);
 	} else
@@ -1464,7 +1464,7 @@ static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 						     skb->data, len,
 						     DMA_TO_DEVICE);
 	dev->tx_desc[slot].data_len = (u16) len;
-	wmb();
+	dma_wmb();
 	dev->tx_desc[slot].ctrl = ctrl;
 
 	return emac_xmit_finish(dev, len);
@@ -1560,7 +1560,7 @@ emac_start_xmit_sg(struct sk_buff *skb, struct net_device *ndev)
 	/* Send the packet out */
 	if (dev->tx_slot == NUM_TX_BUFF - 1)
 		ctrl |= MAL_TX_CTRL_WRAP;
-	wmb();
+	dma_wmb();
 	dev->tx_desc[dev->tx_slot].ctrl = ctrl;
 	dev->tx_slot = (slot + 1) % NUM_TX_BUFF;
 
@@ -1671,7 +1671,7 @@ static inline void emac_recycle_rx_skb(struct emac_instance *dev, int slot,
 			       DMA_FROM_DEVICE);
 
 	dev->rx_desc[slot].data_len = 0;
-	wmb();
+	dma_wmb();
 	dev->rx_desc[slot].ctrl = MAL_RX_CTRL_EMPTY |
 	    (slot == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
 }
@@ -1754,7 +1754,7 @@ static int emac_poll_rx(void *param, int budget)
 			break;
 
 		skb = dev->rx_skb[slot];
-		mb();
+		dma_rmb();
 		len = dev->rx_desc[slot].data_len;
 
 		if (unlikely(!MAL_IS_SINGLE_RX(ctrl)))
@@ -1845,7 +1845,7 @@ static int emac_poll_rx(void *param, int budget)
 	}
 
 	if (unlikely(budget && test_bit(MAL_COMMAC_RX_STOPPED, &dev->commac.flags))) {
-		mb();
+		dma_rmb();
 		if (!(dev->rx_desc[slot].ctrl & MAL_RX_CTRL_EMPTY)) {
 			DBG2(dev, "rx restart" NL);
 			received = 0;
@@ -3167,7 +3167,7 @@ static int emac_probe(struct platform_device *ofdev)
 	/* Set our drvdata last as we don't want them visible until we are
 	 * fully initialized
 	 */
-	wmb();
+	smp_wmb();
 	platform_set_drvdata(ofdev, dev);
 
 	printk(KERN_INFO "%s: EMAC-%d %pOF, MAC %pM\n",
diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 4025bc36ae16..99615c8a6c3e 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -691,7 +691,7 @@ static int mal_probe(struct platform_device *ofdev)
 	       mal->num_tx_chans, mal->num_rx_chans);
 
 	/* Advertise this instance to the rest of the world */
-	wmb();
+	smp_wmb();
 	platform_set_drvdata(ofdev, mal);
 
 	return 0;
diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index b544dd8633b7..093aa4f129e3 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -255,7 +255,7 @@ static int rgmii_probe(struct platform_device *ofdev)
 	       ofdev->dev.of_node,
 	       (dev->flags & EMAC_RGMII_FLAG_HAS_MDIO) ? "" : "out");
 
-	wmb();
+	smp_wmb();
 	platform_set_drvdata(ofdev, dev);
 
 	return 0;
diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index ed07532aaf85..077da56fa449 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -112,7 +112,7 @@ static int tah_probe(struct platform_device *ofdev)
 	tah_reset(ofdev);
 
 	printk(KERN_INFO "TAH %pOF initialized\n", ofdev->dev.of_node);
-	wmb();
+	smp_wmb();
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index a3839cf02ec4..5144ee94a7d2 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -258,8 +258,8 @@ static int zmii_probe(struct platform_device *ofdev)
 	/* Disable all inputs by default */
 	out_be32(&dev->base->fer, 0);
 
-	printk(KERN_INFO "ZMII %pOF initialized\n", ofdev->dev.of_node);
-	wmb();
+	dev_info(&ofdev->dev, "ZMII initialized\n");
+	smp_wmb();
 	platform_set_drvdata(ofdev, dev);
 
 	return 0;
-- 
2.54.0


