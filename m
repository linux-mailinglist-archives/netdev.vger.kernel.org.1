Return-Path: <netdev+bounces-167996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C50A3D1CC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758EC176406
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62EC1E4929;
	Thu, 20 Feb 2025 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWwa+n/a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D51E3DEF;
	Thu, 20 Feb 2025 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035414; cv=none; b=prwefrQUvQOZPhZfNYFiy35FFzCIeC3ynx887k5Q0rRViNk7fPqh2JhvZ8epM4yJjVFA37rxQ4oAMQm4FhFb+lOtJ95ib1o8ELkHImpwBRyig7GDHo9PlKW3pOT99Sp/bPd/tWku5k7eBCIT/4skTP/Czzi9d0P8n5cZNQw1OdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035414; c=relaxed/simple;
	bh=eRPAElEUQRhTF2bycVJ8zY1sUK27uy0WvVugrYviEas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOvKR0fdGtdDlolZ3TQMCre1yvtLA8hOPHfWmGPtFd7fG9LLAoy21sOJY4mUuYilCZnLPJ4Q+0+SU1ZWATd3Q8iNDVNAgC92Z/avjxoJt1PiAQUCIE44jYVMfUlBoGcCWNE0DE3orMqx8fBbXB4lOV67NYGt0cXHKv30mcKhDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWwa+n/a; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220d39a5627so8449595ad.1;
        Wed, 19 Feb 2025 23:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740035412; x=1740640212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvmhmxQBJd3Pxct/LB/6igLYaJZhPSkR0ZLw5XhDmV4=;
        b=aWwa+n/avtzYmWBQZYAHMbBGBVjafvy++hrg+iZbtXwSqlDSY4DU8efj/QgrxT1dIG
         ec8TisbEB5sc57Kumv+0R/lEQk8o0eShO9/SIvqwPzDkGGC9YsLvvOa5lQ0M98aj+NYd
         +fmwZ8q5n1sMVlztSTJEKq7dZ/Mls1P09T+esFmJDwCvbZ4Eho+i8lKBDfY8b+/Tvc8z
         O1PzA6QGjOLCF/UizEAAtqzJKwMMdGqjb5vcX54svl4ZjSILLoCXDCe3tDoRpjc8QzO9
         kvk+by1gwAotBRjs0nbjiM4PfXZNIyX373bd3kshKBf6FzvajxrC6XT6qubZJKa3AQ+u
         caDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035412; x=1740640212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvmhmxQBJd3Pxct/LB/6igLYaJZhPSkR0ZLw5XhDmV4=;
        b=Y9EKBfh9EKhelvO2k+U2WBEkUV1zD2zKFnUFba6jv0ENZGKebdHvp1lj6shUZN2aQu
         1wlZRChDJAdqI+wtS/LYuQ9QEPk6QoVelcwa+ED4crdVsdeR7X1Kp/uvPoXDQ9N7YTla
         G9cp38Ya4nE7FZSksabD2HlyocDB+QfqscLaSujDX7C//bRuYtKWtxRv74T2oNPZPuLS
         2aIcW/neGcC9dRa7L/0cB54PC5yF0vrFBNLiX1a355403JZj2klcxrx8URYtAEVLntav
         vi+AWYluNGV+6LEPK0U6RaNiWoiK1W9tzGDT8lPeLwUnJPn7jnQaLvA4FWuK1w93wyIJ
         12rg==
X-Forwarded-Encrypted: i=1; AJvYcCUWnAzyrwedDIpKxvFmXKGVyBs8K5OiNtM/taWtCFQLMYTQ5DZaZDTI1aoMPviN92url75X4nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNoyDzS4z4j5tAxumORXh2q/dqzYDm3C542vsKLGDzLC5OrX78
	uGs+kbFbfYy+pScVpBjA6ZUnM/uV3KFwJqmFEd3//eBddzEqHszCBC6a6ZkK
