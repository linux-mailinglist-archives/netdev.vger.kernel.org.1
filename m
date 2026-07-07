Return-Path: <netdev+bounces-305397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5m5VFjfQTGqcqAEAu9opvQ
	(envelope-from <netdev+bounces-305397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:08:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42471A230
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:08:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=HKNvYKla;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305397-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305397-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFBDC305E27C
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31FD3DB625;
	Tue,  7 Jul 2026 10:07:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF53DA7F5
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:07:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418830; cv=none; b=Iv4skSAk9s9dledrCdNSyIMkwvCh5qaYgPc70o1nMfalCtT4I43yOAnLWk8SfANRmZx1kaH7plIY7hp9N3bLPua7mZdn+RAzgxZVOZ71BWGkcke1ldlAahAfQTK/ISc7hlZgC+Z/gmArRdk5kBeXovK0fCpUXGP8wvnej0jyU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418830; c=relaxed/simple;
	bh=6YFTVJq+eXK1sd4f4NYRqF8TiaWwoIg3PDzftuocxPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l5ZfyrLyrahwtvUeC4w6SXdEEOifRBpzO6v3tnt7RjflxiT4AN6YWwc/cH9byu+O9Mw/ooLw4plVqx5OMJzj8ZSGs76rm2sM6yRiYsalh2mDyFYgJCz1QJ0yVijdzSqFMpap1fzhMNuJFjfG7pTAtnFY4PgagRBEv7hFVXgIlIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKNvYKla; arc=none smtp.client-ip=209.85.128.73
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493b786d550so43432365e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783418827; x=1784023627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvJZiF+ZNcO6HcSEVguvAgjmo1hMTzhxVHQS84V41HQ=;
        b=HKNvYKlaAIoTWg6YI//A7jiGJg4+fUsJGItJBuSwbhsV9GkzLG4YaDlejDZuv9a0/a
         jF1Ua52y2P1fy95yNve0QYAhxHwoU6STrOFDHI8E/aKAHeQo7napxKJwpwO0sA0u29WP
         i2nYOqXD+dtfCTnu05UmVJArKOl2HjPhjONmozCOUDKv1qEJjGo4rm/C6fqxuloLwdGV
         jV3Ighg794weoNLUwlrnW13WX/Xz4DFOlwYmMXok0GLpk1WLPxKQUT92ozkkQJuneCqm
         8WACoUrEqF4fXVeo0ikSl4YQ0R8Prb67p4riwkTnuYpDOMT+ffm1fk5+01DHPE9IWa1m
         dzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783418827; x=1784023627;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvJZiF+ZNcO6HcSEVguvAgjmo1hMTzhxVHQS84V41HQ=;
        b=fkmdiE7pr+vn8svVzvljgfsnh4s+vbWWKqnxRFNsZ5/x67YbR0yr4V1aqJSVgdUYHy
         C7kXFE8FEzNFHo8XV6NQ0cgT/9OassAFLSGd2tybCoe5h1eZgDGr5Ths3TeILirk1lP3
         EbDLcActk1hF//eYjMhvRnwUpCIM+CS++1TMlciKe6OVGYkQn074z55KKx7bNijrGhr7
         VEA1OFkxScfOIObwwo8JudZ/Q4X0IvuHPxUxV2rzwO6B6Df677dvfnasWwRjU9ndnCJy
         gyE1yQ13e/RXEfC9kqQtteV0W0HtgdefvsR+tgBsPkrf2/tuCXDdTGa2I/qFeLvDvsrh
         T/cA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3yPyxj1ldW3JBdBLBe3zDnUjlSNyH1KKD8JQDwC8b4SmJLJGUfCJGm3WbXa3tnAgrFrD05hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAyrz7sWw6kPxBtyalXhHKJhk/IY6eXXe24GVZ3l0CiTOtHIY4
	BDoe3Fy5WZCOhQK1f9zVLQE9WpgbbyBu9syz22aHnrvEcZ7MOvNYMofNlZEajn0q6z7fw9gaY6a
	VJ9wJtpadua8jjgbBmg==
X-Received: from wmbjv16.prod.google.com ([2002:a05:600c:5710:b0:493:bb45:d546])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:609b:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-493df0aec34mr47588595e9.28.1783418826788;
 Tue, 07 Jul 2026 03:07:06 -0700 (PDT)
Date: Tue, 07 Jul 2026 10:06:50 +0000
In-Reply-To: <20260707-binder-netlink-v7-0-42b40e4b1ac8@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707-binder-netlink-v7-0-42b40e4b1ac8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15895; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=6YFTVJq+eXK1sd4f4NYRqF8TiaWwoIg3PDzftuocxPQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqTM/DlbMlkDy/2oEXGmvLBSZzclxx43420Dqeo
 9E9lfcOaOmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCakzPwwAKCRAEWL7uWMY5
 Ru4tD/4v/5mqTPApPbbI3x/opInmM+ceINjZuzqAGA5zJH6MzGbelmZDL+yXNNpYT1X7J0LJghl
 GojR0XF5N9z0DdjO5KS+xyM9xNSIKLMDk8dCFA4UR92nz8pcf5QG7Z5weLgqwU0R+K/OhGq4jdx
 J619lkUgY6V13tmG9ywaAyqw+VSOp4hA/CP1gkVqbClH7T2Zd2N1fEKFeFzV8Mak6iN9AGq++EG
 e9ZxhDMhYeX+MgZ8D5c/vslDbDe+dyFQbF2tX52ZCK1+8zJYuZ7H2Lst74CM7xl/HXu9t4VI+O3
 qQRvscrWsN4S5tcsA3xfoLyU2I1jdCkkUNzGtYRGhBrUb3/I0+sD2SOOAUA4ErLI+iwNuJ5YqSX
 ukiD+u4QCTR5+WNq8SYkode514OLZttymLN2EiIWbpjbD//zJZS/EOi3efBoI/DMneDzqxnbhoM
 WL31rFjCixdOtOE/xNePFTvAj6mGiDj8LHiUOnyFScCkwOi1QXwloT+X/b8dk8R70VHyhfo1+Iv
 twvpfBK6c+O5SOceAef/17itHzGj90/YVqu5SSe6+O2UHshQ4rR1f/268ty2gLcgdWrWtIH2I9T
 7cSFNmv4q4Awt5IdpVU1CCu66ggwOFQFJuCDQZss9/fnZNoVgaiid7We32guQEVswMwoYOOABxa WvwKA1N87sYMTWQ==
X-Mailer: b4 0.14.3
Message-ID: <20260707-binder-netlink-v7-2-42b40e4b1ac8@google.com>
Subject: [PATCH v7 2/3] rust: netlink: add raw netlink abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cmllamas@google.com,m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:mmaurer@google.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:brauner@kernel.org,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:netdev@vger.kernel.org,m:aliceryhl@google.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305397-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[google.com,linuxfoundation.org,lunn.ch,gmail.com,kernel.org,davemloft.net,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,google.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF42471A230

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

Reviewed-by: Matthew Maurer <mmaurer@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   3 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/net/genetlink.c    |  46 ++++++
 rust/kernel/net/mod.rs          |   2 +
 rust/kernel/net/netlink.rs      | 337 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 389 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1124785e210b..ec96e811610d 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -93,6 +93,8 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <trace/events/rust_sample.h>
 
 /*
@@ -110,6 +112,7 @@
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
 const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN = ARCH_KMALLOC_MINALIGN;
 const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
+const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE = GENLMSG_DEFAULT_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 998e31052e66..1d4ee51f576b 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -72,6 +72,7 @@
 #include "maple_tree.c"
 #include "mm.c"
 #include "mutex.c"
+#include "net/genetlink.c"
 #include "of.c"
 #include "page.c"
 #include "pci.c"
diff --git a/rust/helpers/net/genetlink.c b/rust/helpers/net/genetlink.c
new file mode 100644
index 000000000000..3530b69f6cf7
--- /dev/null
+++ b/rust/helpers/net/genetlink.c
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
diff --git a/rust/kernel/net/mod.rs b/rust/kernel/net/mod.rs
index fe415cb369d3..8ecae7577ed2 100644
--- a/rust/kernel/net/mod.rs
+++ b/rust/kernel/net/mod.rs
@@ -4,3 +4,5 @@
 
 #[cfg(CONFIG_RUST_PHYLIB_ABSTRACTIONS)]
 pub mod phy;
+
+pub mod netlink;
diff --git a/rust/kernel/net/netlink.rs b/rust/kernel/net/netlink.rs
new file mode 100644
index 000000000000..22ef3dde36fa
--- /dev/null
+++ b/rust/kernel/net/netlink.rs
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Google LLC.
+
+//! Rust support for generic netlink.
+//!
+//! Currently only supports exposing multicast groups.
+//!
+//! C header: [`include/net/genetlink.h`](srctree/include/net/genetlink.h)
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
+        // Convert from little endian to the target's endianness.
+        bits = u8::from_le(bits);
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
+    ///
+    /// Intended to be used from const context only. Will panic if provided with invalid arguments.
+    ///
+    /// The name must be a nul-terminated string, but it is taken as `&[u8]` so that it can be used
+    /// more conveniently with the strings generated by bindgen.
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
+    ///
+    /// Intended to be used from const context only. Will panic if provided with invalid arguments.
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
2.55.0.rc2.803.g1fd1e6609c-goog


