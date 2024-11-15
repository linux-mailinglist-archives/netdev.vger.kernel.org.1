Return-Path: <netdev+bounces-145201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A259CDA9D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1E71F24CBC
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CACA18CBFC;
	Fri, 15 Nov 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="EC0kt2n2"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5C18A6AD
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659638; cv=none; b=JVOtEtW9Qix/yq+C1Xi6g12mPeBz9lUHKpD70vd0whji/14+Et+QQL1NRd7kuju3tCTFQLfUb0krdDT5FBo39vnWhYtXhEy2Yc8eUb3QTHLjPzQ6RDb57kYVlAd2fBwTT4dPb6UpuvD/MLXHItfausPiEJJKE6BiNZgmyiBHQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659638; c=relaxed/simple;
	bh=+x64WDMW8S/L0AHk/GxN9XZiPc7c5et2vuBfh1eqZuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDzEhOq2tPzv0dREuXzzIH9N3YLcII6i9euGIRnwCmphEgYXpkDiiNyTiaCuLe29OCl7q2VavNPbMGTaow0XahbX7L/2sL87Gru8Ri2SsSOlpVEbLHeWK1xbJpEaOPLOIFMH3nkES3ltTyGdehaFwoQsRJtsqgOjMxTz41nyWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=EC0kt2n2; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6AB16205CF;
	Fri, 15 Nov 2024 09:33:55 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FpHrwP2OlkOk; Fri, 15 Nov 2024 09:33:54 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EFFAE2085A;
	Fri, 15 Nov 2024 09:33:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EFFAE2085A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731659634;
	bh=BsVrulECb8CVqxpWapm5mHavTgKPZFE5LbWuQm9532s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=EC0kt2n2+/kcdtq4Z8/bomQHP/habif4J7wmmKF9sGlHI05DoxGLMUSlmFap8kgko
	 OjQElwZj6jsDEJRJiauElDY4JkoLZOq5fm/5TtxixibiwswXmvlaUGA1MRCWHF2vGi
	 0celxaO/yXOqEittVCGHyZZRDxff2kpd4iPOt8iJWqgn+WbK0l1pk3bp5L0Fz57UKd
	 IjQ5TGWMazqOiK4BAMrEgl7nf4pvDbvZyh9J4tGZfk7EC+tHP9D+NKt9pTnG91P2ZN
	 GOAqruGt7POs3acIa1Ls8eAQEwtU7DP3cfqIFgb4icVEO3fe7ij+/sU87THfbVulIf
	 ZxzIyE9QDOKDA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:33:53 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:33:53 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id BF76F318442C; Fri, 15 Nov 2024 09:33:52 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/11] xfrm: Convert xfrm_bundle_create() to dscp_t.
Date: Fri, 15 Nov 2024 09:33:38 +0100
Message-ID: <20241115083343.2340827-7-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Guillaume Nault <gnault@redhat.com>

Use a dscp_t variable to store the result of xfrm_get_dscp().
This prepares for the future conversion of xfrm_dst_lookup().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 51a071a79016..ecb989347bd4 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2678,13 +2678,13 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 	int header_len = 0;
 	int nfheader_len = 0;
 	int trailer_len = 0;
-	int tos;
 	int family = policy->selector.family;
 	xfrm_address_t saddr, daddr;
+	dscp_t dscp;
 
 	xfrm_flowi_addr_get(fl, &saddr, &daddr, family);
 
-	tos = inet_dscp_to_dsfield(xfrm_get_dscp(fl, family));
+	dscp = xfrm_get_dscp(fl, family);
 
 	dst_hold(dst);
 
@@ -2732,7 +2732,8 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 				family = xfrm[i]->props.family;
 
 			oif = fl->flowi_oif ? : fl->flowi_l3mdev;
-			dst = xfrm_dst_lookup(xfrm[i], tos, oif,
+			dst = xfrm_dst_lookup(xfrm[i],
+					      inet_dscp_to_dsfield(dscp), oif,
 					      &saddr, &daddr, family, mark);
 			err = PTR_ERR(dst);
 			if (IS_ERR(dst))
-- 
2.34.1


