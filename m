Return-Path: <netdev+bounces-277138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJp6GCMf2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:50:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C279A3D005A
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C14E302D0B7
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BE9374E7F;
	Thu,  9 Apr 2026 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZJl9f1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8453341ADF
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771369; cv=none; b=PH+Nyk4XvsjnXyXDVXi0NlaL4pnjkqEWY6FsjIABc/iJlxQeJXR3YsgIAV7WmoSn9Q6grjLXRF9hdpkCpN92xfI3pAe6VyGwVsJ5tbNcWfmYeIgpn5zNYctJBl9fPk8o7lWEC6kCWzAeFNJPyx24Q2iDH4eTAx9f4IGt/HTOZuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771369; c=relaxed/simple;
	bh=WBZ5rV1P8t3IJkV/ibcR6IrrHNu0cxjLRqE7kz8CEY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VT1v666iJE7VWdeGbWTmvUJK1rYCZYdm79WUUhPuvJvznojXdR4IfwRgL+dnuQVsamVVwQfUvAnF249HYwYkQ+7fwGwookbT7lRGnKE0pSs4e65e4uBebs7ojN7bQZeWd1wnpUWZg7LxYm2B/qAN4/g4l1er9EIkF2AiE1nh7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZJl9f1m; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cfc1bc572cso256665785a.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771366; x=1776376166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAA5IEIg/EkYdnvoWxMQuLZJn6OTNTQT9X/s82sOO+M=;
        b=TZJl9f1mlMH8OyyeIMSX6ZB2IRML8ullJJBBu6ILIFVcwv0cGoUNcK0k8yl/27hm7S
         fl9dHmbaV3VBt9KSbtOZgSCGk6rI97PqyadAZkPdk3WIA/bHcianVAm8FYUOTY/KYKai
         BU9fTJKA3m0iQOjzj5isoF5PvNoiJEBRT4pY1XhB/cWbH6LJKAXudNt5cxO+sCssuLmR
         LxKB7fGSUlpJ2U2yT0EcRK4BhqMgN5PqjpCS4rvSajkze4s2TD1LMemBRctppcRCSDi1
         pHux+o9cVWuYOY4dzh8055BhD808ndA426ByIwM8ULpCHYZZD/AfBx2mDSOwJQyko+1U
         9I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771366; x=1776376166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAA5IEIg/EkYdnvoWxMQuLZJn6OTNTQT9X/s82sOO+M=;
        b=lUyVjS+1KuB8kYoJZniylRvRRgRWmElhIiBPtlKjK+lRRkL5eZxQ4vgmS1AImiDavf
         B1wPEHod6F9nddbMuKkw8VtgCro4H9GagVMHzvU5m9J22C2Nq7a17+tiDpRpZ3ly+nVM
         PLUF0NjkE+sMfsulQ1WiXilBkuz5BH3XVl4E8bqTUPjUPbP3A7iMXkQUNyzYegyMw18e
         2YwmsrpGIKRAl761ODK66d1c+ZbUwI+KJ7YT2OIR8zZabIFfnYYCp7d/ShrORzrk+tOl
         V5dHre3CUT4lzeGmB+MCtkyPAmEPaIc/DGv25Hpzmas1uIR+FFkXW7PTTE3tH5phBPji
         SQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCVS8aBkq+EgMeUIdAmz85iOrNgty9f6kEfOATHEZuwWImx8k+gFmApHFMkDcJuxveug82zLOj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFbSAGsjXu53VIcY+vK29c2+V34WoURJ5sPhT38dIW0QfGUogX
	f+lY6FB+73wMbH/sz4hhxdsj2Y418ADLhmNbY8PiYESfikicPLHawkmRz/wUiddB0HPqvig6Ke/
	CNBAXCG2QjMEglg==
