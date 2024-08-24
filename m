Return-Path: <netdev+bounces-121561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1C795DA83
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 04:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8382C284716
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3AA381AA;
	Sat, 24 Aug 2024 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rze33Ju4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB737703;
	Sat, 24 Aug 2024 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465327; cv=none; b=HGdnjDk8eVET4CYvAuNPJEeKUTISJtKl/QMJ2BEc3c/B0HbRcU5Ls8bvbQZyOBM8AWx7KjwtpeVx6bGcUQDscLEIFnH8kN13dhPONy6zMma2cOWxyHjMacAwzR2cZlFzli2Pm32Rw5isE2YwegyWT7+sk83jCjYAgGmZ2tL3yF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465327; c=relaxed/simple;
	bh=mQ8aREftwLM2oDkaN3pSIUQfWEh3U+4Dr3jAuUi3ufM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPN5F6z3srPfEh+p7teeOcgIk7BxFUuBEUHwdADLWSNPexV1vELNX03nbgqcMPlJOTNGZPpbsQPzn/O/ZxjYaHB5QFsb/87FRMYjp1ZKLYRC6B9dU1Yak8v7KG1uOjVhA42z/G2RIr3WedFnVzf54LUw3zKcoPFagMZiSSxTcMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rze33Ju4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20231aa8908so22444075ad.0;
        Fri, 23 Aug 2024 19:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724465325; x=1725070125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAh1k/0KTc47RoNgrauNAFLnTbW0bmkOhgMjgVAFa2Y=;
        b=Rze33Ju4imlQZcYdDDYDuC+baCWEhE1VwFAeqeMuNp/XEX1z0fkt0Xm3buZGdNX3tG
         Qo+EzmNKv6EwGxw8Mhok8Ul5PSS5C8NqK4eThig+ZU5ShyQqT7ad7F1q8PsZjOL9Friq
         ba1HUgt4RBDmfg7LYqGXryIGBgBFms7QaU6rwd/N5BjqX49v2wlGl1KuerY1dlqm5CtS
         ebzlVwZeaVjPlOJ8FDyir5xo8NBy6mxZvw9CDFQQKgY66IPWaK3+TOfisam+qd6Tj1Jw
         CJSSMkl/oTz+q+YSf1cssM3ix4Nmi5uB2F4tBnZ1xu+BRyM/TqdSg31HEci9jCtCZ8BQ
         P2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465325; x=1725070125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAh1k/0KTc47RoNgrauNAFLnTbW0bmkOhgMjgVAFa2Y=;
        b=n3J5fuPQbD2X8aQibrJ3hyNWdSQwVbBqKyuJiUvNOgOn8TBFOZc6TPw5YlFNrqhA48
         GJ73ez2qOillATFvtLG0saFayMxQCUYayx+M16xEolWC4e2JFzEOYIjkeVO5OLm4iEMs
         HklnB38MmU7ADaf8IySYslPbrxnb3Nj0CbHBvGkrFilvJ0sRE5Y3nO069K59IFH9UA9d
         LBc6cTxXpmXge2LYu/zCpk0RrHHiYoxVuVySUo247vUDPPnYPHHECxGujifCiDvVuj+5
         0XGvL13s2YW+ZTSrhVwcZv+YQzw1xrPReAP7gFCmH66VRYkfDW88XKvcGg9L8ozW+yt0
         1ArQ==
X-Gm-Message-State: AOJu0Yyskbj7WJ2sc1ycrfA7sVvrlYkGly1iuQ/uWcSR2Cd+VIujZmET
	i/5QGg+/wlr7QQQWdTHR/9xFzbYCOvkGsMoFcyvKMDoqlpJ2tNGEyPBovDfR
X-Google-Smtp-Source: AGHT+IGr69KD1z4J1CLNJa0ESA1o84OT8PbgZbd+jL6NZRI3YIf+IssJ3yW8y5mdJBLqhAvAzGr3sg==
X-Received: by 2002:a17:902:e801:b0:1fb:6294:2e35 with SMTP id d9443c01a7336-2039e5598c7mr52029295ad.50.1724465324748;
        Fri, 23 Aug 2024 19:08:44 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855809d4sm34393875ad.95.2024.08.23.19.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 19:08:44 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v7 6/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Sat, 24 Aug 2024 02:06:16 +0000
Message-ID: <20240824020617.113828-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824020617.113828-1-fujita.tomonori@gmail.com>
References: <20240824020617.113828-1-fujita.tomonori@gmail.com>
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

Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS               |   8 +++
 drivers/net/phy/Kconfig   |   7 +++
 drivers/net/phy/Makefile  |   1 +
 drivers/net/phy/qt2025.rs | 103 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 drivers/net/phy/qt2025.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index eb787b5d5612..c5d617bc2c81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1609,6 +1609,14 @@ F:	Documentation/admin-guide/perf/xgene-pmu.rst
 F:	Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 F:	drivers/perf/xgene_pmu.c
 
