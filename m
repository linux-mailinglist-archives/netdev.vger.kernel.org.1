Return-Path: <netdev+bounces-72301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53B5857791
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C10D1F24958
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137271CD0A;
	Fri, 16 Feb 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JX2mNbVx"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFC1CAAD
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071586; cv=none; b=EDi/DsMn9IXtXI6Ffgm83L+63+nYuzz0xiguKa8c0WCZMRu0k5/Z0WB8UkinH6eU7l7xZKN1AVidSYI+YUWhu/05oXd9EqC5yhe9+RLsFji4fkqlc8jymMJxS1IMlN9s+NaKj8nJODDfA7YvPU1RR78y9pE9kkBTf+elIwu7ebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071586; c=relaxed/simple;
	bh=z2iqypaRRJ/8bV9Ci+Yydp53Lv/zAAf1DgpuFf6Xu6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ImgaXOrPfNJ4aaSsScVt8k8z92CZsPtYXkb9Sf/h5H1D79egOTQvzBiDPW0FuVSHSbSw5fhAkdpulD2nRp8+vdGnC1aGnujvaNKayHkuH6Ur4QjkFE3kiz9EOJqhnXbnpjxYQ7GJ+xjclQW/jHU+NOu4Au1frEitbU9//zYGU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JX2mNbVx; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 88B462048C; Fri, 16 Feb 2024 16:19:34 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708071574;
	bh=BQl9Bfy2r77tXN2eEBgqjV5SEAbhA3l4xfqhAQMxJw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JX2mNbVxIcAzti5H/8Sl0MEXNW01e7ykvs1wOQ0dJ6QR1nLMr+5TLeFh+QYstReHD
	 WHaemsUvcppalYTNGh04hEm5UlxJZln/Tx92TYia5hAWoDGGze9cPlzbo+OsCzsIel
	 CctYPFgQQtn2x4+sMzZZj4CPHrTL7TsWr+I/n/4XZajc2uLyQ2xkzwpYat5j4OJ6kX
	 qkEof1r1HfM9UbXXfArh3gXdVKQg8RfHbk0dMUl96+1ehr0y51/MmUZuwK7pXf/f6E
	 wgB8nBIGxkdZbLI29k52JBkCsFpEMhW/+40lAvC5+Cw+6p1A151Vyt4xuUmffuzXRB
	 nEK+1G4PVsypg==
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
Subject: [PATCH net-next 08/11] net: mctp: tests: Add MCTP net isolation tests
Date: Fri, 16 Feb 2024 16:19:18 +0800
Message-Id: <9e15b5b8fc097bd33707386bd25ab831ab74af2c.1708071380.git.jk@codeconstruct.com.au>
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

