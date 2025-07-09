Return-Path: <netdev+bounces-205308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D124AFE2AD
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0EA3A550F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2BC274FCD;
	Wed,  9 Jul 2025 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aX4JRhH4"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5A27511F
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049893; cv=none; b=nd9kCpBccovmg0Vied2coRKcna8C53N2aJPSov8k13fo8HDx+1c0nFY3k0owFuKbz0aZ1L2xA4QMZG2d1zzjkmt4/9J9y/BNhU5QrHc2uDpHRnyCT1Fbyhbge5OZm+WVyAX1jBLHypLzOnGOrtlfSAJvn2QG68qlEDHrsk+7/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049893; c=relaxed/simple;
	bh=GP3xL2+MQczAb6//iseZtWZbP5dIspygDFgs0ADzf54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgyPSDCOvh7R5Hge4qT439XlvGhz2+rI/og0Q80hEcybYfMO/BVuL+yHuECn5TrZPfNJrKJVpaRPaYBX8JO04igEopN8uA9vDQFQitwXHoaIkaJ/vUV4/auBF5G/Nc0eJsuMv8IwxtpGFiwPAbELKN05kMKYL4K06ilTqlsuCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aX4JRhH4; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752049882;
	bh=usxdNqlA0gKeFh2lca5jQcg/1pg6/IR4terT4kV9ay8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aX4JRhH4ku69gRLHMVtDCk2EbOFhrl+zcnTixXkKYJBK9Fk/KdA5nzJD9C/DFJdYW
	 C26qj6GJ7u+QuQVOZE3U608pp0ufZECJoMhBEbNtSOVeLpmY7GO5gtNNfe7rbUvA1G
	 vjLlLRSBKNGbZMeth7HluwZDRusXYc3wjoMpCXyuOU+8B65SJIL6ZaZhvLSqm13rVy
	 uB7I7l9YtBYc7w5EJaIAEIhKRb8lRo8LRTwxvS8QVEQU+79Qe3Q7JDiP0xjReootXR
	 V6X2QXlRhuJtOIo1K3h7G56vVcyNdXADKg0BTd8bMmeom+VVhdnIeIJWyojwXNXWFQ
	 sOYUM+YLaqcmA==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 0979B6B172; Wed,  9 Jul 2025 16:31:22 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Wed, 09 Jul 2025 16:31:08 +0800
Subject: [PATCH net-next v3 7/8] net: mctp: Test conflicts of connect()
 with bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-mctp-bind-v3-7-eac98bbf5e95@codeconstruct.com.au>
References: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
In-Reply-To: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752049878; l=4967;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=GP3xL2+MQczAb6//iseZtWZbP5dIspygDFgs0ADzf54=;
 b=7JOKzn8mZWZCa4LPqzmgq2lHx9J1ksz4WSHxZD+YurN8PsQ/NWsJjQYkmukgaKvOKrXo52xTk
 9MIYcP5IXBhD9yXcdTugNTFdEN64ur3HBNlFt7KEHKbxnPwVwLBw9gF
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

The addition of connect() adds new conflict cases to test.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

---
v3:
- Moved test code to mctp/test/sock-test.c recently added in
  net-next
---
 net/mctp/test/sock-test.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 net/mctp/test/utils.c     | 14 ++++++++++++++
 net/mctp/test/utils.h     |  4 ++++
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/net/mctp/test/sock-test.c b/net/mctp/test/sock-test.c
index 0cfc337be687e7ad903023d2fae9f12f75628532..b0942deb501980f196ce13da19ab171a3a9c9b8c 100644
--- a/net/mctp/test/sock-test.c
+++ b/net/mctp/test/sock-test.c
@@ -245,6 +245,11 @@ static const struct mctp_test_bind_setup bind_addrany_net2_type2 = {
 	.bind_addr = MCTP_ADDR_ANY, .bind_net = 2, .bind_type = 2,
 };
 
