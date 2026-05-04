Return-Path: <netdev+bounces-283760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOdcAgxi+GlJtgIAu9opvQ
	(envelope-from <netdev+bounces-283760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:08:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6903E4BAC29
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BA22304C951
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 09:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9735CB89;
	Mon,  4 May 2026 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzprFKxl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1A35B649
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885516; cv=none; b=Wxnolqj/ZjjFP2pj35x6kIpT43Bvm1CnZ5RHD63i9ObZjOxiPj4GBr6bIGGr0C3tPNBT3O8ywQuJg2TMyul3aWX0Tly5DiKHszPyTCu96sJnlWSChih3A9BPxB59PjrdOJWENgmYkINLjZv7xdwXkJpyCGUp9mbLo2d+03C7sJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885516; c=relaxed/simple;
	bh=1wCvLKojE5VMmDHf90lahs0vrb8enbEkI/Ogt8PvM1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eLh8ILYpCYEJ6hltI7lJzp1m63mJbWw9URHQoyJx6I0966ezENTyvg+ewh8/3C5o8wBnglVifQ6OOhMn/h767dnv8LNV569g2UNwUPVwhETWYc8O4/SjSSTq03GvLVBzAdh1jYVez80P//OnDt2oY6hsk1c16le5X3pv11xPzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzprFKxl; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-44696b11265so4123141f8f.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777885513; x=1778490313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEY60xtnrtZlmDpZYjCBRIROfxsrlUrdOXIjmLSez0o=;
        b=gzprFKxlRQyvj2uWo3GNgiXetnceccJwv5KR2Airyb7j6lb4K5s+Olg4IzwdoUU2KN
         GRrcnQz4O23u60/7nttMAZg801QDIA5OFFAyI6IZSN3kcY64fznxY4dSXE3rurJvP4Ku
         kiRU0z5n6W1g4oQEA6GnxclOIwPguV/Fu3alkdXbLSauQwUBZqmXwlleRH2I/TtfYip+
         71zl5teC5i6SBGft87PDY3aPVUsZfK3SamXwdv9WQvaaX2N7/Fka2vboVDEkBpCRA7Az
         zDSUrtPWZqWzIPODdkFtX5+6lAtDcsjkGMY7xw/4SA+awOou1VmICYam5ENiJ1KJP1qD
         Ylpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885513; x=1778490313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEY60xtnrtZlmDpZYjCBRIROfxsrlUrdOXIjmLSez0o=;
        b=UB2EPbgxk2Hqc2juVOmlsu4Yzj9BQHwIka9hdvj2kjUZAnMVXTxvoyrfm/Yyhh2el2
         yArKs3bMn/HoMSCfapxIy0a8N/Z50skFjYEcFD3f0jsYNoMzIlxjl/he4ygN69cJA7RA
         exscHF+HxpOPmQY6F/xV//3t4BDmJVOyT10zkrpvqbb6HVA8yjue2L9Cyxcn3YFmpQIJ
         4qINLPR9aBEw9PfMcoSJZ5h9Yn8tBbLGjSpByuLTgsmVi5Uz9KPktjxkN43mm6pgKUSA
         AHQo97DflmfGG583DtDVHUg9UjMf2BM/kxAfdZZQ+rs8lKxEYDuZw14DEzqmUFdDeo0n
         j3Uw==
X-Forwarded-Encrypted: i=1; AFNElJ+Fh68hKH9IKGQvdJz/vZtoTDJRSz7cftkg5uoNn/cIR++whnLo+SAhhd/P3z/8ImZw5eqnIug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/Qs8x/dRbRl61AG4CjHzK30DgtypUgFzuNRIO2haaoNKPuJD
	ExfC/B7oQFgV9jJ4EXRDPQHPR54SsR3CmfzXll2TgKMhb8GTSUiQ7t/G5Y24uQF2892PUIhZYIb
	n36mM9xE+wQA35BCyyg==
X-Received: from wrom11.prod.google.com ([2002:adf:f38b:0:b0:43c:ffef:4ab3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4287:b0:43d:70de:1c70 with SMTP id ffacd0b85a97d-44bb68c79a0mr14978714f8f.32.1777885512373;
 Mon, 04 May 2026 02:05:12 -0700 (PDT)
Date: Mon, 04 May 2026 09:04:57 +0000
In-Reply-To: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4353; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=e73WyOyB+mDDLHLibrQ4vjOLyE9SKfri82WTOXEFb3Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp+GFAKMS1St3zC0Se2iWAaH7evFPI7zqntrHGm
 yKRSVTsnyuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafhhQAAKCRAEWL7uWMY5
 RuE7D/4vIMshog5wxMxLVYiT2zWIQW2eTJ05nCquFUkoBrITs6advjQOzEQrZHoF9fHbIplNp9I
 FbW5IN/0my1AtE1ONhqX3/eyjNgciX51/ZnVfdIopMg8x9TaWPzPhX7rYmBTzTVcqhBK7vsvuKZ
 rnkx9+zNGM2nBKXojrv/wKlp0trlIHIwyvyw9qF16kwhxNc3PH2iYEnQHCSG8i7zmhxW3lowhdR
 n9u97rczFLXnvg1jglpSeS1XiBAJNIYuenCukVFKIUJ11wpTemZaNmW9X+b8NdLkqE171YuqPBw
 TDhjqRKhqggNp9XYTObqhL7j+oJ3ZWijzoRiEFpqZEqdhYVY35Ywr8qQUxzecvhhJ9DfDSHUYqx
 raN2hse1xy3xE9ukK+C2E1ceNA6z0zqeFxAbjkhZwgsO7vmW2m9i800GboaaiMaztBfM44Dph/2
 d4XhDrBuuVoexePsU8IobI0qGjEJkDPnFvCcTEC3qpEvWywGqWprSGIjTcjhrAegb5rcrw/AyNf
 TgZSc1PK8yZFMAE+y4O4e/s/xjurPkYRAFJ+oTzyHBn2oBMYj2fHU+EEo4bSegwsw9XCMc88XEJ
 wDKdqKGtpI10ztMb6mlboCu36IQ7OpG8xmViyX8bJ8yNuG4hurOPwSF/3syZ1+Hiec2lbfcP8FR jGeLc+huavhQpGw==
X-Mailer: b4 0.14.3
Message-ID: <20260504-binder-netlink-v4-4-601b41cd25b2@google.com>
Subject: [PATCH v4 4/4] rust_binder: report netlink transactions
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
X-Rspamd-Queue-Id: 6903E4BAC29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283760-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Carlos Llamas <cmllamas@google.com>

The Android Binder driver supports a netlink API that reports
transaction *failures* to a userspace daemon. This allows devices to
monitor processes with many failed transactions so that it can e.g. kill
misbehaving apps.

One very important thing that this monitors is when many oneway messages
are sent to a frozen process, so there is special handling to ensure
this scenario is surfaced over netlink.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/rust_binder_main.rs |  1 -
 drivers/android/binder/thread.rs           | 10 ++++++++
 drivers/android/binder/transaction.rs      | 40 ++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index 2cb9f4897ad7..bbef68993b8d 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -38,7 +38,6 @@
 mod deferred_close;
 mod defs;
 mod error;
-#[allow(dead_code)]
 mod netlink;
 mod node;
 mod page_range;
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

-- 
2.54.0.545.g6539524ca2-goog


