Return-Path: <netdev+bounces-106275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B392E915A6F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698B61F215A5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3E1A38F6;
	Mon, 24 Jun 2024 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upDGTY+V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861571A2FC0
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271749; cv=none; b=cZTP8jnjt4XxLNUM526xWtu/U7vgf7XKpXpo2clV7acs+rkCZL2F9bjW+1Y3sFJydoxhrIETyNoXTmxuaHdn8YXLCuD7WR1POPT9z71XueYQ3eS0OgKwWy/ZQI/PoDmxjpJZVoGs5euzK2iMk61R74vSX9jNbSFvyo99+JqqQY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271749; c=relaxed/simple;
	bh=xwftBfRu5G8w7ol9IF7MUG9BSiGvoLKlVTWAOAeO/Is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d/MoAaznA9Zwfg6KKsnziv3PUS8ABVk9ihM6zwnVAOLtJIx8kpYnqLZ8UQsxgTtFAzhI2rfC6TSxLAtOeLplAonUFIu7WhWzjjiaNs65B47cPuynK728aItGnupfeZXJJ2pdi28LZnhbZfy31Dl+wvQGr+pygEAH90IAaylsMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upDGTY+V; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-704d99cb97aso5869346a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271747; x=1719876547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7F8R5HE+eZyxlB2ebQLwW1FMzverfSOUo2IuXKNmLY=;
        b=upDGTY+VAWxjOiGt1aN8qq/MXQcXxCGhECKCR+u/ehZUHokbQYBzXGPPb67Ib14AYJ
         WS+Icm1jnUp19BMdXpFSNeL98mC+XEUCbkDJQQdWPHozIzclQDGsE2NnJ/l/XJ+h7O1m
         BssvmwEpWtykYwfNxyQEQFmdtvyoEdRIcIsrBkQADycUJB0CmlZmdQklWhhB6zAEHG/I
         qmHXlzQINVs+7F8iOa8zPeFNnGQXynyT4+QVgszv5DndlHQ29J5RjVYvVlGrSXxJBBls
         8ZRfhzFO9fvFPh6hFHx772LXsRysy4ieIYujQB+oSWpQi4Cn3AKoENJq6O/tqt0a8G82
         yRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271747; x=1719876547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7F8R5HE+eZyxlB2ebQLwW1FMzverfSOUo2IuXKNmLY=;
        b=nZ3vym24DAUmcbDL8KSRQ91xmfAhjqz0kKvimkthZGH1SmbqCBLSUM3+VhYyt/EwuX
         kOirxggJ35qbwlKcTaqliIffVk4RIeesq9TNfnjQD7dVyX5N2s+d9Xmvn44tfzaX2g+N
         V76J8LjiFim/oOBWTD/+M8ZCHiF5RAJTtS75a1oLbjlgMMQsxew7JpKzYAgMNQP9pNKy
         ArJFDcy1QdABfzerqx3g0+fEpVkOo+TcXSpFf2b/zwoUDdwtxQLu3ImwQ6H5hbDfZJss
         xyXEzyARQAcd6cuzCGaqVZMmkTtzDaDY8iCgyxbhMWmryQSN4bpv2cwQfJ0EPnOD64Gy
         UTYg==
X-Forwarded-Encrypted: i=1; AJvYcCUl5i12hnW02YoDZUv2X0YEyH9PBBpNlgevdLcWUzOKIOuL/xkgkZf5jSqjIV6O0Qt9Dw8j8MgixTFvPgaDCd4by02Bhc0c
X-Gm-Message-State: AOJu0YxDjzs7SaKseWG1pEmjvYfReAPe5a6ICzWQ1TSyvuJXLWxB6ovU
	XyaZbSBThRtVZKoQYQrfx6LN/8fGewPGHuJDLT8QG7AUanQqaCnbSquT50xOBlRPfcfo3LgzKz8
	YUQ==
X-Google-Smtp-Source: AGHT+IFY6zwuM+fBRs+r7yFjUxfbkM+X5No4nRI5eUjSYyy4xzwRR2NKqiye6S+BJr7Hl1+KVMRcw6AW1Us=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f693:b0:1f7:3763:5ff0 with SMTP id
 d9443c01a7336-1fa158d034emr7382275ad.1.1719271746792; Mon, 24 Jun 2024
 16:29:06 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:11 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-3-edliaw@google.com>
Subject: [PATCH v6 02/13] selftests: Add -D_GNU_SOURCE= to CFLAGS in lib.mk
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
	linux-sgx@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Centralizes the _GNU_SOURCE definition to CFLAGS in lib.mk.

This uses the form "-D_GNU_SOURCE=", which is equivalent to
"#define _GNU_SOURCE".

Otherwise using "-D_GNU_SOURCE" is equivalent to "-D_GNU_SOURCE=1" and
"#define _GNU_SOURCE 1", which is less commonly seen in source code and
would require many changes in selftests to avoid redefinition warnings.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/lib.mk | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7b299ed5ff45..d6edcfcb5be8 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -196,6 +196,9 @@ endef
 clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
+# Build with _GNU_SOURCE by default
+CFLAGS += -D_GNU_SOURCE=
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
-- 
2.45.2.741.gdbec12cfda-goog


