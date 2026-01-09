Return-Path: <netdev+bounces-248500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C7D0A633
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8FF230FDBA7
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CBE35CB65;
	Fri,  9 Jan 2026 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCDxgecL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZnUkrgb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5349435BDA8
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964549; cv=none; b=Xn6km2iXaX9qCGCnD1ZSr9Xjgq49H5acJU+X+/pLEHqDKDz1ntQhJow4CFcLIJiW3Jio6jJCxMw3sNYsgJ/D/bxWOZR8HQLw5y/FDJPN8i1BlkJw7dJKpaY8mRPQyn4XJrHNIcEGQoCCUqsGAv6IetZHRwpwA4r7mh210n6HiMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964549; c=relaxed/simple;
	bh=tgqcH6bS1sUOk8kTqsfff/fz2swE4YfdvoIOa/c659c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEg9U6jpHNuujF9w++3nyNDxoZ9U1485BNUynDfKsg3oq2jPZ3M2zFzExVIOobk3ySHpv4VdhcXYQP1AaC8c90EsvV+pRVDy2kTUsYKmAiH51vKPetH9XJ+JTirBrHBNl+oHILD1cKMORDFnDPj/vwQJBh9T6uPbxfLmR9pCNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCDxgecL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZnUkrgb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767964546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+y8nr22EOqsIKlkFfOSiieyoGz2jsNZZsRdVnI1AELk=;
	b=DCDxgecLUbCOu7JlWUibOOdTfnluac7pQpVAUTxFgaBKoi4E2UJVRIR4j2FrUkBBO5bkza
	vEObiqaRwDPOE+4H8ceQJSqF3oUNJnl72za50rrZJcZxF5e/logaUM7y86KL8I0IHkr69n
	7B8DnOoX3A1rhvtiXVkXcnpdRTq1cQI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-YjLzGv37MPiWdstvlSpbZw-1; Fri, 09 Jan 2026 08:15:45 -0500
X-MC-Unique: YjLzGv37MPiWdstvlSpbZw-1
X-Mimecast-MFC-AGG-ID: YjLzGv37MPiWdstvlSpbZw_1767964543
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b807c651eefso537781566b.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 05:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767964543; x=1768569343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+y8nr22EOqsIKlkFfOSiieyoGz2jsNZZsRdVnI1AELk=;
        b=cZnUkrgbPSIaUwxTXWN/iXC2Zs8ATuMi01yoSd5YtqvvnCAPASHKQZ+N7uHQkZziZY
         0mG10cVKtrB0Pf1agoKxpipqoggwKOmZH5nrvluGV0ouBxYb7qksZA4fgMU/QVVVADGY
         lfxlpOEZ8Izh4buXCpmWjyPUr0axZu5H3htxjV4wUSqY6xORW3uL0WX44Q74huEORTAc
         8FtUTSohX90x4T3w8v/h1iFYVwKW8rvQK5g1aupIusfCPO/K5Q4EXnvhTW4iL0CtFDGB
         UxIT66EHHhgTex1D2IyrcnR2HYGtbtzZpoF3R5M3kDObMpYCvoLRDYwqR9fTxIMvNXqH
         tCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964543; x=1768569343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+y8nr22EOqsIKlkFfOSiieyoGz2jsNZZsRdVnI1AELk=;
        b=l9yb9zqgZL4EpFeLe+p+MJPKFicm5rHefuKnD3iNAKQsYEFCjbZ1wbirn05kkRCTAs
         DHVLasc4geruBaQsI002wbKRM6ZHCFbehy0rviGko5mfIsR6YuZThp7ztiX8TYGrnt8H
         lYXb3/uBUfsOvrUpsyt+RMSOtVyKnP8pW7JmMpDvUQD3ZObMmc5o2EvQ0XfAi+r6tFQ7
         N0sXdDT+FEgQceyWW+nMKG++U14COy5Hg2p2N7cect6hQ4NYkxvaSE4nbwz1Sx81NHLG
         hLWzvoyEd92hM6IGTpIhZNdq1Efhh4QVgVEE/miO4IaafpGtZjhPCPR5PiTVJxgrbarQ
         P3WA==
