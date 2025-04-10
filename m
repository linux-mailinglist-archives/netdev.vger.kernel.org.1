Return-Path: <netdev+bounces-181230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EB4A8422F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520C74C7D1A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E528CF43;
	Thu, 10 Apr 2025 11:53:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCB2857D1
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286002; cv=none; b=bvyn3bQCEHb2z7xPWR8zcQdCdqWK8LkoHJ2zR13oOdNYTukOp0+o4qvQWc2LosnuhqcSGa8V3NeAc7dobbsJn+O+nXtV0nJ5pMfeh8UQq3L37Bx+GlWGDmCEezMxyz0sxz7g8zLT5oMDOJj7bEhInVQpaA2qhz8yQtYgajxipGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286002; c=relaxed/simple;
	bh=R6b4n6nC15xoaOkbAw+pBbmn+M3dq3xctr6dUUJpFgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWGvsCoPNQ4KkDWeuM2+DAumzmZBlXa+bbtQo/fXewTqUV8E/JRiqfy6gVc+9iD/GVdLvLFzJ0AGYg5rfPns2geQ/EfG4/pLaAY03FF87Rtc1yF4lvq4zflsM2QzSwUe0pRVoG5W34bUL0ORAfRJWm6LEbeFw+SO87vsNE931KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSw-0002xt-Q1; Thu, 10 Apr 2025 13:53:06 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSt-004GKy-37;
	Thu, 10 Apr 2025 13:53:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSt-00Akep-2s;
	Thu, 10 Apr 2025 13:53:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v6 02/12] net: usb: lan78xx: remove explicit check for missing PHY driver
Date: Thu, 10 Apr 2025 13:52:52 +0200
Message-Id: <20250410115302.2562562-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410115302.2562562-1-o.rempel@pengutronix.de>
References: <20250410115302.2562562-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

RGMII timing correctness relies on the PHY providing internal delays.
This is typically ensured via PHY driver, strap pins, or PCB layout.

Explicitly checking for a PHY driver here is unnecessary and non-standard.
This logic applies to all MACs, not just LAN78xx, and should be left to
phylib, phylink, or platform configuration.

Drop the check and rely on standard subsystem behavior.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- this patch is added in v6
---
 drivers/net/usb/lan78xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 13b5da18850a..2876a119159c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2543,10 +2543,6 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 		if (ret < 0)
 			return ERR_PTR(ret);
 	} else {
-		if (!phydev->drv) {
-			netdev_err(dev->net, "no PHY driver found\n");
-			return ERR_PTR(-EINVAL);
-		}
 		dev->interface = PHY_INTERFACE_MODE_RGMII_ID;
 		/* The PHY driver is responsible to configure proper RGMII
 		 * interface delays. Disable RGMII delays on MAC side.
-- 
2.39.5


