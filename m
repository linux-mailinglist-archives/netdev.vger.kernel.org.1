Return-Path: <netdev+bounces-280490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDxzF4n86Gl/SgIAu9opvQ
	(envelope-from <netdev+bounces-280490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:51:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B558F448ED5
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42AA4315DFFB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237D37F736;
	Wed, 22 Apr 2026 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnjXIO92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA83803F7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874838; cv=none; b=aOybX3Be3efqxZeWFCzHCPTFh/ZOftSu782qGK/1MY9mwa4CNkRkyxzYnNqb9Iz6rAuI2Ai5kpFBRAnyF77cGFYXCfWLaPvWNZbiqWsKu758d3LBudEf8EvcO0WkykTzfrQkN85pswpra3GKWWyuHmjVT8nn4/4+aMv+oJRzAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874838; c=relaxed/simple;
	bh=Hh1pW8TCbKrbRyYxSV+yEg7FM8rEKcdeMWZzSpi3Zls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rInvAgUXTMfjyl7Z8o2lmxlaYrU7tpvlyFlXhtPCVr/Ccc7G+Da8sW7UNYUo/QJAKt3rOEwDILrStJzszSCHs8Bxd2ADMQHQh0Bfrxj1XurZpvc6of7DP8FhgtYVJRSiQQ7phXTb129zoFVHHAKMLJpYB+Gp8G9QiNmC8JeQV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnjXIO92; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so4460318a91.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776874836; x=1777479636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7RXJ4fqCE+PSvOq7lwXbfz/521k66dE3TKDKqzl/LE=;
        b=YnjXIO92PE3jVdv4xTXtwIQ516Q61n+YY6VSHlKBSf2/odBU9WgloNEBJaeK9W+nE/
         g5Q+9fianYxp6YXE/mJAVrigMZ0vbBSjtwM1Snv4476LhlkVqn70s/0yZGnGLHIdl/D1
         0OXhG0c0+AY8Kn2UYsecd6+eZVX+GfgxZ+7+AlO0UdSq72cdn22IuIM+9TrnuwMCf+6m
         QeFHllfW6BDBuW/g6JaXS/dDYpCOOmQrN/Kwjlv1CaGZPKLz8T01ACLgPIjH8InS8AMa
         M/tCRuNS94B62q5X0bFTzxu+QIRF1yVnkdVRCpjSffovkW7KiBE9HdJZKDIaff35JHNO
         TZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874836; x=1777479636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7RXJ4fqCE+PSvOq7lwXbfz/521k66dE3TKDKqzl/LE=;
        b=R37hULzBtO1jhlwp/mpc7h4grQYdbmEPb9ctLPupeUHyJBBtkv+svXjYwNAIToDOvP
         oBraxOe1me3RUO2yw8LVjln4CxKY7HWRmZ9eFZXSNSWRLaCLboI+DaYSWYT9m/8vjnT1
         EeUCS/+dWz5jk3h1R05Se+l+KXirL7ZUZVdMzFR0Z2s6Y13Z3rkn4js/DbfJdgYyhI8v
         pmLn3KA6ywAe9ZBiXDxYXTUcAZ7mkOvCqb6RJhFKsRxXWWL8Lcv3Gfb0/RAp4cADGIES
         N75LoRyT0/BeXkulP2q/vm+v5JOo8rqOQGzxM6V3Gb0hcewtarzB5QR17yFL2eiWji0T
         o2IQ==
X-Forwarded-Encrypted: i=1; AFNElJ+liREa0FP8D09tUH3XmKmC/RF80LHeKwejZoQEnjSg8SHX4iQbOVd22plTN9h7EYMMTtFAnJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwerZAlOpIGg13eOvI/rJ/qHMMeogrTTege2TJ2u2mgEfe3/2Lb
	TOiqME2UpTrorVNVpjfl+gdMh8MXDe3ObY+EGT+P5Jd/ZfzaQSnmgryz
X-Gm-Gg: AeBDieu6Gr3N48Tl9T4A7UOYzGtpuKo5djD9Ov4icuZWV7hHKheBNGJw1uc9/6pxTqA
	hq2qJeZYDQKzuU+UseYFyPCAErPoIxRN/L+f26Hims9Z9018Md3EpRdYfaCldkpjKExnP6dH7ZF
	hcsqft3FXF8tcltRXtmVJP9Mo89SXisCRL+hYDw3cv3Se7P7LlOlyFOsncpZFrMmF5bZ4sNWJWW
	wPGbmlyyi8ZN33ym5svJvxUsdUkNNZJpRR4vMwTYGdRw5eO3ERZJpeRW59/nqmh9uOQ/E8lr2ub
	oMjJT+FxEg2N+7lWma9Ljgw41mFYX2ql2DGAIlEYlTP2Yb7+p1OkK8oKBCwPy/bcNBeeKN6EFzU
	1ABwvMe11Zfl8PYCXBo4WiJDjOUWX/5/U7RsOtpUTkKeztCNQK7glYYOk+xCavvCplHhWNCTaQk
	Lvrz3PeuG/zXhigVhQUU1LEXyvdLwQGH+e9WM9EkUxkb7hyA/2qqqT4NulQsTWbIXdH39MTWpAy
	Puxta86iSmLzU+3kd1eM8Q=
X-Received: by 2002:a17:90b:5865:b0:35e:27ec:dea with SMTP id 98e67ed59e1d1-36140493410mr25667475a91.23.1776874836157;
        Wed, 22 Apr 2026 09:20:36 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cdd1sm170335445ad.38.2026.04.22.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:20:35 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vladimir.oltean@nxp.com,
	shuah@kernel.org,
	xmei5@asu.edu,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v5 1/2] net/sched: taprio: fix NULL pointer dereference in class dump
Date: Thu, 23 Apr 2026 00:19:58 +0800
Message-ID: <20260422161958.2517539-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422161958.2517539-2-bestswngs@gmail.com>
References: <20260422161958.2517539-2-bestswngs@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-280490-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nxp.com,asu.edu,vger.kernel.org,gmail.com];
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
	NEURAL_HAM(-0.00)[-0.920];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B558F448ED5
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

After this change *old can be a valid qdisc, NULL, or &noop_qdisc.
Only call qdisc_put(*old) in the first case to avoid decreasing
noop_qdisc's refcount, which was never increased.

Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual q->qdiscs[]")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 net/sched/sch_taprio.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8e37528119506..a7daf34593e07 100644
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
-		if (*old)
+		if (*old && *old != &noop_qdisc)
 			qdisc_put(*old);
 	}
 
 	q->qdiscs[cl - 1] = new;
-	if (new)
+	if (new != &noop_qdisc)
 		new->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
 
 	if (dev->flags & IFF_UP)
-- 
2.43.0


