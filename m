Return-Path: <netdev+bounces-97449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0658CB7C8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D211F28CA9
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F11527A2;
	Wed, 22 May 2024 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/ucLtSs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250BE15251B
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339691; cv=none; b=ou7W12oECW81CaeQVI/rO+UifgLlkm482xYzCt8CLY0zbFLDks4d1EUgnwe+6ilD9lcU2tsdZDq6/HTKTnKCWbMa2QTqOqZYlhVH816DAFD5BtjtY+jTjT8v5/5AFcNVFIJ5FbuQAtxAH9JmL2N1eqnRYNVwUxmE1MlV6jr5qdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339691; c=relaxed/simple;
	bh=MTodUmyJXfHVVr8W8CfAFa090pYkk2toySoZR7GP0Sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z+rVaMCMgmqQRX7p/XTPyrmuXTU6vRpmxq/Q1OjKgW8VClsA99jAQbrd3Hf+oHFoV9W7Codx0fHNvIdiYvk3AfZFNn3IWWDkr62y185LjdohQhbzdIza8J/rifhi7Cu/NiodUTV87VKhfyNfY+mgVYhRHTX0b173K9+JpezSw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/ucLtSs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c66a69ec8eso10752254a12.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339689; x=1716944489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a9qeTCFtvuxbGsifiEmJumkkd9/puPZE3ppF8UEgJw0=;
        b=r/ucLtSsVYWgqYTaJTNB+ELgUHHbbR7RO6ag712NLigCuiAl0DRRzQBUFVoizX/I4P
         9xxiYd6mQWklDOhc8JTZYJH5Nnf2UY66xGO6HRubEKqYxM2uMgnFM1x7J6Irt5eSqnoe
         EtOTEU9cZnMbBIMGLdp5pg29LMecC1ioipuzvnJffCmdQ559xEnBsdAgUuk1zir3c4MD
         N4HFHk6RviVFj+39A7cCIs9VvSPGu+9WBLDYr3TFuOPq1rSjGEifJrRSQ9C3hUoBrKm6
         242KIPBWlTox8FHpZRpRieHl61G11kCSAm+eX0+4J0eMd4cBhseERIdSFnX/6Grk2tX7
         lMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339689; x=1716944489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9qeTCFtvuxbGsifiEmJumkkd9/puPZE3ppF8UEgJw0=;
        b=lc9Jyei6Yz8QPnHzlQ2tJ/NSWb+y+Gi1SyZOCxLGgXASKrKnFELvkkZtRSQma7XBeO
         vr1OSCuXY9k9s31c8RSN03f+GIpzwa8fEYi1EBFlP4iMyenvalWp6c6LNEOKngzLfP5o
         IgfPsWmmX0zHBGELsQ0sVijlClNn5ayx5JYAr8uqADwS5Nw8WGfTjEzKrTm2oBlbPvpH
         RVo95s2abofVd5M1jvVvwOt07urotwvdn4XkCdhsKEfnwzQ8XiEXovq0U15/EfeNyvA2
         Evix/Bqqbna+1VvCPj5qx2mwz3l0QCc8Mm3hckjkRj65X3qRgkwdQ0S0mU0wn5LN7mfj
         /RbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4l2Chb05hCsZc1U1fq8SadBE1g2oDarDlIeuHsPFep5fUgQyVdyRxOY1hft8bUGCXYob8fz2pVdhbAoN1HNuWQy8fCyI2
X-Gm-Message-State: AOJu0Yylex1tOAABxe6M78dbQanlg00zGA1OCr7uDAnJzgeobKzgbM2g
	Y44Dhew8hijGvFINWGZP2o+z2VXEvobRMaRJALAKnTKwcQQswgtgH9zfpNM4SS9O3MLhDt/f5oq
	f8A==
X-Google-Smtp-Source: AGHT+IGEcjqj8zufEeTMy6AMcaIsqkRg6a51FGXyadk70W9VXPBiz86Gg8WH59rMqAlu/ildvCYIItBNoi4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:dd53:0:b0:658:956f:9800 with SMTP id
 41be03b00d2f7-6764de8cb6fmr2228a12.7.1716339688506; Tue, 21 May 2024 18:01:28
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:26 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-41-edliaw@google.com>
Subject: [PATCH v5 40/68] selftests/perf_events: Drop define _GNU_SOURCE
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
 tools/testing/selftests/perf_events/remove_on_exec.c   | 2 --
 tools/testing/selftests/perf_events/sigtrap_threads.c  | 2 --
 tools/testing/selftests/perf_events/watermark_signal.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
index 5814611a1dc7..ef4d923f4759 100644
--- a/tools/testing/selftests/perf_events/remove_on_exec.c
+++ b/tools/testing/selftests/perf_events/remove_on_exec.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2021, Google LLC.
  */
 
-#define _GNU_SOURCE
-
 /* We need the latest siginfo from the kernel repo. */
 #include <sys/types.h>
 #include <asm/siginfo.h>
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index d1d8483ac628..14d1a3c8cb5c 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2021, Google LLC.
  */
 
-#define _GNU_SOURCE
-
 /* We need the latest siginfo from the kernel repo. */
 #include <sys/types.h>
 #include <asm/siginfo.h>
diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index 49dc1e831174..19557bd16e9e 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/perf_event.h>
-- 
2.45.1.288.g0e0cd299f1-goog


