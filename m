Return-Path: <netdev+bounces-119521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F99560AF
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F701C21221
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367262941B;
	Mon, 19 Aug 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl+N6kQD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A238DE4;
	Mon, 19 Aug 2024 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029248; cv=none; b=RBc4ByNFIkIWeFOTJFHdFaEU2l00Gx6MBXVB4Bs9isn5+c2WnarfVztkusUIYPdViWIXxj1Jch6MmjLN+5xTUhr8/FrRiwXmolr3h4i2CAD9XZogBmMNnHUwyxnp7HAZLoN8QMYgfdswZTUvpRcK4zwMuxZdFAsM++mxD0QgOWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029248; c=relaxed/simple;
	bh=y2cjxgBXC3a5osoIOO65GeJzqCEOLHSshPNJxJevB4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N43yMGwVTaL4PUuhqj8EiJc/nGzrx+kWvEahZB7Bj+hE3fX9dgUsWQQgFbKqp9UFF0108xVCXXUQ8LUhETslyOxTn5+grmbpAmga8bTpjQm2dmAXgdnHbhxIBYuze5y0CSOAw7J5n6+we+fQdnjFzDlVHbfRiWFC/h0sIE8jd+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl+N6kQD; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a0ed32c0ebso88026a12.2;
        Sun, 18 Aug 2024 18:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724029246; x=1724634046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cR6d3z4dkTkVOajgyHKENK0hKflSKn8qrA5cqnIiTY=;
        b=dl+N6kQDvB21V1ew1jvWhzikqeE2eZ7bFUrTeEv15FFUJSCvFHeUpG1zEhdRIvmedQ
         mB9r8RqjLN4xnyOb3IqDg1ydwKfeWojeYuq+IEN3umCvpek8N43/XxCg0I/zr0gU2gOU
         H94EllcpJZOUf5It+iEjsPPDaXtErvmsx8kaLACYtbnuqfaR50uDUR7yjEuZ0Gc7iSFW
         8oUtDz9OHiI3F6wIIUDIURWsJoYO+pBVlg2F9gll4HAEfalBro0F56j0tf14jjxPxMZg
         Kp2jsdTsbgQkSgCqbOznj3yLfU0il0cDQU65K7lX1nWEjx1zfulqeFa47W/4l/w2Hq+W
         lI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724029246; x=1724634046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cR6d3z4dkTkVOajgyHKENK0hKflSKn8qrA5cqnIiTY=;
        b=t9/KZ9aK6Dt1hD9XWopuEr529+IyEQzj6PRs+FoNpRNlcujfEDrgefxyZvH6g0o+Ia
         2boTvP46iRAWeBebAo/j2FBzMDtaYsTYvf2nMqTMCWbTrd4qJUL824AjkWc8EnPuANCe
         clGOUmQ7LduKQXAvOOlaB81xqiSj7Gg9dUqBb8xRQx0LJbw0wuuBvKyWXG4iI5rEMzTw
         H/WQruELoSQmNBo4eLZU0X9SYrLzwfeawdz/huB9aju2W6Ap9pJAWmO3Ihem5lbMSsmP
         it91yXaK15m5IcCB2dfUwOXxfUGm5/JqdPvjOz52naxxSToYNVLzhCwMxD4aLLxVC1hd
         KAXQ==
X-Gm-Message-State: AOJu0Yxp5lyFgCuYnkE2736rdEflnSCRYM/0T3Zi65TcNaW7tRGJJ3sD
	htNuWW+YHCCJnBevRjPULfQGQNDZBxpNXn9lXHoIY/V3VquQCJlMLHqpaNM0
X-Google-Smtp-Source: AGHT+IHkkUfwBXVysgu6t48MlL1RFYx61x7yrrl88/Ul6rtn+YBspySf88hrEbKVozQsjFJ3RYkujQ==
X-Received: by 2002:a05:6a00:2d17:b0:70d:1048:d4eb with SMTP id d2e1a72fcca58-713c5222e10mr7345653b3a.3.1724029245320;
        Sun, 18 Aug 2024 18:00:45 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c4a7sm5718732b3a.193.2024.08.18.18.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 18:00:45 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v5 6/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Mon, 19 Aug 2024 00:53:45 +0000
