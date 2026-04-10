Return-Path: <netdev+bounces-277591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPcnH8Zp2Wk1pggAu9opvQ
	(envelope-from <netdev+bounces-277591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:21:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F0F3DCD9A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBDBB307EC8A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABCB3D3001;
	Fri, 10 Apr 2026 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yf5kkHGu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662023AF674
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855880; cv=none; b=kODSy7CDguMRgZULNxx94wgFBW2zp4jNVYgE7MzWjKM6m66NISfYwPg9+sAnWLNgdnIMbXje+rMjOz+rqSvTA0IDzCU+GF94UODBen38F8Vg8nvCwohh3ta/CSfhRVeQ7WPdW91kO3MBX5eKBMw+dXSeH5IKnAG/a5L/760sy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855880; c=relaxed/simple;
	bh=hMNtfYSZwwbzgVDN0jXf1WOOS/ZrKCgk3HF92b7y430=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gVnhLLDQtolPa4zSDIs0uIocN6lrw7MKQr/hP1yrMJmkUwAexnllonvZdKYKyXtHqZ8hyqyxMM9W1tcV4e4R5wSOsHd3DSqQwz+y53VsWEGeCEbEsL0JdB+LUMqN3L/zmFIzsRlCUWpInvTHSVuVGIEShtyJp8sk0xqK0Dll/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yf5kkHGu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f0f2b2641so817697b3a.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855878; x=1776460678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UA8RckrnfoUZskv+LGz2p4m2VbrwDG/26/lC7tyWXE=;
        b=Yf5kkHGuv/NSRKTVWLyUjOZABf5pyUfM82mgo9GEaZrbyuM1/7Els8eO0zPVaz3rnw
         U6dkz8Lu4P7Wrz/JayGRFS9eM9n0uZfSNmCmQCInfNq1MFoVV13lh9b2a/3ddi+MYzL2
         5Mu6i/0NMxd1GyaPqXWDfSAZoqsbOUVHGtTJbbam+f2oL0wpB/swXA21Kxxps+dRUvbb
         9WrsaauORFYYX+ngGRcdpDsvM72OeUfydaxaNPHITGdKVUFS2d+DYwA2Q7yuZDXNvzhq
         yzOSXU7vSRQnuQQVX+hgnU+eHcRTA7OjG3xU2EXeVQzLev07czKCENafSGqKH2chits4
         ybFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855878; x=1776460678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UA8RckrnfoUZskv+LGz2p4m2VbrwDG/26/lC7tyWXE=;
        b=YIILOOJgEjU2Sd0y7hHqoi2OmhBa2YUJyH1B0kVc4/VaIUsWT3sDi4ub/Q2w9vga1g
         SKTCHZ5U8oot2Jpl+KcoQqZg9jy9dV98CVbUc9IwVY5DvVt4n1amQU2LxO06l7dV8MAS
         ec2bBLUQDKx+MX3UOXvv6JiFW5SDxuoxPVNr0Z/ce2jbUZUswo3dOUvHZnGBSxA26Xdi
         wg0KoL0/s2dzbZhEiqmIDc3NqDS8ftiOjYfvskpIxikreGMBN2OJuGKdJPW2wrJk9iPm
         F3zXaC8gC3TjnzONTPCiuTTirX0alVH0508BoYXddHLFIbA3mpG8SkLJYjfwWpOfcuas
         kcyg==
X-Forwarded-Encrypted: i=1; AJvYcCWOFzpklCywDzJYaYOzy0mJL+WBE4OodUbW6fabRqy93uIQFEjSi2VKluAxBTF1tGIhlO+ObvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ID/Z0IYlKVQuc/sZ6XNWzobk5TyoSV9osQr8Y74flo3BpWLI
	zW0QEc5FBsCv20tdHWsyrvDlDh9L+ofLSWxCzsqvqeFBt7G+JwvzGvAqJTvhH1WY/OmkIuYkXsN
	c0FhumA==
X-Received: from pfbdo12.prod.google.com ([2002:a05:6a00:4a0c:b0:82c:d980:d6e9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3028:b0:82c:e692:1f91
 with SMTP id d2e1a72fcca58-82f0c2b368amr5119311b3a.39.1775855877429; Fri, 10
 Apr 2026 14:17:57 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:11 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-16-kuniyu@google.com>
Subject: [PATCH v2 net-next 15/15] ip6mr: Replace RTNL with a dedicated mutex
 for MFC.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277591-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16F0F3DCD9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 net/ipv6/ip6mr.c         | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 499e4288170f..83ac9c82d7dc 100644
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
index a31e3b740581..67385de7befe 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1259,7 +1259,6 @@ static int ip6mr_mfc_delete(struct mr_table *mrt, struct mf6cctl *mfc,
 {
 	struct mfc6_cache *c;
 
-	/* The entries are added/deleted only under RTNL */
 	rcu_read_lock();
 	c = ip6mr_cache_find_parent(mrt, &mfc->mf6cc_origin.sin6_addr,
 				    &mfc->mf6cc_mcastgrp.sin6_addr, parent);
@@ -1349,6 +1348,8 @@ static int __net_init ip6mr_net_init(struct net *net)
 	LIST_HEAD(dev_kill_list);
 	int err;
 
+	mutex_init(&net->ipv6.mfc_mutex);
+
 	err = ip6mr_notifier_init(net);
 	if (err)
 		return err;
@@ -1477,7 +1478,6 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
 			ttls[i] = 1;
 	}
 
-	/* The entries are added/deleted only under RTNL */
 	rcu_read_lock();
 	c = ip6mr_cache_find_parent(mrt, &mfc->mf6cc_origin.sin6_addr,
 				    &mfc->mf6cc_mcastgrp.sin6_addr, parent);
@@ -1555,6 +1555,7 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
 static void mroute_clean_tables(struct mr_table *mrt, int flags,
 				struct list_head *dev_kill_list)
 {
+	struct net *net = read_pnet(&mrt->net);
 	struct mr_mfc *c, *tmp;
 	int i;
 
@@ -1571,18 +1572,21 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags,
 
 	/* Wipe the cache */
 	if (flags & (MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC)) {
+		mutex_lock(&net->ipv6.mfc_mutex);
+
 		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
 			if (((c->mfc_flags & MFC_STATIC) && !(flags & MRT6_FLUSH_MFC_STATIC)) ||
 			    (!(c->mfc_flags & MFC_STATIC) && !(flags & MRT6_FLUSH_MFC)))
 				continue;
 			rhltable_remove(&mrt->mfc_hash, &c->mnode, ip6mr_rht_params);
 			list_del_rcu(&c->list);
-			call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
-						       FIB_EVENT_ENTRY_DEL,
+			call_ip6mr_mfc_entry_notifiers(net, FIB_EVENT_ENTRY_DEL,
 						       (struct mfc6_cache *)c, mrt->id);
 			mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
 			mr_cache_put(c);
 		}
+
+		mutex_unlock(&net->ipv6.mfc_mutex);
 	}
 
 	if (flags & MRT6_FLUSH_MFC) {
@@ -1765,15 +1769,18 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
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
2.53.0.1213.gd9a14994de-goog


