Return-Path: <netdev+bounces-53135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3CA801738
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9947280A97
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008E3F8CE;
	Fri,  1 Dec 2023 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mZc/xNrL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F9103
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 15:00:23 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b83c4c5aefso704148b6e.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 15:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701471623; x=1702076423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiMeUGo4nRjMWg2tSlkR0vnsKAPZRTlnUfFXcLKn8aU=;
        b=mZc/xNrLAo0jsIsu8+hajX/824lQS3j3qFh7R42/aErhJP73O4yo72A2NWrhMzM/ZF
         JHSUxAYgdcL733WTFymUaHV/TIxwQZNquM1R681vwj94lxIvPSAAojtQuhHdZI/Gjnzy
         yVQnwekZC66X8ekNfHVgeA1KhLIaluvQDjSwdKARnxnM000KkdXVqIWJTkb0fU9rHgLR
         NkepHN/DraW+bYt1uA5qmtUmTP/vhIyXuzl4Z2hiAtsEPi7VAAPgywS1gdOilI6KS2So
         d6UDTIBqc2yPzv8Y4XAuTg23A+zTcsJT/jHgWL96f2pdfs34GjqZeds7o8cwkVcZ7e2u
         H4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701471623; x=1702076423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiMeUGo4nRjMWg2tSlkR0vnsKAPZRTlnUfFXcLKn8aU=;
        b=rRhLvfGcR6EIvUikhN4N5vqOnaSBIfTBCFLxwRyRrvrNhjBNI2mKMXXln+4z6RleFs
         OViE00+nuHkp288B6RTCwZMaowpszlRLCyyT5ZnecklJGaqOTq0wIrM3mXxkRoi4grfK
         kHaln5y0ap6sV+7NzhSi4xXtM4VGEcaLk1DyVc4770F4JhRgUJBu/REPsh9gKN40Sxzr
         Sa/SPleEMtOG7xFSfPOnG/OoAygHxRHt6RgCAeZnW3TPyS85NlrBiQhah5aoVhePsOV/
         ywKF9codm8tT/pRWViD13/fQ0XMXvJb0h2I4D45PTog4XBH2sQX4e75kt5WhDJj4xekX
         jrQw==
X-Gm-Message-State: AOJu0YwU3KgoE3jYLr9DwbijUhVRoZT25NC7BtOkYvzH6qzBDmAbBcDp
	/M+ds7g7JRyyWzMMnj2Ihg+Caw==
X-Google-Smtp-Source: AGHT+IFRz6VOOv+3ZpYftqpdwhba679PSGq87BHNJCz2YPq7SFA2hq+iHT3TKq4p5ZxuZmR3WwXfLg==
X-Received: by 2002:a05:6808:1247:b0:3b5:84b0:6be6 with SMTP id o7-20020a056808124700b003b584b06be6mr319007oiv.47.1701471622816;
        Fri, 01 Dec 2023 15:00:22 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id y62-20020a62ce41000000b006be0fb89ac3sm3632124pfg.30.2023.12.01.15.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 15:00:22 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net
Cc: dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v2 1/3] net: sched: Move drop_reason to struct tc_skb_cb
Date: Fri,  1 Dec 2023 20:00:09 -0300
Message-ID: <20231201230011.2925305-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231201230011.2925305-1-victor@mojatatu.com>
References: <20231201230011.2925305-1-victor@mojatatu.com>
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
---
 include/net/pkt_cls.h     | 14 ++++++++++++--
 include/net/pkt_sched.h   |  1 +
 include/net/sch_generic.h |  1 -
 net/core/dev.c            |  5 +++--
 net/sched/act_api.c       |  2 +-
 net/sched/cls_api.c       | 23 ++++++++---------------
 6 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a76c9171db0e..7bd7ea511100 100644
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
+tc_skb_cb_drop_reason(const struct sk_buff *skb)
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
index 9fa1d0794dfa..f09bfa1efed0 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -277,6 +277,7 @@ static inline void skb_txtime_consumed(struct sk_buff *skb)
 
 struct tc_skb_cb {
 	struct qdisc_skb_cb qdisc_cb;
+	u32 drop_reason;
 
 	u16 mru;
 	u8 post_ct:1;
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
index 3950ced396b5..323496ca0dc3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3924,14 +3924,15 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 
 	tc_skb_cb(skb)->mru = 0;
 	tc_skb_cb(skb)->post_ct = false;
-	res.drop_reason = *drop_reason;
+	tc_skb_cb(skb)->post_ct = false;
+	tcf_set_drop_reason(skb, *drop_reason);
 
 	mini_qdisc_bstats_cpu_update(miniq, skb);
 	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
 	/* Only tcf related quirks below. */
 	switch (ret) {
 	case TC_ACT_SHOT:
-		*drop_reason = res.drop_reason;
+		*drop_reason = tc_skb_cb_drop_reason(skb);
 		mini_qdisc_qstats_cpu_drop(miniq);
 		break;
 	case TC_ACT_OK:
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c39252d61ebb..12ac05857045 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1098,7 +1098,7 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 			}
 		} else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
 			if (unlikely(!rcu_access_pointer(a->goto_chain))) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 			tcf_action_goto_chain_exec(a, res);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..32457a236d77 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1658,7 +1658,6 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				 int act_index,
 				 u32 *last_executed_chain)
 {
-	u32 orig_reason = res->drop_reason;
 #ifdef CONFIG_NET_CLS_ACT
 	const int max_reclassify_loop = 16;
 	const struct tcf_proto *first_tp;
@@ -1683,13 +1682,13 @@ static inline int __tcf_classify(struct sk_buff *skb,
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
 
@@ -1713,18 +1712,12 @@ static inline int __tcf_classify(struct sk_buff *skb,
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
 
@@ -1736,7 +1729,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
-		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 		return TC_ACT_SHOT;
 	}
 
@@ -1774,7 +1767,7 @@ int tcf_classify(struct sk_buff *skb,
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
 				if (!n) {
-					tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+					tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 					return TC_ACT_SHOT;
 				}
 
@@ -1785,7 +1778,7 @@ int tcf_classify(struct sk_buff *skb,
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
 			if (!fchain) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
@@ -1807,7 +1800,7 @@ int tcf_classify(struct sk_buff *skb,
 
 			ext = tc_skb_ext_alloc(skb);
 			if (WARN_ON_ONCE(!ext)) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
-- 
2.25.1


