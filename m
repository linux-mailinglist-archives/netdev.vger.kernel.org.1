Return-Path: <netdev+bounces-136734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F079A2C3F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8950CB20AC3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D27E188731;
	Thu, 17 Oct 2024 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G9wCygHj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4116EB42
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190085; cv=none; b=CFXqWf7R4g3yUXdj321+aVRqFSg8J/gdxYeNnMWyIz9dR/g2M/51mju9+qeSQQxhcYdWvib3+7fSAQhIXv8QoUdpfsDAFi1W6H97RAx0JoiEl37FeiGWzelgtoXGy8dYXWmuPZCAuSkN6fc0ezw/8PlNqfJBjaKGYrZgoILpn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190085; c=relaxed/simple;
	bh=t8VvAQ0Omj64LxcL8dnjsLKUcnJuy+rqlf9DK+3ZtD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1BrSDfCn7NZLTbAhlrQDTJeIpANHOyCnv72yxzFg3GRVjUs1XmUK6qtSEue5e7xoaPp6sqhXH98/jjp4XLHIIrloD8JOzhnBuPt+dFPryzum//IhFrDMjYNH6D22pLFinSpkvFR46Tl9gIR0tKCwQr2nUDFcJgPjNZWI13TtRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=G9wCygHj; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729190081; x=1760726081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H0mJSF2TxlfZzvtGbhYB2AVSxydP3pgjJdnHsgrJfkk=;
  b=G9wCygHjGSiRkbTjNnejvOZfry7siqV/sRhCvCoaqBPYiKbTaFQJmon8
   xcwxAzstHNihM1Gqtk5Ke3SnCyPb5Jq4Xw4UwZFKmhdg2YETPXzQLA4bH
   0AefKgZuGFhE+nESE4tVDZkF0NpZqQip2Pp3GSJYARDiQefFPrrEnNJAX
   E=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="377312469"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:34:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:64917]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id 71ce9a74-71de-403c-b269-79df2d59465c; Thu, 17 Oct 2024 18:34:40 +0000 (UTC)
X-Farcaster-Flow-ID: 71ce9a74-71de-403c-b269-79df2d59465c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 18:34:39 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 18:34:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 9/9] phonet: Don't hold RTNL for route_doit().
Date: Thu, 17 Oct 2024 11:31:40 -0700
Message-ID: <20241017183140.43028-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Now only __dev_get_by_index() depends on RTNL in route_doit().

Let's use dev_get_by_index_rcu() and register route_doit() with
RTNL_FLAG_DOIT_UNLOCKED.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/phonet/pn_netlink.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index bfec5bd639b6..ca1f04e4a2d9 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -245,8 +245,6 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	ASSERT_RTNL();
-
 	err = nlmsg_parse_deprecated(nlh, sizeof(*rtm), tb, RTA_MAX,
 				     rtm_phonet_policy, extack);
 	if (err < 0)
@@ -262,16 +260,25 @@ static int route_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 
 	ifindex = nla_get_u32(tb[RTA_OIF]);
-	dev = __dev_get_by_index(net, ifindex);
-	if (dev == NULL)
+
+	rcu_read_lock();
+
+	dev = dev_get_by_index_rcu(net, ifindex);
+	if (!dev) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	if (nlh->nlmsg_type == RTM_NEWROUTE)
 		err = phonet_route_add(dev, dst);
 	else
 		err = phonet_route_del(dev, dst);
+
+	rcu_read_unlock();
+
 	if (!err)
 		rtm_phonet_notify(net, nlh->nlmsg_type, ifindex, dst);
+
 	return err;
 }
 
@@ -308,9 +315,9 @@ static const struct rtnl_msg_handler phonet_rtnl_msg_handlers[] __initdata_or_mo
 	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_GETADDR,
 	 .dumpit = getaddr_dumpit, .flags = RTNL_FLAG_DUMP_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_NEWROUTE,
-	 .doit = route_doit},
+	 .doit = route_doit, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_DELROUTE,
-	 .doit = route_doit},
+	 .doit = route_doit, .flags = RTNL_FLAG_DOIT_UNLOCKED},
 	{.owner = THIS_MODULE, .protocol = PF_PHONET, .msgtype = RTM_GETROUTE,
 	 .dumpit = route_dumpit, .flags = RTNL_FLAG_DUMP_UNLOCKED},
 };
-- 
2.39.5 (Apple Git-154)


