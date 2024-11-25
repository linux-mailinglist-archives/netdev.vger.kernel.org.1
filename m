Return-Path: <netdev+bounces-147172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC469D7D10
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2353B2331A
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFDF18C907;
	Mon, 25 Nov 2024 08:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B737188CCA
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524069; cv=none; b=Rq51JThvjmH6xWkYyXFDhrW+WvqEgxwYkINQcBg/vMq53M55iHt3kbl/m0qPfr2vNbrX98TPxv3d63sGPnGHrcb06bNSHHIY+yzHRgN2+y+YRlkqwmKPQWsIetWGEPVhLPUeCFPn39DI6PuwAkonG2Cj7CXHUQoeJ0WKMQMeu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524069; c=relaxed/simple;
	bh=kiBBSUL9X7SN5dhyCf4edjM+pjDqTJGocy6zkHwz4Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D08HthNovvsY1r+HiFHPQhUdHN+tFjba5yqEga5OKx8iFliqdf9JYRnxNLiCodMKlbL+8MZE0b9pIIxZOeztK7iDJrS9bMGxs3ByYbghQIkjZCeBq1BHBWBAF3S71hqNd7uLp/GhU+UG9PeMB3L+DkOwmUCe9qX1GgAOPoAaLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tFUeK-0002xJ-Qq; Mon, 25 Nov 2024 09:40:52 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tFUeI-00038D-0n;
	Mon, 25 Nov 2024 09:40:51 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tFUeI-001jnX-30;
	Mon, 25 Nov 2024 09:40:50 +0100
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
Subject: [PATCH net v2 1/1] net: phy: microchip: Reset LAN88xx PHY to ensure clean link state on LAN7800/7850
Date: Mon, 25 Nov 2024 09:40:50 +0100
Message-Id: <20241125084050.414352-1-o.rempel@pengutronix.de>
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

Fix outdated MII_LPA data in the LAN88xx PHY, which is used in LAN7800
and LAN7850 USB Ethernet controllers. Due to a hardware limitation, the
PHY cannot reliably update link status after parallel detection when the
link partner does not support auto-negotiation. To mitigate this, add a
PHY reset in `lan88xx_link_change_notify()` when `phydev->state` is
`PHY_NOLINK`, ensuring the PHY starts in a clean state and reports
accurate fixed link parallel detection results.

Fixes: 792aec47d59d9 ("add microchip LAN88xx phy driver")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/microchip.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index d3273bc0da4a..691969a4910f 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -351,6 +351,22 @@ static int lan88xx_config_aneg(struct phy_device *phydev)
 static void lan88xx_link_change_notify(struct phy_device *phydev)
 {
 	int temp;
+	int ret;
+
+	/* Reset PHY to ensure MII_LPA provides up-to-date information. This
+	 * issue is reproducible only after parallel detection, as described
+	 * in IEEE 802.3-2022, Section 28.2.3.1 ("Parallel detection function"),
+	 * where the link partner does not support auto-negotiation.
+	 */
+	if (phydev->state == PHY_NOLINK) {
+		ret = phy_init_hw(phydev);
+		if (ret < 0)
+			goto link_change_notify_failed;
+
+		ret = _phy_start_aneg(phydev);
+		if (ret < 0)
+			goto link_change_notify_failed;
+	}
 
 	/* At forced 100 F/H mode, chip may fail to set mode correctly
 	 * when cable is switched between long(~50+m) and short one.
@@ -377,6 +393,11 @@ static void lan88xx_link_change_notify(struct phy_device *phydev)
 		temp |= LAN88XX_INT_MASK_MDINTPIN_EN_;
 		phy_write(phydev, LAN88XX_INT_MASK, temp);
 	}
+
+	return;
+
+link_change_notify_failed:
+	phydev_err(phydev, "Link change process failed %pe\n", ERR_PTR(ret));
 }
 
 /**
-- 
2.39.5