+static const struct mctp_test_bind_setup bind_addrany_net2_type1_peer9 = {
+	.bind_addr = MCTP_ADDR_ANY, .bind_net = 2, .bind_type = 1,
+	.have_peer = true, .peer_addr = 9, .peer_net = 2,
+};
+
 struct mctp_bind_pair_test {
 	const struct mctp_test_bind_setup *bind1;
 	const struct mctp_test_bind_setup *bind2;
@@ -278,19 +283,50 @@ static const struct mctp_bind_pair_test mctp_bind_pair_tests[] = {
 	 *  vs ADDR_ANY, explicit default net 1, OK
 	 */
 	{ &bind_addrany_netdefault_type1, &bind_addrany_net1_type1, 0 },
+
+	/* specific remote peer doesn't conflict with any-peer bind */
+	{ &bind_addrany_net2_type1_peer9, &bind_addrany_net2_type1, 0 },
+
+	/* bind() NET_ANY is allowed with a connect() net */
+	{ &bind_addrany_net2_type1_peer9, &bind_addrany_netdefault_type1, 0 },
 };
 
 static void mctp_bind_pair_desc(const struct mctp_bind_pair_test *t, char *desc)
 {
+	char peer1[25] = {0}, peer2[25] = {0};
+
+	if (t->bind1->have_peer)
+		snprintf(peer1, sizeof(peer1), ", peer %d net %d",
+			 t->bind1->peer_addr, t->bind1->peer_net);
+	if (t->bind2->have_peer)
+		snprintf(peer2, sizeof(peer2), ", peer %d net %d",
+			 t->bind2->peer_addr, t->bind2->peer_net);
+
 	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
-		 "{bind(addr %d, type %d, net %d)} {bind(addr %d, type %d, net %d)} -> error %d",
-		 t->bind1->bind_addr, t->bind1->bind_type, t->bind1->bind_net,
-		 t->bind2->bind_addr, t->bind2->bind_type, t->bind2->bind_net,
-		 t->error);
+		 "{bind(addr %d, type %d, net %d%s)} {bind(addr %d, type %d, net %d%s)} -> error %d",
+		 t->bind1->bind_addr, t->bind1->bind_type,
+		 t->bind1->bind_net, peer1,
+		 t->bind2->bind_addr, t->bind2->bind_type,
+		 t->bind2->bind_net, peer2, t->error);
 }
 
 KUNIT_ARRAY_PARAM(mctp_bind_pair, mctp_bind_pair_tests, mctp_bind_pair_desc);
 
+static void mctp_test_bind_invalid(struct kunit *test)
+{
+	struct socket *sock;
+	int rc;
+
+	/* bind() fails if the bind() vs connect() networks mismatch. */
+	const struct mctp_test_bind_setup bind_connect_net_mismatch = {
+		.bind_addr = MCTP_ADDR_ANY, .bind_net = 1, .bind_type = 1,
+		.have_peer = true, .peer_addr = 9, .peer_net = 2,
+	};
+	mctp_test_bind_run(test, &bind_connect_net_mismatch, &rc, &sock);
+	KUNIT_EXPECT_EQ(test, -rc, EINVAL);
+	sock_release(sock);
+}
+
 static int
 mctp_test_bind_conflicts_inner(struct kunit *test,
 			       const struct mctp_test_bind_setup *bind1,
@@ -348,6 +384,7 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_sock_sendmsg_extaddr),
 	KUNIT_CASE(mctp_test_sock_recvmsg_extaddr),
 	KUNIT_CASE_PARAM(mctp_test_bind_conflicts, mctp_bind_pair_gen_params),
+	KUNIT_CASE(mctp_test_bind_invalid),
 	{}
 };
 
diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index c971e2c326f3564f95b3f693c450b3e6f3d9c594..953d419027718959d913956c4c3893ef91624eb5 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -271,6 +271,20 @@ void mctp_test_bind_run(struct kunit *test,
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
+	/* connect() if requested */
+	if (setup->have_peer) {
+		memset(&addr, 0x0, sizeof(addr));
+		addr.smctp_family = AF_MCTP;
+		addr.smctp_network = setup->peer_net;
+		addr.smctp_addr.s_addr = setup->peer_addr;
+		/* connect() type must match bind() type */
+		addr.smctp_type = setup->bind_type;
+		rc = kernel_connect(*sock, (struct sockaddr *)&addr,
+				    sizeof(addr), 0);
+		KUNIT_EXPECT_EQ(test, rc, 0);
+	}
+
+	/* bind() */
 	memset(&addr, 0x0, sizeof(addr));
 	addr.smctp_family = AF_MCTP;
 	addr.smctp_network = setup->bind_net;
diff --git a/net/mctp/test/utils.h b/net/mctp/test/utils.h
index 7dd1a92ab770995db506c24dc805bb9e0839eeef..c2aaba5188ab82237cb3bcc00d5abf1942753b9d 100644
--- a/net/mctp/test/utils.h
+++ b/net/mctp/test/utils.h
@@ -35,6 +35,10 @@ struct mctp_test_bind_setup {
 	mctp_eid_t bind_addr;
 	int bind_net;
 	u8 bind_type;
+
+	bool have_peer;
+	mctp_eid_t peer_addr;
+	int peer_net;
 };
 
 struct mctp_test_dev *mctp_test_create_dev(void);

-- 
2.43.0


