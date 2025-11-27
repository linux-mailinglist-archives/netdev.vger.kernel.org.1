Return-Path: <netdev+bounces-242215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA5BC8D8FA
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E27E3AC83C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8306C32A3D7;
	Thu, 27 Nov 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGbzacs0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWXMqgEt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6E329E4A
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235869; cv=none; b=W5uQY1uChUgkHogz+JO+AGVqJdjTHxDIMaK51AL4dbWTTPNbMUHaa/fXWXrnCAYSVBgNZUh06LzfwFp7rvqBkROvLbnzeAZ8Yly/T0c2BHjgFDJ9e8WNQWs5ka26Nv7HIkumr1xG/AVMkg6bMYQAL61NxkA5fBUu2Xcop/1Gtb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235869; c=relaxed/simple;
	bh=bPaD/fRoosxlUE+r8F+LhPQ32G9LUCh1FV2zVy13y0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfrxbLgzxbieo7evGnfskHIGhBqKzNpY9edRwibEZXVv+YAMV6jcZbBmQiW2msCK8/7+vJxS8kqc/DlBzKZNzVGVlQT6lLwklVP79bj8wmkuIziqJm9jlq5YX44scWfDE0x4EezNg4pjXfSmre7Mg3ONoJuroTWXeIZnQ3vVWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGbzacs0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWXMqgEt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764235866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YeR4pHyn8JRPtsUsQEB6Db0GcddVy+xH6dFMR4x25A=;
	b=gGbzacs0beHVzkgx03w7MNUVA/QVr0OjTDhEwmXpVsCtJ5fzF6N4/DVhvLC0HuhgFuaSir
	BIbeu08lmkFebKSdkuuWVFk3rD/OhBG60wKk+LPjBNvck7NuwOAelh7q0Ydoklq605ENeu
	6WY3T7eZSgxx9yA3uH3tfokUMLLVW7s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-AYZ6Wqh2MzGRzonPGy4v-A-1; Thu, 27 Nov 2025 04:31:04 -0500
X-MC-Unique: AYZ6Wqh2MzGRzonPGy4v-A-1
X-Mimecast-MFC-AGG-ID: AYZ6Wqh2MzGRzonPGy4v-A_1764235863
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64537824851so769981a12.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764235863; x=1764840663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YeR4pHyn8JRPtsUsQEB6Db0GcddVy+xH6dFMR4x25A=;
        b=RWXMqgEtAWp04autUnkWZjMpgXiZw2bR2vKsTzzweXKpmCAlMRgDdf0Ub/kidm09/l
         oCaJ4k9q1jEZkv24gE8RDS38uTLs+wW21oUCNeBA8zU1a46P3XZST8t0sFTV2SZBwjcQ
         VaYtkTykkCaliGHpUVuCZu+ntQznQXyEZQMQpsrcnVJDcEnvJb/xnvbWrjbjZf/4uMTk
         kEUsfPEZGmR660zzVs7a2R7pk2L4l9s99cpBoP4Sbj0jzu0XPCx9sLYeHIMJ4h+1wc2n
         1diJm7NoslgliWHzYtYES06kp2qWgN2OaAgGqskvGFbNFRhumvlRg10Co5DANEWE5ZZU
         Z1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235863; x=1764840663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7YeR4pHyn8JRPtsUsQEB6Db0GcddVy+xH6dFMR4x25A=;
        b=UVpRM3NoT/UaeMQAikDEg0FJyICzejYDahAnqdL7GAnSLMOlUGQfShhLUc7aj1VPpi
         Ml8Xy7SMaAiFrkp0CjfS6XrsHChhmFpfulx3I3OsgGMqfekFi6ZYvzvpdk+aK98+NWk1
         WuK/fz14Yy0TAYdSe00jYJfKzQODmoINnwQ2ZU/baQwtJ2JoKx2HawDQSYjJ5Z17KRrE
         MMHeKkIyMTtN1qfc3fTs791I277519j4DVI5QMTmqfcvLKD1HFpxDRC9PJA9vom4cscW
         0eZFKxWHQctHSlc7v/z6iSGCq6NZptB8EZ6jMJVVqhPfsCyBt4RMiJBVHWgTgSNICQ+K
         pFvg==
