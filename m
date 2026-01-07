Return-Path: <netdev+bounces-247676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3CCFD410
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 865D93003FF4
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E3432F740;
	Wed,  7 Jan 2026 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJO7uDsl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492332ED20
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782523; cv=none; b=dID0aToQ8BsSOC5sPfnqCpJGSm6tRkvb6fg0DEbVq1E2N+TDUnwUXZodXiPlUtTjOYyE5hgNOtVe4WOIKceA2I8iAKnDrYGjvxZyq0D9hJoD1+x+/Bkm4aKL6buJ0EeUEjs95UdAgfhT3oy6QDHMXmQhfDHX3UrT4kUTGDf5N/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782523; c=relaxed/simple;
	bh=X/wxFcbZ/kyuWDchKXYBFqZzUOrlJH+wP+YngA1VzoA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jaRqpayfSfSZGCawGGgvm8O3gRrO5L2IxNK5QvRt6xagNDsg09f66V8su20r/F8zwLH4DJGiXIujByDn62QugC55AxkojwqDtt78fAVEZKNxN1ZP7K7+fr5cYzjMjofMlsamGSABzlKZqETGYMJW+CX9+swXljGa+UurGQFvqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJO7uDsl; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b2e2342803so501980685a.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 02:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767782521; x=1768387321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T7vbBihGHIZyntDpx8/k2lDC6Cmr31eEgz5mAjfRbC0=;
        b=OJO7uDslGZ1cTepfWJbGro7ipEw4eTQfxxRThih5opkXdeeOFXjg+sw6YoVmpdvV+Y
         mmULKDhg0nAeChpVbUQ3O5uWda7D7uRdTjOKrirXfpc40vR+fCahzE1Ltglp5SV/Ua+3
         jEG3mkwYsT7M4k9NW5ANnS8X7t5ltRvczQ1GjP+j5eYdFhETLVqA6IFnRs4Vm7McPu7p
         kgyc2PL2wTHjB/4lmUVMXM0IQJsnemNUNTHWSburzq9I5aaAy0A6cCSVEQkC2TH4/QcU
         Mu9FKJqTOp2oIG3NS74CSPPgdNo1xuyZFGS9NG0faAhlp4qelxhMzW24y3rI8el1nQyG
         Y1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767782521; x=1768387321;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7vbBihGHIZyntDpx8/k2lDC6Cmr31eEgz5mAjfRbC0=;
        b=sHisMEBe6YHIhmoUys3ALMb/yRmiemOYx1l7TqhWeB11Jsi5YMlLz8/kUEFtvfLNvI
         K2QmzA865tQ6AUBg1ZKs24+H76jkbYsacHpqivq5elzMzEx8Y3nHI5X0UvakZkwAsGsp
         J7XNZSxTYaZPog2EoYvDyCAcy5GZMbR/eFfU9srrM1YgD4/pHrehxMVexP1pJrXKs6Vg
         Eucq9aQiiERkHpK65VbyImvQjt1YWRGOI/uEPJCrA8UuypbtWs/Uj7996zBTK+3UCVe/
         PusstMorRjZLETdnoobHkeZ2Dd4GslgXgatEuS8g13cMymw4ewCLk8RW5Tq0fHgIU4wL
         iPJg==
X-Forwarded-Encrypted: i=1; AJvYcCXRfRZcMa7QWnvnPsOB5bTJWK5/nM0D42tPMNLE/BA+x074w3evv2DZ2NeQBhf8cl9z2cCy/3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoc8o2zgIcJHi1xR+WfWXOFHIhQJBVW2kBScgKjw79Q2Baiwik
	XRqneHgCyyOnAPM1750WeSOIKpCl9JZidpPcrPoqCEfScbI4MdX5W1M2RMOfyEsIVaAoKvr0Ui4
	jgDGNJ44wvedp7Q==
