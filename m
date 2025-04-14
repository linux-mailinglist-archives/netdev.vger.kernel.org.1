Return-Path: <netdev+bounces-182037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A026DA877A6
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D85B7A228F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA011A8F6E;
	Mon, 14 Apr 2025 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTJiMdCC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198B199EBB;
	Mon, 14 Apr 2025 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610485; cv=none; b=hiAlSO51PDBDzdLPN/I08jL7q5MO5LCouOHDHXJU5ySxaFgItyZh54Lx1cERt+QqsVjOOTzudg0JNE5DjgOoqdxMnFqI+9vKy3ychGiQxpl7iE7pnM/DmBbSSjb81A6yIr0w64Gd4tj3LVRH+TvSaHsAa/+rR4n+/bgmX8tG5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610485; c=relaxed/simple;
	bh=MEZ7giHmtw9fWMENPevjSoJlsHffoTXUsiIwAwrxeW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM/navw2/70Qe23LGGy/PxhnWtbq8t59tzjuEUsGBVhV4Dq4s5iDD8w5a326KRW+bYutoecFfOW2U9GZbF81jBpOW64fTfGvdOmluM1GxGgTrTTFbDJrc9ONaItPAsqsIhQp8mWyeB6cDTJApblaaCbQUgrjKV2NL2nTqWXAKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTJiMdCC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5e39d1e0eso395084885a.1;
        Sun, 13 Apr 2025 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610481; x=1745215281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vz0LbkXlPV4anrqa0D131BJNHrlwrd4cBtjVcyihCP4=;
        b=hTJiMdCCiceA5iMq315ops3QGFLCZXRJmFWWnCu9pp+DRtQyUfSbrB1cwO6StQiGW8
         hfqrkctBNY74I9FabAVJ0+mtrsgB63XkTTU7JHwYYG3hqKZaRhqlO9W4vxAy29r+ysIU
         S6/a3rYXgw7XHFI4EJv+EBnX75kaYDJ4zzT50NvaUpXRLv0krBiobJdusXPzECxIF3Wz
         /oEQTE6bFruW/psZ9MbMm9QuAr5Yhjy0O21M+1DNpxGTolpuGt3xTlhwj2emrGjaBUoa
         BlQzKq/SMVs4EWub5j1wGT630I/xxa1jrn2iTldfx3jw8w0OcfS3gWs60bm0kc2wvP91
         ks/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610481; x=1745215281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vz0LbkXlPV4anrqa0D131BJNHrlwrd4cBtjVcyihCP4=;
        b=dovlGT2C5jq0yPck7pAC/FtKjnjMVW5JwhzzTEZYiS/SvX+DMpGpGrKd/lbKzr4+wt
         iKxVLM9HP8jTf9Z0BKIuD0CIZlIno4lK3NvD4tw/3xeGTpfVgr40qPz54ra/kFbERN4o
         cNIImcMNOxK4gy+jQnycC2fxkj4sEot5b5DIfeKL9gDwghPf+Oi732SoDq0qg70naYJN
         /dg9ZiHjaCKxGlAQWeEt07i1q+E6c+5/Z5ZxZ6NskTAcwKewc4yUHP793p3KeDy9EIeV
         G2Tv0b6m1NOLwfH2TUxkOh1MJSaYYbJENhyJ+zSkD65ri0yD0M9Jcfcsi7szMioVwzvN
         sVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCULf5FHUy2eQOiEeHUSMs68tbj7ENInfbuOeQp+EYmpgqQihPUgL+b1fVj114ZhlMlFD7v0@vger.kernel.org, AJvYcCUnhR7/ZR/115vrysA+0QVTril1QRJVF276i8qaCXbgrXZQOD8cm84PiopsK9411CLK8tP6Upe2@vger.kernel.org, AJvYcCXG7EIF0XdO3ivJ8He9ACFipjVatQCJnLlEuHulQlttfF8s3X3pvI8KhkarIFizf0C96YTOIAbljfWRT68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQa/r0xNvc9ysji5RwYrVBDNLj4wo7/NVSkyrRKO+QT3fb9vS5
	tRPXztBdKOZ5v5O0z+frSx37H+V2XaXK4GmlPtTJVmLynLglDLNp
