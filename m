Return-Path: <netdev+bounces-225948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF7B99CA2
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96AF19C6D37
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4347301039;
	Wed, 24 Sep 2025 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDznfqh/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46F61922F6
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716194; cv=none; b=S1WMoqXazRxj6XviO2vWlVmvuLBLdFYO1pmdFnaLj8zXx4MPaEoBE1qwm35AsmgSlqR0SncBGJeUUGgptbbOIyczaB68pHEoKO+zJyrRioiaV/SVDD/AuFiMLF7j5j9Pcd6pAohNah13WC+/whuNkogO7i98pS0RF+bYuKIIQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716194; c=relaxed/simple;
	bh=bJfTQiEq1TAT/XLnBLwNUOKBXo7NQU0/BmZy33IMyNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uW4m0dQ1RotEuFfvDzRDRg3qaHgBVKvUA2ORmym6ZTQZ3fIejZ1pnmhL6Qy+IZMPsnbgrYTnk6EzpHnbCRJ1FLrb2WFF+T0eVJDp/FI0KqhfxWSbJCaPNnvwrGLvRj9zjGNHp9AB773RLL5v+ULws8BFiEPWWijPWb0+3AKX7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDznfqh/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758716191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaZBj7DV56tdO3MZR0SX2xTuMVtdTe+cM0MJkyLqgvo=;
	b=JDznfqh/t0CvdaKxppN66yV0Pk+5ihLrgoP/anFnp5Fp1BZhEwHg19siArX+RshP3BDMKR
	eTJMg/nhbUPI1g1UY2/AF0zkJvroy1D6+5Pow9rPXvZMSpo59Kf9DcVPMiZi5Q7fFczo6K
	B0fVCPg7YFB1i6L6U4X9PRDwt/qzZew=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ttLUCxPiOjioPQkaXO8qUQ-1; Wed, 24 Sep 2025 08:16:30 -0400
X-MC-Unique: ttLUCxPiOjioPQkaXO8qUQ-1
X-Mimecast-MFC-AGG-ID: ttLUCxPiOjioPQkaXO8qUQ_1758716189
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b33d785dc3bso32695566b.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 05:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716189; x=1759320989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaZBj7DV56tdO3MZR0SX2xTuMVtdTe+cM0MJkyLqgvo=;
        b=nbtnoSGMNbrEQHyu7Ki6NFBONQQutv19+hRBuRepMSJ3rcTstbu8dlxdOJuFH/JCAD
         IJa2JP3agxSEshQ9Y5WmesjY3vcecOLvykaXuzZ/eWxVLXSpJzrIgwtMUkS78i74+P5w
         B8YUaBYSR5JK73331nS18ChFh6hbxjr9XPLp7NH+BQKX1Sx9E9KIN+5hHheRHbG/cUrC
         RKSC+znSq3Z2ymiB7ksXr/XFKKYL63R7aDIqEW6hygaD2BjyL5N8JGJkWzGVcHbut6gm
         Grh4Z+yESl0l0uUOWlduJqk2u36jqIzOaVdOJ17Esg89+j40LGot2MXVq39Dgwc+xY7d
         hJDg==
X-Forwarded-Encrypted: i=1; AJvYcCX5X4JNyWehjv2OBOXk5FWoy7Z9LJBb5X8kuKYQS7qDqyruwHH4t8quZMaJz5njPv32i854tQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZRZRmkCePOrp5vfnpVm3TEH6qdTSoIvvUpzVwoyFAysUlYh/
	h+O8hov9C7kEkkFzbUT4MP7jrCkB6z73PGLt9WnMRYdhS3+EN2gTVxqbMgaKKUGWRQf+7HUIk8s
	Y9PONlBZO06xFLRGqDiuPnH4uJue85uHNJq2GIQQ/HqxpNE63aKpJT0xV3A==