X-Received: from qknqh4.prod.google.com ([2002:a05:620a:6684:b0:8d0:85d:4ba8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:170f:b0:8d0:8f7:36b4 with SMTP id af79cd13be357-8ddceecb5bfmr95906785a.32.1775771366274;
 Thu, 09 Apr 2026 14:49:26 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:04 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/15] net/sched: annotate data-races around sch->qstats.backlog
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277138-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C279A3D005A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add qstats_backlog_sub() and qstats_backlog_add() helpers
and use them instead of open-coding them.

These helpers use WRITE_ONCE() to prevent store-tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 16 +++++++++++++---
 net/sched/sch_api.c       |  2 +-
 net/sched/sch_cake.c      |  8 ++++----
 net/sched/sch_cbs.c       |  2 +-
 net/sched/sch_codel.c     |  2 +-
 net/sched/sch_drr.c       |  2 +-
 net/sched/sch_ets.c       |  2 +-
 net/sched/sch_fq_codel.c  |  4 ++--
 net/sched/sch_fq_pie.c    |  4 ++--
 net/sched/sch_hfsc.c      |  2 +-
 net/sched/sch_htb.c       |  2 +-
 net/sched/sch_netem.c     |  2 +-
 net/sched/sch_prio.c      |  2 +-
 net/sched/sch_qfq.c       |  2 +-
 net/sched/sch_red.c       |  2 +-
 net/sched/sch_sfb.c       |  4 ++--
 net/sched/sch_sfq.c       |  2 +-
 net/sched/sch_tbf.c       |  4 ++--
 18 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 84acf7ac42cb5173d151d98fa0ea603e9cc80d69..2a07f45e6e915a03389ac54328ba500ca0cbe309 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -965,10 +965,15 @@ static inline void qdisc_bstats_update(struct Qdisc *sch,
 	bstats_update(&sch->bstats, skb);
 }
 
+static inline void qstats_backlog_sub(struct Qdisc *sch, u32 val)
+{
+	WRITE_ONCE(sch->qstats.backlog, sch->qstats.backlog - val);
+}
+
 static inline void qdisc_qstats_backlog_dec(struct Qdisc *sch,
 					    const struct sk_buff *skb)
 {
-	sch->qstats.backlog -= qdisc_pkt_len(skb);
+	qstats_backlog_sub(sch, qdisc_pkt_len(skb));
 }
 
 static inline void qdisc_qstats_cpu_backlog_dec(struct Qdisc *sch,
@@ -977,10 +982,15 @@ static inline void qdisc_qstats_cpu_backlog_dec(struct Qdisc *sch,
 	this_cpu_sub(sch->cpu_qstats->backlog, qdisc_pkt_len(skb));
 }
 
+static inline void qstats_backlog_add(struct Qdisc *sch, u32 val)
+{
+	WRITE_ONCE(sch->qstats.backlog, sch->qstats.backlog + val);
+}
+
 static inline void qdisc_qstats_backlog_inc(struct Qdisc *sch,
 					    const struct sk_buff *skb)
 {
-	sch->qstats.backlog += qdisc_pkt_len(skb);
+	qstats_backlog_add(sch, qdisc_pkt_len(skb));
 }
 
 static inline void qdisc_qstats_cpu_backlog_inc(struct Qdisc *sch,
@@ -1294,7 +1304,7 @@ static inline void qdisc_update_stats_at_enqueue(struct Qdisc *sch,
 		qdisc_qstats_cpu_qlen_inc(sch);
 		this_cpu_add(sch->cpu_qstats->backlog, pkt_len);
 	} else {
-		sch->qstats.backlog += pkt_len;
+		qstats_backlog_add(sch, pkt_len);
 		qdisc_qlen_inc(sch);
 	}
 }
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 0dd3efd86393870e9695dddb4a471c5bf854f81e..292bc8bb7a79922a83865ed54083c04ff72742ff 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -806,7 +806,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 			cops->qlen_notify(sch, cl);
 		}
 		WRITE_ONCE(sch->q.qlen, sch->q.qlen - n);
-		sch->qstats.backlog -= len;
+		qstats_backlog_sub(sch, len);
 		__qdisc_qstats_drop(sch, drops);
 	}
 	rcu_read_unlock();
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 0a8b067ba8ecbb85bd6f96ee9e5e959ba5e2efae..0104c29b20f8e43ffa025f0eb58bfe4e2b801010 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1596,7 +1596,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	q->buffer_used      -= skb->truesize;
 	b->backlogs[idx]    -= len;
 	b->tin_backlog      -= len;
-	sch->qstats.backlog -= len;
+	qstats_backlog_sub(sch, len);
 
 	flow->dropped++;
 	b->tin_dropped++;
@@ -1826,7 +1826,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		b->bytes	    += slen;
 		b->backlogs[idx]    += slen;
 		b->tin_backlog      += slen;
-		sch->qstats.backlog += slen;
+		qstats_backlog_add(sch, slen);
 		q->avg_window_bytes += slen;
 
 		qdisc_tree_reduce_backlog(sch, 1-numsegs, len-slen);
@@ -1863,7 +1863,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		b->bytes	    += len - ack_pkt_len;
 		b->backlogs[idx]    += len - ack_pkt_len;
 		b->tin_backlog      += len - ack_pkt_len;
-		sch->qstats.backlog += len - ack_pkt_len;
+		qstats_backlog_add(sch, len - ack_pkt_len);
 		q->avg_window_bytes += len - ack_pkt_len;
 	}
 
