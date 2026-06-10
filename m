Return-Path: <netdev+bounces-297808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vEC0Ayq7KWrocQMAu9opvQ
	(envelope-from <netdev+bounces-297808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:29:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4C266C82B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:29:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b="Hn6Eq/8p";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297808-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297808-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F8F331D015D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C759E374A1B;
	Wed, 10 Jun 2026 19:29:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947B36D4E1
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:29:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119749; cv=none; b=O/g87rwci7O0ELItZ0BOlzLqHMayErWPfdggh+zLOr3fPO7MHDea7cp/Ox2toIOdw74jDNCAKyanpjIkEmftkkInIADNT0Egrm5mJrwHmzuV8o+C9Ca+aE6nblkHeUp62Ajm9ltiE+EkvbQFsu9YNDWX+uYhMv+ug4sk3bewlII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119749; c=relaxed/simple;
	bh=CKa06CG3S7SDqedKKbznrl4b+wQhoo4WPd9giTNEkx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj/9vduLHe7tAhiWfMbCt28ZZE7iYNT9nKHLvbVYVbbeO2tWjWzn5zMn2GgIGkEpQvQWJkoIdj2aojjEIjjhEMDnjMt6jaJIKfR90ryc+h/uT5YmlxF0guu48Ei282REbC/hDVe+WE6pLywNV+tVeHbQgOfl8cpGNT46IU4/brQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Hn6Eq/8p; arc=none smtp.client-ip=209.85.221.179
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59b6227df10so4271649e0c.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781119747; x=1781724547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHQKG7QNo1JSttDULNveW5reSzpUhJMYd23RpqXmmKc=;
        b=Hn6Eq/8pa8+ZJDA9r+4Pz9ngyBvoXVzDuU+jxy9XBanChwegv/qDbvmL0SxwmldE4T
         bfca2wu2sdu4B8pLt0jOdNKLyKsViPpCasKJ0sldmk8/ljT0nWQlc+jHBMczQ+iV5MmQ
         bkwXuQlQE17ywLKnkmfpdxyAPr+wW1foWpdf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781119747; x=1781724547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHQKG7QNo1JSttDULNveW5reSzpUhJMYd23RpqXmmKc=;
        b=k/SoHeAxRYkhRlgQfxH14eY3V2O+K9LAAGWiE8nO1sA+5rUi/yzfKOzHg5TdHJ+QYL
         Rt1I2kc1IY0m4GkKS7wHVPCYr+381uniPtUciKq6MwxTUS2Ga7OUmRb2foI1nS4+kKk9
         gkGXEfJHqXN6wDsWBFls8aiMqzPSPjhamVtX7LP1USqrhvJ0rzvt/FIxrVnUGVcQDRt/
         Trh0wcUA2IwnnVxS6Y4R5Qc1t5XgfHsoDhKfKz8lfQ+2ThddUJLnwI0dEHkqEb/pov3M
         blCOYb8uUibSIj3XRKoijLNzBJHa8qrT/4jisYQprQBAPMinKkfzuIOB8N1+eyXDv+1N
         acEA==
X-Gm-Message-State: AOJu0Yx1QIq9oepRT/kgb5srs4BxOLDrVg3bglrqirzShGl12PytRHkJ
	kR2cXeuWG376pTNrQPmMLBAQd2IVQYdmZ4D+5zBOTvvmVOfvBqBLJyt6336p0BYjCg==
X-Gm-Gg: Acq92OFMLQyuU1jpQ8ADGYWbdje/wmPrh4S3lb7Mo/DCImHNhTj3TFVZkwvGUG0PRso
	PChmZj7Gbhivtyx1oIQ9VbH5G9qDj7e2NuwwA/KfYZKqqq7q6pADzm1ZYFLanbOdpI51YU5875p
	qUKtDgo/14APCeuVHYZ1P7mVQFYX0rBgmqqs+WZU/q+ZnnVlVzuOGQOrQtGX9cI9Z84xQZz+nkE
	DjIhR4acaSeaH6DkxIb+rIpSKtqdP9U/b4A7QNLgsY7GLZx/h6PK9FyNPbItRm9ejrMXRmp+rej
	ouUAzgx8eHZts/z35XfIW4RIiu3gB8yXacGMgdvQxYqIBeybdV1VAYynid6yHKXJRHP+LuAWMwy
	KzZSITe5lBO5lbszPOSxDksUiPWha6xV6F+88PbK/yHDM3MxGowk2XqfEVcER3a/rtMytDkN1dd
	ZkNIaJnd9tj3hqWAdVISjkQ7b/IMcLmQflog==
X-Received: by 2002:a05:6122:45a8:b0:5a4:3c79:f5a8 with SMTP id 71dfb90a1353d-5ac477d7f60mr15669080e0c.0.1781119747228;
        Wed, 10 Jun 2026 12:29:07 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm21848563e0c.5.2026.06.10.12.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 12:29:06 -0700 (PDT)
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
Subject: [PATCH net 1/4] net/sched: sch_fq_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
Date: Wed, 10 Jun 2026 16:28:52 -0300
Message-ID: <20260610192855.3121513-2-victor@mojatatu.com>
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
	TAGGED_FROM(0.00)[bounces-297808-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 5C4C266C82B

Whenever fq_codel drops packets during peek, it calls
qdisc_tree_reduce_backlog. An issue arises because it calls
qdisc_tree_reduce_backlog before it reincrements the qlen. If qlen drops
to zero, but peek returns an skb, the parent's qlen_notify callback will be
executed even though fq_codel still has 1 packet on the queue and, thus,
will mistakenly deactivate the parent's class causing issues like a recent
report [1] and a wild memory access in qfq:

[   29.371146][  T360] Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
[   29.371666][  T360] KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
[   29.371987][  T360] CPU: 6 UID: 0 PID: 360 Comm: tc Not tainted 7.1.0-rc5-00285-gc530e5b2dbc6-dirty #82 PREEMPT(full)
[   29.372384][  T360] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   29.372620][  T360] RIP: 0010:qfq_deactivate_agg (include/linux/list.h:1029 (discriminator 2) include/linux/list.h:1043 (discriminator 2) net/sched/sch_qfq.c:1369 (discriminator 2) net/sched/sch_qfq.c:1395 (discriminator 2)) sch_qfq
[   29.373544][  T360] RSP: 0018:ffff888102417370 EFLAGS: 00010216
[   29.373800][  T360] RAX: 0000000000000000 RBX: ffff88811224d568 RCX: dffffc0000000000
[   29.374079][  T360] RDX: 1ffff11021fe1543 RSI: ffff88810ff0aa00 RDI: dffffc0000000000
[   29.374368][  T360] RBP: ffff88811224c280 R08: dead000000000122 R09: 1bd5a00000000024
[   29.374649][  T360] R10: fffffbfff7940329 R11: fffffbfff7940329 R12: 0000000000000000
[   29.374926][  T360] R13: dead000000000100 R14: ffff88811224d580 R15: ffff88811224d578
[   29.375207][  T360] FS:  00007f5b794e5780(0000) GS:ffff88815d1e9000(0000) knlGS:0000000000000000
[   29.375545][  T360] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.375823][  T360] CR2: 000055ffb091f000 CR3: 000000010a305000 CR4: 0000000000750ef0
[   29.376103][  T360] PKRU: 55555554
[   29.376258][  T360] Call Trace:
[   29.376401][  T360]  <TASK>
...
[   29.376885][  T360] qfq_reset_qdisc (net/sched/sch_qfq.c:357 net/sched/sch_qfq.c:1487) sch_qfq
[   29.377074][  T360]  qdisc_reset (net/sched/sch_generic.c:1057)
[   29.377414][  T360]  __qdisc_destroy (net/sched/sch_generic.c:1096)
[   29.377600][  T360]  qdisc_graft (net/sched/sch_api.c:1062 net/sched/sch_api.c:1053 net/sched/sch_api.c:1159)
[   29.378593][  T360]  tc_get_qdisc (net/sched/sch_api.c:1528 net/sched/sch_api.c:1556)

