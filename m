Return-Path: <netdev+bounces-136729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05D19A2C38
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DF61F23996
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA27183CAE;
	Thu, 17 Oct 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UClH6fGP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7C17E00E
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189989; cv=none; b=iDn3rS2VF4Fn7ETzof2SIC+6Jx6BdGZi1Eu6j5nUWztYIUfFkRIBfBU28b28QjvLz1B+Ehwij9e9Q3pkgvkeBI+Nm2Jwws+0G9iBPvpSuYxEW9kzfI2Sy0JOPeql62bVzTpTwzQ2KWqemQnoG902RPOPSe7Gphp9i1JBrgij5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189989; c=relaxed/simple;
	bh=w0tQc0ecsZELgPf+9/opmvFeQoLNAfClYLOg9jtPEK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCiXN+HkzC54xR3KQi9ZPvmJ+2rNOxnNdvUoeGAuoaL9aaYxmbU3IFHsVGvhqj4sxdBZkpn+5kY1sI658XYFKkyIWmZB7WztpOhuWZKJ/VTL/0dEzVe98uAxpkiSpRNjOGvYSHHdSOB73X9Z/EBI3Scqoih+IItRwA4eNMxp070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UClH6fGP; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729189987; x=1760725987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RDWJnoU8bMagK3aQRzrx8NtqEUmaWeYTHh5BIZhJOj0=;
  b=UClH6fGPe9BXER0yNijQyTFzNHjPlnA9tIVOrV8b5Ls+Lru7KFFkdDCs
   20/vA7OwASyPCko/skRfwlOu6/t1YxTuUq2+MJ2/qks9Uf/CDMyrfewMA
   sBiv96D9HFtR2T/Tw/a+ir3rDi+b0c/mbgORUdDpQMKt+eHvD5v66Fc6I
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="138897907"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:33:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:32526]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id a78431cb-a6bc-43c3-999e-4a782f5abcd9; Thu, 17 Oct 2024 18:33:05 +0000 (UTC)
X-Farcaster-Flow-ID: a78431cb-a6bc-43c3-999e-4a782f5abcd9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 18:33:04 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 18:33:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/9] phonet: Don't hold RTNL for addr_doit().
Date: Thu, 17 Oct 2024 11:31:35 -0700
Message-ID: <20241017183140.43028-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241017183140.43028-1-kuniyu@amazon.com>
References: <20241017183140.43028-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Now only __dev_get_by_index() depends on RTNL in addr_doit().

Let's use dev_get_by_index_rcu() and register addr_doit() with
RTNL_FLAG_DOIT_UNLOCKED.

While at it, I changed phonet_rtnl_msg_handlers[]'s init to C99
style like other core networking code.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/phonet/pn_netlink.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 23097085ad38..5996141e258f 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -65,8 +65,6 @@ static int addr_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	ASSERT_RTNL();
-
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFA_MAX,
 				     ifa_phonet_policy, extack);
 	if (err < 0)
@@ -80,16 +78,24 @@ static int addr_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		/* Phonet addresses only have 6 high-order bits */
 		return -EINVAL;
 
-	dev = __dev_get_by_index(net, ifm->ifa_index);
-	if (dev == NULL)
+	rcu_read_lock();
+
+	dev = dev_get_by_index_rcu(net, ifm->ifa_index);
+	if (!dev) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	if (nlh->nlmsg_type == RTM_NEWADDR)
 		err = phonet_address_add(dev, pnaddr);
 	else
 		err = phonet_address_del(dev, pnaddr);
+
+	rcu_read_unlock();
+
 	if (!err)
 		phonet_address_notify(net, nlh->nlmsg_type, ifm->ifa_index, pnaddr);
+
 	return err;
 }
 
@@ -287,13 +293,18 @@ static int route_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 }
 
 static const struct rtnl_msg_handler phonet_rtnl_msg_handlers[] __initdata_or_module = {
-	{THIS_MODULE, PF_PHONET, RTM_NEWADDR, addr_doit, NULL, 0},
-	{THIS_MODULE, PF_PHONET, RTM_DELADDR, addr_doit, NULL, 0},
-	{THIS_MODULE, PF_PHONET, RTM_GETADDR, NULL, getaddr_dumpit, 0},
-	{THIS_MODULE, PF_PHONET, RTM_NEWROUTE, route_doit, NULL, 0},
-	{THIS_MODULE, PF_PHONET, RTM_DELROUTE, route_doit, NULL, 0},
-	{THIS_MODULE, PF_PHONET, RTM_GETROUTE, NULL, route_dumpit,
-	 RTNL_FLAG_DUMP_UNLOCKED},
+	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_NEWADDR,
+	 .doit = addr_doit, .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_DELADDR,
+	 .doit = addr_doit, .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_GETADDR,
+	 .dumpit = getaddr_dumpit},
+	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_NEWROUTE,
+	 .doit = route_doit},
+	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_DELROUTE,
+	 .doit = route_doit},
+	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_GETROUTE,
+	 .dumpit = route_dumpit, .flags = RTNL_FLAG_DUMP_UNLOCKED},
 };
 
 int __init phonet_netlink_register(void)
-- 
2.39.5 (Apple Git-154)


