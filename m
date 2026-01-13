Return-Path: <netdev+bounces-249406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1F4D17FFF
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4F63014D97
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC963876D1;
	Tue, 13 Jan 2026 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qh2IkMS9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EBF3446CC
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300023; cv=none; b=Auh/E2Z7BdEozkyIg7u39Nc3cZCKGWN2yKDoAL/mGixy1sBl2D0GgIDVqKTFyehRcNY+pQq8zAfaCfNRNkh9UVcEd5vlji3sfCvVmBygL1ExsON085k457YT+Qvcn9uY5pGeRpftxan3V0rWl8ZvNOaRzjLkm773tH5Gnt4wAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300023; c=relaxed/simple;
	bh=o+nhYXWfd2zUEo4WHOw2AX4PEwxHY0tWx9PSX+0A1QM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rknhZV0DErldK8Z0xIfYwZoaMu1xJQyV8B6ltHGYs50bI541Oggr23PR01OyvAMduYsXMZX8Hl7PE9e92Cb+DXO6+CT+zkzseVqDwnI0A+tVatCFPEb1vYRrzI/dVskP4dDPMEKn/sRb2ejYMZNQEd7SgjSiSU1/FViiEwVx6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qh2IkMS9; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so54439965e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768300008; x=1768904808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJpIuelX4DquNfRDlO2MRonQeXm4YP1X8f+1rZWzezQ=;
        b=Qh2IkMS94JQ3ryTsDa/EE0dqR8PrGwbAVHfvnXW4gYs0XFPdlbSTIO2Ww95wApt5WO
         9RWwCV6vBtZKOaRQn3+LFOJuGLrAC15nMYx0WH7EVjZLCZxlen40+kFvhOxRdbA6Eo2x
         jxcP1FOaeTEoe7RnlIbv0n07DCi2DjU1EGDJQzUlYCjJvpGFofWgKifF/gMsG70tkr/c
         cc/mLbBT0Cr3CV2aJ7a5r4P+YeAI5Drwh8O46TSF+FijDXlwJkTW5bE5n2vvPjoMFbd7
         txKbi17n/dvE3ezNb+2w612e2VqZhB0kQcGR/Debqnd51dWOO++p93YsZKRG+mUACDn/
         MOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300008; x=1768904808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJpIuelX4DquNfRDlO2MRonQeXm4YP1X8f+1rZWzezQ=;
        b=NtrMPGQgYOaEoqi5cBS3Sj8gUsPaWdRs0Hw4qP5oHePEZC7pbN+idp8DsWsh5pPrbK
         BdxjZSK+3ehhWM3m7+vDlcQNIzIvRJuRdUuS/vcdWg33TI21DaDLg/qiMgY7tdiJvEpw
         wsbRMKFQc/TqMoe/l6pkSMGfC7OorzQ1GiQEPgl1jsZt1yO1fQoT7WiLgDyTCAFHDX0g
         TS7TZhl9XgAK1Wju5MYpi2k57rv45YSylRxsLs5IIpoaBRqdOyRQKELak3EjJygUFRva
         v4vsaNeYNvKLxIHeW5bc59x6XiDqAzB655/KZQTHNfp0HVvRmg/CnOwanrTYBcHznoVS
         2ZPw==
X-Forwarded-Encrypted: i=1; AJvYcCWDOTMULSnAb6MyZ7icAfp92c2aVqMAdT69GEF1a0bvibOv8uX3iXE0f/NLgOvYyAJWQUHt9ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4LV+onOoWBvENFkwUzeTBQ2G0fCOVIp8RucdOm3YvB9en6/I
	OFPxMdDOZdnUytthxTWF5bnUdIgB9WhdmbqbV2Sfog/I9DoSpqE5j/iFOQ4Lld51lnA=