+APPLIED MICRO QT2025 PHY DRIVER
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+R:	Trevor Gross <tmgross@umich.edu>
+L:	netdev@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	drivers/net/phy/qt2025.rs
+
 APTINA CAMERA SENSOR PLL
 M:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index f530fcd092fe..01b235b3bb7e 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -112,6 +112,13 @@ config ADIN1100_PHY
 	  Currently supports the:
 	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
 
+config AMCC_QT2025_PHY
+	tristate "AMCC QT2025 PHY"
+	depends on RUST_PHYLIB_ABSTRACTIONS
+	depends on RUST_FW_LOADER_ABSTRACTIONS
+	help
+	  Adds support for the Applied Micro Circuits Corporation QT2025 PHY.
+
 source "drivers/net/phy/aquantia/Kconfig"
 
 config AX88796B_PHY
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 33adb3df5f64..90f886844381 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
+obj-$(CONFIG_AMCC_QT2025_PHY)	+= qt2025.o
 obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
 ifdef CONFIG_AX88796B_RUST_PHY
   obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
new file mode 100644
index 000000000000..28d8981f410b
--- /dev/null
+++ b/drivers/net/phy/qt2025.rs
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) Tehuti Networks Ltd.
+// Copyright (C) 2024 FUJITA Tomonori <fujita.tomonori@gmail.com>
+
+//! Applied Micro Circuits Corporation QT2025 PHY driver
+//!
+//! This driver is based on the vendor driver `QT2025_phy.c`. This source
+//! and firmware can be downloaded on the EN-9320SFP+ support site.
+//!
+//! The QT2025 PHY integrates an Intel 8051 micro-controller.
+
+use kernel::c_str;
+use kernel::error::code;
+use kernel::firmware::Firmware;
+use kernel::net::phy::{
+    self,
+    reg::{Mmd, C45},
+    DeviceId, Driver,
+};
+use kernel::prelude::*;
+use kernel::sizes::{SZ_16K, SZ_8K};
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
+    firmware: ["qt2025-2.0.3.3.fw"],
+}
+
+struct PhyQT2025;
+
+#[vtable]
+impl Driver for PhyQT2025 {
+    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043a400);
+
+    fn probe(dev: &mut phy::Device) -> Result<()> {
+        // Check the hardware revision code.
+        // Only 0x3b works with this driver and firmware.
+        let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
+        if (hw_rev >> 8) != 0xb3 {
+            return Err(code::ENODEV);
+        }
+
+        // `MICRO_RESETN`: hold the micro-controller in reset while configuring.
+        dev.write(C45::new(Mmd::PMAPMD, 0xc300), 0x0000)?;
+        // `SREFCLK_FREQ`: configure clock frequency of the micro-controller.
+        dev.write(C45::new(Mmd::PMAPMD, 0xc302), 0x0004)?;
+        // Non loopback mode.
+        dev.write(C45::new(Mmd::PMAPMD, 0xc319), 0x0038)?;
+        // `CUS_LAN_WAN_CONFIG`: select between LAN and WAN (WIS) mode.
+        dev.write(C45::new(Mmd::PMAPMD, 0xc31a), 0x0098)?;
+        // The following writes use standardized registers (3.38 through
+        // 3.41 5/10/25GBASE-R PCS test pattern seed B) for something else.
+        // We don't know what.
+        dev.write(C45::new(Mmd::PCS, 0x0026), 0x0e00)?;
+        dev.write(C45::new(Mmd::PCS, 0x0027), 0x0893)?;
+        dev.write(C45::new(Mmd::PCS, 0x0028), 0xa528)?;
+        dev.write(C45::new(Mmd::PCS, 0x0029), 0x0003)?;
+        // Configure transmit and recovered clock.
+        dev.write(C45::new(Mmd::PMAPMD, 0xa30a), 0x06e1)?;
+        // `MICRO_RESETN`: release the micro-controller from the reset state.
+        dev.write(C45::new(Mmd::PMAPMD, 0xc300), 0x0002)?;
+        // The micro-controller will start running from the boot ROM.
+        dev.write(C45::new(Mmd::PCS, 0xe854), 0x00c0)?;
+
+        let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
+        if fw.data().len() > SZ_16K + SZ_8K {
+            return Err(code::EFBIG);
+        }
+
+        // The 24kB of program memory space is accessible by MDIO.
+        // The first 16kB of memory is located in the address range 3.8000h - 3.BFFFh.
+        // The next 8kB of memory is located at 4.8000h - 4.9FFFh.
+        let mut dst_offset = 0;
+        let mut dst_mmd = Mmd::PCS;
+        for (src_idx, val) in fw.data().iter().enumerate() {
+            if src_idx == SZ_16K {
+                // Start writing to the next register with no offset
+                dst_offset = 0;
+                dst_mmd = Mmd::PHYXS;
+            }
+
+            dev.write(C45::new(dst_mmd, 0x8000 + dst_offset), (*val).into())?;
+
+            dst_offset += 1;
+        }
+        // The micro-controller will start running from SRAM.
+        dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
+
+        // TODO: sleep here until the hw becomes ready.
+        Ok(())
+    }
+
+    fn read_status(dev: &mut phy::Device) -> Result<u16> {
+        dev.genphy_read_status::<C45>()
+    }
+}
-- 
2.34.1


