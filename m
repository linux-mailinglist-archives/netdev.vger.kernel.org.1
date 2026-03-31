Return-Path: <netdev+bounces-273498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABO+Bqh7y2lPIQYAu9opvQ
	(envelope-from <netdev+bounces-273498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:45:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD27E3656E7
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00890303A81E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3263D1CB5;
	Tue, 31 Mar 2026 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ektWt1lr"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79113CD8D9
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942885; cv=none; b=h19h08tfEQ418v9nSN1+FunT8iGhF9pib74bmCYuDtvKxBYKB+JfRl5WedbBrY0PcPt8lVuEgARcumXPDCVLF637z2nASE0aXbwXuKGozsfeqN2DpQnSSc6JbJQyOCGJ0oO/dlJ0UMVSGEUWrpfLvQzV1TpYqUCHKouB4csYBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942885; c=relaxed/simple;
	bh=3JutQZddoBNbcTYuKGe4z6Sei7iHuu+t8apx7FT4jew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYmxmBBf+1+oComeruoDeo5OqVjONwbn8tPd52vfYqdrkepCuGD4X3kTeC91CbJuamvjWZz3IF4J+3IRk8dbQIzXn1Ubu9WBz9Nmlupk8Sq95hCSbcrFeMzV1PB4pZn+GALBD4CPYVTmAmzvBPpLvMuYQUmD4R5q49R+Bz6VhwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ektWt1lr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774942877;
	bh=yrYoGPJ7SJ5q6d4HC40ilOjkXt2E0Z+/9Rbr3rh09/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ektWt1lraZkbiGP++zCnv0hbFoM3M2nPlUC690ZxlhrJwsPkjoUhWg+rq1pA/IfbY
	 vMxwGL7eUdSwdznn5+koUAE9XH9Qgg5s0MAdPI4fjtnHM/P2TKsPUxQkSitdICxSeI
	 m6UlYmsSeLDAS34p8cNf5oLmC5I0acXw9I3lyw6q0NbOLFGiFzoXliycfoqkixJn8P
	 3MBs0Evuc6UoED2jJKAp2w8B8quWX56YntzDVtvqEUPaKBcRfF4kp3fE71ej7CCxTd
	 OWcXBQcVZJoqEyaZMAxtosz16ptNLcD57iHf0FEzaTWAdFQRZq4wMNrxDjn223CXhp
	 YSEZparxtXFKg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id CE7CE65DF6; Tue, 31 Mar 2026 15:41:17 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 31 Mar 2026 15:41:06 +0800
Subject: [PATCH net-next 1/3] net: mctp: perform source address lookups
 when we populate our dst
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-dev-mctp-null-eids-v1-1-b4d047372eaf@codeconstruct.com.au>
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
	TAGGED_FROM(0.00)[bounces-273498-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: AD27E3656E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rather than querying the output device for its address in
mctp_local_output, set up the source address when we're populating the
dst structure. If no address is assigned, use MCTP_ADDR_NULL.

This will allow us more flexibility when routing for NULL-source-eid
cases. For now though, we still reject a NULL source address in the
output path.

We need to update the tests a little, so that addresses are assigned
before we do the dst lookups.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 include/net/mctp.h         |  1 +
 net/mctp/route.c           | 51 +++++++++++++++++++++++++++++-----------------
 net/mctp/test/route-test.c | 23 +++++++++++----------
 net/mctp/test/utils.c      | 27 ++++++++++++++++++++++++
 net/mctp/test/utils.h      |  1 +
 5 files changed, 73 insertions(+), 30 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index c3207ce98f07fcbb436e968d503bc45666794fdc..e1e0a69afdcef7f0924523757010e75ea53e8e7c 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -270,6 +270,7 @@ struct mctp_dst {
 	struct mctp_dev *dev;
 	unsigned int mtu;
 	mctp_eid_t nexthop;
+	mctp_eid_t saddr;
 
 	/* set for direct addressing */
 	unsigned char halen;
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 021e04f1ea7c950af4c4e21d7afbc8c98d093186..f6a88e668e68a8431e58ccc46e7ebb7bf2303f71 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -880,6 +880,21 @@ static bool mctp_rt_compare_exact(struct mctp_route *rt1,
 		rt1->max == rt2->max;
 }
 
+static mctp_eid_t mctp_dev_saddr(struct mctp_dev *dev)
+{
+	mctp_eid_t addr = MCTP_ADDR_NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->addrs_lock, flags);
+	if (dev->num_addrs) {
+		/* use the outbound interface's first address as our source */
+		addr = dev->addrs[0];
+	}
+	spin_unlock_irqrestore(&dev->addrs_lock, flags);
+
+	return addr;
+}
+
 /* must only be called on a direct route, as the final output hop */
 static void mctp_dst_from_route(struct mctp_dst *dst, mctp_eid_t eid,
 				unsigned int mtu, struct mctp_route *route)
@@ -892,6 +907,7 @@ static void mctp_dst_from_route(struct mctp_dst *dst, mctp_eid_t eid,
 		dst->mtu = min(dst->mtu, mtu);
 	dst->halen = 0;
 	dst->output = route->output;
+	dst->saddr = mctp_dev_saddr(route->dev);
 }
 
 int mctp_dst_from_extaddr(struct mctp_dst *dst, struct net *net, int ifindex,
@@ -924,6 +940,7 @@ int mctp_dst_from_extaddr(struct mctp_dst *dst, struct net *net, int ifindex,
 	dst->halen = halen;
 	dst->output = mctp_dst_output;
 	dst->nexthop = 0;
+	dst->saddr = mctp_dev_saddr(dev);
 	memcpy(dst->haddr, haddr, halen);
 
 	rc = 0;
@@ -958,6 +975,7 @@ int mctp_route_lookup(struct net *net, unsigned int dnet,
 {
 	const unsigned int max_depth = 32;
 	unsigned int depth, mtu = 0;
+	struct mctp_dst dst_tmp;
 	int rc = -EHOSTUNREACH;
 
 	rcu_read_lock();
@@ -978,9 +996,15 @@ int mctp_route_lookup(struct net *net, unsigned int dnet,
 			mtu = mtu ?: rt->mtu;
 
 		if (rt->dst_type == MCTP_ROUTE_DIRECT) {
-			if (dst)
-				mctp_dst_from_route(dst, daddr, mtu, rt);
-			rc = 0;
+			mctp_dst_from_route(&dst_tmp, daddr, mtu, rt);
+			/* we need a source address */
+			if (dst_tmp.saddr == MCTP_ADDR_NULL) {
+				mctp_dst_release(&dst_tmp);
+			} else {
+				if (dst)
+					*dst = dst_tmp;
+				rc = 0;
+			}
 			break;
 
 		} else if (rt->dst_type == MCTP_ROUTE_GATEWAY) {
@@ -1116,26 +1140,15 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
 	struct mctp_sk_key *key;
 	struct mctp_hdr *hdr;
-	unsigned long flags;
 	unsigned int netid;
-	mctp_eid_t saddr;
-	int rc;
+	int rc = 0;
 	u8 tag;
 
 	KUNIT_STATIC_STUB_REDIRECT(mctp_local_output, sk, dst, skb, daddr,
 				   req_tag);
 
-	rc = -ENODEV;
-
-	spin_lock_irqsave(&dst->dev->addrs_lock, flags);
-	if (dst->dev->num_addrs == 0) {
+	if (dst->saddr == MCTP_ADDR_NULL)
 		rc = -EHOSTUNREACH;
-	} else {
-		/* use the outbound interface's first address as our source */
-		saddr = dst->dev->addrs[0];
-		rc = 0;
-	}
-	spin_unlock_irqrestore(&dst->dev->addrs_lock, flags);
 	netid = READ_ONCE(dst->dev->net);
 
 	if (rc)
@@ -1146,8 +1159,8 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 			key = mctp_lookup_prealloc_tag(msk, netid, daddr,
 						       req_tag, &tag);
 		else
-			key = mctp_alloc_local_tag(msk, netid, saddr, daddr,
-						   false, &tag);
+			key = mctp_alloc_local_tag(msk, netid, dst->saddr,
+						   daddr, false, &tag);
 
 		if (IS_ERR(key)) {
 			rc = PTR_ERR(key);
@@ -1174,7 +1187,7 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 	hdr = mctp_hdr(skb);
 	hdr->ver = 1;
 	hdr->dest = daddr;
-	hdr->src = saddr;
+	hdr->src = dst->saddr;
 
 	/* route output functions consume the skb, even on error */
 	return mctp_do_fragment_route(dst, skb, dst->mtu, tag);
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 61c989c43ec09c9e105de4e51b295d07bb93d6da..639b7c41c2a233fa78f789d0ef25b87a15fb702b 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -174,7 +174,9 @@ static void mctp_rx_input_test_to_desc(const struct mctp_rx_input_test *t,
 KUNIT_ARRAY_PARAM(mctp_rx_input, mctp_rx_input_tests,
 		  mctp_rx_input_test_to_desc);
 
-/* set up a local dev, route on EID 8, and a socket listening on type 0 */
+/* set up a local dev (with addr 8), route on EID 8, and a socket listening on
+ * type 0
+ */
 static void __mctp_route_test_init(struct kunit *test,
 				   struct mctp_test_dev **devp,
 				   struct mctp_dst *dst,
@@ -191,6 +193,10 @@ static void __mctp_route_test_init(struct kunit *test,
 	if (netid != MCTP_NET_ANY)
 		WRITE_ONCE(dev->mdev->net, netid);
 
+	dev->mdev->addrs = kmalloc_objs(u8, 1, GFP_KERNEL);
+	dev->mdev->num_addrs = 1;
+	dev->mdev->addrs[0] = 8;
+
 	mctp_test_dst_setup(test, dst, dev, 68);
 
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
@@ -928,11 +934,6 @@ static void mctp_test_flow_init(struct kunit *test,
 	 */
 	__mctp_route_test_init(test, &dev, dst, sock, MCTP_NET_ANY);
 
-	/* Assign a single EID. ->addrs is freed on mctp netdev release */
-	dev->mdev->addrs = kmalloc(sizeof(u8), GFP_KERNEL);
-	dev->mdev->num_addrs = 1;
-	dev->mdev->addrs[0] = 8;
-
 	skb = alloc_skb(len + sizeof(struct mctp_hdr) + 1, GFP_KERNEL);
 	KUNIT_ASSERT_TRUE(test, skb);
 	__mctp_cb(skb);
@@ -1058,8 +1059,6 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 	WRITE_ONCE(dev->mdev->net, netid);
 
-	mctp_test_dst_setup(test, &dst, dev, 68);
-
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
@@ -1067,6 +1066,8 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	dev->mdev->num_addrs = 1;
 	dev->mdev->addrs[0] = src_eid;
 
+	mctp_test_dst_setup(test, &dst, dev, 68);
+
 	skb = alloc_skb(sizeof(struct mctp_hdr) + 1 + len, GFP_KERNEL);
 	KUNIT_ASSERT_TRUE(test, skb);
 	__mctp_cb(skb);
@@ -1165,7 +1166,7 @@ static void mctp_test_route_gw_lookup(struct kunit *test)
 	struct mctp_test_dev *dev;
 	int rc;
 
-	dev = mctp_test_create_dev();
+	dev = mctp_test_create_dev_with_addr(8);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	/* 8 (local) -> 10 (gateway) via 9 (direct) */
@@ -1195,7 +1196,7 @@ static void mctp_test_route_gw_loop(struct kunit *test)
 	struct mctp_test_dev *dev;
 	int rc;
 
-	dev = mctp_test_create_dev();
+	dev = mctp_test_create_dev_with_addr(8);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	/* two routes using each other as the gw */
@@ -1254,7 +1255,7 @@ static void mctp_test_route_gw_mtu(struct kunit *test)
 	unsigned int netid;
 	int rc;
 
-	dev = mctp_test_create_dev();
+	dev = mctp_test_create_dev_with_addr(8);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 	dev->ndev->mtu = mtus->dev;
 	mdev = dev->mdev;
diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index 97afe8cd2b05c9f047c4a6e8c9fb1b4496183cfe..2f79f8c1a2b44beb4917a9b92ffd72955a3a03c6 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -80,6 +80,26 @@ struct mctp_test_dev *mctp_test_create_dev(void)
 	return __mctp_test_create_dev(0, NULL);
 }
 
+struct mctp_test_dev *mctp_test_create_dev_with_addr(mctp_eid_t addr)
+{
+	struct mctp_test_dev *dev;
+
+	dev = __mctp_test_create_dev(0, NULL);
+	if (!dev)
+		return NULL;
+
+	dev->mdev->addrs = kmalloc_objs(u8, 1, GFP_KERNEL);
+	if (!dev->mdev->addrs) {
+		mctp_test_destroy_dev(dev);
+		return NULL;
+	}
+
+	dev->mdev->num_addrs = 1;
+	dev->mdev->addrs[0] = 8;
+
+	return dev;
+}
+
 struct mctp_test_dev *mctp_test_create_dev_lladdr(unsigned short lladdr_len,
 						  const unsigned char *lladdr)
 {
@@ -171,6 +191,8 @@ struct mctp_test_route *mctp_test_create_route_gw(struct net *net,
 void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
 			 struct mctp_test_dev *dev, unsigned int mtu)
 {
+	unsigned long flags;
+
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
 
 	memset(dst, 0, sizeof(*dst));
@@ -179,6 +201,11 @@ void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
 	__mctp_dev_get(dst->dev->dev);
 	dst->mtu = mtu;
 	dst->output = mctp_test_dst_output;
+	dst->saddr = MCTP_ADDR_NULL;
+	spin_lock_irqsave(&dev->mdev->addrs_lock, flags);
+	if (dev->mdev->num_addrs)
+		dst->saddr = dev->mdev->addrs[0];
+	spin_unlock_irqrestore(&dev->mdev->addrs_lock, flags);
 }
 
 void mctp_test_route_destroy(struct kunit *test, struct mctp_test_route *rt)
diff --git a/net/mctp/test/utils.h b/net/mctp/test/utils.h
index 4cc90c9da4d1bfe9c63b2cac5253f9e09be3b147..47603732e6a570f7bb7e138246071fdbc092f790 100644
--- a/net/mctp/test/utils.h
+++ b/net/mctp/test/utils.h
@@ -42,6 +42,7 @@ struct mctp_test_bind_setup {
 };
 
 struct mctp_test_dev *mctp_test_create_dev(void);
+struct mctp_test_dev *mctp_test_create_dev_with_addr(mctp_eid_t eid);
 struct mctp_test_dev *mctp_test_create_dev_lladdr(unsigned short lladdr_len,
 						  const unsigned char *lladdr);
 void mctp_test_destroy_dev(struct mctp_test_dev *dev);

-- 
2.39.5


