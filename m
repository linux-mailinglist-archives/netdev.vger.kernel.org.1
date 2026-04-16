Return-Path: <netdev+bounces-279113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JQ5Isgy4Wm4qQAAu9opvQ
	(envelope-from <netdev+bounces-279113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:04:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AB5413F55
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E674C30616CF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D63C3491C9;
	Thu, 16 Apr 2026 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuO7+Ed5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19359340280
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365722; cv=none; b=TUYuMAv3IPyeVZL28+vZd4QXk789km9ZxUdLb0UUZs/WBVybT3g1XLYXZXW4RMi31piIFmjocqG/kuWni4nXDV9wKXSbA9VTKkgsITyUS/b/NVadKo/lrnbyKFT+lwhKHIjrQkzAvR+wwUozUcCgcPSPQbtajNSTH5WpUiRsWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365722; c=relaxed/simple;
	bh=5Qo+eAz3SBKadm4Z8gZJ/qNzFApy6MaZ8rec1M7Tiz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qe7dKDAV/R1vDEgn3D4rSkUWBSMmlttAIIqcodvu13cYctuQkMuHiVQHI5lfP1rqTJX1K9H9XZYgQRK/A8z3drN8JYOjU2e8j8PP0mpWrEL0qFM6pTPqnYSP+QPAUay45i0JPgVnMRI3L1r5S16UnPn8V/qzvAFswvU3iCAmWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuO7+Ed5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so974543b3a.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365720; x=1776970520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gfLwe6MOspavv7FeIUqnxHqxQUhY4jmj4V6sVwADv8=;
        b=SuO7+Ed5Sd0p20+BRsOtBzQ+T1aToNSRcjWm7m0TTFsW4XhcT5FptzPWmErtqOYXIU
         Ihezea1JehizNfTw4F1zpVZk6c2WrLZivRfCkqLP7YpyUpM2lCHM8jYkTf3fRMo/8GHR
         OOwsUu8H0bgJBGeF0+2WjLMexeM4mVM/AmqH6Uns93nLHJEKZ+8ZgFXU5EWbSfi+5Zo+
         qd6pqlQ4RH+OJwaGf8z3S1GPw6XppToX9I4jU1YNDf+oFInCU85OJ7xMzARmdxcKa8sG
         XQHWcs8+GYR/7TTPAMK4nDGa38qQCZX6/+SG5LiXDz8Ws0mGti3OOJ1H9cYHMY4QX/rc
         8G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365720; x=1776970520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/gfLwe6MOspavv7FeIUqnxHqxQUhY4jmj4V6sVwADv8=;
        b=Eyt1EM1TZa7OlhDr4jyjmdIfw/kN7aagi0FVauwVihH0l9YXIWLi1+fTJ4GHd/vtQj
         3QJVeHJyy9f+6q15FHT9VNC3MzIrJrDNOolExrDrt0ua1hSJvzUGiPMIuPWlXuXcyVpU
         +kcWWdEGonURfelOgENcsGpOjWX3saPR4+XyZcuHOE3vTWGV2SJhkieIx0qLB4g4kh5f
         OB2I9w9loh+4FKU0hJS1rxI/kfl3WjVMYEOxpjVzetNyMWIGp1r7yCcLXHqI/byCBHwO
         y5QtiTBSCYkt5KxKH8Ra0F6Qzj44o9gwDcX3uvH8ZO7Pu6uPJ0Jp44nCNgl2BLVNeu7o
         sYyA==
X-Forwarded-Encrypted: i=1; AFNElJ+AZJjXQuCgtIAZ9RL4lTZ80qwOxo0ORK/iJIrzPZ0bPS9ggcROeFsMZiStlFDLp2GGFcMPLxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAT+vok+Ho1W7sLQJAyvrn4pxCooSTnJR5SRlg953yXj9cF4hb
	+30o75zRUsp0iz5T/EIq3Lcaxkt6INoj2AUOakvj/vftEHYXT2S959PK
X-Gm-Gg: AeBDietzudCFQdj8pHH43QLYMOkzPzV0VP0EB9vdlYB3wK7Xb1/eM8VSyqtSxzg/hea
	h0ANwILamZQnLDzAotgjHWk1i5gN5WDeR4VAgMEO5Sy+LWObH6m+P4KYHlTYnPi69NQwzqgbPhq
	qkhQbabInmq5mT7O4M2KxA9bkx5dfC6aG7SwtDp6VajR5b93FcwqvdlXq0mvEZ175uIjTvsSSVG
	WDlWq/qdSNgpyXOBWlM3vxjmz8aGlbVV05zeX+XF43jgjuJSb8YcLyKVLvIs6IXpDiaQ77u1Q49
	jts7yd65vG0a7zLavYz8QkRZOa329Dmpu2FV5mBuNRgI0b3rB8uqwTWOLsEIaNvhdKMQPat+20Q
	oaZCiflzI5LepDdGsma39h6kdhXmtZTCan8ZVetGtN9cGtlWhiQJ8Kdk0hPtRafcOUzWey1jkFH
	zGYv7hgtPJN/N1nVISEz3dHVfDYyv5rFWpxWGZpquth4N+LYWQJn2JGQujYFK40Ou7o96d3b4hK
	KXmCUzoBlpz3v6eVwTVwSKz32BzqhjiUA==
X-Received: by 2002:a05:6a00:1d95:b0:829:8c08:d1f4 with SMTP id d2e1a72fcca58-82f889133c7mr477950b3a.39.1776365720339;
        Thu, 16 Apr 2026 11:55:20 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6744b350sm5668181b3a.54.2026.04.16.11.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:55:19 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: jhs@mojatatu.com,
	vinicius.gomes@intel.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: horms@kernel.org,
	vladimir.oltean@nxp.com,
	xmei5@asu.edu,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v4 1/2] net/sched: taprio: fix NULL pointer dereference in class dump
