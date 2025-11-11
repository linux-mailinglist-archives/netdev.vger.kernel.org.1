Return-Path: <netdev+bounces-237520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFABC4CB14
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238C5189636D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7EF2F2617;
	Tue, 11 Nov 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFNrqKFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8D82F2618
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853548; cv=none; b=NxSVFJpxXWoCLcp7L6C4cPagAvC1xEtwkSz3RCXOQY+39FksIgpYSHziQcNEGbyn+XNw50Mp/4jyILIDMG77VQQIKziIz4KzO6cvAAWTZq5WqfjCgNleaKGA6fFMh2Qfpqbo7Zl5uJPoRDF/5BT7ZVtUb2fJlDgFA3kx9K5EAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853548; c=relaxed/simple;
	bh=QW8VhNaqKttycpHFwfku2Kgw+GgIuC6QhFkMlB43eq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pJAYahUluDzw7LQLR+YspV52Af2gm6xcZNKCcoC86DTXrWN8pSzIQb4Ele/wT7vh0i2DwLMNDMaPnb49cJmrKbotYlu498fLHmeKaVoV7j3sG79QpoETr7XnO7QmupE8YNbFCdy55NISWskOqTGKxap/Bqkgr2xGBqx2WfiqDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFNrqKFc; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8824292911cso15835486d6.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853546; x=1763458346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdJufPHVMbx1closdS+e5mPfBn5MsRicx3A6qjV6f70=;
        b=VFNrqKFcS/fo0d5nKClmivYTfC+bkqxFDDCpCyajKgvQ+18u8EDhLojkrhLGDLvCPk
         OdCARlsrA7puXpNzshPMA8YP7RWCiZ649LmI8L8i6/Nib92eTep4WdS9JNDR9CGLvkFt
         WOuCV0XW4MBwnJqrBlNTZ+X7InvAcy+ROYjN3dMzY8TIQQsM+6KnGoVaMgWYNqaDCBnA
         SMVY/mKQlUjexzEuOARUUBhhqspJTWXHHv6aJ4edMsZmKbcsnQKIzqHglVpgl/6f0Cnk
         BN1F6JrlArUXTBbIFN9WgvHOnWJOBZhI5J38X/RTP1/hR9npSf7Us5dW/UoHI1tEhzLZ
         AYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853546; x=1763458346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdJufPHVMbx1closdS+e5mPfBn5MsRicx3A6qjV6f70=;
        b=JlxFKiAIqU8r4eJkWOSKv96Mz+SalIkmRvlr6QwXQyiM1dptKTjy40inKZkHQV2sig
         Z5vcpMWyDG2sIhvdwipmxDQpDzfFCt1+puy6kSsCWA2Xmngq4AlKhT0Mbmx+xB06teDa
         pY4f0gfwQWblChqVod2jRblUr3g5Ew36tepYjddsF1XxSabRWYYum4xQyWOXRRoOTqe2
         dmnMOEv76xVbP4TJbiVeUXrQBBijWnlQO4jKnccvnOfvdy3Qm5/XaI+R/yIpZNfFfHot
         eD3rlQ1wRp+jxlOlzWhjlRWVoozC6yIaNMfM6ObVu33zP6mtv5WpAEE/5Wu5V8VbnSzQ
         Jblw==
X-Forwarded-Encrypted: i=1; AJvYcCVTUG2Ow/fXdhGwWe003bwtTAOLx77sRBSNcoM5AjVBoCeLHCYwZNBoC8mo47Wfe3fyoYrAYww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdf8KekaVe/10ay7Jr17LAIyXl/fs45hPd084FZLZilUQ0SlF
	D3ss+Vqv7Np4EfvRIqUMrkfKfFjFu8K2vG/XlB0lVuVD2orQtMMVHj3LphCjfa1r238xmR2tCGk
	QRJf5UqAmMNw11Q==
X-Google-Smtp-Source: AGHT+IFzcR+0THPJSADfPtKQhRLrDemW8qGJ7dqvBiWliEF1+v6d247hQmHAvvPCz3WlcTOpUkPKx1NZqvOg+w==
X-Received: from qva22.prod.google.com ([2002:a05:6214:8016:b0:882:4912:459f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2029:b0:882:36d6:e5c1 with SMTP id 6a1803df08f44-8825e85717amr35511566d6.29.1762853546383;
 Tue, 11 Nov 2025 01:32:26 -0800 (PST)
Date: Tue, 11 Nov 2025 09:32:03 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-15-edumazet@google.com>
Subject: [PATCH v2 net-next 14/14] net_sched: use qdisc_dequeue_drop() in
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
2.52.0.rc1.455.g30608eb744-goog


