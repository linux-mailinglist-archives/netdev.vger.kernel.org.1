Return-Path: <netdev+bounces-173053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD332A57070
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513A5189B35F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675462459FB;
	Fri,  7 Mar 2025 18:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A624418F
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371888; cv=none; b=Ao7q0KFEvoEkiMq/aG5WoZjkaqIDsN8GySDMZaJQZHP+4XSoD1v7oAxUO+9WH9Ff1/zFG4XY6CLQigwy0mOj+jRVqJ11tSR1SwRPgel8UBOU/l2FYe6Q1YPdKiz4b0deaOqjgtBzFfnbyWbCsbirnbmLVMOnglGRTAbMNafi9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371888; c=relaxed/simple;
	bh=yCv8x93YhYUOE3HnfsdkAVa7/Luf5udGUPO0YCHVmZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ib9/hg0beDqnrAfYt+NQ6HZHxNSyFzj06f/LO4J9aD5IDUYiAZBi+GGVG7hJNu85lzIu3jQCyuymGRKEEtTHxpLUkLVz1b/0EBCilm3oUptB4AKkg6cR2jhCPx7Dvf9wAOklsf7oP7tGFob2yyvXgDDPt7LPPQFfh3ZVmf1URVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN9-0005me-4x; Fri, 07 Mar 2025 19:24:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-004X2Z-1z;
	Fri, 07 Mar 2025 19:24:33 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-008I8w-1e;
	Fri, 07 Mar 2025 19:24:33 +0100
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
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 5/7] net: usb: lan78xx: port link settings to phylink API
Date: Fri,  7 Mar 2025 19:24:30 +0100
Message-Id: <20250307182432.1976273-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307182432.1976273-1-o.rempel@pengutronix.de>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
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

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 224932d8134c..eca64334f383 100644
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


