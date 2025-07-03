Return-Path: <netdev+bounces-203786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C71AF72F7
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915BF5631CF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94C2E6D34;
	Thu,  3 Jul 2025 11:49:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A4256C71
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543399; cv=none; b=O7xDRIQmsm/pgfItZC0aTN9iXJbw+2oZR5Y3BWg2nsg8qwSVQ31vYNjZCue5TArbUHUEd+vL8dNcmV0uPrSVCy6HcTw85hHyxEGB21cSdQesM0/OUSc2fVatpdtdDuBCK7feO+L1ncxD3w6UID13MOE/q4Wv2K06Nbo9cg8QGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543399; c=relaxed/simple;
	bh=T1eznURLjuD0Abxq1edZummHu16xKukTlKv1spW65/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q8XLzZ47eHbT32/dijXySGOxHvTsY+g+1GtManpKTc5hUfVB6u/lXW/LUNbAjeIT2tArT5la+TaI4ozlTBWEK7xaY7cQdTLqqmBpauoU7e+PGlyIiRD+kLwsHM2tKLrPMy+ZgKTx9lnR1OPzMy5uRA1h+T3yzTYdPy5BDABoOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uXIRk-0004Pk-FK; Thu, 03 Jul 2025 13:49:44 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uXIRi-006awG-1f;
	Thu, 03 Jul 2025 13:49:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uXIRi-00DbtN-1Q;
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
Subject: [PATCH net v2 1/3] net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
Date: Thu,  3 Jul 2025 13:49:39 +0200
Message-Id: <20250703114941.3243890-2-o.rempel@pengutronix.de>
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

Correct the Auto-MDIX configuration to ensure userspace settings are
respected when the feature is disabled by the AUTOMDIX_EN hardware strap.

The LAN9500 PHY allows its default MDI-X mode to be configured via a
hardware strap. If this strap sets the default to "MDI-X off", the
driver was previously unable to enable Auto-MDIX from userspace.

When handling the ETH_TP_MDI_AUTO case, the driver would set the
SPECIAL_CTRL_STS_AMDIX_ENABLE_ bit but neglected to set the required
SPECIAL_CTRL_STS_OVRRD_AMDIX_ bit. Without the override flag, the PHY
falls back to its hardware strap default, ignoring the software request.

This patch corrects the behavior by also setting the override bit when
enabling Auto-MDIX. This ensures that the userspace configuration takes
precedence over the hardware strap, allowing Auto-MDIX to be enabled
correctly in all scenarios.

Fixes: 05b35e7eb9a1 ("smsc95xx: add phylib support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andre Edich <andre.edich@microchip.com>
---
 drivers/net/phy/smsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 31463b9e5697..adf12d7108b5 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -167,7 +167,8 @@ static int lan87xx_config_aneg(struct phy_device *phydev)
 			SPECIAL_CTRL_STS_AMDIX_STATE_;
 		break;
 	case ETH_TP_MDI_AUTO:
-		val = SPECIAL_CTRL_STS_AMDIX_ENABLE_;
+		val = SPECIAL_CTRL_STS_OVRRD_AMDIX_ |
+			SPECIAL_CTRL_STS_AMDIX_ENABLE_;
 		break;
 	default:
 		return genphy_config_aneg(phydev);
-- 
2.39.5


