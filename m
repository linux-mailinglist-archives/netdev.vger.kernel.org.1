Return-Path: <netdev+bounces-193065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEA2AC2581
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5591C06ACE
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462C29825D;
	Fri, 23 May 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPZRPQ3w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C94296FA6;
	Fri, 23 May 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011947; cv=none; b=fK7jaBtlhr7yZLhQiMKmFxx5Q96NQYw+8ys/zIvv58Vt2FEOrwq6mOMo5S/TXg/GvQ4F1JBvkaPwwTshBiVEb/qaV19CgYt/IcdM4iMlI1LHtOKijiedvFg6rJYebAfwIHp2Q87+FzDZrPu1ssPABd23mFTKdPSF878fNOADtmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011947; c=relaxed/simple;
	bh=pHvt+GnwXLhrEkNRd/KMPXBlewCCAlo3Q7U2IC0h/A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuRhSYqKy7KbUjoXYfJfEe1oqHw7rqd12kC2283ysUGnNfUwcgIF1jgF4JzzTShUABDsVzpJm8P0hKRmBHIiBVmXoHSlj2nm9WPJygWf9qpr7bzNTvEnUqWQCB7TZyMIZKvkfteSzc7QA4HKS/pIsgtS9R+Q/9NKbg0YkGTy7hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPZRPQ3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E588C4CEE9;
	Fri, 23 May 2025 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748011946;
	bh=pHvt+GnwXLhrEkNRd/KMPXBlewCCAlo3Q7U2IC0h/A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aPZRPQ3wZYiREIm5EFtPn9qUnV9nsdEf5kePJYa/8NTAmDpfCIDU9XvWNqnXKR4lw
	 qxiMmxmFl+bIlyPrLXt4V3MlCkbf5ACudMn9NyZxb0EKZzJcvFABjPmpfzgZYcbXwt
	 0iyixjiyU9GBylZu8Z9r3/IX2Hyl6SfKzaLH4qIDPhXjq2Mjnf9V5NiMeU7PnY5Aqx
	 xxH4+W3kAzs8H5Un8Bq4h7Emkj/OlPhFAgIVq65oJVB0NJl12iiLSuTUPfd+VH9/rG
	 C4FJ8+UEKbWhEMMei/25FnOHRJNwRu2U1BH9K9RG4DEWkYHpYs8UCcSJf3sJ5MyBvV
	 b+3U5nJhB7Hng==
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
Cc: Lyude Paul <lyude@redhat.com>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] rust: phy: replace `MaybeUninit::zeroed().assume_init` with `pin_init::zeroed`
Date: Fri, 23 May 2025 16:51:06 +0200
Message-ID: <20250523145125.523275-11-lossin@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523145125.523275-1-lossin@kernel.org>
References: <20250523145125.523275-1-lossin@kernel.org>
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
index a59469c785e3..de38f123e50a 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -563,9 +563,7 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
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
2.49.0


