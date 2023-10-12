Return-Path: <netdev+bounces-40364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810CA7C6E96
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727F11C210D6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99B29424;
	Thu, 12 Oct 2023 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcR6FWgt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC052273F6;
	Thu, 12 Oct 2023 12:54:28 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62216FD;
	Thu, 12 Oct 2023 05:54:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-693400e09afso232598b3a.1;
        Thu, 12 Oct 2023 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697115264; x=1697720064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhNEQ7+r0oIb+0QxuiC3ANgztvngviruU2jPsw/HVNY=;
        b=NcR6FWgtIqOqirpVr20EurN85KrSerUM5BJQAv39msNoyGSAWKG6AR8IiqQ0Vtlnrj
         bRlG0xSGwUGwzFfKLhJUh9wddPuACVVDvshuwRE6EWfAvrjtGaELAbioQ4U1BgnGLOve
         RCXkMvksT+NPr5IY4L43qpK+pgQ+JvJ0TJ0KTSXNSQ0coQ9aj7so+5OdBKGCYHxkXzjw
         eItwz4KKWA8Fqo9Mp4r1VMkGzVHIKwSVL62Ivc3m7LSfSyQ1nTmvhfx6pxboxKusSxnr
         CZcyVsYOmBIInn11u94zUwZx1vYKpQ7mwfWX733XEg6Nf0ALlotm+fC54nou2T8QX8s2
         Gx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697115264; x=1697720064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhNEQ7+r0oIb+0QxuiC3ANgztvngviruU2jPsw/HVNY=;
        b=PPG95BkieVBqOPsRk2pmQo7NkZl/PWP9I1K4ebNGY6ckCZqOpck482Pyxpqqb5LEO5
         ZvojPi+Jpfro44ZSr7QjpUuAs6/y0fSPuFtSmCNFARu99WoONiKJOkDEHtDhDMA6LAOG
         elz0E3GXGFIsJhwztv+ZGf2W/POM/iTQew+BfDfLBq6/AVwFxZDWVIfbgz5id5kFQvCS
         /qUMxVhreynq+H80iQl3F1ldB+UNHE4cxGInpbMs08mDTAFaK0vh0OL2cYX3iVUO/1c6
         oWYuki+5wgRQPWQzHrXEtXZNHXFVAe2+UcXEKy6Ov3+8tRhjda6SwGaJL7TtoDepU/Cb
         X7XA==
X-Gm-Message-State: AOJu0YwPp68+CTyi5ap73+DV/SgIx05VJvxS7Gvz2IA+j/tVeNDFOgXd
	Sb5amw5QTK7jZgmrqqfGxyXjmgX6AIqxV5TM
X-Google-Smtp-Source: AGHT+IEeplpWZ9X+ByPDV2I0fZ0kONmS0ic/moh4zLAYev7XzoB9xEHTwACp4r8qOZvRWrIUzGLVyw==
X-Received: by 2002:a17:902:e5d2:b0:1c4:1cd3:8062 with SMTP id u18-20020a170902e5d200b001c41cd38062mr27021689plf.2.1697115264101;
        Thu, 12 Oct 2023 05:54:24 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r23-20020a170902be1700b001ba066c589dsm1886857pls.137.2023.10.12.05.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 05:54:23 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	wedsonaf@gmail.com,
	benno.lossin@proton.me,
	greg@kroah.com
Subject: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
Date: Thu, 12 Oct 2023 21:53:46 +0900
Message-Id: <20231012125349.2702474-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
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

This patch adds abstractions to implement network PHY drivers; the
driver registration and bindings for some of callback functions in
struct phy_driver and many genphy_ functions.

This feature is enabled with CONFIG_RUST_PHYLIB_ABSTRACTIONS=y.

This patch enables unstable const_maybe_uninit_zeroed feature for
kernel crate to enable unsafe code to handle a constant value with
uninitialized data. With the feature, the abstractions can initialize
a phy_driver structure with zero easily; instead of initializing all
the members by hand. It's supposed to be stable in the not so distant
future.

