Return-Path: <netdev+bounces-95122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C918C171E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF91288215
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9129A147C6C;
	Thu,  9 May 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGdVhBkX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AE11474A6
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285030; cv=none; b=JY96g/1zU9wE3MHeGwxff+UaNwuUlKnsKU/2TMaUD56eC+sF9LVxJm3/Ah82u6Fl8x1rrpVQE++RsuMPU1MUxdyU38XNLmKxdC+MTQcZR/epXG2aDG9gY9GQEGbRykp+PuHPHWGTmOR44j6XcPx8g3Fr6f8yBb+W9iEHg1iw+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285030; c=relaxed/simple;
	bh=Jk9WlsOAEnwbmnHRW1QFCXzqP1dOARmd0dJyp3x2RB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jeFCI9E31Ws94DPlylyo8yuazkAFXpqP50p4VL800i2jJ9PBtj0VH8HaNk8jZtqLqeRYWyZP65icjSorXlRa8rteVP8hd0gmhQe6U2tiA1ej/fxLLQWZp2FgIZuMhilIuVYMkHs837aTotPNWRUeU35DPG4US85Bne1NKYpNwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGdVhBkX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee3b4f8165so11516085ad.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285027; x=1715889827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrH27rGPbpomBrMwjXFw9TPUN7Jl3Ae++I8KKaa1ZHU=;
        b=oGdVhBkXE6V+l6B1ZgbolcieIh40J+k5lT4HKLueJ1rTppb4IfvzoPDPcxHzhbS+28
         RqISanvJ58jnNGVpC+mLkwuFP7anyIs0N684iQm2BKGaasptH8VMMClQV6nvPSx00IDw
         ZidgBjAq3LJi5suqoJlnuFI00Ld7fNdCBSrWti9LAHSYBnNiVDINWxi82REh5DKsBxbJ
         ym0w3A4Bf9rNaG0Lyk/RlDg3AWHVlY80Fiuw3u+DfFCWGT7A4qcga+I9sQ4rkrSgL80O
         geGmviCbUH/je6VWq3VQuZA7xSR/BXp9+jydg+j6InNrSEGrxVEo+/nsXboZA4sOsynv
         eZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285027; x=1715889827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrH27rGPbpomBrMwjXFw9TPUN7Jl3Ae++I8KKaa1ZHU=;
        b=comvwyzliapZ7tqmNktD+rko6Pc+omvPwlJfkOrY7hNv/Py5fqihtebwnxJWRwkbF8
         yI6H6pJcvMq/8whhqR5XbCrKKayxJVPxAGr04iaYuVL5uBGV9YPhbx++7W6ftnA3qRs7
         9j0XRsdW/vMqK7IFeG3iRXr6CXA311osWC0LESRwzrogGcCTii/GpZQkz3KxyMpvXWaK
         pvdGeALti9zqEDnWumXfWv7oc1LGqe1vEJgKzhEqEXFH13D0qjQHe7EWVVTmNQYp6XHw
         V7g9mFyuHak/shJwhT3wgzWkjtEI3vDsebTIuYP0GoaihY+Zld+HLPHiXu93VPw7RJAr
         pvLA==
X-Forwarded-Encrypted: i=1; AJvYcCVsnFjP1eM2wLKqlEq7S1YhxWRrWsqM+O7UkXiEXmoh02Bm/RrJublEklC2m4Tgj9UMU3HX9JCwg1Tr9AoDVVPgOUs8ieJM
X-Gm-Message-State: AOJu0YypQ5WLjkyv/QPsU3hRG5UPE1x8m+/H87GxnIJXPtOBMP+YITVr
	IrgcX5ISitCm/SE8UgybzVVBJhTM8i723o1V2B39RM6d2imeFx4R8hC50SEF+MDLWqgtUSaHvKX
	0iw==
X-Google-Smtp-Source: AGHT+IEuE3KvkQE4fBcoS4/aejH8+5T9BJ8+Tcefhf/wjiyYj040WpgbcuK7JYXdw/yXkY1WQk04Fq+Ou3U=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f548:b0:1eb:ac97:6c35 with SMTP id
 d9443c01a7336-1ef43f41477mr266155ad.9.1715285027301; Thu, 09 May 2024
 13:03:47 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:54 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-63-edliaw@google.com>
Subject: [PATCH v3 62/68] selftests/timens: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/timens/clock_nanosleep.c | 1 -
 tools/testing/selftests/timens/exec.c            | 1 -
 tools/testing/selftests/timens/futex.c           | 1 -
 tools/testing/selftests/timens/gettime_perf.c    | 1 -
 tools/testing/selftests/timens/procfs.c          | 1 -
 tools/testing/selftests/timens/timens.c          | 1 -
 tools/testing/selftests/timens/timer.c           | 1 -
 tools/testing/selftests/timens/timerfd.c         | 1 -
 tools/testing/selftests/timens/vfork_exec.c      | 1 -
 9 files changed, 9 deletions(-)

diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
index 72d41b955fb2..5608f2b519e1 100644
--- a/tools/testing/selftests/timens/clock_nanosleep.c
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/timerfd.h>
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f66..7f718a3bb043 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/timens/futex.c b/tools/testing/selftests/timens/futex.c
index 6b2b9264e851..0a5a81939220 100644
--- a/tools/testing/selftests/timens/futex.c
+++ b/tools/testing/selftests/timens/futex.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <linux/unistd.h>
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
index 6b13dc277724..9fe6690edd2a 100644
--- a/tools/testing/selftests/timens/gettime_perf.c
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index 1833ca97eb24..7bc389b05799 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <math.h>
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 387220791a05..7941a43155a8 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5e7f0051bd7b..378e058359c1 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/syscall.h>
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index 9edd43d6b2c1..807edb9d83c9 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <sys/timerfd.h>
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index beb7614941fb..675c6a8b2eed 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog


