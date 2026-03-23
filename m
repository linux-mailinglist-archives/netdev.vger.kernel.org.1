Return-Path: <netdev+bounces-270727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YExCKpygwWmFUAQAu9opvQ
	(envelope-from <netdev+bounces-270727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:20:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC72FD1E0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45BC6301CCA0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDBA3DF011;
	Mon, 23 Mar 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og8Da343"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73613DE452
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297195; cv=none; b=okTB/fyuKVKEx7eeKarpmbGhTJYfsBC50HveIHb1gu1/x88BgcSUUEqzCI6z8o6+LCU721a5YxVytDQZbQaZQ3ToVwGBsvCfJ4IKs8b2SWRHF3gvKNvUDWWonGZRV2EtBigm3DCQ14NFzgLK+d64n9GQWvYZ93ippH0ZJXXDc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297195; c=relaxed/simple;
	bh=f/J5EMg+Drp9b+uB5wBZSB8iuerBEt2mi5AD+iiCZVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxKVEerEcDL0dWJyq2gs0UgL3v6n7BuoMvnuOMWmwxqmrGp5qZe+6cttPZDQpbK7r6ug9bbiQACv2mAqCy2XXZyJbksakq73xrwk3rDReH8XdjThZeDWOVJ+MxAXnAWSyIbjG9knTu5NrJdCgInVIi1rAx+GyoGrUVTdJd7gEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og8Da343; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a27c329e98so4119403e87.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774297192; x=1774901992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODa9V1ONAe27El6MccwX/8dOupDp0vcPfwidEacJlc0=;
        b=Og8Da3433VH0wr1RKvpm93m+VhrsxDMlTVyQQUa9BZafaeu6t9+aKoKAB/QGMxJonV
         9VshCDGwWznbyZjM24MGyiGlVDChFYYixB1n5Vt6/b7nsJ4oP8vL1f2GSVZvm/3+VHbk
         KP3iSdT4peANAB6Gn7+qEV/kcroyDV3ZA6ktkiBcGha+PBlh/A9LJA/X9+DrJMtPYNdS
         /f56pNsyUqgBYAefhQTRTBkCWCPESqUcSfN5RvUWqMWkRhI/Ky1vqb0jxQn0I0snhUfr
         D1cVRmh4wkMp4Oy0at5RhWDpUWA/i/Wm5WRjueHA+kB55RlbBb1pnPtT3VqoANI/EqkM
         h5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297192; x=1774901992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODa9V1ONAe27El6MccwX/8dOupDp0vcPfwidEacJlc0=;
        b=KZBuz7MP7WitdWZBHXiLIq7lPdErW57s123QXQQ+3QXMpbKziKS0xg2BO6EihlBTlo
         cQehTMHUOryxcSj/5UGFjtByJJ/zb9iUp2b51wqvNEsKQOjP5spV7oSva/Ve9aRazEZq
         M7MP8B0vxtdAKtDDT1r+uWmPD4Bkk7FYs31ep0eQ4qDDJNZwEfGF/r6CWjsMJTG1HZkr
         ikuR3n6+Vj/vyPNrR1hoHY0FYiTS3DErnOiuhsyA7SK4idkSEscwI6w8h3Q0GWMOG6sW
         lSNGSy9tIwjvls9xXtdp2LqVb+w24zMydHNFSGz7gBtrAMxEmMVQm+rzwSjiaNnfhRFO
         OrtA==
X-Gm-Message-State: AOJu0YwetDmMXuYJEAs9dT+Az2hUztZFAewfZuOfcPvvAMzSJxz8kLEI
	v5EsBFwTRK26r+wMR08MtI8bWIkUBNbD/kx1tdQI1ELIOez2pHuW8sQ5R/mMMHtm
X-Gm-Gg: ATEYQzzWpuQ6qYhB1jR5pn5IjfnNK0rsWJJcI8FKkZ8+/8/f174V68M5DeB9dcCG5al
	pGJmQ9dikhOmT6sCNpOvqH+JqrfxuVZ06FaqA8DxV5alAQPIRcg0dYjByuZ3AIAKjKbWcZHho4C
	C4XejG3tK+shwR5hLiGrfx5ssGXu38iPoiuVTX0LNLuAwPRqKauF42iLwwNTeblP2IHo53SJmRN
	Nz+g/nU+pC0oSQ85qDnBXkLAkBbhwpdopQpPyUQwDIrzzktjUsCGaFiJ1IzI04+W9eUXlguAODQ
	vqRXgATfYZe6RjudycjwjQUJfratdyuJH5ENAP8kthyW/6D7VlPIxbHiltLYco+dJRtfB391kSm
	Arkjbk6V6FH4h/rGiapI3FDF0vQBPJnUfBicEFSwYFTcwoR5O2Q+K4aDbvXIYD5H7crDOG/hldn
	Od7LjWNw7Tvj+odxyhl7tasVXee2yQrmHZKVpk0s9AvwuttBYJGtuHnNum5e7RkdGM1Mx9OdwlV
	wW+JSLkQxlRM4at8w==
X-Received: by 2002:a05:6512:12d5:b0:5a2:7ddd:ec16 with SMTP id 2adb3069b0e04-5a285b83c49mr4242012e87.40.1774297191526;
        Mon, 23 Mar 2026 13:19:51 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-69.dynamic.spd-mgts.ru. [46.138.191.69])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207365sm2720623e87.42.2026.03.23.13.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:19:50 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: fujita.tomonori@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	dakr@kernel.org
