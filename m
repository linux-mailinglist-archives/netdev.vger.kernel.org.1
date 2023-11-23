Return-Path: <netdev+bounces-50372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB3A7F57B1
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4614F1F207C9
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 05:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D5F9EB;
	Thu, 23 Nov 2023 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw2rYoSp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975AD8;
	Wed, 22 Nov 2023 21:09:56 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so130536b3a.0;
        Wed, 22 Nov 2023 21:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700716196; x=1701320996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKgwMw8xEOloMITCqI0jo2CSKxSB98mTWRniPYWtqRE=;
        b=Tw2rYoSpdKs8GNytJf2y0cauJwOIZr2MPQmNsXZyGlfeNgj3dcHsqZBtceUBRpY7vj
         09qLjsa0AW19W35Fzck1JYWkkQ8qqhluESEL+8nXh/gXjPkx9nNJfGd+97wc9m41MPAC
         Bdf85K8G+80MKIlzPeYSXIEOY/DtfSttUTzhJ+GtQhk6/0JcQ6bv0haChcxZj8SLU9wE
         n5tCakVoTKjPnCg+4n6D27cwQu087Qn+qG6tUljbbDaIo7wqTH4gIJR9RV84rxNNPkFV
         jRf9Mj9dWt+jZo362V/jfysbnRztAzRzBUW2ml1pbeE5Noz+85yA+7U2/W4oRri8Sx4B
         DJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700716196; x=1701320996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKgwMw8xEOloMITCqI0jo2CSKxSB98mTWRniPYWtqRE=;
        b=IuCX8zB/sGCw4q9cTlxbaLbcicpVRNQJ5qAlHGSr7QWEDoTQXmzPu4mYoE+HqhLPrz
         hckPvBPKBCdqwBdKGqMoAW8douCM+u3kPLXz6evqC7zQCzTpQurNmmjB7TevKTwviGDm
         TC2mGuKx4g7oN11WrxhDc7MShfdWg1PKKgmKpcVjcwQOb44X6KXzB4OFdfYbCH0DzcJA
         vMhJFfsBz0j2UllqXNAArc7BHO+lQCVH3K38LJz9R5SAgoYfentr8FyhoLXCrDIrXwdL
         qmKdWgaRqALmFHiwAB+KHsvCn7BQ4Ag0PEKQ2lId67BGDVajpD0lm0tprBKkVSQBoH9L
         ascg==
X-Gm-Message-State: AOJu0YxEe5Qdrz80Rx5GgsA0GXtVCW6RtqqAHai5J8TMtxtfPHCBj4Ha
	SJVfFmGTUeU+wqNukD6tr3MX+MFXwfJiZdlK
X-Google-Smtp-Source: AGHT+IF1TaGK8I5aSjyp+8LBmcPmSqudaw3FGdz2kqK32gWs6vPcLTaXO9PyxsVnKFLnl+FnOZYCBg==
X-Received: by 2002:a05:6a20:4282:b0:187:df59:5c3c with SMTP id o2-20020a056a20428200b00187df595c3cmr4322180pzj.3.1700716195636;
        Wed, 22 Nov 2023 21:09:55 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78007000000b006900cb919b8sm347734pfi.53.2023.11.22.21.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 21:09:55 -0800 (PST)
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
Subject: [PATCH net-next v8 4/4] net: phy: add Rust Asix PHY driver
Date: Thu, 23 Nov 2023 14:04:12 +0900
Message-Id: <20231123050412.1012252-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123050412.1012252-1-fujita.tomonori@gmail.com>
References: <20231123050412.1012252-1-fujita.tomonori@gmail.com>
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
index 49ba506fbc3c..2cf606342a1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3084,6 +3084,14 @@ S:	Maintained
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


