Return-Path: <netdev+bounces-74155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA59860423
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 21:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153171C24A90
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028212D1E1;
	Thu, 22 Feb 2024 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HmDGbtV+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD5A73F33
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635426; cv=none; b=UU9Lpz2/4y8dur7XNoUuXLCmDDU16yljGmGj1Zo8ZWfclGAs9jhl3MLSl66AuF5E+WUlFsIXgrHHHlYgFlNM5ITevZLpVsb5GoU/qZ58CgEqChYwwyHYRpF15BR9IhyDWXylc/X1JpeJyR3Oz5QE+r8K1hMeuajnUJF6OjNxUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635426; c=relaxed/simple;
	bh=q1ZH7yIUqFcd9MTGDHmRPHuIklsw1eKBMw0vlVYjAF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWYPNd4dxcTKP30uKPPbfD7L4utVmpc9aA7/5pyrJ6sSaBMHYfRprO5z33KGhpiNQE6d8XyS8x6BvdKw5VV4z+ZuPnGdVV+GVhOjdyUE4b7EZ/8lpHsLF0NapB0e7lIAQRrl0FFx/t+wH8FZZMZywMqHrMvPibUCOwRGRhyrmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HmDGbtV+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6085b652fc8so1819697b3.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708635424; x=1709240224; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RGQI2yalz6BpWO9w8LLQyK5yZ1mY0xsDb9d/gt6s7cM=;
        b=HmDGbtV+OoH9bLjqBTuu/QckagG8gY+/zhFumttTnOTgD3eAiQ1lhBivvpsVp4mL7p
         XATVxHAuZPlXEWHkEpA23mtyIumRvbqHpqjQ9ijJVtqhC5FiVL/hT2wyTbhDBL7S4Whx
         G9gPmW3y2mfJluz7iDYh4KzYDUzTXmlNR/mdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635424; x=1709240224;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGQI2yalz6BpWO9w8LLQyK5yZ1mY0xsDb9d/gt6s7cM=;
        b=ZA0FCDdFCLIYCb4qLGgKm8NLAIPOyQaKwATtBkbvv7+O/J4sUL6w8CVUbHu4uNMaJy
         xK9+vm750ABCE9CLCpnQFYEGLKlRX9LUzSCn5Ftvp4jF6vvMR7ZgPONFKFzepPx5vHZ3
         g9Hk/3BtUnj7e8nusvEot596keSWzGzK4nDcXHGbtV0LjPXwCwwnwI3KDzfeqA/NKYQA
         CAwc2uZDms8NLMpMwfmcXdWQw4ptwJKmldaQSQXUrEIdkXEmqgm77mQBSmvWVUtvdio6
         jmH9BkfpClxHekOvKW7AsTdbHFoVZuw5qKzs9MOKto38N4krGqUe3nRAiumyU/XppJ8y
         ovPQ==
X-Gm-Message-State: AOJu0Yz93C+ZGGLOVH0bLvPFce27m8lIAXTapE76bERw6sjptPRbZAeB
	d488dvgxEvDXbHvLr7vq3A06Q7ddTr4NJXxy/RAyvk5WLLhL3UvVX5DS2t3kqTeTVCveGDoQvZ9
	CW8fgnYaPr0D7ICogU2a8mjMYhCQdY+xGV9iQZFcG6HhGNbwh9pVnUjG3Itf3tJF+U4zGTNZ0vD
	JmPWZ4pt3ZPMXpWRtia3t7RfnGvwPF/i3t1Nk4pGeW9g==
X-Google-Smtp-Source: AGHT+IF6rt2RmDlbkG4SUgjztfcZk8Kw+bXcqmbMIBdwSCUpEh9gDmf3GsfNwjfG5swpbgaQMxOQSA==
X-Received: by 2002:a81:a056:0:b0:608:b523:c410 with SMTP id x83-20020a81a056000000b00608b523c410mr187637ywg.41.1708635423728;
        Thu, 22 Feb 2024 12:57:03 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id jr11-20020a05622a800b00b0042e224098eesm3159370qtb.27.2024.02.22.12.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:57:03 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	opendmb@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	rafal@milecki.pl,
	devicetree@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 5/6] net: bcmasp: Keep buffers through power management
Date: Thu, 22 Feb 2024 12:56:43 -0800
Message-Id: <20240222205644.707326-6-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222205644.707326-1-justin.chen@broadcom.com>
References: <20240222205644.707326-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000082d84e0611feaf00"

--00000000000082d84e0611feaf00
Content-Transfer-Encoding: 8bit

