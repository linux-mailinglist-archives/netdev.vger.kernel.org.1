Return-Path: <netdev+bounces-106279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4150B915A82
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0621F20584
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5421ACE6C;
	Mon, 24 Jun 2024 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVEsOTrA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618251AC780
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271771; cv=none; b=L6bIy2O+QVP70h8h35gk41FK5mH/adqA5004Ec4doEc75EuBbxGQUmx1HxDvwM8GncYpoVHG8uBb+y5IbLZRldneGpv6+Hf6pYHCBmYMjj24+m+EVwiucsgmVlbIQCd/uK+HWIFypK2zzExMkKId1NKto49aIpXFPq3QywRui/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271771; c=relaxed/simple;
	bh=X0lnJ8lH8/hxDl4Hg4Bojyv5HWdI5Bnk/QcwrFlBWSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OlbwRfeXjhzEPckMLVV8tmqXQvdbqFqWMOUMoBrPyEqOpthOf5cCyLkTYuT8pWCy4TRsKsayIIJGbgN3OEx6dzONjCVdcYD9G366fjrcU7S8v9Waa8EhT006wVTdWSC0zKCO9tje8/QAmXmT8Lk3k8aviwvD88YE9kdBui6ji8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVEsOTrA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7065df788f7so2244652b3a.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271770; x=1719876570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ifr8Ya8A/Lifd4HdrItZMFbfd7FCXsltsIVIxxyLaY=;
        b=gVEsOTrAOHTrdqZlWQp2WkUT2d7NhPD6lyhMpWNNkUEYpyuuAKqtVII8DQzYWh68Bb
         SxowWlKGeiLLLYlsdYooxHnvQA/0F21N17+q7/HlKBn1CCLzWKdsHUhKSIebs1n9g/ry
         OfXsYVBst8CfnoLgPF76b27aGwN8gP9xghIVY2jVp/ZGM++wQKlauwiUlZU0sH+xWOB2
         CvVVAA7Av3o03LoUobyEvhsfpLxYGbwms5aT7X+W+mgWFUCDsxvGLeGGOyH3VB2EB4Ul
         5pmFimG0izMNIOC5psMY9TTf44fis4F/+fKkTOo60zCGxAou+OMrWYFRRmcz2oOiFkU+
         /Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271770; x=1719876570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ifr8Ya8A/Lifd4HdrItZMFbfd7FCXsltsIVIxxyLaY=;
        b=uyMbCLT8yEjRjbdrGMHk3IUmdfSwCtImSDjaBKDOXTpb9S6c4PI/Z8L2nibJgJA1Ck
         mj+jGbWf+UEGEW7aMdvyTFefn+DioMK5VMAXJGx0YSvpEcODQqMwbnoKSCa0N4elcAPM
         UW+pv37LtQAGgfgCsO3B1je7gCvkNPMSI/GPDL0EElBM3RK0S3cOHLc4LbduyoNpci0F
         zk3G8n+kvURGApG5DhzEnkx/emoBcpIOKHaGskLzs7zFizaFFfG0ix0N7r3VrN6m8j3D
         H3a1BjC4rTVgeNvLWazePCVL/3ZvCI+1D3KbnMHceausdczFXXDHleeI5TIUJuOlfpbR
         d7rA==
X-Forwarded-Encrypted: i=1; AJvYcCWBF1pmCHPWjIPp5vJSEle4MJuU20CSUhDgeYKA1wgbk8jBdhAel63vX84YTa7D5HOsM2fNiEMUsGR4QaU9JxFQ2x3w0FEL
X-Gm-Message-State: AOJu0YzW0+FskPX3nOFd03prJF+OYaCukPacAyAPWY3awmFq8v4qVCA4
	uLjM6Ju4/Wa9bh8T7M/yFPaz3EcpfapWSjjHQrnBkpqkjf1TXuqWGFIDV+B2PPaJc82wurkxRAG
	ntw==
X-Google-Smtp-Source: AGHT+IGfwxTfgoKpQbwyVdHdeu4Fayfp12bseSCI+21TX1FuKt23v8wGVL/xanJWyhgjJiFfoB7TugWlGLo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:898e:b0:706:3433:bf21 with SMTP id
 d2e1a72fcca58-70669dfcfdamr31477b3a.3.1719271768844; Mon, 24 Jun 2024
 16:29:28 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:15 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-7-edliaw@google.com>
Subject: [PATCH v6 06/13] selftests/intel_pstate: Drop redundant -D_GNU_SOURCE
 CFLAGS in Makefile
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
 tools/testing/selftests/intel_pstate/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 05d66ef50c97..f45372cb00fe 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
+CFLAGS := $(CFLAGS) -Wall
 LDLIBS += -lm
 
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
-- 
2.45.2.741.gdbec12cfda-goog


