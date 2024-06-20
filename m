Return-Path: <netdev+bounces-105291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206B910605
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF15AB23AA3
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1F61B29B0;
	Thu, 20 Jun 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mDck/gTw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="twD7uYx2"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357141B0133;
	Thu, 20 Jun 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890057; cv=none; b=mjcrOQTwYAgjfyoNy+PmDUFaS6N6R9GUWD/qwW1NcRsA+JXHHV5MAu1aEbqRBMc7Cmd6HoSxzoxZV838xgE6NK2VKlHU8qdmFIPOlRdVVc3EvQsPyme3dmQuozNrZvQw7vgaE4MGDV/hE8iYTKaYxMTI1c8qok00eJFDUPOA8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890057; c=relaxed/simple;
	bh=1vLGuywkKXgAITcXqnFVZDkwztcMBbiNTnJd4tFAyYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtIJCuELh5TWo+rDk1kmK73j9O7HoKaA8OPSSsf/wzIHFymdtAIcdqsaEgCjQb7MOwe/bUEPv8xow3zM24Qk7kaAVQyeYFjuy4KGvjF5EXCEayP0fbjjVCXNWT2lq5RbiH01KS9hyBjLAXlJ5HwsXp2NbrpSZeFMRN3KIZq0qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mDck/gTw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=twD7uYx2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718890053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhjueB/Zw+st/p0jwSxRVntltx2CtPizCDSJU2xaKnU=;
	b=mDck/gTw1kmE3u0xoNApi6XY6MJ++cp/Ik/QpcT+id68ciyDT/6m2MwV2g9lGI3c6Ytm57
	HZwQ3azh46DKpuuniM3PNH/oomMAt3f8xcd/5WihIq125ZdsYkgH4vkzm/S8HM32iKSnjv
	73eqY+oAgmN49xny1OAFHRxU0jZHcQ2ln1u8SeFaDjXQsmfg9ush2V7yu8YKybaGS1Po7K
	79mpjFtrOUnbe9Kga3LsOBS6kk1ct9jzoNwnwagHZEBHPoPZvbrwg6y24aDtqtB2VW/9K/
	oAFPSc36OT9mnR65w0SqLhhUP94BX1PHoDxCLgwPvCyBIZPkZ1+xQMK6QF9i4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718890053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhjueB/Zw+st/p0jwSxRVntltx2CtPizCDSJU2xaKnU=;
	b=twD7uYx2DmX6vPUj2NNU3bmMvuvaKQQSYDtHmVVnsxHTMCkJ3UUhaW3NMPgMd768wPC8cR
	OqlarP5iwZ+iuOAQ==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
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
Subject: [PATCH v9 net-next 08/15] net: softnet_data: Make xmit per task.
Date: Thu, 20 Jun 2024 15:21:58 +0200
Message-ID: <20240620132727.660738-9-bigeasy@linutronix.de>
In-Reply-To: <20240620132727.660738-1-bigeasy@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
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
`recursion' counter gets incremented by different threads and exceeds
XMIT_RECURSION_LIMIT leading to a false positive recursion alert.
The `more' member is subject to similar problems if set by one thread
for one driver and wrongly used by another driver within another thread.

Instead of adding a lock to protect the per-CPU variable it is simpler
to make xmit per-task. Sending and receiving skbs happens always
in thread context anyway.

Having a lock to protected the per-CPU counter would block/ serialize two
sending threads needlessly. It would also require a recursive lock to
ensure that the owner can increment the counter further.

Make the softnet_data.xmit a task_struct member on PREEMPT_RT. Add
needed wrapper.

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
 include/linux/netdevice.h      | 42 +++++++++++++++++++++++++---------
 include/linux/netdevice_xmit.h | 13 +++++++++++
 include/linux/sched.h          |  5 +++-
 net/core/dev.c                 | 14 ++++++++++++
 net/core/dev.h                 | 18 +++++++++++++++
 5 files changed, 80 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/netdevice_xmit.h

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c83b390191d47..f6fc9066147d2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -43,6 +43,7 @@
=20
 #include <linux/netdev_features.h>
 #include <linux/neighbour.h>
+#include <linux/netdevice_xmit.h>
 #include <uapi/linux/netdevice.h>
 #include <uapi/linux/if_bonding.h>
 #include <uapi/linux/pkt_cls.h>
