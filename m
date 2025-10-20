Return-Path: <netdev+bounces-230915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D51BF1A39
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449AB424E94
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6D6322DD4;
	Mon, 20 Oct 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyBP06TQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D6322A29
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968174; cv=none; b=NkLQb1wHTQ3V6ez2FGDoSVOAvHKskZGRUGNVzu0w+6+5toGct7Df24GmQCph+UJubnix4ZWVx2o2yuWH/TqiUCeLAxVomPJGEWLDd5paMqGRXbVRd4TWj81Ixy7VTf65ZesAy8yGWKPgB6wVgvY6z6T/49So9kWvHFG3aFhQsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968174; c=relaxed/simple;
	bh=OdAkGFsVBeypNY8bG/+x2bxmidQpWkTH+22jXc8Cjk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sr8o4oL+xQ5VXAoDpxAjw1poXATMCte+Zm4Na0z42wr8937tx68SUCz7p9rhJwDqa10WSoIAZ6XZWKYZTieBGgrr9gVKFdhdcQZxpbLNbFYeferkJiBfzBr/GC6GfICLlcufojpt+1c6LrMz+BXJBmJWW/3zev7L9AXsuItcwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyBP06TQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso2826716a12.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760968172; x=1761572972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eODQs0ub6BtCBcbm30jQFNEO4Utk4CtbjZek/rCcark=;
        b=NyBP06TQ31cD4hxfY1WJg9sVX4t7jMmTENkQ0PXSPbKToz5tTNfU9Cn3lXG+M4ATk/
         3le8jww25kt4lzXp93jBrILDFZDqY02WlTiMmcHDFXCB2uZkElBjdK2NOnQnyDAsTo6/
         tQk0deOYL29lndtH5u8Ey4A3p2oy/5jy+x8qG6ZZ5Y/b88IRvaEyO9oW3J3yytxtnm92
         4hQbHka/bD63kUtzqYbPndXrMXqNmO1XbvFsBDWQVVaGxdN0MO0z+CVAXngyafXZv/2z
         ctpX7w8G7fhJF92+41tLTBmE7dwKmyHarUMVyyCIrDVpuufFc1um96+uwFd/BgGtfjph
         tpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968172; x=1761572972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eODQs0ub6BtCBcbm30jQFNEO4Utk4CtbjZek/rCcark=;
        b=YBXqr5VVtXctpQoOV2RLZP7WENjerlhmbJ0v0nis0naQvcQSVApsUv5aRwWGdKmIZ3
         I4BPvVC4G/xILsfz3LsSSng7IP5jYK5gpWBu+bS+jnuHnrvR23wiwgwYdGLtSjDaq6KC
         nksjAVc12k2XHI7LNMhF5s0WZo6rrFh5FNyJZumOnyYOvTOs7UFTkhl2XmTKSCNOa0nx
         1TI3xRfS+bLYj2m75CvCoY6GZWdasDdgG0Y804zzyLjDDlVdng0+aqeff4dVGuIrhFBi
         EMYVeIugLqT3yl/3m167guQLeP0iUo058KtEU9WCwWiRgAYk8GOgBz3+98TYCHtAg8+v
         KHGg==
X-Gm-Message-State: AOJu0YwdV+hkA2AvWAqLVqK2aeAaH7DoRFvH062YKf22EdXidhCgddCG
	P8LtfR/ui8lQjJDHl16LTGE7Bui5T6Lfe4pJUcgo5xAGTo9m5VanMYlQ
