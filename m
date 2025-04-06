Return-Path: <netdev+bounces-179445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C448CA7CC72
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 03:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A997176678
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 01:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D13422087;
	Sun,  6 Apr 2025 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKQmWtN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5C6ADD;
	Sun,  6 Apr 2025 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743903319; cv=none; b=WGJA5OgCVi6/BaIJil5z+e7eNQA40sdIppF/NSDB1UP/ld5OBpazVStQzLYpmvT+NACVwVwMjZDLgaJtWED3NFzn82LUswHESFsTH1wMRt4ew/V3egaMh27BrmU6dS6dTFSkTmNnVvOYyVVJJrR7YOx5p+s2TS2sWZFhyuoQy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743903319; c=relaxed/simple;
	bh=q5vR44eIfRZEuiN9gUjuScPb2LpSVmHww2A7+Efe4c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1p6SPhyxaDqoIz1xdNZfimta1oq9a5YRWQ7CA++JK4ppLBkk1vsyZxsQ4GWMrJ8HN+DTsIlA8uJ6sGQdD8Ptqw0sne+HkObC1eymzLGUbhcofM08/H6NihVBfhzqWYmkGmfuJslHrYXZr0+VYyVppAghpqe15IBGZuJ4ebuJPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKQmWtN7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736c3e7b390so2866859b3a.2;
        Sat, 05 Apr 2025 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743903316; x=1744508116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+PCL2OUEh2hiTZatqVQoNxi6KO3hVe1igBRT0vir/Y=;
        b=jKQmWtN7FOFgjVjt4K7y8iaghI2n2lDEIaqKSpNgptIgRJ7LqiWLavv85Q3xeAWD/V
         Ro4ymoUP4UN4xJRaekew8ULEFrigaAC67z3eN4OfRreDkPSvAVmdEYWhJqVqIiz2Jcs1
         +9OXHBb/6mKpC6DgsbiMf1app9iF7wGEcKOeejZT8lVLTjQwH3jbJEjMXIFkRRb5J6s+
         yyl0UQl86xlb52CwsiaVrZajT9bTqOXZZVVu6U8EndO1QGYwlxp+K/j7fs3Qg/Zi5Hwi
         ibIwcoypWYGfsCNpTu0yexWd7f9e4Gp0xDx7ofr6Sicu+ongQldLyPPK/XovyOGoSVxA
         JzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743903316; x=1744508116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+PCL2OUEh2hiTZatqVQoNxi6KO3hVe1igBRT0vir/Y=;
        b=sSw1d7JeftRCxTJ9Ub29ECtgG1dBUsUaqo3gqCwOKOQkjG2NCCYxOzd9Zz3uQJi5tk
         aBUfyI0dWQcttK89k0Ewd6tQz7gb0L9kguvduFTN7pjoQ5gZKTOGlaa//pd6yT4xYq0y
         9rY9K7WHGgiUgdpJx0Kp50Nww4KYzDDsHzGQz5aXSFTR4EWzZCR32DEs//5Tg8joCIrT
         G/6bqjUJOGikVAPcaSzSAUqcu0uUZDzOxXiqakL8PEVltk5UJkMMatOPSRmwSYvbt5cA
         /NVjlc9UqLgyP1fSbcI0+b/3vT8M5gBjRDVrCSKR93Kx4hOVQyUVvHulZAl0oToDAz6R
         csAg==
X-Forwarded-Encrypted: i=1; AJvYcCVAkWA0xPjJbe5fuupzbhfk//bK3MeAscsYweLHlnh9eIB4DR1h2nGoIeQVo7gdMYlIoMm8YQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAH58xK7h8CAm1oye4qE9fBjtcb5qFHR4mB23iBvZtz7JIaB3K
	zSJ9N34SUoJpAmMpAheNolfILIhdD25+kSVrEhgRx9r9s0zf3Ojg1a6zDpZh
X-Gm-Gg: ASbGncsuZ08/E9OfVM8NXrivkCwEIpaWJ6Vu7a5TksGbHQci7bRkwuVOFgeuOgitjWg
	hRKzLjRqw6rgNpDEcuHuaaUE1fiNLua0t9USffd+dg4asl4KzTMorpUjVRC0rAX/LxwovVYnxVK
	tkZX7s36yzbgIVWNBLzPluBMjuK8W5c4SIgnMPdaMeT37Y8pld1/pb0cXfD1rVp6gl2gPAq66Uu
	CiJ33OGWI7SRsdxNCQ6FXwMJOarzsDCRPLktckwlCffmlz7YqH1HnmztMSDWO2G4EKKu3kcXJDC
	LJZNyfcq/25kwFGO0rQL030B4WMX1cI77Unf/nKNua3xEwubqHDwFSkWcUpyBLhwxDA2aJGSs9I
	1LN6XxVJTjGMFLqd+75n5aQ==
X-Google-Smtp-Source: AGHT+IF/BOq0AnchPDL5eAscTdh3DB/v6gk5itdPNX2t2u8wvsYyRd7cUAUVB7U4VbH0aq48CWsVWA==
X-Received: by 2002:a05:6a00:4646:b0:736:532b:7c10 with SMTP id d2e1a72fcca58-739e716242amr9688542b3a.21.1743903316314;
        Sat, 05 Apr 2025 18:35:16 -0700 (PDT)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0bc052sm5846849b3a.156.2025.04.05.18.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 18:35:15 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
	tgunders@redhat.com,
	me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: [PATCH v12 0/5] rust: Add IO polling
