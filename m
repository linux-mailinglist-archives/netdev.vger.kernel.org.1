Return-Path: <netdev+bounces-176343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A21AA69C92
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D7C3BF2C0
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B322258C;
	Wed, 19 Mar 2025 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DGACrLXk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23701C3C11
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425838; cv=none; b=op68OIk924gG7rRvkRRh1mPARmLn4M6m7O0igLFke5biXWfDO3NGjBNdTR4eaLJtmZcAC6Wdmm77NzKebE3jkb9sOTGljhbL8DqLgsTvV7JnlORbbD9LESPMaZixOfRsRZHdpl/ftH0D/ysuZuwUuSh0A+BoeSfn8u5OEWXOGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425838; c=relaxed/simple;
	bh=heR2pC8Eyc2NlZLvSdOFtNgKFsTXO0R4NAu+BkI8OPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GK7o8LVZVm8gE0pR8SR+Jf6utanNUirlK/FOuDFUPgnOhACBYfYb24JtcaPOULtWAW4r0iDDr//tVn3filtJz78jALfJt46chtb6YrcWEncmzIz5TQqXncQ1ZK89GwuhsYfcnSeMH8u0cg50Ro2/So2oiL357WVTcA1nGMqVKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DGACrLXk; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742425837; x=1773961837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bBmhM8Urq4ehUXyUuomPJOJwRJBuBu5HPcAZpIVuB+E=;
  b=DGACrLXkGsVoJgSnG2Sgo8gaCzc7C6gZuMsZAPwS6lsqUh3iIv706+HJ
   oektV3rbV66Kco7XcTu9dav0+3qcUrRd6+XLtkxloHdWmH+HysiPZ/2qG
   wJlQ++ZgecfNpF5S/dYESWjv84DrCmq3j9yXRwJlbGsVPmgU0h2knrrjY
   k=;
X-IronPort-AV: E=Sophos;i="6.14,260,1736812800"; 
   d="scan'208";a="75909889"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 23:10:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:26468]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.101:2525] with esmtp (Farcaster)
 id 1fd66f0c-0685-48f8-915e-05a0978e8bcd; Wed, 19 Mar 2025 23:10:34 +0000 (UTC)
X-Farcaster-Flow-ID: 1fd66f0c-0685-48f8-915e-05a0978e8bcd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:10:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:10:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 6/7] nexthop: Convert RTM_NEWNEXTHOP to per-netns RTNL.
Date: Wed, 19 Mar 2025 16:06:51 -0700
Message-ID: <20250319230743.65267-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319230743.65267-1-kuniyu@amazon.com>
References: <20250319230743.65267-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

If we pass false to the rtnl_held param of lwtunnel_valid_encap_type(),
we can move RTNL down before rtm_to_nh_config_rtnl().

Let's use rtnl_net_lock() in rtm_new_nexthop().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index c552bb46aa23..06d5467eadc1 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3169,7 +3169,7 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 
 		cfg->nh_encap_type = nla_get_u16(tb[NHA_ENCAP_TYPE]);
 		err = lwtunnel_valid_encap_type(cfg->nh_encap_type,
-						extack, true);
+						extack, false);
 		if (err < 0)
 			goto out;
 
@@ -3245,13 +3245,18 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 	}
 
+	rtnl_net_lock(net);
+
 	err = rtm_to_nh_config_rtnl(net, tb, &cfg, extack);
 	if (err)
-		goto out;
+		goto unlock;
 
 	nh = nexthop_add(net, &cfg, extack);
 	if (IS_ERR(nh))
 		err = PTR_ERR(nh);
+
+unlock:
+	rtnl_net_unlock(net);
 out:
 	return err;
 }
@@ -4067,18 +4072,19 @@ static struct pernet_operations nexthop_net_ops = {
 };
 
 static const struct rtnl_msg_handler nexthop_rtnl_msg_handlers[] __initconst = {
-	{.msgtype = RTM_NEWNEXTHOP, .doit = rtm_new_nexthop},
+	{.msgtype = RTM_NEWNEXTHOP, .doit = rtm_new_nexthop,
+	 .flags = RTNL_FLAG_DOIT_PERNET},
 	{.msgtype = RTM_DELNEXTHOP, .doit = rtm_del_nexthop},
 	{.msgtype = RTM_GETNEXTHOP, .doit = rtm_get_nexthop,
 	 .dumpit = rtm_dump_nexthop},
 	{.msgtype = RTM_GETNEXTHOPBUCKET, .doit = rtm_get_nexthop_bucket,
 	 .dumpit = rtm_dump_nexthop_bucket},
 	{.protocol = PF_INET, .msgtype = RTM_NEWNEXTHOP,
-	 .doit = rtm_new_nexthop},
+	 .doit = rtm_new_nexthop, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_GETNEXTHOP,
 	 .dumpit = rtm_dump_nexthop},
 	{.protocol = PF_INET6, .msgtype = RTM_NEWNEXTHOP,
-	 .doit = rtm_new_nexthop},
+	 .doit = rtm_new_nexthop, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET6, .msgtype = RTM_GETNEXTHOP,
 	 .dumpit = rtm_dump_nexthop},
 };
-- 
2.48.1