Add a couple of tests that excersise the new net-specific sk_key and
bind lookups

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 161 +++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 0880c3c04ace..bad084525f17 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -678,6 +678,165 @@ static void mctp_route_input_sk_keys_to_desc(
 KUNIT_ARRAY_PARAM(mctp_route_input_sk_keys, mctp_route_input_sk_keys_tests,
 		  mctp_route_input_sk_keys_to_desc);
 
+struct test_net {
+	unsigned int netid;
+	struct mctp_test_dev *dev;
+	struct mctp_test_route *rt;
+	struct socket *sock;
+	struct sk_buff *skb;
+	struct mctp_sk_key *key;
+	struct {
+		u8 type;
+		unsigned int data;
+	} msg;
+};
+
+static void
+mctp_test_route_input_multiple_nets_bind_init(struct kunit *test,
+					      struct test_net *t)
+{
+	struct mctp_hdr hdr = RX_HDR(1, 9, 8, FL_S | FL_E | FL_T(1) | FL_TO);
+
+	t->msg.data = t->netid;
+
+	__mctp_route_test_init(test, &t->dev, &t->rt, &t->sock, t->netid);
+
+	t->skb = mctp_test_create_skb_data(&hdr, &t->msg);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t->skb);
+	mctp_test_skb_set_dev(t->skb, t->dev);
+}
+
+static void
+mctp_test_route_input_multiple_nets_bind_fini(struct kunit *test,
+					      struct test_net *t)
+{
+	__mctp_route_test_fini(test, t->dev, t->rt, t->sock);
+}
+
+/* Test that skbs from different nets (otherwise identical) get routed to their
+ * corresponding socket via the sockets' bind()
+ */
+static void mctp_test_route_input_multiple_nets_bind(struct kunit *test)
+{
+	struct sk_buff *rx_skb1, *rx_skb2;
+	struct test_net t1, t2;
+	int rc;
+
+	t1.netid = 1;
+	t2.netid = 2;
+
+	t1.msg.type = 0;
+	t2.msg.type = 0;
+
+	mctp_test_route_input_multiple_nets_bind_init(test, &t1);
+	mctp_test_route_input_multiple_nets_bind_init(test, &t2);
+
+	rc = mctp_route_input(&t1.rt->rt, t1.skb);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+	rc = mctp_route_input(&t2.rt->rt, t2.skb);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	rx_skb1 = skb_recv_datagram(t1.sock->sk, MSG_DONTWAIT, &rc);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, rx_skb1);
+	KUNIT_EXPECT_EQ(test, rx_skb1->len, sizeof(t1.msg));
+	KUNIT_EXPECT_EQ(test,
+			*(unsigned int *)skb_pull(rx_skb1, sizeof(t1.msg.data)),
+			t1.netid);
+	kfree_skb(rx_skb1);
+
+	rx_skb2 = skb_recv_datagram(t2.sock->sk, MSG_DONTWAIT, &rc);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, rx_skb2);
+	KUNIT_EXPECT_EQ(test, rx_skb2->len, sizeof(t2.msg));
+	KUNIT_EXPECT_EQ(test,
+			*(unsigned int *)skb_pull(rx_skb2, sizeof(t2.msg.data)),
+			t2.netid);
+	kfree_skb(rx_skb2);
+
+	mctp_test_route_input_multiple_nets_bind_fini(test, &t1);
+	mctp_test_route_input_multiple_nets_bind_fini(test, &t2);
+}
+
+static void
+mctp_test_route_input_multiple_nets_key_init(struct kunit *test,
+					     struct test_net *t)
+{
+	struct mctp_hdr hdr = RX_HDR(1, 9, 8, FL_S | FL_E | FL_T(1));
+	struct mctp_sock *msk;
+	struct netns_mctp *mns;
+	unsigned long flags;
+
+	t->msg.data = t->netid;
+
+	__mctp_route_test_init(test, &t->dev, &t->rt, &t->sock, t->netid);
+
+	msk = container_of(t->sock->sk, struct mctp_sock, sk);
+
+	t->key = mctp_key_alloc(msk, t->netid, hdr.dest, hdr.src, 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t->key);
+
+	mns = &sock_net(t->sock->sk)->mctp;
+	spin_lock_irqsave(&mns->keys_lock, flags);
+	mctp_reserve_tag(&init_net, t->key, msk);
+	spin_unlock_irqrestore(&mns->keys_lock, flags);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t->key);
+	t->skb = mctp_test_create_skb_data(&hdr, &t->msg);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t->skb);
+	mctp_test_skb_set_dev(t->skb, t->dev);
+}
+
+static void
+mctp_test_route_input_multiple_nets_key_fini(struct kunit *test,
+					     struct test_net *t)
+{
+	mctp_key_unref(t->key);
+	__mctp_route_test_fini(test, t->dev, t->rt, t->sock);
+}
+
+/* test that skbs from different nets (otherwise identical) get routed to their
+ * corresponding socket via the sk_key
+ */
+static void mctp_test_route_input_multiple_nets_key(struct kunit *test)
+{
+	struct sk_buff *rx_skb1, *rx_skb2;
+	struct test_net t1, t2;
+	int rc;
+
+	t1.netid = 1;
+	t2.netid = 2;
+
+	/* use type 1 which is not bound */
+	t1.msg.type = 1;
+	t2.msg.type = 1;
+
+	mctp_test_route_input_multiple_nets_key_init(test, &t1);
+	mctp_test_route_input_multiple_nets_key_init(test, &t2);
+
+	rc = mctp_route_input(&t1.rt->rt, t1.skb);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+	rc = mctp_route_input(&t2.rt->rt, t2.skb);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	rx_skb1 = skb_recv_datagram(t1.sock->sk, MSG_DONTWAIT, &rc);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, rx_skb1);
+	KUNIT_EXPECT_EQ(test, rx_skb1->len, sizeof(t1.msg));
+	KUNIT_EXPECT_EQ(test,
+			*(unsigned int *)skb_pull(rx_skb1, sizeof(t1.msg.data)),
+			t1.netid);
+	kfree_skb(rx_skb1);
+
+	rx_skb2 = skb_recv_datagram(t2.sock->sk, MSG_DONTWAIT, &rc);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, rx_skb2);
+	KUNIT_EXPECT_EQ(test, rx_skb2->len, sizeof(t2.msg));
+	KUNIT_EXPECT_EQ(test,
+			*(unsigned int *)skb_pull(rx_skb2, sizeof(t2.msg.data)),
+			t2.netid);
+	kfree_skb(rx_skb2);
+
+	mctp_test_route_input_multiple_nets_key_fini(test, &t1);
+	mctp_test_route_input_multiple_nets_key_fini(test, &t2);
+}
+
 static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE_PARAM(mctp_test_fragment, mctp_frag_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_rx_input, mctp_rx_input_gen_params),
@@ -686,6 +845,8 @@ static struct kunit_case mctp_test_cases[] = {
 			 mctp_route_input_sk_reasm_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_route_input_sk_keys,
 			 mctp_route_input_sk_keys_gen_params),
+	KUNIT_CASE(mctp_test_route_input_multiple_nets_bind),
+	KUNIT_CASE(mctp_test_route_input_multiple_nets_key),
 	{}
 };
 
-- 
2.39.2