X-Forwarded-Encrypted: i=1; AJvYcCUlE6LDYg2rF53WoxibWsBjF1PruUn3p5vQVeNt7ZxbLYyAacT9WY8/WfomEaTPXIdmjz0S4qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxXd+7roKnHoNrtUSQnsbroVD59l8aNjrCp/y16m75WM+scKar
	MODpvff95ke0UPQe6XAFFSoWkS9qG2tT03HzZJmN3Q+a4y8Zf2VUHhsTps9PiEWDcyZAsv7f2ST
	dnX7poMQ66lBrLuQSmkvSfWUM75m+o/kRE619wTEAqUF1DynKEDBtfVd6gQ==
X-Gm-Gg: ASbGncuBNIS8baLfZ4f5Sgkjt1F2I+IgvGYz0Xrhh1jcWmxk4UfzxdKyz62UATLLA6w
	zK5yXCLYse7hrmp0PyuYJ/MhM6WdpvItevSzxy8PM6qUzBZ1Qy5LddOzUkjX/itEifg/KL+EK/Q
	c4FZAkukVQkeIdpJz4ByRePBouAm8hNaDa8qQzUZLt3gfAVFARpsBIZo44N4AIubI+QEoWOwOhB
	jLzeuhn1pIMhUZI7rUC9s0Jk3ZACEqSt1EvmotKMQL7roJwdB0t8EnxIvG9MebuvSrTd6u/Zm4a
	RqySKAwDXylpDRUw0WFi/LcoclkBaznlrqgdQUSEJd0MuAqkMtDOEEiLSDCGnaynNWOz9sICXAT
	22hC+tNTb0ilfRTg/TViN0yoltTzCu6lEDYhY
X-Received: by 2002:a17:906:c34b:b0:b73:6d56:f3ff with SMTP id a640c23a62f3a-b76715abd41mr1794066766b.20.1764235862796;
        Thu, 27 Nov 2025 01:31:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWhrSr19ITY09f0NCqAie9Y7DS3c2o5V/jz2EFQtdt3RR3r6NMJx6MVRVn3Ca0dG4YnAR8pw==
X-Received: by 2002:a17:906:c34b:b0:b73:6d56:f3ff with SMTP id a640c23a62f3a-b76715abd41mr1794064766b.20.1764235862284;
        Thu, 27 Nov 2025 01:31:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51c6c12sm114939766b.29.2025.11.27.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:30:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4D02B395707; Thu, 27 Nov 2025 10:30:57 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 27 Nov 2025 10:30:54 +0100
Subject: [PATCH net-next v2 4/4] net/sched: sch_cake: share shaper state
 across sub-instances of cake_mq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251127-mq-cake-sub-qdisc-v2-4-24d9ead047b9@redhat.com>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
In-Reply-To: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
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
index 066aa03f3fa5..5264d7a366a7 100644
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
@@ -1997,6 +2005,40 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
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
@@ -2196,6 +2238,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 
 	b->tin_ecn_mark += !!flow->cvars.ecn_marked;
 	qdisc_bstats_update(sch, skb);
+	q->last_active = now;
 
 	/* collect delay stats */
 	delay = ktime_to_ns(ktime_sub(now, cobalt_get_enqueue_time(skb)));
@@ -2296,6 +2339,9 @@ static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
 	b->tin_rate_ns   = rate_ns;
 	b->tin_rate_shft = rate_shft;
 
+	if (mtu == 0)
+		return;
+
 	byte_target_ns = (byte_target * rate_ns) >> rate_shft;
 
 	b->cparams.target = max((byte_target_ns * 3) / 2, target_ns);
@@ -2758,6 +2804,7 @@ static void cake_config_init(struct cake_sched_config *q, bool is_shared)
 			       */
 	q->rate_flags |= CAKE_FLAG_SPLIT_GSO;
 	q->is_shared = is_shared;
+	q->sync_time = 200 * NSEC_PER_USEC;
 }
 
 static int cake_init(struct Qdisc *sch, struct nlattr *opt,
@@ -2831,6 +2878,9 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	qd->avg_peak_bandwidth = q->rate_bps;
 	qd->min_netlen = ~0;
 	qd->min_adjlen = ~0;
+	qd->active_queues = 0;
+	qd->last_checked_active = 0;
+
 	return 0;
 err:
 	kvfree(qd->config);
@@ -2964,6 +3014,7 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	PUT_STAT_U32(MAX_ADJLEN, q->max_adjlen);
 	PUT_STAT_U32(MIN_NETLEN, q->min_netlen);
 	PUT_STAT_U32(MIN_ADJLEN, q->min_adjlen);
+	PUT_STAT_U32(ACTIVE_QUEUES, q->active_queues);
 
 #undef PUT_STAT_U32
 #undef PUT_STAT_U64

-- 
2.52.0


