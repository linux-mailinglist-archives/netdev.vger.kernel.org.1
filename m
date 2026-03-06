Return-Path: <netdev+bounces-264846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKrSG5fwqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:19:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA83223A9A
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC87317E441
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D13B8939;
	Fri,  6 Mar 2026 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPpVtYzH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35B03AE6FB
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809953; cv=none; b=E6uv4RUyJhAl3dGZI4sJ2ArRguAgCnlk6giLk44jpw/Q6jS9bMTF84oH4zIqfxvx6r0uhY2q7bf4SUgRkvrHjZMhjpb0hlaZ5K4/S2EcC3l7NrrhWpX7uaWgqHMTwP8uK3bHCfVNQvjobfWjicgAEH0Y+rWOat1AH6z9P0uJCro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809953; c=relaxed/simple;
	bh=YxuNBCXB1ruXIhdHNa9guGwhOCpJAbw7MdxScXE7uVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GMsqxSm0+SCZNkuFNNgaf4aJNjBVz7RMkpfpqNyj27s537eIv9Dd0Kgm7mcuvtnR+XrmaGbvB7AjApa+s/HJZqNDuvRU8aJYPn2vbBID9Brh1Uyg13aVuN+h5gCYYQr0DImDccnBJsV9vQy0DQG0CP7+TrWZQ0o61eIH8O7r7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPpVtYzH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48529847dedso3198195e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772809949; x=1773414749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7W6/0L6JR9EvU6fV715H5TPwVjS+u6fq9W7W12hOUQ=;
        b=CPpVtYzH/0aED2WmQjoU+HCX292Y3RigMl1W2EFDO9AXFy/FpxxbjqXveWRyDf3Nr9
         v0rmNCDBsZvE5hVOeJW4eOcPduRmafFp82fw3iNGEnaQ3//ypcdCHhQOBKlgrlMC/v8a
         uHwEnwPB1HX+x7lPE3Vuu1fUqvqjftd/OucUdYAN9EwfetFnZU6qBKaTjxRiQ+AFAH3B
         x5ngGLhGrJcwk74K5q/7YDiQYmMwAaDZXcqYKjsMkMwOY7diAKbckVnIivm9zt/Jnx3l
         olfIo380qP7VpsP+f4Z0l+8fmya5tfvUv1RBuftddfeG1ffGu4UMru7KHWnHHrbQ3AYE
         2K0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772809949; x=1773414749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7W6/0L6JR9EvU6fV715H5TPwVjS+u6fq9W7W12hOUQ=;
        b=IOtwSysnQQPAMWWGROzvq5TRDjDcqcU3qockkI1dBw9EahxJK8HQk5CeGycq9+xoli
         Yq0VRPI3RVitrUJI9gjyugXCLyxvEXuKu/36D7l0HU9Quhu94HnULaXb/XkGtEYBntCo
         arf8YKXlPQhpdHEc/il+heRgAzrDeJFp/RcXxAh9roDjsyRFse2hgMzAP2V9l2pxf4K3
         dGd6FN6pfHs4eUIo77EOsk41rLj1+KUFx3NJ7fF75VuWzfumWv5frXLb3JB50x/L9srW
         v5O+ADIFzH7r0FeJUlQfbfH19a3p9xBh5AILy0r+xmQ7KXM3SvWi643PL1j65JEVnaO4
         ajzA==
X-Forwarded-Encrypted: i=1; AJvYcCXF83s3kG0lk4LskApF5RLKRFkOu5rHG4xAhSW511UiUD1+LfVKcW8blPcW0+Jacto2F1lrEeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMAI8jbsy9OqEuUZe4oP5MpDSBianVJRCEPiu2LN7LubiBS3W
	IAQsEjvNsRJ6CKdg6vB12FOgtPAyGd0n+sPfLvMYZ5leUXbPmA8TzhEScg5BwZq/jYvc69dfCQl
	iNC5KURdT4iyPw81csw==
X-Received: from wmqy16.prod.google.com ([2002:a05:600c:3650:b0:47e:dc0c:276f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:609a:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-48526919691mr41548895e9.2.1772809949104;
 Fri, 06 Mar 2026 07:12:29 -0800 (PST)
Date: Fri, 06 Mar 2026 15:12:16 +0000
In-Reply-To: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3906; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=B4IqF7dNXJQF1f3lvVpuUKgRecGFsxg/WIFjSG2Bg5s=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpqu7VYn9W4TXw9As8/a5rEo1WV2ZUs9sKk6G0R
 bBm2CSidn+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaaru1QAKCRAEWL7uWMY5
 RuefEACHdn+kgRMMwfBVAlPfxB9vQs0RUvm8N2+9VvXmSkylMedWJAejMVAZJoRXZeg2A4B3v1w
 6Fj45doXbx8I7fU/+acVjzDzoZJiGoyhu0DhB1/Y9QhY8CklBTWqFLfgHJtxVjaXEMiwoHbkP6p
 ZyKXm4hERfzOfs3j0reDO6jkaJV4Ac54gKM6Pq/qXyCqq2LZL3zTuS5Vkl33N12IHCl4YsXWHcl
 iLrWO1MTeGBfa6PS1ruzmptC7gWoBDP8jmy3RIZOSAlCia6do0g9dmv+Chl/57VExVx1/e7mCxm
 F9XqAjIr68Jth/7aWWhwnzj41DcfilwQJI8tQXwxg9HsbHlBRHiciMxiqwcoATTS8GJoM5hshOp
 7ZGc319+n1ZA4moPwrwukSlyzyqTOEIVK4kdohWUTav2t53YvO8qJlZYihcafhayewZMzBlx1eB
 7REUfU5C2864Py1xR+YpZbBtXsZ5paSbpXX6XcLWFd0x7ylzmxnYbhUhcjzEiJL47yX2MEW4vsX
 4+N1Tm0KGZ2ya5zJqBw+oa41g48dJtlBz0oZl/oZPj4bDYoQGPlF2K+rN/mags4G0tK0e3ZhosI
 +CD+yDonYZBgr5sCBV1kxv2P+SDHUtHDA4P6QxMeVMsA9Xk8biIq/fV0hjKuHiOcCFk1t6A1wwg S2Nsx/pNpMzof6g==
X-Mailer: b4 0.14.3
Message-ID: <20260306-binder-netlink-v1-4-daceb5bc83f2@google.com>
Subject: [PATCH 4/4] rust_binder: report netlink transactions
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
X-Rspamd-Queue-Id: 0DA83223A9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264846-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.971];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Carlos Llamas <cmllamas@google.com>

The Android Binder driver supports a netlink API that reports
transaction *failures* to a userapce daemon. This allows devices to
monitor processes with many failed transactions so that it can e.g. kill
misbehaving apps.

One very important thing that this monitors is when many oneway messages
are sent to a frozen process, so there is special handling to ensure
this scenario is surfaced over netlink.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder/rust_binder_main.rs |  1 -
 drivers/android/binder/thread.rs           |  9 +++++++
 drivers/android/binder/transaction.rs      | 38 ++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index 65dae8931676..f96264406ef3 100644
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
index 97a5e4acf64c..49879e615ce5 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1262,6 +1262,15 @@ fn transaction(self: &Arc<Self>, cmd: u32, reader: &mut UserSliceReader) -> Resu
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
index 5dff3d655c4d..4b3fba76114a 100644
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
@@ -49,6 +51,42 @@ impl TransactionInfo {
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
+        report.to_pid(self.to_pid as u32)?;
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
2.53.0.473.g4a7958ca14-goog