X-Gm-Gg: ASbGnct4KkN8AoFu6ErPiU/VdGsltIKFgDPfmrZQEcI5ziMpFe+QgVBIf3Cn8P3trHE
	AZ7+PGutnuYwyFxv7XjqvRc7f3WRiy0SKTVrXZECsrEuwWMC3SptARHY09VL8YXgdXPNUMge3ND
	S5zIZ5cjLVfOOASltfQPdkb6yjQMtbO6LX7n9cxdkBrnJDFQr6mGoEeftO6q7cCCdv/gFzo50IZ
	XWv6J784bzIZQOBFlxU4TbjzheoQIXYy8jgWCPPe3qqV6la1hSDkf8AKkFB1QqwLDm0vharvUpZ
	rVAWsl1bWFu39+X6hV8Bg02dZTNdePu8nvZWiimHwT/x3WXcTnY/SyvBnAFRj7wT
X-Received: by 2002:a17:906:c182:b0:b31:ec30:c678 with SMTP id a640c23a62f3a-b31ec3193f1mr325994466b.57.1758716189113;
        Wed, 24 Sep 2025 05:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELErqdAePyfYI3I/G7TvvYplOjnruJiXghDSSSCw965rvIJ/98I1bHzk7mcp2LbWzRGx0U6A==
X-Received: by 2002:a17:906:c182:b0:b31:ec30:c678 with SMTP id a640c23a62f3a-b31ec3193f1mr325992366b.57.1758716188688;
        Wed, 24 Sep 2025 05:16:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b261bdfe871sm1212276166b.61.2025.09.24.05.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:16:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5AAE4276E2E; Wed, 24 Sep 2025 14:16:26 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 24 Sep 2025 14:16:06 +0200
Subject: [PATCH RFC net-next 4/4] net/sched: sch_cake: share shaper state
 across sub-instances of cake_mq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250924-mq-cake-sub-qdisc-v1-4-43a060d1112a@redhat.com>
References: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
In-Reply-To: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

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

The interval for scanning the number of active queues is configurable
and defaults to 200 us. We found this to be a good tradeoff between
overhead and response time. For a detailed analysis of this aspect see
the Netdevconf talk:

https://netdevconf.info/0x19/docs/netdev-0x19-paper16-talk-paper.pdf

Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/uapi/linux/pkt_sched.h |  2 ++
 net/sched/sch_cake.c           | 67 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index c2da76e78badebbdf7d5482cef1a3132aec99fe1..a4aa812bfbe86424c502de5bb2e5b1429b440088 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1014,6 +1014,7 @@ enum {
 	TCA_CAKE_ACK_FILTER,
 	TCA_CAKE_SPLIT_GSO,
 	TCA_CAKE_FWMARK,
+	TCA_CAKE_SYNC_TIME,
 	__TCA_CAKE_MAX
 };
 #define TCA_CAKE_MAX	(__TCA_CAKE_MAX - 1)
@@ -1036,6 +1037,7 @@ enum {
 	TCA_CAKE_STATS_DROP_NEXT_US,
 	TCA_CAKE_STATS_P_DROP,
 	TCA_CAKE_STATS_BLUE_TIMER_US,
+	TCA_CAKE_STATS_ACTIVE_QUEUES,
 	__TCA_CAKE_STATS_MAX
 };
 #define TCA_CAKE_STATS_MAX (__TCA_CAKE_STATS_MAX - 1)
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 7ceccbfaa9b6b4cdeaf17b416c2b65709c22a60a..014a399bac30ed4a40ca4ede313db5abfbbb5243 100644
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
@@ -257,6 +258,10 @@ struct cake_sched_data {
 	u16		max_adjlen;
 	u16		min_netlen;
 	u16		min_adjlen;
+
+	u64 last_checked_active;
+	u64 last_active;
+	u32 active_queues;
 };
 
 enum {
@@ -383,6 +388,8 @@ static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] = {
 	1239850263, 1191209601, 1147878294, 1108955788
 };
 