X-Gm-Gg: ASbGncucovTO+bW2fyhrHgjdxth2rBz4CzEr6CACu/tA5s5VO+YrmlNIBZxgzmTd8Sf
	bKNoKAjvnrYhIL9yuyG4mPQgru/ykn83o0SF8a1NeL7PE2E6EHtubUkkN6+D0ijIw0ShbS0h3qa
	t1n3rsXQm3IrMJIvnsWOHtTE03tDgw1X3/WcQfDM8oi22VcZ7Bb/KgB4DzhbMt3d0UbnTPuC4sP
	s94oe+XZAyGGt0aR9qHpvBQ5MkeTN88ic/4ZNUAWJ6AJY0ovTbtdeP2OySzOPoETvSqcAGrul7E
	K514EFmdF9TtKnXRMMjlb5BrppGP82CMtu8sBGKaf5rI8ita7sK0P7a6y/lBwD4Lts6mZMTDcM6
	xijR+6roOURCm9jr5e1bN8PVSbOuwliCep1XAMMqnax3dazt7b7Urfdr3bibfE2bo1emoj2HlA2
	O44V/q6djw9anRqmfS/AVK3zCgH6vkvUzF6vg6U1EEeMJMNrSYsWeMO5ANq0xTDfMBOladh4J4v
	w==
X-Google-Smtp-Source: AGHT+IFiKRAll9tcnFwi3rMLldMi2VlZJ+m3l4+IxH5yr0qxsRT3jhyqtjhnAiXqR5sBVn7aaUjVHg==
X-Received: by 2002:a17:903:2309:b0:262:79a:93fb with SMTP id d9443c01a7336-290ca121803mr178719455ad.32.1760968172002;
        Mon, 20 Oct 2025 06:49:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cc9:d444:c07a:121f:22da:3f7b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bdd02793dsm4507349a91.3.2025.10.20.06.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:49:31 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFC net-next PATCH 2/2] net: ethernet: Implement ndo_write_rx_config callback for the 8139cp driver
Date: Mon, 20 Oct 2025 19:18:57 +0530
Message-ID: <20251020134857.5820-3-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020134857.5820-1-viswanathiyyappan@gmail.com>
References: <20251020134857.5820-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ndo_write_rx_config for the 8139cp driver

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 I modified and set ndo_set_rx_mode to be __cp_set_rx_mode as using
 cp_set_rx_mode as ndo_set_rx_mode callback would have led to a deadlock
 in cp_init_hw() 
 
 drivers/net/ethernet/realtek/8139cp.c | 67 ++++++++++++++++++---------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 5652da8a178c..ff6195c7f3b6 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -319,6 +319,11 @@ struct cp_extra_stats {
 	unsigned long		rx_frags;
 };
 
