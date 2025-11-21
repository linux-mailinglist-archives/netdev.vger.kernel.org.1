Return-Path: <netdev+bounces-240699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419AC77F51
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 033282D278
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B1A2FCC01;
	Fri, 21 Nov 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDSQcCtc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6A6FBF
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714198; cv=none; b=HZtt3YeE7Udpl3j8DL4EG6QUJ5UoaOoqAhMP47O/uyse+UsN0H1XZDsFXhi3zxCN0avaVedpW1ov0Ny/QjZb5CDLXVYDy4psxDTtX2OCSBxol+9pZ3EdwqkNynI30U/bC75q4RmZVyKemZHYPPy3pbPPj1SNPbMzvCAohE2b8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714198; c=relaxed/simple;
	bh=BGsYfoIXQOo7EBrCA+FKVvoWypNTWbTjqeI+vRCjzio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uAlOwh8wGrOOTPd0KqiUDqjOAtZ3z8xS6G4Bsdz/fjL6jZn3OCO+1gOU4m3d1Q/800obhT2gIvxG3xqcQ0vbzmdRWUAddtECEYaSUTyq+Ql3z2vdBR5y3U01wdKZP9NOH2Bd941TQH5KzNPrQTQYoOSkmhgbGrctqnfKH612rN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDSQcCtc; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b1d8f56e24so510843785a.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763714195; x=1764318995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J4iSXC6NdmEtBlxlmiqyi3eI5X/KgZ5Vd1ugbaI/ieQ=;
        b=TDSQcCtcqxa/Z5E8OMFlD7X4fm7PiKauYWSbVN7/i8n6IOfc2MweSPi7oYlSiSuoDm
         P41U6QHhd/38QnfQKMKtCxcaciC1mvLqaWHSjudByqbo6oX0BLp6HNWu2OzyQ0CITrEY
         X/vMGr/04WO6h5jKgTd5Tvu7RsEL+Yevr/Gb9NkGNThv5Ykc5owqWr22TF8CSeQ7vsmb
         LZpk7DVSRssWIzqQxl3MZ5iEAfWQbK8LEVsrizxKJcyjbR20jmBNS7FtRPPrRUya6nTO
         SlKY3Tos1Palfk7Du6RyQ/gnSZZ4/Z/u3J9tiKWDuzBcpNtD2pDxtajp7/foBIW5oXZ/
         ppig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763714195; x=1764318995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4iSXC6NdmEtBlxlmiqyi3eI5X/KgZ5Vd1ugbaI/ieQ=;
        b=SI19AUGzwX+Xa3NVMyHY1vqtD2TZShK3zrUPaZiqV/+paKX0MaMTkz+A0/qW7yphKc
         e82lQKXkbj//4JIYNKEQ1LttmUwqHWWe6iX3qlJGS6JtVDHvwr6nKjIfMwMBwKPeCbxL
         zhyZZB7dmLYvw836079mRYPMjDUM1CyFf3HcGUB+IGTIJ8aW04VLVA5nulAKoA9NJNnW
         2e3hR6VKRFf3UTGPYO7MI4YDxKO3kSsdtKt5FOxBGidJSpgunxjhI4ViwfnGU3j/HuJk
         yOD694azSJm1FyY1QBLuF8lBhc/fbV+ieIZk+xAo1zGN+qgX8T8rpWxb18F+ZVygTWs+
         2GAA==
X-Forwarded-Encrypted: i=1; AJvYcCU+EIMJs2XRhFe4/Q3vAH1/D/IAcID8Ys+jSb5sMuY5srxFK5BB9TtTQfE3vgkg6CudkK76X6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkh4jp3HptNOrL8nLoOPJ6JpmsXgMXVFbZrDKUZ4pK0wQFJ7F
	1/tlFEAxmgIX03MOW6hO3j3WCZrdBiBvz6z3SVDVfqAEpUbfpVecHyvUFglfA29/EBdOr0Wgeh9
	pA/OK4kazB8Vn8Q==
X-Google-Smtp-Source: AGHT+IGyr5xtYMHADzxbmuU97amgwP0zrAcVSuLUd083MPVCAdpV08IIQbZrkQYbR/YFb9CKPqRDyo5O2MofYw==
X-Received: from qkbef2.prod.google.com ([2002:a05:620a:8082:b0:8b2:d765:51ef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4411:b0:8b2:6121:5aff with SMTP id af79cd13be357-8b33d1e2eb0mr148748185a.8.1763714195473;
 Fri, 21 Nov 2025 00:36:35 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:56 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-15-edumazet@google.com>
Subject: [PATCH v3 net-next 14/14] net_sched: use qdisc_dequeue_drop() in
 cake, codel, fq_codel
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

cake, codel and fq_codel can drop many packets from dequeue().

Use qdisc_dequeue_drop() so that the freeing can happen
outside of the qdisc spinlock scope.

Add TCQ_F_DEQUEUE_DROPS to sch->flags.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_cake.c     | 4 +++-
 net/sched/sch_codel.c    | 4 +++-
 net/sched/sch_fq_codel.c | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 5948a149129c6de041ba949e2e2b5b6b4eb54166..0ea9440f68c60ab69e9dd889b225c1a171199787 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2183,7 +2183,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		b->tin_dropped++;
 		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 		qdisc_qstats_drop(sch);
-		kfree_skb_reason(skb, reason);
+		qdisc_dequeue_drop(sch, skb, reason);
 		if (q->rate_flags & CAKE_FLAG_INGRESS)
 			goto retry;
 	}
@@ -2724,6 +2724,8 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	int i, j, err;
 
 	sch->limit = 10240;
+	sch->flags |= TCQ_F_DEQUEUE_DROPS;
+
 	q->tin_mode = CAKE_DIFFSERV_DIFFSERV3;
 	q->flow_mode  = CAKE_FLOW_TRIPLE;
 
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index fa0314679e434a4f84a128e8330bb92743c3d66a..c6551578f1cf8d332ca20ea062e858ffb437966a 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -52,7 +52,7 @@ static void drop_func(struct sk_buff *skb, void *ctx)
 {
 	struct Qdisc *sch = ctx;
 
-	kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_CONGESTED);
+	qdisc_dequeue_drop(sch, skb, SKB_DROP_REASON_QDISC_CONGESTED);
 	qdisc_qstats_drop(sch);
 }
 
@@ -182,6 +182,8 @@ static int codel_init(struct Qdisc *sch, struct nlattr *opt,
 	else
 		sch->flags &= ~TCQ_F_CAN_BYPASS;
 
+	sch->flags |= TCQ_F_DEQUEUE_DROPS;
+
 	return 0;
 }
 
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index a141423929394d7ebe127aa328dcf13ae67b3d56..dc187c7f06b10d8fd4191ead82e6a60133fff09d 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -275,7 +275,7 @@ static void drop_func(struct sk_buff *skb, void *ctx)
 {
 	struct Qdisc *sch = ctx;
 
-	kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_CONGESTED);
+	qdisc_dequeue_drop(sch, skb, SKB_DROP_REASON_QDISC_CONGESTED);
 	qdisc_qstats_drop(sch);
 }
 
@@ -519,6 +519,9 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt,
 		sch->flags |= TCQ_F_CAN_BYPASS;
 	else
 		sch->flags &= ~TCQ_F_CAN_BYPASS;
+
+	sch->flags |= TCQ_F_DEQUEUE_DROPS;
+
 	return 0;
 
 alloc_failure:
-- 
2.52.0.460.gd25c4c69ec-goog


