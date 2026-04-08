Return-Path: <netdev+bounces-276504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IESOJpK1mkFDQgAu9opvQ
	(envelope-from <netdev+bounces-276504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:31:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1710F3BC16D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C11C6309EF52
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573EE3C65E0;
	Wed,  8 Apr 2026 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWEdTESG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE353C199E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650862; cv=none; b=fwlnqHiV4YtSNj35jLacfz2co0Ba/yfPVbfO9AofuUwyng4N3mQ73gvQF1PFo/MiqfoEKAeUdT1ZWmGaSw8quTcfKCuIhqM8L7sIkCQXWIfyBuwsImqH08u1yYdrWUwW3EJy/KD8LDtzBWZabF2fiJMtN99DgECAMwwXZMAb+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650862; c=relaxed/simple;
	bh=CzcAYIaFHkE+89TDt97IaYCt9YKdTOLMvtVgqltTBvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lbrlIl6L3xDKMfVJCarB37ZcWeFgIFOSQWkADEZh8xCohStE1TIyV3eQZ3RmEzKP3K8DN8UDhYTf4Ha+KdPQar9ydspBpgn5C8lIz/tWP7qzvEKgnGpVto0VyAjTuFD00R1rPQcDO4bNGiYopXQNi40iFNMRx/Kp1X7GTUnDCHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DWEdTESG; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43b8c472f3eso4680189f8f.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775650859; x=1776255659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=otAjrBmCGps90JtJ0ZRC66OaIMxDxpfCCAO6f/cO6a4=;
        b=DWEdTESG0b3z+i0cd+8ZVhm7knN/U9qRdqHS9zfXzW20vItSs/t5lQSf9LamgVkooH
         Q796/C7UzpYcSglnjQ3ptxIRP2CgOcJ2UKpdYQuy0xo1HSADGzNgQySF6FgPJ8oHOq1b
         y9ByhjL9/LGHVX6byFjSi7kCQm0nUOCPe1DrryqLycKjSLqKAXAsu1erKltjB86YLgeJ
         Lbm9jl0p1zzJpoTxL8y/hAm21KUpO5GKlLP8Z7hErWDs0EhrsoSXiya8+gKlQnqfMtRr
         sHX8tnzrgASA+xdTawe2veEAAHc0blsgvWEHwN+sqFK46yvbsd8fAHKqM4qNg19usbme
         uVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775650859; x=1776255659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otAjrBmCGps90JtJ0ZRC66OaIMxDxpfCCAO6f/cO6a4=;
        b=e+bNnRSLM/HokMvXaCcs9IAmZgM4+yp3TwMls+7t8IGVJ7kYqiw9sDda4J6ighec8C
         0r368LVbpm7VmnmwXGRrmHquxfz84Ti9NUMiVWk6ZaoAWAvppLNBhudLMz32zqjYDPMk
         uPJ2mRS2gz22tI/qIB9peuA4mYFR20pZyOzA6RIxZIa45y3/uxMYwPlm/wdXFbTw+pUG
         Rgwu9MompLtit3na5zWsPfOFZbt7io97vQc/1cM2D386iUKnOMcyDMgwbA3xPnsnq12J
         to0HmOI4bNicds5Oe7sdXsWmvbNmU5ktqbllrz6YMuw6oi6KlguR56RDY2m3w5whkcWM
         8qdA==
X-Forwarded-Encrypted: i=1; AJvYcCWTqzJ7hCSQ8I9kG/WiHM305onWZt19hzkI3PSxNdaG0Iv4+FC0bf9/esvZ8pIomyoB9ggkS2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUEf2HiEbEpr5+fWSFL3VIX2AtMUh7a3zN0nU/K6a/jURnvuy
	is9YFc3BabKtxETBcRiSvUaPUKjobzzdlv47Qj0T34WbOcuR69E9fpCpFD3g3H6GUsDzCx7BB+R
	w7r3OQyfFOzIUcgLkiw==
X-Received: from wraj2.prod.google.com ([2002:a5d:4522:0:b0:43c:8e1f:502e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1202:b0:43d:301c:ecbb with SMTP id ffacd0b85a97d-43d301ced27mr18928068f8f.14.1775650858756;
 Wed, 08 Apr 2026 05:20:58 -0700 (PDT)
Date: Wed, 08 Apr 2026 12:20:46 +0000
In-Reply-To: <20260408-binder-netlink-v2-0-c0d327d15435@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-binder-netlink-v2-0-c0d327d15435@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7773; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CzcAYIaFHkE+89TDt97IaYCt9YKdTOLMvtVgqltTBvU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp1kgksm8OAwqfLYcwRRuQZVq9VDzEGCvXmTvnt
 kpN8+PYQpuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCadZIJAAKCRAEWL7uWMY5
 RugjD/9y97CFtvhw239xA/YZ56CT3/0860IukRTSyXH04axbppu9lj9a0nlG8MyRWD9qo0ETuGi
 EVwQ5nP/0j8nDV610RnvoMTn8R+STeORSpdKE6MH3cTLL2JJCzqz9NHGvmObWiKE4lKU6nM7T56
 xnf8NxrVh09Z1Iowr9MbzUFVT2GvLqRJPdoz/ENoZHxTBOYMIzxw2TDLK4CJDoXhu5shjiAa7+F
 9Hnduecl1pnoS6oIoKPnTXc2c34nGnFdgvf/DTYQ0N1Vaop8vEeZhA+CLkZNXX713rMc0DFrjaA
 2wGrZIPAU6yABZH9gsS7cnkQ6ZqSa1VUSXwW8ZRALC+3/EA494pJU3DaaTuk5KbCRTav8XWrJ+L
 MP94+vzLiD4DfQ/VuRyxA0LN6Dq4YyxIzWC9jNfsubbanF7omXkXdFf08c0vZwdsSwE3e7O5Cyw
 PmfSS+Qdso4daiOaADPQLlDRjtNuQcUXT/ZM1lS4L2TOE3VRw9uPrSgSDKUfaqJQO6C2j5SOia+
 opkgg2+AizkdpPC8ByFFqhodiBSnwSIJiR9LNtPOHxp5P7b4rQHl8UxEhTDslYJ9NIZ3W0AmZjM
 pZhQjVIWBBSV+rpjBi/TDO+oS0IlkMaUkZGw7+oS8Mu2VW6DHwwpGkY28ZgC3lx+DHwvRg+v3d+ u0lbTHhOwpHTctQ==
X-Mailer: b4 0.14.3
Message-ID: <20260408-binder-netlink-v2-3-c0d327d15435@google.com>
Subject: [PATCH v2 3/4] rust_binder: add generated netlink.rs file
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276504-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1710F3BC16D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 678e987902aa..9057e5dba7ed 100644
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
@@ -286,19 +288,22 @@ fn ptr_align(value: usize) -> Option<usize> {
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
2.53.0.1213.gd9a14994de-goog