+struct cp_rx_config {
+	int rx_mode;
+	u32 mc_filter[2];	/* Multicast hash filter */
+};
+
 struct cp_private {
 	void			__iomem *regs;
 	struct net_device	*dev;
@@ -328,7 +333,7 @@ struct cp_private {
 	struct napi_struct	napi;
 
 	struct pci_dev		*pdev;
-	u32			rx_config;
+	struct cp_rx_config	*rx_config;
 	u16			cpcmd;
 
 	struct cp_extra_stats	cp_stats;
@@ -882,45 +887,53 @@ static netdev_tx_t cp_start_xmit (struct sk_buff *skb,
 	goto out_unlock;
 }
 
+static void cp_write_rx_config(struct net_device *dev)
+{
+	struct cp_private *cp = netdev_priv(dev);
+	struct cp_rx_config snapshot;
+
+	read_snapshot((&snapshot), struct cp_private);
+
+	/* We can safely update without stopping the chip. */
+	cpw32_f(RxConfig, snapshot.rx_mode);
+
+	cpw32_f(MAR0 + 0, snapshot.mc_filter[0]);
+	cpw32_f(MAR0 + 4, snapshot.mc_filter[1]);
+}
+
 /* Set or clear the multicast filter for this adaptor.
    This routine is not state sensitive and need not be SMP locked. */
 
 static void __cp_set_rx_mode (struct net_device *dev)
 {
-	struct cp_private *cp = netdev_priv(dev);
-	u32 mc_filter[2];	/* Multicast hash filter */
-	int rx_mode;
+	struct cp_rx_config new_config;
 
 	/* Note: do not reorder, GCC is clever about common statements. */
 	if (dev->flags & IFF_PROMISC) {
 		/* Unconditionally log net taps. */
-		rx_mode =
+		new_config.rx_mode =
 		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
 		    AcceptAllPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
+		new_config.mc_filter[1] = new_config.mc_filter[0] = 0xffffffff;
 	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
 		   (dev->flags & IFF_ALLMULTI)) {
 		/* Too many to filter perfectly -- accept all multicasts. */
-		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
+		new_config.rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
+		new_config.mc_filter[1] = new_config.mc_filter[0] = 0xffffffff;
 	} else {
 		struct netdev_hw_addr *ha;
-		rx_mode = AcceptBroadcast | AcceptMyPhys;
-		mc_filter[1] = mc_filter[0] = 0;
+		new_config.rx_mode = AcceptBroadcast | AcceptMyPhys;
+		new_config.mc_filter[1] = new_config.mc_filter[0] = 0;
 		netdev_for_each_mc_addr(ha, dev) {
 			int bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
 
-			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
-			rx_mode |= AcceptMulticast;
+			new_config.mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
+			new_config.rx_mode |= AcceptMulticast;
 		}
 	}
 
-	/* We can safely update without stopping the chip. */
-	cp->rx_config = cp_rx_config | rx_mode;
-	cpw32_f(RxConfig, cp->rx_config);
-
-	cpw32_f (MAR0 + 0, mc_filter[0]);
-	cpw32_f (MAR0 + 4, mc_filter[1]);
+	new_config.rx_mode = cp_rx_config | new_config.rx_mode;
+	update_snapshot(&new_config, struct cp_private);
 }
 
 static void cp_set_rx_mode (struct net_device *dev)
@@ -1040,7 +1053,7 @@ static void cp_init_hw (struct cp_private *cp)
 	cp_start_hw(cp);
 	cpw8(TxThresh, 0x06); /* XXX convert magic num to a constant */
 
-	__cp_set_rx_mode(dev);
+	set_and_schedule_rx_config(dev, true);
 	cpw32_f (TxConfig, IFG | (TX_DMA_BURST << TxDMAShift));
 
 	cpw8(Config1, cpr8(Config1) | DriverLoaded | PMEnable);
@@ -1188,6 +1201,12 @@ static int cp_open (struct net_device *dev)
 	if (rc)
 		return rc;
 
+	cp->rx_config = kmalloc(sizeof(*cp->rx_config), GFP_KERNEL);
+	if (!cp->rx_config) {
+		rc = -ENOMEM;
+		goto err_out_rx_config;
+	}
+
 	napi_enable(&cp->napi);
 
 	cp_init_hw(cp);
@@ -1207,6 +1226,9 @@ static int cp_open (struct net_device *dev)
 err_out_hw:
 	napi_disable(&cp->napi);
 	cp_stop_hw(cp);
+	kfree(cp->rx_config);
+
+err_out_rx_config:
 	cp_free_rings(cp);
 	return rc;
 }
@@ -1227,6 +1249,8 @@ static int cp_close (struct net_device *dev)
 
 	cp_stop_hw(cp);
 
+	kfree(cp->rx_config);
+
 	spin_unlock_irqrestore(&cp->lock, flags);
 
 	free_irq(cp->pdev->irq, dev);
@@ -1262,7 +1286,7 @@ static void cp_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	cp_clean_rings(cp);
 	cp_init_rings(cp);
 	cp_start_hw(cp);
-	__cp_set_rx_mode(dev);
+	set_and_schedule_rx_config(dev, false);
 	cpw16_f(IntrMask, cp_norx_intr_mask);
 
 	netif_wake_queue(dev);
@@ -1869,7 +1893,8 @@ static const struct net_device_ops cp_netdev_ops = {
 	.ndo_stop		= cp_close,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address 	= cp_set_mac_address,
-	.ndo_set_rx_mode	= cp_set_rx_mode,
+	.ndo_set_rx_mode	= __cp_set_rx_mode,
+	.ndo_write_rx_config    = cp_write_rx_config,
 	.ndo_get_stats		= cp_get_stats,
 	.ndo_eth_ioctl		= cp_ioctl,
 	.ndo_start_xmit		= cp_start_xmit,
-- 
2.47.3


