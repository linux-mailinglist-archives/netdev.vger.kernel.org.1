Return-Path: <netdev+bounces-199365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D5BADFF58
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BB6189F21F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC825EF9C;
	Thu, 19 Jun 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GiBOcC8U"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B325E47D
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320073; cv=none; b=ZUpGdWSE/kPfzSzGh2Sa/BfE/exBKD/OadBKqs7k6oLzj1my6lTS9Un+u63h0AoI/NmFsVAfyaRZLp+b3taTFeU6cWr6fc9KOANQLtpRb6G9xpWLOtXcKX5VoahriKkJnhTX3Hbc3JbNRGUJWMDoLljGVSjWtD+jtMtROwS4cQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320073; c=relaxed/simple;
	bh=zVuld+2m2MEUitbQZwla1PDS+SinR+fyDsgT1hhK5Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mvp+OsztXOzLYR5X7vZG2X/tgTCnZhbC0nqXPy8SYVr+AXmgQaDE4iYSVBBMYJ+kqHtJiribgpfLBIlz27/Q9+zYdfaHGOLDfKQHcyt9MjY86NF2iA/1p594uz5Kqykz7qpaIikrgpTkeTFQncLiXv3cetYhiSlyrMZyQZDcA1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GiBOcC8U; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750320061;
	bh=/2zf83oVZEReg1d9mh2DMWCAmDDCvhyRZ10CEc9oizU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GiBOcC8UDotx19lVZEOhZXABS9klQHu5v14dn1RPaBXZ1RJZ8aYJl8trOkNo1+amE
	 k8MhOo6GgHLxMiMN99w3hxMkwQF/IiFPE2AJbQKD/DbkSo8dZ+TCHGthFFnF5+8M9l
	 jui4/382r3ByK8BirRLOYwaQTQawscHPEyXQWFB/ea5Y42uEUeEyU3x2itXYsWCbXc
	 YHjbKnmL7GZCjgU6jbzKZ2o8xUktdCsqbwRl11tO9b1Zaqr40NwmK9BchBSMZ9P+8x
	 CloS2JeTR9OKnF67wPp/7FwITh45rRkG0F3zMg6WCPg0tLXU2ikpWj3YsB5ej8u8ms
	 nOPd1nxZBUimw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 9365F68EBE; Thu, 19 Jun 2025 16:01:01 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 19 Jun 2025 16:00:40 +0800
Subject: [PATCH net-next v2 05/13] net: mctp: test: Add extaddr routing
 output test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-dev-forwarding-v2-5-3f81801b06c2@codeconstruct.com.au>
References: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
In-Reply-To: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
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
index bd1bf6f45fdbe8e9278618cb53410ae66e9aa78b..704169f4ba3865aea3f48883de4d46d6a146b639 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1296,6 +1296,58 @@ static void mctp_test_route_output_key_create(struct kunit *test)
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
@@ -1312,6 +1364,7 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_fragment_flow),
 	KUNIT_CASE(mctp_test_route_output_key_create),
 	KUNIT_CASE(mctp_test_route_input_cloned_frag),
+	KUNIT_CASE(mctp_test_route_extaddr_input),
 	{}
 };
 

-- 
2.39.5


