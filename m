Return-Path: <netdev+bounces-237508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D313C4CACC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8BF2347705
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3332ED168;
	Tue, 11 Nov 2025 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0NirXKNJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB12F1FD7
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853529; cv=none; b=YwlmGtZytWFHr+FmRNd2eg59aFtiOrqP899zoYCTOOPCeWw5/IZU8aHXoDHVJSKVzWlgKRXM0SO3fl2vtkaXHbDMZpjzkHPYdbtcgT1/+301Ni8jmA0IWODvAqwBwcUAnNWE3dT3EPz52fyUKq6bL4b7HUEj/UPvepj4Mu+2YpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853529; c=relaxed/simple;
	bh=igH0ZiG7WLdmEZxIyd83kXiMTygPQxsRo0qkkiz77HU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QT1VL42S9nlas+E4s9a2ycoLx7FF75aKJAPpTXV6ssusk3Boxypl2ETgUHSWDNtcqxWywfqaTCvx6e84vGJTYbbKcHZNmtqKIjfJQBpACvawnU6lrkRj0KJLLc3Rjn9crJ8Z//b0jojooA0K0C1f3DWQNS+9SQhN++baQE+AMsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0NirXKNJ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4edd678b2a3so536641cf.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853527; x=1763458327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nerSlMICnpfIVupvtaXWUtQG6jSnO7x2mwtBtl5h+pA=;
        b=0NirXKNJ3YA5njxJ7sh95xLWDw65eH4RvovAPSKv3k14LHvPK201fh6O/HfNTAppZr
         uacxOFZUiyfhEiJWOt58JxssQKmZTI/jEAZucNLTh2DWleIcwrcGolj3uHTsK00S5J++
         0iJPMYyLfjM97tR+ojOL5pPK5flrCQsgrp0VwkUM7z8y07qkjRlktA9Km+RvnC4AyLKu
         B8MBs+PapFiJsVVphwUL15v8+1ShctANzMUwDZnnP56oaddSpswrUDxxt/9duUYy9sw0
         50DUD4xRh2vuiWkUH9z5HLqbBTq/3mYItJjH9KjlHr8KrkDJVRyFjFscJhXZd57ZcVwp
         0GBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853527; x=1763458327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nerSlMICnpfIVupvtaXWUtQG6jSnO7x2mwtBtl5h+pA=;
        b=UPd08aPNrGVqrmokISoYIrbbMC5Vf4QTyq0MpJ7N16HouvdsZGuKTgH3TSdwaTwzL8
         95L0XbZ/tf4QKXgWlPOB7W65c2s8Os23Yuu7RnDqUpxftskAYgAOdhguITAYStCjahTl
         7OVDhDS1KWe/FkeeN6m3Ftap/Y3oa8EiC9xu+BbdI8KQxuEFKtVxr8iFhRV1+LXDugAI
         WGi7QbILCPmYerf0JZ/oXlSBNHtWPMzv85aJCvGzMBt52I2WRUG04GEc2sn+oZJFO+pX
         03rtgM/UOUQ2Cz/ifoWjbCdGW3n6xwfR9K+2JQDaTgmO/QnxaRReFBe/wzaoVdfcFV6L
         pOwA==
X-Forwarded-Encrypted: i=1; AJvYcCVGBhfWVzItsBrGEiE51AvnueoJCK//I2IrS2SfVbiE99F8CLlX4X6LfBiIsx9B3kRqdTdup9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYuByHfNnHbRkYTcSyYvSs9yi4F3y+jBHSIUxFi8pSWoWGffa
	V9TrGeduAGHxOcCauqw7maXnSkhlECy8o/FxTSbaQjBQ1ragMDW/wrPIK98X1cnWflvpgJ4lkRB
	51hl6Q9GKIF0gkg==
