Return-Path: <netdev+bounces-297809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BBsoMTy7KWrscQMAu9opvQ
	(envelope-from <netdev+bounces-297809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A54966C830
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:30:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=KEbz1Z2H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297809-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297809-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA0E31D33FC
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE9374A1B;
	Wed, 10 Jun 2026 19:29:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840C2374E5C
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:29:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119753; cv=none; b=HbGf3DMHZqg6jWZ8Qh9WuK1J5RIL8Gx9484ap3ce0VwNpcW/a2I/h5ldJguei/8czUt/lhsRxpmaxvh9F7vErktvTGxcivUyO9cZU/jarOybKROOg1EeVaiAc/yEsjPMcRuLpOha2p8EwzwQ42zRz/70OJFkN+Kv90o7MBJThu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119753; c=relaxed/simple;
	bh=J3oPbuGuOV9Wl0+uSnDHoR5kkZ3x8LTyD41St3iceJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgPUaOhnvSNbkSyWuMFcvkgjfWhygRAGhEnu6Oct4LF0mA7Y3tqXV/EduqcHjtKFWPaaCWeNfpE2tbmSzSuFK3KDmV1rNaUAepFo773ztQGZuPzsMPHhzIvwDJgPXO11tvDzz4sZZEQDaXLn/RVUb76kKLnZZ8z6uPILggaxh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=KEbz1Z2H; arc=none smtp.client-ip=209.85.221.175
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-59eb57ed4cbso2573074e0c.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781119751; x=1781724551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QFv6vK04Mrreyy9Ir+5CsqwKnn4Y3sKIKCaqva1X2k=;
        b=KEbz1Z2HvSUnuTfNfISTkLDoY3HoA9Zvy3HQlkqw9uum1Fi9f/Z5Uy/kCxTHcBCKuC
         2GGKSSUqfbvzzZ0BZUm8hcXt8IHIwl2MaZ7AZeB6hwDYnSWDr3BVIrpWLFiq7pFqKZfJ
         QVaPRjChMAWG/hTI4y01bniP70SGsVTvYAfzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781119751; x=1781724551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6QFv6vK04Mrreyy9Ir+5CsqwKnn4Y3sKIKCaqva1X2k=;
        b=CJ4MZb2MYpH9BVa59dc4KcxVtJFJDUoTLIKLQwuUFx0xORn6c/n9iA8CaRbD33LFBu
         f7XlRtcEjDYP4vTN4zxhlltB4Mq8F9LncWMLP/Y688Gp1vY4aRo1Dc3Woex9cFUsnDbn
         X5onQpUAO9pzx+hvcgcDbZIwUr64UXE7LhluFCbMwI4/iKt1wBp2KQj28zjspECFAuH8
         Q4/DmkIQ3IzswnaTqxHx34Mup1nIcHUFqrtyShaOwuKiKZl5TacrkvkkC1OvizRpbKZw
         jCvGafB42J77zhjscRhbcISDNbQ2Z77uBrd0Kyt4DCEik+hF0kV6guJySaQNaW0W9YkB
         XysQ==
X-Gm-Message-State: AOJu0YymyAutiiAV/kAUhe58+iV37QI3oqgnU7izFSZaHnWJEwXufGh9
	s6pJ6LZ1L5U6rM/F7vJ46WzO1bqigP+tPV+tpggHASWMtVI/QTUNJiiQw/cMdTFs/w==
X-Gm-Gg: Acq92OGM+qbdh2EgUxIMiqJSB4h/iSHtie3zDht5MfwT7gIARLCXS0XGXIGQcKiiW9j
	D2nGRLnKfenGo+auv7dsChXSf12pIWOG26GC2HaENG4SAn8AnJXEXSmX9gk1MugkNCThVkCffC/
	ih0Iq5wcp8hH+GlIKJsiOaktgI4xS2ZoKwJxgZJSZ86RcKGVVbAKau863AYzXQQC3zGIBSj8VCe
	Qk3wtM3wrWaq0/HMfbvmlyjmj7CVsJrp9HGHjoOtwnfBw24tc+yGGaRrJNbF2x6fsMdYgiM+JyY
	9nWUCSVwmPbPHMpxYE6G/JTKe2H+hSZHE05BY05HuyG1bb2C3QqWCu3mXPZAa9Yz2WhqfriFzXR
	NF06FmVUesjsZ3HAMasChQU2VDLyS1Y5Tki/VSky6Zu6i6OyscQZaeeRB5kWVO30ZoJ2usXggIX
	b1O/idtoygWSaIzgzC5j5umhRwwR80VBd4K3SlgK4FTzPz
X-Received: by 2002:a05:6122:2226:b0:576:c4b:460a with SMTP id 71dfb90a1353d-5b635627886mr5382339e0c.8.1781119751400;
        Wed, 10 Jun 2026 12:29:11 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm21848563e0c.5.2026.06.10.12.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 12:29:10 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	anirudhrudr@gmail.com,
	pctammela@mojatatu.com,
	ij@kernel.org,
	henrist@henrist.net,
	chia-yu.chang@nokia-bell-labs.com
Subject: [PATCH net 2/4] net/sched: sch_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
Date: Wed, 10 Jun 2026 16:28:53 -0300
Message-ID: <20260610192855.3121513-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610192855.3121513-1-victor@mojatatu.com>
References: <20260610192855.3121513-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:anirudhrudr@gmail.com,m:pctammela@mojatatu.com,m:ij@kernel.org,m:henrist@henrist.net,m:chia-yu.chang@nokia-bell-labs.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297809-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,mojatatu.com,kernel.org,henrist.net,nokia-bell-labs.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A54966C830

Whenever codel drops packets during peek, it calls
qdisc_tree_reduce_backlog. An issue arises because it calls
qdisc_tree_reduce_backlog before it reincrements the qlen. If qlen drops
to zero, but peek returns an skb, the parent's qlen_notify callback will
be executed even though codel still has 1 packet on the queue and, thus,
will mistakenly deactivate the parent's class causing issues like a wild
memory access when qfq has codel as a child:

[   36.339843][  T370] Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
[   36.340408][  T370] KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
[   36.340737][  T370] CPU: 2 UID: 0 PID: 370 Comm: tc Not tainted 7.1.0-rc5-00287-g66e13b626592 #87 PREEMPT(full)
[   36.341113][  T370] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   36.341357][  T370] RIP: 0010:qfq_deactivate_agg (include/linux/list.h:1029 (discriminator 2) include/linux/list.h:1043 (discriminator 2) net/sched/sch_qfq.c:1369 (discriminator 2) net/sched/sch_qfq.c:1395 (discriminator 2)) sch_qfq
[   36.342221][  T370] RSP: 0018:ffff8881100ef370 EFLAGS: 00010216
[   36.342422][  T370] RAX: 0000000000000000 RBX: ffff8881058a9568 RCX: dffffc0000000000
[   36.342664][  T370] RDX: 1ffff11021064dc3 RSI: ffff888108326e00 RDI: dffffc0000000000
[   36.342905][  T370] RBP: ffff8881058a8280 R08: dead000000000122 R09: 1bd5a00000000024
[   36.343140][  T370] R10: fffffbfff2940329 R11: fffffbfff2940329 R12: 0000000000000000
[   36.343383][  T370] R13: dead000000000100 R14: ffff8881058a9580 R15: ffff8881058a9578
[   36.343631][  T370] FS:  00007fc04b0ca780(0000) GS:ffff888184fef000(0000) knlGS:0000000000000000
[   36.343911][  T370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.344116][  T370] CR2: 0000557c02c02000 CR3: 000000010e0ba000 CR4: 0000000000750ef0
[   36.344359][  T370] PKRU: 55555554
[   36.344481][  T370] Call Trace:
...
[   36.345054][  T370] qfq_reset_qdisc (net/sched/sch_qfq.c:357 net/sched/sch_qfq.c:1487) sch_qfq
[   36.345222][  T370]  qdisc_reset (net/sched/sch_generic.c:1057)
[   36.345503][  T370]  __qdisc_destroy (net/sched/sch_generic.c:1096)
[   36.345677][  T370]  qdisc_graft (net/sched/sch_api.c:1062 net/sched/sch_api.c:1053 net/sched/sch_api.c:1159)
[   36.346335][  T370]  tc_get_qdisc (net/sched/sch_api.c:1528 net/sched/sch_api.c:1556)

