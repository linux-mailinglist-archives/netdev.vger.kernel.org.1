Return-Path: <netdev+bounces-202877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F834AEF83B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1811893CB2
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB222741B9;
	Tue,  1 Jul 2025 12:22:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DF273818
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372521; cv=none; b=nXqsM7qUqlbV17r5b7ai6UfmFwtRd4eoyAnqK2uZxaU73CNkfSr0iDbeKUNm1khkiLGQv1hdT7I6p50d2IY20ddqoVOW9EHw28goWmGcYtJTJZDraKXqClr9PQUTkLHh8homEYB+b7INwsSRGAK3X6L9zJp6vL0vR+5E2/Uy1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372521; c=relaxed/simple;
	bh=h5sT7K0qujjGAxa1ljOQ5qCQmP+3h2L0erhsAYhuP9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIkLjOFbkLz/QmDfhA7bV5W53hzYYTcYoi2C6BjHVBrwlR1QR3K4fXLHSpaNf3+izegHWqmf6qxZcoHxdKkj2DlIx3r9c29gKigcCJ4D+ADKu1wOi1cbXz7y22G2Ew+Qy0ghX/MRS5oVIQj6s4Ut2oA+SD51c6oTAX991zfr8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzh-0007K2-6Z; Tue, 01 Jul 2025 14:21:49 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzf-006GdF-2J;
	Tue, 01 Jul 2025 14:21:47 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzf-0009Gc-24;
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
Subject: [PATCH net v1 2/4] net: phy: smsc: Force predictable MDI-X state on LAN87xx
Date: Tue,  1 Jul 2025 14:21:44 +0200
Message-Id: <20250701122146.35579-3-o.rempel@pengutronix.de>
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

Override the hardware strap configuration for MDI-X mode to ensure a
predictable initial state for the driver. The initial mode of the LAN87xx
PHY is determined by the AUTOMDIX_EN strap pin, but the driver has no
documented way to read its latched status.

This unpredictability means the driver cannot know if the PHY has
initialized with Auto-MDIX enabled or disabled, preventing it from
providing a reliable interface to the user.

This patch introduces a `config_init` hook that forces the PHY into a
known state by explicitly enabling Auto-MDIX.

Fixes: 05b35e7eb9a1 ("smsc95xx: add phylib support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andre Edich <andre.edich@microchip.com>
---
 drivers/net/phy/smsc.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index adf12d7108b5..ad9a3d91bb8a 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -262,6 +262,33 @@ int lan87xx_read_status(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(lan87xx_read_status);
 
+static int lan87xx_phy_config_init(struct phy_device *phydev)
+{
+	int rc;
+
+	/* The LAN87xx PHY's initial MDI-X mode is determined by the AUTOMDIX_EN
+	 * hardware strap, but the driver cannot read the strap's status. This
+	 * creates an unpredictable initial state.
+	 *
+	 * To ensure consistent and reliable behavior across all boards,
+	 * override the strap configuration on initialization and force the PHY
+	 * into a known state with Auto-MDIX enabled, which is the expected
+	 * default for modern hardware.
+	 */
+	rc = phy_modify(phydev, SPECIAL_CTRL_STS,
+			SPECIAL_CTRL_STS_OVRRD_AMDIX_ |
+			SPECIAL_CTRL_STS_AMDIX_ENABLE_ |
+			SPECIAL_CTRL_STS_AMDIX_STATE_,
+			SPECIAL_CTRL_STS_OVRRD_AMDIX_ |
+			SPECIAL_CTRL_STS_AMDIX_ENABLE_);
+	if (rc < 0)
+		return rc;
+
+	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+
+	return smsc_phy_config_init(phydev);
+}
+
 static int lan874x_phy_config_init(struct phy_device *phydev)
 {
 	u16 val;
@@ -696,7 +723,7 @@ static struct phy_driver smsc_phy_driver[] = {
 
 	/* basic functions */
 	.read_status	= lan87xx_read_status,
-	.config_init	= smsc_phy_config_init,
+	.config_init	= lan87xx_phy_config_init,
 	.soft_reset	= smsc_phy_reset,
 	.config_aneg	= lan87xx_config_aneg,
 
-- 
2.39.5


