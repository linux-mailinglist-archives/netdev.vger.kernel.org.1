Return-Path: <netdev+bounces-234339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FF4C1F82C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6186A4E8340
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C2433B955;
	Thu, 30 Oct 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vAn9a9rm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FBF350D5A
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819871; cv=none; b=Lb8HYJQAWMDZwU2iMq72GlnyLIni38A+lscsT2aH5QBIV5ZtFGOsuMHCOgEE0+ctx181s+Z3nebuBOA7Iru/uTNVeXwoprXBSCkKrgXLepOISJbG2AEe98YmMOesyPD1uSV9ip0hfp+yBN2qiHLw35VjutZQjOSyAFmE780+a+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819871; c=relaxed/simple;
	bh=NeJozDG6vfAMv5LoS86jW2wCvGloDnDz+QdanWS+ZoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxxWsq+1WDca/S6Bf9Z6yFl0l1I8cnZdsj7c3oHLLAdbFs/XhV6bKL/CGebiZqsXxXKAEx5NDN8TGHwqNoU8UpUIQzSkjljEjha2IKYibt2lfMxPRcjy/QVDkDGQB5Waw+jcdcM0/0DZIV2ocUNSUVSpWjryPA8p9uIFe8ZaYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vAn9a9rm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CF6F01A177A;
	Thu, 30 Oct 2025 10:24:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A43776068C;
	Thu, 30 Oct 2025 10:24:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6E6411808822;
	Thu, 30 Oct 2025 11:24:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761819866; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2s4YXZ006r6JZP+ciPRm1kPsUk3RftNVPiuxZBb+ZTw=;
	b=vAn9a9rmxnbtvZT/vKNskkN65m9GgP+3q8h+3M5x//R56m/gemmelQiAgN6FMK+iR3EDB3
	btIbRjEhe40kR/XIjhowoBflZXk+RfqSvUrtcw+FQqthYO8xL2TqurCVq71N4Wf4AOyvCt
	eYbKAeN73cEKSTC4Da/4s0L72RibvqH1zz6jEWnVCEWhuKxyTvhBfrvrdcauaQeHUobGRe
	EbUwK9rs+70XURh9KN1stUkOr7wkfRiMbIp1bheey9U/ZLTXVhh2l0Lozy40njWDR11Skr
	VPw5JTiHMNTNpntmQk/035OzYvK4AP8+mUywR9mUAn3610M++Eju2SaUae5mrQ==
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
Subject: [PATCH net-next 2/4] net: altera-tse: Read core revision before registering netdev
Date: Thu, 30 Oct 2025 11:24:15 +0100
Message-ID: <20251030102418.114518-3-maxime.chevallier@bootlin.com>
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

The core revision is used in .ndo_open(), so we have to populate it
before regstering the netdev.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 6ba1249f027d..c74b1c11d759 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1388,6 +1388,8 @@ static int altera_tse_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->tx_lock);
 	spin_lock_init(&priv->rxdma_irq_lock);
 
+	priv->revision = ioread32(&priv->mac_dev->megacore_revision);
+
 	netif_carrier_off(ndev);
 	ret = register_netdev(ndev);
 	if (ret) {
@@ -1395,8 +1397,6 @@ static int altera_tse_probe(struct platform_device *pdev)
 		goto err_register_netdev;
 	}
 
-	priv->revision = ioread32(&priv->mac_dev->megacore_revision);
-
 	if (netif_msg_probe(priv))
 		dev_info(&pdev->dev, "Altera TSE MAC version %d.%d at 0x%08lx irq %d/%d\n",
 			 (priv->revision >> 8) & 0xff,
-- 
2.49.0


