Return-Path: <netdev+bounces-48959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D84C7F02ED
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 21:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B18B280EF0
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 20:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C60111B8;
	Sat, 18 Nov 2023 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="lSmIYeYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01B7D5
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 12:38:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso3074616b3a.1
        for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 12:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700339909; x=1700944709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BH0h9BqIXM1scIo6s3enWyiip53HzVmoI7QyAejJRg=;
        b=lSmIYeYOlPNBnvj6on2dXKoeZVM7lIlEtW+O4+v3PNAJPjjkYrTylKrulhXYhe76o8
         WMXhiGF2EFsRtTqjdaOJ/Y6LI9nrSlzo9w3adtVCFPKOTbMnIJ03faHGm+pqWMN8ssMM
         vj1zK1+xhDNO697Xxv5maqNIc611mUumZTkVpKqsKSqksfq7q0p/pKgyTVQ4b9Ay9k5O
         ahnniJ53CLJz2EpcpZnxDoiUZSUR3jlIqL6T9h8FJdJ1df8Oj7qyRaJmrXsqKkYBwyg0
         6tAciqqMIOu7KfQXQTCIc6oONSn+7xMTdwgJUH6c1PL/LS1Fss0QpMHfKzc9pnQbjHLq
         jHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700339909; x=1700944709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BH0h9BqIXM1scIo6s3enWyiip53HzVmoI7QyAejJRg=;
        b=to7lIGkNL6o/vVXIUIoMPxk9L3ItJJod4YnFeu3Q7GX58AQqtITM/6vLXhwvCfPgV2
         nFgguG6xVYvxkdGxLsD2erA63n85sregTgF42PVmxHjY+N66SZwqkNIM+cew9IcvlZSe
         bePxxA1yASS7Z8BHwbyLHuBjYmwt6cY1Fsfik0E/XjxOSpobNEp4zZTYA0/Q6q4ALg4O
         nCE3OJKuU4jRCgCfXA/+YAgVcOMDdmmYZR4s62/v8pav68729Osr6E4hVOJfeC6T18Mc
         HE7vz+5vqN6dDDfT/wHDJyA4gHuMbEvXhJ6fhqzbqo05Y1vR0t32UpNz0Oau0soy9+Y+
         020w==
X-Gm-Message-State: AOJu0YxRi3L8d6GHa5y2m/3CWXKDcQhq8zcIG3W2C4u6ONma6l5vh9jf
	AWKRom0PKAsPS7nznw17ghdqX8bAXLzXbRkefMfDtQ==
X-Google-Smtp-Source: AGHT+IEjFQ/I42gX5A14AWA4iM0H28hjDDGGfkXo3yPtTlEYS6EoreIEMHiZKMc7LaenwcLmUJSXxg==
X-Received: by 2002:a05:6a21:19a:b0:17a:e981:7fe4 with SMTP id le26-20020a056a21019a00b0017ae9817fe4mr14387727pzb.16.1700339909201;
        Sat, 18 Nov 2023 12:38:29 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c3:b02d:77:2195:4deb:3614])
        by smtp.gmail.com with ESMTPSA id g31-20020a63565f000000b005891f3af36asm3403875pgm.87.2023.11.18.12.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 12:38:28 -0800 (PST)
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
Subject: [PATCH RFC net-next 3/3] net: sched: Add initial TC error skb drop reasons
Date: Sat, 18 Nov 2023 17:37:54 -0300
Message-ID: <20231118203754.2270159-4-victor@mojatatu.com>
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
index 13a04463e18e..2dddabba3e9f 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1683,13 +1683,15 @@ static inline int __tcf_classify(struct sk_buff *skb,
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
 
@@ -1724,7 +1726,8 @@ static inline int __tcf_classify(struct sk_buff *skb,
 	}
 
 	if (unlikely(n)) {
-		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb,
+				    SKB_DROP_REASON_TC_COOKIE_MISMATCH);
 		return TC_ACT_SHOT;
 	}
 
@@ -1736,7 +1739,8 @@ static inline int __tcf_classify(struct sk_buff *skb,
 				       tp->chain->block->index,
 				       tp->prio & 0xffff,
 				       ntohs(tp->protocol));
-		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+		tcf_set_drop_reason(skb,
+				    SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
 		return TC_ACT_SHOT;
 	}
 
@@ -1774,7 +1778,8 @@ int tcf_classify(struct sk_buff *skb,
 				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
 								&act_index);
 				if (!n) {
-					tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+					tcf_set_drop_reason(skb,
+							    SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND);
 					return TC_ACT_SHOT;
 				}
 
@@ -1785,7 +1790,9 @@ int tcf_classify(struct sk_buff *skb,
 
 			fchain = tcf_chain_lookup_rcu(block, chain);
 			if (!fchain) {
-				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
+				tcf_set_drop_reason(skb,
+						    SKB_DROP_REASON_TC_CHAIN_NOTFOUND);
+
 				return TC_ACT_SHOT;
 			}
 
@@ -1807,10 +1814,9 @@ int tcf_classify(struct sk_buff *skb,
 
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


