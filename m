Return-Path: <netdev+bounces-142621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A29BFC8F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3351F215DB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4174A17BCA;
	Thu,  7 Nov 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J8mMOlgt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBA3D64
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946637; cv=none; b=UL0u40osTr+Zx7yiwd1cR26D6xV9cSoYmj/QAJgeQ7wWJx8Xa5ekU4TkXv45NzbD7Un7DiJMCsIJ7spCBTZfe8jB3Yhdc5uCbKOtnb9XR4mpCiNnEExtAJxFArcP46Nkxc2JHhhyM7kFeZxVjODRGOpYaeleUtqcmMMDgIy8l+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946637; c=relaxed/simple;
	bh=nafpWMOADu46APbiYMLK49H+PNnEV7EPjrgjthxHYHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKEdL5DyNV4dupktBVxvUC0/7FK3J0gZ4Ky0z/MOKVDtQwafjtyXDdbsg7sG5FMnpn0tnB9dmKpWmujpVvroNstGT3SBmPkQkSSFoa3o3oB/xnpSJEwOCW2YfuK+zfMvv+X9hcAgK5YCfsqywm3FS7XKbTxo4aSlWVNjhOINACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=J8mMOlgt; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730946635; x=1762482635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YutrCQc7H5HpgQkl2/wLc8GD3cwpkKlIcjmp/z19VMo=;
  b=J8mMOlgtOiWY4Wi0/Axhj+1Iw8++lvIXyQ09auLshFFP9h8sp7VCx1qi
   J1AwD2wPmL66uKVMKb/N93XlHAAD961/5vPZo5ZrTpEcqzF01ZpwSmxI2
   9atxW/Duu8rBl2uwVZCG2QCz903xLRL+59f8mhbxzDfTe84G/TZQZZm+3
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="143982197"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 02:30:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:7116]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.53:2525] with esmtp (Farcaster)
 id 8e22d93f-47ae-47a0-a7dc-b59d5cade8b1; Thu, 7 Nov 2024 02:30:33 +0000 (UTC)
X-Farcaster-Flow-ID: 8e22d93f-47ae-47a0-a7dc-b59d5cade8b1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 02:30:33 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 02:30:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 04/10] rtnetlink: Introduce struct rtnl_nets and helpers.
Date: Wed, 6 Nov 2024 18:28:54 -0800
Message-ID: <20241107022900.70287-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241107022900.70287-1-kuniyu@amazon.com>
References: <20241107022900.70287-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
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
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2:
  * Move struct rtnl_nets to net/core/rtnetlink.c
  * Unexport rtnl_nets_add()
---
 net/core/rtnetlink.c | 70 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 61bf710f97b8..1879a46a9d7e 100644
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
@@ -3770,6 +3829,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *tgt_net, *link_net = NULL;
 	struct rtnl_link_ops *ops = NULL;
 	struct rtnl_newlink_tbs *tbs;
+	struct rtnl_nets rtnl_nets;
 	int ops_srcu_index;
 	int ret;
 
@@ -3813,6 +3873,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 #endif
 	}
 
+	rtnl_nets_init(&rtnl_nets);
+
 	if (ops) {
 		if (ops->maxtype > RTNL_MAX_TYPE) {
 			ret = -EINVAL;
@@ -3842,6 +3904,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto put_ops;
 	}
 
+	rtnl_nets_add(&rtnl_nets, tgt_net);
+
 	if (tb[IFLA_LINK_NETNSID]) {
 		int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);
 
@@ -3852,6 +3916,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto put_net;
 		}
 
+		rtnl_nets_add(&rtnl_nets, link_net);
+
 		if (!netlink_ns_capable(skb, link_net->user_ns, CAP_NET_ADMIN)) {
 			ret = -EPERM;
 			goto put_net;
@@ -3861,9 +3927,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


