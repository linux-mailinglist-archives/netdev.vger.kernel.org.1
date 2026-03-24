Return-Path: <netdev+bounces-271149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNRvIfy0wmkvlAQAu9opvQ
	(envelope-from <netdev+bounces-271149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:59:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 091D13187FD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F62E3105F37
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77C38F62D;
	Tue, 24 Mar 2026 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHU237Dg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C6365A1D
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367598; cv=none; b=r2fmn7q4WMQ+rB8ts+RWSX5EbVhhLplQ6KsbXf2OEp0Qfb+BoHXR7gWNAfVDoAGG8Vt9q0zzUSbUha6s1uZK4aP8YB9JcV6LySrT92KOBjgniyA1nKFQcQE8zUljQSjNiLtOXZKO3fdgmXhe9qKvWpskVIPPLANZHnrtSWoTubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367598; c=relaxed/simple;
	bh=f2fhNgEZ9mq/NMTTBc2nagEfYfPtdMldazchFYecDeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpcBEnv7En4CQFVY96FrX0EGVwTuo9tm2VVyZgZcy63OqWECFlQbwriL19Gspak8tuIlRk0QI8GVg8A6HOStMpVnKpHiR6pe1JOekPIQ2QV68lj2jzd7sP6yRFfFfu/HZ0ogj17FGR4gTU8ElkXX0O3iPSRsfmRrKVkRIE94FR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHU237Dg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38c01150eb2so34177641fa.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367595; x=1774972395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfeAjXMVYCj1aDUUjyZzfRg1uUQ9OgRu51XWUh4xZSo=;
        b=cHU237DgfFPOuV/Oll6ioEVrCW1poKc4Lvsacv71LSG8Bi1vbSWCxiy8a9xWLfi5ja
         B4Hqi9NaQRcMDd2NpNkj/Mo4q0z+6yMAOW4REm0huuFoA5nNsddxZy5M5TppgfOzaqQt
         l+6kwvZuWxsurAXI3+iu48GDFKSQ+2/g14UvIHYjTTewEIZr0a0qOPsDhk4cCaGclLr0
         MBZ6y6OpnGhNStmoX/58Q564Ql7g6ZeUXNdZoiniwyUE1kE/NqEMCE7rV2yVEG/9UDEA
         kJIGlktzdL33mYcSGD3KTKwA//D4GBDNIDiRORtNFU2uzMOTKvqSyfavBYg3gYLBZdn8
         9oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367595; x=1774972395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FfeAjXMVYCj1aDUUjyZzfRg1uUQ9OgRu51XWUh4xZSo=;
        b=a6j9M2pIsCoCZtBiQg2dvkDvHVG7m6Q1rf8rYN9XJkQdvLnk21r24PX9PdVdpttVbQ
         PLi6S511gUUBUv2bDdRK7JhROpbfqbgCVlP+hPPcm+Lg7YXbM0LJwRlBHgipfnJZj1+Z
         88FZpux9ONETvo2RudHSyWgJsDMHWikYBp4Rjw4G/vgZ9oJQ/qPIn/O7WpLBS4tls9ym
         eWDne7mlsCRpFaF0AweuM74Z1LwSX7DGUO+AJgHCyn/P0nLwCP2NEJ0MO62L05Vw0DRc
         V6Z8Y5gcIdHENHPttyhrttqDfN4u6MIItfMv0gltvzXlGC0Uea+UL9E2ypNuA5BdljmY
         mtgg==
X-Gm-Message-State: AOJu0Yy2Den/sApyp6t1h7AWkZ9sX0L++Y4YNSwy37SjQ70tm9JJhy+E
	qDCEuTpAJnRMwfepAm93jRja/BV4ssWwZkDZilA32XQ/cFucX64+CrZShS9ntu6l
X-Gm-Gg: ATEYQzwqtNx1LEHOVVr1wF32VOAdBOmi5VD2OVQDPYCX5mbcqEGp2b/oxUoW0Xrg95u
	ABq8BAUdWeAODukroYlmYuXjfi0yb2uy/vfhh65VhqMlULioxMDQkU6/mSp4eb/ZPuak7GeVWdT
	vqBvbX1GUkftm5DvYWAm3LDjmdgVyH5emFrrvd2g7FuEcZPpYADAptH2Ck8zZbCYKdTvwQY1r+O
	/0CsqxE0c2J1q7BMBOjqSXZEw2pk0C019hChgB5FJRxpJufqEyJ14liB0/y2XcvVwvWr5U0zpPU
	tL1Dqp/IWMB9tx8dmhEvK6QW2uA87mlSHdIkYhqOmBgG0PEZlRNuw7d2wl9ScejN2xR8MSjuO5d
	Q+jMpt9Eykqq0OuowGtCsih3vJE46kACrnyKI26BIjVoSgKQF22WkzDeDp32jrORnnK6d4LLURh
	t12FH80WQiZUGazPRkEkxgvYF4AEEfxpMzaYF+5KmNuKCH+GOOXaLNYrHrNEtAdERDXPhUPJ5Iv
	tpM9E/YLsJy6wW+7Y/X1Tk7YhNQ
X-Received: by 2002:a2e:894b:0:b0:389:fb7f:3def with SMTP id 38308e7fff4ca-38bf96ee30fmr42392691fa.23.1774367594407;
        Tue, 24 Mar 2026 08:53:14 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-69.dynamic.spd-mgts.ru. [46.138.191.69])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf9aa7cd0sm32567841fa.32.2026.03.24.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:53:14 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: fujita.tomonori@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	dakr@kernel.org
