Return-Path: <netdev+bounces-152184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875A9F3023
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A82D18837AE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE653204F66;
	Mon, 16 Dec 2024 12:09:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD12046B3
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350997; cv=none; b=FHPme3/mel9ZWgdVcILo534N0oZI2wMwpVQLBsM0RKPOUBe/YLuIG8PkqCsLYl2dM1y1XFz/YreIc5VZvQ9M0q47pHHm6m402f55uftKUwQGsnTuGZk0lic+DB1CmxSToqaHZaimV47briRhFZFL9ZnV/2NhvIrVwNU9YyDv25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350997; c=relaxed/simple;
	bh=RzI4qsAHPERBhbBj0HS3GCFXD9+RssdnOGbClkUytIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iI5pyHWcxqGl4K7kJGOZy2/ZPBtg67XYa33ofI+6kcEXTXuoIX4N4e2L/uipKlsI6attW3iV61Cael1OfmPYpRrHAXxYEvQA1Eqggm7pTQflLxM9Txq8oSOZgorBpNMt7Cx6Spfor7s5M5XWOF/7fosMVl8mhSN6SbmJr+rMvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9v1-0001C6-9G; Mon, 16 Dec 2024 13:09:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9uw-003h1l-2N;
	Mon, 16 Dec 2024 13:09:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tN9ux-0075uK-1N;
	Mon, 16 Dec 2024 13:09:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 5/6] net: usb: lan78xx: remove PHY register access from ethtool get_regs
Date: Mon, 16 Dec 2024 13:09:40 +0100
Message-Id: <20241216120941.1690908-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216120941.1690908-1-o.rempel@pengutronix.de>
References: <20241216120941.1690908-1-o.rempel@pengutronix.de>
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

Remove PHY register handling from `lan78xx_get_regs` and
`lan78xx_get_regs_len`. Since the controller can have different PHYs
attached, the first 32 registers are not universally relevant or the
most interesting. Simplify the implementation to focus on MAC and device
registers.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 78c75599b8f1..6c9dab290f3f 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2096,10 +2096,7 @@ static int lan78xx_set_pause(struct net_device *net,
 
 static int lan78xx_get_regs_len(struct net_device *netdev)
 {
-	if (!netdev->phydev)
-		return (sizeof(lan78xx_regs));
-	else
-		return (sizeof(lan78xx_regs) + PHY_REG_SIZE);
+	return sizeof(lan78xx_regs);
 }
 
 static void
@@ -2109,7 +2106,7 @@ lan78xx_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 	struct lan78xx_net *dev = netdev_priv(netdev);
 	unsigned int data_count = 0;
 	u32 *data = buf;
-	int i, j, ret;
+	int i, ret;
 
 	/* Read Device/MAC registers */
 	for (i = 0; i < ARRAY_SIZE(lan78xx_regs); i++) {
@@ -2124,22 +2121,6 @@ lan78xx_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 		data_count++;
 	}
 
-	if (!netdev->phydev)
-		return;
-
-	/* Read PHY registers */
-	for (j = 0; j < 32; i++, j++) {
-		ret = phy_read(netdev->phydev, j);
-		if (ret < 0) {
-			netdev_warn(dev->net,
-				    "failed to read PHY register 0x%02x\n", j);
-			goto clean_data;
-		}
-
-		data[i] = ret;
-		data_count++;
-	}
-
 	return;
 
 clean_data:
-- 
2.39.5


