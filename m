Return-Path: <netdev+bounces-57656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024B813B9A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC706B21DC1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F4B6A359;
	Thu, 14 Dec 2023 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Qx/AdtJb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EC1110
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d0bcc0c313so47857025ad.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 12:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702586146; x=1703190946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of6J+086OPjEIj9keVzyqTPwLJ+HMrnbr9lLx0QxZhc=;
        b=Qx/AdtJb9cwrpIGlJHxv/wuyjiT2xl3VdGEqteJnqwNhCdAJpBB2ZwsyohDJ534j/t
         rXn4m13f6X3OOuDgrwlDibSYL2lAu1HYUgHhY6+IUenfQdiswXIPGwG9qctzyUA/SsqJ
         2Oon/brLgnN3XH4mk0R2yglg3bPbXnwKd80IS0UB/3eehHhkJsTOnlFTA5EET08stGyp
         qU3hijPDCk4ud9biGzYkhmQ7UtksGc+KuiUZB1qd5tjurgQ7/QpDf5X1wEIinrsoqJK0
         Q8bcFTO5ZugL8Ge0lSoMXBAcc1Ze33bdClU4/Ya2C4nTrG94et9/duuFm0r0SCiNuFRz
         pJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586146; x=1703190946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of6J+086OPjEIj9keVzyqTPwLJ+HMrnbr9lLx0QxZhc=;
        b=etYmcXUj1HQ5JGLloRcI80lxv69iYy0bFA/rSfmWVW+YB9lBO73yHgexUtNF4zLHDJ
         RAfCseQYzeO1H11D/J+n/opr2IqrkWREZ+TdtfDnHOX7mXeQneBaBpqCVEyDod1yYudy
         wsofTAke+5qYeqCVcA+/fTEkGzFOs5/vhAoCZMtd2PKJl03FmIbaBiYbrU0PNKHKduCZ
         YFkt3v9RAutIa6npyjivcU/JlIj5koxG7qothuUv9nZYA8v6PWNbTCzCz7H0xRAOONB0
         +X5EvgYp2B++4tK3niKCWSiq6TR0bQ8ZObM34/gAlIvi+wOch6y8U0Y4kfUkP8MtPk0i
         ur6A==
X-Gm-Message-State: AOJu0YwC0fsfAWUAOR+1a7h2O+nGIcLW1UkFo3GBRFcCzmJPUZbFZ0Gx
	tGGyY1dCKOYbLz6jQhk9VgOpKA==
X-Google-Smtp-Source: AGHT+IFYbob67lAFnAYbaGJ7q5XXvuDwTIB11VBqGF+8CthuLiSHnu+q1iKzZG5RQcozUbw4yZW9Jw==
X-Received: by 2002:a17:902:a383:b0:1d0:84f1:6fb8 with SMTP id x3-20020a170902a38300b001d084f16fb8mr4397345pla.68.1702586146368;
        Thu, 14 Dec 2023 12:35:46 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm12842871plk.171.2023.12.14.12.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:35:46 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	horms@kernel.org
Cc: dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v4 1/3] net: sched: Move drop_reason to struct tc_skb_cb
Date: Thu, 14 Dec 2023 17:35:30 -0300
Message-ID: <20231214203532.3594232-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214203532.3594232-1-victor@mojatatu.com>
References: <20231214203532.3594232-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move drop_reason from struct tcf_result to skb cb - more specifically to
struct tc_skb_cb. With that, we'll be able to also set the drop reason for
the remaining qdiscs (aside from clsact) that do not have access to
tcf_result when time comes to set the skb drop reason.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/pkt_cls.h     | 14 ++++++++++++--
 include/net/pkt_sched.h   |  3 ++-
 include/net/sch_generic.h |  1 -
 net/core/dev.c            |  4 ++--
 net/sched/act_api.c       |  2 +-
 net/sched/cls_api.c       | 23 ++++++++---------------
 6 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a76c9171db0e..761e4500cca0 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -154,10 +154,20 @@ __cls_set_class(unsigned long *clp, unsigned long cl)
 	return xchg(clp, cl);
 }
 
