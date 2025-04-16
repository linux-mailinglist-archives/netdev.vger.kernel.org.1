Return-Path: <netdev+bounces-183066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435AA8ACF1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7062E170B06
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59691CD208;
	Wed, 16 Apr 2025 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EWILvkfp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CFE1C862A
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764261; cv=none; b=J6b1KJQgd52xx3OGc8vF/XhRapuGBwGtKPENVFwmLDjd1DzY+R2SoxSgWBidnBVLewIPxBWxUN8d2PLAmnvQu2Ty96U42y3Z6gnGZU/tQJVQImlqeRIQOjaIMWax5co/TdKa/RIMn6ZiC193dGYOe3vSqGa5C0yYc5JgXFVXPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764261; c=relaxed/simple;
	bh=WF5ixX1Z6dgie/g2CJdXGodctYf5/jWcNa2cNPX97RY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epI3vCfdK0TJUOqUbEOlS6ogiAnPUQj/gi1wgd01i4O+++Gc/fSYmA6rGTExAVdU8ZxJanrGAXtTOK1AooSUKjOeeFyXl6BXJeQQUeVT6ZyDJ8o4NMf7NmTsQz2VUIbmUb/d+4Ldg63Z+rEMyxzpAkZqy+WtHk+Ef/pdLf8/IcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EWILvkfp; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744764260; x=1776300260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mqsQE/4cXfPfBPYuS75SOm06axNxOFiod2rKNICT43A=;
  b=EWILvkfpvpcaaXrp9QPfCLYIcN86V7JuD8ID6P8Jh9yTzddS3uMygFNg
   Lb1vTLS/cFiYZJ/srfhgNf1iU51yP+Fty7bVYUZgMN5fc4ycS4T9eFhun
   wJRnKMOfG+DxLJsE5TwU4Gk37ViYzf6DmyCh6G9gzgH6ANBsmeEsfM9V9
   g=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="714141476"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:44:17 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:41227]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 4cd58c9e-17d7-4748-8e4c-e40b201712cd; Wed, 16 Apr 2025 00:44:16 +0000 (UTC)
X-Farcaster-Flow-ID: 4cd58c9e-17d7-4748-8e4c-e40b201712cd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:44:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:44:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/7] neighbour: Allocate skb in neigh_get().
Date: Tue, 15 Apr 2025 17:41:26 -0700
Message-ID: <20250416004253.20103-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416004253.20103-1-kuniyu@amazon.com>
References: <20250416004253.20103-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove RTNL for neigh_get() and run it under RCU instead.

neigh_get_reply() and pneigh_get_reply() allocate skb with GFP_KERNEL.

Let's move the allocation before __dev_get_by_index() in neigh_get().

Now, neigh_get_reply() and pneigh_get_reply() are inlined and
rtnl_unicast() is factorised.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 88 ++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 56 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index af84515fb86a..297954ff13a8 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2928,27 +2928,6 @@ static inline size_t neigh_nlmsg_size(void)
 	       + nla_total_size(1); /* NDA_PROTOCOL */
 }
 
-static int neigh_get_reply(struct net *net, struct neighbour *neigh,
-			   u32 pid, u32 seq)
-{
-	struct sk_buff *skb;
-	int err = 0;
-
-	skb = nlmsg_new(neigh_nlmsg_size(), GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	err = neigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0);
-	if (err) {
-		kfree_skb(skb);
-		goto errout;
-	}
-
-	err = rtnl_unicast(skb, net, pid);
-errout:
-	return err;
-}
-
 static inline size_t pneigh_nlmsg_size(void)
 {
 	return NLMSG_ALIGN(sizeof(struct ndmsg))
@@ -2957,34 +2936,16 @@ static inline size_t pneigh_nlmsg_size(void)
 	       + nla_total_size(1); /* NDA_PROTOCOL */
 }
 
-static int pneigh_get_reply(struct net *net, struct pneigh_entry *neigh,
-			    u32 pid, u32 seq, struct neigh_table *tbl)
-{
-	struct sk_buff *skb;
-	int err = 0;
-
-	skb = nlmsg_new(pneigh_nlmsg_size(), GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	err = pneigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0, tbl);
-	if (err) {
-		kfree_skb(skb);
-		goto errout;
-	}
-
-	err = rtnl_unicast(skb, net, pid);
-errout:
-	return err;
-}
-
 static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		     struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(in_skb->sk);
+	u32 pid = NETLINK_CB(in_skb).portid;
 	struct net_device *dev = NULL;
 	struct neigh_table *tbl = NULL;
+	u32 seq = nlh->nlmsg_seq;
 	struct neighbour *neigh;
+	struct sk_buff *skb;
 	struct ndmsg *ndm;
 	void *dst = NULL;
 	int err;
@@ -2993,11 +2954,19 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (IS_ERR(ndm))
 		return PTR_ERR(ndm);
 
+	if (ndm->ndm_flags & NTF_PROXY)
+		skb = nlmsg_new(neigh_nlmsg_size(), GFP_KERNEL);
+	else
+		skb = nlmsg_new(pneigh_nlmsg_size(), GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
 	if (ndm->ndm_ifindex) {
 		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
-			return -ENODEV;
+			err = -ENODEV;
+			goto err;
 		}
 	}
 
@@ -3007,23 +2976,30 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		pn = pneigh_lookup(tbl, net, dst, dev, 0);
 		if (!pn) {
 			NL_SET_ERR_MSG(extack, "Proxy neighbour entry not found");
-			return -ENOENT;
+			err = -ENOENT;
+			goto err;
 		}
-		return pneigh_get_reply(net, pn, NETLINK_CB(in_skb).portid,
-					nlh->nlmsg_seq, tbl);
-	}
-
-	neigh = neigh_lookup(tbl, dst, dev);
-	if (!neigh) {
-		NL_SET_ERR_MSG(extack, "Neighbour entry not found");
-		return -ENOENT;
-	}
 
-	err = neigh_get_reply(net, neigh, NETLINK_CB(in_skb).portid,
-			      nlh->nlmsg_seq);
+		err = pneigh_fill_info(skb, pn, pid, seq, RTM_NEWNEIGH, 0, tbl);
+		if (err)
+			goto err;
+	} else {
+		neigh = neigh_lookup(tbl, dst, dev);
+		if (!neigh) {
+			NL_SET_ERR_MSG(extack, "Neighbour entry not found");
+			err = -ENOENT;
+			goto err;
+		}
 
-	neigh_release(neigh);
+		err = neigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0);
+		neigh_release(neigh);
+		if (err)
+			goto err;
+	}
 
+	return rtnl_unicast(skb, net, pid);
+err:
+	kfree_skb(skb);
 	return err;
 }
 
-- 
2.49.0


