Return-Path: <netdev+bounces-184012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B12A92F46
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53C219E3920
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2301BC099;
	Fri, 18 Apr 2025 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eK1Z/zxg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0420B22
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939738; cv=none; b=fDngo2Qpq/86cWcA/0lTBZxSyEcly+Ui5+A4f9Slll1pIy3k3uPMwVCCh9IxGT5fFF+CwR3Cozstm7VJttP23gO7Rn2LNz1STW6vf6kNt1nky1GKLQXIr3+ONVzZLKXPoqRFj5DAYdAJjkobVxEEoTrGABfGSfJIl225LdkXREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939738; c=relaxed/simple;
	bh=xeG5txq1ZvTBN510ZvLhkpxt0GkFISl2QHT78uwF+lY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pb2O02tFFHGySEgyIibGc2axnpIY+k/ElfyLOcK/z99EcYY1BFuRvlkkcwwJCI3eoKvTNG0s7nM3aSeJm3y42ng5ebb64xJU3ThZFzCyCixQXagNT5X4cw3CATUUOKvXVxAkbNSUyxFhq5K965IQWDl23/YiJ9LzucCFAxjWi1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eK1Z/zxg; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744939738; x=1776475738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BaH9FTGGuNKOF7UZSFtrotlBAonP80bMhdgsaosdyRA=;
  b=eK1Z/zxg72JIG4oA+ehxAFmHaMyrOlC/AsbJxELYxD2eeefMmKkbjBW8
   pRedKV6Wi0ygMKWKOtH+Q1okNHt0nbaGuBAwftGdulhW6Y1iS8UygyIkW
   aBV8+R68b0VdMd3G5RWyAKMe9pxheeOYxRMhpG+/a+k8L7frvmyK/vmha
   I=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="816993749"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 01:28:52 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:48774]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.240:2525] with esmtp (Farcaster)
 id 0b53948f-b215-4442-9e27-0a6ee93ca091; Fri, 18 Apr 2025 01:28:51 +0000 (UTC)
X-Farcaster-Flow-ID: 0b53948f-b215-4442-9e27-0a6ee93ca091
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:28:50 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 01:28:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/7] neighbour: Allocate skb in neigh_get().
Date: Thu, 17 Apr 2025 18:26:55 -0700
Message-ID: <20250418012727.57033-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418012727.57033-1-kuniyu@amazon.com>
References: <20250418012727.57033-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
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
index 29f3d5e31901..1abce19040bf 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2934,27 +2934,6 @@ static inline size_t neigh_nlmsg_size(void)
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
@@ -2963,34 +2942,16 @@ static inline size_t pneigh_nlmsg_size(void)
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
@@ -2999,11 +2960,19 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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
 
@@ -3013,23 +2982,30 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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


