Return-Path: <netdev+bounces-95065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A508C15EB
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFBE283044
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B286146;
	Thu,  9 May 2024 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hH9xnUGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C286249
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284858; cv=none; b=EHCSR5qf0+aZM4CGgG8nE8tdWMvczO9cZH5iOHmlusgYVcOPR7ntQ1gWGSOenA3DhHR8Ji/EXp1OsNGk+v80WmWEk6DwcHftXxwLe2ZJtFwfGkyMg2X5mJiS6+SlOfOvZl90x1tTYn0NpGi9iRPAWQz1vuSS6sejzvh5YrNx+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284858; c=relaxed/simple;
	bh=euHNwBS6Epsw1wGiLajK2FBLzSmnArw8M3ba7LO9eJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MZ1/HVx56fJcSTSUIm9NXv9k5W3Us3P836s0Nav1NqEtY2P21f+k1CmYqJsiqBvqstrS/PGrGiXvL6GzDS+SwExj8PdllzFRLcOrTKwyk4ajZs4AjJijD7U2k6+gH8wA7rE+0eUkC88XBYvdEKeYuJlhGuiT6nJevjlKdSVmmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hH9xnUGm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be4601434so22565637b3.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284855; x=1715889655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSnXkY+i8xBz8FisUXSmsQkSZaie1U2SXlbBYlPacTk=;
        b=hH9xnUGmDdeKavQ7o3KXJnb3ZTFuAhk/hFxA7x8b7NccNKEZbYrGeYFfVX46BIOc8R
         GTNFLhz/QQ8PRfhBvKicPlEtACEWhl8n0tcFLIyYyYSe1xAJK/TBoCmNTUI4gwbhYGhg
         /INfWYsEMmM5j9cHoXcnd6TXXy6Xpu4FZgAufoSwFQMDofvEdDmljU4zPXvT5EyzKEpl
         aTRo2qUyuHCvR41kRDC4QFOF93IaJmcaxqpfpq5Qllx+2T+97xE7zYl++jLsxla28H+m
         iJ82WyXpAc0Hi/o4ULjWJ75t+Y5sILr5b4ohKUSZ4on/rFr99Tbm+kanF67fsSk38BT0
         PSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284855; x=1715889655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSnXkY+i8xBz8FisUXSmsQkSZaie1U2SXlbBYlPacTk=;
        b=XiSU+p4o87ZT5nZSynFKQW1QwT7WweHjC1OLMq97oguwHa60v+vIMNyHZoCVJxFsZ8
         Ennj+RdEuK1s+tx0hbN5NUnt7QOq/GQvF9dV9VqDat7xjch/RNKW9cvAz2QwoWR7Xjl+
         hsU+RkorfYTdVwfaaCsGHFADvCDwg+spc8peVqkKR8tuZ0OSTswOTCbGtdoCoUNp7VxW
         OnBo03hQV5fup8eZWcNAz0UJwptRYqTgUZUuXDQ3U311JWwOuCKDlRi3jJ+v1LCv5C1U
         gNHsd1Ev5IcTK9+gj1+7y1hFEyw/wlAQQ2Uoni9TGrkA276Tdgi3WLFWpf2y04nmhdYZ
         c5yw==
X-Forwarded-Encrypted: i=1; AJvYcCVXEvcaOQC1V9AEAYDf9dwmDa+7/NxfEUc33iNwRtEmEyV2t8SLKcb1UX32JApzjt3wGWnNrdwYlhnjKrw2QQa33YCVLhWE
X-Gm-Message-State: AOJu0YzeMJJQbi7R5WfdHNLzmoucOXoxdy7ICnM+UvjkIEZW1LhEukNU
	UOWr5W9kKXITUAacfECOe4dm249LTPM9xKVAXde65RRVaOjc5qg46+cigVo1XR/8YGGfXFnW3h4
	o2Q==
X-Google-Smtp-Source: AGHT+IGojUkNrisAmY+TVjQpynkG2w84qahgUw1mqZZfDgiCsUKwxR/6LFnDu05hn55cxfE5RMPak7RAuao=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:a443:0:b0:de5:9e4b:fbb with SMTP id
 3f1490d57ef6-dee4f363e51mr139553276.6.1715284854975; Thu, 09 May 2024
 13:00:54 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:57 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-6-edliaw@google.com>
Subject: [PATCH v3 05/68] selftests/arm64: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/arm64/signal/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 8f5febaf1a9a..37c8207b99cf 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2019 ARM Limited
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
-- 
2.45.0.118.g7fe29c98d7-goog


