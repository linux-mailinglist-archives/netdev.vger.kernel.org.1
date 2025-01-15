Return-Path: <netdev+bounces-158526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472EFA12601
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E3516328C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18BA762EF;
	Wed, 15 Jan 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgYFjJM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D724A7D1
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951279; cv=none; b=CtBPBY/DCo1RMQQA86+WUDiWDQnzDcGoKQbI6HVZKREtv++79NUZBxLoZ9dDKmHdUyEQZHgIJtHiC3UMqEQcMepQfAxLhwQBSwHHXuogpu9EDsKX4ofqFImKx/fjxxnMVRmeUuRdkBp/GSOlySLBB6iuvYfl6gJUezdtPkre4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951279; c=relaxed/simple;
	bh=slhzRwYMTkKQeU6R2//hj5cO4gJs8J63JmqkthJAf84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jnDV6aTMRqkoRr4LTmQ5WWq2nXMd3p6GuwFebMCIKikgPZAWJWjUs0cAqDsOQ91l560CecyUIX91emCpD2exZMgW8k3yttYqM5rZQ4uYP9TGsqRiRXGR1nzFfwGuo3JhPw8/KbfxTW+3qwvkrss6PFeEN+AeXg/tctqF6uGgmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgYFjJM0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7bcf33f698dso417445185a.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 06:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736951276; x=1737556076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=djwrfieanoMmboWsY8s1t9Oivtbr/8ObbokfC96ZS9A=;
        b=IgYFjJM089JI3bihmI8OhM/dx+ENjV4SM3G/Iy4HjYhP7Dt93JTXJv0l1RFl4UEF6M
         QS5KJpKnsTuLZN7Ro+7Z+56VU+dImAG/KZyYFcvzocFXauCRlqPHkHt3E6DliatbPUQ5
         kVQqt0uTPEGeuFTfdAwzkqaZEJzxaCM/QMMty3TFQAtx3mrPoNW3dG5v+dnviTkjoFWe
         RNe8yZlijpeU5RRvBe2MslwXvPz2gMzSPj+tcL04TDGYqDUT34gMOzGB+Fna1p0QUQdc
         yAieE7kX6sZX+hjGa1nRs2pB6dXX7iUDj7THDoLDIeUBtsz4+BlNXXutQexh0p+/j0mc
         HjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736951276; x=1737556076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djwrfieanoMmboWsY8s1t9Oivtbr/8ObbokfC96ZS9A=;
        b=Jz6tp7U99TwyJ16t1DTADU4kv6wzaiFuK53AmgX8HO3F+EVMPN7eMpgwuGaTwfOlby
         2zeakrA0tJQH9QDgDHsrn3rYe1Z73vh3TD8n4d+WR5EXZEW6xblUiCZXHdJcD9J2nd7s
         UhtXMvsvrJlk3TNG5gJHChVpakz37xn5MxbvzTKPaULxLBHUHhdMBIB7jLn2e7dI2nUz
         nTb6nnjCg2AGAZUyR6W9y8uEs2GcSJlITkeMAwrKopkTgFemBd/RghHnJSGrZpjn01Hw
         s5BTB3wcPhfud4wzvBukzwZ37BovJbUtc61JPtXaVg7hGkSPqoDG0NC3XUKtl9dJGYMT
         aZAA==
X-Gm-Message-State: AOJu0Yy9YPQ8NkR+EBeR5OuU4J2F4+/rKyLA4CPDq8cZsx/RIkf6VYvv
	vejpB5+w8c3pC0FZs5JEcbmphmjJsZFJYbe9Y9I5rtJ4BV2uQU2e7Xy2/P4n
X-Gm-Gg: ASbGncu+GtzpR3K6bhAhYxipocJQXBHj7+lQk2YHt6IW80X4C5vsZWyMJUrsSQjcAWQ
	6tjtH6KwWTPKhbR83IZI42IRQPhq4k5nO2F7a0oCGSAzRkRGC024LWBIs/ipUqN3mL7L0HX/PU6
	CwMreZoXC6w+ykPGNB9JjKC5eoZOoEcA1ySmPUWF5rdXcS7atJ6GPsEGtkoTPnXZgqgT/7aXaYR
	QDs/GoN38fE6B5OsHacPsHYXpcKGlh1fTeQaeQpgg1PKz2zYZqVppC18rnoMfxeYUOZVpZj+LO1
	OQChkPaCNyfxb9NT
