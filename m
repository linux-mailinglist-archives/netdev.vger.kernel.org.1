Return-Path: <netdev+bounces-229597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F5EBDECF9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A33E34AA49
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040DF23BD1D;
	Wed, 15 Oct 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="uVfAl0mJ"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891F2264B1;
	Wed, 15 Oct 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535912; cv=none; b=Jk73fj8Dx5FBm3suioOe+QfwQulb7Z8zwD6f6siRLNGYnlteDatUWLCJ1FEs2Lg7cpKAXO97fj04xuj68eim6BERreV3LHPzBzPwErd6+K9b6uWIRLRKhWtfus2WcuBFsxEux1YpmhS+qp3x3mHq/2z7LQ7DIq4B/9dSTKs2D3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535912; c=relaxed/simple;
	bh=tHzPQ914X8TTctWSiJ8ibXYvAhbpT+ZVP3DQyksWNu8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MMdDnVktga2dnGziaXJLoZaDU7LzPU0FvPxEEc25Cnszqnv5v73ooRAqsY1vPbm9A9ffgODqqZBpD7RJhqozCRrPI3tctkYs8HRYk+0du3NDhDRM8RolYp/L+52/h3ZfW7CahYY0FhpJzNY0PxV94XAZyT5phN9nC2b6oDweNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=uVfAl0mJ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0F926A1AA5;
	Wed, 15 Oct 2025 15:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=MXJdM8cTqS9HrIPjdoxajauisYtWpOglBHWBj9fWUgY=; b=
	uVfAl0mJSJymLIaqRfd6r5ZrcYfN+wIm33oBZ/XJ4PK1Xt+lT0mE16jALlt30GIx
	j3PBii489uHLQSRCqxXkrnQFN/BohytnWKaGTotoz7dd4nfdiC9dBtupqs34dWql
	Jd+Cy43Wn/PnSpelW/ke/5XfzCAIPJYxlkqBkLMWwwb1uqSSBDZ2WbA8XX1F+AMj
	wx2G6AiLjlBnE2mJ5bfwE9fH9ZqzK6JmqZPDCdJk25lPiggK1P3zCfPCgdiaEv93
	u/P4Ny+sPIZnuV6LosMXuM+20FaYJTf1Yas5e2Aaw09e7LcVpUTJyacpz0zZr1I4
	B/gR53EQXTk6QzEBLBVr/FxiXgBeTo0ZGg+UrBpxkL4TCtmVGwA3O/wKjFogmT5M
	wRBx7gkqIcwTuW1YpfvQrHI6kXxBud8bMe5d2pd5hQvt70QaSRrHS21fREmE1xpx
	nZtYj0GQtYPRIht1Ab4BMHzv2vA7UpG0s32N5WnHOSYlKptQbG+Cj7ucB6rv/wxw
	gjIdG3xMidKO2xCCatAfT/BRfOqQf5SrTKJpLZe3ryaqhH8JidpJKavsrzlbMyTL
	bSw1+kIwO6uMcuNTHvZ0xacPjxlQgC61e3QYYVlugdym5c1vnbmUAe9li89ttD8O
	om36nlHfqX1+N8LhwsqodRC2yHHgBsFKYekgASHluuE=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH v2 1/4] net: mdio: common handling of phy reset properties
Date: Wed, 15 Oct 2025 15:45:00 +0200
Message-ID: <20251015134503.107925-1-buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760535906;VERSION=8000;MC=1304816191;ID=558032;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F64756A

Reset properties of an `mdio_device` are initialized in multiple
source files and multiple functions:
  - `reset_assert_delay` and `reset_deassert_delay` are in
    fwnode_mdio.c
  - `reset_gpio` and `reset_ctrl` are in mdio_bus.c, but handled by
    different functions

This patch unifies the handling of all these properties into two
functions.
mdiobus_register_gpiod() and mdiobus_register_reset() are removed,
while mdio_device_register_reset() and mdio_device_unregister_reset()
are introduced instead.
These functions handle both reset-controllers and reset-gpios, and
also read the corresponding properties from the device tree.
These changes should make tracking the reset properties easier.

The reset logic is unaltered, and should work as it did before.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V1 -> V2: the return value of mdio_device_unregister_reset() is made void
---
 drivers/net/mdio/fwnode_mdio.c |  5 ----
 drivers/net/phy/mdio_bus.c     | 39 ++------------------------
 drivers/net/phy/mdio_device.c  | 50 ++++++++++++++++++++++++++++++++++
 include/linux/mdio.h           |  2 ++
 4 files changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 9b41d4697..ba7091518 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -92,11 +92,6 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 	if (fwnode_property_read_bool(child, "broken-turn-around"))
 		mdio->phy_ignore_ta_mask |= 1 << addr;
 
