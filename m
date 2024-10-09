Return-Path: <netdev+bounces-133961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A63997909
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2800728434C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899EB1E32A6;
	Wed,  9 Oct 2024 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OqfdJqmU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061D183CC1
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516048; cv=none; b=feDKh7NodH24MIbTNfft88xEUh6/gZMrPXdPWyLwEN/wyQzC4KQm2Gj9G+LPgktNVWeJJpPHqxukbdiLXkwsPS3bHwDg4KAPj7Mbw/9faj4bD7OLyMCT31G3vUG3oevIQgKs9JazJig6GCKtukYm5ddZeubEUuw3xptjBAe9Hdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516048; c=relaxed/simple;
	bh=6TjUqRS2Six37QPt7Bxdh2FQUj38Cp0rQhgGNdPfQrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+EWDWsC5jSDdxI0EKhk15/pOywvK6FYbql60Qyf5TKdz0fHhsadBzvphrQBXeXs7AUQ6gzkECgCCosVulXqL8VTAHXZL8vURBXMsAo7lFFdRscOYXRVTVKj0mpRRPASy/rIKaswxQFMN4ZAIv0PHMqXF/cXmRp2RJOCktFDKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OqfdJqmU; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728516047; x=1760052047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hUmG5zHRXs777dslUqPDJwWZmEtpXHbsLgZ6YrE+qZg=;
  b=OqfdJqmUVNH30qaG8p8bNx/e9r8otgXBjJXlKLV3hNFtf6bh1bbE6taI
   NJQ+9L3591vmtKtNNa3Y/EhFHauENImOwgrMIn8y4RG7jYhHC2YRvvefV
   k26aQ7Jx55wulyQhbpsjlKnHbuFENZDOfQOACiRvzQzPNi04GZLnFidrz
   E=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="439638516"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:20:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:44697]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.107:2525] with esmtp (Farcaster)
 id 14fdecb0-d98c-4197-8b78-31f407c17927; Wed, 9 Oct 2024 23:20:45 +0000 (UTC)
X-Farcaster-Flow-ID: 14fdecb0-d98c-4197-8b78-31f407c17927
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:20:41 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:20:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/13] rtnetlink: Clean up rtnl_setlink().
Date: Wed, 9 Oct 2024 16:16:54 -0700
Message-ID: <20241009231656.57830-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will push RTNL down to rtnl_setlink().

Let's unify the error path to make it easy to place rtnl_net_lock().

While at it, keep the variables in reverse xmas order.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 59a83fd52a92..de693a88986e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3273,11 +3273,11 @@ static struct net_device *rtnl_dev_get(struct net *net,
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
@@ -3288,21 +3288,18 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


