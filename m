Return-Path: <netdev+bounces-155505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7274A028CC
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABD31605C1
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91A12F399;
	Mon,  6 Jan 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW38YMz0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608161C69D
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176117; cv=none; b=cq6IRV/2pD+0VQpaUGCDq8EB7BO96hR/DTseNL9YSzVBbbuWaVwEtcTcO/DYaCA/VM7+QdCyVWB812GymzA1LKIXQySuz2cyfkXuO8LYeBaO+NilECqfP15HxqHNu2iEQRY+9mN0IaKd2gL4DjV0BnADEXKIDVQuSgDNbLT7JOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176117; c=relaxed/simple;
	bh=nnboLfvd5r6P5+KsvIxEJUIkaeKDoEgQR4uluzFagww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1tsbwVKRgHdx9z93reEpdbH55pmEYJd/Fdpa2WKNgNF+CDAYX2Dx/2okdoamNeYDBH5l2Sw1GUr3dYDqurk8N73pQCF73KF1jBox1ujiX85zySZWrU51SK2HG+jVokaya1HwX+rEHmgTEuN71AzQ0dXzEqkN0X2ruEVfJ0dNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW38YMz0; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso127760346d6.3
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 07:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736176114; x=1736780914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTiT+7r8+6ie/mPLv4Jrgg2vJLTLwNkrL+zyo2F+cbs=;
        b=SW38YMz0czs2HjACAWEUXHPmtg8BV5IkU0WOSdz6nWhV0ksEINqhgB/wR21OxgYPhX
         WXPHhSNugqqGEzYb+jWevwabdVW4HEKkILPeFGcZ0nNFYX44WatOeUU2roebXKiY0t8t
         c4jeAjbLYpAcxs7vqwpo6Go15jBcEvGBBuIoz/lu2JQQaZZ4qvNdBhoBmlDCZ5iabkvX
         sOuwFndIXoXRNHsJy0pM0Xx0rhFrKpUAuhcRAvc5nKUy+IekFJwkchUH3zXTAY32Z305
         hFAAA1qJeNBKmpULdJYb94FeQEcf7lESk615kwGihMUjOLVuIhWEktlFuPkBoXRi+X2o
         oMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736176114; x=1736780914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTiT+7r8+6ie/mPLv4Jrgg2vJLTLwNkrL+zyo2F+cbs=;
        b=MWoarW1aljDhYKNUY3GJNiihItTQNppuPx0GH+XVkImyUwtJtpk3DkLGJFM66x4lXZ
         AKCs/hJryBN6holtgRIEZdvOGnl33znRDeYmY6EgRU68tP2YiNgUBcSQulUizxBxSOFp
         HRUpnRQSQQXMqpJRMuYvVQafqYQ0vLlBUXbHSaoLdKLjveekic+UlzYF3Yu3Xl0YAmzM
         XSDmDhRsMXmFcdTZuRh7sNGwwj0AmkeQOQuqD071ly8h1FFnUxjvI0uAysMxeaNhDd7A
         MfKfiEpUtb88C7Bjsa3fdGDoYphRGk89dZEb70i74fNkCg+J0qgeag622ze+UxhFsFfz
         KnzQ==
X-Gm-Message-State: AOJu0YytN9eYkTAutOsWhEGvTTy2WVRynD3Xoj7RCrmMooX3bYdg2ko8
	ScH+gnDGTLqhbZgJ1YMgJbPEYslrgrGn5EA6gL3EWgtmWrrY/I55YARJGQ==
X-Gm-Gg: ASbGncvMTPuoUVCJxl3/300jfLmGkIYwH6e7THJ2ex4Ze1Y26dHyBdnZBJ5QbtD4jXL
	7G80Wgl++H/MeQA6iADpIPLnUrJyzV7J6jMJREHSL09m2LQ1xRoIwaha3ftHDtHApfS45hoh7NQ
	jGsPWwbDBv7FZ6dBSD+lIkni7jc42vTIdqqvHonZ6CAAzp3RxWciTXlF/cAdeBrAZM0tBTClKpw
	JW0CpRe4r0xDnY1SQCs7yp9ae/ikKRoMbLO/y3B9E3h+817/uI1HRVzSCvkTY0kkAKoUChI9wuD
	Jdij7bBQ4u21OJC6
