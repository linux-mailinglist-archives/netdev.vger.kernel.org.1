Return-Path: <netdev+bounces-186427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B19A9F165
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398483B6750
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933F726B2CA;
	Mon, 28 Apr 2025 12:51:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244C26A1DE
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844699; cv=none; b=OrAcy83yQtEaKqSrAQMR4Am+WmGATp5MhYqo11e0Ty9zZRV9U60FZF+VC2I9uJQcTOtRx0TYCCUMjDMOpWWO0LpjcDEJ80p4fFrwv/77aY9CzpQcl6iMpQZ41SxoK0U1MdYJEtQYcX2rVLs1BttKnDN/L1IUjPmnvQSwUAJ+IBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844699; c=relaxed/simple;
	bh=xtQH8hL/JAq5BZPBxmrrmwIJH1+MKVZHkg0hPfy9pV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIIKk0w+zvYFNF+CgVbBO1FWxpWXr/bEE9v8mkXFLwBeEfhu3tWrd+F3xqkdZX6SskmiYwFz4umrr0i2VrNjGitjgtYE29ZuZD9fN2zWpecL/sNE+zCZmfy5BYnP/Xzq0x5CZJ7kTXE7QW1H81xerrVLrpkP95wBX0jswt4TKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9NxD-0002iW-AH; Mon, 28 Apr 2025 14:51:23 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9NxB-00068H-2t;
	Mon, 28 Apr 2025 14:51:21 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9NxB-00EKA4-2e;
	Mon, 28 Apr 2025 14:51:21 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v1 2/2] net: phy: micrel: remove KSZ9477 EEE quirks now handled by phylink
Date: Mon, 28 Apr 2025 14:51:19 +0200
Message-Id: <20250428125119.3414046-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125119.3414046-1-o.rempel@pengutronix.de>
References: <20250428125119.3414046-1-o.rempel@pengutronix.de>
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

The KSZ9477 PHY driver contained workarounds for broken EEE capability
advertisements by manually masking supported EEE modes and forcibly
disabling EEE if MICREL_NO_EEE was set.

With proper MAC-side EEE handling implemented via phylink, these quirks
are no longer necessary. Remove MICREL_NO_EEE handling and the use of
ksz9477_get_features().

This simplifies the PHY driver and avoids duplicated EEE management logic.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: stable@vger.kernel.org # v6.14+
---
 drivers/net/phy/micrel.c   | 7 -------
 include/linux/micrel_phy.h | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 71fb4410c31b..c2e5be404f07 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2027,12 +2027,6 @@ static int ksz9477_config_init(struct phy_device *phydev)
 			return err;
 	}

-	/* According to KSZ9477 Errata DS80000754C (Module 4) all EEE modes
-	 * in this switch shall be regarded as broken.
-	 */
-	if (phydev->dev_flags & MICREL_NO_EEE)
-		phy_disable_eee(phydev);
-
 	return kszphy_config_init(phydev);
 }

@@ -5698,7 +5692,6 @@ static struct phy_driver ksphy_driver[] = {
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= genphy_suspend,
 	.resume		= ksz9477_resume,
-	.get_features	= ksz9477_get_features,
 } };

 module_phy_driver(ksphy_driver);
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 591bf5b5e8dc..9af01bdd86d2 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -44,7 +44,6 @@
 #define MICREL_PHY_50MHZ_CLK	BIT(0)
 #define MICREL_PHY_FXEN		BIT(1)
 #define MICREL_KSZ8_P1_ERRATA	BIT(2)
-#define MICREL_NO_EEE		BIT(3)

 #define MICREL_KSZ9021_EXTREG_CTRL	0xB
 #define MICREL_KSZ9021_EXTREG_DATA_WRITE	0xC
--
2.39.5


