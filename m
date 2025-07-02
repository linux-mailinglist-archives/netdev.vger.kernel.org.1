Return-Path: <netdev+bounces-203194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF199AF0B81
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5DE4A3F99
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92103225403;
	Wed,  2 Jul 2025 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TujROd+a"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018622257E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437222; cv=none; b=ucxxwhWKKCgIC7+zxAfbXAuSFSjjkNrGCQ4ON+eM58y1wKq9Upw25jGM8GJy3/E5FV24Ze16vpsJ2FNbWM9gvcbgCrFn0b2Q8xM8LI9FJ6YmHZOOwb9akh3kYtSwWiK7Op9lQrFmcQU0vFBx6fC6TEfpqu/jeVSczrC10jqKkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437222; c=relaxed/simple;
	bh=ZJp2HjcVsPoxxoBEkEZHhUQTWbAjLlLOvQCV6m4NcDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLOIRLmIAAeqJ8IsyRc2CB/oIl/yI7xzh7DyLU82qiVC4IED/mqqq9q9FjztLK8aXO7poPIjemDZMnJ2lbTZ38ynPLNtmzWubkYwp9Qad9nzOaMrdtJftGva0eZeuL8F5124dOUbjp4zk0PhdHoZs9MAIGcln8ub+sAZ2py4iuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TujROd+a; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751437216;
	bh=mGu60tlqFztUWyd1Ilm2Hk2b8oLP5dkP5s8S9fOy73I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TujROd+a0QL0ghszM4rsQZF5sapeimkew51vpWOA4YoXnv1swInc28Ig7pOQT6YU2
	 zAMUdUwRUndS2N0bgnQ9DS6dQQSja9CL2fctGKw2h5I48lHjWqkgfOcC3USGiGPVlC
	 ahHMU6sbm50kuyvqG8Uog/fQJ5oc1PzuqtI874BwO5eMfFzZFPw46VvSBSTjiPui/Z
	 nrHd/9m07IM6Rxp9TDUOB/k7MVZPBI7W4SNE8BirbnLa7+6jzbMyEvPW7DarrGC8X2
	 ByixVDQfB+PyrI8PWFX8hmY0ldnCXxjyuUWvDXgel/Egn5zmp1UFzv8bB28tfzLt0t
	 59qFEetakCwTg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id C9D426A70D; Wed,  2 Jul 2025 14:20:16 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 02 Jul 2025 14:20:06 +0800
Subject: [PATCH net-next v5 06/14] net: mctp: test: Add extaddr routing
 output test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-dev-forwarding-v5-6-1468191da8a4@codeconstruct.com.au>
References: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
In-Reply-To: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Test that the routing code preserves the haddr data in a skb through an
input route operation.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 7a1eba463fe77e4419dfeb94341562541a13fe8a..3a1a686e36c36d3ee700a093cbf77da7e25afe56 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1294,6 +1294,58 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	mctp_test_destroy_dev(dev);
 }
 
+static void mctp_test_route_extaddr_input(struct kunit *test)
+{
+	static const unsigned char haddr[] = { 0xaa, 0x55 };
+	struct mctp_test_pktqueue tpq;
+	struct mctp_skb_cb *cb, *cb2;
+	const unsigned int len = 40;
+	struct mctp_test_dev *dev;
+	struct sk_buff *skb, *skb2;
+	struct mctp_dst dst;
+	struct mctp_hdr hdr;
+	struct socket *sock;
+	int rc;
+
+	hdr.ver = 1;
+	hdr.src = 10;
+	hdr.dest = 8;
+	hdr.flags_seq_tag = FL_S | FL_E | FL_TO;
+
+	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
+
+	skb = mctp_test_create_skb(&hdr, len);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
+
+	/* set our hardware addressing data */
+	cb = mctp_cb(skb);
+	memcpy(cb->haddr, haddr, sizeof(haddr));
+	cb->halen = sizeof(haddr);
+
+	mctp_test_skb_set_dev(skb, dev);
+
+	rc = mctp_dst_input(&dst, skb);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	mctp_test_dst_release(&dst, &tpq);
+
+	skb2 = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb2);
+	KUNIT_ASSERT_EQ(test, skb2->len, len);
+
+	cb2 = mctp_cb(skb2);
+
+	/* Received SKB should have the hardware addressing as set above.
+	 * We're likely to have the same actual cb here (ie., cb == cb2),
+	 * but it's the comparison that we care about
+	 */
+	KUNIT_EXPECT_EQ(test, cb2->halen, sizeof(haddr));
+	KUNIT_EXPECT_MEMEQ(test, cb2->haddr, haddr, sizeof(haddr));
+
+	skb_free_datagram(sock->sk, skb2);
+	mctp_test_destroy_dev(dev);
+}
+
 static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE_PARAM(mctp_test_fragment, mctp_frag_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_rx_input, mctp_rx_input_gen_params),
@@ -1310,6 +1362,7 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_fragment_flow),
 	KUNIT_CASE(mctp_test_route_output_key_create),
 	KUNIT_CASE(mctp_test_route_input_cloned_frag),
+	KUNIT_CASE(mctp_test_route_extaddr_input),
 	{}
 };
 

-- 
2.39.5


