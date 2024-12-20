Return-Path: <netdev+bounces-153594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A499F8C96
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD3E1896C0C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310F719D06A;
	Fri, 20 Dec 2024 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5Sd47Xh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801A19D88B;
	Fri, 20 Dec 2024 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675661; cv=none; b=ICxfSWUUfbBnSzvcGubS16mVvD46CukG321ER2gqiSZEZ8AqVbpqFv3RC7nbv/lmFIttOLVZWMS55hdQICItepaVTtWx0V3Y4Emfcxc81t2zxONLhCHxIH0H67DrbStcNiMXnoHgVQWL3XjAeyEp1cg31Nyv0jtQ2FExlvV6tRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675661; c=relaxed/simple;
	bh=bMso3DHfsWBN0gDBTq+K2KopRQ7F5J1XtcvYTrPrpIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRw9wHTBHfo6kzcui383P78+0aFtPdBxEovvlZMYWJmYXv41rDDPWkK5+uHGaavsF/WKBAHavB8WYC250lLEnVM9xQbUH0nMwnMjvlO+bgerc4jFDbTvoHT28iKpp/TPIEPJqThlZC+M8Vf/XwX4cndgxLc38FNB8m1y5wgJJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5Sd47Xh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd4998b0dbso1233106a12.0;
        Thu, 19 Dec 2024 22:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734675658; x=1735280458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Olb0QLGj+RCh4kd80efX/TZFFIjD27aCKDh0v0M6XD8=;
        b=j5Sd47XhZOTxkN5tv1jqghLiU0APJcWlKpxzYtoIsssPWUe/Pg75jmpa3RttOs2wgv
         djwZrnQABk/CBUaS2i3W0bDl9nizXRnBpc9iR/bhDgRRcAD51O7tj3Xqr1i5NCai/cCk
         yIQsYrMQqoB1EEDj0Cs4i/JpykIVzaY19F4uaoLDRpaig+c5OgC1BvqDq7DgMrAbonMF
         vO4xjp+REPP9afb7sPX7CGcdRZf/wGtbIIoJhPznHvoiueTeB1ynf3MvDz0b/lWFn2Ez
         TJhg0a5NxMQy1m0hOEG29KD2bv3rc82EApXbyUwkFylOfuvT8uGCKqvYQw2O3tTT+4Xz
         iWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734675658; x=1735280458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Olb0QLGj+RCh4kd80efX/TZFFIjD27aCKDh0v0M6XD8=;
        b=asRIVToXOylZlJZbqC3tGeyUgixk7yypaGaW3EULFDTWfW6Agd1Lp2JeHjeJOzGnr8
         Uaohh3xuFp1McSUzi3EOZHrFr6JUw/rR7TOCyDVRzTykGMjdsp90L40ZShxMGZyWK8hu
         LAwDH6/Rnnhgvmh8C1XroKfb6XEx2BfT6hb1acb0lSTsosteQINR69CxMLFpUmTXdeq5
         D7Vk+ZC+3pjZq535B7/DaG5MOuWkq1Zps5sMgWCBDzCO9ErMy1KbpDY4ofUOhelfVp9p
         pMCUhOVSE1m4hWG9uwtwxKoVJz8F6Ob7J4Wu/rXFjeu21EbNey+RAb+gj7Ka/7cZ36QV
         jCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyDWi4dPYsu33XwTxkQR6czvYlJALxq47BzFSKYV/N7qQZ1nWKSJImIl4Stsv1/cft2LL987I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cW5LEJxFm2UUryGtkvc+ryJVmVlsom2UI4iwZA/F+KkQhe5O
	5rn606Fnou4hGNWgInaOsjZSXsR/zD3UfojvaUvGY1gzonkG5zo5YBMKtjVT
