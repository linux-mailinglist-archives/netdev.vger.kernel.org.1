Return-Path: <netdev+bounces-238520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6454C5A6EA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9EC43454A0
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A4F32861A;
	Thu, 13 Nov 2025 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuuGeHPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44601316194;
	Thu, 13 Nov 2025 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074716; cv=none; b=MlfyO8uiqNVUdMsv6LRPG83sIoOnfYWReqCfQ23T52ANTKn9g3m6JWDbifECzJrxcodcgGtoIWA5ID+aweWxK2e0CgjHB6GlIc0nxN6uisAQ8dC7llD/l4gLQBkYa03YzpXM/8z87j127OqIgmyd3LQxfe+687PlsP03N8XjhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074716; c=relaxed/simple;
	bh=+gotfND6+EK22qcnNgJ80M57aS5MBYstylF5+8IyY1M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vAIJafWCwSGAuMRyzq17LPl2PygLeNOUiP7X6d5aPvJ4H53mS/S7JvXr5KeVOpc0L8dDhXaZqwMULh3OGHXnlhBj0dMXdEHGvDwabo7zum4O4uD8Rn6h/rqXp4wREBd+TqKQERQOoE9slYJ9fI/aHRAwx2+hSdzQSbS9CfBl6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuuGeHPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10800C2BC86;
	Thu, 13 Nov 2025 22:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763074715;
	bh=+gotfND6+EK22qcnNgJ80M57aS5MBYstylF5+8IyY1M=;
	h=From:Subject:Date:To:Cc:From;
	b=NuuGeHPn7pffuN7s3QZBfqfwKRSbwPwbodjJc7BFHpfFi+rs2Hoo2NZYmsaJPfCTs
	 6UaeYuikXCN2vOGXI4Xu1DVKFet/OoeIKDca6XJ+1e3qrb4/9gBUyodvHrbcE/BTkg
	 zBD58iZ2FOjbDpv6H7xVeS+a+ya07w7tpYOkwnC4CIAdwKfGwwJx28yUYn1Xu7tWY/
	 ybWezWDycCZRgrXwv3Vx2D/lW4RZSDgEZ+Dg7KsMQstpZ6edbU8kewkpPFEVENddDC
	 dtiJmETWV4YBCqpBn1ikZlwa2EjJHsI3QsfkTcndXe/a8MMsHwW1DjOde2YVPlaC3A
	 Ca/BHJKjuSOMQ==
From: Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH v3 0/6] rust: replace `kernel::c_str!` with C-Strings
Date: Thu, 13 Nov 2025 17:58:23 -0500
Message-Id: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI9iFmkC/33OwQ6CMAwG4FchOzvTFXHiyfcwHpbRQRMB3XDRE
 N7dgQc8GC9N/j/p144ikGcK4piNwlPkwH2XQr7JhG1MV5PkKmWBgAVoBdL2nqQNg18Gd3WQyhl
 j9jk6cJVIizdPjp8Ler58sqf7I9nDWjYcht6/lsNRze3fG1FJkIB6h0BGlyWd6tbwdWv7Vsxcx
 JUosfhJYCL0gSB9a0nZ6puYpukNpaCVrQwBAAA=
X-Change-ID: 20250710-core-cstr-cstrings-1faaa632f0fd
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1763074712; l=1648;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=+gotfND6+EK22qcnNgJ80M57aS5MBYstylF5+8IyY1M=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKcnIqYCqQbJKlNf25amvRNVxxGzdanoDKCzAF92OuNDlYPLo0mUQPW6ctSEX67hp2CllG0H3/z
 kilYWTZypxQk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This intentionally includes only those changes that can be taken through
the Rust tree. I will send separate patches after rc1 for the remaining
changes.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Include all patches that can be taken through the rust tree.
- Split "sync" patch into "sync" and "workqueue". Kept the tags on both.
- Link to v2: https://lore.kernel.org/r/20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com

Changes in v2:
- Rebase.
- Add two patches to address new code.
- Drop incorrectly applied Acked-by tags from Danilo.
- Link to v1: https://lore.kernel.org/r/20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com

---
Tamir Duberstein (6):
      rust: firmware: replace `kernel::c_str!` with C-Strings
      rust: net: replace `kernel::c_str!` with C-Strings
      rust: str: replace `kernel::c_str!` with C-Strings
      rust: sync: replace `kernel::c_str!` with C-Strings
      rust: workqueue: replace `kernel::c_str!` with C-Strings
      rust: macros: replace `kernel::c_str!` with C-Strings

 rust/kernel/firmware.rs        |  6 ++---
 rust/kernel/net/phy.rs         |  6 ++---
 rust/kernel/str.rs             | 57 +++++++++++++++++++++---------------------
 rust/kernel/sync.rs            |  5 ++--
 rust/kernel/sync/completion.rs |  2 +-
 rust/kernel/workqueue.rs       |  8 +++---
 rust/macros/module.rs          |  2 +-
 7 files changed, 41 insertions(+), 45 deletions(-)
---
base-commit: 5935461b458463ee51aac8d95c25d7a5e1de8c4d
change-id: 20250710-core-cstr-cstrings-1faaa632f0fd

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


