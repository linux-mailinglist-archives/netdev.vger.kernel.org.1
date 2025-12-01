Return-Path: <netdev+bounces-242932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813ADC96893
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485793A2603
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDBE3043C7;
	Mon,  1 Dec 2025 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNJ+xBmK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AB0bWWHx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E339D303A22
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583242; cv=none; b=rWXkU7J30QoU9AoWHUElLSoEVn9prualBL0dNmGzFokQowknxWQ2d3mW2cW+RWwxdAbMDz042ShH82tTcyySwsHgnMYrdZx8Dg0nYkuFrzLLrq19afhhsusY+sgqIbZks9khCxNZnq+K90BiQM0RGBjaN+erHfh+Xws5H14YfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583242; c=relaxed/simple;
	bh=K8fKcRcVizwqS6P+ca3FECkasM2uNPaWO4r6W23oQZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hKAx7eBD2MPQFzrdJ3nSWUslRSBib1KYgUkneADfhm8Acy5v84ZN47oAG0Zks1n0b12MD5t09CHq9peRsXjAJbd97VDSjdFDziv3V82XkINqfPX1WoI8XCCnUIEn8JPrst2IlyGoa3VKGk+emjg/GTqVvHUNYeI265cK8+61xXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNJ+xBmK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AB0bWWHx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764583240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRBxC0ZFGZCmSk2UkTIDHKIUO68izOSwQRX/nixt0fo=;
	b=bNJ+xBmKtKPmJq/EtzfReLT8yhvY//lsEViWhM3EQ9mceIKAgbSWBGShD5UYHjlGWGksVn
	qGMAsom447zGlupPP68W8BqA/J/iy+FcaRC7iWLL+7+QGxxdl3Vx6DfmGi7ta/54xUp3DX
	nCc56M33y870zEyjJKa4SiWPY5Z2MrA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562--Ovo2rkwPaOOKT4T0aYw3Q-1; Mon, 01 Dec 2025 05:00:36 -0500
X-MC-Unique: -Ovo2rkwPaOOKT4T0aYw3Q-1
X-Mimecast-MFC-AGG-ID: -Ovo2rkwPaOOKT4T0aYw3Q_1764583235
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6409849320cso8927953a12.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764583235; x=1765188035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRBxC0ZFGZCmSk2UkTIDHKIUO68izOSwQRX/nixt0fo=;
        b=AB0bWWHxcTBh1zTD61nbZ0J8gNS2XfFfVZl1Uy+bbVR9dkggUB/O5bFoHFOYNnvG6j
         tClF+ZiphgDFHoroKsmrc1SgPgs3mMDJceqwINA/nNSx7WzbwGwM8+DjTeosfzazixBV
         EYAtM2Je6m1cKPn+h8K+MQbzOYKOFgop/K9SjHUzRzUp3Ocjdj4b2C34VrfQpBuaCEct
         OyX7R77GVRyJxY8GlIFsRbr+xvRsuvySqQ7D1uY0ZQhey2QX/I41N00CKvtXt4KMVtxO
         I/BCpHrWoVDfItPRO4n2pDYXFEuokEJ9VQhC0+ERsKaQaVwzNJXhCOtoh8oAKoGLwOzB
         yxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583235; x=1765188035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GRBxC0ZFGZCmSk2UkTIDHKIUO68izOSwQRX/nixt0fo=;
        b=U72U5BYB5SPJj50aTjjmV30Ed8cSCLBl0VsmyT0Vt7iBKiK/ksvv2mDQPaMFABdtzm
         EzB7EEMb3af/UnBFH91hP2ynRlgk9XXGpzhilliMy4meC+QxP0hBb2kTXUfBPS9Qr5mj
         cLV3cvTAzszBsvW1rcjZZKKGx6K8HLuB3SIXfLcKA0MN2Xgia7LeCQN8yeYPjw+u+ggF
         jxORJzCMAQAqxf96Tc7e2zgLSacpdl7vRNPOuNosQNhNNgPDKROZSZBc0wcYey5lfLNQ
         PEyRYrR6aPvUVR5W0h2l4PqYHtSzaX60JhaIPgwjXUSWGJzASTQNmQEJgX1fetomARLt
         FYLw==
