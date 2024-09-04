Return-Path: <netdev+bounces-124830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BCE96B18F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA381C216A1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D113A25F;
	Wed,  4 Sep 2024 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXGOKLqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81979139579;
	Wed,  4 Sep 2024 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431280; cv=none; b=cF1utsBy+gs4V5bXOD6GXcdOfMgyiGClMQ4vbNu5f50jLjph7FskbKbsy9hHTXSFylja3hmKwqkyHESlpElsdSiV8huOfGuIynPlUsM2hBlkyeFGrlhrpyAPwFZePs1cwW7WM0GqJ3V91A0Wg4VrgnnIkT/Gw4PBkpDaW2LNEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431280; c=relaxed/simple;
	bh=obA9dxpCUGQxT2WkHqZCk0H6H19Rw8sW7aLJIxK8DBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZpozY6Sk4QqjwMChqTk6ZVRna15EGsKxWtsXait0BO4bMGh9dSYJse8TAATYe6qbtawJNe4Jk8XGdlkoCZMvq6cfGQjmaAYPUgSJn9885dVNVVAeoyu6yKILnLCqWp+H8nvHSZni/SYoJj6qcurhdyixqyOgEE4qDqx7Jd45iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXGOKLqz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86abbd68ffso69202566b.0;
        Tue, 03 Sep 2024 23:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725431277; x=1726036077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6i3Km+inX9EWUYXQA5l7QVIM9SmXTJ4vnExYfHEiFc=;
        b=nXGOKLqz3CvUlprM5G8g+UMSLK6bHYJCChUz7UNtYFeMMhCF1h2WjkUIMRDQgKcbC+
         3Ht/GVly06CZIU7bPYqklaQcovi8e3w0dd3MWZYrrpTwNVMGI2S1mYts4Da9pb9MCJtf
         8xsgHS3wpbJaD4aWDQD1pQGQWeHbw4OtnhVlshvdG+Jz8kmzfvinl4CxppDY0rfULf9B
         STMDjvvBWMDdglEXyFFHHeG2MgNIdaDMGiZ/ZzyXnQPOEc68BJmcJ8rcsrjzBXcxRR3g
         1m91Fzz5+ieCRUMTAM0+F2FGatGlf37d4qKz4rBszy7DtY335s5ql2MY//PZFEGeIDWV
         9PyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725431277; x=1726036077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6i3Km+inX9EWUYXQA5l7QVIM9SmXTJ4vnExYfHEiFc=;
        b=EPU50s1WspG/85l/JBkAWae3WMZVxWPkalXmmIh8vf8xn4OX3S3FiSV1sbfe+OPxXN
         +ljAoJBK/WY031pWEQ5Gg19khC09Q9HZeHMA0HGm9gBNWrbBJIA/zDA0Y++7FdxWxRcJ
         119glKowdHJ1haNu5poD6f3lKzTWbyWEk+hOi1Zw7K0wKPuBANwLr2hJd1diDsYa1uyJ
         ZRrm88Dum1XyADvFX7jzkp0lx/kqiSRRDqOBbpbMypuQEGHraJkZXH/MOzNh6BQtPhO9
         E+WkpwaB3hBHwaZe6wgZpZ3s3ThpVkpKuYWjoVddzhcgFif9Y+9SWJFkjVMIFcRGQRoK
         PvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFAzxTtr39IClNQwokvaRdF4S7JSO0Vrtxz40kupaWN87byoff7LOGIUSxlevoq2RnPl6o9ujTX3IiwJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjUbccz38pKEiu9lcthPUqRCvNEfg/RlRk7cHnfJxxhrYQOfL
	6TtXVEu17eLGACvYXfU7ks2C2uGBklAFoz/XJX60Edb/DxjwGfQT
X-Google-Smtp-Source: AGHT+IEG0w+o65UONk6K4rdQjzQi03jHVFigLwkEyUHda2O0uSLHCZwdU2wJ2FrxAmw4tph2S1wePw==
X-Received: by 2002:a17:907:3e1f:b0:a7d:a453:dba1 with SMTP id a640c23a62f3a-a8a430ba903mr104411366b.20.1725431276328;
        Tue, 03 Sep 2024 23:27:56 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff0465sm768659666b.29.2024.09.03.23.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 23:27:55 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/3] net: dsa: microchip: rename ksz8 series files
Date: Wed,  4 Sep 2024 08:27:40 +0200
Message-ID: <20240904062749.466124-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904062749.466124-1-vtpieter@gmail.com>
References: <20240904062749.466124-1-vtpieter@gmail.com>
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
index c1b906c05a02..12a86585a77f 100644
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
+	  KSZ9477/9897/9896/9567/8567, KSZ9893/9563/8563 and
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


