Return-Path: <netdev+bounces-205418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B09AFE9A8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5CF07B60C5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3AE2E06D7;
	Wed,  9 Jul 2025 13:08:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E8E2DC330
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066490; cv=none; b=AaJ5hQXV0TFuEDnA/YyCGUw51mFzmEHkmKsxeA+DSsqmZQvuSHb0JYd/XVm8HYpD8amzy84rwyUZwLJTRLHZulebQ0JjO1mQ2wZRqf9IHThEbHyYv5MNLQ0D0EkirZzuPxlc0wdG4FnPiu0QuIqTwLZU2kdum7kM6I9s02vFi0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066490; c=relaxed/simple;
	bh=KbQkGauBnJ7Yg2RJHXECgDLTB81gGN+tu3f81Z/wcjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIf8LxtssRoM2z8JZca0Wuyv1keaO3cN2RtCvU4IIfbCK/riCbg+2cQ6CqksrVcuqob/suPV9CP6guW+N6e3j3Bt2navcFxTUE2s6/sQZj89wxFDWu6EQbgDbE+tlU/Ue5RA5vVJuKsFoYESW9ky4J8LgLV0770vsM+whXbNCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uZUWj-00036o-Fp; Wed, 09 Jul 2025 15:07:57 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZUWi-007afS-2x;
	Wed, 09 Jul 2025 15:07:56 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZUWi-00Gl9L-2h;
	Wed, 09 Jul 2025 15:07:56 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net v1 1/2] net: phy: microchip: Use genphy_soft_reset() to purge stale LPA bits
Date: Wed,  9 Jul 2025 15:07:52 +0200
Message-Id: <20250709130753.3994461-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709130753.3994461-1-o.rempel@pengutronix.de>
References: <20250709130753.3994461-1-o.rempel@pengutronix.de>
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

Enable .soft_reset for the LAN88xx PHY driver by assigning
genphy_soft_reset() to ensure that the phylib core performs a proper
soft reset during reconfiguration.

Previously, the driver left .soft_reset unimplemented, so calls to
phy_init_hw() (e.g., from lan88xx_link_change_notify()) did not fully
reset the PHY. As a result, stale contents in the Link Partner Ability
(LPA) register could persist, causing the PHY to incorrectly report
that the link partner advertised autonegotiation even when it did not.

Using genphy_soft_reset() guarantees a clean reset of the PHY and
corrects the false autoneg reporting in these scenarios.

Fixes: ccb989e4d1ef ("net: phy: microchip: Reset LAN88xx PHY to ensure clean link state on LAN7800/7850")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/microchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 13570f628aa5..5e590b0a75e5 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -488,6 +488,7 @@ static struct phy_driver microchip_phy_driver[] = {
 	.config_init	= lan88xx_config_init,
 	.config_aneg	= lan88xx_config_aneg,
 	.link_change_notify = lan88xx_link_change_notify,
+	.soft_reset	= genphy_soft_reset,
 
 	/* Interrupt handling is broken, do not define related
 	 * functions to force polling.
-- 
2.39.5


