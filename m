Return-Path: <netdev+bounces-136268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ECA9A1224
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C12CB2457E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201018C348;
	Wed, 16 Oct 2024 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uOWfbUks"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2492141C0
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105064; cv=none; b=X07ywgazDAdlYEW1HRJfrikZvde2/hfzHVJzJxS+C3T/tm6wUyObjRx9was1VQ7dl+COVGJveyIA8n9aG4Lr032t10x/5yxigF+sG7rGAy9CFjvzuY+A9dTWAubblwgwzFiHrM2wG6j4kRoTdSJrqUSvR6igjeKZUIwv9akVMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105064; c=relaxed/simple;
	bh=953IyyIE54Gv2+yoDg2GLRRi4SG81caxwUdOt1UsOeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMQlnUYwVikRamSFJtNTJvrWmKIrFzjYhDHpVSopzXL7a5hzPaWnzP3hgsRageFu9MNr8whfZ7ZxPTQE9rrOMD+ZdeVSlru6SBGRpOuGDYcmaf8/2UGUbBRCVD9hgCFmTvIYWYMIYAyKf2TWLPpPZvFVo1aYzVmF/OZolA8+O3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uOWfbUks; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729105064; x=1760641064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d/hXO61qwPj8q931bwHEr7ia1OJ0JDaHooBzcWrECPU=;
  b=uOWfbUks48k1nZ0UlB4hDqnvLRtG5YOH0ekYuV9oCZIzKFo7Mta5n/2W
   73Eqqqdev1DNI+WOfOaeqN2mYQEazq3m6caeRfhStwGzeK8pct7RkOgux
   im5jMEMIYRHJmQy9d5IV0QRryvhU67iUpYS6C7bE2dDJ9x1TYTybKyMqj
   k=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="461391573"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:57:43 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:17462]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 5b404aeb-50b5-4e7c-82e1-8ddb848ec81e; Wed, 16 Oct 2024 18:57:42 +0000 (UTC)
X-Farcaster-Flow-ID: 5b404aeb-50b5-4e7c-82e1-8ddb848ec81e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:57:41 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:57:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 11/14] rtnetlink: Clean up rtnl_setlink().
Date: Wed, 16 Oct 2024 11:53:54 -0700
Message-ID: <20241016185357.83849-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will push RTNL down to rtnl_setlink().

Let's unify the error path to make it easy to place rtnl_net_lock().

While at it, keep the variables in reverse xmas order.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a19b2eb2727e..f89a902458d6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3279,11 +3279,11 @@ static struct net_device *rtnl_dev_get(struct net *net,
 static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	struct ifinfomsg *ifm = nlmsg_data(nlh);
 	struct net *net = sock_net(skb->sk);
-	struct ifinfomsg *ifm;
-	struct net_device *dev;
-	int err;
 	struct nlattr *tb[IFLA_MAX+1];
+	struct net_device *dev = NULL;
+	int err;
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
 				     ifla_policy, extack);
@@ -3294,21 +3294,18 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
-	err = -EINVAL;
-	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
 		dev = rtnl_dev_get(net, tb);
 	else
-		goto errout;
+		err = -EINVAL;
 
-	if (dev == NULL) {
+	if (dev)
+		err = do_setlink(skb, dev, ifm, extack, tb, 0);
+	else if (!err)
 		err = -ENODEV;
-		goto errout;
-	}
 
-	err = do_setlink(skb, dev, ifm, extack, tb, 0);
 errout:
 	return err;
 }
-- 
2.39.5 (Apple Git-154)


