Return-Path: <netdev+bounces-248188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5414DD05328
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C78F33A4EFB
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5F2F4A14;
	Thu,  8 Jan 2026 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pdbva9VT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L22dPC4u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E192D8DB5
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891487; cv=none; b=mDqArgzaBVjI3TyPIeJd5KMloIk3PaKsNpuUWzqv0UtRTjN7g8w86P6wC6nnfLmiPxdJgYiAeKeVJ6Q0t6GLveeB2XOMadOsAv97qavJf/64b4Kbxy22FGJnC2QpJUxK8z06OUZQFvmMIJFrL7NY83Tba5ARE6Odd9yY8gl2Lo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891487; c=relaxed/simple;
	bh=QM5kzySdjT98rAg4wXEgmhsHF2JTrRX5ixqo0uaWdpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgPPFDVRSf09tK8w16dobzaCvec3x/9fMYVCF0vmkx4O0dmpJ53PPghzzgLDymGyS+5BAkBRa5Xc4fN2GSyhP7VxmN2kOlFhiFxnquycBU60ylVgyoiWbrDngZxu0ECeqVSkGUFtZyPoXDZvVx0A8luIYCAeCE0QK+fOnYSOQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pdbva9VT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L22dPC4u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767891480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRjthpsF6K8HFr1yY9/DbqcKJ9s/6Ttv2qe7VrB+bU8=;
	b=Pdbva9VTga0wlWPB/gsjqJApi1tUo2lIkV9F1Yl0LiTQNvVkKQR0eJfQhOlQNHkJeH//tv
	HYqhUK76KqRVR19cr/tiOUyJ4QivF0/Pb6nyB9FeV+9u83qJcRxd8/32SMN9pdOGQXeXqB
	D6bbgiVETAZT1Tg1TP621UiCDJoYOzc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-IJKrTzRsOkeBCKJBQ-TF7g-1; Thu, 08 Jan 2026 11:57:58 -0500
X-MC-Unique: IJKrTzRsOkeBCKJBQ-TF7g-1
X-Mimecast-MFC-AGG-ID: IJKrTzRsOkeBCKJBQ-TF7g_1767891477
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b800559710aso288187666b.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767891477; x=1768496277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRjthpsF6K8HFr1yY9/DbqcKJ9s/6Ttv2qe7VrB+bU8=;
        b=L22dPC4uLZg/9qkOQgAP9qW6zkR7FnT8G5FyamptJT/JK9r59zxxp6HDapCKcxg6Y7
         9VUSZmaJbXff7gX+JxsPTlygzVI7weNI4hADjNKBlZwzTtmbq3VjzgvawbtyNw5+MvAk
         uidc4Q6qTb508jlscZdA5RqduKqjecnuSiXmgSiiDGYSC6LT3q8PUC2gp7OueZmXrUUw
         u/4TFfzmNJ0DFGlgyt8cvdYnf8AGrh2kdZ9Ia8CM7aQfF9hsRwx1Q7rN9NQ17qhK4H7K
         bW5E5gmvq/l8Kn9eJSFkJ0B4lBrd9j9+KeGp/9hFHwENELmo/jWmUuNulfd6eUgAKq6W
         OHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891477; x=1768496277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XRjthpsF6K8HFr1yY9/DbqcKJ9s/6Ttv2qe7VrB+bU8=;
        b=to5vID9r85yu3hLg5IFkff0R2NrUGSNK3Yf0KNUw3WFnVnY0na5hwtWc0TtOMyRSyM
         ryy4TT+jaX95vQQWgpp02JVhUjmodlJoa/9BKHgcRCPwC24i6HaHFv9US1h+b8twql8m
         Et4kDl49wFXuEWoA63jBqm6XZ6LY8lTPOuHWWPxUnLDhXeuUvOhfexnxuNG6zthCrMVh
         qWiatUfe4vNoRXoGejICltXsN8QACQgm15Qioi39zGWv3xfubQZfmf9NGWuKrLYf4EVS
         W6ES84Bl6/qToq+1J2uHRTl/eL9H47udiNkAmN5RSNm7DIMk0EJGEAmZ1HLysSKpQrBn
         rzvg==
X-Forwarded-Encrypted: i=1; AJvYcCU7GOtVKzpXK/jkXDNWl6fykj1GWavp0q3ZdvQcDE2osE3VqyjTK9VtjGwtDE6lNsKOyHT7HdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Men3b3Gd0luyYAF4X415JZZP2YTAKcs19Fpm4rEWmO8xdWPZ
	IIMbhepdA0T3GkrlO01+MD2IaVN56/4/2Z7Knc6F4N2RFUisKULFSp7RH6aWA58CRCTmcW+95Lc
	/tR92A1Bm7dXwNSRfIKI5fjvNSipXXbuF5o3z7jP0HZhfWEPPaadaTurAXA==
X-Gm-Gg: AY/fxX550GPLcXCG81CE8zkll0LLd1z+VtAttiXkBKvHQVK5z8yMrflAlyfcxi06XDW
	1XErahkaze172EknoW26upLWmd1C/DRQ5ackEqq1CqNAiunEB4lQXaOz1Av4hih9IWCMMibQkhF
	3ZbtEkM1y+uYhOC4Jz4mH/GX9aU0/WFHe/ssA/n0cHvXqKqUN+Vy4kvJzb1nMa1zDxXx6KoA+1M
	sjIOrJEvaptV57V0NvOK8CgIgyaZwB5XLQDxiTVEdR/Hq7gskDylWeUG4XNMf5Cr+FnQ3Vfsx1k
	8XFWSLZ3o0xOQTiIJ87HCa7gWHwL1o+w63SzhT5QBcaUGSoLIIbuwo/h2Y6shkF5ddBX+mKmDbl
	y7TNB3eLwPvIJKBJ/VW//jWV4npoLZfokCpbf
X-Received: by 2002:a17:907:9704:b0:b6d:7288:973d with SMTP id a640c23a62f3a-b844503a6f6mr698488566b.56.1767891477430;
        Thu, 08 Jan 2026 08:57:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5GdIo7VyCb89V3WIeGbRCSN2hUlRQaLsbWZ5nZ9k1uJoQOjkUeFv7zppZFU+ogbd3x7sHnw==
X-Received: by 2002:a17:907:9704:b0:b6d:7288:973d with SMTP id a640c23a62f3a-b844503a6f6mr698485866b.56.1767891476974;
        Thu, 08 Jan 2026 08:57:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5d4sm7957275a12.32.2026.01.08.08.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:57:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D36644083C3; Thu, 08 Jan 2026 17:57:52 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 08 Jan 2026 17:56:07 +0100
Subject: [PATCH net-next v7 5/6] net/sched: sch_cake: share shaper state
 across sub-instances of cake_mq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260108-mq-cake-sub-qdisc-v7-5-4eb645f0419c@redhat.com>
References: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
In-Reply-To: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
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
index 4dbfee3e6207..8dc177f28832 100644
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


