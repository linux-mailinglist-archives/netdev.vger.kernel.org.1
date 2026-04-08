Return-Path: <netdev+bounces-276530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGaHAptS1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:05:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF563BC8D4
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD11300A613
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADD33C6619;
	Wed,  8 Apr 2026 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wll/AwlU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53753C9423
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653004; cv=none; b=MLlISJvyGZG8kpqOWHn642DNTLw3Vf2N7x/k1ClGjGV3/YQBVIG4/hvlqvNu79EnAyAra7q/a6oRVR4DEI46RM3Kn/NwB2LOaD/tVEXlNUdfh4ifzxnciRGCRdSixEJljCLKqlMKiPZRaKTcgBZvCmnzvSBy4VvjBNgDr9c3nkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653004; c=relaxed/simple;
	bh=6hRsfXlN89RRJiUiE9nMviLIk2NOhjItbK2aCgHe08c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BYIhwC+IUz9mUavmKaGsw7lQU8L95DSOKFyAlEDADg2kiCai4YYNjdmEQ3ySZ0g/BXb4akGqLmVoqa0+xKgwp3VNC0DKNQ3rwFjCS+9HL26gw6UIM1kcaV0ODc/5GbdA4U7vqGo57gos1BbCDFvXfIrnFxd4symzZctIp4tCXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wll/AwlU; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cfbfac0e05so70550885a.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775653002; x=1776257802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZuGz0g/mPyGEy2y+edr0SWMm9AOn+0wjeVaZhi2hNk=;
        b=Wll/AwlUDW/pl1EKvcUo0sLwEiCk1nztTOBb9+6JUW2GvrZfk+ubZRFCamYvDraeBq
         8nuhmvQbq7HbrRSZ25jZm6SKVwsqNuB2hvLR5vH1KXwg+UGuSqtW4RAHLdo8iUruXT58
         Kkyj4uXRwVz9O4oKwOA7ywvIV/Z1oxBkQ9XWlbywXNkvExt+TqfVpXHmQRv/N7TFCXBZ
         GWs+z3QGqhW68SGUeSNzK3M4qj8/RVtuBQcmqwHZdZmQEuTh5puPfkl1s7AjYDsLnRkX
         PFWju7Yo1re0ABHuaSNeKbZx6RxYTk8/+GnaWpOhjIgNdKELFlidfd0VAz1g7nQNz5VP
         3Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775653002; x=1776257802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZuGz0g/mPyGEy2y+edr0SWMm9AOn+0wjeVaZhi2hNk=;
        b=pyjgXqk/AG+3lusSDhNVaoGSeef07xar30NEQGRYCja62NmtHBmZmQLl/tyFnYZ+Sx
         /kNc/ZlKEsB41qhpGESwCHLmZ3+QT+wpBy3V27tG6i4csUCK/fwWxgMc9BXSpNKN5LmE
         GY9+a3NDyqSlYfmOfz7cMFOI69tHRcIWZmuNgTdYlQ7HgmzQMIjZbcDp0JQ3qKTb2XVp
         azseyZDsbeYmSQqrlaoLv0xlVsFGKPB+lSgppnqt9Jz8gG9BHZt7jI5tYAUycebbBK/M
         sCY+xc8qGPaF9D3l9xXRsJMNQjb/iuB06B4J3j9+a0/J0G6SQC9RYnqfW8qLUQR3ih2T
         1P0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgzHR0jGAa2OGGON+Bhqoc+Xc1swY1JRYUWkhFM1xBpCySg6apVVQVZSnDKv5OJXU7wXjPnhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJImSX3N4/fO5BsEx7M5+o73pXiYKYdapoc8BAR9dCSgq9kSjg
	2Sg7fo5I2Tu+fu0VLUn0/qfqvL4yLiqxJMn5OBCa9aVPcTKnCMNQOFeTgLfmmOOm2fQxuPfqmm8
	XRVDuuANLejtV9w==
