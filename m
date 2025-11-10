Return-Path: <netdev+bounces-237127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94CC45B38
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0584E82AE
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB83263F38;
	Mon, 10 Nov 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGZBjb+5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D096239086
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767925; cv=none; b=jKg4phwpDsSatca0C5sbmDo09GHyzyrEXeUB7o0+3+S9eKPTbvnYIFChqja70nlB/CxTxS5h893ryLhWD8JOkAM1UssTfCU6+rGeG7N+voSTR8rqu+d0BPUgyMeDJ3DmLTccg+ycm5b7rupizNOwb8CJ9wL87HzXPW4C4ogJgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767925; c=relaxed/simple;
	bh=OD+fuy1S5E28Z+qMdKlpHkOwULtJzFX325d6AbIbp4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R3EtxLsb86KxvykzJIL/pbVDfm6Hj5h8i5DwBcLFn9pBNF+uk9qnJOYIYmmMDdz3SNZyPNmiT9B47ZZxzk2j3IKwvBNd+Joaec7bv/P6DFzEBJmn/acWnbUFa3jx21bcuLyZhXRY6g07ffe7brs60dLcYj4G6/BBMKGrRBC0RAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGZBjb+5; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-882380bead6so52544906d6.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767922; x=1763372722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qF+MfUTbg2jxlm04df/2RJP24hkCgaT+IKEg/PnGNt0=;
        b=SGZBjb+5PVCdohaRuGorAl7jpcaFZeC/vwDHqLqANNKI0MmY9vLg0Spw3GEPkqpxIb
         Dfi8SoK76rRmPeBf8PfmZaA1aqazYotEJqNqR6RVf36NmtsCv9kB32LgVDGP+lslZ0sh
         jzcJz7tw/zScfCefz8qBlAW9FdOrUMOzKXUSeV5SRrd5wuoR2HWjAs0MgQkKj9a6ndf6
         Z0+UXKN6/b0aln2s7V+y7ePHwg9IzyDOU9rzMVXoYDhZWra4L6WEw/Wljj7Ux4cvaEUj
         iPcR6uuBLAsNzoFGF/RtxSz3C6/4Un9EqGKGfIG3Eu2cPsKbTYGSGXh0huRWwaDelxr/
         GOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767922; x=1763372722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qF+MfUTbg2jxlm04df/2RJP24hkCgaT+IKEg/PnGNt0=;
        b=RgfjOvo8UFfvurPLkat/J2iwQ3fj28GLXNV7WpcVtcetObrghogYzF1996UuNUGVU1
         6q0ugYwQa5/zecYwqFdoZ3+EbD5+OfIFcATlY0FaegTJVeB2rScSJ3N6NjqRrrV0R5HB
         GxOPEJEbG7+i9qP5VCsD18vPLz1vPrsbwJwHu3ElyhRsGtMkx7MTdmCxv6dWAPJ6Ka6j
         n0y8Bic/FNjuurb3ua5sTwNRfywINxAwVUuNxpyhQpOhd0mP8SxsuEo1LsRN2LpEoSTh
         tjdNu1/yMbhrEeDQUkohE5RRzR6qA/Jk0Bc/6EnM/A6W1YCcOWHkmf+2ZFzZ4y9Ebrb1
         zlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNI3as36PV94sh7JhbGsg4B7fe8mGHhfNEIpJivYiBmpTTLA5/THBO9ugvumZyiFIQ/PosIOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7yCmsYj3TW5SbQgh0h7cV25tVdgEYxgia8DJ/bdYflta3kQu
	Ars57jBNR4mDaEWP+Mu3a2sBSUvmqf35EsVS8+rafp1Qhe6pwJk1u+Xo4A5h0W6JlAKPSz8BTrS
	5bRrkCrUSIai+1Q==
X-Google-Smtp-Source: AGHT+IHYHVKJXiV9Qsjj6Orbb6xtmgmCvptyX261xAgDjRZR6do0NECYyu+d7DUP5fXsxPmHvVXkYxXDdHxjAw==
X-Received: from qvbri1.prod.google.com ([2002:a05:6214:3301:b0:882:365e:39e7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:242c:b0:880:57b3:cd1b with SMTP id 6a1803df08f44-882385de463mr109828416d6.18.1762767922408;
 Mon, 10 Nov 2025 01:45:22 -0800 (PST)
Date: Mon, 10 Nov 2025 09:44:56 +0000
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-2-edumazet@google.com>
Subject: [PATCH net-next 01/10] net_sched: make room for (struct qdisc_skb_cb)->pkt_segs
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
2.51.2.1041.gc1ab5b90ca-goog


