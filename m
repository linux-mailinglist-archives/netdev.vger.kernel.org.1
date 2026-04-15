Return-Path: <netdev+bounces-278729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBzwDnNe32n+SAAAu9opvQ
	(envelope-from <netdev+bounces-278729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:46:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DE9402CBD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA3F7311BEC0
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6814F33DEC8;
	Wed, 15 Apr 2026 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdNQyN4F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305F033DED1
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245982; cv=none; b=F8/qd9Rk5CtPK99vPxqVttCulaZT4gYMwqZpAFLyMgGIcOMJKL6EdUygO95S5SOdcX9qptuRzY9nOXDjF/iPGO2zuKhmziFTD08zCztnu4RgZLWZUQsc0uelZuD/a1UYcBZmmTyZTK+zmsXDLzDsWGyyZkDBbT8WcFaAwbe2Ikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245982; c=relaxed/simple;
	bh=zNZrVUvlUUacK2uhATRh2O/ldEh8gnA9RA9Mdle7mFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J/wVabdL2PnFItYyQixYBIXbP4HhrFkn6GpjMGNwX013tAzZu2Z4IpjAJPiB36LZfQI6/EpXXGIXqthwgDPd63mbQ/ezacAetOaMoBpQyd56d5P0bGpneA4ivoBe+rYH+NnV5Agx7wPJmckZCpnOQmxhhMMOBWuQSZyPATekWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PdNQyN4F; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d744128b9so2776856f8f.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776245978; x=1776850778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/MVTcJFkC+EYfL8l2u+nLk94ROweihpl1VmTbmUq7w=;
        b=PdNQyN4F1T2kOuiM+pIqaBsAw5O04ItGcN/5pu5H1bGZ8joYETE88sZJXGdiYqkthK
         Jopcq0Lrfv2QNsEoYhzk6nSn4LM9ARt3dfO7+7h1t9hH26Dv0wFj5GEIG78C2Xrh+gdi
         XWFnGl1xLTFMiSXqL4k7brY//6weYJ8Utp7BBABQbAIZrsNwBhirLbxr7AE/iHyV4Wgq
         q1Gbd/vIP36vh8I7QyvALL/ivpfh1ILDzLK1SVBCu5TwHYoY518pMxicrvkVed/OY7uO
         RMz39E/hZFOZahV2Wd1P/UF0OosiG8Rhu97B9l/DOFue6+1dH+40VW/HjBBYkJpBM4X7
         J2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245978; x=1776850778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/MVTcJFkC+EYfL8l2u+nLk94ROweihpl1VmTbmUq7w=;
        b=PSecvDBD4QUI+2fOOLF7MMkrA/qDUS7QYaK5tj5eCfQAMMgn2JdSNpzes0K1HVHHW4
         4F8WgJi9D2ze3TMlFlRV++5fN+7V7iNlBRjnTnmbUs2FLcAWp+aXPR8mMvplZJekw2uQ
         xNPBwQquO6twupb9HiZc8PoAt3/bQElnjPR7GxdlMODuScmVG9Af7bQJEHVqirqtiHI4
         BAggQc6GopM3xjABfdxGorEtdqIZRNFltCrXS3ZS3H8D9c8JFoJNuXtZYVUawDnhm8SS
         407lnqV4WjA8dQzmyU4Seydp3DtZ7OQcCAknZ0JefKGvWz6OhLiNRY/ImdCzMuXLUJgn
         m7Mg==
X-Forwarded-Encrypted: i=1; AFNElJ9CvKlE7FhK7qrDCoWDuMRRjapHf5q+LlRUWN6HYUCkGkAuRSgF/NqcOcOitNYosSEbPsl/SPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxacnW+tGJnCbpwl8r5OxbX196mvVa60JUhbQxgrI5Rtg7aMbOf
	lLmVtuBREgWdZCaV9bxUooLqROh86Sq83QihXQchIJfzivhBnMpMCQXIhQ5/v/JXsmzZRfV85Li
	FYhHzGMZZKnjnLlCc6Q==
X-Received: from wmqn6.prod.google.com ([2002:a05:600c:4f86:b0:488:ad14:4c60])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19cd:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-488d67e3671mr285545145e9.10.1776245977384;
 Wed, 15 Apr 2026 02:39:37 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:37:53 +0000
In-Reply-To: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7776; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=zNZrVUvlUUacK2uhATRh2O/ldEh8gnA9RA9Mdle7mFI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp31zOpb/X3H5KVDxnJg+z0/8mY1syUfppmoDEq
 vAW+PS1vPmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCad9czgAKCRAEWL7uWMY5
 RtVxD/4j/wFrXmCUB1T1DC3Tqoa4xOWS6oAYUqUzfs53UibmR5Gab7kQbI3h3jrF37RDv5uTZtK
 zSDJuj8MwIRDVW7o9uka9IJ/+cZmzBfM9PlXb7PqE2/xmPXZ53gXZmMcOMERM8vbxea6fBNL1av
 HVEqWiBGfqTMFUIr4bQCkrScf09/ELayO23vg4JBMzNx3OEyxfbMfo/YIncIBO0V4C9jgdtHF5m
 4rVolRp1dUT82q6iIT6v+NBS13o8PP2P6dsxiGObjrcdoKIG48j/s/BFD32iwWtI/4LnazSCFAy
 P+xj2P3+9d4RQOXCMhy/4COtfyG5SCit0cH14y0+r9l5E2S7CA4D6SSKLDCfSCv702LmzGOLasP
 gPdEqhGFTnNt7piP0qDVlEB8s000FVz3pZsnVuC1/B9V+VlVXV+1dD2X0wEkT5YD90+emTZmIMc
 JKFj7BZJssbD8aF7VOmx3dXrxTXfmClM2v3a0F2hV0sJREY3COxbHdz9e3WREch0uze6ZMG4VJq
 VWQGanK079F8yS3y7eM94m413BWXtCC0f4+25hkrRJjwvaW7EGee2wid1BeKI6Be6SPOUA7vMAu
 feeJhtn8VRIFN6PYJsCTVG1W2J5OHjO6DC3KiV2byPkOCSxfTLr5uK3Rd3Y5pLn3nKcRYJ7CzRE pnoRhozCv3AOAPQ==
X-Mailer: b4 0.14.3
Message-ID: <20260415-binder-netlink-v3-3-84be9ba63ee2@google.com>
Subject: [PATCH v3 3/4] rust_binder: add generated netlink.rs file
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278729-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0DE9402CBD
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
2.54.0.rc0.605.g598a273b03-goog


