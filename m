Return-Path: <netdev+bounces-38511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241047BB480
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11917282477
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C003F14296;
	Fri,  6 Oct 2023 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGeJ2cvt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3613AEE;
	Fri,  6 Oct 2023 09:49:24 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819D5F2;
	Fri,  6 Oct 2023 02:49:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c76ef40e84so3174185ad.0;
        Fri, 06 Oct 2023 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696585761; x=1697190561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQTTlYYsnz8FL8Zy6c22htG1c4iCQ1YYL+g38bjpDds=;
        b=dGeJ2cvt1EkN4jKGJuE3CF4naG1DVxLmPvVrG9JrVgTVFMLY2OKcjjZkFH1hTysJb1
         VWTxxnkVTKT5/HYYTLnwVYYWx91CokD2OSXR8Cls1r7PxCxrhUcKq0U1QClJGXKSREpy
         sA49/ecZEu1aLa7CUcY/uL9N6GmDSH0u23HOzXUxtF4QhnTZnn3E/q4SO/QYLgdfN1bC
         bDssT2w1jCGAQFhuSVy1xKhbs7mf4LQr6jVSTVYWtaz0bYIgGVq7R6RM6MF6xpsrHY+8
         T761jg88Q2cFLK5tU1evbHCbkv9/NAcn0oX46WmZ2wIiQyAfxR0ToRmSgpQLCZzo9Hpn
         AvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696585761; x=1697190561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQTTlYYsnz8FL8Zy6c22htG1c4iCQ1YYL+g38bjpDds=;
        b=caGWJhi50TkzOToGm9xMZZCuDF01S8YTNmV+rmQjdvFtXq7xxFxWbsyRwv0jmas1Jn
         KOuQ1FMMwxKZUChvxom5IenpM4y8Kik1eFWlZOaguryo+mM613Gdl4IVoZVN3WvwoFQs
         L7pZVLOIsOSvrznnG+VS9DIxg6iKPwg8NHroMmDBhjYef2fGV7IItBh+5n1+EVMbG6/Q
         13NucdkWSGfjS9/xxJRjweMcfalQNLDfFAMsnPY1XmQLQTfhI4zI/sK6Ynjk8E6Q7i68
         zvkZFR9APXtZH4XdNVL8Nk4uqvsSUQhcNP0vwDk0VIxU3Hnj9eRCIixbWuN/SFtrlk9s
         Z7fg==
X-Gm-Message-State: AOJu0YzhxOWgCqg+STCB9tfAFDUtJYPx+UAhrFsXEU47fH4x+HsLzduY
	tKQsgDPAg3K4kgSJ2lOnY5dYsGtW1dQAjpr4
X-Google-Smtp-Source: AGHT+IGYbJoHLXNBkhiDaBVDJZtIGf/dYfoV7x86+idXs9hhWosUZmIKZ4vFjtPCJIRJkB3hKUYcHw==
X-Received: by 2002:a17:902:dacd:b0:1b3:d8ac:8db3 with SMTP id q13-20020a170902dacd00b001b3d8ac8db3mr8057019plx.6.1696585761585;
        Fri, 06 Oct 2023 02:49:21 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902eecd00b001c446f12973sm3362144plb.203.2023.10.06.02.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:49:21 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com
Subject: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
Date: Fri,  6 Oct 2023 18:49:11 +0900
Message-Id: <20231006094911.3305152-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is the Rust implementation of drivers/net/phy/ax88796b.c.  The
features are equivalent. You can choose C or Rust versionon kernel
configuration.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/phy/Kconfig          |   7 ++
 drivers/net/phy/Makefile         |   6 +-
 drivers/net/phy/ax88796b_rust.rs | 129 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   1 +
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/ax88796b_rust.rs

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 107880d13d21..e4d941f0ebe4 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -107,6 +107,13 @@ config AX88796B_PHY
 	  Currently supports the Asix Electronics PHY found in the X-Surf 100
 	  AX88796B package.
 
+config AX88796B_RUST_PHY
+	bool "Rust reference driver"
+	depends on RUST && AX88796B_PHY
+	default n
+	help
+	  Uses the Rust version driver for Asix PHYs.
+
 config BROADCOM_PHY
 	tristate "Broadcom 54XX PHYs"
 	select BCM_NET_PHYLIB
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..58d7dfb095ab 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -41,7 +41,11 @@ aquantia-objs			+= aquantia_hwmon.o
 endif
 obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia.o
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
index 000000000000..d11c82a9e847
--- /dev/null
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust Asix PHYs driver
+use kernel::c_str;
+use kernel::net::phy::{self, DeviceId, Driver};
+use kernel::prelude::*;
+use kernel::uapi;
+
+kernel::module_phy_driver! {
+    drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
+    device_table: [
+        DeviceId::new_with_driver::<PhyAX88772A>(),
+        DeviceId::new_with_driver::<PhyAX88772C>(),
+        DeviceId::new_with_driver::<PhyAX88796B>()
+    ],
+    type: RustAsixPhy,
+    name: "rust_asix_phy",
+    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
+    description: "Rust Asix PHYs driver",
+    license: "GPL",
+}
+
+struct RustAsixPhy;
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
+impl phy::Driver for PhyAX88772A {
+    const FLAGS: u32 = phy::flags::IS_INTERNAL;
+    const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1861);
+
+    // AX88772A is not working properly with some old switches (NETGEAR EN 108TP):
+    // after autoneg is done and the link status is reported as active, the MII_LPA
+    // register is 0. This issue is not reproducible on AX88772C.
+    fn read_status(dev: &mut phy::Device) -> Result<u16> {
+        dev.genphy_update_link()?;
+        if !dev.get_link() {
+            return Ok(0);
+        }
+        // If MII_LPA is 0, phy_resolve_aneg_linkmode() will fail to resolve
+        // linkmode so use MII_BMCR as default values.
+        let ret = dev.read(uapi::MII_BMCR as u16)?;
+
+        if ret as u32 & uapi::BMCR_SPEED100 != 0 {
+            dev.set_speed(100);
+        } else {
+            dev.set_speed(10);
+        }
+
+        let duplex = if ret as u32 & uapi::BMCR_FULLDPLX != 0 {
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
+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1881);
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
+    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_model_mask(0x003b1841);
+
+    fn soft_reset(dev: &mut phy::Device) -> Result {
+        asix_soft_reset(dev)
+    }
+}
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 301f5207f023..d92abe9064c2 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -7,3 +7,4 @@
  */
 
 #include <uapi/asm-generic/ioctl.h>
+#include <uapi/linux/mii.h>
-- 
2.34.1


