Return-Path: <netdev+bounces-268185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE2fDhMeuGlYZAEAu9opvQ
	(envelope-from <netdev+bounces-268185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:13:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F2229C12C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 734D9306D8E8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D530D39E6FE;
	Mon, 16 Mar 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/D3XetM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB539D6D9;
	Mon, 16 Mar 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673710; cv=none; b=jD8D+BPeTE6ddsZjSwSjiIcKSCTRIHr4mDXINOkcEFrrfSCbXoy9VkfuyXJcUzqqEyVqLKnPUX/lkvi66hCvuc1oCUriDWGYsduBnQRl6lGglExh0SlFyltOVvX5KcDJi8BuD/rl9N7p+KmZLYkQYENOniA8U+dO0CZB4xQ2bE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673710; c=relaxed/simple;
	bh=UI39a1x/Is4yFLYih00scFN3QWaqps8X2NhPvJgjJs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8KSutl8NoL6ooqUh/wxYYQCjZEH7qrCuZn3NVNeo9xsGFGmW54yFKweP2wsxBUgAjyPKXru0swppFWIrRj/mbG7bAUCIlIpVtLD0aZVjP+EwZGBgttaVOMycfEte2k+i992T+cA+fGtPBYqLC5XE0WmQD9pRmQ9oq9HeModvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/D3XetM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD77C19425;
	Mon, 16 Mar 2026 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773673710;
	bh=UI39a1x/Is4yFLYih00scFN3QWaqps8X2NhPvJgjJs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=X/D3XetM1EC5Yi+GvVCuME8uQHlD+3pdzy99F0h4OWzO2RYt1WXL4hxp4304UyhV/
	 uOmGyhEhah/Jp0Nq+3Wmxx4lN0f4lLX9jHPbUQI4yGxqO7OGn3P4vkfFrIgZo+kedS
	 Yq7gc6SY4SQrUm3QS529gJObQD0fgir65dsyYQfZp7Who3gCnUlhCGS9FfDRV5AoM2
	 XRADaP3NG9i4Hd3xQ8OBppBGTSeDpq7heZrHXe9IPT0Ua8fXmb+J8LEiudKExAk3Wi
	 ku9OC8tXW2nlhJ6cKVxzTUZJklVYkpO+soJVqUmusvfvFA9Lebmjvg+0S64Z7REx2y
	 DoyiWMH/TgYbA==
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
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tamir Duberstein <tamird@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH v2 4/4] rust: make `build_assert` module the home of related macros
Date: Mon, 16 Mar 2026 15:07:15 +0000
Message-ID: <20260316150720.1646109-5-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260316150720.1646109-1-gary@kernel.org>
References: <20260316150720.1646109-1-gary@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-268185-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,gmail.com,collabora.com,arm.com,nvidia.com,infradead.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[gary@garyguo.net];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[gary@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email,garyguo.net:replyto]
X-Rspamd-Queue-Id: 99F2229C12C
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
 rust/kernel/build_assert.rs          | 19 ++++++++++++-------
 rust/kernel/dma.rs                   |  6 ++++--
 rust/kernel/io/resource.rs           |  2 +-
 rust/kernel/ioctl.rs                 |  2 +-
 rust/kernel/net/phy/reg.rs           |  8 +++++---
 rust/kernel/num/bounded.rs           |  2 +-
 rust/kernel/prelude.rs               |  3 ++-
 rust/kernel/sync/atomic/predefine.rs |  3 +--
 rust/kernel/sync/locked_by.rs        |  2 +-
 rust/kernel/sync/refcount.rs         |  8 +++++---
 rust/kernel/xarray.rs                |  6 ++++--
 11 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
index acdfcbeb73f3..5d671761c446 100644
--- a/rust/kernel/build_assert.rs
+++ b/rust/kernel/build_assert.rs
@@ -61,15 +61,16 @@
 //! symbols and linker errors, it is not developer friendly to debug, so it is recommended to avoid it
 //! and prefer other two assertions where possible.
 
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
 
@@ -196,15 +200,16 @@ macro_rules! build_error {
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
index a396f8435739..bef3f33cf2ea 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -5,12 +5,14 @@
 //! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
 
 use crate::{
-    bindings, build_assert, device,
+    bindings,
+    build_assert::build_assert,
+    device,
     device::{Bound, Core},
     error::{to_result, Result},
     prelude::*,
     sync::aref::ARef,
-    transmute::{AsBytes, FromBytes},
+    transmute::{AsBytes, FromBytes}, //
 };
 use core::ptr::NonNull;
 
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index b7ac9faf141d..9cb18ce1c479 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -229,7 +229,7 @@ impl Flags {
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     const fn new(value: u32) -> Self {
-        crate::build_assert!(value as u64 <= c_ulong::MAX as u64);
+        crate::build_assert::build_assert!(value as u64 <= c_ulong::MAX as u64);
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
index 54d0ce3ba595..c09abfab1ce2 100644
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
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 67a0406d3ea4..77f4a5c91a80 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -2,8 +2,7 @@
 
 //! Pre-defined atomic types
 
-use crate::static_assert;
-use core::mem::{align_of, size_of};
+use crate::prelude::*;
 
 // Ensure size and alignment requirements are checked.
 static_assert!(size_of::<bool>() == size_of::<i8>());
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
index a49d6db28845..50b9feca7f10 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -5,10 +5,12 @@
 //! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
 
 use crate::{
-    alloc, bindings, build_assert,
+    alloc,
+    bindings,
+    build_assert::build_assert,
     error::{Error, Result},
     ffi::c_void,
-    types::{ForeignOwnable, NotThreadSafe, Opaque},
+    types::{ForeignOwnable, NotThreadSafe, Opaque}, //
 };
 use core::{iter, marker::PhantomData, pin::Pin, ptr::NonNull};
 use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
-- 
2.51.2


