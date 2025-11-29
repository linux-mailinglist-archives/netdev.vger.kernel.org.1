Return-Path: <netdev+bounces-242696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF00C93BC7
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8137C4E1BE3
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25C26738B;
	Sat, 29 Nov 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1rlC5L1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889872405ED
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764410267; cv=none; b=PkyfUTrJjBNyoXvxVEE7x+C1jhzWR51d1KximVuaWl0l61AZI9fD0/6NO3mpAGybBsf7qcyyg3zps/Zs0w9+5OsOHMgZBPeTT44dMgzkEtyBHJOi2RQ8yjo9SMUrZ8Wav0t+aP5eQAnWpMrf5e9yYQsQYKGxOiLhXfn4ncBfehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764410267; c=relaxed/simple;
	bh=kjC2CRoj1ICKpdLHPJNJwc/suA2ZEqoPeuQugHkxNh8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SoOslbCh7snILi00suKkTxB0yzs2OixfNe4YsJ2tEUH0R77syMxmfB+op8QnFmLKHGoKpxeSk3904VmE0qjezoYcR7ka3my7NplVpEDqgD5xsrVjaOWYDZRwTdEuF3eObKyXTVIZRE48g8P81A9xBOplPEW4uI0Qcf32N+02W94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1rlC5L1; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ed79dd4a47so47169581cf.3
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 01:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764410264; x=1765015064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RaHWpzLeVxoNOwQpfQ6Ps3eCZ1QEUD7c077XzEg2PUA=;
        b=n1rlC5L1Yuo5AgXpxUcRROP9hTO6oVTyIkZ+rfMJ/LnSarblaqqZxDbklhx5JUU+F1
         R4mgjsQdKtaw4oOdcqL+iLWwXdDMxeeNjRxvMpAXZyZ/UeWoNuGbJ2EO4jhfi7ooJ4pb
         +IvGqVsNDjVs/DLkriuMTGVh0QbqVszO71hrspw47FBFjHpC2AIlsGf8/Ae3FBnCXx3Q
         BihRYed6HwAAkthUiypT/MSTVIt0Q9Zb1V+4Udfcv65niAWsO+imho6kHHM0RFXFrCN9
         NAUGKtw3VdSRNiaDDLwhYcW5zZsHK632jvGZALXgNlx0T96FcoB+lhRL34NMq4/9HHyx
         /ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764410264; x=1765015064;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RaHWpzLeVxoNOwQpfQ6Ps3eCZ1QEUD7c077XzEg2PUA=;
        b=F4NMV8xHwHbDM5bD80xnVzGR6hgt1mEKIxr6DCTiSY0rzovfkbI2ooxqJQFTRZnyHn
         41eNjwoJZlHRnJ7Ezxn802Doi27iTChbgNxE1ySfz0A973vGqy6uYfKhzRvucrFIaylb
         e+/onF4g0wMKjPWFfdJV2NlI/5G/+EBNichsqnPaos/RUWtUhzY9SmUsqd9lhuDdGsgP
         umCf0p0n2RbxyJbXOJ4f90YjuR5P6OOd3Joa5KgmhJWeK4aN09kwzszOtuf86eVvke7H
         sooulMeSa80dpFCgVPsOf4E9uIx3UZA5K0eSxD16ZqRqqAKKURPMz0KkQnjMsZ9vwmr7
         AGdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9ZQrSAXgwQ1SnJxlpzjIMklra8SctUP6CatoJlpu4+VsZ8KTsyfxc1pDpJOMNrLye7miVfGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT2UQvgoLcqFZuQ9saZlFb/PKrlxv9/6tTOJ+LjBlP6U7miJfS
	esxCdELjLPo440kcF8Dk4keuz3UbWE9ThZtW9zZDfBxJlNhZ+wVds2+mXfgOKtdMbk08jDEFOGq
	BREU0wNhj2kx9qQ==
X-Google-Smtp-Source: AGHT+IE9e52KmeeUSI7PHmKs+tbnInUYzJa7BV62x1xd1VKYwrIlfZmBDNqCs536+iI8/0ZLLbiasYsjsJ41Ug==
X-Received: from qtql8.prod.google.com ([2002:ac8:4a88:0:b0:4ed:3cc:ba24])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d0e:0:b0:4ed:70fd:1453 with SMTP id d75a77b69052e-4ee58935f18mr428211591cf.60.1764410264593;
 Sat, 29 Nov 2025 01:57:44 -0800 (PST)
Date: Sat, 29 Nov 2025 09:57:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251129095740.3338476-1-edumazet@google.com>
Subject: [PATCH] time/timecounter: inline timecounter_cyc2time()
From: Eric Dumazet <edumazet@google.com>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Kevin Yang <yyd@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"

New network transport protocols want NIC drivers to get hwtstamps
of all incoming packets, and possibly all outgoing packets.

