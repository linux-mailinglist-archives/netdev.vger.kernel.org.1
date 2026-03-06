Return-Path: <netdev+bounces-264844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M2JNy3wqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:18:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E0223A2E
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADD7230C1896
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7583B583E;
	Fri,  6 Mar 2026 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGiNMEbp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE153B52E5
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809951; cv=none; b=Dtyc2fSJgQiKZoS/itSoYJ97hMsxWqUUpHX3smg8ZYgLukAAj1QcDoLDjyPcezf8d0V84pElf2NAYjeP/sdpoVE12ViyJBqfj6GMI6fTdVKXMB3j5ARWYN8bQCbKKJ/J/IznIrKh/VMmkRc8NsJVf4Mx8v/eYXVvBmvSZCbv5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809951; c=relaxed/simple;
	bh=2gg0IMeCOonNFxAMRE6I6j2GzytDKOh8FHyYzEqMsFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QYnach9fow5hp6uDXhzhd7qJFDtderiy9xRapzeVmF1Bxn0HjdwMoOlyrYFGRNQYVhpv0w3mSis+EIWnSNCY/tjtlkU0tXwUQ3Sx+dQqSGeecpPggb1Dkb4f8o9WCH6jqScm+VPbPhNzOLtVo5WPj8P24+xJmezj8PiSxEMIxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGiNMEbp; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4832c4621c2so100986675e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772809944; x=1773414744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=550E8GK4gdkLJqbKYXMCXLAWMQ96P9Gx+7hniyLd5m8=;
        b=JGiNMEbpsFE3ZnjMJJ8xFR2tEIwu6g3TEP9P4DUaCXj+5riK/haDzNEGLolUj2nyd4
         cWczkN3iey3kI0P7b+K0OunEZQFppjqR4qLrVQOsku059MfZPlmEuWh1xylMONXCrU2W
         +8ZreFDaBLQs4Pb1dwEqaThfm+iShFz2bdjlx8O/EPsU39uAcy0pBmIS5lj+ZjfuTLbz
         D/YRngsDEMjBAmRSPcOaWO8JPoraIgQYf3p7UOo/Yw2bS4bkxOImiayg3Mn3F9tvVM18
         XldokK/1XjVSK5FOIfnHwkPKLnXUAMslZverASENs5xuO5i6WJ9TOnJGv7OUek7uF/H4
         4KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772809944; x=1773414744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=550E8GK4gdkLJqbKYXMCXLAWMQ96P9Gx+7hniyLd5m8=;
        b=BNdWUWohgToYeJUG5CPXSpyQhkDb9dHMEYdwJlFcb0bxXuICbO3W6L82J/eUG5g5Z/
         IXJRNUjSxN3RwY/XOaHyK7L4hO1KhkgJXqRAWXeYk3cbgaldfO5u8dQNnYd8XQHOfnpi
         mnGFqfpwZKLjio7N3e5A/Qb+saH2DFKm7K338sbYwKQak6MvIRx0wkQHTNj/NjACwTPX
         bIrsgqfZvbJgT73GTmgn+HkBgVLG3yXxc+ILT9z4PP6+dNFbLiuk1tRft/Nlx5swNP/B
         uraLvE29LnGYVVly5yOlvi4W0TVTMGIi+HZRz5a9u3pwEGQWlcv+jV8KHkmYbvH6R26a
         9ubg==
X-Forwarded-Encrypted: i=1; AJvYcCUIShJ+96JNEATJxafEqcD0byLiGj93AtfuT/p1qWnhHXckHqPZP85CLSg8kyZ5mlaDzto5UqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3AtRdX1Wlbh9jX26DJApj60c7Sil3n+y0NlVpEGpZO0mbFOEe
	QX/dOZonbeHtc+XdnheMgklmCVL7vGfSxjh3Ob/9oTEomZCOTNISGtsye8I0GZNAVh7w5hc2C+M
	jfUC9E3lUWbDshMI0sw==
X-Received: from wrsw18.prod.google.com ([2002:a5d:4b52:0:b0:437:7338:c338])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:500d:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48526968008mr38754015e9.29.1772809943979;
 Fri, 06 Mar 2026 07:12:23 -0800 (PST)