There is no advantage of freeing and re-allocating buffers through
suspend and resume. This waste cycles and makes suspend/resume time
longer. We also open ourselves to failed allocations in systems with
heavy memory fragmentation.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   |   1 +
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 181 ++++++++----------
 2 files changed, 76 insertions(+), 106 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 61598dc070b1..127a5340625e 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -315,6 +315,7 @@ struct bcmasp_intf {
 	struct bcmasp_desc		*rx_edpkt_cpu;
 	dma_addr_t			rx_edpkt_dma_addr;
 	dma_addr_t			rx_edpkt_dma_read;
+	dma_addr_t			rx_edpkt_dma_valid;
 
 	/* RX buffer prefetcher ring*/
 	void				*rx_ring_cpu;
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index cbe9acfa985d..1aed28b06309 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -674,40 +674,78 @@ static void bcmasp_adj_link(struct net_device *dev)
 		phy_print_status(phydev);
 }
 
-static int bcmasp_init_rx(struct bcmasp_intf *intf)
+static int bcmasp_alloc_buffers(struct bcmasp_intf *intf)
 {
 	struct device *kdev = &intf->parent->pdev->dev;
 	struct page *buffer_pg;
-	dma_addr_t dma;
-	void *p;
-	u32 reg;
-	int ret;
 
+	/* Alloc RX */
 	intf->rx_buf_order = get_order(RING_BUFFER_SIZE);
 	buffer_pg = alloc_pages(GFP_KERNEL, intf->rx_buf_order);
 	if (!buffer_pg)
 		return -ENOMEM;
 
-	dma = dma_map_page(kdev, buffer_pg, 0, RING_BUFFER_SIZE,
-			   DMA_FROM_DEVICE);
-	if (dma_mapping_error(kdev, dma)) {
-		__free_pages(buffer_pg, intf->rx_buf_order);
-		return -ENOMEM;
-	}
 	intf->rx_ring_cpu = page_to_virt(buffer_pg);
-	intf->rx_ring_dma = dma;
-	intf->rx_ring_dma_valid = intf->rx_ring_dma + RING_BUFFER_SIZE - 1;
+	intf->rx_ring_dma = dma_map_page(kdev, buffer_pg, 0, RING_BUFFER_SIZE,
+					 DMA_FROM_DEVICE);
+	if (dma_mapping_error(kdev, intf->rx_ring_dma))
+		goto free_rx_buffer;
+
+	intf->rx_edpkt_cpu = dma_alloc_coherent(kdev, DESC_RING_SIZE,
+						&intf->rx_edpkt_dma_addr, GFP_KERNEL);
+	if (!intf->rx_edpkt_cpu)
+		goto free_rx_buffer_dma;
+
+	/* Alloc TX */
+	intf->tx_spb_cpu = dma_alloc_coherent(kdev, DESC_RING_SIZE,
+					      &intf->tx_spb_dma_addr, GFP_KERNEL);
+	if (!intf->tx_spb_cpu)
+		goto free_rx_edpkt_dma;
 
-	p = dma_alloc_coherent(kdev, DESC_RING_SIZE, &intf->rx_edpkt_dma_addr,
+	intf->tx_cbs = kcalloc(DESC_RING_COUNT, sizeof(struct bcmasp_tx_cb),
 			       GFP_KERNEL);
-	if (!p) {
-		ret = -ENOMEM;
-		goto free_rx_ring;
-	}
-	intf->rx_edpkt_cpu = p;
+	if (!intf->tx_cbs)
+		goto free_tx_spb_dma;
 
-	netif_napi_add(intf->ndev, &intf->rx_napi, bcmasp_rx_poll);
+	return 0;
+
+free_tx_spb_dma:
+	dma_free_coherent(kdev, DESC_RING_SIZE, intf->tx_spb_cpu,
+			  intf->tx_spb_dma_addr);
+free_rx_edpkt_dma:
+	dma_free_coherent(kdev, DESC_RING_SIZE, intf->rx_edpkt_cpu,
+			  intf->rx_edpkt_dma_addr);
+free_rx_buffer_dma:
+	dma_unmap_page(kdev, intf->rx_ring_dma, RING_BUFFER_SIZE,
+		       DMA_FROM_DEVICE);
+free_rx_buffer:
+	__free_pages(buffer_pg, intf->rx_buf_order);
+
+	return -ENOMEM;
+}
+
+static void bcmasp_reclaim_free_buffers(struct bcmasp_intf *intf)
+{
+	struct device *kdev = &intf->parent->pdev->dev;
+
+	/* RX buffers */
+	dma_free_coherent(kdev, DESC_RING_SIZE, intf->rx_edpkt_cpu,
+			  intf->rx_edpkt_dma_addr);
+	dma_unmap_page(kdev, intf->rx_ring_dma, RING_BUFFER_SIZE,
+		       DMA_FROM_DEVICE);
+	__free_pages(virt_to_page(intf->rx_ring_cpu), intf->rx_buf_order);
+
+	/* TX buffers */
+	dma_free_coherent(kdev, DESC_RING_SIZE, intf->tx_spb_cpu,
+			  intf->tx_spb_dma_addr);
+	kfree(intf->tx_cbs);
+}
 
+static void bcmasp_init_rx(struct bcmasp_intf *intf)
+{
+	/* Restart from index 0 */
+	intf->rx_ring_dma_valid = intf->rx_ring_dma + RING_BUFFER_SIZE - 1;
+	intf->rx_edpkt_dma_valid = intf->rx_edpkt_dma_addr + (DESC_RING_SIZE - 1);
 	intf->rx_edpkt_dma_read = intf->rx_edpkt_dma_addr;
 	intf->rx_edpkt_index = 0;
 
@@ -733,64 +771,23 @@ static int bcmasp_init_rx(struct bcmasp_intf *intf)
 	rx_edpkt_dma_wq(intf, intf->rx_edpkt_dma_addr, RX_EDPKT_DMA_WRITE);
 	rx_edpkt_dma_wq(intf, intf->rx_edpkt_dma_addr, RX_EDPKT_DMA_READ);
 	rx_edpkt_dma_wq(intf, intf->rx_edpkt_dma_addr, RX_EDPKT_DMA_BASE);
-	rx_edpkt_dma_wq(intf, intf->rx_edpkt_dma_addr + (DESC_RING_SIZE - 1),
-			RX_EDPKT_DMA_END);
-	rx_edpkt_dma_wq(intf, intf->rx_edpkt_dma_addr + (DESC_RING_SIZE - 1),
-			RX_EDPKT_DMA_VALID);
-
-	reg = UMAC2FB_CFG_DEFAULT_EN |
-	      ((intf->channel + 11) << UMAC2FB_CFG_CHID_SHIFT);
-	reg |= (0xd << UMAC2FB_CFG_OK_SEND_SHIFT);
-	umac2fb_wl(intf, reg, UMAC2FB_CFG);
+	rx_edpkt_dma_wq(intf, intf->rx_edpkt_dma_valid, RX_EDPKT_DMA_END);
+	rx_edpkt_dma_wq(intf, intf->rx_edpkt_dma_valid, RX_EDPKT_DMA_VALID);
 
-	return 0;
-
-free_rx_ring:
-	dma_unmap_page(kdev, intf->rx_ring_dma, RING_BUFFER_SIZE,
-		       DMA_FROM_DEVICE);
-	__free_pages(virt_to_page(intf->rx_ring_cpu), intf->rx_buf_order);
-
-	return ret;
+	umac2fb_wl(intf, UMAC2FB_CFG_DEFAULT_EN | ((intf->channel + 11) <<
+		   UMAC2FB_CFG_CHID_SHIFT) | (0xd << UMAC2FB_CFG_OK_SEND_SHIFT),
+		   UMAC2FB_CFG);
 }
 
-static void bcmasp_reclaim_free_all_rx(struct bcmasp_intf *intf)
-{
-	struct device *kdev = &intf->parent->pdev->dev;
-
-	dma_free_coherent(kdev, DESC_RING_SIZE, intf->rx_edpkt_cpu,
-			  intf->rx_edpkt_dma_addr);
-	dma_unmap_page(kdev, intf->rx_ring_dma, RING_BUFFER_SIZE,
-		       DMA_FROM_DEVICE);
-	__free_pages(virt_to_page(intf->rx_ring_cpu), intf->rx_buf_order);
-}
 
-static int bcmasp_init_tx(struct bcmasp_intf *intf)
+static void bcmasp_init_tx(struct bcmasp_intf *intf)
 {
-	struct device *kdev = &intf->parent->pdev->dev;
-	void *p;
-	int ret;
-
-	p = dma_alloc_coherent(kdev, DESC_RING_SIZE, &intf->tx_spb_dma_addr,
-			       GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
-
-	intf->tx_spb_cpu = p;
+	/* Restart from index 0 */
 	intf->tx_spb_dma_valid = intf->tx_spb_dma_addr + DESC_RING_SIZE - 1;
 	intf->tx_spb_dma_read = intf->tx_spb_dma_addr;
-
-	intf->tx_cbs = kcalloc(DESC_RING_COUNT, sizeof(struct bcmasp_tx_cb),
-			       GFP_KERNEL);
-	if (!intf->tx_cbs) {
-		ret = -ENOMEM;
-		goto free_tx_spb;
-	}
-
 	intf->tx_spb_index = 0;
 	intf->tx_spb_clean_index = 0;
 
-	netif_napi_add_tx(intf->ndev, &intf->tx_napi, bcmasp_tx_poll);
-
 	/* Make sure channels are disabled */
 	tx_spb_ctrl_wl(intf, 0x0, TX_SPB_CTRL_ENABLE);
 	tx_epkt_core_wl(intf, 0x0, TX_EPKT_C_CFG_MISC);
@@ -806,26 +803,6 @@ static int bcmasp_init_tx(struct bcmasp_intf *intf)
 	tx_spb_dma_wq(intf, intf->tx_spb_dma_addr, TX_SPB_DMA_BASE);
 	tx_spb_dma_wq(intf, intf->tx_spb_dma_valid, TX_SPB_DMA_END);
 	tx_spb_dma_wq(intf, intf->tx_spb_dma_valid, TX_SPB_DMA_VALID);
-
-	return 0;
-
-free_tx_spb:
-	dma_free_coherent(kdev, DESC_RING_SIZE, intf->tx_spb_cpu,
-			  intf->tx_spb_dma_addr);
-
-	return ret;
-}
-
-static void bcmasp_reclaim_free_all_tx(struct bcmasp_intf *intf)
-{
-	struct device *kdev = &intf->parent->pdev->dev;
-
-	/* Free descriptors */
-	dma_free_coherent(kdev, DESC_RING_SIZE, intf->tx_spb_cpu,
-			  intf->tx_spb_dma_addr);
-
-	/* Free cbs */
-	kfree(intf->tx_cbs);
 }
 
 static void bcmasp_ephy_enable_set(struct bcmasp_intf *intf, bool enable)
@@ -915,10 +892,7 @@ static void bcmasp_netif_deinit(struct net_device *dev)
 	bcmasp_enable_rx_irq(intf, 0);
 
 	netif_napi_del(&intf->tx_napi);
-	bcmasp_reclaim_free_all_tx(intf);
-
 	netif_napi_del(&intf->rx_napi);
-	bcmasp_reclaim_free_all_rx(intf);
 }
 
 static int bcmasp_stop(struct net_device *dev)
@@ -932,6 +906,8 @@ static int bcmasp_stop(struct net_device *dev)
 
 	bcmasp_netif_deinit(dev);
 
+	bcmasp_reclaim_free_buffers(intf);
+
 	phy_disconnect(dev->phydev);
 
 	/* Disable internal EPHY or external PHY */
@@ -1070,17 +1046,12 @@ static int bcmasp_netif_init(struct net_device *dev, bool phy_connect)
 	intf->old_link = -1;
 	intf->old_pause = -1;
 
-	ret = bcmasp_init_tx(intf);
-	if (ret)
-		goto err_phy_disconnect;
-
-	/* Turn on asp */
+	bcmasp_init_tx(intf);
+	netif_napi_add_tx(intf->ndev, &intf->tx_napi, bcmasp_tx_poll);
 	bcmasp_enable_tx(intf, 1);
 
-	ret = bcmasp_init_rx(intf);
-	if (ret)
-		goto err_reclaim_tx;
-
+	bcmasp_init_rx(intf);
+	netif_napi_add(intf->ndev, &intf->rx_napi, bcmasp_rx_poll);
 	bcmasp_enable_rx(intf, 1);
 
 	/* Turn on UniMAC TX/RX */
@@ -1094,12 +1065,6 @@ static int bcmasp_netif_init(struct net_device *dev, bool phy_connect)
 
 	return 0;
 
-err_reclaim_tx:
-	netif_napi_del(&intf->tx_napi);
-	bcmasp_reclaim_free_all_tx(intf);
-err_phy_disconnect:
-	if (phydev)
-		phy_disconnect(phydev);
 err_phy_disable:
 	if (intf->internal_phy)
 		bcmasp_ephy_enable_set(intf, false);
@@ -1115,6 +1080,10 @@ static int bcmasp_open(struct net_device *dev)
 
 	netif_dbg(intf, ifup, dev, "bcmasp open\n");
 
+	ret = bcmasp_alloc_buffers(intf);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(intf->parent->clk);
 	if (ret)
 		return ret;
-- 
2.34.1


--00000000000082d84e0611feaf00
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIC/ARlwEoZDKuzS7b2dVXpH+XUIMc3/VnF1z
DSIpiHkkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIyMjIw
NTcwNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQAVF4sCru0FcIlfjK1xcYiJEGbRy53mJB7/56Ip0HPwU+634AlyVHUb
NgSmmIb0I10P6VQK/fVXxsdK3Fygq/BVaKYxCEtzjy2qe+GKxMqdX4NLUduSPcLUuEb9flBnCTWa
o+QEGHFrMcUopOBcW71+ebrkc06cmv5Eg8J5wrwpKsND+4Pp65kl6mwKSDqJFoDBqbtwmqOvrxNh
cxm5wEdLEBE2dLwmU6LzEH6NsMiG/bGprIxfaMcx82I8+/gU0SVZf9avsmrtwCOc9XKf7l9Ub/bx
DOUDqKWAXNSUlgXHIlKAgoJHwSEHzatk4WnsNheOiW6HPcSHwu5n/JFb6+O1
--00000000000082d84e0611feaf00--

