Return-Path: <netdev+bounces-99135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A5E8D3C83
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006F91C230F8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E021A0AEB;
	Wed, 29 May 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t3dpXEF3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k/NWdQLd"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098819067F;
	Wed, 29 May 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000181; cv=none; b=h2Ec9NTHP9gCFrQl6jYQwRNlqbHIaJFb04Ta+3KGQHPEW8FBy259C6QYaaNjOkmvqpx3Lz0f4V8nkztOmdxQkXVHT7ZqruQR31us+AeDkI+5tRFkfDnNC8f80dbyrzICcuSTK3uvb+gh9USIttedkG/qnp+9hR/sfl8ySK8adSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000181; c=relaxed/simple;
	bh=8mNx9FPoHj4JNcDCiK2qJg5jIW+93DxmgJLrP1yB8cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEH0d0xrZlRqUebw2WyZUG5ZIq+pNgsWg7kHLuX5XwXflMcmWQ2GbSM+xLo6M5+uas4DnPmj554D1YSzzS4x922Bxz9bPq5QPWVzQLaH+gwXbgjxDSqR0tAWb4HXvR0Q0L35+8trxB39NAfoVW1l9bNDLhsdxaog13Wjdi1wkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t3dpXEF3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k/NWdQLd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717000176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeTJF40iEq+NZZllVmnIBl8wcOsjOidTGbpcz9abXes=;
	b=t3dpXEF3hlanB/SrLpS+MYcisqeVyjUs9fhJEY5XHfYt6fhSRG8VyDh8jFyEr2kRGFqNas
	qHLNtPtc7WbdNBrZ5abFWonVlNeyUkl4BJn3t3I6q3QJcYonnh8Ah9IU3MAlHEZHXhpGCZ
	VdGoVCJFNKwRPLdMTFfqg3MLgwZ2lN/Nm5obZ8AI8gLmlxmv+gZCLCWQmQ9Ic5qXMtfC+W
	WQP4s6oleQOrBv/tPuF+5XFPiAgJ9lLFyN/Ne8eN1PygG0gQZXdwFOdJn+JeS8eL0oqurC
	I2gw66PuQjg5V8xMq7VHqG9oAS2g2sQ0WOzeF7ooWvYkpBotcqbYswD/NmQuSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717000176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeTJF40iEq+NZZllVmnIBl8wcOsjOidTGbpcz9abXes=;
	b=k/NWdQLdxINN/JoYw408AdJ8V4E+DO4dy/0bYcr4Jx02XEh242nlRsKdnZPqvb1ZnvubTc
	i9j762RAxzgBzxAQ==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 net-next 08/15] net: softnet_data: Make xmit.recursion per task.
Date: Wed, 29 May 2024 18:02:31 +0200
Message-ID: <20240529162927.403425-9-bigeasy@linutronix.de>
In-Reply-To: <20240529162927.403425-1-bigeasy@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Softirq is preemptible on PREEMPT_RT. Without a per-CPU lock in
local_bh_disable() there is no guarantee that only one device is
transmitting at a time.
With preemption and multiple senders it is possible that the per-CPU
recursion counter gets incremented by different threads and exceeds
XMIT_RECURSION_LIMIT leading to a false positive recursion alert.

Instead of adding a lock to protect the per-CPU variable it is simpler
to make the counter per-task. Sending and receiving skbs happens always
in thread context anyway.

Having a lock to protected the per-CPU counter would block/ serialize two
sending threads needlessly. It would also require a recursive lock to
ensure that the owner can increment the counter further.

Make the recursion counter a task_struct member on PREEMPT_RT.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h | 11 +++++++++++
 include/linux/sched.h     |  4 +++-
 net/core/dev.h            | 20 ++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d20c6c99eb887..b5ec072ec2430 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3223,7 +3223,9 @@ struct softnet_data {
 #endif
 	/* written and read only by owning cpu: */
 	struct {
+#ifndef CONFIG_PREEMPT_RT
 		u16 recursion;
+#endif
 		u8  more;
 #ifdef CONFIG_NET_EGRESS
 		u8  skip_txqueue;
@@ -3256,10 +3258,19 @@ struct softnet_data {
=20
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
=20
+#ifdef CONFIG_PREEMPT_RT
+static inline int dev_recursion_level(void)
+{
+	return current->net_xmit_recursion;
+}
+
+#else
+
 static inline int dev_recursion_level(void)
 {
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
+#endif
=20
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6d..a9b0ca72db55f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -975,7 +975,9 @@ struct task_struct {
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
 #endif
-
+#ifdef CONFIG_PREEMPT_RT
+	u8				net_xmit_recursion;
+#endif
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
=20
 	struct restart_block		restart_block;
diff --git a/net/core/dev.h b/net/core/dev.h
index b7b518bc2be55..2f96d63053ad0 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -150,6 +150,25 @@ struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
=20
 #define XMIT_RECURSION_LIMIT	8
+
+#ifdef CONFIG_PREEMPT_RT
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(current->net_xmit_recursion > XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	current->net_xmit_recursion++;
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	current->net_xmit_recursion--;
+}
+
+#else
+
 static inline bool dev_xmit_recursion(void)
 {
 	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
@@ -165,5 +184,6 @@ static inline void dev_xmit_recursion_dec(void)
 {
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
+#endif
=20
 #endif
--=20
2.45.1


