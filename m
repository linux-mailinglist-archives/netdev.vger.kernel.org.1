Return-Path: <netdev+bounces-269432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCl1DEzqu2kKqQIAu9opvQ
	(envelope-from <netdev+bounces-269432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:21:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6242CB14E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 641A23238E7C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09DC18FDBD;
	Thu, 19 Mar 2026 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Goaft2Kl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEFA4C81;
	Thu, 19 Mar 2026 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922673; cv=none; b=W3eZRRiORgAAzi/tey68/3TFN9Id7V7ICt/XDb4dQEM2mnHMHWOaSpwPhH2KW8wV5oEFlDvMcyYyCkA+iQZlosnTHDKXCQ6iT/gJKn8VWRVuH0NcwdGTl+BJjVb9cc6AdO0FL8mgtKr+YRp/+VJQys0jL7BaOfa+IYwX22oEIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922673; c=relaxed/simple;
	bh=VwEsF9EQGPz3i57kHhrp/z50QBvX35y/RpPO/7tkNjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMI5M5sYhXDdqd2hB4RZdDuf6hVn9FGp8fEqt6dcxjBCMseZCba5SVL2c9hurhzPIrwpt3hZcLnsmx8v048FdMnVyTqtH/lbAI38gxZk7JilFKKhdkrGc9hjOI+NFxEgxo08JPxMI7pMvu1S1CFSbF68RdFIriKoNc/6LlkbERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Goaft2Kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE464C2BCAF;
	Thu, 19 Mar 2026 12:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773922673;
	bh=VwEsF9EQGPz3i57kHhrp/z50QBvX35y/RpPO/7tkNjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Goaft2KltY334Mnjm72+JEJd908o1WEP1iQ7VjHEzaal8j6yDbrnHA78Wl4H8ubo7
	 NBk+Az/YXWyUEmA6BP9uSZHONh8a/gEUs+JbCRZGcHr6R3zfic/61qKYOAIokVSi7k
	 2YdpOlxZMGm/Al6l1zCAtS8gMBorZiBzdZ3rr6pNmObP9Croz2xAXEIVLuFxrqUsR0
	 94ScIc+aGqp2JS7liGzCotFUPlPsMugdUU5eCi7fsp09eKue/XVS7b41l9TTssk9fq
	 oC595rnqjxuOc7ELQHMeIgLbzryvRwIbjS2cG1aAtch3fVaN8YcPOksMA6yah7HRpX
	 c6XjpAwXEuIRw==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Yury Norov <yury.norov@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tamir Duberstein <tamird@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>,
	rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH v3 4/4] rust: make `build_assert` module the home of related macros
Date: Thu, 19 Mar 2026 12:16:48 +0000
Message-ID: <20260319121653.2975748-5-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260319121653.2975748-1-gary@kernel.org>
References: <20260319121653.2975748-1-gary@kernel.org>
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269432-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,gmail.com,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gary@garyguo.net];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	FROM_NEQ_ENVFROM(0.00)[gary@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email,garyguo.net:replyto]
X-Rspamd-Queue-Id: 7F6242CB14E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gary Guo <gary@garyguo.net>

Given the macro scoping rules, all macros are rendered 3 times, in the
module, in the top-level of kernel crate, and in the prelude.

Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
re-export inside `build_assert` module so the top-level items are hidden.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/bitfield.rs    |  4 ++--
 drivers/gpu/nova-core/num.rs         |  2 +-
 rust/kernel/build_assert.rs          | 19 ++++++++++++-------
 rust/kernel/dma.rs                   |  5 +++--
 rust/kernel/io/register.rs           | 19 ++++++++++++-------
 rust/kernel/io/resource.rs           |  2 +-
 rust/kernel/ioctl.rs                 |  2 +-
 rust/kernel/net/phy/reg.rs           |  8 +++++---
 rust/kernel/num/bounded.rs           |  2 +-
 rust/kernel/prelude.rs               |  3 ++-
 rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
 rust/kernel/sync/atomic/predefine.rs |  2 +-
 rust/kernel/sync/locked_by.rs        |  2 +-
 rust/kernel/sync/refcount.rs         |  8 +++++---
 rust/kernel/xarray.rs                | 10 ++++++++--
 15 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
