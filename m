Return-Path: <netdev+bounces-97438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF28CB78F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F0C1C210B8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39414BFBF;
	Wed, 22 May 2024 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+aoStCl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12E14B95C
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339654; cv=none; b=bS1mzCiPB63n/Bkn74BqsI2d+G67K5Px9j/tY69cxL58du2U7IQwfCC92lZZOJAonDAatp6X5uJYCAN4ee0kfTtW2C0m2ZrhH61HraeitqCJs/SwWoP6IH9g6BE+Nb5ASDQDrkVsdcaDq4HgjMd2Jo+vleGDI82l1I0yDd22Egg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339654; c=relaxed/simple;
	bh=7z2cK/G7kUfriq3IqJdcywskZOy0/wDKMEFNF/o0umk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BgWohV1/DHqCZ9+Pd5EPFW2bnGfFNeT7BU8S751gQYGFePQqrAHTipkqEIIkqcnnJvsQvBS+TAp7Trs2wZtaIFYSdjnzvumlbgTYIVIzUM5i/w9E9vOUWye3k7vaTPurPy6PeQkyZtiEITo8vZ/G2RFTcHMG21Bdsw+ikRyyYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+aoStCl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61d21cf3d3bso234783567b3.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339651; x=1716944451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N8L5ENa9saWnWy7VMZgJQvy8O2UHKdWgDS9fdPg7qj8=;
        b=k+aoStClS1UiazscDoVQLOM1WVf0RmO5j3vCzdBb4D8uC0FairiuHEy4kDINYQG92Y
         5Yk4v7MdtvSR1nCWWK9aibo9JsUKXyXIe14d+RHL8dNZkKw4toInGYos+KiTJTOIEWPi
         tb+uRifwGfehat5dUl2AyYXhlw1MuLA/gYufpEuJifwEF8OMZdgZJXjOebj7ygE6tTSi
         22Rji/im/i2tUWn57HaSd1sFPousoaAvCyWrUJS8oa5yfLdY1RZ8/8q2cdLUSbsLWYuA
         AaN+29Eo+pEOyivrB6z0OQDnXxKLMUg9Kjcok0QYXhpwuUZ5RiNvrGspG2yEGUMEs18W
         Dbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339651; x=1716944451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8L5ENa9saWnWy7VMZgJQvy8O2UHKdWgDS9fdPg7qj8=;
        b=uKOlM0bAiw6oPNi+QbCxW/RpBrqR72D5kO/O3CG4fSddhK6V7Q8s5Da5+mCU8xOOwP
         txXNXaltLTFF5EUERp3eeRmJ17jg82vrL1Lbsve+v6/aQGxUCsso/weViB3fbA2KFsQu
         KAisUly8KpH/HgkU+5oqxxR5EDHAJ3xdc5+v2ZsZW+59q9ZEX8dx0vE++Hke/b5YUVus
         E/FQjO0n0UMm0/XhRXO3KyMnwiO3Xxy9PLZ5nioHPWkF9iY7FsOWPDKa33qYeqyjezVE
         u/pC7PUgUrXQm4Bv/tQgKY0AlkeeXq1yijTyGDfNEQi18YlwgLFixGUwIPIbevwMjafX
         8Qxg==
X-Forwarded-Encrypted: i=1; AJvYcCXLhfMLyp4WipvPa9wPqZZL49Yvk2WEYUvGFo/e9U1X15dbHTrYh50uakIpUEQwUsA97oMe2PrDCHROF5txoVnsbxZSM90F
X-Gm-Message-State: AOJu0YwMyDDPRwDBmJpWFNlzNf9phllu7+wDOMVfMgsvzcPMXvVE6szQ
	U8XQkyMCwqkdBu1kHIgbBfbfsljZgr+OEUPfWJXUe63QwLENhCUctMPFSAKmrDNdT1dlmFKXlS5
	f4w==
X-Google-Smtp-Source: AGHT+IFS/IZw7uE/6kkYjIq+Ri8WqRBtijmIEiJcIQSsTtS4Ny9KcGMsd6Vyi/YUNyZQw3Hok9pzmfMHEIg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:d5c7:0:b0:627:8b31:e81 with SMTP id
 00721157ae682-627e484a333mr1542497b3.5.1716339650801; Tue, 21 May 2024
 18:00:50 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:15 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-30-edliaw@google.com>
Subject: [PATCH v5 29/68] selftests/memfd: Drop define _GNU_SOURCE
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
 tools/testing/selftests/memfd/common.c     | 1 -
 tools/testing/selftests/memfd/fuse_test.c  | 2 --
 tools/testing/selftests/memfd/memfd_test.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/memfd/common.c b/tools/testing/selftests/memfd/common.c
index 8eb3d75f6e60..879d4f4c66fa 100644
--- a/tools/testing/selftests/memfd/common.c
+++ b/tools/testing/selftests/memfd/common.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <stdio.h>
diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index dbc171a3806d..e35c6909f0bb 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -12,8 +12,6 @@
  * the read() syscall with our memory-mapped memfd object as receive buffer to
  * force the kernel to write into our memfd object.
  */
-
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <errno.h>
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 95af2d78fd31..ee019b57bb98 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


