Return-Path: <netdev+bounces-262240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F8jERtqo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:20:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B466D1C9737
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3248330965F6
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5BC3D4133;
	Sat, 28 Feb 2026 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J8TOQQwe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912053D411B
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317096; cv=none; b=oe75rzWXRStEJTO2s/rYmVCSyksbdGMdoebWjUiPeIVEdA+bAQESTtEUPVrz3AGOJOMK7Kf7VAyiw3V/I3qZLqKpOiJfZxmOiqu+etgc6bfjnywcGDo7+TVQKpdSJgX8vaf6V62u6IeQ8Qh3BASmyQF8yQdZ9bF9Prm3F6dKqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317096; c=relaxed/simple;
	bh=9j6IfFijJcJSGTL8Zu0od2hCNShMpJqQ4sXIY3t7I8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GXyPB57wL/wNf/csAkC7V3IDdSF7d5dhmiRaQJaLvL50UCWmzBCY/5LxtZRD06VShe0hatwuigxakx0r3wYU3v2UG72r+31uK9gmZqx94ZdVvS0P5pzp6FQm0nbMxzlUjrbEIZsIgNGDnt9MILcs8kTJBN42x0bB7pl4CTKLQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J8TOQQwe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae48a21d12so576845ad.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317095; x=1772921895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDsINcMa7ubxNLI36LVvkPy3KV20vBdthQ0z1FDe6Y0=;
        b=J8TOQQwewnrtTIJ1GopnY+lWr2QV9Uag0i86W/baMA4nWrMbNA5OwQIaTqvXbwHlKv
         5BC5xBPkMzxdQzZCaUequey2+y4r7YSzAci8O9zE2gDDgz5mc4ukn+YVBBSmKl64S++w
         Yft4/XTh6mFjJG678u+NUvzg5OW7a60pqghGlNADEqcTZxh76EmxC9u8NwjWpgTxh9Vj
         y+9foyREOqHhMUCldXXIGAyFMmf+Rg5zKBnA/T0WJfHc4mC+CMv6Z51HQx8Tw94rxpW8
         0/d1O0ALomsQ53PVz8ZSkbbLUnVzAeKwciSyo0+nbDPyOegGBvtySn0U33C2SkI55xci
         CZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317095; x=1772921895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDsINcMa7ubxNLI36LVvkPy3KV20vBdthQ0z1FDe6Y0=;
        b=BD0jvCwv5SI06N6D7HHUCXkciLdCMe00DRjaQXKH6AIxk2GpKJMeoNGgD7lwZgMZkV
         1Pf8maolnRmZJNmFel9cALhpRq8dihcBe4M9tZWtw2tKugAU7tcLGsu2b2okUOaLTRuV
         Sqt1XaCVTrP+pyemgJpd0lIUaJCyExG2HSvBkMSKIjAVO0I+wCpmT38QaPxI256KDhXw
         xcX3CEUIWOG3OmLugi/E7nl80zWDoghpbA6b5UZGHiPpTIuuO4NOX95oNVEihVi85ui8
         65oLhq8FJ/yQCmknTZF//TBXcdFACOfocIghNN4MeHy7O4yC9FjPX2Jw8WJKnhCtCOhM
         vWjg==
X-Forwarded-Encrypted: i=1; AJvYcCXzwlSHQV77RKOCZCZgy0nlofwOasuuQCvJzeXFyL1lxA+nhaDnYwuwK9rh448JcylkWd1pk7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjnGCCgXgl8nAkaqxkuqwMeUhW2sjavYDONbz2y9emXEew8n3B
	6cAR79ftUiW4cWlgE0arhoDipLHW7HNFtXcCxvE8MXeJxl+QmDpFCPEqYPTGnWdJUFj+i/7xk6k
	8Don5/A==
