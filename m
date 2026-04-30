Return-Path: <netdev+bounces-282667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGnTCa308mnNvwEAu9opvQ
	(envelope-from <netdev+bounces-282667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:20:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3B49E014
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B5E1302AD39
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39CE19D092;
	Thu, 30 Apr 2026 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IN1lFlk3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DBD3750D6
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529780; cv=none; b=gyUF0T1hLe+zP17mwdvLbRh2O64hlNVGHQY5Potzm/+y2gwnX5HjE/aaCkm1PDazSxFOFWSuwp0tjqk6y6bMPD8TMNDNaes0VmS/UyNPfJaTW2mpLfyMPG/iHRa+qtTDz0SWlA5Brix1NAvVy2y+640Z4urCklkAzVJGNgNVO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529780; c=relaxed/simple;
	bh=DXcQJLFP+kRpDy9R1KLmjWWop34hFKAVO4wYiid/uhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cv82jjxJ+K+PaaaR0ACziMZ4QwhWrsK59H+1+8yLg+RJTH4TMATXD6wwo7JsmLd0my8NE2zrq+7fxPoIINaYgtK3+KoOAJhWaayx4im/gU5qd+l1NKDMzLpY8uCsdqToDWhpjjm7g0hCP+duL32e/IrBHaGph1Awf+iOtrW0Qss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IN1lFlk3; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8d6061bd722so90354885a.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777529778; x=1778134578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gsLUy9BLgnEf3/fgFOvFq5sAGh898VtCmFlAwumUzIw=;
        b=IN1lFlk3GWW/h6MGk6hV3HRWrixRRhX5W1/cy+gjF513W3VirJZgo5YNG4e/0kwn3Q
         6utBihTHMzZn7wfWc/5VioKYXOtnD105BFhfVJ/AXTFNkye5a1D5gDHLiOXDHvHBIicL
         pJEe0LIBdGKBk9qT10knbY6aoMVCoE2l6AHusHzDAHeffu2zBZFuD6UAyrd8Sc6KdQp9
         wOVnq5hxAC2N36FEc+kdGMVDk0uwaeOkX2HBQFRY2SbEq1mV14Prf78hkm3RGmnHDTKQ
         qI06M8w9zUGCVJfhfoYvv0HqaWZ0F+DR40YrOiXybAeqLU7lNfButb+7sXW1rd4GiBpz
         udHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777529778; x=1778134578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsLUy9BLgnEf3/fgFOvFq5sAGh898VtCmFlAwumUzIw=;
        b=pEWRo+CaZmrR76yEB+7bfcF7a6OSMRpYjFYOwAh+pfJldxhxSXD0XI3ZDQxZS2NKG+
         b5h8Q4T8XQJ+Fzmd8gytDYtbWrswk5bCjKUEBU7xQV7+l/tKdIwtsB/L0nQKvp4LNt/a
         r7jOxr4W0XogZVKlEWUoiw1qwMpmDHz/N/RzsTfzf/4q2rwhhwOMZ7mK/mbOqRSAbMZu
         1+X+TrP5+6CqaODtnmUzrrTMINXr2h4UsqP88f/5j+qBY+nXxApTvId9eCHfTrflVfZe
         RHvfn1G5AfaWyf3H2Fh4d1siJKXgBuycGZRgy7Pj9sJj6MDHOmQLKlm4CHX4xtspD7sF
         sFtg==
X-Forwarded-Encrypted: i=1; AFNElJ94qta15upZYBhRg44Ona0e6g92P0Wx4Q0jbaDguGtPozaUulbn6h0a+Qwh0uH2tgqAgGnxlL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWK4zvAToV324UzQhP7I/y+PJ563aGRpKSNMqv/6gJ7KvPnen/
	88RALZ4afrtlezeih0M8H7PMrGOE6yhoW4h6qysTHUHBaglBUp+bLhMsElWini7szRyujnwq8W8
	YgbdMS0XWnjnMkA==
X-Received: from qknqy9.prod.google.com ([2002:a05:620a:8bc9:b0:8cd:94d0:b9c6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4591:b0:8cf:d516:8451 with SMTP id af79cd13be357-8fa8ae850d0mr270887485a.62.1777529777868;
 Wed, 29 Apr 2026 23:16:17 -0700 (PDT)
Date: Thu, 30 Apr 2026 06:16:09 +0000
In-Reply-To: <20260430061610.3503483-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430061610.3503483-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430061610.3503483-2-edumazet@google.com>
Subject: [PATCH net 1/2] net/sched: sch_cake: annotate data-races in
 cake_dump_class_stats (I)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BAE3B49E014
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,toke.dk,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282667-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

cake_dump_class_stats() runs without qdisc spinlock being held.

In this first patch, I add READ_ONCE()/WRITE_ONCE() annotations for:

- flow->head
- flow->dropped
- b->backlogs[]

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) qdisc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_cake.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 13c6d1869a144738c52ffc462f06338bf8245fea..806eb73d6a05e1a7391e4bef55d6aca5052bb8ab 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -914,7 +914,7 @@ static struct sk_buff *dequeue_head(struct cake_flow *flow)
 	struct sk_buff *skb = flow->head;
 
 	if (skb) {
-		flow->head = skb->next;
+		WRITE_ONCE(flow->head, skb->next);
 		skb_mark_not_on_list(skb);
 	}
 
@@ -926,7 +926,7 @@ static struct sk_buff *dequeue_head(struct cake_flow *flow)
 static void flow_queue_add(struct cake_flow *flow, struct sk_buff *skb)
 {
 	if (!flow->head)
-		flow->head = skb;
+		WRITE_ONCE(flow->head, skb);
 	else
 		flow->tail->next = skb;
 	flow->tail = skb;
@@ -1357,7 +1357,7 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 	if (elig_ack_prev)
 		elig_ack_prev->next = elig_ack->next;
 	else
-		flow->head = elig_ack->next;
+		WRITE_ONCE(flow->head, elig_ack->next);
 
 	skb_mark_not_on_list(elig_ack);
 
@@ -1595,11 +1595,11 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	len = qdisc_pkt_len(skb);
 	q->buffer_used      -= skb->truesize;
-	b->backlogs[idx]    -= len;
 	WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
+	WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] - len);
 	sch->qstats.backlog -= len;
 
-	flow->dropped++;
+	WRITE_ONCE(flow->dropped, flow->dropped + 1);
 	WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
 
 	if (q->config->rate_flags & CAKE_FLAG_INGRESS)
@@ -1824,11 +1824,11 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		}
 
 		/* stats */
