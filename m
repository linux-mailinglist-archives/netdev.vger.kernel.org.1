Return-Path: <netdev+bounces-150988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A95C9EC47D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2611E167CFE
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 05:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D61C3314;
	Wed, 11 Dec 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lui6xrzM"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51D1C2324
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896608; cv=none; b=skNgGL4cQix+FKBlH4mqB1sQTDFQjgd4Gq9qfW6GDAQsnfFff8hpjcxO1+3PDU0jIKZorHAzcz+BOXsT27crb9XIYQCOgaV2PHe3ZQ3BdDVQcp0pIgJ6tyvtcgC2d7UBvI267HSKEI0dytvdY4pi/MtPKofaqHPcZMTqUq07tq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896608; c=relaxed/simple;
	bh=WsZ3rHxDAuH+C+xsliP1E/cxRqvpIxRHOFLbpdd6Q+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qENGNNK2+L/TzMThB6kyjEkYcDMmYVp+Var8Yekx0h5zkTv8rMtv/W9Dxur3p2JQPDlFya1dY+PHLU3GcnKcryezsajKMLl55HHMPpKfohuIIK4OhymNGx5wg9elced9WIxdiDieJVLfInpjuI1b1zKfK37/97HcmcAc81+0X98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lui6xrzM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1733896598;
	bh=BZ3YZytObn3nRZrq8ocWLEOy+M3CkWmH/pFC9eD4si8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lui6xrzMu3BN6p0vHcACDiccZez/k0SWwLtNiZRjuynmD6SAu4DsHcDr1sM5YYQha
	 T3x1c4KVJzPpKHfVm5Wk4extr1BFIvZcKiv53N5F2EvXnuOP7mLiaGTFMPuZUZiA/p
	 cFDmFRLB80nXnaWhqVSp7MZPwQcTRJyl6kjvGsr2rwErhCPj1T0fmvO8hlo5kWN13g
	 YI0l+B+QV1cNKzYVqJJ6VoTKTsI1Zn8jnqRM2/K0JDEiWrui9WsgPYVedK8v9YKrWF
	 HFaFNDmaRQJmH5yAiWuhfVSfvE2nQsZrnMY5tU+ID7Uh2chaAnPebjs6wWMzDUQD8O
	 nol++DWW63xXQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id C06506E7A2; Wed, 11 Dec 2024 13:56:38 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 11 Dec 2024 13:56:16 +0800
Subject: [PATCH net-next 1/3] net: mctp: handle skb cleanup on sock_queue
 failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-mctp-next-v1-1-e392f3d6d154@codeconstruct.com.au>
References: <20241211-mctp-next-v1-0-e392f3d6d154@codeconstruct.com.au>
In-Reply-To: <20241211-mctp-next-v1-0-e392f3d6d154@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Currently, we don't use the return value from sock_queue_rcv_skb, which
means we may leak skbs if a message is not successfully queued to a
socket.

Instead, ensure that we're freeing the skb where the sock hasn't
otherwise taken ownership of the skb by adding checks on the
sock_queue_rcv_skb() to invoke a kfree on failure.

In doing so, rather than using the 'rc' value to trigger the
kfree_skb(), use the skb pointer itself, which is more explicit.

Also, add a kunit test for the sock delivery failure cases.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c           | 38 +++++++++++++-------
 net/mctp/test/route-test.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 597e9cf5aa64445474287a3fee02ba760db15796..49676ce627e30ee34924d64fe26ef1e0303518d9 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -374,8 +374,13 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	msk = NULL;
 	rc = -EINVAL;
 
-	/* we may be receiving a locally-routed packet; drop source sk
-	 * accounting
+	/* We may be receiving a locally-routed packet; drop source sk
+	 * accounting.
+	 *
+	 * From here, we will either queue the skb - either to a frag_queue, or
+	 * to a receiving socket. When that succeeds, we clear the skb pointer;
+	 * a non-NULL skb on exit will be otherwise unowned, and hence
+	 * kfree_skb()-ed.
 	 */
 	skb_orphan(skb);
 
@@ -434,7 +439,9 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 		 * pending key.
 		 */
 		if (flags & MCTP_HDR_FLAG_EOM) {
-			sock_queue_rcv_skb(&msk->sk, skb);
+			rc = sock_queue_rcv_skb(&msk->sk, skb);
+			if (!rc)
+				skb = NULL;
 			if (key) {
 				/* we've hit a pending reassembly; not much we
 				 * can do but drop it
@@ -443,7 +450,6 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 						   MCTP_TRACE_KEY_REPLIED);
 				key = NULL;
 			}
-			rc = 0;
 			goto out_unlock;
 		}
 
@@ -470,8 +476,10 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 			 * this function.
 			 */
 			rc = mctp_key_add(key, msk);
-			if (!rc)
+			if (!rc) {
 				trace_mctp_key_acquire(key);
+				skb = NULL;
+			}
 
 			/* we don't need to release key->lock on exit, so
 			 * clean up here and suppress the unlock via
@@ -489,6 +497,8 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 				key = NULL;
 			} else {
 				rc = mctp_frag_queue(key, skb);
+				if (!rc)
+					skb = NULL;
 			}
 		}
 
@@ -498,17 +508,22 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 		 */
 
 		/* we need to be continuing an existing reassembly... */
-		if (!key->reasm_head)
-			rc = -EINVAL;
-		else
+		if (key->reasm_head)
 			rc = mctp_frag_queue(key, skb);
+		else
+			rc = -EINVAL;
+
+		/* if we've queued, the queue owns the skb now */
+		if (!rc)
+			skb = NULL;
 
 		/* end of message? deliver to socket, and we're done with
 		 * the reassembly/response key
 		 */
 		if (!rc && flags & MCTP_HDR_FLAG_EOM) {
-			sock_queue_rcv_skb(key->sk, key->reasm_head);
-			key->reasm_head = NULL;
+			rc = sock_queue_rcv_skb(key->sk, key->reasm_head);
+			if (!rc)
+				key->reasm_head = NULL;
 			__mctp_key_done_in(key, net, f, MCTP_TRACE_KEY_REPLIED);
 			key = NULL;
 		}
@@ -527,8 +542,7 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	if (any_key)
 		mctp_key_unref(any_key);
 out:
-	if (rc)
-		kfree_skb(skb);
+	kfree_skb(skb);
 	return rc;
 }
 
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 8551dab1d1e69836c84f68509bc9dab43a96cc67..17165b86ce22d48b10793a82cc10192b8749e7e6 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -837,6 +837,90 @@ static void mctp_test_route_input_multiple_nets_key(struct kunit *test)
 	mctp_test_route_input_multiple_nets_key_fini(test, &t2);
 }
 
+/* Input route to socket, using a single-packet message, where sock delivery
+ * fails. Ensure we're handling the failure appropriately.
+ */
+static void mctp_test_route_input_sk_fail_single(struct kunit *test)
+{
+	const struct mctp_hdr hdr = RX_HDR(1, 10, 8, FL_S | FL_E | FL_TO);
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct socket *sock;
+	struct sk_buff *skb;
+	int rc;
+
+	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
+
+	/* No rcvbuf space, so delivery should fail. __sock_set_rcvbuf will
+	 * clamp the minimum to SOCK_MIN_RCVBUF, so we open-code this.
+	 */
+	lock_sock(sock->sk);
+	WRITE_ONCE(sock->sk->sk_rcvbuf, 0);
+	release_sock(sock->sk);
+
+	skb = mctp_test_create_skb(&hdr, 10);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
+	skb_get(skb);
+
+	mctp_test_skb_set_dev(skb, dev);
+
+	/* do route input, which should fail */
+	rc = mctp_route_input(&rt->rt, skb);
+	KUNIT_EXPECT_NE(test, rc, 0);
+
+	/* we should hold the only reference to skb */
+	KUNIT_EXPECT_EQ(test, refcount_read(&skb->users), 1);
+	kfree_skb(skb);
+
+	__mctp_route_test_fini(test, dev, rt, sock);
+}
+
+/* Input route to socket, using a fragmented message, where sock delivery fails.
+ */
+static void mctp_test_route_input_sk_fail_frag(struct kunit *test)
+{
+	const struct mctp_hdr hdrs[2] = { RX_FRAG(FL_S, 0), RX_FRAG(FL_E, 1) };
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct sk_buff *skbs[2];
+	struct socket *sock;
+	unsigned int i;
+	int rc;
+
+	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
+
+	lock_sock(sock->sk);
+	WRITE_ONCE(sock->sk->sk_rcvbuf, 0);
+	release_sock(sock->sk);
+
+	for (i = 0; i < ARRAY_SIZE(skbs); i++) {
+		skbs[i] = mctp_test_create_skb(&hdrs[i], 10);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skbs[i]);
+		skb_get(skbs[i]);
+
+		mctp_test_skb_set_dev(skbs[i], dev);
+	}
+
+	/* first route input should succeed, we're only queueing to the
+	 * frag list
+	 */
+	rc = mctp_route_input(&rt->rt, skbs[0]);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+
+	/* final route input should fail to deliver to the socket */
+	rc = mctp_route_input(&rt->rt, skbs[1]);
+	KUNIT_EXPECT_NE(test, rc, 0);
+
+	/* we should hold the only reference to both skbs */
+	KUNIT_EXPECT_EQ(test, refcount_read(&skbs[0]->users), 1);
+	kfree_skb(skbs[0]);
+
+	KUNIT_EXPECT_EQ(test, refcount_read(&skbs[1]->users), 1);
+	kfree_skb(skbs[1]);
+
+	__mctp_route_test_fini(test, dev, rt, sock);
+}
+
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 
 static void mctp_test_flow_init(struct kunit *test,
@@ -1053,6 +1137,8 @@ static struct kunit_case mctp_test_cases[] = {
 			 mctp_route_input_sk_reasm_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_route_input_sk_keys,
 			 mctp_route_input_sk_keys_gen_params),
+	KUNIT_CASE(mctp_test_route_input_sk_fail_single),
+	KUNIT_CASE(mctp_test_route_input_sk_fail_frag),
 	KUNIT_CASE(mctp_test_route_input_multiple_nets_bind),
 	KUNIT_CASE(mctp_test_route_input_multiple_nets_key),
 	KUNIT_CASE(mctp_test_packet_flow),

-- 
2.39.2