X-Received: from plaq10.prod.google.com ([2002:a17:903:204a:b0:2a7:5e40:dcf0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:944:b0:2ae:4999:2194
 with SMTP id d9443c01a7336-2ae49992583mr1278495ad.10.1772317094855; Sat, 28
 Feb 2026 14:18:14 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:25 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-8-kuniyu@google.com>
Subject: [PATCH v3 net-next 07/15] ipmr: Move unregister_netdevice_many() out
 of mroute_clean_tables().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262240-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B466D1C9737
X-Rspamd-Action: no action

This is a prep commit to convert ipmr_net_exit_batch() to
->exit_rtnl().

Let's move unregister_netdevice_many() in mroute_clean_tables()
to its callers.

As a bonus, mrtsock_destruct() can do batching for all tables.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ipmr.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 5c8508788fb6..d15e05662b09 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -112,7 +112,8 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 static void mroute_netlink_event(struct mr_table *mrt, struct mfc_cache *mfc,
 				 int cmd);
 static void igmpmsg_netlink_event(const struct mr_table *mrt, struct sk_buff *pkt);
-static void mroute_clean_tables(struct mr_table *mrt, int flags);
+static void mroute_clean_tables(struct mr_table *mrt, int flags,
+				struct list_head *dev_kill_list);
 static void ipmr_expire_process(struct timer_list *t);
 
 #ifdef CONFIG_IP_MROUTE_MULTIPLE_TABLES
@@ -427,12 +428,15 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
 static void ipmr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);
+	LIST_HEAD(dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
-				 MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC);
+			    MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC,
+			    &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree(mrt);
 }
@@ -1293,12 +1297,12 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
 }
 
 /* Close the multicast socket, and clear the vif tables etc */
-static void mroute_clean_tables(struct mr_table *mrt, int flags)
+static void mroute_clean_tables(struct mr_table *mrt, int flags,
+				struct list_head *dev_kill_list)
 {
 	struct net *net = read_pnet(&mrt->net);
-	struct mr_mfc *c, *tmp;
 	struct mfc_cache *cache;
-	LIST_HEAD(list);
+	struct mr_mfc *c, *tmp;
 	int i;
 
 	/* Shut down all active vif entries */
@@ -1308,9 +1312,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags)
 			     !(flags & MRT_FLUSH_VIFS_STATIC)) ||
 			    (!(mrt->vif_table[i].flags & VIFF_STATIC) && !(flags & MRT_FLUSH_VIFS)))
 				continue;
-			vif_delete(mrt, i, 0, &list);
+			vif_delete(mrt, i, 0, dev_kill_list);
 		}
-		unregister_netdevice_many(&list);
 	}
 
 	/* Wipe the cache */
@@ -1349,9 +1352,11 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags)
 static void mrtsock_destruct(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
+	LIST_HEAD(dev_kill_list);
 	struct mr_table *mrt;
 
 	rtnl_lock();
+
 	ipmr_for_each_table(mrt, net) {
 		if (sk == rtnl_dereference(mrt->mroute_sk)) {
 			IPV4_DEVCONF_ALL(net, MC_FORWARDING)--;
@@ -1360,9 +1365,13 @@ static void mrtsock_destruct(struct sock *sk)
 						    NETCONFA_IFINDEX_ALL,
 						    net->ipv4.devconf_all);
 			RCU_INIT_POINTER(mrt->mroute_sk, NULL);
-			mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_MFC);
+			mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_MFC,
+					    &dev_kill_list);
 		}
 	}
+
+	unregister_netdevice_many(&dev_kill_list);
+
 	rtnl_unlock();
 }
 
@@ -1485,7 +1494,9 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 					   sk == rtnl_dereference(mrt->mroute_sk),
 					   parent);
 		break;
-	case MRT_FLUSH:
+	case MRT_FLUSH: {
+		LIST_HEAD(dev_kill_list);
+
 		if (optlen != sizeof(val)) {
 			ret = -EINVAL;
 			break;
@@ -1494,8 +1505,11 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			ret = -EFAULT;
 			break;
 		}
-		mroute_clean_tables(mrt, val);
+
+		mroute_clean_tables(mrt, val, &dev_kill_list);
+		unregister_netdevice_many(&dev_kill_list);
 		break;
+	}
 	/* Control PIM assert. */
 	case MRT_ASSERT:
 		if (optlen != sizeof(val)) {
-- 
2.53.0.473.g4a7958ca14-goog


