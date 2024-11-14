Return-Path: <netdev+bounces-144700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28E19C83B9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E207B27254
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF91F7797;
	Thu, 14 Nov 2024 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Mkcfra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7D1F76B6;
	Thu, 14 Nov 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568031; cv=none; b=ruA+vEgJZ/ZYwsHnokkjJpxWD9Y+aQv9XDjC/bJJq7sm6u+Vy1oKxD/31ttcstz/tLijYVgrSB+MsbfRgEYg9ZXDUF7LncN0kiAzs3STuFM6uMMnqiZryBIh4IiWJxkRIU3JcH16Sx+A/zUQpPolupx3o/SfJAVPcCRe4Ck7NS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568031; c=relaxed/simple;
	bh=coO/62PFielIrZRTO+usYpn2tan0xME9EFYmpjouIPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J///Hye/g3riqd0hk+TbRezLE+bb0d6Jih07Um5StAKj+yGJQlESzp2tGGEB4cRSTMCfMzjJzOEb7b8UFa4kpFLC3E56zQ2nh92795sn/8EftOv9cfFDqvrXsLLQJDQxjaJvGaHVnaAgL9YfdyCL3pS2wbeD2fMRP2T/40Qk8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4Mkcfra; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c714cd9c8so2613195ad.0;
        Wed, 13 Nov 2024 23:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731568029; x=1732172829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDf3qaNZuFjpFW/AdnAs8K9jS8fTv/EUiczvsLPk+9k=;
        b=Y4MkcfrafM2JzrLrMNJNnao5a0Ebmz904NLT8cFOy9TtcfAx0T7fruuEKrOjayULVu
         5z3+4m0dvHcaye5+TnxuXTX1MeBhiHTTv0hrePZNgBRGFCsJiGVFG033Ux/NL+7uOULX
         Y9e17E2jCIHIcqfCHUCUUizE20WHsYEBNWakLk/Brg3pc1iQU0Id5yEROJTLkfwV1UkE
         j+7MU6MvVgYHMdOE1uu/yeSxE5dXyTGzb8GoEA9r0iYgCnbDB4sG4oIwfKrPTYm429Fs
         H7jk0tZ6LjaTTWSsT05WzSzN/XewnCbEyxbOD2ulAevHyrykMQkORre5HwB68QR3X6te
         oJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568029; x=1732172829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDf3qaNZuFjpFW/AdnAs8K9jS8fTv/EUiczvsLPk+9k=;
        b=PgvLtmKThBsY0l9Bn90UG1ACyVR6kv7XDT9jPzslwI3Sjrh4c4d8XRycrbzfN5SZnH
         d+VtHJhldJSdRSfj/Lf8Z1KX/g5mGwiYOI0zhNr6I5S/N4Qw8w3p+CUJLxm50ieJ99OB
         4mM9/0RTNJy1dgIIAhOb/Ox/VjOZdZU5HWYm5ByeJog4GEIKxFoEKTk8haokHISQ27Dj
         6IgovlNuqaWZgwXlIVo70ILniEp4AtW+KQezZK/gJ3LZEHq+V+BDHwJPkdCuMeYYd6hb
         /lkg5g2ynX7fby7DCxgVpRLb4EfcCzQXNE8voC6cpSk6TNAFCBTn8lvyUjvDYyrBAVYk
         RKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/l/+gE0YURVhZjHBTJfw63eqg2LWdAoipqs+7bp8gMFOZVGO9ujcZ6Dwx6kmftf/zXzPgZO/1clOjGhbUaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65pgIBr1dlAnNaj0Pq4Jve7xVNHbKTQI/V3hnfPTscJH3dPUT
	NNd2LeFf1zVbv8TECHOA9oUrNbnnodVgrkuOZ//TyE0E5CHm7uEOHNeWAOg9
X-Google-Smtp-Source: AGHT+IHXrERLGZfkPf94/cBZFjn1mjI79ApKerufewROWOtHV8p5cqTsreZmlE6wcxcLAwgsWI4CcQ==
X-Received: by 2002:a17:902:e892:b0:20c:637e:b28 with SMTP id d9443c01a7336-211c5092094mr11987835ad.39.1731568029285;
        Wed, 13 Nov 2024 23:07:09 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm4260315ad.244.2024.11.13.23.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:07:08 -0800 (PST)
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
Subject: [PATCH v6 5/7] MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
Date: Thu, 14 Nov 2024 16:02:32 +0900
Message-ID: <20241114070234.116329-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114070234.116329-1-fujita.tomonori@gmail.com>
References: <20241114070234.116329-1-fujita.tomonori@gmail.com>
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
index 3a24287712f1..9a7899f3685d 100644
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


