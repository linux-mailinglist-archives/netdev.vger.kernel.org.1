Return-Path: <netdev+bounces-145203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804C79CDA9F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110FDB23FF2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAF218F2F8;
	Fri, 15 Nov 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rQdRdp2R"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7E18E05F
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659641; cv=none; b=uj9Mn95tAsDxdPkheJbaTOdsjLf1tEh330phc5XO70POCKlJDibRb0zsaQMXaGAoGetIRmexcNrNgZoeqSSoQ7Eo8LBiPOHCMaVF8tqfY4K4Tv/gzzVn3tgByiMxL2izk/O++10pqlK8iWTBXqhU+YrOIR4JOYRXXxz6n0eqozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659641; c=relaxed/simple;
	bh=HJ5ljkvsj3SKTa3sftZnuu/BhD7Sb2gWXkxkQsmwCAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iefcNeHez8+RuL2Dq7ijU98QoSm9D+ynjHEZ9Fr3EAsx/OQ/eN4fhUiWfBanruvZhR6ljkxecvVKuaMVJJcHUz3ioJ1gzulYQaRf75kVb7jf00FYOGuPt78T87Kv7pAu7qRHl+/SLfpAOrWaMjpA7RLLHj7Bk4WEwQB/PxvarkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rQdRdp2R; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EF6A320820;
	Fri, 15 Nov 2024 09:33:55 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yf6yo2J1z0-7; Fri, 15 Nov 2024 09:33:55 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 21EA32085B;
	Fri, 15 Nov 2024 09:33:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 21EA32085B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731659634;
	bh=NOviO9ZxcUDUpM/D8aRn/mqS7NfcssNJYMzSjZc6/Kw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=rQdRdp2Rwr8d/N/mjNyOuoB6fTH9Hwso3W9U6nthsD6tE3AUovotFDfRpjLMhZ5tG
	 ouYETdGcLTSv1yZ1X1MPuFX5pAO6IXnBD/2RfILWK7v/TGw8af9SvBnwgmwqZ00I4q
	 CPQqgwu7ZipYxb7Dyp5qa+R3gSnNXVGeZ1OJmYYEEmEpHk5NQxLjekyVZelZ35OErW
	 6ZdhUY/UE+0XIDpD/6keC8ECS9VWUAh2dDC1oY4QyQqVz5jwgMfaPA6MQC7kQhPx4Z
	 zA3KcSwjh1i8fomT6EF/kUB9sMfU5VkqmS/vtccBoxc/ecI+iVt9IBs+MUbGDrg2qt
	 Tavmszy8YNbpg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:33:53 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:33:53 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C37D33184483; Fri, 15 Nov 2024 09:33:52 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 07/11] xfrm: Convert xfrm_dst_lookup() to dscp_t.
Date: Fri, 15 Nov 2024 09:33:39 +0100
Message-ID: <20241115083343.2340827-8-steffen.klassert@secunet.com>
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

From: Guillaume Nault <gnault@redhat.com>

Pass a dscp_t variable to xfrm_dst_lookup(), instead of an int, to
prevent accidental setting of ECN bits in ->flowi4_tos.

Only xfrm_bundle_create() actually calls xfrm_dst_lookup(). Since it
already has a dscp_t variable to pass as parameter, we only need to
remove the inet_dscp_to_dsfield() conversion.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index ecb989347bd4..7e3e10fb9ca0 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -289,7 +289,7 @@ struct dst_entry *__xfrm_dst_lookup(int family,
 EXPORT_SYMBOL(__xfrm_dst_lookup);
 
 static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
-						int tos, int oif,
+						dscp_t dscp, int oif,
 						xfrm_address_t *prev_saddr,
 						xfrm_address_t *prev_daddr,
 						int family, u32 mark)
@@ -312,7 +312,7 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 	params.net = net;
 	params.saddr = saddr;
 	params.daddr = daddr;
-	params.tos = tos;
+	params.tos = inet_dscp_to_dsfield(dscp);
 	params.oif = oif;
 	params.mark = mark;
 	params.ipproto = x->id.proto;
@@ -2732,9 +2732,8 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 				family = xfrm[i]->props.family;
 
 			oif = fl->flowi_oif ? : fl->flowi_l3mdev;
-			dst = xfrm_dst_lookup(xfrm[i],
-					      inet_dscp_to_dsfield(dscp), oif,
-					      &saddr, &daddr, family, mark);
+			dst = xfrm_dst_lookup(xfrm[i], dscp, oif, &saddr,
+					      &daddr, family, mark);
 			err = PTR_ERR(dst);
 			if (IS_ERR(dst))
 				goto put_states;
-- 
2.34.1


