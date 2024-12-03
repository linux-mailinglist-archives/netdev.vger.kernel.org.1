Return-Path: <netdev+bounces-148363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437B9E13F5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21D7B229DE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7D1DED6D;
	Tue,  3 Dec 2024 07:22:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB01DA11A
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210529; cv=none; b=IqHDnA4HowTNuA4FlcaTq7Ge+pHOak+cjuGtKcW9PzwZ+YVVH4wgDXjPUTEhXoqrvzxqPpSnxC2jvtBFPtHuATipo5i+qL/RVGaXC24VEH07CD/rXmkQD7sxHqf5czR2DaXKrAjQXwSBAQvGiF3hSGL+n1OTYQzk+MTF5/YR474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210529; c=relaxed/simple;
	bh=UnHLfhf1YV8TxVWKllpqYg/Sg1jZmQ3fTomBfGIX/1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qEr7A0TKH/YSyXCuSnHI5TWl6TGgo++BDOaZYXvCxIOQpY04rtaMkWpZyO7riLfiDK8U3XmDV6vNMc0aEzUf404NNQHjX4N6Ay1tUAcnRp8v/lKkjp9Pgm8fnRvkXosRxw1U4YSptHUN4yDA2D4rg/FF1e/FkqVWfu3dug+eoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEL-0004s2-6F; Tue, 03 Dec 2024 08:21:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001Qyp-0E;
	Tue, 03 Dec 2024 08:21:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEnE-2S;
	Tue, 03 Dec 2024 08:21:55 +0100
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
Subject: [PATCH net-next v1 05/21] net: usb: lan78xx: Fix error handling in MII read/write functions
Date: Tue,  3 Dec 2024 08:21:38 +0100
Message-Id: <20241203072154.2440034-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203072154.2440034-1-o.rempel@pengutronix.de>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
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

Ensure proper error handling in `lan78xx_mdiobus_read` and
`lan78xx_mdiobus_write` by checking return values of register read/write
operations and returning errors to the caller.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 94320deaaeea..ee308be1e618 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2136,12 +2136,16 @@ static int lan78xx_mdiobus_read(struct mii_bus *bus, int phy_id, int idx)
 	/* set the address, index & direction (read from PHY) */
 	addr = mii_access(phy_id, idx, MII_READ);
 	ret = lan78xx_write_reg(dev, MII_ACC, addr);
+	if (ret < 0)
+		goto done;
 
 	ret = lan78xx_phy_wait_not_busy(dev);
 	if (ret < 0)
 		goto done;
 
 	ret = lan78xx_read_reg(dev, MII_DATA, &val);
+	if (ret < 0)
+		goto done;
 
 	ret = (int)(val & 0xFFFF);
 
@@ -2172,10 +2176,14 @@ static int lan78xx_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
 
 	val = (u32)regval;
 	ret = lan78xx_write_reg(dev, MII_DATA, val);
+	if (ret < 0)
+		goto done;
 
 	/* set the address, index & direction (write to PHY) */
 	addr = mii_access(phy_id, idx, MII_WRITE);
 	ret = lan78xx_write_reg(dev, MII_ACC, addr);
+	if (ret < 0)
+		goto done;
 
 	ret = lan78xx_phy_wait_not_busy(dev);
 	if (ret < 0)
@@ -2184,7 +2192,7 @@ static int lan78xx_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
 done:
 	mutex_unlock(&dev->phy_mutex);
 	usb_autopm_put_interface(dev->intf);
-	return 0;
+	return ret;
 }
 
 static int lan78xx_mdio_init(struct lan78xx_net *dev)
-- 
2.39.5


