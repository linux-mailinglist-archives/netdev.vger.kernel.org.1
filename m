Return-Path: <netdev+bounces-141750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDB09BC2E5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408F8B21708
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7522F1C;
	Tue,  5 Nov 2024 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SqvCiEFa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD9C139
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772369; cv=none; b=rQgH5nC9gg2Jym6+lqE0hmlVk7Qcz1R56UXyey5qmscYeYN/vh+HB0RAaYM6IX/nafp9fJrry3BmfTMSGvsQFaCb+UTEMmr27eU8M0JgDnHEO7ZsAZcMHhu0pspqKig0Q1bJRCq4a/1Woeltyj6ZJZ+zp9+cxbw6z7EHKu2xFM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772369; c=relaxed/simple;
	bh=1Weq/rwj8Z0Qeryc/CpUyVF+R0AkGA09FVdGyp7crjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1oDbpGohhNX+wwTVy5IcwnPp6Ub3Wr5ZEshIn4mtSvkw/9VWGdd6tUTsEbCl2EE3E3yiPhsXpje7b05eDIcq4wZy73eZFXQNuMAE1m4VIIdkE5CVVJ5ZjkGeTVxjeOBrymwbodSiUj54yTkWsobzxR+h3t2GjawVPv8qt/jwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SqvCiEFa; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730772368; x=1762308368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2I5aaqLYZsNCiXqULiBUT7p0gYZuP3uboHkO5RejwXc=;
  b=SqvCiEFa5FF1qhfy6EVC15hmgV3WTfqRYYiWRzo8fksVrabiIo5kE+m/
   e87DLQQ3U+T7m4USwPF42IaFtEdb4vm62CQMVqQsFzhDbeiNuPRyEgUzv
   o7e2CMwGgKQjUhXb7mt3NlPWsX6heNTRJBvQcknHPqpPRI6tUuTXs0LLf
   c=;
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="scan'208";a="772825462"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:06:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:19387]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.37:2525] with esmtp (Farcaster)
 id 31f04357-e68b-41ed-b5ec-93556945258d; Tue, 5 Nov 2024 02:06:01 +0000 (UTC)
X-Farcaster-Flow-ID: 31f04357-e68b-41ed-b5ec-93556945258d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 02:06:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 02:05:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/8] rtnetlink: Factorise rtnl_link_get_net_tb().
Date: Mon, 4 Nov 2024 18:05:08 -0800
Message-ID: <20241105020514.41963-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105020514.41963-1-kuniyu@amazon.com>
References: <20241105020514.41963-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In ops->newlink(), veth, vxcan, and netkit call rtnl_link_get_net() with
a net pointer, which is the first argument of ->newlink().

rtnl_link_get_net() could return another netns based on IFLA_NET_NS_PID
and IFLA_NET_NS_FD in the peer device's attributes.

We want to get it and fill rtnl_nets->nets[] in advance.

Let's factorise the peer netns part from rtnl_link_get_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/rtnetlink.h |  1 +
 net/core/rtnetlink.c    | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 814364367dd7..b9ed44b2d056 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -221,6 +221,7 @@ struct rtnl_af_ops {
 int rtnl_af_register(struct rtnl_af_ops *ops);
 void rtnl_af_unregister(struct rtnl_af_ops *ops);
 
+struct net *rtnl_link_get_net_tb(struct nlattr *tb[]);
 struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[]);
 struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 				    unsigned char name_assign_type,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f98706ad390a..1bc8afcefc1e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2511,9 +2511,10 @@ int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
 }
 EXPORT_SYMBOL(rtnl_nla_parse_ifinfomsg);
 
-struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
+struct net *rtnl_link_get_net_tb(struct nlattr *tb[])
 {
-	struct net *net;
+	struct net *net = NULL;
+
 	/* Examine the link attributes and figure out which
 	 * network namespace we are talking about.
 	 */
@@ -2521,8 +2522,18 @@ struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
 		net = get_net_ns_by_pid(nla_get_u32(tb[IFLA_NET_NS_PID]));
 	else if (tb[IFLA_NET_NS_FD])
 		net = get_net_ns_by_fd(nla_get_u32(tb[IFLA_NET_NS_FD]));
-	else
+
+	return net;
+}
+EXPORT_SYMBOL(rtnl_link_get_net_tb);
+
+struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
+{
+	struct net *net = rtnl_link_get_net_tb(tb);
+
+	if (!net)
 		net = get_net(src_net);
+
 	return net;
 }
 EXPORT_SYMBOL(rtnl_link_get_net);
-- 
2.39.5 (Apple Git-154)


