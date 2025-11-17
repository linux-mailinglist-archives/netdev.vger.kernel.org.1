Return-Path: <netdev+bounces-239062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8625C63466
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CE01365CFA
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D41A32B994;
	Mon, 17 Nov 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tfVBsPSV"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946432ABC0;
	Mon, 17 Nov 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372061; cv=none; b=gh7Mfh15dVjuHWd9shXt+ktJ3mdl9OSiooU+am8NNxl3biEGPDEMk+BFvOvZRl3QXcZG0lXLOFFXAIDSya2fvI/RkV2RExIpAbWrM2NjTCvPwMKKWcKFxrr9s66QoO/Or1jwI6euGpfSLDq0kZCpn+Im2PIxVyMX3s4NVlF3fSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372061; c=relaxed/simple;
	bh=UeYYf5VV0kNIm9E+nCWuO1OCQIgok0tEk2oRFrkujdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzp2KtOLAZ6Lc4I6Gsbp+x4UDSiwd3gCj99GaS7Y+GdwigfUSIqqPcubLoV9hbbnODYRAb2SpyYBpH88FHbnVRY8XHo2X4W8sjOL7moLbAOlIdN+QzEbEEyDpizJW6xbN/lzfwEr0OkYEd3QUhSr9W02EbO3GN5E55bwvYti7v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tfVBsPSV; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 213E8A0E2D;
	Mon, 17 Nov 2025 10:29:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=NKTXCxE+WmadGakS8Fqc
	pxLfd+wNbf2qDFOLWh1VPBA=; b=tfVBsPSV9m9ewR7AVTtkBuk7PFY+r/FdBMlN
	ne7VbQTOmbD4UpmELqBWFvzY9c9SR9HAmbGoVVuTtVshvQMicPFgrwfJkEK7YcUa
	99c19Hf38QZ6QdRPfvNSXKC4w2s9D+UOHx5ZXrZEiWRGpucBypaEn02rjwkyCs6o
	l0hIUUjBkrh2LDxDdT7MVUGKyVDr/yUxNmWfNpwNIQVuq00bSI2L5ARByuysE6xO
	5KCIU4GX5JtN7fidi/+frGv0ySVRMQ+N8r5ps4w8jCeSWRoQbgHwtJS+2jkfvQYW
	JO0YpW2Y0Ne2ZWa/0QYoYiy8akb1zgCfb+MzjTYrH1OPe7tl+i9QnJBy9ZQiojfO
	ScWB/8lqUmyIEVi0dGb0TsB9QqUleV4FSXIY3KsZ67uiQYnbrrI+OMqEAh1F+WtR
	oCYSRVG/3amUTqlJ8OFKOSgzXGkx/0y+CYsybs3RiB/raZuPlnpV+B6CSxIfC7BX
	9FJFrKaA4ghLNZKEGgcp0Wg0koR80KmPYMwLS4JUtiL9Z93pNNdagsM6rWrgcU5v
	v7sjrVssCXV2C1DZC6qxtPCfX40i2oIS6Nn9oo/ZqGy5ZdA7Sa5Kp0RE9hqcyvZL
	v9tg5o308XJz2k+GOakv0Wiajx5bnRue1okRcGy5d/oWdhQ0tFYVu0cpFmrcMYhB
	bguSMDY=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v2 1/3] net: mdio: move device reset functions to mdio_device.c
Date: Mon, 17 Nov 2025 10:28:51 +0100
Message-ID: <d81e9c2f26c4af4f18403d0b2c6139f12c98f7b3.1763371003.git.buday.csaba@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763371741;VERSION=8002;MC=2833516564;ID=73151;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F617362

The functions mdiobus_register_gpiod() and mdiobus_register_reset()
handle the mdio device reset initialization, which belong to
mdio_device.c.
Move them from mdio_bus.c to mdio_device.c, and rename them to match
the corresponding source file: mdio_device_register_gpio() and
mdio_device_register_reset().
Remove 'static' qualifiers and declare them in mdio.h.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V1 -> V2: rebase, no changes
---
 drivers/net/phy/mdio_bus.c    | 31 ++-----------------------------
 drivers/net/phy/mdio_device.c | 27 +++++++++++++++++++++++++++
 include/linux/mdio.h          |  2 ++
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 435424113..1ac942102 100644
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
@@ -68,11 +41,11 @@ int mdiobus_register_device(struct mdio_device *mdiodev)
 		return -EBUSY;
 
 	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
-		err = mdiobus_register_gpiod(mdiodev);
+		err = mdio_device_register_gpiod(mdiodev);
 		if (err)
 			return err;
 
-		err = mdiobus_register_reset(mdiodev);
+		err = mdio_device_register_reset(mdiodev);
 		if (err) {
 			gpiod_put(mdiodev->reset_gpio);
 			mdiodev->reset_gpio = NULL;
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index f64176e0e..5a78d8624 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -118,6 +118,33 @@ void mdio_device_remove(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL(mdio_device_remove);
 
+int mdio_device_register_gpiod(struct mdio_device *mdiodev)
+{
+	/* Deassert the optional reset signal */
+	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
+						 "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(mdiodev->reset_gpio))
+		return PTR_ERR(mdiodev->reset_gpio);
+
+	if (mdiodev->reset_gpio)
+		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
+
+	return 0;
+}
+
+int mdio_device_register_reset(struct mdio_device *mdiodev)
+{
+	struct reset_control *reset;
+
+	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	mdiodev->reset_ctrl = reset;
+
+	return 0;
+}
+
 void mdio_device_reset(struct mdio_device *mdiodev, int value)
 {
 	unsigned int d;
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 42d6d47e4..1322d2623 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -92,6 +92,8 @@ void mdio_device_free(struct mdio_device *mdiodev);
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr);
 int mdio_device_register(struct mdio_device *mdiodev);
 void mdio_device_remove(struct mdio_device *mdiodev);
+int mdio_device_register_gpiod(struct mdio_device *mdiodev);
+int mdio_device_register_reset(struct mdio_device *mdiodev);
 void mdio_device_reset(struct mdio_device *mdiodev, int value);
 int mdio_driver_register(struct mdio_driver *drv);
 void mdio_driver_unregister(struct mdio_driver *drv);
-- 
2.39.5



