Return-Path: <netdev+bounces-245425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A1CCD13F
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 19:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC95230674F9
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EA330649A;
	Thu, 18 Dec 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvzlD5m3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48330F922
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080609; cv=none; b=P7Fgri9rBoKPm8ALCizj5Z6JWOiDNlYbu5BVZeSo/Ng1PwElBVYubnyVK8LgFQipCWR5YWZT3oyqEIHjCgRyqHG46hFXR9YeJQ7Q/FZgJBOcTupb0YiVFfl9utjPUTar4/T7omyPh5Ta5sx2gD405QRH8TaldPPJ3mKifqQqCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080609; c=relaxed/simple;
	bh=An8BnmX9Br7RS5E/JK5+AuLgGH68OZSuI8tJGKtCb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTGxL8CVKR29YCvCCjg7UkMzhqEb7HxShYxVSwZj736aoEyI+dgW9PCFcaJI7GHuKG6Lr4JlWSMtuTzF1ZW843yWGovSaar5/yi5i1yKITZ4BbTHiWMEtXtPf9ZhERqBxt/aIwsZJyULydiL/PP23GZnM+ypSv2O3kJ3bAbbZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvzlD5m3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a081c163b0so9349575ad.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080607; x=1766685407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuNvMHG7EsV3WDXcTIQ0sCJGxiwxkoeLevbL1JCpO94=;
        b=CvzlD5m3nHccPfxyBLLit8EDHYIewJo7Z2MFSKa4fNxUrS2wwtR2wPsGqS9zjilw6Y
         mGKcWdnLRaxnwMuwjvz0IQIto8ei6k+eZ2hLY+BKLuy1pPP/rRPhWku94gCBpPAVK3zl
         q1rg06fb+ggWn13qSmirEb8150uGYARrYeyrfB6MAHn4LNfA/xdylDG7DHDM6PB4D1lv
         OkksNAZ7wAVnWb/hZWA1MZpEZk8TtQWR9O4KgJa9MXaUjZQMfdNymNnO9AAE4kY2qOmy
         N/pPDVfC0TAPChq0mivSxBvlQ9C+1obMltYxuSeBJ4KzwI2kCNen+qmIFbpU/59KMLtz
         8G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080607; x=1766685407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuNvMHG7EsV3WDXcTIQ0sCJGxiwxkoeLevbL1JCpO94=;
        b=o956YXKn2cPCePDx7jmwtP/PBjVtRCiVaIDdQjWu2Kl5p8FvDUGDn32e3P6o+7lT/v
         9T1d1s1CKv/0bBJ/KYQ7J6WO5c6E1XOAoxTeZSTyrOmK+Pvd6LYo32I1yDBBIPwmny5i
         jYpanLZAFLc4um2rCtwyLX7GTvDu7bzNbeA2AjQMQD372Xry2YdYAZa74meM/li7/TbL
         GTD8Kkpm/jQEq3nJOjQHbysPUwlPw6ejNwpS8pItH345/HfvO2bNz/yjnM9uDdf+Io9j
         XDh2W4PfJyOL2Dt9xRLwBoG7GxzdWi6L5ntACYNCH7qypLbbOV35UlpG+2oHz4CHPKni
         iS1A==
X-Gm-Message-State: AOJu0YwTHk6183+DRfkfYp0fJ+lf1U/TsDk5vqmjXwHIitzpT03J0fnd
	ec0t8zBi0mqAwTiMSY4xNn8wAK/oq8Weu7AaUm9gHY0smvr81DAM6V+y
X-Gm-Gg: AY/fxX5rg2fBLuxMkNY/TjlRB8Uxl+Yk+XabLTBMQ8DdZJ8Aa3RMEEKUKc6gBeCb4+i
	+wpTSiFc90kyFvQRsjzlVP5E0KmqScHVxeU6RRHB+CDE/50PfLx4y0uDR1CH2z6vh8aY4uXtf1O
	uJFsVgPS1b+dtOPoEnyV3UrbsMjKvU5iJcamWE9bH6iUV55X6Ozl1Qs99YHTrrfCnQ4TSjIFywU
	bdpm8Z8r8To87SSu7ogz711Q47siJfVzcNmIeNTLLjgu0gHlOBgBBiL94VoB5E24Pque3uvrL8y
	izYLfRmecv9r9lIg84JfjwAxufzpQ6A/LA6aYJC+7ihHvId297Hr45gkzp8I1SH1FXSstCR3sVn
	cm2fSS5WOSGu9UP85UexA9BFRLy/DavEquNMGN8oPonjjR2kAtSKkWwglfJCjPKbZM0g/C1qfqv
	2x5z3U949QBosQ1w==
X-Google-Smtp-Source: AGHT+IGh2Lk1XMg+o0oiNmR3d12OTi1u4MOPjiFlEQvGb37xjw/US/MSn/Va6np7AIN+1z1t/e53wA==
X-Received: by 2002:a17:902:ef47:b0:297:f0a8:e84c with SMTP id d9443c01a7336-2a2f2a4f69fmr948745ad.52.1766080606831;
        Thu, 18 Dec 2025 09:56:46 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c8absm32397025ad.10.2025.12.18.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:46 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 14/16] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
Date: Thu, 18 Dec 2025 09:56:24 -0800
Message-ID: <20251218175628.1460321-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjsut the error code we are checking against as bpf_task_storage_get()
now returns -EDEADLK or -ETIMEDOUT when deadlock happens.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/task_storage_nodeadlock.c  | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
index 986829aaf73a..6ce98fe9f387 100644
--- a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
+++ b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
@@ -1,15 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "vmlinux.h"
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
-#ifndef EBUSY
-#define EBUSY 16
-#endif
-
 extern bool CONFIG_PREEMPTION __kconfig __weak;
 int nr_get_errs = 0;
 int nr_del_errs = 0;
@@ -40,7 +37,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 
 	ret = bpf_task_storage_delete(&task_storage,
 				      bpf_get_current_task_btf());
-	if (ret == -EBUSY)
+	if (ret == -EDEADLK || ret == -ETIMEDOUT)
 		__sync_fetch_and_add(&nr_del_errs, 1);
 
 	return 0;
-- 
2.47.3


