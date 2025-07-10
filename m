Return-Path: <netdev+bounces-205707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D055AFFCFE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E771C86ABE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40FA28FA9E;
	Thu, 10 Jul 2025 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PHyg6HF5"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3928D827
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137771; cv=none; b=UlZ+Ioz+lAaRSeXxihyFZ+HPSPSi8tWhJEHCeecFmkUybb95+4LSd7MBUrDYozE9e+TNItfbwoQIPglJpjKxB9HnGIMrErD6rr83+5JiP4ttULeRlzHLoi5N89rad+U+O9wbHZ527DPwkqkNA7VL/0DopqQYJIIngNXOhHrFTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137771; c=relaxed/simple;
	bh=IWGTAJd6qFLj37iUw18x165Dk7OkJQ6iI4ZnBzyH5Ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoCXqxNDpuclWY2EXyGNQNlbCK2k9tYuPmHz+UwwlMe+qHg0WQBp4qPsvW21KV2Ef4Br8CtRbT+1TkIWrDDLkZrzy0e4AsYQe/FMiq9AMgMmDFfsOziWP5oRuiN3RWTolYE75Iaph0zuI12EXnu9gwm3uDBIlj20+BmcokUbk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PHyg6HF5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752137762;
	bh=BF8vak7Mxr9+BOuAgW/VX5xlEycGXGR0KtCYLLzLVdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PHyg6HF5DY+ts7RWQ9DFjF+nvfcA7EplGfr9Uv5z7+pc6yIHQ7U3/0/FgkKUHdgNU
	 i075NTl3RQecnt3BCBDni8+KDru6wBF4tboeHwJa4dJN5HaPAUiCkGQeTxI87x0ckA
	 BXrVgSj3a5FpF3EES4tIJ0j8L7XzV85Auu7zm4ggrmCZzQO/trgC7K1ii7+PXnWfa1
	 17B1W/U2Q52jGQRrroa/lNZSopNnNxHWQO4vIAP4oVy4GP1VckZ5Kp4KdWRK3rCeLa
	 jQ4koVjUxFtEG7CUyLi8PsYCV8yAbJEQw2H2Zd2J9jxTSPGFs4rRyMY+l7iVUCWeXn
	 Ul202yshCJbmQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 669246B220; Thu, 10 Jul 2025 16:56:02 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 10 Jul 2025 16:55:54 +0800
Subject: [PATCH net-next v4 1/8] net: mctp: mctp_test_route_extaddr_input
 cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-mctp-bind-v4-1-8ec2f6460c56@codeconstruct.com.au>
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
In-Reply-To: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137761; l=1526;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=IWGTAJd6qFLj37iUw18x165Dk7OkJQ6iI4ZnBzyH5Ww=;
 b=MKJy91ChivN/PvSqaO2TZ9JM/6/TLm3kPh5JMOm1vgykCLkeNO2koUMoexsqBgFtNnUNKqqqO
 6UynYCcqmAdB2NI187dRt/HH801CvSxo1yPbJHbh6l0GFHQOL0bRVwg
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

The sock was not being released. Other than leaking, the stale socket
will conflict with subsequent bind() calls in unrelated MCTP tests.

Fixes: 46ee16462fed ("net: mctp: test: Add extaddr routing output test")
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

---
Added in v3. The problem was introduced in current net-next so
this patch isn't needed in the stable tree.
v4:
- Use correct Fixes: rev
---
 net/mctp/test/route-test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 7a398f41b6216afef72adecf118199753ed1bfea..12811032a2696167b4f319cbc9c81fef4cb2d951 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1164,8 +1164,6 @@ static void mctp_test_route_extaddr_input(struct kunit *test)
 	rc = mctp_dst_input(&dst, skb);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
-	mctp_test_dst_release(&dst, &tpq);
-
 	skb2 = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb2);
 	KUNIT_ASSERT_EQ(test, skb2->len, len);
@@ -1179,8 +1177,8 @@ static void mctp_test_route_extaddr_input(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, cb2->halen, sizeof(haddr));
 	KUNIT_EXPECT_MEMEQ(test, cb2->haddr, haddr, sizeof(haddr));
 
-	skb_free_datagram(sock->sk, skb2);
-	mctp_test_destroy_dev(dev);
+	kfree_skb(skb2);
+	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
 }
 
 static void mctp_test_route_gw_lookup(struct kunit *test)

-- 
2.43.0


