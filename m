Return-Path: <netdev+bounces-53711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF98043D9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F502812E2
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405E10E8;
	Tue,  5 Dec 2023 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWZPM+mj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69006CD;
	Mon,  4 Dec 2023 17:16:20 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c6910e93e3so150705a12.1;
        Mon, 04 Dec 2023 17:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701738979; x=1702343779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYu15P6L7YoC9UhBeN8d/Ym2A87Uy+RxNP4GwDIuHFE=;
        b=LWZPM+mjI79Xk35fkGedwc+UWi0vNf8sQ4yGWoAnySV42qOzRjnrkPLC0RrNhpZ+M1
         mWVZyvOsfKsf0uOvqaacMlYqqyp+toKJRSh3UAAMUPhtjTFj6tqQKE4J0MD/dQhhpsMw
         5FU179Valz0SflP62flRPRdzsM8pM/St0ZveWddmq799TL+5iPZYRQzUbt50gzJz20G4
         9Bmlln9Thks/6WWILAUU9BxZCFGdGU5zY28wR8dfNxfk+FaEA0rDaTNvPpdsFHsSzB+/
         o8c3MOaFimNJ79OSaBawteaR/LeEOWou1ZNicvTqpmnczkyJ+PeF3ece7Fnwiv75gUHm
         x3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701738979; x=1702343779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYu15P6L7YoC9UhBeN8d/Ym2A87Uy+RxNP4GwDIuHFE=;
        b=CSyn5jCdn1IILDA4lpdmd9YbJUemQZ/mRfsUJg1d8kF7X98Oya6SfByh2hcApe01Sb
         36/OsvVuVWk1j2oNu8PIMavd+0XFgao23NpAhlFQbbLQ+3Zfwk/pG4FN5BiAKsbt8Qwn
         8vkIQ4ph6hkDnlZOV0W7zWrNI1pfzLr4XCJmCCt3F2Rnift40C0au9B4zuVX0gGDHpuV
         XmWwsxUk4XRTocAZsiW9c11AMTFUu4arh7Kq/3jXX4sGKHQipg6zedwAYPMZCv7OvtNt
         CPMNove5Uwz648eIiihPtTQaviT2sfDqpWaz1/+NpFgS8m5bqSUotc8KnYs2DDWtPES7
         Uaqg==
X-Gm-Message-State: AOJu0YxdQFT/IiC3i1REXAuWkD/UbgVLkMQZWlXC/S7LqECDi69glD/H
	FbBbOwNRZP9QTBDBryVI95YHOyw5ARTjLE5R
X-Google-Smtp-Source: AGHT+IEdOEVsck3h7mEvfeVihB40BnZMh/R2UlA/TRJUf9LEaR1GdzgG82kbLZ+64tlo+L5h/mCjOg==
X-Received: by 2002:a05:6a20:da89:b0:18c:18d4:d932 with SMTP id iy9-20020a056a20da8900b0018c18d4d932mr42029821pzb.6.1701738979466;
        Mon, 04 Dec 2023 17:16:19 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id m18-20020a056a00081200b006ce64ebd2a0sm89337pfk.99.2023.12.04.17.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 17:16:19 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	aliceryhl@google.com,
	boqun.feng@gmail.com
Subject: [PATCH net-next v9 4/4] net: phy: add Rust Asix PHY driver
Date: Tue,  5 Dec 2023 10:14:20 +0900
Message-Id: <20231205011420.1246000-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the Rust implementation of drivers/net/phy/ax88796b.c. The
features are equivalent. You can choose C or Rust version kernel
configuration.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
 MAINTAINERS                      |   8 ++
 drivers/net/phy/Kconfig          |   8 ++
 drivers/net/phy/Makefile         |   6 +-
 drivers/net/phy/ax88796b_rust.rs | 135 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   2 +
 5 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 0166188446ac..1ed8b2ae5099 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3083,6 +3083,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/asix,ax88796c.yaml
 F:	drivers/net/ethernet/asix/ax88796c_*
 
+ASIX PHY DRIVER [RUST]
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+R:	Trevor Gross <tmgross@umich.edu>
+L:	netdev@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	drivers/net/phy/ax88796b_rust.rs
+
 ASPEED CRYPTO DRIVER
 M:	Neal Liu <neal_liu@aspeedtech.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 8d00cece5e23..0f483c3dfed9 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -112,6 +112,14 @@ config AX88796B_PHY
 	  Currently supports the Asix Electronics PHY found in the X-Surf 100
 	  AX88796B package.
 
+config AX88796B_RUST_PHY
+	bool "Rust reference driver for Asix PHYs"
+	depends on RUST_PHYLIB_ABSTRACTIONS && AX88796B_PHY
+	help
+	  Uses the Rust reference driver for Asix PHYs (ax88796b_rust.ko).
+	  The features are equivalent. It supports the Asix Electronics PHY
+	  found in the X-Surf 100 AX88796B package.
+
 config BROADCOM_PHY
 	tristate "Broadcom 54XX PHYs"
 	select BCM_NET_PHYLIB
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index f65e85c91fc1..ab450a46b855 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -37,7 +37,11 @@ obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
 obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
 obj-$(CONFIG_AT803X_PHY)	+= at803x.o
-obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
+ifdef CONFIG_AX88796B_RUST_PHY
+  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
+else
+  obj-$(CONFIG_AX88796B_PHY)	+= ax88796b.o
+endif
 obj-$(CONFIG_BCM54140_PHY)	+= bcm54140.o
 obj-$(CONFIG_BCM63XX_PHY)	+= bcm63xx.o
 obj-$(CONFIG_BCM7XXX_PHY)	+= bcm7xxx.o
diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
new file mode 100644
index 000000000000..5c92572962dc
--- /dev/null
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
+
+//! Rust Asix PHYs driver
+//!
+//! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
+use kernel::{
+    c_str,
+    net::phy::{self, DeviceId, Driver},
+    prelude::*,
+    uapi,
+};
+
+kernel::module_phy_driver! {
+    drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
+    device_table: [
+        DeviceId::new_with_driver::<PhyAX88772A>(),
+        DeviceId::new_with_driver::<PhyAX88772C>(),
+        DeviceId::new_with_driver::<PhyAX88796B>()
+    ],
+    name: "rust_asix_phy",
+    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
+    description: "Rust Asix PHYs driver",
+    license: "GPL",
+}
+
+const MII_BMCR: u16 = uapi::MII_BMCR as u16;
+const BMCR_SPEED100: u16 = uapi::BMCR_SPEED100 as u16;
+const BMCR_FULLDPLX: u16 = uapi::BMCR_FULLDPLX as u16;
+
+// Performs a software PHY reset using the standard
+// BMCR_RESET bit and poll for the reset bit to be cleared.
+// Toggle BMCR_RESET bit off to accommodate broken AX8796B PHY implementation
+// such as used on the Individual Computers' X-Surf 100 Zorro card.
+fn asix_soft_reset(dev: &mut phy::Device) -> Result {
+    dev.write(uapi::MII_BMCR as u16, 0)?;
+    dev.genphy_soft_reset()
+}
+
+struct PhyAX88772A;
+
+#[vtable]
+impl Driver for PhyAX88772A {
+    const FLAGS: u32 = phy::flags::IS_INTERNAL;
+    const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
+    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x003b1861);
+
+    // AX88772A is not working properly with some old switches (NETGEAR EN 108TP):
+    // after autoneg is done and the link status is reported as active, the MII_LPA
+    // register is 0. This issue is not reproducible on AX88772C.
+    fn read_status(dev: &mut phy::Device) -> Result<u16> {
+        dev.genphy_update_link()?;
+        if !dev.is_link_up() {
+            return Ok(0);
+        }
+        // If MII_LPA is 0, phy_resolve_aneg_linkmode() will fail to resolve
+        // linkmode so use MII_BMCR as default values.
+        let ret = dev.read(MII_BMCR)?;
+
+        if ret & BMCR_SPEED100 != 0 {
+            dev.set_speed(uapi::SPEED_100);
+        } else {
+            dev.set_speed(uapi::SPEED_10);
+        }
+
+        let duplex = if ret & BMCR_FULLDPLX != 0 {
+            phy::DuplexMode::Full
+        } else {
+            phy::DuplexMode::Half
+        };
+        dev.set_duplex(duplex);
+
+        dev.genphy_read_lpa()?;
+
+        if dev.is_autoneg_enabled() && dev.is_autoneg_completed() {
+            dev.resolve_aneg_linkmode();
+        }
+
+        Ok(0)
+    }
+
+    fn suspend(dev: &mut phy::Device) -> Result {
+        dev.genphy_suspend()
+    }
+
+    fn resume(dev: &mut phy::Device) -> Result {
+        dev.genphy_resume()
+    }
+
+    fn soft_reset(dev: &mut phy::Device) -> Result {
+        asix_soft_reset(dev)
+    }
+
+    fn link_change_notify(dev: &mut phy::Device) {
+        // Reset PHY, otherwise MII_LPA will provide outdated information.
+        // This issue is reproducible only with some link partner PHYs.
+        if dev.state() == phy::DeviceState::NoLink {
+            let _ = dev.init_hw();
+            let _ = dev.start_aneg();
+        }
+    }
+}
+
+struct PhyAX88772C;
+
+#[vtable]
+impl Driver for PhyAX88772C {
+    const FLAGS: u32 = phy::flags::IS_INTERNAL;
+    const NAME: &'static CStr = c_str!("Asix Electronics AX88772C");
+    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x003b1881);
+
+    fn suspend(dev: &mut phy::Device) -> Result {
+        dev.genphy_suspend()
+    }
+
+    fn resume(dev: &mut phy::Device) -> Result {
+        dev.genphy_resume()
+    }
+
+    fn soft_reset(dev: &mut phy::Device) -> Result {
+        asix_soft_reset(dev)
+    }
+}
+
+struct PhyAX88796B;
+
+#[vtable]
+impl Driver for PhyAX88796B {
+    const NAME: &'static CStr = c_str!("Asix Electronics AX88796B");
+    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_model_mask(0x003b1841);
+
+    fn soft_reset(dev: &mut phy::Device) -> Result {
+        asix_soft_reset(dev)
+    }
+}
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 301f5207f023..08f5e9334c9e 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -7,3 +7,5 @@
  */
 
 #include <uapi/asm-generic/ioctl.h>
+#include <uapi/linux/mii.h>
+#include <uapi/linux/ethtool.h>
-- 
2.34.1


