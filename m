Return-Path: <netdev+bounces-235011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1389CC2B251
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5FA14F2962
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22A330170F;
	Mon,  3 Nov 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XZemZQeV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398630147F;
	Mon,  3 Nov 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166984; cv=none; b=jhB6/M3p07w8Ks0OjaXY9JhM8a1V3wBjt7AFDUSQFS8Ea3+2EH9y+gfFkD7B2K0Rjz60dgF17CAczwUIEWwpLCL9JlUyyLuq06+Uuv2ibZXF3AirrRKM0xu3UNu5U34yw0FrZLd6qxUmcQnmCvfJ5NCnd+M2z7Ye8eoxKUr1qXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166984; c=relaxed/simple;
	bh=c9t+E3pawcbLcU0pARfnzXYmRo4V+2g7Cp66AAjOSmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUBMR6Kmk8EzzZkd3ho8zhSTX8bk8N6/BXSP3ORLKriCj9JS2VlQmEGJ5sLU1NfyU6KB6aDvv9i74/7p6mpidfCvr+v11ewzoMPnnhbjOyVPFRio4KsnL9Aec7uN9ZnFnSR7HjGI19R8xsQi8Xt6CA4gsm0owDU1QsWLHMRdVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XZemZQeV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3D6DAC0D7AA;
	Mon,  3 Nov 2025 10:49:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 09F2B60628;
	Mon,  3 Nov 2025 10:49:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1F4210B50078;
	Mon,  3 Nov 2025 11:49:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762166980; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8TPCTtZANNTp/VYFJqCDjc/4NduN0XXsteAOjwzluOs=;
	b=XZemZQeVyfmAD5Ol4lpacCnPomlQc5PGvGZtuF5hUmBD5HgGbMC/ffi/WPb3uMtmymsdCk
	+m/waRSCjN4WjF3vo0EmkX5HfPT9XCDA96d8HjbZU56WWtrfJ1Us1YdYQE8NUQn6YkKj+e
	QlWCvRndzfhnEXQVl10nYLKOPpDVo39S7ikz6LXwyqv+kbDysyGoRPJzOfqaowH5DgNsc+
	SAHrOwrZfHRokQ+bMw88vpYOCLUnvOsv9YXSS0mj8jwpi4T3+XwyRECA0FmaPgEUwPDZlY
	H3b27k5JroclJafsHX6JyZqL5t80gytpIjR0t9gxt8+hUSbO8Ec7iaHnRf00mw==
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
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2 4/4] net: altera-tse: Init PCS and phylink before registering netdev
Date: Mon,  3 Nov 2025 11:49:27 +0100
Message-ID: <20251103104928.58461-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251103104928.58461-1-maxime.chevallier@bootlin.com>
References: <20251103104928.58461-1-maxime.chevallier@bootlin.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 003df8970998..ca55c5fd11df 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1386,24 +1386,6 @@ static int altera_tse_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->tx_lock);
 	spin_lock_init(&priv->rxdma_irq_lock);
 
-	netif_carrier_off(ndev);
-	ret = register_netdev(ndev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register TSE net device\n");
-		goto err_register_netdev;
-	}
-
-	revision = ioread32(&priv->mac_dev->megacore_revision);
-
-	if (revision < 0xd00 || revision > 0xe00)
-		netdev_warn(ndev, "TSE revision %x\n", revision);
-
-	if (netif_msg_probe(priv))
-		dev_info(&pdev->dev, "Altera TSE MAC version %d.%d at 0x%08lx irq %d/%d\n",
-			 (revision >> 8) & 0xff, revision & 0xff,
-			 (unsigned long) control_port->start, priv->rx_irq,
-			 priv->tx_irq);
-
 	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii", dev_name(&pdev->dev));
 	pcs_bus = devm_mdio_regmap_register(&pdev->dev, &mrc);
 	if (IS_ERR(pcs_bus)) {
@@ -1441,12 +1423,30 @@ static int altera_tse_probe(struct platform_device *pdev)
 		goto err_init_phylink;
 	}
 
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register TSE net device\n");
+		goto err_register_netdev;
+	}
+
+	revision = ioread32(&priv->mac_dev->megacore_revision);
+
+	if (revision < 0xd00 || revision > 0xe00)
+		netdev_warn(ndev, "TSE revision %x\n", revision);
+
+	if (netif_msg_probe(priv))
+		dev_info(&pdev->dev, "Altera TSE MAC version %d.%d at 0x%08lx irq %d/%d\n",
+			 (revision >> 8) & 0xff, revision & 0xff,
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


