Return-Path: <netdev+bounces-250893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20ED3976C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39003004512
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F51532E739;
	Sun, 18 Jan 2026 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/U93Q4D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8BF284671
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768749899; cv=none; b=KWCqpPgdxVDYURWRu0QbCCY87NBTcBYfk7EfdiagBVd6o1lc2JFsR/J1GCd7C98BMSNbSru+EmW3Q+3zs3APD08eNnUy1OoRwALv3mp6Y53lDPNReNr4jIiitlq1WjCZR/poYpwQ93iAGmeMWkNlwDThr1vGMnVY+oPrZxooov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768749899; c=relaxed/simple;
	bh=VHmiJuMJbPDpWxV4IYXEc28L56C4UEafSbGq24gbvpc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rlCmd8JJyZsxouPD6f/0nzfjXP5DJk3bbig9bqBDKxexq1/hIkYK1we1jFsrx7TlLJy9osKc92F60fzkr7p4Xaj95qZhxLWytmUOT0OCxpiShedgzZRWRCp+lrivQqiTvY13FyefOk1TSPvWVWkh2BryQOqDJLpUvicFeVRY+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/U93Q4D; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c6a87029b6so564067585a.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 07:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768749897; x=1769354697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2LHv3OrSa9OqYQbqrtUVrMolbL3HFUqKriN4YFc7z+I=;
        b=A/U93Q4Dvmo390GXhKWWL3r1pzJCGt0IzXXdazndzPK3M3VoBjWFLDFAGG8nKVgdWG
         pVc7ng92QRVzJSDgTBeNipF/rQGDIKlqUm2lJyTqFhJM4zeaKiwFVQaCr8+RtKZE0/kx
         v1XiukK576dw6AROa10+oQDCZLHVDbJi+mKWafwoqz9Ot+d0llGD7U6DGJMwCg4exIj9
         2yslnS0zannmaC4GB8gHaQGVOP5ShugvAXzTA1Cdxo06nCnNchK9F0Mpr2q+yCbnkm0U
         NBfyaILVYqnD1Fc/t3rKSvJkMZP/NKkhTfCUsd3oj0oULrxp6LbwXdZEP0sT2UKaso3R
         ZTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768749897; x=1769354697;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LHv3OrSa9OqYQbqrtUVrMolbL3HFUqKriN4YFc7z+I=;
        b=CC7ox2+N7nWf5rf+7x1bf3qwrBcKOgzrefMgF2mNiQ6E9i7ome+byiZeg3LRcaVqcp
         iDpm8kxWRHIPGgm2qIoPF+elzLR0/PKFJhywUbHAUGtIr01Z0HA/+j+KXCNtVAfuv7hV
         ZJOvG0ex2XIfOrxq7E3mGLX43D4wHmdq9dPKLG0oGXqs7wGj7HJJb4ikROgRisTgykco
         d3QwiMdUOVpl1gFB14ibYxAlHnBTgo86O3qlktQzMwjv521VebFim9PkvXDlwH5eUcIa
         fNMb7GBClD9rOvQWG/ONdxNC7zq1X1rXXJQJh8lj7/e+zkCU/j1BX/xOdAFPYbcTMJnu
         YUqg==
X-Forwarded-Encrypted: i=1; AJvYcCXY+Rse7G7JADrASkyBL+xf0Wfp2ccRFe6VWQRe/fmqbwmAPXOOa2GgcV1rTRWlTlL9wDV077o=@vger.kernel.org
X-Gm-Message-State: AOJu0YymfV2v6urqE/A3FKxttzv4GOTg+lOmtrGbbP6dA0iJq0utSKGr
	QMD0cuSFLKW23BEVx6/oVVQjyF3KDaxvyFgPwKZ9ScU55iYvfytlKEfXboN8wp03b6YnTJw28ui
	Mo+ozGOQW5lieKw==
X-Received: from qkaj7.prod.google.com ([2002:a05:620a:a47:b0:8c5:308b:42d0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:191e:b0:8b2:ec00:7840 with SMTP id af79cd13be357-8c6a6704482mr1232976285a.27.1768749897014;
 Sun, 18 Jan 2026 07:24:57 -0800 (PST)
Date: Sun, 18 Jan 2026 15:24:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260118152448.2560414-1-edumazet@google.com>
Subject: [PATCH] compiler_types: Introduce inline_for_performance
From: Eric Dumazet <edumazet@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Nicolas Pitre <npitre@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

inline keyword is often ignored by compilers.

We need something slightly stronger in networking fast paths
but __always_inline is too strong.

Instead, generalize idea Nicolas used in commit d533cb2d2af4
("__arch_xprod64(): make __always_inline when optimizing for performance")

This will help CONFIG_CC_OPTIMIZE_FOR_SIZE=y users keeping
their kernels small.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/176847720679.3956289.12601442580224129560.git-patchwork-notify@kernel.org/T/#m2d7e201372a8aae1ce62a0b548e55fd4fe804909
Cc: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm/include/asm/div64.h   |  6 +-----
 include/asm-generic/div64.h    |  6 +-----
 include/linux/compiler_types.h | 10 ++++++++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index d3ef8e416b27d22d38bf084e091b0e4795f74bd4..877dfc4c4c7344849eec2109b66c2825561719dc 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -52,11 +52,7 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
 
 #else
 
-#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
-static __always_inline
-#else
-static inline
-#endif
+static inline_for_performance
 uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
 {
 	unsigned long long res;
diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index 25e7b4b58dcf55a395b9db72e01f2cd220da58a0..9893356fff55679304f68833c11c8ae9052b9cea 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -134,11 +134,7 @@
  * Hoping for compile-time optimization of  conditional code.
  * Architectures may provide their own optimized assembly implementation.
  */
-#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
-static __always_inline
-#else
-static inline
-#endif
+static inline_for_performance
 uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
 {
 	uint32_t m_lo = m;
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d3318a3c257775d4f44e8f2eb7911ac52eefecc5..58b3de1f4c2540b6ffabd916948396ac8df9ba8f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -248,6 +248,16 @@ struct ftrace_likely_data {
  */
 #define inline inline __gnu_inline __inline_maybe_unused notrace
 
+/*
+ * Compilers might decide to ignore inline hint.
+ * Functions that are performance critical can use inline_for_performance.
+ */
+#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
+#define inline_for_performance __always_inline
+#else
+#define inline_for_performance
+#endif
+
 /*
  * gcc provides both __inline__ and __inline as alternate spellings of
  * the inline keyword, though the latter is undocumented. New kernel

base-commit: e84d960149e71e8d5e4db69775ce31305898ed0c
-- 
2.52.0.457.g6b5491de43-goog


