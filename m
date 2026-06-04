Return-Path: <netdev+bounces-295465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dbqrCMMAImrrRQEAu9opvQ
	(envelope-from <netdev+bounces-295465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7AF643DC6
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tj2vAlRx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295465-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295465-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9899D3031277
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466A236A36B;
	Thu,  4 Jun 2026 22:47:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6D30C629
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613256; cv=none; b=AuaYsxW1HLfSbDo5+HDqxlBHslj2dyKaEOMzlCc5tI9/O1fqdnuv0sGRDSVcD2JzdYAjU3518qAUY9Ub1w3bcles2AH/+eAAZUmskIUQiWgTNAPu9SrQTWdyjQryAa+h5XUulM6AryTIVJEXCmhgjZ20j+zy8SveZa1qlCy9MWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613256; c=relaxed/simple;
	bh=0jKAvxRpE4bazeLNqVgEB6mMS/FacMglt/DiO+9Pvhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k8ki/SeZdLgGYg4MDkuVKg550YvbtBmVnmAVk81um8xxmiyRvByVbhgS+xaA7QRITM7Ph7RuDWP0Hqge3saBaDOCXH8TDYK9P9d04qpLRE6v2G5mF6FQIO3WU0h+cF0FfivxeJQ9hC0NGWMLadd9X3Eq4JFzTW/NCfAZtPEQYHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tj2vAlRx; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c859d79c10eso1402208a12.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613254; x=1781218054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=maAZ8zcAlniHe5sm3pctD8x54Co1aQe2u7VO+edp6C8=;
        b=tj2vAlRxnOo+AlH+RFYpy045X4J3EnxKYFC+iInL6gx4DvJRyTHgE8wNehtJ0NkRz/
         D3hASddgtTxylpjKsT1ayQFhmeq73Is1sY8dqe4YLHKUaqNHd/CVk9VIgK6lmq5JjrqY
         u4j5p40hraW8b801VMppH+RDjoojoOxLZOggnAt2OA4X2szWcXartiTAoP2+yG8WGG7+
         zjhFIQ19Z7Jw9TsrBpWv8Hbv5xRLbQSwURySAvzxjRu74f+5QpXg/r6PqE5rgo3YYDTC
         lY3nrQ+mtt/wWPaqksNUJBjg0/3Z2SNmRpkWtbEvm6Gu/1XBf7pfcg+lHBh7e33ka1/N
         TT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613254; x=1781218054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maAZ8zcAlniHe5sm3pctD8x54Co1aQe2u7VO+edp6C8=;
        b=Ghb0w9bCSC/ps1EnHDDzc/3VDw+W5ACxDq+KfXiWD28NdW1fM/9PJD/HnxSyuDKgeb
         CqaxOp9fdmtmyDEZyr2uGOdDz/aNCi4YKZA5i31XDam2YiXK0S3y+nuU07PRLWWI6gP9
         6FAltb7Dd5Lspz6xB9YRGcbiHPOOmL8W44wm2S9zY3YP8XDqOL51UPWyzFGUWPZftz7S
         761Vx/EP0D+2Nu1CZZA6exSPwRbTs0De1c5CZ6mdbKQ5CPkmgY4blYWrGo1UPEif09jq
         8daa5yyPFiHSl9W6rq0CfZ0VfYjiewo/ctcPPnW2axNw/g9wPko28IeVyPmjFFUAsUxg
         sPgA==
X-Forwarded-Encrypted: i=1; AFNElJ8iDwtDunLapV3Ojkb98H++0aIpR3soGg0/Zn5ZOsPDM3ezTBULGV8D5HgRw0xUs2VBkZQseK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9CvnRQNxGP/f5ItpTWFqZ2+yNsdE8izgM16p0fvqbXNz1Q4S1
	vsiJUwOH4QD3vExHJBGVFoLhQOC3tYOmxNBqkEG0UgCwe9QPECuUUB//7OvgiBVs8PchSFyLVAD
	3epoB2w==
X-Received: from pgww21.prod.google.com ([2002:a05:6a02:2c95:b0:c85:8689:5271])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:8941:b0:3b4:68e3:f16b
 with SMTP id adf61e73a8af0-3b4cd010f51mr1014414637.25.1780613254038; Thu, 04
 Jun 2026 15:47:34 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:32 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-15-kuniyu@google.com>
Subject: [PATCH v3 net-next 14/15] ip6mr: Replace RTNL with a dedicated mutex
 for MFC.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295465-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF7AF643DC6

ip6mr does not have rtnetlink interface for MFC unlike ipmr,
which uses dev_get_by_index_rcu() to set struct mfcctl.mfcc_parent.

ip6mr_mfc_add() and ip6mr_mfc_delete() are called under RTNL
from ip6_mroute_setsockopt() only.

There are no RTNL dependant, but ip6_mroute_setsockopt() reuses
RTNL just for mrt->mfc_hash and mrt->mfc_cache_list.

Let's replace RTNL with a new per-netns mutex.

Later, ip6mr_notifier_ops and ipmr_seq will be moved under
CONFIG_IPV6_MROUTE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6mr.c         | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 875916d60bfe..668f10498c5c 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -112,6 +112,7 @@ struct netns_ipv6 {
 	struct list_head	mr6_tables;
 	struct fib_rules_ops	*mr6_rules_ops;
 #endif
+	struct mutex		mfc_mutex;
 #endif
 	atomic_t		dev_addr_genid;
 	atomic_t		fib6_sernum;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b13ce9c2c463..5a4816225fb1 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1266,7 +1266,6 @@ static int ip6mr_mfc_delete(struct mr_table *mrt, struct mf6cctl *mfc,
 {
 	struct mfc6_cache *c;
 
-	/* The entries are added/deleted only under RTNL */
 	rcu_read_lock();
 	c = ip6mr_cache_find_parent(mrt, &mfc->mf6cc_origin.sin6_addr,
 				    &mfc->mf6cc_mcastgrp.sin6_addr, parent);
@@ -1358,6 +1357,8 @@ static int __net_init ip6mr_net_init(struct net *net)
 #endif
 	int err;
 
+	mutex_init(&net->ipv6.mfc_mutex);
+
 	err = ip6mr_notifier_init(net);
 	if (err)
 		return err;
@@ -1486,7 +1487,6 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
 			ttls[i] = 1;
 	}
 
-	/* The entries are added/deleted only under RTNL */
 	rcu_read_lock();
 	c = ip6mr_cache_find_parent(mrt, &mfc->mf6cc_origin.sin6_addr,
 				    &mfc->mf6cc_mcastgrp.sin6_addr, parent);
@@ -1581,6 +1581,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 
 	/* Wipe the cache */
 	if (flags & (MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC)) {
+		mutex_lock(&net->ipv6.mfc_mutex);
+
 		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
 			if (((c->mfc_flags & MFC_STATIC) && !(flags & MRT6_FLUSH_MFC_STATIC)) ||
 			    (!(c->mfc_flags & MFC_STATIC) && !(flags & MRT6_FLUSH_MFC)))
@@ -1592,6 +1594,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 			mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
 			mr_cache_put(c);
 		}
+
+		mutex_unlock(&net->ipv6.mfc_mutex);
 	}
 
 	if (flags & MRT6_FLUSH_MFC) {
@@ -1775,15 +1779,18 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			return -EFAULT;
 		if (parent == 0)
 			parent = mfc.mf6cc_parent;
-		rtnl_lock();
+
+		mutex_lock(&net->ipv6.mfc_mutex);
+
 		if (optname == MRT6_DEL_MFC || optname == MRT6_DEL_MFC_PROXY)
 			ret = ip6mr_mfc_delete(mrt, &mfc, parent);
 		else
 			ret = ip6mr_mfc_add(net, mrt, &mfc,
 					    sk ==
-					    rtnl_dereference(mrt->mroute_sk),
+					    rcu_access_pointer(mrt->mroute_sk),
 					    parent);
-		rtnl_unlock();
+
+		mutex_unlock(&net->ipv6.mfc_mutex);
 		return ret;
 
 	case MRT6_FLUSH:
-- 
2.54.0.1032.g2f8565e1d1-goog


