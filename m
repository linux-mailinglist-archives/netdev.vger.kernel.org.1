Return-Path: <netdev+bounces-261703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HsQLUsSoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF91B254F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A40312B16A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99820332EC7;
	Fri, 27 Feb 2026 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0axaz3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65996332EA5
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163559; cv=none; b=vBs+qbZGjt382j7HNXvrKD5OSYPRxPPGk6ke+hz8dwuRjGXnM91IIBudQDk6pyNIp7+oqC79ulsq0F2RhS0JK/1gUdWyNb8dr0y4F0IfzLq0w8Z5bW2kOBywoGDIQch00pGXNO+NyLsI1SgAzNWHBz6stwMvrZWfLdB1N1oCxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163559; c=relaxed/simple;
	bh=MnKpn8tu16NToxqgboVjghXLyC0aqNXw/f6OZRv9BqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kPXBoxymLWkJOtaUY4zDa7vPQvIorcPM168/4NUxRNu3fJWNGzpQKd9kow+0ODm6MaFJl6fuhV/TpkgSzSw/FXvufC/3bMs3egURul9Awyy4xIrPBZjVoJMIPaXU8/LP6h1avzhJmbcM8KzABiPFSHXqOO+DH4HpVF76eKAvSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0axaz3p; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358dc09b43eso1397010a91.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163558; x=1772768358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9l7fwj5eMKpx3MVznzGJNr2fMUk7Mob+OOYAgqowzs=;
        b=r0axaz3pioxjRfou16mnjG6JNpD/1DMYMGKW8xpz6jO9K2Pwtbst9T30iL5Nz0MRE3
         Tes6eOyeAslTxvLpRZYh7MOBUdRn6UTg/gCOCWdtBslQ6hhr7Dq8xfuNw/5L9REnVHy+
         WZMRpRWMTmatV4MK/BqQlU7tF6QyPWWSOgwcKZt838oYI6/NAsv6groBx9P2p5oGoLPP
         uPJogJ5j2PmYXPLbVUeRmqBu9euVe+fEaWbTAQyPj9jBhpVKe+geaZeG37F7oRu6ckY0
         MtVeFZOeX94AdBRjajgUuHccJBVEsxuKHHDKtR8Sjbah3ZDpVuq+bOIGwobQdoBsF8mo
         4SxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163558; x=1772768358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9l7fwj5eMKpx3MVznzGJNr2fMUk7Mob+OOYAgqowzs=;
        b=NVIJW7a1nvEMchnH1yCa0Z1YD+EElAsQu4N5pYLMYUmVsq/15D8U8iJBot/MZtb0WZ
         G9+xWhAgL+d2BOAmIEAm0pPTkWcJm82VoZq2QaA/QEUFwZkwt64s1/cvU1bmgulTDIoA
         hp2t/MMRIbyvlHneSLRa0UXdiZAo/gXQffwMiywtFjgzZeez6d6f7oFE6yOv4KRrQJdG
         6GjyrGENqmZayCiJYNQK9TbkCijjmB/8/78nk3HC7h0ZJXLIx74999Zug4Wsp1ujFP27
         iXZp6C1S9KLSkJsm2avb+kfDkRtRpuJ1LKld58X+vLByz3N5NuueieHkJINNrTJnojci
         NfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdd3ZGLdB8jWc7mDxDePRwGzBiz0VlhHIj+n3Id7suP+t64NpqIPj9Vjwe75NePMzfG1SVTkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2SV009irnkJVBVq6hs69kYnoFEPcpIwRK19vWypXZ9/4nKj3
	JFJ99lGUiiz3ckx/jUTMUX1rcqSn0ai90CimBH8R4WKs/BQ3B/1rfjcV0FQOt4u3R5is2kJHUUE
	o9CiN7g==
X-Received: from pjvc15.prod.google.com ([2002:a17:90a:d90f:b0:352:ed03:9879])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1ccc:b0:340:b912:536
 with SMTP id 98e67ed59e1d1-35965cec355mr1198303a91.31.1772163557748; Thu, 26
 Feb 2026 19:39:17 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:30 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 07/15] ipmr: Move unregister_netdevice_many() out
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261703-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19AF91B254F
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
index 5e45730ed3bb..64c73bf7389f 100644
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


