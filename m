Return-Path: <netdev+bounces-302558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nt9tHwtIQmo33wkAu9opvQ
	(envelope-from <netdev+bounces-302558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:25:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF8A6D8E02
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:25:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=x4hhWJE9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302558-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302558-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7834030530E5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333373BBFB0;
	Mon, 29 Jun 2026 10:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6F3DD523
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:22:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728542; cv=none; b=TIHdQGYh/4xHO3HuLmg6M5n/jbt7HZ+5yWrt+pWOnoTz2liOS0FFcLu3po789c4mlUZCenaggm3gtXmoUfSmM1dJaFT2VOtoquwiPDDd2uCXmXXem6niQwfqAb7z/X3zZcRCGUVhVY7PYb8f/bNuvbUdvZ6bnUgCzax0E0HuqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728542; c=relaxed/simple;
	bh=LQyuk+2XvgHA9CRUQzSGIGOjO95syCUcsge3kwP89SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qu94jZZiSSSXsGGnX3dyoBiTgxtgAXIHKYtL9XCAs7yRTlDOp54+2OofmZwK74d72fo4a07LzFBYno7RVcQpKtpHXTK8HG3yi8L09zpCfh+BBnsOM5xdbR1EwkeaImQe48LVRMKIDWWpNckdNHrY3dQ10XNg5Wt3phX9nLPWuSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=x4hhWJE9; arc=none smtp.client-ip=209.85.219.41
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eeb4508f29so17742996d6.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782728540; x=1783333340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKvM1smkzYAQlLOUZpGNh94x+wzWvVAEpjlRBYbmxwA=;
        b=x4hhWJE9TYcWIQTvFhgR6iZGSaaNlEQQY+cuuR4gS0KqL3BWFhPAOreUciYwqqSKRR
         NYFRaTIdPhw3vB70831WBFfJ0+4SEEpBXr2pbrUf6ktHQc1mkmYvytstq565GEcTi0p+
         vqQgg2LEDyBRve41Dlamemjw4U7UHD+ARu2W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728540; x=1783333340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKvM1smkzYAQlLOUZpGNh94x+wzWvVAEpjlRBYbmxwA=;
        b=SwX72Iw/b010jP1BDXovCm7f204SFCkeln7HhkZnXJLNWR2TiKlXRwqCFYyEo4pPGd
         ESb3ZoDGyHfmsOYRKxIxf6AgjCHcMiQx6oDgiSI1couOEK+AReAvtnOuAiNpuv/8Grbh
         EE2KWDg5KZTa7xa1EsDCnQb/S0XB91nSsYtvJ+WHPQWOtHAgMlX4R3ufL+eMs+HOdlEO
         34W8GpMZtN1UgadvqFj8mMpK0ko3qQFEKC3j4sEX52jr0ujBiM3bHSKDtQ0qu7UDsMXD
         pCmwslf5aNnx12OgVRVpKB5bmCD9QnI78WeFdBHE/3PwdjEW/GypO4hUPLFT0saAlMXu
         GmVw==
X-Gm-Message-State: AOJu0YxGOQhnBIaxMJaL4kWJLNamTs5q6+WrYN9v2S2ViXiV3p6o8IV6
	Bs6Jz/5Ib8phM2hOOpJngaUCpmx5+jl8RMzM9o9EcMSXSdovNsqXEBKjkyUee6xX3apfiCcugMV
	baXE=
X-Gm-Gg: AfdE7cndhUYnO6Kzz73HQJcRnEZM+j+DSlYKgpCXPzjjkZIaotPzmPK8XxCTdVnze7Y
	8vdHiwP0F3T9Tg1iDONx6zkxRGILGpZuHNNCMEhgqZ5/Ex/AeYTCnbAFjU7seacqjClDj6ejzMR
	YYjQgia200F3qyDabCZjUqgTWQXX20psq/Ie4OvHvs8BBsqOUqpTQCmlSSk58kr9ZrBBkgArQM/
	fdGeEf0/CryTKuKecStnXtuFsGggkvnDHzyU1vVftm+ZYkRFEG8NDNfjk00wuZQXUdDIJRIeXzx
	4ofDoDk+nqa4fACh5ifKUOLiEwV10x5vGQXHkw5VwOpEFL0s3mDhCQoIo3Rb9i34Uo3Cy97UN1v
	NyqYmXsp+/AO4iRqNkgV1NCfsGAuHUKTySoL7koaceJD0lx9dLibsMPq1t2rdQlN81wpFX+12Tm
	S64XFY/g==
X-Received: by 2002:a0c:f00a:0:b0:8e9:f5de:d5c1 with SMTP id 6a1803df08f44-8e9f5ded9fcmr144265496d6.56.1782728533809;
        Mon, 29 Jun 2026 03:22:13 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ef0f2b9df0sm53589236d6.13.2026.06.29.03.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:22:13 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	toke@toke.dk,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Machata <petrm@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 1/3 v2] net: Extend bpf_net_context lifetime to cover qdisc enqueue
