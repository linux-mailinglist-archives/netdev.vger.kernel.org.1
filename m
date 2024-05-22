Return-Path: <netdev+bounces-97464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E60488CB816
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241471C20F26
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E081586CC;
	Wed, 22 May 2024 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huLa982i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B608158203
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339734; cv=none; b=aTHIzrtnLrd+wFfsL1nps+pqv/1Z0sykMI44YgJFmBr0vy37NKyJ4CQT2LbxGrFLFkRf72CcZziMtbTcRWYLQ4MhVIM1b6Wok0RvG2l6qIiJ+TXk48mAZF4TOWTcdFfSzOqIzK3G/TcSU8WoxRaMBZMs8ISHU6GGCVd2yx4tzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339734; c=relaxed/simple;
	bh=cNihbrzeHXKylEz/SCN9dJ+kYGl2jhozgZowklGSBnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IS1IjUqzN8jtT5kv9u3nsJVutK/1/yBRsqnWudexHVj8Tds2vCsU3xOihhXuuwT2e2SxXWDGjlPHL5kmpMns1qnrxCh8sKTn/rlZiHPHyGazD9YK/oOXd4bmWIwAHGTN771aUpPYDcJm4aw7Jezo7u5awEEmUenjfy9eSed834g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huLa982i; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f6d7f0b304so31955b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339733; x=1716944533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAsd/Ppca2ejRhM9/9MWOjE3ktFAjB1L9G3cs3vun20=;
        b=huLa982ip39nhYcAJ+yjNXdol3toF+VODR4r88JoAy3HWw8LngTRTJYRVjiMvFraBx
         684LfoMT38IpJgArwassPpy3tQYzS0k7xDRR2HVtM9tvs5ywB1Mm7TG+DXKbVec9pf7J
         vjGjRtxs7UpdCh/r+rAqIHjNtp/v96nphwVRYiz6wuwDOv+jd5D0rdr2dsS+aTvNm+EG
         VFGqHFYitUmPQjMqhIW0zNCvpPhBdUEAPY4Vj06xA1CObBPWwDc3a1K2RUI9VtL6Gic5
         kfnJsw/BDFvmJuAq2bAhomirpC8Ao/hbEff86KrUbO7pWaMREBoAshq1A99ZHiAPwknT
         5OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339733; x=1716944533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAsd/Ppca2ejRhM9/9MWOjE3ktFAjB1L9G3cs3vun20=;
        b=DC1dZOwkYHc8JiZjuqD8OtkxmTSEqciE0V3xo4iDgjKBHQriR0dwDgLqaMVBJUCuBK
         xmK3GR2hIgt+widimUMsbjU9IIo2Id6sMF6XCgPd6k3Cfc0++9bAm7BRlKaWHnuEIb4x
         7LbokVuX0NVfSFWNi47uSOTdukYQR9DU8J8SMGIE1asAEP3uPrxvktCH7oshGkqEXRLd
         L1BNNnbMv50uy8qgvbu5f9QJ8x+P5OeEXmkSquctp2/Hh/tToE03SLXElgslBUMGZoWa
         tIceCqWD/9b5+pg3bHdCbxYBtMHq4ZG75R9G/BLSXFxeFzMZRz1IBK+C7Wf1l9ciIGFE
         QdTg==
X-Forwarded-Encrypted: i=1; AJvYcCUyObL0BkGDjOrr9q0Ot3H6V+9/mNTkOJpiwHtSpYqyHDr9f4VO1G0AOXuAOmOGQZkLCz6ebxPgdtzK1gNaIH5aasn6+Zfs
X-Gm-Message-State: AOJu0YxRZ8Y4Pphsg13fk14ji+AfI0nMtsDYy1vELTynd+phsqXniz+f
	Z8hZkjkzvhWhWhEf+jwAiCFZ00qXY8hDg91NiWh0CR8y8tOf48f4UPNtjG8BeF7S9RbZDhflUpb
	WvQ==
X-Google-Smtp-Source: AGHT+IHH7wkPUdUjgwa1/oOxKhUosXdZXQHCdxIhj9UD0tOKCukjPqh+CALUTfw2/d4x2W06CEkVNYszUyc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:aa7:8888:0:b0:6f4:9fc7:d21e with SMTP id
 d2e1a72fcca58-6f6d643e499mr24375b3a.5.1716339732719; Tue, 21 May 2024
 18:02:12 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:41 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-56-edliaw@google.com>
Subject: [PATCH v5 55/68] selftests/seccomp: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 1 -
 tools/testing/selftests/seccomp/seccomp_bpf.c       | 2 --
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index b83099160fbc..3632a4890da9 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -2,7 +2,6 @@
  * Strictly speaking, this is not a test. But it can report during test
  * runs so relative performace can be measured.
  */
-#define _GNU_SOURCE
 #include <assert.h>
 #include <err.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 783ebce8c4de..972ccc12553e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4,8 +4,6 @@
  *
  * Test code for seccomp bpf.
  */
-
-#define _GNU_SOURCE
 #include <sys/types.h>
 
 /*
-- 
2.45.1.288.g0e0cd299f1-goog


