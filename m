Return-Path: <netdev+bounces-275263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCcsJ5VF0Gk45QYAu9opvQ
	(envelope-from <netdev+bounces-275263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:56:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F941398DFF
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87C7A308A14E
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077537FF7A;
	Fri,  3 Apr 2026 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="EovQBNOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1337FF51
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256838; cv=none; b=MIUwtjcf8hytVBqM0+jEBcLyjHSlsEzwg5pVGluWd99b+JxaWRkkVTb+jVVZRLCX0ncdp62N0cenquipmfYBlvIqFBuEOJbBo2lSAmqf+o1kR9ltF4YA55h51vyvCcppL6RKgAuTYilHvqBv4edTeED0YOjHb6vPeM7b57GF5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256838; c=relaxed/simple;
	bh=M2qmTTtZobIu2vRljTsz4LeEPyny1OaI1d4BN2RKTIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2jdCiW+yi+jzKGb7BEttFXITIefud+h9Nlw71D3060uaazB5UftegNrudG/3D6ljiWgtt3F9I7Zq8qV80/SGumCOlbRNhENQlfIAv2r7FATxyJQJfGnXx4il8gQNpeZD6MojQJ7sA5E/9B/GDvZidYVRWLmPlp1mmxm9u3MHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=EovQBNOT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1299621a91.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775256836; x=1775861636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cm9Ky5yIQaqrRhne/ygDjVZ67IPE843/JQ9W9h10p4=;
        b=EovQBNOTF+epKDG0Yhn26+AqmamLbrC8uC08DFnakt2t7kVW4cYq+CrSpl4WRawqNO
         Wh2M/7gl8W4ckr6Z+JJA3vmA6qKflQMf+/TTQphbL329+EXEudXuPhoOIsNbeV74Zacg
         9eLDpu0NrQH+wj0cBS41Bhl8CY+ZKjySLiWjoogPNo1cXxPw5eodxHw5A04syW+1w8WP
         fAYB14lOdvBgzTQA4HgyBWSfhYb5vsfxZObuxQuOkKMziCO5HFfeOxmNl/squaEkedSh
         z+LM4hMTEoeTfQuyzBIhbiCT3vPE1ZiqPyaoFcf388UJLaEgS1fXtP0XkWs50cZpSc8Q
         QBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775256836; x=1775861636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cm9Ky5yIQaqrRhne/ygDjVZ67IPE843/JQ9W9h10p4=;
        b=r+FYsa1Nu6iSYTOmUYxOo85DFW8SPL2vKnz/1rgFBjuCdJN9kv0UUjIrvdiyQhM9pA
         kwQBZbl6rYC4qMGdfq62jT+fHk22mN9+k5+Je65mpkwkj/l7qEsBUyt88+eCZOFgqLzj
         EkbduEYzk8+UdRjvnccHNGZufKYoeuA1zYIgExY+pPpuffv4K/638Pzgby9FnF10YOUL
         DbUPT2Qr+uLD7ERMxKnnrfBS+hQCNcSU4TKXZGczu45p4uWdqbXgQePKEV+31RyG/Bv6
         l+GuyT9wGO/9gChpZa5AjTMvbE4E37z7MMJFsA5LiY9ZPPKKRkHASYtMJ3IZJV3LoPNK
         bR3w==
X-Gm-Message-State: AOJu0YxeKcbekUDKpRiOgbReQCaplIKKiOZaeIC3EDooNRqLZjOHMNIE
	MwRWcYeknYfcVjyrg+U07d3CCZE2Lft8OqqtO+9bMjiJEM6Kk+/GXjWxu4GxXJCF/+qSRTHTXPs
	kL5s4
X-Gm-Gg: AeBDievMq0hzjXUb6qO+xDFnJUfL+7o39pCdbyAfgWgFdWjxEIjZLWYYPw5Ltc/k78k
	XI2/MTg2+l9GD9uNbakjCJO5uk11dPBfELfj7AHRNw4VFd9g6Y6h48pIoBIZLzWxDRtGoPaPdHM
	EQa/sgUpWrBJggNZWCsny6Fu4wVKugzGeZUMcmx6eJbLVLyXW5JaEVTgFAXOLlaC/An2GzhLCQe
	2RHw1urqZPbFQBDq8SgzXOhpbTlfLEMe1QkngWi9bmfqHGWW5tG98nZ8sFbSkHOAJ7F7zmNiyBs
	IPGCkexNo7hDZ2Rfl66JFYG6HOqM+3MpdjnQgDlQj6p6mgvQzTsDK6/5q8ZOgLAIttNW2Yzwnen
	4TBCqaYu7ThUfGnk/PA0ZGYBjig3gUKdMuV16LrLMJQpLRmBk1KHL9LS6M0G5xA6YPZ6xYq33Pk
	aYEsPqZdBFrAM+6bNDC0rCCEQIUt53rJD5
X-Received: by 2002:a17:90b:510d:b0:35b:a3be:f1b6 with SMTP id 98e67ed59e1d1-35de68f7c0amr3773324a91.16.1775256835703;
        Fri, 03 Apr 2026 15:53:55 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de5197472sm1624944a91.1.2026.04.03.15.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 15:53:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 4/5] net/sched: netem: add per-impairment extended statistics
