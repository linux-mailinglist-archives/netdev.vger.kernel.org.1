Return-Path: <netdev+bounces-145729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBD09D0936
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEDEAB21626
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74551547E8;
	Mon, 18 Nov 2024 06:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70314EC60;
	Mon, 18 Nov 2024 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909750; cv=none; b=lGj4wc+Vm3n0N1wFZf3sLQdZEAuks1roAWpvXuG+04VLUucijeZn9zrCvMchMMzwp1Csc2m90WrxQW41+61kEDjPrS/J6M7A21vg7Zx6LDd+H7qVFF2EZJ0W1URkRjDE2X/8hNnA0AGlnMcvSGeHHQ8KfWctWPk+5q/i2POgAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909750; c=relaxed/simple;
	bh=n2XTKaJCsH8XAHaHQX2Xfs1h9fKItgAa3nZrIKn7oOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMS9F2VWlo9OHs25qEjUzS+joM2/wdibg8MxT/JA0K4ubAMebfBVoCXJHYMfinvwqlivvzB7BALFpCD4FrUyXpD5EWSUB69zum+26XakCtbxeywhygepu2+atnVyIaMb+VTubfuBmou2D2tdURauZjargTUVZUb15t49AWep458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 18 Nov
 2024 14:02:07 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Nov 2024 14:02:07 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next v2 4/7] net: ftgmac100: Add support for AST2700
Date: Mon, 18 Nov 2024 14:02:04 +0800
Message-ID: <20241118060207.141048-5-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
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
 drivers/net/ethernet/faraday/ftgmac100.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index cae23b712a6d..5b277285666a 100644
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
@@ -1967,7 +1968,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			dev_err(priv->dev, "MII probe failed!\n");
 			goto err_ncsi_dev;
 		}
-
 	}
 
 	if (priv->is_aspeed) {
@@ -1995,9 +1995,18 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		}
 
 		/* Disable ast2600 problematic HW arbitration */
-		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
+		if (of_device_is_compatible(np, "aspeed,ast2600-mac") ||
+		    of_device_is_compatible(np, "aspeed,ast2700-mac"))
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
+
+		if (of_device_is_compatible(np, "aspeed,ast2700-mac")) {
+			err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+			if (err) {
+				dev_err(&pdev->dev, "64-bit DMA enable failed\n");
+				goto err_register_netdev;
+			}
+		}
 	}
 
 	/* Default ring sizes */
-- 
2.25.1


