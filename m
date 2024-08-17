Return-Path: <netdev+bounces-119373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C17955586
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 07:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D312844AD
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 05:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EF812C7FB;
	Sat, 17 Aug 2024 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBWci6Yb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B285947;
	Sat, 17 Aug 2024 05:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723872340; cv=none; b=npkEsS24oFbKW7WT6Cp8/K6c4wYKHMhg5cKDpvdCs3I9rvKTcytV+uzjHEbHlIvreY4J8IbZR8XscsHLcLUFw6NVnBIbZ4sJ/fOmeUuvilP6wjvchl1iPGWm6Mr0TNHc2n/HyQXFC0802Zvc1qugiWeSPTVJduYoi9C4w1ra5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723872340; c=relaxed/simple;
	bh=GGmTQ/DpZ1ivxAVL85XAJcvbvjdi7bdulyr9WEIIcaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRiMqIiK5YkM3/1z8eUE9cNprFdpU+7ox49AqaGclX8SoGS/3xUvgyFiFwp2bilBZehgBUsUKzMusp0uzKcFYvNuGe87ZgDd/LZ7h6pfkwh/bJVbpp8bd9V7QXdZGUp8FF8NBTv9Pu43f5tLizkF9sjpIEsFIbagAQw2PQQ3M9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBWci6Yb; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3e6fd744fso228050a91.3;
        Fri, 16 Aug 2024 22:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723872338; x=1724477138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS8+RiZEmv0wlXGw1pCvo0HTl03EM7UdQxVuxn5OxZY=;
        b=CBWci6Yby0uoiumLbfND8k0e9bOSEteCEZ4KjjcvLE9NWrRa4yTlCHErClv3ddc8I6
         pOydgkJcEN88AbkzYbbcEI6ZpNrEP64XKdsXpNsmhTyU6kqYO8a+d9QgvgIdxYFGw1tG
         R8hwmI16I6jQDOzvkXZakXnyY4/vfzdnb5fLaPTlglJVugfiUALeTfjI7F1jAZr92ZT/
         9i99FuhvllKFDRR2Wr9gsT92NvHNmoZdvgJbhshs3f7GS4I8mJ2Wffn1oeHB0xoTK9un
         nu+Vrh2szIXbGbrR/e8/7q2cf8XazkJe9q9HZZmHMviiIt+wwXE6sd022VVNz3cQ6sz0
         H7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723872338; x=1724477138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS8+RiZEmv0wlXGw1pCvo0HTl03EM7UdQxVuxn5OxZY=;
        b=FxYAdnbaKottKW9/Jyic0xgBONAKJw0YuPWX6KgRgJEGKPJwh9CUnanG+Ow5jODjDm
         y3/M0JJz6YZhnabgUH32vSB78dFmwU0QV7UltCT7csCng2MEpJkD56d0BX/2/eVqTFgw
         /mM6vNMfJeZBQtzBzEEEz13CtcR1jcAdPPfYroGd2ff7VB9um3SdBvegz25ClaZAVzk6
         HNWHgR7rTfLdgy4ji92OfWEBps4F8Tu/35PwKjLr4jXMFMR5t4JEVCO7V1XhVo86jfji
         vibAnxg8oygl6A94Mx7P+GLSYNIXxvP0PIoBTbWP4L9T6IGuMz1NYT6yL8BDeaxU4tgO
         k03g==
X-Gm-Message-State: AOJu0YyjDcqCIa18gTxvGF2R0lj7Ht+2yrQjSwjkXxwlBXyL5imn4WPu
	IXDJEDakd5XDujRPHG1KJmtIKPO11QfLI40BKKgEXAEgWFKG6g8uHxttqsxx
X-Google-Smtp-Source: AGHT+IEEy0Y/XAlhCUbj+gItKs0f4xPx1joKR8KvueFcw9K+Y1u5o0sAzkbWb+YG4X7r0qzML87bJw==
X-Received: by 2002:a17:90b:146:b0:2c8:4623:66cd with SMTP id 98e67ed59e1d1-2d3e1a42e70mr3315416a91.1.1723872337402;
        Fri, 16 Aug 2024 22:25:37 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c74e33sm2881655a91.39.2024.08.16.22.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 22:25:37 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v4 1/6] rust: sizes: add commonly used constants
Date: Sat, 17 Aug 2024 05:19:34 +0000
Message-ID: <20240817051939.77735-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240817051939.77735-1-fujita.tomonori@gmail.com>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
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


