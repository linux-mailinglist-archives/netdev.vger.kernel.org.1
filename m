Return-Path: <netdev+bounces-239063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 869F3C63451
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B561E4EEE96
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6F32B98D;
	Mon, 17 Nov 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="q2ZDsKOf"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E732AADF;
	Mon, 17 Nov 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372061; cv=none; b=X9ibUudxw7OPec5++T0tanpG0k+62NHz30eay3tBbugTNbbo3HgqXIcZqrAXCZnhdTbfmEPZwMrw/xge08I5aMYxqqr7eXy+m8eTJVCFo7wfH1sptJOZD6ECh6mjTBgvgHRrCvxBNtHHW6JBLGGPnrv3RRIn/XAC/fpRGEx8F+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372061; c=relaxed/simple;
	bh=B49nBHxIuzVOEULhPN5wOHnbfcc4eVZGc2xkKeclO/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkrKxhPbNEtYV4itygle05KyQH1W+te+mJiFlzew1pvEWsOv8Q4m0FPeJSmQzD2bvk9cPPgr+RRA72Bo0Cl1NbrO0alv5MrD/QRe8UPDqR2niyREkFEZQN8wHC2WWZW1bcCqXJqdJUkMHnE6qTXm/LyoQ+cGU1coKraxnTNyljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=q2ZDsKOf; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 713EEA0E58;
	Mon, 17 Nov 2025 10:29:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=RjR5fIJXZ0Wd2CbExGWG
	ok0ww2A3povdz3FFp+DBBBQ=; b=q2ZDsKOf0dPVcrjVtxLiRiO79tCxDzng5m1G
	0tiYK3g906sxXrwIjciOB5SdZE+udRHhEKBE/JBX04bkk3c5kzgIKAN/Gi5FmK5h
	/y1Ai749GrNHLopkxFMHWbKfFNcTkKgrAATUMrztbzjCnEQG00kHjF9MZYv4uYLX
	LGNfKspxUdn9H38VgK0TAXhXbkyEQ9o7hf3m5iJVJj433+I7hI78YkiS1VATHdOD
	Z1lSGlMgoM1FCw1+ki313HKqg5CoiuCIx48167aC6rnyl6fQAZPmK/D54VjnUiDK
	14fzBSA1lagqznf3xJdDGR0LekRF2NI874sEpbt5SOZYmrF3r+r43qk3QKCdnZmI
	V1km4MRIjDhFREf7YZX3DOJDbJnW93GkMBAV2AKhzE/vFGmc2L1EZ3A3mJ6aEgMs
	uFjFAVxTfb3tsuI5gzNPcy5BdOECf5lWkKuyStBezbcD+zB9Z9JViZ4GgTf9xXxK
	YORVq+dXhX6Fj4KMP7aWYWDQTfOHySzk2MN0ao1wWGyYvG21bloW3iqrTS5c/vg+
	rw1sP3k4HpwB2LdPuK6m43Fqlb73Q7hPuU5PVjD0cPaNAURNY5hjvlBsBIRy6X2n
	sWsgD/rACWUVf7l6ngFxrWNTZecwcJGNZe4wauBOIjOD9UGJEGisYrTmpHOWh9OG
	wm+o78Y=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v2 2/3] net: mdio: common handling of phy device reset properties
Date: Mon, 17 Nov 2025 10:28:52 +0100
Message-ID: <94434fe1ccc72c45e1a3070d53885c8ab21a967a.1763371003.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1763371003.git.buday.csaba@prolan.hu>
References: <cover.1763371003.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763371741;VERSION=8002;MC=1368006000;ID=73152;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F617362

Unify the handling of the per device reset properties for
`mdio_device`.

Merge mdio_device_register_gpiod() and mdio_device_register_reset()
into mdio_device_register_reset(), that handles both
reset-controllers and reset-gpios.
Move reading of the reset firmware properties (reset-assert-us,
reset-deassert-us) from fwnode_mdio.c to mdio_device_register_reset(),
so all reset related initialization code is kept in one place.

