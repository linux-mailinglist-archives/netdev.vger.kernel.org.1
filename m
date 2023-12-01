Return-Path: <netdev+bounces-53137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E3180173A
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3A41F210A5
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB23F8D1;
	Fri,  1 Dec 2023 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="WxUKOBHw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374CB90
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 15:00:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cdd4aab5f5so2697719b3a.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 15:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701471629; x=1702076429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvNXlJCUre4blvQphhyoImMEr7IPlPMUGpUGsyC1+BQ=;
        b=WxUKOBHwHk5doi92iD9rieD5Q+FzS4MVOxmVAloCx75aWV4me7MyjRVwW+P/ZRrOKg
         c9HkPeexIrj0KjWUJXf2LcaW+HTR2jNtYWoZ5miRA/bO9EQcsfrfo9CM37Jz4YalsJnN
         OrG1L7eaJNRaDuDhSVDCLwW8QW0ugMMqNoDq96HKWKKFaY19hguWeQ2w/BoB4ACbn6BQ
         ItL9r7oX58gMtIlT8MKEea6IRlpyu8SvkrWdQi7xmJNgYRcdyy90RL9TTXdOjhNeuca8
         WbqR+dxx3HkDIMltIEhHQ/gfhwg56L62/+K3SX7/VY0tlmRVN3wytNF3qe30zgMb0kVF
         ZIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701471629; x=1702076429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvNXlJCUre4blvQphhyoImMEr7IPlPMUGpUGsyC1+BQ=;
        b=T25xbB1Ftxm/fKou9p/qJv83mSDWBqeePeICzWVf0016UWYP6pOTEWF2nt0TPcxTO0
         kg7Tsy7gWGKSo9yro/u/lFcQvaaAsw/gx5eo0AiFE0vsbJVIpb4sw3pGXuOQ1D29YWO7
         V7CoJZYl6C2ap6lc3L22hQ4Myq+tqNJZM+zdFmjqPAZq18GBct6MaoTB9VbV26Ifb9T7
         ADIvNHfCklhCigQxd2QI8v8jY9askxPka4GIu9N68RHmyLPV8yB2FhQ0guFhI1ZjF8Et
         KWbq7V8ssqBkwuJ4kgtLho0+pXm5gkC6M1sw2k2fHTyzbRPdMaNT2jtta8dUp6W5q9c3
         eHfQ==
X-Gm-Message-State: AOJu0YwhDF4YCzgADsCG4DaoROUIZPdaxCz5NwXYZUgGEChGcemPdo/s
	Cb5QTFOUXPxDkggs8aUXGIKsfQ==
X-Google-Smtp-Source: AGHT+IGvoEKPZYCb4ZcybHFBNrC4IizCTO6XRNhBOIfaH54aGGXSM/jwYbro2FmAtwu7n4unmn9hgw==
X-Received: by 2002:a05:6a00:b96:b0:68e:4303:edb8 with SMTP id g22-20020a056a000b9600b0068e4303edb8mr444686pfj.30.1701471629619;
        Fri, 01 Dec 2023 15:00:29 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id y62-20020a62ce41000000b006be0fb89ac3sm3632124pfg.30.2023.12.01.15.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 15:00:29 -0800 (PST)
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
Subject: [PATCH net-next v2 3/3] net: sched: Add initial TC error skb drop reasons
Date: Fri,  1 Dec 2023 20:00:11 -0300
Message-ID: <20231201230011.2925305-4-victor@mojatatu.com>
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

Continue expanding Daniel's patch by adding new skb drop reasons that
are idiosyncratic to TC.

More specifically:

- SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND: tc cookie was looked up using
  ext, but was not found.

- SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH: tc ext was looked up using cookie
  and either was not found or different from expected.

- SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed.

- SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify loop
  iterations

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/dropreason-core.h | 30 +++++++++++++++++++++++++++---
 net/sched/act_api.c           |  3 ++-
 net/sched/cls_api.c           | 22 ++++++++++++++--------
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 3c70ad53a49c..fa6ace8f1611 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -85,7 +85,11 @@
 	FN(IPV6_NDISC_BAD_OPTIONS)	\
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
-	FN(TC_ERROR)			\
+	FN(TC_EXT_COOKIE_NOTFOUND)	\
+	FN(TC_COOKIE_EXT_MISMATCH)	\
+	FN(TC_COOKIE_MISMATCH)		\
+	FN(TC_CHAIN_NOTFOUND)		\
+	FN(TC_RECLASSIFY_LOOP)		\
 	FNe(MAX)
 
 /**
@@ -376,8 +380,28 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
 	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
 	SKB_DROP_REASON_QUEUE_PURGE,
-	/** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
-	SKB_DROP_REASON_TC_ERROR,
+	/**
+	 * @SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND: tc cookie was looked up
+	 * using ext, but was not found.
+	 */
+	SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND,
+	/**
+	 * @SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH: tc ext was lookup using
+	 * cookie and either was not found or different from expected.
+	 */
+	SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH,
+	/**
+	 * @SKB_DROP_REASON_TC_COOKIE_MISMATCH: tc cookie available but was
+	 * unable to match to filter.
+	 */
+	SKB_DROP_REASON_TC_COOKIE_MISMATCH,
+	/** @SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed. */
+	SKB_DROP_REASON_TC_CHAIN_NOTFOUND,
+	/**
+	 * @SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify loop
+	 * iterations.
+	 */
+	SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 12ac05857045..429cb232e17b 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1098,7 +1098,8 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 			}
 		} else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
 			if (unlikely(!rcu_access_pointer(a->goto_chain))) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_CHAIN_NOTFOUND);
 				return TC_ACT_SHOT;
 			}
 			tcf_action_goto_chain_exec(a, res);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 32457a236d77..5012fc0a24a1 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1682,13 +1682,15 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			 */
 			if (unlikely(n->tp != tp || n->tp->chain != n->chain ||
 				     !tp->ops->get_exts)) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_COOKIE_MISMATCH);
 				return TC_ACT_SHOT;
 			}
 
 			exts = tp->ops->get_exts(tp, n->handle);
 			if (unlikely(!exts || n->exts != exts)) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH);
 				return TC_ACT_SHOT;
 			}
 
@@ -1717,7 +1719,8 @@ static inline int __tcf_classify(struct sk_buff *skb,
 	}
 
 	if (unlikely(n)) {
-		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb,
+				    SKB_DROP_REASON_TC_COOKIE_MISMATCH);
 		return TC_ACT_SHOT;
 	}
 
@@ -1729,7 +1732,8 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
-		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb,
+				    SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
 		return TC_ACT_SHOT;
 	}
 
@@ -1767,7 +1771,8 @@ int tcf_classify(struct sk_buff *skb,
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
 				if (!n) {
-					tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+					tcf_set_drop_reason(skb,
+							    SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND);
 					return TC_ACT_SHOT;
 				}
 
@@ -1778,7 +1783,9 @@ int tcf_classify(struct sk_buff *skb,
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
 			if (!fchain) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_CHAIN_NOTFOUND);
+
 				return TC_ACT_SHOT;
 			}
 
@@ -1800,10 +1807,9 @@ int tcf_classify(struct sk_buff *skb,
 
 			ext = tc_skb_ext_alloc(skb);
 			if (WARN_ON_ONCE(!ext)) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb, SKB_DROP_REASON_NOMEM);
 				return TC_ACT_SHOT;
 			}
-
 			ext->chain = last_executed_chain;
 			ext->mru = cb->mru;
 			ext->post_ct = cb->post_ct;
-- 
2.25.1


