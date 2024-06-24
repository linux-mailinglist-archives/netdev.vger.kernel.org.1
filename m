Return-Path: <netdev+bounces-106281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95783915A8C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AC6B22052
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC421A2FCB;
	Mon, 24 Jun 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpRmI7zp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682641A2FDA
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271782; cv=none; b=KulCFwC/8YnK1e5lWEvA21HYTyd3Ykei2qK5rzQuthpj/B90UhgTzhgEx9Xe39GAsCL6ceKdf7+RmOemX3Kv5Ji67EuziBQr5evgq16H3XC41tGFV+qf7YYgdO8EUMifDHsLzxqOC0Bwex9lq6bALxH3LhxdxYHjEx9oy1CKSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271782; c=relaxed/simple;
	bh=Vn2wAzsGFTLvBvD15AbUZj/MnMw/n9DKUySpFM3EEW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ATuQc4Ze/S/bZ+Ts/64UBwpjFwsb8cGdHT65zXBAAdr75CEoykOAreOjx1/1uTGGPLgoWe/6diaMBm3i1pqDLukY3TCHjg6kfv6Offnq2SDUJWO1bgCzrBGSCFL/2qpQvl849wPZlydl43XE94sgwcR2rak78NIvqOBujcrqSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpRmI7zp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70679e6722aso1461981b3a.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271781; x=1719876581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrZ+5Kk2oEbgMtgXaDgXkxLOd4phuQ+pRNBukp2bFkg=;
        b=ZpRmI7zpfk4CODpNByZZ+NS8/x8bXWS2416efYVuGf7Bo9fUY27KzEH0ECEG9UShmJ
         3ldX92/Dy5dbLaUbu4bBonueA39OU6w98bFvzlLPptylShgVgSzktpzS3AL13kQBPn6/
         2fFgZEd7Nq9NkuBj2JCwAzhN8087n/nIbYzLGyBwjWPy0CyGjcP++/vyhSIZ+7LBLjvk
         E9CI5gOTAT6WIxx3AhSFXwLFz2BCxfsL0Nh+i5L6Pj6mApiu/cAA3VSz2yMYyv6L/Ys2
         pK2hCdzXbof1FrBy96lC2943PubZolSrqBkllCPI5+Op7wu0AxZEU6CxM9vdYMkQQn/V
         s/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271781; x=1719876581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrZ+5Kk2oEbgMtgXaDgXkxLOd4phuQ+pRNBukp2bFkg=;
        b=NzelVdZLSLpOMYqmlvIPQCL3Db4Z3vnYjm5a7ZVQ0UIqcCsxvZ82WHJTsaLFZR3/jx
         y9I9ym8Ubiu8cM1JjtJv5BughjIMBfmiPPsdDPemLl/o205OzfgQvlCnkhpcZ+MA8i+z
         Gz/uKQMmfvUbt318vUYs8eky/yVn6kuUEv4qszPGt+oRPuzDDXPUcsGOSTiO2baPPbJt
         92OcwUyBsdk1loK47F6k5FcfY5LbrCaCtPML+VFoOpcy1JkUws+bhLqRjNbM0DBoaiPE
         V+tEF+oeXC3/jL7eqHSbT5eGLARFQ+rcGs2DWnrPxJh49GixQrqqQhiC7ENmktAi4Kjh
         cpLg==
X-Forwarded-Encrypted: i=1; AJvYcCXMC9m0wggWMulx/gRRE8WhoNR5mJLI0jmRwhi407El4+trohFMfZA020dLaE3m/G36EJjK6NNG1mr5wxqAswOt1oO7oW0s
X-Gm-Message-State: AOJu0YzzIVFXRr2NlQr4B+sB9ZNT4ljZLby2TNDILvEOsyyOzUX19x9L
	OJYw23Wdy0fICj9nGYoCIwhda3UvWhPLuGnV70mwlXt2I7cT2BSXYfo9FYi+NEBJ9RS58zE8dZg
	xSQ==
X-Google-Smtp-Source: AGHT+IHpQrIc85Iwvne/JtUL74k7CtaEnEbXK9UND6RiBewc+A4BXz2SYDvXCOVunV74/hhFEZKy/c23brg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:4309:b0:705:d750:83dd with SMTP id
 d2e1a72fcca58-70669e5e132mr244774b3a.0.1719271780764; Mon, 24 Jun 2024
 16:29:40 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:17 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-9-edliaw@google.com>
Subject: [PATCH v6 08/13] selftests/kvm: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ac280dcba996..4ee37abf70ff 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -231,7 +231,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
-	-D_GNU_SOURCE -fno-builtin-memcmp -fno-builtin-memcpy \
+	-fno-builtin-memcmp -fno-builtin-memcpy \
 	-fno-builtin-memset -fno-builtin-strnlen \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-- 
2.45.2.741.gdbec12cfda-goog