+static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
+			  u64 target_ns, u64 rtt_est_ns);
 /* http://en.wikipedia.org/wiki/Methods_of_computing_square_roots
  * new_invsqrt = (invsqrt / 2) * (3 - count * invsqrt^2)
  *
@@ -2002,6 +2009,40 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
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
+		// mtu = 0 is used to only update the rate and not mess with cobalt params
+		cake_set_rate(b, new_rate, 0, 0, 0);
+		q->last_checked_active = now;
+		q->rate_ns = b->tin_rate_ns;
+		q->rate_shft = b->tin_rate_shft;
+	}
+
 begin:
 	if (!sch->q.qlen)
 		return NULL;
@@ -2201,6 +2242,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 
 	b->tin_ecn_mark += !!flow->cvars.ecn_marked;
 	qdisc_bstats_update(sch, skb);
+	q->last_active = now;
 
 	/* collect delay stats */
 	delay = ktime_to_ns(ktime_sub(now, cobalt_get_enqueue_time(skb)));
@@ -2271,6 +2313,7 @@ static const struct nla_policy cake_policy[TCA_CAKE_MAX + 1] = {
 	[TCA_CAKE_ACK_FILTER]	 = { .type = NLA_U32 },
 	[TCA_CAKE_SPLIT_GSO]	 = { .type = NLA_U32 },
 	[TCA_CAKE_FWMARK]	 = { .type = NLA_U32 },
+	[TCA_CAKE_SYNC_TIME]	 = { .type = NLA_U32 },
 };
 
 static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
@@ -2301,6 +2344,9 @@ static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
 	b->tin_rate_ns   = rate_ns;
 	b->tin_rate_shft = rate_shft;
 
+	if (mtu == 0)
+		return;
+
 	byte_target_ns = (byte_target * rate_ns) >> rate_shft;
 
 	b->cparams.target = max((byte_target_ns * 3) / 2, target_ns);
@@ -2703,6 +2749,17 @@ static int cake_config_change(struct cake_sched_config *q, struct nlattr *opt,
 	WRITE_ONCE(q->rate_flags, rate_flags);
 	WRITE_ONCE(q->flow_mode, flow_mode);
 
+	if (tb[TCA_CAKE_SYNC_TIME]) {
+		u32 sync_us = nla_get_u32(tb[TCA_CAKE_SYNC_TIME]);
+
+		if (!q->is_shared) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[TCA_CAKE_SYNC_TIME],
+					    "Sync time can only be set for cake_mq variant");
+			return -EOPNOTSUPP;
+		}
+		q->sync_time = (u64)sync_us * 1000; // from us to ns
+	}
+
 	return 0;
 }
 
@@ -2763,6 +2820,7 @@ static void cake_config_init(struct cake_sched_config *q, bool is_shared)
 			       */
 	q->rate_flags |= CAKE_FLAG_SPLIT_GSO;
 	q->is_shared = is_shared;
+	q->sync_time = 200 * NSEC_PER_USEC;
 }
 
 static int cake_init(struct Qdisc *sch, struct nlattr *opt,
@@ -2834,6 +2892,9 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	qd->avg_peak_bandwidth = q->rate_bps;
 	qd->min_netlen = ~0;
 	qd->min_adjlen = ~0;
+	qd->active_queues = 0;
+	qd->last_checked_active = 0;
+
 	return 0;
 err:
 	kvfree(qd->config);
@@ -2925,6 +2986,11 @@ static int cake_config_dump(struct cake_sched_config *q, struct sk_buff *skb)
 	if (nla_put_u32(skb, TCA_CAKE_FWMARK, READ_ONCE(q->fwmark_mask)))
 		goto nla_put_failure;
 
+	if (q->is_shared) {
+		if (nla_put_u32(skb, TCA_CAKE_SYNC_TIME, READ_ONCE(q->sync_time) / 1000))
+			goto nla_put_failure;
+	}
+
 	return nla_nest_end(skb, opts);
 
 nla_put_failure:
@@ -2967,6 +3033,7 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	PUT_STAT_U32(MAX_ADJLEN, q->max_adjlen);
 	PUT_STAT_U32(MIN_NETLEN, q->min_netlen);
 	PUT_STAT_U32(MIN_ADJLEN, q->min_adjlen);
+	PUT_STAT_U32(ACTIVE_QUEUES, q->active_queues);
 
 #undef PUT_STAT_U32
 #undef PUT_STAT_U64

-- 
2.51.0


