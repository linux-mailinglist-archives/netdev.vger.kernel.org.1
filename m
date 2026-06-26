Return-Path: <netdev+bounces-302238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5xF4H0quPmquKAkAu9opvQ
	(envelope-from <netdev+bounces-302238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:52:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F546CF459
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:52:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=Flxz4pdM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302238-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302238-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2163D30583D0
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356173FE674;
	Fri, 26 Jun 2026 16:52:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71D3FD131
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 16:52:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492728; cv=none; b=ie+0x0lSeIRIDGJr6YTrQYlyuo+c8r3jfpsEEnysCauNTGfPyml8Jr5k+wdMaSp+jBQVKeXQ0G05FZTcfXz6TqwiN6m/g/Q8obVQq2BhSnHpg0oVFWFFs3XreY4VvehRP0ajGamkOOgUhRH1of7KI8/5m/SFGp9HirvKjew4CLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492728; c=relaxed/simple;
	bh=Kv1pCNa4AGxs+0GNCCLsz+zl6t3qjPAshD8fX4AsOXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwisRBxS4/DfO7VHEDT6hBiuI/R79hFgLkGA188pZ1vw/j5fQ2foXcxfR+pXDOdhftGR+REo6FdGM6Mv5QnYf1XB93ywQYwyaWFowF5o64Gi3WIuWbD/k7X8R9bvoucfVpAFk+9Cljj5xPQnZS43Zrn0/TRYrqQsunqY4ajK2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Flxz4pdM; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92b21f65b60so45776985a.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782492726; x=1783097526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz+L1/Su9AEPUILxJxLQJzJejPxQKg7ou0p4PQtWgUQ=;
        b=Flxz4pdMzARAo07Ct2ZuD7rONzUQ2ZoBABDcCQCiAztpLzwFJu8OV7I96y9khfamSd
         TcRCtubmq/3Sy0C1kACOEzf/yfuL1S+SzNnxWAPARUZlQyPAYFMFW/IDo+2PLGz+KO73
         soaGHtKtSZnQyF5KUs1f9uENsvZxKL5v3vrng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492726; x=1783097526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xz+L1/Su9AEPUILxJxLQJzJejPxQKg7ou0p4PQtWgUQ=;
        b=LgUUfU3kxSt+WrhT2h2Hwu5/N5i7nNRX5n0rJz3L+rwY1KNNv583YoAcqvCd99gCYE
         kbEiHW7QfnIy6jp6M8y7QtWK04NvQFAH0wgiQidIKMX1c5Ol8tt6AcV+xyrFIEX+XJue
         9s8IHoJqJRQjEMu8fWwEi97pP6Jop9wA4XVCgClps5BR5whOPxEkcjcmbRKl/qDiZHhH
         /N6HFuH4YT/uvsuobGKwXqHtHHpLHWkZMQ35ZhIIx9cPpgQ7MtvTGeqESWK43p0i1BI2
         okl2QnIDsL1rSOjqziQcT1xvbqX0U2MHNsRtqUt+bNSOe37jECa7YPOFW5DQYksXVCcV
         eurA==
X-Gm-Message-State: AOJu0Yw6SpSppSz5DY9dFyqip90aYNyCPFOJrW6mheQCN9ub9ZRmZfgK
	OnKDvbK5ehugnC8vUJGKLGHIGGwRPl0jOdSYWnAlFbBzOyjYnb9FeymCoTG4zOfhEC7pbkJWZOi
	UJm23AA==
X-Gm-Gg: AfdE7cnDSYmlOpOMbakcE/XHv08A008gShwnILhKTYbByRaBXltv8/aSNKep9e5NjxJ
	ns8PnBMLo5RARj6qDbdARqoTZ9YVvyNUrhI9al9uHis6svvDFJ/GAbfGMNh8RDo87sns3ZLAG4c
	5dHOvkhrgEXYtiUaO3dllZm9nL0fAfKdTwBNLbvgFFo/zyeAFF2W9Wp8Z4dgOQlOEOIjwqLwt8j
	za15GuuajOIcpK0E0+5NdDuF1aj08Eg08R9856bLdCfwU8zQ3/P9gxnChn2hzw6Aarn7EUQyMus
	OtBOFFKyNFe0OpCHCetkVR3nNco/ciFwCphB7CZ7HgFAEEuxctEeipypSc0LSuKX12RWPnPlaAW
	ttuvXMvaVeoAtCYdLpBmRWm8QT/6hUg1QcuWqDIHhbfgu8JRGDwmEq/VHKe9JScwZ+aLOsoVO8l
	E+XxZKb65cE21enfKg
X-Received: by 2002:a05:620a:40c3:b0:92b:67e6:4b77 with SMTP id af79cd13be357-92b67e64fa9mr110327685a.33.1782492725576;
        Fri, 26 Jun 2026 09:52:05 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004abe29sm1216957385a.33.2026.06.26.09.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:52:04 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	toke@toke.dk,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kuniyu@google.com,
	sdf.kernel@gmail.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	krikku@gmail.com,
	mkarsten@uwaterloo.ca,
	victor@mojatatu.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 1/3] net: Extend bpf_net_context lifetime to cover qdisc enqueue
Date: Fri, 26 Jun 2026 12:51:54 -0400
Message-Id: <20260626165156.169012-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626165156.169012-1-jhs@mojatatu.com>
References: <20260626165156.169012-1-jhs@mojatatu.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302238-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:toke@toke.dk,m:jiri@resnulli.us,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:victor@mojatatu.com,m:ast@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:daniel@iogearbox.net,m:jhs@mojatatu.com,m:sashiko-bot@kernel.org,m:sdfkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,toke.dk,resnulli.us,linutronix.de,goodmis.org,gmail.com,uwaterloo.ca,mojatatu.com,iogearbox.net];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3F546CF459

The bpf_net_context used by sch_handle_egress() is stack-allocated and torn
down in that function returned. By the time tcf_qevent_handle() runs
current->bpf_net_context is NULL.

When a filter attached to a qevent block (e.g. RED's early_drop or mark
qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf helper
bpf_net_ctx_get_ri(). That helper unconditionally dereferences
current->bpf_net_context resulting in a NULL pointer dereference.

Note: The same holds for actions that invoke BPF redirect helpers
(e.g. act_bpf running a program that calls bpf_redirect()) during qevent
classification itself. And as a matter of fact the same assumption is
made in the code outside of tc.

Fix:
Move the bpf_net_context lifecycle out of sch_handle_egress() into
__dev_queue_xmit(), so that it spans both the egress TC fast path and the
qdisc enqueue. The setup is placed outside the egress_needed_key static
branch because qevents are independent of clsact/NF egress hooks and
that key may stay disabled when only a qevent-bearing qdisc is
configured. Unfortunately this adds a small unconditional penalty to the
code path _per packet_ only guarded by CONFIG_NET_XGRESS (two writes and
one read for bpf_net_ctx_set, plus one write for bpf_net_ctx_clear).

This keeps all bpf_net_context management in net/core/dev.c i.e the
existing boundary between tc core and BPF without requiring any net/sched/
code to know about BPF plumbing.

Reproducer (see the accompanying tdc test):

  tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB \
      avpkt 1000 burst 100 qevent early_drop block 10
  tc qdisc add dev eth0 clsact
  tc filter add block 10 pref 1 bpf obj redirect.o
  tc filter add dev eth0 egress protocol ip prio 1 matchall \
      action gact pass

  traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() and,
  on a redirect verdict, a NULL deref in skb_do_redirect().

Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..8c214bfff8aa 100644
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
-- 
2.54.0


