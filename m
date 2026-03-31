Return-Path: <netdev+bounces-273496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPutF5t7y2lPIQYAu9opvQ
	(envelope-from <netdev+bounces-273496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:45:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C283656DF
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 134263038A4E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282BD3CEB93;
	Tue, 31 Mar 2026 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="h5qMVyHG"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C63CE4BE
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942883; cv=none; b=EdfZGt8XVS2yIbCIstfy62gswwudxU/iMovJg0KWfVp7LIg2pAVXi/KXSnZrDzXLQN7lP9C3XdSxNUeONa619p7rtO5LZi/jSw0FMw9XvfyKGIU8jBwLqzmtZgSmSq0Cj2MtQvRdMqUV4zsAn0x8W1VpmBtPPDMlY/8z5culDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942883; c=relaxed/simple;
	bh=jmEYepzSM2TgbqGPnijhhyUIxkqmmBid9P/r9cAxUBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j1SEKXguPQ0Kjgc8iNjuqUnXbZceEc5g5lI5wZCVmg0JgAiNkm6tXCRI3ZvYjRWwfdEOdYZPl5H0mQ8IWudvlsbMdZ+G08ayl3knr7aIr+SrXCWMhoPs8ntyr1yF8jZJoXQOXShLCaNGN0cbkY2EfPFI8UfAaS+ma+19tUZDfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=h5qMVyHG; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774942878;
	bh=Rkn75HKzvVtqyvb3JCIWMx5Z5E1sqpZP/D8U5nyWouM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h5qMVyHGQk1Wq3EWEtCqXky9RxaUpBB3h4KECkd9sDEloaZTbBU/p5RWXttvyJC9v
	 Psb6D3xsSbb274vv0OEwLGapUiTNV9vaGESmw/3fjxs5bzyOthRDrDzrzsyItrlyfm
	 drKsQ9I0BRy6oRnZEonQ1Fdfndx2VezS9GiMGYNzlgSw0kJkYf/tx+HS4zJT9OWgBv
	 +8LXbtcolFG+0BiEUwZXVpjVbErYDNYJ/zTWJA6XsJu/CpNq0rHdi0+ptFXWpwe6Mq
	 BH69M7oDI8WJlq2R6fkg2ADlcGt6YzC1ijG5TnKHWi/rOnkcVtz3q92Dg+3LTZxb5A
	 M86+qXr6PPirw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 3A19065DF7; Tue, 31 Mar 2026 15:41:18 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 31 Mar 2026 15:41:07 +0800
Subject: [PATCH net-next 2/3] net: mctp: allow local TX with no address
 assigned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-dev-mctp-null-eids-v1-2-b4d047372eaf@codeconstruct.com.au>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273496-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,codeconstruct.com.au:dkim,codeconstruct.com.au:email,codeconstruct.com.au:mid]
