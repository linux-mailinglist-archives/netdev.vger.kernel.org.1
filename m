Return-Path: <netdev+bounces-48957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBF7F02EB
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 21:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F7B1F225F3
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 20:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B035A125CD;
	Sat, 18 Nov 2023 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0HpD/vsw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E034DC5
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 12:38:23 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso2783060b3a.3
        for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 12:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700339903; x=1700944703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DRBRsuYSe8GiQqSl23qJvxzf8oMDFUuuf3/1QCpP2I=;
        b=0HpD/vsw+ttjmdiMYXGk0fC5um+c+tw7r/rCxtVJD8Z7hlI9/hM/7cRq+MyOFOI4/G
         RWp5YKrbi1FqcJksymnFzgzOTdzDS+yxSq9nwtpjHVFYM/lEqP+15XyOMuZXxWI2G5Jq
         UP69nFR4wmfn34PnONXJqw3fBPKrdqTQSe03lG/hwAKv4MdDPJvvyp2b+yLeNDiYhGy1
         W903OXnIix4UGvm+mdkp8rcdWRHLalfscglsI35yYH1QDNuM9U62I8pHgQ1Wla/yc/7m
         aFp93cGeQ1INrfJrNykQ3I5j1TyYvlGH+XliZSzGsSrzbVkz/PzahuV2P9cWlcF+iKVz
         0f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700339903; x=1700944703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DRBRsuYSe8GiQqSl23qJvxzf8oMDFUuuf3/1QCpP2I=;
        b=w9Uj+iiVkd4UtT3zbqUuCygTdkGcJ4jFmh4eTyF45nZDE/StvgxiR6JOoX1q/p2E01
         PtCI7hGecEQWsubKQgPijQbIyr4FJtdQO3Ap3w7JAuZmmVhYwPxlkmOOGBPeewZWNePF
         Wjezq/VWqkMeBDiiMu4gAynoPRWY4ygftYYn2Y5kp6QybWA9WxxURe+CoXbJXE84s2Cn
         yvXgqPwbTYeD5UZYClMCc4O3UTWpG5nbnmOsuEjHrX4792/mHgTbDKhl2wUWtDsliDJw
         ceGMODZwu02szCa/zLKjQMgDARgVi7LhnX3P1ccFtU0rDpyJKalQJEzss23/CRCo8Dqr
         P4WQ==
X-Gm-Message-State: AOJu0YzmGOZEiiozWZ/TegLHVbq2M6Ad973QmE0/EzJA9KR533cg4qKf
	wWM/tlHe5gcWKoUPzgziOD9LEQ==
X-Google-Smtp-Source: AGHT+IE0GF5ywV1LKlzG46IErkUZ3O3YwC319W1H3vRFuLMxSVTZ4nHn8ztB5OEu4eWZXgyuJDrDrQ==
X-Received: by 2002:a05:6a00:84a:b0:6bd:f760:6ab1 with SMTP id q10-20020a056a00084a00b006bdf7606ab1mr3122765pfk.14.1700339903327;
        Sat, 18 Nov 2023 12:38:23 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c3:b02d:77:2195:4deb:3614])
        by smtp.gmail.com with ESMTPSA id g31-20020a63565f000000b005891f3af36asm3403875pgm.87.2023.11.18.12.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 12:38:23 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net
Cc: netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH RFC net-next 1/3] net: sched: Move drop_reason to struct tc_skb_cb
Date: Sat, 18 Nov 2023 17:37:52 -0300
Message-ID: <20231118203754.2270159-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231118203754.2270159-1-victor@mojatatu.com>
References: <20231118203754.2270159-1-victor@mojatatu.com>
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
 net/core/dev.c            |  4 ++--
 net/sched/act_api.c       |  2 +-
 net/sched/cls_api.c       | 20 ++++++++++----------
 6 files changed, 26 insertions(+), 16 deletions(-)

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
index 05ce00632892..eb39e9f80428 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3924,14 +3924,14 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 
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
index 1976bd163986..13a04463e18e 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1658,7 +1658,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				 int act_index,
 				 u32 *last_executed_chain)
 {
-	u32 orig_reason = res->drop_reason;
+	u32 orig_reason = tc_skb_cb_drop_reason(skb);
 #ifdef CONFIG_NET_CLS_ACT
 	const int max_reclassify_loop = 16;
 	const struct tcf_proto *first_tp;
@@ -1683,13 +1683,13 @@ static inline int __tcf_classify(struct sk_buff *skb,
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
 
@@ -1717,14 +1717,14 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			/* Policy drop or drop reason is over-written by
 			 * classifiers with a bogus value(0) */
 			if (err == TC_ACT_SHOT &&
-			    res->drop_reason == SKB_NOT_DROPPED_YET)
-				tcf_set_drop_reason(res, orig_reason);
+			    tc_skb_cb_drop_reason(skb) == SKB_NOT_DROPPED_YET)
+				tcf_set_drop_reason(skb, orig_reason);
 			return err;
 		}
 	}
 
 	if (unlikely(n)) {
-		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 		return TC_ACT_SHOT;
 	}
 
@@ -1736,7 +1736,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
-		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 		return TC_ACT_SHOT;
 	}
 
@@ -1774,7 +1774,7 @@ int tcf_classify(struct sk_buff *skb,
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
 				if (!n) {
-					tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+					tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 					return TC_ACT_SHOT;
 				}
 
@@ -1785,7 +1785,7 @@ int tcf_classify(struct sk_buff *skb,
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
 			if (!fchain) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
@@ -1807,7 +1807,7 @@ int tcf_classify(struct sk_buff *skb,
 
 			ext = tc_skb_ext_alloc(skb);
 			if (WARN_ON_ONCE(!ext)) {
-				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
 				return TC_ACT_SHOT;
 			}
 
-- 
2.25.1


