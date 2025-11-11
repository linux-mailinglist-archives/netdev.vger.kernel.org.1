Return-Path: <netdev+bounces-237511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C1C4CBE6
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93F13B18D6
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67122F39C9;
	Tue, 11 Nov 2025 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLmwzZRb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61F2F0686
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853535; cv=none; b=Adt5CHnagdIIoDFIRT5bT2y1fP56+LlcGDWrjyqdMqUC9a6VjWZSJq5ej7JbPpMPcsXTKP7OCNQPo+4EUV7r4drHCNwrqvQPyNYw2YBVoO9ajB11z7Aj/1vw9PzLXr8phPPZLlvFGrYylpNCbrIdiUyjO09ASeq9y6MbTuErPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853535; c=relaxed/simple;
	bh=OFouXx7gqm08wENzxgOyKPAhwsHlbyth0hPxgsXt+Hw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GbKO/anISLvlx8XQ+QOG0aIicuzqQpO1cemmYXg2GG4pV9pYnzLfe93Z90t6a2d9je1AVfOG0O00ZGHpSZCyhv+ou4lnPg4tCEaMDrAtGp+wHxD9YisXnmZ/52QR+aAnDhJCVnMjOUpHPlFQY516TcGP5nq9JBUTS5Vz2iz3wA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLmwzZRb; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8803f43073bso132309416d6.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853533; x=1763458333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpcQa21S+2ceym36PecRTSwNXIuUKo5LDl0vfjjPEG0=;
        b=fLmwzZRbfNuNKkfxOHfKMRY9Olqn+hN+ABimwAqKycijxXnTh7HVv/S0tLpgZwX7OI
         dMyP5YrzyvCcWhDg8GCmZQNTCpBio2z2rRWcW4aPlO0+8kUHp819GWIjmMG0yv2dzoAl
         5lwY8PByENZ8kPD7H6SXMr9isRW64qHvS0Fd8NMWYgkcik9US3jPiso472GsLh0wjoIK
         tv/dvHFl3pbwXfqw6jvw2XWeQyIH7U6rNvqEc//P10/o33k03Szqeb7+HdAT6ZwJsfV4
         UTivFoyQsLlQm342tSSzYyNrOyDgbIyUNtLiIn1OjvraKMBtWmUG5qJriqZDCap8HU6C
         VTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853533; x=1763458333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpcQa21S+2ceym36PecRTSwNXIuUKo5LDl0vfjjPEG0=;
        b=eK5AKpivPbqVsMJQyiKLImyrk0CUIN0sOhWDLrUlYXN+zSzPc78NnuQfz5oeJ9wGdg
         UakE1swkE7YcQwJRypDdeJ9dg5HIKs1bPtt97XL+9HmicP3zDTMkIkkzLsa+reE6aR1R
         rrZ7ByhI0mfyrO9XHITWWJL/HqcWhX1aY1Yr/VMWLmVgqxdXQDf1RSVtEraOfZi49nXQ
         ObUxCuGxcqgfFNLGUVPpBJmx4fCuTXpiCtzKoWyX4sB0grKebNcfgTsq0NPaWuoKxKFE
         EK6pKHIO/PKd5ECpRMtMaty95wWNxwzB8AGjOqfzfSYHHcaE1l1NypYfB49QOCF/ICKN
         BOVg==
X-Forwarded-Encrypted: i=1; AJvYcCUfwxkRnNTfiEq5aQwqEZH1AU0IvmuR9WjhWMdWvRlMbYN0VwzrPTCIvObAcb6LWE0Q9/wbe/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Tfe/8g6/7o6wKucaPN3u5yAXTSgz1RwJUSigsK+qIPzz+prS
	bKcRYSp+0TprPRv+C++QJvEHNTOCC8f3Xw0GP3GFgqgHWk5dPRAoUBCKt0Q/JbZMjrzE760AOEh
	2dsbXOjPI5S9EbQ==
X-Google-Smtp-Source: AGHT+IHPZqoYA3DvnoVCMFxgf2yYHl1xcWnLljoiv3kTorZy86zBufMQwgKzedSrelsJXiGxlVNqtirSe8/mcw==
X-Received: from qvbqv3.prod.google.com ([2002:a05:6214:4783:b0:880:4a81:f747])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5b8e:0:b0:880:54e2:3517 with SMTP id 6a1803df08f44-882385cff37mr152509336d6.12.1762853532685;
 Tue, 11 Nov 2025 01:32:12 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:54 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/14] net_sched: use qdisc_skb_cb(skb)->pkt_segs
 in bstats_update()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid up to two cache line misses in qdisc dequeue() to fetch
skb_shinfo(skb)->gso_segs/gso_size while qdisc spinlock is held.