Date: Fri, 06 Mar 2026 15:12:13 +0000
In-Reply-To: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=12905; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2gg0IMeCOonNFxAMRE6I6j2GzytDKOh8FHyYzEqMsFw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpqu7UQ2pg3Q1K0jA1mE1WZqjSNpeYUcA0o+2b5
 phN/eDOiEeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaaru1AAKCRAEWL7uWMY5
 Ri7lEACKZA4t9mW1PRY2HeVksoFBYDfNwiLO+uWYu3cDyE52mRcT1x8wJxB9Kn7jp/KHw7ZMCS6
 WYody/yBBvbeaZNYp8aeeByM/K4jcvsE2b27QfBL50emfO7kTk05oGJUodC/zg61yf1uEuDHz5v
 g6i7ehVkvxIjXDgINJzEiLCmqrStZLj9/28Wgvu3lTKkj3B2o0jLSbU63Rw6pCyPYRwEfQbukXR
 tO1gpmEyJeah6o3BI4TBVptImXWhpTMW01FvjTeHkye6YUDaxf8oJNWCoZf4hSSFfr7otXSJNWF
 X3ExbWPJTOZOSWKSKioGo1nTR7Yp2FfCRhx0/3vBr5oj/5jv1s9FKEvw5GbUE6XttfsmaooCzJ+
 +CBNFP9TT91yf0lW6r9Y/fEloeEAr8A1G4mnsLqJ92twmVWxoAaPCI29Y5WBFmyKiKCLGi13QXr
 2v/wQrlDTTK/KcI4DlOm6Q5dP92p+E+ioTOweK/XmTF0UsIfO+OBJpEjaMrrj1ZL6UUTEtZjlQj
 y214iyWC29LlppBtm5BlywLCliuZ90tRrqpA8KeI2Rpm4q3Z5o8/m+Cc2Mn1B6GeBzMVTL1iBiQ
 noPYGsxFhWsyCAnLpODhp4ZBM3Bem8Hw21W/eyqCwLCU+3nubYVjbMZYAbrPHoGwLLbcEumg9kD f8ACYotbggUUFbg==
X-Mailer: b4 0.14.3
Message-ID: <20260306-binder-netlink-v1-1-daceb5bc83f2@google.com>
Subject: [PATCH 1/4] rust: netlink: add raw netlink abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 7D3E0223A2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264844-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.971];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This implements a safe and relatively simple API over the netlink API,
that allows you to add different attributes to a netlink message and
broadcast it. As the first user of this API only makes use of broadcast,
only broadcast messages are supported here.

This API is intended to be safe and to be easy to use in *generated*
code. This is because netlink is generally used with yaml files that
describe the underlying API, and the python generator outputs C code
(or, soon, Rust code) that lets you use the API more easily. So for
example, if there is a string field, the code generator will output a
method that internall calls `put_string()` with the right attr type.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   3 +
 rust/helpers/genetlink.c        |  46 +++++++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/netlink.rs          | 267 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 318 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 083cc44aa952..8abb626fce6c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -88,6 +88,8 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <trace/events/rust_sample.h>
 
 /*
@@ -105,6 +107,7 @@
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN = ARCH_KMALLOC_MINALIGN;
 const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
+const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE = GENLMSG_DEFAULT_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
diff --git a/rust/helpers/genetlink.c b/rust/helpers/genetlink.c
new file mode 100644
index 000000000000..99ada80cfa41
--- /dev/null
+++ b/rust/helpers/genetlink.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2026 Google LLC.
+ */
+
+#include <net/genetlink.h>
+
+#ifdef CONFIG_NET
+
+__rust_helper struct sk_buff *rust_helper_genlmsg_new(size_t payload, gfp_t flags)
+{
+	return genlmsg_new(payload, flags);
+}
+
+__rust_helper
+int rust_helper_genlmsg_multicast(const struct genl_family *family,
+				  struct sk_buff *skb, u32 portid,
+				  unsigned int group, gfp_t flags)
+{
+	return genlmsg_multicast(family, skb, portid, group, flags);
+}
+
+__rust_helper void rust_helper_genlmsg_cancel(struct sk_buff *skb, void *hdr)
+{
+	return genlmsg_cancel(skb, hdr);
+}
+
+__rust_helper void rust_helper_genlmsg_end(struct sk_buff *skb, void *hdr)
+{
+	return genlmsg_end(skb, hdr);
+}
+
+__rust_helper void rust_helper_nlmsg_free(struct sk_buff *skb)
+{
+	return nlmsg_free(skb);
+}
+
+__rust_helper
+int rust_helper_genl_has_listeners(const struct genl_family *family,
+				   struct net *net, unsigned int group)
+{
+	return genl_has_listeners(family, net, group);
+}
+
+#endif
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index a3c42e51f00a..0813185d8760 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -32,6 +32,7 @@
 #include "err.c"
 #include "irq.c"
 #include "fs.c"
