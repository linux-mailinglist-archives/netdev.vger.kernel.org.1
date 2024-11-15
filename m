Return-Path: <netdev+bounces-145207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C39CDAC4
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4BE7B24757
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6768D17E44A;
	Fri, 15 Nov 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="awTMG2Q/"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4B14D43D
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660094; cv=none; b=Q2mV4GjuPr4nPWxUIANbKTkjXh6HmL6FTIrnC1m22TvCSGix2luUY/apZqCu1aYwBQ1rj3/OgOlCnkZKbAYM65ZQMxW4BjfQnY47Iot3OafRWmbKQeBfp8Abx+Pi5k1vpzRns5j+PIerU2I6yuTY2nb9qtNcpVG6TW2P9MmEZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660094; c=relaxed/simple;
	bh=VgeaN4rFESSmDTNEsQCmx/xAuDcijxxI9gWOowCNeSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7NFEIS/ESMKD+9y64H49F1zwrZxSrGmn+IVCAuevcRp4N+5+qkU+u2JafjW87+mg4vN3y/9wCw1ZAMePEaHfvZsC9iMca6GWNgRaLx13LNdDu4sdhip3KmwuzVdbR/y/D7at9R9e+OZW7Hf0aGbF5F0UCQtlbz0HJsgdbDryq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=awTMG2Q/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 304CB2064C;
	Fri, 15 Nov 2024 09:41:30 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gMdpg8EigriH; Fri, 15 Nov 2024 09:41:29 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9F6CD2085B;
	Fri, 15 Nov 2024 09:41:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9F6CD2085B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731660089;
	bh=XXDhB26Y3YO7DNhxqanYD56+G2MX+IoLqJe/FL3VaoA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=awTMG2Q/M2jw2l9jvvdAwBe+co2j4865jqnY68V/RY26fQp3XICzhqHxhEGZfOQLz
	 tLVqb2P+sojYfs5pkh5/EAPQrx3iCwJwIM2ON0EVFwmYhcQ8QDiluuED3DzWDePwWs
	 xJzgeVZhNd08tBQ8/IutrNDD5XxRy+Cw2vNgdZth6oXxm/Kac/W9QU+d+9lRRpdcft
	 K8RCl8oGKQPRK4MGBX4nVFEj+b/24Bu06QlR/SvwgDJv/V7iWjziiMQ5esMB8bLZiE
	 HxvrSGigVgR9S5fj74A7k5jw+QIp+ZYwU/6/sNrXy7vylTafJt3OaUUsQoZANEBQll
	 j1iMOYYoLqEPQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:41:29 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:41:29 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D22583184498; Fri, 15 Nov 2024 09:33:52 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/11] xfrm: replace deprecated strncpy with strscpy_pad
Date: Fri, 15 Nov 2024 09:33:42 +0100
Message-ID: <20241115083343.2340827-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115083343.2340827-1-steffen.klassert@secunet.com>
References: <20241115083343.2340827-1-steffen.klassert@secunet.com>
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

From: Daniel Yang <danielyangkang@gmail.com>

The function strncpy is deprecated since it does not guarantee the
destination buffer is NULL terminated. Recommended replacement is
strscpy. The padded version was used to remain consistent with the other
strscpy_pad usage in the modified function.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index fab18b85af53..6b0800c7c75e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1101,7 +1101,7 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 	if (!nla)
 		return -EMSGSIZE;
 	algo = nla_data(nla);
-	strncpy(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
+	strscpy_pad(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
 
 	if (redact_secret && auth->alg_key_len)
 		memset(algo->alg_key, 0, (auth->alg_key_len + 7) / 8);
-- 
2.34.1


