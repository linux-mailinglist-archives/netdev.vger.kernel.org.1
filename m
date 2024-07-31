Return-Path: <netdev+bounces-114392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC1E94255B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE584283035
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8971BDE6;
	Wed, 31 Jul 2024 04:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC+A5ltc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F01BC4E;
	Wed, 31 Jul 2024 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399748; cv=none; b=W0whGKHTs30T7WI3LMXrew9/FLpi8j2jamonK6+rZWrgPcybU9vm64y8PYJAZRXLunh4UThu6+dJmhAOKnaSFt2D7fqmO4IkiLFiYVab0zySGT4OzmaaAnEz6aoL/EsNb1jIQRcrY4LrWoroXyUdUAUi0ITrQ63ntNd+H7tacDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399748; c=relaxed/simple;
	bh=F6VQPDZkMiHUYry4mcCki7rp4ojrRPWnc1ymCkC+lAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1g/H/B3RcQutyIuXS3em5xO5ANp/h1lWMQM3wIZgEu0EyRwv4k0EriQ4B0Jfo5bAiEOGmzGqzhODIlkCkjTwSqTDAshS3bhCx1rWe2y56zyS5E2nivzD3Z6RmEyhfuty1x1fPqdK8M29IvhfJOUCHEB08PC3yww4JX/wJiPx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dC+A5ltc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb6b247db0so913496a91.2;
        Tue, 30 Jul 2024 21:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722399746; x=1723004546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLlIPpgwDeHsVYKfjp5eQYx/g1IrCkH7XRUUc5epW9c=;
        b=dC+A5ltcEbBWz4DU3mcHhtmocCEwskf5i5kTco7CCLluhi1eWnaeVYgc8/KNLE/Lxu
         4XkwY8dxt42JtXqmblAP7BeLLsLGlitVGGKI6jyJNeUyB1K3+yfgA19fcilXJ0Es5fK0
         wD646yAxitbLPIlg27rX7FrCKsGoQPakHSk/sBYvkCdn1KMDOO+vKtRGsmC7xs2XlWYU
         xcny8o8Zv1RcZzziCrAR1A0/VuU9jrqbuB8YSilTZs8B3dOW8rW78nFmCorAzrsAoG/f
         Og2UE+omR9iFB0Foycb548zLkKnYj8knQjYGbcfsajlRqsFDDKb0kxz64EDB20oWU5dH
         QFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722399746; x=1723004546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLlIPpgwDeHsVYKfjp5eQYx/g1IrCkH7XRUUc5epW9c=;
        b=NQIJaYJahZ9EQhToyET/bYgVxmGO0+tb/etpRTPUtJs6dE2SyYSbJOowh/nWqgqJ62
         n4v6DO4Mzh5KO912Vb7c2+tm8O+244AYys81Susy+qnxNGNRnJCmJa7RtDXzpFpPKLBX
         YaxUiV7zayCIJMsjbM7K7RJaBBHT8AZCETuW+IdBpm3bOfX/AvG48ZI1xtK2v9fXyZx0
         8vZruTq0QOE6LC1MYk9k9QceEMfhiTuZs+jpgrVdTKEcRjT7KtFP9lstBkgLT4ofzPyr
         VXCZrnkDN6MVDSvU3Y8PIhDhEhzPmG75/rW+z5Nz01BwLWGyUInD/NW1UGegRUqugg7C
         rrLA==
X-Gm-Message-State: AOJu0YwTD4iNgY4T4KSp27RREj8jeVfDF9VsPbzHBp39InElc9CbIRcr
	dEYR3/jQGOVV8Se+EKWb7hhl44GNlD8LOQMnefjQ5EpFewPRPjwt7relSx0S
X-Google-Smtp-Source: AGHT+IEcEjzFO5S3E/UFcjaL1FrhMmR1DelX9uRyAZ7pzBqV+YTM+8794AR0dYWDLY/wFgf31OPRoA==
X-Received: by 2002:a05:6a21:3a46:b0:1c0:f5fa:db13 with SMTP id adf61e73a8af0-1c477199be3mr12111597637.2.1722399745864;
        Tue, 30 Jul 2024 21:22:25 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8d376sm110815145ad.18.2024.07.30.21.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 21:22:25 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: [PATCH net-next v2 6/6] net: phy: add Applied Micro QT2025 PHY driver
Date: Wed, 31 Jul 2024 13:21:36 +0900
Message-Id: <20240731042136.201327-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731042136.201327-1-fujita.tomonori@gmail.com>
References: <20240731042136.201327-1-fujita.tomonori@gmail.com>
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
 drivers/net/phy/qt2025.rs | 92 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 drivers/net/phy/qt2025.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f85fad3b939..b8fda7e0343c 100644
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
index 000000000000..b93472865bde
--- /dev/null
+++ b/drivers/net/phy/qt2025.rs
@@ -0,0 +1,92 @@
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


