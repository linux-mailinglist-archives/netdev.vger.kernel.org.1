Return-Path: <netdev+bounces-119516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA99560AA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AE41C20F51
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160DF1A28C;
	Mon, 19 Aug 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juqeIyGl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A978D2F5;
	Mon, 19 Aug 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029235; cv=none; b=Rl41TlodZN0o5JX5R2VwbpqqIM22LiD8SDFXKdkPaIge3Pb2lGG1C65DlYYndlb/rZJsL68JCnpxuKTV9A/rad2R10GKpC2Hctp9jDI24JWQaOcLnh8fTV5wJGz6znZeAa6Bkq9/liFlDUCSjGo7iIWVPmCevS2I9CmwHKIuVCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029235; c=relaxed/simple;
	bh=RILoisfnGBbOpWeCATqosphpuf8tPEXjX4axWzXpG/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTKiM50baTx6WfVCwqqlcLV5bvci4YD5AZ7TPpEp/Xh752owtwZuibBo1JCD9QiOeqr9+D+L4cm+cSYRFr6rGz2pH4cdBQCbX4P0S20bd2wISkaLWXJGyacrVEtWHveQx1JhtdqACZOxiqTCxYFF1zFJa30DeO/fgXlBtzGQe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juqeIyGl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d19bfdabbso100381b3a.2;
        Sun, 18 Aug 2024 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724029233; x=1724634033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1hypnzEtFF41K4hUiN7kQ5KHZD5MuFGpfmnmIufdSM=;
        b=juqeIyGlxvecj9DBuTCNOm6ahAg8FGpk/or0gYV6e6SCbfx4NH2vyk73TVgf4R8KF/
         TZ+12TXCIF/Jl7LFnNQHt9vnGPovs1xyP8kSJCUgs+vEMKdCp1hGHLj1kHrV7UzEDItC
         d8lydrBaJtcS9VDnqziKm0Qitvpuple2u6Yv88NhUWvQP9mIXDIjko7OJeVUk5BBfCi1
         DfTayEReQ8oWdN3fUs9hGrHaXYOHv9s/vVLBo8cbdqztyh8pER2euQGKXT4tShxSKbaZ
         jGcBZ5u6D5PEdsjSUx497olOMC68SyECK1CBnbMUKggMQNBJccOiRXoGSLJFdrCZf/Q2
         vhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724029233; x=1724634033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1hypnzEtFF41K4hUiN7kQ5KHZD5MuFGpfmnmIufdSM=;
        b=Yxpg8o49mkBhi7P84J/yoPGz7LNdgBsk3Vc2pOLOtJH0XDMrPCH8WE20dJKAtjG1/Z
         SiNlzOdhS9+hdkXR6vk0eQEurmg+37sFODK1shqAsAKFEewjC8BLnJn6u+cVoBMVJ8Gl
         msvRl+0fl//460WJlK1rmQMX6/x1TQ3JoYI+I5dZIG/MdXiS8A5tK+y0GnjqLUVvF/8n
         YSBSTXMaqSHkTfgFtb6UgHsHBo45W8tcURybZG2KYxRBm7ywcChUe6hNK3QVL5pS2zQa
         L+oTn3oUUtlqYJNSWn0rDfTlEGDnjremMoebkCm2KON8CNyqe01/XQBq6kbNbZO+0WI6
         jStQ==
X-Gm-Message-State: AOJu0Yw6IQNMnF1bDtgnLNn2ULMhtyj/hWblX9Hfu1isi5XZ6C4qw6cp
	To3SWJ1NnX3gycWPpU2CUN6kZu3GSMjyjI0n/nmHc/wBtt0aNaQEKOJYFt2e
X-Google-Smtp-Source: AGHT+IHB9Zz2I8FO/a02tFKjlRvD/n0kK/a8ZcST3swTLiu3NjMXxaM9KxK4giOsnIOnTSOq7+h+Xw==
X-Received: by 2002:a05:6a00:9146:b0:706:32d1:f6c9 with SMTP id d2e1a72fcca58-713c559c92amr7129543b3a.2.1724029232611;
        Sun, 18 Aug 2024 18:00:32 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c4a7sm5718732b3a.193.2024.08.18.18.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 18:00:32 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v5 1/6] rust: sizes: add commonly used constants
Date: Mon, 19 Aug 2024 00:53:40 +0000
Message-ID: <20240819005345.84255-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819005345.84255-1-fujita.tomonori@gmail.com>
References: <20240819005345.84255-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rust equivalent to include/linux/sizes.h, makes code more
readable.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
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


