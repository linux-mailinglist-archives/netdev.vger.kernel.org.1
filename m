Return-Path: <netdev+bounces-77868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E586287346E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E110FB2FE3F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52B26027B;
	Wed,  6 Mar 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="kAgUIDzS"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D715D750
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720671; cv=none; b=tJiUm3Tl7pLK/QiuoXdo4DfWSBYEazLsvJJxIMZrUwt4HB/w1c2lUi0qZboExQRCykBsSR1rtmDUE5yvwyjPnQ/imagcTacRX222X8QWPmadlBIUoHf+aOvPJCtKEOqGAs45d/JwjIEPlUso3CPYnz5s/UZDGVdm1uoWzjI9wxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720671; c=relaxed/simple;
	bh=xf+2YnOGp+s4jfA0EUSDEwy7AiMSz2oK62GpsilHvak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnXeSWTrY+nYQ9v26NEOHNL0foxKfQFwr7HK/oXyIs+BbMRU6YDFN/+NRmM16hs9sb37sUFvZIdQpeLQYupy4nj+w43+cSvHanRW51l9zUHZhpke498A7o4mIG4fBJ64ICSFzB+/wBdG/dHJmmNMPo1uHfMs5LdQUsAHenKGO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kAgUIDzS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 39CA72083B;
	Wed,  6 Mar 2024 11:24:28 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kCumlfNhJwvc; Wed,  6 Mar 2024 11:24:27 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 41F91207E4;
	Wed,  6 Mar 2024 11:24:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 41F91207E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709720666;
	bh=ezArLZcv9Yv+NQVH6oaElTJE4ygOCeAtMn5HnAtoHMU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=kAgUIDzSQWR6g9blyO03MLbTwviBQ6z00FLr0WFP7J5rSN/G9nb+yz8SE2TOMlq/T
	 kJYvLgqK/tyhRuxQfmcCcvllr8KlvX8ttOqh1kewivuc5b5diQab7j1C3M11o+QP/y
	 9zPpnwnJ7+8XYdmo7m1rFbKptip8TrzyMk1JtApRcydIjT6UXmdflakooYUvDVtcH6
	 V2o9LiIPsEOzXNXUohgLbUbroZwmeWNMAcQ1OKAq4nkceCBtdDFItNZ3lt0EbH5yJz
	 K7tzbPWN7VaGnxTUP8sm2ak8AJ3VWpNtkF7r6mVyuXZaYJ8z8L/mlm4kF+gD1pH+WV
	 a/WIQvOdexR3g==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 348D280004A;
	Wed,  6 Mar 2024 11:24:26 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:24:26 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:24:25 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 35D09318297D; Wed,  6 Mar 2024 11:24:25 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/4] xfrm6_tunnel: Use KMEM_CACHE instead of kmem_cache_create
Date: Wed, 6 Mar 2024 11:24:19 +0100
Message-ID: <20240306102421.3963212-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306102421.3963212-1-steffen.klassert@secunet.com>
References: <20240306102421.3963212-1-steffen.klassert@secunet.com>
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

From: Kunwu Chan <chentao@kylinos.cn>

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/xfrm6_tunnel.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 1323f2f6928e..0f3df26878a3 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -355,10 +355,7 @@ static int __init xfrm6_tunnel_init(void)
 {
 	int rv;
 
-	xfrm6_tunnel_spi_kmem = kmem_cache_create("xfrm6_tunnel_spi",
-						  sizeof(struct xfrm6_tunnel_spi),
-						  0, SLAB_HWCACHE_ALIGN,
-						  NULL);
+	xfrm6_tunnel_spi_kmem = KMEM_CACHE(xfrm6_tunnel_spi, SLAB_HWCACHE_ALIGN);
 	if (!xfrm6_tunnel_spi_kmem)
 		return -ENOMEM;
 	rv = register_pernet_subsys(&xfrm6_tunnel_net_ops);
-- 
2.34.1


