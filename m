Return-Path: <netdev+bounces-77856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCD4873382
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECE71C2085C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5FF5F564;
	Wed,  6 Mar 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qdGequKo"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60025EE84
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719496; cv=none; b=l3HCjeLLSsbmCV7b0NDSXr8kXxn+zeBaS5VK1ElB5OWYGj4ES8fOJH6raNZ7+yCZ8vyJtugtLEbah5WwQKAyV9QFDEqDDal+/WW85CEHgh0NLS2z9UD7KAwJUd+U2N3g6X/HtbX2XKqwOv2yfcd4TKgCmITl8Jq4o4SymZegxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719496; c=relaxed/simple;
	bh=Wfl4t2QCLnnvqFdQmf88aoQmJVu/76wDmVV7Jp/Vm3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toW9+tIkzcJi65ZB+Ty8q+jEUT0ojyQ+y4PV8ndRX6oT/cSDhNkV9FwUwG+ZkYAfXMsTd80MZ7oEDUzpPAzidSaEODnoNRMKd6yjUi/uCshcHekGOxbEbMOsAFmQskQHFEVs+HUlU+DLwcNB5gOgXnB1ReOkgQmqTyxXNRvji+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qdGequKo; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 476CB20748;
	Wed,  6 Mar 2024 11:04:52 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ri3l064wrSzw; Wed,  6 Mar 2024 11:04:51 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C0DF520820;
	Wed,  6 Mar 2024 11:04:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C0DF520820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709719484;
	bh=435RrYgIMtBJyDmy2yUQ5NnCNuHUJyowrYG9yWfn8vA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=qdGequKoac/g9SpziUueS4KG9imFPaBfrGT7SMXtEfPZ9zY+Dcny5C8tEuN+8ICay
	 fejswMBs8pzhxvEhlUac5HUiPh3lX5s8M5kiCwjlKHFo8ku+2k3jl+FxwmQSCoGDcO
	 HxhJvghD5JLNwsaDDtGT84PRlbcX0ezWKnxBwzC2qORXeN0RCo+ewyUkYLaKoYG5xx
	 0ZL5nOUNd2y9GcZGys1JvCRLkPAxRXU+gffs0vrOx5ymbft2MqrZ2XB25ibdrJmuep
	 53Fuau5k8Ks6H6fZ/M5vJJiGhpraIPy1UmTlcaIIGBsZnhmOfHBdh2u77nXLma4Ivq
	 PSzd/VjSbcJkQ==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id B2A1E80004A;
	Wed,  6 Mar 2024 11:04:44 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:04:44 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:04:44 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CA0383180404; Wed,  6 Mar 2024 11:04:43 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/5] xfrm: Clear low order bits of ->flowi4_tos in decode_session4().
Date: Wed, 6 Mar 2024 11:04:34 +0100
Message-ID: <20240306100438.3953516-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306100438.3953516-1-steffen.klassert@secunet.com>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
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

From: Guillaume Nault <gnault@redhat.com>

Commit 23e7b1bfed61 ("xfrm: Don't accidentally set RTO_ONLINK in
decode_session4()") fixed a problem where decode_session4() could
erroneously set the RTO_ONLINK flag for IPv4 route lookups. This
problem was reintroduced when decode_session4() was modified to
use the flow dissector.

Fix this by clearing again the two low order bits of ->flowi4_tos.
Found by code inspection, compile tested only.

Fixes: 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 1b7e75159727..7351f32052dc 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3416,7 +3416,7 @@ decode_session4(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 	}
 
 	fl4->flowi4_proto = flkeys->basic.ip_proto;
-	fl4->flowi4_tos = flkeys->ip.tos;
+	fl4->flowi4_tos = flkeys->ip.tos & ~INET_ECN_MASK;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.34.1


