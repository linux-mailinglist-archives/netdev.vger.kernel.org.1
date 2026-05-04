Return-Path: <netdev+bounces-283759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKhBE3Rh+GlJtgIAu9opvQ
	(envelope-from <netdev+bounces-283759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:05:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9C64BABD8
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F9D73009824
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1D35B63F;
	Mon,  4 May 2026 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aoy0Ld5N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7135A939
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885514; cv=none; b=anbIcurrRPY6v5ddLXHMk0+AZ3LbgVSTn4H4VuZwPrWmEepJekvwFNS0Fmy56wP+Jk5vLC8pY3qV4LeK4MWlkGXzfQkXNla9NsUP2CdrxzGpxEDh0ED6yA5/N7TD2KKcALg5HqxZGATr9SElP5NGWeatSGSSGfAc3xV76ItFByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885514; c=relaxed/simple;
	bh=0A6XAfvCdt6W/6IIVvLzFfQVMMJf2MNw3synGGt9C+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ulq2Wm1UUC00VIXFO2b0HtL/e9qL1Rfgf1QhfOk4PXVOqOtFdMwXm3n+SqhC5+AJeepHyNPQ6T3aE0/JH32FICmC4+C2U9xGHuTNDHCgDVPUZpvq01akeRYgz4OhsMcfqEPwComVjz5QXLD7+auStLRHSW8UT6E1pJmgfFfkd+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aoy0Ld5N; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48d0889c1ecso5367625e9.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777885511; x=1778490311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxjmzDKG680fOnwjQkgR5+9rnq3DYmiVavVZFpaNns8=;
        b=Aoy0Ld5N9RvDeHFF+0wn78sLUJgbq92QXP4Nkf2TwrOT1Dqp8KxEQ2IuAGEycd2Cnx
         Db5fv/Dc67ZWoCBamCOVpQF+GlaRqvZycrVU7Ud/zVPGIEzp+KUtIxCN1grJSPTD/BZW
         uhd1Yk83WhEYnkqeQl+3e4PVzsmo1nJTGHhGk4fY3A36lw7sld/zyRoHH3tOgVbbCbny
         13R5R1LkJFE/tVt8Ni+htYfz6mQF6PJhY9Q9u2kNry2R67S5rqtGx3m5byJiR3iC5IUk
         6rX6EYQbn4uCQ22xuXkToV78ZEh5Yl9WszwMuM2Bl3YKI0Wp9Bai/mFL4r8PKysOb8CY
         CW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885511; x=1778490311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxjmzDKG680fOnwjQkgR5+9rnq3DYmiVavVZFpaNns8=;
        b=kh3xP9C+D9MBZTuzgpZsyHE39BzHd/0eEApRWLRVg5cQ24pbiL+uy7GyZfPZ53aZ/y
         jf5zuWrQ1hOqNvC8kZ6EJo+OKQKR8r1NfBPSA59bw5Q/+OqoncIs71LuretpdcKYnvjo
         pat3TqvyNxLcJJ61fKUWZ0pmS8E6A5XB7gzagEBtzzoofvAT5tHTUwu1QIfZdDjy478W
         gHn9J5OVfIssjXR/xX2kj+eAZRFrvHlaBXVTxyM16KJuE3wqzhtENNGpi/oSymUF3Mw6
         BxEL88csqzlZU7ZC5hrph2xDLjTgQ7PzJKzsvp4im4NO6WHPXdRR1E1UiMMTJg5VcFow
         i0Tg==
X-Forwarded-Encrypted: i=1; AFNElJ/OkzvTdRSjwMq8x6tVMJPxHfg6mXcmh3EsvNY+wgkz/RrSab+1mnmG++9G+90GKBijSx1TbKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDsmC5G7eOttBrSSFPJ1kLogbSstAYvHHYZPIMZ3nP4hSe/3+F
	XCU+zHmA1UI18vMa8Dtr8FHKGYG/QAUkskAhnZdk/Dy+ZyLBbxIsWv3Fgb9dxnEETjiTPz4/rPw
	Ech0uNklMEF51ojWqHA==
X-Received: from wmdd13.prod.google.com ([2002:a05:600c:a20d:b0:48a:66a8:9970])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a011:b0:48a:8cb6:88b9 with SMTP id 5b1f17b1804b1-48a988be2b3mr140212885e9.22.1777885510778;
 Mon, 04 May 2026 02:05:10 -0700 (PDT)
Date: Mon, 04 May 2026 09:04:56 +0000
In-Reply-To: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7772; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=0A6XAfvCdt6W/6IIVvLzFfQVMMJf2MNw3synGGt9C+8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp+GFAnX+ozWqi83GnI7z5xxQzfxq1FXvnAuFBZ
 ro/hEDwmtqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafhhQAAKCRAEWL7uWMY5
 RhRUD/oCb7ZGuVAnoCa76M5ZkVRtq3ZzgMhM9cOaZAKFJmk8Iga7Y+Hlh/WxjPGmj5v3LZznrEY
 upyyhilIY4PL351k68v2mx0GUUBC0eKxE/uUWMf8d7J9YxbS2mJ0aPelkeHVDNtM49mhl9VvGX3
 FW04Nz05cUbEY6aguFyHUeTwA19FqXm02MRbOd16CzFAiGWKIx7V/Vg3JJtZTTG2rvq8WsZAJuZ
 5XC77IHX/PM0j8OWVDhtr3/7j4VFP+b9JZW5L0ITJJqTnvy/IMNL32sXGNqsIoVK1imW45bfKdR
 4GLzIRmxcvGxfj7Adn8FxkFrOuKpFZUDvwda03YRkGVfBKnquskcT6vTpre2VpAkcFqRA2VUMI/
 9FuzdcmhwWUoGqG+3cEKMOoEmLr1uNUDtnkJ71xaLaQvOsb80kxz73+Vtq+zgPOh74JuPNTpigp
 FZ9GSBiqqZ09B0sal6YmfoKVYqOzKrTYTAtmdyLewbBlSdMzojXtXcO9f8itMDqkunlDGOb/swA
 t9yU3g/A0mO+/qMdsjHtjOlIHx3VJnzp5Vx2hHHt2/IDHk/ojgYZME3h9wXMB8L33AZ/8V2f7KZ
 gc5DbPFNGuMn+l2bwgnshdP4N0yRbIqwfluH28ysKTZDV7ihFqqYsOITSK5grn8S6tDaPiwzTxf Sz2G+ArQpUhh1ag==
X-Mailer: b4 0.14.3
Message-ID: <20260504-binder-netlink-v4-3-601b41cd25b2@google.com>
Subject: [PATCH v4 3/4] rust_binder: add generated netlink.rs file
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
X-Rspamd-Queue-Id: 5A9C64BABD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283759-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,linuxfoundation.org,lunn.ch,gmail.com,kernel.org,davemloft.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,google.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

To use netlink from Rust Binder, add a new generated netlink file using
the new script and Documentation/netlink/specs/binder.yaml.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/Kconfig                    |   2 +-
 drivers/android/binder/netlink.rs          | 113 +++++++++++++++++++++++++++++
 drivers/android/binder/rust_binder_main.rs |   9 ++-
 rust/uapi/uapi_helper.h                    |   1 +
 4 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index e2e402c9d175..606a9d07f774 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -16,7 +16,7 @@ config ANDROID_BINDER_IPC
 
 config ANDROID_BINDER_IPC_RUST
 	bool "Rust version of Android Binder IPC Driver"
-	depends on RUST && MMU && !ANDROID_BINDER_IPC
+	depends on RUST && MMU && NET && !ANDROID_BINDER_IPC
 	help
 	  This enables the Rust implementation of the Binder driver.
 
diff --git a/drivers/android/binder/netlink.rs b/drivers/android/binder/netlink.rs
new file mode 100644
index 000000000000..2a842c7b1b33
--- /dev/null
+++ b/drivers/android/binder/netlink.rs
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder.yaml */
+/* YNL-GEN rust source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#![allow(unreachable_pub, clippy::wrong_self_convention)]
+use kernel::netlink::{Family, MulticastGroup};
+use kernel::prelude::*;
+
+pub static BINDER_NL_FAMILY: Family = Family::const_new(
+    &crate::THIS_MODULE,
+    kernel::uapi::BINDER_FAMILY_NAME,
+    kernel::uapi::BINDER_FAMILY_VERSION,
+    &BINDER_NL_FAMILY_MCGRPS,
+);
+
+static BINDER_NL_FAMILY_MCGRPS: [MulticastGroup; 1] = [MulticastGroup::const_new(c"report")];
+
+/// A multicast event sent to userspace subscribers to notify them about
+/// binder transaction failures. The generated report provides the full
+/// details of the specific transaction that failed. The intention is for
+/// programs to monitor these events and react to the failures as needed.
+pub struct Report {
+    skb: kernel::netlink::GenlMsg,
+}
+
+impl Report {
+    /// Create a new multicast message.
+    pub fn new(
+        size: usize,
+        portid: u32,
+        seq: u32,
+        flags: kernel::alloc::Flags,
+    ) -> Result<Self, kernel::alloc::AllocError> {
+        const BINDER_CMD_REPORT: u8 = kernel::uapi::BINDER_CMD_REPORT as u8;
+        let skb = kernel::netlink::NetlinkSkBuff::new(size, flags)?;
+        let skb = skb.genlmsg_put(portid, seq, &BINDER_NL_FAMILY, BINDER_CMD_REPORT)?;
+        Ok(Self { skb })
+    }
+
+    /// Broadcast this message.
+    pub fn multicast(self, portid: u32, flags: kernel::alloc::Flags) -> Result {
+        self.skb.multicast(&BINDER_NL_FAMILY, portid, 0, flags)
+    }
+
+    /// Check if this message type has listeners.
+    pub fn has_listeners() -> bool {
+        BINDER_NL_FAMILY.has_listeners(0)
+    }
+
+    /// The enum binder_driver_return_protocol returned to the sender.
+    pub fn error(&mut self, val: u32) -> Result {
+        const BINDER_A_REPORT_ERROR: c_int = kernel::uapi::BINDER_A_REPORT_ERROR as c_int;
+        self.skb.put_u32(BINDER_A_REPORT_ERROR, val)
+    }
+
+    /// The binder context where the transaction occurred.
+    pub fn context(&mut self, val: &CStr) -> Result {
+        const BINDER_A_REPORT_CONTEXT: c_int = kernel::uapi::BINDER_A_REPORT_CONTEXT as c_int;
+        self.skb.put_string(BINDER_A_REPORT_CONTEXT, val)
+    }
+
+    /// The PID of the sender process.
+    pub fn from_pid(&mut self, val: u32) -> Result {
+        const BINDER_A_REPORT_FROM_PID: c_int = kernel::uapi::BINDER_A_REPORT_FROM_PID as c_int;
+        self.skb.put_u32(BINDER_A_REPORT_FROM_PID, val)
+    }
+
+    /// The TID of the sender thread.
+    pub fn from_tid(&mut self, val: u32) -> Result {
+        const BINDER_A_REPORT_FROM_TID: c_int = kernel::uapi::BINDER_A_REPORT_FROM_TID as c_int;
+        self.skb.put_u32(BINDER_A_REPORT_FROM_TID, val)
+    }
+
+    /// The PID of the recipient process. This attribute may not be present
+    /// if the target could not be determined.
+    pub fn to_pid(&mut self, val: u32) -> Result {
+        const BINDER_A_REPORT_TO_PID: c_int = kernel::uapi::BINDER_A_REPORT_TO_PID as c_int;
+        self.skb.put_u32(BINDER_A_REPORT_TO_PID, val)
+    }
+
+    /// The TID of the recipient thread. This attribute may not be present
+    /// if the target could not be determined.
+    pub fn to_tid(&mut self, val: u32) -> Result {
+        const BINDER_A_REPORT_TO_TID: c_int = kernel::uapi::BINDER_A_REPORT_TO_TID as c_int;
+        self.skb.put_u32(BINDER_A_REPORT_TO_TID, val)
+    }
+
+    /// When present, indicates the failed transaction is a reply.
+    pub fn is_reply(&mut self) -> Result {
+        const BINDER_A_REPORT_IS_REPLY: c_int = kernel::uapi::BINDER_A_REPORT_IS_REPLY as c_int;
+        self.skb.put_flag(BINDER_A_REPORT_IS_REPLY)
+    }
+
+    /// The bitmask of enum transaction_flags from the transaction.
+    pub fn flags(&mut self, val: u32) -> Result {
+        const BINDER_A_REPORT_FLAGS: c_int = kernel::uapi::BINDER_A_REPORT_FLAGS as c_int;
+        self.skb.put_u32(BINDER_A_REPORT_FLAGS, val)
+    }
+
+    /// The application-defined code from the transaction.
+    pub fn code(&mut self, val: u32) -> Result {
+        const BINDER_A_REPORT_CODE: c_int = kernel::uapi::BINDER_A_REPORT_CODE as c_int;
+        self.skb.put_u32(BINDER_A_REPORT_CODE, val)
+    }
+
+    /// The transaction payload size in bytes.
+    pub fn data_size(&mut self, val: u32) -> Result {
+        const BINDER_A_REPORT_DATA_SIZE: c_int = kernel::uapi::BINDER_A_REPORT_DATA_SIZE as c_int;
+        self.skb.put_u32(BINDER_A_REPORT_DATA_SIZE, val)
+    }
+}
diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index dc1941cd2407..2cb9f4897ad7 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -38,6 +38,8 @@
 mod deferred_close;
 mod defs;
 mod error;
+#[allow(dead_code)]
+mod netlink;
 mod node;
 mod page_range;
 mod process;
@@ -288,19 +290,22 @@ fn ptr_align(value: usize) -> Option<usize> {
 // SAFETY: We call register in `init`.
 static BINDER_SHRINKER: Shrinker = unsafe { Shrinker::new() };
 
-struct BinderModule {}
+struct BinderModule {
+    _netlink: kernel::netlink::Registration,
+}
 
 impl kernel::Module for BinderModule {
     fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
         // SAFETY: The module initializer never runs twice, so we only call this once.
         unsafe { crate::context::CONTEXTS.init() };
 
+        let netlink = crate::netlink::BINDER_NL_FAMILY.register()?;
         BINDER_SHRINKER.register(c"android-binder")?;
 
         // SAFETY: The module is being loaded, so we can initialize binderfs.
         unsafe { kernel::error::to_result(binderfs::init_rust_binderfs())? };
 
-        Ok(Self {})
+        Ok(Self { _netlink: netlink })
     }
 }
 
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 06d7d1a2e8da..86c7b6b284b0 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -11,6 +11,7 @@
 #include <uapi/drm/nova_drm.h>
 #include <uapi/drm/panthor_drm.h>
 #include <uapi/linux/android/binder.h>
+#include <uapi/linux/android/binder_netlink.h>
 #include <uapi/linux/mdio.h>
 #include <uapi/linux/mii.h>
 #include <uapi/linux/ethtool.h>

-- 
2.54.0.545.g6539524ca2-goog


