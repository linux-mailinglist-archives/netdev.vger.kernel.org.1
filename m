Return-Path: <netdev+bounces-95103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 885BC8C16BA
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD201F21550
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9870613E3F0;
	Thu,  9 May 2024 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRedCCVQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817D13E051
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284975; cv=none; b=LKDAws4m94WK/v57I1EeAfxw5jZrsQJ+OB8ccR04uOarglYlCk8v0jUeT6ECnPgxLt84IHNVYGWQnYCAWv6Lerd+vxl94Yba3zi7v7XTbC9uw7dwiZXVl4Ylk1tHmMEgcXaDrEVJ9FyPlq60h2x1/Ehrc1DiXEc5tdWDGTXTZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284975; c=relaxed/simple;
	bh=UfAo//kQqUK9+HsAvQuH76Z/Ww9en9hZzqfCF87sxjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=usMTGrBkLb/kvsxUuCxxr9u2dxSlPA14zJqg5tMYb7tNSCc+iLIhrN3IHVrp96wUqvuDMcS8vCXRPphP95wvJ3SAdUx3FcP2Gk9IX2msYAN5da+SzL+waqt9qmcdNbdosnN4zOwC1aLRie8XxL0w/mYfSBbB4U/RDFe3ySK+Kp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eRedCCVQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso1745089276.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284973; x=1715889773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4YtNx2ds/btNjRumtpOC1sPQ1T7EDCPNUgbL6GhZJk=;
        b=eRedCCVQPZl1KOUbxZ95OUl70EF1rX06XqFV8lQqMTTlVOyTqj51cEb5KvBzZ3Hzb1
         hthxAJGRE304FYwQXUk7ovvTnVA/eA5h/tRLekQz2Fr72FIhiNyESeaj7wFvq6gfJvSP
         DNjSbLAZwXKpiOA8c2aFE76BV+Q3cXr8m3u/bdJgAzRuWL61XQ1fc480Ka8QFzpqqsiz
         tH608v2Kl0sUc6wMlMKtgUmB5QBJqFFYKw6a70eod3X0sM0hRxG0l5dEz6QdjZKlmwDb
         zFl9OFRRp/JU5pPcNgdiZ8OjYwA83eHfvWGZykIAumFzvVLOMtledaL7juum/ABVdD+3
         3GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284973; x=1715889773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4YtNx2ds/btNjRumtpOC1sPQ1T7EDCPNUgbL6GhZJk=;
        b=lkJlgBZG0V7dE9Wxhn72lonHPZqAL/wWz6HOg/qVq1Tg+cflTbRxmuzo91OkAl+uRS
         zrp9bTzFL5Ys0bhDA2Rb/DxB+uiSjFmW3kltGDUmGSAypRupVBvxoEjC6/4R80No4a5h
         z7dshft8kwYOexIEfg2axm56P8ZmblsGWNbI5WxSaBLt16Daw/SahvKafCe8rOF1p5tV
         6EvkXpxU1JnIjZ5I1BGjd4H3CcXMv1mHLbk0TFB1mV9GtbAGhS+ovI/9k9Hfai9XfZky
         f9hlsQjuJwZeRpES/2vpVxNhLnimVjTWa0md468ifN4dg7EfpAOzYWfv32jT8/mxf/A7
         oTow==
X-Forwarded-Encrypted: i=1; AJvYcCVKQgCd32PKxFXbJfSOc723cWebER8bqw+rePGU0Z8/qK6n+r0qu1Z5UpahRaoH3/bm2ItO7g3Z6cacaayvK5DoT/5KQd5f
X-Gm-Message-State: AOJu0YzXuzz3S27iAbswJFyvZoMfb6TsnMwaarroQ9eZRB5hHIQhyjtK
	eBMHO0nCDsQWMBU2Eyu8Wxzi0kpZf4LvnvDTsZ4tOtKSDescMnlAHEl7uUKx9RwW69DP02xEjU8
	lmQ==
X-Google-Smtp-Source: AGHT+IEhjwAEZ9srmk6nd+nHtbruz7CGwS3heWa3ViPqupsQl0bknuytB51bhWsROyhFvq739JBd1odb8+0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:149:b0:de5:5225:c3a4 with SMTP id
 3f1490d57ef6-dee4f304cb7mr138986276.7.1715284973168; Thu, 09 May 2024
 13:02:53 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:35 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-44-edliaw@google.com>
Subject: [PATCH v3 43/68] selftests/pid_namespace: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>
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
 tools/testing/selftests/pid_namespace/regression_enomem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 7d84097ad45c..54dc8f16d92a 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -1,4 +1,3 @@
-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.0.118.g7fe29c98d7-goog


