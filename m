Return-Path: <netdev+bounces-96688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E3D8C7270
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E337CB22E38
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2F076023;
	Thu, 16 May 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lHRcDfor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86769D2B;
	Thu, 16 May 2024 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846790; cv=none; b=ExeHYijwIiQrf69ji6P52qKTeC3udtOeOikXHhQFS9M1NzuzyvtayeQlBmexDH9/JPXDRzqZmfuf0+jfuNLNljVy3riGkYqkxItwboHOjsKC6gdAqaGTKxiPxXu8VHzL1is0tlfjh3WSVLqL3VItvF6BEuToIhxHDneMNYfvc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846790; c=relaxed/simple;
	bh=owQIT5HD7OJm8jW2vo7iEeB4HQZrjCDFv0xnzHggShY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fJr2VEi5hkdzfjArZ36cUwAquGl7U3U7MRCrVZUcPDfrQU05ubqMrtVl6S6O+PLPSTzDHt1igAx/bvZGNCllYPA519nCwOG3ic6KwEi5bCgrlTnRTwjaZWiugWv0+Q5FSIRoYO1eDOmHtIfClhY+EJZIlHQPaW0PyJzawCWXmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lHRcDfor; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715846788; x=1747382788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2HnucdSCbwmmrq18H0sTxqOAmaX8YFcHdjs/KVqRrxo=;
  b=lHRcDforotFU1Uqv1GBzrQGutIniwBTctJi4YI1lnmty+aIzfdd7NrEs
   1xp175kfZ0U53xTcagJ663pv4yeh5oJP+MJiUf3WD5icH50e3iPMrMFfC
   ylIU/zGbgwM/uKswuk+WPrZy9bBEo9M8dEd68Wxv+3vYycHcRZ3+GK60r
   s=;
X-IronPort-AV: E=Sophos;i="6.08,163,1712620800"; 
   d="scan'208";a="89622299"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 08:06:25 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:39479]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.135:2525] with esmtp (Farcaster)
 id de62bcfb-7319-429d-bc38-d1d0827c5886; Thu, 16 May 2024 08:06:24 +0000 (UTC)
X-Farcaster-Flow-ID: de62bcfb-7319-429d-bc38-d1d0827c5886
Received: from EX19D002EUA004.ant.amazon.com (10.252.50.181) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 08:06:23 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D002EUA004.ant.amazon.com (10.252.50.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 08:06:23 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 16 May 2024 08:06:23
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 169CC20AC1; Thu, 16 May 2024 08:06:23 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: Norbert Manthey <nmanthey@amazon.de>, Hagar Hemdan <hagarhem@amazon.com>,
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] net: esp: cleanup esp_output_tail_tcp() in case of unsupported ESPINTCP
Date: Thu, 16 May 2024 08:03:09 +0000
Message-ID: <20240516080309.1872-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

xmit() functions should consume skb or return error codes in error
paths.
When the configuration "CONFIG_INET_ESPINTCP" is not used, the
implementation of the function "esp_output_tail_tcp" violates this rule.
The function frees the skb and returns the error code.
This change removes the kfree_skb from both functions, for both
esp4 and esp6.

This should not be reachable in the current code, so this change is just
a cleanup.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 net/ipv4/esp4.c | 3 +--
 net/ipv6/esp6.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d33d12421814..e73de3abe37c 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -238,8 +238,7 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 #else
 static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 {
-	kfree_skb(skb);
-
+	WARN_ON(1);
 	return -EOPNOTSUPP;
 }
 #endif
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 7371886d4f9f..600402e54ccd 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -255,8 +255,7 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 #else
 static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 {
-	kfree_skb(skb);
-
+	WARN_ON(1);
 	return -EOPNOTSUPP;
 }
 #endif
-- 
2.40.1


