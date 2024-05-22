Return-Path: <netdev+bounces-97437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9458CB785
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4846D28773D
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FBC14B086;
	Wed, 22 May 2024 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBx+aRsG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695A14B06C
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339650; cv=none; b=guiMQhd13x2G+JgDKBfC/2Hu0ZjnHhp9BgSmJcZmzvuP6ZpWmFnvrlrHhUEHmc9JGmAusK5LG0aTRJAKBhT35WLgrE03AApfRn6PEL3ksxT8MUB5qtleIhKKTSRtie/pCSsFYHS+fgYPIO+ueFFB845fKNgVlh46IdZvMRKgT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339650; c=relaxed/simple;
	bh=lsQ42Y5Htgr3DTEtIEz5DolJMzdlzKLlDpLP6Gf0KXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JzgFgQRq/rm78oEZCCtmtLDqLNAqEAnQWmEnKja5uz3CdIyD90CNG/usRg7vz2EMl9uzakk+i2NL8iwfHqWUZYEQfA6RP9vG1uSLl6+CPrkQCoxMk31AmDLzw4I4As6a8sg5RZXEI++LJ9/zY0O4dZt3gVxMwwRvMCoHA5ENPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBx+aRsG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61c9e368833so260863727b3.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339648; x=1716944448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yAQSiPU3Xxpg5se1jVwrYALJE0mXKiuWYh1IlCTKguE=;
        b=DBx+aRsGrh43u1T1Bdx0RBdlDC2H0IJkLaia4U6o/JP83zOgcIEc+I4V630p2qBfVo
         MfhV94JD++lDmpnUJGolpYOa/gcikUtgEb/PUuz5u03sNsqEqtmy4DnymaQt/+U1QiU3
         H5XrO57kUalPd8+1Pg7Tv+T0s27wlP+XCVBxUzIDjroxUwTNtWWPN62oGIgn6J7wwBRJ
         KsQkRUSgoVksiiILKhosxCD6QSiateUyDkXHA6ONP8B64Wdbn75m0dHe0KQmiVwLv07E
         aCf3FkS3Q91WT9AeSSB1xiJswErFOxevLTYCyvmZ87MfJJB79ur+yhUYVZ1ZRYvUrxJC
         6KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339648; x=1716944448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAQSiPU3Xxpg5se1jVwrYALJE0mXKiuWYh1IlCTKguE=;
        b=uxV7EqXTeTj92FPDGiA3xHzspTmjcjYCKX73/Extbu/8YB4gfQ6uDdp/C9nb3Iys/V
         3bjxg8u1VXqnW9DVFQTBElAw69tHgGeGEoRaQz0F5zwLEXJPJ3mQiLu0pmWZ408gYjg6
         da/EpE6d4EiEXhplR+Vt7vCkcb5CtCFP+TmFG9A6SDl6Ox8cwoIG+OvX/xCaMJ6pEmLL
         irz/dnhfTqDoRpneM2XYxf8C4mE+ZaEyMIHfmmfcKzAOGyjSCXaqi5rifjgzhw/0UAg7
         4miK4fmxB5K/Ky4FjJaxJVvrliGAcnQJ2mqBPV6NSq6nb9Ki6Eg74EnTmmnnPmrQRvyF
         +sLA==
X-Forwarded-Encrypted: i=1; AJvYcCUrTQjvbnxpMBGAnwkUTJcGfMM/eQX+0qhNDexFUotThqPRxj8lRsOZJfgVQ2cyWjAZAadJNuNUYJ9hUKnVjQWd9FHMwHxR
X-Gm-Message-State: AOJu0YzY1Qqgot8AfyNNA0qicHediFEN4HVgi6F/NYjBVb4vW0PkIttc
	iZqF363WnXWeLeuFy8pvMo9OWOU4jOpWolE9X1GZoGh/4A8T800iTAJlCztGLaTl0lZT1k760Q8
	yZA==
X-Google-Smtp-Source: AGHT+IFjr+dMdwwjSeyKVtDvj71h4a27dlU6zI/2JB6uVxDlz76u2lFmfPLoHDWhwCSwvHwm9NN5UxukkLw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1083:b0:dcd:88e9:e508 with SMTP id
 3f1490d57ef6-df4e0ab542cmr224908276.5.1716339647973; Tue, 21 May 2024
 18:00:47 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:14 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-29-edliaw@google.com>
Subject: [PATCH v5 28/68] selftests/membarrier: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/membarrier/membarrier_test_impl.h        | 1 -
 .../testing/selftests/membarrier/membarrier_test_multi_thread.c  | 1 -
 .../testing/selftests/membarrier/membarrier_test_single_thread.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index af89855adb7b..a8a60b6271a5 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index 4e14dba81234..c00f380b2757 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index fa3f1d6c37a0..c399fbad8efd 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
-- 
2.45.1.288.g0e0cd299f1-goog


