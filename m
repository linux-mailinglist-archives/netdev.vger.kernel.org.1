Return-Path: <netdev+bounces-297078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0kh3AJojKGqL+gIAu9opvQ
	(envelope-from <netdev+bounces-297078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:30:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 471796610BD
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:30:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nwDszgGM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297078-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297078-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25DAA3054925
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B619344029;
	Tue,  9 Jun 2026 14:27:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DC734040F;
	Tue,  9 Jun 2026 14:27:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015232; cv=none; b=eCa2K/B9wCHqbU05t0qruyFv+3aEvE90ne6WCHbxxENZtPC6i8b6TVKdKsdc4Ued+ymgg/2t7RnZQ0bobJpb2uz3ZrVPJg5VqUJOlNdGiM0WFOkORX5SbfyBIWrpBT+TBvoWPpw75BX/VTRk/uxFz3q8w7PyM7Nbj/9f0l+FreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015232; c=relaxed/simple;
	bh=iygAOfvA2foW8/+jP6Ee21bgu2uYdvqpa6z2Rjyy9uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWyQnNeFQ3UTnhTAzZvbj6ppLSL/rqsvEAarPZe+dquxt52/W9Ta7OxrU+uSgrF9o21HP5VDjo1kZ9Fb/jruXRL5QGgsSp0JGdQvfoOr8fMSb2oi62zANSJ6sAcsPpJwHz54Qzzdwy0fBVZ/VdFDv8oGLeWK+q1QqsxNsAlNp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwDszgGM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C0D1F00893;
	Tue,  9 Jun 2026 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015229;
	bh=7b6cZO88qxYhwPQRHX9JdG5EbRfREDm6sv5DAhrto3Y=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=nwDszgGMS4Q5Gx6dDnrYmmxG3JFRwCznR8eeTRISzUFizK3fvgodofWAu0j6qV7Vm
	 x8jzUygPHi0X7dKckNz5MK6s/lYGVbDQhxCVCq/CV6YZzLrPMaloIQFmQ9JFuDUE5t
	 bsKGaAtZc/eXQskQawfXOzP2QBNT3/JHr9JepY5csJaBJqqS9brT6suCfR/tDAY0dl
	 3cy1egpS8C+a924GwJU7wfUap2OVoYsh+qWf3VZMyjzZUZq62sEE4olr+tg2BSk3eU
	 n3m/ldEIak5tl9p0RlIcfwcAmJu0eCLrYxhxYEWpbrCZaUgMHWORyNWIt7SezgpP9w
	 fnMRyl333y4xg==
From: Gary Guo <gary@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alice Ryhl <aliceryhl@google.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Yury Norov <yury.norov@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tamir Duberstein <tamird@kernel.org>
Cc: nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH v4] rust: make `build_assert` module the home of related macros
Date: Tue,  9 Jun 2026 15:26:33 +0100
Message-ID: <20260609142637.373347-1-gary@kernel.org>
X-Mailer: git-send-email 2.54.0
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297078-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:acourbot@nvidia.com,m:aliceryhl@google.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:fujita.tomonori@gmail.com,m:yury.norov@gmail.com,m:will@kernel.org,m:peterz@infradead.org,m:mark.rutland@arm.com,m:mingo@redhat.com,m:longman@redhat.com,m:tamird@kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:driver-core@lists.linux.dev,m:netdev@vger.kernel.org,m:fujitatomonori@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,nvidia.com,google.com,gmail.com,ffwll.ch,garyguo.net,protonmail.com,umich.edu,collabora.com,infradead.org,arm.com,redhat.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@kernel.org,netdev@vger.kernel.org];
	HAS_REPLYTO(0.00)[gary@garyguo.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email,garyguo.net:replyto,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 471796610BD

From: Gary Guo <gary@garyguo.net>

Given the macro scoping rules, all macros are rendered twice, in the
module and in the top-level of kernel crate.

Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
re-export inside `build_assert` module so the top-level items are hidden.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Acked-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
This is the remaining unapplied patch from
https://lore.kernel.org/rust-for-linux/20260319121653.2975748-1-gary@kernel.org/.

Changes:
- Rebased so it applies cleanly. (both on linux-next and rust-next)
- Picked up tags
- Updated commit message to reflect that my other patch "rust: doc: disable
  doc inlining for all prelude items" already reduce number of rendering
  times from 3 to 2.
---
 drivers/gpu/nova-core/bitfield.rs    |  4 ++--
 drivers/gpu/nova-core/num.rs         |  2 +-
 rust/kernel/build_assert.rs          | 19 ++++++++++++-------
 rust/kernel/io/register.rs           | 19 ++++++++++++-------
 rust/kernel/io/resource.rs           |  2 +-
 rust/kernel/ioctl.rs                 |  2 +-
 rust/kernel/net/phy/reg.rs           |  8 +++++---
 rust/kernel/num/bounded.rs           |  2 +-
 rust/kernel/prelude.rs               | 12 ++++++++----
 rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
 rust/kernel/sync/atomic/predefine.rs |  2 +-
 rust/kernel/sync/locked_by.rs        |  2 +-
 rust/kernel/sync/refcount.rs         |  8 +++++---
 rust/kernel/xarray.rs                | 10 ++++++++--
 14 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
index 02efdcf78d89..660c3911402d 100644
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
index 6c824b8d7b97..6eb174d136ab 100644
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
index 2ea2154ec30c..c3acb9b68a65 100644
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
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 388647f28292..f924c7c7c1db 100644
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
index ca260cc3937a..f6e852638ade 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -79,9 +79,6 @@
         VVec,
         Vec, //
     },
-    build_assert,
-    build_error,
-    const_assert,
     current,
     dev_alert,
     dev_crit,
@@ -105,7 +102,6 @@
     pr_info,
     pr_notice,
     pr_warn,
-    static_assert,
     str::CStrExt as _,
     try_init,
     try_pin_init,
@@ -113,6 +109,14 @@
     ThisModule, //
 };
 
+#[doc(no_inline)]
+pub use crate::build_assert::{
+    build_assert,
+    build_error,
+    const_assert,
+    static_assert, //
+};
+
 // `super::std_vendor` is hidden, which makes the macro inline for some reason.
 #[doc(no_inline)]
 pub use super::dbg;
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
index 7468153429e1..adc5fa126487 100644
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
index 46e5f43223fe..987c9c0c2198 100644
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

base-commit: 98cc68794c003bc76fc9da2e8a075e947eee5921
-- 
2.54.0


