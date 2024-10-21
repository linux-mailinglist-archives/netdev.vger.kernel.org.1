Return-Path: <netdev+bounces-137610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5195F9A726E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D22E1C21BE5
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E5F1F9AB1;
	Mon, 21 Oct 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DNFX3306"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB03A41
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535704; cv=none; b=jEhh0e5tTyZCk8+65ybdnGOAVvSD6rjyasUBzIeKDcpILpTFsJJG45XhPCmAxhGv5AvvsYT3u84dZiMPAEtRH/K+mZHUyHjD1KdEVSB/RwTAp2L9V/XU8AUfkp3IL3m+1e21G/RQKxSTWBmJsUDYwRNvFQyWkJiTCB8/7iESGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535704; c=relaxed/simple;
	bh=lm+ItdEShmtD0dsOS8gUASXHw8vfmgMO7v/ygzcD0GI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQakcgI5yAjkYXLq4Xi8YNXADeQ3RFaTZp+8gzPs1GBZJ431egiBqhatvH7ecLFiZBnG4Wek+Q+nyODpX9LIKEfc+AIpRW/7gX8dOZMa8/epnj2LVibMjBf3j0XTayiaYotKRqUEPeTnN1Vbm5GX/gCqsL9ZGr0gEtYggX9Bt40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DNFX3306; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535703; x=1761071703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=prSrnDCmntYuYVZsK85uDPqZ+IrVK1VCdsgGcKczyPc=;
  b=DNFX3306xnLjD3YLspNWSSbYffvKUTFwGQlFVASMrreErVnmwTldr/BI
   G1R5dmFBqfYCBV38XSujd0gxhpgEAKQlbYXysHw7r9OD3mZJFcyiNPQdL
   KQNbofID6+yMQgRZ/8ZuipdOphltlzhWsvuPbspFaClmDOuWwelyiAbJQ
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="668014541"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:35:01 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:63038]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.192:2525] with esmtp (Farcaster)
 id 02fcacca-4860-47a9-a8bf-f25e702e3817; Mon, 21 Oct 2024 18:34:59 +0000 (UTC)
X-Farcaster-Flow-ID: 02fcacca-4860-47a9-a8bf-f25e702e3817
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:34:59 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:34:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/12] ipv4: Convert RTM_DELADDR to per-netns RTNL.
Date: Mon, 21 Oct 2024 11:32:34 -0700
Message-ID: <20241021183239.79741-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
References: <20241021183239.79741-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's push down RTNL into inet_rtm_deladdr() as rtnl_net_lock().

Now, ip_mc_autojoin_config() is always called under per-netns RTNL,
so ASSERT_RTNL() can be replaced with ASSERT_RTNL_NET().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 96f6592740c6..db56c1e16f65 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -645,7 +645,7 @@ static int ip_mc_autojoin_config(struct net *net, bool join,
 	struct sock *sk = net->ipv4.mc_autojoin_sk;
 	int ret;
 
-	ASSERT_RTNL();
+	ASSERT_RTNL_NET(net);
 
 	lock_sock(sk);
 	if (join)
@@ -671,22 +671,24 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct in_ifaddr *ifa;
 	int err;
 
-	ASSERT_RTNL();
-
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFA_MAX,
 				     ifa_ipv4_policy, extack);
 	if (err < 0)
-		goto errout;
+		goto out;
 
 	ifm = nlmsg_data(nlh);
+
+	rtnl_net_lock(net);
+
 	in_dev = inetdev_by_index(net, ifm->ifa_index);
 	if (!in_dev) {
 		NL_SET_ERR_MSG(extack, "ipv4: Device not found");
 		err = -ENODEV;
-		goto errout;
+		goto unlock;
 	}
 
-	for (ifap = &in_dev->ifa_list; (ifa = rtnl_dereference(*ifap)) != NULL;
+	for (ifap = &in_dev->ifa_list;
+	     (ifa = rtnl_net_dereference(net, *ifap)) != NULL;
 	     ifap = &ifa->ifa_next) {
 		if (tb[IFA_LOCAL] &&
 		    ifa->ifa_local != nla_get_in_addr(tb[IFA_LOCAL]))
@@ -702,13 +704,16 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 		if (ipv4_is_multicast(ifa->ifa_address))
 			ip_mc_autojoin_config(net, false, ifa);
+
 		__inet_del_ifa(in_dev, ifap, 1, nlh, NETLINK_CB(skb).portid);
-		return 0;
+		goto unlock;
 	}
 
 	NL_SET_ERR_MSG(extack, "ipv4: Address not found");
 	err = -EADDRNOTAVAIL;
-errout:
+unlock:
+	rtnl_net_unlock(net);
+out:
 	return err;
 }
 
@@ -2832,7 +2837,8 @@ static struct rtnl_af_ops inet_af_ops __read_mostly = {
 static const struct rtnl_msg_handler devinet_rtnl_msg_handlers[] __initconst = {
 	{.protocol = PF_INET, .msgtype = RTM_NEWADDR, .doit = inet_rtm_newaddr,
 	 .flags = RTNL_FLAG_DOIT_PERNET},
-	{.protocol = PF_INET, .msgtype = RTM_DELADDR, .doit = inet_rtm_deladdr},
+	{.protocol = PF_INET, .msgtype = RTM_DELADDR, .doit = inet_rtm_deladdr,
+	 .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_GETADDR, .dumpit = inet_dump_ifaddr,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
 	{.protocol = PF_INET, .msgtype = RTM_GETNETCONF,
-- 
2.39.5 (Apple Git-154)


