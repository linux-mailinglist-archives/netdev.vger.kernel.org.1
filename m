Return-Path: <netdev+bounces-274770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEYGDQb8zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:30:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC0538F3A4
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D3BE30A20A8
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F36392819;
	Thu,  2 Apr 2026 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="SsQbp6Of"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576D38C41A;
	Thu,  2 Apr 2026 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172418; cv=none; b=sBjKhbyrebPc4LbvaS4TP3c1jllgV7Wx/zElXFSOclzfmO/WznowrPLgrDia3kK4WsWjOm0ArYAS6pZw+YeI5B8hK7vWtgf4pN8l/CkIyq9W8aUD5rt1ti7rj3UE5nQ2BOlT5nRLMRVz17OsC1+4EmN2axMy0guBUKq7xCzn/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172418; c=relaxed/simple;
	bh=kJlR2Ns8kF7cTAUqt1+wsSt4O9jfhLCxG0g+f8scNsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TA/yUi/1WlE+QERZfRNsBc3Nbklows3ESLQ3DGibGa0TA3aMhMLm4GZPpSS2fV87dNLpfagyV95wlOyhHx6V3vTayby8BjRD/0ZEFtt7DJRbKulTvPmG/0HWM6dyedm8WBKPOlp0b0G47hV5FXvgQgLtOuL9plj54sLGZxkRkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=SsQbp6Of; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3956a5597;
	Fri, 3 Apr 2026 00:37:09 +0800 (GMT+08:00)
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
Subject: [RFC PATCH 3/6] rust: net: add minimal skbuff, netdevice, and stats abstractions
Date: Thu,  2 Apr 2026 12:36:37 -0400
Message-Id: <20260402163640.1079056-4-wenzhaoliao@ruc.edu.cn>
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
X-HM-Tid: 0a9d4f0e49d303a2kunm6754def456bf3b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSxkZVhhNTx8fHkhOTRodTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SsQbp6Ofx6tbC278bWXlNQ6nG9kdmGKiDUE8BCfpMlPftXPsyJ8yJgP1M4i/VE5pspJyEIXVP7amkY8K/TizYSGuanfrUGyQCxk/i28RWlBBXlZ+BqNhyGwxxOnqnB0jxeB2nfycZk0SJT/GAY91nqQfps7ylTsPQVl0H9nfHxo=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=3yj724qbxmPZznRzy+XcCgyvPzeCQ0S4i2y7mbpIovU=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,lunn.ch,davemloft.net,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274770-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ruc.edu.cn:dkim,ruc.edu.cn:email,ruc.edu.cn:mid]
X-Rspamd-Queue-Id: BEC0538F3A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add narrow Rust wrappers for sk_buff access, net_device private state,
and lightweight stats updates.

These APIs keep ownership with kernel-managed networking objects while
confining unsafe operations to the abstraction boundary.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/kernel/net.rs           |   3 +
 rust/kernel/net/netdevice.rs | 319 +++++++++++++++++++++++++++++++++++
 rust/kernel/net/skbuff.rs    |  67 ++++++++
 rust/kernel/net/stats.rs     |  17 ++
 4 files changed, 406 insertions(+)
 create mode 100644 rust/kernel/net/netdevice.rs
 create mode 100644 rust/kernel/net/skbuff.rs
 create mode 100644 rust/kernel/net/stats.rs

diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
index fe415cb369d3..a61bc76f4499 100644
--- a/rust/kernel/net.rs
+++ b/rust/kernel/net.rs
@@ -4,3 +4,6 @@
 
 #[cfg(CONFIG_RUST_PHYLIB_ABSTRACTIONS)]
 pub mod phy;
