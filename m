Return-Path: <netdev+bounces-54089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4D5805FC5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704011C210AB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59186A022;
	Tue,  5 Dec 2023 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="lbSYgCJq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CB9181
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 12:50:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2886579d59fso69387a91.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 12:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701809446; x=1702414246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVANgdRDEa+YJZCXYx7mIertr2awDLabYrGi9jshxt8=;
        b=lbSYgCJqnulzL2dUFGxDsa7X8W927VHfIZmcWoEBQ3tcBLybQ7kdbzu0v6gQUIvj8r
         37SP2zKLW7KLOKgv5o9ps56NoDbePFcug5Iioqf9SJI+XbUqhbu999bDqhgWCoat8dKa
         Me1VItXWjS9wxOHQDJcBgaUVeRD+3CcD3t0SSges3WZKf5AbBNMPvC0o0yh1wqHIi8lj
         eA7w+dkN4pr7fIMxiZkuh9e1RoDvBGgPgsC0AS8NUe+5nqT7T53KhqTMpsRaz98LnFWY
         8JJ2a0Etj6p4/7K0qP6bIr+E0XFXWC9MaFZn3DsG+gJSD1quoiTTRBzzlqVUEkWufA9t
         adEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701809446; x=1702414246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVANgdRDEa+YJZCXYx7mIertr2awDLabYrGi9jshxt8=;
        b=Xppu5mH3NG8DK8o5yM11fdP+wQbP3rGOD4W+wf4+tu7lLKBhtnbJtHmpcSZ/7BlYng
         ohDDmKT+SFnlDI86vb4ALTFXVqgcnLaiYNYFDSOmc/A4272xtAs7B3fSRQpCQCnGy2Cu
         VwoXdTG3G5N8ZtDW/1nkSSMFITq5kg+q4gIk10WmVYwF2FRH/2z/7y8jSl7GRHvKDO5J
         CWarzcNRSYu1C/lkl7L8D8lYIYiAUT3ebma3iLZkPG1580Q6LtjcranIl4jAUtau9+28
         M0GuFBq/KCV6ZXjowip2C0danxJhCKsr1815peZ5tp401z7XFaIn4KMyDdAgaUKL3JM9
         zEfQ==
X-Gm-Message-State: AOJu0YwYLCPgrQ+5CnOxP1hK4xTafj/C1+AsVcaVXlrkKaWJxl+JsGPP
	NAwKpyoopMfEMRA0tbuV34AFKQ==
X-Google-Smtp-Source: AGHT+IHLt4SrwwWGW2aZ7I4/HLxgm1mq9RIHmZB5C1UJMMH6/Ga2KPgnmpmbE7FfKSy3mASBbKU+QA==
X-Received: by 2002:a17:90b:3912:b0:285:fc67:6164 with SMTP id ob18-20020a17090b391200b00285fc676164mr1772672pjb.5.1701809446037;
        Tue, 05 Dec 2023 12:50:46 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id iw13-20020a170903044d00b001bf52834696sm8772788plb.207.2023.12.05.12.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 12:50:45 -0800 (PST)
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
Subject: [PATCH net-next v3 3/3] net: sched: Add initial TC error skb drop reasons
Date: Tue,  5 Dec 2023 17:50:30 -0300
Message-ID: <20231205205030.3119672-4-victor@mojatatu.com>
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
index f2b136ce9282..ba5aad9be161 100644
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