@@ -3223,13 +3224,7 @@ struct softnet_data {
 	struct sk_buff_head	xfrm_backlog;
 #endif
 	/* written and read only by owning cpu: */
-	struct {
-		u16 recursion;
-		u8  more;
-#ifdef CONFIG_NET_EGRESS
-		u8  skip_txqueue;
-#endif
-	} xmit;
+	struct netdev_xmit xmit;
 #ifdef CONFIG_RPS
 	/* input_queue_head should be written by cpu owning this struct,
 	 * and only read by other cpus. Worth using a cache line.
@@ -3257,10 +3252,18 @@ struct softnet_data {
=20
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
=20
+#ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
 {
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
+#else
+static inline int dev_recursion_level(void)
+{
+	return current->net_xmit.recursion;
+}
+
+#endif
=20
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
@@ -4872,18 +4875,35 @@ static inline ktime_t netdev_get_tstamp(struct net_=
device *dev,
 	return hwtstamps->hwtstamp;
 }
=20
-static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops =
*ops,
-					      struct sk_buff *skb, struct net_device *dev,
-					      bool more)
+#ifndef CONFIG_PREEMPT_RT
+static inline void netdev_xmit_set_more(bool more)
 {
 	__this_cpu_write(softnet_data.xmit.more, more);
-	return ops->ndo_start_xmit(skb, dev);
 }
=20
 static inline bool netdev_xmit_more(void)
 {
 	return __this_cpu_read(softnet_data.xmit.more);
 }
+#else
+static inline void netdev_xmit_set_more(bool more)
+{
+	current->net_xmit.more =3D more;
+}
+
+static inline bool netdev_xmit_more(void)
+{
+	return current->net_xmit.more;
+}
+#endif
+
+static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops =
*ops,
+					      struct sk_buff *skb, struct net_device *dev,
+					      bool more)
+{
+	netdev_xmit_set_more(more);
+	return ops->ndo_start_xmit(skb, dev);
+}
=20
 static inline netdev_tx_t netdev_start_xmit(struct sk_buff *skb, struct ne=
t_device *dev,
 					    struct netdev_queue *txq, bool more)
diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmit.h
new file mode 100644
index 0000000000000..38325e0702968
--- /dev/null
+++ b/include/linux/netdevice_xmit.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_NETDEVICE_XMIT_H
+#define _LINUX_NETDEVICE_XMIT_H
+
+struct netdev_xmit {
+	u16 recursion;
+	u8  more;
+#ifdef CONFIG_NET_EGRESS
+	u8  skip_txqueue;
+#endif
+};
+
+#endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6d..5187486c25222 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -36,6 +36,7 @@
 #include <linux/signal_types.h>
 #include <linux/syscall_user_dispatch_types.h>
 #include <linux/mm_types_task.h>
+#include <linux/netdevice_xmit.h>
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers_types.h>
 #include <linux/restart_block.h>
@@ -975,7 +976,9 @@ struct task_struct {
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
 #endif
-
+#ifdef CONFIG_PREEMPT_RT
+	struct netdev_xmit		net_xmit;
+#endif
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
=20
 	struct restart_block		restart_block;
diff --git a/net/core/dev.c b/net/core/dev.c
index 093d82bf0e288..95b9e4cc17676 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3940,6 +3940,7 @@ netdev_tx_queue_mapping(struct net_device *dev, struc=
t sk_buff *skb)
 	return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
 }
=20
+#ifndef CONFIG_PREEMPT_RT
 static bool netdev_xmit_txqueue_skipped(void)
 {
 	return __this_cpu_read(softnet_data.xmit.skip_txqueue);
@@ -3950,6 +3951,19 @@ void netdev_xmit_skip_txqueue(bool skip)
 	__this_cpu_write(softnet_data.xmit.skip_txqueue, skip);
 }
 EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
+
+#else
+static bool netdev_xmit_txqueue_skipped(void)
+{
+	return current->net_xmit.skip_txqueue;
+}
+
+void netdev_xmit_skip_txqueue(bool skip)
+{
+	current->net_xmit.skip_txqueue =3D skip;
+}
+EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
+#endif
 #endif /* CONFIG_NET_EGRESS */
=20
 #ifdef CONFIG_NET_XGRESS
diff --git a/net/core/dev.h b/net/core/dev.h
index 58f88d28bc994..5654325c5b710 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -150,6 +150,8 @@ struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
=20
 #define XMIT_RECURSION_LIMIT	8
+
+#ifndef CONFIG_PREEMPT_RT
 static inline bool dev_xmit_recursion(void)
 {
 	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
@@ -165,6 +167,22 @@ static inline void dev_xmit_recursion_dec(void)
 {
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
+#else
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(current->net_xmit.recursion > XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	current->net_xmit.recursion++;
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	current->net_xmit.recursion--;
+}
+#endif
=20
 int dev_set_hwtstamp_phylib(struct net_device *dev,
 			    struct kernel_hwtstamp_config *cfg,
--=20
2.45.2


