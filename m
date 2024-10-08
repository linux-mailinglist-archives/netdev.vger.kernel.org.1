Return-Path: <netdev+bounces-133065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD835994659
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE981C23DA1
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D574199E92;
	Tue,  8 Oct 2024 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjZmb2sh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0918C900
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386168; cv=none; b=V8NJ3P0zLUvAaH+zs8fNthXK6XJwC5U0NB1YMuU4TJBiomtTOuH74K/BYbgsK9Tn7i9WQWZ+LYusDCh8VMWUbL+2kwXlCDZlZ0+kgGLjPIx8aV/gK185q+OuxQnxhoOHkrlD+QAP23yals98cOxbEkSvyETpvacmUYv91lJwA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386168; c=relaxed/simple;
	bh=4bjVuoaEqOg9kTKBVPX6HtmLxvp6STF3+bBMsHNqYjo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YwY7BRE330DzFePQEg0HQ86pltuWEKWdhUJA9KjAJsXPWhiGM9OnIrtAJMfUX5mhaKrEZey8i1IGPEfl9WD0LMpvQlDb4E5pjcQLW+dXgLddZ+5YmSV4YkTUE6V6o+Za6jWLbXROR0keV3jIpJdAS9ilFbh4STfZpshTSNQc+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjZmb2sh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e21dcc7044so77968907b3.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728386166; x=1728990966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RtQHNgBmIFqK1ii3HgJLr+jMF62s09rx1muiZr/MtG0=;
        b=mjZmb2sh4UZuvuosN+fOcOkW+tAG83MYd0Cz979KtW87BkCCOlU4QgoplZxjc02U+R
         BIrGu0E5yN5ex2jnYYnIktYK+sWMqeNKIyurDHoBaxcB94KHvG+NlLI9S5Ig3OPnmg92
         t2rNm/wlF3YxjwvbWfVrVILDAWtroMsFr83Sa0CESxsVZxx5EmoUhzWy3bpEknrFkcH8
         4eSbIRrzoKjVxj6Bb7S1TN8bUoPK1+s4djoxifx9qw1qh8TkF9t3kjDauyjmXYM9BXph
         AebYffC79RuXBCZgDqMfkE4flOtvQ1vSRG1HWSBPXwUkD1ddTDJhIafYWvxGqBNrEZ8g
         ulAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728386166; x=1728990966;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtQHNgBmIFqK1ii3HgJLr+jMF62s09rx1muiZr/MtG0=;
        b=mDKHXY8LCLWbiP4J4F1Pv0dlcIyHXe4soxSJDU5jPz67a66r5Zd2Z17E9GqVbDL6Bw
         5X03K/+ewijO2oidAM2ZhmIoDaDk65as3sGEjEW41JokjAzlVVVZk3k0qHECCmiaJrEj
         4Fa5YuKYJxzCungQxI8dcpX4qzOFWAlLjWvisqHG5Sb2T+uMJiDPUHP58pD/HDsaBth+
         4PbLScvAt5/KIA55wosTw/GhG6+vNQZRwFvMiGu5I0hhKP3H61hCjkTlBjFuFXBzVzaq
         yCMKcK9EGKYdIq9M92407eye2WI8PFPaVa8pM7ToqQRc1NKwhf2zg091dEmD7WWo+DGq
         xZxw==
X-Forwarded-Encrypted: i=1; AJvYcCWon0CW1LUQB4ZLOLX+a+JsGZFUrhm2R6hxgtnfej9/PuShx6Y/ANq26cAvhq74HrT2eWrypbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFYN/cXNAshtehDaS+LGH96oMhVsX13lwzgoPt3rkK2ydPkmx
	iibmyn5+CUsDeb7ws1kA7qMeK8XOQBtt8vkPawVArOHxZ+BSydWdEEsMbp+HjVKYAayGqXwfg1t
	TDAsoKYU5jQ==
X-Google-Smtp-Source: AGHT+IGVFwx/N04q+WX+emofPypV+2wjByU0qpUR1aI0ODWWPJgt5I7JMXPqoqBcAh0MRpX7wxknUuiWBZeXJw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:4b8f:b0:6e2:19f3:ff75 with SMTP
 id 00721157ae682-6e2c72933e5mr2970867b3.6.1728386165778; Tue, 08 Oct 2024
 04:16:05 -0700 (PDT)
Date: Tue,  8 Oct 2024 11:16:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008111603.653140-1-edumazet@google.com>
Subject: [PATCH net-next] net_sched: sch_sfq: handle bigger packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

SFQ has an assumption on dealing with packets smaller than 64KB.

Even before BIG TCP, TCA_STAB can provide arbitrary big values
in qdisc_pkt_len(skb)

It is time to switch (struct sfq_slot)->allot to a 32bit field.

sizeof(struct sfq_slot) is now 64 bytes, giving better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_sfq.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 3b9245a3c767a6feed5e06f90459ae896b217c23..a4b8296a2fa1caf2e8337610d705cc9b06b1a2f8 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -77,12 +77,6 @@
 #define SFQ_EMPTY_SLOT		0xffff
 #define SFQ_DEFAULT_HASH_DIVISOR 1024
 
