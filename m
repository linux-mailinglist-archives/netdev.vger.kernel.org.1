Return-Path: <netdev+bounces-278727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPjAJwte32m5SAAAu9opvQ
	(envelope-from <netdev+bounces-278727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:44:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0141C402C59
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57AE530DFC64
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0562C33C51D;
	Wed, 15 Apr 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1MofJnc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7433ADA0
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245977; cv=none; b=GlnUvvfqY1rGthTspIexKfWoPMi8JxVLixkBBDA+bs4QyuabNUm7zXzrfS2uzpgSbZ3NapmUcHLdeJ8iqexlCTDWYtx4b4VYVYN7q+vkOHXD/TyYfEPc4uuf0M5H8g7CNwR/OarAgLDlTaEJBaMwZJ71lCS8DfRTxO2gaCWdgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245977; c=relaxed/simple;
	bh=pjbAO55XTwIKrveO3PbdZX0WLuUD19YrjQYqWj4r0aw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F9fAYfwILR74U1tLEE67RbZ+TCN9mc0KrPdaXnS8wCNcwl9RPUbht0Dy0YiIBpgelAiz31glitHEzQu/KbzEWaiPR8XzD05CT2lLlNp+iezoCSHT9zSxhRc9QDVaucHpwHu7HGdWjr3VLPkyg5CWu3WQptwLpY9Fqe9O8+yNxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1MofJnc; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d1ceb2ddfso6149999f8f.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776245973; x=1776850773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0SpVJdizsDVLrsxZKoDmA13FbMhOjDZMUd96vsteDw=;
        b=F1MofJncUjgUZi+rIZIyhH8jqXi6BItJhPku7hHKjx+t/AZMErc2u9upH9hwvdGomm
         4vAmbvlrLFw5pwzjRUKFmasoZOKr9F5E12JipIYyRT+C4Hm4RHrQBpRVCW+1p5IFYYAJ
         N/KKZGrE6cKsiascAhRaOflSGM8AWmpusMmXylLz7hzS8rWBCiyN0yLpWiSHHpcICYL9
         HS8dW6W/ii3uzOGmRgbhUu1dVfXeV8sgNDB5w4dQBMZl6Ugyop1vsN5A+NrPp8+8osOQ
         0EZ+5zGzOYr+bYKoA4jdtyFlcf9LQIYp/4WDK1e/pduVsr5Cf9yvMTSsJP7VzYu6tDec
         jiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245973; x=1776850773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0SpVJdizsDVLrsxZKoDmA13FbMhOjDZMUd96vsteDw=;
        b=VXeTmqlcbwniIGIfUU1Xdw8ypDj8k98aSYVpUWYDW5hvupMmBcK/wjQlyAGkGp2mQh
         4sHKMtBuN1sU91BxSDlaO4tv9wc+vJ3xq59jVq1JyPYrR8c4E/ihZe7Sm1LdCMoZI1aJ
         j987c/bJS5SiEnp3VgXLEeRzDl1ZBqn4k3A8alsqQ8txxbneoWrksiUx1HmDmc+62usU
         sUni2XwL5yJ3u/9RDlKI0a97z3emNPPQhjEGOXyQHOaLTcvQG4ozciaqRY3p9Hsiqzkh
         QmQBXTjoa2/qZC1rLn+wEU9WV7wOLuc3ylH62LOahQTkruModoUDrQilKsM9giEz0+WW
         gwMA==
X-Forwarded-Encrypted: i=1; AFNElJ/Pfxq5iYfmrgOExlyT7cpYgXbYvEngOsFY1e/UiUToorf5VysekK3Iw6OINEUi9WOMbgRMYVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsgb7r0axqcPZ7VVG984Yb9fb9JyT8WxYAL3L3qHwqsOE/kREQ
	67RYduZWWO1YSq+0QMEoC109itjUxHrKhwfkOcil3JTkzzeB6WxasxP/wfONQfPYmX9inaahdM6
	G3sGhCthmiHebeEFdEg==
X-Received: from wmcn8.prod.google.com ([2002:a05:600c:c0c8:b0:488:a988:5a23])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c091:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-488d683662cmr207593395e9.19.1776245973300;
 Wed, 15 Apr 2026 02:39:33 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:37:51 +0000
In-Reply-To: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15232; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pjbAO55XTwIKrveO3PbdZX0WLuUD19YrjQYqWj4r0aw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp31zNrmus/sufEicoc9Kd6GzpXU6laiuVIRFT7
 VM1klZjQc6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCad9czQAKCRAEWL7uWMY5
 RldjD/9AdyhCU9dhdkTvm5ulbdNBhL6bDmZ6IP4uzI9gnp/dAbsLpU9KCTrKrYEWoFS57bR4b96
 Lv0uEm1MOE6y6FF83O6cK3bqJovZol8E4VBgcQaWi4rYgy0EJgrJms/uuBpCNh0gOGMju5bBilX
 YLYxGi/1rSHuRRuzsWrHABKD1kF27hbGppl5Zc9jqSNWzAmNd9gzwwR2O6g2cSGfUxysY5MtESV
 z/iX0zxV7eGCdUdnXlshPK+u1nIPHjRoylqExh7mJf9WF1wUJA1gr3GmntejYT8TZOIDSHCqFK9
 1KS5xizB8obEYV3bi/MEDcld96cAKy/pWmiu3rWxrI3XQ9aDHuC01R+BPHWN/leRS8eeL1kSCJl
 8ditNZrfTzOOkUwhEfg7FQk3zQSZ8MAg9mC1oTY5eDLJMNGhoERRU292X9P9m/8I22Hi4P32w2t
 5GY8V7Z4cUwuFfVzigIJeJo1JS0IIuWFN+CzPbryT08B1UNh0EL5/ugn6sxGRR/Jpb2la0Z53IG
 DFSc512jKUuBYaz7dslfizPey19a3m7K7vqBmt0qHA5Q1M5e7RCmOFBzYyWF+gJYNU4+mVSNzRc
 YR6SP4y2em43rCmWUr7qaOUL35TYPB7u7dnIFS0rrMpNJycauL/KfB+uxE5zJ9BMVT4IQ98z78D AVvAxLP9JFm9ISw==
X-Mailer: b4 0.14.3
Message-ID: <20260415-binder-netlink-v3-1-84be9ba63ee2@google.com>
Subject: [PATCH v3 1/4] rust: netlink: add raw netlink abstraction
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278727-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0141C402C59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 rust/helpers/genetlink.c        |  46 ++++++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/netlink.rs          | 329 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 380 insertions(+)

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
index 000000000000..3530b69f6cf7
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
+	genlmsg_cancel(skb, hdr);
+}
+
+__rust_helper void rust_helper_genlmsg_end(struct sk_buff *skb, void *hdr)
+{
+	genlmsg_end(skb, hdr);
+}
+
+__rust_helper void rust_helper_nlmsg_free(struct sk_buff *skb)
+{
+	nlmsg_free(skb);
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
index d93292d47420..f5ea0ae0b6b7 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -122,6 +122,7 @@
 pub mod module_param;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod netlink;
 pub mod num;
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
diff --git a/rust/kernel/netlink.rs b/rust/kernel/netlink.rs
new file mode 100644
index 000000000000..21f959c95fdc
--- /dev/null
+++ b/rust/kernel/netlink.rs
@@ -0,0 +1,329 @@
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
+/// This type is intended to be specific for buffers used with netlink only, and other usecases for
+/// `struct sk_buff` are out-of-scope for this abstraction.
+///
+/// # Invariants
+///
+/// The pointer has ownership over a valid `sk_buff`.
+pub struct NetlinkSkBuff {
+    skb: NonNull<kernel::bindings::sk_buff>,
+}
+
+impl NetlinkSkBuff {
+    /// Creates a new `NetlinkSkBuff` with the given size.
+    pub fn new(size: usize, flags: alloc::Flags) -> Result<NetlinkSkBuff, AllocError> {
+        // SAFETY: `genlmsg_new` only requires its arguments to be valid integers.
+        let skb = unsafe { bindings::genlmsg_new(size, flags.as_raw()) };
+        let skb = NonNull::new(skb).ok_or(AllocError)?;
+        Ok(NetlinkSkBuff { skb })
+    }
+
+    /// Puts a generic netlink header into the `NetlinkSkBuff`.
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
+impl Drop for NetlinkSkBuff {
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
+    skb: NetlinkSkBuff,
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
+        // SAFETY: `skb` is valid by `NetlinkSkBuff` type invariants, and the provided value is
+        // readable and initialized for its `size_of` bytes.
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
+        // SAFETY: `skb` is valid by `NetlinkSkBuff` type invariants, and a null pointer is valid
+        // when the length is zero.
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
+/// Flags for a generic netlink family.
+struct FamilyFlags {
+    /// Whether the family supports network namespaces.
+    netnsok: bool,
+    /// Whether the family supports parallel operations.
+    parallel_ops: bool,
+}
+
+impl FamilyFlags {
+    /// Converts the flags to the bitfield representation used by `genl_family`.
+    const fn into_bitfield(self) -> bindings::__BindgenBitfieldUnit<[u8; 1]> {
+        // The below shifts are verified correct by test_family_flags_bitfield() below.
+        //
+        // Although bindgen generates helpers to change bitfields based on the C headers, these
+        // helpers unfortunately can't be used in const context. Since `Family` needs to be filled
+        // out at build-time, we use this helper instead.
+        let mut bits = 0;
+        if self.netnsok {
+            bits |= 1 << 0;
+        }
+        if self.parallel_ops {
+            bits |= 1 << 1;
+        }
+        // SAFETY: This bitfield is represented as an u8.
+        unsafe { core::mem::transmute::<u8, bindings::__BindgenBitfieldUnit<[u8; 1]>>(bits) }
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
+            _bitfield_1: FamilyFlags {
+                netnsok: true,
+                parallel_ops: true,
+            }
+            .into_bitfield(),
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
+/// `self.family` always holds a valid reference to an initialized and registered [`Family`].
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
+
+#[macros::kunit_tests(rust_netlink)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_family_flags_bitfield() {
+        for netnsok in [false, true] {
+            for parallel_ops in [false, true] {
+                let mut b_fam = bindings::genl_family {
+                    ..Default::default()
+                };
+                b_fam.set_netnsok(if netnsok { 1 } else { 0 });
+                b_fam.set_parallel_ops(if parallel_ops { 1 } else { 0 });
+
+                let c_bitfield = FamilyFlags {
+                    netnsok,
+                    parallel_ops,
+                }
+                .into_bitfield();
+
+                // SAFETY: The bit field is stored as u8.
+                let b_val: u8 = unsafe { core::mem::transmute(b_fam._bitfield_1) };
+                // SAFETY: The bit field is stored as u8.
+                let c_val: u8 = unsafe { core::mem::transmute(c_bitfield) };
+                assert_eq!(b_val, c_val);
+            }
+        }
+    }
+}

-- 
2.54.0.rc0.605.g598a273b03-goog


