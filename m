Return-Path: <netdev+bounces-244899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85500CC1432
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 08:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1C5D3011FAE
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 07:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1633BBB3;
	Tue, 16 Dec 2025 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e2NQlq4a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C30833B97E
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765868670; cv=none; b=R7tkEed0ehd2M419kavZCxHhUe683zsuQqA32PY0K165MpANOEYau3jHkGM2O0U50rfwzhDRqZvBivKKbM9gZLvHNmxM/ECopt1C5E6sjy/9StSLPQI9o486bgWqpIqo9TLRqeh1hPFK/jqRlHJfwrxh4FcFULOA2lwNqD2Tejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765868670; c=relaxed/simple;
	bh=AQX7yNTtfA9IcqfaIKUHFoG8NTBcZCmjIWuqp46O86s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nz8thWJvNN6JWOLM1gdxA4nrm9SIqqaXxekm+Xy4bbY0HB8vB2b6xbJ4Xwmq2hot6PWza+PSFcblc9VKqw2lVVrDPTDb57ArhpiUiOrGiKg6HhmN7mtUpt/tkS9IsuyMfUtD+u/68iQYm8PifonqFXQzQ0rh5SI/D6kuyW3UdVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e2NQlq4a; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so6591432a12.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 23:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765868659; x=1766473459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz4VfmkbrAVuA0srNqOZBjakq+WXYqKehe7VPiS/fPo=;
        b=e2NQlq4a9RJ8kQ+aOabQN4oDMWlBwKGvXmA2+53ve6o5Br/sWEKT2d/d0xT+nFTRgo
         zxNRZnOQIwintmP7DZ682j0nqf2PN7JWq8gY1NGeU/aISQMQy/RcNANuij38OslDgUws
         MbEZxckl+qQYyLWkQuKvqugS5YJRdGM2z5GD9u5j06PVzCyrKzOeNPRmkUMDmF2COJlW
         W9e1rHVPw3yrz5WK41gbBeP4s2yp0EgE4y5QY/R53n/Iy1uF6EB1GMc/a+UhIJ5CrKlv
         DFmG2h4pc7cN9z/j23XF2OxCreCDVI1IbiudPSWDZd4J6Zhnu3ULLEWRXDC3OAG5D5E1
         UTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765868659; x=1766473459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz4VfmkbrAVuA0srNqOZBjakq+WXYqKehe7VPiS/fPo=;
        b=ez3jRE62QTAkNzcn4o7nCOBWuz+ATFXg0XX8XxO6D9KdLPqHuTuVqukmuB8VK6Mxnj
         drmdxETDs0Lp+W9GpKHNfKYgW1hC6oqNk/qZ2URbm6KeiE/BNJuLWpkqSfdmku+zA2zM
         a3D2t0ZOMhG1reRJTdc4w8qWHI88igKQ7pvEU3MI+QCyNs2NWriZmrY62LcH0t3FRBH4
         d9dpV/Iw5AvIW4Ld6/TYvWlE+ZkjPEUti/7tzrX0Kgr6mywm4BdHITOqv6X0FLiyTBDL
         XoEF+dQAh5J2bwdaZn7/zc55iBTKOoZyTnrrxxeme8J1gUNk65tzmD9F9mYIzO9dKXUT
         RQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAoxXyPEkJq+yV2GiwOuQpQqYaJ7UgqXxhWqqrIxGSN7qNu/DxoaMZZTsVWDpH2zrpcRiQmXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvwa5MedEo3w8e0nfZclLb0fyJGlSZFmRLPkQeida6Fyl6+3N
	N6IOHpVfuI8+LKlv1I9n8mJFLWtDsba6OGLNRomjFQcLt41AMMopoISrbzs2KmON77I=
