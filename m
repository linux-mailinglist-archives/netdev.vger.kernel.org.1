Return-Path: <netdev+bounces-195846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2097CAD2806
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11F416506A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE8821B191;
	Mon,  9 Jun 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvJ80d6K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685010E3;
	Mon,  9 Jun 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502047; cv=none; b=PRpkUUzBrerVRDj6jOFCVNAe/f7MBcaXdZOSUwS8YZUuIEl/nSopJ3EFjPsZ7oYIL3d88PnuZG+d8Y4ecgwRQD5JmTCIrcg6TSs2gDfveuB6tdo2j1rsv8QaUCIkCA/ajswmyKW9fdQKWWID9eRV6Pj1YHVGN2pWCsCH3A99h4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502047; c=relaxed/simple;
	bh=efwRt9AsjY6DCceMMyJwt6Pe2f2DQsUY58BN5JsAsLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sLxr7+Ygl8cs0T2hqDfVGTjtusztJ8Hr4/VBC/Q9vfCXrbUsYIG+7/Lqbe+kWHxRfio9sd3WEzGhOvnfpk1ExM4PXeK0/+AtKeMjkPGSSzgCaoyjiwLpM1DH9ZQdP7OIB7xHeZOMY98KvEdyjiDrYlLTp+ruQIn96Bbl5rQ+npk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvJ80d6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959B3C4CEEF;
	Mon,  9 Jun 2025 20:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749502046;
	bh=efwRt9AsjY6DCceMMyJwt6Pe2f2DQsUY58BN5JsAsLI=;
	h=Date:From:To:Cc:Subject:From;
	b=dvJ80d6KkiJd9yaU/MEiSsorsnNPpEQGf4a/vsu0IvoRS1MUuU3I+9BVHNsNABTP8
	 ctw1pPA1y4J2NAB3HJFohUI2L2gfwbvuIc+JadAOzGEjErTdE2K6Rgj5Z1eRcVPKw0
	 HZGzi8NqNM4wJHDcLz+NVyIuBLqW2SAnCk+CHILFesW7YvCbOAl0HS2pKqLIe25XXb
	 wIfSpDFnitCb0L1/DP+L5k1QumDzNibCqPdU8HiWt53elfrOOnuGnflP8Cx6bnpRRN
	 ThZzNKphtrdsPnn3mrtsnQFm2UOauOGgqas4KMG9CpC9m5s8c6+dh1NT7/54AxehPB
	 D+1Vs4+OyDi7g==
Date: Mon, 9 Jun 2025 10:47:25 -1000
From: Tejun Heo <tj@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RESEND net-next] net: tcp: tsq: Convert from tasklet to BH
 workqueue
Message-ID: <aEdIXQkxiORwc5v4@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws. To
replace tasklets, BH workqueue support was recently added. A BH workqueue
behaves similarly to regular workqueues except that the queued work items
are executed in the BH context.

This patch converts TCP Small Queues implementation from tasklet to BH
workqueue.

Semantically, this is an equivalent conversion and there shouldn't be any
user-visible behavior changes. While workqueue's queueing and execution
paths are a bit heavier than tasklet's, unless the work item is being queued
every packet, the difference hopefully shouldn't matter.

My experience with the networking stack is very limited and this patch
definitely needs attention from someone who actually understands networking.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [IPv4/IPv6])
Cc: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org (open list:NETWORKING [TCP])
---
 include/net/tcp.h     |  2 +-
 net/ipv4/tcp.c        |  2 +-
 net/ipv4/tcp_output.c | 36 ++++++++++++++++++------------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index dd78a1181031..89f3702be47a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -324,7 +324,7 @@ extern struct proto tcp_prot;
 #define TCP_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.tcp_statistics, field)
 #define TCP_ADD_STATS(net, field, val)	SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
 
-void tcp_tasklet_init(void);
+void tcp_tsq_work_init(void);
 
 int tcp_v4_err(struct sk_buff *skb, u32);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1baa484d2190..d085ee5642fe 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4772,6 +4772,6 @@ void __init tcp_init(void)
 	tcp_v4_init();
 	tcp_metrics_init();
 	BUG_ON(tcp_register_congestion_control(&tcp_reno) != 0);
-	tcp_tasklet_init();
+	tcp_tsq_work_init();
 	mptcp_init();
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..d11be6eebb6e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1049,15 +1049,15 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
  * needs to be reallocated in a driver.
  * The invariant being skb->truesize subtracted from sk->sk_wmem_alloc
  *
