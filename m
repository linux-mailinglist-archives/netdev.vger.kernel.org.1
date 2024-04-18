Return-Path: <netdev+bounces-89229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15B88A9BA0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A880A2816E6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2106982889;
	Thu, 18 Apr 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0bthSUN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60445EAD2
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448235; cv=none; b=kB7HrN3mRDph1iTBUehI2/6dQBznwUEYZDApUvCYtIiujfScAK4LPJ0MDm7QEX+/BZb0l6pK2ZMewDH1vIuhOMPi9eciKCTHbS5jFY2jSMewLDYz8cxA6F6ugrIA+V9OwlYMsDwWiyyLPlAg5OTZvSDedwXGuNLnzfXVgoAj/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448235; c=relaxed/simple;
	bh=B+4p1ag6NIMNulSFYsY1N84u/KMvVtCvBo+OuAmUXy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNnb9ajyA7By616HrWcmznRDLn6IkCAK5P2ZH7XgxhrHDcyB5B3uCdk4KGaaZKV6O7IA/XaXI9MLs/HivseOtxdBy9VIPYNNQeHcL43oxU+aHMCTCuYQngodXZuN1hQ96BGuT9zuLxcEjfTPvgMmpdWEQ7D77poOFGHOQdQ8dDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0bthSUN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713448232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cJIktUU/P6Fto6HocisdAyKaVqJxP2VEEZLFfKubyvU=;
	b=Y0bthSUN868GIU8O4X5pdvrjvDLRx7v04UpQFz/tA6DZ5f7yUe8BslxIFOJcLd5yAiyMso
	NRxodpVr9q4vb47ZDhl/i8AOemZIGsK+oAB+3yzTcP4iC0NT630jONwMEelYRaT2W0hkQZ
	/lSPSHktast/5F6Vp9Gm5267DK6D2EM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-1s7qMdWzOaCRiDlQpKc2XQ-1; Thu, 18 Apr 2024 09:50:30 -0400
X-MC-Unique: 1s7qMdWzOaCRiDlQpKc2XQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B1FF104B500;
	Thu, 18 Apr 2024 13:50:30 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC1062166B32;
	Thu, 18 Apr 2024 13:50:27 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Eric Dumazet <edumazet@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>,
	Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org,
	renmingshuai@huawei.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	xmu@redhat.com,
	Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH net-next v2] net/sched: fix false lockdep warning on qdisc root lock
