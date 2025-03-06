Return-Path: <netdev+bounces-172566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD390A556AE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729FC18991E1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C527CB1C;
	Thu,  6 Mar 2025 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJZJtvdg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6E27C874;
	Thu,  6 Mar 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289270; cv=none; b=fVWzndjWcEycfMURGuhtEZV4LxSm/0hENu/8j6hD3Xp/jEvquO69u66+HJhNjdeoEu4NCXD+QbUJYrHAZZEvLsjGUTXHUvlPaic9i1eV+ycwmpVs0bIhjm0TtIu12a1arpZFgQxfF8iQ4dKVGWofV0pnNQGfC+//Gk5UUe0Zr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289270; c=relaxed/simple;
	bh=v28IfsUbQe0PXYxTI+G9B9X2cdtl27D6ZmFrLIzlBkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNTH+OHhU7XyrvyaM3Pzsv+eRwYUOzb3br9+bJIyAzmqVta/CgrGUSCxuV9q8iACfZwQ02g/RbUELbgMnVKsMwDVTfiOVVMwzhm4OG/DmFmFApLSIRG8bAnSvP3KwPryh8sJ19axXA5WcmmGTBDwmqMS109GNX5vhp7raqLxAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJZJtvdg; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-60047980ffdso257012eaf.1;
        Thu, 06 Mar 2025 11:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289268; x=1741894068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1okH526yzfViUdNUDUAPmmtKrqlkw9GmVS36CY/1Jo=;
        b=HJZJtvdgpVMi/YqBupr6QoEegc1bndwD30gGl3WZCTnu+aRfoORLTRRAiAkeIPcyDj
         zKKbEjbksdU7a5tZPtsMu3wmffGWm1GyQ8dI8T9QpJCZIuieuAAvEdkzHb474/QttJk5
         D9a4+3qg2bt8C24OyMfUdJPAZLsQaDkG/NNmh0KLx4aetDv+tPGkzGVfdeOS6qyn7jlB
         sz/WkZydQVpX7sAUfryWXp9O/PRrKrYViP90IcBNgdkEBQ1tyWr/Orz4Ekd4EBeeEieL
         F/pFKcirvZniZjf2mSq2tVElELx5Uk9LVtW8+LBJzsIqY5arY79Ae6osXC+o9syQJ/fe
         9BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289268; x=1741894068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1okH526yzfViUdNUDUAPmmtKrqlkw9GmVS36CY/1Jo=;
        b=w9yqqWuk3dcPD3MzJ/IXykxKohvvrv352ya8UkY8omce9bXOPRDZqw7SmTzHdXFoy5
         lLwf/hiQSj6esrza4+1DUNO+CpkT9IP05I71kwKB1TG8nHDZ1OomhzYtP5b/f/ntV1wi
         MXyCX0oqovLA/RE3Rn/0ZfF48Qlr0p4a7qCDcjA7morta3kxn857Bjfwei+nDLxRazzA
         gdkvxlyQLuAAAFVpnv3L35EJHpZ15l9UPkrJFJzHZq7Eg5PJfR9MgZgr2AJJzn32vIP5
         qM8JOq/oU/TJ0qV3iE5TRMWevPssWyX8MWzOypoQLoJEFOM74IwzT5b2yuB63HT3FI0z
         ZQkw==
X-Forwarded-Encrypted: i=1; AJvYcCUX+oN9T9G5SEcFCEv+I1QmnPxd8C2rtKhVBpIQeY8bKKXXH8UHAx7dV/a8DXIT6CXxthpmKm2q59vzZ50=@vger.kernel.org, AJvYcCViO+sGltdpb5h7HvmVYLpNHrDIxSd662GNttybbNFRxwlhRzjSstQwz6AcUwoaQD/X/BwrXLhY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4hP3IUsyuUsb0eEiqjIqlIGUjNUdgA7lwWtSybqa7wloY7+DZ
	Pz6WS79CumNMTLfdqx00IrTBWv60PSQrzgDakmgT8GVdfwQKsWre