X-Forwarded-Encrypted: i=1; AJvYcCUPpy/i9U5EBwMrBzZf9J4XR2Ia4QuytHbug3XLDLish9/pnM+bGGbExZgUg7kKUNJ0+eR/ODI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4d88yqdq+TesimO+BQ2ONqdWnKBPIvJ2pmCnPIifHo0or0lE2
	wNMp+cTf1becvJvX583j8mFVeJIQnW/BZRKJfVPmMMUI5yobiOiBh3nTJHKuO1q+/yW90NUB2L7
	8dz4mXfEgH0oZ4eeB+K1Syr8fPTzn8YMtxv9JExKDh84URiebFmhlH3qqxA==
X-Gm-Gg: AY/fxX6sEr7qA6RBZAIiF2/VJDLeMrWLB04+sKLEFwGowGgOtFy1Yn1lBSe8OG3haLf
	YsKNxmmURuu3gAHukPaGWFVASpEBKOsVWz9rNb1N0XnKqP/HL1wda0FMg8swWoDGmUI7EwgWpwJ
	Maqa4WOV1mjb+y2tN2ZLWfO+HKrFGT1PotS/zTZ2I5WVZ2kynsVabNAI4cnUjkarJycZz9EEHBb
	g30pcHy///Z/SKDHcgbv77t+jj4tfkS3kLKZBvfiqG89wFW90ucbY69M9KrVgYHjuPBDGT1kVPT
	pOhSV2AthW8ja5g3MpUyvaIGK8Kg/zKn4Jb1iuj5vudCgHzzpLIBhWVtOa+b2cEY3mKSuAOgzXT
	xrTpWgapbHOMIlDTJcwpqRGX29H/fn+fDkXl0
X-Received: by 2002:a17:907:6d1a:b0:b76:74b6:da78 with SMTP id a640c23a62f3a-b8444f4afe6mr948626966b.35.1767964542945;
        Fri, 09 Jan 2026 05:15:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESLqZ1X69qioHrfRsqVHeL17hSfWwDwGgNJDnZZGkYdNw1edGjAi9tJb0T9l4djKJTg99mwA==
X-Received: by 2002:a17:907:6d1a:b0:b76:74b6:da78 with SMTP id a640c23a62f3a-b8444f4afe6mr948624566b.35.1767964542440;
        Fri, 09 Jan 2026 05:15:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5641casm1171826366b.64.2026.01.09.05.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:15:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2FD70408635; Fri, 09 Jan 2026 14:15:38 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 09 Jan 2026 14:15:34 +0100
Subject: [PATCH net-next v8 5/6] net/sched: sch_cake: share shaper state
 across sub-instances of cake_mq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-mq-cake-sub-qdisc-v8-5-8d613fece5d8@redhat.com>
References: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
In-Reply-To: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.3

From: Jonas Köppeler <j.koeppeler@tu-berlin.de>

This commit adds shared shaper state across the cake instances beneath a
cake_mq qdisc. It works by periodically tracking the number of active
instances, and scaling the configured rate by the number of active
queues.

The scan is lockless and simply reads the qlen and the last_active state
variable of each of the instances configured beneath the parent cake_mq
instance. Locking is not required since the values are only updated by
the owning instance, and eventual consistency is sufficient for the
purpose of estimating the number of active queues.

The interval for scanning the number of active queues is set to 200 us.
We found this to be a good tradeoff between overhead and response time.
For a detailed analysis of this aspect see the Netdevconf talk:

https://netdevconf.info/0x19/docs/netdev-0x19-paper16-talk-paper.pdf

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Documentation/netlink/specs/tc.yaml |  3 +++
 include/uapi/linux/pkt_sched.h      |  1 +
 net/sched/sch_cake.c                | 51 +++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index b398f7a46dae..2e663333a279 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -2207,6 +2207,9 @@ attribute-sets:
       -
         name: blue-timer-us
         type: s32
