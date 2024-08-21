Return-Path: <netdev+bounces-120547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C1E959BB5
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DC7286553
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AE8171E69;
	Wed, 21 Aug 2024 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mdKykYtk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1216631D
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243143; cv=none; b=kOUn6SFseNalyoUsZEjlpRM3srd9/STKvKMcTA0RSL19YQAMHi05C9CqlnynthIrOrsncmbAbCOwUeqD26A/9+k7tb9OmW87F50up+FNtd/XDCsfsJPwtZ87okyKrCX67jEmGIFENLdD3fjtzNEBy5G8bcvv24tyBmb5QK65cRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243143; c=relaxed/simple;
	bh=IuNjvKXxc8195sfjF1M7dyMkYLRReEdhi9cSCYqo5PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHHV47wm9QKjK7p4xeW1CsemCj7XFAFRsgv0/3LLP7o7QkHdLxNWXDkM42XYkGZudtUf39SCkRj31Odo6mW6bmEhzGXowr0zYvwkxcW7IzilBnIHhEZFeZ6YyQ/VTtECjqNrSTqWMFr4UUwmG/Rpt+vm7TQlcq+kUow6zxjFwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mdKykYtk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428178fc07eso51397705e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724243140; x=1724847940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQrxaH5KBXicmydrUIJxyHguplR6xyPZC/0ncboBE2g=;
        b=mdKykYtkOZCsbCm54/SuR7SIiEQlNpkUvy6SwRRZ/ZCh3af0bHtlj2DBX3UN467eYK
         IhbS38tET+XdgGtepcHTGJyExr1R9s3g1aAm/aI6VQTvtZeLaamMpLWGsw74l8MH3VXF
         2Ay/oMnI5Kyz7gphO/1YRn8G1C6E0JMuLu3Xg2jASH7KNt0Wq5GFOqlhZ1HBm0IVXzWG
         hbeiCy3vdRHUkafhYgPHrC2UEhFTmkLgqOeXt5nit9t3N8KMCvoVS9KbqSg+blreFK+E
         Qxvsmw+ScnSkg1dLDZ4Nkokr2hhZ6gDzpN3jlzTuUqyi11md3qavFQ/Ot2sgONJoYL6f
         NaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724243140; x=1724847940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQrxaH5KBXicmydrUIJxyHguplR6xyPZC/0ncboBE2g=;
        b=t50FtE0Kin0SG55Ie31wMOSL2qwaRmMCJSXI68WMwW4h5eLF2Otp3bNq3xn0vLF4NR
         CNOo9UAo559WqGiYadVGGRAEFSIivOqoXtTvOlvH/RDvaCc6vQxahVocxwI7OlKObX1a
         EJEcrlz5D2kuTAH3Gt6Qc8vseFEzEjPCGXdevhTG7+2GdfSiX7SFaT3ynBfbt1R4kVF3
         S5k/zpbWWMkmcHfZFiD3AjJIJU//8DRrox82DzS7vDf+iqg2kG9Aq2boSKFidt87aMER
         OWn/xRPFSkfse/Fh8e7Cnz+uJT8aCrIH288j1SSclHSRF6a2jSLfzjw2/s3gcondEKTH
         u1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWC4oTL6gRUp4XXS0cSaw1XM5MN02KRUrEYBec8e/FQGqdPPwIRvRqvLHFGOEcV649hu3n6oe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdu8nssoLd1Ims4iY8mxEGqdSLTIt+UVvUTSMjQlUOm6RfvJMp
	q52eSFWAuaxzegoJ2GoNcROpE24bmY8i/h+3mEQvK+RrusM8LwEWHJqDU86xtd8=
X-Google-Smtp-Source: AGHT+IF+DngRbG/MkFlmUkI81Y79IdOW1Bkw3GNZ4jH12LBBRE9JHgmVvPZayZh4m41c6AWUU0XT3w==
X-Received: by 2002:a05:600c:4fd1:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-42abd21b97amr16269145e9.17.1724243139621;
        Wed, 21 Aug 2024 05:25:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:42a6:b34f:6c18:3851])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeffe43esm23544075e9.44.2024.08.21.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:25:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next] net: mdio-gpio: remove support for platform data
Date: Wed, 21 Aug 2024 14:25:29 +0200
Message-ID: <20240821122530.20529-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no more board files defining platform data for this driver so
remove the header and drop the support.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 MAINTAINERS                             |  1 -
 drivers/net/mdio/mdio-gpio.c            |  7 -------
 include/linux/platform_data/mdio-gpio.h | 14 --------------
 3 files changed, 22 deletions(-)
 delete mode 100644 include/linux/platform_data/mdio-gpio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a7cb909ffa1d..146f4eb95e7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8413,7 +8413,6 @@ F:	include/linux/phy.h
 F:	include/linux/phy_fixed.h
 F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
-F:	include/linux/platform_data/mdio-gpio.h
 F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
index 82088741debd..9e194ebfe7d2 100644
--- a/drivers/net/mdio/mdio-gpio.c
+++ b/drivers/net/mdio/mdio-gpio.c
@@ -23,7 +23,6 @@
 #include <linux/mdio-gpio.h>
 #include <linux/module.h>
 #include <linux/of_mdio.h>
-#include <linux/platform_data/mdio-gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -110,7 +109,6 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
 					  struct mdio_gpio_info *bitbang,
 					  int bus_id)
 {
-	struct mdio_gpio_platform_data *pdata = dev_get_platdata(dev);
 	struct mii_bus *new_bus;
 
 	bitbang->ctrl.ops = &mdio_gpio_ops;
@@ -127,11 +125,6 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
 	else
 		strscpy(new_bus->id, "gpio", sizeof(new_bus->id));
 
-	if (pdata) {
-		new_bus->phy_mask = pdata->phy_mask;
-		new_bus->phy_ignore_ta_mask = pdata->phy_ignore_ta_mask;
-	}
-
 	if (device_is_compatible(dev, "microchip,mdio-smi0")) {
 		bitbang->ctrl.op_c22_read = 0;
 		bitbang->ctrl.op_c22_write = 0;
diff --git a/include/linux/platform_data/mdio-gpio.h b/include/linux/platform_data/mdio-gpio.h
deleted file mode 100644
index 13874fa6e767..000000000000
--- a/include/linux/platform_data/mdio-gpio.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * MDIO-GPIO bus platform data structure
- */
-
-#ifndef __LINUX_MDIO_GPIO_PDATA_H
-#define __LINUX_MDIO_GPIO_PDATA_H
-
-struct mdio_gpio_platform_data {
-	u32 phy_mask;
-	u32 phy_ignore_ta_mask;
-};
-
-#endif /* __LINUX_MDIO_GPIO_PDATA_H */
-- 
2.43.0


