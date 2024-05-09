Return-Path: <netdev+bounces-95075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423AC8C1625
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734BF1C2037A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CFF134433;
	Thu,  9 May 2024 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1grMg40n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACD13440C
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284892; cv=none; b=QGYjky/hiLzZOileNLPbtNYX0MoiM498+1mjQm8tsF5S8w3A9qmPHzH6xRYXE0ZFOPm3YWkJ+3Qn4Ti51Dp/LJh1PwvnxnmnM0rDXwAe99hL9Lq73CV7+7VyzhTMqoZyNemS0L3VAAgzBuuR0B18Lunu3cKSwsVS7oOlPcQVt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284892; c=relaxed/simple;
	bh=tTj3M6fIal5DHH8k+Tew/M8u7hiv4dqwU6VGCuE8kiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JhewKwfCglXKU+HUmE/bfLmAUnmo/RdOrCZro3syAzKx0WLVSsBeoX1j1kqwBEsTNzfqTN38/7XYhNIK8McKM4a8Rjjy5fr0CGK4FI5X37NqLWcL2Ud6Ruz2NAUHiGhvunNWu/ZWEZk0MYqLzWgAXQcM3Mz5Jq51LqM4u1fqSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1grMg40n; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1edf507b9e4so12719365ad.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284891; x=1715889691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SARWn1297sTaPTixNcZ2P/NfR3z6dYPtI+wY0CAAJVY=;
        b=1grMg40nSGXiqE+I6S9kiCAhvYqAMfdhjtlFh9ujPrB66YhywAywE20mBO2gQYUIEA
         TBuJwFMk7tmy9o14MxBJK4LaAe4yFTSbr0Us9UavbtfnNtT1XDPXcbfVK2ONsMzFENWE
         rHOnf44B9sy2U1+7oL8rZwQGJlDIFtCAt7bZtS6t+qr2VI4ECSEDiM7MsvgrnsHw6xKt
         wQdVQkyNbu4HfnRsKL0to9G2E1ggVyQos0omOd/GYOZwNLoiL6O9uFbhe3O7ZOFyYcUb
         W3P/Tq92iPKWvDunZFpamvlqcy8u956fK3tlvj1BcFjwxppIA5wnx538kP9i0tRLYbI5
         IWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284891; x=1715889691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SARWn1297sTaPTixNcZ2P/NfR3z6dYPtI+wY0CAAJVY=;
        b=Puw6Gnv5GsKpxLN7ElNkIW15SasgKEDEMxA5t1bTS/Dgw6W3qCTra8+i8/NpMsuBEM
         bWCSdxE0mccCz2htCLdCX8jlGtCzMS5P7C3ADwOEf3AAVm6t1GmgzE7oKh0hC2iuKP2v
         52/w1NqcywhW+6ls7+I8QgFFXECMzk/YSIg4Nz39ty6wNYvRqIn5ohsoz5qGE/nGLh/U
         JYP6M/tPugb0DZB6BINGCQo7i/zbkU10EdU6QJlFoBrqemAwXs+7yo4ooIs8CbjwnO8h
         D9ywpZ1jwc7sl3FY4RAJPPZlOmNWgTt3Dmm/qTdNNUnbOfvYXslc5nx+beorYLikkvn6
         6mcg==
X-Forwarded-Encrypted: i=1; AJvYcCWxBkB8z4IQWrmiFsVmassAlX0LsvPvfKxjJKLRpd6I9vr+8WZJtOcE2Kmt9qCsp5Ns11FIPMTmKKCXPQwC7tDVhOKIry8b
X-Gm-Message-State: AOJu0YysfIaR3dRXKBfpOcJr2NNyBz23pkL7qIskH4PpdC+own5FvTtV
	NTNBqyiLzSb59y1zdItP4Z9ZCElvHiO0aqHbLwwHyG12OOHgRXvXB72rYiF5Ax1Jz8SB4k8hl4v
	p7Q==
X-Google-Smtp-Source: AGHT+IGdQihvGYGHF6PdjZpZUUK6gc/kNAnaTsu4e7xw8HeMCFzPLsdZMDhNcn3aU3W22mZMcXJG1JBkESE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:110d:b0:1e5:62:7ab5 with SMTP id
 d9443c01a7336-1ef433d9bc7mr28285ad.0.1715284890584; Thu, 09 May 2024 13:01:30
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:07 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-16-edliaw@google.com>
Subject: [PATCH v3 15/68] selftests/exec: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/exec/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 3c79ec9bf780..18d7a1e5a416 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
-- 
2.45.0.118.g7fe29c98d7-goog


