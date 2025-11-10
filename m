Return-Path: <netdev+bounces-237123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E63C459FD
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95A61891074
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7EF30215F;
	Mon, 10 Nov 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wArlXWyS"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7E301707;
	Mon, 10 Nov 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766715; cv=none; b=JRGX/RV3fWYJsUqFFJpgq2eXF8GmlOUcVuCOklPWABtCDvHsUDsaU1/UYp+aLKywyj01qB+5ESd0tN6t7qVXytiO++FCY7GTb8omZysoEe9DQ0oaklnwz+vjLWXVOC8DfpKcuWhMHb8Vs69ZRHq2/bjtUyN3tur+XKRS7idPvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766715; c=relaxed/simple;
	bh=ULs1DEZEigOyIVU7AoEOuGOQZb2JvmSdJPOMo+K/7wM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxIkvQ8AJFO6/c3VDmTL6EYP/JhxuYWj7agVU3oVvxGIdJSo2PfePIhKsytSO45EeKqp/YMepuZ4rJ6H9w599c7YBLGhj/ikKVVFk51p30IKIwHiyIy1QPW3JRzGz6e6+lOPT/wDiQJvtBpv+aBUxxz4CYryA/J5cjh4nudVjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wArlXWyS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E73211A19A8;
	Mon, 10 Nov 2025 09:25:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD0FA606F5;
	Mon, 10 Nov 2025 09:25:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F29D2103718CB;
	Mon, 10 Nov 2025 10:25:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762766703; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B1QSpE6XJ9KVp8HlVH1jfxpje3rEVDSSIyeKjy0FtNU=;
	b=wArlXWySXjAeHWfd6jjhnKWGB9Tj29IdT3i2QxHg7WaOTjgZc/TU75thgXa+p8Utw2a2XF
	dqfWXnQFi3uNI7le29Du88tlFt/eXa6ShMXtg7lRq+q1Iv6F1IJT3cFcVfWkwZ4sy12Wot
	bwJIfogrPd1Hd+0pOm8gtzJFjBV9TCrcAv+K38W3F1chWvZxwtZrEx3CXdO59NwZkyHXj3
	b5r2IUfVQ+s7jj9ESrAk0mPS/i/BeOHFNLG8D2B0wmhg+nrOe1Gt16lQ8icpQYtygFj3hQ
	nbYFYmoNSW7gSpKGlS8Se6CI0ndrD/nG13xDigJxvTEaW13wGy6zn/Huj8Qg0g==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 10 Nov 2025 10:24:54 +0100
Subject: [PATCH net-next v2 2/3] net: phy: dp83869: ensure FORCE_LINK_GOOD
 is cleared
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-sfp-1000basex-v2-2-dd5e8c1f5652@bootlin.com>
References: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
In-Reply-To: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The FORCE_LINK_GOOD bit in the PHY_CONTROL register forces the reported
link status to 1 if the selected speed is 1Gbps.

According to the DP83869 PHY datasheet, this bit should default to 0 after
a hardware reset. However, the opposite has been observed on some DP83869
components.

As a consequence, a valid link will be reported in 1000Base-X operational
modes, even if the autonegotiation process failed.

Make sure that the FORCE_LINK_GOOD bit is cleared during initial
configuration.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 309bf608d630..143b75842fc7 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -89,6 +89,7 @@
 #define DP83869_STRAP_MIRROR_ENABLED           BIT(12)
 
 /* PHYCTRL bits */
+#define DP83869_FORCE_LINK_GOOD	BIT(10)
 #define DP83869_RX_FIFO_SHIFT	12
 #define DP83869_TX_FIFO_SHIFT	14
 
@@ -811,6 +812,15 @@ static int dp83869_config_init(struct phy_device *phydev)
 	struct dp83869_private *dp83869 = phydev->priv;
 	int ret, val;
 
+	/* The FORCE_LINK_GOOD bit in the PHYCTRL register should be
+	 * unset after a hardware reset but it is not. make sure it is
+	 * cleared so that the PHY can function properly.
+	 */
+	ret = phy_clear_bits(phydev, MII_DP83869_PHYCTRL,
+			     DP83869_FORCE_LINK_GOOD);
+	if (ret)
+		return ret;
+
 	/* Force speed optimization for the PHY even if it strapped */
 	ret = phy_modify(phydev, DP83869_CFG2, DP83869_DOWNSHIFT_EN,
 			 DP83869_DOWNSHIFT_EN);

-- 
2.51.2


