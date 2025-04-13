Return-Path: <netdev+bounces-181958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B40A871A2
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 12:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D973ABFC7
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 10:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665771A0BFA;
	Sun, 13 Apr 2025 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fADNq65X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC232178372;
	Sun, 13 Apr 2025 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744541024; cv=none; b=BaLaAdV23In/W77ce2YMDNOqMfLakziMorf706+OQR6AIHvZHUgSNesYK8SfzvkozpyE9ZgGEUIACFek5mrTtZYp1ni5AClc3JwZmGVyIITpXpwA/K/58+PVywiFHyzNZ63vl5I+MVSejh7Q6mn1Jn7+hdJi9tsQGXkg8qHUTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744541024; c=relaxed/simple;
	bh=W86Nx23QlemiacCSBRuDz2NDVnHDfz2MqfuFj75l2QM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxzRqmD+1HSH2X/RFMfHxM024tw+H7sJYmno8mOEkKtCESCCV2lAAngtkkY9DjU9CYxKO5kNPkc66xnkuSFxFWgk9A3gzmqy615ZInWJUWw0CDhta4CONidYm1bd2OKIP6tsDUOpM4IMpnk2WK83v82/+or+TVCdquj7MJfITGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fADNq65X; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af93cd64ef3so2354515a12.2;
        Sun, 13 Apr 2025 03:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744541021; x=1745145821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hsqax02qrC+ZpSBVeQ2miABCZ3FfLDCeI7crtMGF0Is=;
        b=fADNq65Xvwh2bDUbqcyrQ6B0SSNcbLpE/sBZQGTI008/yGbu26Jq4tSicnmhmdfLIw
         PHiuP/S0yQSu0wqRvFDaXOQJ+sqJjS52xWNph9YQb8oMXRpm93q9WGWoOlfTu/IqzYqo
         kscWi6fkOdzxf7UIyVeAFnsxGsjDoLdVmT6bBu0QDt099Ab/pNQ+KBpzvma+l/X0hG9C
         QW8tEYR1WQdyTooLLUJ2SvsRjy0lKEPPPkbuEdQBti3+5lDnDfUO36Q4W6y7WnCIN00r
         DNGJ5tgGtf990F+XdUpMGwVJ8o8jo9kBVWqEiylY8USdqG6mpetVWzD+eobHLxVT0s19
         hLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744541021; x=1745145821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsqax02qrC+ZpSBVeQ2miABCZ3FfLDCeI7crtMGF0Is=;
        b=uLQU3ektittHzDQmftxtR2dIbyFQ6ZFtPM4vjKJvVoWHYVUDnWi72PMLADLygR88qV
         VByi7yv2R7bnEjZO+rktXn/YZejHSreA7jHwrT+iUQgVt1JX82zVYMOlU7ujPpiyRFJ5
         /+woKpMgkYYVYBpK8v96EZliN9KhY35sC+dAGOqpb9syoOmBRHmgbHiBHctQu/P0JGB5
         KuT6JLpfWfGZOiiLuOUExsf19mFcj0xKlgArSS9BolD+aIm1ZTdw7d/hwbKmHPaiN0Hq
         Tm3sbY5lkZJDn8L70vJWwIWfJfiVa8yyiQBJUf3rvA6qbTLvdfAokpWlJaKiM1InriMm
         yRKA==
X-Forwarded-Encrypted: i=1; AJvYcCU8UwxdDryqBB9Z5NWhRTZMvZss3wFgJ2v06mxHQXiQ9vHLZjkvxrjBy4LbYW/Kem/X1rdew+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4IHU9DJBLapHvOKVLweShvyz11T+54WvhPXMT9jvS56DJCQMg
	CUK8mfYEOn3KSvgrQ1KeVYdv+pYxzqdTIC+7675FnZoJMO2v0+BuMJEcjBx7
X-Gm-Gg: ASbGncsvADSFQlI1UmNp9CdY8anY0HFgHBIZsSZoPg5f15sO9uVcBW4Tg7sdV3x4AXP
	6n3lBOdIa7expgpqyLDXokWEVINwop/8okXyHn59h4QUZP3MMXsIHQDGTmkuvDjOJ7wy0Oo2Um2
	adSYZJHBfuKqmHyIYn+e90pB+2UUDt4C20YLuk5CNFUEqFhxvLexQp1uD1TfWPsgueWF3ULexN9
	/kO7m/znycOAw4UlStEFRRuH3Y3fLunmc9/dr5szqdXqEoJaABX2xm6OU1PetoCQkcxOm9X212q
	zi2T4x64bMtBujxicPwlx+eJ4a2El1A6O7VBBCIn5H9GPvEiG9C5ZvtsI+l+aYPyhDGmhs1//BV
	GVe2eW09MLxo/j/zuTg==
X-Google-Smtp-Source: AGHT+IE4MOmpDwNJQW/QA2OFNtZQrHj+mCCECxYrX5aI0uJe6fplZfoekq6i9uozZx8nQFpCryeCeQ==
X-Received: by 2002:a17:902:ea0b:b0:223:64bb:f657 with SMTP id d9443c01a7336-22bea4fde71mr123686925ad.46.1744541020316;
        Sun, 13 Apr 2025 03:43:40 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8af56sm80160885ad.66.2025.04.13.03.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 03:43:39 -0700 (PDT)
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
Subject: [PATCH v13 0/5] rust: Add IO polling
Date: Sun, 13 Apr 2025 19:43:05 +0900
Message-ID: <20250413104310.162045-1-fujita.tomonori@gmail.com>
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

v13
- fix typo in MAINTAINERS file
v12: https://lore.kernel.org/lkml/20250406013445.124688-1-fujita.tomonori@gmail.com/
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


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.43.0


