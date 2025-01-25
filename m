Return-Path: <netdev+bounces-160913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B910A1C2AE
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F326C188A382
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E311E7C05;
	Sat, 25 Jan 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bihp882b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6742713C9B3;
	Sat, 25 Jan 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800401; cv=none; b=iK/SfXfGsLA6ONfA8HytuZwlYOPWI0K17iKQS+W9tjkczPE6LFjbofSNxpQXQaJ36jiHA9bC+ts24Hja/VTaCUlUnTysIW5kHpjsiREIXyboBv2R1RJp6+hEEy9TALRipHsZLBSH71QjvV7jm08zkmdSgWNYY3Q4nMnRvhBhwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800401; c=relaxed/simple;
	bh=+Eqz8L6iwIeAyxYthbcPbOT5pObjT7nu0hB5ptFKY0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/gohiS4XooKZJ3RP09gU8Xq555mo3V9Th0AGaxVKvdtGe5vfybfmdBs8kA/ZPgrd6TmokE92ZE7wZR/2a3muOYOtCHhNn08LUoh8hNiqpcMVL2L51D3ZGnyvFSOU+8d2dN1B09zsL+zqU+FOcv/m3X5P4YjnTWFTvTYWu+rC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bihp882b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21634338cfdso68547355ad.2;
        Sat, 25 Jan 2025 02:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737800398; x=1738405198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73BfxK5YKRtfcVc8VvAhkoeewKfj+fcn/o7LMwtUNOU=;
        b=Bihp882bEig1ETYSuTdSmIHmj8ZIK9mE7OAXNzoUiQm5CitFDFDXyHFFl0COVyqjll
         7jvhUj2Ag6NyZ+3ZVUWyLS11yvMxQmyBFWhK9C2z2cb3+EAhkPUUMpTxrLuoRIN8Ijae
         erRaUPf/QBmpMQ/jWLizVztz4UO0GMqkf6LNZruuO7TdWXipUGmQEGUJWgLE8dMCVO/M
         CmGqIvU0Y7p3pE+fgP6REvv5figVDDin8/Dg/cJ2F/V/MkILAONQ/10SfNvbsuq0ECB0
         MujbXtaZlM+53UhFwZ80zjNizSOE4t0nVYDz9S47E9v+p/NfIJRdyZ4GFImqeuE2ViSR
         Zbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737800398; x=1738405198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73BfxK5YKRtfcVc8VvAhkoeewKfj+fcn/o7LMwtUNOU=;
        b=wIfhq4OFmKKixfSXOx+fFpNBq/ZOX52yFKeM6yUE+AdgCF0cC92246wybSZbAHXlh1
         1KlO+7QkTqaYPdHgQ4aDgS6u1yNFmrgZGLWYxHoazrNGtm7+k8FRBKb81fjYo08/lTfC
         Hq7GDTSm2XJ1pGp9eB9/8np5TxTtXO+7BIzoyg9sUxBa5K9vFQsa1PkyjjnNjZkmqsJF
         TBgwLir6Kv2VtgoRrQgOpEf65prke9yKohA6ZTQyRrIRYxFsFj4bzbitCm3qx5Ryhvvc
         omxnhjUOFcFuKeO5vBHyGHtRNDy7UU/I9i0Vqqmt2HGOOZwOImdATdjbZASbRvqEQK4S
         w3mg==
X-Forwarded-Encrypted: i=1; AJvYcCVpq1IySjXwdou2ON1T2MH4KaXYcV/LKHBh+drEbisBNWQSyab0bowZ2lkXkJxXJlTprobkp+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK62CHqie+mggBTguZmlWAK9CZlFLeDB4EhUStWIl4d9eC7/Hm
	cEF0RStx2Z1sxrDxnyKExRlc16gQfhhmXfNR5jmIAoaGemsOn4vSEDgYAYcF
X-Gm-Gg: ASbGnctEMN0TFyZ1C5RVas40rw3LIzJAe/BjmEaZBn0VDbJ9D8nLPrcolyo+sugNBpT
	oEYZ+bz6/Ve5ltEOBw5twueYpe3y5QdzdDu/zV/9LYH/Lp8V0WQiE0WjsAPcKLY0fyaovUtDTy9
	WJLYEFKf+lDELbpSRSlT/cxOFS4XHrkBbCTkNcJ/9xl3TFsUTEmmnfIcaX4exf3tzBiT72urO6e
	OFN9ynYNi6MAcEvv8ztsLJaVYh1LdbisaqbBIhQIpSc2Xs/q8J5wddyQzxiKr3Qol0gcjLpIXZB
	JYWWSNlgjZKchvIogyA4vqQte3RGSTv9JLoiI8pFtL9Jzcbpg3e+V8fn
X-Google-Smtp-Source: AGHT+IEOkL1TByT4k5PujkBvwmwoHO3aD8gEfGXh7T2u5Gg9Phn99fmxvrAOewfGAL3LwMIxH9ntKA==
X-Received: by 2002:a17:902:ec90:b0:216:3dc0:c8ab with SMTP id d9443c01a7336-21c3553b527mr458114665ad.9.1737800398321;
        Sat, 25 Jan 2025 02:19:58 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f344sm29461155ad.232.2025.01.25.02.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:19:57 -0800 (PST)
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
Subject: [PATCH v9 0/8] rust: Add IO polling
Date: Sat, 25 Jan 2025 19:18:45 +0900
Message-ID: <20250125101854.112261-1-fujita.tomonori@gmail.com>
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

The remaining patches are for the Rust side.

This introduces two new types, Instant and Delta, which represent a
specific point in time and a span of time, respectively.

Unlike the old rust branch, This adds a wrapper for fsleep() instead
of msleep(). fsleep() automatically chooses the best sleep method
based on a duration.

[1]: https://github.com/rust-lang/libs-team/issues/466

v9:
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
  sched: Add __might_sleep_precision()
  rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
  rust: time: Introduce Delta type
  rust: time: Introduce Instant type
  rust: time: Add wrapper for fsleep() function
  MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
  rust: Add read_poll_timeout functions
  net: phy: qt2025: Wait until PHY becomes ready

 MAINTAINERS               |   2 +
 drivers/net/phy/qt2025.rs |  10 ++-
 include/linux/kernel.h    |   2 +
 kernel/sched/core.c       |  55 ++++++++------
 rust/helpers/helpers.c    |   2 +
 rust/helpers/kernel.c     |  13 ++++
 rust/helpers/time.c       |   8 ++
 rust/kernel/cpu.rs        |  13 ++++
 rust/kernel/error.rs      |   1 +
 rust/kernel/io.rs         |   5 ++
 rust/kernel/io/poll.rs    |  79 +++++++++++++++++++
 rust/kernel/lib.rs        |   2 +
 rust/kernel/time.rs       | 155 ++++++++++++++++++++++++++++++--------
 rust/kernel/time/delay.rs |  49 ++++++++++++
 14 files changed, 342 insertions(+), 54 deletions(-)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/time/delay.rs


base-commit: 606489dbfa979dce53797f24840c512d0e7510f9
-- 
2.43.0