Date: Thu, 18 Apr 2024 15:50:11 +0200
Message-ID: <7dc06d6158f72053cf877a82e2a7a5bd23692faa.1713448007.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Xiumei and Christoph reported the following lockdep splat, complaining of
the qdisc root lock being taken twice:

 ============================================
 WARNING: possible recursive locking detected
 6.7.0-rc3+ #598 Not tainted
 --------------------------------------------
 swapper/2/0 is trying to acquire lock:
 ffff888177190110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0x1560/0x2e70

 but task is already holding lock:
 ffff88811995a110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0x1560/0x2e70

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&sch->q.lock);
   lock(&sch->q.lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 5 locks held by swapper/2/0:
  #0: ffff888135a09d98 ((&in_dev->mr_ifc_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11a/0x510
  #1: ffffffffaaee5260 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x2c0/0x1ed0
  #2: ffffffffaaee5200 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x209/0x2e70
  #3: ffff88811995a110 (&sch->q.lock){+.-.}-{2:2}, at: __dev_queue_xmit+0x1560/0x2e70
  #4: ffffffffaaee5200 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x209/0x2e70

 stack backtrace:
 CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.7.0-rc3+ #598
 Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7353+9de0a3cc 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x4a/0x80
  __lock_acquire+0xfdd/0x3150
  lock_acquire+0x1ca/0x540
  _raw_spin_lock+0x34/0x80
  __dev_queue_xmit+0x1560/0x2e70
  tcf_mirred_act+0x82e/0x1260 [act_mirred]
  tcf_action_exec+0x161/0x480
  tcf_classify+0x689/0x1170
  prio_enqueue+0x316/0x660 [sch_prio]
  dev_qdisc_enqueue+0x46/0x220
  __dev_queue_xmit+0x1615/0x2e70
  ip_finish_output2+0x1218/0x1ed0
  __ip_finish_output+0x8b3/0x1350
  ip_output+0x163/0x4e0
  igmp_ifc_timer_expire+0x44b/0x930
  call_timer_fn+0x1a2/0x510
  run_timer_softirq+0x54d/0x11a0
  __do_softirq+0x1b3/0x88f
  irq_exit_rcu+0x18f/0x1e0
  sysvec_apic_timer_interrupt+0x6f/0x90
  </IRQ>

This happens when TC does a mirred egress redirect from the root qdisc of
device A to the root qdisc of device B. As long as these two locks aren't
protecting the same qdisc, they can be acquired in chain: add a per-qdisc
lockdep key to silence false warnings.
This dynamic key should safely replace the static key we have in sch_htb:
it was added to allow enqueueing to the device "direct qdisc" while still
holding the qdisc root lock.

v2: don't use static keys anymore in HTB direct qdiscs (thanks Eric Dumazet)

CC: Maxim Mikityanskiy <maxim@isovalent.com>
CC: Xiumei Mu <xmu@redhat.com>
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/451
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/net/sch_generic.h |  1 +
 net/sched/sch_generic.c   |  3 +++
 net/sched/sch_htb.c       | 22 +++-------------------
 3 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 76db6be16083..47ccaa0bff29 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -127,6 +127,7 @@ struct Qdisc {
 
 	struct rcu_head		rcu;
 	netdevice_tracker	dev_tracker;
+	struct lock_class_key	root_lock_key;
 	/* private data */
 	long privdata[] ____cacheline_aligned;
 };
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ff5336493777..7dca99a4e5d1 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -945,7 +945,9 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	__skb_queue_head_init(&sch->gso_skb);
 	__skb_queue_head_init(&sch->skb_bad_txq);
 	gnet_stats_basic_sync_init(&sch->bstats);
+	lockdep_register_key(&sch->root_lock_key);
 	spin_lock_init(&sch->q.lock);
+	lockdep_set_class(&sch->q.lock, &sch->root_lock_key);
 
 	if (ops->static_flags & TCQ_F_CPUSTATS) {
 		sch->cpu_bstats =
@@ -1067,6 +1069,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 	if (ops->destroy)
 		ops->destroy(qdisc);
 
+	lockdep_unregister_key(&qdisc->root_lock_key);
 	module_put(ops->owner);
 	netdev_put(dev, &qdisc->dev_tracker);
 
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 93e6fb56f3b5..ff3de37874e4 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1039,13 +1039,6 @@ static void htb_work_func(struct work_struct *work)
 	rcu_read_unlock();
 }
 
-static void htb_set_lockdep_class_child(struct Qdisc *q)
-{
-	static struct lock_class_key child_key;
-
-	lockdep_set_class(qdisc_lock(q), &child_key);
-}
-
 static int htb_offload(struct net_device *dev, struct tc_htb_qopt_offload *opt)
 {
 	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_HTB, opt);
@@ -1132,7 +1125,6 @@ static int htb_init(struct Qdisc *sch, struct nlattr *opt,
 			return -ENOMEM;
 		}
 
-		htb_set_lockdep_class_child(qdisc);
 		q->direct_qdiscs[ntx] = qdisc;
 		qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
 	}
@@ -1468,7 +1460,6 @@ static int htb_graft(struct Qdisc *sch, unsigned long arg, struct Qdisc *new,
 	}
 
 	if (q->offload) {
-		htb_set_lockdep_class_child(new);
 		/* One ref for cl->leaf.q, the other for dev_queue->qdisc. */
 		qdisc_refcount_inc(new);
 		old_q = htb_graft_helper(dev_queue, new);
@@ -1733,11 +1724,8 @@ static int htb_delete(struct Qdisc *sch, unsigned long arg,
 		new_q = qdisc_create_dflt(dev_queue, &pfifo_qdisc_ops,
 					  cl->parent->common.classid,
 					  NULL);
-		if (q->offload) {
-			if (new_q)
-				htb_set_lockdep_class_child(new_q);
+		if (q->offload)
 			htb_parent_to_leaf_offload(sch, dev_queue, new_q);
-		}
 	}
 
 	sch_tree_lock(sch);
@@ -1947,13 +1935,9 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 		new_q = qdisc_create_dflt(dev_queue, &pfifo_qdisc_ops,
 					  classid, NULL);
 		if (q->offload) {
-			if (new_q) {
-				htb_set_lockdep_class_child(new_q);
-				/* One ref for cl->leaf.q, the other for
-				 * dev_queue->qdisc.
-				 */
+			/* One ref for cl->leaf.q, the other for dev_queue->qdisc. */
+			if (new_q)
 				qdisc_refcount_inc(new_q);
-			}
 			old_q = htb_graft_helper(dev_queue, new_q);
 			/* No qdisc_put needed. */
 			WARN_ON(!(old_q->flags & TCQ_F_BUILTIN));
-- 
2.44.0


