Return-Path: <netdev+bounces-200963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF2CAE78BD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540D11BC5CF9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6E521930A;
	Wed, 25 Jun 2025 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Mj4Se3Hq"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22FD2147F9
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836912; cv=none; b=hI9roAeT4T26S3s+3gnUDzCl5QOvIm67S5caol7bKh0x47jaDnft83/cgo1Q4z4kZ1lCTJ7CRu9CWT4kyJAVIO4Giv17UCc7jBWQJP5hg2Hcodz9ngW5xKp6IjkAZ2z9DQwTm2AOdjHfWpQQbzefWu8n6fiDFBx15sfEOBwAGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836912; c=relaxed/simple;
	bh=pHsy79o3NLEM2zTBUlZ0BCtqvWNfw+bhAO6UrQE+rRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WI2iN6qZ3pQJ3DVmoWAmzwnYiZ5eao03KIyy2wmDm2zQXutpz1aVxN/qXIyZBvNVpYOfuFlKbX+aZkQ2HCVOr/YVv9Y5PosiBnm2vave0tDXPXeE25MunGc2qjGuQvlXlR/LRo5jwvO8At3JE0VWAvn1Os/8PRvGxQ89nH+Q6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Mj4Se3Hq; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750836905;
	bh=DtTN6mEz/DA7G5GTX1h0WLK0Hbvt5Jn/ZqEhPkERDow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Mj4Se3Hq6nNokleHvCGiwMPPNORIl9IgBOseukgeD+eFC3tu4bLlkWqJngFyWpRXr
	 5bbBN7yAPdzoJ+brknTYOk33Gx8Fok1nwu8rjrI77O9HTlaJRf2VzglJLLxQ3vzsZz
	 3oMSObK4vFNv4O0tbLzBSa/l57erIGzVv19QHL4AazEIVU6TQvSyZJemxHDMn47s8L
	 U2YpcScEvkLpF2yERFM/CVHjQTuz2NinlF2fisug5HH3uOrCOVyopeNS2DRnvG5vzL
	 GATdAgB4Q9cb6Oh8S+WmbkDt8SZTKX30aV1Pw6JNTn9xh/fVb1QKObDVVVj5g1qVod
	 WpDrLEJIUl81w==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 61A5069A36; Wed, 25 Jun 2025 15:35:05 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 25 Jun 2025 15:34:41 +0800
Subject: [PATCH net-next v3 03/14] net: mctp: separate routing database
 from routing operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-dev-forwarding-v3-3-2061bd3013b3@codeconstruct.com.au>
References: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
In-Reply-To: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

This change adds a struct mctp_dst, representing the result of a routing
lookup. This decouples the struct mctp_route from the actual
implementation of a routing operation.

This will allow for future routing changes which may require more
involved lookup logic, such as gateway routing - which may require
multiple traversals of the routing table.

Since we only use the struct mctp_route at lookup time, we no longer
hold routes over a routing operation, as we only need it to populate the
dst. However, we do hold the dev while the dst is active.

This requires some changes to the route test infrastructure, as we no
longer have a mock route to handle the route output operation, and
transient dsts are created by the routing code, so we can't override
them as easily.

Instead, we use kunit->priv to stash a packet queue, and a custom
dst_output function queues into that packet queue, which we can use for
later expectations.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 include/net/mctp.h         |  35 +++++--
 net/mctp/af_mctp.c         |  59 ++++-------
 net/mctp/route.c           | 205 +++++++++++++++++++------------------
 net/mctp/test/route-test.c | 245 ++++++++++++++++++++++++++++-----------------
 4 files changed, 308 insertions(+), 236 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index 07d458990113d2bc2ca597e40152f3d30e41e5dd..6c9c5c48f59a1bf45f9c9d274a3ca2b633e96c75 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -222,6 +222,8 @@ struct mctp_flow {
 	struct mctp_sk_key *key;
 };
 
