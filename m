Return-Path: <netdev+bounces-250369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC89D29739
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90DE830704D1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DA430FF04;
	Fri, 16 Jan 2026 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WfgAENTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2226630EF6F
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524647; cv=none; b=bQfgq4CNQYYEuPQNYSYnNN3ukCpxwvhzvCKmzNsE0T5PIXXIHUyHFkjp5ATIyZNqO6fC9XLz16dhWadKekHd9SrWvM7zu17UfJF6pBZs1PTqahQQSKJEUJfjQEYPFaBUZFXGyX65ma/oa5xyAvyZ74C+4rrpNaul9RTx5PD0gKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524647; c=relaxed/simple;
	bh=LxCC8AKduReVOLlnP5kuSc8onO9WV8svZBgSLnuvKM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njTHgOZqiAjdz8kK8jdVC3Ir3ZKuhWYEdMGXq8AOeG8DM/EeXvPed1Lj6MIWMY+z2VpuAZuJGo05lCF/w7T97BL1eFOAjCYyU8+YKZAbbqaYuUGbVrO1WMLHp9dJ6BMpgHOEKR5CRDowQ8JxiAtgR8d8zMKsUMnqKw0JsOzSuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WfgAENTP; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a137692691so9265105ad.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768524646; x=1769129446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHFPBrVlK2s/u5AKaaQtJA7blAEpHfxbbOxow8w91c8=;
        b=B5KxoRPql9R6i18VdIFajnhHMDqpl8721+NMyR4knYgqVoNP8dzuEVuTuCznMYZw/c
         DvbLb13fTWsYcD9EgsqkJElxiuaGOkO7zKN1ATP9OuuFvRzcxdl2n5tWhDgdzXgpmiHO
         rxs9hjSQ/DN4wH65i8mb3Oww/6/jXGKItRtK25YBlGSaXN8LWwVIqfzdgmmJRenQPMac
         fbwI6Ykl8DpkkG0RHzmBv6lcs6DO8XGYAX/y+hQux8SEUzo5BCeRSytuNA8Ncicwejpr
         x7uNw89INt3NWv50UUms1T//jeuvb/JB+txn8im84yYO8W8Yblh1IPGBsa9jQ3P0QbyZ
         e2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUpuQb/VD5GkayqUJT95wzd6AxGRS+bNI1U47fY5kds+Ctu/4Kgeb7CeczGLB5Igh5dMhRuoPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA7nheXTynPHisvgyMZKKG8LQT6J/x3+JU5+dqc1r+nWcrQ1lG
	0EI5Ots35IgugBfnbVFtp2LSLbIvirWO0Uc7i6kwQkIxUFYxPnLsJA1znwYqKeuOv4TPod3JL+F
	UGssFwYWQ0xhlIYabIOm44i1JwioA0236/QTiWF+/5njWdJawtO1gaNTna88Dk60nKltHXGDuoP
	AcMmzP5YEeNtbd63O8C69QMZleRGiIpN+Z8XNhM42kpR0z+EeY9v5BGN0wAQhJ0fo7TClaTGCPN
	9DpqPWSSg==
X-Gm-Gg: AY/fxX5DQiPVBDnbS1osvEBKcTjyPXP32FnMUi7oW94VaEOsmqlOOeUMVw9NZ8OKhMH
	Wzm6HLG86CnoJXrSUOCSGGuZieGWMfWqxCB1+LDLEcxH28Jx7ftdazFSUZLn4MfaQYpLZdNQGJG
	k/k4Z4cQDFZY9hSUktQ+2SbE8+c7RJCI5xDnFKC48Jh/v3jQQPp2lVH0zZ8YQ+YQ4JftZPHg3pE
	EAoRDaGN5rc0kKhmzHjeERqeYOHg2s2EqzZzfUVDJ4sHuHut6f81ek3LmrGDG5MlAR+2lTY6wf2
	jRDMGBCIYN7d5Gtu4lQBAiPecliGTkRUP4RscIwDnt2jQFeoT1El3sanOfayC4xEz/BW/KqWdvD
	trtawWfe/3cOXDbhGI3K2gtvQOBSTfmNZTPX//72nIzyHVNlciHmHb3sr0NO725iSb0TqhSug3o
	PcU7tCrOi/Z1AyGGM3SkatW9QoeZuKBzbEhY0snSnA
