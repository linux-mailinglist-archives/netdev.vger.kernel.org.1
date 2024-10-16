Return-Path: <netdev+bounces-136026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC099FFC9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF862818E2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269918C346;
	Wed, 16 Oct 2024 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+foAIVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6118C90D;
	Wed, 16 Oct 2024 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050843; cv=none; b=eXbGlXLQtxj11qgS2XaOJu1SqBmQEKqQBerJ/oaIBfOkaY01fkadENUDfl+HuXUEUmdH6sWx1UbmH+bXJNKaGblUC4YiuMxLRrIPwWYAWAQSiA1ry2oqHbib9gGr5TCmSpG1FLcDs7PqC2BzvyDBn04qk5tV6GTrRcT78GdPaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050843; c=relaxed/simple;
	bh=VgLWI+AjLBx8Ja7xEtqgZgZBMA3LJvFtYSnH/F5Vxc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr7TomvgLoxfzS/Ucy4RmAYiveN1Vjoi2HWjQUt0baMW8iCRe+/ilN3iPrIS5ZyYlKjHrhgFGLvqXcAPg8ldZemcki5FBCSeIhAYUbVUfmjbHFn6LcWlYOU5USpJexyDoNyizTz6avHPCc8pK/tcdT3Up3R2w6fTcvYAAgfkgUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+foAIVR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e34a089cd3so2617594a91.3;
        Tue, 15 Oct 2024 20:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729050841; x=1729655641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Woj+2pHK7bC5CLcfrqEjzTTpY7289fmk2YwH0hzw958=;
        b=X+foAIVRy8l3MTP+fBgNcP8f5/zihesZdq7zCov0q01NEhqUlz4oZP5OSXxUCPMfwF
         00dtvUDrus6mNx8pDF7SIK6Ei3J3Kn71JIB7AtWeqR2V2WYnKoVEZ8SizI7Aw9z8Ng5G
         U6hmsUNC56L+103OpZun3mJ0+BL7dDN0im2j6cjXVA5yW0VAU1ytP63hCZ3hOWfev4Yb
         8y7WFv8lz68pwzdkgHcdbMxLjfNulXUQPGU1/10oPYvtvKP2UnyJB8ApGU2CCVMwG0bF
         yHfTLIxCpqsrP87VfB2PUc8KAD2ap+p4KazL9zvkuNe5sXbUawuqAj43N9Njz3rGXoDo
         U/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729050841; x=1729655641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Woj+2pHK7bC5CLcfrqEjzTTpY7289fmk2YwH0hzw958=;
        b=jmpopJU9k7LhBkjzxakjlLkOQOI89izNpCYVZqCUitxlAImmA0mwAfpN8llX6E0cdI
         HUcjjR/75LIx+xGPIvW0GiyoqK/CY19WtWbo3doRkbGRg+OEpwx7xC8xL9lBZ8aCQ+yz
         neWTHt0eO/3/97Ed2CRxi9nT2Rg+O2xjV5t/O6OwDDnj/wWo1+QHera7p0gUvde/2drN
         G/Gr1D2ayxU2gxe8drYbzkRw5ayH4VqvaW+ztWYpYkBqzfXIitr/aMfzbEmiON5gKqrk
         2CqrSyG1RQpnvGzVQt7S7VTsfze4NC4IInHKOX/bNTs2Kny3F/0zJ49AM7+7bBVGlxl7
         C7AA==
X-Forwarded-Encrypted: i=1; AJvYcCXHyRmqkjoajbOfVU0NQq29XDf35snaUNz7n7S/OGgjUl3fJNLiC63sAhLLKiVGXx3Z0zidCd8IWq2hcXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHmh/SN5ZtoItdOpkBqyEAlVntjyn9mhOg5PwcqYecAP2pwhf
	q0y83Rb47B+AwRZRdfi+Za+LUvIwJIIEF8AGiKAO7I9c2q2Jfg/jTUlsETZa
X-Google-Smtp-Source: AGHT+IHMmqygum/tEmic42aO376l8Z/b8aPxK63tGMO9TYQnXDAdlDD1YCniFmgmLGT5hcdUiZIDog==
X-Received: by 2002:a17:90b:224d:b0:2e2:bb02:466d with SMTP id 98e67ed59e1d1-2e3ab8dfb4fmr3211675a91.33.1729050841450;
        Tue, 15 Oct 2024 20:54:01 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed1a4fsm2885691a91.17.2024.10.15.20.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:54:01 -0700 (PDT)
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
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 6/8] MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
Date: Wed, 16 Oct 2024 12:52:11 +0900
Message-ID: <20241016035214.2229-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016035214.2229-1-fujita.tomonori@gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
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
index d678a58c0205..faef059c16b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10172,6 +10172,7 @@ F:	kernel/time/hrtimer.c
 F:	kernel/time/timer.c
 F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
+F:	rust/kernel/time/delay.rs
 F:	tools/testing/selftests/timers/
 
 HIGH-SPEED SCC DRIVER FOR AX.25
@@ -23382,6 +23383,7 @@ F:	kernel/time/timeconv.c
 F:	kernel/time/timecounter.c
 F:	kernel/time/timekeeping*
 F:	kernel/time/time_test.c
+F:	rust/kernel/time.rs
 F:	tools/testing/selftests/timers/
 
 TIPC NETWORK LAYER
-- 
2.43.0


