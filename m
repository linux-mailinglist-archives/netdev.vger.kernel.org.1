Return-Path: <netdev+bounces-136266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A919A121C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D13B24A68
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB2212627;
	Wed, 16 Oct 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WHsJYHJC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049413B584
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105044; cv=none; b=YMEjPcrX9rQ50zYwnpk1ROwWLR+ac6gl9SgoG4IxHfZD2AcmCYHbIiVhICl7k+n82aGofMHIe0dNhdEh9gbTRNgpWCf4Kg3oq7VhX9gPmjLc4FRivRYnN41w6L1IbuzLOqBYpEE/lW3CARlZ6WpX3LwAXBE6iwSWJsD8YtFDX94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105044; c=relaxed/simple;
	bh=leUFy5z6mn3IgFS+NJx9kBbFhhp2sF2uHA4LLUOUEO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9oTZvwgTBGHYPnMWCwT4zIA3N/xfkK6hGr7SP+5C27GF7CQbGJDKsw1yphLI43KRL7S5cK26k5Yna2UouSm87HU1EGuONHWS1DuNzbvbtTTcGbgThIMiTK2G4iLnG0Guen6eHSLwQ7bP36/k1wnjakD/Hxi8AxfE9l0XnluW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WHsJYHJC; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729105044; x=1760641044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9qlAs2ZtbBnA6ISB6pEBwsQPvwbKQtkC7SADEbgyNik=;
  b=WHsJYHJCLH5QT4Z1kQzNkuD19RqLxa4CoDEGRUJsMB9moZ5wjlxJAyOT
   yqo9eVTlVz2KWM69IZW8oHpbQweK6iseISmNvIl0mQd1gjS8QnZJ1MbgX
   GDDFs/z/iY3ccng8t4+oV2SDIRvzZSrBKnCZRomy8BWgu67eUPlKFTa2e
   4=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="461391478"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:57:23 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:10853]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id c239e8e8-f08c-4b7c-a121-6ca39d047a26; Wed, 16 Oct 2024 18:57:22 +0000 (UTC)
X-Farcaster-Flow-ID: c239e8e8-f08c-4b7c-a121-6ca39d047a26
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:57:21 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:57:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 10/14] rtnetlink: Clean up rtnl_dellink().
Date: Wed, 16 Oct 2024 11:53:53 -0700
Message-ID: <20241016185357.83849-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016185357.83849-1-kuniyu@amazon.com>
References: <20241016185357.83849-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will push RTNL down to rtnl_delink().

Let's unify the error path to make it easy to place rtnl_net_lock().

While at it, keep the variables in reverse xmas order.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eee0f820ddf6..a19b2eb2727e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3368,14 +3368,14 @@ EXPORT_SYMBOL_GPL(rtnl_delete_link);
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
@@ -3393,27 +3393,20 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


