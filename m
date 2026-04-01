Return-Path: <netdev+bounces-274142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MqyKKc1zWlwawYAu9opvQ
	(envelope-from <netdev+bounces-274142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D1B37CC65
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE34F3128548
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1E46AF31;
	Wed,  1 Apr 2026 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="L82tw11b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BF44D693
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055222; cv=none; b=NP3d9r8f1eC8ikoRDOx+GoPbCSCVZeK3FodxZUI/7phpy2nZ09P5E+QFuxF8BSwqKA9W1krc8ebjq0m0PKF63Y9kvcXqYIu9dukDDxX5HPDatLjHBqeC7lxvsOhFhAocU4ZRjcN89mCilVcDeAgs11CHabF2AJH6vA7cxxp5dQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055222; c=relaxed/simple;
	bh=TOAKlDfWzkgQtJ9z1HH1Fm0oFhes+H4PHDuXFVXaQj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dINnzHPYddUPdd4hTwwltazQmdrbWtriCEdvIcngj+cw1ervnR8IAKt+aF6NK+03/rEcj4GObbL5jedobUXiCCGHoKOv5V2+DRM5/GDtMtsHoRuJBPrSvzNVOHkF+hv5N0tIZBvXGuelCIL0r3uvIH2uc8qXpPcfc2kAWDG8JEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=L82tw11b; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ca4ff720ccso122952eec.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775055220; x=1775660020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muqqZpGr47aKejirv9NV6VhTuEnxkRoIgVczQSZpOIU=;
        b=L82tw11bkBgPCy/OpHnDn3rcbsk7x5YtqYHrRFNAd7NaLJ2oufGyR8pFXCwv7Uh5eT
         a5ihU3WLwz2R3d2+fg72O8VFMoJ74rEXsgrWw3jEsouL/clT7RIxjWpQuOXMJtRKG8IJ
         8ZWqd5ZwLzmsfeu//n0othQ08zZLTQT0gaCNcDCOA9duf3B3YXDDQcMy4wKpZwSNdwCf
         YfdyIqCR+wajfuafgvSRj22XDZZCZ/6WLWzXMRvaJoGw20BhVoOoN6/1Wme22vjU4Tf7
         Rg4KziAfyyPi50bw0DGKNlCwGWF1UBjD7F8kE+3SyJFWt6qbkxTsBi6a0p13fAIMXcTS
         zGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055220; x=1775660020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=muqqZpGr47aKejirv9NV6VhTuEnxkRoIgVczQSZpOIU=;
        b=TkZz+Gu2tzqey6LfX5bTABief2PRjhvxvz3pnL8geoEL9b/qnmf92FrfUSPl3ld9bj
         No98DP72ZU9FLl22EGTrfGSYDWa54OEdkry+N1CXwtzdGD4U7+QT8bvzzcy8sQMK3qy8
         tZytKqKnmv6duMMTwXhkDRv06npxtURvZqNuMT+bSKEopkF9B3NMskRKB6MT2/P2VF/V
         d7g740obBbZukOmEBNPLUoLCpaHFOYtu4DCKKnRkpXdBvBkfPCYJR+YLSz2eCS33qvBD
         FM1h/llPBNVp797ujY1e5dX4eeWM20zsl6hzaJE53fjJFM91zJb4DZm2GQb6EDpk+MhW
         8jpQ==
X-Gm-Message-State: AOJu0YwKYyJgPdxkV1jqQvGdixDAwWPe9IKkRngDGlHtFp5ZvsVP1zJ6
	976zUS5/tHv2ECdGYAO9DuUw/W4sqAA3464bstyATzA3fsd4HxdqLmmogGdFwYatK3nACOdTU++
	ip9w7
X-Gm-Gg: ATEYQzxb6QNUeV/PcBwxfo5eNKiOXgsq9Y5tZgULUPj2AIyvSqbRmqvCg2mNg2Z2J9j
	qWG61Zdk4oGRyIxL4CMje+tPz70W4w9QD8GNFeSGm0IDEyH1Sg139vNguy+QkYBFXIhmD8cdikc
	UeXK4fe0LfNsJmN2pTGAnaN21UR+vHbgFI3ibr9KBo+PHgrCtQq/DTjFX+XDGShZAj9q3LhGKYd
	ehtvV8t2KXjbXp9rPEEEx7yqRYsbvSPdzEHDNg5nTdGcsOKYJv2ea3KPe93BeWPwUjjPZiK71/T
	UoMHmdr8NZPlUVy3mnz2jK5IZkL/ux3p4QTHxHbQ7pLxMyLgN5OYdd1+W6EFl6xsK050wyCrCcG
	QMYzdOXIvp3ehx+7UHZol7XcRr82Tf3uMOHEEcijmQNodqw/RkT5fPZrJ1k0TcDZ0RFXh+SrQeF
	rJl7GSsL3Ze+W4d+FcsMaq/0oyUIIWod+N
X-Received: by 2002:a05:7301:100a:b0:2c6:e4f:5dab with SMTP id 5a478bee46e88-2c7bb44cf45mr3920020eec.6.1775055220254;
        Wed, 01 Apr 2026 07:53:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm12804830eec.6.2026.04.01.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:53:39 -0700 (PDT)
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
Subject: [PATCH net v2 4/7] net/sched: netem: restructure dequeue to avoid re-entrancy with child qdisc
Date: Wed,  1 Apr 2026 07:51:56 -0700
Message-ID: <20260401145332.78285-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401145332.78285-1-stephen@networkplumber.org>
References: <20260401145332.78285-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274142-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99D1B37CC65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem_dequeue() enqueues packets into its child qdisc while being
called from the parent's dequeue path. This causes two problems:

- HFSC tracks class active/inactive state on qlen transitions.
  A child enqueue during dequeue causes double-insertion into
  the eltree (CVE-2025-37890, CVE-2025-38001).

- Non-work-conserving children like TBF may refuse to dequeue
  packets just enqueued, causing netem to return NULL despite
  having backlog. Parents like DRR then incorrectly deactivate
  the class.

Split the dequeue into helpers:

  netem_pull_tfifo()    - remove head packet from tfifo
  netem_slot_account()  - update slot pacing counters
  netem_dequeue_child() - batch-transfer ready packets to the
                          child, then dequeue from the child
  netem_dequeue_direct()- dequeue from tfifo when no child

When a child qdisc is present, all time-ready packets are moved
into the child before calling its dequeue. This separates the
enqueue and dequeue phases so the parent sees consistent qlen
transitions.

Fixes: 50612537e9ab ("netem: fix classful handling")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 201 +++++++++++++++++++++++++++---------------
 1 file changed, 128 insertions(+), 73 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 448097fc88a4..ce12b64603b2 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -688,99 +688,154 @@ static struct sk_buff *netem_peek(struct netem_sched_data *q)
 	return q->t_head;
 }
 
