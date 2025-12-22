Return-Path: <netdev+bounces-245701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3DECD5FBC
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 13:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EB993016340
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60EB29A9C3;
	Mon, 22 Dec 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itfbRcQ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630D299A8F;
	Mon, 22 Dec 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766406755; cv=none; b=cjLBUAgzvYp9t7w5lrZB8XKHi7QgZeMfCKRxwTOPtig7ejvH/iRW6W/C8aJRNGvk+YephAgokhHSFaN6lOPqIOQPX8hcn2ag5oLDI71fOvM9c3K+tyCm66aFBwEofPyMAKMBz/O/kuGyIfMYu36yUQslLMYeyCt5WoPWMzCZdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766406755; c=relaxed/simple;
	bh=xx/uYV553XLxIK/fGNh/4KijfTQ1GtZ8PN9TNKwXRAM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SNkJiAA9ZQjIri/I1LJtj4KD+IT+K2F5SMaS7uOmIa4J919JgUF+b6utdl8pXtQOUHF5O2jW3LKpUKSrHyx8AVRaa2q7xu0V0xM5bRAJCdGgqvjItX254EiEG+lmTNVYCPt0IkfgJPM//EFCwq+c5QBpJqpMJUptVR9YpXJto5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itfbRcQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E929C4CEF1;
	Mon, 22 Dec 2025 12:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766406755;
	bh=xx/uYV553XLxIK/fGNh/4KijfTQ1GtZ8PN9TNKwXRAM=;
	h=From:Subject:Date:To:Cc:From;
	b=itfbRcQ70GEt1xT5l60gryWiL5lSxUt14LgubtOk+N0e165g5rN2d9dEm67QVsrhV
	 zl76Z9t4xD8m0zfffViuT8OJPd3YzlBg/6/l7S9EaIGvXztqMNIIqw/CNwhv384126
	 uqhZb40nLund4bxZLyGiCytvrUV4N7fA5ImkPvojnkygkKrHK1988dvVqBoCR+B49p
	 GUMwnaX505SCvjUsHIg638JklJN/DcB+NbZ6sZ2ApykY/ysNaudWl4zhYYixnLEZuy
	 wqoBYQZNRd6lBDKgNHVtjWODU9NcymAUMQGfjWPyPybMOVOosDYT5AUYlH+2MlMzBz
	 SmlaeN1N4GbNQ==
From: Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH 0/2] rust: net: replace `kernel::c_str!` with C-Strings
Date: Mon, 22 Dec 2025 13:32:26 +0100
Message-Id: <20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAQBCF4VfRXNuyIymvIhd2DMbF0s6Skne3u
 PzqP+cC5SCs0GQXBD5EZfUJNs+A5t5PbGRIBiywsohoSGMwnqMp3TjUrqx6Igsp3wKPcn5Xbfd
 bd7cwxXcP9/0Aurhz9WwAAAA=
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766406749; l=678;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=xx/uYV553XLxIK/fGNh/4KijfTQ1GtZ8PN9TNKwXRAM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP1XHdpS63EXR1qtjiPqDhnUC8tSnzEo1B31/oJZC5PpS57k9YtKGAF94f/xF75u0i/vkfDbLBO
 TnvKeLV53TgQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
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


