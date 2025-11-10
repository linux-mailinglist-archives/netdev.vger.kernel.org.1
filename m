Return-Path: <netdev+bounces-237130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13887C45B44
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6D2A4E9D31
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA47301711;
	Mon, 10 Nov 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9j+NJ74"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A1301464
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767930; cv=none; b=CdyujInoCD3P2aD7exAURi6lSTYGUai/XibYzOnPrmUZ7bubWKOoCS0IvJPynyD25OleTRHDHjioykRZ7KprdEfjf6er+X8bkWK9QXwxVJ4hWRH2tlYNayPNN39m+Vt2kYF1YHx0fT8kRMNw7CcCj9UlBaBbdPCCqmZixwJuLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767930; c=relaxed/simple;
	bh=q4q0IsVfMuvaphUNYThkAUuQdIirzVYHMB4xt1P9PpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nPBkm3Zu2n4zRD8TeDmyX/zMYMpsz05FRabTfnReus4UpB2HWzruCedcyvXFsV0zlaBPe00k4EIJt2D3kWt2oo0VYGB0QKFEnBr16T0THK3jbQCNAT3GYYXn1lGyxvTx0p441oBNQr0O8sqtuJRm5X85Kc0ILmdPQt2WEHkq8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9j+NJ74; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8904a9e94ebso22876185a.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767927; x=1763372727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfgDLhGAMbtuhThMAu5zShZC6IqMFqpLucSmJvN0478=;
        b=m9j+NJ74+9JlwG1Gl319bvPsXMIdbO4jdc++tp4+KYj7iKKKxuulFss/mvp/dWBZrX
         UhXtAXyLP2wOe6rlBmeg4rfFRO93EeUfV55Q+eGI3nHbdXBh6CdcA7okJUA+8vDmdkeS
         +xKkrWthEMT8smGtfDFS7KbueyHozhejuSnLgMLnxsU/CIJbXQ0rnYHqskFE60LhlnsV
         AZZG4Ot1V5K05/AjyP9Eg1cujGaCs2ZYw8HLtMpgV8MjHHRt/rcZjtMavZs8v+rtK6Ad
         foFZvbjP95fOhyWVRexLxVfZbI0jjFp6AhURhpKVbSVk2PqpWhtnE6rstwlsrvX+ELmw
         yO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767927; x=1763372727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfgDLhGAMbtuhThMAu5zShZC6IqMFqpLucSmJvN0478=;
        b=psOF95VZ2h98fTwd+MI7FvfEq857KYikJvlC1cfew9y0lLfVZj45rRBy+SirqpRKAh
         O/5h4czDSIR0HwxG4IknM/L8J0qajk61WGH6KqwtoC/53lQz/qx84rzJCXcsYNsK6UZN
         w6dObN3l/GMg2svRMKU2P5MxB2u4oDoLulG2qCdY3Y+WSzytIcZPlLRK+ovESusDXXH0
         xwfw1aTZGk21/eIu4r1RAYYL+/mFuJoRgWDQTpsx6frjtXvNDc1n3Ded/a78Oe82AbeS
         28dj6fKfdb8K8Lww8W1SfBRvUyJSaQhUC0/KZUEFGTafpUmjR28UlyPESvFkQdwPm8+e
         YR5w==
X-Forwarded-Encrypted: i=1; AJvYcCVVDuIdLfO2r1Y0UImj1zjRwJjFV/5RK2Ef069K7YQYBkljuHKumtMtUn/LeDqnaxyx1HXzWe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6tWZK3mHgzjpD8a3+BhT9rxi67tj8I84ucooHf3h9brFpiXM
	p5CY39YERnalQKVpf50sp5FriaoyuvO/oyXQgvAg9NK0v5uhAGqJt5rHIonh7FBWwhIfV7fV3bo
	67V5yhUUX1LPUKw==
X-Google-Smtp-Source: AGHT+IFvxIV5JMwm25z1Gw4v4ehdowiFOisppfHx4n+f5aOM3w5et37Jk189wv5V4QXG6IQRyuCgLAn8V3QtIg==
X-Received: from qkbdz18.prod.google.com ([2002:a05:620a:2b92:b0:89f:85cb:4a4d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3792:b0:8b1:2853:673f with SMTP id af79cd13be357-8b257ef95a5mr642294085a.15.1762767927429;
 Mon, 10 Nov 2025 01:45:27 -0800 (PST)
Date: Mon, 10 Nov 2025 09:44:59 +0000
In-Reply-To: <20251110094505.3335073-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110094505.3335073-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-5-edumazet@google.com>
Subject: [PATCH net-next 04/10] net_sched: use qdisc_skb_cb(skb)->pkt_segs in bstats_update()
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
index 9cd8b5d4b23698fd8959ef40c303468e31c1d4af..ae037e56088208ad17f664c43689aee895569cab 100644
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
+			       skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1);
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
index 32bacfc314c260dccf94178d309ccb2be22d69e4..993ce808230fb7d4769c926f6c8368d927f5a45f 100644
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
2.51.2.1041.gc1ab5b90ca-goog


