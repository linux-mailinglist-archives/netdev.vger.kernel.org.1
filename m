Return-Path: <netdev+bounces-196431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC3CAD4BC7
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3F13A650D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC65233128;
	Wed, 11 Jun 2025 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hJuANKE+"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35A22FDE7
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749623466; cv=none; b=agG/eyMFj2mQfszhG3VrQTWGLUzM2XRBJzUAMZRoPa/kTKlUbaN6roX+rV85GV0K5SV+rr0XZ4u9qgRN5wQ6cfaNDKeGv47PC47jdoek5/ozJXOetLbj15C5nSdG/nJ5JEhC8JcUC6wY00RJXt1HBnABzqH22FaUblPkwpzEia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749623466; c=relaxed/simple;
	bh=hYrJ7vDrgWxmOJMEAQCXQP1C5ZVZbefrJf68yrONIH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OxJO86EztktaMCQnJjytA6+AnPcjPJZdIe2SbzKkMsuOJokBJYckRrzHO/szU/Q5ys/geHw87/SNVu8NEh0s4trHC16ZwaRIlEhSGhEljPXD19ytEAT1/XvoxYWSAqN02bV2R5CzYyskF8z/xmGs91qjSZ7H6Qsjm2Qv69szfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hJuANKE+; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749623461;
	bh=qXz0E+SLRzZlKrmee3eJ0ElVlypKAmp8Rbf2bf5b/CA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hJuANKE+oJG+aHv4uTg5P5OHKVYjl/rI5BHTpBddFfrAV3EDdB4nyPNIHRJTsVwrj
	 QjUrQZGuqR8wlV/JMmAO3PN/Ytgwrht74ZlXeT9pjnv7M3Quzf7tJL6m4ols8l3CkU
	 fynnSu6QkxNRQIKOqXWirBCBU0CO6O2RTQCe93ZQiwG6HUBiyNdB3NXWfbByJjnV7m
	 jE5DKvfV7jB1PsF0Gy0g20FiAQIoi/lz8mJwAznBeSnLQoc8Gb3nFU7nawmhCqUy0A
	 9yZF+c2dMvjhR0TJkBgudiHW2cowt3x75fK4vGi8VtCD2NLGNgU4B0LnTy8jILHySn
	 DOAfN4Xv/Yv6g==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 08E8F67DEA; Wed, 11 Jun 2025 14:31:01 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 11 Jun 2025 14:30:38 +0800
Subject: [PATCH net-next 11/13] net: mctp: allow NL parsing directly into a
 struct mctp_route
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-dev-forwarding-v1-11-6b69b1feb37f@codeconstruct.com.au>
References: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
In-Reply-To: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

The netlink route parsing functions end up setting a bunch of output
variables from the rt attributes. This will get messy when the routes
become more complex.

So, split the rt parsing into two types: a lookup (returning route
target data suitable for a route lookup, like when deleting a route) and
a populate (setting fields of a struct mctp_route).

In doing this, we need to separate the route allocation from
mctp_route_add, so add some comments on the lifetime semantics for the
latter.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 194 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 130 insertions(+), 64 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 1731cabcc30780226d39e6e0716346f7acb5bd7e..ab5116c12b91461011c1ec3d9954609658a40a22 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1086,25 +1086,32 @@ static unsigned int mctp_route_netid(struct mctp_route *rt)
 }
 
 /* route management */