index 16e143658c51..c3e1235ad7fb 100644
--- a/drivers/gpu/nova-core/bitfield.rs
+++ b/drivers/gpu/nova-core/bitfield.rs
@@ -170,7 +170,7 @@ impl $name {
     (@check_field_bounds $hi:tt:$lo:tt $field:ident as bool) => {
         #[allow(clippy::eq_op)]
         const _: () = {
-            ::kernel::build_assert!(
+            ::kernel::build_assert::build_assert!(
                 $hi == $lo,
                 concat!("boolean field `", stringify!($field), "` covers more than one bit")
             );
@@ -181,7 +181,7 @@ impl $name {
     (@check_field_bounds $hi:tt:$lo:tt $field:ident as $type:tt) => {
         #[allow(clippy::eq_op)]
         const _: () = {
-            ::kernel::build_assert!(
+            ::kernel::build_assert::build_assert!(
                 $hi >= $lo,
                 concat!("field `", stringify!($field), "`'s MSB is smaller than its LSB")
             );
diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index c952a834e662..329169b21b28 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -49,7 +49,7 @@ macro_rules! impl_safe_as {
             #[allow(unused)]
             #[inline(always)]
             pub(crate) const fn [<$from _as_ $into>](value: $from) -> $into {
-                kernel::static_assert!(size_of::<$into>() >= size_of::<$from>());
+                ::kernel::build_assert::static_assert!(size_of::<$into>() >= size_of::<$from>());
 
                 value as $into
             }
diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
index 726d0b76ca2b..11ac83e515ac 100644
--- a/rust/kernel/build_assert.rs
+++ b/rust/kernel/build_assert.rs
@@ -61,15 +61,16 @@
 //! undefined symbols and linker errors, it is not developer friendly to debug, so it is recommended
 //! to avoid it and prefer other two assertions where possible.
 
+#[doc(inline)]
 pub use crate::{
-    build_assert,
+    build_assert_macro as build_assert,
     build_error,
     const_assert,
     static_assert, //
 };
 
 #[doc(hidden)]
-pub use build_error::build_error;
+pub use build_error::build_error as build_error_fn;
 
 /// Static assert (i.e. compile-time assert).
 ///
@@ -105,6 +106,7 @@
 /// static_assert!(f(40) == 42, "f(x) must add 2 to the given input.");
 /// ```
 #[macro_export]
+#[doc(hidden)]
 macro_rules! static_assert {
     ($condition:expr $(,$arg:literal)?) => {
         const _: () = ::core::assert!($condition $(,$arg)?);
@@ -133,6 +135,7 @@ macro_rules! static_assert {
 /// }
 /// ```
 #[macro_export]
+#[doc(hidden)]
 macro_rules! const_assert {
     ($condition:expr $(,$arg:literal)?) => {
         const { ::core::assert!($condition $(,$arg)?) };
@@ -157,12 +160,13 @@ macro_rules! const_assert {
 /// // foo(usize::MAX); // Fails to compile.
 /// ```
 #[macro_export]
+#[doc(hidden)]
 macro_rules! build_error {
     () => {{
-        $crate::build_assert::build_error("")
+        $crate::build_assert::build_error_fn("")
     }};
     ($msg:expr) => {{
-        $crate::build_assert::build_error($msg)
+        $crate::build_assert::build_error_fn($msg)
     }};
 }
 
@@ -200,15 +204,16 @@ macro_rules! build_error {
 /// const _: () = const_bar(2);
 /// ```
 #[macro_export]
-macro_rules! build_assert {
+#[doc(hidden)]
+macro_rules! build_assert_macro {
     ($cond:expr $(,)?) => {{
         if !$cond {
-            $crate::build_assert::build_error(concat!("assertion failed: ", stringify!($cond)));
+            $crate::build_assert::build_error_fn(concat!("assertion failed: ", stringify!($cond)));
         }
     }};
     ($cond:expr, $msg:expr) => {{
         if !$cond {
-            $crate::build_assert::build_error($msg);
+            $crate::build_assert::build_error_fn($msg);
         }
     }};
 }
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index a396f8435739..f209fb334c85 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -5,12 +5,13 @@
 //! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
 
 use crate::{
-    bindings, build_assert, device,
+    bindings,
+    device,
     device::{Bound, Core},
     error::{to_result, Result},
     prelude::*,
     sync::aref::ARef,
-    transmute::{AsBytes, FromBytes},
+    transmute::{AsBytes, FromBytes}, //
 };
 use core::ptr::NonNull;
 
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index abc49926abfe..2133d3e62fd5 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -108,9 +108,10 @@
 
 use core::marker::PhantomData;
 
-use crate::io::IoLoc;
-
-use kernel::build_assert;
+use crate::{
+    build_assert::build_assert,
+    io::IoLoc, //
+};
 
 /// Trait implemented by all registers.
 pub trait Register: Sized {
@@ -872,7 +873,7 @@ macro_rules! register {
         @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             [ $size:expr, stride = $stride:expr ] @ $offset:literal { $($fields:tt)* }
     ) => {
-        ::kernel::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
+        $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name($storage) @ $offset);
@@ -895,7 +896,9 @@ macro_rules! register {
         @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident [ $idx:expr ]
             { $($fields:tt)* }
     ) => {
-        ::kernel::static_assert!($idx < <$alias as $crate::io::register::RegisterArray>::SIZE);
+        $crate::build_assert::static_assert!(
+            $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
+        );
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
@@ -912,7 +915,7 @@ macro_rules! register {
             [ $size:expr, stride = $stride:expr ]
             @ $base:ident + $offset:literal { $($fields:tt)* }
     ) => {
-        ::kernel::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
+        $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name($storage) @ $offset);
@@ -938,7 +941,9 @@ macro_rules! register {
         @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             => $base:ident + $alias:ident [ $idx:expr ] { $($fields:tt)* }
     ) => {
-        ::kernel::static_assert!($idx < <$alias as $crate::io::register::RegisterArray>::SIZE);
+        $crate::build_assert::static_assert!(
+            $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
+        );
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index b7ac9faf141d..17b0c174cfc5 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -229,7 +229,7 @@ impl Flags {
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     const fn new(value: u32) -> Self {
-        crate::build_assert!(value as u64 <= c_ulong::MAX as u64);
+        build_assert!(value as u64 <= c_ulong::MAX as u64);
         Flags(value as c_ulong)
     }
 }
diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index 2fc7662339e5..5bb5b48cf949 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -6,7 +6,7 @@
 
 #![expect(non_snake_case)]
 
-use crate::build_assert;
+use crate::build_assert::build_assert;
 
 /// Build an ioctl number, analogous to the C macro of the same name.
 #[inline(always)]
diff --git a/rust/kernel/net/phy/reg.rs b/rust/kernel/net/phy/reg.rs
index a7db0064cb7d..80e22c264ea8 100644
--- a/rust/kernel/net/phy/reg.rs
+++ b/rust/kernel/net/phy/reg.rs
@@ -9,9 +9,11 @@
 //! defined in IEEE 802.3.
 
 use super::Device;
-use crate::build_assert;
-use crate::error::*;
-use crate::uapi;
+use crate::{
+    build_assert::build_assert,
+    error::*,
+    uapi, //
+};
 
 mod private {
     /// Marker that a trait cannot be implemented outside of this crate
diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index f9f90d6ec482..dafe77782d79 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -364,7 +364,7 @@ pub fn try_new(value: T) -> Option<Self> {
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     pub fn from_expr(expr: T) -> Self {
-        crate::build_assert!(
+        crate::build_assert::build_assert!(
             fits_within(expr, N),
             "Requested value larger than maximal representable value."
         );
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 6a54597fa0a2..baf8f6a94ea1 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -29,7 +29,8 @@
 
 pub use pin_init::{init, pin_data, pin_init, pinned_drop, InPlaceWrite, Init, PinInit, Zeroable};
 
-pub use super::{
+#[doc(no_inline)]
+pub use crate::build_assert::{
     build_assert,
     build_error,
     const_assert,
diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
index ad810c2172ec..9c8a7a203abd 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -4,8 +4,11 @@
 //!
 //! Provides 1:1 mapping to the C atomic operations.
 
-use crate::bindings;
-use crate::macros::paste;
+use crate::{
+    bindings,
+    build_assert::static_assert,
+    macros::paste, //
+};
 use core::cell::UnsafeCell;
 use ffi::c_void;
 
@@ -46,7 +49,7 @@ pub trait AtomicImpl: Sized + Copy + private::Sealed {
 // In the future when a CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=n architecture plans to support Rust, the
 // load/store helpers that guarantee atomicity against RmW operations (usually via a lock) need to
 // be added.
-crate::static_assert!(
+static_assert!(
     cfg!(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW),
     "The current implementation of atomic i8/i16/ptr relies on the architecure being \
     ARCH_SUPPORTS_ATOMIC_RMW"
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 1d53834fcb12..2c92de040f03 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -2,7 +2,7 @@
 
 //! Pre-defined atomic types
 
-use crate::static_assert;
+use crate::prelude::*;
 use core::mem::{align_of, size_of};
 use ffi::c_void;
 
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index 61f100a45b35..fb4a1430b3b4 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -3,7 +3,7 @@
 //! A wrapper for data protected by a lock that does not wrap it.
 
 use super::{lock::Backend, lock::Lock};
-use crate::build_assert;
+use crate::build_assert::build_assert;
 use core::{cell::UnsafeCell, mem::size_of, ptr};
 
 /// Allows access to some data to be serialised by a lock that does not wrap it.
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
index 6c7ae8b05a0b..23a5d201f343 100644
--- a/rust/kernel/sync/refcount.rs
+++ b/rust/kernel/sync/refcount.rs
@@ -4,9 +4,11 @@
 //!
 //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
 
-use crate::build_assert;
-use crate::sync::atomic::Atomic;
-use crate::types::Opaque;
+use crate::{
+    build_assert::build_assert,
+    sync::atomic::Atomic,
+    types::Opaque, //
+};
 
 /// Atomic reference counter.
 ///
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index a49d6db28845..8fc4eab02642 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -5,10 +5,16 @@
 //! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
 
 use crate::{
-    alloc, bindings, build_assert,
+    alloc,
+    bindings,
+    build_assert::build_assert,
     error::{Error, Result},
     ffi::c_void,
-    types::{ForeignOwnable, NotThreadSafe, Opaque},
+    types::{
+        ForeignOwnable,
+        NotThreadSafe,
+        Opaque, //
+    }, //
 };
 use core::{iter, marker::PhantomData, pin::Pin, ptr::NonNull};
 use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
-- 
2.51.2