Introduce mdio_device_unregister_reset() to release the associated
resources.

These changes make tracking the reset properties easier.
Added kernel-doc for mdio_device_register/unregister_reset().

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V1 -> V2: rebase, no change (leak fix already applied to base)
---
 drivers/net/mdio/fwnode_mdio.c |  5 -----
 drivers/net/phy/mdio_bus.c     | 12 ++--------
 drivers/net/phy/mdio_device.c  | 40 ++++++++++++++++++++++++++--------
 include/linux/mdio.h           |  2 +-
 4 files changed, 34 insertions(+), 25 deletions(-)

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
index 1ac942102..748c6a9aa 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -41,16 +41,9 @@ int mdiobus_register_device(struct mdio_device *mdiodev)
 		return -EBUSY;
 
 	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
-		err = mdio_device_register_gpiod(mdiodev);
-		if (err)
-			return err;
-
 		err = mdio_device_register_reset(mdiodev);
-		if (err) {
-			gpiod_put(mdiodev->reset_gpio);
-			mdiodev->reset_gpio = NULL;
+		if (err)
 			return err;
-		}
 
 		/* Assert the reset signal */
 		mdio_device_reset(mdiodev, 1);
@@ -67,8 +60,7 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
 	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
 		return -EINVAL;
 
-	gpiod_put(mdiodev->reset_gpio);
-	reset_control_put(mdiodev->reset_ctrl);
+	mdio_device_unregister_reset(mdiodev);
 
 	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
 
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 5a78d8624..749cf8cdb 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -118,8 +118,17 @@ void mdio_device_remove(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL(mdio_device_remove);
 
-int mdio_device_register_gpiod(struct mdio_device *mdiodev)
+/**
+ * mdio_device_register_reset - Read and initialize the reset properties of
+ *				an mdio device
+ * @mdiodev: mdio_device structure
+ *
+ * Return: Zero if successful, negative error code on failure
+ */
+int mdio_device_register_reset(struct mdio_device *mdiodev)
 {
+	struct reset_control *reset;
+
 	/* Deassert the optional reset signal */
 	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
 						 "reset", GPIOD_OUT_LOW);
@@ -129,22 +138,35 @@ int mdio_device_register_gpiod(struct mdio_device *mdiodev)
 	if (mdiodev->reset_gpio)
 		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
 
-	return 0;
-}
-
-int mdio_device_register_reset(struct mdio_device *mdiodev)
-{
-	struct reset_control *reset;
-
 	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
-	if (IS_ERR(reset))
+	if (IS_ERR(reset)) {
+		gpiod_put(mdiodev->reset_gpio);
+		mdiodev->reset_gpio = NULL;
 		return PTR_ERR(reset);
+	}
 
 	mdiodev->reset_ctrl = reset;
 
+	/* Read optional firmware properties */
+	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
+				 &mdiodev->reset_assert_delay);
+	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
+				 &mdiodev->reset_deassert_delay);
+
 	return 0;
 }
 
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
+
 void mdio_device_reset(struct mdio_device *mdiodev, int value)
 {
 	unsigned int d;
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 1322d2623..e76f5a6c2 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -92,8 +92,8 @@ void mdio_device_free(struct mdio_device *mdiodev);
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr);
 int mdio_device_register(struct mdio_device *mdiodev);
 void mdio_device_remove(struct mdio_device *mdiodev);
-int mdio_device_register_gpiod(struct mdio_device *mdiodev);
 int mdio_device_register_reset(struct mdio_device *mdiodev);
+void mdio_device_unregister_reset(struct mdio_device *mdiodev);
 void mdio_device_reset(struct mdio_device *mdiodev, int value);
 int mdio_driver_register(struct mdio_driver *drv);
 void mdio_driver_unregister(struct mdio_driver *drv);
-- 
2.39.5



