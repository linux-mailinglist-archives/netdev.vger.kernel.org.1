Return-Path: <netdev+bounces-238521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 468FDC5A71F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFAA64EC537
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE0232936A;
	Thu, 13 Nov 2025 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci2M8YlR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267B329362;
	Thu, 13 Nov 2025 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074718; cv=none; b=tjImUlON3XYOnrxRBCP7m6PLRgNsJQYnzDeMlvniRLzcU+V/TSeAjDYWfN8d8lK8QcBfwpc/rwLc0GWWf80k9O5WBEqGyHWKFg+wjGiRfLOLH13iKq+adjpmrtzJ7mMRLhEvDX82366IlLmot3/1zzuY6gKFwBYVFheftRPx3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074718; c=relaxed/simple;
	bh=HBb0BE/CmfrNz8JEu1arFu71La4LfBFUUZFMR0rFz9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGN7dTl0ap/MI0Xnr9qwAO6XGCKICyACwt5dEmBHHwNo5k2XIdVf80GO80OQULWQpLEluvFSHOnZCocLeWtAHEG7DomGSxSHyrOfKB0iR+t6Ljxo1d0IFCBRxzTL+/neYaVP4gCPtd97StIlOlHVzt6QwUXi7i2hUpRvo/csuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci2M8YlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296EAC4CEF5;
	Thu, 13 Nov 2025 22:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763074718;
	bh=HBb0BE/CmfrNz8JEu1arFu71La4LfBFUUZFMR0rFz9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ci2M8YlR//71Ag+ahXIUE3oGxeqLs+4XElLvtWFWv9nzU050mn24NoRtISOfb8DCu
	 43lCDcokruh33enC9ir+d1cJpmsoXsTWn3dDVHxC8Meoj8rInSTTCwNPC8m23n7K9A
	 dLJ94JWrMTrYhG/z+HQCtAcC7VUW2x1VanRgv7VVLk6y8EQg5OBb73OhFlRzRRCTRT
	 dNcVBH2Xnhc8Vr0cmxUst3EdyTYxDZ9U/H24XtBfot51MlLjXw49tGZ9oQgQZoX3uU
	 X3b5qBMQ6NG4YzTuy3tOrTxgRzUoeXQrU3CmxQta72c1UZvWRxXuj/DHggzWxLRdYk
	 T1JyFOyZ6XT1A==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 13 Nov 2025 17:58:24 -0500
Subject: [PATCH v3 1/6] rust: firmware: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-core-cstr-cstrings-v3-1-411b34002774@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1763074712; l=1629;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=4dgd5s5cItkGKitaXqCnLjiqgIDU68VUxn2FkB76slk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAX5YlrubLyTMDqJGWSi2UrRWygI9h86eTz2GXO0nk0VW2JBnnnHCxQNCEpjRV9a3kAs8a5dN6T
 6SkMjeu2y+ws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/firmware.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 376e7e77453f..71168d8004e2 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -51,13 +51,13 @@ fn request_nowarn() -> Self {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{c_str, device::Device, firmware::Firmware};
+/// # use kernel::{device::Device, firmware::Firmware};
 ///
 /// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
 /// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
 ///
-/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
+/// let fw = Firmware::request(c"path/to/firmware.bin", &dev)?;
 /// let blob = fw.data();
 ///
 /// # Ok(())
@@ -204,7 +204,7 @@ macro_rules! module_firmware {
     ($($builder:tt)*) => {
         const _: () = {
             const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr = if cfg!(MODULE) {
-                $crate::c_str!("")
+                c""
             } else {
                 <LocalModule as $crate::ModuleMetadata>::NAME
             };

-- 
2.51.2