Date: Fri,  3 Apr 2026 15:52:09 -0700
Message-ID: <20260403225324.476787-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403225324.476787-1-stephen@networkplumber.org>
References: <20260403225324.476787-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275263-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: 0F941398DFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem applies several impairments (delay, loss, corruption, duplication,
reordering) but exposes no counters distinguishing which impairment
affected a given packet.

Add a struct tc_netem_xstats reported via TCA_STATS_APP so that
userspace (tc -s qdisc show) can display per-impairment counters.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/uapi/linux/pkt_sched.h |  9 +++++++++
 net/sched/sch_netem.c          | 27 ++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 66e8072f44df..fada10cb9b7b 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -569,6 +569,15 @@ struct tc_netem_gemodel {
 #define NETEM_DIST_SCALE	8192
 #define NETEM_DIST_MAX		16384
 
+struct tc_netem_xstats {
+	__u32	delayed;	/* packets delayed */
+	__u32	dropped;	/* packets dropped by loss model      */
+	__u32	corrupted;	/* packets with bit errors injected   */
+	__u32	duplicated;	/* duplicate packets generated        */
+	__u32	reordered;	/* packets sent out of order          */
+	__u32	ecn_marked;	/* packets ECN CE-marked (not dropped)*/
+};
+
 /* DRR */
 
 enum {
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 76af9bd3ecaa..6dc1ba8e999b 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -152,6 +152,9 @@ struct netem_sched_data {
 	} slot;
 
 	struct disttable *slot_dist;
+
+	/* Per-impairment counters */
+	struct tc_netem_xstats xstats;
 };
 
 /* Time stamp put into socket buffer control block
@@ -459,17 +462,22 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng)) {
 		++count;
+		q->xstats.duplicated++;
+	}
 
 	/* Drop packet? */
 	if (loss_event(q)) {
-		if (q->ecn && INET_ECN_set_ce(skb))
+		if (q->ecn && INET_ECN_set_ce(skb)) {
 			qdisc_qstats_drop(sch); /* mark packet */
-		else
+			q->xstats.ecn_marked++;
+		} else {
 			--count;
+		}
 	}
 	if (count == 0) {
+		q->xstats.dropped++;
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
@@ -520,6 +528,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (skb_headlen(skb))
 			skb->data[get_random_u32_below(skb_headlen(skb))] ^=
 				1 << get_random_u32_below(8);
+		q->xstats.corrupted++;
 	}
 
 	if (unlikely(q->t_len >= sch->limit)) {
@@ -598,6 +607,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			delay += packet_time_ns(qdisc_pkt_len(skb), q);
 		}
 
+		if (delay > 0)
+			q->xstats.delayed++;
+
 		cb->time_to_send = now + delay;
 		++q->counter;
 		tfifo_enqueue(skb, sch);
@@ -610,6 +622,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		q->counter = 0;
 
 		__qdisc_enqueue_head(skb, &sch->q);
+		q->xstats.reordered++;
 		sch->qstats.requeues++;
 	}
 
@@ -1296,6 +1309,13 @@ static int netem_dump(struct Qdisc *sch, struct sk_buff *skb)
 	return -1;
 }
 
+static int netem_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
+{
+	struct netem_sched_data *q = qdisc_priv(sch);
+
+	return gnet_stats_copy_app(d, &q->xstats, sizeof(q->xstats));
+}
+
 static int netem_dump_class(struct Qdisc *sch, unsigned long cl,
 			  struct sk_buff *skb, struct tcmsg *tcm)
 {
@@ -1358,6 +1378,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.dump_stats	=	netem_dump_stats,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
-- 
2.53.0


