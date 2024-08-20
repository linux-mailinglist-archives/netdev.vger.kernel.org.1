Return-Path: <netdev+bounces-120369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5289590CB
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6131F22C3B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0951C9DDA;
	Tue, 20 Aug 2024 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQOb8Ba4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387691C9DD7;
	Tue, 20 Aug 2024 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194761; cv=none; b=h6hoiVh4kiMIwZ0p2dUe533hi/yPTVaBPx9YIXVPqQNGBtHai/oVyP8kLr3E78SbkygZDeWQ0Gsd1ZiAQ10mphvSdFYkW4box7MNhOZvYZawfh36oa5ZLVRaVXc1nErIXvPA/X6necuFowVAVtVuZeGqsfHe9Pzh4q7cdZ4NeTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194761; c=relaxed/simple;
	bh=SYB1bYt/I9pbgcrV03oLTHLBqJQvuECjyVQk2wzkJ1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9JlrANHFm/gIrdIWZelV6nKJJwcxiFzBbYcoLl82/LLVJesK3uW1Kxan9V0uMWYmqhp9ZST8LxP6VAOuId4hhwXlstXUwQoLBYTTE4HiuCUxvdwci/2OzWoYOOZg9W3++U3XdEvih5Zxm+xykix8wME8SSYPHtVxPvspEzm6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQOb8Ba4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-713f3b4c9f7so2065084b3a.2;
        Tue, 20 Aug 2024 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724194759; x=1724799559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk6cenPh8mXerZDJZXHKSIJxmQKegqpbUXCJEqMtXGo=;
        b=aQOb8Ba4lRrhu6g2PP5CgYqItnPngOJh+ShxEdxEoXI8+B3NNnoPNDpGeN974Cq0Br
         8/buu/UW/DvJduxp0elXHEMpkcn1wOOVOBm4P7jzOf0nkUCtLNJeQhSqinACxrkp53d7
         am/YYWqdiUwhQ8YTnxOwgp8bp77AzDKvrSDx4U9tw9kqUOQ6z/L22bXmvRYErkWhDMLC
         ZsKayDbdmfemIYETL+XRO7u/OAU6TzWTY1S+AOKjZW88QxoIVgd1uM4Ny0PPXCX5IAGl
         WpDLdSo4ICslSwTtFm6LZBeBjz6Y7T2N1sZ5gBXmjwZ43syzGWtaSvEcye8nWdS4kiG1
         ltQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724194759; x=1724799559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk6cenPh8mXerZDJZXHKSIJxmQKegqpbUXCJEqMtXGo=;
        b=kzoqFCsZebV/Dct5jmZzruWBnVeIw8whoZTr8V6pczJL4IeZbSKCzP/Cq1veuFk7AS
         U0R7bFmQV+771TW1ul0YECuXCfxa/SGz2HVSrWcHx+ho455ReylPBZIuN39hBXcmLsOQ
         YNDEGf0f9E1hX5j/7suuwEFO083fI7ZijMteIP1WOYPxGVZcZWrt0fUEEqaoEYVfr31T
         ixUQ+uluVIYDFdUuQA7Lk9SpsrtffeGcQmBOlhPBq6p3rMmGJKoQ0cw2Mpj4TlP92aY0
         JefKDdGZaLAtCFYqykOwf1IZKcZnP+ykLc+wh94Y8gzkBcFMcWH2B+O3siz/Ph30Ic5p
         /Uow==
X-Gm-Message-State: AOJu0YzQg8dDk/Wzvqu4BQSHZxr0LpwmC1xVhytri/fWYoiFBj4cea8d
	CTYhKoWRWzEi/ztE0b/SyL/mrTIKCht/Ls6LPqZLtfPgoCffB5aQMXxMj7gj
X-Google-Smtp-Source: AGHT+IHljW+8ipi10Rh9i8Rv2nwtaG7zl0rlwr9s65wUL4AOd2s4gBbwpl+LiwLtlafo5waOFsrJCw==
X-Received: by 2002:a05:6a20:c78e:b0:1c4:919f:3677 with SMTP id adf61e73a8af0-1cada1488c8mr750933637.42.1724194759047;
        Tue, 20 Aug 2024 15:59:19 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61d5045sm9922076a12.38.2024.08.20.15.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:59:18 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v6 6/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Tue, 20 Aug 2024 22:57:19 +0000
Message-ID: <20240820225719.91410-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820225719.91410-1-fujita.tomonori@gmail.com>
References: <20240820225719.91410-1-fujita.tomonori@gmail.com>
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
 drivers/net/phy/qt2025.rs | 98 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+)
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
index 000000000000..a1505ffca9f5
--- /dev/null
+++ b/drivers/net/phy/qt2025.rs
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) Tehuti Networks Ltd.
+// Copyright (C) 2024 FUJITA Tomonori <fujita.tomonori@gmail.com>
+
+//! Applied Micro Circuits Corporation QT2025 PHY driver
+//!
+//! This driver is based on the vendor driver `QT2025_phy.c`. This source
+//! and firmware can be downloaded on the EN-9320SFP+ support site.
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
+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
+
+    fn probe(dev: &mut phy::Device) -> Result<()> {
+        // The vendor driver does the following checking but we have no idea why.
+        let hw_id = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
+        if (hw_id >> 8) & 0xff != 0xb3 {
+            return Err(code::ENODEV);
+        }
+
+        // The Intel 8051 will remain in the reset state.
+        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0000)?;
+        // Configure the 8051 clock frequency.
+        dev.write(C45::new(Mmd::PMAPMD, 0xC302), 0x0004)?;
+        // Non loopback mode.
+        dev.write(C45::new(Mmd::PMAPMD, 0xC319), 0x0038)?;
+        // Global control bit to select between LAN and WAN (WIS) mode.
+        dev.write(C45::new(Mmd::PMAPMD, 0xC31A), 0x0098)?;
+        // The following writes use standardized registers (3.38 through
+        // 3.41 5/10/25GBASE-R PCS test pattern seed B) for something else.
+        // We don't know what.
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
+        // The Intel 8051 will start running from SRAM.
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


