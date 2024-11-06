Return-Path: <netdev+bounces-142206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B039A9BDD01
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35D21C231BC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323ED18FDAF;
	Wed,  6 Nov 2024 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bIDvR5zf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315BF18FC81
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859906; cv=none; b=LP5CvOe0Hq+akz0jD+SvacNVmY2qa8GbHKq6s22oMBkfUv7MTLmi1gqgemw36VrtK9AfNYdUX+luTSIlAe/5bTWETLst7XOZo+lIceCDayij+xBtJwmWAIE/7RDFKZ/6ZDrV+16DWYykXVFIi1Byu//Rl0boOFD+2UkBAGdw61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859906; c=relaxed/simple;
	bh=mgMPXp/Umcf564mwO4xjfmYj6DyvhTN88OcPNnDMz0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5vqBZ5oh5pGIP3RFxchGk17xk8iC+zthTMZae4zh+mqHVRBUPKmhfobzQd/xVtqLq/KxO4A8AzGltU1CHjYUBw1QdWwrkCqn5Rd2YgYGmpxHQfkpZNvu92mFYHHWwt3ERVbS4nss35wD9v4OjNroXwtwEAg1U6mYSV5jxsXRPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bIDvR5zf; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730859904; x=1762395904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d1m/N81QT+tePNxRmD+pHNTYOKxskE7NJ4uryXLXhYM=;
  b=bIDvR5zfPjf9iOPD1N6Ltgb9B4eMXz9cQ9lz9AYNO4BjBrTiKDPfIfdn
   3vsvBf7SNlZN7PA93zYjeH9NYQ8EZB//yORI77od/N/kw3YJXZUgIfO6B
   7XtrlnfN+7b5vJfLMejcXFB5dP3/bukvmz3I8WjeT3uhp83zEChMUtk6+
   8=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="446706402"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:25:01 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:48625]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.72:2525] with esmtp (Farcaster)
 id c19a0965-ef88-4724-8e2a-91fffd046ebd; Wed, 6 Nov 2024 02:24:59 +0000 (UTC)
X-Farcaster-Flow-ID: c19a0965-ef88-4724-8e2a-91fffd046ebd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 02:24:59 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 02:24:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/7] rtnetlink: Introduce struct rtnl_nets and helpers.
Date: Tue, 5 Nov 2024 18:24:26 -0800
Message-ID: <20241106022432.13065-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241106022432.13065-1-kuniyu@amazon.com>
References: <20241106022432.13065-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

rtnl_newlink() needs to hold 3 per-netns RTNL: 2 for a new device
and 1 for its peer.

We will add rtnl_nets_lock() later, which performs the nested locking
based on struct rtnl_nets, which has an array of struct net pointers.

rtnl_nets_add() adds a net pointer to the array and sorts it so that
rtnl_nets_lock() can simply acquire per-netns RTNL from array[0] to [2].

Before calling rtnl_nets_add(), get_net() must be called for the net,
and rtnl_nets_destroy() will call put_net() for each.

Let's apply the helpers to rtnl_newlink().

When CONFIG_DEBUG_NET_SMALL_RTNL is disabled, we do not call
rtnl_net_lock() thus do not care about the array order, so
rtnl_net_cmp_locks() returns -1 so that the loop in rtnl_nets_add()
can be optimised to NOP.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v2:
  * Move struct rtnl_nets to net/core/rtnetlink.c
  * Unexport rtnl_nets_add()
---
 net/core/rtnetlink.c | 70 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3b33810d92a8..81f4722c1353 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -258,8 +258,67 @@ bool lockdep_rtnl_net_is_held(struct net *net)
 	return lockdep_rtnl_is_held() && lockdep_is_held(&net->rtnl_mutex);
 }
 EXPORT_SYMBOL(lockdep_rtnl_net_is_held);
+#else
+static int rtnl_net_cmp_locks(const struct net *net_a, const struct net *net_b)
+{
+	/* No need to swap */
+	return -1;
+}
 #endif
 
+struct rtnl_nets {
+	/* ->newlink() needs to freeze 3 netns at most;
+	 * 2 for the new device, 1 for its peer.
+	 */
+	struct net *net[3];
+	unsigned char len;
+};
+
+static void rtnl_nets_init(struct rtnl_nets *rtnl_nets)
+{
+	memset(rtnl_nets, 0, sizeof(*rtnl_nets));
+}
+
+static void rtnl_nets_destroy(struct rtnl_nets *rtnl_nets)
+{
+	int i;
+
+	for (i = 0; i < rtnl_nets->len; i++) {
+		put_net(rtnl_nets->net[i]);
+		rtnl_nets->net[i] = NULL;
+	}
+
+	rtnl_nets->len = 0;
+}
+
+/**
+ * rtnl_nets_add - Add netns to be locked before ->newlink().
+ *
+ * @rtnl_nets: rtnl_nets pointer passed to ->get_peer_net().
+ * @net: netns pointer with an extra refcnt held.
+ *
+ * The extra refcnt is released in rtnl_nets_destroy().
+ */
+static void rtnl_nets_add(struct rtnl_nets *rtnl_nets, struct net *net)
+{
+	int i;
+
+	DEBUG_NET_WARN_ON_ONCE(rtnl_nets->len == ARRAY_SIZE(rtnl_nets->net));
+
+	for (i = 0; i < rtnl_nets->len; i++) {
+		switch (rtnl_net_cmp_locks(rtnl_nets->net[i], net)) {
+		case 0:
+			put_net(net);
+			return;
+		case 1:
+			swap(rtnl_nets->net[i], net);
+		}
+	}
+
+	rtnl_nets->net[i] = net;
+	rtnl_nets->len++;
+}
+
 static struct rtnl_link __rcu *__rcu *rtnl_msg_handlers[RTNL_FAMILY_MAX + 1];
 
 static inline int rtm_msgindex(int msgtype)
@@ -3796,6 +3855,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *tgt_net, *link_net = NULL;
 	struct rtnl_link_ops *ops = NULL;
 	struct rtnl_newlink_tbs *tbs;
+	struct rtnl_nets rtnl_nets;
 	int ops_srcu_index;
 	int ret;
 
@@ -3839,6 +3899,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 #endif
 	}
 
+	rtnl_nets_init(&rtnl_nets);
+
 	if (ops) {
 		if (ops->maxtype > RTNL_MAX_TYPE) {
 			ret = -EINVAL;
@@ -3868,6 +3930,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto put_ops;
 	}
 
+	rtnl_nets_add(&rtnl_nets, tgt_net);
+
 	if (tb[IFLA_LINK_NETNSID]) {
 		int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);
 
@@ -3878,6 +3942,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto put_net;
 		}
 
+		rtnl_nets_add(&rtnl_nets, link_net);
+
 		if (!netlink_ns_capable(skb, link_net->user_ns, CAP_NET_ADMIN)) {
 			ret = -EPERM;
 			goto put_net;
@@ -3887,9 +3953,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, tbs, data, extack);
 
 put_net:
-	if (link_net)
-		put_net(link_net);
-	put_net(tgt_net);
+	rtnl_nets_destroy(&rtnl_nets);
 put_ops:
 	if (ops)
 		rtnl_link_ops_put(ops, ops_srcu_index);
-- 
2.39.5 (Apple Git-154)