+      -
+        name: active-queues
+        type: u32
   -
     name: cake-tin-stats-attrs
     name-prefix: tca-cake-tin-stats-
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index c2da76e78bad..66e8072f44df 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1036,6 +1036,7 @@ enum {
 	TCA_CAKE_STATS_DROP_NEXT_US,
 	TCA_CAKE_STATS_P_DROP,
 	TCA_CAKE_STATS_BLUE_TIMER_US,
+	TCA_CAKE_STATS_ACTIVE_QUEUES,
 	__TCA_CAKE_STATS_MAX
 };
 #define TCA_CAKE_STATS_MAX (__TCA_CAKE_STATS_MAX - 1)
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 2e60e7980558..e30ef7f8ee68 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -202,6 +202,7 @@ struct cake_sched_config {
 	u64		rate_bps;
 	u64		interval;
 	u64		target;
+	u64		sync_time;
 	u32		buffer_config_limit;
 	u32		fwmark_mask;
 	u16		fwmark_shft;
@@ -258,6 +259,11 @@ struct cake_sched_data {
 	u16		max_adjlen;
 	u16		min_netlen;
 	u16		min_adjlen;
+
+	/* mq sync state */
+	u64		last_checked_active;
+	u64		last_active;
+	u32		active_queues;
 };
 
 enum {
@@ -384,6 +390,8 @@ static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] = {
 	1239850263, 1191209601, 1147878294, 1108955788
 };
 
+static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
+			  u64 target_ns, u64 rtt_est_ns);
 /* http://en.wikipedia.org/wiki/Methods_of_computing_square_roots
  * new_invsqrt = (invsqrt / 2) * (3 - count * invsqrt^2)
  *
@@ -2004,6 +2012,40 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	u64 delay;
 	u32 len;
 
+	if (q->config->is_shared && now - q->last_checked_active >= q->config->sync_time) {
+		struct net_device *dev = qdisc_dev(sch);
+		struct cake_sched_data *other_priv;
+		u64 new_rate = q->config->rate_bps;
+		u64 other_qlen, other_last_active;
+		struct Qdisc *other_sch;
+		u32 num_active_qs = 1;
+		unsigned int ntx;
+
+		for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
+			other_sch = rcu_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
+			other_priv = qdisc_priv(other_sch);
+
+			if (other_priv == q)
+				continue;
+
+			other_qlen = READ_ONCE(other_sch->q.qlen);
+			other_last_active = READ_ONCE(other_priv->last_active);
+
+			if (other_qlen || other_last_active > q->last_checked_active)
+				num_active_qs++;
+		}
+
+		if (num_active_qs > 1)
+			new_rate = div64_u64(q->config->rate_bps, num_active_qs);
+
+		/* mtu = 0 is used to only update the rate and not mess with cobalt params */
+		cake_set_rate(b, new_rate, 0, 0, 0);
+		q->last_checked_active = now;
+		q->active_queues = num_active_qs;
+		q->rate_ns = b->tin_rate_ns;
+		q->rate_shft = b->tin_rate_shft;
+	}
+
 begin:
 	if (!sch->q.qlen)
 		return NULL;
@@ -2203,6 +2245,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 
 	b->tin_ecn_mark += !!flow->cvars.ecn_marked;
 	qdisc_bstats_update(sch, skb);
+	WRITE_ONCE(q->last_active, now);
 
 	/* collect delay stats */
 	delay = ktime_to_ns(ktime_sub(now, cobalt_get_enqueue_time(skb)));
@@ -2303,6 +2346,9 @@ static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
 	b->tin_rate_ns   = rate_ns;
 	b->tin_rate_shft = rate_shft;
 
+	if (mtu == 0)
+		return;
+
 	byte_target_ns = (byte_target * rate_ns) >> rate_shft;
 
 	b->cparams.target = max((byte_target_ns * 3) / 2, target_ns);
@@ -2769,6 +2815,7 @@ static void cake_config_init(struct cake_sched_config *q, bool is_shared)
 			       */
 	q->rate_flags |= CAKE_FLAG_SPLIT_GSO;
 	q->is_shared = is_shared;
+	q->sync_time = 200 * NSEC_PER_USEC;
 }
 
 static int cake_init(struct Qdisc *sch, struct nlattr *opt,
@@ -2842,6 +2889,9 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	qd->avg_peak_bandwidth = q->rate_bps;
 	qd->min_netlen = ~0;
 	qd->min_adjlen = ~0;
+	qd->active_queues = 0;
+	qd->last_checked_active = 0;
+
 	return 0;
 err:
 	kvfree(qd->config);
@@ -2974,6 +3024,7 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	PUT_STAT_U32(MAX_ADJLEN, q->max_adjlen);
 	PUT_STAT_U32(MIN_NETLEN, q->min_netlen);
 	PUT_STAT_U32(MIN_ADJLEN, q->min_adjlen);
+	PUT_STAT_U32(ACTIVE_QUEUES, q->active_queues);
 
 #undef PUT_STAT_U32
 #undef PUT_STAT_U64

-- 
2.52.0


