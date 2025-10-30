Return-Path: <netdev+bounces-234338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50908C1F826
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F14BA34A333
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB62351FB1;
	Thu, 30 Oct 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Owwl7WWy"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328992F5A0A;
	Thu, 30 Oct 2025 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819870; cv=none; b=Yj1fhbca6QmgrO/EkE+I1iBAim/Phb4RXpXR8PzhzZIqQXWQB9lMnQQHgVOI7NOQ/t3CPgVnbAeD17s7PQAop0rpVh1+Lrh4oazp2G+p3J6uu6jD+U03zjD42ORShHgPgI2wyVFV+7ilghLU8r7ZZXktl/tbJ/VYbZCJQLRJsn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819870; c=relaxed/simple;
	bh=bjGY5hODqCejSH9ODN/FinKpeyl4BAwFHF0wER2tDu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM8HXY2yMXNvlKDPMQA5Hf0nfg1QI7WLdLzlf6AgrolpO5DSGWFPmdGNdKhK5b/auookRLVHErx1TXznCpBVBVJGUmQRKPUeLXd3eeMfZgORREytuD9RhiXYXyihKNA6ZPUH208fkX2XfU3IjVnSlBX9EKjvRmlHpNKiNffkzdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Owwl7WWy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B0EB71A1778;
	Thu, 30 Oct 2025 10:24:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 86C9F6068C;
	Thu, 30 Oct 2025 10:24:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F29C102F2500;
	Thu, 30 Oct 2025 11:24:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761819865; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=etITqC8jMduEZk9ztensAl81JNZKmJfNvh2+zyGxRok=;
	b=Owwl7WWybvrT1Z8Yo3fx2q4sNl0TlauRyJQiLrYVmeIGttEKzq33li3cuSW0SuI1hwWscT
	MIKA1eId/jlI1o4zrLrgRKBj3pO5ms9JRHFOmMvogAOlXZFw5r8LFhTL24ij6WIjZlv1Cw
	7YPSUCIvfaYBJK/yWcR7zcLpKe0R6SJ+v597rH0IAr65DFD8DnTh2N5S8ZGR9kSDrrq1BV
	YHCJxP2q4NfzrQSJn5Q0cRBp/C853ssipiERIpAgz5S7RTDI6KEcPgmmBSeK2gt/sG7B2/
	Fr0XeScLi2VeJzON8sd2OygTUrN2rNpbBKmo6XlzPPLDNAj65o0oDPcdyem5dQ==
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
Subject: [PATCH net-next 1/4] net: altera-tse: Set platform drvdata before registering netdev
Date: Thu, 30 Oct 2025 11:24:14 +0100
Message-ID: <20251030102418.114518-2-maxime.chevallier@bootlin.com>
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

We don't have to wait until netdev is registered before setting it as the
pdev's drvdata. Move it at netdev alloc time.

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