This gives a 5 % improvement in a TX intensive workload.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 13 ++++++++++---
 net/sched/sch_cake.c      |  1 +
 net/sched/sch_dualpi2.c   |  1 +
 net/sched/sch_netem.c     |  1 +
 net/sched/sch_qfq.c       |  2 +-
 net/sched/sch_taprio.c    |  1 +
 net/sched/sch_tbf.c       |  1 +
 7 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 9cd8b5d4b23698fd8959ef40c303468e31c1d4af..cdf7a58ebcf5ef2b5f8b76eb6fbe92d5f0e07899 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -829,6 +829,15 @@ static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)
 	return qdisc_skb_cb(skb)->pkt_len;
 }
 
+static inline unsigned int qdisc_pkt_segs(const struct sk_buff *skb)
+{
+	u32 pkt_segs = qdisc_skb_cb(skb)->pkt_segs;
+
+	DEBUG_NET_WARN_ON_ONCE(pkt_segs !=
+			(skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1));
+	return pkt_segs;
+}
+
 /* additional qdisc xmit flags (NET_XMIT_MASK in linux/netdevice.h) */
 enum net_xmit_qdisc_t {
 	__NET_XMIT_STOLEN = 0x00010000,
@@ -870,9 +879,7 @@ static inline void _bstats_update(struct gnet_stats_basic_sync *bstats,
 static inline void bstats_update(struct gnet_stats_basic_sync *bstats,
 				 const struct sk_buff *skb)
 {
-	_bstats_update(bstats,
-		       qdisc_pkt_len(skb),
-		       skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1);
+	_bstats_update(bstats, qdisc_pkt_len(skb), qdisc_pkt_segs(skb));
 }
 
 static inline void qdisc_bstats_cpu_update(struct Qdisc *sch,
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 9213129f0de10bc67ce418f77c36fed2581f3781..a20880034aa5eacec0c25977406104448b336397 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1800,6 +1800,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		skb_list_walk_safe(segs, segs, nskb) {
 			skb_mark_not_on_list(segs);
 			qdisc_skb_cb(segs)->pkt_len = segs->len;
+			qdisc_skb_cb(segs)->pkt_segs = 1;
 			cobalt_set_enqueue_time(segs, now);
 			get_cobalt_cb(segs)->adjusted_len = cake_overhead(q,
 									  segs);
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4b975feb52b1f3d3b37b31713d1477de5f5806d9..6d7e6389758dc8e645b1116efe4e11fb7290ac86 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -475,6 +475,7 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 * (3) Enqueue fragment & set ts in dualpi2_enqueue_skb
 			 */
 			qdisc_skb_cb(nskb)->pkt_len = nskb->len;
+			qdisc_skb_cb(nskb)->pkt_segs = 1;
 			dualpi2_skb_cb(nskb)->classified =
 				dualpi2_skb_cb(skb)->classified;
 			dualpi2_skb_cb(nskb)->ect = dualpi2_skb_cb(skb)->ect;
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index eafc316ae319e3f8c23b0cb0c58fdf54be102213..32a5f33040461f3be952055c097b5f2fe760a858 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -429,6 +429,7 @@ static struct sk_buff *netem_segment(struct sk_buff *skb, struct Qdisc *sch,
 	struct sk_buff *segs;
 	netdev_features_t features = netif_skb_features(skb);
 
+	qdisc_skb_cb(skb)->pkt_segs = 1;
 	segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
 
 	if (IS_ERR_OR_NULL(segs)) {
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 2255355e51d350eded4549c1584b60d4d9b00fff..d920f57dc6d7659c510a98956c6dd2ed9e5ee5b8 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1250,7 +1250,7 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		}
 	}
 
-	gso_segs = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
+	gso_segs = qdisc_pkt_segs(skb);
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		pr_debug("qfq_enqueue: enqueue failed %d\n", err);
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 39b735386996eb59712a1fc28f7bb903ec1b2220..300d577b328699eb42d2b829ecfc76464fd7b186 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -595,6 +595,7 @@ static int taprio_enqueue_segmented(struct sk_buff *skb, struct Qdisc *sch,
 	skb_list_walk_safe(segs, segs, nskb) {
 		skb_mark_not_on_list(segs);
 		qdisc_skb_cb(segs)->pkt_len = segs->len;
+		qdisc_skb_cb(segs)->pkt_segs = 1;
 		slen += segs->len;
 
 		/* FIXME: we should be segmenting to a smaller size
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index 4c977f049670a600eafd219c898e5f29597be2c1..f2340164f579a25431979e12ec3d23ab828edd16 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -221,6 +221,7 @@ static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
 		skb_mark_not_on_list(segs);
 		seg_len = segs->len;
 		qdisc_skb_cb(segs)->pkt_len = seg_len;
+		qdisc_skb_cb(segs)->pkt_segs = 1;
 		ret = qdisc_enqueue(segs, q->qdisc, to_free);
 		if (ret != NET_XMIT_SUCCESS) {
 			if (net_xmit_drop_count(ret))
-- 
2.52.0.rc1.455.g30608eb744-goog


