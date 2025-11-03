Return-Path: <netdev+bounces-235008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1043FC2B23C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B02764EE810
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C073009D6;
	Mon,  3 Nov 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gngyqhCs"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79FB2F28FC;
	Mon,  3 Nov 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166980; cv=none; b=nWJjR7fZd/yxVvF2XJ8Lo9E1flJPdYNvG37d5woX+FJSG5r0tMxDmutwDbqOn+7yk8YvJOUNaKa84RPWZN+T9x6aD/gR/WGmI0zayLWqIuNmG/z4Je8nRPoRy2mEO9A/bPrzP9gHQpt7M0UFqMlUw16Am3DkpOTOr23aegK9vj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166980; c=relaxed/simple;
	bh=0OPJrbTpbWnpgh1IpgBlFhkzIkSzBiYZl1U7Hgvbg3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVBz/mYwGa2lAVTwwpoDkTizmXwtI+16cgY4/cjT25LtpaJIM8tBSc/j7lFba7QayZtbwoAm0ItoxOHbyTBjiX5V/vjbVEA7EzIFpm0z57XQnkITsH8PrNMI4gW6FkjSHD4+PuMlP4PYXGVdMKyEVAZr+ROXkhnh/AI6H+xylRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gngyqhCs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4030C1A183F;
	Mon,  3 Nov 2025 10:49:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15A3060628;
	Mon,  3 Nov 2025 10:49:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C00DF10B50003;
	Mon,  3 Nov 2025 11:49:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762166975; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=DfdABhxo77Vq2hWxH97QPFhtQeZZYgJJr6yRSjPrA0g=;
	b=gngyqhCs0gVqdt4b/ON+QymUFz/4cmLsE12V8lsFHKwdis7GNwIJWR9XoGh3+pszOiRbA2
	oEJrJDEfXd6/JDSJCVx7bFk0ScTYE8tk2wALSmTlYsw2v+xO0m5/Exg6+eVhA28SI9Ihi8
	G5e6wJyqXbCr5yiVxY4ql3dPXqoBjSQiU2oEY6b6hbuPF/76yjqV8p+a7xdLwgd2UOwESD
	jDRGtEL3EP3DW0JdtSmgmYsDb97fcGqMpGw8wh4JpipZ2BXFd/d0jufPPCzWAL+ZtoncjC
	0zqxZg+5wGpUkP7uz31rJgJSfbY1ELkzMfVaW2OYK5fU0z80XYMeB6U32ktXTg==
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
Subject: [PATCH net-next v2 1/4] net: altera-tse: Set platform drvdata before registering netdev
Date: Mon,  3 Nov 2025 11:49:24 +0100
Message-ID: <20251103104928.58461-2-maxime.chevallier@bootlin.com>
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

We don't have to wait until netdev is registered before setting it as the
pdev's drvdata. Move it at netdev alloc time.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 3f6204de9e6b..6ba1249f027d 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1150,6 +1150,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 	}
 
 	SET_NETDEV_DEV(ndev, &pdev->dev);
+	platform_set_drvdata(pdev, ndev);
 
 	priv = netdev_priv(ndev);
 	priv->device = &pdev->dev;
@@ -1394,8 +1395,6 @@ static int altera_tse_probe(struct platform_device *pdev)
 		goto err_register_netdev;
 	}
 
-	platform_set_drvdata(pdev, ndev);
-
 	priv->revision = ioread32(&priv->mac_dev->megacore_revision);
 
 	if (netif_msg_probe(priv))
-- 
2.49.0


