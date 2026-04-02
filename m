Return-Path: <netdev+bounces-274629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHnLGAOhzmmQpAYAu9opvQ
	(envelope-from <netdev+bounces-274629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:01:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD0638C4CB
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CC653051852
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747153F7AB0;
	Thu,  2 Apr 2026 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="UBFS7DnH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m24124.xmail.ntesmail.com (mail-m24124.xmail.ntesmail.com [45.195.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1E3F7885;
	Thu,  2 Apr 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148170; cv=none; b=cu0+1EiIXTTTx8FUVNne7LPh9e8j5IYb7AKCwo+/2w4VBGtbtcr8FMeMK9lcvHJG8RxbWenwkGKmWbyrFZUCodFmhpoU3OyeZpkuEI7Sb9n4hOrsOTq6e76F+PPTDOlNuTmo2HI7GxmtZUG2bPQPMyujIKwet5FPYHRZtQHQXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148170; c=relaxed/simple;
	bh=tNI/lzfNVMFJLGZUOC7zw3RzUqFKt/DhWPHxoVwk7Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ebPtD+dYcAu4/S82lHjIeVTL91VS6yrrOK1CS7DupNqN41nL2c7KSmb5gH2+oFA9uqOKI/+gf780HrhUGsNR6i1X/KCyD9tPQH2l0xlPtFSmR4buOU4otPIhUJ8lEiUjtMbbMBVANxDLadFKzLppx2OXsqkLRW4VdAKwRUQTqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=UBFS7DnH; arc=none smtp.client-ip=45.195.24.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3956a559a;
	Fri, 3 Apr 2026 00:37:16 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 4/6] rust: net: add minimal rtnl registration and netlink tap support
Date: Thu,  2 Apr 2026 12:36:38 -0400
Message-Id: <20260402163640.1079056-5-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
References: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d4f0e62a503a2kunm6754def456bf48
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkpCVhlCGE8fTBhPQk1NT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=UBFS7DnHV82/lmeO6h5lzCGpw80eIx1OJjnjmlDGIa4Ai1okxOs9FQjUqHcIVrY4CMyMT4vymR+binmd1Qjy6I17ezcsYQC0i+Ue3b0QPXgZOiiv2yZOdAx+XkQDbrpbHGV0C4NohaHJMYxOGCZjb/5vd59IbU6mFWegJFmvMR0=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=hENdfJYTaCz+DNkQzaLUlsMdCmLD4GifK7zE2H7w848=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,lunn.ch,davemloft.net,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_URIBL_FAIL(0.00)[ruc.edu.cn:query timed out];
	TAGGED_FROM(0.00)[bounces-274629-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ruc.edu.cn:dkim,ruc.edu.cn:email,ruc.edu.cn:mid]
X-Rspamd-Queue-Id: 9AD0638C4CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the minimal pieces needed to register an rtnl link driver and to
attach or detach a netlink tap from a net_device.

The abstractions model kernel-owned registration lifetime and keep the
driver layer free of unsafe blocks.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/kernel/net.rs             |   2 +
 rust/kernel/net/netlink_tap.rs |  89 +++++++++++++
 rust/kernel/net/rtnl.rs        | 221 +++++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+)
 create mode 100644 rust/kernel/net/netlink_tap.rs
 create mode 100644 rust/kernel/net/rtnl.rs

diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
index a61bc76f4499..35459816c518 100644
--- a/rust/kernel/net.rs
+++ b/rust/kernel/net.rs
@@ -5,5 +5,7 @@
 #[cfg(CONFIG_RUST_PHYLIB_ABSTRACTIONS)]
 pub mod phy;
 pub mod netdevice;
+pub mod netlink_tap;
+pub mod rtnl;
 pub mod skbuff;
 pub mod stats;
