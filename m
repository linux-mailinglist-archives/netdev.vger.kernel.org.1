Return-Path: <netdev+bounces-276505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMPCIAFK1mkFDQgAu9opvQ
	(envelope-from <netdev+bounces-276505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:28:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E755F3BC0C8
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A061030F8082
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410B3C7DE9;
	Wed,  8 Apr 2026 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huRpiYMP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FB3C5DB8
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650863; cv=none; b=mo7QAWWrQB6G3W3Z2W7SEdWKM2x+tUwT/73tX/kNs0f+B3vrKYpj/ywPmob4Oe5Onw66lyhbrgJlmUutFbxg1r0q43GRQZGT5HPV/iDzlEzsyt8ZgxCy274MJk5P6XWVsc7SuCiCp7d2vyhYDziFtc3eC6qGMpKwchIvuXjgYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650863; c=relaxed/simple;
	bh=F7f94fTfMSJCY3wmlwluznC0FF90gOMcL3zlAtjwpw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HFmgC5fqis9twMymktOTIExjFMhHgXFV+BDZWhQzid+KxkibAb9Q8dhefsbFA30CnrToFL6SskjVziXjf7PRpLjfZR9M+mODerWzZJ8WNAwVv2i43J7ElOp+nYJfA7eeB4QTj21KdsC2kiQxK64l1iMu1ISH0DA43ZLNjUGlBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huRpiYMP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4836abfc742so51973295e9.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775650860; x=1776255660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBYY3QvrCgPn9EPvO5/3tLsHRY+z899eCOLcISOcO7I=;
        b=huRpiYMPhPcbw0/smYBOrUlf4gwuOxSxWrxQY11H16/5mdrmtEUMFl8p4PG+Z982mJ
         rNeePg8RxlIp+MnnBYgWfgE4bSiJw/MynYMUmM2iiX5o/T4/3tRR6uBh9uQkmdXCpaKf
         V5/q+yVdIvzWPrPXlA2AAJ1rp4A2vabixPFoxP9nKZf9+H3b91GhAsq0yxdcpTDQJBXd
         uUCXAwuuSdSO22YCB2Fvuoo+OpWqiYOzgh2vWAvlVp+++bqpfIDnVjiq1fobXEvrrq3d
         ZMum0zRXG2R8rcH72AGDOw/uPAJUiJtQNE4umptMmYyajVQ2jD772bp2GbwUPBQ2fAmY
         7ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775650860; x=1776255660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBYY3QvrCgPn9EPvO5/3tLsHRY+z899eCOLcISOcO7I=;
        b=qqYB8JN2u5GFg1wumFFxlOFil6oget+EJxMh70u6HnFib+0pfbatUy3mpyX5ecb070
         F1tJtSgUl0HFefmOrTyQ3/RNlqVtrWClboRWVS77HHwdoqr6vEDw8KErccIpsHBlS2a+
         YtNKt2rpF3qeTQozBPAyUswlo78IwPpyg0xW+I/l42M8+sPaWxsMoJQTZn2XQlE8WFaz
         OtjPuMhQv/6YEDthSUrwpsXBeElwilzXdSdnIxGun2tLx0lRSO2bvl5oBE70zoD+aei3
         W+ZM0qAuB5nV8ETfZtiQ8g9D2ChpwxGVwIWBagL0tI3RZEpyo8EBGk5+Z0Kj8xblS0bf
         joYw==
X-Forwarded-Encrypted: i=1; AJvYcCU0AL8gw08ABZW2DUwNpXdoZjhBE6EiSsfNgrTxFykFZUQ3k20Wi22BUU8i8yp8bUdUh3Dtvfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NEyrZta/O+h5+EkGav37Ua3C5vpm5NsCZV9s53CSNB/ejAGM
	yQrVZFVpCh255J6rWNULIZEr3Eh66q60N3moxDgX4rZtvgkdpvmEg6IloBDATTrBR2JwlFr/+Lh
	tcbh55git7i1pAneZDw==
X-Received: from wrxm1.prod.google.com ([2002:a05:6000:81:b0:43d:2a3:461a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c8d:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-488997a6883mr281760915e9.23.1775650860293;
 Wed, 08 Apr 2026 05:21:00 -0700 (PDT)
Date: Wed, 08 Apr 2026 12:20:47 +0000
In-Reply-To: <20260408-binder-netlink-v2-0-c0d327d15435@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-binder-netlink-v2-0-c0d327d15435@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4005; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=1Ltud0DFd3FPi7N3hRuEEuwQSMUXr9ABKDC9dGaJ4cE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp1kgk4LO5HLhqZ54TgromOML55f8Rta56qfp/X
 8Oj7TaPvDyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCadZIJAAKCRAEWL7uWMY5
 Ri3VEAC0ni7lJPZGIMUoJmkzj8liJFDdboT66VViQYnK97KHVhmpSLziVblb3o8bAIC/nZKGEf8
 D3335KeXl9fOruzsAFbxFHSXxEhbA1EODisgSHH7PeQFFUm5vWth7aU8xWJJUMj7V+EmrW2GIXk
 oWZrMj56YSOpdhNKu3XHQC1rPkDiX5xBo43G6EnyuuGtAcqx8XnSNmJGPG3IQudRYNH+Vtyluyb
 AvemSCTXL4eWuuNbTJuNwj7It4t3FrnFUOpgvM1XWorJdiiXfAWrkWeuZmG9bgaEtbBRo6udnZ6
 4TREjucV+0Rd41DwqsLvHisr/mIN+8lQ0LZLGPEVfTUkADu0XvHnCR6MeYzBwpBVSi+Ex0D17lu
 mfw2+8J/QkA6Vliu3ZpHNIGUoDp+cOkLS+gO8WczxoBUN25zw25lyyTrgPxPxmnjjplE90rVzO1
 55k1LBaum9d5cMWYAVPLCYjdZoJE04dZazTtEP7vN1KxX56C21CoGYsRtlKyCibbIvWNn8+1vkF
 2myKoLL8SBdDhMChbZUqeRWOauAU9kProNhtLKaN6F/D0vzZzd3OsBzUX9by/2gPceP7rwEgoZh
 U7IiVaTB72TgX9vzMU+pEJ0/S2ZQJhHlDwKwdCeI72d2GkjjcmDs8jE2KI81aMW9idHwHC1PXwI LzsvXUgkgonx3MQ==
X-Mailer: b4 0.14.3
Message-ID: <20260408-binder-netlink-v2-4-c0d327d15435@google.com>
Subject: [PATCH v2 4/4] rust_binder: report netlink transactions
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276505-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E755F3BC0C8
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
 drivers/android/binder/thread.rs           |  9 +++++++
 drivers/android/binder/transaction.rs      | 40 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

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
index 97d5f31e8fe3..e9bff4956ac8 100644
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
2.53.0.1213.gd9a14994de-goog


