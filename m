Return-Path: <netdev+bounces-132363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D728F9916BA
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F6E284380
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4E514830A;
	Sat,  5 Oct 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4wRYy7c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01F14884C;
	Sat,  5 Oct 2024 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131179; cv=none; b=e3hLXT1nhKig9vPjN4408kM7HBqM3m2yaO6kC2tGFk19olNRXL2JhBr+8bWa41oc87RjuB4ZX3cuAZ4AJiISI64DS+0lHTQ1yhI8CjbffiKICeZqJSN8612EbZiL8nQyWptvNa5O8GbwdRJBMMkxDAeEjDxDk2MUKHS1+fpaCeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131179; c=relaxed/simple;
	bh=AI88GXG1Ky7KLJg1RLwowYwwiDKqBzc7ni+NOn77VY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMcMkA9lQCwodOVhCytv6Tzd4BQrQ7fDwuQKckuN1NprWAFju0rDHiIvi0ivFxpibmSUwec2XarivHd5euNN6Sykvm7OsvhlD5mZDqFGPCdK63YkaLZrORDGY+N0KEzMfjSE6NIvuv3BNMQXArZyU53Wrzh1BvvGZM1/Hal3gmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4wRYy7c; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso2029124a12.3;
        Sat, 05 Oct 2024 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131175; x=1728735975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bgG34/A+4YzDfDMw6C+N7buhN2H/pmUs0F1NK/affXo=;
        b=G4wRYy7c5LOi7mIgrHfw28PZoAXW4fW++s1PWFz8bNOhQcLtJ+nFvEqK5br7zM25Bg
         UMoyD3htqJWtLZHQuvDwTCCEwPCUTnS3hILuqsWZ8bg9LTAfk7rQQkXnuRvt24B690ic
         ixVvAdGif/BMeMy8pVfKI/nGu9tSImVShSNTAbcpQslYmdxXSWh5pw3dA5OraozVWcDb
         OMNIsor8oM0V//xcPQL5JEE822rCLKd77LAgu6im1vu55f4TN3tYjK2e5sL6CviAMSMW
         3mjpjzgWLbpEEzXk5aK5B2MetGhJT92rNzSTvCv4dZUIPnmETT0Rg3e+xh7sWyKIRQPz
         2avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131175; x=1728735975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgG34/A+4YzDfDMw6C+N7buhN2H/pmUs0F1NK/affXo=;
        b=TgE/JiWzvZQjbNfzpdcfbaPAmK2HB5Xr2x/dqGd2J+vTiDJbToGiXUcv38lbCr/6eK
         6TuE2hKWIeUOpE9TVSekxj+1/om3Lhe/7S/QVGFs5G2XTp18x828KLMCyqOESnG9wnmR
         Jw4WljlZMHGIaRrAp5RdAYCAEpad+jhsNV9SyCDn1HZhps3wXXzOHILEd0YpWVc992ii
         iHoBCEqKP5G483sUye/5Op7/ggOqLUiOnVQ2asB3eoT8wNFzmRepqCmgeCPSLxLuAihu
         WHpxnC6ln8wijojwyShKa/ayl3yoqP3E10u7izqdIJwsvd32tPrLCq3y20ua9iQQnAQf
         0XNg==
X-Forwarded-Encrypted: i=1; AJvYcCXU/rxwywCjVei9lUNAiFbr5DkGM/f1a0+UlRYyMyyxgRTPzhWmyRB/hrgOHi3m5wbIXWinL7eUTsn7BWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9RrulcEXWF09DTiGrRvIOQ54e9UUb3G2qbkodsBKz40p4L1O6
	d1lB52IjcMiDkaG0+VUmgAeutmlLDk8hN6EGpytIlI4a9EctTFbUYwctJh3q
X-Google-Smtp-Source: AGHT+IEUXGB996LMyK/77m6HUJmjzyHYUWZ59BgENzeV99/x2SzX3Ca+7Kn0GAOBIEW7Zi+H7IZaEQ==
X-Received: by 2002:a05:6a21:4d8a:b0:1d0:3a32:c3f8 with SMTP id adf61e73a8af0-1d6dfabc77amr9210900637.39.1728131175200;
        Sat, 05 Oct 2024 05:26:15 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd08besm1397878b3a.79.2024.10.05.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 05:26:14 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/6] rust: Add IO polling
Date: Sat,  5 Oct 2024 21:25:25 +0900
Message-ID: <20241005122531.20298-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Rust version of read_poll_timeout (include/linux/iopoll.h), which
polls periodically until a condition is met or a timeout is reached.
By using the function, the 6th patch fixes QT2025 PHY driver to sleep
until the hardware becomes ready.

As a result of the past discussion, this introduces a new type
representing a span of time instead of using core::time::Duration or
time::Ktime.

Unlike the old rust branch, This adds a wrapper for fsleep() instead
of msleep(). fsleep() automatically chooses the best sleep method
based on a duration.

v2:
- Introduce time::Delta instead of core::time::Duration
- Add some trait to Ktime for calculating timeout
- Use read_poll_timeout in QT2025 driver instead of using fsleep directly
v1: https://lore.kernel.org/netdev/20241001112512.4861-1-fujita.tomonori@gmail.com/


FUJITA Tomonori (6):
  rust: time: Implement PartialEq and PartialOrd for Ktime
  rust: time: Introduce Delta type
  rust: time: Implement addition of Ktime and Delta
  rust: time: add wrapper for fsleep function
  rust: Add read_poll_timeout function
  net: phy: qt2025: wait until PHY becomes ready

 drivers/net/phy/qt2025.rs |  11 +++-
 rust/helpers/helpers.c    |   2 +
 rust/helpers/kernel.c     |  13 +++++
 rust/helpers/time.c       |  19 +++++++
 rust/kernel/error.rs      |   1 +
 rust/kernel/io.rs         |   5 ++
 rust/kernel/io/poll.rs    |  70 +++++++++++++++++++++++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/time.rs       | 113 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs


base-commit: d521db38f339709ccd23c5deb7663904e626c3a6
-- 
2.34.1


