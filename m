Return-Path: <netdev+bounces-245702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43040CD5FC8
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 13:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1430330336B8
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF0829AB05;
	Mon, 22 Dec 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM9gNI+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CB299A8F;
	Mon, 22 Dec 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766406760; cv=none; b=JUpAOoQ7b/kw+LubfeXTYb8aAQjgFxewBiSrmkdWaFhsuwTJoDaVm5J8TQ1P70sdLXhFqrrlAoCXpyWIGAQ1sCwlWp3ARdF9EHn7YukWQ1pUJZ6jkOBYbIXNGZ6fzNxVdlBSHK0C44Ff0e7mlrYDeD9VR4yF/9iOxXvNduthXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766406760; c=relaxed/simple;
	bh=ZTQvplbOEMMHxXaYqiZzYFUmEN08twJ2eCRVSFv3I0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jf3yLzL8vbBuSjlLoyUnnzY3n4SMd4gwNqvBEabDQMa2HL/54qYY2YrHgZLP2n3Ao93xz7JGqIdqtxV6PI3FhB+0y3nuPyaai/4Ktyarocf/lWTV9pLw5NKP7Uf5PPPkAqtvuXtdRfMAl59R/b6+9v8nbVbAgTlO3DcttbfRr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM9gNI+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B416FC113D0;
	Mon, 22 Dec 2025 12:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766406760;
	bh=ZTQvplbOEMMHxXaYqiZzYFUmEN08twJ2eCRVSFv3I0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BM9gNI+t4li5Pkko3kpRifZsH+y7Kuew/+khqRpu99B3vq2Tt9fgn3T1KNr3zCO2t
	 zTNVhoPF4/lH3mfhhRL5ILOjOUYu/J1k/o76GQvzR2OQ3imDA50fB98PcQzykqNHSm
	 e7YtWvd1M186FZs/7hv7gk0H+SOTetoiWpAjaDThGVMcJrDuErMNQV5ohTsdE6wCPF
	 eVWWM5dyz+ZFHQaN3hfo1MfaR25Xh38RPUg9nkpl7Q5nKUuIKJnirse00GZX+bnBTv
	 wM0WZqoBlUYzAGeKmmY33j89InbeD5aOOzkzrtqV/bGiFoCWZdsHctbrMIh0IwYF4l
	 aBILS8cBSy52g==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 22 Dec 2025 13:32:27 +0100
Subject: [PATCH 1/2] rust: net: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-cstr-net-v1-1-cd9e30a5467e@gmail.com>
References: <20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com>
In-Reply-To: <20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766406749; l=1712;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=HcspC81hb5Ldki8q3pxmBaVR9zMPXvkj5LMt9l+0xEI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMATpdWSmj+tzLGnMBWC7Pt+kve4W0s8rHOwv13z4SrjlTTMJHX7JJbV+op4NX6OrJ8hABYuvqb
 La3ITrRzPSwI=
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
2.52.0


