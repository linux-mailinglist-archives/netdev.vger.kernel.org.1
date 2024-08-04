Return-Path: <netdev+bounces-115598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8774B9471CD
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 01:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA901C209A2
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 23:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5513C810;
	Sun,  4 Aug 2024 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elHn9PEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB713B787;
	Sun,  4 Aug 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722814906; cv=none; b=s/m9sUjqd+Dl4+vHMqEa94Dyxn/0GA5B2NdQ4/bFjY0IEt63UVsySvKZgpvKXENUmC6vWZkXdZLfPTsRFXsrMyrDWwAEM+agTbHMal5FoKsWKLLd1vZpeDwOXmzbZW+43koFWCdDR3XgaOrxtaVbk7eIl/tKnoI13VfTiRSClv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722814906; c=relaxed/simple;
	bh=NLZmyFwRmNrUpvp1/DY1sE6dhxHV+9KSXjfdHJoB9w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nBT2dTon7WEbAjwCIQ3IsVG3LD4AR16i2RpZIEduEhg8rzfk99sG+h5+xN4RcIBb+TkFMwXklsbe4kNcaTaV0lFa6MdQ4bV9sQii0NKv7Wa0nTlF1Qm7sxeApjhvm+u9emgzkomJxM3XsMisYz5D5w5sacXphSLh8BoOkcqea1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elHn9PEh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d19bfdabbso237165b3a.2;
        Sun, 04 Aug 2024 16:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722814904; x=1723419704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRA70TSyME+q1opiUIADckKNjk/c0WKvNY/ksIWq50M=;
        b=elHn9PEh5QXcl+zs9oKK8yMNAMznSFDTu37Bosslayk+jtgk6Qlw/racKp9w+M4ISq
         rIiz4bWSnXrW8goH+MmV7c/jtJaL0MPx2X5P70Zy1SrzjZSbsp73v8feh9BZC2AOEQ2T
         iVjO/C4kAZxtRNS79kYngvf/ZTZHz7mfzG6jala1wCzLf8ZTVkKHYQTcVvEKWf1+c1Nm
         2EoPQ0pMlehT4SUbQwGPz69FKUO7j1TgvmJ6e5Z0c3kDhUO37UPM2V+JmgeJpy1d9hH0
         PifSroODYt7ocKNZiM630bEHlou1Kwvf6vr6YYyMpWm5J/lD/j0bFeGLZgKbeUHIzueT
         wwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722814904; x=1723419704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRA70TSyME+q1opiUIADckKNjk/c0WKvNY/ksIWq50M=;
        b=SyVStIYkaEuE7vZRQ8/lKdvuLybttlYM48xSK+MXdlFpw4yLfKWPjC5oFJsg0A3Sh0
         SuyMiEYsVgf27BqGkOxh2xLQCBQvQdhI0SASdATEtQUADboMQSuaZ0oKmsTO7nb8Et1y
         ivOekVPFYUoPavYh5EhMnaMXAmoLBi6lA1PXZ5rNqCo64xXNias7oSf3gRTRmqDOP1kQ
         wTLvwMZUAC8d2Jl1SlsM/9269JibS5eIagVHwCGjUg90oH/o2ai7sUI1c0rAF8zpVyQs
         StOORTbIQn/xtz2uaWI1IxX5HYeO2bi1H0EIAXeBUdFYvV5SvIhQNsW59EZ27NWF0UIv
         zTaQ==
X-Gm-Message-State: AOJu0YwabfVwerR2GWt+47CIzUgYAFEWVJe08VJbPgWMFwBUY0MWLBKO
	Jqei/35pK9FJcdsPLIXuGafIt6/18AZ3bFUx/XjghjJv6uNVuR/HvwcxDV1x
X-Google-Smtp-Source: AGHT+IEdvtmUluYDQ0ALf48ez1BJzm3+9tPZ4s24RlZO914TTdg/hquV1C8/2shSxFe5PJc+WTiBOA==
X-Received: by 2002:a05:6a00:4fca:b0:70b:705f:dda7 with SMTP id d2e1a72fcca58-7106d099268mr8341892b3a.4.1722814904021;
        Sun, 04 Aug 2024 16:41:44 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece3b99sm4535258b3a.98.2024.08.04.16.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 16:41:43 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v3 1/6] rust: sizes: add commonly used constants
Date: Mon,  5 Aug 2024 08:38:30 +0900
Message-Id: <20240804233835.223460-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804233835.223460-1-fujita.tomonori@gmail.com>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rust equivalent to include/linux/sizes.h, makes code more
readable.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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


