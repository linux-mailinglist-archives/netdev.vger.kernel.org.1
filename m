Return-Path: <netdev+bounces-234340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667AC1F86E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC4E425EE0
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E56354AF8;
	Thu, 30 Oct 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cuKxX9me"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285F3546E7
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819873; cv=none; b=Aho1RpS3FvQb1DLXL758f6YBFScHeUNafrHVi1rez8nqosH+kSm9G3+epNuRDpJwD0fgu0KUrhF9sDwKS86LZN7Z4Ipwl2ben3hQwQ3P7vuwPj9mjsR4HPQB5sJyecm+DzoJd31CYOvZL9FivqnATZkGkWiCApX66CBznfuTLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819873; c=relaxed/simple;
	bh=Ez7a+wreIh7UMIo9IVUU+O2bN8hhAvrjsWtYzNG/hJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i25n336fzhNrZReBIgYeg1sm4WOPWoDTh/0FHrGwFh9U0bGphcTl/WQhQ0YoEXAp0mC+qx7GghPUpfGtFJ0gpeGD6HoSQbdGOdieBH+tXKDIhsfM9sc1K28I4kN09HEQPK6/Le/vVHPIQX6aVliMPnlLtuSRYF8j0XHtihNlMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cuKxX9me; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 51D581A177B;
	Thu, 30 Oct 2025 10:24:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 284156068C;
	Thu, 30 Oct 2025 10:24:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D81911808821;
	Thu, 30 Oct 2025 11:24:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761819868; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RoyBPsQbxCeIyoPQ2zrzEdmuX54xkmjv6HtTh7tX2pE=;
	b=cuKxX9meA+bNJDneTgaqLKGwAeRY7C04U2PFcPPzTSTA9uWBDYQ0LRTaKNwIBFSD3I7Bzi
	ObVIj158RqAaCWrwRf9txLznrlOKryzaZB4nwF/0oqyKVx6pQk4raE090zw2mci+BK9iQT
	IibgK5D/5bmfhh3kOoQ/0WCrv+mWKZ6GYTSxggeieViKa0kDvlnHHMpZgXhRGX83uf6qMn
	LMz1d22VP5UDc72kb0mtMhlR5Nbd7K9ZX/GJJuets1I14b0pBELKf/wU/HCy6VqQjljV8h
	fEl0yPKiC2m8yS8kVIGzr9BoMaobqKdZWONokoR5helRQmT8GiWYVCRPXvtaUA==
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
Subject: [PATCH net-next 3/4] net: altera-tse: Don't use netdev name for the PCS mdio bus
Date: Thu, 30 Oct 2025 11:24:16 +0100
Message-ID: <20251030102418.114518-4-maxime.chevallier@bootlin.com>
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

The PCS mdio bus must be created before registering the net_device. To
do that, we musn't depend on the netdev name to create the mdio bus
name. Let's use the device's name instead.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index c74b1c11d759..a601ba57190e 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1404,7 +1404,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 			 (unsigned long) control_port->start, priv->rx_irq,
 			 priv->tx_irq);
 
-	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii", ndev->name);
+	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-pcs-mii", dev_name(&pdev->dev));
 	pcs_bus = devm_mdio_regmap_register(&pdev->dev, &mrc);
 	if (IS_ERR(pcs_bus)) {
 		ret = PTR_ERR(pcs_bus);
-- 
2.49.0


