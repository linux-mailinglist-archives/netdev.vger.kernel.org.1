Return-Path: <netdev+bounces-234341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174EC1F85F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FD04263E3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220635504A;
	Thu, 30 Oct 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gZxe+zAT"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2071354AE5
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819874; cv=none; b=pMYUiVwlX23hf9H5HKB22G63+Anbdg6rYaW6Cn+9i8YLYO2Of2y4R9cjWZHMKvavbAfh+ekoRsIOGTaCAc/+5eaV+ZmAp0/77bjnhhbuQmZ+gmUcscpsYjrLGf00DQpR15Z+7A51c1VJW41WboNO2Tsl3B4WyPXq1vgy6nNhM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819874; c=relaxed/simple;
	bh=/+Ud9HruVze393NyT1qzp2ulTBCT/YDFMljaKM2s+v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoRCG953Kxwep6Nj5hlCHaHaKW7qfTXEoItuAYra0bVNSNBaLZUtyWGrSqZAIbjRPyqoVZbnsrIbjcI9gu7HsBnYgFtWLesSMg/jQ8sJJd413lBrrGvXTjRohwE8ghX+nHsBkeZtuSUxSNuUx+TUzUMLsQZI7buwMktgN/Pm92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gZxe+zAT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EF66C1A1777;
	Thu, 30 Oct 2025 10:24:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C66136068C;
	Thu, 30 Oct 2025 10:24:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A67E0102F2500;
	Thu, 30 Oct 2025 11:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761819870; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=pYQO/J8iwjLT+7v/VfTgDA/2MnHjgHlcPgf4jpQ3AXs=;
	b=gZxe+zATPo1ZUR444y2TlDGvsM9lETqMy7I/JWzjj9wQNzpOdcT1fm+2wN4cCzHxZBj6WP
	cVF0v/YOfw0Feab6GlIKGwKAdIw9yNFLaU29abStuieUIn/eHDigSsmZAhvD34iB7yrmWM
	/kIko9F7NQHox/3C8nu/WQsXfsIB7evmNNfK5Fuf7Brl/Upabt0QOBZhNWGCeViOifPb2Z
	belpWKJXlcvvksH/XuoZd5wuzVgF6OrnfBHHebYgjnQMxDSz2nKfin85LD4N7oblPEgmnf
	fpsHuxEYvNduINWzIRxEfUSZ1u+8HoFj+4QeL3/0IOK6kD8BTRI+BfpEuxw+oA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: altera-tse: Init PCS and phylink before registering netdev
Date: Thu, 30 Oct 2025 11:24:17 +0100
Message-ID: <20251030102418.114518-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251030102418.114518-1-maxime.chevallier@bootlin.com>
References: <20251030102418.114518-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

register_netdev() must be done only once all resources are ready, as
they may be used in .ndo_open() immediately upon registration.

Move the lynx PCS and phylink initialisation before registerng the
netdevice. We also remove the call to netif_carrier_off(), as phylink
takes care of that.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index a601ba57190e..4ffa3edf1d0c 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1390,20 +1390,6 @@ static int altera_tse_probe(struct platform_device *pdev)
 
 	priv->revision = ioread32(&priv->mac_dev->megacore_revision);
 
-	netif_carrier_off(ndev);
-	ret = register_netdev(ndev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register TSE net device\n");
-		goto err_register_netdev;
-	}
-
-	if (netif_msg_probe(priv))
-		dev_info(&pdev->dev, "Altera TSE MAC version %d.%d at 0x%08lx irq %d/%d\n",
-			 (priv->revision >> 8) & 0xff,
-			 priv->revision & 0xff,
-			 (unsigned long) control_port->start, priv->rx_irq,
-			 priv->tx_irq);
-
 	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii", dev_name(&pdev->dev));
 	pcs_bus = devm_mdio_regmap_register(&pdev->dev, &mrc);
 	if (IS_ERR(pcs_bus)) {
@@ -1441,12 +1427,26 @@ static int altera_tse_probe(struct platform_device *pdev)
 		goto err_init_phylink;
 	}
 
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register TSE net device\n");
+		goto err_register_netdev;
+	}
+
+	if (netif_msg_probe(priv))
+		dev_info(&pdev->dev, "Altera TSE MAC version %d.%d at 0x%08lx irq %d/%d\n",
+			 (priv->revision >> 8) & 0xff,
+			 priv->revision & 0xff,
+			 (unsigned long)control_port->start, priv->rx_irq,
+			 priv->tx_irq);
+
 	return 0;
+
+err_register_netdev:
+	phylink_destroy(priv->phylink);
 err_init_phylink:
 	lynx_pcs_destroy(priv->pcs);
 err_init_pcs:
-	unregister_netdev(ndev);
-err_register_netdev:
 	netif_napi_del(&priv->napi);
 	altera_tse_mdio_destroy(ndev);
 err_free_netdev:
-- 
2.49.0


