Return-Path: <netdev+bounces-264847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEsFLkLwqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:18:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF05223A56
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78ACA307456B
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD43B8BA3;
	Fri,  6 Mar 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZsa4FqM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4F3B7B69
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809954; cv=none; b=qsKdfdKCrSLuGqUwLwEB01q46O0FLmvekLrrmZzNBUWq3YKEeRDGnoOKNV5jIEo4nb8GLeCxIx1kPBsjgpYT74HxFZ/N32tTL544ld3yfrtWtFwH1JmmCU8ReHQmeoxYt1BN9NETkagND8YVyEHNMpLLB/O69rBZI/A6vedU7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809954; c=relaxed/simple;
	bh=Sk1TAxEEV4GhsxW0UREgc7Kuhcte6geJK72w1Dswhp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tv68M+ayZjXzbHFB1bksXnfOtU4Ff2fjFjdjWK0LmOYptYc6mmVVeItaT3FIVpFdZIzJuBn5yFqyMQcNcEOlnQTcdLsR8m6Ol+mTtEVnb2O9dcgPphEHkCv3+Qbqhe6yTTecxtcO3G7v9DS9Gcp2TR7tA/jMgZ2OjLdjPo39TDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZsa4FqM; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b943a60ee02so35201966b.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772809948; x=1773414748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKcO5P//MUAi6X8UCN0d3ddOG88u8rL+NGXHISGAiZM=;
        b=vZsa4FqMK+bK0V4+Bo1bQl3n4tEEkuEIR1C3XKY7x8Q/gONlEEO1w5njlAc2g3xw4x
         5BlHbDn+2BiZebZ8hM4+QlZxHriRnaIDljUtUnqV1GdrnOTdcbWJEDT8Qj/Wppb4SIn0
         1ikV7l34NYq90CiySAp9QRgvSLoMQgvncVK4RtJtCuaAnkrvkP7ZBHfz2gXQms5rV9A0
         Nw8NHQqofqO09bGoPmrY5qVo2hv64TLndZIoXqH3BZOUWSR5h39daaodYa5Nz9YdCG3a
         OOpcP10okDTU6W797DJG9bCFBdf4AJRTheyU+v9/RUuZtrOawX6lS0E8gspm+aW8vuSl
         GKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772809948; x=1773414748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKcO5P//MUAi6X8UCN0d3ddOG88u8rL+NGXHISGAiZM=;
        b=Irxu4Dfz2Tn0e+O+E8EgAQkEGn/QkvpFbdvF8VcifkSyvUFf6qLYkDFnS7zfGzDMAl
         v+CzvPyh2m47MvQv+Bp4uVb2ek8J3LurXbZAiHi1Tk1g4BZEUcDQbpM0pgLDdP1NwFtb
         GRMKt1fKQNlORUEL3iCUWJKvqMFxQqKiPN0JXZjT8gtzGUSNkc28wg7CaO+Ro92adAT7
         SfikW8JDl1mSbq+WRsndO6zTxS5s63F3eU8BFgkaQWZVLH1Bs+Bz78uPCNCzyNbDpro5
         9T5YPVFic3hlHSQ7MsuVLAew8AlEUXLDRfmaZrm6d8TkJShaCI0RGJiDXH+ClAAsW0lG
         hruA==
X-Forwarded-Encrypted: i=1; AJvYcCWhbGOJx3MSbXlS6M3FTh24nUC05fKuPuZFfkhSkCWc9q8oR5CaOQF8bIeITbyWjX1CB4kceS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+2XozBDCNR6feyMKScgeKuRiRhgfrE2sa7hUeJcXxM3w8RtO
	T6DWf371wxPAnPE2E117Jl+tUy8NR5IuTERSHzkVnw+UyJ82Cmnmn9LELt6/g9KhfNDgxrE6e3i
	9MeOJFvDYk8B75DEtGQ==
X-Received: from ejcuh2.prod.google.com ([2002:a17:906:b382:b0:b8f:87e0:aa2b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3da7:b0:b87:1e50:95c2 with SMTP id a640c23a62f3a-b942da27c26mr139764066b.3.1772809947304;
 Fri, 06 Mar 2026 07:12:27 -0800 (PST)
Date: Fri, 06 Mar 2026 15:12:15 +0000
In-Reply-To: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7753; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Sk1TAxEEV4GhsxW0UREgc7Kuhcte6geJK72w1Dswhp0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpqu7V1SkNGeGtAl99aCrvoRQqa5WaFdwWxGa6A
 sYlU5EocSmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaaru1QAKCRAEWL7uWMY5
 RqWSEACpsPjJtTqGr9LbRZAqK0TdOwEL3LxqkFcUggStQFpHcFhIEnIqPonudosX/Npk9XxEtfK
 VFbNxrRny+tyU92GuA4C0xd0r2StiWliofGelTxDAo78F+J5hOTFNYIskP/H49JqM84lWDoW3gI
 uxqoKplpRe93kAsQQyU7OSWQ++sUAzVdO0Z+vXakJ8xGPktO546+/SGPdsgh6feIj0khjlfsinF
 IcfsiSRLgBAnsu34971biAiqXWMY94dYR412L4Y16HfNS0JZ+Z9znQnn//nSfEaNd8SosdE+giZ
 lLW3yI/Lwe4A85wleV+kWWxPKWr9OeCigGsGeAilYVVk2804nVrUOh0HK6cOJK7lrSFaW6MAa2S
 ZPqMN8THwytpPo1r6enQD9xVc9TOPBcS9smg8ztIwaTAuU9ZNZFIgPAoN54avZmMVJACBGTPecV
 TEalNrpdWZqWmsB5l2KnV3xOuvoeSBuDoXwwptlQmrNeHd9Vr3Qu2ALK7EVClQssaO2FlfUQH0w
 7W0L4L8hllvhN1U29uDqDY2jG0lUwUKkh0Xv+H5aR/2Uo/Lx9kwKGoJTg7QPCGpkWQLHBsnGZxH
 FmOboOlr4cKkAPa5TCzd6sxY9pslKIBhXIsG2nNSBf37dO9sRV2DkozKqwAlbEAe+ufd6UnKJbU /DrlwJTXOM4VVzQ==
X-Mailer: b4 0.14.3
Message-ID: <20260306-binder-netlink-v1-3-daceb5bc83f2@google.com>
Subject: [PATCH 3/4] rust_binder: add generated netlink.rs file
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
X-Rspamd-Queue-Id: 1FF05223A56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264847-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.969];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
index 000000000000..0537be08f4d5
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
+        let skb = kernel::netlink::SkBuff::new(size, flags)?;
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
index aa5f2a75adb4..65dae8931676 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -36,6 +36,8 @@
 mod deferred_close;
 mod defs;
 mod error;
+#[allow(dead_code)]
+mod netlink;
 mod node;
 mod page_range;
 mod process;
@@ -285,7 +287,9 @@ fn ptr_align(value: usize) -> Option<usize> {
 // SAFETY: We call register in `init`.
 static BINDER_SHRINKER: Shrinker = unsafe { Shrinker::new() };
 
-struct BinderModule {}
+struct BinderModule {
+    _netlink: kernel::netlink::Registration,
+}
 
 impl kernel::Module for BinderModule {
     fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
@@ -294,12 +298,13 @@ fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
 
         pr_warn!("Loaded Rust Binder.");
 
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
2.53.0.473.g4a7958ca14-goog


