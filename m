Return-Path: <netdev+bounces-97458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45598CB7F6
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59903282702
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0C15535D;
	Wed, 22 May 2024 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFl9/zMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF0155346
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339719; cv=none; b=aqwxDaItIAHwt5Rjpn+PR8sjSIFbj7pZwhYxHaH1k7N2WA+NuyGHbNmStKsjn5XVrF7+9nngI6hHmtOKlKpcLZucDSeXu5U876NY3U9oZ6A9VcmairBaJRZO4/e8ozIxicR8WcRykV78S5esJ3vno88L05lUh6rM2vp+eiYYYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339719; c=relaxed/simple;
	bh=GPntLq7+5p05K4Kj80a1ofx+IxdVyo2sAkOefotHnTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uo8pU9BGrlXx6YEymFNa/5ESP1B4QwFGZt/06b0c1JEQ+lYUMMH1Z/FuQm+FdvhKQGJvxTVWyg1lfwR8Y9T6NNpXpu6n7r6zM+EDOw5QvDCQoBip/sp8G53Nu+5nGx1je6ci2FhEShQchd9GgGlWJ/LLwmrCThlrdxdlRPDJnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFl9/zMw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee13ebef37so135804425ad.2
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339717; x=1716944517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdhZH2VylrS+6EeGuf6ae6S+DzMPS8o3sFjSdgWRyqU=;
        b=kFl9/zMwn5EI7b/RVWPpEtdc+LAfDjM+BKyAI0BIOqU+xCr6lCAjQQtryha6e+jKpU
         5XGSpoaegMaFwNMVdY7PKKkRh+DOC26jvMqNZNLJS/pl0oPvVG35UOvkCzv7tFnJEvEc
         tacqLzavXTVhhFRu/IRbEl5QsE/qTm7GMpM+BFxtViA6S2qmIcTQPDIITDnC4+Hsnb+P
         jPWkSar0nVDKVGEAoKcLURcAIqqDqDOovZfoEFDcPXlvrNBLDHDCMKiJQYskh4L0MNea
         nCy1plRH7hpADoDx00SqcroPueS32Os7SbxgElU4IhKKoYfD0+pYdXmHz/kHiRyLuKqJ
         2N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339717; x=1716944517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdhZH2VylrS+6EeGuf6ae6S+DzMPS8o3sFjSdgWRyqU=;
        b=qkDYle96cAtpGWQeYmMSYogyVzgJlu8/psMct22DV9PCp/P+bQvt9ZSnRrRUjSOX5w
         mTx85LT5J0dsVSBtVmHGJ8CfvFlMfCD5/drj8ZsYMkmHaj2jgPg1eXJj9mv526u+quXs
         1ydMJOLrDFJ7VMj6tP1J7NOzktN8VcQE0dXj+kcin3AEo6cEF2EnNlrcKbELLLbIZAL7
         lcnZs4PgagWBQm0XCgQ0CXjtZHtFotvgQU6d1858z06US4SFQyWlGcWhvkxb4osITLYL
         1uSO1qXZlqr2YETlx+oYJOEJVj4BtvZutbigmLpK/LKOAFecs+M53NzwKM+cE/R7vK4A
         KvTg==
X-Forwarded-Encrypted: i=1; AJvYcCXmMx8tln4kZ/8qmy5/QKlRIFIWMQlSlNJ9XyxhF3YPfagqg5/UMfOI0RSu/IyBzKTv+B+x98nDq+vgOSuKnCQUcEoiOaWA
X-Gm-Message-State: AOJu0YxVTOcbvnYfCI4Qa7KMWELrBoqV3+PfK9UBvWCW6tTVFfs9eTbZ
	7RG6i5DjXBM5LZ6B4KKhn+DGtw/z1GvG72zU43zfYryZaDrTJ94XlhHsFTc0zzOQXbRwfce9mKM
	xqw==
X-Google-Smtp-Source: AGHT+IFXkW29jWSmXKYdgVJioCSYV7fU9D+QDgsIm3BIsuSFmV/S8sHX1eOFRDsg9MXg5XjDONxLYS9KAdU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ea0b:b0:1f2:fb7a:19ac with SMTP id
 d9443c01a7336-1f31c9e7df6mr65215ad.12.1716339716964; Tue, 21 May 2024
 18:01:56 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:35 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-50-edliaw@google.com>
Subject: [PATCH v5 49/68] selftests/riscv: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c        | 1 -
 tools/testing/selftests/riscv/hwprobe/which-cpus.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index a40541bb7c7d..4de6f63fc537 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -5,7 +5,6 @@
  * Run with 'taskset -c <cpu-list> cbo' to only execute hwprobe on a
  * subset of cpus, as well as only executing the tests on those cpus.
  */
-#define _GNU_SOURCE
 #include <stdbool.h>
 #include <stdint.h>
 #include <string.h>
diff --git a/tools/testing/selftests/riscv/hwprobe/which-cpus.c b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
index 82c121412dfc..c3f080861c06 100644
--- a/tools/testing/selftests/riscv/hwprobe/which-cpus.c
+++ b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
@@ -5,7 +5,6 @@
  * Test the RISCV_HWPROBE_WHICH_CPUS flag of hwprobe. Also provides a command
  * line interface to get the cpu list for arbitrary hwprobe pairs.
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.45.1.288.g0e0cd299f1-goog