+pub mod netdevice;
+pub mod skbuff;
+pub mod stats;
diff --git a/rust/kernel/net/netdevice.rs b/rust/kernel/net/netdevice.rs
new file mode 100644
index 000000000000..1e6a63741422
--- /dev/null
+++ b/rust/kernel/net/netdevice.rs
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Network device support.
+//!
+//! C headers: [`include/linux/netdevice.h`](srctree/include/linux/netdevice.h)
+
+use crate::{
+    bindings,
+    error::from_result,
+    net::skbuff,
+    prelude::*,
+    types::Opaque,
+};
+
+/// Network device feature flags.
+pub type Features = bindings::netdev_features_t;
+
+/// `features` bits used by the MVP link-type setup path.
+pub mod features {
+    use super::{bindings, Features};
+
+    const fn bit(index: u32) -> Features {
+        1u64 << index
+    }
+
+    /// Equivalent to `NETIF_F_SG`.
+    pub const SG: Features = bit(bindings::NETIF_F_SG_BIT as u32);
+
+    /// Equivalent to `NETIF_F_FRAGLIST`.
+    pub const FRAGLIST: Features = bit(bindings::NETIF_F_FRAGLIST_BIT as u32);
+
+    /// Equivalent to `NETIF_F_HIGHDMA`.
+    pub const HIGHDMA: Features = bit(bindings::NETIF_F_HIGHDMA_BIT as u32);
+}
+
+/// MTU-related constants and helpers used by the MVP link-type setup path.
+pub mod mtu {
+    use super::bindings;
+
+    const fn align(value: usize, alignment: usize) -> usize {
+        (value + alignment - 1) & !(alignment - 1)
+    }
+
+    /// Equivalent to `NLMSG_GOODSIZE`.
+    pub const fn nlmsg_goodsize() -> u32 {
+        let page = if bindings::PAGE_SIZE < 8192 {
+            bindings::PAGE_SIZE
+        } else {
+            8192
+        };
+        let overhead = align(
+            core::mem::size_of::<bindings::skb_shared_info>(),
+            bindings::SMP_CACHE_BYTES as usize,
+        );
+
+        (page - overhead) as u32
+    }
+
+    /// Equivalent to `sizeof(struct nlmsghdr)`.
+    pub const NLMSGHDR: u32 = core::mem::size_of::<bindings::nlmsghdr>() as u32;
+}
+
+/// `priv_flags` bits used by the MVP link-type setup path.
+pub mod priv_flags {
+    use super::bindings;
+
+    /// Equivalent to `IFF_NO_QUEUE`.
+    pub const NO_QUEUE: u32 = bindings::netdev_priv_flags_IFF_NO_QUEUE;
+}
+
+/// `flags` bits used by the MVP link-type setup path.
+pub mod flags {
+    use super::bindings;
+
+    /// Equivalent to `IFF_NOARP`.
+    pub const NO_ARP: u32 = bindings::net_device_flags_IFF_NOARP;
+}
+
+/// Device type constants used by the MVP link-type setup path.
+pub mod device_type {
+    use super::bindings;
+
+    /// Equivalent to `ARPHRD_NETLINK`.
+    pub const NETLINK: u16 = bindings::ARPHRD_NETLINK as u16;
+}
+
+/// Per-cpu stat type constants used by the MVP link-type setup path.
+pub mod pcpu_stat_type {
+    use super::bindings;
+
+    /// Equivalent to `NETDEV_PCPU_STAT_LSTATS`.
+    pub const LSTATS: bindings::netdev_stat_type =
+        bindings::netdev_stat_type_NETDEV_PCPU_STAT_LSTATS;
+}
+
+/// Result of an `ndo_start_xmit` callback.
+pub enum TxOutcome {
+    /// The skb has been consumed and may be dropped by the abstraction.
+    Ok,
+
+    /// The device is temporarily busy; ownership of the skb goes back to the networking core.
+    Busy(skbuff::SkBuff),
+}
+
+/// Operations exposed by a network device for the MVP `nlmon` loop.
+///
+/// The callback trampolines live in this abstraction layer so that driver code does not have to
+/// touch raw kernel pointers or private storage casts directly.
+pub trait Operations: Send + Sync + 'static {
+    /// The type stored in `net_device` private storage.
+    ///
+    /// The RTNL/netdevice allocation path zero-initializes private storage before any driver
+    /// callback observes it, so implementations must accept the all-zero bit pattern.
+    type Private: Zeroable;
+
+    /// Device open callback.
+    fn open(dev: &mut Device, private: Pin<&mut Self::Private>) -> Result;
+
+    /// Device stop callback.
+    fn stop(dev: &mut Device, private: Pin<&mut Self::Private>) -> Result;
+
+    /// Packet transmit callback.
+    ///
+    /// This only exposes a shared device view: TX callbacks may run concurrently, so the
+    /// abstraction must not synthesize an exclusive borrow of either `net_device` or private
+    /// driver state here.
+    fn start_xmit(skb: skbuff::SkBuff, dev: &Device) -> TxOutcome;
+}
+
+/// A Rust wrapper over `struct net_device`.
+///
+/// # Invariants
+///
+/// - The wrapped pointer always points to a valid `struct net_device`.
+/// - The caller is responsible for only creating references in contexts where the kernel allows
+///   the accessed fields to be mutated.
+#[repr(transparent)]
+pub struct Device(Opaque<bindings::net_device>);
+
+impl Device {
+    /// Creates a mutable wrapper from a raw `net_device` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must point to a valid `struct net_device` for the lifetime of the returned
+    /// reference, and the caller must ensure that it is safe to mutate through it.
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::net_device) -> &'a mut Self {
+        let ptr = ptr.cast::<Self>();
+        // SAFETY: The caller guarantees the pointer is valid for the returned lifetime.
+        unsafe { &mut *ptr }
+    }
+
+    /// Creates a shared wrapper from a raw `net_device` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must point to a valid `struct net_device` for the lifetime of the returned
+    /// reference.
+    pub(crate) unsafe fn from_raw_ref<'a>(ptr: *mut bindings::net_device) -> &'a Self {
+        let ptr = ptr.cast::<Self>();
+        // SAFETY: The caller guarantees the pointer is valid for the returned lifetime.
+        unsafe { &*ptr }
+    }
+
+    /// Returns the wrapped raw `net_device` pointer.
+    pub(crate) fn as_ptr(&self) -> *mut bindings::net_device {
+        self.0.get()
+    }
+
+    /// Sets `dev->type`.
+    pub fn set_type(&mut self, device_type: u16) {
+        let dev = self.as_ptr();
+        // SAFETY: The type invariant guarantees that `dev` points to a valid `net_device`.
+        unsafe { (*dev).type_ = device_type };
+    }
+
+    /// ORs a bit into `dev->priv_flags`.
+    pub fn add_priv_flag(&mut self, flag: u32) {
+        let dev = self.as_ptr();
+        // SAFETY: The type invariant guarantees that `dev` points to a valid `net_device`, and the
+        // bindgen-generated accessors preserve the layout of the `priv_flags/lltx` union.
+        unsafe {
+            let flags = &mut (*dev).__bindgen_anon_1.__bindgen_anon_1;
+            let current = flags.priv_flags();
+            let flag = flag as usize;
+            flags.set_priv_flags(current | flag);
+        }
+    }
+
+    /// Sets `dev->lltx`.
+    pub fn set_lltx(&mut self, enabled: bool) {
+        let dev = self.as_ptr();
+        // SAFETY: The type invariant guarantees that `dev` points to a valid `net_device`, and the
+        // bindgen-generated accessors preserve the layout of the `priv_flags/lltx` union.
+        unsafe {
+            let flags = &mut (*dev).__bindgen_anon_1.__bindgen_anon_1;
+            flags.set_lltx(if enabled { 1 } else { 0 });
+        }
+    }
+
+    /// Stores a typed `net_device_ops` vtable pointer into `dev->netdev_ops`.
+    pub fn set_netdevice_ops<T: Operations>(&mut self) {
+        let dev = self.as_ptr();
+        // SAFETY: The type invariant guarantees that `dev` points to a valid `net_device`.
+        unsafe { (*dev).netdev_ops = OperationsVTable::<T>::build() };
+    }
+
+    /// Sets `dev->needs_free_netdev`.
+    pub fn set_needs_free_netdev(&mut self, enabled: bool) {
+        let dev = self.as_ptr();
+        // SAFETY: The type invariant guarantees that `dev` points to a valid `net_device`.
+        unsafe { (*dev).needs_free_netdev = enabled };
+    }
+
+    /// Sets `dev->features`.
+    pub fn set_features(&mut self, features: Features) {
+        let dev = self.as_ptr();
+        // SAFETY: The type invariant guarantees that `dev` points to a valid `net_device`.
+        unsafe { (*dev).features = features };
+    }
+
+    /// Sets `dev->flags`.
+    pub fn set_flags(&mut self, flags: u32) {
+        let dev = self.as_ptr();
+        // SAFETY: The type invariant guarantees that `dev` points to a valid `net_device`.
+        unsafe { (*dev).flags = flags };
+    }
+
+    /// Sets `dev->mtu`.
+    pub fn set_mtu(&mut self, mtu: u32) {
+        let dev = self.as_ptr();
+        // SAFETY: The type invariant guarantees that `dev` points to a valid `net_device`.
+        unsafe { (*dev).mtu = mtu };
+    }
+
+    /// Sets `dev->min_mtu`.
+    pub fn set_min_mtu(&mut self, mtu: u32) {
+        let dev = self.as_ptr();
+        // SAFETY: The type invariant guarantees that `dev` points to a valid `net_device`.
+        unsafe { (*dev).min_mtu = mtu };
+    }
+
+    /// Sets `dev->pcpu_stat_type`.
+    pub fn set_pcpu_stat_type(&mut self, stat_type: bindings::netdev_stat_type) {
+        let dev = self.as_ptr();
+        // SAFETY: The type invariant guarantees that `dev` points to a valid `net_device`.
+        unsafe { (*dev).set_pcpu_stat_type(stat_type) };
+    }
+
+    /// Returns a typed raw pointer to `net_device` private storage.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the current `net_device` was allocated with private storage for
+    /// `T`. Dereferencing the returned pointer additionally requires exclusive access to that
+    /// storage.
+    pub(crate) unsafe fn private_ptr<T>(&self) -> *mut T {
+        // SAFETY: The caller guarantees that the private storage really contains a `T`, and the
+        // helper/exported wrapper preserves the C `netdev_priv` semantics.
+        unsafe { bindings::netdev_priv(self.as_ptr() as *const bindings::net_device).cast::<T>() }
+    }
+}
+
+struct OperationsVTable<T: Operations>(core::marker::PhantomData<T>);
+
+impl<T: Operations> OperationsVTable<T> {
+    extern "C" fn open_callback(dev: *mut bindings::net_device) -> c_int {
+        from_result(|| {
+            // SAFETY: The networking core only calls this callback with a valid `net_device`.
+            let dev = unsafe { Device::from_raw(dev) };
+            // SAFETY: The `rtnl::Registration<T>` abstraction ties `priv_size` to `T::Private`.
+            let private = unsafe { Pin::new_unchecked(&mut *dev.private_ptr::<T::Private>()) };
+            T::open(dev, private)?;
+            Ok(0)
+        })
+    }
+
+    extern "C" fn stop_callback(dev: *mut bindings::net_device) -> c_int {
+        from_result(|| {
+            // SAFETY: The networking core only calls this callback with a valid `net_device`.
+            let dev = unsafe { Device::from_raw(dev) };
+            // SAFETY: The `rtnl::Registration<T>` abstraction ties `priv_size` to `T::Private`.
+            let private = unsafe { Pin::new_unchecked(&mut *dev.private_ptr::<T::Private>()) };
+            T::stop(dev, private)?;
+            Ok(0)
+        })
+    }
+
+    extern "C" fn start_xmit_callback(
+        skb: *mut bindings::sk_buff,
+        dev: *mut bindings::net_device,
+    ) -> bindings::netdev_tx {
+        // SAFETY: The networking core only calls this callback with a valid `net_device`.
+        let dev = unsafe { Device::from_raw_ref(dev) };
+        // SAFETY: The networking core transfers ownership of the callback skb to the driver.
+        let skb = unsafe { skbuff::SkBuff::from_raw_owned(skb) };
+
+        match T::start_xmit(skb, dev) {
+            TxOutcome::Ok => bindings::netdev_tx_NETDEV_TX_OK,
+            TxOutcome::Busy(skb) => {
+                let _ = skb.into_raw();
+                bindings::netdev_tx_NETDEV_TX_BUSY
+            }
+        }
+    }
+
+    const VTABLE: bindings::net_device_ops = bindings::net_device_ops {
+        ndo_open: Some(Self::open_callback),
+        ndo_stop: Some(Self::stop_callback),
+        ndo_start_xmit: Some(Self::start_xmit_callback),
+        // SAFETY: A zeroed `net_device_ops` is valid because omitted callbacks are represented by
+        // null pointers and all remaining fields are plain data/pointers.
+        ..unsafe { core::mem::zeroed() }
+    };
+
+    pub(crate) const fn build() -> &'static bindings::net_device_ops {
+        &Self::VTABLE
+    }
+}
diff --git a/rust/kernel/net/skbuff.rs b/rust/kernel/net/skbuff.rs
new file mode 100644
index 000000000000..32ca2bb24a75
--- /dev/null
+++ b/rust/kernel/net/skbuff.rs
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Socket-buffer ownership wrappers.
+//!
+//! C header: [`include/linux/skbuff.h`](srctree/include/linux/skbuff.h)
+
+use crate::bindings;
+
+use core::ptr::NonNull;
+
+/// Owns a single `struct sk_buff` passed into Rust from `ndo_start_xmit`.
+///
+/// # Invariants
+///
+/// - `ptr` is either `None` after ownership was handed back to the networking core, or it points
+///   to a valid `struct sk_buff` exclusively owned by this value.
+/// - Dropping this wrapper releases the skb exactly once via `dev_kfree_skb`.
+pub struct SkBuff {
+    ptr: Option<NonNull<bindings::sk_buff>>,
+}
+
+impl SkBuff {
+    /// Creates an owned skb wrapper from the callback argument.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid non-null skb pointer whose ownership is transferred to Rust for the
+    /// duration of the callback.
+    pub(crate) unsafe fn from_raw_owned(ptr: *mut bindings::sk_buff) -> Self {
+        Self {
+            // SAFETY: The caller guarantees ownership of a valid non-null skb pointer.
+            ptr: Some(unsafe { NonNull::new_unchecked(ptr) }),
+        }
+    }
+
+    fn ptr(&self) -> *mut bindings::sk_buff {
+        self.ptr
+            .expect("SkBuff ownership already transferred back to the core")
+            .as_ptr()
+    }
+
+    /// Returns `skb->len`.
+    pub fn len(&self) -> u32 {
+        // SAFETY: `Self` owns a valid skb until ownership is explicitly returned with `into_raw`.
+        unsafe { (*self.ptr()).len }
+    }
+
+    /// Hands ownership back to the networking core without freeing the skb.
+    pub(crate) fn into_raw(mut self) -> *mut bindings::sk_buff {
+        self.ptr
+            .take()
+            .expect("SkBuff ownership already transferred back to the core")
+            .as_ptr()
+    }
+}
+
+impl Drop for SkBuff {
+    fn drop(&mut self) {
+        let Some(ptr) = self.ptr.take() else {
+            return;
+        };
+
+        // SAFETY: `Self` owns the skb exactly once unless ownership has been transferred back to
+        // the networking core via `into_raw`.
+        unsafe { bindings::dev_kfree_skb(ptr.as_ptr()) };
+    }
+}
diff --git a/rust/kernel/net/stats.rs b/rust/kernel/net/stats.rs
new file mode 100644
index 000000000000..3e17f3b19c05
--- /dev/null
+++ b/rust/kernel/net/stats.rs
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Network-device statistics helpers.
+//!
+//! C header: [`include/linux/netdevice.h`](srctree/include/linux/netdevice.h)
+
+use crate::{
+    bindings,
+    net::netdevice,
+};
+
+/// Equivalent to `dev_lstats_add(dev, len)`.
+pub fn dev_lstats_add(dev: &netdevice::Device, len: u32) {
+    // SAFETY: The helper expects a valid `net_device *`; `netdevice::Device` maintains that
+    // invariant and the helper handles the required per-cpu synchronization internally.
+    unsafe { bindings::dev_lstats_add(dev.as_ptr(), len) };
+}
-- 
2.34.1


