Return-Path: <netdev+bounces-254942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKJdKKDne2laJQIAu9opvQ
	(envelope-from <netdev+bounces-254942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:05:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C1B5946
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D0F73019503
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8FE36BCEF;
	Thu, 29 Jan 2026 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+gGrxJD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9959334405D
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769727901; cv=none; b=dQa7MA9p8I0I5n+re7kpsmFHYzGoVDvnWl4LRLM62mhfvMaT+f0Xv969mycN1ow+cryJkg1Z+rdSn/7H6TZTUt2bVJ/AocI5xpSUijkJA9LvXkkv1I5Nj7bRByEYjpPXD8HSsRMDhZcpGi3FfQ7o0TS0NIJ7vehA/jXW5ud1rso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769727901; c=relaxed/simple;
	bh=VOqIjKQ2L8g9CntX8TSWbyQG4JDIWD0ret4p40N2KgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOzxz//QGxBaDQx+1FFw8bzKeiBIXLygjOrn1VCiGmMnWMGE832hej3bVtR6LSw5BMVnC3aZXlwmyuOKUai7CmdjL+sOPG1ooEiP/PRoQYTwem6bC3Ks/Uy2nCtBeNA/WSS2UK/NFttS7aISKQdf6LF5z9IM0Gi8lpCecBsDB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+gGrxJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02A5C4CEF7;
	Thu, 29 Jan 2026 23:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769727901;
	bh=VOqIjKQ2L8g9CntX8TSWbyQG4JDIWD0ret4p40N2KgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C+gGrxJDUHg+7MpEbDFJfN8izdBLIF/w8NR1Rz8kxLdlBszuUvVdevnabs3hG4Fi9
	 cwW3c6kPkw3fRvofp5HOxaDZa0Ltgdt28vguFVOsdMWq4qAagr+x0ld6iVG+YZQc0H
	 it1sZZuqkEpEIeMg3dbO9V49Ry3IXpx2ZwVKMXt6ZtXcI7SV0ouVJJMBO1yd9Np4vp
	 +nno4Ax+tXZdbmPUtNVRivwqDa8nw2NxT/RSr2gCB5xeI5dufy+aTDFFr1DCYlJZGS
	 /lioxAqqPzGTBMzw2F5Vc2qNKCFEDbfpagdQNvGcPSGY2UspMexOP+tmR0ZXEF0PvC
	 uy1e+P66FMigg==
Date: Thu, 29 Jan 2026 15:04:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
Message-ID: <20260129150459.29419003@kernel.org>
In-Reply-To: <20260119090435.44b1da2d@kernel.org>
References: <20260117164255.785751-1-kuba@kernel.org>
	<CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
	<20260117150346.72265ac3@kernel.org>
	<CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
	<20260119090435.44b1da2d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/5+eEJTlv1jpRdS=zRovL3ll"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254942-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E49C1B5946
X-Rspamd-Action: no action

--MP_/5+eEJTlv1jpRdS=zRovL3ll
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 19 Jan 2026 09:04:35 -0800 Jakub Kicinski wrote:
> > > Not sure if there's much we can do about that.. Perhaps we should have
> > > a shrinker that flushes the defer queues? I chatted with Shakeel briefly
> > > and it sounded fairly straightforward.    
> > 
> > I was mostly concerned about latency spikes, I did some tests here and
> > this seems fine.  
> 
> Looks like selftests run into the zerocopy Tx latency issue.
> I'll drop this version from patchwork..

Delaying zero copy forever is a bit of an annoyance.
I believe the same thing can happen in net-next with UDP 
but I haven't tested to confirm.

I assume the attached patch is out of question since it came up before?

--MP_/5+eEJTlv1jpRdS=zRovL3ll
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-net-periodically-flush-the-defer-queues.patch

From ec1dcd1d542880fdaa126a5d4d57147ce69c80d3 Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 28 Jan 2026 15:01:27 -0800
Subject: [--tree name--] net: periodically flush the defer queues

Zero-copy skbs may sit in the defer skb queue forever.
AFAIU we don't see this for UDP in SW tests because over veth
we end up hitting skb_orphan_frags_rx(). But it should happen
when we zero-copy Tx on a real interface, which frees skbs
via napi_consume_skb(). Since commit 6471658dc66c ("udp: use
skb_attempt_defer_free()") we will queue the skb with a ubuf
to a remote core where it may never be freed.

If we make TCP defer freeing Tx skbs this will be even more
obvious and trigger over veth. In TCP the stack is traversed
by a skb clone, and freeing happens when the ACK comes in,
so no lucky skb_orphan_frags_rx().

This patch attempts a periodic scrub of the defer queues.
Hopefully perf overhead is negligible under normal load,
even on huge machines, as we'll just check that timer is
already pending vast majority of the time.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/admin-guide/sysctl/net.rst |  13 ++
 include/net/hotdata.h                    |   1 +
 net/core/dev.h                           |   4 +
 net/core/dev.c                           |   1 +
 net/core/skbuff.c                        | 152 +++++++++++++++++++++++
 net/core/sysctl_net_core.c               |   8 ++
 6 files changed, 179 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 19408da2390b..dbfae381818a 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -368,6 +368,19 @@ by the cpu which allocated them.
 
 Default: 128
 
+skb_defer_timeout_us
+--------------------
+
+Timeout in microseconds for the safety timer that flushes deferred skb
+queues. When skbs are deferred to a CPU that never runs network softirq
+(e.g., application threads that allocated TX skbs for zero-copy sends),
+they may remain queued indefinitely. This timer periodically triggers
+an IPI to the affected CPUs to drain their defer queues.
+
+Setting this to 0 disables the safety timer.
+
+Default: 20000 (20 milliseconds)
+
 optmem_max
 ----------
 
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 6632b1aa7584..fb738da24fe6 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -10,6 +10,7 @@
 struct skb_defer_node {
 	struct llist_head	defer_list;
 	atomic_long_t		defer_count;
+	u8			needs_flush;
 } ____cacheline_aligned_in_smp;
 
 /* Read mostly data used in network fast paths. */
diff --git a/net/core/dev.h b/net/core/dev.h
index 98793a738f43..e481b5e67363 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -366,6 +366,10 @@ static inline void napi_assert_will_not_race(const struct napi_struct *napi)
 
 void kick_defer_list_purge(unsigned int cpu);
 
+extern unsigned int sysctl_skb_defer_timeout_us;
+int sysctl_skb_defer_timeout(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos);
+
 #define XMIT_RECURSION_LIMIT	8
 
 #ifndef CONFIG_PREEMPT_RT
diff --git a/net/core/dev.c b/net/core/dev.c
index 43de5af0d6ec..e6e004f56c58 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6801,6 +6801,7 @@ static void skb_defer_free_flush(void)
 		if (llist_empty(&sdn->defer_list))
 			continue;
 		atomic_long_set(&sdn->defer_count, 0);
+		WRITE_ONCE(sdn->needs_flush, 0);
 		free_list = llist_del_all(&sdn->defer_list);
 
 		llist_for_each_entry_safe(skb, next, free_list, ll_node) {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 63c7c4519d63..4c234617d0ab 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -86,6 +86,7 @@
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
 #include <linux/highmem.h>
+#include <linux/hrtimer.h>
 #include <linux/capability.h>
 #include <linux/user_namespace.h>
 #include <linux/indirect_call_wrapper.h>
@@ -7219,6 +7220,152 @@ static void kfree_skb_napi_cache(struct sk_buff *skb)
 	local_bh_enable();
 }
 
+/*
+ * Deferred skb flush timer.
+ *
+ * SKBs may get stuck in the defer queue if the originating CPU never runs
+ * network softirq (e.g., application threads that allocated TX skbs).
+ * This timer periodically flushes aged skbs from all defer queues.
+ *
+ * State machine:
+ *   DISABLED -> IDLE: sysctl changed from 0 to non-zero
+ *   IDLE     -> ACTIVE: first defer schedules the timer
+ *   IDLE     -> DISABLED: sysctl set to 0 while timer idle
+ *   ACTIVE   -> RECHECK: timer fires, reschedules to check for races
+ *   ACTIVE   -> DISABLED: timer fires, sees timeout=0
+ *   RECHECK  -> ACTIVE: new defer arrives, timer will continue
+ *   RECHECK  -> IDLE: timer fires again with no new work
+ *   RECHECK  -> DISABLED: timer fires, sees timeout=0
+ *
+ * IDLE is 0 so kick_defer_safety_timer() fast path is a single comparison.
+ * DISABLED is -1, outside the IDLE/ACTIVE/RECHECK cycle.
+ */
+enum {
+	SKB_DEFER_TIMER_DISABLED = -1,
+	SKB_DEFER_TIMER_IDLE = 0,
+	SKB_DEFER_TIMER_ACTIVE = 1,
+	SKB_DEFER_TIMER_RECHECK = 2,
+	__SKB_DEFER_TIMER_STATE_CNT
+};
+
+static atomic_t skb_defer_timer_state = ATOMIC_INIT(SKB_DEFER_TIMER_DISABLED);
+static struct hrtimer skb_defer_flush_timer;
+unsigned int sysctl_skb_defer_timeout_us __read_mostly = 20000;
+
+static void skb_defer_flush_aged(void)
+{
+	struct skb_defer_node *sdn;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		bool kick = false;
+		int node;
+
+		for_each_node(node) {
+			sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + node;
+
+			if (!atomic_long_read(&sdn->defer_count)) {
+				WRITE_ONCE(sdn->needs_flush, 0);
+				continue;
+			}
+
+			kick |= READ_ONCE(sdn->needs_flush);
+			WRITE_ONCE(sdn->needs_flush, 1);
+		}
+		if (kick)
+			kick_defer_list_purge(cpu);
+	}
+}
+
+static enum hrtimer_restart skb_defer_flush_timer_fn(struct hrtimer *timer)
+{
+	enum hrtimer_restart ret;
+	unsigned int timeout;
+	int new_state, state;
+	ktime_t delay;
+
+	state = atomic_read(&skb_defer_timer_state);
+	timeout = READ_ONCE(sysctl_skb_defer_timeout_us);
+	if (!timeout) {
+		atomic_set(&skb_defer_timer_state, SKB_DEFER_TIMER_DISABLED);
+		return HRTIMER_NORESTART;
+	}
+
+	WARN_ON_ONCE(state == SKB_DEFER_TIMER_IDLE);
+	WARN_ON_ONCE(state == SKB_DEFER_TIMER_DISABLED);
+
+	/* State machine: ACTIVE (1) -> RECHECK (2) -> IDLE (0) */
+	new_state = (state + 1) % __SKB_DEFER_TIMER_STATE_CNT;
+	new_state = atomic_cmpxchg(&skb_defer_timer_state, state, new_state);
+
+	if (new_state == SKB_DEFER_TIMER_IDLE) {
+		ret = HRTIMER_NORESTART;
+	} else {
+		delay = ns_to_ktime((u64)timeout * (NSEC_PER_USEC / 2));
+		hrtimer_forward_now(timer, delay);
+		ret = HRTIMER_RESTART;
+	}
+
+	skb_defer_flush_aged();
+
+	return ret;
+}
+
+static DEFINE_SPINLOCK(skb_defer_sysctl_lock);
+
+int sysctl_skb_defer_timeout(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	unsigned int old_timeout;
+	int ret;
+
+	if (!write)
+		return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	spin_lock(&skb_defer_sysctl_lock);
+
+	old_timeout = sysctl_skb_defer_timeout_us;
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret)
+		goto unlock;
+
+	if (!old_timeout && sysctl_skb_defer_timeout_us)
+		atomic_cmpxchg(&skb_defer_timer_state,
+			       SKB_DEFER_TIMER_DISABLED,
+			       SKB_DEFER_TIMER_IDLE);
+	if (old_timeout && !sysctl_skb_defer_timeout_us)
+		atomic_cmpxchg(&skb_defer_timer_state,
+			       SKB_DEFER_TIMER_IDLE,
+			       SKB_DEFER_TIMER_DISABLED);
+unlock:
+	spin_unlock(&skb_defer_sysctl_lock);
+	return ret;
+}
+
+static void kick_defer_safety_timer(void)
+{
+	unsigned int timeout;
+	ktime_t delay;
+	int state;
+
+	state = atomic_read(&skb_defer_timer_state);
+	if (likely(state))
+		return; /* already running (or disabled) */
+
+	timeout = READ_ONCE(sysctl_skb_defer_timeout_us);
+	if (!timeout)
+		return;
+
+	state = atomic_cmpxchg(&skb_defer_timer_state, SKB_DEFER_TIMER_IDLE,
+			       SKB_DEFER_TIMER_ACTIVE);
+	if (state != SKB_DEFER_TIMER_IDLE)
+		return;
+
+	/* Half the sysctl period, once cycle marks and second will flush */
+	delay = ns_to_ktime((u64)timeout * (NSEC_PER_USEC / 2));
+	hrtimer_start(&skb_defer_flush_timer, delay, HRTIMER_MODE_REL);
+}
+
 /**
  * skb_attempt_defer_free - queue skb for remote freeing
  * @skb: buffer
@@ -7264,6 +7411,8 @@ nodefer:	kfree_skb_napi_cache(skb);
 	 */
 	if (unlikely(kick))
 		kick_defer_list_purge(cpu);
+	else
+		kick_defer_safety_timer();
 }
 
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
@@ -7439,4 +7588,7 @@ void __init skb_init(void)
 						SKB_SMALL_HEAD_HEADROOM,
 						NULL);
 	skb_extensions_init();
+
+	hrtimer_setup(&skb_defer_flush_timer, skb_defer_flush_timer_fn,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 }
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 03aea10073f0..af8528a2337c 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -645,6 +645,14 @@ static struct ctl_table net_core_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "skb_defer_timeout_us",
+		.data		= &sysctl_skb_defer_timeout_us,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_skb_defer_timeout,
+		.extra1		= SYSCTL_ZERO,
+	},
 };
 
 static struct ctl_table netns_core_table[] = {
-- 
2.52.0


--MP_/5+eEJTlv1jpRdS=zRovL3ll--

