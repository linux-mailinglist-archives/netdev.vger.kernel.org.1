Return-Path: <netdev+bounces-87865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B83D58A4CD8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC754B23167
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B8D5FB92;
	Mon, 15 Apr 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrnIumQh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0A55C902;
	Mon, 15 Apr 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178046; cv=none; b=TglJpdvPm5xyDbvmBEOJYG3KoMASSzmCjo5KtnD7zF0N7Jc1rBCQ3LavHoqnQpf0vzq0cdUxOVV3MoHZSPLDX9GxAyrSJ08XQpcVncFp//rYpinSqm6YGn3fpouD37UuzUScW7jxIE1FBICCGQY9Jv7E3C78BS7cNDrcYy7rN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178046; c=relaxed/simple;
	bh=YqKX4wriXAtnIM/JGv9nvIiRNMzJYkycaNwKhjTmUCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZByiZlPtk4gvVHL/s6bA3I21tvCn2Lt9LKKt6od7tEXRCLxAbaIfDRsm0tGAc8bRTHFNCtIAIffN9eoDVbRFXLN0U7I1/xPp0K1JYcfN+/nub6CNHo+Rr1lCDKDqH2ZGrz5la3bY23OvQZNUGeG/s+GkX3pNHgrzEWBBWlbeJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrnIumQh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e45f339708so5334055ad.0;
        Mon, 15 Apr 2024 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713178044; x=1713782844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuGWEpVupawPMlvYk1r1Gqqq+H/sSkI0jwfxINnsGuc=;
        b=IrnIumQhSgyrAF0KKL+etCs35zEVCWkEBURd4f2+h8aU577OTStWzCa83hyinovxkC
         OX/qVzZA7wdTy6a/ntAlf1Y7mGZj7QddNMrBFBziId/w1+G/7lq+lZymT/T1S5Wwas6K
         nhjQuWTLcnOH9borSlosTBGybumWV5jeU+37WIja4nGyBrIGmVYBTPGM/5HrM+IMNa6f
         2M6jMhwKsPiXiskyaN5eIuQigITj7hZlBh2Q3XV1DOgw73zF8aOywOyumjl4dJzCigul
         FK3tBsZ2o/LyGk9jVDpkTn5QVYv+TtGIRZC7cvI5yG5B1jIOMJD+QUKDRoFfIlQWHjSN
         nNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713178044; x=1713782844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuGWEpVupawPMlvYk1r1Gqqq+H/sSkI0jwfxINnsGuc=;
        b=MXNW7HKpwtRqeiOdwPe4afEktXlZyHfi2jj4qG2KOyL9UChI11ZbAuvqyQV6lVDTlN
         JAahgwZYJrQVEfTBwt5KFZMjDOc+NycNX988qwgVmT3xAjBtgQSMS+j8vwEAZfySZwZm
         knsUqQ9RLFpscLffG+N2o4NguGo1HEbM25V1IsfnpiHbR6EVW7oBKiqDOzmPHgdqD8pR
         IOxEVUHoPIdagWMaatFHtd+Vd1BSZkdANykYBZM04C6l92RJc47vezEuwaZYTUjfXIFj
         HFYchBbIRsnocO3GYaRjD+xMXOi7JplMKZf8JVWReyWwUZS3LyASNofU0cweXb4hE1aL
         /L/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMkwJd+LndjMtmDxqoxFix/u8lwRAIP5ZbB57xMgKvMvo+TDm98NSUwtccPrwN5Y6OCDI9t2tHInNn382m+u5qK+A0e6+1baCPLZ+HkTI=
X-Gm-Message-State: AOJu0YwmFTKbRTtaFfHCnAlLqxOg4jiAuWEQ/iVfAIjVod0byveY2Uw9
	2A4+rgrebMZC64rCOE61R8TgFA/1WHmH/kl2cQfG7b9TmIwRARwZ9y2UlA==
X-Google-Smtp-Source: AGHT+IEZ9OSO247b6f+EAz1CmZ+duvAxD9xV+suTGWux3++UqlxWrmm8uT2YgTwrUHkRraRoHRQN9A==
X-Received: by 2002:a17:902:e845:b0:1e0:c887:f93f with SMTP id t5-20020a170902e84500b001e0c887f93fmr12692959plg.1.1713178044490;
        Mon, 15 Apr 2024 03:47:24 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b001e20afa1038sm7807806pln.8.2024.04.15.03.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:47:24 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY driver
Date: Mon, 15 Apr 2024 19:47:01 +0900
Message-Id: <20240415104701.4772-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415104701.4772-1-fujita.tomonori@gmail.com>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver supports Applied Micro Circuits Corporation QT2025 PHY,
based on a driver for Tehuti Networks TN40xx chips.

The original driver for TN40xx chips supports multiple PHY hardware
(AMCC QT2025, TI TLK10232, Aqrate AQR105, and Marvell 88X3120,
88X3310, and MV88E2010). This driver is extracted from the original
driver and modified to a PHY driver in Rust.