X-Gm-Gg: ASbGncsN3Z3V6DY7VjH7XGpHo5lKCdV5tOgeUawUdo7prmHd0iK+auXLj5XhV/5f9OP
	WOuMQw0+j7HbzR2j1hfZB71pIdhNmNAA3ycwtKlrqGqjA6bxYo0kN/G0/O60LdmdAb4Mucg8AYi
	g10S4sSyfwVI06ee0LS85HcOvCjX54BPrnSog47WRVG4FgoaMc3ZnqOEGY3f6W7HOMcXJYcFdpM
	o8tKLfvfnEHwcVK6yhxJFI3Z3eHb4r+ATTjjhGx7XBl0Gf/7VeBS1dFBK0YqeAhHUNtx5CxRyL/
	gkzlRTtBP1UgGLwvQg==
X-Google-Smtp-Source: AGHT+IF6E9cVqnkRiwBBwaZlakFvSiONZRloqIlwwAi61MxMcEEA6Z1StgE3u7hVaMW9/CawqrkL6g==
X-Received: by 2002:a05:6a21:164e:b0:1e1:bdae:e054 with SMTP id adf61e73a8af0-1e5e079985emr3580688637.25.1734675658262;
        Thu, 19 Dec 2024 22:20:58 -0800 (PST)
Received: from snail23.. (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm2158548a12.23.2024.12.19.22.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 22:20:57 -0800 (PST)
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
	vschneid@redhat.com
Subject: [PATCH v7 0/7] rust: Add IO polling
Date: Fri, 20 Dec 2024 15:18:46 +0900
Message-ID: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to poll periodically until a condition is met or
a timeout is reached. By using the function, the 7th patch fixes
QT2025 PHY driver to sleep until the hardware becomes ready.

As a result of the past discussion, this introduces two new types,
Instant and Delta, which represent a specific point in time and a span
of time, respectively.

Unlike the old rust branch, This adds a wrapper for fsleep() instead
of msleep(). fsleep() automatically chooses the best sleep method
based on a duration.

Add __might_sleep_precision(), rust friendly version of
__might_sleep(), which takes a pointer to a string with the length.
core::panic::Location::file() doesn't provide a null-terminated string
so a work around is necessary to use __might_sleep(). Providing a
null-terminated string for better C interoperability is under
discussion [1].

[1]: https://github.com/rust-lang/libs-team/issues/466

v7:
- rebased on rust-next
- use crate::ffi instead of core::ffi
v6: https://lore.kernel.org/netdev/20241114070234.116329-1-fujita.tomonori@gmail.com/
- use super::Delta in delay.rs
- improve the comments
- add Delta's is_negative() method
- rename processor.rs to cpu.rs for cpu_relax()
- add __might_sleep_precision() taking pointer to a string with the length
- implement read_poll_timeout as normal function instead of macro
v5: https://lore.kernel.org/netdev/20241101010121.69221-1-fujita.tomonori@gmail.com/
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

FUJITA Tomonori (7):
  rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
  rust: time: Introduce Delta type
  rust: time: Introduce Instant type
  rust: time: Add wrapper for fsleep function
  MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
  rust: Add read_poll_timeout functions
  net: phy: qt2025: Wait until PHY becomes ready

 MAINTAINERS               |   2 +
 drivers/net/phy/qt2025.rs |  10 +++-
 include/linux/kernel.h    |   2 +
 kernel/sched/core.c       |  27 ++++++++--
 rust/helpers/helpers.c    |   2 +
 rust/helpers/kernel.c     |  13 +++++
 rust/helpers/time.c       |   8 +++
 rust/kernel/cpu.rs        |  13 +++++
 rust/kernel/error.rs      |   1 +
 rust/kernel/io.rs         |   5 ++
 rust/kernel/io/poll.rs    |  84 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs        |   2 +
 rust/kernel/time.rs       | 103 ++++++++++++++++++++++++++++----------
 rust/kernel/time/delay.rs |  43 ++++++++++++++++
 14 files changed, 282 insertions(+), 33 deletions(-)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/time/delay.rs


base-commit: 0c5928deada15a8d075516e6e0d9ee19011bb000
-- 
2.43.0


