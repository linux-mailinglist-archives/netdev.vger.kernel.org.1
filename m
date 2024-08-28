Return-Path: <netdev+bounces-122650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3895D962165
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4C3B23696
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D7415B104;
	Wed, 28 Aug 2024 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M73gkQyA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C1165F15;
	Wed, 28 Aug 2024 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830619; cv=none; b=cZxtwz+P/wQ1pbpKqgFltkcrYsm2AIhZ7n3e4OBf9cdv3H0bXUbKH7IBHycraIwlAr/HH5XbfmXsNFXXCl1tCvmUcKRnv1udtkiRsfOksnuldboNcSFqKw7aqV/MurpJhssf8rJip1u8cQqxj31wo7gS/ZoJDlbPrnnkJWK5QTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830619; c=relaxed/simple;
	bh=56e05tdstgexLmP1+5MIdKv3GhEp1YJ7z7LR0/FHPOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdeVAnCvkc/AeRkzNO8/tEwhjaeAuz3EWgeNoc59/IOkK/GfTPpsNEf2lKxliteQdnqsiXQPhY7276AZEub+18k9VKs/xg0JUlngv24rlJkYfwrzjR4mwPIR9D2VBTg6Yc5CwT6LainFlWBx57JP5e3qalgERMSKFCK8LUGclyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M73gkQyA; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3dc16d00ba6so986440b6e.0;
        Wed, 28 Aug 2024 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724830616; x=1725435416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5haTbZ7ZfXMbo1JOz7kTHDQXYr/nQ+nxqrOAzO6uXug=;
        b=M73gkQyAKSWGBSKB6l+p+YikIol3vL+ylyd9eeVryD7eFr0WMaRJyxNzidzTIFH5m9
         VjYgteDaHJEUKLYQK8j+8KmmVklp8Hxgh2ksLwJOcAVBlRCjUIuigLzECjvZDYQJJ2Ux
         wSe6J2rP2QyfPW1WIL39RDG6eV/hFeEFSFsKr2cghv58D6YuT4J8bUA1DYhHdE2qojxV
         xLHHYk+Zw1uC1fAKEzr0MOAjspU9n0l2WKxjQicWY0pum3NTeIK7q38KsVdZ5c1Ic5zj
         ZNdOiu+rdU1IOxxUU1rLe79niKLEIuWts6xP7pSs4a0lm93CtEvTWPo7XtyA2n4AhxIt
         i2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724830616; x=1725435416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5haTbZ7ZfXMbo1JOz7kTHDQXYr/nQ+nxqrOAzO6uXug=;
        b=I2gGSbzhVm6jmofukfB2Q9ASk7naYfNsFjmZbDbQBxL9gaFHXK2NMupq7CsQDRNlvU
         LSqUnDzLk4Z2E+R9Bm3MRZINV+N5w4UUIYcgdT6II9QDLWm7r0s+gjiyKqTmQMgMWit8
         ILymOG4b4Z0ldYWF1Fc2nqNEV32vhm+FtuFDXmvT6rttvqhuH0/ES6Asfh6IaLtAXPn5
         F8neB4eZzHNM30dHHeZUeguU3EvYg6dLSVa/VCv0zS+OppZQMrlYN+vOgapea/Rkn+t9
         5l0UrJbeK8DEzVW1BUspJf0Bo2E9+pGExJzBHVcs9bifLZ1Xj6vt5WM+322cbuPD9Xqk
         nryQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6J//b2c6Kk0ISGRVe3txHYyjveGw5KHASpXmPloN+/8smPnUS45hvkyAY5x2cP1h3oqQrCqcscwa+rV6Qaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyge3YHnFXhClfHsH5+ssKJx9pGyIi0/+mDGCZVz4xILqSXrEz
	Bz0++2BnlXN4KOQ24qd6ACnoCJfKbl7PMvcwoL+3TcIYcVpg/byrbOGgYO3QaGo=
X-Google-Smtp-Source: AGHT+IEuZHz4sUPUU0Ir3841liDOlKXbDdHwAKl8k33GfrPwc/8xLYjuXlFxRtOToc9SaHET8+kM1Q==
X-Received: by 2002:a05:687c:2bd6:b0:270:6bae:5573 with SMTP id 586e51a60fabf-2777d1f22eemr1005991fac.28.1724830615419;
        Wed, 28 Aug 2024 00:36:55 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac98286sm9016225a12.5.2024.08.28.00.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:36:55 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v8 4/6] rust: net::phy unified read/write API for C22 and C45 registers
Date: Wed, 28 Aug 2024 07:35:14 +0000
Message-ID: <20240828073516.128290-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828073516.128290-1-fujita.tomonori@gmail.com>
References: <20240828073516.128290-1-fujita.tomonori@gmail.com>
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

Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS                      |   1 +
 drivers/net/phy/ax88796b_rust.rs |   7 +-
 rust/kernel/net/phy.rs           |  31 ++---
 rust/kernel/net/phy/reg.rs       | 196 +++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h          |   1 +
 5 files changed, 209 insertions(+), 27 deletions(-)
 create mode 100644 rust/kernel/net/phy/reg.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 30a9b9450e11..ec395140668e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8357,6 +8357,7 @@ L:	netdev@vger.kernel.org
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
index b16e8c10a0a2..45866db14c76 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -9,6 +9,8 @@
 use crate::{error::*, prelude::*, types::Opaque};
 use core::{marker::PhantomData, ptr::addr_of_mut};
 
+pub mod reg;
+
 /// PHY state machine states.
 ///
 /// Corresponds to the kernel's [`enum phy_state`].
@@ -177,32 +179,15 @@ pub fn set_duplex(&mut self, mode: DuplexMode) {
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
index 000000000000..4563737a9675
--- /dev/null
+++ b/rust/kernel/net/phy/reg.rs
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 FUJITA Tomonori <fujita.tomonori@gmail.com>
+
+//! PHY register interfaces.
+//!
+//! This module provides support for accessing PHY registers in the
+//! Ethernet management interface clauses 22 and 45 register namespaces, as
+//! defined in IEEE 802.3.
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
+#[derive(Copy, Clone, Debug)]
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
+#[derive(Copy, Clone, Debug)]
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


