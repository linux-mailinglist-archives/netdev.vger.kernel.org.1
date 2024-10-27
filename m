Return-Path: <netdev+bounces-139382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72449B1CD9
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 10:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DAA1F21882
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FDC5674D;
	Sun, 27 Oct 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdLtNHEe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A33FB0E;
	Sun, 27 Oct 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022115; cv=none; b=FV/QZzvW3NLhiZALjJh3SNlfo0M/eQiJdofXCuQYUwvCZv243OqIlosSMS/S1D84uIqgBLM4Y+cZwEXArwMbEi2X+M3OO7Xjc54GcSwno3chuMN7SpnzL3KrZSTIWHByoCMuBC6dBQCu2XUUX0efGX+u2ud/SuIysgaVgISmCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022115; c=relaxed/simple;
	bh=//vCHa3l2oXHtkeBL8877YuNandmlWAYd1w4Ufm2iDo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ksRnfS9XcPEn/t6FH0OrOaMHTZPZIH5LHYD8MvjCrEopf3/yhkboa7YVUZ+i0+jnggQJezwNzLY9h1sGFydSb0LNVffo00aMtAYVVu//oV3qpUWcj4RZcD9HSw0hvKCTd4HC2+doUL15HdVZvXulAwGiB5krkOaEGuFeNj6Zf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdLtNHEe; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a139be16dso57501966b.3;
        Sun, 27 Oct 2024 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730022111; x=1730626911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2vkwpVcb4kCS4Ij9rwKADi36HiqXNmkZd+FH34mnDY=;
        b=GdLtNHEegoupTtRd56b6BT3i21ZXAy+4LQACHCkaRJtVBjaQm86jmK/k9nOVkJ4xEq
         zqVEzR+TXx84llrT0rXTDOfaLeXHEnhyj0XYQCg9b+hN7EGHhzmZ7CNy+1TXYLvNoUln
         cwcgGpUWsw1X6Pp2LtAk0IJyh2F74OrZEPywXkT7QO12dx+tGfk4cXxSmkheRNGSECu7
         vIJwodPSf/LB5kX+QAVjlKTgwkaLRPMYBzEZYuU3ZodiLYAno2dFoTiJkG38XV8WOjjO
         R+Z6642zXn0t+ZRgAMxvjlzmgoyXoHvUE1Q8c2QR04eXbAUs7OPm/SPAAdoDs1UEx66B
         DbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730022111; x=1730626911;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n2vkwpVcb4kCS4Ij9rwKADi36HiqXNmkZd+FH34mnDY=;
        b=WrcrzXh3lnLxyU+8uq5SPKm/iKq4tDCG5/YntQmfRGpok7UyeZDjkZf8GM+ImHg+kR
         HjtzA9mXEcAsacINw8U5QE8FVY0i0dCuAh1nD9g2QDEXD+A+zceAHmLDScmip1j5Tg4S
         6iVta5sV0+18A4TkZCVxci/KGat1T/NoRuegec2EUNF2YRti9Hj8bjPayNsi4Pot/36C
         itpxsS43rBsCKr+Nt5Z+j7W2Zhj5S8eomVpAl1dqakz9qPANAWCne7yOx4jgQB5n1d2f
         IynFpe0rbVHe/d4hgbjk7z6aOmnqvPUj+aIV0A34dRZ9WN8/322BZDXvMh0Tq4ftY87R
         gqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJpdHLXNO7PpiBBjw7O/yngyosI2/cb2+cK+PpXE9uX4226nD3LlXesGS1UrTLDIHHJuTf0csQ@vger.kernel.org, AJvYcCXRHcdMTSwJroFaiqQOwn20XF2wM08SphNAMehAo6ehdE8Ieo8DzTOiY9U1hlnsKlR8QyLoSBjtspD3WCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztL+oNFGflmo4Ni+FXUsKX1hVOpNcmh3z9tWKBO4OgFmGEGc1p
	CroVh4TH9OWcxk1ngdfcAbP5CJr8+0GAVaQ+UhWcAIf9FIEFcZnx
