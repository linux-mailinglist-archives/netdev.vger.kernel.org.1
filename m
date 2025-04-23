Return-Path: <netdev+bounces-185267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127B0A998D3
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556BA4A262D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6927A2957AA;
	Wed, 23 Apr 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmXX85RI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF6293B5A;
	Wed, 23 Apr 2025 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437334; cv=none; b=BagKx8wqFch+nGd3gC3cvl4mQvtqBwk5VohDcRGsV6h781e21HcOmcOGl64dhhxpkaPf6K7ZLke4FQjSElomO+qml5jGkv8i15eN+RZyw87UPqP3uoJEEtem4M6T8JSqIDT64TguuxiGMXyRmp7wBeHjonazEXIXo51yGNm9gPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437334; c=relaxed/simple;
	bh=4ZdUq2tzBznByojYCi0WA8cKaEHmxfVFiiY35QjqGeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvHGRcksUfKam3JuqqjTtScliBa0ofO8oYjam3yRe/oziVKW2UfXdIBM5/Px9HL7/tWia1HSc6/PFjiS9DqU7B8ykcy3KAryuaLX9whDsA3HSbFgoEEG28lkzEl8u1GhTcwMV/ivrvs4ITqOw8VSL8J5SLz6BFnHpVhpHT1AzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmXX85RI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so334930a91.3;
        Wed, 23 Apr 2025 12:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437332; x=1746042132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBIIB+/ZmIi8Tc2LcqXAgRSWZd60kP7sw7lnOaM4f9M=;
        b=hmXX85RIAtMQuPggXYQd1hxa7W4Df1yKq4A2zSl+0aUoqsmuEnJHh70hlHVQ8qi501
         os+pjuLzcg0lCZturKWWVu5kLToFYyF4dqj/yFW8OK6wY//8WbD3zOTPU+Zuqui5QagB
         BEhMDEYcsur9lh1uIJrI+blqgoYkC4kpCh1GS8koGa//zdTNTdIuh/GQAQEwfzV2rGnD
         y9uaOfj5W7wz6YKpaWeO+6rPP6qt48bur4dpCEpNXli+48BChkee0p5qXQBIzc9+33rz
         xE2LpUeOvA5F51+/1E5QgRyJ7O8S0xCEOzhPsDQh8Z6EyUtNzNX9DwOGSjEObpRtpC9C
         3cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437332; x=1746042132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBIIB+/ZmIi8Tc2LcqXAgRSWZd60kP7sw7lnOaM4f9M=;
        b=XCKO8bGgdpe97p/GlI0kCOtIqq8fzPlA2V2hbJw9//i05XffktlXj0bVWPZZDfQk39
         5cO43RdPHQJpg6AsYhcbttCvf+KvrYLG/zOycbb+Gszm2BuEwhy/HpqWl1T9Bp7e6bC+
         09PCUzqgysTIOYs1SECAxQd1ZfufDXiRr8ogwBrqjPT9POpF/hxTvozmIQCp3UAjqeev
         M5PlfwUwj5zLpaZaoxP2qf6te2gZo/rUVFgHHEWz1SisqZfhXxDnO0obykFSxjG6d99U
         AfMJeSGpcxsSQ62grmhoOSW3F9Nol0nQi4LtWOnAb5eHGRQhBojwQ1Dt+l9jBe3cYM30
         CSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVshvQ7dBWi9MPjNjPEF0I0NjZGxzdyUMIuRgnmnqt5qX0i3wPUgFrmUqtskidGaM0PUAy7UvkL@vger.kernel.org, AJvYcCWImE7UveCMWk5FlSiJCfIgXmcZWwCAd2jEzxqmiZG3Cc4+8h+b7uDxo8nEhS6og3Acw2nTKAjkDRHyYgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvrgCwk8DiiDO98XscyH+ruJfXKdbyKcz8IQmeQ9d2LRLzd3lX
	BLhjrj7BHtgJNqkjX86Ws/yaLxW9rs2Fl496yqHbvSjetYiIhgEM0wCcDp88
X-Gm-Gg: ASbGncs0hCk80o+l6YNCvVImAl6SSurpGZvVtrOsaC7Cdz7YhqCkL1XAMts1aO7rH2J
	VDuv8JwqfbjnOyHyAW3yGlCq50bK77BUsywBsjbarhdBtUs5DuYQE8VnjEX2KPiJIfskFw9n7Kc
	KRWYl+dLY+/BLAqgFxQtF1a5iNTKbWWU9ku+NhKpiFJl4cVmlwDf2rEUm7DzrqXp/7IeKNKB81/
	LNI7A2hUQ+y5NBFiBFO2wCKw8O/ExJKV+dHjOlbUdEmzu08kPoX8xNKXOqs2EvrRqknoK54H72H
	vPGhhWt81Caf0VsXlXwV/bT9SSczBb2jnp5OWk4QTmkP248QKs1TCmrdAKyvCCjLDjZd376ppzE
	xUKauhoUmkkEuI1fInw==
X-Google-Smtp-Source: AGHT+IHVHb8f5emrtviZLG/qufveIt8tZsd+Ml9sZN+0I3m7amvYcQpN6eX7VVzpqWUE/VNgi2h9Nw==
X-Received: by 2002:a17:90b:5488:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-309ed24bc3bmr93692a91.7.1745437331875;
        Wed, 23 Apr 2025 12:42:11 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9ef918sm2056475a91.7.2025.04.23.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:42:11 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH v15 6/6] MAINTAINERS: rust: Add a new section for all of the time stuff
Date: Thu, 24 Apr 2025 04:28:56 +0900
Message-ID: <20250423192857.199712-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423192857.199712-1-fujita.tomonori@gmail.com>
References: <20250423192857.199712-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new section for all of the time stuff to MAINTAINERS file, with
the existing hrtimer entry fold.

Acked-by: John Stultz <jstultz@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c59316109e3f..3072c0f8ec0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10585,20 +10585,23 @@ F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
 F:	tools/testing/selftests/timers/
 
-HIGH-RESOLUTION TIMERS [RUST]
+DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
 M:	Andreas Hindborg <a.hindborg@kernel.org>
 R:	Boqun Feng <boqun.feng@gmail.com>
+R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
 R:	Frederic Weisbecker <frederic@kernel.org>
 R:	Lyude Paul <lyude@redhat.com>
 R:	Thomas Gleixner <tglx@linutronix.de>
 R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
+R:	John Stultz <jstultz@google.com>
+R:	Stephen Boyd <sboyd@kernel.org>
 L:	rust-for-linux@vger.kernel.org
 S:	Supported
 W:	https://rust-for-linux.com
 B:	https://github.com/Rust-for-Linux/linux/issues
-T:	git https://github.com/Rust-for-Linux/linux.git hrtimer-next
-F:	rust/kernel/time/hrtimer.rs
-F:	rust/kernel/time/hrtimer/
+T:	git https://github.com/Rust-for-Linux/linux.git rust-timekeeping-next
+F:	rust/kernel/time.rs
+F:	rust/kernel/time/
 
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
-- 
2.43.0