Subject: [PATCH net-next v2 5/5] net: phy: realtek: add Rust RTL8211F PHY driver
Date: Tue, 24 Mar 2026 18:52:49 +0300
Message-ID: <20260324155249.15098-6-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324155249.15098-1-iprintercanon@gmail.com>
References: <20260324155249.15098-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271149-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,umich.edu,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 091D13187FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a Rust implementation of the Realtek RTL8211F Gigabit Ethernet PHY
driver. This exercises the extended Rust PHY abstraction with
config_init, read_page/write_page, and interrupt support callbacks.

The driver implements:
  - config_init: Configures RGMII TX/RX internal delays based on the
    PHY interface mode, and disables PHY-level EEE so LPI is passed
    to the MAC. This matches the C driver's essential initialization.
    ALDPS and CLKOUT are left at hardware defaults since they depend
    on device tree properties and per-device private data not yet
    supported by the Rust PHY abstraction.
  - read_page / write_page: Standard RTL821x page select register.
  - config_intr: Enables/disables link status change interrupts.
  - handle_interrupt: Reads INSR and triggers the state machine on
    link change. PME/WoL interrupts are documented as unsupported.

The PHY ID 0x001cc916 matches the RTL8211F specifically.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/net/phy/realtek/Kconfig          |  12 +++
 drivers/net/phy/realtek/Makefile         |   1 +
 drivers/net/phy/realtek/rtl8211f_rust.rs | 127 +++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 drivers/net/phy/realtek/rtl8211f_rust.rs

diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
index b05c2a1e90243..4cc880683367d 100644
--- a/drivers/net/phy/realtek/Kconfig
+++ b/drivers/net/phy/realtek/Kconfig
@@ -13,3 +13,15 @@ config REALTEK_PHY_HWMON
 	  Optional hwmon support for the temperature sensor
 
 endif # REALTEK_PHY
+
+config REALTEK_RTL8211F_RUST_PHY
+	tristate "Rust Realtek RTL8211F PHY driver"
+	depends on RUST && RUST_PHYLIB_ABSTRACTIONS && !REALTEK_PHY
+	help
+	  Rust driver for the Realtek RTL8211F Gigabit Ethernet PHY.
+	  This is a Rust implementation demonstrating the extended PHY
+	  abstraction with config_init, paged register access, and
+	  interrupt support.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rtl8211f_rust.
diff --git a/drivers/net/phy/realtek/Makefile b/drivers/net/phy/realtek/Makefile
index dd21cf87f2f18..56ae5d2e39f65 100644
--- a/drivers/net/phy/realtek/Makefile
+++ b/drivers/net/phy/realtek/Makefile
@@ -2,3 +2,4 @@
 realtek-y			+= realtek_main.o
 realtek-$(CONFIG_REALTEK_PHY_HWMON) += realtek_hwmon.o
 obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