-static inline void tcf_set_drop_reason(struct tcf_result *res,
+struct tc_skb_cb;
+
+static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb);
+
+static inline enum skb_drop_reason
+tcf_get_drop_reason(const struct sk_buff *skb)
+{
+	return tc_skb_cb(skb)->drop_reason;
+}
+
+static inline void tcf_set_drop_reason(const struct sk_buff *skb,
 				       enum skb_drop_reason reason)
 {
-	res->drop_reason = reason;
+	tc_skb_cb(skb)->drop_reason = reason;
 }
 
 static inline void
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 9fa1d0794dfa..9b559aa5c079 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -277,12 +277,13 @@ static inline void skb_txtime_consumed(struct sk_buff *skb)
 
 struct tc_skb_cb {
 	struct qdisc_skb_cb qdisc_cb;
+	u32 drop_reason;
 
+	u16 zone; /* Only valid if post_ct = true */
 	u16 mru;
 	u8 post_ct:1;
 	u8 post_ct_snat:1;
 	u8 post_ct_dnat:1;
-	u16 zone; /* Only valid if post_ct = true */
 };
 
 static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index dcb9160e6467..c499b56bb215 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -332,7 +332,6 @@ struct tcf_result {
 		};
 		const struct tcf_proto *goto_tp;
 	};
-	enum skb_drop_reason		drop_reason;
 };
 
 struct tcf_chain;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0432b04cf9b0..16af89a733e4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3923,14 +3923,14 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
-	res.drop_reason = *drop_reason;
+	tcf_set_drop_reason(skb, *drop_reason);
 
 	mini_qdisc_bstats_cpu_update(miniq, skb);
 	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
 	/* Only tcf related quirks below. */
 	switch (ret) {
 	case TC_ACT_SHOT:
-		*drop_reason = res.drop_reason;
+		*drop_reason = tcf_get_drop_reason(skb);
 		mini_qdisc_qstats_cpu_drop(miniq);
 		break;
 	case TC_ACT_OK:
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 3a7770eff52d..db500aa9f841 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1119,7 +1119,7 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 			}
 		} else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
 			if (unlikely(!rcu_access_pointer(a->goto_chain))) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 			tcf_action_goto_chain_exec(a, res);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index dc1c19a25882..199406e4bcdd 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1657,7 +1657,6 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				 int act_index,
 				 u32 *last_executed_chain)
 {
-	u32 orig_reason = res->drop_reason;
 #ifdef CONFIG_NET_CLS_ACT
 	const int max_reclassify_loop = 16;
 	const struct tcf_proto *first_tp;
@@ -1682,13 +1681,13 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			 */
 			if (unlikely(n->tp != tp || n->tp->chain != n->chain ||
 				     !tp->ops->get_exts)) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
 			exts = tp->ops->get_exts(tp, n->handle);
 			if (unlikely(!exts || n->exts != exts)) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
@@ -1712,18 +1711,12 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			goto reset;
 		}
 #endif
-		if (err >= 0) {
-			/* Policy drop or drop reason is over-written by
-			 * classifiers with a bogus value(0) */
-			if (err == TC_ACT_SHOT &&
-			    res->drop_reason == SKB_NOT_DROPPED_YET)
-				tcf_set_drop_reason(res, orig_reason);
+		if (err >= 0)
 			return err;
-		}
 	}
 
 	if (unlikely(n)) {
-		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 		return TC_ACT_SHOT;
 	}
 
@@ -1735,7 +1728,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
-		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 		return TC_ACT_SHOT;
 	}
 
@@ -1773,7 +1766,7 @@ int tcf_classify(struct sk_buff *skb,
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
 				if (!n) {
-					tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+					tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 					return TC_ACT_SHOT;
 				}
 
@@ -1784,7 +1777,7 @@ int tcf_classify(struct sk_buff *skb,
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
 			if (!fchain) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
@@ -1806,7 +1799,7 @@ int tcf_classify(struct sk_buff *skb,
 
 			ext = tc_skb_ext_alloc(skb);
 			if (WARN_ON_ONCE(!ext)) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
-- 
2.25.1


