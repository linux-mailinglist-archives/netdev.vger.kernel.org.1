Return-Path: <netdev+bounces-270726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IrxHfahwWknUQQAu9opvQ
	(envelope-from <netdev+bounces-270726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:26:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FBB2FD2FF
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14425307828D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6133DEFE7;
	Mon, 23 Mar 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi9AWFBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C23DDDB1
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297194; cv=none; b=SGLvMpEJZVpG46QjqATIbjG/NWfDKZRXw5gFVllAZK//V50zfxj/RMoAQEb7OWVRprWo4ccj+7r9Y4dGwjzOtU08LgUlHIPBjbr+vpqldPGyzk7ppCmq39iS+Bz9G9+A1bfK38UA0yOfR3vrcUe9YaloT8Dfwor0RrDMZu+Guzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297194; c=relaxed/simple;
	bh=jaVCjToO+gpl0Xhk9wiD6+mjNpwl6V+EE9cW4gICpe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg8C11N5QWBXq6WL0uKuftgdYC6WtX69no4mL6SFo/OhORcipQXR0itrrxj3YEgkWheAPk7hn0ZDK2rLhqyWqqN4K+9MZRdA0acGxt2voTuu+Pk/tzGxxbttnkfpbD8JyzFCyKkZqyPN7EVSoRN06vqTVopcSvamp3iXmz9r2E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi9AWFBS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a76ba6a78so30103311fa.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774297190; x=1774901990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKcR9KDseDj3TeztQh/9bADUvUV+mYPWEL56B3A2aDE=;
        b=fi9AWFBSX8xA2HTD7SW1FLe3Ua4YhEFQixpl2S1+0vHJnNqLTVWVDLQ/TI8X1JsD29
         QD4evJFeOOUsjsv0yHS0rGy1sn9fUxhZjFMs8IivJiqeYkXemAO3oL42KoouoBa7rz/7
         10qmxLb8bL9ftQeVLS9Aop+k5AU31wLDwg85g48TYYr2u51O3yxuccTlbuVv99M80CnZ
         ZZ+9ULW1V/1yPbQgXRRGlKBgRd1iSwtRvk8LQsrsI1Pu8bLK9GPr6WDGIfOsbkx6fY/P
         hWibIpkCawphjYzRNNcKB2iu1TMtCjGMCgUbw5LbjSdHGnLV9hOEG5yGSLcGyA8guWrh
         q/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297190; x=1774901990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tKcR9KDseDj3TeztQh/9bADUvUV+mYPWEL56B3A2aDE=;
        b=AnWaYU8pmTV1zTDu84z6RUUsAfWsouiL9fcpYRmJc0qUMG7LFmCIqVfg3EhdQUml8M
         qGngRM3M/9QrbyAwUhnt9E4Q6UWyKcuXEYzaVsuJHXrIIkgNF8/IOxPzkTtHjuT5XAW6
         Jo5JPlPRFrt6qahUW1rkOIUa9gnkFsCQAHWLRWE/HUgjU5tpdJbM+B2GpbFaACJnfnmX
         iI1c55C8yrIdtgE0lWoguLlguX0YT+6b0cvDeuDZ3QKRRsmGGaM4LDpBPWm9ULdyCCh3
         wuAVc5oskaI+R9+HPYhyCjiwThg1Tws48duxDCp6nKDdC9RSAI9+I8mvxrGLbx67vGSC
         O2dg==
X-Gm-Message-State: AOJu0YwDPAjcbhJ+clkbDzQ80wHrIrW2BMiXRL9QNqXIPWSKswlfq5Q2
	qDYkgGlgEqpOYEwAo2B38D59H6tRalqpZc6S7PyELik1Qv0VfSRm7/wAwVOtuLk+
X-Gm-Gg: ATEYQzzuC7YQWQolSQmj/Q75WEtLyYIB9gXjlFB1/zkY2O00fTLLDRQ+CVuQy2aFBon
	chlQqTJngboJ/mnkDyPXv76TzfGeBXs270mDbaVkUn04vOg8rP+7hkMT3GfsuaIturuYy8ORZHh
	Ai8iEULM6V39svqcbCEQEWofeq6byZ3PLKRJr9fXRuvdAgXyssAFFtkT7Lgenbu9e5bGphlEa/S
	R2gjFvb6K+H57S+942DQbtcmSIB6utfXZclFSuOLvpZfLnLn2b4S9+D9yiI1r30bYC+N0Mg2vLR
	nJgRyMU43XdjsUdM2vi1ec8e3lZID4dgP5OC7tNdmzf6zhYwBjbWBcBgwCW38woTxOJD6qxm+w+
	9dfArlB1Oo/70flAtHgQpbruJbtsHdbmNMpg0hkosaJ4+saBfNJlVcYC57kLFLn2Y7dtfxzrlrY
	ecd9IffDXbldXsnng0V2VdRTIFDj1K0DrMEHc7uTcAS4pw4S7+Hd3Bv6VUJJX8f88X4dkACmNUh
	VmQi0qSMmocx66FlA==
X-Received: by 2002:a05:6512:234c:b0:5a1:3485:1c29 with SMTP id 2adb3069b0e04-5a285ae2a00mr3763339e87.6.1774297190199;
        Mon, 23 Mar 2026 13:19:50 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-69.dynamic.spd-mgts.ru. [46.138.191.69])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207365sm2720623e87.42.2026.03.23.13.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:19:49 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: fujita.tomonori@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	dakr@kernel.org
