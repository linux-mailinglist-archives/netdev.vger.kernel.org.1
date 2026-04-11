Return-Path: <netdev+bounces-277662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPyVJx7a2WlOtwgAu9opvQ
	(envelope-from <netdev+bounces-277662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:20:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7363DE675
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5F1D30701BE
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1E2E92D2;
	Sat, 11 Apr 2026 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="VlxBR86/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B51B6CE9
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884654; cv=none; b=pXpZKqMGY9Ytp1lPoGILJRN5Z412T6ZM+ye6WoNHbeyj/MAdlKpRIsRetImY92StY1xpQQcUnwY5J7btXtcAIHmIRvncxwhKL4MZ2PAHr0GYE/zpYDqSv4OrEMX4KVc4Laa1TurVY9SVKZfjwPUIrS9hB3FCh0uCGd5qn940+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884654; c=relaxed/simple;
	bh=hRNNTo28tzEk08AeYgdYXshGuDWJss2IZHA3HL/pL30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svEX2YIBCNuAKDYlXC5oawgHr9qIhYtVZ0GtIo1v5d4Vo7l3KEnx+xaBNqdNq74r38qnfkUS2vyFf26p7plk5EL4Pk/TYimtySx/vrYFWMq2TpSQf2WVXHda2BZx95K6WXrGcNPYaaYAABtPm0PyTblwmSS8WF8j0T9+Khbbzm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=VlxBR86/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1083313a12.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775884651; x=1776489451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMFC+FBTlDJLwZK7hSs6SdzaAG0XCoUsoeen1X8JWeQ=;
        b=VlxBR86/i5dIbLBeSGzE+1NIlGfVp1FKr6aGNBU8SHwl1Fk+kG6vgWfBMFqgcIVy3X
         eSjq/0d1KOEPuOzeMQd/9Af+lcUQYkG6n5y8B0XRFP0vE4UbpeVo216LXbBFJ9Wpakul
         ZKk+M604/oBjo4YVANYQNwn+/JhMZtZlJ8d+z8+KpZ4RyXuZq9nfUJaDEw/MH25on3EM
         d13hEY8+f4sC4lsX7KqxktEuY0FXyVdQ0mhGUzP0lQtmdHr+O4TO5fw3NVla+79zdBh9
         lZlq8KXtCjaizEpRLAWpQaD/ycRWPeZ9EIg2oq4E/mySP92jgwW8K28bJxITWN6SPuMD
         jpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884651; x=1776489451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMFC+FBTlDJLwZK7hSs6SdzaAG0XCoUsoeen1X8JWeQ=;
        b=RtbVaYLsIsccvdEIS7dYuKOQjTtDjIx0BAwzDZ2Io0p9yeYowYbIQs0kieEA+RE+p3
         Eb+YfB40Aam7nKjOima2wMFbKpQSTnAps10iC3BBDMe5pga3ciYBXVWz72xo1GXOyvuA
         Hap2l3Sxc5I6/0oiFP24Z3tI03Cro2OUchfBek4tFEI/2exK2xDBesLAot/Gd/+Ahe2I
         vw3HAI1jAX7MktOZylxe/escbZ2Im3Imk9WAGastWZLQJVgUNsrVmgMF+ohyHi2PyxvY
         zPm0zouNJ+1+adN9Qyf3YU6yziLqPctUDi//D0I3a0+EU4Q8ZQ9yz2RcFgSLoxUhI+Do
         lhEw==
X-Gm-Message-State: AOJu0YxV4A/FIRNduuKSNGY/JV6iyTkk1a20aT7U4f78l0K3+ZRPkDiF
	NybtXVDniR07AfaIB7xOiV9keJNTCMSroS+Biw4Fhx6lDVR2WIjuBvPYt2eAPpk5GCbdFzhzv+I
	GSGyP
X-Gm-Gg: AeBDies0/IGa58gmyIGnPHY17Jx01Z9qz3sd755WhD47uszPUj1dWogUnKaP9b89OgM
	geB8aAay/eY5vkfZXTPsOFDlC18WtSS3nHqGk/jls7kZ463mJLQEVvM0IkW6eMWjZECaPVyVsRG
	8j9t+N05kpZtNvVQJXY5P+t9VUnWfZ+LKkMbwBiDC5nI7axw9J6LLUkigdTKVq1MowodfsQ6Xg/
	tTsn17N5wB1rf9jXxrj0TUheggJNiA1rwwnH8OI4WHRArw6WETI/BC4HfvxaO+h5mStmutuQDvU
	iB3z/BgksgUIhENfZ59nFsBei186CoXmMyzgbqH4/Xfjt6tGvb4kDA+/wGcszy4zhuRpjzKmfYg
	/jwvlc0m/B87sflfHemfJ6MFADYazCsfmKKcOOpUpp9k+FMQrHx6qD5JGbSJv3zdv8jj4wUMXtv
	oVmJ1JGQ1U55wXjypdX3BAJLEE7n0gYKLq
X-Received: by 2002:a05:6a20:3946:b0:39b:f0a1:1498 with SMTP id adf61e73a8af0-39fe407ff77mr6689726637.48.1775884651000;
        Fri, 10 Apr 2026 22:17:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1ef00sm3855700a12.28.2026.04.10.22.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:17:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATTCH net v5 4/8] net/sched: netem: refactor dequeue into helper functions
