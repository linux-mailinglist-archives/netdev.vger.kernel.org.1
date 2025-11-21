Return-Path: <netdev+bounces-240876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CED9FC7BB14
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BF564E164D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3799303A13;
	Fri, 21 Nov 2025 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeYBgsDA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D802F7AB3
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758648; cv=none; b=kjVQF7icbAU6S70VlhAkXta0frDE7Q6h98sX4D+HnMsFxfVJYYrkE+C0wR7A+01ALAWuW+E3A0vo8Cre04wGgt354IxNaSzWneQHnk3joaDHeCjlieTm5U8mien8PM5+TuFNAVOGtcOiPPwaWvlFdCZpMrXSGqj+n22xJ3Q8jLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758648; c=relaxed/simple;
	bh=yEGSclzEy0HCMJpFnPYIguSWn7nHMtZipXnSVMNR4u0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfYtwYist0fYchSwEH4U+ZC4oZEqetBgPEJVsRMx3PEIv4EYjBAq2VSUDYH/3IntbuGaLy0Sgkyhp/gbW/2aZaYNudGfhwnDv16gW+DC+enWQksuvxf61rujoT+d7fcU/8PGyu7+wYezL5mDEOXOrmz3o5ANZwre28KzLYs28zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeYBgsDA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-298250d7769so18552475ad.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763758645; x=1764363445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0e90kbQuRFRNPGgj2N4VURR8qaKhd83Gb50woQGGFOE=;
        b=OeYBgsDAvGPqWf5K+aUcmRXy04KvZriKtRVEsWFZ1vt/VvcsIvEIa3Ff/q1e/Bm9gn
         iX7k4npBtv4eYEr1j5FeTIehKrBDT3ITNcc6/9G649U7d6rnSJMs2u1isPDGjjXLz+RJ
         EcAQgNzKAczGOXnxY7LNNzW4HeDdneF+RbiTeGADjk0mXCY67F3Mbi7JkVtraArz7l//
         tArcc1gDHM1ayPPFkJnkFMp2hni4XUaUQZu2+3eWYA4X15vDzc0Cvyc2ieGCL9s+W3ng
         VcXVahvE1x7+zgsFv3HsQ4wJH/GNR2S2ezE76Z9avGCQN1DHLhrwrgnk3tBrnlJI0sxH
         fIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763758645; x=1764363445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e90kbQuRFRNPGgj2N4VURR8qaKhd83Gb50woQGGFOE=;
        b=Ur2ck9/GlhGvZS656V2N2BsC6zirtDtiF5Q26ytPIo+3BYMdjJ0ZkQJp/2OBm+0PkJ
         t63iBfoQgJYJQsb3/kewS1n8E0jsxaCEJkGfx1pwu0S2g9279UuuwoCCOjQ5YyXFTUvy
         j5qQqcNp7BbLf2dICVyDF93JCiB+muSqSCbDpcaWDePQywAJuBJHKU8OHBzti3l+2hrF
         OcSkyHtqlG82iXgmnLK49N61jit5R9KgdBJAHmdAy1W6BTiI6Aa3hcOxAthiJyoSBpVM
         PBJYkG59noLZa7/riV5W866HKM3U19iuXurT/uTfQMNt7xSxDJv+W1gkug0PNIeWFgAQ
         /bVQ==
X-Gm-Message-State: AOJu0YxG2ZcppIDVZimwAc2cU4L0pP4FMnNEQVmpbPG9yPe3wWOdCIU0
	5U1XrvqD/I4PF6OggWGy4vDmZDz+YaBggfi9wTWgzqNaA38kh1eJ+J0l48OxCA==
