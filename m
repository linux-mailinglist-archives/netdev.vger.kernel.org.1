Return-Path: <netdev+bounces-106282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDD4915A95
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC182883A8
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE101B5805;
	Mon, 24 Jun 2024 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuYj4ap5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE61B3F25
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271789; cv=none; b=QXyIgZ/0/n6Hk8IE4cA0daw8julUh7sdwG2GSc+rGwzDJmUZcrgykTQdsmfydCUacqC9YY/YCHSASorfFIQ/5fKPqFx/6D5eudNMDT7y0Maddxgo2ShFFCSqGXXh+Au2rNuw+iwPdaOK0jDvhCpON4OlRRUx6b/5cXAe9tFCEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271789; c=relaxed/simple;
	bh=7x4LoDZgR5E/QVoS9cmfJRmJxj+4a44E8Ep8Vb6AuSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K4zgVDu9JbPGHwXcfnQylx/HQEOwSVR+TGTgyyaGBPZY3fAlhbXuufHbz+5yAW5TGnrH7ZD2uXgGw2uO8vcf7g8ibzyYIJYy0yQOmxgddEPhO7YwwjCH/XqvOTG+D0l+jy+0gM7S6riDtqpj9DoSMScV6yt1g1H25SS8kUF3qyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuYj4ap5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-70ab3bc4a69so6143554a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271786; x=1719876586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJFiGCZar+q63pIILXV1m5S/VTx8srfmbdTO812oVXc=;
        b=XuYj4ap5BBVHxp6cnA/Krxeluc7KtWQdOXexVpa39vo3mc9NtKJp3n3Pi5EVyXUeh6
         DpS2xhdegtD8uvViwIzrh2kKdQSugCe1APCyQFltR/FoJ5+ZCMSjAj1qL3mG9NFR/wL8
         vmw5n63XC6Id/iNS/urDnbh3hkYHCxDGOi7HMicwuGQIfLwWcipGbmTgkZAMTu9utr3M
         JCfQc4l6tDIsJAG2o2F/M7TJgC3MkKHHQJurbnK5jR9ECA/SQ2AlCi2yEkUWz9s7uP0s
         H0iGAhjbu11f1L2TE8HxZNj/7O4ftsPKBs2sIUWHCEMFJ3ofiijj69/BzL6ZNCfvtxHs
         iWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271786; x=1719876586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJFiGCZar+q63pIILXV1m5S/VTx8srfmbdTO812oVXc=;
        b=c7ZR2fQfWLME3ipJ+Pou2QtVTICJZ5iRsbcj/Nc+gGdF72I5NX4lQ1Nb3EXUdJmEo+
         oycIW3CL9I4qGsHadchsDJ16ebPa6cIHAqNnFL2x1ZEfDaO/BZ4eaPIMUPj5NlvrG0V6
         YvOrweTpFmXt+Ph8K6Xx3JHCtSpaap/08xrQHgkQHPnr8EoSVlT0zy3Gd6nbA3UBZWTe
         IHfXglgLx9IUq15olwK1Xy38aLCylD/EKJANZ9q0sOp+a1ALXc+glJ3wiDb32r48TpJd
         /YV01bDsAsJpe92i5JENbDgzvsYizkAXsI6gXdtMr0b5G4iQAqBsVJYIU+aZOAE1sT1q
         yF1A==
X-Forwarded-Encrypted: i=1; AJvYcCVrUvGLcpYBJMyfmZ54oqpwpSlvo4mgMHu+T5QY5D2TXI0vZsWtW0O/Kl1prub2j1fTu6vsah1JagRwnR91IQROLeeLqRqZ
X-Gm-Message-State: AOJu0YxsCi3s9q04UGRhrZqsrtrdGmGU+fPnhI77rPJfAmioTC4WJnaI
	1utVuMmzZnqxekAtkVAFZiAVHHbbjgOND7p04BWvH9o944gV+NMZvrKYCw7wkp+TY39WfMMipmV
	1wg==
X-Google-Smtp-Source: AGHT+IHZaXS4lSce/uBBUIpFuXCH7I0BpPEaAf3VbI7ppnPDWzJgDOW4eIq57gPJilnwaCJeffaGJD+7rCQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:6dc1:0:b0:6c0:3f:cd46 with SMTP id
 41be03b00d2f7-71b5b395b46mr19980a12.2.1719271786190; Mon, 24 Jun 2024
 16:29:46 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:18 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-10-edliaw@google.com>
Subject: [PATCH v6 09/13] selftests/proc: Drop redundant -D_GNU_SOURCE CFLAGS
 in Makefile
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE= will be provided by lib.mk CFLAGS, so -D_GNU_SOURCE
should be dropped to prevent redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index 6066f607f758..ee424a9f075f 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.2.741.gdbec12cfda-goog


