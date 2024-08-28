Return-Path: <netdev+bounces-122646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4387896215F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29851F2231F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72415FCE5;
	Wed, 28 Aug 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKZNfnxe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55415F33A;
	Wed, 28 Aug 2024 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830611; cv=none; b=sPmnfbDNNR8NuxmlYq6UXjyd3+los7twqyX8S+q3fEj0+yttglV58s47S6uIJ0dpYKBua48WHlT1fLF3cTUV5HcNcLjczJx0kQpfne3HdBiui3gnyQ16FILkoxtckbcPv3TJZU/ZeHj8jAdg/CKD4oADjciElz5YUG+C+83g8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830611; c=relaxed/simple;
	bh=Zd8l1q0D19cU6pErw51JdqlQ7c0xNmlvoL/tC1zo+/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry8PPNFq2Wx3Ldw6AotoiZ3Oxemmtjnmn5QVzIKbFplkQSatyQmfIV1Z7Z2MLKMfcNcvzMv0wPyeIS1lYj6Y2IyHvqAO8bd36I7TUcc+uWHVhhUn/4lTcuZBuODWkuFKVEneBkDJyIn9tNCVkz2BFuruLEyZhh9mjCCjD9tz+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKZNfnxe; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d2ceca81cso23941025ab.3;
        Wed, 28 Aug 2024 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724830608; x=1725435408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Beto75Mf9prahnTjU1kwOMy7OnVuEGAzz1OuVXCfzHo=;
        b=dKZNfnxelHCugDk1Rw08dBpae0XVTZ5jtoaamw2QJX34dhwrLKd2AK/8mwy50dqx3A
         p099AXU+GW93QKU5J4Bid8zYLUYtSvjMpkCFUBxNw5UDJSmYfo/z/kniHklMnAC7jQQ8
         Py0Aw0UmcIAep1zu63Z0KQXkra6HBLOL3uwbDB8+Fn07Cg5K6C4+UlWi9U3YuQiloEcM
         yQcVkdpiUGhwGbg7JqmGscTWTcILHJ+28OZTeyI/m85lgqMS4gUNisrvBXeEbsT39SDY
         kPI7mLZcEL4yzDZS8zCAv/wS2NjybLQSDMRAoawdkFKMSPxI1XAmNkn2OvOX+UQxQpxH
         FW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724830608; x=1725435408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Beto75Mf9prahnTjU1kwOMy7OnVuEGAzz1OuVXCfzHo=;
        b=LTYQE+cHyG1Ww4yP9f03s2vloiS6B69IQVOJdLAxI6Fba5DOc6Cfbnmqc3UwQgGr7U
         PUW9+DbQq11PbaiBm7F6Rfkj+upQ7v6vKPXdKCVwJ8YVjWCssqeEht/9dPQ5qXIjvdpf
         agned/ikBrltfNKQsNCzSumtY9ABWSJVz+wUwPSYB5t7i8YABfu5f0qU3sUzmQ056UCT
         feXM1TJ0X+fQf6AdXPm0mqErm3gyMwTmayDa95wtQICM4Zu7zcdtZqGa3liGEuAyhgE+
         O5JXSH81pNFuquNmUYOYv0fioUYn/LKB6UuTp5pZhsKtLHZ5lUy7g1comm23mXfZ2cR7
         e6mA==
X-Forwarded-Encrypted: i=1; AJvYcCVSr+QalA7wmP+Se8cLijcgtpd0+XEiTrmfFOJXWBGkhfD7zkOFAANe7g008xrKf3tzU2C1ub1p+ArMYnOKfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEa7dla5LATFoCDPCo7Uxm55o/YQfYaPPl/pQyvzc0HOuq/0F
	cuJYoaTkkUEoO7XQkIWd569QN5tZ63wbW9csyrbimzADBPdNoxWQmG4MqFSX2J0=
X-Google-Smtp-Source: AGHT+IHF+LGeqKsmSTv0OTM0ltqQ9PHeLYWKrHmXe61XjX4/necuf+E920pSmitQWyeQd67P3A9kXw==
X-Received: by 2002:a92:ca0c:0:b0:39d:376b:20b9 with SMTP id e9e14a558f8ab-39e3c9c0b0dmr202016575ab.20.1724830608207;
        Wed, 28 Aug 2024 00:36:48 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac98286sm9016225a12.5.2024.08.28.00.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:36:47 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v8 1/6] rust: sizes: add commonly used constants
Date: Wed, 28 Aug 2024 07:35:11 +0000
Message-ID: <20240828073516.128290-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828073516.128290-1-fujita.tomonori@gmail.com>
References: <20240828073516.128290-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rust equivalent to include/linux/sizes.h, makes code more
readable. Only SZ_*K that QT2025 PHY driver uses are added.

Make generated constants accessible with a proper type.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/lib.rs   |  1 +
 rust/kernel/sizes.rs | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 rust/kernel/sizes.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 274bdc1b0a82..58ed400198bf 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -43,6 +43,7 @@
 pub mod page;
 pub mod prelude;
 pub mod print;
+pub mod sizes;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
new file mode 100644
index 000000000000..834c343e4170
--- /dev/null
+++ b/rust/kernel/sizes.rs
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Commonly used sizes.
+//!
+//! C headers: [`include/linux/sizes.h`](srctree/include/linux/sizes.h).
+
+/// 0x00000400
+pub const SZ_1K: usize = bindings::SZ_1K as usize;
+/// 0x00000800
+pub const SZ_2K: usize = bindings::SZ_2K as usize;
+/// 0x00001000
+pub const SZ_4K: usize = bindings::SZ_4K as usize;
+/// 0x00002000
+pub const SZ_8K: usize = bindings::SZ_8K as usize;
+/// 0x00004000
+pub const SZ_16K: usize = bindings::SZ_16K as usize;
+/// 0x00008000
+pub const SZ_32K: usize = bindings::SZ_32K as usize;
+/// 0x00010000
+pub const SZ_64K: usize = bindings::SZ_64K as usize;
+/// 0x00020000
+pub const SZ_128K: usize = bindings::SZ_128K as usize;
+/// 0x00040000
+pub const SZ_256K: usize = bindings::SZ_256K as usize;
+/// 0x00080000
+pub const SZ_512K: usize = bindings::SZ_512K as usize;
-- 
2.34.1


