Return-Path: <netdev+bounces-185261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7453A998BF
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616D73B381F
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99EF293B45;
	Wed, 23 Apr 2025 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcqMR1sU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA8291170;
	Wed, 23 Apr 2025 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437294; cv=none; b=RR1POMMnz5wxIZ4JFMObqERDP/cchcWBUaWdkM9zRgFzbs9X48+Hal6oMfBjmQALwLGWVHVrD6xwe1c1Dps2LH5W6hSkbG+hrKfy4JdYc2CaAgIEHm7voShLShc5oq2eMpHnJW1hJRcX2QTZHwNrlWiz/a0SWoCcvHyC7IOZES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437294; c=relaxed/simple;
	bh=gz0UTPi1bcomJR/H3DIjAyZl+dlC3YhO+kGBOC4UWDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeqhB90tcEUrRnBiVLzpE1GP/aXy1VnGeSR3qGM9TlRuox+fhXITj2HMUH1k3nKDsE03re19Sm1kn9R/rGnmDHfTLeAA2aVtnIW9f7pDJEDa5bhuf5LMA+jFY5d6qPyI2IULpzdi94YZI0IUWMeECTNQOXlu9C8iQkQpP19gspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcqMR1sU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3085f827538so342780a91.0;
        Wed, 23 Apr 2025 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437291; x=1746042091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKJHASye17MFM8qC1IGdA4juHz1iYrFYpUpJMos7xP8=;
        b=gcqMR1sUAr+CxmSS8UYRs19S2DiWzBaskP4GJ4W/LXTm2U2N2iSlqkkAJiJ/PlnJyB
         W3rSUW32O69snjirM8C5gqLg9hxLIvnf84JFec9YWUJJ7zux7IADmLNTpLTTIJKyOQCT
         g/ve4pI7HpC0gE+7rf4Nb6u/TeWfG/ApKr+R18kjxbZzLWYwNkwA21XrtSQl5gblJ8Um
         fGc1bELm3gnE4mz0F30qbbtm8RDR/DuC0LEew5BIHyzjfQs07/ci7PRG8lhTwQyo70RO
         a+4ZojWQNekr+PJcoDAOvpIXI+r59whcT2NFwZmaFWv+NNiUzlNgllBjgf0JlIA9U7eA
         kMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437291; x=1746042091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKJHASye17MFM8qC1IGdA4juHz1iYrFYpUpJMos7xP8=;
        b=TZBzC+RqL+629OxZy2iBg+k5ymRjgJX1lL5z+13MRcT3eZhtRgOHHDa95YRwpIceEo
         IZUlJZNRKJMbah1FDFXg4Fy1fD6AR+W1964dA6fln4BAFLuucXsh9QLi7PrDh1G9dU38
         ELDS4hB1BMrzFsfu9K1JEFuDtBQF3DLFi/PaiQcUGssCv5J43DQxbXtXgqolADiMN/DR
         /tXd/RlBD8TDk3MlOu4UKXwIEOVyYEAqx+McPXM4b97Andsj/qc8CIE+Dlew0dLMeVOs
         YlVlhMutNPC81OrDh0FlNf9I79k9aBVmXvZ14oJ6N/lnwkFNaG3phR1881G+a5iRumXY
         yK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCK5krVVKqqY+slVcMxmK38xaHJyfkIupcQGXYp5IrxjHFMvOA5QZJIwyBuDJvtOuX1hHEJJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuGszMQllFXJqFeL92xMCxZrdi5MPErF+X+48E7WLlKHcSNYJ
	G1RHVlWfkipJH7xW3uHD1NwX6YEnesq2VP6J+jkQcXvwNF5YdYki+j8Bfsg8
X-Gm-Gg: ASbGncsyPIcjLiu/OrcCzQhse0EjcMI8ngmeqZXiJEtGmd+o9PUmkoErLYp7JlhZcUe
	JYm1ppmJEYo6gyeMflGHF6UwClkaXC9pYFxopy15R/R1cou8yiTiJJBkhpmEg6FxS84ZjfgXtRq
	qTENLMFI13IgAjONAA4wLVD7aDnNYfo9ayfT9DrPrGbsisUsiXtHhkXZyrbaCTQTOFlQyMX0A3Q
	w9bczfo1Wx1PZEURSqe2f5v9CebO+tyZUU14400OW1LHwiNSYlJXjbA9Xcx6SHX4KT90ksa0OWR
	D+Wj8xCNnsDMPJmi8ZSrZqKbZo5NOhuN14uQ7TphmdNdPdgU0mQt1NjGMGZkm5U7dgJrTCE3Bb1
	sbjKHen+l1d4vGed+UQ==
X-Google-Smtp-Source: AGHT+IGvU7L8rXtlOKJZ4PzXC0+9UMN0pAOvi0Kb8qDu8H6XSLavkF5K8Ta09kiMwI4/YnwX2PsFZQ==
X-Received: by 2002:a17:90b:2f4f:b0:2ff:6a5f:9b39 with SMTP id 98e67ed59e1d1-309ed286434mr94763a91.18.1745437290579;
        Wed, 23 Apr 2025 12:41:30 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9ef918sm2056475a91.7.2025.04.23.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:41:30 -0700 (PDT)
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
	david.laight.linux@gmail.com,
	boqun.feng@gmail.com
Subject: [PATCH v15 0/6] rust: Add IO polling
Date: Thu, 24 Apr 2025 04:28:50 +0900
Message-ID: <20250423192857.199712-1-fujita.tomonori@gmail.com>
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

v15
- fix the comment and commit message on Ktime
v14: https://lore.kernel.org/lkml/20250422135336.194579-1-fujita.tomonori@gmail.com/
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