Date: Fri, 17 Apr 2026 02:55:01 +0800
Message-ID: <20260416185501.647884-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416185501.647884-2-bestswngs@gmail.com>
References: <20260416185501.647884-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279113-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,asu.edu,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.583];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22AB5413F55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a TAPRIO child qdisc is deleted via RTM_DELQDISC, taprio_graft()
is called with new == NULL and stores NULL into q->qdiscs[cl - 1].
Subsequent RTM_GETTCLASS dump operations walk all classes via
taprio_walk() and call taprio_dump_class(), which calls taprio_leaf()
returning the NULL pointer, then dereferences it to read child->handle,
causing a kernel NULL pointer dereference.

The bug is reachable with namespace-scoped CAP_NET_ADMIN on any kernel
with CONFIG_NET_SCH_TAPRIO enabled. On systems with unprivileged user
namespaces enabled, an unprivileged local user can trigger a kernel
panic by creating a taprio qdisc inside a new network namespace,
grafting an explicit child qdisc, deleting it, and requesting a class
dump. The RTM_GETTCLASS dump itself requires no capability.

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
 RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2478)
 Call Trace:
  <TASK>
  tc_fill_tclass (net/sched/sch_api.c:1966)
  qdisc_class_dump (net/sched/sch_api.c:2326)
  taprio_walk (net/sched/sch_taprio.c:2514)
  tc_dump_tclass_qdisc (net/sched/sch_api.c:2352)
  tc_dump_tclass_root (net/sched/sch_api.c:2370)
  tc_dump_tclass (net/sched/sch_api.c:2431)
  rtnl_dumpit (net/core/rtnetlink.c:6864)
  netlink_dump (net/netlink/af_netlink.c:2325)
  rtnetlink_rcv_msg (net/core/rtnetlink.c:6959)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  </TASK>

Fix this by substituting &noop_qdisc when new is NULL in
taprio_graft(), a common pattern used by other qdiscs (e.g.,
multiq_graft()) to ensure the q->qdiscs[] slots are never NULL.
This makes control-plane dump paths safe without requiring individual
NULL checks.

Since the data-plane paths (taprio_enqueue and taprio_dequeue_from_txq)
previously had explicit NULL guards that would drop/skip the packet
cleanly, update those checks to test for &noop_qdisc instead. Without
this, packets would reach taprio_enqueue_one() which increments the root
qdisc's qlen and backlog before calling the child's enqueue; noop_qdisc
drops the packet but those counters are never rolled back, permanently
inflating the root qdisc's statistics.

Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual q->qdiscs[]")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 net/sched/sch_taprio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8e37528119506..e866e5288c3e6 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -634,7 +634,7 @@ static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	queue = skb_get_queue_mapping(skb);
 
 	child = q->qdiscs[queue];
-	if (unlikely(!child))
+	if (unlikely(child == &noop_qdisc))
 		return qdisc_drop(skb, sch, to_free);
 
 	if (taprio_skb_exceeds_queue_max_sdu(sch, skb)) {
@@ -717,7 +717,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	int len;
 	u8 tc;
 
-	if (unlikely(!child))
+	if (unlikely(child == &noop_qdisc))
 		return NULL;
 
 	if (TXTIME_ASSIST_IS_ENABLED(q->flags))
@@ -2183,6 +2183,9 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
 	if (!dev_queue)
 		return -EINVAL;
 
+	if (!new)
+		new = &noop_qdisc;
+
 	if (dev->flags & IFF_UP)
 		dev_deactivate(dev, false);
 
@@ -2196,14 +2199,14 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
 	*old = q->qdiscs[cl - 1];
 	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
 		WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) != *old);
-		if (new)
+		if (new != &noop_qdisc)
 			qdisc_refcount_inc(new);
 		if (*old)
 			qdisc_put(*old);
 	}
 
 	q->qdiscs[cl - 1] = new;
-	if (new)
+	if (new != &noop_qdisc)
 		new->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
 
 	if (dev->flags & IFF_UP)
-- 
2.43.0