-		b->backlogs[idx]    += slen;
 		sch->qstats.backlog += slen;
 		q->avg_window_bytes += slen;
 		WRITE_ONCE(b->bytes, b->bytes + slen);
 		WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
+		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
 
 		qdisc_tree_reduce_backlog(sch, 1-numsegs, len-slen);
 		consume_skb(skb);
@@ -1861,11 +1861,11 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		/* stats */
 		WRITE_ONCE(b->packets, b->packets + 1);
-		b->backlogs[idx]    += len - ack_pkt_len;
 		sch->qstats.backlog += len - ack_pkt_len;
 		q->avg_window_bytes += len - ack_pkt_len;
 		WRITE_ONCE(b->bytes, b->bytes + len - ack_pkt_len);
 		WRITE_ONCE(b->tin_backlog, b->tin_backlog + len - ack_pkt_len);
+		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + len - ack_pkt_len);
 	}
 
 	if (q->overflow_timeout)
@@ -1977,7 +1977,7 @@ static struct sk_buff *cake_dequeue_one(struct Qdisc *sch)
 	if (flow->head) {
 		skb = dequeue_head(flow);
 		len = qdisc_pkt_len(skb);
-		b->backlogs[q->cur_flow] -= len;
+		WRITE_ONCE(b->backlogs[q->cur_flow], b->backlogs[q->cur_flow] - len);
 		WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
 		sch->qstats.backlog      -= len;
 		q->buffer_used		 -= skb->truesize;
@@ -2235,7 +2235,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			flow->deficit -= len;
 			b->tin_deficit -= len;
 		}
-		flow->dropped++;
+		WRITE_ONCE(flow->dropped, flow->dropped + 1);
 		WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
 		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 		qdisc_qstats_drop(sch);
@@ -3137,7 +3137,7 @@ static int cake_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 
 		flow = &b->flows[idx % CAKE_QUEUES];
 
-		if (flow->head) {
+		if (READ_ONCE(flow->head)) {
 			sch_tree_lock(sch);
 			skb = flow->head;
 			while (skb) {
@@ -3146,8 +3146,8 @@ static int cake_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 			}
 			sch_tree_unlock(sch);
 		}
-		qs.backlog = b->backlogs[idx % CAKE_QUEUES];
-		qs.drops = flow->dropped;
+		qs.backlog = READ_ONCE(b->backlogs[idx % CAKE_QUEUES]);
+		qs.drops = READ_ONCE(flow->dropped);
 	}
 	if (gnet_stats_copy_queue(d, NULL, &qs, qs.qlen) < 0)
 		return -1;
-- 
2.54.0.545.g6539524ca2-goog


