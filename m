Return-Path: <netdev+bounces-235009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ACAC2B263
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CC03B9EB0
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64609301034;
	Mon,  3 Nov 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AhoXYc8U"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD93002A2
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166981; cv=none; b=JHwuMP/VjdDuXw4SSVIa0Nif1LKgWp6+8oU+t0AeVihJ4eXVYB5oQAvndB2ywg9/fZFaOTQjSyUN9TVg9uW/elL4eeBQweWEHCVuFtTXkTb28qP6qZTltzcyRyFWDNokgAXbYZAAZyvZRp99TtRKPxfULg03cc0ln/dYFdFRMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166981; c=relaxed/simple;
	bh=InAVLUnBPwjwM5N0wu8ba1szAdFOvcGYqdi4f31hQ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0pVUao64kUP8pisI4FBJlXdtlGbz+R2q/tBzBCxNS4rBfR50Pt9GXnpirCvXe/D64Gv/BZEaV43NQkd9nEvQAsuiny8Lu0zyXH10smtQKkJu3UdTCGDJ7o7h1/7b+kOvKNwtUN7PyGd7c93JNzp3Fmv7Avqv6UXtaaf6WQve0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AhoXYc8U; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 005C51A1840;
	Mon,  3 Nov 2025 10:49:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BFB5B60628;
	Mon,  3 Nov 2025 10:49:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BBC810B50018;
	Mon,  3 Nov 2025 11:49:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762166977; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=JVnvhYZYcU/MclyC3ag8i28LJKKIP3ycGDnvcI+cCrM=;
	b=AhoXYc8Uu+j1QbV8gyNQGU3NxKrGG6bxDtTswfcKaEJVkaR4cXNKt0SzI2XLwHe/sKMyGr
	r2tW1w0Viqc+i1WpSCrR+gKxqfv3X8+dl0p/Ibn7FcnJBPR8Wilycs9K8PnGG4CcbibvmG
	ENCAHVgUP89bfgfRW3gJMvLWM5Nzn9GL+eDXOGjDe3IEE+ry1nmCilamze3On9f1tDSGqE
	vC2BEGzaAlMUONHSkkpsn81EZB2pWhxTReiK8QXQ1H2UmVis68YI5IolQlzgNvXQgNhQ5M
	+VkP8QlVFKmLx/mmC1HLhb5pGZwzHUiUFXfozf32pDYq6ZxQYnZA1aVRIcQFWA==
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
Subject: [PATCH net-next v2 2/4] net: altera-tse: Warn on bad revision at probe time
Date: Mon,  3 Nov 2025 11:49:25 +0100
Message-ID: <20251103104928.58461-3-maxime.chevallier@bootlin.com>
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

Instead of reading the core revision at probe time, and print a warning
for an unexecpected version at .ndo_open() time, let's print that
warning directly in .probe().

This allows getting rid of the "revision" private field, and also
prevent a potential race between reading the revision in .probe() after
netdev registration, and accessing that revision in .ndo_open().

By printing the warning after register_netdev(), we are sure that we
have a netdev name, and that we try to print the revision after having
read it from the internal registers.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/altera/altera_tse.h      |  3 ---
 drivers/net/ethernet/altera/altera_tse_main.c | 12 ++++++------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse.h b/drivers/net/ethernet/altera/altera_tse.h
index 82f2363a45cd..e5a56bb989da 100644
--- a/drivers/net/ethernet/altera/altera_tse.h
+++ b/drivers/net/ethernet/altera/altera_tse.h
@@ -401,9 +401,6 @@ struct altera_tse_private {
 	/* MAC address space */
 	struct altera_tse_mac __iomem *mac_dev;
 
-	/* TSE Revision */
-	u32	revision;
-
 	/* mSGDMA Rx Dispatcher address space */
 	void __iomem *rx_dma_csr;
 	void __iomem *rx_dma_desc;
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 6ba1249f027d..343c78a493a1 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -892,9 +892,6 @@ static int tse_open(struct net_device *dev)
 		netdev_warn(dev, "device MAC address %pM\n",
 			    dev->dev_addr);
 
-	if ((priv->revision < 0xd00) || (priv->revision > 0xe00))
-		netdev_warn(dev, "TSE revision %x\n", priv->revision);
-
 	spin_lock(&priv->mac_cfg_lock);
 
 	ret = reset_mac(priv);
@@ -1142,6 +1139,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 	struct net_device *ndev;
 	void __iomem *descmap;
 	int ret = -ENODEV;
+	u32 revision;
 
 	ndev = alloc_etherdev(sizeof(struct altera_tse_private));
 	if (!ndev) {
@@ -1395,12 +1393,14 @@ static int altera_tse_probe(struct platform_device *pdev)
 		goto err_register_netdev;
 	}
 
-	priv->revision = ioread32(&priv->mac_dev->megacore_revision);
+	revision = ioread32(&priv->mac_dev->megacore_revision);
+
+	if (revision < 0xd00 || revision > 0xe00)
+		netdev_warn(ndev, "TSE revision %x\n", revision);
 
 	if (netif_msg_probe(priv))
 		dev_info(&pdev->dev, "Altera TSE MAC version %d.%d at 0x%08lx irq %d/%d\n",
-			 (priv->revision >> 8) & 0xff,
-			 priv->revision & 0xff,
+			 (revision >> 8) & 0xff, revision & 0xff,
 			 (unsigned long) control_port->start, priv->rx_irq,
 			 priv->tx_irq);
 
-- 
2.49.0