Fix this by only calling qdisc_tree_reduce_backlog in peek after the
qlen is restored.

[1] http://lore.kernel.org/netdev/CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com/

Fixes: 342debc12183 ("codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()")
Reported-by: Anirudh Gupta <anirudhrudr@gmail.com>
Closes: https://lore.kernel.org/netdev/CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com/
Tested-by: Anirudh Gupta <anirudhrudr@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_fq_codel.c | 41 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 24db54684e8a..9aebf25ddc79 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -280,7 +280,7 @@ static void drop_func(struct sk_buff *skb, void *ctx)
 	qdisc_qstats_drop(sch);
 }
 
-static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
+static struct sk_buff *__fq_codel_dequeue(struct Qdisc *sch)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *skb;
@@ -317,12 +317,49 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
 	qdisc_bstats_update(sch, skb);
 	WRITE_ONCE(flow->deficit, flow->deficit - qdisc_pkt_len(skb));
 
+	return skb;
+}
+
+static void fq_codel_dequeue_drop(struct Qdisc *sch)
+{
+	struct fq_codel_sched_data *q = qdisc_priv(sch);
+
 	if (q->cstats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
 					  q->cstats.drop_len);
 		q->cstats.drop_count = 0;
 		q->cstats.drop_len = 0;
 	}
+}
+
+static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
+{
+	struct sk_buff *skb;
+
+	skb =  __fq_codel_dequeue(sch);
+
+	fq_codel_dequeue_drop(sch);
+
+	return skb;
+}
+
+static struct sk_buff *fq_codel_peek(struct Qdisc *sch)
+{
+	struct sk_buff *skb = skb_peek(&sch->gso_skb);
+
+	if (!skb) {
+		skb = __fq_codel_dequeue(sch);
+
+		if (skb) {
+			__skb_queue_head(&sch->gso_skb, skb);
+			/* it's still part of the queue */
+			qdisc_qstats_backlog_inc(sch, skb);
+			sch->q.qlen++;
+		}
+
+		fq_codel_dequeue_drop(sch);
+	}
+
 	return skb;
 }
 
@@ -725,7 +762,7 @@ static struct Qdisc_ops fq_codel_qdisc_ops __read_mostly = {
 	.priv_size	=	sizeof(struct fq_codel_sched_data),
 	.enqueue	=	fq_codel_enqueue,
 	.dequeue	=	fq_codel_dequeue,
-	.peek		=	qdisc_peek_dequeued,
+	.peek		=	fq_codel_peek,
 	.init		=	fq_codel_init,
 	.reset		=	fq_codel_reset,
 	.destroy	=	fq_codel_destroy,
-- 
2.54.0