X-Received: by 2002:a17:903:40cb:b0:2a0:faf1:782 with SMTP id d9443c01a7336-2a717519edbmr9682535ad.9.1768524645600;
        Thu, 15 Jan 2026 16:50:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a719190214sm1118615ad.33.2026.01.15.16.50.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 16:50:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-11b9786fb51so9599841c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768524644; x=1769129444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHFPBrVlK2s/u5AKaaQtJA7blAEpHfxbbOxow8w91c8=;
        b=WfgAENTPEgxS0jLIIHS/NT6KjJWc1R6g6Q0/YvnWoSfVItunzI3W/JCZ4wnfXQyoRa
         2zrDhHzBZKK/3h9pRfFLGa9oxKCDXl0iFBJruH69JIvYuZA2OuBJmqZ3D/lq8ISpRt6B
         d4QRvDp9FNH2cX31IGJd6kuD16L6kPnN7yQ6g=
X-Forwarded-Encrypted: i=1; AJvYcCXuyUZdXs2QJXdmB+BhBMBKwRIpMkkXZepE+GxYSn+fAn5uKhic1SHVQEq64/jwOxQIa87u4jE=@vger.kernel.org
X-Received: by 2002:a05:7022:6b86:b0:11a:fe6f:806a with SMTP id a92af1059eb24-1244a769e0emr1212111c88.31.1768524643922;
        Thu, 15 Jan 2026 16:50:43 -0800 (PST)
X-Received: by 2002:a05:7022:6b86:b0:11a:fe6f:806a with SMTP id a92af1059eb24-1244a769e0emr1212094c88.31.1768524643339;
        Thu, 15 Jan 2026 16:50:43 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm1162305c88.5.2026.01.15.16.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 16:50:42 -0800 (PST)
From: justin.chen@broadcom.com
To: florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 2/3] net: bcmasp: clean up some legacy logic
Date: Thu, 15 Jan 2026 16:50:36 -0800
Message-Id: <20260116005037.540490-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116005037.540490-1-justin.chen@broadcom.com>
References: <20260116005037.540490-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Justin Chen <justin.chen@broadcom.com>

Removed wol_irq check. This was needed for brcm,asp-v2.0, which was
removed in previous commits.

Removed bcmasp_intf_ops. These function pointers were added to make
it easier to implement pseudo channels. These channels were removed
in newer versions of the hardware and were never implemented.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   |  5 --
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 36 ------------
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 58 ++++---------------
 3 files changed, 10 insertions(+), 89 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 014340f33345..36df7d1a9be3 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1081,15 +1081,10 @@ static irqreturn_t bcmasp_isr_wol(int irq, void *data)
 	struct bcmasp_priv *priv = data;
 	u32 status;
 
-	/* No L3 IRQ, so we good */
-	if (priv->wol_irq <= 0)
-		goto irq_handled;
-
 	status = wakeup_intr2_core_rl(priv, ASP_WAKEUP_INTR2_STATUS) &
 		~wakeup_intr2_core_rl(priv, ASP_WAKEUP_INTR2_MASK_STATUS);
 	wakeup_intr2_core_wl(priv, status, ASP_WAKEUP_INTR2_CLEAR);
 
-irq_handled:
 	pm_wakeup_event(&priv->pdev->dev, 0);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index e238507be40a..29cd87335ec8 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -268,13 +268,6 @@ struct bcmasp_mib_counters {
 	u32	tx_timeout_cnt;
 };
 
