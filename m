Return-Path: <netdev+bounces-234629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06368C24CB2
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5261A249CE
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF634678D;
	Fri, 31 Oct 2025 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="nD8yJqjj"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678BC345CCD;
	Fri, 31 Oct 2025 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910356; cv=none; b=L7VZFZpdrNtdx6SeDZzTTo1q76TvPcWlxBCj6EiEOA+6fdWNJCtkEqyfuxcSRhX5L2uw4cgOCUEWJANcwskSjzkiFEAqSRpTePjl7YkuTwzJ/J4JkoUXf1n+i3pb50y+8nq2AxHaMPrAnogQra/ugc8NufSiSkAvCvfvNVGAkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910356; c=relaxed/simple;
	bh=zLXljtxNeGil4tVodSFVJBMMRARpQudfdoCr1hFMJcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaQHK9l1NbyVncEYv5T4Z1CMRjmzEg+M8X7YRvLrKQ5yVocB6WNJSkhuLCrWANLIRQixIWTQNumBKpEAATZzXguTx7Upxool1nsYtf3GkPHbCvXNIDaItmCQh9+DdaA05nAY56LG3mc/VLSUEpjKt1hjuFihp79gUxDo+37Rz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=nD8yJqjj; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1C32FA13FD;
	Fri, 31 Oct 2025 12:32:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=BKpyHjHhRf5ksYaNNHmr
	cZ1RxCByOAimOnmst8sw3sQ=; b=nD8yJqjjd5WKPIzZQZFi7n3oCs1TpHfEZniY
	IMKqG95fKky7CBJcY0sN/UOQBjh1VaJGxUSM0V9f1drKWusAc8PmASi98DT5GQMd
	GlLAiVOjPJzOZk8koBnc9Q7cht6j+gwLqAZJblnkOdL/R86PU6RL87uDmty/fGM0
	Wkr7+5pbakswoZgELqVVhQvYV9h1FVNN6ZWy1/JQQTP40fE2WgvmbRS9uQGeik8W
	BSbeEUxDIwKxE69flnn2HE/j/61QUb83hLjhJxg+HC2o5JaFCPF7laKNP01zHGEg
	2H0yKUIE8dTJJthoJLybCwAOQr4sWR8e3K1Dyio+eVTf8sIJMOKrf2aPQK5mdydk
	oAXvmCFlQFjMxsVWmy22G3yrzrwqNcHJRAxtVHiQayIOD8Z4KcCX0tspKRzKsnGA
	BEZYH8ycxFKmaffy2dNzxeLhPYQCEB/qs8kbbfw/b6rgBnb8e8Zo2uA83RLgQYeJ
	zqPy8DwlBUJ6NhCmD/TYuGwFA89wsR1Sdosr8pPmy9dFTKZN+nvXKlLd4Oh0hwIR
	p4+Kur+YSSD2dnxEI9eGI8UMz7n2D3iI/Fd2ivTzmVHQbHSfbQCJhOwRCp3Ozys7
	1w/XNt0uo7WWEli7nyZYePBOrv2mLNjqQmM0KIqGxBvhQhoTY3M1VzEfSyjX/fLO
	YAQushs=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next 1/3] net: mdio: move device reset functions to mdio_device.c
Date: Fri, 31 Oct 2025 12:32:26 +0100
Message-ID: <809bbe7fd239d17ad55cca12038d4bf30924f126.1761909948.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1761909948.git.buday.csaba@prolan.hu>
References: <cover.1761909948.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761910350;VERSION=8001;MC=2560744196;ID=195342;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677D60

The functions mdiobus_register_gpiod() and mdiobus_register_reset()
handle the mdio device reset initialization, which belong to
mdio_device.c.
Move them from mdio_bus.c to mdio_device.c, and rename them to match
the corresponding source file: mdio_device_register_gpio() and
mdio_device_register_reset().
Remove 'static' qualifiers and declare them in mdio.h.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/phy/mdio_bus.c    | 31 ++-----------------------------
 drivers/net/phy/mdio_device.c | 27 +++++++++++++++++++++++++++
 include/linux/mdio.h          |  2 ++
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index cad6ed3aa..f23298232 100644
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
 		if (err)
 			return err;
 
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