X-Google-Smtp-Source: AGHT+IHrdjdecaM0KsIeT3Ke1jfnzCbxeBSq0MzqyVkaXHSQ3vt8mbYeyqM0HC0g2Aks/Dgj4sDSEw==
X-Received: by 2002:a05:6214:e49:b0:6d4:215d:91c3 with SMTP id 6a1803df08f44-6dd2334f2c9mr1066060436d6.28.1736176113697;
        Mon, 06 Jan 2025 07:08:33 -0800 (PST)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd35b0c471sm147478826d6.29.2025.01.06.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 07:08:33 -0800 (PST)
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
Subject: [PATCH net] net: sched: refine software bypass handling in tc_run
Date: Mon,  6 Jan 2025 10:08:32 -0500
Message-ID: <b9e81aa97ab8ca62e979b7d55c2ee398790b935b.1736176112.git.lucien.xin@gmail.com>
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
 include/net/pkt_cls.h     | 18 +++++++-------
 include/net/sch_generic.h |  5 ++--
 net/core/dev.c            | 11 ++-------
 net/sched/cls_api.c       | 52 +++++++++------------------------------
 net/sched/cls_bpf.c       |  2 ++
 net/sched/cls_flower.c    |  2 ++
 net/sched/cls_matchall.c  |  2 ++
 net/sched/cls_u32.c       |  2 ++
 8 files changed, 32 insertions(+), 62 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index cf199af85c52..d66cb315a6b5 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -74,15 +74,6 @@ static inline bool tcf_block_non_null_shared(struct tcf_block *block)
 	return block && block->index;
 }
 
-#ifdef CONFIG_NET_CLS_ACT
-DECLARE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
-
-static inline bool tcf_block_bypass_sw(struct tcf_block *block)
-{
-	return block && block->bypass_wanted;
-}
-#endif
-
 static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
 {
 	WARN_ON(tcf_block_shared(block));
@@ -760,6 +751,15 @@ tc_cls_common_offload_init(struct flow_cls_common_offload *cls_common,
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
diff --git a/net/core/dev.c b/net/core/dev.c
index 45a8c3dd4a64..c1fff978f3ac 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2103,11 +2103,6 @@ void net_dec_egress_queue(void)
 EXPORT_SYMBOL_GPL(net_dec_egress_queue);
 #endif
 
-#ifdef CONFIG_NET_CLS_ACT
-DEFINE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
-EXPORT_SYMBOL(tcf_bypass_check_needed_key);
-#endif
-
 DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
 EXPORT_SYMBOL(netstamp_needed_key);
 #ifdef CONFIG_JUMP_LABEL
@@ -3998,10 +3993,8 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 	if (!miniq)
 		return ret;
 
-	if (static_branch_unlikely(&tcf_bypass_check_needed_key)) {
-		if (tcf_block_bypass_sw(miniq->block))
-			return ret;
-	}
+	if (miniq->block && !atomic_read(&miniq->block->useswcnt))
+		return ret;
 
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 7578e27260c9..4b971184cfbb 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -390,6 +390,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
 	tp->protocol = protocol;
 	tp->prio = prio;
 	tp->chain = chain;
+	tp->usesw = !tp->ops->reoffload;
 	spin_lock_init(&tp->lock);
 	refcount_set(&tp->refcnt, 1);
 
@@ -410,48 +411,16 @@ static void tcf_proto_get(struct tcf_proto *tp)
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
+		tp->counted = false;
+		atomic_dec(&tp->chain->block->useswcnt);
+	}
 	if (sig_destroy)
 		tcf_proto_signal_destroyed(tp->chain, tp);
 	tcf_chain_put(tp->chain);
@@ -2409,7 +2378,12 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
 			       RTM_NEWTFILTER, false, rtnl_held, extack);
 		tfilter_put(tp, fh);
-		tcf_block_filter_cnt_update(block, &tp->counted, true);
+		spin_lock(&tp->lock);
+		if (tp->usesw && !tp->counted) {
+			tp->counted = true;
+			atomic_inc(&block->useswcnt);
+		}
+		spin_unlock(&tp->lock);
 		/* q pointer is NULL for shared blocks */
 		if (q)
 			q->flags &= ~TCQ_F_CAN_BYPASS;
@@ -3532,8 +3506,6 @@ static void tcf_block_offload_inc(struct tcf_block *block, u32 *flags)
 	if (*flags & TCA_CLS_FLAGS_IN_HW)
 		return;
 	*flags |= TCA_CLS_FLAGS_IN_HW;
-	if (tc_skip_sw(*flags))
-		atomic_inc(&block->skipswcnt);
 	atomic_inc(&block->offloadcnt);
 }
 
@@ -3542,8 +3514,6 @@ static void tcf_block_offload_dec(struct tcf_block *block, u32 *flags)
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
index d3a03c57545b..5e8f191fd820 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1164,6 +1164,8 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
+		tcf_proto_update_usesw(tp, n->flags);
+
 		ins = &ht->ht[TC_U32_HASH(handle)];
 		for (pins = rtnl_dereference(*ins); pins;
 		     ins = &pins->next, pins = rtnl_dereference(*ins))
-- 
2.43.0