-struct bcmasp_intf_ops {
-	unsigned long (*rx_desc_read)(struct bcmasp_intf *intf);
-	void (*rx_buffer_write)(struct bcmasp_intf *intf, dma_addr_t addr);
-	void (*rx_desc_write)(struct bcmasp_intf *intf, dma_addr_t addr);
-	unsigned long (*tx_read)(struct bcmasp_intf *intf);
-	void (*tx_write)(struct bcmasp_intf *intf, dma_addr_t addr);
-};
 
 struct bcmasp_priv;
 
@@ -286,7 +279,6 @@ struct bcmasp_intf {
 	/* ASP Ch */
 	int				channel;
 	int				port;
-	const struct bcmasp_intf_ops	*ops;
 
 	/* Used for splitting shared resources */
 	int				index;
@@ -407,34 +399,6 @@ struct bcmasp_priv {
 	struct mutex			net_lock;
 };
 
-static inline unsigned long bcmasp_intf_rx_desc_read(struct bcmasp_intf *intf)
-{
-	return intf->ops->rx_desc_read(intf);
-}
-
-static inline void bcmasp_intf_rx_buffer_write(struct bcmasp_intf *intf,
-					       dma_addr_t addr)
-{
-	intf->ops->rx_buffer_write(intf, addr);
-}
-
-static inline void bcmasp_intf_rx_desc_write(struct bcmasp_intf *intf,
-					     dma_addr_t addr)
-{
-	intf->ops->rx_desc_write(intf, addr);
-}
-
-static inline unsigned long bcmasp_intf_tx_read(struct bcmasp_intf *intf)
-{
-	return intf->ops->tx_read(intf);
-}
-
-static inline void bcmasp_intf_tx_write(struct bcmasp_intf *intf,
-					dma_addr_t addr)
-{
-	intf->ops->tx_write(intf, addr);
-}
-
 #define __BCMASP_IO_MACRO(name, m)					\
 static inline u32 name##_rl(struct bcmasp_intf *intf, u32 off)		\
 {									\
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index b9973956c480..6cddd3280cb8 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -231,39 +231,6 @@ static struct sk_buff *bcmasp_csum_offload(struct net_device *dev,
 	return skb;
 }
 
-static unsigned long bcmasp_rx_edpkt_dma_rq(struct bcmasp_intf *intf)
-{
-	return rx_edpkt_dma_rq(intf, RX_EDPKT_DMA_VALID);
-}
-
-static void bcmasp_rx_edpkt_cfg_wq(struct bcmasp_intf *intf, dma_addr_t addr)
-{
-	rx_edpkt_cfg_wq(intf, addr, RX_EDPKT_RING_BUFFER_READ);
-}
-
-static void bcmasp_rx_edpkt_dma_wq(struct bcmasp_intf *intf, dma_addr_t addr)
-{
-	rx_edpkt_dma_wq(intf, addr, RX_EDPKT_DMA_READ);
-}
-
-static unsigned long bcmasp_tx_spb_dma_rq(struct bcmasp_intf *intf)
-{
-	return tx_spb_dma_rq(intf, TX_SPB_DMA_READ);
-}
-
-static void bcmasp_tx_spb_dma_wq(struct bcmasp_intf *intf, dma_addr_t addr)
-{
-	tx_spb_dma_wq(intf, addr, TX_SPB_DMA_VALID);
-}
-
-static const struct bcmasp_intf_ops bcmasp_intf_ops = {
-	.rx_desc_read = bcmasp_rx_edpkt_dma_rq,
-	.rx_buffer_write = bcmasp_rx_edpkt_cfg_wq,
-	.rx_desc_write = bcmasp_rx_edpkt_dma_wq,
-	.tx_read = bcmasp_tx_spb_dma_rq,
-	.tx_write = bcmasp_tx_spb_dma_wq,
-};
-
 static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bcmasp_intf *intf = netdev_priv(dev);
@@ -368,7 +335,7 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	skb_tx_timestamp(skb);
 
-	bcmasp_intf_tx_write(intf, intf->tx_spb_dma_valid);
+	tx_spb_dma_wq(intf, intf->tx_spb_dma_valid, TX_SPB_DMA_VALID);
 
 	if (tx_spb_ring_full(intf, MAX_SKB_FRAGS + 1))
 		netif_stop_queue(dev);
@@ -449,7 +416,7 @@ static int bcmasp_tx_reclaim(struct bcmasp_intf *intf)
 	struct bcmasp_desc *desc;
 	dma_addr_t mapping;
 
-	read = bcmasp_intf_tx_read(intf);
+	read = tx_spb_dma_rq(intf, TX_SPB_DMA_READ);
 	while (intf->tx_spb_dma_read != read) {
 		txcb = &intf->tx_cbs[intf->tx_spb_clean_index];
 		mapping = dma_unmap_addr(txcb, dma_addr);
@@ -519,7 +486,7 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 	u64 flags;
 	u32 len;
 
-	valid = bcmasp_intf_rx_desc_read(intf) + 1;
+	valid = rx_edpkt_dma_rq(intf, RX_EDPKT_DMA_VALID) + 1;
 	if (valid == intf->rx_edpkt_dma_addr + DESC_RING_SIZE)
 		valid = intf->rx_edpkt_dma_addr;
 
@@ -591,8 +558,8 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 		u64_stats_update_end(&stats->syncp);
 
 next:
-		bcmasp_intf_rx_buffer_write(intf, (DESC_ADDR(desc->buf) +
-					    desc->size));
+		rx_edpkt_cfg_wq(intf, (DESC_ADDR(desc->buf) + desc->size),
+				RX_EDPKT_RING_BUFFER_READ);
 
 		processed++;
 		intf->rx_edpkt_dma_read =
@@ -603,7 +570,7 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 						 DESC_RING_COUNT);
 	}
 
-	bcmasp_intf_rx_desc_write(intf, intf->rx_edpkt_dma_read);
+	rx_edpkt_dma_wq(intf, intf->rx_edpkt_dma_read, RX_EDPKT_DMA_READ);
 
 	if (processed < budget && napi_complete_done(&intf->rx_napi, processed))
 		bcmasp_enable_rx_irq(intf, 1);
@@ -1271,7 +1238,6 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 	}
 
 	SET_NETDEV_DEV(ndev, dev);