X-Gm-Gg: ASbGncvY9NiVQI7isgKcjBrvbYSVRPJW55CMhTRT7EDgOKzByLu7P7f+Zd260hduhpI
	VEDCaPYhvITT7IdPEyhClM3U7cSqt3vIxO5nUn0ps+cLjiBR1HiEfbKuOy0U3I9xv2x5SAoI/lI
	Esi73hGLonBoT90HgNI3UXyOS2CgnYC8Vfu8Nm3No5oo9j8ChMRCN6f02tJF8FNxx1vB6fjU/Yu
	+1TRuKSHgFQAsuiHkH32m8w800swf++DyIdmv4IlIwv6l2I2A6W6RfeeUXq2q6loV/ONZs7a20y
	xtMi1BPiFrKeCbkPbcHk9jJ45A4YQJhn/jGtFispBIUukrYdJuSVVXKrVgAaIO4z7k1hsnDVjE1
	cqGupqw9QcObylTd11TuzjWxAFuPwBoKt6fW2/7t4blqB2IRmANSMKJWxGENLKJHpX86goNB0w+
	MxDVuaMJ1PoA==
X-Google-Smtp-Source: AGHT+IHDzW/1iR1xEDGJ0dwaoqoMH40/yX+pLY9Um5VI4qfzpikefyubAUzl+tIWVfX1qgXtQ8eZkA==
X-Received: by 2002:a17:902:e890:b0:295:9cb5:ae07 with SMTP id d9443c01a7336-29b6c574f95mr49854655ad.38.1763758645359;
        Fri, 21 Nov 2025 12:57:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75dfeeaffsm6393615a12.5.2025.11.21.12.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:57:25 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	david.laight.linux@gmail.com,
	dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] rqspinlock: Annotate rqspinlock lock acquiring functions with __must_check
Date: Fri, 21 Nov 2025 12:57:23 -0800
Message-ID: <20251121205724.2934650-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Locking a resilient queued spinlock can fail when deadlock or timeout
happen. Mark the lock acquring functions with __must_check to make sure
callers always handle the returned error.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/asm-generic/rqspinlock.h | 47 +++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 6d4244d643df..855c09435506 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -171,7 +171,7 @@ static __always_inline void release_held_lock_entry(void)
  * * -EDEADLK	- Lock acquisition failed because of AA/ABBA deadlock.
  * * -ETIMEDOUT - Lock acquisition failed because of timeout.
  */
-static __always_inline int res_spin_lock(rqspinlock_t *lock)
+static __always_inline __must_check int res_spin_lock(rqspinlock_t *lock)
 {
 	int val = 0;
 
@@ -223,27 +223,36 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
 #define raw_res_spin_lock_init(lock) ({ *(lock) = (rqspinlock_t){0}; })
 #endif
 
-#define raw_res_spin_lock(lock)                    \
-	({                                         \
-		int __ret;                         \
-		preempt_disable();                 \
-		__ret = res_spin_lock(lock);	   \
-		if (__ret)                         \
-			preempt_enable();          \
-		__ret;                             \
-	})
+static __always_inline __must_check int raw_res_spin_lock(rqspinlock_t *lock)
+{
+	int ret;
+
+	preempt_disable();
+	ret = res_spin_lock(lock);
+	if (ret)
+		preempt_enable();
+
+	return ret;
+}
 
 #define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_enable(); })
 
-#define raw_res_spin_lock_irqsave(lock, flags)    \
-	({                                        \
-		int __ret;                        \
-		local_irq_save(flags);            \
-		__ret = raw_res_spin_lock(lock);  \
-		if (__ret)                        \
-			local_irq_restore(flags); \
-		__ret;                            \
-	})
+static __always_inline __must_check int
+__raw_res_spin_lock_irqsave(rqspinlock_t *lock, unsigned long *flags)
+{
+	unsigned long __flags;
+	int ret;
+
+	local_irq_save(__flags);
+	ret = raw_res_spin_lock(lock);
+	if (ret)
+		local_irq_restore(__flags);
+
+	*flags = __flags;
+	return ret;
+}
+
+#define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irqsave(lock, &flags)
 
 #define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
 
-- 
2.47.3


