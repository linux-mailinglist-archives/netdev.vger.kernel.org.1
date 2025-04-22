Return-Path: <netdev+bounces-184685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01891A96D92
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788E5188DAA1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA8E284B5B;
	Tue, 22 Apr 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M222v9/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2F284B4E;
	Tue, 22 Apr 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330121; cv=none; b=h/cAtnk2Up4EsKoEmHewNWym1f7QvC5o0hGnHbDtLo1jt8el86O8gopyLboecaJM4YnPHVsCq511xagbA9Kbxx0yRECAfVmFEZv5Z624he8opfXUZrvACcHyAE736rO9oID+yVjw8e3wjLMc61Qu6ii3hw1iJo8PU7sfAroLSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330121; c=relaxed/simple;
	bh=4ZdUq2tzBznByojYCi0WA8cKaEHmxfVFiiY35QjqGeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSb1Thu7wkzW4jsrgFDFrJ+jAdkYcpRdLyGXfafrRsJhLwQsLB5hxGCK99dWPqbffj5HlHrnD1LGJgd5k7frRGESMU9rsQrfMOwquDziCYs19GeYF0NvN7EiOt9fzhChU93IobLbZZoTMvIT37uMBVX9TRkLWtCy2p2rebq6sD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M222v9/Y; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so5353479b3a.1;
        Tue, 22 Apr 2025 06:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745330119; x=1745934919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBIIB+/ZmIi8Tc2LcqXAgRSWZd60kP7sw7lnOaM4f9M=;
        b=M222v9/YpypTSDx+YuemhRKLRo9D2AHuFFgZjpLUa1HrdzBkw4w+CvEFUlmSZr7pzT
         ePKldol6KHxXZhAEQD17RrhIUlaqfvQ+pViITiUDodiB+zXz1UmE9HLu5OjxBixCwWDZ
         oBOqx4xiZ3tesjTr1pPTpZt3QG8Lms8Lpdy6NepUPwz3zIXL+c+jNFg4FqErLokDv6XN
         yIyC5qWGPUiWtnSXWqDm/nNiV32Heg/zNJqnIty3QMr6tDOShvhQswM0A94xVd7+iXky
         s+pvz4LzWIHNl1F+qv1n22bmw5134/sMuDcnl/H11mwVcSeMJM5Mc2SXmzTQCX5qWA6b
         33YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330119; x=1745934919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBIIB+/ZmIi8Tc2LcqXAgRSWZd60kP7sw7lnOaM4f9M=;
        b=pXOKS9EmFaa9u9NX5+PNa8C/8PIUgG36fSftaQOdNJHgMQZOviA+iD+gXllX37iISh
         k5rdLrm0oUq7QCpMwCLAzYqrnr0Te7Mo5262T020gKJ9/JUzzkiArHDytozOEvwtDc6B
         4Q2Mmbs1m3f/I4BMsAEc/r7ld0IfAfj6W0VMB+CJquBzrV5O5ughpy9kdRKqeBo63Mv4
         aN4Pkqma2BBZrdXi2DsId0PxX9AX1XFDK1tTuRzAw0KwFCMGtO07OjjE0NRUmSUakXCb
         Z6Sh9ZBQv2ErEZqamsmWgS7Zi4HdvUFAEJy4M7/Z3dqtNguwiZ2ukypd6lP5vSh1aP/l
         osZg==
X-Forwarded-Encrypted: i=1; AJvYcCWyOSkC6ui/JizXwXiZ0Vh0cK6vgB9/dLq8lImAwqyxGk/wJCyHUFU4P5sxAC7Yd3hLPpzpFm5Iy/Vz/OA=@vger.kernel.org, AJvYcCX22kE82LHbewROMtwiebOOfJPVUUU2xwl4GJFHsLkxFvpswLCshHG2o89j8nBHx+C5o3jvBYTu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz32TsW0NxgI9Vh49AO2saZbS+bslOOo+02W1A+cOiv6L8E/zgV
	cEGnRnQbXgqYtm2b6HjPzCxw0sgSLf1M+wgifeqJOOidQPQ+2XaQ0UgQksQ3
X-Gm-Gg: ASbGncup8nqUVu2NpRgD2yIbIuZ/J8Fx8sYW49a7MTTKnK2phtEaeIe8v2PObSqj52H
	t4E9Zd3JxP7lNZMF2jtA3tTQNvPfjxFzrkisyfasmJvVOBVKR7F6j/hQVHgc9Ndvz3hPmjq+m//
	cRa7X78fJQYHp/YzWCG/leYkTo4XKK5lcAJAR/FRWWE/5i/OSLDPEzfUWSVhcf8uoWsJryxNIw3
	5gPfyaHjKJguAjkR7nRukSgyI8PGk5hscJ4TJQU7X+3XxOZ549LKO8qHQXbOAJCPg1Ey/jor/t0
	zXppzVSzbJWb/vHmq6aGtUnftsgwF8grIcP3WuJQ8l04rHYmtlY+w8TgOSjBSTM5bNt1mdFaTHZ
	kjIGiDNUWBmbn/pt/h/Ex6t83eoeQ
X-Google-Smtp-Source: AGHT+IFXRrARe8B8erEVjY0bsIsDRjykaQmH3G9PNmeJ+0cdtHJdHSfeGFZ8jml40/4gPtVqgjgFug==
X-Received: by 2002:a05:6a00:1305:b0:736:42a8:a742 with SMTP id d2e1a72fcca58-73dc14ccd73mr20406967b3a.11.1745330119578;
        Tue, 22 Apr 2025 06:55:19 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaaba76sm8869650b3a.143.2025.04.22.06.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:55:19 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
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
	me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: [PATCH v14 6/6] MAINTAINERS: rust: Add a new section for all of the time stuff
Date: Tue, 22 Apr 2025 22:53:35 +0900
Message-ID: <20250422135336.194579-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422135336.194579-1-fujita.tomonori@gmail.com>
References: <20250422135336.194579-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new section for all of the time stuff to MAINTAINERS file, with
the existing hrtimer entry fold.

Acked-by: John Stultz <jstultz@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c59316109e3f..3072c0f8ec0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10585,20 +10585,23 @@ F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
 F:	tools/testing/selftests/timers/
 
-HIGH-RESOLUTION TIMERS [RUST]
+DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
 M:	Andreas Hindborg <a.hindborg@kernel.org>
 R:	Boqun Feng <boqun.feng@gmail.com>
+R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
 R:	Frederic Weisbecker <frederic@kernel.org>
 R:	Lyude Paul <lyude@redhat.com>
 R:	Thomas Gleixner <tglx@linutronix.de>
 R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
+R:	John Stultz <jstultz@google.com>
+R:	Stephen Boyd <sboyd@kernel.org>
 L:	rust-for-linux@vger.kernel.org
 S:	Supported
 W:	https://rust-for-linux.com
 B:	https://github.com/Rust-for-Linux/linux/issues
-T:	git https://github.com/Rust-for-Linux/linux.git hrtimer-next
-F:	rust/kernel/time/hrtimer.rs
-F:	rust/kernel/time/hrtimer/
+T:	git https://github.com/Rust-for-Linux/linux.git rust-timekeeping-next
+F:	rust/kernel/time.rs
+F:	rust/kernel/time/
 
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
-- 
2.43.0


