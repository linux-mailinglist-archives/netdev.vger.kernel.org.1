Return-Path: <netdev+bounces-95105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DBB8C16C4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF735B2587E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960DD13F00F;
	Thu,  9 May 2024 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSuxJZz/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E768C13E8BD
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284981; cv=none; b=ojiDRc3QiF1PETRjeG7qfUGdkfX6P1cg/YlHdIBR4ck0yXYjYIRsLWzbc9qzVCo3nL+cPAblyWES7OcreNIba7DER4jiV2Ynsegj3TqBbxBb9t0amS1skp0eD7uqlV5UAbW7rpqE/FISo4QLKhoezD+2UTRqo8maDuDPTNcGtxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284981; c=relaxed/simple;
	bh=Yhucvb4XvEH9ebVKmn2tHmUSyiCYlyI/y4adrQ50D4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TbihR5VNgmx8uB4HJKwW/lAj3HXSRKPX1uKEQIzu5KIcwUuGrFMGQQHhqgmp/axcZaejnIvnuYwRTJJpBPdHkAxQ7sCd6n7oVQ5PH2XyhrVUvToanWxaJ7dXtEPoRVGjmJSHXFSG+QPY7BD7ptbohZlj2P3nWCu8HuOy4SHBYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSuxJZz/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-620a2321b0fso14049917b3.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284979; x=1715889779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvmtJI8ym3OlQtCXEUxM/omnRwwmEG5jK8JE00ZU37Y=;
        b=uSuxJZz/Mm4cknurqiynWSzrcEqpcfyAQzgyus5COBBuunzwRoeesSU+P1keFW/CFw
         DQHIRPhd6D8Yk4GIUjh+pR1W4JTBNf/8UCtxWAFsgjg+U236MFJyadOjKyIMlOpzCi1s
         +eCVua/hX0X2AAy+Vpv8Sys8UrFoWhHTXlkCu7WsqiXAkLq7FjUzy0Fx2+PHA9ibatLq
         uPpHAfr/iuHqAkt3wjLtVU5uy+L88YnCRO1oqmLPLLOcruLUfbxH4OpEZn3S2gV31btC
         d1ZFmt77v25m13I6S2qft1pFLBw3pXT1jjOElh7wta5m+4ChH/qr2gy4+bOJ7kD7/O2O
         lzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284979; x=1715889779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvmtJI8ym3OlQtCXEUxM/omnRwwmEG5jK8JE00ZU37Y=;
        b=OUqkVM4SRFhcJSh0f2VfuIV2dEQy4AnF8+RnklBilkDpTM/ISesG6V0ftQ04s5Rw0w
         FdXjRHYiccfvbX2kgTMYclgNXWUf6IoPEcCN3sHjOERp07NJasjcNPraURAkJcYubJMp
         mMiMrLOPZxSNPfi40KxCcOoxdgfFaBzdfjRHN+iWD/Z9LUfRKh5Gdj3J3S84YOy2DwZv
         6dKZn7JjU8Ses6cHEHACsI/20Ufl2uLrrH0X6ttHgKlj6LlZCynsa8U7ZZlRjUr2nz2s
         7EaLHgvYTgYoVj2ppAB8KwY97+QbA6p3CtjgWo7+R3lzYfCJRf/HKQsdXdsSgRrdK8/q
         BjJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLBp/j6Afuu5MabUFMpAJkxXCwbdB5IHSyqN3YcHpOZYhTTg9AfI2ANLu+zmJBqC0VT0U+qKzel1irp/5RHJTcG+gydkfp
X-Gm-Message-State: AOJu0Yz5tySHn1vjYnhzEZqfEBqW8HSb38C3FmqMwXCI4haagf6iPmzg
	vifCDtJv80fgEUKud7aIw/4jIgX9ZStKG36V2DTyZBsz2zSEJw3yk2hQwzQ8g3jbOyt61NJr/tg
	HkA==
X-Google-Smtp-Source: AGHT+IECWXJfpRwj4dOARyjNpf5qmoqsg21f1i+unVXRq4Ddyrt1gCo+t8C3Okd0lmBC5HYwEwRa9oXboTc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6f87:b0:61a:e7f7:a4cc with SMTP id
 00721157ae682-622affa4dc7mr1321267b3.4.1715284979174; Thu, 09 May 2024
 13:02:59 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:37 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-46-edliaw@google.com>
Subject: [PATCH v3 45/68] selftests/ptrace: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/ptrace/get_set_sud.c | 1 -
 tools/testing/selftests/ptrace/peeksiginfo.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
index 5297b10d25c3..054a78ebe8b5 100644
--- a/tools/testing/selftests/ptrace/get_set_sud.c
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include "../kselftest_harness.h"
 #include <stdio.h>
 #include <string.h>
diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
index a6884f66dc01..1b7b77190f72 100644
--- a/tools/testing/selftests/ptrace/peeksiginfo.c
+++ b/tools/testing/selftests/ptrace/peeksiginfo.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <signal.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


