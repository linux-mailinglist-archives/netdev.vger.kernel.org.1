Return-Path: <netdev+bounces-275666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMMlHPPs02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:27:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3203A5AE9
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C720301A7D1
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571C39023B;
	Mon,  6 Apr 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="Kie+xGdk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7B38F63B
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496420; cv=none; b=gnEmQElDzvmNvKa4gNN4cHMLACl40dHSId7IEDXOE/VkdJRQlZRAtt+6qE0cAhWpXusLxtCKQKTesSjbmQc1NrL10bn6RBvwqCigGSC6CJ9W9r0t+pY36OWdLfDwJNmvUystmCp+kt0OuKjB3dabH/i3f36WejcFiW3NsafM57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496420; c=relaxed/simple;
	bh=GLSG8FtIwLjde69qoOu6kXSyzXUvQM1EG/q+3zv/Neo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPylzd3T9XsfhxUe0u/rcSpWTQTSMTvsgWdlNh9gO1B0KirHFvo0XHHXud9LzmLkflCHzo8W15AU8RqbXU4BOY3RpR7QrGuc7x3xzxovI3ydj8MdwF3EsafbcGdy/g0j/x9JN76evgBVLjHrTZ3Ixz/c/QtPlLn/tsraMplTFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=Kie+xGdk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad21f437eeso20999805ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775496418; x=1776101218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAt6MuY3k4AQYrmKu/CCCfGz0vUfJv+Dtwx2Q0voWRA=;
        b=Kie+xGdkJGy2oezjhcS/ayWvRpPbnBfvWlifNXddui1kwVssGptcyvECF5zroyK7GY
         hGBe5ZjRcLBK5xQ3QkV9gXkywS0TQWTFYVMNdwKtOpqw+UwPeiVdrNuxRlzMs48Iuvrr
         KCz76XmTHbaKZsUti7xmLFSCh4mowzDRt5NjpkyCTDC4l1jgbB9yFYOvUfxEybO+Yktw
         6h2hJjHbcujDnqeFQ+BvHTKi0hTXdKB3n2TRs8yOCuXeneqLsipj561sKJ18Yep+3hRa
         NhygfIk1tqZt22GrLnAvl7EJsijsvk3EO9qPgK3l+JyNkh/+aerw1miwYzvUiqPEH0YO
         gzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496418; x=1776101218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IAt6MuY3k4AQYrmKu/CCCfGz0vUfJv+Dtwx2Q0voWRA=;
        b=WlHO/vY4rV5JsgVxuvIBBid9A3XlRWEqEQW0DvOJhgD+lYIdNKkD2pHUcuWOCQ+nCB
         mPOcoHgw//BNQY3MJ0BWgSj4EKpvygjoAfgE3rJ3WRlIjWLUgsbra+SLCSvdjldmyk3p
         uLNeSSqGG3hn7tWoDyt5nfisUW9WEaU7Ea/LcbZm5Ld2vIT0H85Li+oojsqYkW0N+SHG
         IYya8m26xOHPxHmYfSv0iDOJrGEen7sDZSdRd+6YRWXm8SdRaQUD5whFuL9HFYaCTDjy
         uAFIE4m4Vsv2DVURp/H5ZaTPXhOeLJzTEA9B4HVDENu4OiVgkeLNvewHha0XrcqxYsAQ
         Kz/Q==
X-Gm-Message-State: AOJu0Yy/mb7iArhAmRVLUPmUFbBI+iSs7GKVGM71QcQz8X6cbVeUHLic
	EJJCy1fIZ9GnkG7SLiuza6JplDtReS347GbDeLo57XwZhE4fTFmU3aO5zj+jLG65hfoRJXPAkqH
	2LX2y
X-Gm-Gg: AeBDietvLyHxYlvmH7heXJHjq9SBXxWb8WHEnVQhyQomWrwQ3lSHmy1Sb9cyWNoCy0A
	WVMXLBEO0JOr0/xIDqwjR0MI8GCT3qQeKrR5/zUVDdYgN9+8c2+D9rwsfR6EMxX88D+Yt4xZE4E
	ordlob34gBkfXEbVQVO6krJNe1Em4qR1wdIm8dun3iKE12GyOO0K4LnH2PZirkgivuvRLrz+O6K
	RJ8X+jXt5xTjP1DEARZbkUp8Li8YTzhRiT2VZRx7JlgR1h9AEjlptmSmylxl0A220ob1mjhYgYO
	worE/vlppk9+x8gb7KC9Bc/W+ccAgKkKAc5iNMoc7W5dRDiGBRmp48F7U+p7jQI85m/0H6moIU/
	SwF+iEMapU3dRddUB08gEZJQTPe9wXDX4FcAk+WmaXBACmGuJ3/u5k7ras1FwyL2XXpNrBr2Ywl
	d8qtLP4tlBgfYVrM5QraLFmPRglcpLiurr
X-Received: by 2002:a17:903:4b03:b0:2ae:5a38:96bb with SMTP id d9443c01a7336-2b277d633f8mr157734695ad.2.1775496418528;
        Mon, 06 Apr 2026 10:26:58 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm146437945ad.26.2026.04.06.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:26:58 -0700 (PDT)
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
Subject: [PATCH net v4 4/8] net/sched: netem: refactor dequeue into helper functions
Date: Mon,  6 Apr 2026 10:25:12 -0700
Message-ID: <20260406172627.210894-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406172627.210894-1-stephen@networkplumber.org>
References: <20260406172627.210894-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.56 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275666-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0D3203A5AE9
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


