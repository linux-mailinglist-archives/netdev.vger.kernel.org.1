Return-Path: <netdev+bounces-286262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB6hN89MAGqsGAEAu9opvQ
	(envelope-from <netdev+bounces-286262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 879A4503480
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5225301ECDB
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE6A36E495;
	Sun, 10 May 2026 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGvSfk2f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27236D9EE
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404504; cv=none; b=WhialmMA+Lb7QGmOReD7Dlyxg+LclgtK8m0jYTl8Cu9xEjLamvpVO4fTccoQs0Z/pbwIriqKyt9WMr/m8ZgOTblYITvGiHW1bzs5yuSvVqpOiv/H5Q3zmdenFoPT4MLmktKj81da3oZccrPL2vsRdpT6ie91+InTnyFYWWuXy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404504; c=relaxed/simple;
	bh=bYvXv0+kbOE+ZVqTRc0/4RrEZ7ZxZOx8dYCR8lkCcIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ITQoriDLN+5LjJ20VUI1h2n+SaA/5AmSjLCmtOLcQ0ppAtj8OZglJ/at/UbDUl7qo5SZMSDnb/ztnU1aekQ5t6LpJbjbGiVf5X3ZIpDEeNTbSpzFZcFoC745ow537wJ00xQ835LVTCY/Gxo721xEDYl4E9Eb6HjbV5U85sKEgjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGvSfk2f; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50fb6d713ddso6713541cf.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 02:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778404501; x=1779009301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCB6R1bXUeFl34rVCjoAuuxut3y/cSBfO8b6oHSq3Fg=;
        b=OGvSfk2fS08JKFHtZPYbLpn5ZVAXP58s16S2n8rLYqxPqTVVGwY0f5MIZWjMxuY/z7
         XDDKZ0KjPBNl92GXmhYMpxhnsNqZP0ISEDe5T1tyB35rTaTdy+pilRte7aaHkdLhtFcG
         vFYfEGOZdNYR99MwjHudPQcuMBdSmbMpwWJcRqFGFi5s3Jd2WIyefkFlVfsbgBO1q8Wx
         jIqK1HkixfhYg+YXbC1YYoXR45sM1MLamIaBlQut/ukShjIBlQGzhHVIP6kpmTxxV6qQ
         Hq6JCMgjRwjSLjvD9+OfbEicCsU+iU61WR7ya39XCl7fs8kWNg0JXWvVEjnMXGVsCCl2
         Z9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778404501; x=1779009301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCB6R1bXUeFl34rVCjoAuuxut3y/cSBfO8b6oHSq3Fg=;
        b=U9eMgkq57dBjrUNRHQKwYraloEQnRpTwJGsiZnmjHEWuBVKUoNbitt/aefaWyjSRuu
         g5CTTtUrgMhYp8ty10itZtb3j7WUByH4AH6vMAXwzFl+hTbwjDAhg//nsnHdxKb95LOM
         8vaL2ljZ1FaL06MAU36i5g5CYekXmRHumsFYWfl2JJK3F+XHU3F8cgjPKDiDYjuC4EgI
         +/zccEeP0QIdcv0qlb4honY15Hthmj+qJLYndAu5kvVy65g5XKg0+aFnWr6zVM9prm/d
         28a8mfLZhCWh+HLglKDPl3r1szhjHU9xqXhJ/dCGvb9uA5JvSAvZucdHC8lKvi6KPxhR
         9rKw==
X-Forwarded-Encrypted: i=1; AFNElJ/vfVVtSYAY6iDpRgzl5DQAF28EV242/pACWV773w/xc+Ub4d2HQTFGcvdUSeyPxv3fBIa0Gfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVA8f8fXDmBXizokcjjYFP1wF/9MnbmfMgu+dp/1tdBSAFFF8E
	ViZxeeSU9f0HpweD8n7Dm0TkvBdd/YlufUy3athOKr1Qlwdn7ZloMxPPHs/xaBBQGNqqbvIdpBl
	mgc9ae70GbiROBg==
X-Received: from qtnm19.prod.google.com ([2002:ac8:4453:0:b0:50d:4130:ba9a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5909:b0:50d:8e6b:96ac with SMTP id d75a77b69052e-514621e4c0dmr284308501cf.58.1778404501229;
 Sun, 10 May 2026 02:15:01 -0700 (PDT)
Date: Sun, 10 May 2026 09:14:50 +0000
In-Reply-To: <20260510091455.4039245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260510091455.4039245-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510091455.4039245-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/8] net/sched: annotate data-races around sch->qstats.backlog
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 879A4503480
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286262-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add qstats_backlog_sub() and qstats_backlog_add() helpers
and use them instead of open-coding them.

These helpers use WRITE_ONCE() to prevent store-tearing.

Also use WRITE_ONCE() in fq_reset() and qdisc_reset()
when sch->qstats.backlog is cleared.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 16 +++++++++++++---
 net/sched/sch_api.c       |  2 +-
 net/sched/sch_cake.c      | 10 +++++-----
 net/sched/sch_cbs.c       |  2 +-
 net/sched/sch_codel.c     |  2 +-
 net/sched/sch_drr.c       |  2 +-
 net/sched/sch_ets.c       |  2 +-
 net/sched/sch_fq.c        |  2 +-
 net/sched/sch_fq_codel.c  |  4 ++--
 net/sched/sch_fq_pie.c    |  4 ++--
 net/sched/sch_generic.c   |  2 +-
 net/sched/sch_gred.c      |  2 +-
 net/sched/sch_hfsc.c      |  2 +-
 net/sched/sch_htb.c       |  2 +-
 net/sched/sch_netem.c     |  2 +-
 net/sched/sch_prio.c      |  2 +-
 net/sched/sch_qfq.c       |  2 +-
 net/sched/sch_red.c       |  2 +-
 net/sched/sch_sfb.c       |  4 ++--
 net/sched/sch_sfq.c       |  2 +-
 net/sched/sch_tbf.c       |  4 ++--
 21 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index dbb3ba6416e485128c120eb3dacb9b38d8f8ffe6..391ee85300172fced9bd7c8918727f01662c4a11 100644
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
@@ -1304,7 +1314,7 @@ static inline void qdisc_update_stats_at_enqueue(struct Qdisc *sch,
 		qdisc_qstats_cpu_qlen_inc(sch);
 		this_cpu_add(sch->cpu_qstats->backlog, pkt_len);
 	} else {
-		sch->qstats.backlog += pkt_len;
+		qstats_backlog_add(sch, pkt_len);
 		qdisc_qlen_inc(sch);
 	}
 }
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index cefa2d8ac5ec00c78b08b520a11672120d10cdef..3c779e5098efd6602ec4efb0abadb8dac21c4b44 100644
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
index 7ab75a52f7d1a46d87fc8f7c099c749a5331ccf6..a3c185505afce405d1a1e5911d22cfc325d69bb2 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1600,10 +1600,10 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 			   b->unresponsive_flow_count + 1);
 
 	len = qdisc_pkt_len(skb);
