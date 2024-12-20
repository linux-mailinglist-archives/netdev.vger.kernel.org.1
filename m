Return-Path: <netdev+bounces-153599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102879F8CA6
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA371188CBA8
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F931A4E9E;
	Fri, 20 Dec 2024 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joJnvPHn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEC19992E;
	Fri, 20 Dec 2024 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675689; cv=none; b=qLK/5q2vqBtGBqaWl/I0qyrqyv+ijjHq+WEb7ijUGJThHS9U+J8AtJ/pWYEZvlST/+Z1vUH2S2syZg1UL32MEDaZcNZATk6UAxPETYc7Duy4YqH9hPby62iL1z1wXVnOzPQSpaqhd6PnZJRL5TjMDpq0hZKNhO1qe0L8jfxudh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675689; c=relaxed/simple;
	bh=QCMniBBTurKlsiy0RrGlj3k+lcWNbYodF8V4zYwePL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkpu/MlXStwFW/rmd/zi+PTo3tcDzyNzg4m18uI14ijNsTqWdMPl9LpcgtTduH57o8fXZW/lrjuxhUYLQHv6Ia4rDCf8C0388HiS0gheLNwTKW+O6UOy2oWuBglW1hid3YmuZrunmFApO3PObqQay91ufE1bLhIFy2STQsLccHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joJnvPHn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725ce7b82cbso1873515b3a.0;
        Thu, 19 Dec 2024 22:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734675687; x=1735280487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR/+/dZXDRQ7/mF/Sv1q8TJwB25bHgFlrdQuIhySF5k=;
        b=joJnvPHnKBDxkBzUKEKkWJ6K5lAJBkosofa/nFN+10z14J4dT86d2g/w1YAEZS0xKw
         702S+uHUG5IYRVnyJj8mIrtBU745YrBFLYWR5yNQR1ST7J6FnBSdWUdZbI3ZyO4ngV59
         CRe5ck49P9LjcuLr+kxBYHpSGRUtKNHrcJVheLTT4/YhB3BhIA72UOoyGaKUwgXL1zm2
         QNIBqUe1dOwB1U1qBj1Dv7GI0/dgP3AuRGi2NxP8bJrgC0vVQIzDXPqgMX07lXJ/N5N8
         E1F1KpCrYfYokhJ5orGwacieNJvV6Z20F1hatv1himuGW/Tw19oX+RFDBdeVwhXV7pyp
         4YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734675687; x=1735280487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR/+/dZXDRQ7/mF/Sv1q8TJwB25bHgFlrdQuIhySF5k=;
        b=A0L+KSBqQ7lzMg1uYj0EwdLCf6MGPQ8M1XrOFsbXb5137tX6QpxhAJtAzCwGTxHlrP
         2ZhzUul6dWvpeP/IGwr3RU1ygNwPWwyx010nWs5qgYi47Zs+NIkgssMZnHTripOk5ReV
         f/7czrvJuG6wskSYs3x2nd+obruUs6hZdh9Py/rXW7B3OfyNbWeL9fpcr/ox+hTmfax3
         OCCAePWanh67twr+dDBwqBxlBnB4ICQ8Rg9cRBfIDGdagmbIq6rLtnkrTrk8A4gSCQOU
         CPRFrywUzbarkBGbGitBzuFct+nX8O+Ze0rqOa/PG8zvNzk4+3mPfy1vV73VOMn95ouo
         EDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCJLxAyrIDY1ujFeLb83+gaHV8uduTkP6aDEbHZpQ0pUze83eV6LfjVpJXsc4JJBmOhV+4EXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/29MTO3n6lLaAyosFkX+dhC5HV12uFEPe/ChVJikBKWAzj+P3
	0ZWhwjj8slu7jqKTPBSCBxHADRdX65i2JDn+yCH7ztI5+2LoxqhzJTu56+JJ
X-Gm-Gg: ASbGncvoF7ziHRSbhPQNxb6dw4BRVkIlAYPgKK7XCzNtj8tljxbIzNXBSmhtx+DIHtU
	DV1tJfXTAyG8ESc8yp5vD6q2odk/ftU5vJ3xVSTyU8pyB4DL1OyF3P+KqzkfhDTptWE6nxv4sam
	NR+FOmtApxz5XZLe6jy+DDsx7yGmV20rgE2jL0B9GRFMJO2EYULWc44QzlJwz/p12d3vAELBdMn
	Vm3eRYRMec9WbDgFP9u/L23XUY84mSrJVfZSrJ3a5oQCDxlPlGVskL989tEezBC18G7t2gktdLP
	HcCgAz9ugtcHhsXnaw==
X-Google-Smtp-Source: AGHT+IHFV2t8OCPSA1zu+ewAPEOjpFRLFZt2xsJBYpDDMQCrftE8yf28qjtd397lZxILIBXZQUprjA==
X-Received: by 2002:a05:6a00:32cb:b0:72a:83ec:b16e with SMTP id d2e1a72fcca58-72abdee30famr2531022b3a.21.1734675687245;
        Thu, 19 Dec 2024 22:21:27 -0800 (PST)
Received: from snail23.. (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm2158548a12.23.2024.12.19.22.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 22:21:26 -0800 (PST)
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
Subject: [PATCH v7 5/7] MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
Date: Fri, 20 Dec 2024 15:18:51 +0900
Message-ID: <20241220061853.2782878-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
References: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Rust TIMEKEEPING and TIMER abstractions to the maintainers entry
respectively.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index baf0eeb9a355..77bf1d2e6173 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10251,6 +10251,7 @@ F:	kernel/time/sleep_timeout.c
 F:	kernel/time/timer.c
 F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
+F:	rust/kernel/time/delay.rs
 F:	tools/testing/selftests/timers/
 
 HIGH-SPEED SCC DRIVER FOR AX.25
@@ -23643,6 +23644,7 @@ F:	kernel/time/timeconv.c
 F:	kernel/time/timecounter.c
 F:	kernel/time/timekeeping*
 F:	kernel/time/time_test.c
+F:	rust/kernel/time.rs
 F:	tools/testing/selftests/timers/
 
 TIPC NETWORK LAYER
-- 
2.43.0


