Return-Path: <netdev+bounces-95112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542A08C16EA
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E6285DC5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12338143C6B;
	Thu,  9 May 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cr+VTQ1C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8ED143C54
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285003; cv=none; b=oebOI3YpQLDF3JyUUHF0yW+5QVhm48JnyXNPX3UUUVdPVwGvesCwO9DdTfr06Z3/YrOV26RDDAsqkbOVoorHf+3tgJE2u0v/RIM8tpTuATrBnwREClqeUBYSP93OitPs0DhImMu3pvGRmO2OegAPcPN/QAY1ttJ2M2l8ZGf72Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285003; c=relaxed/simple;
	bh=O9xtfbgadu/p6ddd8avwApWGZ/0YxN3sdI3PLHa2U58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mrUQDBdKC3Pk+JwcFB6oTyWM7WvEC2saEZ/BZfWNmfdRawqLvrtMkHj24C0u/8p1SePC4l4eEdQCM4Vo6Zuq+tT5zlUdZLLxEn1uu7zaGbmO8KL5Ylf7ql2pLOkGtvSCl+wVFtXn22U7b9BfljRs0gWTzL4kuVyorvsNrPIJ05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cr+VTQ1C; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ec3c838579so11777065ad.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285001; x=1715889801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqJpZ06+qwlYgGDMURIHtEZ0g2cp0HVan8txW5tNeCQ=;
        b=cr+VTQ1C4c+am4VztIb4sZbqfCHwqOledJw5gl2v4yK/45ERyBih97ucrCCesxUUbq
         +MwjzvX/D6Pf5asw61U/7fRPoW5yhH+xzW4MkZ/RpaS/nCal3rSFvFNwbfgO9x/Oxwjf
         ldY8Dx6TVsU8fhNJlznOqeMq8tnwnTB0xs4EQSXVFTbwvnSUoRoh3QQZ+5Bw3alVn37j
         TtTvakU3ll1gcTrGPz7/g9FhtkjMKVdMov/SNIONoF4Lqmr5GUyP9RzvFxKIRQfKi79e
         TZ5TYDf5A1G6Madiup/GBxPef80rMZn9q8c4gMTvQ8TtxpqloYWv+gDC+t+26wheJiJc
         V6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285001; x=1715889801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqJpZ06+qwlYgGDMURIHtEZ0g2cp0HVan8txW5tNeCQ=;
        b=vK5EG5SS4BEPhO497gM27jkGJIg1InPEFXnuO+5k8SgvYGsv4WMvQFHfYbU4AYBirG
         bBFSubQWrrZq8T4dyriKWpTd++fs/i47zOLtuaac69N+WqjoMMmisgamdoDubGGOVkeZ
         zAagsTUD4PD3wswBVSVSXtiRUdN+c1Y2sfvqJqn3EtrpbqGVOMJAzNwh3t24HpZLW44Y
         ZdPdwhwjRmN16ieEzlSsX6HASi1IOHDlz5TBeqIflFQ6qBPMQaqXTvhbvkePZYlECVi3
         6YYH3LiCovHnnnpvarqovvvW+VDqxLGyRFXTHed6xQc8NDhF+OkoiMAQ651FndKiUiRX
         lYEw==
X-Forwarded-Encrypted: i=1; AJvYcCVce2AxBBQppsZtjkH1cmLQ9zj9fQHRrHURedSS8Co1S6FJ4LrjKIkhZHfLgp5GULr/wYKt9axtxg0l1Hf4cCKpI1P4ZXQI
X-Gm-Message-State: AOJu0YwcoZAsp4jSWkvL0uDK8ixSHvmltKWEIRdyNOUZvgw0Tdk64d7P
	NK/ir3LABMCC01vm9FY0eowUl59CzaoBb8KSkKf65XQgosMVsU/tF+3+P+ifO/lBfXThNzLa/xN
	D1A==
X-Google-Smtp-Source: AGHT+IFbSWrUqUEAgrLY6JePy3EwV7Ny9LND4RDwM9prINLxhsyL4egFps4aRssQj4tvxTm8hIFc1i+KYtc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:fb05:b0:1eb:50eb:81bc with SMTP id
 d9443c01a7336-1ef43f53d7bmr119225ad.13.1715285001029; Thu, 09 May 2024
 13:03:21 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:44 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-53-edliaw@google.com>
Subject: [PATCH v3 52/68] selftests/riscv: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/riscv/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index c333263f2b27..4664ed79e20b 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -3,7 +3,7 @@
 # Originally tools/testing/arm64/abi/Makefile
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 TEST_GEN_FILES := mmap_default mmap_bottomup
 
-- 
2.45.0.118.g7fe29c98d7-goog


