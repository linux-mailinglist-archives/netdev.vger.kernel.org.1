Return-Path: <netdev+bounces-99128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B38D3C72
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AC32824CC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59650187342;
	Wed, 29 May 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ECAKNOGW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H1llMsPN"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F91836FD;
	Wed, 29 May 2024 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000177; cv=none; b=D0qJyc+tqbMP7FII+FlVN5Qlsj9H+csX39XvWaIvEM0Acp+q9Ai/zB/jp+RdShyTgzSYilDHiSBkpHayBtwsvAaBpp73hCJiM9/dhcV+wkDn8ixeOt5SoHhszYqseyCxgmZ8bI14PLtV72xeDXfEr1XgAaWmtRlehDUXTP0RlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000177; c=relaxed/simple;
	bh=CpjnF7NQ8ik/bsSLPjV6QCgLsAnODb+JFk1ApHKH3xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssgo602WwabkJRJONTuznaxsOCdmxsVG2/7TJ0++0ZQM76FLQla8NMr7ifWAdZ5X3R0QvaOxb5Gphuq6mMEE+A4s4p51IcxbGeMlAcTBl3UUtN8ZAz+8XF4T2lsAj26+s11BGgKtN5Vn9vFwrDCPQ4lfoGMlbeLY7a3AGU6R7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ECAKNOGW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H1llMsPN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717000173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKeHb6yb6kbztXYTRHNbaIQnvhpfvhLJP9xjIPFBDgI=;
	b=ECAKNOGWzRxlU2VAIzFvv5NQczAwkugXa8I4J9SotvyIafyci7YHLQQvuNjB2FXJ8T1Raa
	fqroVg4kt0i82EaxZT7BEwB1/0VAblg9XuTYODYcMqsbwqRBE6szdeK6EE/TS28V5+47nr
	lYP9nHWKbW2+Slv2jRTOEO+b8Uw3zA1hgGniulfE8rletZAjvWa9Wn6iV8XxnivxO+eRqe
	fZBDVRh1STH3ScLcLPv8/auKK7tRqXu4QUZrlwrDpPQU6ah+oZbf/gSO/NBN1ef8wP70Wc
	CqLvhT/z+9S+76+6klDRazXegWe5+yIu55G9q0azQgM7CsNWDgDhRl+c/ykIcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717000173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKeHb6yb6kbztXYTRHNbaIQnvhpfvhLJP9xjIPFBDgI=;
	b=H1llMsPN+HEBWjRY4UDV3XetYWz2Ge/80Y/WHdWbChqPbdmKrQ51K+2CeER3LLEiKRtnQm
	e3JUELoYXhMm2ACA==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 net-next 02/15] locking/local_lock: Add local nested BH locking infrastructure.
Date: Wed, 29 May 2024 18:02:25 +0200
Message-ID: <20240529162927.403425-3-bigeasy@linutronix.de>
In-Reply-To: <20240529162927.403425-1-bigeasy@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add local_lock_nested_bh() locking. It is based on local_lock_t and the
naming follows the preempt_disable_nested() example.

For !PREEMPT_RT + !LOCKDEP it is a per-CPU annotation for locking
assumptions based on local_bh_disable(). The macro is optimized away
during compilation.
For !PREEMPT_RT + LOCKDEP the local_lock_nested_bh() is reduced to
the usual lock-acquire plus lockdep_assert_in_softirq() - ensuring that
BH is disabled.

For PREEMPT_RT local_lock_nested_bh() acquires the specified per-CPU
lock. It does not disable CPU migration because it relies on
local_bh_disable() disabling CPU migration.
With LOCKDEP it performans the usual lockdep checks as with !PREEMPT_RT.
Due to include hell the softirq check has been moved spinlock.c.

The intention is to use this locking in places where locking of a per-CPU
variable relies on BH being disabled. Instead of treating disabled
bottom halves as a big per-CPU lock, PREEMPT_RT can use this to reduce
the locking scope to what actually needs protecting.
A side effect is that it also documents the protection scope of the
per-CPU variables.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/local_lock.h          | 10 ++++++++++
 include/linux/local_lock_internal.h | 31 +++++++++++++++++++++++++++++
 include/linux/lockdep.h             |  3 +++
 kernel/locking/spinlock.c           |  8 ++++++++
 4 files changed, 52 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 82366a37f4474..091dc0b6bdfb9 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -62,4 +62,14 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __p=
ercpu,
 		    local_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
=20
+#define local_lock_nested_bh(_lock)				\
+	__local_lock_nested_bh(_lock)
+
+#define local_unlock_nested_bh(_lock)				\
+	__local_unlock_nested_bh(_lock)
+
+DEFINE_GUARD(local_lock_nested_bh, local_lock_t __percpu*,
+	     local_lock_nested_bh(_T),
+	     local_unlock_nested_bh(_T))
+
 #endif
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index 975e33b793a77..8dd71fbbb6d2b 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -62,6 +62,17 @@ do {								\
 	local_lock_debug_init(lock);				\
 } while (0)
=20
+#define __spinlock_nested_bh_init(lock)				\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
+	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
+			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
+			      LD_LOCK_NORMAL);			\
+	local_lock_debug_init(lock);				\
+} while (0)
+
 #define __local_lock(lock)					\
 	do {							\
 		preempt_disable();				\
@@ -98,6 +109,15 @@ do {								\
 		local_irq_restore(flags);			\
 	} while (0)
=20
+#define __local_lock_nested_bh(lock)				\
+	do {							\
+		lockdep_assert_in_softirq();			\
+		local_lock_acquire(this_cpu_ptr(lock));	\
+	} while (0)
+
+#define __local_unlock_nested_bh(lock)				\
+	local_lock_release(this_cpu_ptr(lock))
+
 #else /* !CONFIG_PREEMPT_RT */
=20
 /*
@@ -138,4 +158,15 @@ typedef spinlock_t local_lock_t;
=20
 #define __local_unlock_irqrestore(lock, flags)	__local_unlock(lock)
=20
+#define __local_lock_nested_bh(lock)				\
+do {								\
+	lockdep_assert_in_softirq_func();			\
+	spin_lock(this_cpu_ptr(lock));				\
+} while (0)
+
+#define __local_unlock_nested_bh(lock)				\
+do {								\
+	spin_unlock(this_cpu_ptr((lock)));			\
+} while (0)
+
 #endif /* CONFIG_PREEMPT_RT */
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 5e51b0de4c4b5..fcc02812bf31e 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -605,6 +605,8 @@ do {									\
 		     (!in_softirq() || in_irq() || in_nmi()));		\
 } while (0)
=20
+extern void lockdep_assert_in_softirq_func(void);
+
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
@@ -618,6 +620,7 @@ do {									\
 # define lockdep_assert_preemption_enabled() do { } while (0)
 # define lockdep_assert_preemption_disabled() do { } while (0)
 # define lockdep_assert_in_softirq() do { } while (0)
+# define lockdep_assert_in_softirq_func() do { } while (0)
 #endif
=20
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 8475a0794f8c5..438c6086d540e 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -413,3 +413,11 @@ notrace int in_lock_functions(unsigned long addr)
 	&& addr < (unsigned long)__lock_text_end;
 }
 EXPORT_SYMBOL(in_lock_functions);
+
+#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_PREEMPT_RT)
+void notrace lockdep_assert_in_softirq_func(void)
+{
+	lockdep_assert_in_softirq();
+}
+EXPORT_SYMBOL(lockdep_assert_in_softirq_func);
+#endif
--=20
2.45.1


