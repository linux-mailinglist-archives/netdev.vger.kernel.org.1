Return-Path: <netdev+bounces-132141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAEA9908D8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EB21F210CC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61771C761D;
	Fri,  4 Oct 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f5qpaduI"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04BB1C305B;
	Fri,  4 Oct 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058577; cv=none; b=e1pspe7+jTSkZdXpAoB+vmvuhK0BKHJJDXZ3n1Q+qOjHfrYNLFKEMTfKcEb+U0SeDizOBQByePV193IHTVH4M1jfb0PaJC8GbyJJ2aiztVjSRsUaFg6GlkTFkwxEHl42Cn2lomBeQeGNCq0okrvEUdIxdAY5FCR3lklIyl/B3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058577; c=relaxed/simple;
	bh=FLiOKMSX1qX5t7E4RC3TaYm7ih/eICsTBamSnxEWTgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tA8c/esoxFhX63g6kUExjef5htS0I0HCdhobg3RfBp4C3xP2elLFZdA7LYgO98R+UOz3RY+UOm40JdmH5qrFPbExtDNTryMthP8aSWxbdEWeQ3iamQKOD3Ws3mkxMLeXbbo1XQSrOn3j7EaFCoP+ma1yDRI92aKhfo8x7Lcth2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f5qpaduI; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E3C820005;
	Fri,  4 Oct 2024 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728058567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/f6q5Qizdcop8Nrj7jLWs03QirLpkKjlSjLKs9Yhpc=;
	b=f5qpaduI01vlyF6v0hnvsY7WPF8ShonKgNmMqew+TfsDwF9f+n7+hbTSBKMUZqYAgLi/aQ
	UvqG/TyT7i7LWmG/E5W+gqpKCnRRy8cx7CIdlig2dVyUIwqtti2w8n5R76/5ce9l4HYJGP
	EPpJKV9VKXsYQHP4WRxKC62HCojjcPhMRm5u8gohDq+6evu0E8mvvzzuFefY2gmZqKs9TG
	w/0SGODav1K4neVE+bNqkk9dhlwozsqje/MKatUSngcjAi1StT9q/P7qTL2OTgL0aiHHJJ
	gAgi02P3xXtlIaDDRDJxa7viWopiG5/AhzYDNLLYLyblLjuMTj+0a/rwyTiaiQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH net-next v2 2/9] net: phy: Introduce phy_shutdown for device quiescence.
Date: Fri,  4 Oct 2024 18:15:52 +0200
Message-ID: <20241004161601.2932901-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

When the hardware platform goes down for reboot, there's always the
chance that the PHY device doesn't get reset, or fully reconfigured by
the bootloader, which could rely on strap settings.

Therefore, when special modes from the PHY are being used, which could
make it non-functional at reboot, introduce a phy_shutdown helper to
pull the PHY out of the non-functional mode it is currently in.

Currently, this applies to the isolation mode.

Suggested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2 : New patch

 drivers/net/phy/phy_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c468e72bef4b..a0d8ff995024 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3733,6 +3733,17 @@ static int phy_remove(struct device *dev)
 	return 0;
 }
 
+static void phy_shutdown(struct device *dev)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+
+	/* If the PHY isn't reset and reconfigured by the bootloader, the PHY
+	 * will stay isolated. Make sure to un-isolate PHYs during shutdown.
+	 */
+	if (phydev->isolated)
+		phy_isolate(phydev, false);
+}
+
 /**
  * phy_driver_register - register a phy_driver with the PHY layer
  * @new_driver: new phy_driver to register
@@ -3766,6 +3777,7 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
 	new_driver->mdiodrv.driver.probe = phy_probe;
 	new_driver->mdiodrv.driver.remove = phy_remove;
+	new_driver->mdiodrv.driver.shutdown = phy_shutdown;
 	new_driver->mdiodrv.driver.owner = owner;
 	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 
-- 
2.46.1


