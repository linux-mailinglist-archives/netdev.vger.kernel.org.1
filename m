Return-Path: <netdev+bounces-152827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D019F5DA2
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A20018913D7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7F146A6C;
	Wed, 18 Dec 2024 03:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mgRi3O1p"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089E913EFF3
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734494027; cv=none; b=ltkeN2431xe/ZaPV+Gypm5RDxiV9gYKThOWpZChmPKqqsjQ8jIgJgD6hjsUTQ8cTfaUCvvobo4upal36gJQfzMkkqllXBVRFD2uggfbm3z6tL9AjNWCW93gLlocWHyoBzjKAyiEMxhLn0d2bhbRFASRaFHOK+R/fRGbieLDZeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734494027; c=relaxed/simple;
	bh=AWcDphPhP6ikj9UH121mnBLcI2f4K9ko2NN1sT31Azc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D6vtaQ20nEYmSkaEMwyeu+a8MA9EMOxGjFTIqfODlyo24REJit4NLzzVbkyUr5o8+Kw9U8N41bNt0hUWHUqsDO/k63nMda7S6CFjjAiofPGWMs7B9DWYQB9uoNV2CqYS/7TRkVHKoE2/VJY/icrX3Jxe8veJM6PIhxVQUajYX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mgRi3O1p; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1734494022;
	bh=88gqRFj7vqfPEMw1Nyuk1b+HvkQ4C61uAzTKo6ObwzQ=;
	h=From:Date:Subject:To:Cc;
	b=mgRi3O1paNHB3lVj3rwiqbgmC2McsmLBuWpNNglbTZV5KEwjZPUNZI5/CSfXCOM1F
	 ZpeqvMSzt3YmKNJKY5dP3oPV5KBeUXJuPqCTShjHrAvGNQW1jz1l9jNdXTxrjkGmvw
	 FzABF3Ys0rX7Xq4Rrx5fyAUSeLKDUqGq73E43cB5KpmCfA2VaynUNk+U17o07+m+Vk
	 X4c148+qfov2kQ6qt+i2C7sUEqesF8LzqRi2fHYhCGpmKtLiMrxvTK+heQbWMcxSog
	 hva6YS2cRk3uosTi3B7wSBqgzMs6hpnZ4a6dL6eEc2Nt+7SwsiCRxJMiB2/ny+2W4p
	 /qo/pdjJypv2w==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id B66D26EAAF; Wed, 18 Dec 2024 11:53:42 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 18 Dec 2024 11:53:01 +0800
Subject: [PATCH net v2] net: mctp: handle skb cleanup on sock_queue
 failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-mctp-next-v2-1-1c1729645eaa@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIABxHYmcC/22MQQ6DIBBFr2JmXQyD2Maueo/GhRmGykIwgMbGc
 PcS112+/1/eCYmj4wTP5oTIu0su+Arq1gDNk/+wcKYyKKk0KkSxUF6F5yOLTmrsWUtLjwGqv0a
 27rhab/CcYazj7FIO8Xv1d7yuP6kdhRTcDcp25m6w1y8Khin4lONGuaWwtNMGYynlB7w9ngSyA
 AAA
X-Change-ID: 20241211-mctp-next-30415e40fc79
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

Fixes: 4a992bbd3650 ("mctp: Implement message fragmentation & reassembly")
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Changes in v2:
- split series into a net/net-next submissions
- restructure reassembly case, simplifying error path, as suggested by
  Paolo Abeni <pabeni@redhat.com>
- Link to v1: https://lore.kernel.org/r/20241211-mctp-next-v1-0-e392f3d6d154@codeconstruct.com.au
---
 net/mctp/route.c           | 36 +++++++++++++------
 net/mctp/test/route-test.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 597e9cf5aa64445474287a3fee02ba760db15796..3f2bd65ff5e3c940c8204dca14327a15a15ba26d 100644
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
 
@@ -503,12 +513,19 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 		else
 			rc = mctp_frag_queue(key, skb);
 
+		if (rc)
+			goto out_unlock;
+
+		/* we've queued; the queue owns the skb now */
+		skb = NULL;
+
 		/* end of message? deliver to socket, and we're done with
 		 * the reassembly/response key
 		 */
-		if (!rc && flags & MCTP_HDR_FLAG_EOM) {
-			sock_queue_rcv_skb(key->sk, key->reasm_head);
-			key->reasm_head = NULL;
+		if (flags & MCTP_HDR_FLAG_EOM) {
+			rc = sock_queue_rcv_skb(key->sk, key->reasm_head);
+			if (!rc)
+				key->reasm_head = NULL;
 			__mctp_key_done_in(key, net, f, MCTP_TRACE_KEY_REPLIED);
 			key = NULL;
 		}
@@ -527,8 +544,7 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
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

---
base-commit: 7ea2745766d776866cfbc981b21ed3cfdf50124e
change-id: 20241211-mctp-next-30415e40fc79

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


