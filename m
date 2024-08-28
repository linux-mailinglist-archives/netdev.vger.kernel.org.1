Return-Path: <netdev+bounces-122718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7639624EB
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728411C23688
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC6216C680;
	Wed, 28 Aug 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1/s9HpH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439916BE3A;
	Wed, 28 Aug 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840898; cv=none; b=e5knx5EHoMpyYiBC3+bMW8LhnRB9AMGuLLQ3WeYLVmGBfRmSsMxs73wRv4YscUZ8G13KH37c1hvia64c7AVpSwSKoXCpEhZXX0Hyd+dnmAsNJsAKJJ4JmYniBPVHjlFuXQc2+k34mNVmUbW7laAHiCiS4gbtwBu60WDpLaM4u1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840898; c=relaxed/simple;
	bh=7MDbr5SRZKRWWL5DE3XMzZV8sLe2nje+Dkr6NMsAKZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezlUHhFAwAiKPlhvJD2Xwt6fYJS3/djqcCPnl5EgHEs7fLmVBZhjCgYO6lysrt/AeMxPPotlFwb0DMO69lXEhVCy+KOYFznvNir+Wlt3eI1aNCwPidxfeagL9CKVDfS0UG9erFfHlPCIF/p0aoox6qq96bO8nbqkSJ8jUr/rBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1/s9HpH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53346132348so7860626e87.2;
        Wed, 28 Aug 2024 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724840895; x=1725445695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbppHunX8FXHCvUyFh45kZMaqo4duhbi4bftQL0hHl0=;
        b=W1/s9HpH6CCr86eBu6D1R3eRpwjsxGNZef/zxDA3/gFTvfWAlZJ5ndletcfqeKlHOD
         BKENQ1syasnixd50l2KR8O2kYjYqVKbmkvHPSFwYhZH/LaPTg7xEvycis/J/awOBOrq8
         e5yEivSQtr33CUvJ3nYgzBBVFPSjlX6Yz9hxNmgYVIPk6MXeHn6tmkBRVz9yDFpa5p4o
         AReKniev9/gBksdiN8BRMAuIvKztWD27Z2j7lkxM9gBSxAcJ2+EWdJ+1CNJBrwaK6Ro4
         LFayOL8+NnnhzP1EciAaqTPJoHWlx4tudfI18XEEQSmj1sTmJaPD8EjUL+eWgXiGU7Vz
         EmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724840895; x=1725445695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbppHunX8FXHCvUyFh45kZMaqo4duhbi4bftQL0hHl0=;
        b=XH0Irc5OWoPrXNAneEwiIFBGlUrojvT6818C934DuboRnMVNGDDWPLXzYUXXbzI+eL
         BG+KoVOmuOvnAuMGRoIbPbwx54dOjov12OW2ZaDAhWkJtocB9Ym884Vb84pHIh16hvaG
         /Pa7eagCqi7LgfBX7Ejbl6k938JpDkcF+Jj6J0gxzvuXwbfCdc0EAMgLte3sMnV/y40M
         5xkOiuVgClpS9HbQhRgdoXTA8FL9rhL/X+rKB+toCezPRN5qs6EuPhdAEpXZfySpF90Z
         +zfPuSac9ES2RkvSun/JtGtl4CZ7D6LvFB4Z40IgQ6pU/JEvLCGKYuBfwnv0C2a0nHxe
         vYng==
X-Forwarded-Encrypted: i=1; AJvYcCV0G4gCa92Ps3k3VSwljArj5O/Eoe1buOI2RQ8CGg3uE7xHQ5Flm7h56GYcS2ZxBiJ8pNpBWykmyCNjb/o=@vger.kernel.org, AJvYcCWQsJPFN4HW2KSyFXOy5YNU2YN7OYMe7X9kvNNDRLonGKsNzVh9NeJpPwf9V1GC+/DqijnnH8iC@vger.kernel.org
X-Gm-Message-State: AOJu0YzAkyJf+/URC3oLEbQVMkN0yA0giccWgZZxxNxP7wmwsr3xf7Bn
	JwMOkcZyWdKgHJYU+cBBMEBBecpFn9oDarTDJki8keB7IyZhMLuy
X-Google-Smtp-Source: AGHT+IG9WyRf9uY6/5rOAa6YGl1cUUDkZGEv7xcIR3d9PT2zZJoI9i7zMkgBUN4RMUEeUVKpxfkGRA==
X-Received: by 2002:a05:6512:3986:b0:52e:fefe:49c9 with SMTP id 2adb3069b0e04-53438787371mr10964460e87.36.1724840894220;
        Wed, 28 Aug 2024 03:28:14 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5486264sm226482566b.39.2024.08.28.03.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 03:28:13 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/1] net: dsa: microchip: rename ksz8 series files
Date: Wed, 28 Aug 2024 12:27:56 +0200
Message-ID: <20240828102801.227588-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
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

In addition, remove one last register definition that is already part
of the ksz_common.c register structures.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/Kconfig                   |  4 ++--
 drivers/net/dsa/microchip/Makefile                  |  2 +-
 drivers/net/dsa/microchip/{ksz8795.c => ksz8.c}     |  4 ++--
 .../net/dsa/microchip/{ksz8795_reg.h => ksz8_reg.h} | 13 ++++++++-----
 4 files changed, 13 insertions(+), 10 deletions(-)
 rename drivers/net/dsa/microchip/{ksz8795.c => ksz8.c} (99%)
 rename drivers/net/dsa/microchip/{ksz8795_reg.h => ksz8_reg.h} (98%)

diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchip/Kconfig
index c1b906c05a02..68a91afa9c22 100644
--- a/drivers/net/dsa/microchip/Kconfig
+++ b/drivers/net/dsa/microchip/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
-	tristate "Microchip KSZ8795/KSZ9477/LAN937x series switch support"
+	tristate "Microchip KSZ8xxx/KSZ9477/LAN937x series switch support"
 	depends on NET_DSA
 	select NET_DSA_TAG_KSZ
 	select NET_DSA_TAG_NONE
@@ -8,7 +8,7 @@ menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
 	select DCB
 	help
 	  This driver adds support for Microchip KSZ9477 series switch and
-	  KSZ8795/KSZ88x3 switch chips.
+	  KSZ8xxx e.g. KSZ8795 switch chips.
 
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
index aa09d89debf0..804085f3a0f0 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Microchip KSZ8795 switch driver
+ * Microchip KSZ8XXX series switch driver
  *
  * Copyright (C) 2017 Microchip Technology Inc.
  *	Tristram Ha <Tristram.Ha@microchip.com>
@@ -23,7 +23,7 @@
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
index 69566a5d9cda..b2bc6727cdfb 100644
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
 
@@ -359,8 +364,6 @@
 #define REG_IND_DATA_1			0x77
 #define REG_IND_DATA_0			0x78
 
-#define REG_IND_DATA_PME_EEE_ACL	0xA0
-
 #define REG_INT_STATUS			0x7C
 #define REG_INT_ENABLE			0x7D
 

base-commit: e5899b60f52a7591cfc2a2dec3e83710975117d7
-- 
2.43.0