Date: Mon, 29 Jun 2026 06:21:55 -0400
Message-Id: <20260629102157.737306-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629102157.737306-1-jhs@mojatatu.com>
References: <20260629102157.737306-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302558-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:toke@toke.dk,m:rostedt@goodmis.org,m:petrm@nvidia.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:linux-rt-devel@lists.linux.dev,m:bpf@vger.kernel.org,m:security@kernel.org,m:stable@vger.kernel.org,m:jhs@mojatatu.com,m:victor@mojatatu.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,toke.dk,goodmis.org,nvidia.com,iogearbox.net,gmail.com,lists.linux.dev,vger.kernel.org,mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEF8A6D8E02

The bpf_net_context used by sch_handle_egress() is stack-allocated and torn
down in that function returned. By the time tcf_qevent_handle() runs
current->bpf_net_context is NULL.

When a filter attached to a qevent block (e.g. RED's early_drop or mark
qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf helper
bpf_net_ctx_get_ri().  That helper unconditionally dereferences
current->bpf_net_context resulting in a NULL pointer dereference.

Note: The same holds for actions that invoke BPF redirect helpers
(e.g. act_bpf running a program that calls bpf_redirect()) during qevent
classification itself.

Fix:
Move the bpf_net_context lifecycle out of sch_handle_egress() into
__dev_queue_xmit(), so that it spans both the egress TC fast path and the
qdisc enqueue.
Note: The call is placed outside the egress_needed_key static branch
to cover the case where clsact static key is disabled. Unfortunately this
adds a small unconditional penalty to the code path _per packet_ only
guarded by CONFIG_NET_XGRESS (two writes and one read).

As pointed by sashiko [1]:
The same context must also be set up in net_tx_action()'s qdisc drain
path, since qdisc_run() -> netem_dequeue() -> qdisc_enqueue( RED child)
can trigger qevent classification asynchronously from softirq context.

This keeps all bpf_net_context management in net/core/dev.c i.e the
existing boundary between tc core and BPF without requiring any net/sched/
code to know about BPF plumbing.

Reproducer:

  tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB \
      avpkt 1000 burst 100 qevent early_drop block 10
  tc filter add block 10 pref 1 bpf obj redirect.o

  traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() and,
  on a redirect verdict, a NULL deref in skb_do_redirect().

Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks")
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..b95a8b153c76 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4527,14 +4527,11 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_EGRESS;
-	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
 		return skb;
 
-	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
-
 	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
 	 * already set by the caller.
 	 */
@@ -4550,12 +4547,10 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		/* No need to push/pop skb's mac_header here on egress! */
 		skb_do_redirect(skb);
 		*ret = NET_XMIT_SUCCESS;
-		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, drop_reason);
 		*ret = NET_XMIT_DROP;
-		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4565,10 +4560,8 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret = NET_XMIT_SUCCESS;
-		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
-	bpf_net_ctx_clear(bpf_net_ctx);
 
 	return skb;
 }
@@ -4767,6 +4760,9 @@ struct netdev_queue *netdev_core_pick_tx(struct net_device *dev,
  */
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 {
+#ifdef CONFIG_NET_XGRESS
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx = NULL;
+#endif
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq = NULL;
 	enum skb_drop_reason reason;
@@ -4795,6 +4791,9 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_update_prio(skb);
 
 	tcx_set_ingress(skb, false);
+#ifdef CONFIG_NET_XGRESS
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+#endif
 #ifdef CONFIG_NET_EGRESS
 	if (static_branch_unlikely(&egress_needed_key)) {
 		if (nf_hook_egress_active()) {
@@ -4898,12 +4897,18 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 	reason = SKB_DROP_REASON_RECURSION_LIMIT;
 drop:
+#ifdef CONFIG_NET_XGRESS
+	bpf_net_ctx_clear(bpf_net_ctx);
+#endif
 	rcu_read_unlock_bh();
 
 	dev_core_stats_tx_dropped_inc(dev);
 	kfree_skb_list_reason(skb, reason);
 	return rc;
 out:
+#ifdef CONFIG_NET_XGRESS
+	bpf_net_ctx_clear(bpf_net_ctx);
+#endif
 	rcu_read_unlock_bh();
 	return rc;
 }
@@ -5815,6 +5820,9 @@ static __latent_entropy void net_tx_action(void)
 
 	if (sd->output_queue) {
 		struct Qdisc *head;
+#ifdef CONFIG_NET_XGRESS
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+#endif
 
 		local_irq_disable();
 		head = sd->output_queue;
@@ -5824,6 +5832,10 @@ static __latent_entropy void net_tx_action(void)
 
 		rcu_read_lock();
 
+#ifdef CONFIG_NET_XGRESS
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+#endif
+
 		while (head) {
 			spinlock_t *root_lock = NULL;
 			struct sk_buff *to_free;
@@ -5860,6 +5872,10 @@ static __latent_entropy void net_tx_action(void)
 			tcf_kfree_skb_list(to_free, q, NULL, qdisc_dev(q));
 		}
 
+#ifdef CONFIG_NET_XGRESS
+		bpf_net_ctx_clear(bpf_net_ctx);
+#endif
+
 		rcu_read_unlock();
 	}
 
-- 
2.54.0


