Return-Path: <netdev+bounces-242842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C0C954B9
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 21:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F5493419BF
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 20:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA42C3247;
	Sun, 30 Nov 2025 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuYrJmar";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhaBtHs6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156C2C3258
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764535057; cv=none; b=J1NWodRQ0gDv0zDfXL69nt7zaZ/K5O/UKHqDB+CB8hW7KVCYp8wtyXYtAQhe7xUlAK583s5DHzxnpFFIyQtqX/LIDwXzLUWDnR8CnNBUaoEAs2ZOddRzMtmCsUbXKZ0KgTipf22/x5lNbj26pBvc5xGB4nZTzK7NhuBRzEVYCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764535057; c=relaxed/simple;
	bh=JBbjB0Fhxan1TBRrFuySth2Pq1vgLUJM/cv1Zq4IOSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Glqa/+NWj4JvLXFYCN5jbbbfMRY3VSNwIhImxv1kfnJ+LGqDj2Jdgsh5JHLxBup4Uwn7inkH9Azu0HLagKq38x06eFzT17uL7GIrV2KZchNhbEEHMPe3824DyHA8lH/dSqMwAdkRDc++QzPPRbyKTcwdVNd+/uJyXfrnM9xwfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TuYrJmar; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhaBtHs6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764535054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUMJiYZXKqtanBIyLbqRVm5kHc14zllivwQv0Kw91JA=;
	b=TuYrJmarooY4hwmuXNtW5q5KDTMvQFdKtipAENrrOp0hraffd5gLMJwksGROmKyaxTWVS/
	GPAH2FZhBgxRw+zpYMGEhSsJsV8zWGiwdpk9FFYSbyYVT8Av8ALJUNonQ95kx3DciXQ3pB
	lewuUhGRdhVu0enrxEtiga6yfaIzSkQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-i2tETAMaMgyCglKnScDeJg-1; Sun, 30 Nov 2025 15:37:33 -0500
X-MC-Unique: i2tETAMaMgyCglKnScDeJg-1
X-Mimecast-MFC-AGG-ID: i2tETAMaMgyCglKnScDeJg_1764535052
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b73599315adso255083866b.2
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 12:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764535052; x=1765139852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUMJiYZXKqtanBIyLbqRVm5kHc14zllivwQv0Kw91JA=;
        b=IhaBtHs6TnYunlCvL05/nqJYnJJF1kbwlKrtmlMSEOdf0hp89xHiq97EGcVc4V3Z32
         enUy6LXleuK1dnxiFONlTWZBtQ4MXpJ63G2+BG2bxnjUYTGjrzA4AvZdHzAQV+3zEIM5
         FRm3ES/LeFgEDV318bSU+nly7oeUL00qd9yz17/aAh90ZwjDDflWKMrqeMkOh2YYVm77
         O1CepVEisxcLzRmR+jIO6AbbC73zDwzypc69WABqAkr9WOyeyMFoWd78CqBuPudnZr26
         vmsawUojk33A8FOu2ElzPvaCNTVhkTpK/1Iw8biIq82om+YQ7f4iSMZs9Nwn9J1N9hfr
         LysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764535052; x=1765139852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wUMJiYZXKqtanBIyLbqRVm5kHc14zllivwQv0Kw91JA=;
        b=QWgq6eoIwF2SMnWZ1MdJkcqbgTX5nzYP1Fl3/I6JOVUmwilaQVyZ+VOQX3ugAiXf6n
         GITeCc7Q/Fp+9pzZEbG5B06iVmfGIgH/WUlg5wjgYm0L8z9IeDaDsV6o2Nd1a47n/+xP
         IYvGRD1162bUf1uz2TTIJkh1l2WNZwM0oKrbC8M0HxVxcnYeUAXtrPPdsnTVkyxr5WJs
         PCTRX+nzzM5GDi7zz55VqzqARuI6i3GDTC4lZ1a+xyKfJLeafTNR1jWKUmGrp6CXzga9
         2wGQUSCLogkcEaMx2Ug2gYVaTsnEVGilugESPY5RhNRPkPPKMKakWVQmhoHtTUOr7Fi1
         z09A==
X-Forwarded-Encrypted: i=1; AJvYcCWxYAn774Ri2SaxZhxCtf5mwuJToelpJAYMp62SixKjquGuXXqMNzlP2w4Zj861CzP0apnMFMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+V+ti+SLNAtLPIAwRj/I586vPM3srS/pQa7b8hcIz7AbAeHc
	MSyU5xREzD+ZGiGembebf5qi8CBapPSZsczPTQrlJx4nAc3F5mBqYO513ytB3PXGE95DmlGN8+H
	U+n2YqKX52sai8PURL2LOEq7S+H2MCy+0uGcf17Gn8bZvc6VxAnlPa3kqdQ==
X-Gm-Gg: ASbGncvJVfeLldIgRrJS0Jwnl3o2JCu8G8XZUoPuqhsh8iuO+P5GpQ1LA8p0ebdA5kZ
	O+zxBeVVKFI90qKpngCM7p2Y5qHEZsMHrAjBIqlpTYg9IAArP5F5w+lDyS5YAkI3ujyJbxE+ZSH
	RX0BGjDL2MkIgGLbS7eiTIZzv0PmbppN8/gA7D0u+secyCO6704eIwmGplVSm1ViIsBIHnVhcG0
	QebxJ/H+cNwSLW5EF6Ob6p+r2p8vFceKlSYj3yKpeJ9O9oPt0PXhP6cIvQrU6njTWrHqbNiCLl7
	/4E8q3Ywh+T33DbMwBEu1cTa46H7uv5yUnWewoBx1e34Ni5Q24uIuaOyzp4M25UA9W7KMNDRrY2
	tfTHbOQdPXjfkwYJnRf6QcohQfFvp0gqGAg==
X-Received: by 2002:a17:907:a909:b0:b70:ac7a:2a93 with SMTP id a640c23a62f3a-b76c555d858mr2668957166b.43.1764535051840;
        Sun, 30 Nov 2025 12:37:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC0uIo/B+vhvY1UWwpUh6CZ6e9j1wR3D1muobhNkd83nwguyT69Tu6y/GHPktGwYHGkAPBSw==
X-Received: by 2002:a17:907:a909:b0:b70:ac7a:2a93 with SMTP id a640c23a62f3a-b76c555d858mr2668955166b.43.1764535051418;
        Sun, 30 Nov 2025 12:37:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aece0sm1002613766b.32.2025.11.30.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 12:37:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 48901395C2B; Sun, 30 Nov 2025 21:37:26 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Sun, 30 Nov 2025 21:37:22 +0100
Subject: [PATCH net-next v3 5/5] net/sched: sch_cake: share shaper state
 across sub-instances of cake_mq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251130-mq-cake-sub-qdisc-v3-5-5f66c548ecdc@redhat.com>
References: <20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com>
In-Reply-To: <20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com>
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
index 51184f308387..5392e8fbe34b 100644
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
@@ -2963,6 +3013,7 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	PUT_STAT_U32(MAX_ADJLEN, q->max_adjlen);
 	PUT_STAT_U32(MIN_NETLEN, q->min_netlen);
 	PUT_STAT_U32(MIN_ADJLEN, q->min_adjlen);
+	PUT_STAT_U32(ACTIVE_QUEUES, q->active_queues);
 
 #undef PUT_STAT_U32
 #undef PUT_STAT_U64

-- 
2.52.0


