Return-Path: <netdev+bounces-92655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B288B832F
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843481F231AC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90801C6614;
	Tue, 30 Apr 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Yx2vh98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0651C6604
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521080; cv=none; b=IUH3Vb+uo54XgVaVJ/RTVpoNBmtufV0v/9REDK1epw+kZ2nSyyrAHoq7G8iwHJWGM9PSNGTq36po8L+1qFjvEA2MKYSbaMEDDqU1Q93xH+48fRUFfiERLtLdxu30i6fcYSRrOAatThZXX8W9bhKNlUk03FK7Z3u/CIF2DFhGXpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521080; c=relaxed/simple;
	bh=hoKCCWVOkE0ESMxaMi+qTIS8AurEZYZfNn5Rvt++a10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WGF+zdUwbXtpaykFZIGICop5AZYh0nUj5SyoPefX8f1P2Tv48hq6kckmxCKHFeH9wqTlcKSrh+KSf2WifFZhgHk5ifqhT+HUOOSuxfe3Pq+ZqrbSQ+zxWpksoo7mad2IHu/0HHrXioYGFKP/nmP7wSmE1FMgBcXPgf4kIpsHkuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Yx2vh98; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so13201319276.2
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714521078; x=1715125878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjaSNnvftOLawQ81uXTzdayleIIMFIclLDs0BuljtK4=;
        b=4Yx2vh985eAUe73b/Mn7onj2pzj/LBoS71ImaFxNWPt/0DIGzmxTlaskzv3d+Gb+Hp
         L2oyQ8B+7Xe0YZPUQst64aeW5xQCZJ9QXvCd83LpZL4+vT/DG5ys9nm6CxNHyB3q2+Mr
         j9r4MsmhFMUh7tLzhQZhsqgCwU0ukuUnqw5JUzUZxw4pwyQPvzdILp98ErP/aW3/auMy
         F/8HNoZtgvnD+ZwgUY7EoXvui5bBGspVCW3oSJhWFO/pKtL7j3F5MTOtOALW1shc33DW
         Yen84kX/hc1OH9b/W8IWVNIozK+opZC24W78s/cOLHhVbp2x5QLhClbx9YC3xI7RLrCc
         n65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521078; x=1715125878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjaSNnvftOLawQ81uXTzdayleIIMFIclLDs0BuljtK4=;
        b=SJSCCu1G3STyp9bfQOraC7VnhTB32M+a49HqwVTzrah2tYFTh3bZYDf84tpamkffux
         zPULxpq6uCqOuLSdmUCQmbCG/8bVtVu692Oc136pPVtxC6UBBuXMSsarfeNp1ddBs+ng
         Jr1uhQ3ztwBDuk7llZaQrboKRX6XwrcKwzfC2RQe4pQuiIIXbZzVxzEDLQ7gyEPO6UHh
         hu+7Zf/6BqR0SbTL0DZRYHqjO44jiVfQY5vL+TLrl1Yx1FEJvgblESwRlXRjpZKsIDrI
         ihhDgLo72sKk29fXAE/X6NwI5zRcYepIc51lSxVrkciAgJ3/0FURR1fkX/4n0ySNvjCF
         Dwcw==
X-Forwarded-Encrypted: i=1; AJvYcCWP8X9F3aIomWzbjPic8wtlTweOUm4X/6x0ZXFUfxfTjXFiDeXGeobkzbyiaDFocKqfZijeIsR4fCcKJXLGDewwbuT6lO2e
X-Gm-Message-State: AOJu0Yw3aOwYJzbE4lGLtQR5btM2izsfObIbYeSohxvB/iImf6EUITG8
	X8mtBucsXcidY2KwvlWi+czGN3RtUuhGqosItJZYarqvifAR/QpxgO0EhsyJCdZAjP/XBsex+YI
	sNw==
X-Google-Smtp-Source: AGHT+IGPMJHhRXW4IxX0wuIaJEnkwrFiECPVYI3NjrGHekGnxptI0a1rv8ukdUNpyZcLuFV1IvoMatGim7A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:150a:b0:dc2:398d:a671 with SMTP id
 q10-20020a056902150a00b00dc2398da671mr352958ybu.10.1714521078081; Tue, 30 Apr
 2024 16:51:18 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:50:10 +0000
In-Reply-To: <20240430235057.1351993-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430235057.1351993-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430235057.1351993-2-edliaw@google.com>
Subject: [PATCH v1 01/10] selftests/sgx: Compile with -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Bongsu Jeon <bongsu.jeon@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
asprintf into kselftest_harness.h, which is a GNU extension and needs
_GNU_SOURCE to either be defined prior to including headers or with the
-D_GNU_SOURCE flag passed to the compiler.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@intel.com
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sgx/Makefile    | 2 +-
 tools/testing/selftests/sgx/sigstruct.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 867f88ce2570..272da790d9ae 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif

 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -D_GNU_SOURCE
 HOST_LDFLAGS := -z noexecstack -lcrypto
 ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index d73b29becf5b..a0c2de7c5302 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <getopt.h>
 #include <stdbool.h>
--
2.45.0.rc0.197.gbae5840b3b-goog


