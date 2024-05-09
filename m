Return-Path: <netdev+bounces-95091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418EF8C1679
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2C0284A95
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061A13BAF4;
	Thu,  9 May 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFTp/NUm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED513BACE
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284936; cv=none; b=dKlIHM6SgZEZwMGQ/bRQHNXcOi7an0Ui+hUZHRZLy7hdz4YqAcH3p7J7NgD/fQDP1jxj05hU5dzLifNQUpccU92MQiYHNkiF8xELLNzMSk1alfg/MT2WqgSEFPdkmmGtg/HVzgaOHoVBSisjTDgLRG2FBWujO0X6TvWOhgD/2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284936; c=relaxed/simple;
	bh=Q8vMNdjv6oUz3ffMNcoe90QZDt2uRoBqgozhP5DTiA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l7l+chy56IFaDxE9N050KbphgjzE+8VdV+ZCChQHckjPNU0nswxuK7rIEcNEa0C0KLXvsjk8kQvQgqJTy9TUMhwb66drLGaW3YNU7hE6clmUetsCD+Gd2Sk7x+6QvwJQT+x6Co+7tmcmhsOlD2ZWKeTaPBMan/9AxjvwAMSRPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFTp/NUm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be23bb01aso24374767b3.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284933; x=1715889733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ea0S0oR7atF2Lg5jk6+sVnhZ8gGTM0V6dmG3kMF6TeI=;
        b=IFTp/NUmnUR+jPPz4ujog3zcMgIwi3YGl67rPta55u0EYf55NSd92iDLr2zqaMJ7Ge
         a8fMNeB4LzFmiXwz34o3m+tI8GnDdJ+ie3emfW5JcPmxnXx7gYSvly1UWadyXOmY9h5v
         kDWJ8Yp5IfDhmMylqCSkgemMI4oK0PtB7qXiuB1Kb50H2b55NXwB6rtUmNpzJexISHju
         2oe0f9U4h+k54Ha7p1H16kdt5DE7mbYTMfvZpKiOy/x5QbcvoMkk8IJXCAGljyHI1G/5
         D8tN38y3Nv52Blzefk+23RURsZW2ZEM29+cf1dl8TVik3dSk5Fc+GVXMU6sDuYCo/ALZ
         lq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284933; x=1715889733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea0S0oR7atF2Lg5jk6+sVnhZ8gGTM0V6dmG3kMF6TeI=;
        b=aachKnGNh6GEwEEVOzkGBXMsHQkt/Hit3z2H2nSTPn0MZaqXjFtgCiLIV57vDL2TzS
         TmBS+5M9WTIM1rxy43We7iWdDjkrs0hdj2WaJEZlahDNgWr3JusqeMwYSV0PUPpI43Co
         lFe7fniRT8q9Ow+AWR8vE0W7jDcBDTg/Y7m1GVyLSiv0s+ofR6mcluRx58Tybxr25bU/
         FsY30vn1ek9dZajL2vuVrlUWESbmZnmFxMhtdGkX8usvGloMJg8t8rpgdm0TpEgY+O3+
         m2SiK1X+2K4dIOprSllKhgfq9Cob2SKqOXAsebIb8qHPKyWYJvXY7+Kl4YEv5P37Mo9C
         vJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP8wsg3uUsz5Kjlr+eqWV7XylEj3i+EBQiMS8c1ZtY5sjde0vqsU+fOoXhlxA9Zc03UnTaKbfEUJ8VxQFyoSj/Xc/ePLID
X-Gm-Message-State: AOJu0Yy7gd7I3NR3serxXttF/CiUb8+uZ1Tk9Xwa7C4usUrssc5kOLlm
	DI4FinNYfx9v3jf4mnaORRsyiH9t0WBWgW4N+j083rMKCH0MXzjMv9zoVf1Z7ZHHissjbTQiiDt
	ODg==
X-Google-Smtp-Source: AGHT+IF/jnDS4ymNWQMUF/oWdD6iqbobUDLDZUHVjJQIP+SRjrwW5c29IOEMwIEB1XpBJKq7KUUsEHKahpI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr149190276.9.1715284933545; Thu, 09 May 2024
 13:02:13 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:23 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-32-edliaw@google.com>
Subject: [PATCH v3 31/68] selftests/mincore: Drop define _GNU_SOURCE
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
 tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..e12398366523 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -4,9 +4,6 @@
  *
  * Copyright (C) 2020 Collabora, Ltd.
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


