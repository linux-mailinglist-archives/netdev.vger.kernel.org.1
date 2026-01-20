Return-Path: <netdev+bounces-251608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P6FEO7pb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:47:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D34BB82
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78E34A85D57
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4BB47B404;
	Tue, 20 Jan 2026 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UazpdMaF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD8341ACA
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938129; cv=none; b=C3f4LRmQsbz4SJNMWwPEUatNqFuwEyLq9XOXL25hYZ5/dilaKX/6PkCum3iQEj7s5qdHBEvkUciIdQ3G7uzTJmKjTYC4ek6f8Qx3N6vP6PJGZb8nGWn1rHnqMbaEf6siOD690M+ekzMeXgRqTULW6FNOXAXcoLsWZgo6cOphFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938129; c=relaxed/simple;
	bh=597QyYyLBq4plFdprsz0e0+okDjsVq/uSmsle6WtwJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hLT+TGoPMJEiYkXxzeTlBGmTwU+/4spSJXGOSh/veQ8Df8ZHH3R917SurjImFGYTn8WxFOzxMDwQBL1weSk74otP1rfUmvnKlWNeXHXHvngt7eMv7/VqoRtXeRgCgWIoa/XOw0eDGi8gLeKW150Ds4YaTTtnGVl2l8T3nYeMjpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UazpdMaF; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a3e76d0f64so862235ad.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938125; x=1769542925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2a8YvA/hExusOc/exFUXpxRZ5RlQ99dAG16/CcNOR5o=;
        b=VgGsEj6V/6WRQQmNqadLaTb5WO9lctpA/T4Zvo1BXr3+37OJLlqufu4+Lf9eIdnCOs
         qIEmDk0r9L/f7G2oE8OMeSgxCuq2d5zht/EDr+aOPYanFlmmgInVfRGm2MwZkxvdtHEe
         c3kBImDVb8V1tx4aSM0JvamAML+oPlTcFzgto4+ijDZACv+THZrRfN6mZ/StdWMOX7vx
         dGhtcCzBZlRMaHOhr91yyDQ64CDtSd0/Wz5aiK7REwINX3s0YyO3XxsPzuusaqRcETCX
         i/NkWecZUgJn1wTW5T0IakU9vBSADmaen5R4k3wIvPumZgSpxDNU14tzDhO+htcG/RvZ
         Rb+g==
X-Gm-Message-State: AOJu0YyxAG29vMfwSkNycWyXVU6Z7hDGRKTqZQ3+BL6t6e6xxAU7hEJ8
	a/a3vWi/HDSk1KxKhX8iGifwyZEPTdSFodltYx8gK1EXGsyYNtQWwg5ZvmW+nGS6KXy6XXDGhBM
	wnHl62UMn/NcKYqhkoN9KuS/9fas2bG7fnO/RCRXtR+X4/YiIgPC984voEIZivzP7BDRvERhIGd
	5giA5gbVeK6pVDv7N2biENB/Ij7LOxdH0+hjqsAtJLlByg8C1nSrOUA4mVM5ozX4lI8QhYysbgM
	M6mmZyT2w==
X-Gm-Gg: AZuq6aKJO4WwKPWdyVrQQo2/RrpHPT/WOKmj6wen+taxvVupsltWLbbMQvL9WZ+AdWb
	ieJZq1rds2XgNmrQK3uH+8r4pUuPB9S7LrpQHn7Po8LzANh+LSwNHOk8LbM7VpdOLjWviN7x8dJ
	KFpJSpSwe0ML0ELTrFAZUYCHEzzKT3gOeLu9Hi6l6FzOX+nqvB9BOk3H7CTh3yKCb7q9yGo/GvA
	3AW+m3wf4HNKtEhCMiB5Pmim+5TYayrm7ilrxItX3p0odDKoi0zIUIZrWRWNTsDPO5x93QyJ8Pv
	Hc0c5xg6s6+sgBMXikk0guzBJ82gICOzYdqSSHqBmcFKs17LgEshmClAEcvgi1qXED25NStNa9J
	txCEbJYmTPOVRhbp+N5WQeIta0CudqMzPvgl+6zbrzCagmA1yB72rwptJTVLGxxUX5JIPbreniN
	obw4ps4Fb0kjX7QXwMKi5DLpuIlSEPS3Ku4VnTU9SbS7w=
X-Received: by 2002:a17:90b:4f49:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-35272bf2628mr12864650a91.8.1768938125406;
        Tue, 20 Jan 2026 11:42:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-352678c6e64sm2493378a91.8.2026.01.20.11.42.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 11:42:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a2ea47fa5so10883596d6.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768938124; x=1769542924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a8YvA/hExusOc/exFUXpxRZ5RlQ99dAG16/CcNOR5o=;
        b=UazpdMaF9iYl4M8tsmb9BxKdQHQP+SYG9UoHiG8uEcF7M+SYuxNG8AT7kNuPMaJGbh
         2I5cIu5QuyuCEtQh8iX4r5HCGODXNItxeH55VozOGR3HxiUQOToaF9Z4P1vly2BIMsW8
         ngOp5pvtRRvLMU8Lnv3GzlI8I3eazLcKLGG4Q=
X-Received: by 2002:a05:6214:268e:b0:88a:300f:29b7 with SMTP id 6a1803df08f44-8939827306amr266434696d6.30.1768938123595;
        Tue, 20 Jan 2026 11:42:03 -0800 (PST)
X-Received: by 2002:a05:6214:268e:b0:88a:300f:29b7 with SMTP id 6a1803df08f44-8939827306amr266434286d6.30.1768938122970;
        Tue, 20 Jan 2026 11:42:02 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6c9b83sm110887586d6.46.2026.01.20.11.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:42:02 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 1/2] net: bcmasp: clean up some legacy logic
Date: Tue, 20 Jan 2026 11:41:53 -0800
Message-Id: <20260120194154.2047656-2-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120194154.2047656-1-justin.chen@broadcom.com>
References: <20260120194154.2047656-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-251608-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AD8D34BB82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Removed wol_irq check. This was needed for brcm,asp-v2.0, which was
removed in previous commits.

Removed bcmasp_intf_ops. These function pointers were added to make
it easier to implement pseudo channels. These channels were removed
in newer versions of the hardware and were never implemented.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
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


