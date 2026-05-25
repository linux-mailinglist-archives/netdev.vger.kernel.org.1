Return-Path: <netdev+bounces-291324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBN7MxBNFGqnMQcAu9opvQ
	(envelope-from <netdev+bounces-291324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 542CF5CB0AD
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080ED30570DB
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BBF384242;
	Mon, 25 May 2026 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAEyjkse"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90166384CE2
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715070; cv=none; b=V2PvZ3vfUP8xRL6HSC4N4J7mriJpeJxDFL6fu/pWdHIacpPwl0SYaFnl3fm6Cf6VteAhr0Hn1uFmicG0vR9gPytxRxB1NC/sHCPSLUqWY4pDlxx5I+5k+UgK3cqV5PvhONMZYIwBz0fUQI6zJLu64B1nJUliOxgEmRxrYQSJbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715070; c=relaxed/simple;
	bh=cXkggUMWdYmJT2UG2mDh/fQnlEuCCAgIFTLuPJak0FE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RULpxVcYxTOrtcxliYmAoBZW1ViPO3UJQ5UCWyRJvKQmrEMtKDn5zNCkgDb4KuFe3nf5zlCNEgEn92T+ZNYWDi2sZYuPjv5vImR2xUK7LuKFtajuFHScaUA+/9H10MGS9U3Z/3aU5yFBtuvmqZd1lIj0Ejf8LRuSsHxCYDBTbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jAEyjkse; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fe40b61a3so61802855e9.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779715065; x=1780319865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KNbG2HJ2MZ13W/tRCu38pNn9hGvLRzMifdYB/tdu2zc=;
        b=jAEyjkseISXtOamMDEmaKkn4G+KlZliUg+FrJMzqvwGG/o7q/nrHcwuN5JUPcQmVBg
         hGT60bzLx2s957d0uXuZjpm/CQ9J0Fj3vW0fmu7k4RbrW2mjhAwExq5U4UHDUJCNzPD3
         Zyd/j7NP4P12hmJPjQvXX9FS24aCSrpScUAe8e9VKPMyeBs50XGYd+G0WQA6ayhV9XQU
         pq1WpA08NwHzVE5irB4Lr9weolfRUFmg/MFiZICvlJlz4dkldwj+2jeU5W4AH9flltYX
         rOT0QOkZJGafujA+aksk4EJvvgB/Y7QdGo6HlkIrfPPlO71nGi0ODyG9GkS+TAs5vapb
         0U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779715065; x=1780319865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNbG2HJ2MZ13W/tRCu38pNn9hGvLRzMifdYB/tdu2zc=;
        b=r/G2VIzN25VlN58cKP1onySfDv6gNyf0y9WjlvdxpRSMIq6/eUnu4XP8j3nVdFapZa
         5dAmoRdXmtF/sGdSAUy8cEbuVSml+sL5hmasG6SVAyz86lrWGsF16GC0bE7GOVBSPgeH
         gMeKG9fFkiKf6jMOC0l6bFCFU9RzzlTo5viuY6PnNHTlU0WKuCT+Bl/Bj+uTDU5AicwF
         PxwecArkIVy72YfvtTc9lS61SrT0XkXSb719q56iNZWSruRpyEQhtd+oMe1q6G9A+nkY
         u276qnQEVH5u82C6fkbL00ek98xPjbINI9YzN9BQ33OkJ0hgnHeW/k2m/zhA4FfTYURP
         rWFw==
X-Forwarded-Encrypted: i=1; AFNElJ83j+E7bnnrmXKxyos+lP9GtOCrvQQJIa0aJBXVHyVda3neltCBPvknDKOatUeb4eT3YwlfFvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lhaSGktK4Fsg0ffhsKl+f+lQODheTlY2xTkuY14BXopmtozI
	XJw2JOi/yR7jOIS05taGG78CgL8vVGN52lm5SRBMmvuA5oWWBEBygKjlj0zqdbWhf/xoT4XEQeH
	V65xSbjpKEA2rJGm0jQ==
X-Received: from wmep20.prod.google.com ([2002:a05:600c:4314:b0:489:1f97:aec7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f52:b0:490:4f91:5519 with SMTP id 5b1f17b1804b1-4904f91568dmr207512105e9.18.1779715064610;
 Mon, 25 May 2026 06:17:44 -0700 (PDT)
Date: Mon, 25 May 2026 13:17:28 +0000
In-Reply-To: <20260525-binder-netlink-v5-0-a90e2923ebeb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525-binder-netlink-v5-0-a90e2923ebeb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11302; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=oqg7PkgyuFpdSHZMroM+y5quqYpOBs1htUkwsJ8R/8c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqFEvznwLPvxPxyuavoTjmHREwRQvXPngCSNim/
 CTdbY12tbmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCahRL8wAKCRAEWL7uWMY5
 RprCD/9w73QGw1Svtvfz2T7YBtimsZyxq7IWWS3bpjB2bI8ZZFIC9pUGZDvY3ATeRO1lpC4Td01
 JK42P3vJbgkVTVq3YD3pm/JKPWSwX+qCXf5QOZluwwPik4gMk8aHXp19q8kDk1zAXszGuhx7VKo
 HDkK9D03UtTX+BrXMfnG2aoIZwmhlnC+EVr8f3Rhno1ag0wYL8BuuuFNGdGSmbqse7rSqx81+37
 XXnZQ/Aoly9MCRgETIqg+QUC+2uJG6/0EN5SnGsa6537FnNGB1xjm5zXCwAx2qrxke8yzeQy+jw
 B68SIF8AMrNmnf9PncumjNvKI0SjM40nZJPGkRN4sAz1GQzSbXwiP3R0dmvZzBl9/aUlIgXW89m
 Lj/tEXXOv90kvn30Km0LCtYR7XPU9sSo4WC/WrlUMLrrax150g21tnVp+4mdDia+vHcwDMsycht
 M5aKCHleLzj2BJ0kuVYpBdweAdJQWQWxpRbMGc0x0llEHXLlgg/BGPDrdvEIO8WkVzecXaQVZYY
 K+nP3iNEHuOmBZuTQaUldlmCz16GUeg0nIJ/xUV0aCm0Vi2nstrrTJuW4ONLE+udU9fOudBmVnV
 iZgLhiR6J8ZmhRPSV3nf4q6OMnloBQS7xUBZcCnxBDdLsh+U/yPXloVKoxv9VHjURBpeiwmVKhZ YUs7/3Kv/bed5Dw==
X-Mailer: b4 0.14.3
Message-ID: <20260525-binder-netlink-v5-2-a90e2923ebeb@google.com>
Subject: [PATCH v5 2/2] rust_binder: report netlink transactions
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
	TAGGED_FROM(0.00)[bounces-291324-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.873];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 542CF5CB0AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Llamas <cmllamas@google.com>

The Android Binder driver supports a netlink API that reports
transaction *failures* to a userspace daemon. This allows devices to
monitor processes with many failed transactions so that it can e.g. kill
misbehaving apps.

One very important thing that this monitors is when many oneway messages
are sent to a frozen process, so there is special handling to ensure
this scenario is surfaced over netlink.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/Kconfig                    |   2 +-
 drivers/android/binder/netlink.rs          | 110 +++++++++++++++++++++++++++++
 drivers/android/binder/rust_binder_main.rs |   8 ++-
 drivers/android/binder/thread.rs           |  10 +++
 drivers/android/binder/transaction.rs      |  40 +++++++++++
 rust/uapi/uapi_helper.h                    |   1 +
 6 files changed, 168 insertions(+), 3 deletions(-)

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
index 000000000000..818ac6f2536d
--- /dev/null
+++ b/drivers/android/binder/netlink.rs
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Based on: Documentation/netlink/specs/binder.yaml */
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
index dc1941cd2407..bbef68993b8d 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -38,6 +38,7 @@
 mod deferred_close;
 mod defs;
 mod error;
+mod netlink;
 mod node;
 mod page_range;
 mod process;
@@ -288,19 +289,22 @@ fn ptr_align(value: usize) -> Option<usize> {
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
 
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 97d5f31e8fe3..aa4e93a877ac 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1263,6 +1263,15 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
             }
         }
 
+        if info.oneway_spam_suspect {
+            // If this is both a oneway spam suspect and a failure, we report it twice. This is
+            // useful in case the transaction failed with BR_TRANSACTION_PENDING_FROZEN.
+            info.report_netlink(BR_ONEWAY_SPAM_SUSPECT, &self.process.ctx);
+        }
+        if info.reply != 0 {
+            info.report_netlink(info.reply, &self.process.ctx);
+        }
+
         Ok(())
     }
 
@@ -1332,6 +1341,7 @@ fn reply_inner(self: &Arc<Self>, info: &mut TransactionInfo) -> BinderResult {
             );
             let reply = Err(BR_FAILED_REPLY);
             orig.from.deliver_reply(reply, &orig);
+            info.reply = BR_FAILED_REPLY;
             err.reply = BR_TRANSACTION_COMPLETE;
             err
         });
diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
index 47d5e4d88b07..3fa7091ed8a6 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -3,6 +3,7 @@
 // Copyright (C) 2025 Google LLC.
 
 use kernel::{
+    netlink::GENLMSG_DEFAULT_SIZE,
     prelude::*,
     seq_file::SeqFile,
     seq_print,
@@ -17,6 +18,7 @@
     allocation::{Allocation, TranslatedFds},
     defs::*,
     error::{BinderError, BinderResult},
+    netlink::Report,
     node::{Node, NodeRef},
     process::{Process, ProcessInner},
     ptr_align,
@@ -49,6 +51,44 @@ impl TransactionInfo {
     pub(crate) fn is_oneway(&self) -> bool {
         self.flags & TF_ONE_WAY != 0
     }
+
+    pub(crate) fn report_netlink(&self, reply: u32, ctx: &crate::Context) {
+        if let Err(err) = self.report_netlink_inner(reply, ctx) {
+            pr_warn!(
+                "{}:{} netlink report failed: {err:?}\n",
+                self.from_pid,
+                self.from_tid
+            );
+        }
+    }
+
+    fn report_netlink_inner(&self, reply: u32, ctx: &crate::Context) -> kernel::error::Result {
+        if !Report::has_listeners() {
+            return Ok(());
+        }
+        let mut report = Report::new(GENLMSG_DEFAULT_SIZE, 0, 0, GFP_KERNEL)?;
+
+        report.error(reply)?;
+        report.context(&ctx.name)?;
+        report.from_pid(self.from_pid as u32)?;
+        report.from_tid(self.from_tid as u32)?;
+        if self.to_pid != 0 {
+            report.to_pid(self.to_pid as u32)?;
+        }
+        if self.to_tid != 0 {
+            report.to_tid(self.to_tid as u32)?;
+        }
+
+        if self.is_reply {
+            report.is_reply()?;
+        }
+        report.flags(self.flags)?;
+        report.code(self.code)?;
+        report.data_size(self.data_size as u32)?;
+
+        report.multicast(0, GFP_KERNEL)?;
+        Ok(())
+    }
 }
 
 use core::mem::offset_of;
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
2.54.0.746.g67dd491aae-goog


