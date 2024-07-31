Return-Path: <netdev+bounces-114391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2154F94255A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E5B23768
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18191B978;
	Wed, 31 Jul 2024 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZERVrB5Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5DF2E62C;
	Wed, 31 Jul 2024 04:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399744; cv=none; b=kUXiVnrML2W/JYX/Nc8YJTXCxwaeVhoKB26zpkwwY3URBCfjNysANIG05MjOG35gRwQ5exCNm9z8zI4eTw5lV/0quxgIlv0bPsyhkYC9adznUxpj6+zsopXeQn8Rj+m5vnmdvV+1kYyaYx43gxNrawJYxW78qjepcovlijS1Jp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399744; c=relaxed/simple;
	bh=brAXsZwdaCPpMphHTqbjgObKUlNZIvAgrHh7Hr8xtzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/k0aMVXknVKnAFkuw3ZtxYDAgWXnfJokQfjrAJREyzTt/ZbNExyh65OocGT08XA+ZLWz7Y2zU3uI2X3PsopoI48aZKp3ys7TPMrhaGvn0sV6h0OiBsOUyn1AfTMwGtAuCQ9zr4iG3nn3szqitX5u972TOGYJba//GfZmuiQ9eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZERVrB5Q; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb6b247db0so913484a91.2;
        Tue, 30 Jul 2024 21:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722399742; x=1723004542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqp7RU5NjGqF6r9+1ttQs0jeWqmQS94MecYHa/XG+D0=;
        b=ZERVrB5Qw2W82QRon3f8Aw/OamTI0tycCEhdCKqDkinagSQtM2henv1+1nDr/q3CCy
         zbhPAOIZCcV+YJ2G4+xC2hvbFIcBvimdJhoKEhymRMAOHs8UgH+QkpeFKRvSbGgg6Du/
         YqNFVq3YLsSs6OI6yJXyU6rIoyY80Nt1mr1DSaIH6jIdxKnsbMXJCtE26IwDfCttYi0K
         6jASgutpWXvIMpZlqwcMJg/VmNM62hz3d3rMD8dyxWsocYMrWp+gVvt/oV3i04D/2U/f
         07AZFav/pSTMjviaVWKQCpBWKeDmjvTO+/a2wQ4M20Uh+d606Wf5n5tv061eDDyI5Kjy
         yysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722399742; x=1723004542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqp7RU5NjGqF6r9+1ttQs0jeWqmQS94MecYHa/XG+D0=;
        b=QsEVwR6vpr4N66EhxHP97TpaZPWNnKvzZA+/5qRIjKCcIS8OawjHyTcwck7DY9+A+6
         zk8Hm277V2CAJCSIHKQD6Pn4yEeBd+UWNOrnQO8tEBLdikipwJ7AD9dTNVMi3SuUDMbv
         b9u8Fzy32swHLooq86dWiMMMTNBOrmy78oE7a058qUPalWsa5x8A7O21HTqt0TG0tx8Z
         Cc3I3i0tmkm4d+H0J1urUaUSxHc0YtzMGCuWhiHEoearQrZD9nLd0eifmkNw2bseGtqG
         bCM+A6zHQkn9dLXbwbjXkDERLrsPr8zuFHOsMsv6xTKHaXHxJJgE2ZTebuhHsZ7H+25n
         MXfw==
X-Gm-Message-State: AOJu0YyYcGWRsMAB6MZ230Hvd+OF9O/CxM2D+mTWEA9zo8sbcndB5rHZ
	Io4oVc8mTITFfK5vO+NQ950RuOywnQQrM++JscUpjvPBirxtQigihA9oJYah
X-Google-Smtp-Source: AGHT+IF7ktFCSOq1np7COQcf6zugMgf3B+HY62uB9RNqUq3vDCEUF5cVbQJ/reE9we660oL1DPdwWA==
X-Received: by 2002:a17:902:b7ca:b0:1f7:3ed:e7b2 with SMTP id d9443c01a7336-1fed67424e9mr123318645ad.0.1722399741650;
        Tue, 30 Jul 2024 21:22:21 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8d376sm110815145ad.18.2024.07.30.21.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 21:22:21 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: [PATCH net-next v2 4/6] rust: net::phy unified read/write API for C22 and C45 registers
