Return-Path: <netdev+bounces-198185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE3ADB88E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EB93A4B18
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD57D288C16;
	Mon, 16 Jun 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6brB4q8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273A2BF016;
	Mon, 16 Jun 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097448; cv=none; b=MDxoc9+DKzKTZhxis/k6rKpfyyX2tAerkd/lunsOfHAAjnauOenPZuZBMgvs6XN7Ewk+QVgPbLxGWEPWqngWenGLux01rrL3Iej8fp6AyQi8ESZuXa6L9lNO3wfPqYlEwdVA+42ythJdgnyNXwSeEHyxM0gu0cnGEfVSFFQBUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097448; c=relaxed/simple;
	bh=zcp3hWxFI7bS6tJM2iENzfDvEXGjKBN6nai3nvOKFZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SgLS1yCmgVDzqNj5sYJRWPTIsw45yVUTUqVKZ3jOEKd/qHS1IuJQfPDJAPeqkXPVQiOgJsZXEZCOkpTMmmdxSEoZ/yjhhGjVC3azhjBtpl1gstUvokL7vAseIMtmGZhB2wqL1Efq6r8AmUoziHnIZemgOkBSszc+KJLYaedYTdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6brB4q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF9CC4CEEA;
	Mon, 16 Jun 2025 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750097448;
	bh=zcp3hWxFI7bS6tJM2iENzfDvEXGjKBN6nai3nvOKFZ4=;
	h=Date:From:To:Cc:Subject:From;
	b=O6brB4q8wPVw8z58AEOHqUKdrCd1b3HuM7igj6aJqfRhklOIN64o+cGfnyiPppmcs
	 i+TLKqEn1nS0Fgw9mXY0UItkNj0wQ2dB6vmZ2FQkjeTl856L67k15NsdOyWiP50bS8
	 Zzl3MyjclOJVTx5dtHrJBvODChOKgk+c5wVy1ethxL3+rCDr/qDklQitV2KUfuulLg
	 zHBRcDVbmiQDaqYnRjWtWsBR3aEOmu/u7ZOONg7lVWwZekNS4wWGptIO4heYPajVAV
	 ANMvzKsFTyeX2gbCcDpFCbmIxIl6XSpfwzDseIBeSTGcV601JcbGdoUwji8QUeO67x
	 k7Ep8UVakl+bw==
Date: Mon, 16 Jun 2025 08:10:47 -1000
From: Tejun Heo <tj@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH v3 net-next] net: tcp: tsq: Convert from tasklet to BH
 workqueue
Message-ID: <aFBeJ38AS1ZF3Dq5@slm.duckdns.org>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [IPv4/IPv6])
Cc: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org (open list:NETWORKING [TCP])
---
v3: Refreshed on top of net-next/main (8909f5f4ecd5 ("net: stmmac:
qcom-ethqos: add ethqos_pcs_set_inband()")).

 include/net/tcp.h     |    2 +-
 net/ipv4/tcp.c        |    2 +-
 net/ipv4/tcp_output.c |   36 ++++++++++++++++++------------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5078ad868fee..feb7ac89a67c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -321,7 +321,7 @@ extern struct proto tcp_prot;
 #define TCP_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.tcp_statistics, field)
 #define TCP_ADD_STATS(net, field, val)	SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
 
-void tcp_tasklet_init(void);
+void tcp_tsq_work_init(void);
 
 int tcp_v4_err(struct sk_buff *skb, u32);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f64f8276a73c..d84e8d5ff5e4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5243,6 +5243,6 @@ void __init tcp_init(void)
 	tcp_v4_init();
 	tcp_metrics_init();
 	BUG_ON(tcp_register_congestion_control(&tcp_reno) != 0);
-	tcp_tasklet_init();
+	tcp_tsq_work_init();
 	mptcp_init();
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3ac8d2d17e1f..a39275dad489 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1066,15 +1066,15 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
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
@@ -1104,14 +1104,14 @@ static void tcp_tsq_handler(struct sock *sk)
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
@@ -1181,15 +1181,15 @@ void tcp_release_cb(struct sock *sk)
 }
 EXPORT_IPV6_MOD(tcp_release_cb);
 
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
 
@@ -1203,11 +1203,11 @@ void tcp_wfree(struct sk_buff *skb)
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
 
@@ -1229,13 +1229,13 @@ void tcp_wfree(struct sk_buff *skb)
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
@@ -2639,7 +2639,7 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 	if (refcount_read(&sk->sk_wmem_alloc) > limit) {
 		/* Always send skb if rtx queue is empty or has one skb.
 		 * No need to wait for TX completion to call us back,
-		 * after softirq/tasklet schedule.
+		 * after softirq schedule.
 		 * This helps when TX completions are delayed too much.
 		 */
 		if (tcp_rtx_queue_empty_or_single_skb(sk))