-static void netem_erase_head(struct netem_sched_data *q, struct sk_buff *skb)
+/*
+ * Pop the head packet from the tfifo and prepare it for delivery.
+ * skb->dev shares the rbnode area and must be restored after removal.
+ */
+static struct sk_buff *netem_pull_tfifo(struct netem_sched_data *q,
+					struct Qdisc *sch)
 {
-	if (skb == q->t_head) {
+	struct sk_buff *skb;
+
+	if (q->t_head) {
+		skb = q->t_head;
 		q->t_head = skb->next;
 		if (!q->t_head)
 			q->t_tail = NULL;
 	} else {
-		rb_erase(&skb->rbnode, &q->t_root);
+		struct rb_node *p = rb_first(&q->t_root);
+
+		if (!p)
+			return NULL;
+		skb = rb_to_skb(p);
+		rb_erase(p, &q->t_root);
 	}
+
+	q->t_len--;
+	skb->next = NULL;
+	skb->prev = NULL;
+	skb->dev = qdisc_dev(sch);
+
+	return skb;
 }
 
-static struct sk_buff *netem_dequeue(struct Qdisc *sch)
+/* Update slot pacing counters after releasing a packet */
+static void netem_slot_account(struct netem_sched_data *q,
+			       const struct sk_buff *skb, u64 now)
+{
+	if (!q->slot.slot_next)
+		return;
+
+	q->slot.packets_left--;
+	q->slot.bytes_left -= qdisc_pkt_len(skb);
+	if (q->slot.packets_left <= 0 || q->slot.bytes_left <= 0)
+		get_slot_next(q, now);
+}
+
+/*
+ * Transfer all time-ready packets from the tfifo into the child qdisc,
+ * then dequeue from the child.  Batching the transfers avoids calling
+ * qdisc_enqueue() inside the parent's dequeue path, which confuses
+ * parents that track active/inactive state on qlen transitions (HFSC).
+ */
+static struct sk_buff *netem_dequeue_child(struct Qdisc *sch)
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
+	u64 now = ktime_get_ns();
 	struct sk_buff *skb;
 
-tfifo_dequeue:
-	skb = __qdisc_dequeue_head(&sch->q);
-	if (skb) {
-deliver:
-		qdisc_qstats_backlog_dec(sch, skb);
-		qdisc_bstats_update(sch, skb);
-		return skb;
-	}
-	skb = netem_peek(q);
-	if (skb) {
-		u64 time_to_send;
-		u64 now = ktime_get_ns();
-
-		/* if more time remaining? */
-		time_to_send = netem_skb_cb(skb)->time_to_send;
-		if (q->slot.slot_next && q->slot.slot_next < time_to_send)
-			get_slot_next(q, now);
-
-		if (time_to_send <= now && q->slot.slot_next <= now) {
-			netem_erase_head(q, skb);
-			q->t_len--;
-			skb->next = NULL;
-			skb->prev = NULL;
-			/* skb->dev shares skb->rbnode area,
-			 * we need to restore its value.
-			 */
-			skb->dev = qdisc_dev(sch);
-
-			if (q->slot.slot_next) {
-				q->slot.packets_left--;
-				q->slot.bytes_left -= qdisc_pkt_len(skb);
-				if (q->slot.packets_left <= 0 ||
-				    q->slot.bytes_left <= 0)
-					get_slot_next(q, now);
-			}
+	while ((skb = netem_peek(q)) != NULL) {
+		struct sk_buff *to_free = NULL;
+		unsigned int pkt_len;
+		int err;
 
-			if (q->qdisc) {
-				unsigned int pkt_len = qdisc_pkt_len(skb);
-				struct sk_buff *to_free = NULL;
-				int err;
-
-				err = qdisc_enqueue(skb, q->qdisc, &to_free);
-				kfree_skb_list(to_free);
-				if (err != NET_XMIT_SUCCESS) {
-					if (net_xmit_drop_count(err))
-						qdisc_qstats_drop(sch);
-					sch->qstats.backlog -= pkt_len;
-					sch->q.qlen--;
-					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
-				}
-				goto tfifo_dequeue;
-			}
+		if (netem_skb_cb(skb)->time_to_send > now)
+			break;
+		if (q->slot.slot_next && q->slot.slot_next > now)
+			break;
+
+		skb = netem_pull_tfifo(q, sch);
+		netem_slot_account(q, skb, now);
+
+		pkt_len = qdisc_pkt_len(skb);
+		err = qdisc_enqueue(skb, q->qdisc, &to_free);
+		kfree_skb_list(to_free);
+		if (unlikely(err != NET_XMIT_SUCCESS)) {
+			if (net_xmit_drop_count(err))
+				qdisc_qstats_drop(sch);
+			sch->qstats.backlog -= pkt_len;
 			sch->q.qlen--;
-			goto deliver;
+			qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 		}
+	}
 
-		if (q->qdisc) {
-			skb = q->qdisc->ops->dequeue(q->qdisc);
-			if (skb) {
-				sch->q.qlen--;
-				goto deliver;
-			}
-		}
+	skb = q->qdisc->ops->dequeue(q->qdisc);
+	if (skb)
+		sch->q.qlen--;
 
-		qdisc_watchdog_schedule_ns(&q->watchdog,
-					   max(time_to_send,
-					       q->slot.slot_next));
-	}
+	return skb;
+}
 
-	if (q->qdisc) {
-		skb = q->qdisc->ops->dequeue(q->qdisc);
-		if (skb) {
-			sch->q.qlen--;
-			goto deliver;
-		}
+/* Dequeue directly from the tfifo when no child qdisc is configured. */
+static struct sk_buff *netem_dequeue_direct(struct Qdisc *sch)
+{
+	struct netem_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb;
+	u64 time_to_send;
+	u64 now;
+
+	skb = netem_peek(q);
+	if (!skb)
+		return NULL;
+
+	now = ktime_get_ns();
+	time_to_send = netem_skb_cb(skb)->time_to_send;
+
+	if (q->slot.slot_next && q->slot.slot_next < time_to_send)
+		get_slot_next(q, now);
+
+	if (time_to_send > now || q->slot.slot_next > now)
+		return NULL;
+
+	skb = netem_pull_tfifo(q, sch);
+	netem_slot_account(q, skb, now);
+	sch->q.qlen--;
+
+	return skb;
+}
+
+static struct sk_buff *netem_dequeue(struct Qdisc *sch)
+{
+	struct netem_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb;
+
+	/* First check the reorder queue */
+	skb = __qdisc_dequeue_head(&sch->q);
+	if (skb)
+		goto deliver;
+
+	if (q->qdisc)
+		skb = netem_dequeue_child(sch);
+	else
+		skb = netem_dequeue_direct(sch);
+
+	if (skb)
+		goto deliver;
+
+	/* Nothing ready — schedule watchdog for next packet */
+	skb = netem_peek(q);
+	if (skb) {
+		u64 time_to_send = netem_skb_cb(skb)->time_to_send;
+
+		qdisc_watchdog_schedule_ns(&q->watchdog,
+					   max(time_to_send, q->slot.slot_next));
 	}
 	return NULL;
+
+deliver:
+	qdisc_qstats_backlog_dec(sch, skb);
+	qdisc_bstats_update(sch, skb);
+	return skb;
 }
 
 static void netem_reset(struct Qdisc *sch)
-- 
2.53.0


