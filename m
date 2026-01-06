Return-Path: <netdev+bounces-247349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9F5CF821A
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70426310A32D
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C5334374;
	Tue,  6 Jan 2026 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8QD9+Os";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lr72Bxia"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB833344A
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699668; cv=none; b=rKyE8JnlXL3GvDtwdzT+5q8f0ib7k1nTVXFeHL29VyuZYBvuRAr53rAhQddBDgZpHE0Z4OSkWje5Rp+shBKSNVeyW367CzPkJd1fZUDNA+AjXAfiJvf6P/Gehuk6XeY3M7DIzdgtdkMmnRxtmODu7SQI+ZmP/5qRARCJ7qpPSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699668; c=relaxed/simple;
	bh=xxW3waCCSaZ9FdquA2MtzWr4sROdBYIBjnqcvToG7+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oCtPM1NTN2/PFvgw1QjnpqV0D1taztJXmcIree+ue81cU4Z+ZyxTWsuwUlgNdybdlI9U2SqXFuquO7bhWVHgI6XzKBMng4HHkisdczPQGhtJ2a+6IcpeygF3Hu53XVIg4xTkYAg0YTFGUtcbttcgOAbaPcqDpGYsseWTvf9GV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8QD9+Os; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lr72Bxia; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767699665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CWSd+PGM2JdeW7nTcCv/7NGr40swNVwKAd5RTnVFNo=;
	b=C8QD9+Os5cifYCZ2K3wsDxeXnWIVNf9iBjIbDTf/Gj00fhAPeqXdXcttVmfCuaeS3m8m3+
	t025bUAnbzPF9WXthLV9KvDLeF9FGNMNCa+apYoJoSweLki/HeoPoCJY/CkTiehG8VHBs5
	PPgnQLlksQkeXgzagn4EVukxmQSX6rM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-9pChD7IwMNigDrqCO3T8tw-1; Tue, 06 Jan 2026 06:41:04 -0500
X-MC-Unique: 9pChD7IwMNigDrqCO3T8tw-1
X-Mimecast-MFC-AGG-ID: 9pChD7IwMNigDrqCO3T8tw_1767699663
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b763b24f223so101199466b.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 03:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767699663; x=1768304463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CWSd+PGM2JdeW7nTcCv/7NGr40swNVwKAd5RTnVFNo=;
        b=Lr72BxiadGlA4EHmtmVan06WQDOlQXZykxOuEjjr4ASFTEFDeK/1/PicVkrZ59wlPP
         wPDHuCbnp1kmZF4i4AHgv5ZKjy4B0JCjmFkvTNLeVFg7uG9g04YYVl90huC5G37iLenl
         QbUo8JBe75OksODNZDsDXP7gpf51UmizidlkXzNd0hXg5HCpXIECF9auSdCTihItZ9Y7
         nZVJ3sVmWJsNSaMkd9frcEdFoQrVOSs/tZJjbQylI5NKUS1EUoOG9y1rVxB5932OINPP
         TDPMYm3Jp/6BFakEnIZy6oajvK+F+ukujklPagHQI5ppRffxmNN//L87S8b3i2SbMaHx
         ETdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699663; x=1768304463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+CWSd+PGM2JdeW7nTcCv/7NGr40swNVwKAd5RTnVFNo=;
        b=RUVMV4ViiNR1nudQr26Y8lR4YYYueJixIOmmHGaXbkClct2e2nzbKGXwjjR2xjRaJu
         g1crswx/P6/ag9Ib6Jf/P1yTdk7LXADdPHlFqgm3p5reFji3Ne6ubhms0g6pNnjnU1/s
         KYalhLLc87PbU5ushBHEdRftz8SC18kKjveNDtfjhdcNTAG0x8ICZrgH6Gf2XRWQJoL5
         xvGY5GFZ1csf/rYfoJULCFJ+PGtY6Kr3LiknQp9rnrWVbGlYFfYzawA9CzqbQT4fMwwk
         MCMN05Q9/chBkcX1M6v35IKWM1NrApdERzzDkejAbBdHiQWl1f7iFq4B2tY3Vf5FMvRu
         S8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9SjX8SsPx36thDhTCf7OMG+0vSzrSw+t2x1F2Mi77lcOSnexOAuA7Svs2qtsrnrWDbcCHMFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNbp0jxIT+HznKEfS3SmoVImV2GCLcpCfqKZ2HoxkMQCU93xE
	hG1kS7UNnyyPlrcD6QKAV7jDNtpfEbyQgkU9Be2/OmzzG0OYWsQEgHj40QSoskxO/tdCrDZXOO6
	diBZLs0WI4clYMZ7UmmEFi+SORKuDHJghrDOkJUOQNtWShdonvitVf8zsAQ==
X-Gm-Gg: AY/fxX6RRWSaR24/0q0fFEmtwzI804pOJps16bAdvZ/GNQUSGo0t+eVEjLVLEznbfxR
	61VXxWb8CwJkpb5BYAP2E5MmboTzn2jKlWyvKxv3nKLqEd9I413DTqui5LbyorReugHrsxVsXC4
	S6UJYE1LPVqoTRY6YyTHvLTaVUQKrhgbBHLQ/cOasxXKWhDljsOHq6VYrHAqPfT+C36QpG/VYib
	EyT3hoc+7824uhloB6UnSwoHz/mQyBUktK067HfsIwX/8VAgoYUVKEC2siL3fhSSwiqghwongPr
	DjKDbDdbSWIGj3HHyw8uaY/4MORsMsTdI82A36FfdurXvEjv2rx14Z0bRtaOBzkEcz/Ba1FzO4j
	CyLT8BIl813vzSDx17EBIdgWO2v1tnzb43OW5
X-Received: by 2002:a17:907:70c:b0:b7a:1bde:a01b with SMTP id a640c23a62f3a-b8426c3ed60mr276950066b.63.1767699662833;
        Tue, 06 Jan 2026 03:41:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAaiE8g6Eq8MiEKgZTOLIO86BKRGmMgIbiw+sOEZ4B1WqOVglaOjdirFOh0/o1N5soYa4aqQ==
X-Received: by 2002:a17:907:70c:b0:b7a:1bde:a01b with SMTP id a640c23a62f3a-b8426c3ed60mr276948166b.63.1767699662395;
        Tue, 06 Jan 2026 03:41:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2340a2sm211196666b.5.2026.01.06.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:41:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B8525407FD6; Tue, 06 Jan 2026 12:40:58 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 06 Jan 2026 12:40:56 +0100
Subject: [PATCH net-next v6 5/6] net/sched: sch_cake: share shaper state
 across sub-instances of cake_mq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-mq-cake-sub-qdisc-v6-5-ee2e06b1eb1a@redhat.com>
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
In-Reply-To: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
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


