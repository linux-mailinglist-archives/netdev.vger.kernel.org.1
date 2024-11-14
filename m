Return-Path: <netdev+bounces-144695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F29C83AC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9610A1F236F4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1CC1EC01B;
	Thu, 14 Nov 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGfZBl91"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A222AD04;
	Thu, 14 Nov 2024 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568004; cv=none; b=OHWVhi5APFHFsxLAOQT0yxgr505cRFy7KRYK8YLWRQugpez7mpS3Ka++PWW9Ib8ys/Q+OkMXRBpMRxdsgev6RC93SSTnC+fmFzyW1442AebvG6mB5bRRlsw8N61walFb7oKrMYIe63lzxX+CNN9m//gdEtSromcPBX1V5gAcjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568004; c=relaxed/simple;
	bh=rkLeVP2v1PhK5/nY4hC8k1tKYfbRWqjfrFSywgHJF1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qb4kki98PthdfaD1PGVkOBkky+nN51AY1WvoCgYOlQ+4fLP2vWNkx07nGi/vSafeTAW287nm8+Nw5Qw1AZSmDkR+sbgka67DC4+5B/CbMC6y+/cj/PmyEkpV+vBZkdc8MpZJQ8xJuoy0Kz/ZdYfu+P5H92hSUsEDmTClPRcybWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGfZBl91; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cf3e36a76so2503485ad.0;
        Wed, 13 Nov 2024 23:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731568001; x=1732172801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzJGg58BHDait89DXQLWDgs3es/g6e2HVB9OFr5+hQg=;
        b=aGfZBl91sz2d+ccLX3QABKkm9p+aETCyqdKGvRcFXvkDXOemq0HcwtQjhkQE8yYj//
         9IZ+3EEHQeK2SVwH8l5B4AXofO62cUVQqRSEHKYCWmoHX1YGlcJFCIU55fECBigUbJim
         F6Tq6YhrK6zBa63exIW+arc2Z11i6IHNlFtrcWR93A3qVvvSwF5jTsRwofzl9SShyZ9k
         MyvYYusJHn1CmcnhfwasKeepHaehqVMchhX8PPq4aNNYMcEp+90AR1cto1WjSxE47wsd
         ilMg2Ek86FU+OkfkjzVxe/m/CoZT4KOSdAF+f1VMyzT/iVc6HzRDZOYSDGc2EP7wNo4K
         5joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568001; x=1732172801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzJGg58BHDait89DXQLWDgs3es/g6e2HVB9OFr5+hQg=;
        b=UsoipqczLOER6SfQl8wk89wDSFur11PBpj/fFY3xZfQndfJ7kVKML8iut1nhsXdegG
         b+AsmwmiUeV0Rxhig0891F+4SHYgHw/pRWW5Zg7Q52V4wbllMfcSd0YgYYeEX91Yyf3s
         O3ZF8XoUexh9UVpswZoUgM41mKh4DpXaVF7U/X8u2m5moJlZQnBUzMZqux4nvR8sGgep
         aU1m8LFUe/IGu9oVtqKGvN9RBlBL/q0XrNA+YFOzZbB8k6bYWYRyEyoB8oDvgm1AABsy
         Z/PQDO2158BRKPCVcZVB3Uq0xmJn2WGjRePyckVkZb6kkHTUsdDI0I5tSwR/dG48RTAj
         Qr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUkI0OaoY+9WQ2IQd3IJDEod+GsjsDR3qiRYKQKiLpZjkikMDASvLbJ2MlC5YsfygMqi7e5zGxxemUEdt4Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkaDt5CuCIfCdqZRQA2flaIOqnFVrqf2jJltPpNQKk/I3yann6
	pMClL8L5EdjpK15/qvnpnspVPHmO18YwM3lpLtkdUd0gOMhKA2CiyaXnQd15
X-Google-Smtp-Source: AGHT+IEXIJ2VvFgy+l2V8aOnbKdeX7Q41bVsn239JP4oarHZloygQQ78uT9sxqPjex2zLAGOqHDehA==
X-Received: by 2002:a17:903:2282:b0:20e:552c:53ee with SMTP id d9443c01a7336-211b5c884acmr74514595ad.24.1731568001271;
        Wed, 13 Nov 2024 23:06:41 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm4260315ad.244.2024.11.13.23.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:06:40 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
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
Subject: [PATCH v6 0/7] rust: Add IO polling
Date: Thu, 14 Nov 2024 16:02:27 +0900
Message-ID: <20241114070234.116329-1-fujita.tomonori@gmail.com>
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

v6:
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


base-commit: 228ad72e7660e99821fd430a04ac31d7f8fe9fc4
-- 
2.43.0


