Return-Path: <netdev+bounces-141749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4359BC2E4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D61F2175D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E5C1E521;
	Tue,  5 Nov 2024 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pgiq1WTa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050122331
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772344; cv=none; b=oqCX2iK4UdGO2nOVG0O3dIBeToSpWPdHhlA0g39Tu3LBNHye/zBlMY+YnatB4T3cQhym2FA3Ab3vT7QABAOMGX+W7vlGtGgtnanXlJ8GXpFaHbQTpNyHtTd+E3lTiJ+ruO4l4OV0cHp4U10KkwF6ny0jtDuKY+V+pRXXAEDo1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772344; c=relaxed/simple;
	bh=C6RwaLLT2mYCRdMd+CVJigv2CCcd15x1mIqB0/BiVfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/oVRv/ddNXl/3p7JxOOo8j00aO3VXhPk5+b4A0S+N2gaXENty3IjYL+oiZrKEV3Y9xcE5pJOyXC75H71TbvwzMfZVyK20hEw9ZQjs6CXt1xNI4DOO3/Mpp6UQ5NLpvdiksChnGyjR6CUkLtQv8xF22DIE4G5iUqjHFEel1vvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pgiq1WTa; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730772342; x=1762308342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bdmrhO5OfII5psHXdHQjhf0SmuStiB05GQQB8gzYoak=;
  b=pgiq1WTa6DPp8Qb0Nf0mdcc+y7gdJtAaSvJ28RKqjC4IkeIaN1QIQqnH
   vn/KGIMO8kEWzlsdkNWSPonyXlPLEDPHijgcFcvS66ONO+BpnoEuJi/QB
   2OmmzgRgU6BsPRbKRl7o1JzuIaiMYilXCra0xvnvwayCUINgdB2pBQJzw
   c=;
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="scan'208";a="143383104"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:05:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:26016]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.170:2525] with esmtp (Farcaster)
 id 25bab6e1-92aa-4c7b-b43e-c1c6758ae549; Tue, 5 Nov 2024 02:05:41 +0000 (UTC)
X-Farcaster-Flow-ID: 25bab6e1-92aa-4c7b-b43e-c1c6758ae549
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 02:05:40 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 02:05:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/8] rtnetlink: Introduce struct rtnl_nets and helpers.
Date: Mon, 4 Nov 2024 18:05:07 -0800
Message-ID: <20241105020514.41963-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
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
---
 include/net/rtnetlink.h | 10 +++++++
 net/core/rtnetlink.c    | 63 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index b260c0cc9671..814364367dd7 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -68,6 +68,16 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 		return AF_UNSPEC;
 }
 
+struct rtnl_nets {
+	/* ->newlink() needs to freeze 3 netns at most;
+	 * 2 for the new device, 1 for its peer.
+	 */
+	struct net *net[3];
+	unsigned char len;
+};
+
+void rtnl_nets_add(struct rtnl_nets *rtnl_nets, struct net *net);
+
 /**
  *	struct rtnl_link_ops - rtnetlink link operations
  *
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3b33810d92a8..f98706ad390a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -258,8 +258,60 @@ bool lockdep_rtnl_net_is_held(struct net *net)
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
+void rtnl_nets_add(struct rtnl_nets *rtnl_nets, struct net *net)
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
+EXPORT_SYMBOL(rtnl_nets_add);
+
 static struct rtnl_link __rcu *__rcu *rtnl_msg_handlers[RTNL_FAMILY_MAX + 1];
 
 static inline int rtm_msgindex(int msgtype)
@@ -3796,6 +3848,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *tgt_net, *link_net = NULL;
 	struct rtnl_link_ops *ops = NULL;
 	struct rtnl_newlink_tbs *tbs;
+	struct rtnl_nets rtnl_nets;
 	int ops_srcu_index;
 	int ret;
 
@@ -3839,6 +3892,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 #endif
 	}
 
+	rtnl_nets_init(&rtnl_nets);
+
 	if (ops) {
 		if (ops->maxtype > RTNL_MAX_TYPE) {
 			ret = -EINVAL;
@@ -3868,6 +3923,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto put_ops;
 	}
 
+	rtnl_nets_add(&rtnl_nets, tgt_net);
+
 	if (tb[IFLA_LINK_NETNSID]) {
 		int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);
 
@@ -3878,6 +3935,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto put_net;
 		}
 
+		rtnl_nets_add(&rtnl_nets, link_net);
+
 		if (!netlink_ns_capable(skb, link_net->user_ns, CAP_NET_ADMIN)) {
 			ret = -EPERM;
 			goto put_net;
@@ -3887,9 +3946,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


