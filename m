Return-Path: <netdev+bounces-200960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E943AE78B9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F6F16D2B6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF68217F35;
	Wed, 25 Jun 2025 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZutuHPt+"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A020C037
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836912; cv=none; b=LklfQ5JDYd4Cc1Ki0LzjhP6U8vByacYct06Gp0L8uFItyjQMkg9woGuSGVteBYttnd6wuhgb9Y4YOHVOgQn1C4MQpkkJPm3EwvsbmgNAKGSJLPYpX3vVZcuiP59GtTf83FX4/S4wr+M4AchwRoQZRBwPZPnyFDuI66gKvaX7Ong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836912; c=relaxed/simple;
	bh=4qigbWYhFZOuTzmuPTFXTGczmlH/Ux1eOJb7EVzdz+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8H/cSANQGc84foVmrpiYQL1vl5HGLSw9XEcSQQULABTYHIfj+U5E0H0/y22GKw9fEg/pPF9vKOUGzFb1zwOa4yfNbk2ekLB4CFS0kgHr4jWZ5QrQHJ9rNxG/TGSp/JNjtNMXkZyAumCRQmNdMiQmCXBvUfDKb3RPRjbGDG+jBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZutuHPt+; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750836906;
	bh=mGA5jNXvPrCRldSueMt/QQq8WqXM0iV9yk4RG/NywXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZutuHPt+h6/RBP+nI9De8i6RKLmm6ifasmiXLahj5Cl5qT8X+nI/dpZ93i71WGowH
	 X8MacYYBK2qTjjnTUI3o7hr1teLkRzd2lipYu1b+BrT6ws1wyqQ52I0SKERXn7qG3C
	 5YJ63YMDsXVQcDTf97oqge/POt76yC9x+BOx4IehDp9+TrD0Y+FjuDKXAgtPYBgzVg
	 q7oKyTQmvb7nhSuIR32RPCWlFMvor6Ci/XcU4SWZD0vAKtAPMB2wyhPQoAtZuI2NcH
	 kgyW8aVl+PxC69DvMn/hAwlE0Muv6CJaidzylzZ81Nr/SBo7HRrK1cCpkw3NKZpw4G
	 kDtAH8gFp6Uow==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 448CA69A3C; Wed, 25 Jun 2025 15:35:06 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 25 Jun 2025 15:34:44 +0800
Subject: [PATCH net-next v3 06/14] net: mctp: test: Add extaddr routing
 output test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-dev-forwarding-v3-6-2061bd3013b3@codeconstruct.com.au>
References: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
In-Reply-To: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
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
index e611cf0969d42eea3d01651b4aeed525ebde70c6..248d28a4a3ddb3ac531e645d806aba6946efc36d 100644
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