-	q->buffer_used      -= skb->truesize;
+	qstats_backlog_sub(sch, len);
+	q->buffer_used -= skb->truesize;
 	WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
 	WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] - len);
-	sch->qstats.backlog -= len;
 
 	WRITE_ONCE(flow->dropped, flow->dropped + 1);
 	WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
@@ -1830,7 +1830,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		}
 
 		/* stats */
-		sch->qstats.backlog += slen;
+		qstats_backlog_add(sch, slen);
 		q->avg_window_bytes += slen;
 		WRITE_ONCE(b->bytes, b->bytes + slen);
 		WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
@@ -1867,7 +1867,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		/* stats */
 		WRITE_ONCE(b->packets, b->packets + 1);
-		sch->qstats.backlog += len - ack_pkt_len;
+		qstats_backlog_add(sch, len - ack_pkt_len);
 		q->avg_window_bytes += len - ack_pkt_len;
 		WRITE_ONCE(b->bytes, b->bytes + len - ack_pkt_len);
 		WRITE_ONCE(b->tin_backlog, b->tin_backlog + len - ack_pkt_len);
@@ -1985,7 +1985,7 @@ static struct sk_buff *cake_dequeue_one(struct Qdisc *sch)
 		len = qdisc_pkt_len(skb);
 		WRITE_ONCE(b->backlogs[q->cur_flow], b->backlogs[q->cur_flow] - len);
 		WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
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
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 1e34ac136b15cf24742f2810d201420cf763021a..796cb8046a902b94952a571b250813c5e557d600 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -802,7 +802,7 @@ static void fq_reset(struct Qdisc *sch)
 	unsigned int idx;
 
 	WRITE_ONCE(sch->q.qlen, 0);
-	sch->qstats.backlog = 0;
+	WRITE_ONCE(sch->qstats.backlog, 0);
 
 	fq_flow_purge(&q->internal);
 
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index cae8483fbb0c4f62f28dba4c15b4426485390bcf..1b1de693d4c64a1f5f4e9e788371829dea91740e 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -177,7 +177,7 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 	WRITE_ONCE(q->backlogs[idx], q->backlogs[idx] - len);
 	q->memory_usage -= mem;
 	__qdisc_qstats_drop(sch, i);