X-Gm-Gg: ASbGnctcSTSAE9PFofzD6FiznYJ9D0ZQ8iU3/s45vRpaTY+DEIVNXzdYIWRnjaXdBTd
	oC+BPU4MnQ9Tb8/i4dQ8SZUhMwEz2BZpJwORTEPiKdcQCeiCwQObMZzXLUdS+wsK+wzmQG+doCz
	iBbmv11fjEZHqiwGLR6NnQwXOemb4Wp4K1O7E887WJHyGl5Fr9AQOjmpIM2LQpaZXLXHHVwZy0o
	FcKgq1QwdQ0yXzZ34AFhvyLr6WOFpIY21MdnR2nDtK7P5OJhWjMttBSNF/5o8JKz7UB2JPs93E4
	w4kIHuhmXT+P4IcP62u0b6jDC8WHQAO/EPZ9s+0scr7xaA7B7yNzSjW3iGXUBxp7qqA=
X-Google-Smtp-Source: AGHT+IHSiFTWo7GVfctdCwosRMbmchdXoEfhP3nrqjscH3dzq+e9S7RJpTceJFyt6pD8yDn0HAVk9A==
X-Received: by 2002:a05:6a00:2da0:b0:730:1da:d0e with SMTP id d2e1a72fcca58-7341734ee72mr2402726b3a.18.1740035411544;
        Wed, 19 Feb 2025 23:10:11 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm13059672b3a.48.2025.02.19.23.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:10:11 -0800 (PST)
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
	tgunders@redhat.com,
	me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: [PATCH v11 0/8] rust: Add IO polling
Date: Thu, 20 Feb 2025 16:06:02 +0900
Message-ID: <20250220070611.214262-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to poll periodically until a condition is met or
a timeout is reached. By using the function, the 8th patch fixes
QT2025 PHY driver to sleep until the hardware becomes ready.

The first patch is for sched/core, which adds
__might_sleep_precision(), rust friendly version of __might_sleep(),
which takes a pointer to a string with the length instead of a
null-terminated string. Rust's core::panic::Location::file(), which
gives the file name of a caller, doesn't provide a null-terminated
string. __might_sleep_precision() uses a precision specifier in the
printk format, which specifies the length of a string; a string
doesn't need to be a null-terminated.

The remaining patches are for the Rust portion and updates to the
MAINTAINERS file.

This introduces two new types, Instant and Delta, which represent a
specific point in time and a span of time, respectively.

Unlike the old rust branch, This adds a wrapper for fsleep() instead
of msleep(). fsleep() automatically chooses the best sleep method
based on a duration.

[1]: https://github.com/rust-lang/libs-team/issues/466

v11
- use file_len arg name in __might_resched_precision() instead of len for clarity
- remove unnecessary strlen in __might_resched(); just use a large value for the precision
- add more doc and example for read_poll_timeout()
- fix read_poll_timeout() to call __might_sleep() only with CONFIG_DEBUG_ATOMIC_SLEEP enabled
- call might_sleep() instead of __might_sleep() in read_poll_timeout() to match the C version
- Add new sections for the abstractions in MAINTAINERS instead of adding rust files to the existing sections
v10: https://lore.kernel.org/netdev/20250207132623.168854-1-fujita.tomonori@gmail.com/
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

FUJITA Tomonori (8):
  sched/core: Add __might_sleep_precision()
  rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
  rust: time: Introduce Delta type
  rust: time: Introduce Instant type
  rust: time: Add wrapper for fsleep() function
  MAINTAINERS: rust: Add new sections for DELAY/SLEEP and TIMEKEEPING
    API
  rust: Add read_poll_timeout functions
  net: phy: qt2025: Wait until PHY becomes ready

 MAINTAINERS               |  14 ++++
 drivers/net/phy/qt2025.rs |  10 ++-
 include/linux/kernel.h    |   2 +
 kernel/sched/core.c       |  61 +++++++++------
 rust/helpers/helpers.c    |   2 +
 rust/helpers/kernel.c     |  18 +++++
 rust/helpers/time.c       |   8 ++
 rust/kernel/cpu.rs        |  13 ++++
 rust/kernel/error.rs      |   1 +
 rust/kernel/io.rs         |   2 +
 rust/kernel/io/poll.rs    | 120 +++++++++++++++++++++++++++++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/time.rs       | 155 ++++++++++++++++++++++++++++++--------
 rust/kernel/time/delay.rs |  49 ++++++++++++
 14 files changed, 402 insertions(+), 54 deletions(-)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/time/delay.rs


base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
-- 
2.43.0


