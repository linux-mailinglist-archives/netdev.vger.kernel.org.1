Return-Path: <netdev+bounces-278730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kORBA6pe32m5SAAAu9opvQ
	(envelope-from <netdev+bounces-278730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:47:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10151402CEA
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B1BE3044D23
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4833BBBD;
	Wed, 15 Apr 2026 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBizY9Bu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325CF33C195
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245989; cv=none; b=KvApjgwamxr9a95ZyxkBIXBeVWuaXQUqoPvvMUnujRAdQGIc3ievphqDqdmcjbo9FoTeOR1zeLZzxuvX412az4239yaCHLP++6Fmmmnni5Pn42/Xq6kgmpnE7W7Sv/jWRtfBTyIkUQC4QJY9TGDXG+cT1riEuv4+ehNF8dPvpv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245989; c=relaxed/simple;
	bh=vfGvEyjIXVQjJQSlbIVj7pBLzMyBjbJ+t2zP8GbMnR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j5wTerNCQPm4TTGcegC5DZlHQdreDa7bwujMV1vNHv8m3S7cTy6xc8s4FRJ/d36CIo03PQJkTjHXaHhZWQMzdTTtpSxJ+r5Z5TgEE02aX93f9AqLKrfXIwE7oGpNmB/IsuHJ+zdaeAgIAz+27tQ83aQUQKQFF4AFXnE6+P4by80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBizY9Bu; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66ee04c60e6so7477136a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776245979; x=1776850779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCLsNX3cjUHeEq5VeNxpgUoLu/D96PUreoTUzfquF0E=;
        b=OBizY9BuFTecC3VlcVrrQOUhekdFFP/+Oq4Vth58Ez3n1QxBdkOV2P0UVSZgrdDhMn
         Jgnmyvt1AfrV3Dhk68d8EG4Xkm4SO/gIOph0r3kTgwCLrx/PTNA+iWKP7mmegQvJ2nON
         +Ut6xA3EDYdnH4k3UFD/maFlzQ8T5F+kd94gyx0QO81kpeMvzoEzywLvpPm3FwTLRK1A
         r92JZIFFqvz7WEQT5AU+EOJG9n8kH9uAwIj/NC3fPb+oHRZfEbZcRPcrNGqvTOurKN0D
         AMoK79Z9yRD1pi91M7LrwCVzbz+CUkB0xKWDxQH2+zohUT53slbftSgwR52+m/oR6plG
         U9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245979; x=1776850779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCLsNX3cjUHeEq5VeNxpgUoLu/D96PUreoTUzfquF0E=;
        b=Te9KmsMkioLOJQE2FwxqFLpXkALsIBTjrh07e4u/vpNz1ZIybR7jy5URA78bb1MaFB
         YKYk1swy2lwO6/nzNFVI1Qre5R6eWR967jby8XPZPpQEOrw+UjaiqS5uG+LP4ndpt/fG
         8R36m142yb5Yo1ZxzlZuY16jdnl0JARrYqGxjXq848ognxge3ma2G6bg4djVaBqrHAff
         gibqird6fVONq18aWTbsb76sb/A/PzE6QIiTQwNivkywb8fVKYJQN6KDGyr5LQlmQQd9
         uwYZz2ZAoPQPJi5imsSfa7TA/PMy4aHzRSpV9f/K+WvdLcmzYrOVyNeIuzCAyg/n5koP
         c8pA==
X-Forwarded-Encrypted: i=1; AFNElJ+bfwsunBKGWKxMcB9yM1gL+FuhwhF/WqBTCBqtDFXOSjxB1KVUejUzyZBc5w0vHA/29xpr1TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWNSzOL1rGPutgTNHUjiog2KGBbpR2tspkBFFYvcSroKHPxGo
	pQK9fXjW+VogLXeoyzPTS3QoWuC4Gyi1KZasDc1IHGONQ8j369X9z5+3ksbQX162PV2QjYdxdwH
	5lQ0SaCxIQMz+euRCBw==
X-Received: from edcy21.prod.google.com ([2002:a05:6402:3595:b0:66e:6991:c7ce])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:13c4:b0:66e:4372:7518 with SMTP id 4fb4d7f45d1cf-670786a9b2bmr10483508a12.2.1776245979186;
 Wed, 15 Apr 2026 02:39:39 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:37:54 +0000
In-Reply-To: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4356; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=FfVP1wsykDG+Hqd6UNsmQSo/Ch7AeRVTR4IJAZiaXEk=;
 b=owEBbAKT/ZANAwAKAQRYvu5YxjlGAcsmYgBp31zOfKasmwbfkCFFGYk82gVJITP2uU11raptY
 z9wiVal5LmJAjIEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCad9czgAKCRAEWL7uWMY5
 RsahD/joS8/bdiDdrB6f/uSSvZiTtI6Tp6QeRXhgNBIobGYX0Qj4hFIdb7NUK89L3JA2gBQnwWr
 Ffwp3lnsuxybXMktZ7nRl96Z+o5F24WOYHsPXm17YMIk/BsJIzdhzUqYhxnq4SZI9tdQ5azczgt
 o89dmvlyoGmaRjoMGycdfCho4CNjPRhmYht85chyQrBjKgAozFgGSVhsKyVG7US6hTVKRVAOFNM
 1xGYBOSkW8qnZv+8xcdo42+kZiCopu+QfXI0ARTbEDT+dcBR27jRtFIbzQBT4p2v5AejEXhrboE
 tHs6dFEP/CPJymx7jCUIc7dAIHTENYmoMD1/pvyb1JME7mVaN97QWm7CNrcFy+ucPmZjv87bURG
 qMRIuXCKcm6DuSMp1Hxk2JS+FOLmP9bCXpH3E1/zuPQbc20bbiIiw7BaHfX7xttma1mxnEYMhv3
 FLLmBI3RsQqVq3NkSpzz+2iaSEXwFGIR1EutrxMDeg9VnoM2IVpj7I4c0YYt58hgC/FFY0l1bGI
 32c44Iu8VlKdOGJw6K/NNxebqd3zSrLbeTDj0IBDvaTwEU8a/B/lmjCQkoQue+M9VxRmBGyp/uy
 fUdUuyal/xKRakn/bQMJt6yVSt/0zV5UjF1T1BJmS0q6U7Qzx6lwWWzOZWfZrc8Gw7Na8VEzGhz boMqCgh/zE+Xv
X-Mailer: b4 0.14.3
Message-ID: <20260415-binder-netlink-v3-4-84be9ba63ee2@google.com>
Subject: [PATCH v3 4/4] rust_binder: report netlink transactions
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
	TAGGED_FROM(0.00)[bounces-278730-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10151402CEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Llamas <cmllamas@google.com>

The Android Binder driver supports a netlink API that reports
transaction *failures* to a userapce daemon. This allows devices to
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
index 9057e5dba7ed..407cda7bd766 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -36,7 +36,6 @@
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
2.54.0.rc0.605.g598a273b03-goog


