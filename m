Return-Path: <netdev+bounces-209247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A4B0ECA1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994FD188899A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D77F2797AD;
	Wed, 23 Jul 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="i9wXfU26"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB82278E42
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257850; cv=none; b=jh2C14HKUzzFrRPg2e68wJbpbkTd6gOe9Rjwj43vxYSa8GSIx/aZO4EePfKGDOEtn1cKbvbKY05tDaTDNB67M7Ph8oM1ZHU8rMjMkLUv2tckcc/0DzSIGksxeUxCG2/dZSG/2JIm8Jmx0+E1bE+dI97jbU3PiUxzgaJ0DQFAhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257850; c=relaxed/simple;
	bh=NQRTiGIWblFN4lgIuPbDEBRrHkKE0Hpp1A7y6UyqXR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7T7Cp0ZaXRsYJofDUBdwQuAZh/HwS8aYbIWashgGSBlB0o/v+pN9CvKXIAzUuiYcDoj4ORwOspEgmEb4iqQlTlJZp77AsQy7rWtHVfTy5n7MJI8gztZTZZiFGPitmnEpO8Cn43BTz5U5zxqdmhz37ccR56WpZJTC6plBGNyo1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=i9wXfU26; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0DBB520891;
	Wed, 23 Jul 2025 10:04:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K3IGyR49QfQc; Wed, 23 Jul 2025 10:04:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 68A2B20839;
	Wed, 23 Jul 2025 10:04:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 68A2B20839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257845;
	bh=Z4F3zyoXmGEiDpV6GHtnhKZlPDfWNNfcRY1MUc3lUKA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=i9wXfU26XAKpdbgnQLvnmZ0RLQh1RW4RNndOlFyRHrSQ8sqfM+8pB3UIoAa7gT0oV
	 LhLGtLoB5pAFhYh7y7kNVU/KHdxkQyaJlG7GNEvZ2g16Ewju3i1DnTWFCZguqay6ad
	 4iAo90549vNZlFpU1r/a96vHWQ8rsF74upew0DTLevoWrLjZvDw8iw0rflGZM3kU7t
	 5UK2ZblbqKHC6k10Np0+6WVZvmIhPFJA6tST0kxw8km/aiRKFEL7OE9YYODkdR5pQG
	 z3FdZ0GECJYuLyFv3ZCHjJXktnJxgMLpvm/e9Sm2y7jCQmUfDY74AaO6CSd4PxYhLc
	 qZlsL/vBnIihQ==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 10:04:04 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 98CC5318122E; Wed, 23 Jul 2025 10:04:04 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/3] xfrm: hold device only for the asynchronous decryption
Date: Wed, 23 Jul 2025 10:03:48 +0200
Message-ID: <20250723080402.3439619-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723080402.3439619-1-steffen.klassert@secunet.com>
References: <20250723080402.3439619-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Jianbo Liu <jianbol@nvidia.com>

The dev_hold() on skb->dev during packet reception was originally
added to prevent the device from being released prematurely during
asynchronous decryption operations.

As current hardware can offload decryption, this asynchronous path is
not always utilized. This often results in a pattern of dev_hold()
immediately followed by dev_put() for each packet, creating
unnecessary reference counting overhead detrimental to performance.

This patch optimizes this by skipping the dev_hold() and subsequent
dev_put() when asynchronous decryption is not being performed.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_input.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 7e6a71b9d6a3..c9ddef869aa5 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -503,6 +503,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
+			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			goto resume;
 		}
@@ -649,18 +650,18 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		dev_hold(skb->dev);
-
-		if (crypto_done)
+		if (crypto_done) {
 			nexthdr = x->type_offload->input_tail(x, skb);
-		else
+		} else {
+			dev_hold(skb->dev);
+
 			nexthdr = x->type->input(x, skb);
+			if (nexthdr == -EINPROGRESS)
+				return 0;
 
-		if (nexthdr == -EINPROGRESS)
-			return 0;
+			dev_put(skb->dev);
+		}
 resume:
-		dev_put(skb->dev);
-
 		spin_lock(&x->lock);
 		if (nexthdr < 0) {
 			if (nexthdr == -EBADMSG) {
-- 
2.43.0


