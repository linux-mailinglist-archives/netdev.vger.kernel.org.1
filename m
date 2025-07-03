Return-Path: <netdev+bounces-203788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76E5AF72FB
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A6F3B64C6
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0092652B6;
	Thu,  3 Jul 2025 11:50:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242372E339D
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543401; cv=none; b=FKr1T1aYq++NI83K7vckcgr5hP3drkRkBeQOedGmiTeo142KiTrR0j8hguo2IuCIuYxmtGp7IHrxkFB3ahEOdLXenEpWMFMS6sLNUX55JzgF/HgFTMGhJRJP828L5oTmCVHF796rR1vBqg1ApJZCsIA+HDdCojKslYNh0AdkW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543401; c=relaxed/simple;
	bh=2ndnXT/jdRZiwHSO45PZ1vhtye3DENczMp0fuqzlwn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=saMkj+caEDZrB7qLMefJPAAyn9arGQ3mca+8+K+TMrZMTawfwuGrhEgtgAvd+eNzRs4cbRHob4IbYVkIG9zaBXtBwLqFvCSb8NB5w/4uPwea1Vl67Wwco/gx4zd9XrXKKrEUw1nCIoThQ07t3FVvrlwUu502DXENDSlS/IG620M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uXIRk-0004Pm-FJ; Thu, 03 Jul 2025 13:49:44 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uXIRi-006awI-1p;
	Thu, 03 Jul 2025 13:49:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uXIRi-00Dbth-1Z;
	Thu, 03 Jul 2025 13:49:42 +0200
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
Subject: [PATCH net v2 3/3] net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
Date: Thu,  3 Jul 2025 13:49:41 +0200
Message-Id: <20250703114941.3243890-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703114941.3243890-1-o.rempel@pengutronix.de>
References: <20250703114941.3243890-1-o.rempel@pengutronix.de>
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


