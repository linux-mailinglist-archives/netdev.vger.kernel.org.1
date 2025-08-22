Return-Path: <netdev+bounces-215967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16363B312A1
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0CF606093
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4D2EDD62;
	Fri, 22 Aug 2025 09:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CE4D599
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853808; cv=none; b=ZU3IfowgJXkGzSsPCnbXofMw1tbRmAWbIGmX8u7i1Wxx5acc/9cxkevwGE6HAcaLi8i3OwK6yM+DNgNjii6f7K/vsEwMVAoM4D74l9iafPAd/yjbpZ7RbVKnwRZWqFFAy1sgWdkS21J/89M5OTusqR55diu2jVmylHrA46/Dj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853808; c=relaxed/simple;
	bh=H46ZsFdsi8wK5AHAYbNZ9rgx89+GHyKz/gD+2mfUP7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HoqvvtoZqtOs78avrZdWx7MyjaW/19ZnfmOxoFsP9IrqR8CiiTdsqAPssv9omyKP++yb3LfnZTVXngKV/TVPoATAxTs73iMS/lkkKjQJZF88Fl1S6iAUXSNT7nzsrzwi0JfmDlhbI1AkGZ04hdODINsEmFzgjhLE3vJ/0WCBu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1upNmQ-00034v-3v; Fri, 22 Aug 2025 11:09:50 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upNmO-001YBY-25;
	Fri, 22 Aug 2025 11:09:48 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upNmO-00C2jk-1q;
	Fri, 22 Aug 2025 11:09:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v2 1/1] net: phy: Clear link-specific data on link down
Date: Fri, 22 Aug 2025 11:09:47 +0200
Message-Id: <20250822090947.2870441-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

When a network interface is brought down, the associated PHY is stopped.
However, several link-specific parameters within the phy_device struct
are not cleared. This leads to userspace tools like ethtool reporting
stale information from the last active connection, which is misleading
as the link is no longer active.

For example, after running `ip link set dev lan2 down`, ethtool might
show the following outdated information, indicating a 1000Mb/s Full
duplex link with a link partner, even though the link is detected as down:

  # ethtool lan2
  Settings for lan2:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        ...
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
                                             1000baseT/Full
        ...
        Speed: 1000Mb/s
        Duplex: Full
        Auto-negotiation: on
        master-slave cfg: preferred master
        master-slave status: slave
        ...
        Link detected: no

This patch fixes the issue by clearing all outdated link parameters within
the `phy_link_down()` function. This seems to be the correct place to reset
this data, as it is called whenever the link transitions to a down state.

The following parameters are now reset:
- Speed and duplex are set to UNKNOWN.
- Link partner advertising information is zeroed out.
- Master/slave state is set to UNKNOWN.
- MDI-X status is set to INVALID.
- EEE active status is set to false.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- rebase and resned against net-next

 drivers/net/phy/phy.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 13df28445f02..6bdd49d93740 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -83,6 +83,16 @@ static void phy_link_down(struct phy_device *phydev)
 {
 	phydev->phy_link_change(phydev, false);
 	phy_led_trigger_change_speed(phydev);
+
+	/* Clear the outdated link parameters */
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	if (phydev->master_slave_state != MASTER_SLAVE_STATE_UNSUPPORTED)
+		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+	phydev->mdix = ETH_TP_MDI_INVALID;
+	linkmode_zero(phydev->lp_advertising);
+	phydev->eee_active = false;
+
 	WRITE_ONCE(phydev->link_down_events, phydev->link_down_events + 1);
 }

--
2.39.5