Date: Wed, 31 Jul 2024 13:21:34 +0900
Message-Id: <20240731042136.201327-5-fujita.tomonori@gmail.com>
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

Add the unified read/write API for C22 and C45 registers. The
abstractions support access to only C22 registers now. Instead of
adding read/write_c45 methods specifically for C45, a new reg module
supports the unified API to access C22 and C45 registers with trait,
by calling an appropriate phylib functions.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
 MAINTAINERS                      |   1 +
 drivers/net/phy/ax88796b_rust.rs |   7 +-
 rust/kernel/net/phy.rs           |  32 ++---
 rust/kernel/net/phy/reg.rs       | 193 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   1 +
 5 files changed, 206 insertions(+), 28 deletions(-)
 create mode 100644 rust/kernel/net/phy/reg.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..2f85fad3b939 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8353,6 +8353,7 @@ L:	netdev@vger.kernel.org
 L:	rust-for-linux@vger.kernel.org
 S:	Maintained
 F:	rust/kernel/net/phy.rs
+F:	rust/kernel/net/phy/reg.rs
 
 EXEC & BINFMT API, ELF
 R:	Eric Biederman <ebiederm@xmission.com>
diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index 5c92572962dc..8c7eb009d9fc 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -6,7 +6,7 @@
 //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
 use kernel::{
     c_str,
-    net::phy::{self, DeviceId, Driver},
+    net::phy::{self, reg::C22, DeviceId, Driver},
     prelude::*,
     uapi,
 };
@@ -24,7 +24,6 @@
     license: "GPL",
 }
 
-const MII_BMCR: u16 = uapi::MII_BMCR as u16;
 const BMCR_SPEED100: u16 = uapi::BMCR_SPEED100 as u16;
 const BMCR_FULLDPLX: u16 = uapi::BMCR_FULLDPLX as u16;
 
@@ -33,7 +32,7 @@
 // Toggle BMCR_RESET bit off to accommodate broken AX8796B PHY implementation
 // such as used on the Individual Computers' X-Surf 100 Zorro card.
 fn asix_soft_reset(dev: &mut phy::Device) -> Result {
-    dev.write(uapi::MII_BMCR as u16, 0)?;
+    dev.write(C22::BMCR, 0)?;
     dev.genphy_soft_reset()
 }
 
@@ -55,7 +54,7 @@ fn read_status(dev: &mut phy::Device) -> Result<u16> {
         }
         // If MII_LPA is 0, phy_resolve_aneg_linkmode() will fail to resolve
         // linkmode so use MII_BMCR as default values.
