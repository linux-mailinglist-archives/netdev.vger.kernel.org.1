Return-Path: <netdev+bounces-240685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08414C77EA9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28FB034AF05
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448A331214;
	Fri, 21 Nov 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOZcOLap"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C42877CD
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713983; cv=none; b=KkaAxJ4SU1zHcte0ttqiKaU3preN8T8BDDZCjaj/4AnPd0xiTcO+ID4qf9GBqSf7phYZP5eLz//BXrvEeC7RTnqsu2mHY4ztnJszrKBq8E+0EYoM3ZdapcgmC5gF5/2rZ43S2D9TWL2cy+MfKssHfLv3LLCx9P+IPxHAoIcx/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713983; c=relaxed/simple;
	bh=lsF5x0qZhc/T/jm/K9WLG5i5mQmyQV8Zv3SZ/loynS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s6FX7q3ARdkcZ1DmI1sY4bapjxKSqMyFv2d7A9oz4hHyynHUDIJdj70FiVtLgj+Rh5HzRqlrKiT/UL8uJGfb+UZxOIrtrHTPcTU6Zix8BxNSQS/wq4sgeot3ZkSiwgIANOAz84cWfA8/77y6W/K1TyBHA4xRH8kVUS17yrqYYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOZcOLap; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b2e41884a0so543940885a.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713980; x=1764318780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S8cor6K0fAhrpa7YH9AFTfqo7LC8TToEeuW7egxztE4=;
        b=vOZcOLap6SYHkN7ePg9RfLe3wKWkoCoNghqCTLwiqVjT/kyEkc7w5xiDymmtZgH9CD
         jgVmyggGAHsK+wtQTtzV2X1nC0BXjLdcZr0sATpymx41ur7/VnKiYDwXF+CxgpxLJL7c
         KcFgnUG1D6CS/AM+vbXc3T6y36TPjpEUGtxRPH+q1BFm9su/2XWxJRuS52DB5DmOiI24
         IR6YUXubcacgnmJypGCSYE/PtrLzpk6VcF3t+LMt1RwgCzAM7nMJaeqQrmd3sKCWkmOo
         rK2fAi0p+fbn69OeGxOL+tIQx2sNV3fP/HPIm9qsuswt7eUZzpXVazSF2Hxni8CK5AKh
         +neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713980; x=1764318780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8cor6K0fAhrpa7YH9AFTfqo7LC8TToEeuW7egxztE4=;
        b=nWsdQkx/KsycHNlj/sVPez8F0sL+Pyne5J2FRQffuWdwxH4NY55gHkM4O9h+siNnZY
         yAYmaeaNNcHoYE3M193YP8Kc/aOsQFQCBieqRQkbgOi4rDZ6HmikzF2KPyWUpYPbHYRI
         asPK+FH9e8OABqxxkTB7U6sdACFE6BiXDc4dt4CDsFq0E2rr7y/42vxlrVxbzYPMuavl
         0DrVTK9WEhuXjeOQJYIva2tZl6gT8s4V+vH0zsVZArODQNQLXgn9Iz6erj0boETYkYwL
         dmx1ePFqi8uRwm4SIqZ7Ifc9kAledKSnBOpXsKW8706tzWm8BkSygn8x5y/KNKMaS/Id
         6ihQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE8ZfGt8J5vCLF2UyjowMVOnDu6DDBW1uypOT0jVZY2hv+ToBNUW5GrPZQlFifXss4uIFE+os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/EXW59zQr3yoM5Rj83xpgT9ANSSjIkANn3S3k+RTopLJVDEAE
	7AXC4x8el59OeNcwRMemd2Ttz0cuFrUnOLl48iav7WRsB2j7f21iBS+qb0qz5+uq3hkBegJY8WQ
	NtWjsNjL1TfZIuA==
X-Google-Smtp-Source: AGHT+IGaap5Ywh95rViycR8AGTxMxN5gCl3A5/YKaS9/803Ra3AemPW6MqsBREDFhfsLrV8oR9vZJxjyoH0Rmw==
X-Received: from qkbee21.prod.google.com ([2002:a05:620a:8015:b0:8b2:4d20:bbb4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7108:b0:8b1:290f:657d with SMTP id af79cd13be357-8b33d49c642mr100816385a.74.1763713980237;
 Fri, 21 Nov 2025 00:33:00 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:43 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-2-edumazet@google.com>
Subject: [PATCH v3 net-next 01/14] net_sched: make room for (struct qdisc_skb_cb)->pkt_segs
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
2.52.0.460.gd25c4c69ec-goog