Link: https://github.com/rust-lang/rust/pull/116218

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 init/Kconfig                    |   8 +
 rust/Makefile                   |   1 +
 rust/bindings/bindings_helper.h |   3 +
 rust/kernel/lib.rs              |   3 +
 rust/kernel/net.rs              |   6 +
 rust/kernel/net/phy.rs          | 679 ++++++++++++++++++++++++++++++++
 6 files changed, 700 insertions(+)
 create mode 100644 rust/kernel/net.rs
 create mode 100644 rust/kernel/net/phy.rs

diff --git a/init/Kconfig b/init/Kconfig
index 6d35728b94b2..0fc6f5568748 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1903,6 +1903,14 @@ config RUST
 
 	  If unsure, say N.
 
+config RUST_PHYLIB_ABSTRACTIONS
+        bool "PHYLIB abstractions support"
+        depends on RUST
+        depends on PHYLIB=y
+        help
+          Adds support needed for PHY drivers written in Rust. It provides
+          a wrapper around the C phylib core.
+
 config RUSTC_VERSION_TEXT
 	string
 	depends on RUST
diff --git a/rust/Makefile b/rust/Makefile
index 87958e864be0..f67e55945b36 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -331,6 +331,7 @@ quiet_cmd_bindgen = BINDGEN $@
       cmd_bindgen = \
 	$(BINDGEN) $< $(bindgen_target_flags) \
 		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
+		--rustified-enum phy_state\
 		--no-debug '.*' \
 		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
 		$(bindgen_target_cflags) $(bindgen_target_extra)
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c91a3c24f607..ec4ee09a34ad 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,6 +8,9 @@
 
 #include <kunit/test.h>
 #include <linux/errname.h>
+#include <linux/ethtool.h>
+#include <linux/mdio.h>
+#include <linux/phy.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e8811700239a..0588422e273c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -14,6 +14,7 @@
 #![no_std]
 #![feature(allocator_api)]
 #![feature(coerce_unsized)]
+#![feature(const_maybe_uninit_zeroed)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
 #![feature(receiver_trait)]
