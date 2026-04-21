Return-Path: <netdev+bounces-280147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DW8AuyJ52kU9wEAu9opvQ
	(envelope-from <netdev+bounces-280147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA1943C0C5
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91244306A93A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997223CF67C;
	Tue, 21 Apr 2026 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7KU7BgN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDC19005E
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781401; cv=none; b=RBa+2ZrtYVybNfWTB6UCESzQlmNgWswUTGiYoXwzRifkK6OS3+Xzm8SulmTIuI62Hc8/lVm9wt65WVdAbl+1uPGcgQ7NzfiXvN/D63DjuX4Yg3rofBbcVEwov4jJl/CuSlwsruLJQJn86/SNj3hB6sG5yguk0vH2qrJ8Wkgsu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781401; c=relaxed/simple;
	bh=CVS8sOvNdZ852Qzu8ZH6Giwy4M9vgbwSWvF0gwjHpak=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D85RWLaFch4myYh32cKUwli+aRDTMuGhMri90Jfx0xI/M2fy9Htb/W1r+hPH22oFVDrBrFcNIdHS9maycSzxC57In+xVZfZ4f/i0y9YON5iIcbGEJHOWFHtXbraSlXj72FFIj8zRXrcyERHu/mwyHUjVeMpiORhlpYG6wYQG/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7KU7BgN; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8ebbe171210so473280785a.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776781399; x=1777386199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5hEfqox7TtmfOu2LDfsRSMliOt5sXtTkkR/qyZyLzxI=;
        b=F7KU7BgNBsmfmiw5nMOJxoMA1m2LKfCUNy5y3XfhFCoq6T1S+RdeEWNHyepwK482sc
         qv/oaswvHo0Y34dcKazRiFplZ0ybMrrS0f9kd6IQeeW5ZQ4CkT+5RXgyA3UewCYWnAwL
         Ii85uXlcQyhOvymWj42z5VIHbNvKY+fpZQ87N1g4/OziXG+gGyftu2VoOVHWfCbldk+6
         ZEePRfY+1QT1j5TgQEbA/PZH/Z+86is59gSCheRc4Wi+XEDbKzPhRwhWN3+EYXd/Ur1f
         zufaRM/OwNqbsaYaxqoJVo8btkF5h6vZvbOef5V40lcsvqciOGBuFtT0jdbljVQQVNcK
         xa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781399; x=1777386199;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hEfqox7TtmfOu2LDfsRSMliOt5sXtTkkR/qyZyLzxI=;
        b=ZaLYDT2wQBI3/PddOUrRaM7bSs+nOMgkXRPLBZghcP1U6TXg1xlwmO9Aq2bsnFOD58
         Tu9/xV1v6tMVDh1d5n0ss1jiz5OQft1soCidy4PgyfEZdL7GczU0YPk9jfB5Vb/l9+V2
         TFuUUxrfUVny9oDRAvQRjYxnODMBY7Q2JSt+pKV+Td0mio2eqLjmjKPqx7xMoX8Mfh6E
         kxoottlaJAlrJlJVdOxtR+GysLTLbeWtT+IdzyAKJBU2f5QM9WNxHnkXyzY6lhW/OWNJ
         34eu7ODTa1trmc9BDBhrr55dM7Fc9l7UzadeiXHc0a55RYDJ5KdPiNEwsuUnBIroyPwt
         Evkw==
X-Forwarded-Encrypted: i=1; AFNElJ/MLFlb4ViWS9N56Ymmu0DGPoCq0oqhILadtfriRdfPXa7i7Tgsn+LqvvQloE/uNF3wuA29r8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5J427J1um2mjjI2N0BxTEzBdhEf5jzftT961mFImhuQ9un8qL
	RCxeQV6UFcW9nKShyRa4TB02MjslYN+dAX7j10lYCKBYMdpSKwsj1U2gAl7mnteBXYa7oQXCJOu
	eIf9RJ8tQEbovsw==
X-Received: from qkntn21.prod.google.com ([2002:a05:620a:3c15:b0:8cd:78b2:a5f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2a16:b0:8d6:dd76:a539 with SMTP id af79cd13be357-8e78f7339e8mr2712041085a.17.1776781398765;
 Tue, 21 Apr 2026 07:23:18 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:23:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421142309.3964322-1-edumazet@google.com>
Subject: [PATCH net] net/sched: sch_red: annotate data-races in red_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280147-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5AA1943C0C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

red_dump_stats() only runs with RTNL held,
reading fields that can be changed in qdisc fast path.

Add READ_ONCE()/WRITE_ONCE() annotations.

Alternative would be to acquire the qdisc spinlock, but our long-term
goal is to make qdisc dump operations lockless as much as we can.

tc_red_xstats fields don't need to be latched atomically,
otherwise this bug would have been caught earlier.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_red.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index c8d3d09f15e3919d6468964561130bfc79fb215b..432b8a3000a57b4688b3ddb5501f604d5752c67c 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -90,17 +90,20 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	case RED_PROB_MARK:
 		qdisc_qstats_overlimit(sch);
 		if (!red_use_ecn(q)) {
-			q->stats.prob_drop++;
+			WRITE_ONCE(q->stats.prob_drop,
+				   q->stats.prob_drop + 1);
 			goto congestion_drop;
 		}
 
 		if (INET_ECN_set_ce(skb)) {
-			q->stats.prob_mark++;
+			WRITE_ONCE(q->stats.prob_mark,
+				   q->stats.prob_mark + 1);
 			skb = tcf_qevent_handle(&q->qe_mark, sch, skb, to_free, &ret);
 			if (!skb)
 				return NET_XMIT_CN | ret;
 		} else if (!red_use_nodrop(q)) {
-			q->stats.prob_drop++;
+			WRITE_ONCE(q->stats.prob_drop,
+				   q->stats.prob_drop + 1);
 			goto congestion_drop;
 		}
 
@@ -111,17 +114,20 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		reason = QDISC_DROP_OVERLIMIT;
 		qdisc_qstats_overlimit(sch);
 		if (red_use_harddrop(q) || !red_use_ecn(q)) {
-			q->stats.forced_drop++;
+			WRITE_ONCE(q->stats.forced_drop,
+				   q->stats.forced_drop + 1);
 			goto congestion_drop;
 		}
 
 		if (INET_ECN_set_ce(skb)) {
-			q->stats.forced_mark++;
+			WRITE_ONCE(q->stats.forced_mark,
+				   q->stats.forced_mark + 1);
 			skb = tcf_qevent_handle(&q->qe_mark, sch, skb, to_free, &ret);
 			if (!skb)
 				return NET_XMIT_CN | ret;
 		} else if (!red_use_nodrop(q)) {
-			q->stats.forced_drop++;
+			WRITE_ONCE(q->stats.forced_drop,
+				   q->stats.forced_drop + 1);
 			goto congestion_drop;
 		}
 
@@ -135,7 +141,8 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		sch->qstats.backlog += len;
 		sch->q.qlen++;
 	} else if (net_xmit_drop_count(ret)) {
-		q->stats.pdrop++;
+		WRITE_ONCE(q->stats.pdrop,
+			   q->stats.pdrop + 1);
 		qdisc_qstats_drop(sch);
 	}
 	return ret;
@@ -463,9 +470,13 @@ static int red_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED,
 					      &hw_stats_request);
 	}
-	st.early = q->stats.prob_drop + q->stats.forced_drop;
-	st.pdrop = q->stats.pdrop;
-	st.marked = q->stats.prob_mark + q->stats.forced_mark;
+	st.early = READ_ONCE(q->stats.prob_drop) +
+		   READ_ONCE(q->stats.forced_drop);
+
+	st.pdrop = READ_ONCE(q->stats.pdrop);
+
+	st.marked = READ_ONCE(q->stats.prob_mark) +
+		    READ_ONCE(q->stats.forced_mark);
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
 }
-- 
2.54.0.rc2.533.g4f5dca5207-goog


