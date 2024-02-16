Return-Path: <netdev+bounces-72302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F197857792
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F6D1C20BA9
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C1F1CF8B;
	Fri, 16 Feb 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="eokrBPpj"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F9C1CAB9
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071586; cv=none; b=lYy3qSxLw9swYAC2enE3l1w2ZeUQfbn6tWEClibdKuUdF/ZMjtznJONqP04jnX6S5KSnL6uRgq44krzs7vMsM+EaWbbZjOPbbCB81DdrxoZobMqcNQzK+ojzx+NUILEKJvz0PGFfkR4fOJpgmkqobjOMNdRuwlqw0gUgaFu68ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071586; c=relaxed/simple;
	bh=6HrrZf+RvWjkkutH0zKQQN03igGlKMaD/nLcAfMQeVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lo6UM6EMGNxH4zv0+FK9UknTWw732jtTOguv0Cc8rwItI7JKjKLz+s59fMW3T8tsyRMYTboxt4HbleKzbbWepXJYg0FtLq0HXvzVPR49GgUDm0femhU/bI2OUglC62jX5eYRV0FGRSuPcgs6uXJKBdjsVla2ilJxHRFnGVadNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=eokrBPpj; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 8CF3E2048F; Fri, 16 Feb 2024 16:19:35 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708071575;
	bh=jZB8Ilcjys0OU6iBAMmbmCBGxR4AlQJ3KQQosxnH9zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eokrBPpjaz8ZiL6MdoE5MfGUze+dWiTlJJmjWSBiTERKhSbWMg4bMnUppVk/S/Q6c
	 ZwWXIIquHzwhfTIDAhPJA5L+bXqLeRcMM30Cij9tDzGcEh72PGcdXm9DbSMsmJ/mGE
	 nXaLghlZ+f75XDM0LeGufxQMNOWun8B2HWttqtw2lj3OS+UQlOgqNX1FCZrLPU9w+h
	 jm1glwr4wwwJt8BSXM9iCbkiHPAtt1ueyvAFqG9KRVCielbG/ZXdlNAU6cUd0PCfx0
	 0IkSbAODQ5kLLCLUmsVWgoOvGfWoDWoTswx8581DFh2up40awj9n8aIEpaYg7+Iuvz
	 px3SXTDNIl5OA==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 11/11] net: mctp: tests: Add a test for proper tag creation on local output
Date: Fri, 16 Feb 2024 16:19:21 +0800
Message-Id: <95fc6f1218f1396a2277815af4f4dd1a0e8ec7dd.1708071380.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708071380.git.jk@codeconstruct.com.au>
References: <cover.1708071380.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure we have the correct key parameters on sending a message.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index eb7e9ac95612..77e5dd422258 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -971,6 +971,80 @@ static void mctp_test_fragment_flow(struct kunit *test)
 }
 #endif
 
+/* Test that outgoing skbs cause a suitable tag to be created */
+static void mctp_test_route_output_key_create(struct kunit *test)
+{
+	const unsigned int netid = 50;
+	const u8 dst = 26, src = 15;
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct mctp_sk_key *key;
+	struct netns_mctp *mns;
+	unsigned long flags;
+	struct socket *sock;
+	struct sk_buff *skb;
+	bool empty, single;
+	const int len = 2;
+	int rc;
+
+	dev = mctp_test_create_dev();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	WRITE_ONCE(dev->mdev->net, netid);
+
+	rt = mctp_test_create_route(&init_net, dev->mdev, dst, 68);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
+
+	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	dev->mdev->addrs = kmalloc(sizeof(u8), GFP_KERNEL);
+	dev->mdev->num_addrs = 1;
+	dev->mdev->addrs[0] = src;
+
+	skb = alloc_skb(sizeof(struct mctp_hdr) + 1 + len, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, skb);
+	__mctp_cb(skb);
+	skb_reserve(skb, sizeof(struct mctp_hdr) + 1 + len);
+	memset(skb_put(skb, len), 0, len);
+
+	refcount_inc(&rt->rt.refs);
+
+	mns = &sock_net(sock->sk)->mctp;
+
+	/* We assume we're starting from an empty keys list, which requires
+	 * preceding tests to clean up correctly!
+	 */
+	spin_lock_irqsave(&mns->keys_lock, flags);
+	empty = hlist_empty(&mns->keys);
+	spin_unlock_irqrestore(&mns->keys_lock, flags);
+	KUNIT_ASSERT_TRUE(test, empty);
+
+	rc = mctp_local_output(sock->sk, &rt->rt, skb, dst, MCTP_TAG_OWNER);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	key = NULL;
+	single = false;
+	spin_lock_irqsave(&mns->keys_lock, flags);
+	if (!hlist_empty(&mns->keys)) {
+		key = hlist_entry(mns->keys.first, struct mctp_sk_key, hlist);
+		single = hlist_is_singular_node(&key->hlist, &mns->keys);
+	}
+	spin_unlock_irqrestore(&mns->keys_lock, flags);
+
+	KUNIT_ASSERT_NOT_NULL(test, key);
+	KUNIT_ASSERT_TRUE(test, single);
+
+	KUNIT_EXPECT_EQ(test, key->net, netid);
+	KUNIT_EXPECT_EQ(test, key->local_addr, src);
+	KUNIT_EXPECT_EQ(test, key->peer_addr, dst);
+	/* key has incoming tag, so inverse of what we sent */
+	KUNIT_EXPECT_FALSE(test, key->tag & MCTP_TAG_OWNER);
+
+	sock_release(sock);
+	mctp_test_route_destroy(test, rt);
+	mctp_test_destroy_dev(dev);
+}
+
 static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE_PARAM(mctp_test_fragment, mctp_frag_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_rx_input, mctp_rx_input_gen_params),
@@ -983,6 +1057,7 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_route_input_multiple_nets_key),
 	KUNIT_CASE(mctp_test_packet_flow),
 	KUNIT_CASE(mctp_test_fragment_flow),
+	KUNIT_CASE(mctp_test_route_output_key_create),
 	{}
 };
 
-- 
2.39.2


