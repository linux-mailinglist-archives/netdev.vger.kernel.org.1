Return-Path: <netdev+bounces-247041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC6CF3AB1
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997BE31624AA
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9A025333F;
	Mon,  5 Jan 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsuTERlC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rbRcgjOn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B006A33B
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617504; cv=none; b=rYY0+lbnLBe3HqE6PdFSpFViOOPSX1DZcvSwvBiJ09mjAfGRPHt/9/60nKvIKNf85/+DU+5SdcYUfk/db4Ie+aptXekCNjWEpBjNfXoMKHYyOFjgf6+vI8L+2K7iOXKYDIxYUy2t/wnjdEbdYp498nq2MF1bseTqsLS0WfD3X+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617504; c=relaxed/simple;
	bh=xxW3waCCSaZ9FdquA2MtzWr4sROdBYIBjnqcvToG7+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZHpNMHSnk0fLKo1puhMaqQZkdoC4saf9XrdoP5oNpgoEUERfHajGWVMFB6sBMNLqC6u6+OBSOk21mf8DDAkUCIyQ6h3ubyIwdtqOFACf+5mvpdyFyBdTgI4PVPScnC3rtxGQxov9pEwrD322lVRDJidQ7D7qFt5lDVuci5nMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsuTERlC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rbRcgjOn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767617501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CWSd+PGM2JdeW7nTcCv/7NGr40swNVwKAd5RTnVFNo=;
	b=EsuTERlC6VHpQe2cDGwdDm5kC158krRboqxqrRCp4/hxEbwPk5RGySgh1SFuaJI+JVwQ4c
	jZU4PiNb1J6t61NvHdlbBk2Nr3F88p+SSUJVvhFjiXy8tMr/tPo2LohrOZtAJ/QCDmwPsq
	DcuufoMlH8NGcdwOTK++2JFf9uClFhw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-9ETvESTBP02YXfvlNaHxvQ-1; Mon, 05 Jan 2026 07:51:40 -0500
X-MC-Unique: 9ETvESTBP02YXfvlNaHxvQ-1
X-Mimecast-MFC-AGG-ID: 9ETvESTBP02YXfvlNaHxvQ_1767617499
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8395caeab6so56162366b.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767617499; x=1768222299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CWSd+PGM2JdeW7nTcCv/7NGr40swNVwKAd5RTnVFNo=;
        b=rbRcgjOnBxHq2lAk7F/jOLDy782B6zMw8NDQyvS33r0ab2p7Bw9r0VZQABspuPPLBw
         hEwOr8o+r9Vo8DNOoG6y0CtkSDlFZTrckpjtSFnRmez1KYhrKzoFDaDTs/LR2q/8ZJOE
         pQ1HcKJg0YTYH/vHrzgXVDDActM/DCxIPLy/GEhzmXD9nF9xmPg3HIq/zKfXXpQiP15/
         yaUN2gJ7K58aJ6r7l4tJRPBAQWZzO3tCVpu/CzU2g70aepasFYqLcWxr37Xg407QYR0A
         zuT8dGiQlueYGbmTX05GU9wMwkTD4thrci5KkqnFHsC5ridno7F4LSzr4QPNmGUm2LW4
         9xIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617499; x=1768222299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+CWSd+PGM2JdeW7nTcCv/7NGr40swNVwKAd5RTnVFNo=;
        b=sfofPbVYFUiqEdX/tjxJUuJQdTHg1FC2K1d8xqBHzUbhizXtqmurrxrPe5h8Hjcp/j
         TA11duRH4+RhHGz/UECisItu0XATzF09NjR2iOmZPnhEWwF6eRkR5h1zfgq17CpzDGyE
         I/QD4RGoQe9cj8QMuwfhRjMfaCw43g5BTopiJSkQXceCj0fwkheWtvuc0uZwua3nrYix
         vT+6OFPwfe5tNKLDLGurMnvXkaUtzxkAyh3NfTe05N+eBHqL+t4IKQ87Bk+fQlRdgryk
         PaNkaoutYdliAYjlK5TiDerK4Rw9KgUvjdvO/dTQvn7mRw2nxYAckKa773Nfep6YQchA
         /Lvg==
X-Forwarded-Encrypted: i=1; AJvYcCV2A6IJY1uor89M/cIx6s8Hceq2lBAXPH+Hi1i2zx4oWBciPjc7AruGyD2GthNAobtYf1L1h5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNp7E/pYkloWSt+qi+8zlreDB2OXIXz9eGsmoLkXp5lOe9SX8
	lZ0pe4SKKHhAa2Sdr3vlStSC9oe6WrXVFvy8e0G+2Id08QGZ+oqwjz7jxu7gLX/beW2mxrwhfu0
	tL1wiic3Wa4k/fLDRg4XrWS2q2VyBSl55V2mdGOZc5gpfy8+IgNqgotc+8w==
X-Gm-Gg: AY/fxX6sO2op/kP2DI/YJK3NaCVR1V6H+D2AA8nLORjtnrRuZUYRcY5/E10hqsfBytb
	jr6q0oobgIIbOgzNBfScA1q/A/DIwAz+33vv5svcbK7gAxfwrbkc/PXUVVFzh+iMaAMl/rcg/pS
	rDeC7zXSVziRQ0cWx1Dve/cAJgLZB7567mw6yNh5vjxmVHQwvKyJmq/rYkev7K1ZtMQK+j5p9Aq
	yVwKPu4uJGJmzoSCuLa66HO7ATK3KDTluOARAglJUgftUOa6QlPEUvPn5blpHc6GlM6ygqBw9FA
	mW2tDSuIE1EvjVqX29aPktmTtNHhCQF2nSMw1kbqHOZQA0Ml8pdTdge7yTpm6K8nJuLPzdnx3nm
	93l034RzTMEpN88y4RdVB5+wCm2gRzg8CNQ==
X-Received: by 2002:a17:906:f5a3:b0:b73:1baa:6424 with SMTP id a640c23a62f3a-b8037185956mr4932729066b.55.1767617498630;
        Mon, 05 Jan 2026 04:51:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf5MSyqWYebSOBdkzSInvpzSMW38CQDWWfWlR8y/ptAyEgwCLCWJz2fIMb7oW/M4G+k11p7Q==
X-Received: by 2002:a17:906:f5a3:b0:b73:1baa:6424 with SMTP id a640c23a62f3a-b8037185956mr4932726266b.55.1767617498197;
        Mon, 05 Jan 2026 04:51:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0b7bcsm5686072166b.49.2026.01.05.04.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:51:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5494A407E97; Mon, 05 Jan 2026 13:51:32 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 05 Jan 2026 13:50:30 +0100
Subject: [PATCH net-next v5 5/6] net/sched: sch_cake: share shaper state
 across sub-instances of cake_mq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260105-mq-cake-sub-qdisc-v5-5-8a99b9db05e6@redhat.com>
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
In-Reply-To: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
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

Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
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
index f9dafa687950..e9ba7777ec3e 100644
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


