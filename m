Return-Path: <netdev+bounces-282012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HnrKZDs8GmBbAEAu9opvQ
	(envelope-from <netdev+bounces-282012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:21:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2899A489D06
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90BA7308DC65
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AB1423A8B;
	Tue, 28 Apr 2026 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rz2L0er+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81553B2FC8
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395864; cv=none; b=kwHoUK6OcqFh0lC//ld07h1gKf7UWb+IdqM1x/6HV+G5naCD9Nt2KmIVl/n0RxiCE0WQ/HzaLGRgr7OsU4TeIYuYjkZU5ypv+4H7EXEyv4vwft/3QBGoNau2ppjCAo44+7CWQAal0kbJbA8mebnfBXADTFiEeubwwIC9DJ4NenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395864; c=relaxed/simple;
	bh=avy4Npj6hGl/syx9dm8nIcEDDdLLgrp899VzhfMt4bU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mAaYjgLfrptXTbqsIeV+fv622CQrbLOgERwBUgcD8pPIz2LTRqXR5rpWor+jtHsKUYgh+UzxAIzMUaW0D3NzMuenNb5x4Vq/d1zagsnASDIASLVbtWW6SZhSXv4MWSiKKGlelWgV/iH2OyGa5JqqBjPsxuFXtvWEWLGEAdhEU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rz2L0er+; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8a275472d89so184870036d6.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777395862; x=1778000662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1C/7/R1PkydHET+4UJzU2q+hhlxjTP+Gc0Qf3MP1cY=;
        b=rz2L0er+lqti+PSmIJLumnVoL6oqw4WzeQQdHHqcja6AyUxVhoN/kufAp8OYoorMQF
         /f5R74TzQ2tcuVlV5C9dTaGSDoymnGOIVA/Ak5oxtVHEdq6wsan9+qeLSnA0Mk9R7P/k
         MjZDpcxm8WhXosCnkLpXn19UNdsQzKkzWJw1fOmm4f3Whhlpe/13xmesZ6+LAST+ly0Y
         mjhsNWfkI9e1po1IwnXZFlSBWN0OoEnVZIxufkTObdzDIGOdY3bSKrtCiXj9shaFD/RT
         N0QImBk7z4CP0jFLew4F4h7f180Zo/oUYB59DVHvPLeyShoGP/8aVYHSrgn9zVH/sYK8
         6B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395862; x=1778000662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1C/7/R1PkydHET+4UJzU2q+hhlxjTP+Gc0Qf3MP1cY=;
        b=MOqYrhUR7042Z9VJ9UjN/9RwJk42iRfzwOt5NE9m8sWH7F/gnN6d+FaxR1OAbYdM8/
         dwK05N9qYyeML227xGkPagGtsLuu2ON7H2zdBUKadXbuCnmGy99ahXA7PirbNWGlRBB2
         Y+mQEKqkb9IuhGS/BTY5v80cK1Qe2zUJhtYN9kj4t6pQQJkPAtuqkLUGBm7MyjSrvs9k
         ApLZdBlfW9qy9Q3Zwa8RW7GBfZCcY/Tj5zDztR2qhGWQzP9tDMjz/pJ0ee82a415MfXL
         lt4s8ifI5Ct29NBCZ/nzvmWLjPM7VvRzBKo7KkSmNHkrboDUmxSPk8n+gszw2qrtK44U
         0kWg==
X-Forwarded-Encrypted: i=1; AFNElJ/Qlcx6Zwcot6hg5BucNgV0F54ZrHBCyO5ZsLUrunnZl9jBoYD4p6yB1jhlthL+nYkgxNaHODc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztiNhIOiE89VUlXP9GnN4o7zYg3XmfqjYDzUAIZYf0F74Ou53v
	Vx/9pqYFJMxwzdwZNdCq2b5IbDeW0ovW0FzrBw6wSS1aI00jYarfNueOxI/7KYUe4TUuJGR+VKl
	1IpfkIbziSGMhLg==
X-Received: from qvhd14.prod.google.com ([2002:a05:6214:21ce:b0:89c:87f9:550e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:21e1:b0:8ac:a87b:c81c with SMTP id 6a1803df08f44-8b3ede02945mr4228626d6.44.1777395861242;
 Tue, 28 Apr 2026 10:04:21 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:04:13 +0000
In-Reply-To: <20260428170414.250566-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428170414.250566-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428170414.250566-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] net/sched: switch tc_dump_qdisc() to for_each_netdev_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2899A489D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282012-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Use for_each_netdev_dump() instead of for_each_netdev().

This is more scalable, and will ease RCU conversion.

This also offer better behavior when other threads
are adding or deleting netevices concurrently.

This enables dumping qdiscs for a single device
at user space request in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 029e0f87ea9c61cc757432a07a6af92c90c551ef..641f5a01aca167dd230173078f2db5801dca58da 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1877,18 +1877,18 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 
 static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(skb->sk);
-	int idx, q_idx;
-	int s_idx, s_q_idx;
-	struct net_device *dev;
 	const struct nlmsghdr *nlh = cb->nlh;
+	struct net *net = sock_net(skb->sk);
 	struct nlattr *tca[TCA_MAX + 1];
+	struct {
+		unsigned long ifindex;
+		int q_idx;
+	} *ctx = (void *)cb->ctx;
+	unsigned long s_ifindex;
+	struct net_device *dev;
+	int s_q_idx, q_idx;
 	int err;
 
-	s_idx = cb->args[0];
-	s_q_idx = q_idx = cb->args[1];
-
-	idx = 0;
 	ASSERT_RTNL();
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(struct tcmsg), tca, TCA_MAX,
@@ -1896,42 +1896,40 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 	if (err < 0)
 		return err;
 
-	for_each_netdev(net, dev) {
+	s_ifindex = ctx->ifindex;
+	s_q_idx = ctx->q_idx;
+
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
 		struct netdev_queue *dev_queue;
+		struct Qdisc *q;
 
-		if (idx < s_idx)
-			goto cont;
-		if (idx > s_idx)
-			s_q_idx = 0;
 		q_idx = 0;
 
 		netdev_lock_ops(dev);
-		if (tc_dump_qdisc_root(rtnl_dereference(dev->qdisc),
-				       skb, cb, &q_idx, s_q_idx,
-				       true, tca[TCA_DUMP_INVISIBLE]) < 0) {
-			netdev_unlock_ops(dev);
-			goto done;
-		}
+		q = rtnl_dereference(dev->qdisc);
+		err = tc_dump_qdisc_root(q, skb, cb, &q_idx, s_q_idx,
+					 true, tca[TCA_DUMP_INVISIBLE]);
+		if (err < 0)
+			goto error_unlock;
 
 		dev_queue = dev_ingress_queue(dev);
-		if (dev_queue &&
-		    tc_dump_qdisc_root(rtnl_dereference(dev_queue->qdisc_sleeping),
-				       skb, cb, &q_idx, s_q_idx, false,
-				       tca[TCA_DUMP_INVISIBLE]) < 0) {
-			netdev_unlock_ops(dev);
-			goto done;
+		if (dev_queue) {
+			q = rtnl_dereference(dev_queue->qdisc_sleeping);
+			err = tc_dump_qdisc_root(q, skb, cb, &q_idx, s_q_idx,
+						 false, tca[TCA_DUMP_INVISIBLE]);
+			if (err < 0)
+				goto error_unlock;
 		}
 		netdev_unlock_ops(dev);
-
-cont:
-		idx++;
+		s_q_idx = 0;
 	}
+	return skb->len;
 
-done:
-	cb->args[0] = idx;
-	cb->args[1] = q_idx;
+error_unlock:
+	netdev_unlock_ops(dev);
+	ctx->q_idx = q_idx;
 
-	return skb->len;
+	return err;
 }
 
 
-- 
2.54.0.545.g6539524ca2-goog


