Return-Path: <netdev+bounces-230535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6640DBEAA4C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE5265A6509
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B4281358;
	Fri, 17 Oct 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="JdgHh2vI"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9CC277C9B;
	Fri, 17 Oct 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717424; cv=none; b=cMEt4Pr3SodckzpaRk6Mma0mE+mg5j2n/mEaqgSI9yTHhilorEjIDoF+RXigpuM7Lvxd0WA5Edw3s+ick9dd9/1hHnSbbxuym/oQ25dJIrv7VFSMIyhRPqsBmYp3hsyLCdzB624dZiDUm5zXqGwcmmlr+gIEfctPpvxli7EYGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717424; c=relaxed/simple;
	bh=7QR8AU/m7DPl6r2PrXMtOiPfQZs8Z9/LicnwMliQpCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qw1lg8WZUsKF4wl3FJGxkMXSKxTCUuj8ekcYVzrs/ViIQpAAowNepS0GD6gpy2e3VT+/9cyEcERi+gx381AQMxvwor0mEH4Ii3pCOIqsH+9MqQBXEXsSwikJGo2WWRoIphKCgPtZmVJeRd76HwNCoyFd5/RS6ng+ZvslGftDlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=JdgHh2vI; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C4621A1ACB;
	Fri, 17 Oct 2025 18:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=qUKLXm1HJKsNZWHiLZ/7
	UZmcamu/LCklRmckKC9Wl/o=; b=JdgHh2vIZHZqgZuR6TOA8EwURSz79luKlsF3
	MQ+kYPWP6LCNgP3Q40iZHh2pV+XgS0b5+UkLL9g5jg/4w8BKXa13naIjojdZeDK8
	hMJedDLRs28CcctftxWp6qex4D9X9bpDkEeej5PhZtTFzVtvmhFZRCpx+VgjKpSQ
	qvWEK9tTdI67r2gn0WfhS16ytTSyya/TFa/G+0ApRDcXve2ZR7eIEtcPVtEq6sye
	lHgGm2QOzBoHf0zvRCz4zJZidw5G2kCW1QQ0Ir31BAs2hXAG68ScvupcHB5e2brx
	Bo9cjopeH7xW8sAPzTll7eMJosq8d6ElBCGeaCc0g0HdnuhCamEDmE09rj7/Susr
	iCqfugJWL6iWlE6mOElAPiG5yOLChPVJ+aD1C+9zEEXScjBzkav16Eku3dj5pObg
	hRDX5yzph1iMRtFYr042sTZ9uLoBW0A+c0SmH+4Hp3PfHENo7nkPWQCehL2wZp8T
	2ji6JcTrd4I6efeiJkRQSWtolwzKn113UeFh6cgSvqQKVWfj4MGw9sQFcF2Uf05z
	s4H+3nZrAF9r562+nmWS/thhT6h4mV7ja+ybsUP76rkA5Bwniwqf0ddGbBBeo7m7
	XVL7Oo26PD+BwjqGTn4mSdbjzUZEzunRaod5ITaIgs1OLM7sNB6Vc3zSUF4hskVC
	ATW7aEk=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Florian
 Fainelli" <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v3 1/4] net: mdio: common handling of phy reset properties
Date: Fri, 17 Oct 2025 18:10:08 +0200
Message-ID: <e24dabf604c370b65a6b62b99cb1c028616865bd.1760620093.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1760620093.git.buday.csaba@prolan.hu>
References: <cover.1760620093.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760717418;VERSION=8000;MC=436976404;ID=38907;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F647660

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
V2 -> V3: fixed kernel-doc warnings
V1 -> V2: the return value of mdio_device_unregister_reset() is made void
---
 drivers/net/mdio/fwnode_mdio.c |  5 ----
 drivers/net/phy/mdio_bus.c     | 39 ++-----------------------
 drivers/net/phy/mdio_device.c  | 52 ++++++++++++++++++++++++++++++++++
 include/linux/mdio.h           |  2 ++
 4 files changed, 56 insertions(+), 42 deletions(-)

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
index f64176e0e..fb1cb7a26 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -74,6 +74,58 @@ struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
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



