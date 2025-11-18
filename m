Return-Path: <netdev+bounces-239569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE4C69CA7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D88F352C5D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE735B12E;
	Tue, 18 Nov 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Zv9FQRST"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000C35E542;
	Tue, 18 Nov 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474354; cv=none; b=rmUhue/HGEpfc1g53MuOSA//1nq2gOp+dRH2oS5HjI4FhGUZ/e/kVz2+pGEk//Mio+o5Mux84MGBG3UOPPS85DrF2j4ka3RJNFxrJHfoVoMiU0bkzKWxRkt2Uxai/YYylYYEB8E19t8xsKme3AG3O2IGzl1ej2iMbxz5EbYXvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474354; c=relaxed/simple;
	bh=3f7YK3uSc0O+Kfapx1RFq3kfQ8LDm8UVkDFm/HvwC1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rb3mik3HMWye+BLKxNhh0jy3grBvYZNg7b5gfjK7ERwn5dd5OZCosC924S6aSjsVs1yon8KNK0IhTr1onGC6dwY9akReUX2LaYtd+7nLEPWx2JJyDJGOprzSsQCVj3F47zbOa/AGRCTQ6QJelAW7JVlKUNixnmPUhXrSYEV/nqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Zv9FQRST; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5E8E0A1AB9;
	Tue, 18 Nov 2025 14:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=tWRKjLP0mb6mRQSIsKHy
	zZvM1mUPS51i1WRMfsMMAtQ=; b=Zv9FQRSTyps8aknnOxKWY/7CceLC6u4ofSh7
	AM1h9pOor743Moo3IFbNqBb0AXvue2E1Gc2Y9DvwZxFmY/SgG6YY8h+OgIQquck0
	dQs0qxgWgs+Qax+7r+sOT1pugpyx7wo9mrMX2WWh+Jm+sAH2ovyX6DoF2riTavH/
	U8XJGibcp7iQwDdpjt8OpOg0Q6hG0Vqr9G8TsxOQ9JQi8FGvftTYxDd5MFDK0NBO
	WyQ0oKg2M98wQNIvy35nNnXce7a8h56RKyTntnpjlikc8kFwPDNoDGGmSnumemN6
	c8PcolOg60xJJuxnKZgKSwe819rjLHwTM6SSCwQTWosaHJlSUEyt7laxGNXFler4
	rQSxcqWnieA/LxppljKKQIr92pE/n+5a7VDLbXqbOcOrggWIC+UwjeLIFLfyA69l
	f0eCeTryZJfcb63IpAD6jsHPqWFwREBJcJYp8gTCStzfDaDMTTBT8EWw68ugJdI3
	YiQQzD3oDa0Zdjtaj9yrLRgAhtzLMex/p2+85yW8SKDYDScPdMhDOUM8GaiYXjGw
	peYMD49ZCLNm87/D9WQx4vMI3L4ncBpQ+Fz1AWlx5XXSIQJYL/2C9Rm2/+TogiXz
	0kFHxDNXwz+aapD7M3E/VCFFseUijxaHreAp7/rJgVC1Ft7ADUbASGGp9/gM4SBx
	VnK6x8E=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v3 2/3] net: mdio: common handling of phy device reset properties
Date: Tue, 18 Nov 2025 14:58:53 +0100
Message-ID: <17c216efd7a47be17db104378b6aacfc8741d8b9.1763473655.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1763473655.git.buday.csaba@prolan.hu>
References: <cover.1763473655.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763474337;VERSION=8002;MC=711453591;ID=69550;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F617266

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
V2 -> V3: moved declarations to drivers/net/phy/mdio-private.h
V1 -> V2: rebase, no change (leak fix already applied to base)
---
 drivers/net/mdio/fwnode_mdio.c |  5 -----
 drivers/net/phy/mdio-private.h |  2 +-
 drivers/net/phy/mdio_bus.c     | 12 ++--------
 drivers/net/phy/mdio_device.c  | 40 ++++++++++++++++++++++++++--------
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
diff --git a/drivers/net/phy/mdio-private.h b/drivers/net/phy/mdio-private.h
index 44e2e0907..8bc6d9088 100644
--- a/drivers/net/phy/mdio-private.h
+++ b/drivers/net/phy/mdio-private.h
@@ -6,6 +6,6 @@
  */
 
 int mdio_device_register_reset(struct mdio_device *mdiodev);
-int mdio_device_register_gpiod(struct mdio_device *mdiodev);
+void mdio_device_unregister_reset(struct mdio_device *mdiodev);
 
 #endif /* __MDIO_PRIVATE_H */
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 575b8bb5b..ef041ad66 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -42,16 +42,9 @@ int mdiobus_register_device(struct mdio_device *mdiodev)
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
@@ -68,8 +61,7 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
 	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
 		return -EINVAL;
 
-	gpiod_put(mdiodev->reset_gpio);
-	reset_control_put(mdiodev->reset_ctrl);
+	mdio_device_unregister_reset(mdiodev);
 
 	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
 
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 0e04bddd3..a4d9c6ccf 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -119,8 +119,17 @@ void mdio_device_remove(struct mdio_device *mdiodev)
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
@@ -130,22 +139,35 @@ int mdio_device_register_gpiod(struct mdio_device *mdiodev)
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
-- 
2.39.5



