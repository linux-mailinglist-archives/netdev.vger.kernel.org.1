Return-Path: <netdev+bounces-201805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E3FAEB1AF
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873FD1BC6C3F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054227F00E;
	Fri, 27 Jun 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="djuLSddn"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0A27EC98
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014370; cv=none; b=JvlB2b07CFTXScpZ8EhGCHVv67fpeXQbLeyG1lUdH07rSL6/zueN5Nz9Vo0/GIAJTcBu9t+QfIGZ9g0+2MPubyI8tn4iHOVhNG1P4gonWkBsSrADXjox29jH6kd6hiqJ76rP+quzHcpaUzja5cuHCqlY/9EYIwSOAoQWRZH8iAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014370; c=relaxed/simple;
	bh=Yqo35/JjWo5AKin8vnjQacBT1V0azn+wwWy52bLYP2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uq1U7gNMFHYnLorGbT90KxRskpZCRfw4KjB0N1Xzv56Qn8zA3enreNFxQuVG7INcgrncxR7wv7oyImNBBKatY0Xp4KnQnB7D9veS6NP/ERK/ZD2HgZLpB8hsHB8C+UiqtBx1CGvZxgNFJN+GuSAR3pFG1Uz5oFCqndcCIx8cw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=djuLSddn; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751014366;
	bh=NbNRd9b/r2OE6Grr7jCtjxRecGuo5XQxSiiBw8aVTKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=djuLSddnpKTyQcP7eah0eYmFVllLhSuBjJP3VV/ioqW4jmaC6PKf9CZZF/moX+c3i
	 FT76qY1rnLPvbrwCr6Ul4mp9Xnf7+9AlCCSFlJKmvMMG1K9qrnsAFMfARghuGe1G5M
	 C09/RILycEbw6+zMXdMrfM1A7w5pa+PWezqARjNSqPeBKA8K/hJgdxmfNCQc4gBeB3
	 quCqumWoIcGH+/6/YDu3TZgqiPgSWMxKK4EPu92UMqoIOKLV3kTm/D+ohnsucvGDZL
	 dG8X7XbEM9WZjGTsYtP3Gan85hG4wPQnGBIKLPiDPcv8lxEWzS+kWLxFMrtjzrfQ1S
	 cnEG8xj6UpVxg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 2840C69E1A; Fri, 27 Jun 2025 16:52:46 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 27 Jun 2025 16:52:18 +0800
Subject: [PATCH net-next v4 02/14] net: mctp: test: make cloned_frag
 buffers more appropriately-sized
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-dev-forwarding-v4-2-72bb3cabc97c@codeconstruct.com.au>
References: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
In-Reply-To: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

In our input_cloned_frag test, we currently allocate our test buffers
arbitrarily-sized at 100 bytes.

We only expect to receive a max of 15 bytes from the socket, so reduce
to a more appropriate size. There are some upcoming changes to the
routing code which hit a frame-size limit on s390, so reduce the usage
before that lands.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v4:
- don't use const size_t as array size const, it isn't const enough, so
  triggers -Wvla-larger-than warnings. Reported by ktr.
v3:
- new commit, preventing -Wframe-larger-than issues for the upcoming
  change, reported by ktr.
---
 net/mctp/test/route-test.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 06c1897b685a8bdfd6bb4f1bccaacb53b0cd54ba..44ebc8e4e30c6a8f91360926ede99510df2576b2 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -933,20 +933,18 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 		RX_FRAG(FL_S, 0),
 		RX_FRAG(FL_E, 1),
 	};
+	const size_t data_len = 3; /* arbitrary */
+	u8 compare[3 * ARRAY_SIZE(hdrs)];
+	u8 flat[3 * ARRAY_SIZE(hdrs)];
 	struct mctp_test_route *rt;
 	struct mctp_test_dev *dev;
 	struct sk_buff *skb[5];
 	struct sk_buff *rx_skb;
 	struct socket *sock;
-	size_t data_len;
-	u8 compare[100];
-	u8 flat[100];
 	size_t total;
 	void *p;
 	int rc;
 
-	/* Arbitrary length */
-	data_len = 3;
 	total = data_len + sizeof(struct mctp_hdr);
 
 	__mctp_route_test_init(test, &dev, &rt, &sock, MCTP_NET_ANY);

-- 
2.39.5


