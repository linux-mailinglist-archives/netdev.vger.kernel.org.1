Return-Path: <netdev+bounces-158410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 147BAA11B9D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D80417A4124
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9100F22FDFB;
	Wed, 15 Jan 2025 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fqG700ao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA620F07A
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928667; cv=none; b=eJGLrJZ5dz2yFSbgsQw4YrnT+6JjnieJYk+R4zdBgN5myMJF/QMmY9K9OW/I0GqUStDXFSKONCtjbGemFZ0kZMuNvAxK9O3KeRAw6xBABVtS9k6Mh5e8ZBVGf7zpOwWHXAlq/9Dqm7/lJmK/5X2n7P6uVl6gLhTaAujWdksoB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928667; c=relaxed/simple;
	bh=8vuhnvRzNmnPk9b1ud8KN72ZWNkNQWGb9PPPDK9DYdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0aYqEURxZC9aoY4cUiqbHODoxbakNbTXtLPD2tv7iOK8eujB0J/YMhcbCz/OMXJtoeC/OFtiPic8N6eZpxi++rVZ8JIKsEKlfReb83r08LM+pFjyFNnNim+uElXNwEl6mjTmVbYp7prwdAXgU5fighaalv0YU8c1XLbARqnkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fqG700ao; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928665; x=1768464665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ukWMQWDUSTqqzOvRieEBSlxHqY7ApZ+iyIl7g1fHBqE=;
  b=fqG700aoPZouI+KcBhGsYVQ4OFPEaStfSFthB6BflO/vpTIre+94VaMm
   tm1QsY2wPxCXpuxdBDizJ8dSbUGUcRdEnhE6uYpeK22qWlUvQXDwp3Eb5
   r7iXczu5szXEHwrJI03jI9Ta3PEr6tuiqhReWKY4R2vQVjU7eVITCpWw+
   8=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="57830517"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:11:00 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:31282]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.70:2525] with esmtp (Farcaster)
 id 270f051f-dd8a-4659-a0a9-199ce61ff134; Wed, 15 Jan 2025 08:10:59 +0000 (UTC)
X-Farcaster-Flow-ID: 270f051f-dd8a-4659-a0a9-199ce61ff134
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:10:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:10:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 10/11] ipv6: Convert inet6_rtm_newaddr() to per-netns RTNL.
Date: Wed, 15 Jan 2025 17:06:07 +0900
Message-ID: <20250115080608.28127-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115080608.28127-1-kuniyu@amazon.com>
References: <20250115080608.28127-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's register inet6_rtm_newaddr() with RTNL_FLAG_DOIT_PERNET
and hold rtnl_net_lock() before __dev_get_by_index().

Now that inet6_addr_add() and inet6_addr_modify() are always
called under per-netns RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9ae25a8d1632..b848e4038d2e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3014,7 +3014,7 @@ static int inet6_addr_add(struct net *net, struct net_device *dev,
 	struct inet6_ifaddr *ifp;
 	struct inet6_dev *idev;
 
-	ASSERT_RTNL();
+	ASSERT_RTNL_NET(net);
 
 	if (cfg->plen > 128) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid prefix length");
@@ -4849,7 +4849,7 @@ static int inet6_addr_modify(struct net *net, struct inet6_ifaddr *ifp,
 	bool new_peer = false;
 	bool had_prefixroute;
 
-	ASSERT_RTNL();
+	ASSERT_RTNL_NET(net);
 
 	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR &&
 	    (ifp->flags & IFA_F_TEMPORARY || ifp->prefix_len != 64))
@@ -5016,15 +5016,20 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
+	rtnl_net_lock(net);
+
 	dev =  __dev_get_by_index(net, ifm->ifa_index);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to find the interface");
-		return -ENODEV;
+		err = -ENODEV;
+		goto unlock;
 	}
 
 	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev))
-		return PTR_ERR(idev);
+	if (IS_ERR(idev)) {
+		err = PTR_ERR(idev);
+		goto unlock;
+	}
 
 	if (!ipv6_allow_optimistic_dad(net, idev))
 		cfg.ifa_flags &= ~IFA_F_OPTIMISTIC;
@@ -5032,7 +5037,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (cfg.ifa_flags & IFA_F_NODAD &&
 	    cfg.ifa_flags & IFA_F_OPTIMISTIC) {
 		NL_SET_ERR_MSG(extack, "IFA_F_NODAD and IFA_F_OPTIMISTIC are mutually exclusive");
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
 	}
 
 	ifa = ipv6_get_ifaddr(net, cfg.pfx, dev, 1);
@@ -5041,7 +5047,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		 * It would be best to check for !NLM_F_CREATE here but
 		 * userspace already relies on not having to provide this.
 		 */
-		return inet6_addr_add(net, dev, &cfg, expires, flags, extack);
+		err = inet6_addr_add(net, dev, &cfg, expires, flags, extack);
+		goto unlock;
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_EXCL ||
@@ -5053,6 +5060,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	in6_ifa_put(ifa);
+unlock:
+	rtnl_net_unlock(net);
 
 	return err;
 }
@@ -7393,7 +7402,7 @@ static const struct rtnl_msg_handler addrconf_rtnl_msg_handlers[] __initconst_or
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETLINK,
 	 .dumpit = inet6_dump_ifinfo, .flags = RTNL_FLAG_DUMP_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_NEWADDR,
-	 .doit = inet6_rtm_newaddr},
+	 .doit = inet6_rtm_newaddr, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_DELADDR,
 	 .doit = inet6_rtm_deladdr},
 	{.owner = THIS_MODULE, .protocol = PF_INET6, .msgtype = RTM_GETADDR,
-- 
2.39.5 (Apple Git-154)


