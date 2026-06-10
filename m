Return-Path: <netdev+bounces-297810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jM5nL027KWrvcQMAu9opvQ
	(envelope-from <netdev+bounces-297810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:30:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989566C833
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:30:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=QSk70VVM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297810-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297810-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A1D630CF259
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181A43750D7;
	Wed, 10 Jun 2026 19:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FF374E6F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:29:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119758; cv=none; b=ST2VN3Z0k9+KYSu/I4Cu5TURNq3i/632LzB0UYzWIC0MB7DO4IEDQ7Gm8/1TCov+k8eDilLgCdRun1VtLO3JpwHsGtLNPlhmKQImK5jwFgH0GRiwCcfw83dkusJJo2SYGUh7X0LHMX1a82pCY3pwjkcFOO4W/FoaHURBTwmHnxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119758; c=relaxed/simple;
	bh=WTQbXspiYA5M0PCEsA38OITqt4ISBgGuDVKQEm1GJOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4qs/uEPHjhvibgcb9Rmu6vc+H5h8KCs2g2INmC/yuSLENrK8OlQlsmoTBMyVgQmjHCOT7BSzHQlY0E03rKunjtzTNDTpK+ake6L+JjXz025VhnZQsTZKQAgzPlk+eC2lmjDQN79M/6dZIchF+JGPdqg7n3qR+B8rc2O3fZBvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=QSk70VVM; arc=none smtp.client-ip=209.85.221.170
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59ebde7d704so2410558e0c.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781119755; x=1781724555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nauk6OrH6wb2my1Q0Z75MqgMo/CfPm1I5Ik71T9R5Y=;
        b=QSk70VVMn/OmsleefZL7B8ekRI5tZUQZTlu58rCAWfF2J6HcMC5FD5AGWvQ225tclc
         fZiDPcKbJwri2TJlqYCVXdHutdiMZXVw/09iU+s1bTEjmPv9jwg+1l7EKWenxyZ9NQ9t
         epfsl3r0SAZVyl6zaEHptz9XLd3Q6MYaVJKzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781119755; x=1781724555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9nauk6OrH6wb2my1Q0Z75MqgMo/CfPm1I5Ik71T9R5Y=;
        b=eVzLyJOvvD5+QIrcnK7m/q/zT6xwpj20RziY+C9ur1y99bqEe6Xjy4sDWRHglTYSKx
         ZjcMDmvrpoykc+MYvPQRe0EZ7P5mq0N0FDUTPRpeULxVVVnjhzO+AsgKvwKqi+8PxMR2
         w8g683yXhwZaEaBxr7J+MdrvWT+nyuBpDk7p80DuR0/EOBx32TJyVDJ7ceU+puEH7zVM
         pwknYgg82NTza1OCDSHfTNQNwlzEsM6ktIyhURCOt4p2VH69ofoW0eMgWUdmqFcabhnq
         TPdQxDVYpfRXqRzK53jiF1+v3OlHiJr06tJ2C979k0ibo8wzhX6wPGzZsty2459tr3Yp
         q0Sg==
X-Gm-Message-State: AOJu0Yx0enp8KcztyUTsKTpGwWE/KZbUs9x8i3hYzCBQMKbHRxvkg7yQ
	zlkgz2YRZFRTebIMuAhjdjQcSziQff2AWW0gQsRyUlm6qSQfvHgVcQM2vFFuCMIymA==
X-Gm-Gg: Acq92OHo5xn1kMhdPkAt+v8HbJlv0m3TCHrM0fzICcerYw0PEDbgOa/OayN7skMySxd
	nPf6pl87DQAwDlD61vndg5FZL0C3vLx3LphzbWuxJVeXeCMONQHN4c0pv1hPcEO3L2VZ3eUpsR8
	Vu61uLO4gaUhjKfpuGPBG/e9di3qhdcWaM164LRYwjs3ZdliQDpZmAM+qflJ1lwGguouvhaqv8C
	cXoYrhsSxu2gXWqh2rDQDZqSOenEWxfRbN2bFd+GYMCoc3adUVMzi+pbXLERk5+aB8wGB3g0xYv
	IhhlezUNHKZXTLqcE807bR9MejVV6oP72EHbrd7TfEttuTJZ6zoksJ+TSC1v2YWVF+xPdgBCNdf
	OG1SpMwX6jQDxWpkOIvRlpqveg4EtS62Revukdfp/7MQYlHI4iM6pN8r28CZPhXPjX5KY3Vm5zl
	5V6vYc1SvuYkBBousLfQnjqw9Eao3B5FCVdWJVazgyGEKd
X-Received: by 2002:a05:6122:32ce:b0:5a2:4391:1730 with SMTP id 71dfb90a1353d-5ac4dfe28a0mr12994052e0c.7.1781119755505;
        Wed, 10 Jun 2026 12:29:15 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm21848563e0c.5.2026.06.10.12.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 12:29:15 -0700 (PDT)
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
Subject: [PATCH net 3/4] net/sched: sch_dualpi2: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
Date: Wed, 10 Jun 2026 16:28:54 -0300
Message-ID: <20260610192855.3121513-4-victor@mojatatu.com>
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
	TAGGED_FROM(0.00)[bounces-297810-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 1989566C833

Whenever dualpi2 drops packets during peek, it calls
qdisc_tree_reduce_backlog. An issue arises because it calls
qdisc_tree_reduce_backlog before it reincrements the qlen. If qlen drops
to zero, but peek returns an skb, the parent's qlen_notify callback will be
executed even though dualpi2 still has 1 packet on the queue and, thus,
mistakenly deactivates the parent's class which leads to a null-ptr-deref:

[  101.427314][  T599] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] SMP KASAN NOPTI
[  101.427755][  T599] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
[  101.428048][  T599] CPU: 2 UID: 0 PID: 599 Comm: ping Not tainted 7.1.0-rc5-00284-gbce53c430ed7 #102 PREEMPT(full)
[  101.428400][  T599] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  101.428608][  T599] RIP: 0010:qfq_dequeue (net/sched/sch_qfq.c:1150) sch_qfq
[  101.428821][  T599] Code: 00 fc ff df 80 3c 02 00 0f 85 46 0c 00 00 4c 8d 73 48 48 89 9d b8 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 2d 0c 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b
All code
[  101.429348][  T599] RSP: 0018:ffff8881110df4f0 EFLAGS: 00010216
[  101.429541][  T599] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
[  101.429763][  T599] RDX: 0000000000000009 RSI: 00000024c0000000 RDI: ffff88811436c2b0
[  101.429985][  T599] RBP: ffff88811436c000 R08: ffff88811436c280 R09: 1ffff11021277523
[  101.430206][  T599] R10: 1ffff11021277526 R11: 1ffff11021277527 R12: 00000024c0000000
[  101.430423][  T599] R13: ffff88811436c2b8 R14: 0000000000000048 R15: 0000000020000000
[  101.430642][  T599] FS:  00007f61813e1c40(0000) GS:ffff8881691ef000(0000) knlGS:0000000000000000
[  101.430913][  T599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.431100][  T599] CR2: 00005651650850a8 CR3: 000000010ca0b000 CR4: 0000000000750ef0
[  101.431320][  T599] PKRU: 55555554
[  101.431433][  T599] Call Trace:
[  101.431544][  T599]  <TASK>
[  101.431628][  T599]  __qdisc_run (net/sched/sch_generic.c:322 net/sched/sch_generic.c:427 net/sched/sch_generic.c:445)
[  101.431792][  T599]  ? dev_qdisc_enqueue (./include/trace/events/qdisc.h:49 (discriminator 22) net/core/dev.c:4176 (discriminator 22))
[  101.431941][  T599]  __dev_queue_xmit (./include/net/pkt_sched.h:120 ./include/net/pkt_sched.h:117 net/core/dev.c:4292 net/core/dev.c:4831)

