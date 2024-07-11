Return-Path: <netdev+bounces-110771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B1392E3F1
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5771F21BB5
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0946715747C;
	Thu, 11 Jul 2024 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Oi04r2uS"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37B33CD2
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692037; cv=none; b=T8x6+z+Q6a3CWWFdNeaqiCFAYdpqKGGrZgKQPcQWGXY1jNTBqNZJ4f0OmZJDMXyEJS4bgKhStMGImCfvx8cU3L4wvs6wY1Kzp/rBCdC5Je/wNCHVk5IpDjUSehM8F0t7Nb9xe/C5kaEzsmR+GcaqmjenAo1/gaEjxNVCDwHsy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692037; c=relaxed/simple;
	bh=ZAtaPf/2+0Dgo4XMjfKLpSdR+S67OsBXfK71X08Zthc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhahiRNEc4PZfOOJu383gFbsfnSmy0yOP8F4b7jPGgiKhhlAtczD/pKmqzqnR68uHUkictVGboC6G1u5O+MqQDgxE/XIGo5CH5w0056Jgv5fNlQUVNxweY0bT5fX18EGMyEj2wsbPTNSNsngUKIz2bNt7gAPDQVLqXJO8E6aaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Oi04r2uS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2977020860;
	Thu, 11 Jul 2024 12:00:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VdowkGYOTB4o; Thu, 11 Jul 2024 12:00:33 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5A79B20826;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5A79B20826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720692032;
	bh=NaOcMIan44dzWrMBgVeqd758VIZKjq0MhHtltRQc8O0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Oi04r2uSdNw3DVzRYfJFBgm/jst3PAvEgjtx4zmC1Dzjab2DKpwBiSQ3Wrpp/FLRH
	 UlBunlTKY/Hbi1UQmVW0yK3Q6x+u2Ztj8zKakMGHNVNPJ2YaaF6MUjr6jjBeZJES9+
	 dqwEAzbn3Fu0/1zw01ZKPTxJBFPihylyapzQLcZo/sfSAow7B+rBrAhdiTg+cSaFsX
	 9jupGuwMvuJzoI9iQ1v9xClBVb9G9xH8oXefwpYUFeQlS4U+tlqf/HkgWLCZI2YKxR
	 SPkdJQom4TI2PeIPA0+eMXt5ILOY4OilfMsgXK22KQLZy3yMF9rGb7jqDtvFOay4wW
	 glMcNK+CSUkyA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 4D92680004A;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 12:00:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 12:00:31 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 021DD3180C9D; Thu, 11 Jul 2024 12:00:30 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/7] net: esp: cleanup esp_output_tail_tcp() in case of unsupported ESPINTCP
Date: Thu, 11 Jul 2024 12:00:19 +0200
Message-ID: <20240711100025.1949454-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711100025.1949454-1-steffen.klassert@secunet.com>
References: <20240711100025.1949454-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Hagar Hemdan <hagarhem@amazon.com>

xmit() functions should consume skb or return error codes in error
paths.
When the configuration "CONFIG_INET_ESPINTCP" is not set, the
implementation of the function "esp_output_tail_tcp" violates this rule.
The function frees the skb and returns the error code.
This change removes the kfree_skb from both functions, for both
esp4 and esp6.
WARN_ON is added because esp_output_tail_tcp() should never be called if
CONFIG_INET_ESPINTCP is not set.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/esp4.c | 3 +--
 net/ipv6/esp6.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 3968d3f98e08..619a4df7be1e 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -239,8 +239,7 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
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
index 34a9a5b9ed00..3920e8aa1031 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -256,8 +256,7 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
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
2.34.1


