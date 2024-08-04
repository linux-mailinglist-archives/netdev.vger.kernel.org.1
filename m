Return-Path: <netdev+bounces-115603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465B09471D2
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 01:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E188281030
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 23:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75D13C816;
	Sun,  4 Aug 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md0os4y+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B213D53B;
	Sun,  4 Aug 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722814917; cv=none; b=h+0YBvrIOnV8cvedG9LQD8eSdqmpdbISy911ae2kiFlRceRSkC3UdFRF7WneE1UFP20NIB1+e4ibLS6PCb7sRuau/LnaYHKXRfPP1Vm4wyWI3/E1uO6uKenzu2hfugMv7YhIjWBIBBVFXwIyAPDbDaQOWNLyYmzOhKGAOE/Xmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722814917; c=relaxed/simple;
	bh=R+SCPgLKjhjBEoPE2r+XCuSsCjzJ5EtNXsF/tYzmNqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQK2RO/w6D2/jNdf9sLl0WVeSuaZYKB276IL9wolSDljAscVpu0vjkhWAIIYcmhcZ5IstEsbLB/LQ0/l75exOfDulGbx3z8HbCMxXXGFPtM0IGHBGyGvM1E6gR9Dcr/2Ncf6GNxEVYMtCarvFatro/TV4oAl7/Bi5wMDjpK3bAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md0os4y+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1876e748so1242653b3a.1;
        Sun, 04 Aug 2024 16:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722814915; x=1723419715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfGilcpk4OcPcAuhOSUGgfo8hQ3NybwDByISAyYwmo0=;
        b=md0os4y+ssQ1MtPg6UXJfOD8XhjpXFWRRmFePbivc47pe7f319SzBnsXYxTUxwiBkS
         Q/ydu4ohR3v6XvhZ2kTuCz20zgGlpAtH2OogK6pDZ2bHJNTDsfA2H+GO6VXv3MIRhr3/
         P2GV4zuVRKPpEIUVX7SdqYzFIdMMEoQf/pBiffLqRjllMDCieJzCicQnlEAAnIjxOvco
         xrHrysK9HvG/8AEsjghFvzC66DAz7w17GLUS+O1INqKla311Wyl6lJEnf27bfwWIb1fo
         GmnYPlkFUCZ1ANSBCuJNPWwwox5QeZLidCvG5jiV/K6eY0BKzQ+sO2J589GuEZH7ZTgU
         J5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722814915; x=1723419715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfGilcpk4OcPcAuhOSUGgfo8hQ3NybwDByISAyYwmo0=;
        b=eVqTZ7VykmSRY7ZzjQ/KCjWiQjGoiblNp9WwEm4E77eY8mTvLmvNOxelKFbd243RZ1
         PxQxiszy/lewRd/d4SzYtXXnRj6lm+O+U76AXkkgGD20GgSp6mKEaWM3JfSlnS7njm4H
         vC6uHvOwlQGhKh6JSg29TvGc3NYe3K5Ld2P+9EQjmGAb6CMfXvEYzmM8Xm3FCOPE8ECr
         DzX2N5ggFbpyTzH6pphdv8MTyx0S/dTxj5mV16LqPICxIzvgecT4pPsDDLgvNTMyda7n
         j+cGho43cPPub5vYSjpa/2nPlq1feifPs1mfbWL7wnRTUp+w2kcsOdFeDrg01t3rnDRr
         bGDA==
X-Gm-Message-State: AOJu0YzbzvHQBYg24dXwxjZIETFRCqJUYZKXxNDVc6aXhV5MFCkyXAwe
	IfokI4yvLatpAIEYLTIrrLvlb9RRIzd7/bOemkVtWTroTsfchbKqaCnyOw7X
X-Google-Smtp-Source: AGHT+IEetRh1tZGvjxEkuwC66NE/tPNgA20zOcw71ZgmsxmySTER9OzEpailHTJXycVFlIshIc0acg==
X-Received: by 2002:a05:6a00:10cb:b0:70a:efec:6b88 with SMTP id d2e1a72fcca58-7106d07469dmr7998241b3a.3.1722814914849;
        Sun, 04 Aug 2024 16:41:54 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece3b99sm4535258b3a.98.2024.08.04.16.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 16:41:54 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v3 6/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Mon,  5 Aug 2024 08:38:35 +0900
Message-Id: <20240804233835.223460-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804233835.223460-1-fujita.tomonori@gmail.com>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
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
 drivers/net/phy/qt2025.rs | 93 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 drivers/net/phy/qt2025.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index f0639034ef96..d25a529f6e48 100644
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
index 000000000000..ef245e8d4161
--- /dev/null
+++ b/drivers/net/phy/qt2025.rs
@@ -0,0 +1,93 @@
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
+        // The hardware is configurable?
+        let hw_id = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
+        if (hw_id >> 8) & 0xff != 0xb3 {
+            return Ok(());
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
+            dev.write(
+                C45::new(mmd, j as u16),
+                <u8 as Into<u16>>::into(*val).to_le(),
+            )?;
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


