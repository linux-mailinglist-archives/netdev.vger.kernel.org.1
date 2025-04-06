Return-Path: <netdev+bounces-179450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC8CA7CC7A
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 03:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3636E3B5010
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 01:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3B13AA53;
	Sun,  6 Apr 2025 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdrAySVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67848136351;
	Sun,  6 Apr 2025 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743903351; cv=none; b=Rk7NNoH4cqh1Ig42drrbNP5RvPbumG4Uo3CP7sdCcguFkVzGPbrXKe2PWklLuukY4y3J0ojcQP5J1TLbATQqT+DhF/YKnrm7W5ZiF22bO+9JVSHp2QFFq1ZJyzXcoxqA/YddQwGAtdXg0SXKrXDK6Nmf/bvW0R8mHRN2UUCyoQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743903351; c=relaxed/simple;
	bh=SRzA+4cwuLWbi3l+rrGRpJ0i0ekQpxdDzlpPMeSGvI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/WlOtoT8GJDNSZrkc0GZ3HZXkrgOmKkL+3KSC2nqnE0FV5eAuD2KC79xZ5ziHiOhTszkyv2ZlSnqQcKgN/ijGODTPdYJ2DGdmNMQjxqDpKxbGO2ezfIINU56x7DNGPg/7aKFM8e897Hs2a/puQFUE5LHhPSq9Rt9HBQ75pnNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdrAySVH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b98acaadso3082245b3a.1;
        Sat, 05 Apr 2025 18:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743903349; x=1744508149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfV6c322LhNIzDcptdQq7JkAT5PgJ5P9MLOfezDMm4c=;
        b=YdrAySVHJ2opsTq4DSUOh3RzauNGVleIdvb2AX20zGIxTtJJnz1n8Qxhj6/Fu+1itf
         9rn7fwYI4ZWA9cld+QirLHThoWq1zWWvf/a4J8IGEyUsez6lDSfMSBXAKdrZHvmMquk7
         ykiuK/xWhzvGSOkclhuQ2syQED52hUwP0vkhUp6BHXK2kNgTjEcWPdAMHokXtTKS7F9L
         HXrgW00nqRFHPFDBcQCLxghXVwZrCKsdDQbCjHfdfIIEZtwRk6BUVHaeSWOTYed9JA03
         Xk7PY6f0nJ8SNnY/BZhkKtW1Nl2fDdSN3vse1Is2Neq/rhrlwQQNKer/b5rlPv+Lwl/Y
         gNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743903349; x=1744508149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfV6c322LhNIzDcptdQq7JkAT5PgJ5P9MLOfezDMm4c=;
        b=U9+OlQBhi2S+Wh2dsHPg2l56OD2B9gZd4+nNp66TIA+UATBWbAhAaN5ozXyO5OwHug
         yDDG2pufHzjxavO9wt8OpGAR3MNhTebSQD6rYisE/htbaoOsDsxUvQgw2BBBykYr9rKv
         Mil1qCNHe68Ar0xWQM5dPRo4vYvu/2HnvyNVS3mEkT1d9tHb7Nh2j8QwuT+VQ3k3w4ew
         r0UELruP52rnjEye4yvwYVvjDophiuya2HHU7bnDcsku3B73cA6YXPOyjV2V0O0GD2+v
         84INkA666lRCo+gCMDNl86wtHcB3VD1ieuBRpWWMrjiRfjvPKjK1QUdcHo6Ai0k3EWe5
         aHAA==
X-Forwarded-Encrypted: i=1; AJvYcCUcK9b1F3pyS2VSG504LGNN4FFVa9s1wnLVz093st/xNgzXK3WBqEzaa6k3OA7qICgY6QV/p5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgV69NKJvkMjswB9SsM1G1QBlHZLf684EM+i+qQNrRJ7MD+6/
	d3P1LIV/OEKu3kH5VlvbDHUKBQpc3Dy/GC7yxUQWxH7BKvjfZkM+dhw3UJFp
X-Gm-Gg: ASbGncvlXxhRb4XKiazVd0lMUTaPW+4NM4RPqcydlAw/YR++F5kJJ7dapK4tdhqSowa
	i2xGaP5jZNhr8OdglvA//xKbTtDOhs1TeeiQ+8EbELPLutwvSJAUj33kS9KM81FEjswOCf/emmF
	rTKOYQxCejmPZ/zqwhzMAHo99VRKIN9fJRhGSD+DlPGViN/DUKWoYF91FwPz/BP9YtH7Sj0yGUd
	pDlVIJ2THuSlcdKlt1W3rDoSJBI1xwCJOdEekbOF8pT54eVMF/oZvwAshoKLtObfdCty1v2D77E
	onM0zCsvKeiJZr2UKK0+3iBK6oTJBRcm5I+6/0x1bFOwU5odLuKLkbRaeDKdO2hkLC+iBwLe6gt
	CulPuL73li7GQQ2YkgYQaQA==
X-Google-Smtp-Source: AGHT+IEpUDhA1POUXQPRGA+uLs2g/QiNP48C8u7+VJ4QKBtX6WUHQsTe3TvseG7lQb9C2WXizf1tAw==
X-Received: by 2002:a05:6a00:14d4:b0:736:476b:fcd3 with SMTP id d2e1a72fcca58-73b6b8fd296mr6864136b3a.24.1743903349373;
        Sat, 05 Apr 2025 18:35:49 -0700 (PDT)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0bc052sm5846849b3a.156.2025.04.05.18.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 18:35:49 -0700 (PDT)
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
	david.laight.linux@gmail.com
Subject: [PATCH v12 5/5] MAINTAINERS: rust: Add a new section for all of the time stuff
Date: Sun,  6 Apr 2025 10:34:45 +0900
Message-ID: <20250406013445.124688-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250406013445.124688-1-fujita.tomonori@gmail.com>
References: <20250406013445.124688-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new section for all of the time stuff to MAINTAINERS file, with
the existing hrtimer entry fold.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d32ce85c5c66..fafb79c42ac3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10581,20 +10581,23 @@ F:	kernel/time/timer_list.c
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
+F:	rust/kernel/time/
+F:	rust/kernel/time/time.rs
 
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
-- 
2.43.0


