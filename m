Return-Path: <netdev+bounces-140857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5107E9B8815
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0A5281D5B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16C620328;
	Fri,  1 Nov 2024 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSlMCYbD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CE634CC4;
	Fri,  1 Nov 2024 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422939; cv=none; b=Ii8lJHpr0YZZMR+EMabzEF8CujHq1bGN9WoN83/U4J16q2sklg4UALHxBZesvD14AdDE5GENTKxtP3Ljb/nMRdF2oPvWNGpU1t0oRG2E51Vq77J1e1KhgFkSgzLQOopE9qqKcmA0LpJFT6muAvEAdeian+wpqeBCINTo07AibbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422939; c=relaxed/simple;
	bh=rpnrvQ51Pzd6TcTCFw/1JOF6TVB5Ku7URjbwIth5Njg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHA6I/7Hhs7HgHX2amPA95Dgs8KNVMhN81rLx8N71tWvlw2n57IzoJza4UmJ4ZB8gOGxju52w1/mZISSUfMbUH2Si5R+m1yBdxaKpipyq/Vt3uSWhHxmUfQS7k8sOt4uQjOMEkgUyGys6j2EkbCRuQsSkUPA/Qw0EtxIw0IHeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSlMCYbD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7eab7622b61so1217305a12.1;
        Thu, 31 Oct 2024 18:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730422933; x=1731027733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxz2el4wbZ6G3BcKbo7KzoBLvWoRppJU2dbWS5YJA44=;
        b=HSlMCYbDvcLnX/F5tZZdGk4ZfHzh7MKxInI3uT7sKF6vL8pvWQcgoPybFNZgAm+vNe
         MUfHs8m04o1ulsSVdYIMJvsRAvQUTCZTa9HUChU30WrDkm40b/+VZXG9jXedIhkmVFK7
         xIxK2xsjAEPsbifsLIiKJp2s4r5pG6wotWyLxJcoErOh9JIwXVNYOkMY1OLYhAdt4pZ1
         F3DL4Kms+ebbVeCIW3J3VCr2OBryXKAteywVmUgJ2tSH/1JZ0vRQIUL8EKCwe9WvloS1
         eMQ0W/+nfR2Y4iojzzmBexIbLeRZVxAOr8uuLasEafDNx2kfk5v7YZmC+UQRKBWwfkVP
         YBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422933; x=1731027733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxz2el4wbZ6G3BcKbo7KzoBLvWoRppJU2dbWS5YJA44=;
        b=b96t5M0dmWWFZ58si1RM5F1Zl7Id4KBbCqkP3CUsFhMFb4F0+sFlu6QgxnKxHM1F0Z
         AhwCV05Z6TbX8CKq/R1PxbspQyeTriXyJj5ZPSESSwjwTWEwSYLeKEtY3ccKFdOhZkNV
         Sq4npH8SMBRLTvrFBwbVVI5o6qcDIi1Y7Nonyz+KPQHVft9UJnzLwYsngfJfb9VfByG0
         j4BFduY/N8a3lydzF3gPT3no3T6K8byXz0YmpWTo2DRVUJs02Tq/N/fmUj8bKtghw+su
         1fRUuc6dWqKFXrlqJMBl9x5CKcmf9WPcbX3NKBKsBontAqRrFx3PHe4eIO6apLRap03j
         IEkg==
X-Forwarded-Encrypted: i=1; AJvYcCW4dOBmfiKktATOpJz7Jgv3bDxt6b91u8lFamnHL8MafEtkgc5Jl1DACvMvABCEQdS5/9S7cqQW122Ll7Y=@vger.kernel.org, AJvYcCXf2SfUWdD5Ef5KqvCgoADUm1x4NnOSAw0+VDYJ6uUtvqIAh9YhKx8df/GtYfZOthxvrRB35dS59ZYAi2HMp9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHec23uuJ6pmcZZIWiaNeKvqTa4YNsb/9kLKh/WvQQ8lNChdt
	0hmg1GJuZjsMAlDig2OPK7ocnfYb++7Rp5ezOUkGfmTgPiTpNlMO
X-Google-Smtp-Source: AGHT+IGZGlLwqs0no2dclauFE75oRu+pvv2rJZ5SXyzebZVJ67LKbJtJ8Xof1BVHl+beZOs6SyC9xA==
X-Received: by 2002:a05:6a21:1796:b0:1d8:a1dc:b43 with SMTP id adf61e73a8af0-1d9a8402d85mr29843682637.24.1730422933320;
        Thu, 31 Oct 2024 18:02:13 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ea6a1sm1743403b3a.74.2024.10.31.18.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:02:13 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
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
	arnd@arndb.de
Subject: [PATCH v5 0/7] rust: Add IO polling
Date: Fri,  1 Nov 2024 10:01:14 +0900
Message-ID: <20241101010121.69221-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

polls periodically until a condition is met or a timeout is reached.
By using the function, the 7th patch fixes QT2025 PHY driver to sleep
until the hardware becomes ready.

As a result of the past discussion, this introduces two new types,
Instant and Delta, which represent a specific point in time and a span
of time, respectively.

Unlike the old rust branch, This adds a wrapper for fsleep() instead
of msleep(). fsleep() automatically chooses the best sleep method
based on a duration.

v5:
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

 MAINTAINERS               |  2 +
 drivers/net/phy/qt2025.rs | 10 +++-
 rust/helpers/helpers.c    |  2 +
 rust/helpers/kernel.c     | 13 ++++++
 rust/helpers/time.c       |  8 ++++
 rust/kernel/error.rs      |  1 +
 rust/kernel/io.rs         |  5 ++
 rust/kernel/io/poll.rs    | 95 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs        |  2 +
 rust/kernel/processor.rs  | 13 ++++++
 rust/kernel/time.rs       | 97 ++++++++++++++++++++++++++++-----------
 rust/kernel/time/delay.rs | 43 +++++++++++++++++
 12 files changed, 263 insertions(+), 28 deletions(-)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/processor.rs
 create mode 100644 rust/kernel/time/delay.rs


base-commit: 1d4199cbbe95efaba51304cfd844bd0ccd224e61
-- 
2.43.0


