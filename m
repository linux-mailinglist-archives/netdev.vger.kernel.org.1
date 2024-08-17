Return-Path: <netdev+bounces-119378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456DE95558B
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 07:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFA71C22DB6
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 05:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1B312CDB0;
	Sat, 17 Aug 2024 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eev2a576"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3513D2BB;
	Sat, 17 Aug 2024 05:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723872351; cv=none; b=APtURtruS4VoH3EUEWPn6ADfituIqW7Z3W9xiwV+FWiuf78dPB4WGivqlCaNmn4vO67p1xva2NYeDfwIsGS2uRUYGk/VFlsibMnNHE5FeNvCKEhqKAjjD9cIZamLbyy2AFAg0Q2Ksrl89tqsR1VREQdGxH9vtTiGcRbcfVZDipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723872351; c=relaxed/simple;
	bh=rI/ikr9V6tO3wkyPg4vcS/yqWIW2u9mB/lMVVJUWjEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGafzGvP/hVOISG8LFBA9eEfmSqnIxAaDbun+rzvA3WoumGd6SZmY+uEeJ2iFsQxKdhvXvQiNdDcjXVqcg7pb9xnhRF+Y4LzEw9F2PZdrdWbZ9Vxy71IV+wzhIdeSfjuWbe0LKY3jlZDBjJLFH3aXNXkIZ9QSkTId3qKQ9CAtp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eev2a576; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3e6fd744fso228068a91.3;
        Fri, 16 Aug 2024 22:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723872348; x=1724477148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRoGvAsLGHVZKfeLnDcY0W8KGB8Ab4XBjAPvTKAgHPI=;
        b=eev2a576E/zsAR7FnsZe7bDnUC7teReBtYMFgA8Moqzt6G1l9vwFHd+KEBilNaxRJ4
         Vp3UT4SbV+Lgi455yPy4TN/ZvI0gam9AiP0inAZFJ53nDcpcAmsvEfK/22+T45Hfd5Mn
         WJNsg0niE+I+prAtpuXU39PDMmRkkLhuQJaZNGGTcK/vesLNCYDR0x50dGBmrUYEzbHU
         p3OPW5jthnG2zefeRPRL07yCVODomdtj6LCMiR6gDRcCTblAmkP/WBlGIU3B8OphDZYY
         kTN8FuTG7wN2OadiQ2xjEiM92vQ8S+5lgN5WxcM7D+y2A3bkmKrS6eg3KaGELU9Bfx13
         vBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723872348; x=1724477148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRoGvAsLGHVZKfeLnDcY0W8KGB8Ab4XBjAPvTKAgHPI=;
        b=F35mEOORrVn0qv8gZJaUUzk4i83P1QjVS3etU5ikgQ9oz4kxg6vdn6QnUqzID+yL9z
         jSXxgBoCSeAxBYbEuPbHtApNxzr0PT5uluG5RF8m8f/AFgDRLglYoKx5dMcWaYkKH5iA
         S0zYNHRTH2n4ik5nKf+KuHSwFpNqRbUGXy8mUbj7BZlkgmOmlLdNdwPe/UtqT0jdlM2P
         n5XdslYG6QHYVNC+AMfwRPFTYdR/22IX3JZ1Oaiq2OEr+Q3SNTp2FSvdfaGFtQhMyWJu
         wQSDfEIpT0sCn4bZ09ngsGrAfTbXyQ0yw3aoeXNfNsJ8qPv1DTHu/6blcFPc+BAkNXkp
         Eqhg==
X-Gm-Message-State: AOJu0YzR6/hX8Z30k6HAEnSOnXwOUAWCoS1tD4l2Jlod9LvyuC93rfFA
	Kb+v0M2H4lVUq6hDO1xbUQO2qvPqTFZQ4QkMl6dPLcdz2q4xLl2+geGDdEP6
X-Google-Smtp-Source: AGHT+IHTqqwN/GPPLu6imSc0NlyX6/7bfjSPj2az/noHY13AsDs9miZyYCpxDmGG0AYyomoZB96S0g==
X-Received: by 2002:a17:90b:146:b0:2c8:4623:66cd with SMTP id 98e67ed59e1d1-2d3e1a42e70mr3315549a91.1.1723872348326;
        Fri, 16 Aug 2024 22:25:48 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c74e33sm2881655a91.39.2024.08.16.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 22:25:48 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v4 6/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Sat, 17 Aug 2024 05:19:39 +0000
Message-ID: <20240817051939.77735-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240817051939.77735-1-fujita.tomonori@gmail.com>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
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
 drivers/net/phy/Kconfig   |  6 +++
 drivers/net/phy/Makefile  |  1 +
 drivers/net/phy/qt2025.rs | 90 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+)
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
index 7fddc8306d82..e0ff386d90cd 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -109,6 +109,12 @@ config ADIN1100_PHY
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
index 202ed7f450da..461d6a3b9997 100644
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


