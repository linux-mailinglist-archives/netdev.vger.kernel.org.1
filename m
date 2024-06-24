Return-Path: <netdev+bounces-106280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127A0915A87
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E091F22258
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390551AE08D;
	Mon, 24 Jun 2024 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJt7zGNN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CF1AC780
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271777; cv=none; b=dt2Keuu90mcU/er0NH+DUjL7r9ylbK7ZBU3uLiEXMt4yYJ83EszNfpxuZ4xEPmyDx6L+Jv+7OuqXZA55IEFcjg0im7+MJxcl9Dq4VYEWC1rc7iVUtCz8ktwj0+D8LO+CIeVkjsFVZIoRqqIXmUvSJdIlAFjoF/sIgG2pdiTRskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271777; c=relaxed/simple;
	bh=CSHVkY0x8U1pXoBBLz646/d7/XSIXGdSs1WvRtCcMQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V6HHNyQW+8YWULapsM7nctyuAMfOfG2mKdf5JEIfjz1GtHdU3O3lV6YrZlX0e/XzoZyaKVG1tjqNUu6tqc5414hQaYbaMYBWqfwK6PnNchtyxfm5r6EMuTtNKhQjKyy2eIOT9zGEfzfNbeEU4J1ssC4/FIYGJeAEcwX63T/Yc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJt7zGNN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-704d99cb97aso5870039a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271775; x=1719876575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCJX8+VvSnRphReKqOD6AqEhzLc1OgPwFHKFgJpo/3s=;
        b=ZJt7zGNNICI11S4OQyzweLZ3dhSmTNr2dmmTwmTMp3xIeH11QNaw9xK7WXyDhDIfnD
         i5RJWgXkEVS+KCtpbEUX9797V5Yfycj3estF9IHHY92NEfvHALDwVt1oTUO0Wxl7hbJH
         jUQPhxZT2jHiRB0TNkaIUa7am5QR+LvURiFG4cIOUXyBijV7npm0IKQ2j9oLoJ6Yu5Fm
         /IrKT391Or9Sahd8jFfehJO/UQdZo+mLChkLeu4GFPllc3qxP7t3vUuUttGTUyoN/cnR
         2Or0DC79p/yOEH6SLokBqsC+5IBntJuuN9OB79vs7qjbyPfDAjef0N9tue/jLOZub4B9
         wo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271775; x=1719876575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCJX8+VvSnRphReKqOD6AqEhzLc1OgPwFHKFgJpo/3s=;
        b=YsG7nYUBFXHOZANkLNzCMNCeO7KP9ba9DbmOahxsdlGhB5GykiST/Q47PCl5NgvFKJ
         KYrh1fa/1hVOJbeQk+OKvUfWaII+F5vKFRzmX19Kp7MY0x6Sc4VOs2ZtrgK/UY48PN9x
         Ah5B8lflKCVzrPDm1iXGWCeBSeeDvxLaAbqbx8jtAJ8+aQo/QISPZGpFNNSjd7qAqRM0
         OlWQE+2m2fG21RJd69WHMS94rlEtRASlJt9GavBUr97DkLn8Uw08aqnOVfeXO/jg8S+/
         oFg1Gqxa0WptcMMC7bH+Cj0AynEL7QywcNkG/wGjWxBuT7QEoP7iqPAgoZ5eLzIqkygB
         lVtg==
X-Forwarded-Encrypted: i=1; AJvYcCU8mSWou7HPYWXpBhrof0cEGUvolMdGRR9HJ3Fs1eRO1+/FCwAgyQG4YhS3pnu1J6NcOsNdmlNbVfqBgANckEj7aGXMRVDV
X-Gm-Message-State: AOJu0YwAsCbwRfzLS67KNNbdg0r71xLNU9A0nYt5i+61OgNGJY1iSufR
	vLmjjnOncs0a6wDAFKv5wMMMBupL+R3O65tcVfXF5+X9/9SUqtO24Fv8WYTA6RHsAPNEUQodpgh
	+vg==
X-Google-Smtp-Source: AGHT+IFjD4+usXw1SHxX9b7ePdUBbw8ZgCP2CzCr9wFCk6wJU6Q5+R81P4uygwELRit2itW6ZnfR1hiEObg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:91b:b0:710:c65a:7e55 with SMTP id
 41be03b00d2f7-71a35642c51mr18906a12.1.1719271775000; Mon, 24 Jun 2024
 16:29:35 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:16 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-8-edliaw@google.com>
Subject: [PATCH v6 07/13] selftests/iommu: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/iommu/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 32c5fdfd0eef..fd6477911f24 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -2,8 +2,6 @@
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 
-CFLAGS += -D_GNU_SOURCE
-
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
-- 
2.45.2.741.gdbec12cfda-goog


