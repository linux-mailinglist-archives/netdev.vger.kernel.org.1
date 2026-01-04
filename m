Return-Path: <netdev+bounces-246703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE290CF087E
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 03:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A2DA3027DAE
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 02:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459326158B;
	Sun,  4 Jan 2026 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fND0paGH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2D25F984;
	Sun,  4 Jan 2026 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493481; cv=none; b=DxumybTvFjmuIO1XC6DtSble4P5fT8BTEBtwgXX2ldDDyOL9qqNGQ7qQkXL74jv755VdVhKQiFNU3oGVsj1u25m5QEhICaKw9NxEVnsc4V/W6IRVnzrLazcrnyMik0mAGu2ESd/U3P/48A9MrRZUVobqHnYDnuz3Lr+vSdQAqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493481; c=relaxed/simple;
	bh=gsy0D8kyDYWakr3jYAc2tAVK8UL7Tar8rcqHT/k5YKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAT5zsCvgm1kyMfR4umjVJROKwBY8r9O20ezFUSd/ZvzmzplHkILMtyGQ7WrQpqWwLUVYsa3OwDfhw1WzO7tnaAO1NXxQ5aQQEedBzDcTHFS58+LmG/xXIR5fk9DHM559va+niaVCz7X+s2YoNQWy/1gSSNRunYtrKn66+nqWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fND0paGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93A8C19423;
	Sun,  4 Jan 2026 02:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767493481;
	bh=gsy0D8kyDYWakr3jYAc2tAVK8UL7Tar8rcqHT/k5YKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fND0paGHo9Yei4E9mSCjdZcHdeaI8VwKB5Sijbb+Wkb/zfffRQ4y5V5CU9Tcj9OQX
	 vnMnzeiqb7Mm5w+Qlrav9Hz9Azo5dFVhjI0y4ZuhDiMi6SXH21xWaYw162//5ltdVa
	 pXlqW6dhuSG6dXT2pGetfXtTVh03jkUKW+soMMT9srqf9usIoqwGiuLKzLmgQ52ojl
	 jmN7A5Otk6XaLfXhUhtT1ZA3sCeON11+vKBXHOfCW/AJCxGIE6dH6ykIISG0Pz8imR
	 KzOsx1fCk2DSI+No7L0WxIJqwfUGmc7MEklmWFEN77skD22PGKlw4qR07tgdaHXBEj
	 e1PesxTqB3N5A==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 03 Jan 2026 21:24:27 -0500
Subject: [PATCH v2 1/2] rust: net: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260103-cstr-net-v2-1-8688f504b85d@gmail.com>
References: <20260103-cstr-net-v2-0-8688f504b85d@gmail.com>
In-Reply-To: <20260103-cstr-net-v2-0-8688f504b85d@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1767493475; l=1830;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=m1Ef+5RLILS8khynua89ge37a6Fboijupoulr4slPF0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFyUe2hm/ILt6BBdSFF4ctMYHW3ZibaaZc6dp3MO1Pxe1NYS09RvIKDumFTtQCkin+lQze69Ytz
 SrAp+98zLYAA=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
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
2.52.0


