Return-Path: <netdev+bounces-202879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0FEAEF842
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C77D7AE430
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02B274B39;
	Tue,  1 Jul 2025 12:22:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CF2749D3
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372524; cv=none; b=CmOQsS4sSjuaEenkO0kzfpixDTavPIZ/7R3dtwm+knf5v64sB1UANA+x3x+PwBRUtl68VlC9zafLWsUYfEzrAnGglTg6/KAIxR2pdnVmS5yb8NkGB2UWfaXcEUcunFNklUo9zqx/qKta8oghPN55ef0SNyc0aIz4rwMKQWE/hOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372524; c=relaxed/simple;
	bh=2ndnXT/jdRZiwHSO45PZ1vhtye3DENczMp0fuqzlwn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/XfuqAteQON4hnE9zBy3dbbEdd9qwpPYMzclGC2au79LtsVhVF2K8CnZzbF9W3wKunI/b6cIffe9dWSLjFL8QnNZXhR4E7wdo0S6V+KI9klCmswiuIxBHDMLGsaxv0iVrLkjTBHonQwTnG863Y9NR0pmMTYIs8UveB00+RCgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzh-0007K3-6Z; Tue, 01 Jul 2025 14:21:49 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzf-006GdG-2O;
	Tue, 01 Jul 2025 14:21:47 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzf-0009Gm-28;
	Tue, 01 Jul 2025 14:21:47 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andre Edich <andre.edich@microchip.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH net v1 3/4] net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
Date: Tue,  1 Jul 2025 14:21:45 +0200
Message-Id: <20250701122146.35579-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701122146.35579-1-o.rempel@pengutronix.de>
References: <20250701122146.35579-1-o.rempel@pengutronix.de>
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

Force a fixed MDI-X mode when auto-negotiation is disabled to prevent
link instability.

When forcing the link speed and duplex on a LAN9500 PHY (e.g., with
`ethtool -s eth0 autoneg off ...`) while leaving MDI-X control in auto
mode, the PHY fails to establish a stable link. This occurs because the
PHY's Auto-MDIX algorithm is not designed to operate when
auto-negotiation is disabled. In this state, the PHY continuously
toggles the TX/RX signal pairs, which prevents the link partner from
synchronizing.

This patch resolves the issue by detecting when auto-negotiation is
disabled. If the MDI-X control mode is set to 'auto', the driver now
forces a specific, stable mode (ETH_TP_MDI) to prevent the pair
toggling. This choice of a fixed MDI mode mirrors the behavior the
hardware would exhibit if the AUTOMDIX_EN strap were configured for a
fixed MDI connection.

Fixes: 05b35e7eb9a1 ("smsc95xx: add phylib support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andre Edich <andre.edich@microchip.com>
---
 drivers/net/phy/smsc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index ad9a3d91bb8a..b6489da5cfcd 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -155,10 +155,29 @@ static int smsc_phy_reset(struct phy_device *phydev)
 
 static int lan87xx_config_aneg(struct phy_device *phydev)
 {
-	int rc;
+	u8 mdix_ctrl;
 	int val;
+	int rc;
+
+	/* When auto-negotiation is disabled (forced mode), the PHY's
+	 * Auto-MDIX will continue toggling the TX/RX pairs.
+	 *
+	 * To establish a stable link, we must select a fixed MDI mode.
+	 * If the user has not specified a fixed MDI mode (i.e., mdix_ctrl is
+	 * 'auto'), we default to ETH_TP_MDI. This choice of a ETH_TP_MDI mode
+	 * mirrors the behavior the hardware would exhibit if the AUTOMDIX_EN
+	 * strap were configured for a fixed MDI connection.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		if (phydev->mdix_ctrl == ETH_TP_MDI_AUTO)
+			mdix_ctrl = ETH_TP_MDI;
+		else
+			mdix_ctrl = phydev->mdix_ctrl;
+	} else {
+		mdix_ctrl = phydev->mdix_ctrl;
+	}
 
-	switch (phydev->mdix_ctrl) {
+	switch (mdix_ctrl) {
 	case ETH_TP_MDI:
 		val = SPECIAL_CTRL_STS_OVRRD_AMDIX_;
 		break;
@@ -184,7 +203,7 @@ static int lan87xx_config_aneg(struct phy_device *phydev)
 	rc |= val;
 	phy_write(phydev, SPECIAL_CTRL_STS, rc);
 
-	phydev->mdix = phydev->mdix_ctrl;
+	phydev->mdix = mdix_ctrl;
 	return genphy_config_aneg(phydev);
 }
 
-- 
2.39.5


