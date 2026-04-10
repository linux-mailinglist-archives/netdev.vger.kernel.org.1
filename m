Return-Path: <netdev+bounces-277465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLBnDKkg2WkqmggAu9opvQ
	(envelope-from <netdev+bounces-277465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:09:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E13DA1E0
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A88B330EA082
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C635DD1C;
	Fri, 10 Apr 2026 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzlL0uh+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380533F38A
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835645; cv=none; b=KBnQ5pnJwKCdja8voNSGNHU6VH944+3ospx2e7MFIQo79pTYVfgJryfjkHftNhC6e74gqp/oRRvNE9rAQV9wo3syL9A7uhS1O6F+PVY7pxy9um9nlMuZewWdt+h7E0eFetryknNR2REwlVQi3pM/wG3YhUNEpVCMK3U1hxga2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835645; c=relaxed/simple;
	bh=WD2kItpaljpKgAUiK0BAZZLxKk2fz6dofRlZDFLW91k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVCj7oXk/Qh0uNtvAPkUVAzniwnhWEiBhslOzs/1XoAAvC1xucGaaxQGCF4ovSc7g4UamrMHeKJjiq02gAEwxPMEdUbBHgL3O4Q2ogwFkJ8aAR5w+VWR9LCeEUf1aa22KRVhjtELMMUKTXiXu6XGX32XiMLW7RnS/Li9C2bSrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzlL0uh+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82418b0178cso1181534b3a.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835643; x=1776440443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swiKP2dfJ7x8QYcvk/9GMzyobZM35ErBhsi1fgDGHl8=;
        b=FzlL0uh+QG8PbEEfWZCpzqaG2uY2TaAhpqBYKI+LqfJ0CrW3caowuDB8f7vumeqtm1
         OXTgQ4iHWaUfm/DI8q5QMN32Oqc8PNU9E+Iv/0DqujAHLqpQLmdHSZ7cpvQ6GD8Gz5BM
         KMpvN/25w5G7a+0Fd078YlpXnyLHeEP8cB9yNjXCOPEbHbwY1rWsSN6SL7bKPvB9oLDC
         D3h5Fxj2w7EbUzBcFV/GEoZsnIUw6TEfJv4rJHzREI0AGyLV8ts6UL4rHTawcGrjGhID
         DDZmrSYltc7ZaYU3D1alpaOIrm9Bi18P4g53LUIMngGOmZf6cL5Z4YRX4LJ2krDbV4wv
         phaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835643; x=1776440443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swiKP2dfJ7x8QYcvk/9GMzyobZM35ErBhsi1fgDGHl8=;
        b=rgfDZ5wnYJfxeDVrY6pc9sHMIYx67sVSkmlIla5tvMFOu3S3Qc58vYeeua+TOo6u4y
         rXUGBPrk0XsuDfVft2bkzRJ23Md8Za4W1ukdfKXLJ1TcVXhB4yKCxYqGr+zDDplCFOyQ
         7cZF9nJVmhB9+jH/NQxtH6H6o5Hp2fOIMzIhw0BmDvemDZz4khD8LkL3QaF6l9L3e659
         BIChjKYdZ8JXS537RfEPdqglesYoJbU0MpW+IGaBOyNx1i4zo2DKIgYwtcn4QGvw2DVo
         U5XzNxYsaYkjiQRsc+HYfPtTJj78xqqSVVqR2qxgE33QAvI4hopsP+iCJt1rOIxte0Bu
         4y5g==
X-Forwarded-Encrypted: i=1; AJvYcCWh+H7CWE2XLbL/O5IKMTW6xoHNxL3sTCN4uTTchyP4GfpbFiMZi6uEy7cTY6qp1FcFnSobwHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qEKjwLUDBKBV5PFX0uWe1jjJeP8bIuIN8KYoYKSq5B1Aun5V
	7qmtloSvtkikVTaFIc4fEXFI80s0rfrxAUz3Sh9BszcR3hPk5HuSP4jS
X-Gm-Gg: AeBDietMqw+71OYMkH/lmxLVX4p5HV824oPVa8j0/y3Ouoj76fBi7LEl9cLmMqK9XE3
	O5O8QNo08b/1rJ69GjvhSlzopDPh0enLcUiEkX6WGq/01bXtUf9ph69HGREfRw7EQOahKgjl26r
	wQyFkvx8GKufa9FdORfW2pTrvCKLAz5kBWpVULfxvZy/hyFha2m4Wj2Ha1CQ4NE/K5r2FHwxNe7
	zF7YMCugXniznpGYF7YCwZHLfX47Lr2vUoZ68ZasqIylX8hOhjL9Q8Vd7msLUCPIfKQTGSkhCjN
	U/4qFbQPI9hOTcmLugnFqXCDdAO1M/knGxKD1TIAvavNcjk/wc3wDIXn/+H6cunCYF42OwH7uFu
	Y0QqrhnG8imazQP0LzOuWXd/zjfjI+z3owXxD+MYiB1orWD12raOvOw+Pj4ZrDpzYAHUrQ8XpCP
	uVKvx8N8iXWm5ydUnX6dfHk90EjAOgEDSiIBmw/0bHMPwr575R5/SZUR2z4lXq9bFZ5BjyAO1ZV
	TipURp/NPOk
X-Received: by 2002:a05:6a20:2588:b0:39e:f994:f698 with SMTP id adf61e73a8af0-39fe403e6demr4394929637.48.1775835643205;
        Fri, 10 Apr 2026 08:40:43 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a3e6d2sm2678599a12.32.2026.04.10.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:40:42 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2] net/sched: taprio: fix NULL pointer dereference in class dump
Date: Fri, 10 Apr 2026 23:39:03 +0800
Message-ID: <20260410153902.955227-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-277465-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 895E13DA1E0
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

Also update the data-plane NULL guards in taprio_enqueue() and
taprio_dequeue_from_txq() to check for &noop_qdisc, so that packets
are still dropped cleanly without inflating qlen/backlog counters.

Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual q->qdiscs[]")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
  - Update NULL checks in taprio_enqueue() and taprio_dequeue_from_txq()
    to test for &noop_qdisc instead of NULL, preventing qlen/backlog
    counter inflation when noop_qdisc drops packets (Sashiko)
---
 net/sched/sch_taprio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index f721c03514f60..XXXXXXXXX 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -634,7 +634,7 @@ static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,

 	child = q->qdiscs[queue];
-	if (unlikely(!child))
+	if (unlikely(child == &noop_qdisc))
 		return qdisc_drop(skb, sch, to_free);

 	if (taprio_skb_exceeds_queue_max_sdu(sch, skb)) {
@@ -717,7 +717,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	int prio;
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

