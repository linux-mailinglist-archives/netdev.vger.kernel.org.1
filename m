Return-Path: <netdev+bounces-261130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGwbDVKyn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:39:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE931A0282
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D055A307E85F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF0637883E;
	Thu, 26 Feb 2026 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhGHdhNd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1C371067
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073413; cv=none; b=t8LW6EqZzNTXc4/1Psti86SjgDKFNzBhWT8Vf2Idd0cxIvnwRKhCujnPLSCuqF3RvuoPjTm7f6zEbRlh5YoXSi9v1ge1yoW/wjdmw1eBPIIYcUzO3/5wvBTJ6b5mJacz7Bxshs4EECCY2x2pv+ytU49xevgCtDaLPMQzw2Hco00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073413; c=relaxed/simple;
	bh=z341RRUIkndoAJfyR/gZCR1rBgYUDPTvD32uD4/E1GE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L3CCmfnyZLWMrFqQ5ZyBoB4ghI29uB70UmkoXmrd3zxzru4XOOJ4CENLJ9sJhh6oRf8B1SAOYQ5qvB6GGtghty6NoROoG5/EXCy4Mvx3I0SQpyehmzo4Z5q+z3/SVByemnHR++42adgHW75PnVkX+gHu7Zh2P7pOYb71XZPBaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhGHdhNd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358f058973fso236760a91.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073412; x=1772678212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOZ1sYp8La4HxLIE26oXK2U8DAsrTlGJnpQePCoz+b0=;
        b=JhGHdhNd5AzA+UaG9dyhyKSTsSEiyS0mydAC6WyXFUMqC9f14UEm4+l8kVSdOsSqMQ
         FaVdy4sh6O7FlsMWY+PhwRD3majA+Kl4Y3eyX++Y7p298XXfp3oyEsn51IenWGULHmno
         /U0XpXqEMNfxintBoJUOZ6o49bZx/ZJRSrZJrMndKffvrkYPqWBOqnYHTiJ4xpeif8YT
         l3H3idB6a2yfMCwfXTJU4xjZWh5/Jn0A8GJXAydVmq95rhiKYZB2T+dXNXmzQatMaWCv
         KkZdI1DmQpbQNgP3YNjXjtLqtMHax7oRBdl16yrKPHjEd72c8aEIWI5jxhudu4tssfuG
         qEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073412; x=1772678212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOZ1sYp8La4HxLIE26oXK2U8DAsrTlGJnpQePCoz+b0=;
        b=bbI9T/MkTcwoC1rl0+NZNtaA3nOh+cXoWuQYgdpRr+9JTzIMkS947IeG3mRONzgGaA
         Qzt2lwWHotTwiu6UzjAjd93mZkrbXFchNW/+57p/nWVQh3BBqZE0NFxML9zneSvpyFmv
         h3CjCTsXQBK6OdAFKRjuOuV6/n47BoS9D6JiTwbEe2Cn4918x4grRvB5RxN+XaUiZaAr
         dV3f+xj9RtB5N+kpdXWVHq8J2iY075pJQbg71XP2ysWUU1/YnY/yfcOsKZdmqM6qZc6h
         YYLLyvROlBAn9rG67PlGA8+cMOYdoa82Mt4SN7PbdHo2R7Q69mum1ONjfkJvJGhj/RAG
         UZIg==
X-Forwarded-Encrypted: i=1; AJvYcCX9CLeqIG37WokAArmTZVnZese5pUD3NAVC1macr0hH/+Rb5S0uXXwPCFGdCRMERpGtL4OF7yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzncusiYuGIBZeaqsGHu4YknmkuZ7tYfL3KKrQBwp7NA0bMu3F2
	iCz1Kv6Ct85WSJbdk5Nrd6dpt4jWWiG1nln0GzRbKzSRBdsQs0j5NvGXkAAYaA5Q4KM6zI7ivbD
	tTRFmnw==
X-Received: from pjbls11.prod.google.com ([2002:a17:90b:350b:b0:359:f40:eaa1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e83:b0:356:2fc5:30f5
 with SMTP id 98e67ed59e1d1-3593daf4ddbmr761195a91.13.1772073411511; Wed, 25
 Feb 2026 18:36:51 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:19 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 07/15] ipmr: Move unregister_netdevice_many() out
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261130-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AE931A0282
X-Rspamd-Action: no action

This is a prep commit to convert ipmr_net_exit_batch() to
->exit_rtnl().

Let's move unregister_netdevice_many() in mroute_clean_tables()
to its callers.

As a bonus, mrtsock_destruct() can do batching for all tables.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 3af6b3d33cc8..f8bbb88f5784 100644
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
2.53.0.414.gf7e9f6c205-goog