-/* We use 16 bits to store allot, and want to handle packets up to 64K
- * Scale allot by 8 (1<<3) so that no overflow occurs.
- */
-#define SFQ_ALLOT_SHIFT		3
-#define SFQ_ALLOT_SIZE(X)	DIV_ROUND_UP(X, 1 << SFQ_ALLOT_SHIFT)
-
 /* This type should contain at least SFQ_MAX_DEPTH + 1 + SFQ_MAX_FLOWS values */
 typedef u16 sfq_index;
 
@@ -104,7 +98,7 @@ struct sfq_slot {
 	sfq_index	next; /* next slot in sfq RR chain */
 	struct sfq_head dep; /* anchor in dep[] chains */
 	unsigned short	hash; /* hash value (index in ht[]) */
-	short		allot; /* credit for this slot */
+	int		allot; /* credit for this slot */
 
 	unsigned int    backlog;
 	struct red_vars vars;
@@ -120,7 +114,6 @@ struct sfq_sched_data {
 	siphash_key_t 	perturbation;
 	u8		cur_depth;	/* depth of longest slot */
 	u8		flags;
-	unsigned short  scaled_quantum; /* SFQ_ALLOT_SIZE(quantum) */
 	struct tcf_proto __rcu *filter_list;
 	struct tcf_block *block;
 	sfq_index	*ht;		/* Hash table ('divisor' slots) */
@@ -456,7 +449,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		 */
 		q->tail = slot;
 		/* We could use a bigger initial quantum for new flows */
-		slot->allot = q->scaled_quantum;
+		slot->allot = q->quantum;
 	}
 	if (++sch->q.qlen <= q->limit)
 		return NET_XMIT_SUCCESS;
@@ -493,7 +486,7 @@ sfq_dequeue(struct Qdisc *sch)
 	slot = &q->slots[a];
 	if (slot->allot <= 0) {
 		q->tail = slot;
-		slot->allot += q->scaled_quantum;
+		slot->allot += q->quantum;
 		goto next_slot;
 	}
 	skb = slot_dequeue_head(slot);
@@ -512,7 +505,7 @@ sfq_dequeue(struct Qdisc *sch)
 		}
 		q->tail->next = next_a;
 	} else {
-		slot->allot -= SFQ_ALLOT_SIZE(qdisc_pkt_len(skb));
+		slot->allot -= qdisc_pkt_len(skb);
 	}
 	return skb;
 }
@@ -595,7 +588,7 @@ static void sfq_rehash(struct Qdisc *sch)
 				q->tail->next = x;
 			}
 			q->tail = slot;
-			slot->allot = q->scaled_quantum;
+			slot->allot = q->quantum;
 		}
 	}
 	sch->q.qlen -= dropped;
@@ -628,7 +621,8 @@ static void sfq_perturbation(struct timer_list *t)
 	rcu_read_unlock();
 }
 
-static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
+static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
+		      struct netlink_ext_ack *extack)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
 	struct tc_sfq_qopt *ctl = nla_data(opt);
@@ -646,14 +640,10 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 	    (!is_power_of_2(ctl->divisor) || ctl->divisor > 65536))
 		return -EINVAL;
 
-	/* slot->allot is a short, make sure quantum is not too big. */
-	if (ctl->quantum) {
-		unsigned int scaled = SFQ_ALLOT_SIZE(ctl->quantum);
-
-		if (scaled <= 0 || scaled > SHRT_MAX)
-			return -EINVAL;
+	if ((int)ctl->quantum < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
+		return -EINVAL;
 	}
-
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog, ctl_v1->Scell_log, NULL))
 		return -EINVAL;
@@ -663,10 +653,8 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 			return -ENOMEM;
 	}
 	sch_tree_lock(sch);
-	if (ctl->quantum) {
+	if (ctl->quantum)
 		q->quantum = ctl->quantum;
-		q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
-	}
 	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
 	if (ctl->flows)
 		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
@@ -762,12 +750,11 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
 	q->divisor = SFQ_DEFAULT_HASH_DIVISOR;
 	q->maxflows = SFQ_DEFAULT_FLOWS;
 	q->quantum = psched_mtu(qdisc_dev(sch));
-	q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
 	q->perturb_period = 0;
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 
 	if (opt) {
-		int err = sfq_change(sch, opt);
+		int err = sfq_change(sch, opt, extack);
 		if (err)
 			return err;
 	}
@@ -878,7 +865,7 @@ static int sfq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	if (idx != SFQ_EMPTY_SLOT) {
 		const struct sfq_slot *slot = &q->slots[idx];
 
-		xstats.allot = slot->allot << SFQ_ALLOT_SHIFT;
+		xstats.allot = slot->allot;
 		qs.qlen = slot->qlen;
 		qs.backlog = slot->backlog;
 	}
-- 
2.47.0.rc0.187.ge670bccf7e-goog


