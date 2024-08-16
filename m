Return-Path: <netdev+bounces-119164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1289546C7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5886528155D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E7218FC92;
	Fri, 16 Aug 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fFJPqCZs"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083318FC98
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804180; cv=none; b=s+ISnihPywkyWjo/3uhMY1BcWjmzZ0ZrTm9A9+CyoOsuYbf0tmwu2hjqblzFTgta9Hse/RvHVe0FyyYgGu0AjZEQiD6nk1NThTVOawSSIdE20ilGIJjyusqpUAMIcouoLJM6d1iPThZRftAf/tCiRgUp9isM8qwWLx4rf0cNfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804180; c=relaxed/simple;
	bh=VXDnrnKA6PlumFk21oNOnZd0eV1B5JBwNu72qT9QQOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZVa59/2R8pCJJ+VvUKMddUyTQ4nZm47Xje8KxZmsfAT0aaZO76edv3X3oH0VoCB972uz2I/obmAOzUxCVOtiRhr+QHN9KQponYtBVMaw4ycwxa+BK48/LkJGwC3jGgc+9cj5f+Y/12JzW0ZHMEId1DaOway3Q0lDDwpCoAGIVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fFJPqCZs; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723804169;
	bh=huOy5WWiXKdLaQwOh8vM0BWn5YamttLiUn3xYtf3Byo=;
	h=From:Date:Subject:To:Cc;
	b=fFJPqCZsHi/nvr/OA5OibnqHHCrLyzVMgOHzgaALYvWLO3AALNi5dl3dWk8xceriY
	 tHX+xBTdi9Sz9vMoVmB2AYrsDgeuQspiW0dBMjoP1zDjdpFIP40gyITK5EQyVga7dQ
	 0wK/XxfN4+kyOTy+uXGfT+boSwbNfZ3F8vxHxVDO2bSXc8hqsBCGw6Y4hqUQftzyP0
	 ataIjd17vuFrGg6Af+Q6GkB9DAnfj1CEluiwwYx1x68ssxbCyQe8qeLzfkZIcO5cuV
	 C436nVil+VI4PimiM5H0xVw3M/zqiWfv5aWiEZU5sKre8wk3j1nLjAKdkr95stIRFk
	 4B5drVQVEpGsw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id B9929671D5; Fri, 16 Aug 2024 18:29:29 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 16 Aug 2024 18:29:17 +0800
Subject: [PATCH net-next] net: mctp: test: Use correct skb for route input
 check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mctp-kunit-skb-fix-v1-1-3c367ac89c27@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAPwpv2YC/x2MWw5AMBAAryL7bZPWm6uID2qxEUvaEom4u8bnT
 DLzgCPL5KCJHrB0seNdAug4ArP0MhPyGBgSlWSq0gVuxh+4nsIe3TrgxDfmOi21GsvaDDmE8LA
 U9D9tQcij0O2he98PdgNvG24AAAA=
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

In the MCTP route input test, we're routing one skb, then (when delivery
is expected) checking the resulting routed skb.

However, we're currently checking the original skb length, rather than
the routed skb. Check the routed skb instead; the original will have
been freed at this point.

Fixes: 8892c0490779 ("mctp: Add route input to socket tests")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/kernel-janitors/4ad204f0-94cf-46c5-bdab-49592addf315@kili.mountain/
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 77e5dd422258..8551dab1d1e6 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -366,7 +366,7 @@ static void mctp_test_route_input_sk(struct kunit *test)
 
 		skb2 = skb_recv_datagram(sock->sk, MSG_DONTWAIT, &rc);
 		KUNIT_EXPECT_NOT_ERR_OR_NULL(test, skb2);
-		KUNIT_EXPECT_EQ(test, skb->len, 1);
+		KUNIT_EXPECT_EQ(test, skb2->len, 1);
 
 		skb_free_datagram(sock->sk, skb2);
 

---
base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
change-id: 20240816-mctp-kunit-skb-fix-513710d79cb5

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


