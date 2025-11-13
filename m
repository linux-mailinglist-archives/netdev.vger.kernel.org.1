Return-Path: <netdev+bounces-238524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1841C5A72B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E883BB64E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08732ABF7;
	Thu, 13 Nov 2025 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjM8LgMs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0532ABC4;
	Thu, 13 Nov 2025 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074725; cv=none; b=maK2NIR2/VKwWlvt3tYA7b4OPOd+DqEnIvMCiStSG9Bg2rk8XVgil8I+xLRlvF9YvDhv+M3iu655kJ6i3i297PDaY36xlNfSP9EJLpmHfAzoOihu+6pd+nWjn1QS7onTNLIkLwJd3qEOPp8Ytoi77C07JignjFbeDN7EJ0IxsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074725; c=relaxed/simple;
	bh=TDbQC3cz/P7H8urLElCL5pCqJC7qpQOo/p+U98dOcyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tHu87Qj7Y+dKqcKbAI/Nmh4oOQOk3Fky/zKU3iOm58efjnsKAv6aAsXqPpP7OeYagAtRg1IVufcgrKpjH5DeHP2PffHsa0yyzuVYv/ppuT1ma1aL9xE4HL4XMslzJ6OY2xmhuwUwqpgpS7a000FHFvbezzP85PAzP2a1yO6L+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjM8LgMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1301C2BC87;
	Thu, 13 Nov 2025 22:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763074724;
	bh=TDbQC3cz/P7H8urLElCL5pCqJC7qpQOo/p+U98dOcyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bjM8LgMsh1kZcJO8qk0xMTrSQWVxDNKQxd3opTxRf9entqE0/6vccqIs9sQU+QYUA
	 dzkTdU2gpjDETOvG5HC7eGsEmR632d783vb6DzR8pJ2li2CbwGvNVJ4WQYBSe6ffBC
	 8o6PJV7BnImRZisrOtFBQ+HN3/j265ZTcEV/MdNhDQLbMVjUQJziXN8FuxZIGdykBA
	 NcDyAjzPy7uK8QyGoNXXUDYQuNsPHd0JdujLvcM3U+i0n+L44mkoMmGNBeXYt28Jvj
	 5meFk8CwFPtIHSTt0Oy1X9bkVFHOFLPWSeQLlGyD7xOnC8qUHMnlcMXFcRVR9Rhq51
	 7GKV6e9pZ/cAw==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 13 Nov 2025 17:58:27 -0500
Subject: [PATCH v3 4/6] rust: sync: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-core-cstr-cstrings-v3-4-411b34002774@gmail.com>
References: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com>
In-Reply-To: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 netdev@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1763074713; l=2102;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jyXJ3mjACJTGdEHDpcd5bnph32X3ATnuiA+Suya9qvw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD0Pz9FRM76NV97+HgJeK/XQhA/D3DbQhAPYmpH0NVZfHVUMQ41CWlTz+X+SN8rO9cgnxaVmFbw
 44FNPtQfP7gE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync.rs            | 5 ++---
 rust/kernel/sync/completion.rs | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index cf5b638a097d..4e503036e123 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -48,7 +48,6 @@ impl LockClassKey {
     ///
     /// # Examples
     /// ```
-    /// # use kernel::c_str;
     /// # use kernel::alloc::KBox;
     /// # use kernel::types::ForeignOwnable;
     /// # use kernel::sync::{LockClassKey, SpinLock};
@@ -60,7 +59,7 @@ impl LockClassKey {
     /// {
     ///     stack_pin_init!(let num: SpinLock<u32> = SpinLock::new(
     ///         0,
-    ///         c_str!("my_spinlock"),
+    ///         c"my_spinlock",
     ///         // SAFETY: `key_ptr` is returned by the above `into_foreign()`, whose
     ///         // `from_foreign()` has not yet been called.
     ///         unsafe { <Pin<KBox<LockClassKey>> as ForeignOwnable>::borrow(key_ptr) }
@@ -119,6 +118,6 @@ macro_rules! optional_name {
         $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::line!()))
     };
     ($name:literal) => {
-        $crate::c_str!($name)
+        $name
     };
 }
diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index c50012a940a3..97d39c248793 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -34,7 +34,7 @@
 /// impl MyTask {
 ///     fn new() -> Result<Arc<Self>> {
 ///         let this = Arc::pin_init(pin_init!(MyTask {
-///             work <- new_work!("MyTask::work"),
+///             work <- new_work!(c"MyTask::work"),
 ///             done <- Completion::new(),
 ///         }), GFP_KERNEL)?;
 ///

-- 
2.51.2


