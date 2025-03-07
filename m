Return-Path: <netdev+bounces-173054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CCDA5706F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533E3177232
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F75C248874;
	Fri,  7 Mar 2025 18:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AB24418D
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371888; cv=none; b=Sji4aH7xidZO/sUTJRasKwyesDvCEB3+VO5PLacq1af0HrZYV12OfdWNugqbXmCy0wdp9jWiGJpMSsB7OrPqQ37BuFrmFMfdVir2xYUCWqkqkWYYs4xn8tO1K9H+SbDQBkodEYqYnfTQupyl2i53IbTlCbZ1L7AmDxE49dmnE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371888; c=relaxed/simple;
	bh=vEsqwdVT9a4J2K5hdpb/JHjoL9/L/tOBJ65AL2byS50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4VrMID8xBiY9cBieYiOCQaYcZ+f5E4Ydvb383Buog/0W/6DGl0P0QA8LI2B8pIXb4wJwJa+nlbI488iJnbKAFISTUTvBFu7qp5j3KMF7P6TTzRDxlzdeF3VWsi5Q3sukfTN0mqbDcWC8WVCMqxZtn9QdfD7Yr8LJK+rxkpPRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN9-0005mf-4w; Fri, 07 Mar 2025 19:24:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-004X2c-20;
	Fri, 07 Mar 2025 19:24:33 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-008I97-1i;
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
Subject: [PATCH net-next v2 6/7] net: usb: lan78xx: Transition get/set_pause to phylink
Date: Fri,  7 Mar 2025 19:24:31 +0100
Message-Id: <20250307182432.1976273-7-o.rempel@pengutronix.de>
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

Replace lan78xx_get_pause and lan78xx_set_pause implementations with
phylink-based functions. This transition aligns pause parameter handling
with the phylink API, simplifying the code and improving
maintainability.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 51 ++-------------------------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index eca64334f383..c257d8432695 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1878,63 +1878,16 @@ static void lan78xx_get_pause(struct net_device *net,
 			      struct ethtool_pauseparam *pause)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
-	struct phy_device *phydev = net->phydev;
-	struct ethtool_link_ksettings ecmd;
-
-	phy_ethtool_ksettings_get(phydev, &ecmd);
-
-	pause->autoneg = dev->fc_autoneg;
 
-	if (dev->fc_request_control & FLOW_CTRL_TX)
-		pause->tx_pause = 1;
-
-	if (dev->fc_request_control & FLOW_CTRL_RX)
-		pause->rx_pause = 1;
+	phylink_ethtool_get_pauseparam(dev->phylink, pause);
 }
 
 static int lan78xx_set_pause(struct net_device *net,
 			     struct ethtool_pauseparam *pause)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
-	struct phy_device *phydev = net->phydev;
-	struct ethtool_link_ksettings ecmd;
-	int ret;
-
-	phy_ethtool_ksettings_get(phydev, &ecmd);
-
-	if (pause->autoneg && !ecmd.base.autoneg) {
-		ret = -EINVAL;
-		goto exit;
-	}
 
-	dev->fc_request_control = 0;
-	if (pause->rx_pause)
-		dev->fc_request_control |= FLOW_CTRL_RX;
-
-	if (pause->tx_pause)
-		dev->fc_request_control |= FLOW_CTRL_TX;
-
-	if (ecmd.base.autoneg) {
-		__ETHTOOL_DECLARE_LINK_MODE_MASK(fc) = { 0, };
-		u32 mii_adv;
-
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
-				   ecmd.link_modes.advertising);
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
-				   ecmd.link_modes.advertising);
-		mii_adv = (u32)mii_advertise_flowctrl(dev->fc_request_control);
-		mii_adv_to_linkmode_adv_t(fc, mii_adv);
-		linkmode_or(ecmd.link_modes.advertising, fc,
-			    ecmd.link_modes.advertising);
-
-		phy_ethtool_ksettings_set(phydev, &ecmd);
-	}
-
-	dev->fc_autoneg = pause->autoneg;
-
-	ret = 0;
-exit:
-	return ret;
+	return phylink_ethtool_set_pauseparam(dev->phylink, pause);
 }
 
 static int lan78xx_get_regs_len(struct net_device *netdev)
-- 
2.39.5