X-Google-Smtp-Source: AGHT+IEQ1pXJNQiyzoCH+RRN0gRu+Ev80Mk97iEpW4B0zUZqSY+P5JrnUvldiMZGTAagT5rIN1bCkQ==
X-Received: by 2002:a05:620a:2947:b0:7b6:e888:6b0e with SMTP id af79cd13be357-7bcd96fa294mr4221160385a.2.1736951276216;
        Wed, 15 Jan 2025 06:27:56 -0800 (PST)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bcf1808ba9sm559671785a.3.2025.01.15.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 06:27:55 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	ast@fiberby.net,
	Shuang Li <shuali@redhat.com>
Subject: [PATCH v3 net-next] net: sched: refine software bypass handling in tc_run
Date: Wed, 15 Jan 2025 09:27:54 -0500
Message-ID: <76c421c64c640f5a5868c439d6be3c6d1548789e.1736951274.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch addresses issues with filter counting in block (tcf_block),
particularly for software bypass scenarios, by introducing a more
accurate mechanism using useswcnt.

Previously, filtercnt and skipswcnt were introduced by:

  Commit 2081fd3445fe ("net: sched: cls_api: add filter counter") and
  Commit f631ef39d819 ("net: sched: cls_api: add skip_sw counter")

  filtercnt tracked all tp (tcf_proto) objects added to a block, and
  skipswcnt counted tp objects with the skipsw attribute set.

The problem is: a single tp can contain multiple filters, some with skipsw
and others without. The current implementation fails in the case:

  When the first filter in a tp has skipsw, both skipswcnt and filtercnt
  are incremented, then adding a second filter without skipsw to the same
  tp does not modify these counters because tp->counted is already set.

  This results in bypass software behavior based solely on skipswcnt
  equaling filtercnt, even when the block includes filters without
  skipsw. Consequently, filters without skipsw are inadvertently bypassed.

To address this, the patch introduces useswcnt in block to explicitly count
tp objects containing at least one filter without skipsw. Key changes
include:

  Whenever a filter without skipsw is added, its tp is marked with usesw
  and counted in useswcnt. tc_run() now uses useswcnt to determine software
  bypass, eliminating reliance on filtercnt and skipswcnt.

  This refined approach prevents software bypass for blocks containing
  mixed filters, ensuring correct behavior in tc_run().

Additionally, as atomic operations on useswcnt ensure thread safety and
tp->lock guards access to tp->usesw and tp->counted, the broader lock
down_write(&block->cb_lock) is no longer required in tc_new_tfilter(),
and this resolves a performance regression caused by the filter counting
mechanism during parallel filter insertions.

  The improvement can be demonstrated using the following script:

  # cat insert_tc_rules.sh

    tc qdisc add dev ens1f0np0 ingress
    for i in $(seq 16); do
        taskset -c $i tc -b rules_$i.txt &
    done
    wait

  Each of rules_$i.txt files above includes 100000 tc filter rules to a
  mlx5 driver NIC ens1f0np0.

  Without this patch:

  # time sh insert_tc_rules.sh

    real    0m50.780s
    user    0m23.556s
    sys	    4m13.032s

  With this patch:

  # time sh insert_tc_rules.sh

    real    0m17.718s
    user    0m7.807s
    sys     3m45.050s

Fixes: 047f340b36fc ("net: sched: make skip_sw actually skip software")
Reported-by: Shuang Li <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
v2:
  - Keep tcf_bypass_check_needed_key and not touch the code in tc_run().
  - Add the missing call to tcf_proto_update_usesw() for existing rule
    update, as Paolo noticed.
v3:
  - Rename the static key, as it's use has changed, from Asbjørn.
  - Fix tc_run() to the new way to use the static key, from Asbjørn.
  - Move the call to static_branch_inc() out of spin_lock(&tp->lock),
    as Jakub noticed.
  - Move the usesw count code into tcf_proto_count_usesw() and add
    #ifdef CONFIG_NET_CLS_ACT around it, fixing a compile error when
    CONFIG_NET_CLS_ACT is not set.
  - Post to net-next instead.
---
 include/net/pkt_cls.h     | 13 +++++++--
 include/net/sch_generic.h |  5 ++--
 net/core/dev.c            | 15 ++++++-----
 net/sched/cls_api.c       | 57 ++++++++++++++++-----------------------
 net/sched/cls_bpf.c       |  2 ++
 net/sched/cls_flower.c    |  2 ++
 net/sched/cls_matchall.c  |  2 ++
 net/sched/cls_u32.c       |  4 +++
 8 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 22c5ab4269d7..c64fd896b1f9 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -75,11 +75,11 @@ static inline bool tcf_block_non_null_shared(struct tcf_block *block)
 }
 
 #ifdef CONFIG_NET_CLS_ACT
