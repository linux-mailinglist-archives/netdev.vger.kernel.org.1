Return-Path: <netdev+bounces-203190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECAEAF0B7A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7FD44020A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C0821B9C9;
	Wed,  2 Jul 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AA6Gr8tV"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEC1E8348
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437219; cv=none; b=GsdtcS4kmF1wnkBFbuK5ItSY5fzjTlG/eXbXYqxZZrEWCvgVg5x8DgQdhWvf4HbKhnuNNnndDLZLdm05jCbrdUY5o76RAGUkbG/6vmZ9acpHzY/9qu3dki0PIP/hWX8jmIsk6OlCRQaEWmfEWpCMQ1V7eWc1kc8HTbITExMpvd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437219; c=relaxed/simple;
	bh=Yqo35/JjWo5AKin8vnjQacBT1V0azn+wwWy52bLYP2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8vmTyvuxLblz/5pDU+meHENQwAHRAgqHFAQLxLIQCpvl+VJ/7T8bBrJ+6w76EkzXVtkn5VoSFAZxq1r0/MfQiG9aGFJJPf4lXrLbKmN0AIH80eaPvaliFxg9NSgI3jmPWjK0o4g9xmJDsjyy9I73mynGE1HgXrxr6eSaNv/JYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AA6Gr8tV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751437215;
	bh=NbNRd9b/r2OE6Grr7jCtjxRecGuo5XQxSiiBw8aVTKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AA6Gr8tVSsB6IRT+zppfGrgJv9oP6hqDwHTNeT07TSP8lZ1t+S9aKQ4dCjWMqUsAK
	 LyDHp7MKkx27xeCHnSTTuAdpzYDVMbRI77asWNGGLU0jKSXa0XWTLGNyh19JPgGBMx
	 bVjsPXGdcEXiF5Lz4enfrAhl6Y2owK+0/9NqBAXo4KCDJBvlDVKC3M+lN/dejBMnfF
	 wy894WdEKjR6vunTuocALNAQMt8EVK6LrOpFgmXIoscTRcgej9vglxQ6C0oCj45KhG
	 +tQ24ndjHcJVP+HecDCE9kiPuC4sdwbxnB+a1wWfz2GDtkKu/q8RFlGBeBDv6KSqrX
	 0kS9dB6upQi9w==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 945066A709; Wed,  2 Jul 2025 14:20:15 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 02 Jul 2025 14:20:02 +0800
Subject: [PATCH net-next v5 02/14] net: mctp: test: make cloned_frag
 buffers more appropriately-sized
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-dev-forwarding-v5-2-1468191da8a4@codeconstruct.com.au>
References: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
In-Reply-To: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
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