X-Gm-Gg: ASbGncvoGT2K6CpubYf8vTbZkKer6paRgPws4C/ZlhXdRykOSUC5fmA54EDLXxfgLP6
	2h15oCBkNg5ADIwtnikPiqXLr0wTbv3cadB61YK+QCCCGbuGY8Kgjq4WWFkyFv4Dp6RyPQ+6V3t
	kihODi4u4+S4dEweC2Xqz1yf6t+B5nO3IyoGkn1KZMPagErDF+HdP5ICgXSKPkuCk7nWk4ZQWHH
	1NGdfmG/nEAppTuAZjyDfuSmK50cieZBaM2cRKRCXvphXCmzQOs/nILvY1W/iGGfURo7+iM2cdH
	rrGpI/oMP6zK/v+kEtz31J5He+YEAJ14pxj3ZdzaHsYgjg4CLZMKbD3TXLQibvFosmJOAc19XYW
	2wHxTwwW4XLXWIzKir+TGLc2f2rRZc2nQfmCF5o6WZQ==
X-Google-Smtp-Source: AGHT+IFejSegVaNUERFZO2ig/sOvpu3Gz+JaRNwPXpESuceMZMl1hKDnV7fJekIv/VtMTAXs5iP55A==
X-Received: by 2002:a05:620a:4708:b0:7c5:54d7:d744 with SMTP id af79cd13be357-7c7af13289dmr1821167585a.23.1744610480626;
        Sun, 13 Apr 2025 23:01:20 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8969e66sm686730585a.52.2025.04.13.23.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 23:01:20 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8A8E91200043;
	Mon, 14 Apr 2025 02:01:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 02:01:19 -0400
X-ME-Sender: <xms:r6T8Z-dFQYe_UP58bAVc9l3eqEQu9MZL5u3HaJq_Cxjuv817ibOodw>
    <xme:r6T8Z4NpgkYTHxT68RrKoDB20qgUdh9dTcsQLh6apyYzuPL_aP9Fe6qcgffSjbie-
    F4u4vT0GKfKNUnYIw>
X-ME-Received: <xmr:r6T8Z_j2dgbGCVchfNRiSYUlffvmJReqs-4G8Q3ZPseOsNCF9UAuAPK_hVC3SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeljeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhgvihhtrghoseguvggsihgrnhdrohhrghdprhgtphhtthhopehpvghtvghriies
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtg
    homhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhho
    nhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprggvhhesmhgvthgrrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:r6T8Z79jDaRvBM6srJqfkcTnZ5kX8EjXSmChW7iqSy09Bmp6dAvSMQ>
    <xmx:r6T8Z6vWqLPzsp50aGHeBCtopXKoqK6B3ptEyI6oEE7H1mHQYvBC5w>
    <xmx:r6T8ZyGlS-AotWK3Y8nZXETwNVVQbO-2XisqRTxD5T-osf1tUrWKwA>
    <xmx:r6T8Z5OGmsHVpn_-6lGYrp3EpoQnKhT9nuHTo6xmHw31uaxwBF-RIA>
    <xmx:r6T8Z3Mr6NVWQQoa6adI8-KPyBvYkgQKYFHGmDwnTPRkzUTx3aFo1usN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:01:18 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Breno Leitao <leitao@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: aeh@meta.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC PATCH 1/8] Introduce simple hazard pointers
Date: Sun, 13 Apr 2025 23:00:48 -0700
Message-ID: <20250414060055.341516-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414060055.341516-1-boqun.feng@gmail.com>
References: <20250414060055.341516-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As its name suggests, simple hazard pointers (shazptr) is a
simplification of hazard pointers [1]: it has only one hazard pointer
slot per-CPU and is targeted for simple use cases where the read-side
already has preemption disabled. It's a trade-off between full features
of a normal hazard pointer implementation (multiple slots, dynamic slot
allocation, etc.) and the simple use scenario.

Since there's only one slot per-CPU, so shazptr read-side critical
section nesting is a problem that needs to be resolved, because at very
least, interrupts and NMI can introduce nested shazptr read-side
critical sections. A SHAZPTR_WILDCARD is introduced to resolve this:
SHAZPTR_WILDCARD is a special address value that blocks *all* shazptr
waiters. In an interrupt-causing shazptr read-side critical section
nesting case (i.e. an interrupt happens while the per-CPU hazard pointer
slot being used and tries to acquire a hazard pointer itself), the inner
critical section will switch the value of the hazard pointer slot into
SHAZPTR_WILDCARD, and let the outer critical section eventually zero the
slot. The SHAZPTR_WILDCARD still provide the correct protection because
it blocks all the waiters.

It's true that once the wildcard mechanism is activated, shazptr
mechanism may be downgrade to something similar to RCU (and probably
with a worse implementation), which generally has longer wait time and
larger memory footprint compared to a typical hazard pointer
implementation. However, that can only happen with a lot of users using
hazard pointers, and then it's reasonable to introduce the
fully-featured hazard pointer implementation [2] and switch users to it.

Note that shazptr_protect() may be added later, the current potential
usage doesn't require it, and a shazptr_acquire(), which installs the
protected value to hazard pointer slot and proves the smp_mb(), is
enough for now.

