Return-Path: <netdev+bounces-158747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7A7A13205
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F3F165869
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7418C78F49;
	Thu, 16 Jan 2025 04:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj2NA0Uq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F94A01;
	Thu, 16 Jan 2025 04:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737002550; cv=none; b=I0kYr+rYT2bOg8/vkPEqixSzOMxfb3FaPYsIBjQMgV8Yix8lTJFYZ73MKkCLPSdxAGHBLMQYPNMif12o+c30RlXF5872DLVwMDWfG7QaQHxZJA5EgLTO2Cc6bjTQC2+MUQrwBRpFiEBwk3WW0zNIbwTUc3AhbnyN4dGJO1PlGeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737002550; c=relaxed/simple;
	bh=TtJJvzWs7F7tD18OHj+o0NVgHy8zTK+iUWvkOzunM8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuoVlhnBukoWvn58ywT0/t4CtJfJBH5lht8DoPeAeX1FXLlURMnma9P7ZM23NKhYcTaGVfepun4GWzeSOp+6nPEU7fa5WuuV2y3dDcK0o9K5jlplCZ9v1APO4nsKNNQps5l8R8k7VDRKlsD2TApZElIfoEKAELjhnfQ7SwC4TI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bj2NA0Uq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166360285dso7684395ad.1;
        Wed, 15 Jan 2025 20:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737002547; x=1737607347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uKkZs7JfQG3Yl8zQ/sYVk0Dv0KT/LUZVeu7NHKqRR20=;
        b=bj2NA0Uqjv/qHvnWchKrCaEg53nuUY74YH2vuWsxrOpC0Nc3DyQ1BKL/QF0+WKB+SN
         aer1BjTGih6z4dOaeAf9zqqQVNEGBtSYCZsOJ1vBkHHf9bSBSRVaK6rw0aC1qEvtq4C5
         g3yef9qyNRgFxmq9+cVmLu/5G6xhpK5d13YUhY+l6MA1v7y+6nkC68XQ3WSDsUoF47VP
         LFn/Vu+eWrRmFQ7A0XciXRPBFYSm9kUd+rNUcvjG0tmwvps00na/62mywJjds1bwxoiR
         ry0ZuD5ZAu1LSIOz60ZlOZ/+MfG0xXN8b0brVa+2tqbeB31PR7rvUPdg7cxVbwbYWGbl
         aKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737002547; x=1737607347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKkZs7JfQG3Yl8zQ/sYVk0Dv0KT/LUZVeu7NHKqRR20=;
        b=AiAdfQh6M3P5QumKn0HPf4DeJsdA5CMMDG86ahUJWZEeuIaYdtzvL1bszZNvvEIG8b
         ++zt/81F7wVwbb3Ie0XDi2GTk+OxxABDuYz4lYd3TzZbwsS7Ri5Q/Letcvasz6GdnofP
         oNIBWEbCTCRvSZ4mkJ9iIakPDno8k/lizwu3DMFmrAc4oYyv0i5LeQY6h5/bxsqf3aTU
         kYtdMfkAxpiTjziJv7ByU93iQlqOrjz2Dmt2BlRtT8NUUCsNawLvoGa4L8c6yOE6yGDW
         3A4bHOJJztPx0hVyvRPI8LlQqcjYtYC+Z2GP8wH+LpjiBU4c/f0iFGR/IpfQUxvVnkRv
         MPLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdT2d3K035lnmP0edH0sJMqf/0xhDe/LFAotXawW2jqr1aAFU7v/SFpTzCKMjUVm1iU7J0zuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyahcLZuLumT5S6VEzwY/zQzXifJHWyXPUYtuMdmgRR0r1cxt88
	60S1mloGyNZ1mpL9V+pO4n2aXHgzQrzrRep/yE52dowIG8Asr3lgSLzcDKcj
X-Gm-Gg: ASbGncv84JfSvhn4Ie+w2Tg+GFWkDqiPzY+ZyhF6CrQbQXcACkWjuzwVXQP3hpMjI00
	sguSfLd1ndnBMvaF2+vlrdUrVq8WpvfFG4+SH89FqJiEwN6lD7PmtD8R/zGjlYmrsCKATk5U/FU
	1/kEaOrEmfBjmvIB4JJHpE4rI+bUYkk6NYGDINHPJfMZtxS4+Azrntjq3QQALWN2yNG9BpsC6iD
	TH1HcibfRMVUusnS41H87wQVd49Bc4cUS6T5wcIt8CG1WmbaRLqc6IHyI83RJFbqizxiu33Glg5
	6IxO7veLtzpJFkjvIFNp6s06h1DFW0HI
X-Google-Smtp-Source: AGHT+IHSnSWnZsTgSwEjwh48bIPFxZ1s8keNVhfwgqXnJvoLwdMA4fxLV2UAEnpG39uORz5l8wyRHA==
X-Received: by 2002:a17:902:f706:b0:216:6c88:efd9 with SMTP id d9443c01a7336-21a83f4bbf8mr497649205ad.15.1737002546671;
        Wed, 15 Jan 2025 20:42:26 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217a60sm89161045ad.158.2025.01.15.20.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 20:42:26 -0800 (PST)
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
Subject: [PATCH v8 0/7] rust: Add IO polling
Date: Thu, 16 Jan 2025 13:40:52 +0900
Message-ID: <20250116044100.80679-1-fujita.tomonori@gmail.com>
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

v8:
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
 kernel/sched/core.c       |  28 +++++++++--
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
 14 files changed, 283 insertions(+), 33 deletions(-)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/time/delay.rs


base-commit: ceff0757f5dafb5be5205988171809c877b1d3e3
-- 
2.43.0