diff --git a/rust/kernel/net/netlink_tap.rs b/rust/kernel/net/netlink_tap.rs
new file mode 100644
index 000000000000..b26461937c6c
--- /dev/null
+++ b/rust/kernel/net/netlink_tap.rs
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Netlink tap lifecycle helpers.
+//!
+//! C header: [`include/linux/netlink.h`](srctree/include/linux/netlink.h)
+
+use crate::{
+    bindings,
+    error::to_result,
+    net::netdevice,
+    prelude::*,
+    types::Opaque,
+    ThisModule,
+};
+
+/// Owns a `struct netlink_tap` plus its registration state.
+#[pin_data]
+#[derive(Zeroable)]
+pub struct Tap {
+    #[pin]
+    inner: Opaque<bindings::netlink_tap>,
+    registered: bool,
+}
+
+impl Tap {
+    /// Creates an unregistered tap.
+    pub const fn new() -> Self {
+        Self {
+            inner: Opaque::zeroed(),
+            registered: false,
+        }
+    }
+
+    /// Returns whether the tap is currently registered.
+    pub fn is_registered(&self) -> bool {
+        self.registered
+    }
+
+    /// Registers the tap for the provided device.
+    pub fn add(
+        self: Pin<&mut Self>,
+        dev: &netdevice::Device,
+        module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: The caller pinned `self`, so accessing the interior through the stable address is
+        // valid for the duration of this method.
+        let this = unsafe { self.get_unchecked_mut() };
+
+        if this.registered {
+            return Err(EBUSY);
+        }
+
+        let tap = this.inner.get();
+
+        // SAFETY: `tap` points to valid storage for `struct netlink_tap`.
+        unsafe {
+            (*tap).dev = dev.as_ptr();
+            (*tap).module = module.as_ptr();
+        }
+
+        // SAFETY: `tap` points to a valid `struct netlink_tap`.
+        to_result(unsafe { bindings::netlink_add_tap(tap) })?;
+        this.registered = true;
+        Ok(())
+    }
+
+    /// Unregisters the tap if it is currently active.
+    pub fn remove(self: Pin<&mut Self>) -> Result {
+        // SAFETY: The caller pinned `self`, so accessing the interior through the stable address is
+        // valid for the duration of this method.
+        let this = unsafe { self.get_unchecked_mut() };
+
+        if !this.registered {
+            return Ok(());
+        }
+
+        let tap = this.inner.get();
+
+        // SAFETY: `self.inner` contains a valid `struct netlink_tap` previously passed to
+        // `netlink_add_tap`.
+        to_result(unsafe { bindings::netlink_remove_tap(tap) })?;
+        this.registered = false;
+
+        // SAFETY: The tap has been removed and `netlink_remove_tap` waited for in-flight users via
+        // `synchronize_net`, so restoring the zeroed unregistered state is valid.
+        unsafe { tap.write(core::mem::zeroed()) };
+        Ok(())
+    }
+}
diff --git a/rust/kernel/net/rtnl.rs b/rust/kernel/net/rtnl.rs
new file mode 100644
index 000000000000..f3bddd29874f
--- /dev/null
+++ b/rust/kernel/net/rtnl.rs
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! RTNL link-type registration support.
+//!
+//! C headers:
+//! - [`include/net/rtnetlink.h`](srctree/include/net/rtnetlink.h)
+//! - [`include/uapi/linux/if_link.h`](srctree/include/uapi/linux/if_link.h)
+
+use crate::{
+    bindings,
+    error::{from_result, to_result},
+    net::netdevice,
+    prelude::*,
+    types::Opaque,
+};
+
+use core::{
+    marker::PhantomData,
+    mem::size_of,
+};
+
+/// Typed link-level netlink attribute selector.
+#[derive(Clone, Copy)]
+pub struct LinkAttr(usize);
+
+impl LinkAttr {
+    /// Equivalent to `IFLA_ADDRESS`.
+    pub const ADDRESS: Self = Self(bindings::IFLA_ADDRESS as usize);
+
+    const fn as_index(self) -> usize {
+        self.0
+    }
+}
+
+/// Typed info-level netlink attribute selector.
+#[derive(Clone, Copy)]
+pub struct InfoAttr(usize);
+
+impl InfoAttr {
+    /// Equivalent to `IFLA_INFO_KIND`.
+    pub const KIND: Self = Self(bindings::IFLA_INFO_KIND as usize);
+
+    /// Equivalent to `IFLA_INFO_DATA`.
+    pub const DATA: Self = Self(bindings::IFLA_INFO_DATA as usize);
+
+    const fn as_index(self) -> usize {
+        self.0
+    }
+}
+
+const LINK_ATTR_TABLE_LEN: usize = bindings::__IFLA_MAX as usize;
+const INFO_ATTR_TABLE_LEN: usize = bindings::__IFLA_INFO_MAX as usize;
+
+/// Validation context for `rtnl_link_ops::validate`.
+pub struct ValidateContext<'a> {
+    link_attrs: NlAttrTable,
+    data_attrs: NlAttrTable,
+    extack: Option<&'a mut ExtAck>,
+}
+
+impl<'a> ValidateContext<'a> {
+    fn new(
+        link_attrs: NlAttrTable,
+        data_attrs: NlAttrTable,
+        extack: Option<&'a mut ExtAck>,
+    ) -> Self {
+        Self {
+            link_attrs,
+            data_attrs,
+            extack,
+        }
+    }
+
+    /// Returns whether a link-level netlink attribute is present.
+    pub fn has_link_attr(&self, attr: LinkAttr) -> bool {
+        self.link_attrs.has_attr_index(attr.as_index())
+    }
+
+    /// Returns whether an info-level netlink attribute is present.
+    pub fn has_info_attr(&self, attr: InfoAttr) -> bool {
+        self.data_attrs.has_attr_index(attr.as_index())
+    }
+
+    /// Returns the optional extack wrapper.
+    pub fn extack(&mut self) -> Option<&mut ExtAck> {
+        self.extack.as_deref_mut()
+    }
+}
+
+/// Safe view over the `struct nlattr *tb[]` / `data[]` arrays passed to validate callbacks.
+#[derive(Clone, Copy)]
+pub struct NlAttrTable {
+    raw: *mut *mut bindings::nlattr,
+    len: usize,
+}
+
+impl NlAttrTable {
+    fn new(raw: *mut *mut bindings::nlattr, len: usize) -> Self {
+        Self { raw, len }
+    }
+
+    /// Returns `true` if the attribute slot contains a non-null pointer.
+    fn has_attr_index(&self, attr: usize) -> bool {
+        if self.raw.is_null() || attr >= self.len {
+            return false;
+        }
+
+        // SAFETY: The RTNL core provides these arrays for validate callbacks. Indexing is kept in
+        // the abstraction layer so driver code does not perform raw pointer arithmetic.
+        unsafe { !(*self.raw.add(attr)).is_null() }
+    }
+
+}
+
+/// Wrapper over `struct netlink_ext_ack`.
+#[repr(transparent)]
+pub struct ExtAck(Opaque<bindings::netlink_ext_ack>);
+
+impl ExtAck {
+    /// Creates a mutable wrapper from a raw extack pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be valid for the returned lifetime.
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::netlink_ext_ack) -> &'a mut Self {
+        let ptr = ptr.cast::<Self>();
+        // SAFETY: The caller guarantees validity for the returned lifetime.
+        unsafe { &mut *ptr }
+    }
+}
+
+/// A Rust RTNL link-type driver.
+pub trait Driver: netdevice::Operations {
+    /// The RTNL link kind, e.g. `"nlmon"`.
+    const KIND: &'static CStr;
+
+    /// Performs link-type setup.
+    fn setup(dev: &mut netdevice::Device);
+
+    /// Optional netlink validation.
+    fn validate(_ctx: &mut ValidateContext<'_>) -> Result {
+        Ok(())
+    }
+}
+
+/// Owns an RTNL link-type registration.
+#[pin_data(PinnedDrop)]
+pub struct Registration<T: Driver> {
+    #[pin]
+    ops: Opaque<bindings::rtnl_link_ops>,
+    _driver: PhantomData<T>,
+}
+
+// SAFETY: Shared references do not expose interior mutation beyond drop semantics.
+unsafe impl<T: Driver> Sync for Registration<T> {}
+
+// SAFETY: Registration and unregistration are handled by RTNL core code and can be performed from
+// the module init/exit path.
+unsafe impl<T: Driver> Send for Registration<T> {}
+
+impl<T: Driver> Registration<T> {
+    extern "C" fn setup_callback(dev: *mut bindings::net_device) {
+        // SAFETY: The RTNL core only calls setup with a valid `net_device`.
+        let dev = unsafe { netdevice::Device::from_raw(dev) };
+        dev.set_netdevice_ops::<T>();
+        T::setup(dev);
+    }
+
+    extern "C" fn validate_callback(
+        tb: *mut *mut bindings::nlattr,
+        data: *mut *mut bindings::nlattr,
+        extack: *mut bindings::netlink_ext_ack,
+    ) -> c_int {
+        from_result(|| {
+            let extack = if extack.is_null() {
+                None
+            } else {
+                // SAFETY: The RTNL core passes a valid extack pointer when non-null.
+                Some(unsafe { ExtAck::from_raw(extack) })
+            };
+            let mut ctx = ValidateContext::new(
+                NlAttrTable::new(tb, LINK_ATTR_TABLE_LEN),
+                NlAttrTable::new(data, INFO_ATTR_TABLE_LEN),
+                extack,
+            );
+            T::validate(&mut ctx)?;
+            Ok(0)
+        })
+    }
+
+    /// Creates a new RTNL registration object.
+    pub fn new() -> impl PinInit<Self, Error> {
+        build_assert!(!core::mem::needs_drop::<T::Private>());
+        try_pin_init!(Self {
+            ops <- Opaque::try_ffi_init(|ptr: *mut bindings::rtnl_link_ops| {
+                // SAFETY: All-zero is a valid initial state for the opaque RTNL ops structure.
+                unsafe { ptr.write(core::mem::zeroed()) };
+
+                // SAFETY: `ptr` is valid for writes for the duration of this initializer.
+                unsafe {
+                    (*ptr).kind = T::KIND.as_char_ptr();
+                    (*ptr).priv_size = size_of::<T::Private>();
+                    (*ptr).setup = Some(Self::setup_callback);
+                    (*ptr).validate = Some(Self::validate_callback);
+                }
+
+                // SAFETY: `ptr` now points to a fully initialized `rtnl_link_ops`.
+                to_result(unsafe { bindings::rtnl_link_register(ptr) })
+            }),
+            _driver: PhantomData,
+        })
+    }
+}
+
+#[pinned_drop]
+impl<T: Driver> PinnedDrop for Registration<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: The existence of `self` guarantees a successful earlier registration.
+        unsafe { bindings::rtnl_link_unregister(self.ops.get()) };
+    }
+}
-- 
2.34.1


