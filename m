Return-Path: <netdev+bounces-77866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D2C873412
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A56290808
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E6F5FB95;
	Wed,  6 Mar 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SQwVbHLH"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1525F86B
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720670; cv=none; b=uBQYbfUXFelJR8o7zF+TsWLWhvyG+glqDk0NiqlYWTY+fiSmp7pm2T+98+GZ3cCxwsFzK9vtq97L1ECDtTOQhOkGBce2/RUO4ymZKAywWVUenNm+g5+59T2R1wNWktfQXz/BAsRUbB3R/NuTZJoa9WuFXYDF8DvQ4eVGaZlxJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720670; c=relaxed/simple;
	bh=ZhFcmnEKjsZ1Kqn13cZ/lFiY//oG8A+sNY/HR6ojCxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGVA7URtajqOlxPgbModti5rG7Fdu3VHWSG9SHqhUuG27ucJlsls/TVb2l/SzWJZdSBiWw+uic2r8jDY2qDAGgpTDBfeD5gxuc27NmKLGWDE4oo9MXFB4ovspclC6qObaq6RF7gXHrYNyuD2wKOZJYruA+57hJmO5y6p45E78rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SQwVbHLH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 48532207BB;
	Wed,  6 Mar 2024 11:24:27 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QG6XxBx7ti7W; Wed,  6 Mar 2024 11:24:26 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E522A20799;
	Wed,  6 Mar 2024 11:24:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E522A20799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709720665;
	bh=hjo3cNSd7qrjKyswWYCKOoefBhGDkhGj0fjPHu7b4YA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SQwVbHLHd8i9emqMzPb4q38kLwQr24gLQ2gv1qgrGpjVaLFKSUIfmjKq4MUWWHnVh
	 kAm+4wDi+e3Y+mc2bb6SYg1asTtskxIn8E8nyOhr5yclTL/qH09dVPwU9wxTA/GfSt
	 ugrEC6Q7yYQoTffXP7BZ4Sp6cRF23+EI+oRgmicNCW4P3pDuESs5OiPjZfXWKTkEP9
	 L9R/QvzprB9iim2HcnNB3nDkqgmh3QRr4aMVIfxgcNoMoU3zXtNimgupw/LDf0Qpzq
	 8goNhSzlAc1p0RwDOh81bC7ZLNJrfUz1lSzS3uAaYE4zVZk8tL074+4BO1Zqoih9z2
	 ShpwexHyEINzA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id D959680004A;
	Wed,  6 Mar 2024 11:24:25 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:24:25 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:24:25 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 3983431829AE; Wed,  6 Mar 2024 11:24:25 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/4] xfrm: Simplify the allocation of slab caches in xfrm_policy_init
Date: Wed, 6 Mar 2024 11:24:20 +0100
Message-ID: <20240306102421.3963212-4-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Kunwu Chan <chentao@kylinos.cn>

commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
introduces a new macro.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index b4850a8f14ad..53b7ce4a4db0 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4163,10 +4163,7 @@ static int __net_init xfrm_policy_init(struct net *net)
 	int dir, err;
 
 	if (net_eq(net, &init_net)) {
-		xfrm_dst_cache = kmem_cache_create("xfrm_dst_cache",
-					   sizeof(struct xfrm_dst),
-					   0, SLAB_HWCACHE_ALIGN|SLAB_PANIC,
-					   NULL);
+		xfrm_dst_cache = KMEM_CACHE(xfrm_dst, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
 		err = rhashtable_init(&xfrm_policy_inexact_table,
 				      &xfrm_pol_inexact_params);
 		BUG_ON(err);
-- 
2.34.1