X-Gm-Gg: AY/fxX5DYk/dCkmF+JJxmGmOl1fpsMU2WDFX07MZ6WZLNxT4dgytaO4pvkTOq0wQ1oN
	mlylnBxpG6ilsye44BgbTQq2lznshM4lnZr7CGimRlxKZ1rGr3fjAa+9g3TcEtbOU5uwg/p6vTE
	NpgOZeSlnq26DRHf1eNJLOqqdVGo+xU1DJZ67/Ty+9VZ2wlFwAKCqBsyXSaTGqWHCDpk3p5wMPC
	wZ2NobbqkBOz34h7FxrpGy0oXlcuuBE/+0l9xOar4weLrgXtyCjyQnnPGqs6Q+iK3j0LVO89RI/
	7PQFFeJQ1sCRr9XkloxiKUeSO0yOssr8zz+PV+QG6ln0UkLt2FfVZ+vdpeNHl94fKX6QHo5xNm2
	JABe6cog2DgLPb1oHX6JIkqRs9uxbtE6Ax9pqLmfFfXQ5wxT91i4JGslLRpvA5v1j2ix9nPpNjo
	By6pSvAvjyD+F72dAk
X-Google-Smtp-Source: AGHT+IEArc3T1cOh6zBIwI+nRqccMTRTLrVOoN65AQA7++LL93GmKCTv1LnqP5dnm2zqrbg0lsgOgw==
X-Received: by 2002:a05:6402:254c:b0:649:d815:d766 with SMTP id 4fb4d7f45d1cf-649d815d7c1mr6080823a12.12.1765868659536;
        Mon, 15 Dec 2025 23:04:19 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64982040b8bsm15336410a12.2.2025.12.15.23.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 23:04:18 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] mdio: Make use of bus callbacks
Date: Tue, 16 Dec 2025 08:03:33 +0100
Message-ID: <20251216070333.2452582-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5029; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=AQX7yNTtfA9IcqfaIKUHFoG8NTBcZCmjIWuqp46O86s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQQRGJts0GD6Vna/0ZoAim0YnWyun6OVZaPCE1 NuJe0oEPaWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUEERgAKCRCPgPtYfRL+ TrYWCACj4HQqx0AKmnogd+wB682HJg7P1ALfaHMf7p9nZQzQxyz38PhN3LPVn+tH7xFby5K5+4S zuPihHLMijXjJV7IuradokowD8A4bZUVkBVvpMypvIQFprqZRrbbfJ7AeTJNSZMK5QD6ZxpECgb MuzXr5ic+kEdsP5mBYnsAH9Era4OaI4lrDOGY8di+S9GwlV46ydwP02Oq3j4XHS7ggV2ABAIOI/ UnralRxFdhc1sNyIWFNi3Kr7nrW2OpnOIdXdWfH1dd3u710uUTWBKSFepdifs13TKn1LduEobfs Z0xmJC3fXQ9bMrGuAhKFAbhqcUr6CUMPtH+HaktVkn+FQH60
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Introduce a bus specific probe, remove and shutdown function.

The objective is to get rid of users of struct device_driver callbacks
.probe(), .remove() and .shutdown() to eventually remove these.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is part of an effort to drop the callbacks in struct device_driver.

The only relevant differences between the driver callbacks and the bus
callbacks is that .remove() returns void for the latter and .shutdown()
is also called for unbound devices (so mdio_bus_shutdown() has to check
for drv != NULL).

Best regards
Uwe

 drivers/net/phy/mdio_bus.c    | 56 +++++++++++++++++++++++++++++++++
 drivers/net/phy/mdio_device.c | 58 -----------------------------------
 2 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index afdf1ad6c0e6..dea67470a7bf 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -1004,11 +1004,67 @@ static const struct attribute_group *mdio_bus_dev_groups[] = {
 	NULL,
 };
 
