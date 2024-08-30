Return-Path: <netdev+bounces-123711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5431B9663E4
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799911C23114
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3F1B29C5;
	Fri, 30 Aug 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwJGHyJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28FE1B2523;
	Fri, 30 Aug 2024 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027186; cv=none; b=j2nNGID3HX3t05aL2JeysUbUtya8aCFPBaKCaJn7dpctCvQpVKW8v3aX2GavFPfi9/ev4MVy++I2v1hxycUVkQxTydXPfgJ5NtHYBFlLk1uQD8KYKnEUErVpsSU2aqvYPDa3t4DGE0nZVFwKtvPg0ep4Nhi6Cd6FvCjjo2WYPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027186; c=relaxed/simple;
	bh=Jr/SHWu85IVXqiQ6hm9BN/EjcF6D3jzBg1wxdp42aI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/Z6TPa1EY5s2TPCcXF73T/puhnDpgHPD3mAi8WMLzTXMTQspn25z4Xs+MX2l8Mu+fVm03i6o3ePKI4hpit/BctiUJYCrIGuhwd7P7B04feAjNX0KIubBjtO1yAvsFVTefUW9Uf5FUPqJOfQEOlCHd0XO0R5lwwXOSbMnW86vEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwJGHyJL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86c476f679so226578366b.1;
        Fri, 30 Aug 2024 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725027183; x=1725631983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/YgXqbt2Zgj0SVu5IOkEdQXrR3dWDSz8lQN5ds59FY=;
        b=EwJGHyJLwHkkMQg7Opih5hJ1tnPAq7rluwaVECQ488ID2wd35lOy4CoC2kwgeGYx8D
         BdQKOLrrTQD/NsDqd9ksP7GzjECrwuoxVCLj7LdZ2688C9LapfXWNWvtuvd+r9qGaSyx
         F5rcd4FEmI691G7B53Y5BqH6Q8LI/1n057QowIIgYwqIglLZAINTrqj+WyKO/gMOJAoh
         t1UCfzoMXES3D3YQNjb02UpRlPO1jWWrNbL3EEJ0ZnASmGqBaf6G9zcFQ3JFffpw13Q7
         6A+Brb0cXcGm6myNuaQSCtRvoLdrk00kU9oxoPNF2+1qToOAtW1YocTUkYBtPLF8cmx6
         skIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027183; x=1725631983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/YgXqbt2Zgj0SVu5IOkEdQXrR3dWDSz8lQN5ds59FY=;
        b=NN0OjpKZsUv0OEEin7f5Y0AIaFdrpitEWaEv4SXgC7LNKWrrUVN9ztZwNYs/UD6C+/
         NRk4GdJFHp0knnrY54hqHg9voglB+jbSMyj0+MLpH2YB+RMMnMzbV3ZCHjtner6CuT2c
         ACcbJ8aHO+b/Fsgw3+ala5Qlx1PCLuaGF5iy3mm0lj8/iKwFbOK9oKtfeEtrUN99Whce
         fzATtOZ908G8FIdcWwXVffU6VJTaNc+qjFoyWP32ae1YaV/D6YxeJwRu1B0+8ekiZuJW
         UQ4of3dx3sgehZkFMS9nRywOMeojCbRMOgtM5UBOpJNPG3zFeXDPtgoNBctXYd+6Yoi/
         AOcw==
X-Forwarded-Encrypted: i=1; AJvYcCVme2uSGGu1xhEiBwUKSJsxlYf1fklqthZt7cye4I2QLKDSvlKDYhU3TKBVjL7PbWe/P+UkWNgwgyeMfHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFpR+Lvj9x/Fqfu2KKxaFi4jDII0dX5aHp/r7VQb5nx2hrh+Fg
	HCsInn54HBQgLmGLN3oRN/MA240OoBpfx7teIo/Lny4EPYu0FR2E
X-Google-Smtp-Source: AGHT+IFrMQXsL9pPjuF5Vb/PGJ2dJzl1vjs5EOthZOFACokj/V3TXOUNdfPrho6Im5ma0B/MK0wZiQ==
X-Received: by 2002:a17:907:60c9:b0:a86:851e:3a23 with SMTP id a640c23a62f3a-a897f84bc0emr487941866b.27.1725027182901;
        Fri, 30 Aug 2024 07:13:02 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196975sm221304166b.135.2024.08.30.07.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:13:02 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arun.Ramadoss@microchip.com,
	Tristram.Ha@microchip.com,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v2 1/3] net: dsa: microchip: rename ksz8 series files
Date: Fri, 30 Aug 2024 16:12:41 +0200
Message-ID: <20240830141250.30425-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830141250.30425-1-vtpieter@gmail.com>
References: <20240830141250.30425-1-vtpieter@gmail.com>
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
index c1b906c05a02..d43535c9aa72 100644
--- a/drivers/net/dsa/microchip/Kconfig
+++ b/drivers/net/dsa/microchip/Kconfig
@@ -1,14 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
-	tristate "Microchip KSZ8795/KSZ9477/LAN937x series switch support"
+	tristate "Microchip KSZ8XXX/KSZ9477/LAN937X series switch support"
 	depends on NET_DSA
 	select NET_DSA_TAG_KSZ
 	select NET_DSA_TAG_NONE
 	select NET_IEEE8021Q_HELPERS
 	select DCB
 	help
-	  This driver adds support for Microchip KSZ9477 series switch and
-	  KSZ8795/KSZ88x3 switch chips.
+	  This driver adds support for Microchip KSZ9477 series,
+	  LAN937X series and KSZ8 series switch chips, being
+	  KSZ9477/9896/9897/9893/9563/9567,
+	  LAN9370/9371/9372/9373/9374, KSZ8863/8873, KSZ8895/8864 and
+	  KSZ8794/8795/8765.
 
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