Subject: [PATCH 4/4] rust: phy: add interrupt support
Date: Mon, 23 Mar 2026 23:19:25 +0300
Message-ID: <20260323201925.8405-4-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323201925.8405-1-iprintercanon@gmail.com>
References: <20260323201925.8405-1-iprintercanon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270727-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FBC72FD1E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add interrupt handling support to the Rust PHY abstraction:

New driver callbacks:
  - config_intr: Enables or disables PHY link state change interrupts.
  - handle_interrupt: Called when the PHY's interrupt fires. Returns
    IrqReturn (reused from kernel::irq). Unlike other callbacks that
    use from_result(), this directly returns irqreturn_t matching the
    C callback signature.

New Device methods:
  - trigger_machine(): Schedules a PHY state machine update. Used in
    interrupt handlers after detecting a link change event.
  - phy_error(): Reports a PHY error and transitions the state machine
    to the error state. Produces a WARN_ON. Must be called with
    phy_device->lock held (which is the case inside handle_interrupt).

Both callbacks run with phy_device->lock held (from phy_interrupt()
in the threaded IRQ context), consistent with the existing callback
safety model.

These additions enable Rust PHY drivers to use interrupt-driven link
detection, which is required for production-quality drivers like the
Realtek RTL8211F.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 rust/kernel/net/phy.rs | 79 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 8fb34d34fe7de..3a75d3a90333e 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -6,7 +6,7 @@
 //!
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
-use crate::{device_id::RawDeviceId, error::*, prelude::*, types::Opaque};
+use crate::{device_id::RawDeviceId, error::*, irq::IrqReturn, prelude::*, types::Opaque};
 use core::{marker::PhantomData, ptr::addr_of_mut};
 
 pub mod reg;
@@ -360,6 +360,29 @@ pub fn genphy_read_abilities(&mut self) -> Result {
         // So it's just an FFI call.
         to_result(unsafe { bindings::genphy_read_abilities(phydev) })
     }
+
+    /// Triggers the PHY state machine to run.
+    ///
+    /// Used in interrupt handlers to schedule a state machine update
+    /// after processing an interrupt event.
+    pub fn trigger_machine(&mut self) {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        unsafe { bindings::phy_trigger_machine(phydev) };
+    }
+
+    /// Reports a PHY error and moves the state machine to the error state.
+    ///
+    /// Used in interrupt handlers when a register read fails. This will
+    /// produce a kernel `WARN_ON`. Must be called with `phy_device->lock`
+    /// held (which is the case inside [`Driver::handle_interrupt`]).
+    pub fn phy_error(&mut self) {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        unsafe { bindings::phy_error(phydev) };
+    }
 }
 
 impl AsRef<kernel::device::Device> for Device {
@@ -509,6 +532,35 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn config_intr_callback(
+        phydev: *mut bindings::phy_device,
+    ) -> c_int {
+        from_result(|| {
+            // SAFETY: This callback is called only in contexts
+            // where we hold `phy_device->lock`, so the accessors on
+            // `Device` are okay to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::config_intr(dev)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn handle_interrupt_callback(
+        phydev: *mut bindings::phy_device,
+    ) -> bindings::irqreturn_t {
+        // SAFETY: This callback is called only in contexts
+        // where we hold `phy_device->lock` (from phy_interrupt),
+        // so the accessors on `Device` are okay to call.
+        let dev = unsafe { Device::from_raw(phydev) };
+        T::handle_interrupt(dev) as core::ffi::c_uint
+    }
+
     unsafe extern "C" fn config_aneg_callback(phydev: *mut bindings::phy_device) -> c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
@@ -662,6 +714,16 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
         } else {
             None
         },
+        config_intr: if T::HAS_CONFIG_INTR {
+            Some(Adapter::<T>::config_intr_callback)
+        } else {
+            None
+        },
+        handle_interrupt: if T::HAS_HANDLE_INTERRUPT {
+            Some(Adapter::<T>::handle_interrupt_callback)
+        } else {
+            None
+        },
         config_aneg: if T::HAS_CONFIG_ANEG {
             Some(Adapter::<T>::config_aneg_callback)
         } else {
@@ -745,6 +807,21 @@ fn match_phy_device(_dev: &Device) -> bool {
         false
     }
 
+    /// Enables or disables PHY interrupts.
+    fn config_intr(_dev: &mut Device) -> Result {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Handles a PHY interrupt.
+    ///
+    /// Called when the PHY's interrupt line fires. The driver should read the
+    /// interrupt status register to determine the cause and call
+    /// [`Device::trigger_machine`] to schedule a state machine update.
+    /// Returns [`IrqReturn::Handled`] if the interrupt was from this PHY.
+    fn handle_interrupt(_dev: &mut Device) -> IrqReturn {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Configures the advertisement and resets auto-negotiation
     /// if auto-negotiation is enabled.
     fn config_aneg(_dev: &mut Device) -> Result {
-- 
2.43.0


