Return-Path: <netdev+bounces-136021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D09499FFBF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5591C23C67
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711E18800D;
	Wed, 16 Oct 2024 03:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXSzJSmc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AAE187877;
	Wed, 16 Oct 2024 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050823; cv=none; b=rh1Xe/aXeuw8ZFKJ0XqpqVou/4w72nEZEEOZrCIboYWE3O/8/ZgH2r6YdXx/21n60+quKduyEbxrXVM3uy75bxyxSGJL2Gnn7KqD2ODS7QA9ClVC0yw8qh0vT2Ww8UcgnZibGQWi0SN+EZOw3ENfoZ7VEtUVCJ2Qa9sn6SN14YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050823; c=relaxed/simple;
	bh=sdOO7l0VkcV1+c4pfvjDnSgt/7HmqQdukwcZTyA4Bgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWs/kV947cKz/q+lAbPK44fZ1gC/3+n85VQZh3Xaywuwq1ZG/EM7nAySOHOcLvroHWQo1kMYfJoHnInZp0BYYVtw/o7rB7tBgxeCBuI3R/KQc0qd6Xqd5qtiRKNuwuVWZLYJYCXlHNlZYmVeM1+bvbuxPFOdS43Cy0HQ5aVbE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXSzJSmc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cf3e36a76so25988825ad.0;
        Tue, 15 Oct 2024 20:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729050821; x=1729655621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcGxqIvQqc6G0ynE34ZXsyZnUox+rF7yhwSw41f+KIs=;
        b=eXSzJSmc5u/9EOKRY5/vsGt2O98clbojEpuSN8xMcU/xs5uU/LqXk03wZcpKH6lZnN
         Ofw4BF4VhxnN5lvoM/muS/ycqpKHqafTKCcfj2LCivNMbrKHB0XLEJaBCjlVDBBXrx35
         wuLIwwjygQwYkJFccbcH4K5mw0Apa2AsMNIoScOaIUVwIB7CDmFaxxfmda7gOI6iJpHw
         /TTdyStWyPvFKCTGamiS8YHNnJ5iKEsyOOiqlAOkiahLAjq9+IBC5hJ4Gt8Ku0HH4q2C
         dJj9sYaniQyKKJhQ4awgG9nwV49UC7ItjCYR0FyZDdTWnV0d1RBsgc7JJSEYURAe3rYy
         g0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729050821; x=1729655621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcGxqIvQqc6G0ynE34ZXsyZnUox+rF7yhwSw41f+KIs=;
        b=sFVKE1qtPbiSYyGrJJ7yoVjO/mRkfwfdumKpd2mBoZDXqN/i3Ji92DHRQAcEKwLjke
         ns34VDXVas00k/N1DZCEriLowkC0sQ/3vYUll98A5G8QZLadR5/OkBiLrX5yEL5AoZv1
         qCFUe0Lxh6+zWtSPPLgv2BNeCZBRdLLQvu61RHZWRnnwcP21Ze8YwkLUqprvzHn0syWt
         Nf4oJE7/tJZpY5BfQ+hqGDv9Cw70zRDSvXu1MczDGr2Rl9gRravpCn1eITVOOvZjdZmO
         9oTEUcvZr1Rb2/spnNL/IwYxhDidBlijFqRbuOoEfOFPjpLJ83iMQV21O8sp/YSopHxg
         PNTA==
X-Forwarded-Encrypted: i=1; AJvYcCVlG0qK4ilst/P/nXt/dUP3YOuKBBZB+BDIJ7G9ojZe1BZY58HJiLtGgcXY8Eo8OUkFO0tmnKVpSaDHm9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ajno8ookkLy13QRHEXrjlnpfHp2uZfYkQP1iGbu1Gua+hRvS
	4zBmvcFu7OW9DBWWWooGYB0w8VT6c1nGYmWR6EktoJlm97DKQpPsyvJup735
X-Google-Smtp-Source: AGHT+IF42EEDWe2xyQ+/4NTnG61Wd4qxON0nU59qp7Aqk1dUHUJ3Fc5OSnVCc1WYCiCrhT6WxlChsg==
X-Received: by 2002:a17:902:ce92:b0:20c:98f8:e0f5 with SMTP id d9443c01a7336-20ca169e8cbmr212371145ad.43.1729050820686;
        Tue, 15 Oct 2024 20:53:40 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed1a4fsm2885691a91.17.2024.10.15.20.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:53:40 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/8] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Wed, 16 Oct 2024 12:52:06 +0900
Message-ID: <20241016035214.2229-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016035214.2229-1-fujita.tomonori@gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
can be compared to determine whether a timeout is met or not.

Use the derive implements; we directly touch C's ktime_t rather than
using the C's accessors because more efficient and we already do in
the existing code (Ktime::sub).

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e3bb5e89f88d..4a7c6037c256 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -27,7 +27,7 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
 
 /// A Rust wrapper around a `ktime_t`.
 #[repr(transparent)]
-#[derive(Copy, Clone)]
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
 pub struct Ktime {
     inner: bindings::ktime_t,
 }
-- 
2.43.0


