Return-Path: <netdev+bounces-121556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1DB95DA7E
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 04:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850B32847FA
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 02:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80AC1946F;
	Sat, 24 Aug 2024 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM9d7iCB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627DD18028;
	Sat, 24 Aug 2024 02:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465316; cv=none; b=SsVE6ncnk2C79dBagyUpPtacZa0w2rEz/DK2LEZBX9YZbDlEuvN7UBRGVQTfnuN/FZZfDPYCB4f9a4iMkDBhJu0Km0Jwu+MWhbvioBkL8UXgecNvrZL3AtX8BYmK1/LsiGdE604N/vmQsQB9fWQWdm5iRCe95Ngh/LYvbO1cEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465316; c=relaxed/simple;
	bh=Zd8l1q0D19cU6pErw51JdqlQ7c0xNmlvoL/tC1zo+/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgFaONjWHdeenfqXyz99oE5vPfHy98UKMvUCe0j27/Z0D4mv5JETqFHxjIeoz8pQBcJSViCNeH1eRoI0Gy/ryahB0PfxIAPnlJDtzCOz0uwVRWYH8Tzpq+bKn9apXVLFMfJgYm3vPwwFF7mE+eKpX8K0e2bREtXdqH2KaXlViTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM9d7iCB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20223b5c1c0so25014265ad.2;
        Fri, 23 Aug 2024 19:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724465314; x=1725070114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Beto75Mf9prahnTjU1kwOMy7OnVuEGAzz1OuVXCfzHo=;
        b=PM9d7iCBA5pMNirzzVrlTFid2P8tT4mXwU/SzXLJRTh/9+oS4hh7NswcJcjFeZjxRl
         Pvvc1B4HlbQJmMS+PkXe53wkri9i/3QuHsF+WwQqJ9BT0qln0/qCGulR+ToUYTXaQTP3
         XR5bdErYKuRYjzkDp5dMX+c51lWRnWb4Ub2oV81HjsrkW+gRqeUJWrbxYTlp1Cpjz9H0
         yKt5G+mBuZ0Q31GeXV5C1TQbuIesCwjAqVgh0mZsa9m7XMCnqK81mHxAPYWw0xKgpbc6
         cOjTxeWccNyNkbUu8WjeMaW9I1zh2Cz3gV13x0jJMVE5vIKLoDgcVt7vFx9YQSxX+85E
         PCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465314; x=1725070114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Beto75Mf9prahnTjU1kwOMy7OnVuEGAzz1OuVXCfzHo=;
        b=oH7TE6eJWgOBHNabqdFOBOzeNz0ESfVBi+4+ajLu2lcaJD3lodP474kX14JgbEBgzL
         FZA2YMCdDxPIEKeeuRVgmwPblhXsdP7RceQs8fY7KUSp5AGLwCtJBGTxi3YgaUlqlrfO
         1H/N6LWRIuecYEXzOY/W9efIMmhbKXIT3MDCBJx27KShh3qDvqxEyvA08YWQyHwnVbY4
         x1GlWHja3G07pDTeDz2bEZFpGfNy1AD0sv+aGmvMNl78irm+F2iqaTKd4vJkrPEQpwiI
         Ny9/5ipaEnJrjc8AREJC5sudbE9Qf7vdDnsQbM4WnNoOcb4QiXweGhEebEKnjbnuFNAD
         ch5A==
X-Gm-Message-State: AOJu0Yxw/Bat5o/hmTUfdriIkdShcvZ4sQSXo6jOcyHNhACrNoWWR+WC
	wBBp5twuNgKIHDsDKpvnLhDoaLudXI3ABzWdMngE2AWzLEQEQvBrSnSsAMT5
X-Google-Smtp-Source: AGHT+IGcsIkPrxW54iCPL9xeWSo/aGkmoa+zakOlzu3fjeE8Op558WacK6HeRET9Qmf0sWyWTqje3w==
X-Received: by 2002:a17:902:e846:b0:202:1bc9:5a96 with SMTP id d9443c01a7336-2039e4bd50amr41922395ad.9.1724465314066;
        Fri, 23 Aug 2024 19:08:34 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855809d4sm34393875ad.95.2024.08.23.19.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 19:08:33 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v7 1/6] rust: sizes: add commonly used constants
Date: Sat, 24 Aug 2024 02:06:11 +0000
Message-ID: <20240824020617.113828-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824020617.113828-1-fujita.tomonori@gmail.com>
References: <20240824020617.113828-1-fujita.tomonori@gmail.com>
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


