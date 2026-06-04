Return-Path: <netdev+bounces-295461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XdOQBqgAImrlRQEAu9opvQ
	(envelope-from <netdev+bounces-295461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC5E643DB6
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:48:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=oFHKf+VN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295461-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295461-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 629663049728
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB1C2DEA95;
	Thu,  4 Jun 2026 22:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C731E821
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613252; cv=none; b=t5/Zjb3+QEmVH0Fp+9edZKDNXaETUrPY9U1FQvSGkFWsN4Jb10usgzu5XZ9ciEWsauw2nO35ij4iwgsPxwJUHX1nCUa9XA92BEgSJbaubryZnJ9lCtqbGFvbblGxUOTkeTFJ112v3R+M04n+VGJiTb4HLH8882HLUU+JJs3ay0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613252; c=relaxed/simple;
	bh=tFK0C9VWk8pXKYdv8L7EiAnk20cm+XKObl0HmPSvNzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofBWVFmDRwlvBF98q9OeMpTcAu5HGAFfb9WxWIzUMKZQa6RSNUakLm9pwdGbd0ToWaGX0uFSjJRapJLlCJGYuuCtILEY++N4LrW2ebzeIBZfYZ/KOLtMOyuLDTUV8gE3aY4fLwmKVWdBhUko3tl0LYQvwtU4TKRELqugiTcHtZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFHKf+VN; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b934a336eso907181a91.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613248; x=1781218048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6Hrvfr6jEuaea4vnSRjVfuS8Ouv/BLeMkwBhzbWciM=;
        b=oFHKf+VNXBtZCNeCzyI/ytcYHVJx96QLaBnfZialgEL9Qn9/nNwJR+FdBBXI3Pa40N
         WYhML0gMvhC7BYxq0FJp9SVkpxlFSvxvCsqyv+p6xz2LovApj4Kv2AHyRwkmx73RxQ6p
         6HfbIL2pO76I/8xQGrtv7658KHxxK7ZuqufyOMYJPhEPYw5YjF5wpNrR+3epH1s1IWqp
         UO7ZS6+Aiq3Lg49C8ORkEfoqjdOP5LuTMtKMu//2Z4192yBCdVncEH8smhwUAR3JkGRk
         SPb92Dr+R4dtjZQIuoLv7M+kG5JVL1g2Wslcst7I2YaodXri0rrReqo76xTolArXFQj3
         HLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613248; x=1781218048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6Hrvfr6jEuaea4vnSRjVfuS8Ouv/BLeMkwBhzbWciM=;
        b=C4vHli2iJFmnIXWNHnQJtNRhI9j3ZEJjIIeE6lO/39Td8wYqaYgQUxrMRCLkvMfWMK
         j0LHX13NkizoI+6HGshafXHZovbVqpyiPjOo8I8wjzX6uppIX9LUX3f2DnAhBo089x4r
         aX/tAlFU8iRYXBnrzcNzgCbKLJVtLZIZlzx06jKeaRL+mWhEG8aeUh2HSI0YhrvIJskD
         UZxOK72BJ4vfZCTNnNkEa+omlUDGXPO066ROfnk96DZ1r0Fm2+QkItVoDiP4VMNBkp4z
         g7S32+8tG3YhDjzd5hqLNXNc6Qrra7sncRy6BGJsQ8BrqBzUloVEOlNkMQw9CS3Tfv0+
         lt0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/lhHy8GvAHm+NBtJnoxRGZ1XkrrzKoAzBpKBa669cXGplZsbKBhDiyIlgQE3dUP+XUlkzo6Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPrko2H32errY2pjS1Pp/Sp4HVqPH+TAieSN0OqZtwSljbbpI
	DQXIhfPvA8tuk4013NKPZ8QHzwmWzndZlZQeVK+A5zcCwC6Bvw9MuI3LT/uSMebbAsZKzomRcEx
	wBQtIaA==
X-Received: from pgcv14.prod.google.com ([2002:a05:6a02:530e:b0:c85:c772:c6a5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2443:b0:3b4:7163:a7e8
 with SMTP id adf61e73a8af0-3b4ccd1e792mr1231762637.10.1780613248347; Thu, 04
 Jun 2026 15:47:28 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:28 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-11-kuniyu@google.com>
Subject: [PATCH v3 net-next 10/15] ip6mr: Move unregister_netdevice_many() out
 of mroute_clean_tables().
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295461-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FC5E643DB6

This is a prep commit to convert ip6mr_net_exit_batch() to
->exit_rtnl().

Let's move unregister_netdevice_many() in mroute_clean_tables()
to its callers.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index bb613331ead2..b5da94c9f074 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -99,7 +99,8 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			      struct netlink_ext_ack *extack);
 static int ip6mr_rtm_dumproute(struct sk_buff *skb,
 			       struct netlink_callback *cb);
-static void mroute_clean_tables(struct mr_table *mrt, int flags);
+static void mroute_clean_tables(struct mr_table *mrt, int flags,
+				struct list_head *dev_kill_list);
 static void ipmr_expire_process(struct timer_list *t);
 
 #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
@@ -420,12 +421,15 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 static void ip6mr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);
+	LIST_HEAD(dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
-				 MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC);
+			    MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC,
+			    &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 
 	mr_table_free(mrt);
 }
@@ -1558,11 +1562,11 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
  *	Close the multicast socket, and clear the vif tables etc
  */
 
-static void mroute_clean_tables(struct mr_table *mrt, int flags)
+static void mroute_clean_tables(struct mr_table *mrt, int flags,
+				struct list_head *dev_kill_list)
 {
 	struct net *net = read_pnet(&mrt->net);
 	struct mr_mfc *c, *tmp;
-	LIST_HEAD(list);
 	int i;
 
 	/* Shut down all active vif entries */
@@ -1572,9 +1576,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags)
 			     !(flags & MRT6_FLUSH_MIFS_STATIC)) ||
 			    (!(mrt->vif_table[i].flags & VIFF_STATIC) && !(flags & MRT6_FLUSH_MIFS)))
 				continue;
-			mif6_delete(mrt, i, 0, &list);
+			mif6_delete(mrt, i, 0, dev_kill_list);
 		}
-		unregister_netdevice_many(&list);
 	}
 
 	/* Wipe the cache */
@@ -1637,6 +1640,7 @@ int ip6mr_sk_done(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 	struct ipv6_devconf *devconf;
+	LIST_HEAD(dev_kill_list);
 	struct mr_table *mrt;
 	int err = -EACCES;
 
@@ -1664,11 +1668,13 @@ int ip6mr_sk_done(struct sock *sk)
 						     NETCONFA_IFINDEX_ALL,
 						     net->ipv6.devconf_all);
 
-			mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MFC);
+			mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MFC,
+					    &dev_kill_list);
 			err = 0;
 			break;
 		}
 	}
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 
 	return err;
@@ -1783,14 +1789,17 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 
 	case MRT6_FLUSH:
 	{
+		LIST_HEAD(dev_kill_list);
 		int flags;
 
 		if (optlen != sizeof(flags))
 			return -EINVAL;
 		if (copy_from_sockptr(&flags, optval, sizeof(flags)))
 			return -EFAULT;
+
 		rtnl_lock();
-		mroute_clean_tables(mrt, flags);
+		mroute_clean_tables(mrt, flags, &dev_kill_list);
+		unregister_netdevice_many(&dev_kill_list);
 		rtnl_unlock();
 		return 0;
 	}
-- 
2.54.0.1032.g2f8565e1d1-goog


