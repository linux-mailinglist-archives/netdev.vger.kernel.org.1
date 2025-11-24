Return-Path: <netdev+bounces-241193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18181C81373
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10C794E697E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB52FF15F;
	Mon, 24 Nov 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIvofw4y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhI4JfkV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AEB28D8D9
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996452; cv=none; b=REYwsUwcxpqtUJRCYtoRJTE61ETwHg7vPAOIOOfz6U104ABgqo75aYgSiil/4rHjVYRwa27uh+Ng+iZQDqknjclT58WcIojuSVQC880BJzEeAsOPT5mVwZFDs3nVWuGF3YaHirtpiJsd8IDSvxoIZrNgr5VXe3unDnPvF4S1gZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996452; c=relaxed/simple;
	bh=FlK5yx50SQbswgCaBf8i423Y1gSb+Kib79NiE8EvOM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmiQkgH/byBIujJ841HpyAtOi8G5odtOKUZQRp9zRCBs52AE+M4CsHyExWvXOj78zrzgvdmgw9iQLwLVJ/+q3TYDbCkfkou+MPsPeHLWzt3HvErN4LXQDMkpSZ8HrkR3v4wS0nenKlqoXAAJbB0Lm431/yW3ECwcR/4LajrEaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIvofw4y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhI4JfkV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763996448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVLrY5RF3EeKVh8OIsDtnoBsJyiOc9gyGLnCet+xVoE=;
	b=PIvofw4yfBwq20vO8pZ4EL2bo3Tuuix5jdjD6onmpqumrluSGYcUrHHW/S3Z/VxNftZH2l
	S/0ezjyYMflqRYrdf6Cu0b+6zPvbUbIxOH9e5RYxxwolyt0gzKVnlSi+AlHaUqSw7riEb/
	Qcnx/cyMUi6O3TzIN+OFeBGYP+ZDO6M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-9wE529xpMMumN6WA6W3VfQ-1; Mon, 24 Nov 2025 10:00:46 -0500
X-MC-Unique: 9wE529xpMMumN6WA6W3VfQ-1
X-Mimecast-MFC-AGG-ID: 9wE529xpMMumN6WA6W3VfQ_1763996445
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7270cab7eeso360299966b.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763996445; x=1764601245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVLrY5RF3EeKVh8OIsDtnoBsJyiOc9gyGLnCet+xVoE=;
        b=FhI4JfkVX1NXPVeHYPALRxvgJeNd++ZGK+Y5ddXt32/0AIz4jb4MjrcLUqOMhcQ3Tn
         uva8MyL10CV6TgE2FfdHdYCN4RKE/QwgO1Bst0jvyJECIM89TXjSYo4992QrNYqrJPVW
         VVXue+7zr4FFP3Bp7jZFNO6Hyk+gck1I20JJzTSojte+Zb7r2vKBL8yZTO5m6J+ariNk
         +c4PiB1R61nJYjNs0tbztjwlzFMF0qlpygW5jRHSDy8nY4xAHyIftqIerSU05af6irZR
         1wy1tXqu2lE17alWAP3Sb7/sC92zxrf0NplFweJq0Zr8cmSCp35R8wctW0ePZpESYBLw
         fAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996445; x=1764601245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HVLrY5RF3EeKVh8OIsDtnoBsJyiOc9gyGLnCet+xVoE=;
        b=NYiHEv88pfXyQzyrSHmcbWHsOjNUtf1t1RxesYMEGY8VPZ+OiF5QcekCv8QV+vi1ya
         1DfWbIqzq+GIhEEyULoRaMAeXiYLWrwrn9Xic0irGjs31Fho7KCfdhO9CKHhZv3ZOrhu
         Wc6Trp3R0O4i8Dt5QunsRQDoh4BlWPkJkYft+WdFSSXg4fTlov8/vPU1LQl1vOe+4W6e
         LaVxkmMqCUxgcfpAv5bzy4TOmlm7DKOr3sUiYkGC6MSNPF91xnwSs/3clLv55wMAX4Op
         DshTnOhR+V3BH5QIO3hlEFKgPxFMhzePTdlLFj5wNBfLVGcgAIbhIrdlnEDiLcmggrIC
         KVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsFeJ8q7uTyNhBG2Y7CodHbL0uSf6C+jeNulenUp6whxd+5M+0GqrSc/bWeiZm78uNRx8QeIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6+5YglYzgFRtIpeMwB4qB7kSk7fXLB0PjfOPVKoGuLAJClFC
	oZQBpVcg8mf7fly6Q3KaEX//pZmQW4JInTH3j9KixCnl0qoH4e3C+MTj/IE66mH3iGE5uKX0HRv
	7W6h1txNFCoRXCplMOegp2W5OQewF1/SwkvGoFbz/aKkCfStClJ0QCL4Diw==
