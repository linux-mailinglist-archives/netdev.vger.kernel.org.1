Return-Path: <netdev+bounces-281326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEJRNjhk72mHAwEAu9opvQ
	(envelope-from <netdev+bounces-281326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:27:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DCD4735CA
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B47213017252
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27A03C8737;
	Mon, 27 Apr 2026 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPKG0Gbl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D733C8724
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296366; cv=none; b=NXqz+OLMQSEHiCN772YqFLjkf1zUZevAT/yfwsnHWIXaJ0kchZNJVQ4LhcLurqZDLLHhmbiXRGaLCW1ptApAQ0fiFIQ5NwR9c2keEDVQ0Qq3r92NPizJqAucx4u4UrKdASzAJxqjOqhJTfDPf0iDFE+RfqJLaeZbmGG7HFKhqgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296366; c=relaxed/simple;
	bh=eO6BZaF8tID+HMHZwjDSJTW+C//Sv/VCQY6Y5kdBxc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CAqQmjKcZZLMzyFhFPnN0pgZucu0Ashv3OD1+z7/jsAOBvgoeZbBz19SPsKfBGvUhGDm+krrTAEvqkgwl+KROf+oK8VjCm+v6/zidiHsTk3a3P6KAGfudzMWRu2nNV1Lzz5WFsSBM65e+hwKWuXBbjVJlmk1AvuVevWDPBskwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPKG0Gbl; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8eaaf673eb4so1809148985a.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777296363; x=1777901163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=osIWCfX1fd3cxwlHFPvebubj5N4ZDSqkRS5M1d8scBQ=;
        b=sPKG0GblWJtee3ieGe3QdV231dPP9EUnpSOuNFQnt4ZINGNMhHw213h6xI/Tdg3Buu
         4wbn1kIafp/HPpOQumOwbrvdAslXrBbzZl5MzFOgU1cdJNiNgyRK9tJiTKxWko947lM1
         S2yjC1XvoVHGw2/n1/OE4Wv+5d6819DoVUiL0gjBl98ejxKtzy3XzEa3Luz060g4auhD
         vKy8nTZPEL0NlGi5osqXjLknTRlPqsCmDQHGWuAuMxKnsFVqeWPcB/3TX+OJE5JHDQ+4
         dI3lgs5C/Rft+2xzuwJ7qoKXQLK75v8ejGHQ+SYzI8ZJLpzAuzf9/cPaxp+KJ61G6fdL
         gLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777296363; x=1777901163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osIWCfX1fd3cxwlHFPvebubj5N4ZDSqkRS5M1d8scBQ=;
        b=pRDvk7WLw/upyeO3Y5sgU8QcvEI5Qzufettb1D5kVL0NJHKRExwX23kJpZpZZ2r+PA
         V+x6OQYRwNjaq6auSM7fff/sn6Mjittxaxdse1H3TyQ9fyVTXSEvXmfCzsu/27VruQ++
         ONhuOP96C7/dgyX+/1gKs7b0B1L5U8JlJuZ2H9TMsLIIuiNW4cDFg/ZxtY7K/4RGbSOL
         g5YA8h0vLbhaR0Wo2HdiF/kP3jyKXuBaHy1LyT4R6d2ih1xwNy0RWyNdLBVfXakaYlIV
         vfBvcD+K8IB8PT/Iq3YqGlzwlveVxpKleVXvXyypqHJJStApZh1i6SavsogGWHlulT1O
         KzLg==
X-Forwarded-Encrypted: i=1; AFNElJ9E0JvhNvQAq3GvUjlPa9NYoiXrye+AharptAahXDJJQNOaB17ckAV5rWg9/OzFNlWUdQMflBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUP3b0TxXiQ/BF5htBgNVw5JPcfNGkdi/bIszmbvJw66MZteI
	CNE5WlvX0Jfl+4f11sJj77U901BzzcrmBlLr4XKmqFrzTr4f+E4IT5iFS5F6lS2NJLpvIe3Ftgv
	4ezxfNX+PJDxf2w==
X-Received: from qkaw3-n2.prod.google.com ([2002:a05:620a:a2c3:20b0:8cb:4a2d:574d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4456:b0:8cf:e1c9:b286 with SMTP id af79cd13be357-8e78ed5dd31mr5918306185a.2.1777296362655;
 Mon, 27 Apr 2026 06:26:02 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:25:54 +0000
In-Reply-To: <20260427132555.1791636-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427132555.1791636-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427132555.1791636-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] net/sched: switch tc_dump_qdisc() to for_each_netdev_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 64DCD4735CA
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281326-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Use for_each_netdev_dump() instead of for_each_netdev().

This is more scalable, and will ease RCU conversion.

This also offer better behavior when other threads
are adding or deleting netdevices concurrently.

This enables dumping qdiscs for a single device
at user space request in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 61 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 322eab3bd2b1327af323c44333318bdd52c7ee52..c4e8059acdd324441e0d069f6878bbfcab5a0cc7 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1873,18 +1873,18 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 
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
@@ -1892,42 +1892,41 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
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
+		if (ctx->ifindex > s_ifindex)
 			s_q_idx = 0;
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