Swift congestion control is used by good old TCP transport and is
our primary need for timecounter_cyc2time(). This will be upstreamed soon.

This means timecounter_cyc2time() can be called more than 100 million
times per second on a busy server.

Inlining timecounter_cyc2time() brings a 12 % improvement on a
UDP receive stress test on a 100Gbit NIC.

Note that FDO, LTO, PGO are unable to magically help for this
case, presumably because NIC drivers are almost exclusively shipped
as modules.

Add an unlikely() around the cc_cyc2ns_backwards() case,
even if FDO (when used) is able to take care of this optimization.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://research.google/pubs/swift-delay-is-simple-and-effective-for-congestion-control-in-the-datacenter/
Cc: Kevin Yang <yyd@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
---
 include/linux/timecounter.h | 33 +++++++++++++++++++++++++++++++--
 kernel/time/timecounter.c   | 35 -----------------------------------
 2 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/include/linux/timecounter.h b/include/linux/timecounter.h
index dce03a5cafb7cfe61bd83304ef49f7721735da64..de21312ebed0f41946304f95f05cc625ea7f2a68 100644
--- a/include/linux/timecounter.h
+++ b/include/linux/timecounter.h
@@ -115,6 +115,16 @@ extern void timecounter_init(struct timecounter *tc,
  */
 extern u64 timecounter_read(struct timecounter *tc);
 
+/*
+ * This is like cyclecounter_cyc2ns(), but it is used for computing a
+ * time previous to the time stored in the cycle counter.
+ */
+static inline u64 cc_cyc2ns_backwards(const struct cyclecounter *cc,
+				      u64 cycles, u64 frac)
+{
+	return ((cycles * cc->mult) - frac) >> cc->shift;
+}
+
 /**
  * timecounter_cyc2time - convert a cycle counter to same
  *                        time base as values returned by
@@ -131,7 +141,26 @@ extern u64 timecounter_read(struct timecounter *tc);
  *
  * Returns: cycle counter converted to nanoseconds since the initial time stamp
  */
-extern u64 timecounter_cyc2time(const struct timecounter *tc,
-				u64 cycle_tstamp);
+static inline u64 timecounter_cyc2time(const struct timecounter *tc,
+				       u64 cycle_tstamp)
+{
+	const struct cyclecounter *cc = tc->cc;
+	u64 delta = (cycle_tstamp - tc->cycle_last) & cc->mask;
+	u64 nsec = tc->nsec, frac = tc->frac;
+
+	/*
+	 * Instead of always treating cycle_tstamp as more recent
+	 * than tc->cycle_last, detect when it is too far in the
+	 * future and treat it as old time stamp instead.
+	 */
+	if (unlikely(delta > cc->mask / 2)) {
+		delta = (tc->cycle_last - cycle_tstamp) & cc->mask;
+		nsec -= cc_cyc2ns_backwards(cc, delta, frac);
+	} else {
+		nsec += cyclecounter_cyc2ns(cc, delta, tc->mask, &frac);
+	}
+
+	return nsec;
+}
 
 #endif
diff --git a/kernel/time/timecounter.c b/kernel/time/timecounter.c
index 3d2a354cfe1c1b205aa960a748a76f8dd94335e2..2e64dbb6302d71d8b092d92dda0b71c99cdc053d 100644
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -62,38 +62,3 @@ u64 timecounter_read(struct timecounter *tc)
 }
 EXPORT_SYMBOL_GPL(timecounter_read);
 
-/*
- * This is like cyclecounter_cyc2ns(), but it is used for computing a
- * time previous to the time stored in the cycle counter.
- */
-static u64 cc_cyc2ns_backwards(const struct cyclecounter *cc,
-			       u64 cycles, u64 mask, u64 frac)
-{
-	u64 ns = (u64) cycles;
-
-	ns = ((ns * cc->mult) - frac) >> cc->shift;
-
-	return ns;
-}
-
-u64 timecounter_cyc2time(const struct timecounter *tc,
-			 u64 cycle_tstamp)
-{
-	u64 delta = (cycle_tstamp - tc->cycle_last) & tc->cc->mask;
-	u64 nsec = tc->nsec, frac = tc->frac;
-
-	/*
-	 * Instead of always treating cycle_tstamp as more recent
-	 * than tc->cycle_last, detect when it is too far in the
-	 * future and treat it as old time stamp instead.
-	 */
-	if (delta > tc->cc->mask / 2) {
-		delta = (tc->cycle_last - cycle_tstamp) & tc->cc->mask;
-		nsec -= cc_cyc2ns_backwards(tc->cc, delta, tc->mask, frac);
-	} else {
-		nsec += cyclecounter_cyc2ns(tc->cc, delta, tc->mask, &frac);
-	}
-
-	return nsec;
-}
-EXPORT_SYMBOL_GPL(timecounter_cyc2time);
-- 
2.52.0.107.ga0afd4fd5b-goog


