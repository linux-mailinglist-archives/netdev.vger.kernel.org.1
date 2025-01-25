Return-Path: <netdev+bounces-160919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C0A1C2BA
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843D8168729
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F18207DE5;
	Sat, 25 Jan 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYAlhzo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430DD20767A;
	Sat, 25 Jan 2025 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800445; cv=none; b=HkEUk0vKJcGASr4ppkQj1UqJFzvvFEoY+XvDbTP074sC32zBImMJEHKqxI6W7u4wanPgIi5xyJCaB+mIISZSBUY5r/NCKub4DX/8w2lByyJrvhfgGuvjU/xW4C8+MhpLZb7YBjKkcpSlRTldP8CUCRWl++CUTR84oER4orl7wnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800445; c=relaxed/simple;
	bh=k+obMTJKWj1D4d5SWKV3Hm0ZQWUwCvZYP7hKNH2kr2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uv5DvaZKzsJ2145i+ChNHztIAyMETI7eMd3cJoFrsJZN8E7hhCK7KCatrgocq2Mk7Llo1pqgghWJpk1BWWedmIBgGuZzAbIMX2MsHD1J6T1WPwxJEaelaeBy4YHoJSr2/2jSG8lOGhsyiPe+Ni9dVf7/um4Mb0D0qpYhNe9FRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYAlhzo5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166022c5caso46590405ad.2;
        Sat, 25 Jan 2025 02:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737800443; x=1738405243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQVkyYAu0pwAzQ7e0HkaEcvOZiijzMM+hzluoVt+E5A=;
        b=RYAlhzo5SxnxWJ63bQfg52VBXLMPWx1733Nuh2eUUas0K/P3CdArcWV5gnprbDPoVU
         s7z6k0L9znyeNR1rCnb7K4JIVEESSZ3/6pSW1qci6a/RzKGzdgljMQQ6ohnsb8KKKP72
         wsfN8nINXm8IAHDHjWfUjtH7zeg0cbKMFhocSnUNX10WXq7XdilyfL+Fzhp0fcUsSXSl
         LZIPu/fcbJ+zgP0v4qcuNa0w6/xiAsCTrLTbqh1sy3PtvWQSFiVJhTPugNYJwt15s5Cf
         7HyyU8mSvVxasoY+clxgT0IoRUMMrsTksQFhlEU1U3XY9JtwO9CyjpKUVsuZn+LBNjDc
         jZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737800443; x=1738405243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQVkyYAu0pwAzQ7e0HkaEcvOZiijzMM+hzluoVt+E5A=;
        b=wVcswSN0PpUZDvPuldq5yByy4LLvlwYPbw6vMOiuyX/Ulg2TgFNlJZTwYKZ0fSGYLC
         3RmeHEp8bCZhP/LjZ0Lx5IRbMb6KibtoRDd1EjBd5g6DrNdQ/cpECBl4SUGVovzKpscE
         SVUwsc8qGAcGx/a1+rzQAxil5SRI0ZDpX8roql653Lw41Th3LgK7jLXqA9bDpqwcFYw3
         RjiMdWKDGk4slHVSlFoiUqGXHBA2CJJv+n8B/I5cyGOKaGwyp+5V3o2rXUCx6mEn3YvR
         X7PHMpjCfGMfunrXa/8FXXDkmscq0UEISXbn/rot3mKRywVdHFi95KMwOFGgeHDwtngp
         RZeA==
X-Forwarded-Encrypted: i=1; AJvYcCU3F2DB8apE5tQmAewdSIJKatlDN7c8F/2KUFrWNYco7x+ycU/n5Uls7Sx7HklFkpfGXoaDeI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSF0CoPuTqMNpZQBDYo0jh5ieu/iY4dzlO/nEtGBbKWfne6QBt
	MKg6t1JyydQdp/flWtDhz8oYovbqpzFooOiHk1e8La6R+a8eFSNmVABttR0t
X-Gm-Gg: ASbGncsrkDTKnUtDy5XQHdCmE9DvF3dl98KXLgKsB/SiyWhlYYmeI1RXN7JZa0OVPrN
	DnvmcNXSpC3KV0ZcuXvy44iicMMXsIshyEuauPVKdQ9xbiqos2RP393JAuxHzZDno1Vi7nv9+/L
	m0YaoPxtPskfJcWgvt+NWuB0s9z5J/z4LU50tnvY4FcfNBD6/J2EzeiGn/f6Um++WEveHK84ph4
	wKSdUhG89tYjrlxjbTXbfxDAVm58krnUBtIMmORXf6xJMSxQsYkPAMcIZZArCEU/SYwo/9nqlv5
	/PtAQzxX9u/hk5sK8LiQNvji4zovctDKGlhcZ1vwmETeIAGUdTW9c9Fj
X-Google-Smtp-Source: AGHT+IEi4aWAoxQaDbZWMe/Aw+49i/+LZnLUNflot7Bqnw+ULcXmCPJc+z7CHV3N/pRdsKlX6OunEA==
X-Received: by 2002:a17:902:f689:b0:215:acb3:3786 with SMTP id d9443c01a7336-21c35504c1cmr509533115ad.19.1737800443339;
        Sat, 25 Jan 2025 02:20:43 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f344sm29461155ad.232.2025.01.25.02.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:20:43 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
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
	tgunders@redhat.com
Subject: [PATCH v9 6/8] MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
Date: Sat, 25 Jan 2025 19:18:51 +0900
Message-ID: <20250125101854.112261-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250125101854.112261-1-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Rust TIMEKEEPING and TIMER abstractions to the maintainers entry
respectively.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e047e20fbd8..faa4081e9e76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10307,6 +10307,7 @@ F:	kernel/time/sleep_timeout.c
 F:	kernel/time/timer.c
 F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
+F:	rust/kernel/time/delay.rs
 F:	tools/testing/selftests/timers/
 
 HIGH-SPEED SCC DRIVER FOR AX.25
@@ -23741,6 +23742,7 @@ F:	kernel/time/timeconv.c
 F:	kernel/time/timecounter.c
 F:	kernel/time/timekeeping*
 F:	kernel/time/time_test.c
+F:	rust/kernel/time.rs
 F:	tools/testing/selftests/timers/
 
 TIPC NETWORK LAYER
-- 
2.43.0


