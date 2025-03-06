Return-Path: <netdev+bounces-172279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC9AA540B4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDE0188D8F5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB161624C4;
	Thu,  6 Mar 2025 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="I4FmRYrT"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B896F31E
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228382; cv=none; b=LsPfUWWMnqbT9TurZpSoScFnFRNDIR2epMEOFPjqDd8eGK4I6vbwUo1nvVTQrgIHMXCEYWC4+ZbOwAyCRrGrQVi+t5lhW6nXTK4UBJ8Q5gxNGa06Z1hDW4Fz+HKUMA2uV4DHtI9BkPyPdFbavlPTRC2DbrMdCeVx2RClKfRkBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228382; c=relaxed/simple;
	bh=QILeyB4MV7uXXUbO/0/sP2jnpt46e4ZcszoHLpEw3xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XWAQEmxmwLxcyuHkvxDQsDnTibl0SDoSm6MPknUzrf6D79lmy2cTun/hBjJvtGRVEW0r+Ilv6aVb6z/g7rA6YvdkYNqM6flhMgB2yQV1HGWkbJbPbVodguOYYarjaeVDmD05jgYxiRYdHC0o47AnsWd7uGj3vk73+RA7OQHiaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=I4FmRYrT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1741228371;
	bh=avDSCmlucSdU8MpRjvxWxSZ/IVAY0hRJW4imZBqC/Kw=;
	h=From:Date:Subject:To:Cc;
	b=I4FmRYrTk0zY0wARlaZtQVJQ0Gp48c20ze+x9kzSx3RMvrLJzedtM85sspdZlkmy6
	 U/96psMUQMwjFfpdD3H3sLS67JS/NA9n2tzGz2JZXck5HhqLdnhM2ge2z1jkn4GcPm
	 buoc/bOAAYx3W7lHariu7bfsV3n16yM+tSEUsQtUez5pCYZpa8QrtZIgX1B2vfhfWz
	 Xuwf8Tu52y4F2nkGwOg1ln4WkrMBMtfIk0n2FMrQmQkDyar3ORKzahwm0u/Yzcy+xx
	 1KvCPfb0iw653Sxx9ggYBp6VO8P8kXpA/KIUyuK70KW+0JpiGZBdZAS3lvZHjSzHDi
	 WHH0xvgQ/JVJQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 5458378B31; Thu,  6 Mar 2025 10:32:51 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 06 Mar 2025 10:32:45 +0800
Subject: [PATCH] net: mctp: unshare packets when reassembling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-matt-mctp-usb-v1-1-085502b3dd28@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAEwJyWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMz3dzEkhLd3OSSAt3S4iRdY0sjUyMzM7O0FNMUJaCegqLUtMwKsHn
 RsbW1AJTFdVtfAAAA
X-Change-ID: 20250306-matt-mctp-usb-39252666fd5d
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741228370; l=5772;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=QILeyB4MV7uXXUbO/0/sP2jnpt46e4ZcszoHLpEw3xo=;
 b=1jhsT0KXvXGywDQ5LQgxreh+IFMl4XyEW+SXM4LOtzpXPccYNYd1gvCvp3Rh3oRujH2UcCLXB
 SrrmUXHkNcmCpy/v/lCY4RFeIOyTTCGLMmPGdVIVyC3jS+xRBI6dwDj
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Ensure that the frag_list used for reassembly isn't shared with other
packets. This avoids incorrect reassembly when packets are cloned, and
prevents a memory leak due to circular references between fragments and
their skb_shared_info.

The upcoming MCTP-over-USB driver uses skb_clone which can trigger the
problem - other MCTP drivers don't share SKBs.

A kunit test is added to reproduce the issue.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Fixes: 4a992bbd3650 ("mctp: Implement message fragmentation & reassembly")
---
 net/mctp/route.c           |  10 ++++-
 net/mctp/test/route-test.c | 109 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 3f2bd65ff5e3c940c8204dca14327a15a15ba26d..4c460160914f0131f3191ca24dd51ec7a3fb8cc0 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -332,8 +332,14 @@ static int mctp_frag_queue(struct mctp_sk_key *key, struct sk_buff *skb)
 		& MCTP_HDR_SEQ_MASK;
 
 	if (!key->reasm_head) {
-		key->reasm_head = skb;
-		key->reasm_tailp = &(skb_shinfo(skb)->frag_list);
+		/* Since we're manipulating the shared frag_list, ensure it isn't
+		 * shared with any other SKBs.
+		 */
+		key->reasm_head = skb_unshare(skb, GFP_ATOMIC);
+		if (!key->reasm_head)
+			return -ENOMEM;
+
+		key->reasm_tailp = &(skb_shinfo(key->reasm_head)->frag_list);
 		key->last_seq = this_seq;
 		return 0;
 	}
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 17165b86ce22d48b10793a82cc10192b8749e7e6..06c1897b685a8bdfd6bb4f1bccaacb53b0cd54ba 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -921,6 +921,114 @@ static void mctp_test_route_input_sk_fail_frag(struct kunit *test)
 	__mctp_route_test_fini(test, dev, rt, sock);
 }
 
