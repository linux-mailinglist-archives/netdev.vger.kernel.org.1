Return-Path: <netdev+bounces-233874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AADC19BDE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E1304FEF37
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6C33C533;
	Wed, 29 Oct 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="K4cmsBdD"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D577336EEF;
	Wed, 29 Oct 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733439; cv=none; b=mXQ/yAZ4yrS1cr/llJl+ft1UEAmQQDQVzJEcXplOw1XRq3XbkfeZjty55I38ROywX6PB3fuSmPfVdwC4CrWyaGKkI/swVB5f1ctHrnQuK9UjrhoL6Wov7Lbcm1PHDLADPNHlgf0WiRdteCeFAY8f/GGvJCdHdHrs1Y2y0QkQqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733439; c=relaxed/simple;
	bh=N3CjMvJm810Tzw8+vLep/nynn+c6CzgdHtQQv1ih6gE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjzwTjH6nb8HN2zoCTI2Sfcwi04AoWGX3SkhdLhX1G5ypXWjgW4s80+MT3RLYBC5Q1bjP6D6NISV7N0A5pW+hWZRI/oKzfNgVlwVZspKicCSaNiP68MPGKdc4PqKQnJVyDDOqSgrcHswhX7nm2YwSiP466lV/raxCWQWP8XkgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=K4cmsBdD; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E7D54A05A6;
	Wed, 29 Oct 2025 11:23:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=xpe494TUf12sWea7iMN8
	Pf4yZH2UjtnChHKj5WZ93kk=; b=K4cmsBdDGtRNQIdGYURVlBhAZELQjQnox+0M
	bfZsVccdDPEQ2hcJ72lf93ZOe1CtQMKFtS46mpWWybJv2Xdwlu6hO/CD6VYKs4nW
	lU1ZkLI/ULm+bMQRf95zCh9ZkomHV9y7buTZIEfGsi1imWkVr2j1xkmlvjutuqiz
	kH07AfJ1AokpiVtWvUMqkq/Eg2ZNtOo2NzO0kWx0WX2VmBeiaTaBPkEzXPZ1qjeg
	T+FHy1MwRL1hifd5qkfX7Ce2657jGV75k0CerrbLoKoR8cgzIGU9UcbqdhvA5ESb
	f83UDIWDb0kYCQwcRs2IfsP6p7UWHnjjDWVk0AIyVDC2sLX5d/fIUI84H6QRz2lL
	pWXbsSXsfP48vfuPbHeYxBrE+9hcV8CmA01u/IDTpRQo6YaxDs2oQ48d/ghc1lA6
	+zf7JE+3h/Tq+ykHQ37iqEBYUiRCk+fOmaA0pDDEIX8aQLaEYM98sFPSKqdWXlzC
	jhnXvXpyXxZnrHIdyRYsrsSIi0kJ55d08lmqN4nbWchR4nqrExSqLgTiOQMoctrk
	XhpBcNLQtMkz2LZpg15/LilQ6lj99OaImxtYqUgWCnBSONGOhpBohTFX4SIjWgOk
	AINYpBNN099Ua8+WPkb1FxSgrmYTwXKXSFmkrHBgMMBrRtsgHsUmWiRLq4ZfvkU7
	7byRh08=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v5 1/4] net: mdio: common handling of phy reset properties
Date: Wed, 29 Oct 2025 11:23:41 +0100
Message-ID: <a96ac9a58165a4ea15b1c96cab3bbc5d568e9cba.1761732347.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1761732347.git.buday.csaba@prolan.hu>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761733431;VERSION=8000;MC=766825136;ID=148162;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677066

Unify the handling of reset properties for an `mdio_device`.
Replace mdiobus_register_gpiod() and mdiobus_register_reset() with
mdio_device_register_reset() and mdio_device_unregister_reset(),
and move them from mdio_bus.c to mdio_device.c, where they belong.

The new functions handle both reset-controllers and reset-gpios,
and also read the corresponding firmware properties from the
device tree, which were previously handled in fwnode_mdio.c.
This makes tracking the reset properties easier.

The reset logic is unaltered, and should work as it did before.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V4 -> V5:
 - fixed possible leak in mdio_device_register_reset() if both
   a reset-gpio and a reset-controller are present.
 - fixed whitespace
 - updated commit message
V3 -> V4: unmodified
V2 -> V3: fixed kernel-doc warnings
V1 -> V2: changed the return value of mdio_device_unregister_reset()
          to void
---
 drivers/net/mdio/fwnode_mdio.c |  5 ----
 drivers/net/phy/mdio_bus.c     | 39 ++-----------------------
 drivers/net/phy/mdio_device.c  | 53 ++++++++++++++++++++++++++++++++++
 include/linux/mdio.h           |  2 ++
 4 files changed, 57 insertions(+), 42 deletions(-)

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
index f64176e0e..b56a75ee3 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -74,6 +74,59 @@ struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 }
 EXPORT_SYMBOL(mdio_device_create);
 
+/**
+ * mdio_device_register_reset - Read and initialize the reset properties of
+ *				an mdio device
+ * @mdiodev: mdio_device structure
+ *
+ * Return: Zero if successful, negative error code on failure
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
+	if (IS_ERR(mdiodev->reset_gpio))
+		return PTR_ERR(mdiodev->reset_gpio);
+
+	if (mdiodev->reset_gpio)
+		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
+
+	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
+	if (IS_ERR(reset)) {
+		gpiod_put(mdiodev->reset_gpio);
+		return PTR_ERR(reset);
+	}
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
index 42d6d47e4..d81b63fc7 100644
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



