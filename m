Return-Path: <netdev+bounces-247088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E75CF45B6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5579B3016F9C
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8875F30F545;
	Mon,  5 Jan 2026 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SyXbZL93"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62B2EA731;
	Mon,  5 Jan 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626337; cv=none; b=pQRCpSyZyvCA7/r3uwT067MiCJ1L8ILf2g1p0Bs2XdpybpY8BRiHJ+oKrvggZa5MYAb/N8g82aAT+JfKRZ5TOevWAbtb6Joqo3ZqGPLyBoOW/i7s6Kmv0Ry6NZmtPaSNwQGs44ioj2yzP4uoTf1Xl21dbJKQXx5Mp8DOZHS3UPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626337; c=relaxed/simple;
	bh=/itnq6Bb3u8S5tdDDMxlsIB8q1EHSZ6cyOOwLSOdc7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGJK42Hw3fFnf/wQXv6tb5/5httOirLKvsbxSSY+iW/YYxj9ZitzElFAQgL+yJ2+zqwQRxzuj8Nitg9LAL2svlAb2kH1Ec/1xwovnAuJraPVvFgsQ4UXhEBJBIPZIRhRFOnWBr09AX3nPbXVz5wMMRRk3Y5ZaV7VErR+JVgZoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SyXbZL93; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 57D9BC1E487;
	Mon,  5 Jan 2026 15:18:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4C9AE60726;
	Mon,  5 Jan 2026 15:18:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C32E4103C8581;
	Mon,  5 Jan 2026 16:18:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767626331; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=NTfaVJ6LEzshSCXzu2wOy+wPtqzvTXdU9coTrQs7DZk=;
	b=SyXbZL935tCLlXeuNFGQk49fE4fyMznFdmAeQgs0/leamiOZX+dyXV9QfMcC4mM6+X/QlP
	8Jfsca9Ug6zLVJCM9hLETtLr5tDdGjT16ZV3bhC8JPp9B4gRaS3BVShZLGdfEGxjgXRNhm
	0KQOIZ21nDnv4gJob0YNMzDE/evk/D53vbM4M7/8xydyOX2ZJAZQrZRZ1ux7C1PYO4kCfV
	O/2o9qWxLpTwqQ57JTHvndCVzD0cKOy0uqZZe6lpVHR5CaB83Ub4gF9TLGPJLYHDeAe1Q2
	T/VxtTNFtSISZ6MfrHfjeFryHeu/1mKh0B3cnbc/Kti/5wUDYHPH5g6uFYe0Bg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net] net: sfp: return the number of written bytes for smbus single byte access
Date: Mon,  5 Jan 2026 16:18:39 +0100
Message-ID: <20260105151840.144552-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

We expect the SFP write accessors to return the number of written bytes.
We fail to do so for single-byte smbus accesses, which may cause errors
when setting a module's high-power state and for some cotsworks modules.

Let's return the amount of written bytes, as expected.

Fixes: 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 6166e9196364..84bef5099dda 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -765,7 +765,7 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
 		dev_addr++;
 	}
 
-	return 0;
+	return data - (u8 *)buf;
 }
 
 static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
-- 
2.49.0