-        let ret = dev.read(MII_BMCR)?;
+        let ret = dev.read(C22::BMCR)?;
 
         if ret & BMCR_SPEED100 != 0 {
             dev.set_speed(uapi::SPEED_100);
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 561f0e357f31..7ee06dd5a1b1 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -7,9 +7,10 @@
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
 use crate::{error::*, prelude::*, types::Opaque};
-
 use core::marker::PhantomData;
 
+pub mod reg;
+
 /// PHY state machine states.
 ///
 /// Corresponds to the kernel's [`enum phy_state`].
@@ -175,32 +176,15 @@ pub fn set_duplex(&mut self, mode: DuplexMode) {
         unsafe { (*phydev).duplex = v };
     }
 
-    /// Reads a given C22 PHY register.
+    /// Reads a PHY register.
     // This function reads a hardware register and updates the stats so takes `&mut self`.
-    pub fn read(&mut self, regnum: u16) -> Result<u16> {
-        let phydev = self.0.get();
-        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
-        // So it's just an FFI call, open code of `phy_read()` with a valid `phy_device` pointer
-        // `phydev`.
-        let ret = unsafe {
-            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into())
-        };
-        if ret < 0 {
-            Err(Error::from_errno(ret))
-        } else {
-            Ok(ret as u16)
-        }
+    pub fn read<R: reg::Register>(&mut self, reg: R) -> Result<u16> {
+        reg.read(self)
     }
 
-    /// Writes a given C22 PHY register.
-    pub fn write(&mut self, regnum: u16, val: u16) -> Result {
-        let phydev = self.0.get();
-        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
-        // So it's just an FFI call, open code of `phy_write()` with a valid `phy_device` pointer
-        // `phydev`.
-        to_result(unsafe {
-            bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into(), val)
-        })
+    /// Writes a PHY register.
+    pub fn write<R: reg::Register>(&mut self, reg: R, val: u16) -> Result {
+        reg.write(self, val)
     }
 
     /// Reads a paged register.
diff --git a/rust/kernel/net/phy/reg.rs b/rust/kernel/net/phy/reg.rs
new file mode 100644
index 000000000000..91f73179315e
--- /dev/null
+++ b/rust/kernel/net/phy/reg.rs
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 FUJITA Tomonori <fujita.tomonori@gmail.com>
+
+//! PHY register interfaces.
+//!
+//! This module provides support for accessing PHY registers via Ethernet
+//! management interface clause 22 and 45, as defined in IEEE 802.3.
+
+use super::Device;
+use crate::build_assert;
+use crate::error::*;
+use crate::uapi;
+
+mod private {
+    /// Marker that a trait cannot be implemented outside of this crate
+    pub trait Sealed {}
+}
+
+/// Accesses PHY registers.
+///
+/// This trait is used to implement the unified interface to access
+/// C22 and C45 PHY registers.
+///
+/// # Examples
+///
+/// ```ignore
+/// fn link_change_notify(dev: &mut Device) {
+///     // read C22 BMCR register
+///     dev.read(C22::BMCR);
+///     // read C45 PMA/PMD control 1 register
+///     dev.read(C45::new(Mmd::PMAPMD, 0));
+/// }
+/// ```
+pub trait Register: private::Sealed {
+    /// Reads a PHY register.
+    fn read(&self, dev: &mut Device) -> Result<u16>;
+
+    /// Writes a PHY register.
+    fn write(&self, dev: &mut Device, val: u16) -> Result;
+}
+
+/// A single MDIO clause 22 register address (5 bits).
+pub struct C22(u8);
+
+impl C22 {
+    /// Basic mode control.
+    pub const BMCR: Self = C22(0x00);
+    /// Basic mode status.
+    pub const BMSR: Self = C22(0x01);
+    /// PHY identifier 1.
+    pub const PHYSID1: Self = C22(0x02);
+    /// PHY identifier 2.
+    pub const PHYSID2: Self = C22(0x03);
+    /// Auto-negotiation advertisement.
+    pub const ADVERTISE: Self = C22(0x04);
+    /// Auto-negotiation link partner base page ability.
+    pub const LPA: Self = C22(0x05);
+    /// Auto-negotiation expansion.
+    pub const EXPANSION: Self = C22(0x06);
+    /// Auto-negotiation next page transmit.
+    pub const NEXT_PAGE_TRANSMIT: Self = C22(0x07);
+    /// Auto-negotiation link partner received next page.
+    pub const LP_RECEIVED_NEXT_PAGE: Self = C22(0x08);
+    /// Master-slave control.
+    pub const MASTER_SLAVE_CONTROL: Self = C22(0x09);
+    /// Master-slave status.
+    pub const MASTER_SLAVE_STATUS: Self = C22(0x0a);
+    /// PSE Control.
+    pub const PSE_CONTROL: Self = C22(0x0b);
+    /// PSE Status.
+    pub const PSE_STATUS: Self = C22(0x0c);
+    /// MMD Register control.
+    pub const MMD_CONTROL: Self = C22(0x0d);
+    /// MMD Register address data.
+    pub const MMD_DATA: Self = C22(0x0e);
+    /// Extended status.
+    pub const EXTENDED_STATUS: Self = C22(0x0f);
+
+    /// Creates a new instance of `C22` with a vendor specific register.
+    pub const fn vendor_specific<const N: u8>() -> Self {
+        build_assert!(
+            N > 0x0f && N < 0x20,
+            "Vendor-specific register address must be between 16 and 31"
+        );
+        C22(N)
+    }
+}
+
+impl private::Sealed for C22 {}
+
+impl Register for C22 {
+    fn read(&self, dev: &mut Device) -> Result<u16> {
+        let phydev = dev.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
+        // So it's just an FFI call, open code of `phy_read()` with a valid `phy_device` pointer
+        // `phydev`.
+        let ret = unsafe {
+            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, self.0.into())
+        };
+        to_result(ret)?;
+        Ok(ret as u16)
+    }
+
+    fn write(&self, dev: &mut Device, val: u16) -> Result {
+        let phydev = dev.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
+        // So it's just an FFI call, open code of `phy_write()` with a valid `phy_device` pointer
+        // `phydev`.
+        to_result(unsafe {
+            bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, self.0.into(), val)
+        })
+    }
+}
+
+/// A single MDIO clause 45 register device and address.
+pub struct Mmd(u8);
+
+impl Mmd {
+    /// Physical Medium Attachment/Dependent.
+    pub const PMAPMD: Self = Mmd(uapi::MDIO_MMD_PMAPMD as u8);
+    /// WAN interface sublayer.
+    pub const WIS: Self = Mmd(uapi::MDIO_MMD_WIS as u8);
+    /// Physical coding sublayer.
+    pub const PCS: Self = Mmd(uapi::MDIO_MMD_PCS as u8);
+    /// PHY Extender sublayer.
+    pub const PHYXS: Self = Mmd(uapi::MDIO_MMD_PHYXS as u8);
+    /// DTE Extender sublayer.
+    pub const DTEXS: Self = Mmd(uapi::MDIO_MMD_DTEXS as u8);
+    /// Transmission convergence.
+    pub const TC: Self = Mmd(uapi::MDIO_MMD_TC as u8);
+    /// Auto negotiation.
+    pub const AN: Self = Mmd(uapi::MDIO_MMD_AN as u8);
+    /// Separated PMA (1).
+    pub const SEPARATED_PMA1: Self = Mmd(8);
+    /// Separated PMA (2).
+    pub const SEPARATED_PMA2: Self = Mmd(9);
+    /// Separated PMA (3).
+    pub const SEPARATED_PMA3: Self = Mmd(10);
+    /// Separated PMA (4).
+    pub const SEPARATED_PMA4: Self = Mmd(11);
+    /// OFDM PMA/PMD.
+    pub const OFDM_PMAPMD: Self = Mmd(12);
+    /// Power unit.
+    pub const POWER_UNIT: Self = Mmd(13);
+    /// Clause 22 extension.
+    pub const C22_EXT: Self = Mmd(uapi::MDIO_MMD_C22EXT as u8);
+    /// Vendor specific 1.
+    pub const VEND1: Self = Mmd(uapi::MDIO_MMD_VEND1 as u8);
+    /// Vendor specific 2.
+    pub const VEND2: Self = Mmd(uapi::MDIO_MMD_VEND2 as u8);
+}
+
+/// A single MDIO clause 45 register device and address.
+///
+/// Clause 45 uses a 5-bit device address to access a specific MMD within
+/// a port, then a 16-bit register address to access a location within
+/// that device. `C45` represents this by storing a [`Mmd`] and
+/// a register number.
+pub struct C45 {
+    devad: Mmd,
+    regnum: u16,
+}
+
+impl C45 {
+    /// Creates a new instance of `C45`.
+    pub fn new(devad: Mmd, regnum: u16) -> Self {
+        Self { devad, regnum }
+    }
+}
+
+impl private::Sealed for C45 {}
+
+impl Register for C45 {
+    fn read(&self, dev: &mut Device) -> Result<u16> {
+        let phydev = dev.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
+        // So it's just an FFI call.
+        let ret =
+            unsafe { bindings::phy_read_mmd(phydev, self.devad.0.into(), self.regnum.into()) };
+        to_result(ret)?;
+        Ok(ret as u16)
+    }
+
+    fn write(&self, dev: &mut Device, val: u16) -> Result {
+        let phydev = dev.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
+        // So it's just an FFI call.
+        to_result(unsafe {
+            bindings::phy_write_mmd(phydev, self.devad.0.into(), self.regnum.into(), val)
+        })
+    }
+}
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 08f5e9334c9e..76d3f103e764 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -7,5 +7,6 @@
  */
 
 #include <uapi/asm-generic/ioctl.h>
+#include <uapi/linux/mdio.h>
 #include <uapi/linux/mii.h>
 #include <uapi/linux/ethtool.h>
-- 
2.34.1


