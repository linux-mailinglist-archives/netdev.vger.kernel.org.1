Return-Path: <netdev+bounces-37349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB247B4E14
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 25F201C209DE
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C6E8C0D;
	Mon,  2 Oct 2023 08:53:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE610A04;
	Mon,  2 Oct 2023 08:53:26 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D24291;
	Mon,  2 Oct 2023 01:53:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2791d5f1a09so1136345a91.1;
        Mon, 02 Oct 2023 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696236802; x=1696841602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQTTlYYsnz8FL8Zy6c22htG1c4iCQ1YYL+g38bjpDds=;
        b=EXRIcuqJH2v4ZS8c24TXXjmh5EcDrLOlYRfPx4Ktzg9z6tCzAIOf0SW0CmOHKdSq60
         PsCvJxpGB7vfNKoGSCSPklGcASm0dQoQE7pU7zMbw3+fIdy30n79uMK5LHxkB6HZQrjB
         ywbduuWSXNLDZowF/t6nWSYBQDNmvMLLHen2AS7kCYrZqr/a1KzuM9LJHRULaIgGDGUx
         U5zCgb4W78TJv3KeIhzdadiYWtN4Qeqger18NTQjeSSeMG+DFXnOGvtxLd+gLn7a/8y6
         SPpxr2vE4NvvdqI15QDFL65fpaIbtyFRS3FX35yMKHayt6TKDL8P+ouL51VCB0VUqUqR
         GIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696236802; x=1696841602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQTTlYYsnz8FL8Zy6c22htG1c4iCQ1YYL+g38bjpDds=;
        b=mgSA2TRBGcj0nONWkIZBgmoon0/vIQML1yJElKDqmLSozYrtQeZIhuB9tQRF/wcNXZ
         OzhHexGhCkRCxrRKV2ZFpYEgq5RBlBiVYhTDickP4kLzYxqtw/9PhtuOe09pIMsRtQEO
         Zgrdm+qYvAx+NYV55OaCVdVdJqf3TbxkSn8tqwjdwROkjRXkEPjjBLv5z68xUXM0R6Uz
         yFHBM8WFWzHz27/fZSD4aZuLmVMIHsWAMGQLSufLCUEuTXvf92GTRnfglPx4w1z7bjjJ
         KVSVz3D5kPiY5OSk2Ia+jUU9eT76F16hfoJ4E9/ibIfr8Jf1AhPTqaFB/PicMWEzDvnM
         GtYQ==
X-Gm-Message-State: AOJu0YwdG7Uyhh+w8Yqt9Uo4nWwlsSl91DmMcII6X46ouRPpP8Pe22sr
	RTGmQjGmxT3TX/v6NTOfowIYvuj8OoMm9jn7
X-Google-Smtp-Source: AGHT+IHyTMOGN2GTNNfSDTDCH5V1Hc2AjsJ2L3440jarxOdyY6j5cZKRgeAWW2I3JEprHC5aIq9NGg==
X-Received: by 2002:a17:90a:657:b0:277:653b:3fef with SMTP id q23-20020a17090a065700b00277653b3fefmr9269449pje.3.1696236802491;
        Mon, 02 Oct 2023 01:53:22 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00274c541ac9esm5656270pju.48.2023.10.02.01.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 01:53:22 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com
Subject: [PATCH v1 3/3] net: phy: add Rust Asix PHY driver
Date: Mon,  2 Oct 2023 17:53:02 +0900
Message-Id: <20231002085302.2274260-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
References: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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


