Return-Path: <netdev+bounces-124414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF36969583
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FAD281DFE
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CD920FA94;
	Tue,  3 Sep 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgB2kYa0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699F20FAA2;
	Tue,  3 Sep 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348600; cv=none; b=kMCevz0K/NgM6pHMWiR4nfTM8H5d5oietRdcVEQDwZ3MmmX+h1C5RAhgfx8Fm9RKH5WvICA1MHd/Miv+ku8pB2CFXrRRRaNJxceL8Py6gJAucEVRvwk+TiAtvkiJBdfufUWIE4DksvrbsSi7P9D33uBW6KI2wL4aJkROlozlhFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348600; c=relaxed/simple;
	bh=/6H4IU973IO6TgpB/G8XUuZGnmFoco06T05GdXJMYaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcWsg2emh3b0uyK9dz+y66IcNrWjjlvBjS1APe7BRApEIx1kwbTUtFn3wYCJ+y985UOxjBdXBDX1cxYCeYuVyuP6jSu5KM0h2L6HkXmYhEo+AL84snZN+Cw967jzMld1SI4LTNKzjaCUXjrkF03e8YC8+dEp5qcgCcXrvVd0Ujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgB2kYa0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f4f2868783so50657851fa.2;
        Tue, 03 Sep 2024 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348597; x=1725953397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/s5UIjM7KSzyHuEgLitrhtOgHz57a+MvR086mNaSGN8=;
        b=jgB2kYa0CCKelvLBLUnITHhBPlQPXPnof8BbwoJ7/m7V8Zaiy4SeJEND/ThyBcDpKx
         IoD550peVKaeWVHjXbEFb+fMhALH8zZqAv1gsXxhd4pgN2ywci/XcbLzc3v+ocmy1J3j
         2Ove32rcb/MRUTQBCoENzHbIUghSH1yZIC2FzrcRADshLQw10+jhNSrfxn3jJc6Xc9/5
         rT6XTZavO6YCrXdjv/zviMLCHy82+Wm697NFqoYluTfdjJWSEOY4HeqenT4HSzdjgLN4
         IPd3PFJGzIC0ETFl2JDBmQZCGmM/1LwwWcr6825aq3gkEfRIgaRsF6KfM+XR65zzsa+Q
         aPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348597; x=1725953397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/s5UIjM7KSzyHuEgLitrhtOgHz57a+MvR086mNaSGN8=;
        b=KOcokbB0GCF6gzCgdcQI3tmhtXsp/REE77lsicg+K0vJ8OE6PLV71oh7E9dK9RJ4lJ
         Tq8zlYITrbxFVbjs2KiafvfCg2XEWGfpdYoOgvUC46cgj6RmmQKrbmOKoAeY46u5kN96
         woInxWynH5iWr8tVbTBu6ZlhkFjzxcy49fL7yG7yVL7V3LBlH5jUTpNpY+NRsQRssNID
         bChKnqMzBk9jR/l1t002/ALRidNGjc9nuGKAv5sSRunqB+2fcyd8tL/A44VH28VA5INC
         vylpKQZ4YNxq8uiyavBnKfipp0NdsYAUS3otcR8kWw08wLQJ4Ecrg+Yb/AfpXyrVXxJV
         IpBw==
X-Forwarded-Encrypted: i=1; AJvYcCXmH+9ch+YyAJuVwFeEz3F0JFPBOqnGux/IzyTvIoUBhvvogjP7RfmZWPxM5jL43kfdAN5jpwLR+3ErKh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyewIuP/CM8ZNi9riatrq/gbA0qfTjbIK7sMx+qqAUBw6tDUPvM
	JZDf9zi065sHnejSy5rqGpan2AjNW0Cw47gSaX5WmEotAV4cAlkm
X-Google-Smtp-Source: AGHT+IH/gVUhVxRZeifWpAvRYtHairEGB7RdWWjoxFvl/+cxyhJLmC9WVXaMJSS6RDSHeLI6d/Y6ZQ==
X-Received: by 2002:a2e:be91:0:b0:2ee:8db7:47b7 with SMTP id 38308e7fff4ca-2f6254e9ab3mr67149161fa.26.1725348596480;
        Tue, 03 Sep 2024 00:29:56 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a37asm6121947a12.1.2024.09.03.00.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:29:56 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Arun.Ramadoss@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristram.Ha@microchip.com,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v3 1/3] net: dsa: microchip: rename ksz8 series files
Date: Tue,  3 Sep 2024 09:29:37 +0200
Message-ID: <20240903072946.344507-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903072946.344507-1-vtpieter@gmail.com>
References: <20240903072946.344507-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

