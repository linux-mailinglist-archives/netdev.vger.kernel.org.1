Return-Path: <netdev+bounces-54087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC64805FC3
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C6B2110A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD36A03E;
	Tue,  5 Dec 2023 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xKd0h24w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E2E18B
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 12:50:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfb30ce241so42908455ad.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 12:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701809439; x=1702414239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU7+FfrvT4pqeCkaxCSagKCqZdDGcMPC/KDuWJqlcjE=;
        b=xKd0h24wl4Yob03PaKs1BiUlsfvoeDRl+ThwtrX8eTw5kNo9+pS9JR4zrOyeGnUykY
         h9HDRcRwF58mnymD/rg2Hn0oevHYmgkwun5NHDcXuoLKrlnC0RMx0Hos8IC2FuOekHq8
         Nk1Ac08DcmdS3KSXOXDM+cn2Z5XhbK2scg9F7DEoUc12nW1/lx00dJjv4z8EY6cScONU
         oAglTob4/8k8tvCLw04G9422Vql5ScsbkiO0rEs+KWpfCfIG8XoyMUtfDjX6f2KQI5te
         5Yqm6E7xT1om5WBlYTpOA1ms25ZQhsom+XhxwSUPfel1DY+xZ53SavNZPC6mM1y8IPBd
         fjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701809439; x=1702414239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jU7+FfrvT4pqeCkaxCSagKCqZdDGcMPC/KDuWJqlcjE=;
        b=YQueX44jbYNLWWe305LWbdFqox4iHNfboByePvPaEw5mvbziAyACU4z6gjRAbGZfPQ
         lFcdPOUs/HRXKzugYSLz3fS1YgnW33OTj+e2OKicmQHGP71tLpcg+zcV6Vse3Xsfka3i
         8aUIgLiqf4lGeQBAveKXeeaDG6DgedCdeHraZKnwRgtkAMCG2Ez6WiCKYTFuvgvqfuR7
         IC03lc/RbXzRQ6xLYmItGPNx4eOmoBMpr1AitqeCRhq6WmsL02v2Z2opO5koJ+i2zVcs
         DMko9bGZ1OIji6Crk7W8QEbHQ7OllsFk6tkAV9TpklO+cbdxEKFrz/tkyL2NpJxya+Bo
         CyKg==
X-Gm-Message-State: AOJu0Yzd95rNA1tdKP1JQZ/zFg5v8NayGiZtxDz+7I3M5XKqhdEvCKw4
	C3QOpKI9qN9l/oWCYls4aNxxMnXN2Zs5otmUoqg=
X-Google-Smtp-Source: AGHT+IEY7dLCzx7ee3nOJL0QYg4H8SxyPKl+cVJh1fD0ECUhHGjf4Z2PLacvIUPmkB2S14bvld5IUA==
X-Received: by 2002:a17:903:245:b0:1d0:ab2e:8e8e with SMTP id j5-20020a170903024500b001d0ab2e8e8emr3952664plh.82.1701809439647;
        Tue, 05 Dec 2023 12:50:39 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id iw13-20020a170903044d00b001bf52834696sm8772788plb.207.2023.12.05.12.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 12:50:39 -0800 (PST)
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
Subject: [PATCH net-next v3 1/3] net: sched: Move drop_reason to struct tc_skb_cb
Date: Tue,  5 Dec 2023 17:50:28 -0300
Message-ID: <20231205205030.3119672-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205205030.3119672-1-victor@mojatatu.com>
References: <20231205205030.3119672-1-victor@mojatatu.com>
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
index 1d720fc59161..4b84b72ebae8 100644
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
index abec5c45b5a4..f2b136ce9282 100644
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


