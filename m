Return-Path: <netdev+bounces-200957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F7AE78B6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC763BBBC2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A8C214818;
	Wed, 25 Jun 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="iraXLPvQ"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FFE202F71
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836908; cv=none; b=q9srcFoKGg0oJWtUBbm2o7zrbBeGTVy++h7nxBsAfoGNn1waVsOC2aEp5Z9J9Ko1KcoXxWMRcMhF67EK1WZ0MuXp8kfM/8q7POewZSByMRaztIW5ZtOsHISbmsfgzmDpPW9lMaz/tCquFFQgEyTNO2Me/RESoyNQZa88sbP8t3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836908; c=relaxed/simple;
	bh=x5XJLX11OVxvytWlgx9bPoPiJPpRGFoyxsGRUAocDmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CD8ucR57Pq+ckjs6O3Vcpft23bGuZUaaY6zjDpJjYvjMb8rqWH6aHiiNdI1sU+AiXRcFS3hca1XZbtMRCjipU/SpE6CPJ3iHxMFEXYfFDvJfW8/Yrm1YGZnk01FUUYTdsxNsB7T+w56peQ5POd2zia3VYCug70g/wtv92SMIhTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=iraXLPvQ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750836905;
	bh=LuTum6LC4NpDuh9D9Mn/tLBeYa4Q37I11ZlBpCiIklc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iraXLPvQV8BxLoJsTo6VAOd2e6OqyaM/JbbeUOyF0RRMIf+5DzP+WIv01P5rSUkV7
	 QoJWkbcLuomyOy/hvuOnEUGYLb3HPNny6KC2Zac/SuB0JLPrFdeLQEXzl+XUBDti+3
	 gxES17zLXXft/KM5p4uNQlw870fOavEBsrBS8MIeTvrajxyGjaODkGuKCdOaKLyR3a
	 w2YOAFkhGL61OBLwO/e0AxMLx0Kh18rgUibtXZxWwc6dqac0ROhIhT4qX8VmaFxObA
	 3zED3RvIb63E837Nd73PfC5rVy+lIVk3PZ71yXkBSQmJ11t5+AfZmk2l05GBoy4UVI
	 iZV5ZQkHDL6mQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 1A3C069A35; Wed, 25 Jun 2025 15:35:05 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 25 Jun 2025 15:34:40 +0800
Subject: [PATCH net-next v3 02/14] net: mctp: test: make cloned_frag
 buffers more appropriately-sized
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-dev-forwarding-v3-2-2061bd3013b3@codeconstruct.com.au>
References: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
In-Reply-To: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
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
v3:
- new commit, preventing -Wframe-larger-than issues for the upcoming
  change, reported by ktr.
---
 net/mctp/test/route-test.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 06c1897b685a8bdfd6bb4f1bccaacb53b0cd54ba..41c9644704a5dc6237b3820fde3816f2480b5473 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -933,20 +933,18 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 		RX_FRAG(FL_S, 0),
 		RX_FRAG(FL_E, 1),
 	};
+	const size_t data_len = 3; /* arbitrary */
+	u8 compare[data_len * ARRAY_SIZE(hdrs)];
+	u8 flat[data_len * ARRAY_SIZE(hdrs)];
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