X-Gm-Gg: AY/fxX5zjsoIZewg7QFu8RvIxBxm4xju0h4igN4ly9zIB8PO2K7K5WFzoxyqePWKhQZ
	Q8UbM+xEgtERES0OzCLWrVPltm/QuS2f9IN/FFpn680dfZwy6SDGWI0YxU92Di7TPcRPo8/3s78
	8qPsMJWdiftOK2pvATOguO6LEqTL5Fqvqw7HuOX01hM3T9VX9UhZkur1NkEZpUvEDvy4Zl+akQC
	L8BVeZGvD1r9XSl+KzOJPmhMA5PE6XDzbYD910zRrZOMIliu0z7dlRHfdFruqcBTurZZxXFqz7K
	MgjqvzvXvb6+N7jjDpoie9pllS0QvEdwzRkxYeBHEeAwlPtXaHPzf+1Nz4ibreI+BF2wcnGdycP
	ajcCVjGbdXWX3RxQzjMXHaj+Nvz8rJHBR4DBzkIfh8Hvjcu67zobRdb9TXt0Cd3jB7ABJr8Ogw6
	k2/1WM3he+DWZcInegwVC9Uf2/XM3whm38JRjn2gSEhFj9DmyE5XmJYyN4BB+jqP3pzCve17mNR
	j0=
X-Google-Smtp-Source: AGHT+IEbuGfxR1p+fJkXnK5yMjdSzOLHQPwM0s2lDSS9iAv4s1cNcdunRAz8eOOXng88PZ0TPbmktQ==
X-Received: by 2002:a05:600c:3146:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-47d84b3b513mr230348565e9.28.1768300008248;
        Tue, 13 Jan 2026 02:26:48 -0800 (PST)
Received: from localhost (p200300f65f20eb04dea93da528314008.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:dea9:3da5:2831:4008])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47d7f653cd6sm419605875e9.9.2026.01.13.02.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:26:47 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH RESEND net-next] mdio: Make use of bus callbacks
Date: Tue, 13 Jan 2026 11:26:36 +0100
Message-ID: <20260113102636.3822825-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5300; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=o+nhYXWfd2zUEo4WHOw2AX4PEwxHY0tWx9PSX+0A1QM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpZh3cGmq7KsYLP3L7xoFJNIcvku+GENb/4QHz4 G0fOl0lH5KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaWYd3AAKCRCPgPtYfRL+ TqaWB/4o0IDIzkvxy7ETn9/nEP/UQvF+6EhhhB5BSGR8kfLp+GOcqFuaf0rIL4oK8BpwuJPS81S V0z6BiJD9+eTSt3bFwpDuHkwlkTU49vv9Q+HNnNZ2oyFNSbye7CozImV6yn03b/EePKZzrudwIM ZBCNn4kL2jkEwvWe64uLgEuOXgRilyUq62GuLawJhutHhTCFzEycp4UlXENMdVp/bMK1znO22U7 PfheoHxJ6KUjbHkjGWwOXNi9n+deDnX6hmtDfBMCpjBbwjThCs72KKaUFy/GnHfXArxDSjgQY0S 4iUmg0+58NYsZA0R91ABO9NE49ARc9+6WIwS4AgUtNdP1FOD
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Introduce a bus specific probe, remove and shutdown function.

The objective is to get rid of users of struct device_driver callbacks
.probe(), .remove() and .shutdown() to eventually remove these.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

it seems I misunderstood when net-next opens, I thought this happens
"automatically" after an -rc1 is tagged and thus delayed the original
submission
(https://lore.kernel.org/netdev/20251216070333.2452582-2-u.kleine-koenig@baylibre.com/)
only until after v6.19-rc1 was tagged. Anyhow, I got a form letter in
reply that net-next was still closed and thus here comes the requested
resend.

I based this patch on top of v6.19-rc1 for my own tracking of similar
patches for other subsystems but it applies fine to net-next/main
(de746f8f53410a0e31d8e5d145745332ee77d321), too.

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