X-Forwarded-Encrypted: i=1; AJvYcCXsHJsqUhGJ9IlqhJ+z61ZVmJ+dUqiVjbMpGG3KobWMor6DAey+UTfwPTXSLjIstMV5OomMSUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSvFViXRDcYrkXvt7a6FFbvDgg3bk3eSHgmNO53+7niz7m1Ka
	DNb6gtdVmtKyVGqXMFKgiCA6f6IutqphP7l2W40R2DyttSUF4LDGDkAwlD7mqfKxSVW8n9MCO+6
	ZQh8e0rSzQea67eV+x6yBq4FPC7q8bYI1pn5EYxz+9YVE7GzKSEYgjk7Isw==
X-Gm-Gg: ASbGncsfQw414St/U+FsLPyEg656mESEsLHH7Cq2TEWlPwKrm5IajytJ/mK1aCzUfjW
	WvAE9WoQ0Lt+40kAFFQx7/hqABsc9q6/OOCiGAx76fi7AK/efbJlSBG22DwTlw9RlK8/uOiAPYa
	UU0SaIM7kNwswWkB1jDNEn9lyS0R3TpulUaNXsu6vQFJMFi9bezfD4kqMK+rlyWLyiw8Z0iKAYu
	UKN54kaFfMdTekJbu7eR2B6uLyCZd76XzAIjfLT8wyZ2SVy5GHU709qqWxI4zZ2MdI34VC1M038
	vqOKsrfXqa/0ZJKzRUKVjebYoPEAbcSjVasWec+zfXTqUDJXU0xcqlj1NllkmJ9DqTmANOXNV+n
	XPmPlPjM0B/gAhVFlGGDzw9f57mrsJniNbgI+
X-Received: by 2002:a05:6402:5343:20b0:640:abb1:5eff with SMTP id 4fb4d7f45d1cf-645396588c5mr30794387a12.8.1764583234948;
        Mon, 01 Dec 2025 02:00:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6lm2Hov2DqYps3arQU0B8aZlQ7yDmaquMB2qVJT3/S8O1hTn2GfumPtJLf3a3bkDIB5Mu1g==
X-Received: by 2002:a05:6402:5343:20b0:640:abb1:5eff with SMTP id 4fb4d7f45d1cf-645396588c5mr30794367a12.8.1764583234530;
        Mon, 01 Dec 2025 02:00:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035c3bsm11784211a12.19.2025.12.01.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A9937395D5B; Mon, 01 Dec 2025 11:00:28 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 01 Dec 2025 11:00:23 +0100
Subject: [PATCH net-next v4 5/5] net/sched: sch_cake: share shaper state
 across sub-instances of cake_mq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251201-mq-cake-sub-qdisc-v4-5-50dd3211a1c6@redhat.com>
References: <20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com>
In-Reply-To: <20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com>
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
index 9c3eaf5c9107..3ad92cb7358b 100644
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
@@ -2196,6 +2238,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 
 	b->tin_ecn_mark += !!flow->cvars.ecn_marked;
 	qdisc_bstats_update(sch, skb);
+	WRITE_ONCE(q->last_active, now);
 
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
@@ -2963,6 +3013,7 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	PUT_STAT_U32(MAX_ADJLEN, q->max_adjlen);
 	PUT_STAT_U32(MIN_NETLEN, q->min_netlen);
 	PUT_STAT_U32(MIN_ADJLEN, q->min_adjlen);
+	PUT_STAT_U32(ACTIVE_QUEUES, q->active_queues);
 
 #undef PUT_STAT_U32
 #undef PUT_STAT_U64

-- 
2.52.0