- * Since transmit from skb destructor is forbidden, we use a tasklet
+ * Since transmit from skb destructor is forbidden, we use a BH work item
  * to process all sockets that eventually need to send more skbs.
- * We use one tasklet per cpu, with its own queue of sockets.
+ * We use one work item per cpu, with its own queue of sockets.
  */
-struct tsq_tasklet {
-	struct tasklet_struct	tasklet;
+struct tsq_work {
+	struct work_struct	work;
 	struct list_head	head; /* queue of tcp sockets */
 };
-static DEFINE_PER_CPU(struct tsq_tasklet, tsq_tasklet);
+static DEFINE_PER_CPU(struct tsq_work, tsq_work);
 
 static void tcp_tsq_write(struct sock *sk)
 {
@@ -1087,14 +1087,14 @@ static void tcp_tsq_handler(struct sock *sk)
 	bh_unlock_sock(sk);
 }
 /*
- * One tasklet per cpu tries to send more skbs.
- * We run in tasklet context but need to disable irqs when
+ * One work item per cpu tries to send more skbs.
+ * We run in BH context but need to disable irqs when
  * transferring tsq->head because tcp_wfree() might
  * interrupt us (non NAPI drivers)
  */
-static void tcp_tasklet_func(struct tasklet_struct *t)
+static void tcp_tsq_workfn(struct work_struct *work)
 {
-	struct tsq_tasklet *tsq = from_tasklet(tsq,  t, tasklet);
+	struct tsq_work *tsq = container_of(work, struct tsq_work, work);
 	LIST_HEAD(list);
 	unsigned long flags;
 	struct list_head *q, *n;
@@ -1164,15 +1164,15 @@ void tcp_release_cb(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_release_cb);
 
-void __init tcp_tasklet_init(void)
+void __init tcp_tsq_work_init(void)
 {
 	int i;
 
 	for_each_possible_cpu(i) {
-		struct tsq_tasklet *tsq = &per_cpu(tsq_tasklet, i);
+		struct tsq_work *tsq = &per_cpu(tsq_work, i);
 
 		INIT_LIST_HEAD(&tsq->head);
-		tasklet_setup(&tsq->tasklet, tcp_tasklet_func);
+		INIT_WORK(&tsq->work, tcp_tsq_workfn);
 	}
 }
 
@@ -1186,11 +1186,11 @@ void tcp_wfree(struct sk_buff *skb)
 	struct sock *sk = skb->sk;
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned long flags, nval, oval;
-	struct tsq_tasklet *tsq;
+	struct tsq_work *tsq;
 	bool empty;
 
 	/* Keep one reference on sk_wmem_alloc.
-	 * Will be released by sk_free() from here or tcp_tasklet_func()
+	 * Will be released by sk_free() from here or tcp_tsq_workfn()
 	 */
 	WARN_ON(refcount_sub_and_test(skb->truesize - 1, &sk->sk_wmem_alloc));
 
@@ -1212,13 +1212,13 @@ void tcp_wfree(struct sk_buff *skb)
 		nval = (oval & ~TSQF_THROTTLED) | TSQF_QUEUED;
 	} while (!try_cmpxchg(&sk->sk_tsq_flags, &oval, nval));
 
-	/* queue this socket to tasklet queue */
+	/* queue this socket to BH workqueue */
 	local_irq_save(flags);
-	tsq = this_cpu_ptr(&tsq_tasklet);
+	tsq = this_cpu_ptr(&tsq_work);
 	empty = list_empty(&tsq->head);
 	list_add(&tp->tsq_node, &tsq->head);
 	if (empty)
-		tasklet_schedule(&tsq->tasklet);
+		queue_work(system_bh_wq, &tsq->work);
 	local_irq_restore(flags);
 	return;
 out:
@@ -2623,7 +2623,7 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 	if (refcount_read(&sk->sk_wmem_alloc) > limit) {
 		/* Always send skb if rtx queue is empty or has one skb.
 		 * No need to wait for TX completion to call us back,
-		 * after softirq/tasklet schedule.
+		 * after softirq schedule.
 		 * This helps when TX completions are delayed too much.
 		 */
 		if (tcp_rtx_queue_empty_or_single_skb(sk))
-- 
2.43.0