The first KSZ8 series implementation was done for a KSZ8795 device but
since several other KSZ8 devices have been added. Rename these files
to adhere to the ksz8 naming convention as already used in most
functions and the existing ksz8.h; add an explanatory note.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/Kconfig                     |  9 ++++++---
 drivers/net/dsa/microchip/Makefile                    |  2 +-
 drivers/net/dsa/microchip/{ksz8795.c => ksz8.c}       | 11 +++++++++--
 .../net/dsa/microchip/{ksz8795_reg.h => ksz8_reg.h}   | 11 ++++++++---
 4 files changed, 24 insertions(+), 9 deletions(-)
 rename drivers/net/dsa/microchip/{ksz8795.c => ksz8.c} (99%)
 rename drivers/net/dsa/microchip/{ksz8795_reg.h => ksz8_reg.h} (98%)

diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchip/Kconfig
index c1b906c05a02..64ca6217b91f 100644
--- a/drivers/net/dsa/microchip/Kconfig
+++ b/drivers/net/dsa/microchip/Kconfig
@@ -1,14 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
-	tristate "Microchip KSZ8795/KSZ9477/LAN937x series switch support"
+	tristate "Microchip KSZ8XXX/KSZ9XXX/LAN937X series switch support"
 	depends on NET_DSA
 	select NET_DSA_TAG_KSZ
 	select NET_DSA_TAG_NONE
 	select NET_IEEE8021Q_HELPERS
 	select DCB
 	help
-	  This driver adds support for Microchip KSZ9477 series switch and
-	  KSZ8795/KSZ88x3 switch chips.
+	  This driver adds support for Microchip KSZ8, KSZ9 and
+	  LAN937X series switch chips, being KSZ8863/8873,
+	  KSZ8895/8864, KSZ8794/8795/8765,
+	  KSZ9477/9896/9897/9893/9563/9567, KSZ9893/9563/8563 and
+	  LAN9370/9371/9372/9373/9374.
 
 config NET_DSA_MICROCHIP_KSZ9477_I2C
 	tristate "KSZ series I2C connected switch driver"
diff --git a/drivers/net/dsa/microchip/Makefile b/drivers/net/dsa/microchip/Makefile
index 1cfba1ec9355..9347cfb3d0b5 100644
--- a/drivers/net/dsa/microchip/Makefile
+++ b/drivers/net/dsa/microchip/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON)	+= ksz_switch.o
 ksz_switch-objs := ksz_common.o ksz_dcb.o
 ksz_switch-objs += ksz9477.o ksz9477_acl.o ksz9477_tc_flower.o
-ksz_switch-objs += ksz8795.o
+ksz_switch-objs += ksz8.o
 ksz_switch-objs += lan937x_main.o
 
 ifdef CONFIG_NET_DSA_MICROCHIP_KSZ_PTP
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8.c
similarity index 99%
rename from drivers/net/dsa/microchip/ksz8795.c
rename to drivers/net/dsa/microchip/ksz8.c
index aa09d89debf0..7af3c0853505 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1,6 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Microchip KSZ8795 switch driver
+ * Microchip KSZ8XXX series switch driver
+ *
+ * It supports the following switches:
+ * - KSZ8863, KSZ8873 aka KSZ88X3
+ * - KSZ8895, KSZ8864 aka KSZ8895 family
+ * - KSZ8794, KSZ8795, KSZ8765 aka KSZ87XX
+ * Note that it does NOT support:
+ * - KSZ8563, KSZ8567 - see KSZ9477 driver
  *
  * Copyright (C) 2017 Microchip Technology Inc.
  *	Tristram Ha <Tristram.Ha@microchip.com>
@@ -23,7 +30,7 @@
 #include <linux/phylink.h>
 
 #include "ksz_common.h"
-#include "ksz8795_reg.h"
+#include "ksz8_reg.h"
 #include "ksz8.h"
 
 static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
similarity index 98%
rename from drivers/net/dsa/microchip/ksz8795_reg.h
rename to drivers/net/dsa/microchip/ksz8_reg.h
index 69566a5d9cda..ff264d57594f 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -1,13 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Microchip KSZ8795 register definitions
+ * Microchip KSZ8XXX series register definitions
+ *
+ * The base for these definitions is KSZ8795 but unless indicated
+ * differently by their prefix, they apply to all KSZ8 series
+ * devices. Registers and masks that do change are defined in
+ * dedicated structures in ksz_common.c.
  *
  * Copyright (c) 2017 Microchip Technology Inc.
  *	Tristram Ha <Tristram.Ha@microchip.com>
  */
 
-#ifndef __KSZ8795_REG_H
-#define __KSZ8795_REG_H
+#ifndef __KSZ8_REG_H
+#define __KSZ8_REG_H
 
 #define KS_PORT_M			0x1F
 
-- 
2.43.0