X-Google-Smtp-Source: AGHT+IF6cXRGWL8cWTAfzT3Nbf0RVAMBXRR65eslgwEvWjHlEu6M4EFg/RFkFWQlQLDO9Izqdc9p0w==
X-Received: by 2002:a17:907:7287:b0:a9a:1a17:e1cc with SMTP id a640c23a62f3a-a9de5a4a878mr153647666b.0.1730022110663;
        Sun, 27 Oct 2024 02:41:50 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f029564sm262490866b.51.2024.10.27.02.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 02:41:49 -0700 (PDT)
Message-ID: <dcb70a05-2607-47dd-8abd-f6cf1b012c51@gmail.com>
Date: Sun, 27 Oct 2024 10:41:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/2] ethernet: arc: fix the device for
 dma_map_single/dma_unmap_single
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: david.wu@rock-chips.com, andy.yan@rock-chips.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The ndev->dev and pdev->dev aren't the same device, use ndev->dev.parent
which has dma_mask, ndev->dev.parent is just pdev->dev.
Or it would cause the following issue:

[   39.933526] ------------[ cut here ]------------
[   39.938414] WARNING: CPU: 1 PID: 501 at kernel/dma/mapping.c:149 dma_map_page_attrs+0x90/0x1f8

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Original:
https://github.com/andyshrk/linux/commit/a98b368ca6ae79d227415c34e4ca39934af08a6f

Changed:
Use dev variable
---
 drivers/net/ethernet/arc/emac_main.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/arc/emac_main.c b/drivers/net/ethernet/arc/emac_main.c
index 31ee477dd131..8283aeee35fb 100644
--- a/drivers/net/ethernet/arc/emac_main.c
+++ b/drivers/net/ethernet/arc/emac_main.c
@@ -111,6 +111,7 @@ static void arc_emac_tx_clean(struct net_device *ndev)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
+	struct device *dev = ndev->dev.parent;
 	unsigned int i;

 	for (i = 0; i < TX_BD_NUM; i++) {
@@ -140,7 +141,7 @@ static void arc_emac_tx_clean(struct net_device *ndev)
 			stats->tx_bytes += skb->len;
 		}