[1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
     lock-free objects," in IEEE Transactions on Parallel and
     Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004

Link: https://lore.kernel.org/lkml/20240917143402.930114-1-boqun.feng@gmail.com/ [2]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/shazptr.h  | 73 ++++++++++++++++++++++++++++++++++++++++
 kernel/locking/Makefile  |  2 +-
 kernel/locking/shazptr.c | 29 ++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/shazptr.h
 create mode 100644 kernel/locking/shazptr.c

diff --git a/include/linux/shazptr.h b/include/linux/shazptr.h
new file mode 100644
index 000000000000..287cd04b4be9
--- /dev/null
+++ b/include/linux/shazptr.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Simple hazard pointers
+ *
+ * Copyright (c) 2025, Microsoft Corporation.
+ *
+ * Author: Boqun Feng <boqun.feng@gmail.com>
+ *
+ * A simple variant of hazard pointers, the users must ensure the preemption
+ * is already disabled when calling a shazptr_acquire() to protect an address.
+ * If one shazptr_acquire() is called after another shazptr_acquire() has been
+ * called without the corresponding shazptr_clear() has been called, the later
+ * shazptr_acquire() must be cleared first.
+ *
+ * The most suitable usage is when only one address need to be protected in a
+ * preemption disabled critical section.
+ */
+
+#ifndef _LINUX_SHAZPTR_H
+#define _LINUX_SHAZPTR_H
+
+#include <linux/cleanup.h>
+#include <linux/percpu.h>
+
+/* Make ULONG_MAX the wildcard value */
+#define SHAZPTR_WILDCARD ((void *)(ULONG_MAX))
+
+DECLARE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
+
+/* Represent a held hazard pointer slot */
+struct shazptr_guard {
+	void **slot;
+	bool use_wildcard;
+};
+
+/*
+ * Acquire a hazptr slot and begin the hazard pointer critical section.
+ *
+ * Must be called with preemption disabled, and preemption must remain disabled
+ * until shazptr_clear().
+ */
+static inline struct shazptr_guard shazptr_acquire(void *ptr)
+{
+	struct shazptr_guard guard = {
+		/* Preemption is disabled. */
+		.slot = this_cpu_ptr(&shazptr_slots),
+		.use_wildcard = false,
+	};
+
+	if (likely(!READ_ONCE(*guard.slot))) {
+		WRITE_ONCE(*guard.slot, ptr);
+	} else {
+		guard.use_wildcard = true;
+		WRITE_ONCE(*guard.slot, SHAZPTR_WILDCARD);
+	}
+
+	smp_mb(); /* Synchronize with smp_mb() at synchronize_shazptr(). */
+
+	return guard;
+}
+
+static inline void shazptr_clear(struct shazptr_guard guard)
+{
+	/* Only clear the slot when the outermost guard is released */
+	if (likely(!guard.use_wildcard))
+		smp_store_release(guard.slot, NULL); /* Pair with ACQUIRE at synchronize_shazptr() */
+}
+
+void synchronize_shazptr(void *ptr);
+
+DEFINE_CLASS(shazptr, struct shazptr_guard, shazptr_clear(_T),
+	     shazptr_acquire(ptr), void *ptr);
+#endif
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index a114949eeed5..1517076c98ec 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -3,7 +3,7 @@
 # and is generally not a function of system call inputs.
 KCOV_INSTRUMENT		:= n
 
-obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
+obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o shazptr.o
 
 # Avoid recursion lockdep -> sanitizer -> ... -> lockdep & improve performance.
 KASAN_SANITIZE_lockdep.o := n
diff --git a/kernel/locking/shazptr.c b/kernel/locking/shazptr.c
new file mode 100644
index 000000000000..991fd1a05cfd
--- /dev/null
+++ b/kernel/locking/shazptr.c
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Simple hazard pointers
+ *
+ * Copyright (c) 2025, Microsoft Corporation.
+ *
+ * Author: Boqun Feng <boqun.feng@gmail.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/cpumask.h>
+#include <linux/shazptr.h>
+
+DEFINE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
+EXPORT_PER_CPU_SYMBOL_GPL(shazptr_slots);
+
+void synchronize_shazptr(void *ptr)
+{
+	int cpu;
+
+	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
+	for_each_possible_cpu(cpu) {
+		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
+		/* Pair with smp_store_release() in shazptr_clear(). */
+		smp_cond_load_acquire(slot,
+				      VAL != ptr && VAL != SHAZPTR_WILDCARD);
+	}
+}
+EXPORT_SYMBOL_GPL(synchronize_shazptr);
-- 
2.47.1