Date: Sun,  6 Apr 2025 10:34:40 +0900
Message-ID: <20250406013445.124688-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new types, Instant and Delta, which represent a specific point
in time and a span of time, respectively, with Rust version of
fsleep().

I dropped patches related with read_poll_timeout() in this version,
which we haven't reached agreement on yet. There are other potential
uses for the Instant and Delta types, so it's better to upstream them
first. Note that I haven't changed the subject to avoid confusion.

Unlike the old rust time branch, this adds a wrapper for fsleep()
instead of msleep(). fsleep() automatically chooses the best sleep
method based on a duration.

v12
- drop #1, #6, and #7 patches, which we haven't reached agreement on yet
- adjust hrtimer code to use Instance for the removal of Ktime
v11: https://lore.kernel.org/lkml/20250220070611.214262-1-fujita.tomonori@gmail.com/
- use file_len arg name in __might_resched_precision() instead of len for clarity
- remove unnecessary strlen in __might_resched(); just use a large value for the precision
- add more doc and example for read_poll_timeout()
- fix read_poll_timeout() to call __might_sleep() only with CONFIG_DEBUG_ATOMIC_SLEEP enabled
- call might_sleep() instead of __might_sleep() in read_poll_timeout() to match the C version
- Add new sections for the abstractions in MAINTAINERS instead of adding rust files to the existing sections
v10: https://lore.kernel.org/lkml/20250207132623.168854-1-fujita.tomonori@gmail.com/
- rebased on rust-next
- use Option type for timeout argument for read_poll_timeout()
- remove obsoleted comment on read_poll_timeout()
v9: https://lore.kernel.org/lkml/20250125101854.112261-1-fujita.tomonori@gmail.com/
- make the might_sleep() changes into as a separate patch
- add as_millis() method to Delta for Binder driver
- make Delta's as_*() methods const (useful in some use cases)
- add Delta::ZERO const; used in fsleep()
- fix typos
- use intra-doc links
- place the #[inline] marker before the documentation
- remove Instant's from_raw() method
- add Invariants to Instant type
- improve Delta's methods documents
- fix fsleep() SAFETY comment
- improve fsleep() documents
- lift T:Copy restriction in read_poll_timeout()
- use MutFn for Cond in read_poll_timeout() instead of Fn
- fix might_sleep() call in read_poll_timeout()
- simplify read_poll_timeout() logic
v8: https://lore.kernel.org/lkml/20250116044100.80679-1-fujita.tomonori@gmail.com/
- fix compile warnings
v7: https://lore.kernel.org/lkml/20241220061853.2782878-1-fujita.tomonori@gmail.com/
- rebased on rust-next
- use crate::ffi instead of core::ffi
v6: https://lore.kernel.org/lkml/20241114070234.116329-1-fujita.tomonori@gmail.com/
- use super::Delta in delay.rs
- improve the comments
- add Delta's is_negative() method
- rename processor.rs to cpu.rs for cpu_relax()
- add __might_sleep_precision() taking pointer to a string with the length
- implement read_poll_timeout as normal function instead of macro
v5: https://lore.kernel.org/lkml/20241101010121.69221-1-fujita.tomonori@gmail.com/
- set the range of Delta for fsleep function
- update comments
v4: https://lore.kernel.org/lkml/20241025033118.44452-1-fujita.tomonori@gmail.com/
- rebase on the tip tree's timers/core
- add Instant instead of using Ktime
- remove unused basic methods
- add Delta as_micros_ceil method
- use const fn for Delta from_* methods
- add more comments based on the feedback
- add a safe wrapper for cpu_relax()
- add __might_sleep() macro
v3: https://lore.kernel.org/lkml/20241016035214.2229-1-fujita.tomonori@gmail.com/
- Update time::Delta methods (use i64 for everything)
- Fix read_poll_timeout to show the proper debug info (file and line)
- Move fsleep to rust/kernel/time/delay.rs
- Round up delta for fsleep
- Access directly ktime_t instead of using ktime APIs
- Add Eq and Ord with PartialEq and PartialOrd
v2: https://lore.kernel.org/lkml/20241005122531.20298-1-fujita.tomonori@gmail.com/
- Introduce time::Delta instead of core::time::Duration
- Add some trait to Ktime for calculating timeout
- Use read_poll_timeout in QT2025 driver instead of using fsleep directly
v1: https://lore.kernel.org/netdev/20241001112512.4861-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (5):
  rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
  rust: time: Introduce Delta type
  rust: time: Introduce Instant type
  rust: time: Add wrapper for fsleep() function
  MAINTAINERS: rust: Add a new section for all of the time stuff

 MAINTAINERS                         |  11 +-
 rust/helpers/helpers.c              |   1 +
 rust/helpers/time.c                 |   8 ++
 rust/kernel/time.rs                 | 165 ++++++++++++++++++++++------
 rust/kernel/time/delay.rs           |  49 +++++++++
 rust/kernel/time/hrtimer.rs         |  14 +--
 rust/kernel/time/hrtimer/arc.rs     |   4 +-
 rust/kernel/time/hrtimer/pin.rs     |   4 +-
 rust/kernel/time/hrtimer/pin_mut.rs |   4 +-
 rust/kernel/time/hrtimer/tbox.rs    |   4 +-
 10 files changed, 210 insertions(+), 54 deletions(-)
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/time/delay.rs


base-commit: a2cc6ff5ec8f91bc463fd3b0c26b61166a07eb11
-- 
2.43.0


