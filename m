Return-Path: <netdev+bounces-149240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1B69E4E1A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BD028482C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDD61991C1;
	Thu,  5 Dec 2024 07:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201D2391AB;
	Thu,  5 Dec 2024 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383327; cv=none; b=jrNin/VXricmYyK4daDK+VX1SdCdQLh1evg6rXksabQ3LDKL1l0afxNhMx5bcpcbOO31AX9HWuAgp5LwNsEXvsoB8tgI1K8a2ExewjOgH5Z+gMO0FRcB1p8peL4odAZPCuF7s5rnUbwl7DiDiZQhIK/CdjTF9jqcT6HKquoJH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383327; c=relaxed/simple;
	bh=EOv2FiJhNAPI4O0zuh+HzDvaif58ZEgV2F+TDgHsj0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YarBrFcNQhr0EbfbLvdGeLyOwMq501s3mIprjR2ZqiMY0NOl9ufgP5W1a7KMoLLqISu74KWSUBG1HMNfF8Ok7MwYVm9Ge6FtSSHesllvE1i6UB8RQKbkAecZ94t7c8AfM17ird9tw6xVXmyhTrNRq6K+VEoSaKL6Wc8ZWaQmWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 5 Dec
 2024 15:20:49 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 5 Dec 2024 15:20:49 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v4 4/7] net: ftgmac100: Add support for AST2700
Date: Thu, 5 Dec 2024 15:20:45 +0800
Message-ID: <20241205072048.1397570-5-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add comptaible for AST2700 and set dma mask to 64-bit.
The ftgmac100 on AST2700 supports 64-bit DMA.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 96c1eee547c4..c0540645d151 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1884,7 +1884,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	np = pdev->dev.of_node;
 	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
 		   of_device_is_compatible(np, "aspeed,ast2500-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2600-mac"))) {
+		   of_device_is_compatible(np, "aspeed,ast2600-mac") ||
+		   of_device_is_compatible(np, "aspeed,ast2700-mac"))) {
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
 		priv->is_aspeed = true;
@@ -1976,7 +1977,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			goto err_phy_connect;
 
 		/* Disable ast2600 problematic HW arbitration */
-		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
+		if (of_device_is_compatible(np, "aspeed,ast2600-mac") ||
+		    of_device_is_compatible(np, "aspeed,ast2700-mac"))
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
 	}
@@ -2021,6 +2023,12 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		netdev->hw_features &= ~(NETIF_F_HW_CSUM | NETIF_F_RXCSUM);
 	netdev->features |= netdev->hw_features;
 
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_err(&pdev->dev, "64-bit DMA enable failed\n");
+		goto err_register_netdev;
+	}
+
 	/* register network device */
 	err = register_netdev(netdev);
 	if (err) {
-- 
2.25.1