X-Google-Smtp-Source: AGHT+IEQENAUqBI5o6dToUlfFOCpbXmInltizVXiPq40cC5xI3e/4SAzQ+ZDFS3C8+nvtQBelbHHQ6Ak1AcT7w==
X-Received: from qvkj18.prod.google.com ([2002:a0c:e012:0:b0:87c:c1d:5db7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2d6:b0:4ed:8264:91ba with SMTP id d75a77b69052e-4eda4fa9a73mr154563691cf.58.1762853526950;
 Tue, 11 Nov 2025 01:32:06 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:50 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-2-edumazet@google.com>
Subject: [PATCH v2 net-next 01/14] net_sched: make room for (struct qdisc_skb_cb)->pkt_segs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new u16 field, next to pkt_len : pkt_segs

This will cache shinfo->gso_segs to speed up qdisc deqeue().

Move slave_dev_queue_mapping at the end of qdisc_skb_cb,
and move three bits from tc_skb_cb :
- post_ct
- post_ct_snat
- post_ct_dnat

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 18 +++++++++---------
 net/core/dev.c            |  2 +-
 net/sched/act_ct.c        |  8 ++++----
 net/sched/cls_api.c       |  6 +++---
 net/sched/cls_flower.c    |  2 +-
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 94966692ccdf51db085c236319705aecba8c30cf..9cd8b5d4b23698fd8959ef40c303468e31c1d4af 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -429,13 +429,16 @@ struct tcf_proto {
 };
 
 struct qdisc_skb_cb {
-	struct {
-		unsigned int		pkt_len;
-		u16			slave_dev_queue_mapping;
-		u16			tc_classid;
-	};
+	unsigned int		pkt_len;
+	u16			pkt_segs;
+	u16			tc_classid;
 #define QDISC_CB_PRIV_LEN 20
 	unsigned char		data[QDISC_CB_PRIV_LEN];
+
+	u16			slave_dev_queue_mapping;
+	u8			post_ct:1;
+	u8			post_ct_snat:1;
+	u8			post_ct_dnat:1;
 };
 
 typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);
@@ -1064,11 +1067,8 @@ struct tc_skb_cb {
 	struct qdisc_skb_cb qdisc_cb;
 	u32 drop_reason;
 
-	u16 zone; /* Only valid if post_ct = true */
+	u16 zone; /* Only valid if qdisc_skb_cb(skb)->post_ct = true */
 	u16 mru;
-	u8 post_ct:1;
-	u8 post_ct_snat:1;
-	u8 post_ct_dnat:1;
 };
 
 static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
diff --git a/net/core/dev.c b/net/core/dev.c
index 69515edd17bc6a157046f31b3dd343a59ae192ab..46ce6c6107805132b1322128e86634eca91e3340 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4355,7 +4355,7 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
 		return ret;
 
 	tc_skb_cb(skb)->mru = 0;
-	tc_skb_cb(skb)->post_ct = false;
+	qdisc_skb_cb(skb)->post_ct = false;
 	tcf_set_drop_reason(skb, *drop_reason);
 
 	mini_qdisc_bstats_cpu_update(miniq, skb);
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 6749a4a9a9cd0a43897fcd20d228721ce057cb88..2b6ac7069dc168da2c534bddc5d4398e5e7a18c4 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -948,9 +948,9 @@ static int tcf_ct_act_nat(struct sk_buff *skb,
 		return err & NF_VERDICT_MASK;
 
 	if (action & BIT(NF_NAT_MANIP_SRC))
-		tc_skb_cb(skb)->post_ct_snat = 1;
+		qdisc_skb_cb(skb)->post_ct_snat = 1;
 	if (action & BIT(NF_NAT_MANIP_DST))
-		tc_skb_cb(skb)->post_ct_dnat = 1;
+		qdisc_skb_cb(skb)->post_ct_dnat = 1;
 
 	return err;
 #else
@@ -986,7 +986,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	tcf_action_update_bstats(&c->common, skb);
 
 	if (clear) {
-		tc_skb_cb(skb)->post_ct = false;
+		qdisc_skb_cb(skb)->post_ct = false;
 		ct = nf_ct_get(skb, &ctinfo);
 		if (ct) {
 			nf_ct_put(ct);
@@ -1097,7 +1097,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 out_push:
 	skb_push_rcsum(skb, nh_ofs);
 
-	tc_skb_cb(skb)->post_ct = true;
+	qdisc_skb_cb(skb)->post_ct = true;
 	tc_skb_cb(skb)->zone = p->zone;
 out_clear:
 	if (defrag)
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index f751cd5eeac8d72b4c4d138f45d25a8ba62fb1bd..ebca4b926dcf76daa3abb8ffe221503e33de30e3 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1872,9 +1872,9 @@ int tcf_classify(struct sk_buff *skb,
 			}
 			ext->chain = last_executed_chain;
 			ext->mru = cb->mru;
-			ext->post_ct = cb->post_ct;
-			ext->post_ct_snat = cb->post_ct_snat;
-			ext->post_ct_dnat = cb->post_ct_dnat;
+			ext->post_ct = qdisc_skb_cb(skb)->post_ct;
+			ext->post_ct_snat = qdisc_skb_cb(skb)->post_ct_snat;
+			ext->post_ct_dnat = qdisc_skb_cb(skb)->post_ct_dnat;
 			ext->zone = cb->zone;
 		}
 	}
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 099ff6a3e1f516a50cfac578666f6d5f4fbe8f29..7669371c1354c27ede83c2c83aaea5c0402e6552 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -326,7 +326,7 @@ TC_INDIRECT_SCOPE int fl_classify(struct sk_buff *skb,
 				  struct tcf_result *res)
 {
 	struct cls_fl_head *head = rcu_dereference_bh(tp->root);
-	bool post_ct = tc_skb_cb(skb)->post_ct;
+	bool post_ct = qdisc_skb_cb(skb)->post_ct;
 	u16 zone = tc_skb_cb(skb)->zone;
 	struct fl_flow_key skb_key;
 	struct fl_flow_mask *mask;
-- 
2.52.0.rc1.455.g30608eb744-goog