-	intf->ops = &bcmasp_intf_ops;
 	ndev->netdev_ops = &bcmasp_netdev_ops;
 	ndev->ethtool_ops = &bcmasp_ethtool_ops;
 	intf->msg_enable = netif_msg_init(-1, NETIF_MSG_DRV |
@@ -1333,10 +1299,8 @@ static void bcmasp_suspend_to_wol(struct bcmasp_intf *intf)
 
 	umac_enable_set(intf, UMC_CMD_RX_EN, 1);
 
-	if (intf->parent->wol_irq > 0) {
-		wakeup_intr2_core_wl(intf->parent, 0xffffffff,
-				     ASP_WAKEUP_INTR2_MASK_CLEAR);
-	}
+	wakeup_intr2_core_wl(intf->parent, 0xffffffff,
+			     ASP_WAKEUP_INTR2_MASK_CLEAR);
 
 	if (ndev->phydev && ndev->phydev->eee_cfg.eee_enabled &&
 	    intf->parent->eee_fixup)
@@ -1389,10 +1353,8 @@ static void bcmasp_resume_from_wol(struct bcmasp_intf *intf)
 	reg &= ~UMC_MPD_CTRL_MPD_EN;
 	umac_wl(intf, reg, UMC_MPD_CTRL);
 
-	if (intf->parent->wol_irq > 0) {
-		wakeup_intr2_core_wl(intf->parent, 0xffffffff,
-				     ASP_WAKEUP_INTR2_MASK_SET);
-	}
+	wakeup_intr2_core_wl(intf->parent, 0xffffffff,
+			     ASP_WAKEUP_INTR2_MASK_SET);
 }
 
 int bcmasp_interface_resume(struct bcmasp_intf *intf)
-- 
2.34.1


