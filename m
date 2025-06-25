Return-Path: <netdev+bounces-200909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E691AE751F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E07175595
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AAD1DDC2B;
	Wed, 25 Jun 2025 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9ItMkGz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C951D90DF;
	Wed, 25 Jun 2025 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750821090; cv=none; b=tgtbVTZVUu0X7UzCuyZWQIhScrtOGn5W62z+csnIXw7ywSc+NQXh6E2jjQeQOPJZMTsBJ7eayJAJRIkBeK+Mw+dSh/dNd7CzLq8oqRLpg3qCRUx9ZjRoVqTmejEpK3Q/Y+JAiRVi6OK9IcGr/aARm78S+OsAt+jUornuIPgsBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750821090; c=relaxed/simple;
	bh=TpNMyZrlm4tnbU8qIbQP9OAezqCkZ8eRw46ditrX03g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cc84KsUrCKWTEIX1R6DV6oYpVOacXdkZ59/kYM1FViZTGyZzigbJD3WbRPVYFQyInaWoJg0xVnVx9eAwB23E8AuuGC+8MICmRZCeDYeySe4Y7UCY/rL6R0kVvH/y/YCAqDLj/+x5/Gny7JU2dm/pgf15IdjESpPA42VT3pT76V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9ItMkGz; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fafdd322d3so68603096d6.3;
        Tue, 24 Jun 2025 20:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750821087; x=1751425887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=boywPtnWXFrorYFTYWBJNeUbr+NvAx7NTSh4JFed8T4=;
        b=j9ItMkGz0FixI+Qa7A44usw4bQ/lLJM2tmoKM0qTAt2z2/mLtqWfMAF2B3kzY8PzRp
         Mb8EjXF/HUU+7nYBxfnvyoqT3S0Xhi/nvLBoDpNbSaiR6ThecK7LOiMuEj1TEY9IBGy/
         ac8Hdi5L7DI8m6qxwLylzsrUApGCsj9uXcMBOHuYHxdlGbzfVLHcD5qKuSqq6MR84Znz
         Xx/uDimfaxgubDfpeM1B4ahtriAfAeavW5dxSiZGqxRcS+Q9EvksiSCiDDRsI/S2VWz4
         ZLEsOLDrQXxM5V17QuseZRya93ma8E8tlVh73AZ+TRhoAAcFTYYCjTukQqvPJxGj/erl
         A/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750821087; x=1751425887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boywPtnWXFrorYFTYWBJNeUbr+NvAx7NTSh4JFed8T4=;
        b=tOQ6gM+QshLUq5u2IHHpcrwDDwnq/XHVtt6D1hgDdclEzzbjSidS+mV+s9A5CX8u3H
         doXcOFKHCEPps+Ysg/1T0ZqBsB7NfxlBvL/GCg01Mc/7RRJb1ReVJRofa6lDBZWLTDlh
         Dkk6KOV80hEjfyOVS/+TuElLKDG8zB/MKPkyTc9uLdk7Rad/ZDRk5NqbJX5q0pe0WF3s
         KZXXBHX1ImScJczlzCyPbaxgjhQvWXkFUEqMwwJnIynVHRYnYNkWjMsemeFF89L5/7PV
         oeKUrqmsVjvMjoFl3bnzI/xH2v0iK0jYLTNELdEQPjKBTjj2X5nF/RqxA3lMKpHOyjeQ
         pIFw==
X-Forwarded-Encrypted: i=1; AJvYcCWZebJT/5CE3yD8JRJ1h+ZYcF+xQXXrGCWaSA4QIs8z8RkvdBCu7LaNj4fDNV9SaM3ijQ3A@vger.kernel.org, AJvYcCWrFgEizx9g0EFWSS2R2m06cSl5pW6cXrsdYjSddS7d94oV99u4Rfz9nJLiJPs7lnwaceHGUMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhrH8ZrDqkk+tll1rvMwtlmw/c+pDdkINRJF29PIDXQoq87CV
	u5Vw0MralNuIK/wlKKh4PUA90QRlPfInS7eZJIjnCT6O2KUmHsXHGzeh
X-Gm-Gg: ASbGncsUKfFlVRwsD5nEohsJJ0NS3hSgLCP6vh4OvUERVXAKsDr4p52ctKZx+sHipPR
	H+KhvgxVB0z8h3Wn8lp3oPmYtndYGfv75PdZsjxcyeKrXDoFPSbq7RRcta12EYJSFpltHED9S4g
	drrbLUZ/FCAd7LeC8I/vtm5a9nYwEfqykolWdnoFL5tdkuQ4GQmlpks24o242mT+vxHg86TGz6R
	mmPDkroWumxq/YTUuL4PPIOx6HrjxeVnMBmxllMmQ0V3asOnoxdlOCa+K28nfRPA91cwrtMH9Mq
	Vopat+OMYUpk14m5428N2h2LFNo9RyxfQJnVjh4n6c+zemDj+KBHhMM2ICVZkartHSrEmqiNUlF
	CeFZuKpfu1ttRl/76bv8pRNj4/uGLrZw6OwPy+ls3rqyFCrrUum6f
X-Google-Smtp-Source: AGHT+IGSm71fAe04SBpyuIDvnyyRGSPKtLQRNbYp3JCDXDkvCoRWay4YKL+d8dRstEpJV4yfKMo0Cg==
X-Received: by 2002:ad4:5f85:0:b0:6fa:c81a:621b with SMTP id 6a1803df08f44-6fd5ef42043mr21228666d6.14.1750821087055;
        Tue, 24 Jun 2025 20:11:27 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd1c2c544bsm43838116d6.30.2025.06.24.20.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:11:26 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 17AD4F40066;
	Tue, 24 Jun 2025 23:11:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 24 Jun 2025 23:11:26 -0400
X-ME-Sender: <xms:3WhbaByz6eoAOuuNVOH22m3lV3L9CsA1OzrSuzd6rQwM_IF6s_G2Qg>
    <xme:3WhbaBSHMqpCnc5F1GahG5rvAZRHHoy7kHE-3pe7-Ph6kDNUXbXwjPRpceykZPv7r
    sYVO3sceET-TnfDFQ>
X-ME-Received: <xmr:3WhbaLXTr7J34C3T81DJQZm2bwXONkCy9JDMaHsMhK1wFbw88McLnfF6sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefgheei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvg
    hvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurg
    hvvgesshhtghholhgrsghsrdhnvght
X-ME-Proxy: <xmx:3WhbaDgu0XJd10XykLp5KOj6_Ba-AzkcTyX3fCt1H78glmdtLxZt7Q>
    <xmx:3WhbaDDCejoWtF8W9iTjodP-KlBmOQN7UllXdsTt8E6gqOallW5w-g>
    <xmx:3WhbaMJq4lV_cYF4ZKlnMqH6y96puf8UFVHvtFhuU1L3p7FGh-aH6w>
    <xmx:3WhbaCBSxxYaCH74trqxFuU-X_UCjZnosmG5Vn9q6I34coDCZlPOkQ>
    <xmx:3mhbaHyE10R5yEuAJfZ6_R33m-IVjO6WyKbJooNCZNkmT511yf278yCC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 23:11:24 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	aeh@meta.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jhs@mojatatu.com,
	kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: [PATCH 1/8] Introduce simple hazard pointers
Date: Tue, 24 Jun 2025 20:10:54 -0700
Message-Id: <20250625031101.12555-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250625031101.12555-1-boqun.feng@gmail.com>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
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
2.39.5 (Apple Git-154)


