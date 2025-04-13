Return-Path: <netdev+bounces-181963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D9A871AE
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 12:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F78C1680CD
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E31A4F12;
	Sun, 13 Apr 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCgAbWfW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5E1AF0B5;
	Sun, 13 Apr 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744541056; cv=none; b=qO1A9PV8GVM4+14TEE82oJ6DWnJsURisiomJELL9fgr2IQukGmU5A8Q3pPKfWNVd08FbY61gRKHAUbIL/fp5gakYuyLPUpLe/Kxs9FtRjjcpIn5W2kPdsWVSbOg+d+MzQ8r4vXL5053MTak3IVzKfO0qMOyUQLqcPjfeuKOfmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744541056; c=relaxed/simple;
	bh=JD2Vcha6ElX+5r3tPICprQGEcLCZ3uM4HJkKZyfdIl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCRB9VeJUzv37zsZbPwudEWOcWBR/1KRTf3Vf9AtfDd21fJbmX8VB05D/tbHV/e8cduSJQzxf5GRLCyFOOIEtdsiw1EKYM/m5ybjPX11vZqXhXtkcWgkp2KYkI9YzMcnFLUo5CPRW0JXyF8frozhCXh8e2w8LBrFWyskvyaQxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCgAbWfW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2264aefc45dso49455195ad.0;
        Sun, 13 Apr 2025 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744541054; x=1745145854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdoJvmpW6qddfbJB5WSgVAlVfvRBkfyp+bE+C2KQ9c0=;
        b=OCgAbWfW2nFoyC6v2xKjEKNGbQmAhdEx58/EpS3BNWVu+UfPVeOICaOESAWoA/gmEi
         cuj2hFa1EM7P7lHjrJC/yOaAPPVyk1YUHD4eX19z7AXzvfm/MJtjhFfENkDSD0Fu85Dn
         iRIQQGZWW8osze0Hm0hfcds78YJ8oiK2U8qQV6wcc6tbw93CkEMjpmeL08ypv3heQKq4
         PNGleKlQuUro6KCeZuUHrcy7wZwc+kkmULomOSbqebsKtRev2N3P68/xmZwIXdgXdnOY
         5Ihal1oQTd1HGkmITBFzbqS4P8nTh146oyozIpx9sDQqdf3QvF+gdRKhFd+M/Llxj2gt
         vlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744541054; x=1745145854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdoJvmpW6qddfbJB5WSgVAlVfvRBkfyp+bE+C2KQ9c0=;
        b=UvecQDdjclnAsvHNjj3tWHyKau9WqIArqZcGiwpcuTyr2L4asN1Mt1qRCA7uiiSwDj
         Drf6h0iNgVNFlFDjG21PEPGfJhXdCi9ctM/QChPzkuvHbrg8sjWcF85gggh7NXy5lfAN
         eh4hrM8duAbSl+smkspokVr+dIkb0J87aHxUJY+1K9A+IoqpWCEjmCFdlwmnh88wk1Q1
         Vpp12rvOuXx6dpnmoa3FUaXdBtLWqv41YqNXUcmOrdxlxUK8vtCc2Jeep8LTXxIIFC7K
         9fjxCtHv0of6fKeOGl+4Ba4C2Rq534hcT0O0lMmQBLTeuSiiQ0BA0+jO1VGXc21toZ0a
         42KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWwQkE5VULQbPTifN7rD1kylkTtisJ6IgYgiD7dW3QeGVUMkKTyDz3HO52yvMgO+FScHqApmaCYNuD7N4=@vger.kernel.org, AJvYcCVleSyJOBIBgWIXP8YnMdRadl8u+mrCGPuV6n3lZ2yztZf3+AYBKwvhsrxq8JCrf0RUEF7L6G8J@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYhyn2QPrpxCG1yKj6uwBMdnomtpiq6g1/zHvskPMOcv40cxm
	QhUSlgM3Mq3TUyGLr/ZZ0LrkPZ64xoMiP+s2V7QqJqGTlU09lM0Fk5Awuzf4
X-Gm-Gg: ASbGncuYf5Mv471rtOR5u3zxItnOg/8iULlt7ZSHgdxXs397ok0HfyarIV+HcieJoCi
	1GEEpLR4HvLRub7HTaFqVOJ48EV2MfcdBdYAdXhrvCmEcObWvlmQuZWdQ7sM0iatJBMQRME0Rlz
	m2dA2EKPwEMjIY5o0wESKQaZHb52lvOac81u23SRFivaIfxmvPf89Zv+Fyf6Ub4Q/BKsNd1lhM0
	Fndb6T1wYFMnSsXN8bnG7absx5vsEx+c4AUJ2RWulmtWIOm0/ywH5WUSuRQXL8KpTyzwNFn+ipd
	NztkzdGGfzccE4riuE3vs2q8PbHJgrtjifYfLaFTYAYK+qcpN/HcJLIhcO9artZqtTMV3rEOtPd
	c68QyzVe50XEcaTwRlTLeROr3Eerb
X-Google-Smtp-Source: AGHT+IFA/SwdxFVR9lqyRwioQ6mLAepuc6c36TjHQ1kU80v2qwDra/68I4JucotYa72SVT3yX3pXvA==
X-Received: by 2002:a17:903:41c3:b0:223:5a6e:b16 with SMTP id d9443c01a7336-22bea49542dmr131704475ad.5.1744541053570;
        Sun, 13 Apr 2025 03:44:13 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8af56sm80160885ad.66.2025.04.13.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 03:44:13 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
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
Subject: [PATCH v13 5/5] MAINTAINERS: rust: Add a new section for all of the time stuff
Date: Sun, 13 Apr 2025 19:43:10 +0900
Message-ID: <20250413104310.162045-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250413104310.162045-1-fujita.tomonori@gmail.com>
References: <20250413104310.162045-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new section for all of the time stuff to MAINTAINERS file, with
the existing hrtimer entry fold.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..104cec84146f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10583,20 +10583,23 @@ F:	kernel/time/timer_list.c
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


