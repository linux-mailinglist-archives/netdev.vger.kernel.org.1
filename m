Return-Path: <netdev+bounces-175648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE673A66FEB
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F193BF856
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601BF20AF9A;
	Tue, 18 Mar 2025 09:34:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993ED207A3E
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290467; cv=none; b=qHE9282t/ak/c9mgy7dSiFffl50GpbWGRHkhPBLd3Q1TYLw2/j8nVseFEa95Oa8bmrJnTyagCsjRxdVl61Hp5i+e7ICUvenkdYVQnoQMGvFyr4NntCxug7xh7E/66ctnascVY0s/clwRbZAVbdY+YFYwDXLN7Y3FGByrpR52yo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290467; c=relaxed/simple;
	bh=b8G0xHBrERk6HOzvZz5Ak5jFc0QZIpvIzeIrIMbIcB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dc+iRPFXIQj0Z12eWa7msQJxFqA4Gl2YnfxJ3OPCgNd/1YRIhdCzUJ+zP4gYlWf8qi5VyHFSdRKQiWcRPJYQ72wIXYJ3iSdBXReRn+mFYdUHFWjm6qX8uLgmo7eUKq3XmEW+NNiXhkdwAEv2tjeHCH3uuoyVXirwwEEBW7PPjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKu-0005yK-LX; Tue, 18 Mar 2025 10:34:12 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKt-000OyV-0M;
	Tue, 18 Mar 2025 10:34:11 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKt-00CmvF-17;
	Tue, 18 Mar 2025 10:34:11 +0100
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 07/10] net: usb: lan78xx: port link settings to phylink API
Date: Tue, 18 Mar 2025 10:34:07 +0100
Message-Id: <20250318093410.3047828-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318093410.3047828-1-o.rempel@pengutronix.de>
References: <20250318093410.3047828-1-o.rempel@pengutronix.de>
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

Refactor lan78xx_get_link_ksettings and lan78xx_set_link_ksettings to
use the phylink API (phylink_ethtool_ksettings_get and
phylink_ethtool_ksettings_set) instead of directly interfacing with the
PHY. This change simplifies the code and ensures better integration with
the phylink framework for link management.

Additionally, the explicit calls to usb_autopm_get_interface() and
usb_autopm_put_interface() have been removed. These were originally
needed to manage USB power management during register accesses. However,
lan78xx_mdiobus_read() and lan78xx_mdiobus_write() already handle USB
auto power management internally, ensuring that the interface remains
active when necessary. Since there are no other direct register accesses
in these functions that require explicit power management handling, the
extra calls have become redundant and are no longer needed.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
changes v4:
- add explanation why we do not care about usb_autopm in this functions
---
 drivers/net/usb/lan78xx.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 18fd90dd9916..b8d86b4aca57 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1862,46 +1862,16 @@ static int lan78xx_get_link_ksettings(struct net_device *net,
 				      struct ethtool_link_ksettings *cmd)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
-	struct phy_device *phydev = net->phydev;
-	int ret;
-
-	ret = usb_autopm_get_interface(dev->intf);
-	if (ret < 0)
-		return ret;
 
-	phy_ethtool_ksettings_get(phydev, cmd);
-
-	usb_autopm_put_interface(dev->intf);
-
-	return ret;
+	return phylink_ethtool_ksettings_get(dev->phylink, cmd);
 }
 
 static int lan78xx_set_link_ksettings(struct net_device *net,
 				      const struct ethtool_link_ksettings *cmd)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
-	struct phy_device *phydev = net->phydev;
-	int ret = 0;
-	int temp;
-
-	ret = usb_autopm_get_interface(dev->intf);
-	if (ret < 0)
-		return ret;
-
-	/* change speed & duplex */
-	ret = phy_ethtool_ksettings_set(phydev, cmd);
 
-	if (!cmd->base.autoneg) {
-		/* force link down */
-		temp = phy_read(phydev, MII_BMCR);
-		phy_write(phydev, MII_BMCR, temp | BMCR_LOOPBACK);
-		mdelay(1);
-		phy_write(phydev, MII_BMCR, temp);
-	}
-
-	usb_autopm_put_interface(dev->intf);
-
-	return ret;
+	return phylink_ethtool_ksettings_set(dev->phylink, cmd);
 }
 
 static void lan78xx_get_pause(struct net_device *net,
-- 
2.39.5