@@ -36,6 +37,8 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+#[cfg(CONFIG_NET)]
+pub mod net;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
new file mode 100644
index 000000000000..fe415cb369d3
--- /dev/null
+++ b/rust/kernel/net.rs
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Networking.
+
+#[cfg(CONFIG_RUST_PHYLIB_ABSTRACTIONS)]
+pub mod phy;
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
new file mode 100644
index 000000000000..7b2a3a52ff25
--- /dev/null
+++ b/rust/kernel/net/phy.rs
@@ -0,0 +1,679 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
+
+//! Network PHY device.
+//!
+//! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h).
+
+use crate::{bindings, error::*, prelude::vtable, str::CStr, types::Opaque};
+use core::marker::PhantomData;
+
+/// Corresponds to the kernel's `enum phy_state`.
+#[derive(PartialEq)]
+pub enum DeviceState {
+    /// PHY device and driver are not ready for anything.
+    Down,
+    /// PHY is ready to send and receive packets.
+    Ready,
+    /// PHY is up, but no polling or interrupts are done.
+    Halted,
+    /// PHY is up, but is in an error state.
+    Error,
+    /// PHY and attached device are ready to do work.
+    Up,
+    /// PHY is currently running.
+    Running,
+    /// PHY is up, but not currently plugged in.
+    NoLink,
+    /// PHY is performing a cable test.
+    CableTest,
+}
+
+/// Represents duplex mode.
+pub enum DuplexMode {
+    /// PHY is in full-duplex mode.
+    Full,
+    /// PHY is in half-duplex mode.
+    Half,
+    /// PHY is in unknown duplex mode.
+    Unknown,
+}
+
+/// An instance of a PHY device.
+///
+/// Wraps the kernel's `struct phy_device`.
+///
+/// # Invariants
+///
+/// `self.0` is always in a valid state.
+#[repr(transparent)]
+pub struct Device(Opaque<bindings::phy_device>);
+
+impl Device {
+    /// Creates a new [`Device`] instance from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// This function can be called only in the callbacks in `phy_driver`. PHYLIB guarantees
+    /// the exclusive access for the duration of the lifetime `'a`.
+    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `Device` type being transparent makes the cast ok.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Gets the id of the PHY.
+    pub fn phy_id(&self) -> u32 {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        unsafe { (*phydev).phy_id }
+    }
+
+    /// Gets the state of the PHY.
+    pub fn state(&self) -> DeviceState {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        let state = unsafe { (*phydev).state };
+        // FIXME: Here we trust that PHYLIB doesn't set a random value to this `state` enum.
+        // If PHYLIB has a bug to do so, it results in UB. We will use the safe code
+        // automatically generated from C enum once it becomes possible.
+        match state {
+            bindings::phy_state::PHY_DOWN => DeviceState::Down,
+            bindings::phy_state::PHY_READY => DeviceState::Ready,
+            bindings::phy_state::PHY_HALTED => DeviceState::Halted,
+            bindings::phy_state::PHY_ERROR => DeviceState::Error,
+            bindings::phy_state::PHY_UP => DeviceState::Up,
+            bindings::phy_state::PHY_RUNNING => DeviceState::Running,
+            bindings::phy_state::PHY_NOLINK => DeviceState::NoLink,
+            bindings::phy_state::PHY_CABLETEST => DeviceState::CableTest,
+        }
+    }
+
+    /// Returns true if the link is up.
+    pub fn get_link(&self) -> bool {
+        const LINK_IS_UP: u32 = 1;
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        let phydev = unsafe { *self.0.get() };
+        phydev.link() == LINK_IS_UP
+    }
+
+    /// Returns true if auto-negotiation is enabled.
+    pub fn is_autoneg_enabled(&self) -> bool {
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        let phydev = unsafe { *self.0.get() };
+        phydev.autoneg() == bindings::AUTONEG_ENABLE
+    }
+
+    /// Returns true if auto-negotiation is completed.
+    pub fn is_autoneg_completed(&self) -> bool {
+        const AUTONEG_COMPLETED: u32 = 1;
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        let phydev = unsafe { *self.0.get() };
+        phydev.autoneg_complete() == AUTONEG_COMPLETED
+    }
+
+    /// Sets the speed of the PHY.
+    pub fn set_speed(&self, speed: u32) {
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        let mut phydev = unsafe { *self.0.get() };
+        phydev.speed = speed as i32;
+    }
+
+    /// Sets duplex mode.
+    pub fn set_duplex(&self, mode: DuplexMode) {
+        let v = match mode {
+            DuplexMode::Full => bindings::DUPLEX_FULL as i32,
+            DuplexMode::Half => bindings::DUPLEX_HALF as i32,
+            DuplexMode::Unknown => bindings::DUPLEX_UNKNOWN as i32,
+        };
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        let mut phydev = unsafe { *self.0.get() };
+        phydev.duplex = v;
+    }
+
+    /// Reads a given C22 PHY register.
+    pub fn read(&self, regnum: u16) -> Result<u16> {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        let ret = unsafe {
+            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into())
+        };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u16)
+        }
+    }
+
+    /// Writes a given C22 PHY register.
+    pub fn write(&self, regnum: u16, val: u16) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        to_result(unsafe {
+            bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into(), val)
+        })
+    }
+
+    /// Reads a paged register.
+    pub fn read_paged(&self, page: u16, regnum: u16) -> Result<u16> {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        let ret = unsafe { bindings::phy_read_paged(phydev, page.into(), regnum.into()) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u16)
+        }
+    }
+
+    /// Resolves the advertisements into PHY settings.
+    pub fn resolve_aneg_linkmode(&self) {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        unsafe { bindings::phy_resolve_aneg_linkmode(phydev) };
+    }
+
+    /// Executes software reset the PHY via `BMCR_RESET` bit.
+    pub fn genphy_soft_reset(&self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        to_result(unsafe { bindings::genphy_soft_reset(phydev) })
+    }
+
+    /// Initializes the PHY.
+    pub fn init_hw(&self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // so an FFI call with a valid pointer.
+        to_result(unsafe { bindings::phy_init_hw(phydev) })
+    }
+
+    /// Starts auto-negotiation.
+    pub fn start_aneg(&self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        to_result(unsafe { bindings::phy_start_aneg(phydev) })
+    }
+
+    /// Resumes the PHY via `BMCR_PDOWN` bit.
+    pub fn genphy_resume(&self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        to_result(unsafe { bindings::genphy_resume(phydev) })
+    }
+
+    /// Suspends the PHY via `BMCR_PDOWN` bit.
+    pub fn genphy_suspend(&self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        to_result(unsafe { bindings::genphy_suspend(phydev) })
+    }
+
+    /// Checks the link status and updates current link state.
+    pub fn genphy_read_status(&self) -> Result<u16> {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        let ret = unsafe { bindings::genphy_read_status(phydev) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u16)
+        }
+    }
+
+    /// Updates the link status.
+    pub fn genphy_update_link(&self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        to_result(unsafe { bindings::genphy_update_link(phydev) })
+    }
+
+    /// Reads link partner ability.
+    pub fn genphy_read_lpa(&self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        to_result(unsafe { bindings::genphy_read_lpa(phydev) })
+    }
+
+    /// Reads PHY abilities.
+    pub fn genphy_read_abilities(&self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So an FFI call with a valid pointer.
+        to_result(unsafe { bindings::genphy_read_abilities(phydev) })
+    }
+}
+
+/// Defines certain other features this PHY supports (like interrupts).
+pub mod flags {
+    /// PHY is internal.
+    pub const IS_INTERNAL: u32 = bindings::PHY_IS_INTERNAL;
+    /// PHY needs to be reset after the refclk is enabled.
+    pub const RST_AFTER_CLK_EN: u32 = bindings::PHY_RST_AFTER_CLK_EN;
+    /// Polling is used to detect PHY status changes.
+    pub const POLL_CABLE_TEST: u32 = bindings::PHY_POLL_CABLE_TEST;
+    /// Don't suspend.
+    pub const ALWAYS_CALL_SUSPEND: u32 = bindings::PHY_ALWAYS_CALL_SUSPEND;
+}
+
+/// An adapter for the registration of a PHY driver.
+struct Adapter<T: Driver> {
+    _p: PhantomData<T>,
+}
+
+impl<T: Driver> Adapter<T> {
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn soft_reset_callback(
+        phydev: *mut bindings::phy_device,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: Preconditions ensure `phydev` is valid.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::soft_reset(dev)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn get_features_callback(
+        phydev: *mut bindings::phy_device,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: Preconditions ensure `phydev` is valid.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::get_features(dev)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn suspend_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: Preconditions ensure `phydev` is valid.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::suspend(dev)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn resume_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: Preconditions ensure `phydev` is valid.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::resume(dev)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn config_aneg_callback(
+        phydev: *mut bindings::phy_device,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: Preconditions ensure `phydev` is valid.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::config_aneg(dev)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn read_status_callback(
+        phydev: *mut bindings::phy_device,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: Preconditions ensure `phydev` is valid.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::read_status(dev)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn match_phy_device_callback(
+        phydev: *mut bindings::phy_device,
+    ) -> core::ffi::c_int {
+        // SAFETY: Preconditions ensure `phydev` is valid.
+        let dev = unsafe { Device::from_raw(phydev) };
+        T::match_phy_device(dev) as i32
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn read_mmd_callback(
+        phydev: *mut bindings::phy_device,
+        devnum: i32,
+        regnum: u16,
+    ) -> i32 {
+        from_result(|| {
+            // SAFETY: Preconditions ensure `phydev` is valid.
+            let dev = unsafe { Device::from_raw(phydev) };
+            // CAST: the C side verifies devnum < 32.
+            let ret = T::read_mmd(dev, devnum as u8, regnum)?;
+            Ok(ret.into())
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn write_mmd_callback(
+        phydev: *mut bindings::phy_device,
+        devnum: i32,
+        regnum: u16,
+        val: u16,
+    ) -> i32 {
+        from_result(|| {
+            // SAFETY: Preconditions ensure `phydev` is valid.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::write_mmd(dev, devnum as u8, regnum, val)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn link_change_notify_callback(phydev: *mut bindings::phy_device) {
+        // SAFETY: Preconditions ensure `phydev` is valid.
+        let dev = unsafe { Device::from_raw(phydev) };
+        T::link_change_notify(dev);
+    }
+}
+
+/// An instance of a PHY driver.
+///
+/// Wraps the kernel's `struct phy_driver`.
+#[repr(transparent)]
+pub struct DriverType(Opaque<bindings::phy_driver>);
+
+/// Creates the kernel's `phy_driver` instance.
+///
+/// This is used by [`module_phy_driver`] macro to create a static array of `phy_driver`.
+///
+/// [`module_phy_driver`]: crate::module_phy_driver
+pub const fn create_phy_driver<T: Driver>() -> DriverType {
+    DriverType(Opaque::new(bindings::phy_driver {
+        name: T::NAME.as_char_ptr().cast_mut(),
+        flags: T::FLAGS,
+        phy_id: T::PHY_DEVICE_ID.id,
+        phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),
+        soft_reset: if T::HAS_SOFT_RESET {
+            Some(Adapter::<T>::soft_reset_callback)
+        } else {
+            None
+        },
+        get_features: if T::HAS_GET_FEATURES {
+            Some(Adapter::<T>::get_features_callback)
+        } else {
+            None
+        },
+        match_phy_device: if T::HAS_MATCH_PHY_DEVICE {
+            Some(Adapter::<T>::match_phy_device_callback)
+        } else {
+            None
+        },
+        suspend: if T::HAS_SUSPEND {
+            Some(Adapter::<T>::suspend_callback)
+        } else {
+            None
+        },
+        resume: if T::HAS_RESUME {
+            Some(Adapter::<T>::resume_callback)
+        } else {
+            None
+        },
+        config_aneg: if T::HAS_CONFIG_ANEG {
+            Some(Adapter::<T>::config_aneg_callback)
+        } else {
+            None
+        },
+        read_status: if T::HAS_READ_STATUS {
+            Some(Adapter::<T>::read_status_callback)
+        } else {
+            None
+        },
+        read_mmd: if T::HAS_READ_MMD {
+            Some(Adapter::<T>::read_mmd_callback)
+        } else {
+            None
+        },
+        write_mmd: if T::HAS_WRITE_MMD {
+            Some(Adapter::<T>::write_mmd_callback)
+        } else {
+            None
+        },
+        link_change_notify: if T::HAS_LINK_CHANGE_NOTIFY {
+            Some(Adapter::<T>::link_change_notify_callback)
+        } else {
+            None
+        },
+        // SAFETY: The rest is zeroed out to initialize `struct phy_driver`,
+        // sets `Option<&F>` to be `None`.
+        ..unsafe { core::mem::MaybeUninit::<bindings::phy_driver>::zeroed().assume_init() }
+    }))
+}
+
+/// Corresponds to functions in `struct phy_driver`.
+///
+/// This is used to register a PHY driver.
+#[vtable]
+pub trait Driver {
+    /// Defines certain other features this PHY supports.
+    /// It is a combination of the flags in the [`flags`] module.
+    const FLAGS: u32 = 0;
+
+    /// The friendly name of this PHY type.
+    const NAME: &'static CStr;
+
+    /// This driver only works for PHYs with IDs which match this field.
+    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_custom_mask(0, 0);
+
+    /// Issues a PHY software reset.
+    fn soft_reset(_dev: &Device) -> Result {
+        Err(code::ENOTSUPP)
+    }
+
+    /// Probes the hardware to determine what abilities it has.
+    fn get_features(_dev: &Device) -> Result {
+        Err(code::ENOTSUPP)
+    }
+
+    /// Returns true if this is a suitable driver for the given phydev.
+    /// If not implemented, matching is based on [`Driver::PHY_DEVICE_ID`].
+    fn match_phy_device(_dev: &Device) -> bool {
+        false
+    }
+
+    /// Configures the advertisement and resets auto-negotiation
+    /// if auto-negotiation is enabled.
+    fn config_aneg(_dev: &Device) -> Result {
+        Err(code::ENOTSUPP)
+    }
+
+    /// Determines the negotiated speed and duplex.
+    fn read_status(_dev: &Device) -> Result<u16> {
+        Err(code::ENOTSUPP)
+    }
+
+    /// Suspends the hardware, saving state if needed.
+    fn suspend(_dev: &Device) -> Result {
+        Err(code::ENOTSUPP)
+    }
+
+    /// Resumes the hardware, restoring state if needed.
+    fn resume(_dev: &Device) -> Result {
+        Err(code::ENOTSUPP)
+    }
+
+    /// Overrides the default MMD read function for reading a MMD register.
+    fn read_mmd(_dev: &Device, _devnum: u8, _regnum: u16) -> Result<u16> {
+        Err(code::ENOTSUPP)
+    }
+
+    /// Overrides the default MMD write function for writing a MMD register.
+    fn write_mmd(_dev: &Device, _devnum: u8, _regnum: u16, _val: u16) -> Result {
+        Err(code::ENOTSUPP)
+    }
+
+    /// Callback for notification of link change.
+    fn link_change_notify(_dev: &Device) {}
+}
+
+/// Registration structure for a PHY driver.
+///
+/// # Invariants
+///
+/// All elements of the `drivers` slice are valid and currently registered
+/// to the kernel via `phy_drivers_register`.
+pub struct Registration {
+    drivers: &'static [DriverType],
+}
+
+impl Registration {
+    /// Registers a PHY driver.
+    ///
+    /// # Safety
+    ///
+    /// The values of the `drivers` array must be initialized properly.
+    pub unsafe fn register(
+        module: &'static crate::ThisModule,
+        drivers: &'static [DriverType],
+    ) -> Result<Self> {
+        if drivers.is_empty() {
+            return Err(code::EINVAL);
+        }
+        // SAFETY: The safety requirements of the function ensure that `drivers` array are initialized properly.
+        // So an FFI call with a valid pointer.
+        to_result(unsafe {
+            bindings::phy_drivers_register(drivers[0].0.get(), drivers.len().try_into()?, module.0)
+        })?;
+        // INVARIANT: The safety requirements of the function and the success of `phy_drivers_register` ensure
+        // the invariants.
+        Ok(Registration { drivers })
+    }
+}
+
+impl Drop for Registration {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that `self.drivers` is valid.
+        unsafe {
+            bindings::phy_drivers_unregister(self.drivers[0].0.get(), self.drivers.len() as i32)
+        };
+    }
+}
+
+// SAFETY: `Registration` does not expose any of its state across threads.
+unsafe impl Send for Registration {}
+
+// SAFETY: `Registration` does not expose any of its state across threads.
+unsafe impl Sync for Registration {}
+
+/// Represents the kernel's `struct mdio_device_id`.
+pub struct DeviceId {
+    id: u32,
+    mask: DeviceMask,
+}
+
+impl DeviceId {
+    /// Creates a new instance with the exact match mask.
+    pub const fn new_with_exact_mask(id: u32) -> Self {
+        DeviceId {
+            id,
+            mask: DeviceMask::Exact,
+        }
+    }
+
+    /// Creates a new instance with the model match mask.
+    pub const fn new_with_model_mask(id: u32) -> Self {
+        DeviceId {
+            id,
+            mask: DeviceMask::Model,
+        }
+    }
+
+    /// Creates a new instance with the vendor match mask.
+    pub const fn new_with_vendor_mask(id: u32) -> Self {
+        DeviceId {
+            id,
+            mask: DeviceMask::Vendor,
+        }
+    }
+
+    /// Creates a new instance with a custom match mask.
+    pub const fn new_with_custom_mask(id: u32, mask: u32) -> Self {
+        DeviceId {
+            id,
+            mask: DeviceMask::Custom(mask),
+        }
+    }
+
+    /// Creates a new instance from [`Driver`].
+    pub const fn new_with_driver<T: Driver>() -> Self {
+        T::PHY_DEVICE_ID
+    }
+
+    /// Get a `mask` as u32.
+    pub const fn mask_as_int(&self) -> u32 {
+        self.mask.as_int()
+    }
+
+    // macro use only
+    #[doc(hidden)]
+    pub const fn as_mdio_device_id(&self) -> bindings::mdio_device_id {
+        bindings::mdio_device_id {
+            phy_id: self.id,
+            phy_id_mask: self.mask.as_int(),
+        }
+    }
+}
+
+enum DeviceMask {
+    Exact,
+    Model,
+    Vendor,
+    Custom(u32),
+}
+
+impl DeviceMask {
+    const MASK_EXACT: u32 = !0;
+    const MASK_MODEL: u32 = !0 << 4;
+    const MASK_VENDOR: u32 = !0 << 10;
+
+    const fn as_int(&self) -> u32 {
+        match self {
+            DeviceMask::Exact => Self::MASK_EXACT,
+            DeviceMask::Model => Self::MASK_MODEL,
+            DeviceMask::Vendor => Self::MASK_VENDOR,
+            DeviceMask::Custom(mask) => *mask,
+        }
+    }
+}
-- 
2.34.1


