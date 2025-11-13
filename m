Return-Path: <netdev+bounces-238523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E314DC5A725
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF683A7089
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4E732A3C5;
	Thu, 13 Nov 2025 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYzg0xTk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320B329E79;
	Thu, 13 Nov 2025 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074723; cv=none; b=N2rtYEGD2aBJxQDl3V9X29Mmz5ozY1ahfg8H65cEGhsHPqa5C0XcEkHuNxWLUvWui1J17tsrnqIaF4VQ0+ffEbQVO+co+YC9YSsWit0n9djTsjXANAFIBlA7zOY7e5+9h9vDX4h5MvH7RQR3Zgra7KCokbFyVjj0gGWnmSDD36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074723; c=relaxed/simple;
	bh=wNgVJztppGc9jsSDbpXX0JjPiSJcQez98As/TMoZ7fA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XukX2LNWG1FFpjsC28+vVXZfAuMobnnjvw2WIsMvvrC+2Pr3HlnpDniMi93zvMycD07LIOU7YM/RgQAOEK+GFOaV7YihLjw0cz99qxuvHiobEme48On/5ek5bAF8cl3L/Ca7iC/9ebU/D6SgYOzn/46XQzBR3MCaQP3ERTbN8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYzg0xTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86666C19422;
	Thu, 13 Nov 2025 22:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763074722;
	bh=wNgVJztppGc9jsSDbpXX0JjPiSJcQez98As/TMoZ7fA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XYzg0xTkKOebZoutoQXZzOf6NK+w1Tfm9gQFNfwF/7MQ86+G3V5W9PmyPSiAWVqhn
	 gekVKZXfd8uI4Er49nXEkKiRFVV/lOpYwL+CZHGFclqDgjBzv8rkQ1V8N+dc7BxeVG
	 7/fsuUMI7JW/4/9/mmrQC+4NXMWXHuorb4fAe1zv8ca3z/kRmjZgSH7CkMudoIDutQ
	 gk17yoaeR2EDDYISe0SKFfo9N9I53gzKlw7OJkX/iFfwndn6+D+rNHYsYPZxRdEVsM
	 Q2xIZyXbX0niENt+uBy4GY6kDOBtUf7Si8THdzwMz5kNE6iMmZpdLuGjUZIwr/9kN0
	 dJgcSfPsl6QaA==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 13 Nov 2025 17:58:26 -0500
Subject: [PATCH v3 3/6] rust: str: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-core-cstr-cstrings-v3-3-411b34002774@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1763074713; l=4451;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Ukd0njOQK0YeRaX+6ny1eCFNL6/PLRj05aBc864+wkI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP3NktaLpYLdhVCDSUsvmYf6/vFA7p+IHeQLM8KuYbmJLiZo7+afH3Ol/+90TmBKJLNZO0sLz6D
 xMB2PhRagWAY=
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
 rust/kernel/str.rs | 57 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 7593d758fbb7..4d3f46885300 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -277,15 +277,14 @@ impl fmt::Display for CStr {
     /// Formats printable ASCII characters, escaping the rest.
     ///
     /// ```
-    /// # use kernel::c_str;
     /// # use kernel::prelude::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
-    /// let penguin = c_str!("🐧");
+    /// let penguin = c"🐧";
     /// let s = CString::try_from_fmt(fmt!("{penguin}"))?;
     /// assert_eq!(s.to_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
     ///
-    /// let ascii = c_str!("so \"cool\"");
+    /// let ascii = c"so \"cool\"";
     /// let s = CString::try_from_fmt(fmt!("{ascii}"))?;
     /// assert_eq!(s.to_bytes_with_nul(), "so \"cool\"\0".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())
@@ -727,40 +726,40 @@ unsafe fn kstrtobool_raw(string: *const u8) -> Result<bool> {
 /// # use kernel::{c_str, str::kstrtobool};
 ///
 /// // Lowercase
-/// assert_eq!(kstrtobool(c_str!("true")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("tr")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("t")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("twrong")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("false")), Ok(false));
-/// assert_eq!(kstrtobool(c_str!("f")), Ok(false));
-/// assert_eq!(kstrtobool(c_str!("yes")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("no")), Ok(false));
-/// assert_eq!(kstrtobool(c_str!("on")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("off")), Ok(false));
+/// assert_eq!(kstrtobool(c"true"), Ok(true));
+/// assert_eq!(kstrtobool(c"tr"), Ok(true));
+/// assert_eq!(kstrtobool(c"t"), Ok(true));
+/// assert_eq!(kstrtobool(c"twrong"), Ok(true));
+/// assert_eq!(kstrtobool(c"false"), Ok(false));
+/// assert_eq!(kstrtobool(c"f"), Ok(false));
+/// assert_eq!(kstrtobool(c"yes"), Ok(true));
+/// assert_eq!(kstrtobool(c"no"), Ok(false));
+/// assert_eq!(kstrtobool(c"on"), Ok(true));
+/// assert_eq!(kstrtobool(c"off"), Ok(false));
 ///
 /// // Camel case
-/// assert_eq!(kstrtobool(c_str!("True")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("False")), Ok(false));
-/// assert_eq!(kstrtobool(c_str!("Yes")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("No")), Ok(false));
-/// assert_eq!(kstrtobool(c_str!("On")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("Off")), Ok(false));
+/// assert_eq!(kstrtobool(c"True"), Ok(true));
+/// assert_eq!(kstrtobool(c"False"), Ok(false));
+/// assert_eq!(kstrtobool(c"Yes"), Ok(true));
+/// assert_eq!(kstrtobool(c"No"), Ok(false));
+/// assert_eq!(kstrtobool(c"On"), Ok(true));
+/// assert_eq!(kstrtobool(c"Off"), Ok(false));
 ///
 /// // All caps
-/// assert_eq!(kstrtobool(c_str!("TRUE")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("FALSE")), Ok(false));
-/// assert_eq!(kstrtobool(c_str!("YES")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("NO")), Ok(false));
-/// assert_eq!(kstrtobool(c_str!("ON")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("OFF")), Ok(false));
+/// assert_eq!(kstrtobool(c"TRUE"), Ok(true));
+/// assert_eq!(kstrtobool(c"FALSE"), Ok(false));
+/// assert_eq!(kstrtobool(c"YES"), Ok(true));
+/// assert_eq!(kstrtobool(c"NO"), Ok(false));
+/// assert_eq!(kstrtobool(c"ON"), Ok(true));
+/// assert_eq!(kstrtobool(c"OFF"), Ok(false));
 ///
 /// // Numeric
-/// assert_eq!(kstrtobool(c_str!("1")), Ok(true));
-/// assert_eq!(kstrtobool(c_str!("0")), Ok(false));
+/// assert_eq!(kstrtobool(c"1"), Ok(true));
+/// assert_eq!(kstrtobool(c"0"), Ok(false));
 ///
 /// // Invalid input
-/// assert_eq!(kstrtobool(c_str!("invalid")), Err(EINVAL));
-/// assert_eq!(kstrtobool(c_str!("2")), Err(EINVAL));
+/// assert_eq!(kstrtobool(c"invalid"), Err(EINVAL));
+/// assert_eq!(kstrtobool(c"2"), Err(EINVAL));
 /// ```
 pub fn kstrtobool(string: &CStr) -> Result<bool> {
     // SAFETY:

-- 
2.51.2


