Return-Path: <netdev+bounces-120364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE1A9590C6
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BB91C21E9E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F931C825B;
	Tue, 20 Aug 2024 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gizoj3zP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5851C824C;
	Tue, 20 Aug 2024 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194750; cv=none; b=F8cZqF3t/3v1/L46H8FADKvMdvdEHcI/pxtPAE1VMfbH5qxrgiDWrbqe9+nJDt4cgHYpPXJNZmYifrl8WqLZs0kSpYleSWLDXvP8sMFw9B8/BprroOx7HDK3QFLVb9f980fQewstugEQXw3SBLcKMK/wJxp5Qv10S8LnU71MV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194750; c=relaxed/simple;
	bh=VZlZ5qQFEmyWTZ6qnTB3byvaBMUGoBK0XqjE8w0Zoy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8f0pWB1yvNg6Y8gQNgfiIpgt5J2nx4N+pLH261NmF8NBGC5VOMEOTt2hBcMtU7ClJHi7TtJsLM4s25eu/nhBs9rRrqzTdxaHGnwDLjwGq6kp9XTRlJ0vcd9Mil/JN2TeH/93SDQy5Zyl3igOJpTpd39yEczydp2qMPsZDDrB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gizoj3zP; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db130a872fso3763595b6e.2;
        Tue, 20 Aug 2024 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724194748; x=1724799548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncHo+Yl1BU/0RbHH50b50H5vuYVQz7/skUGRmr1iIUI=;
        b=gizoj3zPPENmYLRPROvjoeXeh+rQFW/SIlugXD1mGCt7l7btK2R5ZtSBmNVr+0nsic
         UVRvpPBCRQxe+FbHHU9HPT1WjkUPVqIwkRRuE6Re58rn8mi258qh+pEEpn0C4N3FT6Cs
         mtYcTO49xhFEvTdjgi+jShbE/aOAi6PenUX0Ez2ax/O1jMY1Qbb7kB7BBvTTj0BnHeOI
         fHkykwkE5clsh/qhYILXA1CjUqczIK8O54n4i/NPIFkPMyoHXcY4E5PHYLrnI5ievuSJ
         bH0037N9XhfXAa3+6eSVRDtLqWZVESYHaVqaztCTRcMFKxEq5aGMOnX+9qeMms1hYe+r
         CRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724194748; x=1724799548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncHo+Yl1BU/0RbHH50b50H5vuYVQz7/skUGRmr1iIUI=;
        b=jau7VeSsMXGHhRFrVZm4CnObQdnltsYNeBNT6QimnG7ur4ddrIJDQHZ7QYuaP9eyM2
         FDwPlSh959OAi0+NwOEYelaGXIq7RHAUgzAgFlEwVfNqhm+PwJ+wyK9skYgf7omTnQIP
         VP/j8ycaQoDjk1/Z4pi+7xCcMBeb0NtONcb7Ku0EjNHRWMcnaX9YY0oi9IJSqmIQ6M78
         E3AenUmq5T4ghHgpNrmJjsi3VmS+1dgXiqUj/oC1SDg4zSaroAn2iIK4uWjYOZhOW3nl
         cgzDxjAh9E9LqltPtjVUQYlss20yFBN9zzEZcJfGIZezmwGz6hwWCb/TCMaa9dI8J3OE
         wKiw==
X-Gm-Message-State: AOJu0YznVgNqo6qgqRr3YopFvRBBS9h6/8foiv68bQQ2ewiKObrhJhfS
	JT3IT+qHw0gb/mj331MxQ7+qtXK06Kh4xqFHRbVfJD6Xvr5Eyyp2SEvsjP5l
X-Google-Smtp-Source: AGHT+IGMht80K6Aq3Azms6dTMx9RTSXYfH7h/8IXLGLjZGkx1vPGWq2ojPoJ0cxkQGHSjP8hd+ltsA==
X-Received: by 2002:a05:6808:ec1:b0:3d9:303a:fc6d with SMTP id 5614622812f47-3de1958fccemr876055b6e.41.1724194747914;
        Tue, 20 Aug 2024 15:59:07 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61d5045sm9922076a12.38.2024.08.20.15.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:59:07 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v6 1/6] rust: sizes: add commonly used constants
Date: Tue, 20 Aug 2024 22:57:14 +0000
Message-ID: <20240820225719.91410-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820225719.91410-1-fujita.tomonori@gmail.com>
References: <20240820225719.91410-1-fujita.tomonori@gmail.com>
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