X-Google-Smtp-Source: AGHT+IGRtnzoVLRkTIfsCJtX4Gwei8zeELv60KpBaKOrYRLt6/QGNBnsUC+F9/25lRN4ueN5q4vF7v8ANOSMYw==
X-Received: from qkas21.prod.google.com ([2002:a05:620a:ab15:b0:8b8:a02:fe4b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:191d:b0:8b2:f0be:27e4 with SMTP id af79cd13be357-8c389368958mr227038085a.18.1767782521100;
 Wed, 07 Jan 2026 02:42:01 -0800 (PST)
Date: Wed,  7 Jan 2026 10:41:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107104159.3669285-1-edumazet@google.com>
Subject: [PATCH net] net: add net.core.qdisc_max_burst
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"

In blamed commit, I added a check against the temporary queue
built in __dev_xmit_skb(). Idea was to drop packets early,
before any spinlock was acquired.

if (unlikely(defer_count > READ_ONCE(q->limit))) {
	kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
	return NET_XMIT_DROP;
}

It turned out that HTB Qdisc has a zero q->limit.
HTB limits packets on a per-class basis.
Some of our tests became flaky.

Add a new sysctl : net.core.qdisc_max_burst to control
how many packets can be stored in the temporary lockless queue.

Also add a new QDISC_BURST_DROP drop reason to better diagnose
future issues.

Thanks Neal !

Fixes: 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
Reported-and-bisected-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/admin-guide/sysctl/net.rst | 8 ++++++++
 include/net/dropreason-core.h            | 6 ++++++
 include/net/hotdata.h                    | 1 +
 net/core/dev.c                           | 6 +++---
 net/core/hotdata.c                       | 1 +
 net/core/sysctl_net_core.c               | 7 +++++++
 6 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 369a738a68193e897d880eeb2c5a22cd90833938..91fa4ccd326c2b6351fd028a1c5d1c69126bee5f 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -303,6 +303,14 @@ netdev_max_backlog
 Maximum number of packets, queued on the INPUT side, when the interface
 receives packets faster than kernel can process them.
 
+qdisc_max_burst
+------------------
+
+Maximum number of packets that can be temporarily stored before
+reaching qdisc.
+
+Default: 1000
+
 netdev_rss_key
 --------------
 
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 58d91ccc56e0b54368c432fb9075ab174dc3a09f..a7b7abd66e215c4bcaece6f00ca03de3ac81396f 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -67,6 +67,7 @@
 	FN(TC_EGRESS)			\
 	FN(SECURITY_HOOK)		\
 	FN(QDISC_DROP)			\
+	FN(QDISC_BURST_DROP)		\
 	FN(QDISC_OVERLIMIT)		\
 	FN(QDISC_CONGESTED)		\
 	FN(CAKE_FLOOD)			\
@@ -374,6 +375,11 @@ enum skb_drop_reason {
 	 * failed to enqueue to current qdisc)
 	 */
 	SKB_DROP_REASON_QDISC_DROP,
+	/**
+	 * @SKB_DROP_REASON_QDISC_BURST_DROP: dropped when net.core.qdisc_max_burst
+	 * limit is hit.
+	 */
+	SKB_DROP_REASON_QDISC_BURST_DROP,
 	/**
 	 * @SKB_DROP_REASON_QDISC_OVERLIMIT: dropped by qdisc when a qdisc
 	 * instance exceeds its total buffer size limit.
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 4acec191c54ab367ca12fff590d1f8c8aad64651..6632b1aa7584821fd4ab42163b77dfff6732a45e 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -42,6 +42,7 @@ struct net_hotdata {
 	int			netdev_budget_usecs;
 	int			tstamp_prequeue;
 	int			max_backlog;
+	int			qdisc_max_burst;
 	int			dev_tx_weight;
 	int			dev_rx_weight;
 	int			sysctl_max_skb_frags;
diff --git a/net/core/dev.c b/net/core/dev.c
index 36dc5199037edb1506e67f6ab5e977ff41efef59..a8238023774407adbdb2e5d09dc009802870bd4e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4190,8 +4190,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	do {
 		if (first_n && !defer_count) {
 			defer_count = atomic_long_inc_return(&q->defer_count);
-			if (unlikely(defer_count > READ_ONCE(q->limit))) {
-				kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
+			if (unlikely(defer_count > READ_ONCE(net_hotdata.qdisc_max_burst))) {
+				kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_BURST_DROP);
 				return NET_XMIT_DROP;
 			}
 		}
@@ -4209,7 +4209,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	ll_list = llist_del_all(&q->defer_list);
 	/* There is a small race because we clear defer_count not atomically
 	 * with the prior llist_del_all(). This means defer_list could grow
-	 * over q->limit.
+	 * over qdisc_max_burst.
 	 */
 	atomic_long_set(&q->defer_count, 0);
 
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index dddd5c287cf08ba75aec1cc546fd1bc48c0f7b26..a6db365808178d243f53ae1a817938fb17c3f968 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -17,6 +17,7 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 
 	.tstamp_prequeue = 1,
 	.max_backlog = 1000,
+	.qdisc_max_burst = 1000,
 	.dev_tx_weight = 64,
 	.dev_rx_weight = 64,
 	.sysctl_max_skb_frags = MAX_SKB_FRAGS,
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 8d4decb2606fa18222a02e59dc889efa995d2eaa..05dd55cf8b58e6c6fce498a11c09f23fd56d8f34 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -429,6 +429,13 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
+	{
+		.procname	= "qdisc_max_burst",
+		.data		= &net_hotdata.qdisc_max_burst,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
 	{
 		.procname	= "netdev_rss_key",
 		.data		= &netdev_rss_key,
-- 
2.52.0.351.gbe84eed79e-goog


