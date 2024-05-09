Return-Path: <netdev+bounces-95072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7942E8C1616
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31796285723
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31012E1C7;
	Thu,  9 May 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yuy2xw9z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF412D75A
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284885; cv=none; b=WvadRGVfWruHbe4lo1PYJ/kP7Bo3FAVmkpR8EyzOu9bEuTfC+a3JjGRvpe1pHwD5qT+Z4vJOSLYuTt0wQdhCGQT0gaSwAmrcCyO4AMYVrPOcj0Gd0ZSh/Aibt9y3mMX0hpSB0zw+6oK04X1AqCNpxGyRY5zuXJLJnUeIBuwiGyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284885; c=relaxed/simple;
	bh=1K0xCZRVD3vn54vwOcfFPXDF9T0L4kexPHQ9ePKy6Kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GNo2m2pqlUTSDrp9sXpXXhuynifeU4OLIsWl1y2NdRwlZX5xoPKJhoL6mcYLCDeCHZbQWt8yakfX/M9Kx9oHGfblwZEMGYeUU78Uco9BBCUpDD/kzogIsPTJSZVqZ9BDEBx/L7Yqwk4/TD96Y4WKxM+QzQFhNedJecjlh+BzbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yuy2xw9z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6efef492e79so1328156b3a.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284883; x=1715889683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TU/vpufr9a9ZUHQPOG3JePKH031tzM2+5PrrIqHPNIs=;
        b=yuy2xw9zJxR0T90PEJcbIfBYa4md0HVAwOlsng3ZA8QNPP5v8ZXCGsUNTqKpJU9DHz
         Jz7MqlxMY+JfBQBdvjuHBjmIvUAa/bPUF9Nge3DC8oijKARoygZ/DOQt72njtY9PMaBg
         fqKoCNhRCHh85tISlcnnyaZqDyVaIkgHkLZZ0Uy1cnsrD4Nul36lya5dm2iR/g+xKJ7V
         iudhx/3GAtRnNTm1TqyuYeUCn2uk0b9d2wCwxtaP9XAYFyfZZujsyX6UNRWckrh/D39K
         kIXqoTaxhGiKIJS2oYupSUUQ0AOvMre3tLCw5++Xofo3KjmsjULAegRdpGOaPetFoqv2
         tnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284883; x=1715889683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU/vpufr9a9ZUHQPOG3JePKH031tzM2+5PrrIqHPNIs=;
        b=rLmsZ2btrZ6JTIaSK5GoegThR4d+y/CefhnAqtsTq+0GSbDbU2Lz0tORld7q/dkMr+
         qi4hv74r7OnqZpZDrU5ADaebj1Mz3TnSjkcP4LLImgO2VSb1YcE3o9RyVOwDn/L7Qsgo
         xCQdHadYAiTk5VOpJp1tWyoj91VNz/pjbwhWAdtYX0URhr+BWUxxg6zdjDiDT/hCcPU5
         3BWqjFtnoZDJxCjyYQTcyscSeVBHpLdXHs+8fUq0FsQBlg8D6L034YS2oD7uwsffwseM
         J6l675T0gAfVA/tSWTIPleppARnnFGASQvzEPMB/Po35uPYqIrOON3O74zTe+OxxfwY3
         EHjA==
X-Forwarded-Encrypted: i=1; AJvYcCXSE4NQkIewKw7KXBoff/Js/HmJeTQ+jiFe7KDMwjS+IUHeC4lx9doBm4nlOQU4wfjZgL2M2LtN203sfekMA0qj41c/zetV
X-Gm-Message-State: AOJu0Yzsr3YF8PzHXobo3lhICPTkg7zhnwmb3NJ84C8LLCHR4qfMwoMK
	q+dQpIZKrg5sRcL8KAEIwvICmr7DFzBHDwxycL5Tje0NufDLWJIUHqF1L8jXI56nVcnFZvpaFiG
	7dA==
X-Google-Smtp-Source: AGHT+IF1zeNl7G2mrY5GSol57Wmpqj9CLyOfkFGR2ecW54/KxC4a46reBAyc7WewMqRKduaOo7Ktdkz2CAY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:98b:b0:6f3:ead3:c280 with SMTP id
 d2e1a72fcca58-6f4e027813amr25753b3a.2.1715284883459; Thu, 09 May 2024
 13:01:23 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:04 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-13-edliaw@google.com>
Subject: [PATCH v3 12/68] selftests/core: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
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
 tools/testing/selftests/core/close_range_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c59e4adb905d..1c2902bcc913 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/kernel.h>
-- 
2.45.0.118.g7fe29c98d7-goog