-	fwnode_property_read_u32(child, "reset-assert-us",
-				 &phy->mdio.reset_assert_delay);
-	fwnode_property_read_u32(child, "reset-deassert-us",
-				 &phy->mdio.reset_deassert_delay);
-
 	/* Associate the fwnode with the device structure so it
 	 * can be looked up later
 	 */
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index cad6ed3aa..cc3f9cfb1 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -33,33 +33,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/mdio.h>
 
-static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
-{
-	/* Deassert the optional reset signal */
-	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
-						 "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(mdiodev->reset_gpio))
-		return PTR_ERR(mdiodev->reset_gpio);
-
-	if (mdiodev->reset_gpio)
-		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
-
-	return 0;
-}
-
-static int mdiobus_register_reset(struct mdio_device *mdiodev)
-{
-	struct reset_control *reset;
-
-	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
-	if (IS_ERR(reset))
-		return PTR_ERR(reset);
-
-	mdiodev->reset_ctrl = reset;
-
-	return 0;
-}
-
 int mdiobus_register_device(struct mdio_device *mdiodev)
 {
 	int err;
@@ -68,16 +41,9 @@ int mdiobus_register_device(struct mdio_device *mdiodev)
 		return -EBUSY;
 
 	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
-		err = mdiobus_register_gpiod(mdiodev);
+		err = mdio_device_register_reset(mdiodev);
 		if (err)
 			return err;
-
-		err = mdiobus_register_reset(mdiodev);
-		if (err)
-			return err;
-
-		/* Assert the reset signal */
-		mdio_device_reset(mdiodev, 1);
 	}
 
 	mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;
@@ -91,8 +57,7 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
 	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
 		return -EINVAL;
 
-	gpiod_put(mdiodev->reset_gpio);
-	reset_control_put(mdiodev->reset_ctrl);
+	mdio_device_unregister_reset(mdiodev);
 
 	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
 
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index f64176e0e..eb8237095 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -74,6 +74,56 @@ struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 }
 EXPORT_SYMBOL(mdio_device_create);
 
+/**
+ * mdio_device_register_reset - Read and initialize the reset properties of
+ *				an mdio device
+ * @mdiodev: mdio_device structure
+ */
+int mdio_device_register_reset(struct mdio_device *mdiodev)
+{
+	struct reset_control *reset;
+
+	/* Read optional firmware properties */
+	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
+				 &mdiodev->reset_assert_delay);
+	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
+				 &mdiodev->reset_deassert_delay);
+
+	/* reset-gpio, bring up deasserted */
+	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev, "reset",
+						 GPIOD_OUT_LOW);
+
+	if (IS_ERR(mdiodev->reset_gpio))
+		return PTR_ERR(mdiodev->reset_gpio);
+
+	if (mdiodev->reset_gpio)
+		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
+
+	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	mdiodev->reset_ctrl = reset;
+
+	/* Assert the reset signal */
+	mdio_device_reset(mdiodev, 1);
+
+	return 0;
+}
+EXPORT_SYMBOL(mdio_device_register_reset);
+
+/**
+ * mdio_device_unregister_reset - uninitialize the reset properties of
+ *				  an mdio device
+ * @mdiodev: mdio_device structure
+ */
+void mdio_device_unregister_reset(struct mdio_device *mdiodev)
+{
+	gpiod_put(mdiodev->reset_gpio);
+	reset_control_put(mdiodev->reset_ctrl);
+}
+EXPORT_SYMBOL(mdio_device_unregister_reset);
+
 /**
  * mdio_device_register - Register the mdio device on the MDIO bus
  * @mdiodev: mdio_device structure to be added to the MDIO bus
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index c640ba44d..4cedcae08 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -90,6 +90,8 @@ static inline void *mdiodev_get_drvdata(struct mdio_device *mdio)
 
 void mdio_device_free(struct mdio_device *mdiodev);
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr);
+int mdio_device_register_reset(struct mdio_device *mdiodev);
+void mdio_device_unregister_reset(struct mdio_device *mdiodev);
 int mdio_device_register(struct mdio_device *mdiodev);
 void mdio_device_remove(struct mdio_device *mdiodev);
 void mdio_device_reset(struct mdio_device *mdiodev, int value);
-- 
2.39.5



