Return-Path: <netdev+bounces-246702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA068CF0875
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 03:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91469300EA3F
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C1124677F;
	Sun,  4 Jan 2026 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0GVBe3B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F9D18DB1E;
	Sun,  4 Jan 2026 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493479; cv=none; b=B7Q6M9Y9QVsPRfpjPK4NyFMFSb9EnQwG0gkoL272j4t9Nr32yuBmAkxh1SdwtoRFpKXwi1hGXy4vI6vvm+861VAYeYZ6d9vy/Wd8MooZrRxG446ypFOYE1NK/1UyCBrk31MInCFSdHO7wz/8bUtiFgE3tiLhBgM0oJpFVDYWeZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493479; c=relaxed/simple;
	bh=6zlbwmKxYqD0IqTcR4BQOFgDh/0IVz0BY9YeMtaSrcY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EWAwqsvXRl98ZoYMS1QfbV0gv5fVarHndfg6wvUwa8DiGc/X2T0MRPXnzrN/dqjbszhyRoSq94JYNwTFFpB5XjUbjgFehBO64sXP6u2wYaaaTOrStQZ/TlyDqXaZcYy3tea+YRUGDorHBSCZkjiKVDdb6X0vqyE1UoQdsmxqXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0GVBe3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FAEC113D0;
	Sun,  4 Jan 2026 02:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767493478;
	bh=6zlbwmKxYqD0IqTcR4BQOFgDh/0IVz0BY9YeMtaSrcY=;
	h=From:Subject:Date:To:Cc:From;
	b=m0GVBe3BBmT45DpZ6iZbJeFF06Ij8V5nfqdnMsZJzzyZPoR0lbVFlgNzF0pSNX+rU
	 xQmxnlRAu4Vey2cxF9+SpkqypjYs8iNT+voUwpGc5enEhq2GbRue8c4HAn6UWEQjk8
	 aZwCpEIpJLxTuuK+wSGril2pPCZArU5ClnLkDnMqv2bsS4khvDv+wb+LAIcrkUU14p
	 ujv/BqZ9082l7u+R6tkV4kmK5o9Jdvt2HSYUW/TwiWHUqkUVFkMZJJWCUBvaVc2m/Y
	 pfu9L5RjwgeV2EiY/dbsIPUfQ6N6oBaPDA6YXVDBCDGtmSxLffT8TLaFkRX0uXqOz8
	 nsc/odkrE/VLA==
From: Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH v2 0/2] rust: net: replace `kernel::c_str!` with C-Strings
Date: Sat, 03 Jan 2026 21:24:26 -0500
Message-Id: <20260103-cstr-net-v2-0-8688f504b85d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0JmbQ0dRKIr72FYtMMAY6QlbSUaw
 t0F3Lp8yfvvzxA5CEe4ZjMEniSKdyvgIQPqjetYSbMyYI6lRkRFMQXlOKnCtk1li9IQaVj1MXA
 r7z11r38cX/bBlLb9ZvQSkw+f/WvSm/cnO2mVK2ouXOSmPJ0rvnWDkeeR/AD1sixfc7/KvLIAA
 AA=
X-Change-ID: 20251222-cstr-net-3bfd7b35acc1
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1767493475; l=822;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=6zlbwmKxYqD0IqTcR4BQOFgDh/0IVz0BY9YeMtaSrcY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ1o8mCvCivMZI1NY2PJdpvhMVV/ABFZ/HepqSU+f1B2xz4IYVgbVxKHwmp3Y14wrMUctUCVnkv
 s7CvOBGnvxAY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Pick up Tomo and Daniel's tags.
- Link to v1: https://patch.msgid.link/20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com

---
Tamir Duberstein (2):
      rust: net: replace `kernel::c_str!` with C-Strings
      drivers: net: replace `kernel::c_str!` with C-Strings

 drivers/net/phy/ax88796b_rust.rs | 7 +++----
 drivers/net/phy/qt2025.rs        | 5 ++---
 rust/kernel/net/phy.rs           | 6 ++----
 3 files changed, 7 insertions(+), 11 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-cstr-net-3bfd7b35acc1

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


