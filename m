Return-Path: <netdev+bounces-95096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275AD8C1692
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4031F207BE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8077D13D288;
	Thu,  9 May 2024 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0i0YWe8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60213D260
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284951; cv=none; b=Oy85/NGTNfnYaTXIizkGHWk1Jn216F+n0TxY8zfUMz1UyPHJOySEd5tW57us31dofYPHsZgwr6p7rMOPoExFZqpBWHykBH5WzIGUU0yEuhanK/f5nFb8y6o+qB+hgKO4AKnrtlRbxm/0ZFs643PIbcVdvJ52Ul/QZKU5oVaECnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284951; c=relaxed/simple;
	bh=bxJLCfAhlTefmGTLWdKhHKRSmFtlMAwKw+2HpiuuKOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EI3yh6yjhR6TpSrWQvWgajlCCKrgbT/IEsBkVldiIdPTCyv2oK8jykHovu73N7Ri6VvKvTvBsPclQAHPxB6f58Gq0LQr4CxyCMKY7Ep2o3H6lFLilmt64xeRgOLt2LdoYEfR6yKXszrv+d3lmlHp4pnSGlf4O+rFsUBFuWsnJdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0i0YWe8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f46ebdd8d7so1071258b3a.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284949; x=1715889749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4z9tRmkFYCcw5oob96Va/ErGYfm0S2CmMdMe4FBR7I=;
        b=D0i0YWe8ck8Fmpt+b2aMwVeBEfI756ZePQN9InAJ+AS88oc6rNr+0leQR6D6UiciOO
         TDfkhnwKStVYzMCdS15nlEpc2dlu9Ni5o/MvmXtME0WcneXXHKMHlcb+LsKs8DT3txyl
         WAf9dWrFfisgOiEYG2dE7S3p0mNpxEWTAKRogKpG+hnYxhX9fw+LhNVz3p6t8ajghuNC
         swRaW3bRhAF7jwXzhApmx7mLKyPUlZWCQwgeGCRSDb41PkOR0C/4pYUT93Q+8harwXJg
         5yVCAlrMY10P+mrBZQPGAi4VT9rE5io7NHaoiv4WRFMkLS1wnBf4CVTpih9OJNpVCgEO
         KhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284949; x=1715889749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4z9tRmkFYCcw5oob96Va/ErGYfm0S2CmMdMe4FBR7I=;
        b=u5GXM2wGE0L3+V3zH+F6Zp9QXWqyHghQ8q0dAzfP1yKKP13YqgOWLzoydbJwvb6Fni
         woKTtMnNWsGYRKOYbOecKzlXj8Wb21qlfUcEgeJI1+UEancshj3sWukzbbfwk8OBXg6g
         YZ56JgzpIWN64o/ir4pMgYiBPsOdwVsd3B80OpQ9e1GyfohSBZUNGcl2HDt/cF/gYXZR
         wpZRK4Ie+wtU1MfNjqkZfS0/elLuYxWw+VifwyovwYL2LLFtExi0rVUKitB9wkkbiHYV
         /k0Ev62XxWwJ8XiB0IDmKweaOBaxl8j0jbdauzaFkvm42S77WrXF14XOFDzLU97ACoZo
         mPjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy/NPmhR1G8XJaGQI92erwr4W1e28xEO3Yg03T5w9M3DZDIolpNZHipa92IoLBARU1OMLfQXRDgOkjmUdcilrN3WN+eSx/
X-Gm-Message-State: AOJu0YxJKZa0ZeoXUmA4LRPlN4w+K7Vp6tfm4nl0YHtQe0/RIvs0nQ/c
	mNb1/J8/qESyCeVbvIfKrfXEP5czko/QiX9pBqYdUFPNduN4JE4vgFIbnwob6FhG6yTu48ZEHAD
	r/g==
X-Google-Smtp-Source: AGHT+IGF4qz3epyZCqVd8sIgyp87fgIn9moU6vLMHysn53aGUxAkCsTmzzKAv9A4azIh93bvW+KCzfUowb8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:178a:b0:6f4:9fc8:8cb0 with SMTP id
 d2e1a72fcca58-6f4e037e983mr23426b3a.5.1715284949238; Thu, 09 May 2024
 13:02:29 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:28 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-37-edliaw@google.com>
Subject: [PATCH v3 36/68] selftests/mqueue: Drop define _GNU_SOURCE
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
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mqueue/mq_perf_tests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index fb898850867c..43630ee0b63d 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -20,7 +20,6 @@
  *   performance.
  *
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


