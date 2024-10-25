Return-Path: <netdev+bounces-138950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855599AF835
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152F01F23D2D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFA18BC2C;
	Fri, 25 Oct 2024 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAZYU9o3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4F81727;
	Fri, 25 Oct 2024 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827251; cv=none; b=FYXicvMdOdn3poP6UgQjiYrWy8uCT1hwt8na10y2ITpRHfweB3xFIuJFA8EFIWk1HOsfj7ixjIeJQR6+yrAbHUQbgj6Sni4GGDSmICMhrCuCF542pBehKbfpG/+YbutS/lq0b0shkorSTslqnCYn1yUAhqTfQ5D19J0KKm4j62M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827251; c=relaxed/simple;
	bh=mWQu0AjtW5e2/5o+blWbRjf2bJPNv6vH9E3QtcHvehI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HomYKuz1S0Gi3ppmwovv/72+xTQ+eVlZDlljtDflGYEthth/LOhg8VsbmeIJTS8E/ReTIZs0oml4LyG0RHZqMKUUZQLYi7P3T5rZc6K/td1QOTDDCnBnj1FglPJk8pu9U0GlGQLRKavG9T33HLgksnRZ8g2vFpjC5PHPgaGzNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAZYU9o3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71ec1216156so1244539b3a.2;
        Thu, 24 Oct 2024 20:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827249; x=1730432049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FOfYnoULRHzXE/5/X+YIkXCYZ+UOng59op4po/UmLxs=;
        b=PAZYU9o32JjtOuI5TK9LeUsA2oX+X2cxAN+6f/KZ30PzvOJ+tL8N/DY6+mUyRHUzhq
         kYdpRilMebYim3R1PTWzmJlkBAoral3JkuqzD6FPlotfII1eQz0L5VL3TGQ/VMVv2pcs
         4QzNqaYktYRF6fYNTP1Y/7aiGiUZYOlmzDMe0THtZ28YJdOuTTPtSgpMSAU6JwP6VgZH
         K0B0lSKCJFcKU/wxnyMTMhthSthqJdGxZbSggKj6a7dYYdDrgaFrawCFKfu4uMWQYTiS
         YpDwjyjcyVAfbZQDf5QiTE//VbEW3vIPT/Vp9BDRLwcHbDAaS/4W2EvZwmzukK4asgx1
         e01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827249; x=1730432049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOfYnoULRHzXE/5/X+YIkXCYZ+UOng59op4po/UmLxs=;
        b=i7fJ8ngdcR1oex4LAx/Bq3pyOcVem8wiLcs3aNHCcR/07lW45wc5IS2EB0xU/3cGM+
         nZko6zRLN56DBazYGigfBY6g5UkW0KXEUrM3YFsV0kaXYXoI4hUKeCxdQ3C1wLfQ7ffs
         wfJgSOYXiKYeg74TAS5EqTrvp3Uf2OZTI0QuPxM0fTXBTSIjMRCu3c7emsvYy4/fybfr
         EaeAdafOsM6cO1tsanydla4uaTniUk6EgX5Co6lFpZuCeUn+XFeapU7Oz37d+wJmbAJf
         0uacsfKjtcskwMIOwpb/OULeJB3cYkjbPGyPkInnDvGayHJwT1Df4IN5o2AVq/OsRKtm
         hTsg==
X-Forwarded-Encrypted: i=1; AJvYcCUFu7wNEoFTO2QoVeYJ/0bABsbHHNW7fP/dXro4tBvKpMvgb15j2CMD+e7tyWN/lWSuRUurIvpIq10Z+kE=@vger.kernel.org, AJvYcCUbNcxI8JcwqUlYVC0L+1fF0G/4ypOGBoA51l3wua4UUCk57NodSwLqwh7nTNqHPfqGKfg3RPo+fFefWGpdRNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0MZMNDl82e5FNg//wh9JAWzDiiYl5XTAiYFxD8NdcQCwkgYY
	NYpIWc1cN+tcqaokj1UVV+ZURA2Z+0Vo3G9Z7U2Pbnv1E+MFkWR/
X-Google-Smtp-Source: AGHT+IGRNgtPrCMW9jUAMq6pgXYJmgYGJY+HOZFhQVnOittdaV0Se1VLvTvreFz/dD4sXuDvoPgS8Q==
X-Received: by 2002:a05:6a21:114d:b0:1d9:2994:ca2b with SMTP id adf61e73a8af0-1d978b0d2c5mr10965054637.19.1729827248830;
        Thu, 24 Oct 2024 20:34:08 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791db5fsm180188b3a.11.2024.10.24.20.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:34:08 -0700 (PDT)
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
Subject: [PATCH v4 0/7] rust: Add IO polling
Date: Fri, 25 Oct 2024 12:31:11 +0900
Message-ID: <20241025033118.44452-1-fujita.tomonori@gmail.com>
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

v4:
- rebase on the tip tree's timers/core
- add Instant instead of using Ktime
- remove unused basic methods
- add Delta as_micros_ceil method
- use const fn for Delta from_* methods
- add more comments based on the feedback
- add a safe wrapper for cpu_relax()
- add __might_sleep() macro
v3: https://lore.kernel.org/netdev/20241023.213345.2086786446806395897.fujita.tomonori@gmail.com/
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
 drivers/net/phy/qt2025.rs | 10 ++++-
 rust/helpers/helpers.c    |  2 +
 rust/helpers/kernel.c     | 13 ++++++
 rust/helpers/time.c       |  8 ++++
 rust/kernel/error.rs      |  1 +
 rust/kernel/io.rs         |  5 +++
 rust/kernel/io/poll.rs    | 93 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs        |  2 +
 rust/kernel/processor.rs  | 13 ++++++
 rust/kernel/time.rs       | 89 +++++++++++++++++++++++++------------
 rust/kernel/time/delay.rs | 30 +++++++++++++
 12 files changed, 240 insertions(+), 28 deletions(-)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/processor.rs
 create mode 100644 rust/kernel/time/delay.rs


base-commit: 2e529e637cef39057d9cf199a1ecb915d97ffcd9
-- 
2.43.0


