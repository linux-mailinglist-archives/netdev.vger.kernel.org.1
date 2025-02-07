Return-Path: <netdev+bounces-163981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DC5A2C39B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CE616B06A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392DA1F63E8;
	Fri,  7 Feb 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjZSDRJw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D501F4174;
	Fri,  7 Feb 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935088; cv=none; b=g6Ul+6svhmtFQsjTYQQm5mE2TMvf2McpI7ivcbmsP2xhRc3LnnyAG4MJmDU9YbfbRUn2VS/iOBqqqsIpVRMoHcs2JWFXmZ3YfHg7ft7iwP5OBURr5wv2UwUCXoCMhgzIzuE4SOv82HxWSZS36LJye1FsZLtiM/IlyjbevIHdpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935088; c=relaxed/simple;
	bh=hnOTbmTrrKsnD+Y2GGxHascu/YYa/gDDdIc+hdhOy2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFqBav3OtRx810kzLwQY+bQnzijqIfLpfPpii+JFDGsKixg8ppS8Lq7mz416dXxa6wQZO6WsDstTUqaO6xRKOqkEfWU8sFOU1T3zO4kDmjK4F944IQ2gIs0oLS2aCpEVY2ACdxw3y7X1EqOmF1YAQeziJfLadSP89l7OjyGdSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjZSDRJw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f0c4275a1so31584535ad.2;
        Fri, 07 Feb 2025 05:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738935085; x=1739539885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NK1HGIXoH8vXj+D0vllNs3ytDiD6gTjuLJ5UVxhg7uI=;
        b=RjZSDRJwUqcZkM0PBqiLH8xj4QwCPlFnsXYVxuEDi0oR35V5IisM92L6cYdZ4AQdIb
         2mBumNY9JWId81lnMyZQNad4ufdxfXpI/6YNqWXgKvex0oovltw+Wp0oQAAFWQ06ir9n
         xbIPK+TiUFyjJx7F6rxq8G2YJu/N4wipQso0+eNClgS7mnURtu0B6uf5WWjCyp7BQxJV
         htmYg+VEa2ziRsjpAlDUa5Pi7Hl+iXIrypXNnbIhFRLPKfasqRpCFlpRCT3g02M/AHH8
         usTjtgI9XqFzrh1mzCdAfvUof7i9JZau77L6ZqzQT+Mi5cM8jhGkmDfUWDXLf0iCAl+R
         EgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935085; x=1739539885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK1HGIXoH8vXj+D0vllNs3ytDiD6gTjuLJ5UVxhg7uI=;
        b=UMJcPZOv/qeujoqo7ItDhAkfj3Smf6BzDmfxFa/oqAtqwigzzbon7SUHLI2FgCZjss
         NSkEjdc5LRwyhhvonYCfvFrOccmL7UI4oFwBtoMp+JsVPsBonUPtpaGZ7VGGGkQI7/1a
         3vBgQW0AUOYTPzyb7Y2V7PxCCTgzXh4Ime51/WBA/opGsoluidFH+UsraFonGcanIIeN
         ObLsY7FG6uCfYkjzsF3s5tvREFDCTishBklRnLSgZAJe1IC0CHzcbmdN1dI5TVl/Jxss
         Qk2lc+HPM9ISFGQ0K8W0QNIvxTsxWoEdckgU32t7F6PkQLEapOGo7AU6flqXbVDu5waR
         PMrw==
X-Forwarded-Encrypted: i=1; AJvYcCVaXtlW2hr3i8blIUqILB9O69PNqACp2NJTUIQ7s6JjeMtbyibmNWqBisU32bswCds1q61a9pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzw7uRCxvnyLcg/V9q/w4hQb6154k9xXp+1KXGfqztsNA0/MJ
	Mb9Ftcen57Cq0gac5z/r/AWtFuOQYp9Sx07Qg+YIUwDCaTe182EwrNvkeDaX
X-Gm-Gg: ASbGncvDVjQzoefj0NXZ2rpXIT6wM17NdnDEynKQswWW4aN95tFtI644SZD++EyUFIL
	wRRWoSMKT56ayqsjWPa/s2gNvk6Qq6hDcaVLKFsBljsiPlhTLbIcVT+CDxOA8q+O0Kz3JJxxKp+
	94nhmcIkFkVxwrf1ZenaL08pF27jp7wtVlvH/fGXGT8K88xELb8fO+ITI+Rn5lqmq7NbLl/K0RE
	LL91XPdpZZMshlkuwrJzLaRBCMbYcWlHjwfDcrLPVLEGz8IO3VYKPvZf1Pyi5fu2dO8J7WLOYBZ
	dU57ryQW1afjMF/apWTIhFygZuWjz/Fr6j0Yzhp5iKCN9ZAzY2y/pC/MI71Vhup8RUE=
X-Google-Smtp-Source: AGHT+IHy+EpqgNAEumqcP7+ulrJ69USEKRJ98gpkuxrliW7woK12rfMKtqQYFSXTGB0DnlPZomwu/g==
X-Received: by 2002:a05:6a20:c896:b0:1ed:e7cc:ee7e with SMTP id adf61e73a8af0-1ee03b10078mr7267238637.32.1738935085258;
        Fri, 07 Feb 2025 05:31:25 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51ea79a47sm2877843a12.76.2025.02.07.05.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:31:24 -0800 (PST)
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
	me@kloenk.dev
Subject: [PATCH v10 0/8] rust: Add IO polling
Date: Fri,  7 Feb 2025 22:26:15 +0900
Message-ID: <20250207132623.168854-1-fujita.tomonori@gmail.com>
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

v10:
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
 rust/kernel/io.rs         |   2 +
 rust/kernel/io/poll.rs    |  78 +++++++++++++++++++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/time.rs       | 155 ++++++++++++++++++++++++++++++--------
 rust/kernel/time/delay.rs |  49 ++++++++++++
 14 files changed, 337 insertions(+), 54 deletions(-)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/time/delay.rs


base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
-- 
2.43.0


