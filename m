Return-Path: <netdev+bounces-181959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1574A871A5
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 12:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333C73ACE8F
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 10:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA54F1A3164;
	Sun, 13 Apr 2025 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxkzz6TF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240611A3161;
	Sun, 13 Apr 2025 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744541029; cv=none; b=NlOImYxhn3fzE/qJLOzQ6vBVLMEabZ0IjX63FO/8YhqkXFeguL37JiaEac/0m5vy9SGHxZta9AV5iLrLctPXp3TBFHr9f93FU1xc8WfWKzV3qoBP3nKQNkb9HDoHHgv+BzxxJKw/36FSK2Q3mCDav0LyJwhkv8AHohRG3bHJCUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744541029; c=relaxed/simple;
	bh=kd3vW/wW1gabeQG7Fy0PVk4IKsLzJY/aNs7T6WdurXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xsf7F/ehyqhZBxK1o3eHriaUsqQKo2cbzilxGrRCJBRG9LhTJJYy0cbplm06Kn1yubuokT75viEZZNvg91AxGUH3jUXqkCB+69H8Eau+clE3UF8xI5tj9nCjG9ep07d6MoYXdvQjeeEJDWzCyporaqmQLI7UiyqhPLHGUh5EeAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxkzz6TF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af5cdf4a2f8so2523028a12.3;
        Sun, 13 Apr 2025 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744541027; x=1745145827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA/MmqYliLwWhi3o92n3t+JslJEn4NlsVVnjQQ5ihp8=;
        b=Hxkzz6TFo6gvkivfe3NiQ4KquZsJQiYUXxzZu5//t+7AeF90KZ9lwyURQ72AZn9SWl
         zDEa5srn80bcME8BiAv34LVkzeBZP2ljITbieOXkPND1/r4BzAH2+UtLj1cMwp0ch/dv
         YD1TBx5EkV6tilXmIkkj98AFkGR3urD2xGpStA82tIm6f+SPjRoI8p5da69urqZIxGOQ
         bTNTEQ8k3R8V4YXzQiH31VWalQwpahzIGIzyIpiuGyBNKYYd6NYR/pnpYZZSw2HbhqYS
         rZMDjfHl9zJYNqq6bnf1UBr0f1Xfbo/zBRIDee94FV7JoiiPthH2qqVlZXsL2wc487pc
         H2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744541027; x=1745145827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA/MmqYliLwWhi3o92n3t+JslJEn4NlsVVnjQQ5ihp8=;
        b=imvBjrhRBk2cgsfQr44l+Z03aLb4+91TxqkTvufXEanBWizHR8jRf3VgXTJn4sdpVw
         qGXIl98Ez3GZuIqzuxUbtIQVk2DDBC/xI45zfcobMSBP4q93Y/P+8WXdhxVDehd5fQ5K
         zGEAOJj5Aw5NM1HRbD4R4rL8WjmCebUGBbY+Y67bQQMrYC378R2YhsMuJundPcNNDvZg
         Sq/1eFKUvVF0trqX6LVccI090TNrDxyRf2mskWd6Lt6Vi/C78f0vTEptZtSK35p0xPJ+
         S0FqY36pKbjOTdneSGjbZy0APYZ85ULGe1sAxC7FeeJHMsNmPoi+i2TKTTnzgZTZQ+Yo
         d9lA==
X-Forwarded-Encrypted: i=1; AJvYcCX12Ck6Km2weUy4Ve0CPNCS9m3Xw9ThQn59KU9PQ2H3Q+zCFD2xpzC8UIGhA6hCGNzhZ/qcf+U8@vger.kernel.org, AJvYcCX7bEcNvz7QEeMA7dq4jm5z0/hsv+zl/zemDY1i3NATjx7ZSVK5K1iD+JVAxC3wjPqYB7UiqSr7JBQAaHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/P17JFWSwSV9vwoWJG/yAxQ4YXIXmbz9FWCYvX2QYo9/3ShqK
	Ns+0MDk1n+0wCFAacabsvfGLwQiEsfYgWfNMvAH/VkP/w99vCt/Kg7ofDMz6
X-Gm-Gg: ASbGncuV+RNdX9CYAemP/QgGOnauCa7PIFrqI7+8d9HTKyEvizpuhABPgoqiImJl6mL
	XVhajkC7ce6F/SHggXDK9wE+BHAn2ZF8mabUHH5loOgqIoUwQd2ACmHZ6MNxv1y1KSADGHtFV+6
	KGAL8DihrMYNKyBzbMSPe+v2gbPZnnf8dO7Cez7iGMrD36JOcucDiU/HijoubQK0W9f/dtapsoV
	526xA44QN3qNAmlZO9TnNeBcgd7wlPAKi2Z3tEtXE1q2DTgZrb42Q+6i8KuIHrd5vGLdtvRBLoV
	wJXZSipOqt7PHV01BAUHmwG3KlCxtn0bcKV5DO/KTXodfe74iJcgUdlmHAHejxwm7ubzI1OHwm2
	ddYobDT635NvwWWmTnqVaro7NSFhK
X-Google-Smtp-Source: AGHT+IGRkR4EaVgat4SBKAiC1GXIfoLQhYI6osVfl/nEhYCqGaHVV2NMBlqKKbIQY7b+ds5ZQ2BCzw==
X-Received: by 2002:a17:902:cccd:b0:224:910:23f6 with SMTP id d9443c01a7336-22bea4fcc8dmr133509105ad.45.1744541026919;
        Sun, 13 Apr 2025 03:43:46 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8af56sm80160885ad.66.2025.04.13.03.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 03:43:46 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Trevor Gross <tmgross@umich.edu>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Fiona Behrens <me@kloenk.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tgunders@redhat.com,
	david.laight.linux@gmail.com
Subject: [PATCH v13 1/5] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Sun, 13 Apr 2025 19:43:06 +0900
Message-ID: <20250413104310.162045-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250413104310.162045-1-fujita.tomonori@gmail.com>
References: <20250413104310.162045-1-fujita.tomonori@gmail.com>
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
using the C's accessors because it is more efficient and we already do
in the existing code (Ktime::sub).

Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index f509cb0eb71e..9d57e8a5552a 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -29,7 +29,7 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
 
 /// A Rust wrapper around a `ktime_t`.
 #[repr(transparent)]
-#[derive(Copy, Clone)]
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
 pub struct Ktime {
     inner: bindings::ktime_t,
 }
-- 
2.43.0