-		dma_unmap_single(&ndev->dev, dma_unmap_addr(tx_buff, addr),
+		dma_unmap_single(dev, dma_unmap_addr(tx_buff, addr),
 				 dma_unmap_len(tx_buff, len), DMA_TO_DEVICE);

 		/* return the sk_buff to system */
@@ -174,6 +175,7 @@ static void arc_emac_tx_clean(struct net_device *ndev)
 static int arc_emac_rx(struct net_device *ndev, int budget)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
+	struct device *dev = ndev->dev.parent;
 	unsigned int work_done;

 	for (work_done = 0; work_done < budget; work_done++) {
@@ -223,9 +225,9 @@ static int arc_emac_rx(struct net_device *ndev, int budget)
 			continue;
 		}

-		addr = dma_map_single(&ndev->dev, (void *)skb->data,
+		addr = dma_map_single(dev, (void *)skb->data,
 				      EMAC_BUFFER_SIZE, DMA_FROM_DEVICE);
-		if (dma_mapping_error(&ndev->dev, addr)) {
+		if (dma_mapping_error(dev, addr)) {
 			if (net_ratelimit())
 				netdev_err(ndev, "cannot map dma buffer\n");
 			dev_kfree_skb(skb);
@@ -237,7 +239,7 @@ static int arc_emac_rx(struct net_device *ndev, int budget)
 		}

 		/* unmap previosly mapped skb */
-		dma_unmap_single(&ndev->dev, dma_unmap_addr(rx_buff, addr),
+		dma_unmap_single(dev, dma_unmap_addr(rx_buff, addr),
 				 dma_unmap_len(rx_buff, len), DMA_FROM_DEVICE);

 		pktlen = info & LEN_MASK;
@@ -423,6 +425,7 @@ static int arc_emac_open(struct net_device *ndev)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
 	struct phy_device *phy_dev = ndev->phydev;
+	struct device *dev = ndev->dev.parent;
 	int i;

 	phy_dev->autoneg = AUTONEG_ENABLE;
@@ -445,9 +448,9 @@ static int arc_emac_open(struct net_device *ndev)
 		if (unlikely(!rx_buff->skb))
 			return -ENOMEM;

-		addr = dma_map_single(&ndev->dev, (void *)rx_buff->skb->data,
+		addr = dma_map_single(dev, (void *)rx_buff->skb->data,
 				      EMAC_BUFFER_SIZE, DMA_FROM_DEVICE);
-		if (dma_mapping_error(&ndev->dev, addr)) {
+		if (dma_mapping_error(dev, addr)) {
 			netdev_err(ndev, "cannot dma map\n");
 			dev_kfree_skb(rx_buff->skb);
 			return -ENOMEM;
@@ -548,6 +551,7 @@ static void arc_emac_set_rx_mode(struct net_device *ndev)
 static void arc_free_tx_queue(struct net_device *ndev)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
+	struct device *dev = ndev->dev.parent;
 	unsigned int i;

 	for (i = 0; i < TX_BD_NUM; i++) {
@@ -555,7 +559,7 @@ static void arc_free_tx_queue(struct net_device *ndev)
 		struct buffer_state *tx_buff = &priv->tx_buff[i];

 		if (tx_buff->skb) {
-			dma_unmap_single(&ndev->dev,
+			dma_unmap_single(dev,
 					 dma_unmap_addr(tx_buff, addr),
 					 dma_unmap_len(tx_buff, len),
 					 DMA_TO_DEVICE);
@@ -579,6 +583,7 @@ static void arc_free_tx_queue(struct net_device *ndev)
 static void arc_free_rx_queue(struct net_device *ndev)
 {
 	struct arc_emac_priv *priv = netdev_priv(ndev);
+	struct device *dev = ndev->dev.parent;
 	unsigned int i;

 	for (i = 0; i < RX_BD_NUM; i++) {
@@ -586,7 +591,7 @@ static void arc_free_rx_queue(struct net_device *ndev)
 		struct buffer_state *rx_buff = &priv->rx_buff[i];

 		if (rx_buff->skb) {
-			dma_unmap_single(&ndev->dev,
+			dma_unmap_single(dev,
 					 dma_unmap_addr(rx_buff, addr),
 					 dma_unmap_len(rx_buff, len),
 					 DMA_FROM_DEVICE);
@@ -679,6 +684,7 @@ static netdev_tx_t arc_emac_tx(struct sk_buff *skb, struct net_device *ndev)
 	unsigned int len, *txbd_curr = &priv->txbd_curr;
 	struct net_device_stats *stats = &ndev->stats;
 	__le32 *info = &priv->txbd[*txbd_curr].info;
+	struct device *dev = ndev->dev.parent;
 	dma_addr_t addr;

 	if (skb_padto(skb, ETH_ZLEN))
@@ -692,10 +698,9 @@ static netdev_tx_t arc_emac_tx(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_BUSY;
 	}

-	addr = dma_map_single(&ndev->dev, (void *)skb->data, len,
-			      DMA_TO_DEVICE);
+	addr = dma_map_single(dev, (void *)skb->data, len, DMA_TO_DEVICE);

-	if (unlikely(dma_mapping_error(&ndev->dev, addr))) {
+	if (unlikely(dma_mapping_error(dev, addr))) {
 		stats->tx_dropped++;
 		stats->tx_errors++;
 		dev_kfree_skb_any(skb);
--
2.39.2