This has been tested with Edimax EN-9320SFP+ 10G network adapter.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS               |  7 ++++
 drivers/net/phy/Kconfig   |  6 ++++
 drivers/net/phy/Makefile  |  1 +
 drivers/net/phy/qt2025.rs | 75 +++++++++++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h   |  1 +
 5 files changed, 90 insertions(+)
 create mode 100644 drivers/net/phy/qt2025.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ba3fe6ac09c..f2d86e221ba3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1540,6 +1540,13 @@ F:	Documentation/admin-guide/perf/xgene-pmu.rst
 F:	Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 F:	drivers/perf/xgene_pmu.c
 
+APPLIED MICRO QT2025 PHY DRIVER
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+L:	netdev@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	drivers/net/phy/qt2025.rs
+
 APTINA CAMERA SENSOR PLL
 M:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 3ad04170aa4e..8293c3d14229 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -110,6 +110,12 @@ config ADIN1100_PHY
 	  Currently supports the:
 	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
 
+config AMCC_QT2025_PHY
+	tristate "AMCC QT2025 PHY"
+	depends on RUST_PHYLIB_ABSTRACTIONS
+	help
+	  Adds support for the Applied Micro Circuits Corporation QT2025 PHY.
+
 source "drivers/net/phy/aquantia/Kconfig"
 
 config AX88796B_PHY
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 1d8be374915f..75d0b07a392a 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
+obj-$(CONFIG_AMCC_QT2025_PHY)	+= qt2025.o
 obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
 ifdef CONFIG_AX88796B_RUST_PHY
   obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
new file mode 100644
index 000000000000..e42b77753717
--- /dev/null
+++ b/drivers/net/phy/qt2025.rs
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) Tehuti Networks Ltd.
+// Copyright (C) 2024 FUJITA Tomonori <fujita.tomonori@gmail.com>
+
+//! Applied Micro Circuits Corporation QT2025 PHY driver
+use kernel::c_str;
+use kernel::net::phy::{self, DeviceId, Driver, Firmware};
+use kernel::prelude::*;
+use kernel::uapi;
+
+kernel::module_phy_driver! {
+    drivers: [PhyQT2025],
+    device_table: [
+        DeviceId::new_with_driver::<PhyQT2025>(),
+    ],
+    name: "qt2025_phy",
+    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
+    description: "AMCC QT2025 PHY driver",
+    license: "GPL",
+}
+
+const MDIO_MMD_PMAPMD: u8 = uapi::MDIO_MMD_PMAPMD as u8;
+const MDIO_MMD_PCS: u8 = uapi::MDIO_MMD_PCS as u8;
+const MDIO_MMD_PHYXS: u8 = uapi::MDIO_MMD_PHYXS as u8;
+
+struct PhyQT2025;
+
+#[vtable]
+impl Driver for PhyQT2025 {
+    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
+
+    fn config_init(dev: &mut phy::Device) -> Result<()> {
+        let fw = Firmware::new(c_str!("qt2025-2.0.3.3.fw"), dev)?;
+
+        let phy_id = dev.c45_read(MDIO_MMD_PMAPMD, 0xd001)?;
+        if (phy_id >> 8) & 0xff != 0xb3 {
+            return Ok(());
+        }
+
+        dev.c45_write(MDIO_MMD_PMAPMD, 0xC300, 0x0000)?;
+        dev.c45_write(MDIO_MMD_PMAPMD, 0xC302, 0x4)?;
+        dev.c45_write(MDIO_MMD_PMAPMD, 0xC319, 0x0038)?;
+
+        dev.c45_write(MDIO_MMD_PMAPMD, 0xC31A, 0x0098)?;
+        dev.c45_write(MDIO_MMD_PCS, 0x0026, 0x0E00)?;
+
+        dev.c45_write(MDIO_MMD_PCS, 0x0027, 0x0893)?;
+
+        dev.c45_write(MDIO_MMD_PCS, 0x0028, 0xA528)?;
+        dev.c45_write(MDIO_MMD_PCS, 0x0029, 0x03)?;
+        dev.c45_write(MDIO_MMD_PMAPMD, 0xC30A, 0x06E1)?;
+        dev.c45_write(MDIO_MMD_PMAPMD, 0xC300, 0x0002)?;
+        dev.c45_write(MDIO_MMD_PCS, 0xE854, 0x00C0)?;
+
+        let mut j = 0x8000;
+        let mut a = MDIO_MMD_PCS;
+        for (i, val) in fw.data().iter().enumerate() {
+            if i == 0x4000 {
+                a = MDIO_MMD_PHYXS;
+                j = 0x8000;
+            }
+            dev.c45_write(a, j, (*val).into())?;
+
+            j += 1;
+        }
+        dev.c45_write(MDIO_MMD_PCS, 0xe854, 0x0040)?;
+
+        Ok(())
+    }
+
+    fn read_status(dev: &mut phy::Device) -> Result<u16> {
+        dev.genphy_c45_read_status()
+    }
+}
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 08f5e9334c9e..76d3f103e764 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -7,5 +7,6 @@
  */
 
 #include <uapi/asm-generic/ioctl.h>
+#include <uapi/linux/mdio.h>
 #include <uapi/linux/mii.h>
 #include <uapi/linux/ethtool.h>
-- 
2.34.1


