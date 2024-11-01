Return-Path: <netdev+bounces-140862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC839B881F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1A5B21452
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882F481D1;
	Fri,  1 Nov 2024 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX6WsMZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C212CDAE;
	Fri,  1 Nov 2024 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422961; cv=none; b=j2jqiMESXeuqcpmWLFDMChRcYwgitU/ZtiDCmZCL7C8cQJbygWsKty7VjTvC0D5Sp0ZqJ+BqoXM/960FWY4kTPOsNIukU47oMqyJGKzL0l2SCsEc5WKK2aZsPnqG9SFGM9uaTbpl8VzshY75TkON2gOjoMFhxaKRKl4MI7jgjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422961; c=relaxed/simple;
	bh=YZIDna+Nw7Nb23XtlYPw5rT7pMv1qHX5PotS8Nu/1Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QP6n755/7fmr/Vr1uOz1CvMmhgQsjcCTMyJXcbfQLjeflfMBoPryez8XOAGO8k2b3mFJdIoeq6pJifwGYcK02+8nm4t3OY/0fjtM6t2bxx78Z7hOaS8ya47VnktRG9Joy7i/AZNyx/P+aLqEhvmuPh7FjZBeCUNBtUs8by/Wqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX6WsMZH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso1278319b3a.2;
        Thu, 31 Oct 2024 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730422954; x=1731027754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjDi4l6vEO1+WFS2aicMTlZT3n6TL7cER+Vr/4E6ZEo=;
        b=AX6WsMZHCRljslgezs3esaFjVievgtetdGVb2vQ9JqdU0ADwcf638JitmbMojqczxU
         GJC6+pQ4g3xIqAXmspdyWOYIR9njhNHePmRU/HgYJ2RVMYVBun4PTRsMcId9MUYLbLF6
         P3VYy2BYka/UIwgDaeg5U+D+NZdzzrHM3xEDekKNCB5uaZ+KykrL8sqelnN5IG0iH8NJ
         6UR3SI6toHzcqwkNOIFBXSNnaZCT0kGQPDX6TCzxiEkKXkIZMBbZ27b7MLgRNtuAbdf3
         hy7lI7CLk85Ut1oCrugm7GBD9Vf73w9kFw/7b11QiBfTtWeSb+6Wix0Ho9CGw+1lng80
         mrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422954; x=1731027754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjDi4l6vEO1+WFS2aicMTlZT3n6TL7cER+Vr/4E6ZEo=;
        b=ZGkrqr9WRjruz27VmhEPWLPaZkEiuHNOUGdwCTBTDswzwSbtyRtz9WC1wyG4u3nsvu
         trC7vPDN5kyxz4mzpaAvy9/bcQN5sJv4G6D25cwo+Hr1vI3blU5bj6NvnfI8ms70fleu
         4Dtz1aom4DPkxD/a1AfsBylcjn57kFJlLxSXtLk1xzdSIibu+yNaEGKDdkiuIsYtYpBU
         ZzEmmNBTaSjlcrk0XPRGCVmjYsr8Dw+JhvqsthV+8XhEBL1fQdoy26FDdSSq0p5MurlW
         qA1c/uuoA/tFAxKo77bgD/8rnkfGKM2Gc83LNCCAKkPCsxJEeW2kVgGsrZ88ti5HVf6f
         fSNw==
X-Forwarded-Encrypted: i=1; AJvYcCW1JRUBhsyxGdBP+w855l3erTNmQCbHr+By3qgudy5dAegJX9qGWc6G2RpKcY2gNV4DMvTJpjS0drX93Su7t7k=@vger.kernel.org, AJvYcCXVDMYWaFrsBTICiO8Z/jI/iDKRqDqOVHBPZ1vqsBOLE/aaOitl62CmIHNxxM0eryoG7NGDTSmcqQ5yLzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEUXhcnQ+9ztVmuL4AF5W4MhTev705Ud6J2elI6zB+Y+r9GAtK
	mXfemynaMw7p8zMghA85Jo/E4wzcWyGTvb7UNioMK7i8pZKE1mA8
X-Google-Smtp-Source: AGHT+IHhtMYwMi2k7TtJQkwncbROihJEQz/Z+Rv6bBIiZf8Etqi+7+J26vfBxCV4iCv70+DHdTj12A==
X-Received: by 2002:a05:6a00:2384:b0:71e:68ae:aaed with SMTP id d2e1a72fcca58-72062f81e6dmr27887100b3a.1.1730422954152;
        Thu, 31 Oct 2024 18:02:34 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ea6a1sm1743403b3a.74.2024.10.31.18.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:02:33 -0700 (PDT)
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
Subject: [PATCH v5 5/7] MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
Date: Fri,  1 Nov 2024 10:01:19 +0900
Message-ID: <20241101010121.69221-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101010121.69221-1-fujita.tomonori@gmail.com>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
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
index 2250eb10ece1..6fb56965b4c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10171,6 +10171,7 @@ F:	kernel/time/sleep_timeout.c
 F:	kernel/time/timer.c
 F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
+F:	rust/kernel/time/delay.rs
 F:	tools/testing/selftests/timers/
 
 HIGH-SPEED SCC DRIVER FOR AX.25
@@ -23366,6 +23367,7 @@ F:	kernel/time/timeconv.c
 F:	kernel/time/timecounter.c
 F:	kernel/time/timekeeping*
 F:	kernel/time/time_test.c
+F:	rust/kernel/time.rs
 F:	tools/testing/selftests/timers/
 
 TIPC NETWORK LAYER
-- 
2.43.0


