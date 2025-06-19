Return-Path: <netdev+bounces-199372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F880ADFF60
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1393ACD78
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55E25E829;
	Thu, 19 Jun 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PFMrC4Ce"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2325EF90
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320075; cv=none; b=GiEL9cf5KpHwo3xJQoleBvbDi0t8jKNQZuA/vGhRVilxoDOjzEJtF+KWJXWcZU1szrG9qUv5eZDXjU3znR/98vHZNtYNefO50PQaNUdi3yyrgH29uc8RuXKJpiKQpOPL+yeF61vVqKRr6kq159ngIy/J8N9rBbQTl/kcoqqQSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320075; c=relaxed/simple;
	bh=7rlERiI3Mi+F22kpgOA1hX9Dd3RaYb8gcBMVAPdGNn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RpMk4tZiLicTQokf1QG9S1o9euy347Wl2+lI/DPWQll/88kgK8xNN/Bwyw6Hj3QhjqUkTKlNuQiQZwA2NExx5D8qGd+nerrLcJtPxGqYRD4UhYH0irqxK4OZ3Zse1Wfcs6GZFOEQUZKfRaiTSU8JMSw8ozXJjDd7yWN8zu/Sis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PFMrC4Ce; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750320064;
	bh=AZV4UrZXc/j+AwNr07FO40iJoPQdgQF6koVZQW8htXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PFMrC4Cer0oVlcbTOwJOeTIc7rWGEpSWn8WVk8NR8U8KL4ert6In11fdwPaX6bzxJ
	 dCjcGHi66h0jwW2Mh3U+3JEDcEPx52ODAZPnVbMpPYdJzabLH7HLaQTFaRb9zqI1rz
	 uXLUDRDkBN9I+KcS+S9eyivzuuMLvbBX+PnKQ/LfqYZofzJklAD9EeLJBaEP4qLZCZ
	 tw0QaFxEQ/aSsZWQnmgIvaTX/b57XHvDxxw7jS/k9CdjOFiHXMIV/C8dtqDOIJlZfb
	 OY1MrbXjd8KWJb/J5mLHL61QlUBaWBFs2DUDwnCQirBR2w2ZHxX5lmmoYyZXg5apfo
	 bapygVACwh7jQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 49DA168ED0; Thu, 19 Jun 2025 16:01:04 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 19 Jun 2025 16:00:47 +0800
Subject: [PATCH net-next v2 12/13] net: mctp: add gateway routing support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-dev-forwarding-v2-12-3f81801b06c2@codeconstruct.com.au>
References: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
In-Reply-To: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

This change allows for gateway routing, where a route table entry
may reference a routable endpoint (by network and EID), instead of
routing directly to a netdevice.

We add support for a RTM_GATEWAY attribute for netlink route updates,
with an attribute format of:

    struct mctp_fq_addr {
        unsigned int net;
        mctp_eid_t eid;
    }

- we need the net here to uniquely identify the target EID, as we no
longer have the device reference directly (which would provide the net
id in the case of direct routes).

This makes route lookups recursive, as a route lookup that returns a
gateway route must be resolved into a direct route (ie, to a device)
eventually. We provide a limit to the route lookups, to prevent infinite
loop routing.

The route lookup populates a new 'nexthop' field in the dst structure,
which now specifies the key for the neighbour table lookup on device
output, rather than using the packet destination address directly.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
--
v2:
 - prevent uninitialsed gateway variable in nlparse_common, as reported
   by Simon Horman via smatch