-static int mctp_route_add(struct net *net, struct mctp_dev *mdev,
-			  mctp_eid_t daddr_start, unsigned int daddr_extent,
-			  unsigned int mtu, unsigned char type)
+
+/* mctp_route_add(): Add the provided route, previously allocated via
+ * mctp_route_alloc(). On success, takes ownership of @rt, which includes a
+ * hold on rt->dev for usage in the route table. On failure a caller will want
+ * to mctp_route_release().
+ *
+ * We expect that the caller has set rt->type, rt->min, rt->max, rt->dev and
+ * rt->mtu, and that the route holds a reference to rt->dev (via mctp_dev_hold).
+ * Other fields will be populated.
+ */
+static int mctp_route_add(struct net *net, struct mctp_route *rt)
 {
-	int (*rtfn)(struct mctp_dst *dst, struct sk_buff *skb);
-	struct mctp_route *rt, *ert;
+	struct mctp_route *ert;
 
-	if (!mctp_address_unicast(daddr_start))
+	if (!mctp_address_unicast(rt->min) || !mctp_address_unicast(rt->max))
 		return -EINVAL;
 
-	if (daddr_extent > 0xff || daddr_start + daddr_extent >= 255)
+	if (!rt->dev)
 		return -EINVAL;
 
-	switch (type) {
+	switch (rt->type) {
 	case RTN_LOCAL:
-		rtfn = mctp_dst_input;
+		rt->output = mctp_dst_input;
 		break;
 	case RTN_UNICAST:
-		rtfn = mctp_dst_output;
+		rt->output = mctp_dst_output;
 		break;
 	default:
 		return -EINVAL;
@@ -1112,22 +1119,9 @@ static int mctp_route_add(struct net *net, struct mctp_dev *mdev,
 
 	ASSERT_RTNL();
 
-	rt = mctp_route_alloc();
-	if (!rt)
-		return -ENOMEM;
-
-	rt->min = daddr_start;
-	rt->max = daddr_start + daddr_extent;
-	rt->mtu = mtu;
-	rt->dev = mdev;
-	mctp_dev_hold(rt->dev);
-	rt->type = type;
-	rt->output = rtfn;
-
 	/* Prevent duplicate identical routes. */
 	list_for_each_entry(ert, &net->mctp.routes, list) {
 		if (mctp_rt_compare_exact(rt, ert)) {
-			mctp_route_release(rt);
 			return -EEXIST;
 		}
 	}
@@ -1169,7 +1163,25 @@ static int mctp_route_remove(struct net *net, unsigned int netid,
 
 int mctp_route_add_local(struct mctp_dev *mdev, mctp_eid_t addr)
 {
-	return mctp_route_add(dev_net(mdev->dev), mdev, addr, 0, 0, RTN_LOCAL);
+	struct mctp_route *rt;
+	int rc;
+
+	rt = mctp_route_alloc();
+	if (!rt)
+		return -ENOMEM;
+
+	rt->min = addr;
+	rt->max = addr;
+	rt->dev = mdev;
+	rt->type = RTN_LOCAL;
+
+	mctp_dev_hold(rt->dev);
+
+	rc = mctp_route_add(dev_net(mdev->dev), rt);
+	if (rc)
+		mctp_route_release(rt);
+
+	return rc;
 }
 
 int mctp_route_remove_local(struct mctp_dev *mdev, mctp_eid_t addr)
@@ -1281,13 +1293,16 @@ static const struct nla_policy rta_mctp_policy[RTA_MAX + 1] = {
 	[RTA_OIF]		= { .type = NLA_U32 },
 };
 
-/* Common part for RTM_NEWROUTE and RTM_DELROUTE parsing.
- * tb must hold RTA_MAX+1 elements.
- */
-static int mctp_route_nlparse(struct net *net, struct nlmsghdr *nlh,
-			      struct netlink_ext_ack *extack,
-			      struct nlattr **tb, struct rtmsg **rtm,
-			      struct mctp_dev **mdev, mctp_eid_t *daddr_start)
+static const struct nla_policy rta_metrics_policy[RTAX_MAX + 1] = {
+	[RTAX_MTU]		= { .type = NLA_U32 },
+};
+
+/* base parsing; common to both _lookup and _populate variants */
+static int mctp_route_nlparse_common(struct net *net, struct nlmsghdr *nlh,
+				     struct netlink_ext_ack *extack,
+				     struct nlattr **tb, struct rtmsg **rtm,
+				     struct mctp_dev **mdev,
+				     mctp_eid_t *daddr_start)
 {
 	struct net_device *dev;
 	unsigned int ifindex;
@@ -1318,61 +1333,114 @@ static int mctp_route_nlparse(struct net *net, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
+	if ((*rtm)->rtm_type != RTN_UNICAST) {
+		NL_SET_ERR_MSG(extack, "rtm_type must be RTN_UNICAST");
+		return -EINVAL;
+	}
+
 	dev = __dev_get_by_index(net, ifindex);
 	if (!dev) {
 		NL_SET_ERR_MSG(extack, "bad ifindex");
 		return -ENODEV;
 	}
+
 	*mdev = mctp_dev_get_rtnl(dev);
 	if (!*mdev)
 		return -ENODEV;
 
-	if (dev->flags & IFF_LOOPBACK) {
-		NL_SET_ERR_MSG(extack, "no routes to loopback");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-static const struct nla_policy rta_metrics_policy[RTAX_MAX + 1] = {
-	[RTAX_MTU]		= { .type = NLA_U32 },
-};
-
-static int mctp_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
-			 struct netlink_ext_ack *extack)
+/* Route parsing for lookup operations; we only need the "route target"
+ * components (ie., network and dest-EID range).
+ */
+static int mctp_route_nlparse_lookup(struct net *net, struct nlmsghdr *nlh,
+				     struct netlink_ext_ack *extack,
+				     unsigned char *type, unsigned int *netid,
+				     mctp_eid_t *daddr_start,
+				     unsigned int *daddr_extent)
 {
-	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[RTA_MAX + 1];
-	struct nlattr *tbx[RTAX_MAX + 1];
-	mctp_eid_t daddr_start;
 	struct mctp_dev *mdev;
 	struct rtmsg *rtm;
-	unsigned int mtu;
 	int rc;
 
-	rc = mctp_route_nlparse(net, nlh, extack, tb,
-				&rtm, &mdev, &daddr_start);
-	if (rc < 0)
+	rc = mctp_route_nlparse_common(net, nlh, extack, tb, &rtm,
+				       &mdev, daddr_start);
+	if (rc)
 		return rc;
 
-	if (rtm->rtm_type != RTN_UNICAST) {
-		NL_SET_ERR_MSG(extack, "rtm_type must be RTN_UNICAST");
+	*netid = mdev->net;
+	*type = rtm->rtm_type;
+	*daddr_extent = rtm->rtm_dst_len;
+
+	return 0;
+}
+
+/* Full route parse for RTM_NEWROUTE: populate @rt */
+static int mctp_route_nlparse_populate(struct net *net, struct nlmsghdr *nlh,
+				       struct netlink_ext_ack *extack,
+				       struct mctp_route *rt)
+{
+	struct nlattr *tbx[RTAX_MAX + 1];
+	struct nlattr *tb[RTA_MAX + 1];
+	unsigned int daddr_extent;
+	struct rtmsg *rtm;
+	int rc;
+
+	rc = mctp_route_nlparse_common(net, nlh, extack, tb, &rtm,
+				       &rt->dev, &rt->min);
+	if (rc)
+		return rc;
+
+	daddr_extent = rtm->rtm_dst_len;
+
+	if (daddr_extent > 0xff || daddr_extent + rt->min >= 255) {
+		NL_SET_ERR_MSG(extack, "invalid eid range");
 		return -EINVAL;
 	}
 
-	mtu = 0;
+	rt->type = rtm->rtm_type;
+	rt->max = rt->min + daddr_extent;
+	rt->mtu = 0;
+
 	if (tb[RTA_METRICS]) {
 		rc = nla_parse_nested(tbx, RTAX_MAX, tb[RTA_METRICS],
 				      rta_metrics_policy, NULL);
-		if (rc < 0)
+		if (rc < 0) {
+			NL_SET_ERR_MSG(extack, "incorrect RTA_METRICS format");
 			return rc;
+		}
 		if (tbx[RTAX_MTU])
-			mtu = nla_get_u32(tbx[RTAX_MTU]);
+			rt->mtu = nla_get_u32(tbx[RTAX_MTU]);
 	}
 
-	rc = mctp_route_add(net, mdev, daddr_start, rtm->rtm_dst_len, mtu,
-			    rtm->rtm_type);
+	return 0;
+}
+
+static int mctp_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
+			 struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct mctp_route *rt;
+	int rc;
+
+	rt = mctp_route_alloc();
+	if (!rt)
+		return -ENOMEM;
+
+	rc = mctp_route_nlparse_populate(net, nlh, extack, rt);
+	if (rc < 0)
+		goto err_free;
+
+	mctp_dev_hold(rt->dev);
+
+	rc = mctp_route_add(net, rt);
+	if (!rc)
+		return 0;
+
+err_free:
+	mctp_route_release(rt);
 	return rc;
 }
 
@@ -1380,23 +1448,21 @@ static int mctp_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 			 struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
-	struct nlattr *tb[RTA_MAX + 1];
+	unsigned int netid, daddr_extent;
 	mctp_eid_t daddr_start;
-	struct mctp_dev *mdev;
-	struct rtmsg *rtm;
+	unsigned char type;
 	int rc;
 
-	rc = mctp_route_nlparse(net, nlh, extack, tb,
-				&rtm, &mdev, &daddr_start);
+	rc = mctp_route_nlparse_lookup(net, nlh, extack, &type, &netid,
+				       &daddr_start, &daddr_extent);
 	if (rc < 0)
 		return rc;
 
 	/* we only have unicast routes */
-	if (rtm->rtm_type != RTN_UNICAST)
+	if (type != RTN_UNICAST)
 		return -EINVAL;
 
-	rc = mctp_route_remove(net, mdev->net, daddr_start, rtm->rtm_dst_len,
-			       RTN_UNICAST);
+	rc = mctp_route_remove(net, netid, daddr_start, daddr_extent, type);
 	return rc;
 }
 

-- 
2.39.5


