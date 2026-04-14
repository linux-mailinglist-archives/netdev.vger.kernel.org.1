Return-Path: <netdev+bounces-278391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FqPKv8b3mmFnAkAu9opvQ
	(envelope-from <netdev+bounces-278391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:50:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D463F8F52
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02BF530D00BF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9903D7D8B;
	Tue, 14 Apr 2026 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVavkm82"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549AB3D5662
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163423; cv=none; b=gc2zHgNTCY0E6ka7Q0yqwt6k8p8as+8BLcBj59yxkuiIeKAjDtwrqL8jNDyzRael+4/yEbKCCN4fICnbNWgUwT+DdN+KiAuna9NtHZN6vrGO0NpOqo2l939J9+9PF6Vfsh0282L+5yiV6MUk3Jdun9ys6XP97emDRtLZIy9raDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163423; c=relaxed/simple;
	bh=YltDh2A8O2U9vk5yt1hOIdfJZJy0KrnykCQzCOPrV3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2+Azg/zkwqnGOShuwfTCCFCyJ0YxZG9e3xwxXo3II+BMuSvQongBn6TL3FXaPVlJJw0q2fSdhhjeV3SmiRNQFM+ElfCHFU5AXr1N+vymPZTdJ7jxlsi7vfm57DoO13j/c6EhveJk0OqM4ymETrlz8jHBCpPkh/fvgORe+1BOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVavkm82; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab232cc803so27085385ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776163415; x=1776768215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfnybGMnoxGjJ0hXXGbvVi2E4t4Gka9BqnzKdhcl8dQ=;
        b=nVavkm82nO+rY70ah9Q0hYBU0C+BJnbZx51fiqI83kI39+WZ77OI0c9GzOBi3R4hdQ
         UTINHHxIRRbWE9d/uLSztfPt7vE0rC4myIa7BwLMaaorJcf9wpFniRn/HIawctvoE71s
         iaTN9YnT4wgB6L/Py/MWbZIolcu5X9ONvi1RZ4ghEbbO7/itqK/LHK+g+NiH/27lJnGM
         qT3AvIsNj/oZ/h204vNZsFWbVGEwGk7Uosk7WG2GsVGM7qzRcQYnQboCGXM210eGChTw
         W++fZZSSHSkYgKk/dZGEFfYKhscT1PDQmbL/z3y2jnGiuQ+YEQdD6fTWvOmLz/eW16uY
         kZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163415; x=1776768215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfnybGMnoxGjJ0hXXGbvVi2E4t4Gka9BqnzKdhcl8dQ=;
        b=QkcDd/9axYAAke0JC2aIrjhlw3FbHrDTwXzcHOWGJsBczV/l8CZwpV3+7qn5aEPDRf
         U5us9GvKk01Ro6xwl40bzPHsUCH00oFTJZ6uaf69lvebO5XCLwYaTYuFUSEv5jkRICBQ
         mVZygziC+SdghnMrqp6w6PlQSk8ga9JYAUWEElrQen2HdL9MKBf1IZWKaXGyVKUSSMSA
         CHBvNiu8dFhov7+PHfkzlW9CICod5XmxwDyywoJ3eQOvWAJqTe2pyTRgf6daR2hMrb36
         APR1zh6dW1FAOKQkv8yj4wrNNsTShCLK8cKGdn09jGnAmExDpNeJJPoNHUHe20SXwxa1
         Fy3A==
X-Forwarded-Encrypted: i=1; AFNElJ+9W6lSYWvEa4/sCCrGnaz2hxSkv36vY2dEWU7QuVw4/H2BCs/daJ5IqLCrRjQnt3IEMB9Zkhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RPIRcSHCnRGE7q3hBl9ndNsBIEPRb9mZGXhR/9adAyMhy5oL
	W4cA4lPYqQZSSlXWO0xI1gL4oPtT23p3eeSCAfC+slHaQEgPZKJR4EoF
X-Gm-Gg: AeBDieu6gleLdZEZ9BIJDisM1K6u6ipMZIHuYx4zOFtDvtSR+fgysihDMQ1mJSyx8XX
	K/v33z2p5BlC6fmPSHoB/xGM0G4CYslvlv9qSa0+NhHsE94IV2xPSTmcedBXT+PsDLLdNpK+D1v
	XQ8h01zm1TpUW9LmL6Zvv8MjFZy4lMz5f95CYA1mFx8XPRNIeXs5VauQUGI7jXuggwyQ+g7AZow
	ippdXSiUU6dZ84z/6udMy4FgLSYOjjS5KyDHgV4B0uAdtuznjnt6dkTJso1oDsEY5rzOuEnVLdW
	i9tKxhGoXRcBNnoh/2WJFBOFP9p3sXx1n66/l8KO6eiywadNQUGPbXkhXOPDoFo7qy1k1kegmkz
	h3pQZXGm25mV9PD9/inTxO850E6wld8iF+TkSzZGPi2cndiBkl3ava9pZdGSVqwYtAMWtpKQzW9
	4ZoxO25u1j8o9vfsOydbyfMko5nC+dgupNBF65TsoFYS2tOiXTyJhVIAYzjuxr/d6oEfPdz1OEk
	nRBhyQLyqlk
X-Received: by 2002:a17:903:2847:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2b2ebed7f52mr67126875ad.13.1776163414902;
        Tue, 14 Apr 2026 03:43:34 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f469casm141703575ad.81.2026.04.14.03.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:43:34 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v3] net/sched: taprio: fix NULL pointer dereference in class dump
Date: Tue, 14 Apr 2026 18:43:12 +0800
Message-ID: <20260414104311.74115-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-278391-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06D463F8F52
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
 RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2475)
 Call Trace:
  <TASK>
  tc_fill_tclass (net/sched/sch_api.c:1966)
  qdisc_class_dump (net/sched/sch_api.c:2329)
  taprio_walk (net/sched/sch_taprio.c:2510)
  tc_dump_tclass_qdisc (net/sched/sch_api.c:2353)
  tc_dump_tclass_root (net/sched/sch_api.c:2370)
  tc_dump_tclass (net/sched/sch_api.c:2431)
  rtnl_dumpit (net/core/rtnetlink.c:6827)
  netlink_dump (net/netlink/af_netlink.c:2325)
  rtnetlink_rcv_msg (net/core/rtnetlink.c:6927)
  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
  </TASK>

Fix this by substituting &noop_qdisc when new is NULL in
taprio_graft(), following the same pattern used by multiq_graft() and
prio_graft(). This ensures q->qdiscs[] slots are never NULL, making
control-plane dump paths safe without requiring individual NULL checks.

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
---
v3: fix broken patch
v2: Also update NULL guards in taprio_enqueue() and
    taprio_dequeue_from_txq() to avoid qlen/backlog inflation (Paolo).
---
 net/sched/sch_taprio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index f721c03514f60..07723b156c5b3 100644
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
 		dev_deactivate(dev);
 
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