Date: Fri, 10 Apr 2026 22:15:53 -0700
Message-ID: <20260411051700.311679-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411051700.311679-1-stephen@networkplumber.org>
References: <20260411051700.311679-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277662-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid]
X-Rspamd-Queue-Id: EF7363DE675
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract the tfifo removal, slot accounting, and child/direct dequeue
paths from the monolithic netem_dequeue() into separate helpers:

  netem_pull_tfifo()    - remove head packet from tfifo
  netem_slot_account()  - update slot pacing counters
  netem_dequeue_child() - enqueue to child, then dequeue from child
  netem_dequeue_direct()- dequeue from tfifo when no child

This replaces the goto-based control flow with straightforward function
calls, making the code easier to follow and modify.

No functional change intended.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 190 +++++++++++++++++++++++++++---------------
 1 file changed, 123 insertions(+), 67 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 556f9747f0e7..e264f7aefb97 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -689,99 +689,155 @@ static struct sk_buff *netem_peek(struct netem_sched_data *q)
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
+ * Transfer time-ready packets from the tfifo into the child qdisc,
+ * then dequeue from the child.
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
 	skb = netem_peek(q);
 	if (skb) {
-		u64 time_to_send;
-		u64 now = ktime_get_ns();
+		u64 time_to_send = netem_skb_cb(skb)->time_to_send;
 
-		/* if more time remaining? */
-		time_to_send = netem_skb_cb(skb)->time_to_send;
 		if (q->slot.slot_next && q->slot.slot_next < time_to_send)
 			get_slot_next(q, now);
 
 		if (time_to_send <= now && q->slot.slot_next <= now) {
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
-
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
-			sch->q.qlen--;
-			goto deliver;
-		}
-
-		if (q->qdisc) {
-			skb = q->qdisc->ops->dequeue(q->qdisc);
-			if (skb) {
+			struct sk_buff *to_free = NULL;
+			unsigned int pkt_len;
+			int err;
+
+			skb = netem_pull_tfifo(q, sch);
+			netem_slot_account(q, skb, now);
+
+			pkt_len = qdisc_pkt_len(skb);
+			err = qdisc_enqueue(skb, q->qdisc, &to_free);
+			kfree_skb_list(to_free);
+			if (err != NET_XMIT_SUCCESS) {
+				if (net_xmit_drop_count(err))
+					qdisc_qstats_drop(sch);
+				sch->qstats.backlog -= pkt_len;
 				sch->q.qlen--;
-				goto deliver;
+				qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 			}
 		}
-
-		qdisc_watchdog_schedule_ns(&q->watchdog,
-					   max(time_to_send,
-					       q->slot.slot_next));
 	}
 
-	if (q->qdisc) {
-		skb = q->qdisc->ops->dequeue(q->qdisc);
-		if (skb) {
-			sch->q.qlen--;
-			goto deliver;
-		}
+	skb = q->qdisc->ops->dequeue(q->qdisc);
+	if (skb)
+		sch->q.qlen--;
+
+	return skb;
+}
+
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


