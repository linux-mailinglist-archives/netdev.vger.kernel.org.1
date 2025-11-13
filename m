Return-Path: <netdev+bounces-238522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79FC5A728
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D78304F10B8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0F2329C78;
	Thu, 13 Nov 2025 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmPKwgeg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF41326D74;
	Thu, 13 Nov 2025 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074720; cv=none; b=LyN8eC8f4/q6fuLNY4WJdPytXF2eWQvf0QtD5mcjU1a2affEZTCPh+YJWzrU+oIgrDL8LAtBZYVjd+UDwiGA1hyvrB8hOOdjPJfSSO5QWUUR8xIWz8AfFdJpz6SkUQS1EWS6ETyfgOyVZ3ANGKE/m7Atw7el3ifFebtLFbwTpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074720; c=relaxed/simple;
	bh=L478KaUd0Ot1CfjMXE50G5ugMncb3+czlC4iQTj36Nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mnKoJ2aEjXBiKjBPpeqa45FAXZwGlE5iHmfS//9a/OsY+nW3wQMx8e1EPXseASgoSVba5BaM6sjc69tfxob0g+mweWL0Bj9/rCAODdAjmF8yU4vmtrnP2a9VsTkyCJ/RmoZi0yuhExg5J4LLuuZg4efhJwRkOUNO1WoDigc3Fuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmPKwgeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C86AC19424;
	Thu, 13 Nov 2025 22:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763074720;
	bh=L478KaUd0Ot1CfjMXE50G5ugMncb3+czlC4iQTj36Nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SmPKwgegWgdYdQUmSi5HTEpo3jURr2O5yblEgoUaWcMMQHN/pmXyLTtVsu6KpUgZr
	 vcyfbml8kW5+2IZhXpmnlpRUuGcoHFsAyAp49sLtvM5f5Nosl0M5qo/WPJ8UdykCrJ
	 gwhzOqhjKFXFkHj6DZ0IVuzUtlzT4R67oeZDL/a8HkovNs1EF5pKEd+FX0dgIj+05i
	 NcBr9H28u44Xjp9h+j7Lyoie8DV48tIdG8yIPoIVv5phO4zRWULfxYMwwW0WCTq89d
	 v1hty0Jv760BIOHFewKhtxHbINhjSNmKuro/182AR/hYR2JMjPBKkqG5jXSUWlc3VU
	 J9pZqWbjPjlMw==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 13 Nov 2025 17:58:25 -0500
Subject: [PATCH v3 2/6] rust: net: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-core-cstr-cstrings-v3-2-411b34002774@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1763074713; l=1712;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=aSWd3FABCzlm4GeQ0LS5TjXQD0VOYCr8DP5mFLTZSyg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJlFwX4ang7kg64uHGpfyl6rbW0aUYQqEbb1ab+eVuuwuBLNdbrT2BbjovtuI/ftFNmbUzCS8oI
 P9puVEri04wQ=
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
 rust/kernel/net/phy.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index bf6272d87a7b..3ca99db5cccf 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -777,7 +777,6 @@ const fn as_int(&self) -> u32 {
 ///
 /// ```
 /// # mod module_phy_driver_sample {
-/// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -796,7 +795,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// #[vtable]
 /// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c_str!("PhySample");
+///     const NAME: &'static CStr = c"PhySample";
 ///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
 /// }
 /// # }
@@ -805,7 +804,6 @@ const fn as_int(&self) -> u32 {
 /// This expands to the following code:
 ///
 /// ```ignore
-/// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -825,7 +823,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// #[vtable]
 /// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c_str!("PhySample");
+///     const NAME: &'static CStr = c"PhySample";
 ///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
 /// }
 ///

-- 
2.51.2