X-Gm-Gg: ASbGncuS8/I8yfpIfO8Ca9knaTZej/b7VBQYKUC7jqDe2UWXTfNlSzbTrslkG3NVPta
	oQBM8c/NLQ9WY06kL10VSHP6f4KXTZ3c+Ky2cNxFGyXy2DZmBNPzRdsFr/Ghf9vNEhZAYg7KsVs
	7IX3QNQ4yN+dhWra8MD4Aj5golW08C3dMsDDcsX0R74TsHL0dKFdBiS1vVAuOWp6pwWz5TEVRu5
	aSU7AOExkuSefZ/+Ws3s9poQHzsK1a7Z2r8EKcm80jY9V1wrJQHz+/317dJIlvz7jw0bcuZR52z
	7vy7HuDN2MjE/utTT1zmZpMkrSQVG+zXGyqZEcVpYltrMHmSrIapMXTgEMSy47gkcjR3ONAabu4
	99tyYF+i2G+3rf8QbRtEjm/dS38jSEUukxw==
X-Received: by 2002:a17:907:2d8c:b0:b73:4006:1877 with SMTP id a640c23a62f3a-b7671880a6dmr1484102966b.55.1763996443471;
        Mon, 24 Nov 2025 07:00:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGeM0fxQ6LVMBFG2qg86Ccc5rCbjGmjFgHZdI0Y33E7q9NLcgOwvMBhCjTuZ5l1vEJ76s4Qg==
X-Received: by 2002:a17:907:2d8c:b0:b73:4006:1877 with SMTP id a640c23a62f3a-b7671880a6dmr1484086466b.55.1763996441469;
        Mon, 24 Nov 2025 07:00:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4f59sm1282780366b.36.2025.11.24.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:00:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5416A32A805; Mon, 24 Nov 2025 16:00:37 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 24 Nov 2025 15:59:35 +0100
Subject: [PATCH net-next 4/4] net/sched: sch_cake: share shaper state
 across sub-instances of cake_mq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251124-mq-cake-sub-qdisc-v1-4-a2ff1dab488f@redhat.com>
References: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
In-Reply-To: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
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
index 7ceccbfaa9b6..a04aafb129c4 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -201,6 +201,7 @@ struct cake_sched_config {
 	u64		rate_bps;
 	u64		interval;
 	u64		target;
+	u64		sync_time;
 	u32		buffer_config_limit;
 	u32		fwmark_mask;
 	u16		fwmark_shft;
@@ -257,6 +258,11 @@ struct cake_sched_data {
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
@@ -383,6 +389,8 @@ static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] = {
 	1239850263, 1191209601, 1147878294, 1108955788
 };
 
+static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
+			  u64 target_ns, u64 rtt_est_ns);
 /* http://en.wikipedia.org/wiki/Methods_of_computing_square_roots
  * new_invsqrt = (invsqrt / 2) * (3 - count * invsqrt^2)
  *
@@ -2002,6 +2010,40 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	u64 delay;
 	u32 len;
 
+	if (q->config->is_shared &&
+	    now - q->last_checked_active >= q->config->sync_time) { //check every 1ms is the default
+		struct net_device *dev = qdisc_dev(sch);
+		struct cake_sched_data *other_priv;
+		u64 new_rate = q->config->rate_bps;
+		u64 other_qlen, other_last_active;
+		struct Qdisc *other_sch;
+		u32 num_active_qs = 1;
+		unsigned int ntx;
+
+		for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
+			other_sch = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
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
+		q->rate_ns = b->tin_rate_ns;
+		q->rate_shft = b->tin_rate_shft;
+	}
+
 begin:
 	if (!sch->q.qlen)
 		return NULL;
@@ -2201,6 +2243,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 
 	b->tin_ecn_mark += !!flow->cvars.ecn_marked;
 	qdisc_bstats_update(sch, skb);
+	q->last_active = now;
 
 	/* collect delay stats */
 	delay = ktime_to_ns(ktime_sub(now, cobalt_get_enqueue_time(skb)));
@@ -2301,6 +2344,9 @@ static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
 	b->tin_rate_ns   = rate_ns;
 	b->tin_rate_shft = rate_shft;
 
+	if (mtu == 0)
+		return;
+
 	byte_target_ns = (byte_target * rate_ns) >> rate_shft;
 
 	b->cparams.target = max((byte_target_ns * 3) / 2, target_ns);
@@ -2763,6 +2809,7 @@ static void cake_config_init(struct cake_sched_config *q, bool is_shared)
 			       */
 	q->rate_flags |= CAKE_FLAG_SPLIT_GSO;
 	q->is_shared = is_shared;
+	q->sync_time = 200 * NSEC_PER_USEC;
 }
 
 static int cake_init(struct Qdisc *sch, struct nlattr *opt,
@@ -2834,6 +2881,9 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	qd->avg_peak_bandwidth = q->rate_bps;
 	qd->min_netlen = ~0;
 	qd->min_adjlen = ~0;
+	qd->active_queues = 0;
+	qd->last_checked_active = 0;
+
 	return 0;
 err:
 	kvfree(qd->config);
@@ -2967,6 +3017,7 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	PUT_STAT_U32(MAX_ADJLEN, q->max_adjlen);
 	PUT_STAT_U32(MIN_NETLEN, q->min_netlen);
 	PUT_STAT_U32(MIN_ADJLEN, q->min_adjlen);
+	PUT_STAT_U32(ACTIVE_QUEUES, q->active_queues);
 
 #undef PUT_STAT_U32
 #undef PUT_STAT_U64

-- 
2.51.2