---
 include/net/mctp.h        |  13 ++-
 include/uapi/linux/mctp.h |   8 ++
 net/mctp/route.c          | 200 ++++++++++++++++++++++++++++++++++------------
 net/mctp/test/utils.c     |   3 +-
 4 files changed, 171 insertions(+), 53 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index b3af0690f60749a9bf9f489c7118c82cfd9d577e..ac4f4ecdfc24f1f481ff22a5673cb95e1bf21310 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -237,8 +237,18 @@ struct mctp_route {
 	mctp_eid_t		min, max;
 
 	unsigned char		type;
+
 	unsigned int		mtu;
-	struct mctp_dev		*dev;
+
+	enum {
+		MCTP_ROUTE_DIRECT,
+		MCTP_ROUTE_GATEWAY,
+	} dst_type;
+	union {
+		struct mctp_dev	*dev;
+		struct mctp_fq_addr gateway;
+	};
+
 	int			(*output)(struct mctp_dst *dst,
 					  struct sk_buff *skb);
 
@@ -256,6 +266,7 @@ struct mctp_route {
 struct mctp_dst {
 	struct mctp_dev *dev;
 	unsigned int mtu;
+	mctp_eid_t nexthop;
 
 	/* set for direct addressing */
 	unsigned char halen;
diff --git a/include/uapi/linux/mctp.h b/include/uapi/linux/mctp.h
index e1db65df9359fea810a876786b864743c77e2478..19ad12a0cd4b4599667519aaed73a12d2892aa25 100644
--- a/include/uapi/linux/mctp.h
+++ b/include/uapi/linux/mctp.h
@@ -37,6 +37,14 @@ struct sockaddr_mctp_ext {
 	__u8			smctp_haddr[MAX_ADDR_LEN];
 };
 
+/* A "fully qualified" MCTP address, which includes the system-local network ID,
+ * required to uniquely resolve a routable EID.
+ */
+struct mctp_fq_addr {
+	unsigned int	net;
+	mctp_eid_t	eid;
+};
+
 #define MCTP_NET_ANY		0x0
 
 #define MCTP_ADDR_NULL		0x00
diff --git a/net/mctp/route.c b/net/mctp/route.c
index ab5116c12b91461011c1ec3d9954609658a40a22..ed1ac147aff7af49030663f85558ff9b6dce4b27 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -563,7 +563,6 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 
 static int mctp_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 {
-	struct mctp_hdr *hdr = mctp_hdr(skb);
 	char daddr_buf[MAX_ADDR_LEN];
 	char *daddr = NULL;
 	int rc;
@@ -586,7 +585,7 @@ static int mctp_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 		daddr = dst->haddr;
 	} else {
 		/* If lookup fails let the device handle daddr==NULL */
-		if (mctp_neigh_lookup(dst->dev, hdr->dest, daddr_buf) == 0)
+		if (mctp_neigh_lookup(dst->dev, dst->nexthop, daddr_buf) == 0)
 			daddr = daddr_buf;
 	}
 
@@ -610,7 +609,8 @@ static int mctp_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 static void mctp_route_release(struct mctp_route *rt)
 {
 	if (refcount_dec_and_test(&rt->refs)) {
-		mctp_dev_put(rt->dev);
+		if (rt->dst_type == MCTP_ROUTE_DIRECT)
+			mctp_dev_put(rt->dev);
 		kfree_rcu(rt, rcu);
 	}
 }
@@ -799,10 +799,16 @@ static struct mctp_sk_key *mctp_lookup_prealloc_tag(struct mctp_sock *msk,
 }
 
 /* routing lookups */
+static unsigned int mctp_route_netid(struct mctp_route *rt)
+{
+	return rt->dst_type == MCTP_ROUTE_DIRECT ?
+		READ_ONCE(rt->dev->net) : rt->gateway.net;
+}
+
 static bool mctp_rt_match_eid(struct mctp_route *rt,
 			      unsigned int net, mctp_eid_t eid)
 {
-	return READ_ONCE(rt->dev->net) == net &&
+	return mctp_route_netid(rt) == net &&
 		rt->min <= eid && rt->max >= eid;
 }
 
@@ -811,16 +817,21 @@ static bool mctp_rt_compare_exact(struct mctp_route *rt1,
 				  struct mctp_route *rt2)
 {
 	ASSERT_RTNL();
-	return rt1->dev->net == rt2->dev->net &&
+	return mctp_route_netid(rt1) == mctp_route_netid(rt2) &&
 		rt1->min == rt2->min &&
 		rt1->max == rt2->max;
 }
 
-static void mctp_dst_from_route(struct mctp_dst *dst, struct mctp_route *route)
+/* must only be called on a direct route, as the final output hop */
+static void mctp_dst_from_route(struct mctp_dst *dst, mctp_eid_t eid,
+				unsigned int mtu, struct mctp_route *route)
 {
 	mctp_dev_hold(route->dev);
+	dst->nexthop = eid;
 	dst->dev = route->dev;
-	dst->mtu = route->mtu ?: READ_ONCE(dst->dev->dev->mtu);
+	dst->mtu = READ_ONCE(dst->dev->dev->mtu);
+	if (mtu)
+		dst->mtu = min(dst->mtu, mtu);
 	dst->halen = 0;
 	dst->output = route->output;
 }
@@ -849,6 +860,7 @@ int mctp_dst_from_extaddr(struct mctp_dst *dst, struct net *net, int ifindex,
 	dst->mtu = READ_ONCE(netdev->mtu);
 	dst->halen = halen;
 	dst->output = mctp_dst_output;
+	dst->nexthop = 0;
 	memcpy(dst->haddr, haddr, halen);
 
 	rc = 0;
@@ -863,24 +875,54 @@ void mctp_dst_release(struct mctp_dst *dst)
 	mctp_dev_put(dst->dev);
 }
 
+static struct mctp_route *mctp_route_lookup_single(struct net *net,
+						   unsigned int dnet,
+						   mctp_eid_t daddr)
+{
+	struct mctp_route *rt;
+
+	list_for_each_entry_rcu(rt, &net->mctp.routes, list) {
+		if (mctp_rt_match_eid(rt, dnet, daddr))
+			return rt;
+	}
+
+	return NULL;
+}
+
 /* populates *dst on successful lookup, if set */
 int mctp_route_lookup(struct net *net, unsigned int dnet,
 		      mctp_eid_t daddr, struct mctp_dst *dst)
 {
+	const unsigned int max_depth = 32;
+	unsigned int depth, mtu = 0;
 	int rc = -EHOSTUNREACH;
-	struct mctp_route *rt;
 
 	rcu_read_lock();
 
-	list_for_each_entry_rcu(rt, &net->mctp.routes, list) {
-		/* TODO: add metrics */
-		if (!mctp_rt_match_eid(rt, dnet, daddr))
-			continue;
+	for (depth = 0; depth < max_depth; depth++) {
+		struct mctp_route *rt;
 
-		if (dst)
-			mctp_dst_from_route(dst, rt);
-		rc = 0;
-		break;
+		rt = mctp_route_lookup_single(net, dnet, daddr);
+		if (!rt)
+			break;
+
+		/* clamp mtu to the smallest in the path, allowing 0
+		 * to specify no restrictions
+		 */
+		if (mtu && rt->mtu)
+			mtu = min(mtu, rt->mtu);
+		else
+			mtu = mtu ?: rt->mtu;
+
+		if (rt->dst_type == MCTP_ROUTE_DIRECT) {
+			if (dst)
+				mctp_dst_from_route(dst, daddr, mtu, rt);
+			rc = 0;
+			break;
+
+		} else if (rt->dst_type == MCTP_ROUTE_GATEWAY) {
+			daddr = rt->gateway.eid;
+		}
 	}
 
 	rcu_read_unlock();
@@ -897,10 +939,13 @@ static int mctp_route_lookup_null(struct net *net, struct net_device *dev,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(rt, &net->mctp.routes, list) {
-		if (rt->dev->dev != dev || rt->type != RTN_LOCAL)
+		if (rt->dst_type != MCTP_ROUTE_DIRECT || rt->type != RTN_LOCAL)
 			continue;
 
-		mctp_dst_from_route(dst, rt);
+		if (rt->dev->dev != dev)
+			continue;
+
+		mctp_dst_from_route(dst, 0, 0, rt);
 		rc = 0;
 		break;
 	}
@@ -1080,11 +1125,6 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 	return rc;
 }
 
-static unsigned int mctp_route_netid(struct mctp_route *rt)
-{
-	return rt->dev->net;
-}
-
 /* route management */
 
 /* mctp_route_add(): Add the provided route, previously allocated via
@@ -1092,9 +1132,9 @@ static unsigned int mctp_route_netid(struct mctp_route *rt)
  * hold on rt->dev for usage in the route table. On failure a caller will want
  * to mctp_route_release().
  *
- * We expect that the caller has set rt->type, rt->min, rt->max, rt->dev and
- * rt->mtu, and that the route holds a reference to rt->dev (via mctp_dev_hold).
- * Other fields will be populated.
+ * We expect that the caller has set rt->type, rt->dst_type, rt->min, rt->max,
+ * rt->mtu and either rt->dev (with a reference held appropriately) or
+ * rt->gateway. Other fields will be populated.
  */
 static int mctp_route_add(struct net *net, struct mctp_route *rt)
 {
@@ -1103,7 +1143,10 @@ static int mctp_route_add(struct net *net, struct mctp_route *rt)
 	if (!mctp_address_unicast(rt->min) || !mctp_address_unicast(rt->max))
 		return -EINVAL;
 
-	if (!rt->dev)
+	if (rt->dst_type == MCTP_ROUTE_DIRECT && !rt->dev)
+		return -EINVAL;
+
+	if (rt->dst_type == MCTP_ROUTE_GATEWAY && !rt->gateway.eid)
 		return -EINVAL;
 
 	switch (rt->type) {
@@ -1172,6 +1215,7 @@ int mctp_route_add_local(struct mctp_dev *mdev, mctp_eid_t addr)
 
 	rt->min = addr;
 	rt->max = addr;
+	rt->dst_type = MCTP_ROUTE_DIRECT;
 	rt->dev = mdev;
 	rt->type = RTN_LOCAL;
 
@@ -1198,7 +1242,7 @@ void mctp_route_remove_dev(struct mctp_dev *mdev)
 
 	ASSERT_RTNL();
 	list_for_each_entry_safe(rt, tmp, &net->mctp.routes, list) {
-		if (rt->dev == mdev) {
+		if (rt->dst_type == MCTP_ROUTE_DIRECT && rt->dev == mdev) {
 			list_del_rcu(&rt->list);
 			/* TODO: immediate RTM_DELROUTE */
 			mctp_route_release(rt);
@@ -1291,21 +1335,28 @@ static const struct nla_policy rta_mctp_policy[RTA_MAX + 1] = {
 	[RTA_DST]		= { .type = NLA_U8 },
 	[RTA_METRICS]		= { .type = NLA_NESTED },
 	[RTA_OIF]		= { .type = NLA_U32 },
+	[RTA_GATEWAY]		= NLA_POLICY_EXACT_LEN(sizeof(struct mctp_fq_addr)),
 };
 
 static const struct nla_policy rta_metrics_policy[RTAX_MAX + 1] = {
 	[RTAX_MTU]		= { .type = NLA_U32 },
 };
 
-/* base parsing; common to both _lookup and _populate variants */
+/* base parsing; common to both _lookup and _populate variants.
+ *
+ * For gateway routes (which have a RTA_GATEWAY, and no RTA_OIF), we populate
+ * *gatweayp. for direct routes (RTA_OIF, no RTA_GATEWAY), we populate *mdev.
+ */
 static int mctp_route_nlparse_common(struct net *net, struct nlmsghdr *nlh,
 				     struct netlink_ext_ack *extack,
 				     struct nlattr **tb, struct rtmsg **rtm,
 				     struct mctp_dev **mdev,
+				     struct mctp_fq_addr *gatewayp,
 				     mctp_eid_t *daddr_start)
 {
+	struct mctp_fq_addr *gateway = NULL;
+	unsigned int ifindex = 0;
 	struct net_device *dev;
-	unsigned int ifindex;
 	int rc;
 
 	rc = nlmsg_parse(nlh, sizeof(struct rtmsg), tb, RTA_MAX,
@@ -1321,11 +1372,44 @@ static int mctp_route_nlparse_common(struct net *net, struct nlmsghdr *nlh,
 	}
 	*daddr_start = nla_get_u8(tb[RTA_DST]);
 
-	if (!tb[RTA_OIF]) {
-		NL_SET_ERR_MSG(extack, "ifindex missing");
+	if (tb[RTA_OIF])
+		ifindex = nla_get_u32(tb[RTA_OIF]);
+
+	if (tb[RTA_GATEWAY])
+		gateway = nla_data(tb[RTA_GATEWAY]);
+
+	if (ifindex && gateway) {
+		NL_SET_ERR_MSG(extack,
+			       "cannot specify both ifindex and gateway");
+		return -EINVAL;
+
+	} else if (ifindex) {
+		dev = __dev_get_by_index(net, ifindex);
+		if (!dev) {
+			NL_SET_ERR_MSG(extack, "bad ifindex");
+			return -ENODEV;
+		}
+		*mdev = mctp_dev_get_rtnl(dev);
+		if (!*mdev)
+			return -ENODEV;
+		gatewayp->eid = 0;
+
+	} else if (gateway) {
+		if (!mctp_address_unicast(gateway->eid)) {
+			NL_SET_ERR_MSG(extack, "bad gateway");
+			return -EINVAL;
+		}
+
+		gatewayp->eid = gateway->eid;
+		gatewayp->net = gateway->net != MCTP_NET_ANY ?
+			gateway->net :
+			READ_ONCE(net->mctp.default_net);
+		*mdev = NULL;
+
+	} else {
+		NL_SET_ERR_MSG(extack, "no route output provided");
 		return -EINVAL;
 	}
-	ifindex = nla_get_u32(tb[RTA_OIF]);
 
 	*rtm = nlmsg_data(nlh);
 	if ((*rtm)->rtm_family != AF_MCTP) {
@@ -1338,16 +1422,6 @@ static int mctp_route_nlparse_common(struct net *net, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	dev = __dev_get_by_index(net, ifindex);
-	if (!dev) {
-		NL_SET_ERR_MSG(extack, "bad ifindex");
-		return -ENODEV;
-	}
-
-	*mdev = mctp_dev_get_rtnl(dev);
-	if (!*mdev)
-		return -ENODEV;
-
 	return 0;
 }
 
@@ -1361,16 +1435,25 @@ static int mctp_route_nlparse_lookup(struct net *net, struct nlmsghdr *nlh,
 				     unsigned int *daddr_extent)
 {
 	struct nlattr *tb[RTA_MAX + 1];
+	struct mctp_fq_addr gw;
 	struct mctp_dev *mdev;
 	struct rtmsg *rtm;
 	int rc;
 
 	rc = mctp_route_nlparse_common(net, nlh, extack, tb, &rtm,
-				       &mdev, daddr_start);
+				       &mdev, &gw, daddr_start);
 	if (rc)
 		return rc;
 
-	*netid = mdev->net;
+	if (mdev) {
+		*netid = mdev->net;
+	} else if (gw.eid) {
+		*netid = gw.net;
+	} else {
+		/* bug: _nlparse_common should not allow this */
+		return -1;
+	}
+
 	*type = rtm->rtm_type;
 	*daddr_extent = rtm->rtm_dst_len;
 
@@ -1385,11 +1468,13 @@ static int mctp_route_nlparse_populate(struct net *net, struct nlmsghdr *nlh,
 	struct nlattr *tbx[RTAX_MAX + 1];
 	struct nlattr *tb[RTA_MAX + 1];
 	unsigned int daddr_extent;
+	struct mctp_fq_addr gw;
+	struct mctp_dev *mdev;
 	struct rtmsg *rtm;
 	int rc;
 
 	rc = mctp_route_nlparse_common(net, nlh, extack, tb, &rtm,
-				       &rt->dev, &rt->min);
+				       &mdev, &gw, &rt->min);
 	if (rc)
 		return rc;
 
@@ -1400,6 +1485,15 @@ static int mctp_route_nlparse_populate(struct net *net, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
+	if (gw.eid) {
+		rt->dst_type = MCTP_ROUTE_GATEWAY;
+		rt->gateway.eid = gw.eid;
+		rt->gateway.net = gw.net;
+	} else {
+		rt->dst_type = MCTP_ROUTE_DIRECT;
+		rt->dev = mdev;
+	}
+
 	rt->type = rtm->rtm_type;
 	rt->max = rt->min + daddr_extent;
 	rt->mtu = 0;
@@ -1433,7 +1527,8 @@ static int mctp_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (rc < 0)
 		goto err_free;
 
-	mctp_dev_hold(rt->dev);
+	if (rt->dst_type == MCTP_ROUTE_DIRECT)
+		mctp_dev_hold(rt->dev);
 
 	rc = mctp_route_add(net, rt);
 	if (!rc)
@@ -1488,7 +1583,6 @@ static int mctp_fill_rtinfo(struct sk_buff *skb, struct mctp_route *rt,
 	hdr->rtm_tos = 0;
 	hdr->rtm_table = RT_TABLE_DEFAULT;
 	hdr->rtm_protocol = RTPROT_STATIC; /* everything is user-defined */
-	hdr->rtm_scope = RT_SCOPE_LINK; /* TODO: scope in mctp_route? */
 	hdr->rtm_type = rt->type;
 
 	if (nla_put_u8(skb, RTA_DST, rt->min))
@@ -1505,13 +1599,17 @@ static int mctp_fill_rtinfo(struct sk_buff *skb, struct mctp_route *rt,
 
 	nla_nest_end(skb, metrics);
 
-	if (rt->dev) {
+	if (rt->dst_type == MCTP_ROUTE_DIRECT) {
+		hdr->rtm_scope = RT_SCOPE_LINK;
 		if (nla_put_u32(skb, RTA_OIF, rt->dev->dev->ifindex))
 			goto cancel;
+	} else if (rt->dst_type == MCTP_ROUTE_GATEWAY) {
+		hdr->rtm_scope = RT_SCOPE_UNIVERSE;
+		if (nla_put(skb, RTA_GATEWAY,
+			    sizeof(rt->gateway), &rt->gateway))
+			goto cancel;
 	}
 
-	/* TODO: conditional neighbour physaddr? */
-
 	nlmsg_end(skb, nlh);
 
 	return 0;
diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index 6b4dc40d882c912575e28dfd8f2e730bf346885f..97b05e340586f69d8ba04c970b0ee88391db006a 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -134,6 +134,7 @@ struct mctp_test_route *mctp_test_create_route(struct net *net,
 	rt->rt.max = eid;
 	rt->rt.mtu = mtu;
 	rt->rt.type = RTN_UNSPEC;
+	rt->rt.dst_type = MCTP_ROUTE_DIRECT;
 	if (dev)
 		mctp_dev_hold(dev);
 	rt->rt.dev = dev;
@@ -176,7 +177,7 @@ void mctp_test_route_destroy(struct kunit *test, struct mctp_test_route *rt)
 	list_del_rcu(&rt->rt.list);
 	rtnl_unlock();
 
-	if (rt->rt.dev)
+	if (rt->rt.dst_type == MCTP_ROUTE_DIRECT && rt->rt.dev)
 		mctp_dev_put(rt->rt.dev);
 
 	refs = refcount_read(&rt->rt.refs);

-- 
2.39.5