@@ -1978,7 +1978,7 @@ static struct sk_buff *cake_dequeue_one(struct Qdisc *sch)
 		len = qdisc_pkt_len(skb);
 		b->backlogs[q->cur_flow] -= len;
 		b->tin_backlog		 -= len;
-		sch->qstats.backlog      -= len;
+		qstats_backlog_sub(sch, len);
 		q->buffer_used		 -= skb->truesize;
 		qdisc_qlen_dec(sch);
 
diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index a75e58876797952f2218725f6da5cff29f330ae2..2cfa0fd92829ad7eba7454e09dc17eb8f22519b8 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -96,7 +96,7 @@ static int cbs_child_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (err != NET_XMIT_SUCCESS)
 		return err;
 
-	sch->qstats.backlog += len;
+	qstats_backlog_add(sch, len);
 	qdisc_qlen_inc(sch);
 
 	return NET_XMIT_SUCCESS;
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 317aae0ec7bd6aedb4bae09b18423c981fed16e7..91dd2e629af8f2d1a29f439a6dbb5c186fa01d33 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -42,7 +42,7 @@ static struct sk_buff *dequeue_func(struct codel_vars *vars, void *ctx)
 	struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
 
 	if (skb) {
-		sch->qstats.backlog -= qdisc_pkt_len(skb);
+		qstats_backlog_sub(sch, qdisc_pkt_len(skb));
 		prefetch(&skb->end); /* we'll need skb_shinfo() */
 	}
 	return skb;
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 925fa0cfd730ce72e45e8983ba02eb913afb1235..3f6687fa9666257952be5d44f9e3460845fe2a40 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -365,7 +365,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		cl->deficit = cl->quantum;
 	}
 
-	sch->qstats.backlog += len;
+	qstats_backlog_add(sch, len);
 	qdisc_qlen_inc(sch);
 	return err;
 }
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index c817e0a6c14653a35f5ebb9de1a5ccc44d1a2f98..1cc559634ed27ce5a6630186a51a8ac8180dad96 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -448,7 +448,7 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		cl->deficit = cl->quantum;
 	}
 
-	sch->qstats.backlog += len;
+	qstats_backlog_add(sch, len);
 	qdisc_qlen_inc(sch);
 	return err;
 }
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 183b1ea9d2076d8f709d50a38b39d28a2b14bad8..5c88278a30b3cd92ae525d1a88eb692ff0e296e0 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -177,7 +177,7 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 	q->backlogs[idx] -= len;
 	q->memory_usage -= mem;
 	sch->qstats.drops += i;
-	sch->qstats.backlog -= len;
+	qstats_backlog_sub(sch, len);
 	WRITE_ONCE(sch->q.qlen, sch->q.qlen - i);
 	return idx;
 }
@@ -267,7 +267,7 @@ static struct sk_buff *dequeue_func(struct codel_vars *vars, void *ctx)
 		q->backlogs[flow - q->flows] -= qdisc_pkt_len(skb);
 		q->memory_usage -= get_codel_cb(skb)->mem_usage;
 		qdisc_qlen_dec(sch);
-		sch->qstats.backlog -= qdisc_pkt_len(skb);
+		qdisc_qstats_backlog_dec(sch, skb);
 	}
 	return skb;
 }
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index dba49d44a5d2412b2deb983bf87428ade7944e51..197f0df0a6eb06ab4ce25eefe01d32a35dbd84af 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -184,7 +184,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		pkt_len = qdisc_pkt_len(skb);
 		q->stats.packets_in++;
 		q->memory_usage += skb->truesize;
