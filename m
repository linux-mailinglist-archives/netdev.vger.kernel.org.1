Return-Path: <netdev+bounces-202878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95158AEF83D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8246D3A7B17
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C222749C0;
	Tue,  1 Jul 2025 12:22:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ADD273D7E
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372522; cv=none; b=iOeZJmvbmO/QtSvIAArbmSIGq6STPep0j/7fYI2LwdnrKsPjCPpEWMONHlWigjNepnR3pUa5CeN1NokfBx6Vo6vqQVoHaWMRDWh+6M0En5KUZKM3+D4hw25P7U9H50DRfWgpEvPLf98SjCOH3uhr7jSnSK8EMmXvT9jpV4a1ju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372522; c=relaxed/simple;
	bh=GVxzOmbuteW1CLn6leGWX8qffFDbE9Jux5PfpkbHWh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umRDt9fYXAqxPBqwbu1uYsN4vhPAOlei+slabcBI/o6oL+2+RvXei+eIskoCU1W8L8V2tMWCkGYRKnO1AOj4cfqCAMU7hhEmP4QQNZnJ6SLb45PvszgXCqJm4tZ8ECMuu1o0iIl0HjCevn6RgqIMqU4N0c3JgCeRxeTM27IiGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzh-0007K4-6O; Tue, 01 Jul 2025 14:21:49 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzf-006GdH-2U;
	Tue, 01 Jul 2025 14:21:47 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzf-0009Gw-2C;
	Tue, 01 Jul 2025 14:21:47 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Lukas Wunner <lukas@wunner.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>
Subject: [PATCH net v1 4/4] net: phy: smsc: Disable IRQ support to prevent link state corruption
Date: Tue,  1 Jul 2025 14:21:46 +0200
Message-Id: <20250701122146.35579-5-o.rempel@pengutronix.de>
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

Disable interrupt handling for the LAN87xx PHY to prevent the network
interface from entering a corrupted state after rapid configuration
changes.

When the link configuration is changed quickly, the PHY can get stuck in
a non-functional state. In this state, 'ethtool' reports that a link is
present, but 'ip link' shows NO-CARRIER, and the interface is unable to
transfer data.

Fixes: 1ce8b37241ed ("usbnet: smsc95xx: Forward PHY interrupts to PHY driver to avoid polling")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/net/phy/smsc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index b6489da5cfcd..dac6bf156d15 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -746,10 +746,6 @@ static struct phy_driver smsc_phy_driver[] = {
 	.soft_reset	= smsc_phy_reset,
 	.config_aneg	= lan87xx_config_aneg,
 
-	/* IRQ related */
-	.config_intr	= smsc_phy_config_intr,
-	.handle_interrupt = smsc_phy_handle_interrupt,
-
 	/* Statistics */
 	.get_sset_count = smsc_get_sset_count,
 	.get_strings	= smsc_get_strings,
-- 
2.39.5


