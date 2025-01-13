Return-Path: <netdev+bounces-157850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFEEA0C0AC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D17F163F4D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8640B1CAA8C;
	Mon, 13 Jan 2025 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTg7qysl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1C1C549F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793780; cv=none; b=U6qYoKU8YF4nbBZgIEVUcPvGf6OEhsRwKf4K1SEKqRUVZeME0LunezRnG8jEs23zHVQlfsUPBdMyxxJrKFFmjcPDOrqxK6cLdgYh+04l6p4pf3QjhfzOMCfvyo2PcdYBNJVNwigiGPP6D9S8NDMs4/bnxNdPsq0yoe2Pc3g033g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793780; c=relaxed/simple;
	bh=DKUXRbGnNWOgsMJiD6f//aFt6/3FsdsdcDPxA1plMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vD08hijy8SQv9IDLoKmnjMy+SjT8GAD4uq7dvymwLOXDAwq2V7E5PmzyGKtqLO6ujkYG7DsF0m2iaVstiydvqs2rTnlWfRRfUEv8dw3//bAVmjeS/8pFE9NFAQ1uFbYNKScm1ruY2Qxb1ONuMnw8uqR+nA0wGM4fDhkqWpWVWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTg7qysl; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8f65ef5abso35208706d6.3
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 10:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736793777; x=1737398577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/tfEGZD/3Cd70fKSjf2Kp5dWOTNqs/4tHEivQfF5pc=;
        b=GTg7qyslQNvH+ZI+CemGfLAzx4QzQVZv8Z4Gn6RY1iXKGy20HfRgakDiOjANJ0MeBE
         ic2eWehK24gyuOJjLsQL/ixFOtOiw3GKG19njAoNZCsP92HdC4/7dZEGA0vqFZU4am7r
         WWcJb0MIkpQlAVECdj30An1pHNZE4eIwdL817MV0hohNG3sQfvY1q6dx4MoVruDtJfJd
         lxZjq/QVsQSx/hR3rgDGkb5kRVrJKfbthUvtHqj+P9zbCnY1Hc/lX5oi/HL556PuZA5G
         mROlyiBvljqz78WYWcmW3jsT56mWfcD4bLfRgKtCC21VhomM+en1+GTk4VnrIXKxxvgW
         vO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736793777; x=1737398577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/tfEGZD/3Cd70fKSjf2Kp5dWOTNqs/4tHEivQfF5pc=;
        b=cKKpQ90jP9K9YQf6zWGHZjAPNUujfTrKZQZ7K6FiVty3cqP3VP19NCZq4XECptIhpV
         0wBtY7KanBrjcbYw2FvMlPZb+CkQVEz6ti5GuR9J3HBFT8E4AF7K+fDHcwDr3pQAcKRE
         b3mAl2ZjFG3p+dFXOdN2RJexv1w/AbZVtO0yr5sUCvFW5HObpZzC+aXLckpNFX3z4KyY
         QOLci0vh1KeDPl6XdUOWMCITaFRNWJY6qblqFqXTrQd0eFt26n7uvJrovGz5L1HavfPs
         5CvRR6IAqBi7cqKUZ6a61QxqYL+Lj/gozSQod1gS0eXy1avWHW8krjTqJqhYn8nmAvKq
         6sHA==
X-Gm-Message-State: AOJu0YzhZAlOpKYx/ZeDLJLOzrZ2w85v+GQTaao5egMof6AE8ZwtDZUh
	4v3sfJHVbZgAXMrmLVIa0GehjD8PQnlJsX9h5L/2bam2WXYn0TnbAfW8HQ==
X-Gm-Gg: ASbGncuITQDdCLl8WUxrWY65puezMN/QBIj2gCIZjHIeiNQNGRTTy+wqJFFFxPMcd0g
	BFT6TX7gdHE8dQKGeKcRl0k/aCpdj6j50fl7y8aRiMZBvPVgkYOuxjTk9p3LS2edFeGttNMMRTf
	mFjQC47fIlnrmvUWRNpIz2A6ccGWB0GV2D+w1JtM7I2SrM09fvXeqJ50DesRU9kr/9f3KQW8Gik
	6nyzsuoAqsSVIth08PndP84pVNny9q+PAxON9LX31peLzNyCUbhZKpedY3iZUWVnE112ISEdjH/
	9JDHPbh/oKRdiakW
X-Google-Smtp-Source: AGHT+IET+raO9ehqB/GlbbzpJKLJxr792LrSZh+HsNXwPla/onoOpK7GYcipDANZC6pzxiZaTqnotw==
X-Received: by 2002:ad4:5ccd:0:b0:6d8:8a01:64e2 with SMTP id 6a1803df08f44-6df9b308659mr324024846d6.43.1736793776993;
        Mon, 13 Jan 2025 10:42:56 -0800 (PST)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad886c1bsm44027546d6.45.2025.01.13.10.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 10:42:56 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	ast@fiberby.net,
	Shuang Li <shuali@redhat.com>
