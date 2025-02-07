Return-Path: <netdev+bounces-163987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B19A2C3AE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094E43A9EFF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5E21EDA1A;
	Fri,  7 Feb 2025 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJHgrs9Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208A1F4186;
	Fri,  7 Feb 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935134; cv=none; b=LOLIlDSH99YpFTaEbkVQq4TH6j+LJHanYxITOSfdD2/ZrR25uVIiA70WB7uiF6GrAktK4yd+2+W8MMkCKudncE6qiF3OS2LscpeApK2Fgt1Z8/VGd9BeMyKF4OWnn14U7kCgDhSevNcOpH73n7CjWaDWtJgBpwlG/rnKd1P5Rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935134; c=relaxed/simple;
	bh=W/xND7oeOqSyZuG0lyRIYpdb8PYTcr+3m5N/f6E0YAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzTaM5Uq0nqYez1q1JsZnvCeRrRWsnqy4QoK4pgMsU6ZbQCII2lOShsZlXSCf2MfBIJ/7zWWj4EkefXZKV6VMW3AyLtZuyfWysvg6IOqT9k2DNYbXLt2YkzcwbsXY3noTFKCfFu5SFUOyjWKCQIap/FrB0XdvfbwSaiwnsI3N2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJHgrs9Y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f20666e72so42893735ad.1;
        Fri, 07 Feb 2025 05:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738935131; x=1739539931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy5Hy6LkAGAxIDPrWVxfWAbE7bDJcs0zc4+QaIaJpio=;
        b=VJHgrs9YU5UPFIRjrqIgwohhG2ooJDBg0s+JLorFJIw22F7Wwl3Un2iq70dRxZl/3f
         7l7KbNBruiFPCEWBcuwAtCO7GBjK60s7SSwNcJdRy+LIrhueS/a2Dd6NAUtj2aFrz9Ip
         uCjo2LxVvICZFhTifFs87Z+6JqL5Xkj4cxBcZvew1vvQMI6VruDJTtsH/B3PoVuO31n/
         jJuSbWDDpWuaYpwXJBx7bnmSc312gPpyGICzDTQDBEDesOWdHFDigPAx0DbA4+lA1BRv
         PxWnLaYDes0IBPuxg15V/bJfJI1Wjhy3XFhbYnyc4UXclkDIoNj5TSj+vKWwMon84I2u
         2o3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935131; x=1739539931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fy5Hy6LkAGAxIDPrWVxfWAbE7bDJcs0zc4+QaIaJpio=;
        b=TJT+ra0vDVgVz3gjCVmkhp5kDyQ6EYMdNRokrpLP1IzcD26D4oLRpkY5OOxlFdr+RK
         qQ051L/q+RhdctGNZ8l9gQS6SIyb2eptGYg2vBprxOAVJ4um4dGmU7qRhdGig6ROCyFU
         Tlr3s2xzlIMWF57ODL9rpRZUwqcyjOT8sl6Z5ahgqVDjwYBy4Npm6xkAF3PAiLvyqgaR
         rM7FtImxmokWQQurhAn2mGDzcbGlAc/AxDH24vLyuSDRQ7cGbN1MUGlwYe39rUFcsC3V
         Au4AqHELS4Jp+zEu0PGGVCfRI7zDQaZEkZnlvmrK8p/tkw/efDyuGZiFC8k1SACPDIpm
         qXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnbzS8CzVgO9ZNSiGNC1NvSRtPW9fRecYhXudGC7VY2WY4NX2zz6DbFXdBIdSJOV13Y/rbsxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHHEqRRY17SqfFvEhX+YWwvLRJoRQ+70DzIp6eEwFjx+7ys7AO
	4JRtypg1FKa7HxiaF8+P351JmfU8GCuHXBkVeCqlWNqgNQago+XgAowQaZ+T
X-Gm-Gg: ASbGncvUdWkflXc66fN1TA2FbFzpSOl3yaRRMD+iql0MapvbqhvXOLOmIB1zDR52Krk
	YbJbzNMeoERpfa61jyvpv+ZSWG86QyAuTKEqyLltXtgJHs4V85SRFET+wq0WTitjse3nD9Cxkpi
	Y6/lp8EuzGgcqypbZRaiwNGE2GYh5rbw0yXEWHW/qGyTDQftSSaMtU0KHjr6RkLAn3MHYuk1qMZ
	4avaD1yZf4aZhAOQo6/jF7kAyNA8AoNdxHEBzH1aqueyn1nkqDX+TDFDFgfkk4pmyDK0+jq0o+V
	TeNaNgBsfZgZ0OE7+DLGstp7znasVBeq83L08RMiThwtB6PsqtgL6dcoP8GncPgzP38=
X-Google-Smtp-Source: AGHT+IHdyLlWC3x6DmOvH0dr+XHTfI1t9rk5NvgYdws/iiUCWHn6IT5fkEAHlJ0PoEd2WSEJseQTGA==
X-Received: by 2002:a05:6a20:438c:b0:1e4:80a9:b8fa with SMTP id adf61e73a8af0-1ee03a4149amr7173803637.13.1738935131624;
        Fri, 07 Feb 2025 05:32:11 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51ea79a47sm2877843a12.76.2025.02.07.05.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:32:11 -0800 (PST)
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
Subject: [PATCH v10 6/8] MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
Date: Fri,  7 Feb 2025 22:26:21 +0900
Message-ID: <20250207132623.168854-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207132623.168854-1-fujita.tomonori@gmail.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
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
index c8d9e8187eb0..987a25550853 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10353,6 +10353,7 @@ F:	kernel/time/sleep_timeout.c
 F:	kernel/time/timer.c
 F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
+F:	rust/kernel/time/delay.rs
 F:	tools/testing/selftests/timers/
 
 HIGH-SPEED SCC DRIVER FOR AX.25
@@ -23852,6 +23853,7 @@ F:	kernel/time/timeconv.c
 F:	kernel/time/timecounter.c
 F:	kernel/time/timekeeping*
 F:	kernel/time/time_test.c
+F:	rust/kernel/time.rs
 F:	tools/testing/selftests/timers/
 
 TIPC NETWORK LAYER
-- 
2.43.0


