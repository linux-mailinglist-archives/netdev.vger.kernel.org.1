Return-Path: <netdev+bounces-57657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3098C813B9C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ABBDB21D0F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF416D1D0;
	Thu, 14 Dec 2023 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="kDV73r85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC146D1CD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d331f12f45so24654745ad.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 12:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702586153; x=1703190953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3Du7TLcaIHyQuqazVUXTM+nO7ErhRIiog6HxAadvGA=;
        b=kDV73r85mqOehIQLZTWle6yQ2rM9BfY71O2UVIe22xolM5fNJTLl5DwEul8eWMCrhb
         4ILr+3dXTRaf5D5WMezS4oWe0LeI7ckgG40SicdjgRHttDS9aNoN/FVveryrHZTArsAN
         ariBQ5YM3SgknGhxwVIztWpeEeQurNr5kAzraj2QFwGGLRuWiodVb5F6RloaJ2DodQKj
         yX6zR3w6EfKJn07tUWavLXXwnP1aBBINzjTkro6OHxaiObEwhhO+FIQ/B9dyC2tAVqEV
         XqF4pcj42KxVG+EsyJJbhUaXxFqtT1MHE1Af3jv9dWGPA/R6x9ZNdrg5uH0n9r+Shs7r
         yEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586153; x=1703190953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3Du7TLcaIHyQuqazVUXTM+nO7ErhRIiog6HxAadvGA=;
        b=PijJ9nbEq/Np+WNzCr2iU0q2bUv1sJsx5HQYGev6PwDaI0vY+F0rBSQ3HdWTXZEtGT
         RSCJKtgfWcmew/aysBRL1pxzJOBJ+RflNBUauJF+KnzIfAU7Z3jcIKPIJi1sJoQTahsZ
         Tza3sIpmuT2u2s5v/Wi/GddmZb+7e+hl3HwreFpsntWTkQaIccHi5YK1z1e8wgikDhOB
         FjJJldOUz9s2kIXdyaHWXiOFIFtSmv+NvMQuL6Y70G147zAFDV4/W3fJ27ub9UFbmunx
         B4vaGZ7F82UsmcoeK/AXqoAR25VJgTzE+TT9bKqlT79ajOE4OfoM/LvXih5f85SxGDsG
         HQ9g==
X-Gm-Message-State: AOJu0YwP/7smqXODO0kofROhfOR//q2FpOyh/6VITRhSjllB7IC5KgIq
	01lJPNiUhRon+4xBOiv7VHv76Q==
X-Google-Smtp-Source: AGHT+IGhY8xMseBpVA4kZedbiVSVprk93IJsPk71XFFzE9Ow4wfFdsYoQqZgOaLrCOrS/s/el0vP6A==
X-Received: by 2002:a17:903:22cb:b0:1d0:6ffe:1e6c with SMTP id y11-20020a17090322cb00b001d06ffe1e6cmr6385661plg.79.1702586153278;
        Thu, 14 Dec 2023 12:35:53 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm12842871plk.171.2023.12.14.12.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:35:52 -0800 (PST)
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
Subject: [PATCH net-next v4 3/3] net: sched: Add initial TC error skb drop reasons
Date: Thu, 14 Dec 2023 17:35:32 -0300
Message-ID: <20231214203532.3594232-4-victor@mojatatu.com>
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

Continue expanding Daniel's patch by adding new skb drop reasons that
are idiosyncratic to TC.

More specifically:

- SKB_DROP_REASON_TC_EXT_COOKIE_ERROR: An error occurred whilst
  processing a tc ext cookie.

- SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed.

- SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify loop
  iterations

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/dropreason-core.h | 18 +++++++++++++++---
 net/sched/act_api.c           |  3 ++-
 net/sched/cls_api.c           | 22 ++++++++++++++--------
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 278e4c7d465c..dea361b3555d 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -85,8 +85,10 @@
 	FN(IPV6_NDISC_BAD_OPTIONS)	\
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
-	FN(TC_ERROR)			\
+	FN(TC_COOKIE_ERROR)		\
 	FN(PACKET_SOCK_ERROR)		\
+	FN(TC_CHAIN_NOTFOUND)		\
+	FN(TC_RECLASSIFY_LOOP)		\
 	FNe(MAX)
 
 /**
@@ -377,13 +379,23 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
 	/** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
 	SKB_DROP_REASON_QUEUE_PURGE,
-	/** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
-	SKB_DROP_REASON_TC_ERROR,
+	/**
+	 * @SKB_DROP_REASON_TC_EXT_COOKIE_ERROR: An error occurred whilst
+	 * processing a tc ext cookie.
+	 */
+	SKB_DROP_REASON_TC_COOKIE_ERROR,
 	/**
 	 * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket errors
 	 * after its filter matches an incoming packet.
 	 */
 	SKB_DROP_REASON_PACKET_SOCK_ERROR,
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
index db500aa9f841..a44c097a880d 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1119,7 +1119,8 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
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
index 199406e4bcdd..8978cf5531d0 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1681,13 +1681,15 @@ static inline int __tcf_classify(struct sk_buff *skb,
 			 */
 			if (unlikely(n->tp != tp || n->tp->chain != n->chain ||
 				     !tp->ops->get_exts)) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_COOKIE_ERROR);
 				return TC_ACT_SHOT;
 			}
 
 			exts = tp->ops->get_exts(tp, n->handle);
 			if (unlikely(!exts || n->exts != exts)) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_COOKIE_ERROR);
 				return TC_ACT_SHOT;
 			}
 
@@ -1716,7 +1718,8 @@ static inline int __tcf_classify(struct sk_buff *skb,
 	}
 
 	if (unlikely(n)) {
-		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb,
+				    SKB_DROP_REASON_TC_COOKIE_ERROR);
 		return TC_ACT_SHOT;
 	}
 
@@ -1728,7 +1731,8 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
-		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb,
+				    SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
 		return TC_ACT_SHOT;
 	}
 
@@ -1766,7 +1770,8 @@ int tcf_classify(struct sk_buff *skb,
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
 				if (!n) {
-					tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+					tcf_set_drop_reason(skb,
+							    SKB_DROP_REASON_TC_COOKIE_ERROR);
 					return TC_ACT_SHOT;
 				}
 
@@ -1777,7 +1782,9 @@ int tcf_classify(struct sk_buff *skb,
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
 			if (!fchain) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_CHAIN_NOTFOUND);
+
 				return TC_ACT_SHOT;
 			}
 
@@ -1799,10 +1806,9 @@ int tcf_classify(struct sk_buff *skb,
 
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


