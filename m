Return-Path: <netdev+bounces-273497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEoZHnR8y2lPIQYAu9opvQ
	(envelope-from <netdev+bounces-273497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:49:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC42436577A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2104E30D0EE9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C493CEB8E;
	Tue, 31 Mar 2026 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="QZRombIH"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6EA3CEB90
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942884; cv=none; b=sZgZDGusPZmfd680DxK42kMkSoembf+m5z7mZpeYEEb35hsBX1Fs8yxeRAsu6rH/vJVMlts9DaaxKWDay+mojRpNlRdQgPMqc5Lu5rUbzFrgVmD4dYGgUaydDGMaTb/3KX3kXU5hqZsPj0Sd1nuD3W6aurEPD42l9f9Y/9XpXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942884; c=relaxed/simple;
	bh=naFMPLJ6Dc+gz5TAzXGv6pfBfTwJiet/QEvxl9G/P/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3dpAmTxpMkCLM92wqttq5OjrUjwX+1/xi9eHHE69559V41pcNc54T9d2b/aRjP2aKAd8y8QJ7Fttxl1gfnoZi/tTpM/cB7mEiZA+FhLwDpTahaAKNd+aFlm9XoSKT7BsJMwVMnGMMmEezdq+cjkPEaAePU1SjVsm+8ToYzWdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=QZRombIH; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774942878;
	bh=snx2I9TUrsPWxVM1HKabYbX9KVH4vcKzbwRuAUsh1oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QZRombIH62fGj85zjbY+KGbWcDwIQwdNDjPc+rnw1gApTJUPER0k8X4rfbRXz86RL
	 pmeIfMqgr9C3C4PlPmkIZll4/KWsx3nKo39YeEmx01qfg1NGhzlrPyNW0ohtqd9KYR
	 U8qG1NMWsjnTaYl+BfRyhUw+iMsSZOosA/kQSDm8Tp7CktXU8AcrMXi0CgbtxH22fw
	 Xu+Ew65K5PZZxdHRqJeW8r5uThGMTrTpAoC9Ev1HGXu5A9w7n/BATyuJUQFwAsfW88
	 WQ/ZMcM/sJJue5YlVA9vTV5a5Rm9aUMrYnjgKpUPXzwgoz2g3x6+I11qRO3AEiAaCs
	 vUGvLaNsIqH1w==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id AEEC565DF8; Tue, 31 Mar 2026 15:41:18 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 31 Mar 2026 15:41:08 +0800
Subject: [PATCH net-next 3/3] net: mctp: don't require a route for null-EID
 ingress
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-dev-mctp-null-eids-v1-3-b4d047372eaf@codeconstruct.com.au>
References: <20260331-dev-mctp-null-eids-v1-0-b4d047372eaf@codeconstruct.com.au>
In-Reply-To: <20260331-dev-mctp-null-eids-v1-0-b4d047372eaf@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273497-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:dkim,codeconstruct.com.au:email,codeconstruct.com.au:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC42436577A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, if we receive a physically-addressed packet for the local
stack, we perform a route_lookup_null to find a matching device-based
route. If a route is present, it will always have the ->output fn set to
mctp_dst_input, which provides our delivery mechanism.

However, if we don't yet have any local addresses assigned, we won't
have any local routes to lookup, so this will fail. One of the use-cases
for physical addressing is initial address assignment on endpoint nodes,
where we would have no addresses, and therefore no local routes.

Instead of iterating routes (looking for one matching the dev), just
create a suitable mctp_dst for the device directly.

Add a testcase for the no-route case too.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c           | 31 ++++++++++++-------------------
 net/mctp/test/route-test.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 8c484776e9e42e246d5e214f5c997281f820a43a..78263e7ae423d5bd92b10920b5c42c5f51a15a75 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1017,29 +1017,22 @@ int mctp_route_lookup(struct net *net, unsigned int dnet,
 	return rc;
 }
 
-static int mctp_route_lookup_null(struct net *net, struct net_device *dev,
-				  struct mctp_dst *dst)
+static int mctp_dst_input_null(struct net *net, struct net_device *dev,
+			       struct mctp_dst *dst)
 {
-	int rc = -EHOSTUNREACH;
-	struct mctp_route *rt;
-
 	rcu_read_lock();
+	dst->dev = __mctp_dev_get(dev);
+	rcu_read_unlock();
 
-	list_for_each_entry_rcu(rt, &net->mctp.routes, list) {
-		if (rt->dst_type != MCTP_ROUTE_DIRECT || rt->type != RTN_LOCAL)
-			continue;
-
-		if (rt->dev->dev != dev)
-			continue;
-
-		mctp_dst_from_route(dst, 0, 0, rt);
-		rc = 0;
-		break;
-	}
+	if (!dst->dev)
+		return -EHOSTUNREACH;
 
-	rcu_read_unlock();
+	dst->mtu = READ_ONCE(dev->mtu);
+	dst->halen = 0;
+	dst->output = mctp_dst_input;
+	dst->nexthop = 0;
 
-	return rc;
+	return 0;
 }
 
 static int mctp_do_fragment_route(struct mctp_dst *dst, struct sk_buff *skb,
@@ -1369,7 +1362,7 @@ static int mctp_pkttype_receive(struct sk_buff *skb, struct net_device *dev,
 
 	/* NULL EID, but addressed to our physical address */
 	if (rc && mh->dest == MCTP_ADDR_NULL && skb->pkt_type == PACKET_HOST)
-		rc = mctp_route_lookup_null(net, dev, &dst);
+		rc = mctp_dst_input_null(net, dev, &dst);
 
 	if (rc)
 		goto err_drop;
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index fa28af9ac18e6605867c475ee7110fbbfd556edb..e1033643fab0e2045fef34b42cab87f746761545 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -914,6 +914,48 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 	__mctp_route_test_fini(test, dev, &dst, sock);
 }
 
+/* check we can receive an incoming packet with the null EID as daddr, when
+ * no RTN_LOCAL routes are present.
+ */
+static void mctp_test_route_input_null_eid(struct kunit *test)
+{
+	struct mctp_hdr hdr = RX_HDR(1, 10, 0, FL_S | FL_E | FL_TO);
+	struct sk_buff *skb_pkt, *skb_sk;
+	struct mctp_test_dev *dev;
+	struct sockaddr_mctp addr;
+	struct socket *sock;
+	u8 type = 0;
+	int rc;
+
+	dev = mctp_test_create_dev();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	addr.smctp_family = AF_MCTP;
+	addr.smctp_network = MCTP_NET_ANY;
+	addr.smctp_addr.s_addr = MCTP_ADDR_ANY;
+	addr.smctp_type = type;
+	rc = kernel_bind(sock, (struct sockaddr_unsized *)&addr, sizeof(addr));
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	skb_pkt = mctp_test_create_skb_data(&hdr, &type);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb_pkt);
+
+	skb_pkt->dev = dev->ndev;
+	skb_pkt->pkt_type = PACKET_HOST;
+
+	mctp_pkttype_receive(skb_pkt, dev->ndev, &mctp_packet_type, NULL);
+
+	skb_sk = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, skb_sk);
+
+	skb_free_datagram(sock->sk, skb_sk);
+	sock_release(sock);
+	mctp_test_destroy_dev(dev);
+}
+
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 
 static void mctp_test_flow_init(struct kunit *test,
@@ -1693,6 +1735,7 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_route_input_sk_fail_frag),
 	KUNIT_CASE(mctp_test_route_input_multiple_nets_bind),
 	KUNIT_CASE(mctp_test_route_input_multiple_nets_key),
+	KUNIT_CASE(mctp_test_route_input_null_eid),
 	KUNIT_CASE(mctp_test_packet_flow),
 	KUNIT_CASE(mctp_test_fragment_flow),
 	KUNIT_CASE(mctp_test_route_output_key_create),

-- 
2.39.5