X-Received: from qkntp21.prod.google.com ([2002:a05:620a:3c95:b0:8cd:8dfa:a7e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:199d:b0:8cd:b024:114d with SMTP id af79cd13be357-8d3042cd918mr2715901085a.40.1775653001490;
 Wed, 08 Apr 2026 05:56:41 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:56:11 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-16-edumazet@google.com>
Subject: [PATCH net-next 15/15] net/sched: convert tc_dump_qdisc() to RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276530-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: 5DF563BC8D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

No longer acquire RTNL in qdisc dumps (tc -s -d qdisc show ...)

Notes:

- Add sch_tree_lock_rcu()/sch_tree_unlock_rcu() for dump methods
  which need to acquire qdisc spinlock (fq, fq_codel, fq_pie and gred).

- Removed netdev_lock_ops()/netdev_unlock_ops() because dumps are read-only.
  They were are added in commit a0527ee2df3f ("net: hold netdev instance
  lock during qdisc ndo_setup_tc").

- for_each_netdev_rcu() can be changed later with
  more scalable for_each_netdev_dump().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/sch_generic.h | 14 ++++++++++++++
 net/sched/sch_api.c       | 21 +++++++++------------
 net/sched/sch_fq.c        |  4 ++--
 net/sched/sch_fq_codel.c  |  4 ++--
 net/sched/sch_fq_pie.c    |  4 ++--
 net/sched/sch_gred.c      |  4 ++--
 net/sched/sch_mq.c        |  2 +-
 net/sched/sch_mqprio.c    |  2 +-
 net/sched/sch_taprio.c    | 16 +++++-----------
 9 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f85aca5c1a445debd52a4e7b359141cf90cb7b55..82cb1e639dcc404bffe4b2669bb5aacef605cf6d 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -628,6 +628,20 @@ static inline void sch_tree_unlock(struct Qdisc *q)
 		spin_unlock_bh(qdisc_root_sleeping_lock(q));
 }
 
+static inline void sch_tree_lock_rcu(struct Qdisc *q)
+{
+	if (!(q->flags & TCQ_F_MQROOT))
+		q = qdisc_root_sleeping(q);
+	spin_lock_bh(qdisc_lock(q));
+}
+
+static inline void sch_tree_unlock_rcu(struct Qdisc *q)
+{
+	if (!(q->flags & TCQ_F_MQROOT))
+		q = qdisc_root_sleeping(q);
+	spin_unlock_bh(qdisc_lock(q));
+}
+
 extern struct Qdisc noop_qdisc;
 extern struct Qdisc_ops noop_qdisc_ops;
 extern struct Qdisc_ops pfifo_fast_ops;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 292bc8bb7a79922a83865ed54083c04ff72742ff..adc2d499a03d9fb4667dc87ba06aa3abfce30214 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -909,7 +909,6 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 	u32 block_index;
 	__u32 qlen;
 
-	cond_resched();
 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*tcm), flags);
 	if (!nlh)
 		goto out_nlmsg_trim;
@@ -941,7 +940,7 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 		goto nla_put_failure;
 	qlen = qdisc_qlen_sum(q);
 
-	stab = rtnl_dereference(q->stab);
+	stab = rcu_dereference(q->stab);
 	if (stab && qdisc_dump_stab(skb, stab) < 0)
 		goto nla_put_failure;
 
@@ -1888,14 +1887,14 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 	s_q_idx = q_idx = cb->args[1];
 
 	idx = 0;
-	ASSERT_RTNL();
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(struct tcmsg), tca, TCA_MAX,
 				     rtm_tca_policy, cb->extack);
 	if (err < 0)
 		return err;
 
-	for_each_netdev(net, dev) {
+	rcu_read_lock();
+	for_each_netdev_rcu(net, dev) {
 		struct netdev_queue *dev_queue;
 
 		if (idx < s_idx)
@@ -1904,29 +1903,26 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 			s_q_idx = 0;
 		q_idx = 0;
 
-		netdev_lock_ops(dev);
-		if (tc_dump_qdisc_root(rtnl_dereference(dev->qdisc),
+		if (tc_dump_qdisc_root(rcu_dereference(dev->qdisc),
 				       skb, cb, &q_idx, s_q_idx,
 				       true, tca[TCA_DUMP_INVISIBLE]) < 0) {
-			netdev_unlock_ops(dev);
 			goto done;
 		}
 
-		dev_queue = dev_ingress_queue(dev);
+		dev_queue = dev_ingress_queue_rcu(dev);
 		if (dev_queue &&
-		    tc_dump_qdisc_root(rtnl_dereference(dev_queue->qdisc_sleeping),
+		    tc_dump_qdisc_root(rcu_dereference(dev_queue->qdisc_sleeping),
 				       skb, cb, &q_idx, s_q_idx, false,
 				       tca[TCA_DUMP_INVISIBLE]) < 0) {
-			netdev_unlock_ops(dev);
 			goto done;
 		}
-		netdev_unlock_ops(dev);
 
 cont:
 		idx++;
 	}
 
 done:
+	rcu_read_unlock();
 	cb->args[0] = idx;
 	cb->args[1] = q_idx;
 
@@ -2487,7 +2483,8 @@ static const struct rtnl_msg_handler psched_rtnl_msg_handlers[] __initconst = {
 	{.msgtype = RTM_NEWQDISC, .doit = tc_modify_qdisc},
 	{.msgtype = RTM_DELQDISC, .doit = tc_get_qdisc},
 	{.msgtype = RTM_GETQDISC, .doit = tc_get_qdisc,
-	 .dumpit = tc_dump_qdisc},
+	 .dumpit = tc_dump_qdisc,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_NEWTCLASS, .doit = tc_ctl_tclass},
 	{.msgtype = RTM_DELTCLASS, .doit = tc_ctl_tclass},
 	{.msgtype = RTM_GETTCLASS, .doit = tc_ctl_tclass,
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index dd553d6f3e8e911e161c1440eb6d9ce94f65385a..c13881a5c2b4ecb37b41b906ad96bb5de2653fe8 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1286,7 +1286,7 @@ static int fq_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 
 	st.pad = 0;
 
-	sch_tree_lock(sch);
+	sch_tree_lock_rcu(sch);
 
 	st.gc_flows		  = q->stat_gc_flows;
 	st.highprio_packets	  = 0;
@@ -1310,7 +1310,7 @@ static int fq_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 		st.band_drops[i]  = q->stat_band_drops[i];
 		st.band_pkt_count[i] = q->band_pkt_count[i];
 	}
-	sch_tree_unlock(sch);
+	sch_tree_unlock_rcu(sch);
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
 }
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index db5cf578cbd63e842381cb147ced145fed4cca3e..e14d014041c2e33b344455f089ab69e93a13feca 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -586,7 +586,7 @@ static int fq_codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	};
 	struct list_head *pos;
 
-	sch_tree_lock(sch);
+	sch_tree_lock_rcu(sch);
 
 	st.qdisc_stats.maxpacket = q->cstats.maxpacket;
 	st.qdisc_stats.drop_overlimit = q->drop_overlimit;
@@ -601,7 +601,7 @@ static int fq_codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 
 	list_for_each(pos, &q->old_flows)
 		st.qdisc_stats.old_flows_len++;
-	sch_tree_unlock(sch);
+	sch_tree_unlock_rcu(sch);
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
 }
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 72f48fa4010bebbe6be212938b457db21ff3c5a0..93b2abdb6328f63e2dcbfbee463ddd689a9d733d 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -512,7 +512,7 @@ static int fq_pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	struct tc_fq_pie_xstats st = { 0 };
 	struct list_head *pos;
 
-	sch_tree_lock(sch);
+	sch_tree_lock_rcu(sch);
 
 	st.packets_in	= q->stats.packets_in;
 	st.overlimit	= q->stats.overlimit;
@@ -527,7 +527,7 @@ static int fq_pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 
 	list_for_each(pos, &q->old_flows)
 		st.old_flows_len++;
-	sch_tree_unlock(sch);
+	sch_tree_unlock_rcu(sch);
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
 }
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 36d0cafac2063f3ba1133ad9b8fab08ce4468550..28a99640da95a73117697cbf220109556a253343 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -377,7 +377,7 @@ static int gred_offload_dump_stats(struct Qdisc *sch)
 	/* Even if driver returns failure adjust the stats - in case offload
 	 * ended but driver still wants to adjust the values.
 	 */
