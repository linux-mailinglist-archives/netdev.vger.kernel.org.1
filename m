Return-Path: <netdev+bounces-213644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24D8B2611F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427C9B6516F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A322FC898;
	Thu, 14 Aug 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWXt7W3y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0C2FABFB;
	Thu, 14 Aug 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163879; cv=none; b=Is0ZfdNM4DgIWfdzkmUs5Mzwsam3u4BhBUhaLP/V1Jjl8jVYrIyPn11GTg+k7AeiXvN9DNCFSWTl8bBYWCLKfBVK6IyPYprLW+1MEenG2Q8r3cT4iYSOimMTjsx9fOsRNNI0KQkihULojHEMkNHaNQiYcgYKN+kQzPJDzmSMI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163879; c=relaxed/simple;
	bh=gVyxB1Di/2E8IPGLNeHV1iWeZXC/jQa+aBKyc3yL/O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sywOjobQRKqBADCuDzMwHdrTb+G6zZaFfILVcI8XXEkIFCREJ4acrIFSkSfvybhXBW4jiI1FhFA1KSFcGEJsQjF1JuLMHmNqdpBEQBowMDmHjOHLj0zlWolVm3xQztDguKuG9vMdswkQkeFX2Ya3LxokvhPXO8bhegcd8tZ5chs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWXt7W3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BE7C4CEEF;
	Thu, 14 Aug 2025 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755163879;
	bh=gVyxB1Di/2E8IPGLNeHV1iWeZXC/jQa+aBKyc3yL/O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWXt7W3ykBE+CGCc/BwgDp+tcMOXo40jPetIeBoIf5YzrKWYXdLnCe1I91e1u9VXL
	 TA/6rB9PHeO/C0GvHUTDWIAA3PqQ7YhdkLpXw1GAsBNj/B40CwPT+QjyoUH5A9ZQH6
	 iAiW0gR/B54UDhbJT6LMhI8wLXC4m6awY8iVNqEoB3V7GvWLYWXFTP4ndLnHJib1oY
	 YgloZiQaG/WXFl+Opc02Moi9Kd9G7LMYyR2vEYtIGYnXOK5W4MMfsrHF6DXV3VKGRC
	 MTCzmSLiq0HmnMbgpcD7ak6Rc/bCBx3+FjGCqAdGVKTS5ddwqMsaEwBlrSVhHRzjb2
	 ivFOpBJJsIIbg==
From: Benno Lossin <lossin@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] rust: phy: replace `MaybeUninit::zeroed().assume_init()` with `pin_init::zeroed()`
Date: Thu, 14 Aug 2025 11:30:31 +0200
Message-ID: <20250814093046.2071971-5-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814093046.2071971-1-lossin@kernel.org>
References: <20250814093046.2071971-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/net/phy.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 7de5cc7a0eee..3e5565a6a130 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -556,9 +556,7 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
         } else {
             None
         },
-        // SAFETY: The rest is zeroed out to initialize `struct phy_driver`,
-        // sets `Option<&F>` to be `None`.
-        ..unsafe { core::mem::MaybeUninit::<bindings::phy_driver>::zeroed().assume_init() }
+        ..pin_init::zeroed()
     }))
 }
 
-- 
2.50.1


