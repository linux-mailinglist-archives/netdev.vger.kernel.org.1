Return-Path: <netdev+bounces-238525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2C9C5A72F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA593BBD4A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91632C923;
	Thu, 13 Nov 2025 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onwb+Sd1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB932C33E;
	Thu, 13 Nov 2025 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074727; cv=none; b=Zlwjpcie6Qg8GewvVwzseI80DgF/U7/XIu2ZgC1jt7DGTUDtAdZzDnd2gpzY82tC0ZFUCQKd99deNnN1TgAtP5+LU9fcAITiQoyrmmdJ7sE/A1903zbYUhiZnkLPXMVP5NtqGP0z/I4xLFtFiBpe7YClyo2Q2h86OQaEd9g8Hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074727; c=relaxed/simple;
	bh=IG5415WlYj27eGFCc1Qov/SUbUZaQuNVdXpSkaURsBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPdvIYVk723Y781bHDaikT8me5EreAPn7BndpLZhMeBCgaV+f8QgV1VA60ZvwyYYjxdUPlUitgCFswp/Zx4VFWKCsqm3OvLio5oQ6QgNQdLL19nISlga5h31oZ2wv919ElvsSWRjXTGcp4E9RrKD0iZt7RmG4Z6tTVHEV3h1nag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onwb+Sd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ECDC19424;
	Thu, 13 Nov 2025 22:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763074726;
	bh=IG5415WlYj27eGFCc1Qov/SUbUZaQuNVdXpSkaURsBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Onwb+Sd1p2eBcTfzXTeavR9voPMjb5oi40NYelawiwaWEmzVQl60M7Q34fHJPZhV/
	 KRDSVfr/MEBkiDH5qmXTFaAyslMgWzZsJ4NGF0HouWDvxDBgRU27nwHuQDzrJWYzTk
	 lPvfC73UOXO1ZJw4chupN3ZLIBm7wLrJqy7jJUMzAeaJYGCRwYT+qBQwlZna2sh1+9
	 fDDUEYWSV6dCmrzwCxp94GP2OFc11ECKC6MU9xoEzD25iQP6zfL8C9Myk7BzLcoMXp
	 ntj8ZQ/3x2DLx0h6sZAbYzIzF3Rm22b5KzpkNg7S2UKypP3kxc88AbV+0+tcgGIVAt
	 LbHTJEMahstiA==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 13 Nov 2025 17:58:28 -0500
Subject: [PATCH v3 5/6] rust: workqueue: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-core-cstr-cstrings-v3-5-411b34002774@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1763074713; l=1654;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=5mcnlOdX5skxvzJeMU8gi38lmb4RChkLNrj1vkN6HFg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDqaCQq0XDGYeRSTELtgb3YdPIWn/CQSW9NuU/UsbUeSWHCzn1Vd4WrSEBIVtn9rgrsRHh+0Mce
 GHhiWG4OO4ww=
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
 rust/kernel/workqueue.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 706e833e9702..6dd47095455f 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -51,7 +51,7 @@
 //!     fn new(value: i32) -> Result<Arc<Self>> {
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value,
-//!             work <- new_work!("MyStruct::work"),
+//!             work <- new_work!(c"MyStruct::work"),
 //!         }), GFP_KERNEL)
 //!     }
 //! }
@@ -98,8 +98,8 @@
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value_1,
 //!             value_2,
-//!             work_1 <- new_work!("MyStruct::work_1"),
-//!             work_2 <- new_work!("MyStruct::work_2"),
+//!             work_1 <- new_work!(c"MyStruct::work_1"),
+//!             work_2 <- new_work!(c"MyStruct::work_2"),
 //!         }), GFP_KERNEL)
 //!     }
 //! }
@@ -337,7 +337,7 @@ pub fn try_spawn<T: 'static + Send + FnOnce()>(
         func: T,
     ) -> Result<(), AllocError> {
         let init = pin_init!(ClosureWork {
-            work <- new_work!("Queue::try_spawn"),
+            work <- new_work!(c"Queue::try_spawn"),
             func: Some(func),
         });
 

-- 
2.51.2