+struct mctp_dst;
+
 /* Route definition.
  *
  * These are held in the pernet->mctp.routes list, with RCU protection for
@@ -229,8 +231,7 @@ struct mctp_flow {
  * dropped on NETDEV_UNREGISTER events.
  *
  * Updates to the route table are performed under rtnl; all reads under RCU,
- * so routes cannot be referenced over a RCU grace period. Specifically: A
- * caller cannot block between mctp_route_lookup and mctp_route_release()
+ * so routes cannot be referenced over a RCU grace period.
  */
 struct mctp_route {
 	mctp_eid_t		min, max;
@@ -238,7 +239,7 @@ struct mctp_route {
 	unsigned char		type;
 	unsigned int		mtu;
 	struct mctp_dev		*dev;
-	int			(*output)(struct mctp_route *route,
+	int			(*output)(struct mctp_dst *dst,
 					  struct sk_buff *skb);
 
 	struct list_head	list;
@@ -246,12 +247,34 @@ struct mctp_route {
 	struct rcu_head		rcu;
 };
 
+/* Route lookup result: dst. Represents the results of a routing decision,
+ * but is only held over the individual routing operation.
+ *
+ * Will typically be stored on the caller stack, and must be released after
+ * usage.
+ */
+struct mctp_dst {
+	struct mctp_dev *dev;
+	unsigned int mtu;
+
+	/* set for direct addressing */
+	unsigned char halen;
+	unsigned char haddr[MAX_ADDR_LEN];
+
+	int (*output)(struct mctp_dst *dst, struct sk_buff *skb);
+};
+
+int mctp_dst_from_extaddr(struct mctp_dst *dst, struct net *net, int ifindex,
+			  unsigned char halen, const unsigned char *haddr);
+
 /* route interfaces */
-struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
-				     mctp_eid_t daddr);
+int mctp_route_lookup(struct net *net, unsigned int dnet,
+		      mctp_eid_t daddr, struct mctp_dst *dst);
+
+void mctp_dst_release(struct mctp_dst *dst);
 
 /* always takes ownership of skb */
-int mctp_local_output(struct sock *sk, struct mctp_route *rt,
+int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 		      struct sk_buff *skb, mctp_eid_t daddr, u8 req_tag);
 
 void mctp_key_unref(struct mctp_sk_key *key);
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 9b12ca97f412827c350fe7a03b7a6d365df74826..ca66521435b10c2299b82ed64718ddc98f1f07f3 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -97,8 +97,8 @@ static int mctp_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	struct sock *sk = sock->sk;
 	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
 	struct mctp_skb_cb *cb;
-	struct mctp_route *rt;
 	struct sk_buff *skb = NULL;
+	struct mctp_dst dst;
 	int hlen;
 
 	if (addr) {
@@ -133,34 +133,33 @@ static int mctp_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	if (msk->addr_ext && addrlen >= sizeof(struct sockaddr_mctp_ext)) {
 		DECLARE_SOCKADDR(struct sockaddr_mctp_ext *,
 				 extaddr, msg->msg_name);
-		struct net_device *dev;
-
-		rc = -EINVAL;
-		rcu_read_lock();
-		dev = dev_get_by_index_rcu(sock_net(sk), extaddr->smctp_ifindex);
-		/* check for correct halen */
-		if (dev && extaddr->smctp_halen == dev->addr_len) {
-			hlen = LL_RESERVED_SPACE(dev) + sizeof(struct mctp_hdr);
-			rc = 0;
+
+		if (!mctp_sockaddr_ext_is_ok(extaddr) ||
+		    extaddr->smctp_halen > sizeof(cb->haddr)) {
+			rc = -EINVAL;
+			goto err_free;
 		}
-		rcu_read_unlock();
+
+		rc = mctp_dst_from_extaddr(&dst, sock_net(sk),
+					   extaddr->smctp_ifindex,
+					   extaddr->smctp_halen,
+					   extaddr->smctp_haddr);
 		if (rc)
 			goto err_free;
-		rt = NULL;
+
 	} else {
-		rt = mctp_route_lookup(sock_net(sk), addr->smctp_network,
-				       addr->smctp_addr.s_addr);
-		if (!rt) {
-			rc = -EHOSTUNREACH;
+		rc = mctp_route_lookup(sock_net(sk), addr->smctp_network,
+				       addr->smctp_addr.s_addr, &dst);
+		if (rc)
 			goto err_free;
-		}
-		hlen = LL_RESERVED_SPACE(rt->dev->dev) + sizeof(struct mctp_hdr);
 	}
 
+	hlen = LL_RESERVED_SPACE(dst.dev->dev) + sizeof(struct mctp_hdr);
+
 	skb = sock_alloc_send_skb(sk, hlen + 1 + len,
 				  msg->msg_flags & MSG_DONTWAIT, &rc);
 	if (!skb)
-		return rc;
+		goto err_release_dst;
 
 	skb_reserve(skb, hlen);
 
@@ -175,30 +174,16 @@ static int mctp_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	cb = __mctp_cb(skb);
 	cb->net = addr->smctp_network;
 
-	if (!rt) {
-		/* fill extended address in cb */
-		DECLARE_SOCKADDR(struct sockaddr_mctp_ext *,
-				 extaddr, msg->msg_name);
-
-		if (!mctp_sockaddr_ext_is_ok(extaddr) ||
-		    extaddr->smctp_halen > sizeof(cb->haddr)) {
-			rc = -EINVAL;
-			goto err_free;
-		}
-
-		cb->ifindex = extaddr->smctp_ifindex;
-		/* smctp_halen is checked above */
-		cb->halen = extaddr->smctp_halen;
-		memcpy(cb->haddr, extaddr->smctp_haddr, cb->halen);
-	}
-
-	rc = mctp_local_output(sk, rt, skb, addr->smctp_addr.s_addr,
+	rc = mctp_local_output(sk, &dst, skb, addr->smctp_addr.s_addr,
 			       addr->smctp_tag);
 
+	mctp_dst_release(&dst);
 	return rc ? : len;
 
 err_free:
 	kfree_skb(skb);
+err_release_dst:
+	mctp_dst_release(&dst);
 	return rc;
 }
 
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 128ac46dda5eb882994960b8c0eb671007ad8583..e11bf1c1e383cc251c5b6e2852d3756f706956c7 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -32,7 +32,7 @@ static const unsigned long mctp_key_lifetime = 6 * CONFIG_HZ;
 static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev);
 
 /* route output callbacks */
-static int mctp_route_discard(struct mctp_route *route, struct sk_buff *skb)
+static int mctp_dst_discard(struct mctp_dst *dst, struct sk_buff *skb)
 {
 	kfree_skb(skb);
 	return 0;
@@ -368,7 +368,7 @@ static int mctp_frag_queue(struct mctp_sk_key *key, struct sk_buff *skb)
 	return 0;
 }
 
-static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
+static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 {
 	struct mctp_sk_key *key, *any_key = NULL;
 	struct net *net = dev_net(skb->dev);
@@ -559,24 +559,17 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	return rc;
 }
 
-static unsigned int mctp_route_mtu(struct mctp_route *rt)
-{
-	return rt->mtu ?: READ_ONCE(rt->dev->dev->mtu);
-}
-
-static int mctp_route_output(struct mctp_route *route, struct sk_buff *skb)
+static int mctp_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 {
 	struct mctp_skb_cb *cb = mctp_cb(skb);
 	struct mctp_hdr *hdr = mctp_hdr(skb);
 	char daddr_buf[MAX_ADDR_LEN];
 	char *daddr = NULL;
-	unsigned int mtu;
 	int rc;
 
 	skb->protocol = htons(ETH_P_MCTP);
 
-	mtu = READ_ONCE(skb->dev->mtu);
-	if (skb->len > mtu) {
+	if (skb->len > dst->mtu) {
 		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
@@ -598,7 +591,7 @@ static int mctp_route_output(struct mctp_route *route, struct sk_buff *skb)
 	} else {
 		skb->pkt_type = PACKET_OUTGOING;
 		/* If lookup fails let the device handle daddr==NULL */
-		if (mctp_neigh_lookup(route->dev, hdr->dest, daddr_buf) == 0)
+		if (mctp_neigh_lookup(dst->dev, hdr->dest, daddr_buf) == 0)
 			daddr = daddr_buf;
 	}
 
@@ -609,7 +602,7 @@ static int mctp_route_output(struct mctp_route *route, struct sk_buff *skb)
 		return -EHOSTUNREACH;
 	}
 
-	mctp_flow_prepare_output(skb, route->dev);
+	mctp_flow_prepare_output(skb, dst->dev);
 
 	rc = dev_queue_xmit(skb);
 	if (rc)
@@ -638,7 +631,7 @@ static struct mctp_route *mctp_route_alloc(void)
 
 	INIT_LIST_HEAD(&rt->list);
 	refcount_set(&rt->refs, 1);
-	rt->output = mctp_route_discard;
+	rt->output = mctp_dst_discard;
 
 	return rt;
 }
@@ -828,49 +821,101 @@ static bool mctp_rt_compare_exact(struct mctp_route *rt1,
 		rt1->max == rt2->max;
 }
 
-struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
-				     mctp_eid_t daddr)
+static void mctp_dst_from_route(struct mctp_dst *dst, struct mctp_route *route)
+{
+	mctp_dev_hold(route->dev);
+	dst->dev = route->dev;
+	dst->mtu = route->mtu ?: READ_ONCE(dst->dev->dev->mtu);
+	dst->halen = 0;
+	dst->output = route->output;
+}
+
+int mctp_dst_from_extaddr(struct mctp_dst *dst, struct net *net, int ifindex,
+			  unsigned char halen, const unsigned char *haddr)
 {
-	struct mctp_route *tmp, *rt = NULL;
+	struct net_device *netdev;
+	struct mctp_dev *dev;
+	int rc = -ENOENT;
+
+	if (halen > sizeof(dst->haddr))
+		return -EINVAL;
 
 	rcu_read_lock();
 
-	list_for_each_entry_rcu(tmp, &net->mctp.routes, list) {
+	netdev = dev_get_by_index_rcu(net, ifindex);
+	if (!netdev)
+		goto out_unlock;
+
+	dev = __mctp_dev_get(netdev);
+	if (!dev)
+		goto out_unlock;
+
+	dst->dev = dev;
+	dst->mtu = READ_ONCE(netdev->mtu);
+	dst->halen = halen;
+	dst->output = mctp_dst_output;
+	memcpy(dst->haddr, haddr, halen);
+
+	rc = 0;
+
+out_unlock:
+	rcu_read_unlock();
+	return rc;
+}
+
+void mctp_dst_release(struct mctp_dst *dst)
+{
+	mctp_dev_put(dst->dev);
+}
+
+/* populates *dst on successful lookup, if set */
+int mctp_route_lookup(struct net *net, unsigned int dnet,
+		      mctp_eid_t daddr, struct mctp_dst *dst)
+{
+	int rc = -EHOSTUNREACH;
+	struct mctp_route *rt;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(rt, &net->mctp.routes, list) {
 		/* TODO: add metrics */
-		if (mctp_rt_match_eid(tmp, dnet, daddr)) {
-			if (refcount_inc_not_zero(&tmp->refs)) {
-				rt = tmp;
-				break;
-			}
-		}
+		if (!mctp_rt_match_eid(rt, dnet, daddr))
+			continue;
+
+		if (dst)
+			mctp_dst_from_route(dst, rt);
+		rc = 0;
+		break;
 	}
 
 	rcu_read_unlock();
 
-	return rt;
+	return rc;
 }
 
-static struct mctp_route *mctp_route_lookup_null(struct net *net,
-						 struct net_device *dev)
+static int mctp_route_lookup_null(struct net *net, struct net_device *dev,
+				  struct mctp_dst *dst)
 {
-	struct mctp_route *tmp, *rt = NULL;
+	int rc = -EHOSTUNREACH;
+	struct mctp_route *rt;
 
 	rcu_read_lock();
 
-	list_for_each_entry_rcu(tmp, &net->mctp.routes, list) {
-		if (tmp->dev->dev == dev && tmp->type == RTN_LOCAL &&
-		    refcount_inc_not_zero(&tmp->refs)) {
-			rt = tmp;
-			break;
-		}
+	list_for_each_entry_rcu(rt, &net->mctp.routes, list) {
+		if (rt->dev->dev != dev || rt->type != RTN_LOCAL)
+			continue;
+
+		mctp_dst_from_route(dst, rt);
+		rc = 0;
+		break;
 	}
 
 	rcu_read_unlock();
 
-	return rt;
+	return rc;
 }
 
-static int mctp_do_fragment_route(struct mctp_route *rt, struct sk_buff *skb,
+static int mctp_do_fragment_route(struct mctp_dst *dst, struct sk_buff *skb,
 				  unsigned int mtu, u8 tag)
 {
 	const unsigned int hlen = sizeof(struct mctp_hdr);
@@ -943,7 +988,7 @@ static int mctp_do_fragment_route(struct mctp_route *rt, struct sk_buff *skb,
 		skb_ext_copy(skb2, skb);
 
 		/* do route */
-		rc = rt->output(rt, skb2);
+		rc = dst->output(dst, skb2);
 		if (rc)
 			break;
 
@@ -955,68 +1000,32 @@ static int mctp_do_fragment_route(struct mctp_route *rt, struct sk_buff *skb,
 	return rc;
 }
 
-int mctp_local_output(struct sock *sk, struct mctp_route *rt,
+int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 		      struct sk_buff *skb, mctp_eid_t daddr, u8 req_tag)
 {
 	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
 	struct mctp_skb_cb *cb = mctp_cb(skb);
-	struct mctp_route tmp_rt = {0};
 	struct mctp_sk_key *key;
 	struct mctp_hdr *hdr;
 	unsigned long flags;
 	unsigned int netid;
 	unsigned int mtu;
 	mctp_eid_t saddr;
-	bool ext_rt;
 	int rc;
 	u8 tag;
 
 	rc = -ENODEV;
 
-	if (rt) {
-		ext_rt = false;
-		if (WARN_ON(!rt->dev))
-			goto out_release;
-
-	} else if (cb->ifindex) {
-		struct net_device *dev;
-
-		ext_rt = true;
-		rt = &tmp_rt;
-
-		rcu_read_lock();
-		dev = dev_get_by_index_rcu(sock_net(sk), cb->ifindex);
-		if (!dev) {
-			rcu_read_unlock();
-			goto out_free;
-		}
-		rt->dev = __mctp_dev_get(dev);
-		rcu_read_unlock();
-
-		if (!rt->dev)
-			goto out_release;
-
-		/* establish temporary route - we set up enough to keep
-		 * mctp_route_output happy
-		 */
-		rt->output = mctp_route_output;
-		rt->mtu = 0;
-
-	} else {
-		rc = -EINVAL;
-		goto out_free;
-	}
-
-	spin_lock_irqsave(&rt->dev->addrs_lock, flags);
-	if (rt->dev->num_addrs == 0) {
+	spin_lock_irqsave(&dst->dev->addrs_lock, flags);
+	if (dst->dev->num_addrs == 0) {
 		rc = -EHOSTUNREACH;
 	} else {
 		/* use the outbound interface's first address as our source */
-		saddr = rt->dev->addrs[0];
+		saddr = dst->dev->addrs[0];
 		rc = 0;
 	}
-	spin_unlock_irqrestore(&rt->dev->addrs_lock, flags);
-	netid = READ_ONCE(rt->dev->net);
+	spin_unlock_irqrestore(&dst->dev->addrs_lock, flags);
+	netid = READ_ONCE(dst->dev->net);
 
 	if (rc)
 		goto out_release;
@@ -1048,7 +1057,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 	skb_reset_transport_header(skb);
 	skb_push(skb, sizeof(struct mctp_hdr));
 	skb_reset_network_header(skb);
-	skb->dev = rt->dev->dev;
+	skb->dev = dst->dev->dev;
 
 	/* cb->net will have been set on initial ingress */
 	cb->src = saddr;
@@ -1059,26 +1068,20 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 	hdr->dest = daddr;
 	hdr->src = saddr;
 
-	mtu = mctp_route_mtu(rt);
+	mtu = dst->mtu;
 
 	if (skb->len + sizeof(struct mctp_hdr) <= mtu) {
 		hdr->flags_seq_tag = MCTP_HDR_FLAG_SOM |
 			MCTP_HDR_FLAG_EOM | tag;
-		rc = rt->output(rt, skb);
+		rc = dst->output(dst, skb);
 	} else {
-		rc = mctp_do_fragment_route(rt, skb, mtu, tag);
+		rc = mctp_do_fragment_route(dst, skb, mtu, tag);
 	}
 
 	/* route output functions consume the skb, even on error */
 	skb = NULL;
 
 out_release:
-	if (!ext_rt)
-		mctp_route_release(rt);
-
-	mctp_dev_put(tmp_rt.dev);
-
-out_free:
 	kfree_skb(skb);
 	return rc;
 }
@@ -1088,7 +1091,7 @@ static int mctp_route_add(struct mctp_dev *mdev, mctp_eid_t daddr_start,
 			  unsigned int daddr_extent, unsigned int mtu,
 			  unsigned char type)
 {
-	int (*rtfn)(struct mctp_route *rt, struct sk_buff *skb);
+	int (*rtfn)(struct mctp_dst *dst, struct sk_buff *skb);
 	struct net *net = dev_net(mdev->dev);
 	struct mctp_route *rt, *ert;
 
@@ -1100,15 +1103,17 @@ static int mctp_route_add(struct mctp_dev *mdev, mctp_eid_t daddr_start,
 
 	switch (type) {
 	case RTN_LOCAL:
-		rtfn = mctp_route_input;
+		rtfn = mctp_dst_input;
 		break;
 	case RTN_UNICAST:
-		rtfn = mctp_route_output;
+		rtfn = mctp_dst_output;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	ASSERT_RTNL();
+
 	rt = mctp_route_alloc();
 	if (!rt)
 		return -ENOMEM;
@@ -1121,7 +1126,6 @@ static int mctp_route_add(struct mctp_dev *mdev, mctp_eid_t daddr_start,
 	rt->type = type;
 	rt->output = rtfn;
 
-	ASSERT_RTNL();
 	/* Prevent duplicate identical routes. */
 	list_for_each_entry(ert, &net->mctp.routes, list) {
 		if (mctp_rt_compare_exact(rt, ert)) {
@@ -1200,8 +1204,9 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 	struct net *net = dev_net(dev);
 	struct mctp_dev *mdev;
 	struct mctp_skb_cb *cb;
-	struct mctp_route *rt;
+	struct mctp_dst dst;
 	struct mctp_hdr *mh;
+	int rc;
 
 	rcu_read_lock();
 	mdev = __mctp_dev_get(dev);
@@ -1243,17 +1248,17 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 	cb->net = READ_ONCE(mdev->net);
 	cb->ifindex = dev->ifindex;
 
-	rt = mctp_route_lookup(net, cb->net, mh->dest);
+	rc = mctp_route_lookup(net, cb->net, mh->dest, &dst);
 
 	/* NULL EID, but addressed to our physical address */
-	if (!rt && mh->dest == MCTP_ADDR_NULL && skb->pkt_type == PACKET_HOST)
-		rt = mctp_route_lookup_null(net, dev);
+	if (rc && mh->dest == MCTP_ADDR_NULL && skb->pkt_type == PACKET_HOST)
+		rc = mctp_route_lookup_null(net, dev, &dst);
 
-	if (!rt)
+	if (rc)
 		goto err_drop;
 
-	rt->output(rt, skb);
-	mctp_route_release(rt);
+	dst.output(&dst, skb);
+	mctp_dst_release(&dst);
 	mctp_dev_put(mdev);
 
 	return NET_RX_SUCCESS;
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 41c9644704a5dc6237b3820fde3816f2480b5473..e611cf0969d42eea3d01651b4aeed525ebde70c6 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -2,18 +2,37 @@
 
 #include <kunit/test.h>
 
+/* keep clangd happy when compiled outside of the route.c include */
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+
 #include "utils.h"
 
 struct mctp_test_route {
 	struct mctp_route	rt;
-	struct sk_buff_head	pkts;
 };
 
-static int mctp_test_route_output(struct mctp_route *rt, struct sk_buff *skb)
+static const unsigned int test_pktqueue_magic = 0x5f713aef;
+
+struct mctp_test_pktqueue {
+	unsigned int magic;
+	struct sk_buff_head pkts;
+};
+
+static void mctp_test_pktqueue_init(struct mctp_test_pktqueue *tpq)
+{
+	tpq->magic = test_pktqueue_magic;
+	skb_queue_head_init(&tpq->pkts);
+}
+
+static int mctp_test_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 {
-	struct mctp_test_route *test_rt = container_of(rt, struct mctp_test_route, rt);
+	struct kunit *test = current->kunit_test;
+	struct mctp_test_pktqueue *tpq = test->priv;
+
+	KUNIT_ASSERT_EQ(test, tpq->magic, test_pktqueue_magic);
 
-	skb_queue_tail(&test_rt->pkts, skb);
+	skb_queue_tail(&tpq->pkts, skb);
 
 	return 0;
 }
@@ -29,9 +48,7 @@ static struct mctp_test_route *mctp_route_test_alloc(void)
 
 	INIT_LIST_HEAD(&rt->rt.list);
 	refcount_set(&rt->rt.refs, 1);
-	rt->rt.output = mctp_test_route_output;
-
-	skb_queue_head_init(&rt->pkts);
+	rt->rt.output = mctp_test_dst_output;
 
 	return rt;
 }
@@ -60,6 +77,32 @@ static struct mctp_test_route *mctp_test_create_route(struct net *net,
 	return rt;
 }
 
+/* Convenience function for our test dst; release with mctp_test_dst_release()
+ */
+static void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
+				struct mctp_test_dev *dev,
+				struct mctp_test_pktqueue *tpq,
+				unsigned int mtu)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
+
+	memset(dst, 0, sizeof(*dst));
+
+	dst->dev = dev->mdev;
+	__mctp_dev_get(dst->dev->dev);
+	dst->mtu = mtu;
+	dst->output = mctp_test_dst_output;
+	mctp_test_pktqueue_init(tpq);
+	test->priv = tpq;
+}
+
+static void mctp_test_dst_release(struct mctp_dst *dst,
+				  struct mctp_test_pktqueue *tpq)
+{
+	mctp_dst_release(dst);
+	skb_queue_purge(&tpq->pkts);
+}
+
 static void mctp_test_route_destroy(struct kunit *test,
 				    struct mctp_test_route *rt)
 {
@@ -69,7 +112,6 @@ static void mctp_test_route_destroy(struct kunit *test,
 	list_del_rcu(&rt->rt.list);
 	rtnl_unlock();
 
-	skb_queue_purge(&rt->pkts);
 	if (rt->rt.dev)
 		mctp_dev_put(rt->rt.dev);
 
@@ -141,8 +183,10 @@ struct mctp_frag_test {
 static void mctp_test_fragment(struct kunit *test)
 {
 	const struct mctp_frag_test *params;
+	struct mctp_test_pktqueue tpq;
 	int rc, i, n, mtu, msgsize;
-	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct mctp_dst dst;
 	struct sk_buff *skb;
 	struct mctp_hdr hdr;
 	u8 seq;
@@ -159,13 +203,15 @@ static void mctp_test_fragment(struct kunit *test)
 	skb = mctp_test_create_skb(&hdr, msgsize);
 	KUNIT_ASSERT_TRUE(test, skb);
 
-	rt = mctp_test_create_route(&init_net, NULL, 10, mtu);
-	KUNIT_ASSERT_TRUE(test, rt);
+	dev = mctp_test_create_dev();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	mctp_test_dst_setup(test, &dst, dev, &tpq, mtu);
 
-	rc = mctp_do_fragment_route(&rt->rt, skb, mtu, MCTP_TAG_OWNER);
+	rc = mctp_do_fragment_route(&dst, skb, mtu, MCTP_TAG_OWNER);
 	KUNIT_EXPECT_FALSE(test, rc);
 
-	n = rt->pkts.qlen;
+	n = tpq.pkts.qlen;
 
 	KUNIT_EXPECT_EQ(test, n, params->n_frags);
 
@@ -178,7 +224,7 @@ static void mctp_test_fragment(struct kunit *test)
 		first = i == 0;
 		last = i == (n - 1);
 
-		skb2 = skb_dequeue(&rt->pkts);
+		skb2 = skb_dequeue(&tpq.pkts);
 
 		if (!skb2)
 			break;
@@ -216,7 +262,8 @@ static void mctp_test_fragment(struct kunit *test)
 		kfree_skb(skb2);
 	}
 
-	mctp_test_route_destroy(test, rt);
+	mctp_test_dst_release(&dst, &tpq);
+	mctp_test_destroy_dev(dev);
 }
 
 static const struct mctp_frag_test mctp_frag_tests[] = {
@@ -246,11 +293,13 @@ struct mctp_rx_input_test {
 static void mctp_test_rx_input(struct kunit *test)
 {
 	const struct mctp_rx_input_test *params;
+	struct mctp_test_pktqueue tpq;
 	struct mctp_test_route *rt;
 	struct mctp_test_dev *dev;
 	struct sk_buff *skb;
 
 	params = test->param_value;
+	test->priv = &tpq;
 
 	dev = mctp_test_create_dev();
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
@@ -261,10 +310,13 @@ static void mctp_test_rx_input(struct kunit *test)
 	skb = mctp_test_create_skb(&params->hdr, 1);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
 
+	mctp_test_pktqueue_init(&tpq);
+
 	mctp_pkttype_receive(skb, dev->ndev, &mctp_packet_type, NULL);
 
-	KUNIT_EXPECT_EQ(test, !!rt->pkts.qlen, params->input);
+	KUNIT_EXPECT_EQ(test, !!tpq.pkts.qlen, params->input);
 
+	skb_queue_purge(&tpq.pkts);
 	mctp_test_route_destroy(test, rt);
 	mctp_test_destroy_dev(dev);
 }
@@ -292,12 +344,12 @@ KUNIT_ARRAY_PARAM(mctp_rx_input, mctp_rx_input_tests,
 /* set up a local dev, route on EID 8, and a socket listening on type 0 */
 static void __mctp_route_test_init(struct kunit *test,
 				   struct mctp_test_dev **devp,
-				   struct mctp_test_route **rtp,
+				   struct mctp_dst *dst,
+				   struct mctp_test_pktqueue *tpq,
 				   struct socket **sockp,
 				   unsigned int netid)
 {
 	struct sockaddr_mctp addr = {0};
-	struct mctp_test_route *rt;
 	struct mctp_test_dev *dev;
 	struct socket *sock;
 	int rc;
@@ -307,8 +359,7 @@ static void __mctp_route_test_init(struct kunit *test,
 	if (netid != MCTP_NET_ANY)
 		WRITE_ONCE(dev->mdev->net, netid);
 
-	rt = mctp_test_create_route(&init_net, dev->mdev, 8, 68);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
+	mctp_test_dst_setup(test, dst, dev, tpq, 68);
 
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
@@ -320,18 +371,18 @@ static void __mctp_route_test_init(struct kunit *test,
 	rc = kernel_bind(sock, (struct sockaddr *)&addr, sizeof(addr));
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
-	*rtp = rt;
 	*devp = dev;
 	*sockp = sock;
 }
 
 static void __mctp_route_test_fini(struct kunit *test,
 				   struct mctp_test_dev *dev,
-				   struct mctp_test_route *rt,
+				   struct mctp_dst *dst,
+				   struct mctp_test_pktqueue *tpq,
 				   struct socket *sock)
 {
 	sock_release(sock);
-	mctp_test_route_destroy(test, rt);
+	mctp_test_dst_release(dst, tpq);
 	mctp_test_destroy_dev(dev);
 }
 
@@ -344,22 +395,24 @@ struct mctp_route_input_sk_test {
 static void mctp_test_route_input_sk(struct kunit *test)
 {
 	const struct mctp_route_input_sk_test *params;
+	struct mctp_test_pktqueue tpq;
 	struct sk_buff *skb, *skb2;
-	struct mctp_test_route *rt;
 	struct mctp_test_dev *dev;
+	struct mctp_dst dst;
 	struct socket *sock;
 	int rc;
 
 	params = test->param_value;
 
-	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
 
 	skb = mctp_test_create_skb_data(&params->hdr, &params->type);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
 
 	mctp_test_skb_set_dev(skb, dev);
+	mctp_test_pktqueue_init(&tpq);
 
-	rc = mctp_route_input(&rt->rt, skb);
+	rc = mctp_dst_input(&dst, skb);
 
 	if (params->deliver) {
 		KUNIT_EXPECT_EQ(test, rc, 0);
@@ -376,7 +429,7 @@ static void mctp_test_route_input_sk(struct kunit *test)
 		KUNIT_EXPECT_NULL(test, skb2);
 	}
 
-	__mctp_route_test_fini(test, dev, rt, sock);
+	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
 }
 
 #define FL_S	(MCTP_HDR_FLAG_SOM)
@@ -413,16 +466,17 @@ struct mctp_route_input_sk_reasm_test {
 static void mctp_test_route_input_sk_reasm(struct kunit *test)
 {
 	const struct mctp_route_input_sk_reasm_test *params;
+	struct mctp_test_pktqueue tpq;
 	struct sk_buff *skb, *skb2;
-	struct mctp_test_route *rt;
 	struct mctp_test_dev *dev;
+	struct mctp_dst dst;
 	struct socket *sock;
 	int i, rc;
 	u8 c;
 
 	params = test->param_value;
 
-	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
 
 	for (i = 0; i < params->n_hdrs; i++) {
 		c = i;
@@ -431,7 +485,7 @@ static void mctp_test_route_input_sk_reasm(struct kunit *test)
 
 		mctp_test_skb_set_dev(skb, dev);
 
-		rc = mctp_route_input(&rt->rt, skb);
+		rc = mctp_dst_input(&dst, skb);
 	}
 
 	skb2 = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
@@ -445,7 +499,7 @@ static void mctp_test_route_input_sk_reasm(struct kunit *test)
 		KUNIT_EXPECT_NULL(test, skb2);
 	}
 
-	__mctp_route_test_fini(test, dev, rt, sock);
+	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
 }
 
 #define RX_FRAG(f, s) RX_HDR(1, 10, 8, FL_TO | (f) | ((s) << MCTP_HDR_SEQ_SHIFT))
@@ -547,7 +601,7 @@ struct mctp_route_input_sk_keys_test {
 static void mctp_test_route_input_sk_keys(struct kunit *test)
 {
 	const struct mctp_route_input_sk_keys_test *params;
-	struct mctp_test_route *rt;
+	struct mctp_test_pktqueue tpq;
 	struct sk_buff *skb, *skb2;
 	struct mctp_test_dev *dev;
 	struct mctp_sk_key *key;
@@ -555,6 +609,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 	struct mctp_sock *msk;
 	struct socket *sock;
 	unsigned long flags;
+	struct mctp_dst dst;
 	unsigned int net;
 	int rc;
 	u8 c;
@@ -565,8 +620,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 	net = READ_ONCE(dev->mdev->net);
 
-	rt = mctp_test_create_route(&init_net, dev->mdev, 8, 68);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
+	mctp_test_dst_setup(test, &dst, dev, &tpq, 68);
 
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
@@ -592,7 +646,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 
 	mctp_test_skb_set_dev(skb, dev);
 
-	rc = mctp_route_input(&rt->rt, skb);
+	rc = mctp_dst_input(&dst, skb);
 
 	/* (potentially) receive message */
 	skb2 = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
@@ -606,7 +660,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 		skb_free_datagram(sock->sk, skb2);
 
 	mctp_key_unref(key);
-	__mctp_route_test_fini(test, dev, rt, sock);
+	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
 }
 
 static const struct mctp_route_input_sk_keys_test mctp_route_input_sk_keys_tests[] = {
@@ -681,7 +735,8 @@ KUNIT_ARRAY_PARAM(mctp_route_input_sk_keys, mctp_route_input_sk_keys_tests,
 struct test_net {
 	unsigned int netid;
 	struct mctp_test_dev *dev;
-	struct mctp_test_route *rt;
+	struct mctp_test_pktqueue tpq;
+	struct mctp_dst dst;
 	struct socket *sock;
 	struct sk_buff *skb;
 	struct mctp_sk_key *key;
@@ -699,18 +754,20 @@ mctp_test_route_input_multiple_nets_bind_init(struct kunit *test,
 
 	t->msg.data = t->netid;
 
-	__mctp_route_test_init(test, &t->dev, &t->rt, &t->sock, t->netid);
+	__mctp_route_test_init(test, &t->dev, &t->dst, &t->tpq, &t->sock,
+			       t->netid);
 
 	t->skb = mctp_test_create_skb_data(&hdr, &t->msg);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t->skb);
 	mctp_test_skb_set_dev(t->skb, t->dev);
+	mctp_test_pktqueue_init(&t->tpq);
 }
 
 static void
 mctp_test_route_input_multiple_nets_bind_fini(struct kunit *test,
 					      struct test_net *t)
 {
-	__mctp_route_test_fini(test, t->dev, t->rt, t->sock);
+	__mctp_route_test_fini(test, t->dev, &t->dst, &t->tpq, t->sock);
 }
 
 /* Test that skbs from different nets (otherwise identical) get routed to their
@@ -731,9 +788,9 @@ static void mctp_test_route_input_multiple_nets_bind(struct kunit *test)
 	mctp_test_route_input_multiple_nets_bind_init(test, &t1);
 	mctp_test_route_input_multiple_nets_bind_init(test, &t2);
 
-	rc = mctp_route_input(&t1.rt->rt, t1.skb);
+	rc = mctp_dst_input(&t1.dst, t1.skb);
 	KUNIT_ASSERT_EQ(test, rc, 0);
-	rc = mctp_route_input(&t2.rt->rt, t2.skb);
+	rc = mctp_dst_input(&t2.dst, t2.skb);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	rx_skb1 = skb_recv_datagram(t1.sock->sk, MSG_DONTWAIT, &rc);
@@ -767,7 +824,8 @@ mctp_test_route_input_multiple_nets_key_init(struct kunit *test,
 
 	t->msg.data = t->netid;
 
-	__mctp_route_test_init(test, &t->dev, &t->rt, &t->sock, t->netid);
+	__mctp_route_test_init(test, &t->dev, &t->dst, &t->tpq, &t->sock,
+			       t->netid);
 
 	msk = container_of(t->sock->sk, struct mctp_sock, sk);
 
@@ -790,7 +848,7 @@ mctp_test_route_input_multiple_nets_key_fini(struct kunit *test,
 					     struct test_net *t)
 {
 	mctp_key_unref(t->key);
-	__mctp_route_test_fini(test, t->dev, t->rt, t->sock);
+	__mctp_route_test_fini(test, t->dev, &t->dst, &t->tpq, t->sock);
 }
 
 /* test that skbs from different nets (otherwise identical) get routed to their
@@ -812,9 +870,9 @@ static void mctp_test_route_input_multiple_nets_key(struct kunit *test)
 	mctp_test_route_input_multiple_nets_key_init(test, &t1);
 	mctp_test_route_input_multiple_nets_key_init(test, &t2);
 
-	rc = mctp_route_input(&t1.rt->rt, t1.skb);
+	rc = mctp_dst_input(&t1.dst, t1.skb);
 	KUNIT_ASSERT_EQ(test, rc, 0);
-	rc = mctp_route_input(&t2.rt->rt, t2.skb);
+	rc = mctp_dst_input(&t2.dst, t2.skb);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	rx_skb1 = skb_recv_datagram(t1.sock->sk, MSG_DONTWAIT, &rc);
@@ -843,13 +901,14 @@ static void mctp_test_route_input_multiple_nets_key(struct kunit *test)
 static void mctp_test_route_input_sk_fail_single(struct kunit *test)
 {
 	const struct mctp_hdr hdr = RX_HDR(1, 10, 8, FL_S | FL_E | FL_TO);
-	struct mctp_test_route *rt;
+	struct mctp_test_pktqueue tpq;
 	struct mctp_test_dev *dev;
+	struct mctp_dst dst;
 	struct socket *sock;
 	struct sk_buff *skb;
 	int rc;
 
-	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
 
 	/* No rcvbuf space, so delivery should fail. __sock_set_rcvbuf will
 	 * clamp the minimum to SOCK_MIN_RCVBUF, so we open-code this.
@@ -865,14 +924,14 @@ static void mctp_test_route_input_sk_fail_single(struct kunit *test)
 	mctp_test_skb_set_dev(skb, dev);
 
 	/* do route input, which should fail */
-	rc = mctp_route_input(&rt->rt, skb);
+	rc = mctp_dst_input(&dst, skb);
 	KUNIT_EXPECT_NE(test, rc, 0);
 
 	/* we should hold the only reference to skb */
 	KUNIT_EXPECT_EQ(test, refcount_read(&skb->users), 1);
 	kfree_skb(skb);
 
-	__mctp_route_test_fini(test, dev, rt, sock);
+	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
 }
 
 /* Input route to socket, using a fragmented message, where sock delivery fails.
@@ -880,14 +939,15 @@ static void mctp_test_route_input_sk_fail_single(struct kunit *test)
 static void mctp_test_route_input_sk_fail_frag(struct kunit *test)
 {
 	const struct mctp_hdr hdrs[2] = { RX_FRAG(FL_S, 0), RX_FRAG(FL_E, 1) };
-	struct mctp_test_route *rt;
+	struct mctp_test_pktqueue tpq;
 	struct mctp_test_dev *dev;
 	struct sk_buff *skbs[2];
+	struct mctp_dst dst;
 	struct socket *sock;
 	unsigned int i;
 	int rc;
 
-	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
 
 	lock_sock(sock->sk);
 	WRITE_ONCE(sock->sk->sk_rcvbuf, 0);
@@ -904,11 +964,11 @@ static void mctp_test_route_input_sk_fail_frag(struct kunit *test)
 	/* first route input should succeed, we're only queueing to the
 	 * frag list
 	 */
-	rc = mctp_route_input(&rt->rt, skbs[0]);
+	rc = mctp_dst_input(&dst, skbs[0]);
 	KUNIT_EXPECT_EQ(test, rc, 0);
 
 	/* final route input should fail to deliver to the socket */
-	rc = mctp_route_input(&rt->rt, skbs[1]);
+	rc = mctp_dst_input(&dst, skbs[1]);
 	KUNIT_EXPECT_NE(test, rc, 0);
 
 	/* we should hold the only reference to both skbs */
@@ -918,7 +978,7 @@ static void mctp_test_route_input_sk_fail_frag(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, refcount_read(&skbs[1]->users), 1);
 	kfree_skb(skbs[1]);
 
-	__mctp_route_test_fini(test, dev, rt, sock);
+	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
 }
 
 /* Input route to socket, using a fragmented message created from clones.
@@ -936,10 +996,11 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 	const size_t data_len = 3; /* arbitrary */
 	u8 compare[data_len * ARRAY_SIZE(hdrs)];
 	u8 flat[data_len * ARRAY_SIZE(hdrs)];
-	struct mctp_test_route *rt;
+	struct mctp_test_pktqueue tpq;
 	struct mctp_test_dev *dev;
 	struct sk_buff *skb[5];
 	struct sk_buff *rx_skb;
+	struct mctp_dst dst;
 	struct socket *sock;
 	size_t total;
 	void *p;
@@ -947,7 +1008,7 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 
 	total = data_len + sizeof(struct mctp_hdr);
 
-	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
 
 	/* Create a single skb initially with concatenated packets */
 	skb[0] = mctp_test_create_skb(&hdrs[0], 5 * total);
@@ -986,7 +1047,7 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 
 	/* Feed the fragments into MCTP core */
 	for (int i = 0; i < 5; i++) {
-		rc = mctp_route_input(&rt->rt, skb[i]);
+		rc = mctp_dst_input(&dst, skb[i]);
 		KUNIT_EXPECT_EQ(test, rc, 0);
 	}
 
@@ -1024,29 +1085,29 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 		kfree_skb(skb[i]);
 	}
 
-	__mctp_route_test_fini(test, dev, rt, sock);
+	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
 }
 
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 
 static void mctp_test_flow_init(struct kunit *test,
 				struct mctp_test_dev **devp,
-				struct mctp_test_route **rtp,
+				struct mctp_dst *dst,
+				struct mctp_test_pktqueue *tpq,
 				struct socket **sock,
 				struct sk_buff **skbp,
 				unsigned int len)
 {
-	struct mctp_test_route *rt;
 	struct mctp_test_dev *dev;
 	struct sk_buff *skb;
 
 	/* we have a slightly odd routing setup here; the test route
 	 * is for EID 8, which is our local EID. We don't do a routing
 	 * lookup, so that's fine - all we require is a path through
-	 * mctp_local_output, which will call rt->output on whatever
+	 * mctp_local_output, which will call dst->output on whatever
 	 * route we provide
 	 */
-	__mctp_route_test_init(test, &dev, &rt, sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, dst, tpq, sock, MCTP_NET_ANY);
 
 	/* Assign a single EID. ->addrs is freed on mctp netdev release */
 	dev->mdev->addrs = kmalloc(sizeof(u8), GFP_KERNEL);
@@ -1059,42 +1120,41 @@ static void mctp_test_flow_init(struct kunit *test,
 	skb_reserve(skb, sizeof(struct mctp_hdr) + 1);
 	memset(skb_put(skb, len), 0, len);
 
-	/* take a ref for the route, we'll decrement in local output */
-	refcount_inc(&rt->rt.refs);
 
 	*devp = dev;
-	*rtp = rt;
 	*skbp = skb;
 }
 
 static void mctp_test_flow_fini(struct kunit *test,
 				struct mctp_test_dev *dev,
-				struct mctp_test_route *rt,
+				struct mctp_dst *dst,
+				struct mctp_test_pktqueue *tpq,
 				struct socket *sock)
 {
-	__mctp_route_test_fini(test, dev, rt, sock);
+	__mctp_route_test_fini(test, dev, dst, tpq, sock);
 }
 
 /* test that an outgoing skb has the correct MCTP extension data set */
 static void mctp_test_packet_flow(struct kunit *test)
 {
+	struct mctp_test_pktqueue tpq;
 	struct sk_buff *skb, *skb2;
-	struct mctp_test_route *rt;
 	struct mctp_test_dev *dev;
+	struct mctp_dst dst;
 	struct mctp_flow *flow;
 	struct socket *sock;
-	u8 dst = 8;
+	u8 dst_eid = 8;
 	int n, rc;
 
-	mctp_test_flow_init(test, &dev, &rt, &sock, &skb, 30);
+	mctp_test_flow_init(test, &dev, &dst, &tpq, &sock, &skb, 30);
 
-	rc = mctp_local_output(sock->sk, &rt->rt, skb, dst, MCTP_TAG_OWNER);
+	rc = mctp_local_output(sock->sk, &dst, skb, dst_eid, MCTP_TAG_OWNER);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
-	n = rt->pkts.qlen;
+	n = tpq.pkts.qlen;
 	KUNIT_ASSERT_EQ(test, n, 1);
 
-	skb2 = skb_dequeue(&rt->pkts);
+	skb2 = skb_dequeue(&tpq.pkts);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb2);
 
 	flow = skb_ext_find(skb2, SKB_EXT_MCTP);
@@ -1103,7 +1163,7 @@ static void mctp_test_packet_flow(struct kunit *test)
 	KUNIT_ASSERT_PTR_EQ(test, flow->key->sk, sock->sk);
 
 	kfree_skb(skb2);
-	mctp_test_flow_fini(test, dev, rt, sock);
+	mctp_test_flow_fini(test, dev, &dst, &tpq, sock);
 }
 
 /* test that outgoing skbs, after fragmentation, all have the correct MCTP
@@ -1111,26 +1171,27 @@ static void mctp_test_packet_flow(struct kunit *test)
  */
 static void mctp_test_fragment_flow(struct kunit *test)
 {
+	struct mctp_test_pktqueue tpq;
 	struct mctp_flow *flows[2];
 	struct sk_buff *tx_skbs[2];
-	struct mctp_test_route *rt;
 	struct mctp_test_dev *dev;
+	struct mctp_dst dst;
 	struct sk_buff *skb;
 	struct socket *sock;
-	u8 dst = 8;
+	u8 dst_eid = 8;
 	int n, rc;
 
-	mctp_test_flow_init(test, &dev, &rt, &sock, &skb, 100);
+	mctp_test_flow_init(test, &dev, &dst, &tpq, &sock, &skb, 100);
 
-	rc = mctp_local_output(sock->sk, &rt->rt, skb, dst, MCTP_TAG_OWNER);
+	rc = mctp_local_output(sock->sk, &dst, skb, dst_eid, MCTP_TAG_OWNER);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
-	n = rt->pkts.qlen;
+	n = tpq.pkts.qlen;
 	KUNIT_ASSERT_EQ(test, n, 2);
 
 	/* both resulting packets should have the same flow data */
-	tx_skbs[0] = skb_dequeue(&rt->pkts);
-	tx_skbs[1] = skb_dequeue(&rt->pkts);
+	tx_skbs[0] = skb_dequeue(&tpq.pkts);
+	tx_skbs[1] = skb_dequeue(&tpq.pkts);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tx_skbs[0]);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tx_skbs[1]);
@@ -1146,7 +1207,7 @@ static void mctp_test_fragment_flow(struct kunit *test)
 
 	kfree_skb(tx_skbs[0]);
 	kfree_skb(tx_skbs[1]);
-	mctp_test_flow_fini(test, dev, rt, sock);
+	mctp_test_flow_fini(test, dev, &dst, &tpq, sock);
 }
 
 #else
@@ -1164,15 +1225,16 @@ static void mctp_test_fragment_flow(struct kunit *test)
 /* Test that outgoing skbs cause a suitable tag to be created */
 static void mctp_test_route_output_key_create(struct kunit *test)
 {
+	const u8 dst_eid = 26, src_eid = 15;
+	struct mctp_test_pktqueue tpq;
 	const unsigned int netid = 50;
-	const u8 dst = 26, src = 15;
-	struct mctp_test_route *rt;
 	struct mctp_test_dev *dev;
 	struct mctp_sk_key *key;
 	struct netns_mctp *mns;
 	unsigned long flags;
 	struct socket *sock;
 	struct sk_buff *skb;
+	struct mctp_dst dst;
 	bool empty, single;
 	const int len = 2;
 	int rc;
@@ -1181,15 +1243,14 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 	WRITE_ONCE(dev->mdev->net, netid);
 
-	rt = mctp_test_create_route(&init_net, dev->mdev, dst, 68);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
+	mctp_test_dst_setup(test, &dst, dev, &tpq, 68);
 
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	dev->mdev->addrs = kmalloc(sizeof(u8), GFP_KERNEL);
 	dev->mdev->num_addrs = 1;
-	dev->mdev->addrs[0] = src;
+	dev->mdev->addrs[0] = src_eid;
 
 	skb = alloc_skb(sizeof(struct mctp_hdr) + 1 + len, GFP_KERNEL);
 	KUNIT_ASSERT_TRUE(test, skb);
@@ -1197,8 +1258,6 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	skb_reserve(skb, sizeof(struct mctp_hdr) + 1 + len);
 	memset(skb_put(skb, len), 0, len);
 
-	refcount_inc(&rt->rt.refs);
-
 	mns = &sock_net(sock->sk)->mctp;
 
 	/* We assume we're starting from an empty keys list, which requires
@@ -1209,7 +1268,7 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	spin_unlock_irqrestore(&mns->keys_lock, flags);
 	KUNIT_ASSERT_TRUE(test, empty);
 
-	rc = mctp_local_output(sock->sk, &rt->rt, skb, dst, MCTP_TAG_OWNER);
+	rc = mctp_local_output(sock->sk, &dst, skb, dst_eid, MCTP_TAG_OWNER);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	key = NULL;
@@ -1225,13 +1284,13 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, single);
 
 	KUNIT_EXPECT_EQ(test, key->net, netid);
-	KUNIT_EXPECT_EQ(test, key->local_addr, src);
-	KUNIT_EXPECT_EQ(test, key->peer_addr, dst);
+	KUNIT_EXPECT_EQ(test, key->local_addr, src_eid);
+	KUNIT_EXPECT_EQ(test, key->peer_addr, dst_eid);
 	/* key has incoming tag, so inverse of what we sent */
 	KUNIT_EXPECT_FALSE(test, key->tag & MCTP_TAG_OWNER);
 
 	sock_release(sock);
-	mctp_test_route_destroy(test, rt);
+	mctp_test_dst_release(&dst, &tpq);
 	mctp_test_destroy_dev(dev);
 }
 

-- 
2.39.5