+/**
+ * mdio_bus_probe - probe an MDIO device
+ * @dev: device to probe
+ *
+ * Description: Take care of setting up the mdio_device structure
+ * and calling the driver to probe the device.
+ *
+ * Return: Zero if successful, negative error code on failure
+ */
+static int mdio_bus_probe(struct device *dev)
+{
+	struct mdio_device *mdiodev = to_mdio_device(dev);
+	struct device_driver *drv = dev->driver;
+	struct mdio_driver *mdiodrv = to_mdio_driver(drv);
+	int err = 0;
+
+	/* Deassert the reset signal */
+	mdio_device_reset(mdiodev, 0);
+
+	if (mdiodrv->probe) {
+		err = mdiodrv->probe(mdiodev);
+		if (err) {
+			/* Assert the reset signal */
+			mdio_device_reset(mdiodev, 1);
+		}
+	}
+
+	return err;
+}
+
+static void mdio_bus_remove(struct device *dev)
+{
+	struct mdio_device *mdiodev = to_mdio_device(dev);
+	struct device_driver *drv = dev->driver;
+	struct mdio_driver *mdiodrv = to_mdio_driver(drv);
+
+	if (mdiodrv->remove)
+		mdiodrv->remove(mdiodev);
+
+	/* Assert the reset signal */
+	mdio_device_reset(mdiodev, 1);
+}
+
+static void mdio_bus_shutdown(struct device *dev)
+{
+	struct mdio_device *mdiodev = to_mdio_device(dev);
+	struct device_driver *drv = dev->driver;
+	struct mdio_driver *mdiodrv = to_mdio_driver(drv);
+
+	if (drv && mdiodrv->shutdown)
+		mdiodrv->shutdown(mdiodev);
+}
+
 const struct bus_type mdio_bus_type = {
 	.name		= "mdio_bus",
 	.dev_groups	= mdio_bus_dev_groups,
 	.match		= mdio_bus_match,
 	.uevent		= mdio_uevent,
+	.probe		= mdio_bus_probe,
+	.remove		= mdio_bus_remove,
+	.shutdown	= mdio_bus_shutdown,
 };
 EXPORT_SYMBOL(mdio_bus_type);
 
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 6e90ed42cd98..29172fa8d0df 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -202,61 +202,6 @@ void mdio_device_reset(struct mdio_device *mdiodev, int value)
 }
 EXPORT_SYMBOL(mdio_device_reset);
 
-/**
- * mdio_probe - probe an MDIO device
- * @dev: device to probe
- *
- * Description: Take care of setting up the mdio_device structure
- * and calling the driver to probe the device.
- *
- * Return: Zero if successful, negative error code on failure
- */
-static int mdio_probe(struct device *dev)
-{
-	struct mdio_device *mdiodev = to_mdio_device(dev);
-	struct device_driver *drv = mdiodev->dev.driver;
-	struct mdio_driver *mdiodrv = to_mdio_driver(drv);
-	int err = 0;
-
-	/* Deassert the reset signal */
-	mdio_device_reset(mdiodev, 0);
-
-	if (mdiodrv->probe) {
-		err = mdiodrv->probe(mdiodev);
-		if (err) {
-			/* Assert the reset signal */
-			mdio_device_reset(mdiodev, 1);
-		}
-	}
-
-	return err;
-}
-
-static int mdio_remove(struct device *dev)
-{
-	struct mdio_device *mdiodev = to_mdio_device(dev);
-	struct device_driver *drv = mdiodev->dev.driver;
-	struct mdio_driver *mdiodrv = to_mdio_driver(drv);
-
-	if (mdiodrv->remove)
-		mdiodrv->remove(mdiodev);
-
-	/* Assert the reset signal */
-	mdio_device_reset(mdiodev, 1);
-
-	return 0;
-}
-
-static void mdio_shutdown(struct device *dev)
-{
-	struct mdio_device *mdiodev = to_mdio_device(dev);
-	struct device_driver *drv = mdiodev->dev.driver;
-	struct mdio_driver *mdiodrv = to_mdio_driver(drv);
-
-	if (mdiodrv->shutdown)
-		mdiodrv->shutdown(mdiodev);
-}
-
 /**
  * mdio_driver_register - register an mdio_driver with the MDIO layer
  * @drv: new mdio_driver to register
@@ -271,9 +216,6 @@ int mdio_driver_register(struct mdio_driver *drv)
 	pr_debug("%s: %s\n", __func__, mdiodrv->driver.name);
 
 	mdiodrv->driver.bus = &mdio_bus_type;
-	mdiodrv->driver.probe = mdio_probe;
-	mdiodrv->driver.remove = mdio_remove;
-	mdiodrv->driver.shutdown = mdio_shutdown;
 
 	retval = driver_register(&mdiodrv->driver);
 	if (retval) {

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3