Subject: [PATCH 3/4] rust: phy: add config_init, read_page, and write_page callbacks
Date: Mon, 23 Mar 2026 23:19:24 +0300
Message-ID: <20260323201925.8405-3-iprintercanon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270726-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04FBB2FD2FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add three new driver callbacks to the PHY abstraction:

  - config_init: Called to initialize the PHY after a reset. This is
    needed by nearly all real-world PHY drivers to configure
    vendor-specific registers (RGMII delays, LED settings, etc.).
    config_init was previously proposed in an RFC for the Rockchip PHY
    driver but not merged at that time. This re-introduces it in a
    form consistent with the existing vtable infrastructure.

  - read_page / write_page: Required by page-based PHY chips (Realtek,
    Marvell) for the kernel's paged register access infrastructure.
    When these callbacks are registered, phy_read_paged(),
    phy_write_paged(), and phy_modify_paged() use them to switch
    register pages. Both must be implemented together.

Each callback follows the established Adapter<T> pattern with
unsafe extern "C" fn bridging to the Rust Driver trait method, and
conditional registration in create_phy_driver() via HAS_* flags
generated by the #[vtable] macro.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 rust/kernel/net/phy.rs | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 43d1ee360268b..8fb34d34fe7de 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -390,6 +390,51 @@ struct Adapter<T: Driver> {
 }
 
 impl<T: Driver> Adapter<T> {
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn config_init_callback(phydev: *mut bindings::phy_device) -> c_int {
+        from_result(|| {
+            // SAFETY: The C core calls config_init with the PHY mutex held
+            // (from phy_init_hw), so the accessors on `Device` are okay to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::config_init(dev)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn read_page_callback(phydev: *mut bindings::phy_device) -> c_int {
+        from_result(|| {
+            // SAFETY: This callback is called only in contexts
+            // where we hold `phy_device->lock`, so the accessors on
+            // `Device` are okay to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            let page = T::read_page(dev)?;
+            Ok(page.into())
+        })
+    }
+
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn write_page_callback(
+        phydev: *mut bindings::phy_device,
+        page: c_int,
+    ) -> c_int {
+        from_result(|| {
+            // SAFETY: This callback is called only in contexts
+            // where we hold `phy_device->lock`, so the accessors on
+            // `Device` are okay to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            let page = u16::try_from(page).map_err(|_| code::EINVAL)?;
+            T::write_page(dev, page)?;
+            Ok(0)
+        })
+    }
+
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
@@ -582,6 +627,11 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
         flags: T::FLAGS,
         phy_id: T::PHY_DEVICE_ID.id(),
         phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),
+        config_init: if T::HAS_CONFIG_INIT {
+            Some(Adapter::<T>::config_init_callback)
+        } else {
+            None
+        },
         soft_reset: if T::HAS_SOFT_RESET {
             Some(Adapter::<T>::soft_reset_callback)
         } else {
@@ -632,6 +682,16 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
         } else {
             None
         },
+        read_page: if T::HAS_READ_PAGE {
+            Some(Adapter::<T>::read_page_callback)
+        } else {
+            None
+        },
+        write_page: if T::HAS_WRITE_PAGE {
+            Some(Adapter::<T>::write_page_callback)
+        } else {
+            None
+        },
         link_change_notify: if T::HAS_LINK_CHANGE_NOTIFY {
             Some(Adapter::<T>::link_change_notify_callback)
         } else {
@@ -659,6 +719,11 @@ pub trait Driver {
     /// The default id and mask are zero.
     const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_custom_mask(0, 0);
 
+    /// Called to initialize the PHY, including after a reset.
+    fn config_init(_dev: &mut Device) -> Result {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Issues a PHY software reset.
     fn soft_reset(_dev: &mut Device) -> Result {
         build_error!(VTABLE_DEFAULT_ERROR)
@@ -711,6 +776,24 @@ fn write_mmd(_dev: &mut Device, _devnum: u8, _regnum: u16, _val: u16) -> Result
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
+    /// Returns the current PHY register page number.
+    ///
+    /// Must be implemented together with [`Driver::write_page`]. The kernel's
+    /// paged register access infrastructure requires both callbacks to be
+    /// present.
+    fn read_page(_dev: &mut Device) -> Result<u16> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Sets the current PHY register page number.
+    ///
+    /// Must be implemented together with [`Driver::read_page`]. The kernel's
+    /// paged register access infrastructure requires both callbacks to be
+    /// present.
+    fn write_page(_dev: &mut Device, _page: u16) -> Result {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Callback for notification of link change.
     fn link_change_notify(_dev: &mut Device) {}
 }
-- 
2.43.0