-DECLARE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
+DECLARE_STATIC_KEY_FALSE(tcf_sw_enabled_key);
 
 static inline bool tcf_block_bypass_sw(struct tcf_block *block)
 {
-	return block && block->bypass_wanted;
+	return block && !atomic_read(&block->useswcnt);
 }
 #endif
 
@@ -760,6 +760,15 @@ tc_cls_common_offload_init(struct flow_cls_common_offload *cls_common,
 		cls_common->extack = extack;
 }
 
+static inline void tcf_proto_update_usesw(struct tcf_proto *tp, u32 flags)
+{
+	if (tp->usesw)
+		return;
+	if (tc_skip_sw(flags) && tc_in_hw(flags))
+		return;
+	tp->usesw = true;
+}
+
 #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 static inline struct tc_skb_ext *tc_skb_ext_alloc(struct sk_buff *skb)
 {
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 8074322dd636..d635c5b47eba 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -425,6 +425,7 @@ struct tcf_proto {
 	spinlock_t		lock;
 	bool			deleting;
 	bool			counted;
+	bool			usesw;
 	refcount_t		refcnt;
 	struct rcu_head		rcu;
 	struct hlist_node	destroy_ht_node;
@@ -474,9 +475,7 @@ struct tcf_block {
 	struct flow_block flow_block;
 	struct list_head owner_list;
 	bool keep_dst;
-	bool bypass_wanted;
-	atomic_t filtercnt; /* Number of filters */
-	atomic_t skipswcnt; /* Number of skip_sw filters */
+	atomic_t useswcnt;
 	atomic_t offloadcnt; /* Number of oddloaded filters */
 	unsigned int nooffloaddevcnt; /* Number of devs unable to do offload */
 	unsigned int lockeddevcnt; /* Number of devs that require rtnl lock. */
diff --git a/net/core/dev.c b/net/core/dev.c
index 1a90ed8cc6cc..61825c0ecf4e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2149,8 +2149,8 @@ EXPORT_SYMBOL_GPL(net_dec_egress_queue);
 #endif
 
 #ifdef CONFIG_NET_CLS_ACT
-DEFINE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
-EXPORT_SYMBOL(tcf_bypass_check_needed_key);
+DEFINE_STATIC_KEY_FALSE(tcf_sw_enabled_key);
+EXPORT_SYMBOL(tcf_sw_enabled_key);
 #endif
 
 DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
@@ -4045,10 +4045,13 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 	if (!miniq)
 		return ret;
 
-	if (static_branch_unlikely(&tcf_bypass_check_needed_key)) {
-		if (tcf_block_bypass_sw(miniq->block))
-			return ret;
-	}
+	/* Global bypass */
+	if (!static_branch_likely(&tcf_sw_enabled_key))
+		return ret;
+
+	/* Block-wise bypass */
+	if (tcf_block_bypass_sw(miniq->block))
+		return ret;
 
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 7578e27260c9..8e47e5355be6 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -390,6 +390,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
 	tp->protocol = protocol;
 	tp->prio = prio;
 	tp->chain = chain;
+	tp->usesw = !tp->ops->reoffload;
 	spin_lock_init(&tp->lock);
 	refcount_set(&tp->refcnt, 1);
 
@@ -410,39 +411,31 @@ static void tcf_proto_get(struct tcf_proto *tp)
 	refcount_inc(&tp->refcnt);
 }
 
-static void tcf_maintain_bypass(struct tcf_block *block)
+static void tcf_proto_count_usesw(struct tcf_proto *tp, bool add)
 {
-	int filtercnt = atomic_read(&block->filtercnt);
-	int skipswcnt = atomic_read(&block->skipswcnt);
-	bool bypass_wanted = filtercnt > 0 && filtercnt == skipswcnt;
-
-	if (bypass_wanted != block->bypass_wanted) {
 #ifdef CONFIG_NET_CLS_ACT
-		if (bypass_wanted)
-			static_branch_inc(&tcf_bypass_check_needed_key);
-		else
-			static_branch_dec(&tcf_bypass_check_needed_key);
-#endif
-		block->bypass_wanted = bypass_wanted;
+	struct tcf_block *block = tp->chain->block;
+	bool counted = false;
+
+	if (!add) {
+		if (tp->usesw && tp->counted) {
+			if (!atomic_dec_return(&block->useswcnt))
+				static_branch_dec(&tcf_sw_enabled_key);
+			tp->counted = false;
+		}
+		return;
 	}
-}
-
-static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add)
-{
-	lockdep_assert_not_held(&block->cb_lock);
 
-	down_write(&block->cb_lock);
-	if (*counted != add) {
-		if (add) {
-			atomic_inc(&block->filtercnt);
-			*counted = true;
-		} else {
-			atomic_dec(&block->filtercnt);
-			*counted = false;
-		}
+	spin_lock(&tp->lock);
+	if (tp->usesw && !tp->counted) {
+		counted = true;
+		tp->counted = true;
 	}
-	tcf_maintain_bypass(block);
-	up_write(&block->cb_lock);
+	spin_unlock(&tp->lock);
+
+	if (counted && atomic_inc_return(&block->useswcnt) == 1)
+		static_branch_inc(&tcf_sw_enabled_key);
+#endif
 }
 
 static void tcf_chain_put(struct tcf_chain *chain);
@@ -451,7 +444,7 @@ static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
 			      bool sig_destroy, struct netlink_ext_ack *extack)
 {
 	tp->ops->destroy(tp, rtnl_held, extack);
-	tcf_block_filter_cnt_update(tp->chain->block, &tp->counted, false);
+	tcf_proto_count_usesw(tp, false);
 	if (sig_destroy)
 		tcf_proto_signal_destroyed(tp->chain, tp);
 	tcf_chain_put(tp->chain);
@@ -2409,7 +2402,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
 			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
-		tcf_block_filter_cnt_update(block, &tp->counted, true);
+		tcf_proto_count_usesw(tp, true);
 		/* q pointer is NULL for shared blocks */
 		if (q)
 			q->flags &= ~TCQ_F_CAN_BYPASS;
@@ -3532,8 +3525,6 @@ static void tcf_block_offload_inc(struct tcf_block *block, u32 *flags)
 	if (*flags & TCA_CLS_FLAGS_IN_HW)
 		return;
 	*flags |= TCA_CLS_FLAGS_IN_HW;
-	if (tc_skip_sw(*flags))
-		atomic_inc(&block->skipswcnt);
 	atomic_inc(&block->offloadcnt);
 }
 
@@ -3542,8 +3533,6 @@ static void tcf_block_offload_dec(struct tcf_block *block, u32 *flags)
 	if (!(*flags & TCA_CLS_FLAGS_IN_HW))
 		return;
 	*flags &= ~TCA_CLS_FLAGS_IN_HW;
-	if (tc_skip_sw(*flags))
-		atomic_dec(&block->skipswcnt);
 	atomic_dec(&block->offloadcnt);
 }
 
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 1941ebec23ff..7fbe42f0e5c2 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -509,6 +509,8 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	if (!tc_in_hw(prog->gen_flags))
 		prog->gen_flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+	tcf_proto_update_usesw(tp, prog->gen_flags);
+
 	if (oldprog) {
 		idr_replace(&head->handle_idr, prog, handle);
 		list_replace_rcu(&oldprog->link, &prog->link);
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 1008ec8a464c..03505673d523 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2503,6 +2503,8 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	if (!tc_in_hw(fnew->flags))
 		fnew->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+	tcf_proto_update_usesw(tp, fnew->flags);
+
 	spin_lock(&tp->lock);
 
 	/* tp was deleted concurrently. -EAGAIN will cause caller to lookup
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index 9f1e62ca508d..f03bf5da39ee 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -228,6 +228,8 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 	if (!tc_in_hw(new->flags))
 		new->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+	tcf_proto_update_usesw(tp, new->flags);
+
 	*arg = head;
 	rcu_assign_pointer(tp->root, new);
 	return 0;
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d3a03c57545b..2a1c00048fd6 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -951,6 +951,8 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!tc_in_hw(new->flags))
 			new->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+		tcf_proto_update_usesw(tp, new->flags);
+
 		u32_replace_knode(tp, tp_c, new);
 		tcf_unbind_filter(tp, &n->res);
 		tcf_exts_get_net(&n->exts);
@@ -1164,6 +1166,8 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+		tcf_proto_update_usesw(tp, n->flags);
+
 		ins = &ht->ht[TC_U32_HASH(handle)];
 		for (pins = rtnl_dereference(*ins); pins;
 		     ins = &pins->next, pins = rtnl_dereference(*ins))
-- 
2.43.0