X-Rspamd-Queue-Id: 45C283656DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If we're operating as a non-bus-owner endpoint, we may want to perform
MCTP communication to get an address assigned. In this case, we'll have
no local addresses, but can TX just fine either with extended routing,
or where a direct route exists.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c           |  18 ++-----
 net/mctp/test/route-test.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 14 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index f6a88e668e68a8431e58ccc46e7ebb7bf2303f71..8c484776e9e42e246d5e214f5c997281f820a43a 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -997,8 +997,8 @@ int mctp_route_lookup(struct net *net, unsigned int dnet,
 
 		if (rt->dst_type == MCTP_ROUTE_DIRECT) {
 			mctp_dst_from_route(&dst_tmp, daddr, mtu, rt);
-			/* we need a source address */
-			if (dst_tmp.saddr == MCTP_ADDR_NULL) {
+			/* cannot do gateway-ed routes without a src  */
+			if (dst_tmp.saddr == MCTP_ADDR_NULL && depth != 0) {
 				mctp_dst_release(&dst_tmp);
 			} else {
 				if (dst)
@@ -1141,19 +1141,13 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 	struct mctp_sk_key *key;
 	struct mctp_hdr *hdr;
 	unsigned int netid;
-	int rc = 0;
 	u8 tag;
 
 	KUNIT_STATIC_STUB_REDIRECT(mctp_local_output, sk, dst, skb, daddr,
 				   req_tag);
 
-	if (dst->saddr == MCTP_ADDR_NULL)
-		rc = -EHOSTUNREACH;
 	netid = READ_ONCE(dst->dev->net);
 
-	if (rc)
-		goto err_free;
-
 	if (req_tag & MCTP_TAG_OWNER) {
 		if (req_tag & MCTP_TAG_PREALLOC)
 			key = mctp_lookup_prealloc_tag(msk, netid, daddr,
@@ -1163,8 +1157,8 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 						   daddr, false, &tag);
 
 		if (IS_ERR(key)) {
-			rc = PTR_ERR(key);
-			goto err_free;
+			kfree_skb(skb);
+			return PTR_ERR(key);
 		}
 		mctp_skb_set_flow(skb, key);
 		/* done with the key in this scope */
@@ -1191,10 +1185,6 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 
 	/* route output functions consume the skb, even on error */
 	return mctp_do_fragment_route(dst, skb, dst->mtu, tag);
-
-err_free:
-	kfree_skb(skb);
-	return rc;
 }
 
 /* route management */
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 639b7c41c2a233fa78f789d0ef25b87a15fb702b..fa28af9ac18e6605867c475ee7110fbbfd556edb 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1570,6 +1570,117 @@ static void mctp_test_bind_lookup(struct kunit *test)
 	__mctp_route_test_fini(test, dev, &dst, sock_ty0);
 }
 
+static void mctp_test_route_output_direct_no_eids(struct kunit *test)
+{
+	struct mctp_dst dst = { 0 };
+	struct sk_buff *skb, *skb2;
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct socket *sock;
+	const int len = 2;
+	int rc;
+
+	dev = mctp_test_create_dev();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	rt = mctp_test_create_route_direct(&init_net, dev->mdev, 9, 68);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
+
+	rc = mctp_route_lookup(&init_net, dev->mdev->net, 9, &dst);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	skb = alloc_skb(sizeof(struct mctp_hdr) + 1 + len, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, skb);
+	__mctp_cb(skb);
+	skb_reserve(skb, sizeof(struct mctp_hdr) + 1 + len);
+	memset(skb_put(skb, len), 0, len);
+
+	rc = mctp_local_output(sock->sk, &dst, skb, 9, MCTP_TAG_OWNER);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	KUNIT_ASSERT_EQ(test, dev->pkts.qlen, 1);
+
+	skb2 = skb_dequeue(&dev->pkts);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb2);
+
+	kfree_skb(skb2);
+	sock_release(sock);
+	mctp_dst_release(&dst);
+	mctp_test_route_destroy(test, rt);
+	mctp_test_destroy_dev(dev);
+}
+
+static void mctp_test_route_output_gw_no_eids(struct kunit *test)
+{
+	struct mctp_test_route *rt1, *rt2;
+	struct mctp_test_dev *dev;
+	struct mctp_dst dst = { 0 };
+	int rc;
+
+	dev = mctp_test_create_dev();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	/* route: direct to bridge */
+	rt1 = mctp_test_create_route_direct(&init_net, dev->mdev, 9, 68);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt1);
+
+	/* route: bridge gw to final dest */
+	rt2 = mctp_test_create_route_gw(&init_net, dev->mdev->net, 10, 9, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt2);
+
+	/* route lookup should fail, due to no source address on dev */
+	rc = mctp_route_lookup(&init_net, dev->mdev->net, 10, &dst);
+	KUNIT_ASSERT_NE(test, rc, 0);
+
+	mctp_test_route_destroy(test, rt1);
+	mctp_test_route_destroy(test, rt2);
+	mctp_test_destroy_dev(dev);
+}
+
+static void mctp_test_route_output_extaddr_no_eids(struct kunit *test)
+{
+	struct mctp_dst dst = { 0 };
+	struct sk_buff *skb, *skb2;
+	struct mctp_test_dev *dev;
+	struct socket *sock;
+	const int len = 1;
+	struct net *net;
+	int rc;
+
+	dev = mctp_test_create_dev();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	net = dev_net(dev->ndev);
+
+	rc = mctp_dst_from_extaddr(&dst, net, dev->ndev->ifindex, 0, NULL);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	rc = sock_create_kern(net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	skb = alloc_skb(sizeof(struct mctp_hdr) + 1 + len, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, skb);
+	__mctp_cb(skb);
+	skb_reserve(skb, sizeof(struct mctp_hdr) + 1 + len);
+	memset(skb_put(skb, len), 0, len);
+
+	rc = mctp_local_output(sock->sk, &dst, skb, 9, MCTP_TAG_OWNER);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	KUNIT_ASSERT_EQ(test, dev->pkts.qlen, 1);
+
+	skb2 = skb_dequeue(&dev->pkts);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb2);
+
+	kfree_skb(skb2);
+	sock_release(sock);
+	mctp_dst_release(&dst);
+	mctp_test_destroy_dev(dev);
+}
+
 static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE_PARAM(mctp_test_fragment, mctp_frag_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_rx_input, mctp_rx_input_gen_params),
@@ -1592,6 +1703,9 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE_PARAM(mctp_test_route_gw_mtu, mctp_route_gw_mtu_gen_params),
 	KUNIT_CASE(mctp_test_route_gw_output),
 	KUNIT_CASE_PARAM(mctp_test_bind_lookup, mctp_bind_lookup_gen_params),
+	KUNIT_CASE(mctp_test_route_output_direct_no_eids),
+	KUNIT_CASE(mctp_test_route_output_gw_no_eids),
+	KUNIT_CASE(mctp_test_route_output_extaddr_no_eids),
 	{}
 };
 

-- 
2.39.5