-		sch->qstats.backlog += pkt_len;
+		qstats_backlog_add(sch, pkt_len);
 		qdisc_qlen_inc(sch);
 		flow_queue_add(sel_flow, skb);
 		if (list_empty(&sel_flow->flowchain)) {
@@ -262,7 +262,7 @@ static struct sk_buff *fq_pie_qdisc_dequeue(struct Qdisc *sch)
 	if (flow->head) {
 		skb = dequeue_head(flow);
 		pkt_len = qdisc_pkt_len(skb);
-		sch->qstats.backlog -= pkt_len;
+		qstats_backlog_sub(sch, pkt_len);
 		qdisc_qlen_dec(sch);
 		qdisc_bstats_update(sch, skb);
 	}
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index e71a565100edf60881ca7542faa408c5bb1a0984..59409ee2d2ff9279d7439b744030c0e845386de0 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1560,7 +1560,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
-	sch->qstats.backlog += len;
+	qstats_backlog_add(sch, len);
 	qdisc_qlen_inc(sch);
 
 	if (first && !cl_in_el_or_vttree(cl)) {
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index c22ccd8eae8c73323ccdf425e62857b3b851d74e..1e600f65c8769a74286c4f060b0d45da9a13eeeb 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -650,7 +650,7 @@ static int htb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		htb_activate(q, cl);
 	}
 
-	sch->qstats.backlog += len;
+	qstats_backlog_add(sch, len);
 	qdisc_qlen_inc(sch);
 	return NET_XMIT_SUCCESS;
 }
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 4498dd440a02ea7a089c92ebc005d5064b87e2d2..2a2cdd1e4cc206ba00b8dd1821bef87156050950 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -751,7 +751,7 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 				if (err != NET_XMIT_SUCCESS) {
 					if (net_xmit_drop_count(err))
 						qdisc_qstats_drop(sch);
-					sch->qstats.backlog -= pkt_len;
+					qstats_backlog_sub(sch, pkt_len);
 					qdisc_qlen_dec(sch);
 					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index fe42ae3d6b696b2fc47f4d397af32e950eeec194..e4dd56a890725b4c14d6715c96f5b3fa44a8f4f2 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -85,7 +85,7 @@ prio_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 
 	ret = qdisc_enqueue(skb, qdisc, to_free);
 	if (ret == NET_XMIT_SUCCESS) {
-		sch->qstats.backlog += len;
+		qstats_backlog_add(sch, len);
 		qdisc_qlen_inc(sch);
 		return NET_XMIT_SUCCESS;
 	}
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 195c434aae5f7e03d1a1238ed73bb64b3f04e105..cb56787e1d258c06f2e86959c3b2cfaeb12df1ac 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1264,7 +1264,7 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	_bstats_update(&cl->bstats, len, gso_segs);
-	sch->qstats.backlog += len;
+	qstats_backlog_add(sch, len);
 	qdisc_qlen_inc(sch);
 
 	agg = cl->agg;
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 61b9064d39f222bdfe5021e93e8172b7ae60c408..7db97c96351309bc3e64fa50570a1928f2b2ce55 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -132,7 +132,7 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	len = qdisc_pkt_len(skb);
 	ret = qdisc_enqueue(skb, child, to_free);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
-		sch->qstats.backlog += len;
+		qstats_backlog_add(sch, len);
 		qdisc_qlen_inc(sch);
 	} else if (net_xmit_drop_count(ret)) {
 		q->stats.pdrop++;
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 17b6ce223ad3a6f2d289c3ebe27cce8168c66b2b..2258567cbcaf70863eace85d347efda882a00145 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -406,7 +406,7 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	memcpy(&cb, sfb_skb_cb(skb), sizeof(cb));
 	ret = qdisc_enqueue(skb, child, to_free);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
-		sch->qstats.backlog += len;
+		qstats_backlog_add(sch, len);
 		qdisc_qlen_inc(sch);
 		increment_qlen(&cb, q);
 	} else if (net_xmit_drop_count(ret)) {
@@ -582,7 +582,7 @@ static int sfb_dump(struct Qdisc *sch, struct sk_buff *skb)
 		.penalty_burst = q->penalty_burst,
 	};
 
-	sch->qstats.backlog = q->qdisc->qstats.backlog;
+	WRITE_ONCE(sch->qstats.backlog, READ_ONCE(q->qdisc->qstats.backlog));
 	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (opts == NULL)
 		goto nla_put_failure;
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 5eb6d8abd1c334938f72259f5fc41526597e792f..37410dfd7e3c554d3a8180b4887bdd5872ba8aab 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -425,7 +425,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		/* We know we have at least one packet in queue */
 		head = slot_dequeue_head(slot);
 		delta = qdisc_pkt_len(head) - qdisc_pkt_len(skb);
-		sch->qstats.backlog -= delta;
+		qstats_backlog_sub(sch, delta);
 		slot->backlog -= delta;
 		qdisc_drop_reason(head, sch, to_free, QDISC_DROP_FLOW_LIMIT);
 
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index 25edf11a7d671fe63878b0995998c5920b86ef74..67c7aaaf8f607e82ad13b7fdf177405a1dd075bb 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -232,7 +232,7 @@ static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
 		}
 	}
 	WRITE_ONCE(sch->q.qlen, sch->q.qlen + nb);
-	sch->qstats.backlog += len;
+	qstats_backlog_add(sch, len);
 	if (nb > 0) {
 		qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
 		consume_skb(skb);
@@ -263,7 +263,7 @@ static int tbf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return ret;
 	}
 
-	sch->qstats.backlog += len;
+	qstats_backlog_add(sch, len);
 	qdisc_qlen_inc(sch);
 	return NET_XMIT_SUCCESS;
 }
-- 
2.53.0.1213.gd9a14994de-goog