+obj-$(CONFIG_REALTEK_RTL8211F_RUST_PHY) += rtl8211f_rust.o
diff --git a/drivers/net/phy/realtek/rtl8211f_rust.rs b/drivers/net/phy/realtek/rtl8211f_rust.rs
new file mode 100644
index 0000000000000..f89f2fa55c677
--- /dev/null
+++ b/drivers/net/phy/realtek/rtl8211f_rust.rs
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Artem Lytkin <iprintercanon@gmail.com>
+
+//! Rust Realtek RTL8211F Gigabit Ethernet PHY driver.
+
+use kernel::irq::IrqReturn;
+use kernel::net::phy::{self, reg::C22, DeviceId};
+use kernel::prelude::*;
+
+// Page select register (vendor-specific, register 0x1f).
+const PAGE_SELECT: C22 = C22::vendor_specific::<0x1f>();
+
+// Interrupt status register (vendor-specific, register 0x1d).
+const INSR: C22 = C22::vendor_specific::<0x1d>();
+
+// Interrupt enable register number (used with paged access on page 0xa42).
+const INER_REG: u16 = 0x12;
+const INER_LINK_STATUS: u16 = 1 << 4;
+
+// RGMII TX delay register on page 0xd08.
+const TX_DELAY_REG: u16 = 0x11;
+const TX_DELAY_EN: u16 = 1 << 8;
+
+// RGMII RX delay register on page 0xd08.
+const RX_DELAY_REG: u16 = 0x15;
+const RX_DELAY_EN: u16 = 1 << 3;
+
+// PHY EEE enable bit in PHYCR2 (default page, register 0x19).
+const PHYCR2: u16 = 0x19;
+const PHYCR2_PHY_EEE_ENABLE: u16 = 1 << 5;
+
+kernel::module_phy_driver! {
+    drivers: [Rtl8211f],
+    device_table: [
+        DeviceId::new_with_driver::<Rtl8211f>(),
+    ],
+    name: "rtl8211f_rust",
+    authors: ["Artem Lytkin"],
+    description: "Rust Realtek RTL8211F PHY driver",
+    license: "GPL",
+}
+
+struct Rtl8211f;
+
+#[vtable]
+impl phy::Driver for Rtl8211f {
+    const NAME: &'static CStr = c"RTL8211F Gigabit Ethernet (Rust)";
+    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_exact_mask(0x001cc916);
+
+    fn config_init(dev: &mut phy::Device) -> Result {
+        // Configure RGMII delays based on the PHY interface mode.
+        // This matches the C driver's rtl8211f_config_rgmii_delay().
+        let iface = dev.interface();
+        let tx_delay = iface == bindings::phy_interface_t_PHY_INTERFACE_MODE_RGMII_ID
+            || iface == bindings::phy_interface_t_PHY_INTERFACE_MODE_RGMII_TXID;
+        let rx_delay = iface == bindings::phy_interface_t_PHY_INTERFACE_MODE_RGMII_ID
+            || iface == bindings::phy_interface_t_PHY_INTERFACE_MODE_RGMII_RXID;
+
+        dev.modify_paged(
+            0xd08,
+            TX_DELAY_REG,
+            TX_DELAY_EN,
+            if tx_delay { TX_DELAY_EN } else { 0 },
+        )?;
+        dev.modify_paged(
+            0xd08,
+            RX_DELAY_REG,
+            RX_DELAY_EN,
+            if rx_delay { RX_DELAY_EN } else { 0 },
+        )?;
+
+        // Disable PHY-level EEE so LPI is passed up to the MAC layer.
+        // PHYCR2 is on the default page, no page switch needed.
+        dev.modify(PHYCR2, PHYCR2_PHY_EEE_ENABLE, 0)?;
+
+        // Note: ALDPS and CLKOUT configuration are omitted because they
+        // depend on device tree properties and per-device private data,
+        // which are not yet supported by the Rust PHY abstraction.
+        // The hardware defaults are preserved for these settings.
+
+        Ok(())
+    }
+
+    fn read_page(dev: &mut phy::Device) -> Result<u16> {
+        dev.read(PAGE_SELECT)
+    }
+
+    fn write_page(dev: &mut phy::Device, page: u16) -> Result {
+        dev.write(PAGE_SELECT, page)
+    }
+
+    fn config_intr(dev: &mut phy::Device) -> Result {
+        if dev.is_interrupts_enabled() {
+            // Acknowledge any pending interrupt.
+            dev.read(INSR)?;
+            // Enable link status change interrupt.
+            dev.write_paged(0xa42, INER_REG, INER_LINK_STATUS)?;
+        } else {
+            // Disable all interrupts.
+            dev.write_paged(0xa42, INER_REG, 0)?;
+            // Acknowledge any pending interrupt.
+            dev.read(INSR)?;
+        }
+        Ok(())
+    }
+
+    fn handle_interrupt(dev: &mut phy::Device) -> IrqReturn {
+        let irq_status = match dev.read(INSR) {
+            Ok(val) => val,
+            Err(_) => {
+                dev.phy_error();
+                return IrqReturn::None;
+            }
+        };
+
+        if irq_status & INER_LINK_STATUS != 0 {
+            dev.trigger_machine();
+            return IrqReturn::Handled;
+        }
+
+        // Note: PME/Wake-on-LAN interrupt (bit 7) is not handled because
+        // WoL support requires pm_wakeup_event() binding and per-device
+        // private data, which are not yet available.
+
+        IrqReturn::None
+    }
+}
-- 
2.43.0


