Return-Path: <netdev+bounces-39972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B1C7C5425
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E96C1C20F58
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD4B17740;
	Wed, 11 Oct 2023 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249410A2F
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 12:39:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83BF98
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 05:39:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qqYUN-0006sc-DJ; Wed, 11 Oct 2023 14:38:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qqYUM-000uOC-8G; Wed, 11 Oct 2023 14:38:58 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qqYUM-0063Tr-0c;
	Wed, 11 Oct 2023 14:38:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 3/3] net: phy: micrel: Fix forced link mode for KSZ886X switches
Date: Wed, 11 Oct 2023 14:38:56 +0200
Message-Id: <20231011123856.1443308-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011123856.1443308-1-o.rempel@pengutronix.de>
References: <20231011123856.1443308-1-o.rempel@pengutronix.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Address a link speed detection issue in KSZ886X PHY driver when in
forced link mode. Previously, link partners like "ASIX AX88772B"
with KSZ8873 could fall back to 10Mbit instead of configured 100Mbit.

The issue arises as KSZ886X PHY continues sending Fast Link Pulses (FLPs)
even with autonegotiation off, misleading link partners in autoneg mode,
leading to incorrect link speed detection.

Now, when autonegotiation is disabled, the driver sets the link state
forcefully using KSZ886X_CTRL_FORCE_LINK bit. This action, beyond just
disabling autonegotiation, makes the PHY state more reliably detected by
link partners using parallel detection, thus fixing the link speed
misconfiguration.

With autonegotiation enabled, link state is not forced, allowing proper
autonegotiation process participation.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/micrel.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 927d3d54658e..12f093aed4ff 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1729,9 +1729,35 @@ static int ksz886x_config_aneg(struct phy_device *phydev)
 {
 	int ret;
 
-	ret = genphy_config_aneg(phydev);
-	if (ret)
-		return ret;
+	if (phydev->autoneg != AUTONEG_ENABLE) {
+		ret = genphy_setup_forced(phydev);
+		if (ret)
+			return ret;
+
+		/* When autonegotation is disabled, we need to manually force
+		 * the link state. If we don't do this, the PHY will keep
+		 * sending Fast Link Pulses (FLPs) which are part of the
+		 * autonegotiation process. This is not desired when
+		 * autonegotiation is off.
+		 */
+		ret = phy_set_bits(phydev, MII_KSZPHY_CTRL,
+				   KSZ886X_CTRL_FORCE_LINK);
+		if (ret)
+			return ret;
+	} else {
+		/* Make sure, the link state is not forced.
+		 * Otherwise, the PHY we create a link by skipping the
+		 * autonegotiation process.
+		 */
+		ret = phy_clear_bits(phydev, MII_KSZPHY_CTRL,
+				     KSZ886X_CTRL_FORCE_LINK);
+		if (ret)
+			return ret;
+
+		ret = genphy_config_aneg(phydev);
+		if (ret)
+			return ret;
+	}
 
 	/* The MDI-X configuration is automatically changed by the PHY after
 	 * switching from autoneg off to on. So, take MDI-X configuration under
-- 
2.39.2