-	sch_tree_lock(sch);
+	sch_tree_lock_rcu(sch);
 	for (i = 0; i < MAX_DPs; i++) {
 		if (!table->tab[i])
 			continue;
@@ -394,7 +394,7 @@ static int gred_offload_dump_stats(struct Qdisc *sch)
 		sch->qstats.overlimits += hw_stats->stats.qstats[i].overlimits;
 	}
 	_bstats_update(&sch->bstats, bytes, packets);
-	sch_tree_unlock(sch);
+	sch_tree_unlock_rcu(sch);
 
 	kfree(hw_stats);
 	return ret;
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index 1e4522436620e5ee3a0417996476b37d9abca299..eaffac2453bbd81bcf2655804e22ab9167d0660a 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -155,7 +155,7 @@ void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb)
 	 * qdisc totals are added at end.
 	 */
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
-		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
+		qdisc = rcu_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
 
 		gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
 				     &qdisc->bstats, false);
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index ac6d7d0a35309a5375425790f89f587601511cc7..b585b94d0cef8e13a416d3c2f969e421bc11cbf5 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -567,7 +567,7 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	 * qdisc totals are added at end.
 	 */
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
-		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
+		qdisc = rcu_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
 
 		gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
 				     &qdisc->bstats, false);
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 885a9bc859166dfb6d20aa0dfbb8f11194e02ba9..93a366ba793bf92afe8359d2844b7673326ef79c 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2404,23 +2404,21 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	    nla_put_u32(skb, TCA_TAPRIO_ATTR_TXTIME_DELAY, q->txtime_delay))
 		goto options_error;
 
-	rcu_read_lock();
-
-	oper = rtnl_dereference(q->oper_sched);
-	admin = rtnl_dereference(q->admin_sched);
+	oper = rcu_dereference(q->oper_sched);
+	admin = rcu_dereference(q->admin_sched);
 
 	if (oper && taprio_dump_tc_entries(skb, q, oper))
-		goto options_error_rcu;
+		goto options_error;
 
 	if (oper && dump_schedule(skb, oper))
-		goto options_error_rcu;
+		goto options_error;
 
 	if (!admin)
 		goto done;
 
 	sched_nest = nla_nest_start_noflag(skb, TCA_TAPRIO_ATTR_ADMIN_SCHED);
 	if (!sched_nest)
-		goto options_error_rcu;
+		goto options_error;
 
 	if (dump_schedule(skb, admin))
 		goto admin_error;
@@ -2428,15 +2426,11 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	nla_nest_end(skb, sched_nest);
 
 done:
-	rcu_read_unlock();
 	return nla_nest_end(skb, nest);
 
 admin_error:
 	nla_nest_cancel(skb, sched_nest);
 
-options_error_rcu:
-	rcu_read_unlock();
-
 options_error:
 	nla_nest_cancel(skb, nest);
 
-- 
2.53.0.1213.gd9a14994de-goog