Fix this by only calling qdisc_tree_reduce_backlog in peek after the
qlen is restored.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_dualpi2.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index a22489c14458..05285775b454 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -579,7 +579,7 @@ static void drop_and_retry(struct dualpi2_sched_data *q, struct sk_buff *skb,
 	qdisc_qstats_drop(sch);
 }
 
-static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
+static struct sk_buff *__dualpi2_qdisc_dequeue(struct Qdisc *sch)
 {
 	struct dualpi2_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *skb;
@@ -605,12 +605,49 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
 		break;
 	}
 
+	return skb;
+}
+
+static void dualpi2_dequeue_drop(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
 	if (q->deferred_drops_cnt) {
 		qdisc_tree_reduce_backlog(sch, q->deferred_drops_cnt,
 					  q->deferred_drops_len);
 		q->deferred_drops_cnt = 0;
 		q->deferred_drops_len = 0;
 	}
+}
+
+static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
+{
+	struct sk_buff *skb;
+
+	skb = __dualpi2_qdisc_dequeue(sch);
+
+	dualpi2_dequeue_drop(sch);
+
+	return skb;
+}
+
+static struct sk_buff *dualpi2_peek(struct Qdisc *sch)
+{
+	struct sk_buff *skb = skb_peek(&sch->gso_skb);
+
+	if (!skb) {
+		skb = __dualpi2_qdisc_dequeue(sch);
+
+		if (skb) {
+			__skb_queue_head(&sch->gso_skb, skb);
+			/* it's still part of the queue */
+			qdisc_qstats_backlog_inc(sch, skb);
+			sch->q.qlen++;
+		}
+
+		dualpi2_dequeue_drop(sch);
+	}
+
 	return skb;
 }
 
@@ -1165,7 +1202,7 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.priv_size	= sizeof(struct dualpi2_sched_data),
 	.enqueue	= dualpi2_qdisc_enqueue,
 	.dequeue	= dualpi2_qdisc_dequeue,
-	.peek		= qdisc_peek_dequeued,
+	.peek		= dualpi2_peek,
 	.init		= dualpi2_init,
 	.destroy	= dualpi2_destroy,
 	.reset		= dualpi2_reset,
-- 
2.54.0