+/* Input route to socket, using a fragmented message created from clones.
+ */
+static void mctp_test_route_input_cloned_frag(struct kunit *test)
+{
+	/* 5 packet fragments, forming 2 complete messages */
+	const struct mctp_hdr hdrs[5] = {
+		RX_FRAG(FL_S, 0),
+		RX_FRAG(0, 1),
+		RX_FRAG(FL_E, 2),
+		RX_FRAG(FL_S, 0),
+		RX_FRAG(FL_E, 1),
+	};
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct sk_buff *skb[5];
+	struct sk_buff *rx_skb;
+	struct socket *sock;
+	size_t data_len;
+	u8 compare[100];
+	u8 flat[100];
+	size_t total;
+	void *p;
+	int rc;
+
+	/* Arbitrary length */
+	data_len = 3;
+	total = data_len + sizeof(struct mctp_hdr);
+
+	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);
+
+	/* Create a single skb initially with concatenated packets */
+	skb[0] = mctp_test_create_skb(&hdrs[0], 5 * total);
+	mctp_test_skb_set_dev(skb[0], dev);
+	memset(skb[0]->data, 0 * 0x11, skb[0]->len);
+	memcpy(skb[0]->data, &hdrs[0], sizeof(struct mctp_hdr));
+
+	/* Extract and populate packets */
+	for (int i = 1; i < 5; i++) {
+		skb[i] = skb_clone(skb[i - 1], GFP_ATOMIC);
+		KUNIT_ASSERT_TRUE(test, skb[i]);
+		p = skb_pull(skb[i], total);
+		KUNIT_ASSERT_TRUE(test, p);
+		skb_reset_network_header(skb[i]);
+		memcpy(skb[i]->data, &hdrs[i], sizeof(struct mctp_hdr));
+		memset(&skb[i]->data[sizeof(struct mctp_hdr)], i * 0x11, data_len);
+	}
+	for (int i = 0; i < 5; i++)
+		skb_trim(skb[i], total);
+
+	/* SOM packets have a type byte to match the socket */
+	skb[0]->data[4] = 0;
+	skb[3]->data[4] = 0;
+
+	skb_dump("pkt1 ", skb[0], false);
+	skb_dump("pkt2 ", skb[1], false);
+	skb_dump("pkt3 ", skb[2], false);
+	skb_dump("pkt4 ", skb[3], false);
+	skb_dump("pkt5 ", skb[4], false);
+
+	for (int i = 0; i < 5; i++) {
+		KUNIT_EXPECT_EQ(test, refcount_read(&skb[i]->users), 1);
+		/* Take a reference so we can check refcounts at the end */
+		skb_get(skb[i]);
+	}
+
+	/* Feed the fragments into MCTP core */
+	for (int i = 0; i < 5; i++) {
+		rc = mctp_route_input(&rt->rt, skb[i]);
+		KUNIT_EXPECT_EQ(test, rc, 0);
+	}
+
+	/* Receive first reassembled message */
+	rx_skb = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+	KUNIT_EXPECT_EQ(test, rx_skb->len, 3 * data_len);
+	rc = skb_copy_bits(rx_skb, 0, flat, rx_skb->len);
+	for (int i = 0; i < rx_skb->len; i++)
+		compare[i] = (i / data_len) * 0x11;
+	/* Set type byte */
+	compare[0] = 0;
+
+	KUNIT_EXPECT_MEMEQ(test, flat, compare, rx_skb->len);
+	KUNIT_EXPECT_EQ(test, refcount_read(&rx_skb->users), 1);
+	kfree_skb(rx_skb);
+
+	/* Receive second reassembled message */
+	rx_skb = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+	KUNIT_EXPECT_EQ(test, rx_skb->len, 2 * data_len);
+	rc = skb_copy_bits(rx_skb, 0, flat, rx_skb->len);
+	for (int i = 0; i < rx_skb->len; i++)
+		compare[i] = (i / data_len + 3) * 0x11;
+	/* Set type byte */
+	compare[0] = 0;
+
+	KUNIT_EXPECT_MEMEQ(test, flat, compare, rx_skb->len);
+	KUNIT_EXPECT_EQ(test, refcount_read(&rx_skb->users), 1);
+	kfree_skb(rx_skb);
+
+	/* Check input skb refcounts */
+	for (int i = 0; i < 5; i++) {
+		KUNIT_EXPECT_EQ(test, refcount_read(&skb[i]->users), 1);
+		kfree_skb(skb[i]);
+	}
+
+	__mctp_route_test_fini(test, dev, rt, sock);
+}
+
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 
 static void mctp_test_flow_init(struct kunit *test,
@@ -1144,6 +1252,7 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_packet_flow),
 	KUNIT_CASE(mctp_test_fragment_flow),
 	KUNIT_CASE(mctp_test_route_output_key_create),
+	KUNIT_CASE(mctp_test_route_input_cloned_frag),
 	{}
 };
 

---
base-commit: 3c9231ea6497dfc50ac0ef69fff484da27d0df66
change-id: 20250306-matt-mctp-usb-39252666fd5d

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