Subject: [PATCHv2 net] net: sched: refine software bypass handling in tc_run
Date: Mon, 13 Jan 2025 13:42:55 -0500
Message-ID: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
  - keep tcf_bypass_check_needed_key and not touch the code in tc_run().
  - add the missing call to tcf_proto_update_usesw() for existing rule
    update, as Paolo noticed.
---
 include/net/pkt_cls.h     | 11 +++++++-
 include/net/sch_generic.h |  5 ++--
 net/sched/cls_api.c       | 54 ++++++++++-----------------------------
 net/sched/cls_bpf.c       |  2 ++
 net/sched/cls_flower.c    |  2 ++
 net/sched/cls_matchall.c  |  2 ++
 net/sched/cls_u32.c       |  4 +++
 7 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index cf199af85c52..e4fea1decca1 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -79,7 +79,7 @@ DECLARE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
 
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
index 5d74fa7e694c..1e6324f0d4ef 100644
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
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 7578e27260c9..358b66dfdc83 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -390,6 +390,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
 	tp->protocol = protocol;
 	tp->prio = prio;
 	tp->chain = chain;
+	tp->usesw = !tp->ops->reoffload;
 	spin_lock_init(&tp->lock);
 	refcount_set(&tp->refcnt, 1);
 
@@ -410,48 +411,17 @@ static void tcf_proto_get(struct tcf_proto *tp)
 	refcount_inc(&tp->refcnt);
 }
 
-static void tcf_maintain_bypass(struct tcf_block *block)
-{
-	int filtercnt = atomic_read(&block->filtercnt);
-	int skipswcnt = atomic_read(&block->skipswcnt);
-	bool bypass_wanted = filtercnt > 0 && filtercnt == skipswcnt;
-
-	if (bypass_wanted != block->bypass_wanted) {
-#ifdef CONFIG_NET_CLS_ACT
-		if (bypass_wanted)
-			static_branch_inc(&tcf_bypass_check_needed_key);
-		else
-			static_branch_dec(&tcf_bypass_check_needed_key);
-#endif
-		block->bypass_wanted = bypass_wanted;
-	}
-}
-
-static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add)
-{
-	lockdep_assert_not_held(&block->cb_lock);
-
-	down_write(&block->cb_lock);
-	if (*counted != add) {
-		if (add) {
-			atomic_inc(&block->filtercnt);
-			*counted = true;
-		} else {
-			atomic_dec(&block->filtercnt);
-			*counted = false;
-		}
-	}
-	tcf_maintain_bypass(block);
-	up_write(&block->cb_lock);
-}
-
 static void tcf_chain_put(struct tcf_chain *chain);
 
 static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
 			      bool sig_destroy, struct netlink_ext_ack *extack)
 {
 	tp->ops->destroy(tp, rtnl_held, extack);
-	tcf_block_filter_cnt_update(tp->chain->block, &tp->counted, false);
+	if (tp->usesw && tp->counted) {
+		if (!atomic_dec_return(&tp->chain->block->useswcnt))
+			static_branch_dec(&tcf_bypass_check_needed_key);
+		tp->counted = false;
+	}
 	if (sig_destroy)
 		tcf_proto_signal_destroyed(tp->chain, tp);
 	tcf_chain_put(tp->chain);
@@ -2409,7 +2379,13 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
 			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
-		tcf_block_filter_cnt_update(block, &tp->counted, true);
+		spin_lock(&tp->lock);
+		if (tp->usesw && !tp->counted) {
+			if (atomic_inc_return(&block->useswcnt) == 1)
+				static_branch_inc(&tcf_bypass_check_needed_key);
+			tp->counted = true;
+		}
+		spin_unlock(&tp->lock);
 		/* q pointer is NULL for shared blocks */
 		if (q)
 			q->flags &= ~TCQ_F_CAN_BYPASS;
@@ -3532,8 +3508,6 @@ static void tcf_block_offload_inc(struct tcf_block *block, u32 *flags)
 	if (*flags & TCA_CLS_FLAGS_IN_HW)
 		return;
 	*flags |= TCA_CLS_FLAGS_IN_HW;
-	if (tc_skip_sw(*flags))
-		atomic_inc(&block->skipswcnt);
 	atomic_inc(&block->offloadcnt);
 }
 
@@ -3542,8 +3516,6 @@ static void tcf_block_offload_dec(struct tcf_block *block, u32 *flags)
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


