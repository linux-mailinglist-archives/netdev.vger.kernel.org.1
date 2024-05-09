Return-Path: <netdev+bounces-95104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA58C16BE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7291C21252
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099D713E04F;
	Thu,  9 May 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liKTRHj5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54B13E3EC
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284978; cv=none; b=G+2PpUZQG/8W3CXpDiKFkztws8tOHbpLTPOTuvPwJQ2nIjNlSwo85aysNgK2vY++ulJt9s+EIQGGR/QIZ2Sc/TxQYIawh4jPTxXthgT3pflMaJ1ipJjbXPIEgWtWqOP/tu/XVf1jB9KsPD7OyIL6TPrawI6vltjjuhHBP2VCO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284978; c=relaxed/simple;
	bh=qtfxhXik4RCIYvSYFE6HURw6GVoBtbaX7K5kkbVFZRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=knUrACf1RfAYJzX7aQgB3UxmdSx/gbBYT7Bak4CbJF8iaqz5qJT+uxRxbTsxShDWqJlPAS1kCdYsHDjZ6anm8G9WsajGvQJjdwymlJx0s3eqtLYTk+vPuWDBv3tDBZxOANGRs9RzbFoIMRgQEKxw1loISG6nELCmPuW/r3INUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=liKTRHj5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c1f7169so29089297b3.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284976; x=1715889776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3CKdOXgASsJuwLQx7CbN/Z0GEpdiG1ZeUqLcW5lHOw=;
        b=liKTRHj5QIl2eeitf4x/5bWfCNGxhp8r8dnYaOIPmWI1MNDMzuNagiD05RIxM6waum
         snRusMQkRA2NUbZll+v/jKkRjAX7fQMhhcDbMIEi6cUIF/W4grtN/tlFeborPYaEzhxT
         dB0bUCjoQP88oWjnvM3vgL5Fwcfdv+qfxi+Rp2r++/EUThWJMIDzrgX/96OqgfDPlhZQ
         jXRQefFujsw3ptDjuCGpSroy56/2xURucU10FJ/QAFh3/M9S7iduGnMS2p5kUZiVCxtB
         RQJny/Lvudn6/k1t7b8JF3fGsNsH/yGPHA6WiU+z/ZkZuecScwDFUaTAMS/ONf8UPASO
         VuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284976; x=1715889776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3CKdOXgASsJuwLQx7CbN/Z0GEpdiG1ZeUqLcW5lHOw=;
        b=oOH7sEwZ+nevpzOCrMvtqesHj2y07B7iV4XCpe6u8l3dJcfJgaCT754EUDvaA3Lf7L
         pAuagNfonx9H9/stbUfDbfemlJBqbKKTH8+HQrTWAQISF2uQp48cml6REZyej6Wziu8o
         Wf2qEKvtk5hTm/ByfkUJyYzQEnV0139VTlK69ZhzKIj6RCOQkKeHmgVsbJ8V4ICgmLJO
         9ZM7rvmbmg6Ltf593XVM9eth8RYFG9s3QIh5V/bWGDeGHA3uB67PhSSz0XsDlnB//9NK
         ScfVCVGHYmsyo4jEPzYR5pTFSjK1BI0JJAvV0sWH9FdPYIa4TpfUbG6yFERawvVSITYK
         jixw==
X-Forwarded-Encrypted: i=1; AJvYcCVJxGqHmv5qMwrUa4ONCjeQEerxWtjLH+INhDmEfv0LFRhZ5bLrR0uX9Y/pcO2wCMSNK3xvaYLxWcsorwJrl/CxJqU0wZc+
X-Gm-Message-State: AOJu0Yz6MjGaqOhwJZvBcxbnJd+9S87uB3ene6qrk93/hE2WG5cDNcnk
	t3Uy0OyaKMfmI2/pS0NxK8/mnUaQqWSwGtmJ1TtJVN1pBHCwnZl/6NwE3y4Is074clDTavimNsf
	4Kw==
X-Google-Smtp-Source: AGHT+IELNadyHUbcHsqAN3f9heAaXfLRA5Nts7egCHjZl0H5CAKpMh62vMmCQrVozei5uUelqCkPsrmDhOY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:4c81:0:b0:de6:569:325c with SMTP id
 3f1490d57ef6-debcfca9a3emr851927276.4.1715284976566; Thu, 09 May 2024
 13:02:56 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:36 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-45-edliaw@google.com>
Subject: [PATCH v3 44/68] selftests/pidfd: Drop define _GNU_SOURCE
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
 tools/testing/selftests/pidfd/pidfd.h             | 1 -
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 2 --
 tools/testing/selftests/pidfd/pidfd_getfd_test.c  | 2 --
 tools/testing/selftests/pidfd/pidfd_open_test.c   | 2 --
 tools/testing/selftests/pidfd/pidfd_poll_test.c   | 2 --
 tools/testing/selftests/pidfd/pidfd_setns_test.c  | 2 --
 tools/testing/selftests/pidfd/pidfd_test.c        | 2 --
 tools/testing/selftests/pidfd/pidfd_wait.c        | 2 --
 8 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..e33177b1aa41 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -3,7 +3,6 @@
 #ifndef __PIDFD_H
 #define __PIDFD_H
 
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..84135d75ece7 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..b6a0e9b3d2f5 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index c62564c264b1..f6735eca1dab 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
index 55d74a50358f..83af8489c88e 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
 #include <poll.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 47746b0c6acd..518051f0c3a1 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..53cce08a2202 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 0dcb8365ddc3..54beba0983f1 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/sched.h>
 #include <linux/types.h>
-- 
2.45.0.118.g7fe29c98d7-goog


