Return-Path: <netdev+bounces-277509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK/OJI5A2WkHnwgAu9opvQ
	(envelope-from <netdev+bounces-277509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:25:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C43DB710
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0843303C4EE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E73E1D1F;
	Fri, 10 Apr 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkEFlUTw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC933C187
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845399; cv=none; b=pqBURvLTteAAW2a+Mkw83HwmQ5+Plk5LEGZctJCFNM2ix67qOYE3/V6k/UvuAQc6SylCjvfT00CBAcLTyWvjMEsQYgi+p4AMu5ZbfbHn7f5pchR4R35iIsgiZeniGnG97Sa9cGCKEoF2z3GYXFRs+7yflfpJmTl2/FacEY2c01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845399; c=relaxed/simple;
	bh=1V3vqvi/JBOLyCskOpWmHzYqj/ULhNcAebQht7m3ogE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=anY/8UBgJd+dc3jU44aiCIGVT+tuJ+ORborU8FmI+bg5SNJYJmwLjuDIxnXp9Ac4D0O4JSvQ2xNbq72aQlx8nR1DiAGTxuxPdblDikkcd/LztlBQxnwH43m5Rm/oMoqMvvEBzBAk+SZd7wuM3w2o22rmJOV+7WXiUo0cTKz8LGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkEFlUTw; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d4c2906fdfso251652285a.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845397; x=1776450197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTI7yAOZ81X1QYzsQpHkzfNkmBAzrCB/2s80AeMaadQ=;
        b=dkEFlUTwaPgVRHC/p87MauYAy9hnB1CQqj0fpTZG5dssLIFY8S5uGiKxEPoWfRxKGR
         vfnBy2V3bkmqyftNGgYUJvS2A/DlmHnlUaWv6GLwtngcUMyTxoMu3E1QBDp9JZRGmkyO
         lfoKSfRFuqeaMmDfoQi/kWOFIp9tmaY3SmUGqgrtVwXdSgdXp4HOnp+X9ru4IeP3tO8Y
         7JNyPvbUYbIQ70NAzEglx7yEr8f+BeL0WcyPzapphUhFReuGa2DTm6knJWqeZR3AC+Q6
         lyOuyedrc1ZDlXv8ogyMrWsuzTrUpkBk9Bk6zIqW27ei1lF7+wpM/M2XSw8vIUlN//bQ
         x5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845397; x=1776450197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTI7yAOZ81X1QYzsQpHkzfNkmBAzrCB/2s80AeMaadQ=;
        b=T6/MzD/4tIeJIhC8aNIrvrMtY/BC5XLNaVM761owkkVTW9j2qXUoFATHvOGWlMshay
         fJU0SiYnruVv7prbMFgPRez+ppFH1UEMzyTMww7N1ntSgUdOvBd+qjAeisv7ZLdeppe4
         GX7iUpT/Xin8/6D4Xs9u6mc7joSG2DpB5RlOJ8pHSD5DDJjXg91ZTWttJuy11AQooGO5
         zWnMoz6VWKvkBQNtFlVzQiLUXbPztCLbaIVm5Hw96ixxSTPCIK1TKM+BNeXj8PSm4ac2
         UAdFGSdwkJEBFb7u+9etJTs6uK/t4Ola1nsrH+AOY0erJm8qYWdXVgivocWevPovA3YT
         zyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWix735uv1IVrcjY5S0jhPG8AVTtGOd44Dz5qZ4aId4JpWOIHrSGKHGwy+HHOQlwsPS59awaOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfi0OooKXqGTasP7VyMBYQf1mCRW7qKLvvx5WVD7mEKLogQqdH
	b0Q67jMysylRi9aHxNprfGTlTfmv/keFfM6iGqpCsSKe9MEeR0/NeUULFoWuVnXxUC0B0zG0LsY
	zrgV6BIPGL7m7PA==
X-Received: from qkbg18.prod.google.com ([2002:a05:620a:a352:b0:8d4:dc72:da52])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3705:b0:8dd:7422:6934 with SMTP id af79cd13be357-8ddcfea0d0amr633131185a.44.1775845396596;
 Fri, 10 Apr 2026 11:23:16 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:49 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-8-edumazet@google.com>
Subject: [PATCH v3 net-next 07/15] net/sched: sch_red: annotate data-races in red_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277509-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EF8C43DB710
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
---
 net/sched/sch_red.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 7db97c96351309bc3e64fa50570a1928f2b2ce55..268f1ba4520cd74da60e7b1ca08974fcfdced680 100644
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
 		qstats_backlog_add(sch, len);
 		qdisc_qlen_inc(sch);
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
2.53.0.1213.gd9a14994de-goog