X-Gm-Gg: ASbGncv8/Nr7mAs4DWLBUsx66X/9wU7u4tiXs9QMVUzpcYLA2m+A42bmmCK1tp2J3az
	CYIo0iHMZ7PjyA5Pmg3QpLaWPavn/YHUkVdupZzG6BN6ypFp5IJev0lX+9BDUtVekHSsI7PWrTe
	CjGaGs84bjs/DcUM+2sWKBAjJ32d5m4o2w6dk/KYRhboODwYJ2R4iseAOUHkPOoyyUnpDGpFmPD
	vy40UbnJVDT3xu0VAlSXL6HVuClXhaY6CvofBSBSQuklSuteD4/zeLq3QYTEVrljZlxHwVrgSxi
	InVRISny4V1CIWHAPkKeIAgaMVkuTw6bvnIWY6qtD2KV6UNnUuVqeGcCenQOUtDovxe7VYQN1jL
	qT6wYKy0TLQMP
X-Google-Smtp-Source: AGHT+IEGlVrIv2cxAvja+XwhqrL6JEIqxJ9E80Yk8l52wKaRlsW5aNWuz954DK97f5MwzpCAU4fiTg==
X-Received: by 2002:a05:6871:7a11:b0:28c:8476:dd76 with SMTP id 586e51a60fabf-2c2614281aemr322759fac.29.1741289267891;
        Thu, 06 Mar 2025 11:27:47 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:47 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 11/14] net: bcmgenet: support reclaiming unsent Tx packets
Date: Thu,  6 Mar 2025 11:26:39 -0800
Message-Id: <20250306192643.2383632-12-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306192643.2383632-1-opendmb@gmail.com>
References: <20250306192643.2383632-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When disabling the transmitter any outstanding packets can now
be reclaimed by bcmgenet_tx_reclaim_all() rather than by the
bcmgenet_fini_dma() function.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 37 +++++++++++++++----
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 38943bbc35b1..0706c9635689 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1903,12 +1903,39 @@ static unsigned int __bcmgenet_tx_reclaim(struct net_device *dev,
 }
 
 static unsigned int bcmgenet_tx_reclaim(struct net_device *dev,
-				struct bcmgenet_tx_ring *ring)
+				struct bcmgenet_tx_ring *ring,
+				bool all)
 {
-	unsigned int released;
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct device *kdev = &priv->pdev->dev;
+	unsigned int released, drop, wr_ptr;
+	struct enet_cb *cb_ptr;
+	struct sk_buff *skb;
 
 	spin_lock_bh(&ring->lock);
 	released = __bcmgenet_tx_reclaim(dev, ring);
+	if (all) {
+		skb = NULL;
+		drop = (ring->prod_index - ring->c_index) & DMA_C_INDEX_MASK;
+		released += drop;
+		ring->prod_index = ring->c_index & DMA_C_INDEX_MASK;
+		while (drop--) {
+			cb_ptr = bcmgenet_put_txcb(priv, ring);
+			skb = cb_ptr->skb;
+			bcmgenet_free_tx_cb(kdev, cb_ptr);
+			if (skb && cb_ptr == GENET_CB(skb)->first_cb) {
+				dev_consume_skb_any(skb);
+				skb = NULL;
+			}
+		}
+		if (skb)
+			dev_consume_skb_any(skb);
+		bcmgenet_tdma_ring_writel(priv, ring->index,
+					  ring->prod_index, TDMA_PROD_INDEX);
+		wr_ptr = ring->write_ptr * WORDS_PER_BD(priv);
+		bcmgenet_tdma_ring_writel(priv, ring->index, wr_ptr,
+					  TDMA_WRITE_PTR);
+	}
 	spin_unlock_bh(&ring->lock);
 
 	return released;
@@ -1945,7 +1972,7 @@ static void bcmgenet_tx_reclaim_all(struct net_device *dev)
 	int i = 0;
 
 	do {
-		bcmgenet_tx_reclaim(dev, &priv->tx_rings[i++]);
+		bcmgenet_tx_reclaim(dev, &priv->tx_rings[i++], true);
 	} while (i <= priv->hw_params->tx_queues && netif_is_multiqueue(dev));
 }
 
@@ -2921,10 +2948,6 @@ static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 	bcmgenet_fini_rx_napi(priv);
 	bcmgenet_fini_tx_napi(priv);
 
-	for (i = 0; i < priv->num_tx_bds; i++)
-		dev_kfree_skb(bcmgenet_free_tx_cb(&priv->pdev->dev,
-						  priv->tx_cbs + i));
-
 	for (i = 0; i <= priv->hw_params->tx_queues; i++) {
 		txq = netdev_get_tx_queue(priv->dev, i);
 		netdev_tx_reset_queue(txq);
-- 
2.34.1


