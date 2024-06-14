Return-Path: <netdev+bounces-103661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7C908F80
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A412A1F23888
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696F417DE3D;
	Fri, 14 Jun 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NxIIm3EW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K7uVfacs"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52392030B;
	Fri, 14 Jun 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380893; cv=none; b=KYC520n51NxvFal7+aKFNLgTw71KveR2FZjFRw0k1PhfJu6O07396Mt7/uGb2wBSRXJZoMVWN+bEO+yaj/KbEnPJwYsxi8G2Mp+by5pZ/JZjKpA6LnzV00VCrhUV8ZZIGKGgKNau4VtP8x7Sirr+aFbodzbKqIZoUj+aPV2aD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380893; c=relaxed/simple;
	bh=1y+xKeiK0pZE5/8fHmGlcYwQe5jhcCfD7Qr/u+pUi3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBMrZECuEsmG+8dMXgkecQx0AunFh1IFyoCWN2fnhh/ezO4eDXroz+9pQXZq0SjmsWdA0Os5OfM+bCEZSfKKDWwmuQ/NOi/NcTXNfEqRfEXAm8UtCdyLwhE+85ccyJfR1M0Cz0Um+z2RLFGQo4xMq7js7BpcCJXc2EyVokO8AU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NxIIm3EW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K7uVfacs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Jun 2024 18:01:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718380887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCI2Rec8a4NeZU2JAloIKjW3U2H+vlyxfiaoPaY9FEM=;
	b=NxIIm3EWNBawNUzOlqailT7XLeZew3cUuU8eHh8EpU3J6kgYnmEZjUxXpDd0hE3zCz46Q5
	nGHvQ3I0Zs+BmZfmrQ7ub8eLOLXvWodAUwAkvey2EW+s8KoAZXB58wvhCJE3VDvtYjNiWG
	3UVe98AszbaQO2QPWwm2LJ2qIvy953OKQil1FDgI3oPbr6RozNvFg1uU9uSQTjQMcrGECw
	RRANSGfm2uZNNjHtBt0B8ls1acCx0jqVrr1Lc+UfJefyhW+ZwRG8NceOAAli7JuG8wNh8n
	UiAkIECI+BjrRfD89NOR5kTcONJBJn6by+KNXjJnxmVNsB2+gehmFNc6SLufbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718380887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCI2Rec8a4NeZU2JAloIKjW3U2H+vlyxfiaoPaY9FEM=;
	b=K7uVfacsMz6l19NHQa5BP4mClp5DwQJ9nhcRcZGGoVKZGVLLi8khkRBAnSAdDDCkIcJ/5D
	+B5jgFE+Jde0XlDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6.5 08/15] net: softnet_data: Make xmit per task.
Message-ID: <20240614160125.pd9avKcr@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
 <20240612170303.3896084-9-bigeasy@linutronix.de>
 <20240612131829.2e33ca71@rorschach.local.home>
 <20240614082758.6pSMV3aq@linutronix.de>
 <CANn89i+YfdmKSMgHni4ogMDq0BpFQtjubA0RxXcfZ8fpgV5_fw@mail.gmail.com>
 <20240614094809.gvOugqZT@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614094809.gvOugqZT@linutronix.de>

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

On 2024-06-14 11:48:11 [+0200], To Eric Dumazet wrote:
> duh. Looking at the `more' member I realise that this needs to move to
> task_struct on RT, too. Therefore I would move the whole xmit struct.

Moving the whole struct because `more' also needs this. I haven't looked
at `skip_txqueue' but it is probably also affected.

 include/linux/netdevice.h | 40 +++++++++++++++++++++++++++++++++++----
 include/linux/sched.h     | 10 +++++++++-
 net/core/dev.c            | 14 ++++++++++++++
 net/core/dev.h            | 20 ++++++++++++++++++++
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f148a01dd1d17..eb1a3304a531c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3222,6 +3222,7 @@ struct softnet_data {
 	struct sk_buff_head	xfrm_backlog;
 #endif
 	/* written and read only by owning cpu: */
+#ifndef CONFIG_PREEMPT_RT
 	struct {
 		u16 recursion;
 		u8  more;
@@ -3229,6 +3230,7 @@ struct softnet_data {
 		u8  skip_txqueue;
 #endif
 	} xmit;
+#endif
 #ifdef CONFIG_RPS
 	/* input_queue_head should be written by cpu owning this struct,
 	 * and only read by other cpus. Worth using a cache line.
@@ -3256,10 +3258,19 @@ struct softnet_data {
 
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
 
+#ifdef CONFIG_PREEMPT_RT
+static inline int dev_recursion_level(void)
+{
+	return current->net_xmit.recursion;
+}
+
+#else
+
 static inline int dev_recursion_level(void)
 {
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
+#endif
 
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
@@ -4874,12 +4885,11 @@ static inline ktime_t netdev_get_tstamp(struct net_device *dev,
 	return hwtstamps->hwtstamp;
 }
 
-static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops *ops,
-					      struct sk_buff *skb, struct net_device *dev,
-					      bool more)
+#ifndef CONFIG_PREEMPT_RT
+
+static inline void netdev_xmit_set_more(bool more)
 {
 	__this_cpu_write(softnet_data.xmit.more, more);
-	return ops->ndo_start_xmit(skb, dev);
 }
 
 static inline bool netdev_xmit_more(void)
@@ -4887,6 +4897,28 @@ static inline bool netdev_xmit_more(void)
 	return __this_cpu_read(softnet_data.xmit.more);
 }
 
+#else
+
+static inline void netdev_xmit_set_more(bool more)
+{
+	current->net_xmit.more = more;
+}
+
+static inline bool netdev_xmit_more(void)
+{
+	return current->net_xmit.more;
+}
+
+#endif
+
+static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops *ops,
+					      struct sk_buff *skb, struct net_device *dev,
+					      bool more)
+{
+	netdev_xmit_set_more(more);
+	return ops->ndo_start_xmit(skb, dev);
+}
+
 static inline netdev_tx_t netdev_start_xmit(struct sk_buff *skb, struct net_device *dev,
 					    struct netdev_queue *txq, bool more)
 {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6d..c00f7ec288c8d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -975,7 +975,15 @@ struct task_struct {
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
 #endif
-
+#ifdef CONFIG_PREEMPT_RT
+	struct {
+		u16 recursion;
+		u8  more;
+#ifdef CONFIG_NET_EGRESS
+		u8  skip_txqueue;
+#endif
+	} net_xmit;
+#endif
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
 	struct restart_block		restart_block;
diff --git a/net/core/dev.c b/net/core/dev.c
index c361a7b69da86..c15b0215a66b7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3940,6 +3940,7 @@ netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
 	return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
 }
 
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
+	current->net_xmit.skip_txqueue = skip;
+}
+EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
+#endif
 #endif /* CONFIG_NET_EGRESS */
 
 #ifdef CONFIG_NET_XGRESS
diff --git a/net/core/dev.h b/net/core/dev.h
index b7b518bc2be55..463bbf5d5d6fe 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -150,6 +150,25 @@ struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
 #define XMIT_RECURSION_LIMIT	8
+
+#ifdef CONFIG_PREEMPT_RT
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
 
 #endif
-- 
2.45.1