Fix this by only calling qdisc_tree_reduce_backlog in peek after the
qlen is restored.

Fixes: 342debc12183 ("codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_codel.c | 48 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 317aae0ec7bd..7d5076196aff 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -56,7 +56,7 @@ static void drop_func(struct sk_buff *skb, void *ctx)
 	qdisc_qstats_drop(sch);
 }
 
-static struct sk_buff *codel_qdisc_dequeue(struct Qdisc *sch)
+static struct sk_buff *__codel_qdisc_dequeue(struct Qdisc *sch)
 {
 	struct codel_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *skb;
@@ -65,13 +65,51 @@ static struct sk_buff *codel_qdisc_dequeue(struct Qdisc *sch)
 			    &q->stats, qdisc_pkt_len, codel_get_enqueue_time,
 			    drop_func, dequeue_func);
 
+	if (skb)
+		qdisc_bstats_update(sch, skb);
+	return skb;
+}
+
+static void codel_dequeue_drop(struct Qdisc *sch)
+{
+	struct codel_sched_data *q = qdisc_priv(sch);
+
 	if (q->stats.drop_count) {
-		qdisc_tree_reduce_backlog(sch, q->stats.drop_count, q->stats.drop_len);
+		qdisc_tree_reduce_backlog(sch, q->stats.drop_count,
+					  q->stats.drop_len);
 		q->stats.drop_count = 0;
 		q->stats.drop_len = 0;
 	}
-	if (skb)
-		qdisc_bstats_update(sch, skb);
+}
+
+static struct sk_buff *codel_qdisc_dequeue(struct Qdisc *sch)
+{
+	struct sk_buff *skb;
+
+	skb = __codel_qdisc_dequeue(sch);
+
+	codel_dequeue_drop(sch);
+
+	return skb;
+}
+
+static struct sk_buff *codel_peek(struct Qdisc *sch)
+{
+	struct sk_buff *skb = skb_peek(&sch->gso_skb);
+
+	if (!skb) {
+		skb = __codel_qdisc_dequeue(sch);
+
+		if (skb) {
+			__skb_queue_head(&sch->gso_skb, skb);
+			/* it's still part of the queue */
+			qdisc_qstats_backlog_inc(sch, skb);
+			sch->q.qlen++;
+		}
+
+		codel_dequeue_drop(sch);
+	}
+
 	return skb;
 }
 
@@ -257,7 +295,7 @@ static struct Qdisc_ops codel_qdisc_ops __read_mostly = {
 
 	.enqueue	=	codel_qdisc_enqueue,
 	.dequeue	=	codel_qdisc_dequeue,
-	.peek		=	qdisc_peek_dequeued,
+	.peek		=	codel_peek,
 	.init		=	codel_init,
 	.reset		=	codel_reset,
 	.change 	=	codel_change,
-- 
2.54.0


