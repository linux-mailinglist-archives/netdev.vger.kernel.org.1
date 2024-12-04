Return-Path: <netdev+bounces-148895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4809E35AB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6984C16586F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3141A08CB;
	Wed,  4 Dec 2024 08:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B7195FE8
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301716; cv=none; b=XNMvG9UeS7m1oFdg50MWE/QYGYHwQ6e8cmDS5ZdX8rNdQteC7bdMk6XwBEHLqNKynCgImMTWaAAaIx1fNSDIkD7A0joeqBgwI6M4w0Xr/4ODSFiSmrQwW2pBscfBGdnJfVqEdlMGstfhL2L14bK3Dd+L6zl+gosM12hq2842dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301716; c=relaxed/simple;
	bh=StQoRYtHfhhzrOuELmQHU1gzGAOj2sUbvxcL0xro6tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWFe08cV7OEG6bwdpGQqpadF8hB3gxhwRLXFFg1chi9u+/aBs9sNe4akRSN9Sgn8dmL1pb4pa3tGRV8miS1ThmKQZ1n1/kRYqniYy7RZvduqz3RZRopCh6mQMf0bAAbiPntRMz+TodYwSISEwwqxscjh7NtNHfuAOF+MUNkJoDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx7-0001I6-43; Wed, 04 Dec 2024 09:41:45 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-001cUE-0j;
	Wed, 04 Dec 2024 09:41:44 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-004ptJ-2u;
	Wed, 04 Dec 2024 09:41:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 05/10] net: usb: lan78xx: Fix error handling in MII read/write functions
Date: Wed,  4 Dec 2024 09:41:37 +0100
Message-Id: <20241204084142.1152696-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204084142.1152696-1-o.rempel@pengutronix.de>
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


