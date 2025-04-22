Return-Path: <netdev+bounces-184679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01DA96D7F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8437A9353
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AD8283683;
	Tue, 22 Apr 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRwAEkuh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6028150B;
	Tue, 22 Apr 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330082; cv=none; b=McJ7HtrK9gjFHOfKYmLxfn88HFQPz8+jSPXkXHxJjobFUuttp3rr91QubYzA0VLCQVGJI3dzj26ZC4SSMrUDnEt502b5PupjkI6lJlQBRIWU442BL/Vp+7Nm0oUDKZi2o9Pt+basP3lXumX//g6JkkvPwMoSIXiLR+Dq5EfAO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330082; c=relaxed/simple;
	bh=AtKQAbCNDaqt1p+L+3cEcp6FU4S9eOJn1fUFLjqkpTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9xcdcn8HqICrXfUX35mQ6jNnsw7d5maawjg/IOxK4rzGrgiNWzfptYefi5YUsVun2JgN3hiukF3vVGB2FTND4Jpvsuhb3XJUq0gq239tClC6r0xt0CewJI3L1nGBcqbxzWUc71DILteOCY4HuWnN31Qp+sYdQ9bBfEEK9jcmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRwAEkuh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223fb0f619dso58546785ad.1;
        Tue, 22 Apr 2025 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745330080; x=1745934880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zGNjxmoUsW1oVGUsNvAhXLM57pksEHWbGgDbXJd6LM=;
        b=RRwAEkuh8ot7wGJuNw0Sh82uR3roJmDhXwYSUZigPYrGXwKneCMVRXVizXMw3gTLZH
         s6eL3XrGdSU8gHIpivgWNuaNe9UY4bJMU2weFGXiIGAyDhgLSU5DhCZQZMXeVrTMfOoA
         TmsJgT0eSevf0Ymth9eBXJ1EgZItcFIhubdJBLofGDAm5x4+KUZTSctMgwcBWQ+Lv+Cu
         HeCHQNg0nNwmRxeuLSkiLw+9WzIJ4C1tmqmB+8KQYS1HRvvpmGXMdrrPZe6d/zKquYmG
         RBWQCXx4V4E7MhEegtokPR+oI6VJVFb54fAr4bPgGYBlmBAXO3wG5MZrfrNRc+QaDK6w
         nAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330080; x=1745934880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zGNjxmoUsW1oVGUsNvAhXLM57pksEHWbGgDbXJd6LM=;
        b=KELepl0ggL/mdr/QjF2cQmmAxcUqTLb5M6G753AgMnC/Fm+st6RWKzZJMSd1tuqNmK
         hqBJaJQL8a/pfS2xmnolvWbs0RkJ2j+VtNRmwuu+n4FOsvPDQPZ4myB96wc256kNl3Wz
         XufqextBBo9b8644c+/Ic8I4uu13Gzx0cZAidG0VGkkklerWoj31vMH3wuVYcWF2D5Hg
         tneV1xROg2ULPWH9EDey2lTGB4kgv8z9j0ldL4wNcpXAaVKUhcd3ITDOPFCowcvmQjml
         nQjhqUXBVP9aLK2BwKDBLK/LMxw1qeinxeQAV+W+uuQywGU5crC6x8zeasCt2IouFPHo
         yxTA==
X-Forwarded-Encrypted: i=1; AJvYcCUVbrWY5wWmEG01VtUjdv01YOSem5HrEXn1dK52KBPrCGodeggtXaWuDDv0H/UtQ9ng1/q9jUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigXKMS1HqG15fD62sjFeP/AEkU3sl3YIiteKZ81fRRdfwjVDX
	nLAWgNc0pXBVax6eUbkzP4BiZYjH4+bA2EB94oWtWI/8f7nqikYzzfDkfs08
X-Gm-Gg: ASbGncvpqe/l6zg4YRexhihqYqp5MdbQjyo92qGu4mZL8BWccjWw2h+LpoW1aeHlbha
	4T8u03852iIAwE2lWkyL9gO990sqoTr6NkYVfz5UwSDAAFniLoaP+zEHaVTX+GyjfrlA+RCrG8g
	6TS0Cb6OwQ31MbOhRkco+BrdulyRtqQwzfCrhIhCx7+n5yHakvfgRbBSp7K476uxwBYIt6qahN8
	iGglEu7pZ8lQVworIPj2bO4wcjhKAPb2RrxqIt2jXG6VSao55lByt2HeZ9DagZJnXlCJkgecEod
	B7Uj8qd+9NNhUlZehckqkfN1W3gs8V2+JIMulVEL0sObP869E0JZKsFHpAcnujk4x0684WsMtt6
	5frsw1RewugooIbMbeQ==
X-Google-Smtp-Source: AGHT+IG66T+Qc/resXFvedkXZwti8z9bjWVUzW3Wxn+ayUNwflH3ZuulQ+E0pdiHts/eYAW3uDh8kw==
X-Received: by 2002:a17:902:ebc4:b0:223:5c77:7ef1 with SMTP id d9443c01a7336-22c53586639mr232532265ad.21.1745330079311;
        Tue, 22 Apr 2025 06:54:39 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaaba76sm8869650b3a.143.2025.04.22.06.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:54:38 -0700 (PDT)
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
Subject: [PATCH v14 0/6] rust: Add IO polling
Date: Tue, 22 Apr 2025 22:53:29 +0900
Message-ID: <20250422135336.194579-1-fujita.tomonori@gmail.com>
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

v14
- rebased on timekeeping-next
- add Ktime type temporarily to hrtimer
v13: https://lore.kernel.org/lkml/20250413104310.162045-1-fujita.tomonori@gmail.com/
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

FUJITA Tomonori (6):
  rust: hrtimer: Add Ktime temporarily
  rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
  rust: time: Introduce Delta type
  rust: time: Introduce Instant type
  rust: time: Add wrapper for fsleep() function
  MAINTAINERS: rust: Add a new section for all of the time stuff

 MAINTAINERS                         |  11 +-
 rust/helpers/helpers.c              |   1 +
 rust/helpers/time.c                 |   8 ++
 rust/kernel/time.rs                 | 168 +++++++++++++++++++++-------
 rust/kernel/time/delay.rs           |  49 ++++++++
 rust/kernel/time/hrtimer.rs         |  18 ++-
 rust/kernel/time/hrtimer/arc.rs     |   2 +-
 rust/kernel/time/hrtimer/pin.rs     |   2 +-
 rust/kernel/time/hrtimer/pin_mut.rs |   4 +-
 rust/kernel/time/hrtimer/tbox.rs    |   2 +-
 10 files changed, 216 insertions(+), 49 deletions(-)
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/time/delay.rs


base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
-- 
2.43.0


