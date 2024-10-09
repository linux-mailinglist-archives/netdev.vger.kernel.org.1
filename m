Return-Path: <netdev+bounces-133960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CFA997908
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F17B20F7D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485091E2857;
	Wed,  9 Oct 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k7Taoy5e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6118183CC1
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516033; cv=none; b=tFnPctIgipgAODzIJWlqlBSADnJ9ACCKg7w68fOOnpGAkwzXE3NrbemrbntZTLyqNR4d+KgZ98Ed7c+kSNK89DdKI7Ee4/+UvdgRLEJObz3x2MKh17IvvqjHe24JQcs7aOEFTg8buzD1Vl1saXKxsiSkVaviXImrY4ns1fHtCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516033; c=relaxed/simple;
	bh=ZmgBmoNDzKvddOL6uRK1BXpfDdLMTV9I3wSHjHqM4Xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c66V9Ax5vUd9zSHicH8oKzGidS1N+oNCk4BnoRY2q8m2hsj33nr6mMvTmo/aQQGxss9n6FJU122f0PfdkDmdpBqCOel+B3LI81E4dSWVMnlFuctlikJ6ZVXinHC/SdSPBUofY4s97QMnSIZZQmOuMaTVt4JTFIX2Ve+lyeRrOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k7Taoy5e; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728516029; x=1760052029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Dv5kT5QwJBlAWGz4byvh22avUCmqUEa8gRqZmZQHWA=;
  b=k7Taoy5eFR+JnB/CLoFIl0rQr5h77NynsJUIqDQJMtS//fO4IaERypJV
   XvWoPNFLIcDSKV56HjNFqo8iH1yQ2DBnVXJ4XXrjdmiMuKo4isslaEPRJ
   ElWyQ/n7bYshWA8vp3hvhph7+o0Cxlorf6PjUWF8PwDEHcUItSNCTAq31
   k=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="374826794"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:20:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:11691]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 1cb89540-6ed8-4be1-bea5-a86886deab5c; Wed, 9 Oct 2024 23:20:22 +0000 (UTC)
X-Farcaster-Flow-ID: 1cb89540-6ed8-4be1-bea5-a86886deab5c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:20:22 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:20:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 10/13] rtnetlink: Clean up rtnl_dellink().
Date: Wed, 9 Oct 2024 16:16:53 -0700
Message-ID: <20241009231656.57830-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009231656.57830-1-kuniyu@amazon.com>
References: <20241009231656.57830-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will push RTNL down to rtnl_delink().

Let's unify the error path to make it easy to place rtnl_net_lock().

While at it, keep the variables in reverse xmas order.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 70a3a9f411d8..59a83fd52a92 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3362,14 +3362,14 @@ EXPORT_SYMBOL_GPL(rtnl_delete_link);
 static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	struct ifinfomsg *ifm = nlmsg_data(nlh);
 	struct net *net = sock_net(skb->sk);
 	u32 portid = NETLINK_CB(skb).portid;
-	struct net *tgt_net = net;
-	struct net_device *dev = NULL;
-	struct ifinfomsg *ifm;
 	struct nlattr *tb[IFLA_MAX+1];
-	int err;
+	struct net_device *dev = NULL;
+	struct net *tgt_net = net;
 	int netnsid = -1;
+	int err;
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
 				     ifla_policy, extack);
@@ -3387,27 +3387,20 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			return PTR_ERR(tgt_net);
 	}
 
-	err = -EINVAL;
-	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
 		dev = rtnl_dev_get(tgt_net, tb);
+
+	if (dev)
+		err = rtnl_delete_link(dev, portid, nlh);
+	else if (ifm->ifi_index > 0 || tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
+		err = -ENODEV;
 	else if (tb[IFLA_GROUP])
 		err = rtnl_group_dellink(tgt_net, nla_get_u32(tb[IFLA_GROUP]));
 	else
-		goto out;
-
-	if (!dev) {
-		if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME] || ifm->ifi_index > 0)
-			err = -ENODEV;
-
-		goto out;
-	}
-
-	err = rtnl_delete_link(dev, portid, nlh);
+		err = -EINVAL;
 
-out:
 	if (netnsid >= 0)
 		put_net(tgt_net);
 
-- 
2.39.5 (Apple Git-154)