-	sch->qstats.backlog -= len;
+	qstats_backlog_sub(sch, len);
 	WRITE_ONCE(sch->q.qlen, sch->q.qlen - i);
 	return idx;
 }
@@ -268,7 +268,7 @@ static struct sk_buff *dequeue_func(struct codel_vars *vars, void *ctx)
 			   q->backlogs[flow - q->flows] - qdisc_pkt_len(skb));
 		q->memory_usage -= get_codel_cb(skb)->mem_usage;
 		qdisc_qlen_dec(sch);
-		sch->qstats.backlog -= qdisc_pkt_len(skb);
+		qdisc_qstats_backlog_dec(sch, skb);
 	}
 	return skb;
 }
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 0a4eca4ab086ebebbdba17784f12370c301bbac6..72f48fa4010bebbe6be212938b457db21ff3c5a0 100644
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
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 7b4a5874ed1f612ed1e16f910df30eadce8330fe..237ee1cd013673816b651e4686fed7a7b921ca26 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1063,7 +1063,7 @@ void qdisc_reset(struct Qdisc *qdisc)
 	__skb_queue_purge(&qdisc->skb_bad_txq);
 
 	WRITE_ONCE(qdisc->q.qlen, 0);
-	qdisc->qstats.backlog = 0;
+	WRITE_ONCE(qdisc->qstats.backlog, 0);
 }
 EXPORT_SYMBOL(qdisc_reset);
 
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 8ae65572162c188cca5ac8f030dc6f2054a7fcd0..fcc1a4c0363624293986f221c70572ce6503e220 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -388,7 +388,7 @@ static int gred_offload_dump_stats(struct Qdisc *sch)
 		bytes += u64_stats_read(&hw_stats->stats.bstats[i].bytes);
 		packets += u64_stats_read(&hw_stats->stats.bstats[i].packets);
 		sch->qstats.qlen += hw_stats->stats.qstats[i].qlen;
-		sch->qstats.backlog += hw_stats->stats.qstats[i].backlog;
+		qstats_backlog_add(sch, hw_stats->stats.qstats[i].backlog);
 		__qdisc_qstats_drop(sch, hw_stats->stats.qstats[i].drops);
 		sch->qstats.requeues += hw_stats->stats.qstats[i].requeues;
 		sch->qstats.overlimits += hw_stats->stats.qstats[i].overlimits;
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
index 57b12cbca45355c69780614fa87aaf37255d64cc..ddbfea9dd32a7cee381dc82e0291db709ee57f8a 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -750,7 +750,7 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
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
index 0719590dfd73b64d21f71ab00621f64ed0eefc89..d7598214270b8e5b6b818be37f1519f64ad537c4 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -138,7 +138,7 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	len = qdisc_pkt_len(skb);
 	ret = qdisc_enqueue(skb, child, to_free);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
-		sch->qstats.backlog += len;
+		qstats_backlog_add(sch, len);
 		qdisc_qlen_inc(sch);
 	} else if (net_xmit_drop_count(ret)) {
 		WRITE_ONCE(q->stats.pdrop,
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index efd9251c3add317f3b817f08c732fca0c347bf35..b1d46509427692eeeabcfa19957c83fae3fa306e 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -415,7 +415,7 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	memcpy(&cb, sfb_skb_cb(skb), sizeof(cb));
 	ret = qdisc_enqueue(skb, child, to_free);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
-		sch->qstats.backlog += len;
+		qstats_backlog_add(sch, len);
 		qdisc_qlen_inc(sch);
 		increment_qlen(&cb, q);
 	} else if (net_xmit_drop_count(ret)) {
@@ -592,7 +592,7 @@ static int sfb_dump(struct Qdisc *sch, struct sk_buff *skb)
 		.penalty_burst = q->penalty_burst,
 	};
 
-	sch->qstats.backlog = q->qdisc->qstats.backlog;
+	WRITE_ONCE(sch->qstats.backlog, READ_ONCE(q->qdisc->qstats.backlog));
 	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (opts == NULL)
 		goto nla_put_failure;
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index f9807ee2cf6c72101ce39c4f43bf32c03c0a5f62..758b88f218652704454647f25da270a0254cafcf 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -427,7 +427,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		/* We know we have at least one packet in queue */
 		head = slot_dequeue_head(slot);
 		delta = qdisc_pkt_len(head) - qdisc_pkt_len(skb);
-		sch->qstats.backlog -= delta;
+		qstats_backlog_sub(sch, delta);
 		WRITE_ONCE(slot->backlog, slot->backlog - delta);
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
2.54.0.563.g4f69b47b94-goog