+#include "genetlink.c"
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3da92f18f4ee..c94658051d42 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -118,6 +118,7 @@
 pub mod module_param;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod netlink;
 pub mod num;
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
diff --git a/rust/kernel/netlink.rs b/rust/kernel/netlink.rs
new file mode 100644
index 000000000000..4ac9e6d919fa
--- /dev/null
+++ b/rust/kernel/netlink.rs
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Google LLC.
+
+//! Rust support for generic netlink.
+//!
+//! Currently only supports exposing multicast groups.
+//!
+//! C header: [`include/net/genetlink.h`](srctree/include/net/genetlink.h)
+#![cfg(CONFIG_NET)]
+
+use kernel::{
+    alloc::{self, AllocError},
+    error::to_result,
+    prelude::*,
+    transmute::AsBytes,
+    types::Opaque,
+    ThisModule,
+};
+
+use core::{
+    mem::ManuallyDrop,
+    ptr::NonNull, //
+};
+
+/// The default netlink message size.
+pub const GENLMSG_DEFAULT_SIZE: usize = bindings::GENLMSG_DEFAULT_SIZE;
+
+/// A wrapper around `struct sk_buff` for generic netlink messages.
+///
+/// # Invariants
+///
+/// The pointer has ownership over a valid `sk_buff`.
+pub struct SkBuff {
+    skb: NonNull<kernel::bindings::sk_buff>,
+}
+
+impl SkBuff {
+    /// Creates a new `SkBuff` with the given size.
+    pub fn new(size: usize, flags: alloc::Flags) -> Result<SkBuff, AllocError> {
+        // SAFETY: `genlmsg_new` only requires its arguments to be valid integers.
+        let skb = unsafe { bindings::genlmsg_new(size, flags.as_raw()) };
+        let skb = NonNull::new(skb).ok_or(AllocError)?;
+        Ok(SkBuff { skb })
+    }
+
+    /// Puts a generic netlink header into the `SkBuff`.
+    pub fn genlmsg_put(
+        self,
+        portid: u32,
+        seq: u32,
+        family: &'static Family,
+        cmd: u8,
+    ) -> Result<GenlMsg, AllocError> {
+        let skb = self.skb.as_ptr();
+        // SAFETY: The skb and family pointers are valid.
+        let hdr = unsafe { bindings::genlmsg_put(skb, portid, seq, family.as_raw(), 0, cmd) };
+        let hdr = NonNull::new(hdr).ok_or(AllocError)?;
+        Ok(GenlMsg { skb: self, hdr })
+    }
+}
+
+impl Drop for SkBuff {
+    fn drop(&mut self) {
+        // SAFETY: We have ownership over the `sk_buff`, so we may free it.
+        unsafe { bindings::nlmsg_free(self.skb.as_ptr()) }
+    }
+}
+
+/// A generic netlink message being constructed.
+///
+/// # Invariants
+///
+/// `hdr` references the header in this netlink message.
+pub struct GenlMsg {
+    skb: SkBuff,
+    hdr: NonNull<c_void>,
+}
+
+impl GenlMsg {
+    /// Puts an attribute into the message.
+    #[inline]
+    fn put<T>(&mut self, attrtype: c_int, value: &T) -> Result
+    where
+        T: ?Sized + AsBytes,
+    {
+        let skb = self.skb.skb.as_ptr();
+        let len = size_of_val(value);
+        let ptr = core::ptr::from_ref(value).cast::<c_void>();
+        // SAFETY: `skb` is valid by `SkBuff` type invariants, and the provided value is readable
+        // and initialized for its `size_of` bytes.
+        to_result(unsafe { bindings::nla_put(skb, attrtype, len as c_int, ptr) })
+    }
+
+    /// Puts a `u32` attribute into the message.
+    #[inline]
+    pub fn put_u32(&mut self, attrtype: c_int, value: u32) -> Result {
+        self.put(attrtype, &value)
+    }
+
+    /// Puts a string attribute into the message.
+    #[inline]
+    pub fn put_string(&mut self, attrtype: c_int, value: &CStr) -> Result {
+        self.put(attrtype, value.to_bytes_with_nul())
+    }
+
+    /// Puts a flag attribute into the message.
+    #[inline]
+    pub fn put_flag(&mut self, attrtype: c_int) -> Result {
+        let skb = self.skb.skb.as_ptr();
+        // SAFETY: `skb` is valid by `SkBuff` type invariants, and a null pointer is valid when the
+        // length is zero.
+        to_result(unsafe { bindings::nla_put(skb, attrtype, 0, core::ptr::null()) })
+    }
+
+    /// Sends the generic netlink message as a multicast message.
+    #[inline]
+    pub fn multicast(
+        self,
+        family: &'static Family,
+        portid: u32,
+        group: u32,
+        flags: alloc::Flags,
+    ) -> Result {
+        let me = ManuallyDrop::new(self);
+        // SAFETY: The `skb` and `family` pointers are valid. We pass ownership of the `skb` to
+        // `genlmsg_multicast` by not dropping `self`.
+        unsafe {
+            bindings::genlmsg_end(me.skb.skb.as_ptr(), me.hdr.as_ptr());
+            to_result(bindings::genlmsg_multicast(
+                family.as_raw(),
+                me.skb.skb.as_ptr(),
+                portid,
+                group,
+                flags.as_raw(),
+            ))
+        }
+    }
+}
+impl Drop for GenlMsg {
+    fn drop(&mut self) {
+        // SAFETY: The `hdr` pointer references the header of this generic netlink message.
+        unsafe { bindings::genlmsg_cancel(self.skb.skb.as_ptr(), self.hdr.as_ptr()) };
+    }
+}
+
+/// A generic netlink family.
+#[repr(transparent)]
+pub struct Family {
+    inner: Opaque<bindings::genl_family>,
+}
+
+// SAFETY: The `Family` type is thread safe.
+unsafe impl Sync for Family {}
+
+impl Family {
+    /// Creates a new `Family` instance.
+    pub const fn const_new(
+        module: &ThisModule,
+        name: &[u8],
+        version: u32,
+        mcgrps: &'static [MulticastGroup],
+    ) -> Family {
+        let n_mcgrps = mcgrps.len() as u8;
+        if n_mcgrps as usize != mcgrps.len() {
+            panic!("too many mcgrps");
+        }
+        let mut genl_family = bindings::genl_family {
+            version,
+            // SAFETY: This bitfield is represented as an u8.
+            _bitfield_1: unsafe {
+                core::mem::transmute::<u8, bindings::__BindgenBitfieldUnit<[u8; 1]>>(0b11u8)
+            },
+            module: module.as_ptr(),
+            mcgrps: mcgrps.as_ptr().cast(),
+            n_mcgrps,
+            ..pin_init::zeroed()
+        };
+        if CStr::from_bytes_with_nul(name).is_err() {
+            panic!("genl_family name not nul-terminated");
+        }
+        if genl_family.name.len() < name.len() {
+            panic!("genl_family name too long");
+        }
+        let mut i = 0;
+        while i < name.len() {
+            genl_family.name[i] = name[i];
+            i += 1;
+        }
+        Family {
+            inner: Opaque::new(genl_family),
+        }
+    }
+
+    /// Checks if there are any listeners for the given multicast group.
+    pub fn has_listeners(&self, group: u32) -> bool {
+        // SAFETY: The family and init_net pointers are valid.
+        unsafe {
+            bindings::genl_has_listeners(self.as_raw(), &raw mut bindings::init_net, group) != 0
+        }
+    }
+
+    /// Returns a raw pointer to the underlying `genl_family` structure.
+    pub fn as_raw(&self) -> *mut bindings::genl_family {
+        self.inner.get()
+    }
+}
+
+/// A generic netlink multicast group.
+#[repr(transparent)]
+pub struct MulticastGroup {
+    // No Opaque because fully immutable
+    group: bindings::genl_multicast_group,
+}
+
+// SAFETY: Pure data so thread safe.
+unsafe impl Sync for MulticastGroup {}
+
+impl MulticastGroup {
+    /// Creates a new `MulticastGroup` instance.
+    pub const fn const_new(name: &CStr) -> MulticastGroup {
+        let mut group: bindings::genl_multicast_group = pin_init::zeroed();
+
+        let name = name.to_bytes_with_nul();
+        if group.name.len() < name.len() {
+            panic!("genl_multicast_group name too long");
+        }
+        let mut i = 0;
+        while i < name.len() {
+            group.name[i] = name[i];
+            i += 1;
+        }
+
+        MulticastGroup { group }
+    }
+}
+
+/// A registration of a generic netlink family.
+///
+/// This type represents the registration of a [`Family`]. When an instance of this type is
+/// dropped, its respective generic netlink family will be unregistered from the system.
+///
+/// # Invariants
+///
+/// `self.family` always holds a valid reference to an initialized and registered [`genl_family`].
+pub struct Registration {
+    family: &'static Family,
+}
+
+impl Family {
+    /// Registers the generic netlink family with the kernel.
+    pub fn register(&'static self) -> Result<Registration> {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `genl_family` struct.
+        // The `genl_family` struct is static, so it will outlive the registration.
+        to_result(unsafe { bindings::genl_register_family(self.as_raw()) })?;
+        Ok(Registration { family: self })
+    }
+}
+
+impl Drop for Registration {
+    fn drop(&mut self) {
+        // SAFETY: `self.family.as_raw()` is a valid pointer to a registered `genl_family` struct.
+        // The `Registration` struct ensures that `genl_unregister_family` is called exactly once
+        // for this family when it goes out of scope.
+        unsafe { bindings::genl_unregister_family(self.family.as_raw()) };
+    }
+}

-- 
2.53.0.473.g4a7958ca14-goog