Message-ID: <20240819005345.84255-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819005345.84255-1-fujita.tomonori@gmail.com>
References: <20240819005345.84255-1-fujita.tomonori@gmail.com>
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
 MAINTAINERS               |  7 +++
 drivers/net/phy/Kconfig   |  7 +++
 drivers/net/phy/Makefile  |  1 +
 drivers/net/phy/qt2025.rs | 90 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+)
 create mode 100644 drivers/net/phy/qt2025.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dbfcf77acb2..d4464e59dfea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1609,6 +1609,13 @@ F:	Documentation/admin-guide/perf/xgene-pmu.rst
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
index f086a606a87e..669d71959be4 100644
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
index 000000000000..45864a7e1120
--- /dev/null
+++ b/drivers/net/phy/qt2025.rs
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) Tehuti Networks Ltd.
+// Copyright (C) 2024 FUJITA Tomonori <fujita.tomonori@gmail.com>
+
+//! Applied Micro Circuits Corporation QT2025 PHY driver
+use kernel::c_str;
+use kernel::error::code;
+use kernel::firmware::Firmware;
+use kernel::net::phy::{
+    self,
+    reg::{Mmd, C45},
+    DeviceId, Driver,
+};
+use kernel::prelude::*;
+use kernel::sizes::{SZ_16K, SZ_32K, SZ_8K};
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
+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
+
+    fn probe(dev: &mut phy::Device) -> Result<()> {
+        // The vendor driver does the following checking but we have no idea why.
+        let hw_id = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
+        if (hw_id >> 8) & 0xff != 0xb3 {
+            return Err(code::ENODEV);
+        }
+
+        // The 8051 will remain in the reset state.
+        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0000)?;
+        // Configure the 8051 clock frequency.
+        dev.write(C45::new(Mmd::PMAPMD, 0xC302), 0x0004)?;
+        // Non loopback mode.
+        dev.write(C45::new(Mmd::PMAPMD, 0xC319), 0x0038)?;
+        // Global control bit to select between LAN and WAN (WIS) mode.
+        dev.write(C45::new(Mmd::PMAPMD, 0xC31A), 0x0098)?;
+        dev.write(C45::new(Mmd::PCS, 0x0026), 0x0E00)?;
+        dev.write(C45::new(Mmd::PCS, 0x0027), 0x0893)?;
+        dev.write(C45::new(Mmd::PCS, 0x0028), 0xA528)?;
+        dev.write(C45::new(Mmd::PCS, 0x0029), 0x0003)?;
+        // Configure transmit and recovered clock.
+        dev.write(C45::new(Mmd::PMAPMD, 0xC30A), 0x06E1)?;
+        // The 8051 will finish the reset state.
+        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0002)?;
+        // The 8051 will start running from the boot ROM.
+        dev.write(C45::new(Mmd::PCS, 0xE854), 0x00C0)?;
+
+        let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
+        if fw.data().len() > SZ_16K + SZ_8K {
+            return Err(code::EFBIG);
+        }
+
+        // The 24kB of program memory space is accessible by MDIO.
+        // The first 16kB of memory is located in the address range 3.8000h - 3.BFFFh.
+        // The next 8kB of memory is located at 4.8000h - 4.9FFFh.
+        let mut j = SZ_32K;
+        for (i, val) in fw.data().iter().enumerate() {
+            if i == SZ_16K {
+                j = SZ_32K;
+            }
+
+            let mmd = if i < SZ_16K { Mmd::PCS } else { Mmd::PHYXS };
+            dev.write(C45::new(mmd, j as u16), (*val).into())?;
+
+            j += 1;
+        }
+        // The 8051 will start running from SRAM.
+        dev.write(C45::new(Mmd::PCS, 0xE854), 0x0040)?;
+
+        Ok(())
+    }
+
+    fn read_status(dev: &mut phy::Device) -> Result<u16> {
+        dev.genphy_read_status::<C45>()
+    }
+}
-- 
2.34.1


