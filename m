Return-Path: <netdev+bounces-110773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F171592E3F3
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87181F225DA
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A4157495;
	Thu, 11 Jul 2024 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jirCdixN"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E03C1474D3
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692038; cv=none; b=bzt+ndiyUBlBnzovYT62qJ/oBkkTG7TMsDuqNvv0xbnuU7AHcsAp9+udPr4iydvyB5lZ7CguqSSlR/RhViP75sF6zLC33m13GskYrz5rM3pOUg+Kp1oqj5BXXuQoYQgh20uHdlCo8Q8IL89uom8Suyw2HSwxzxek55h1HZ4udEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692038; c=relaxed/simple;
	bh=VOZzhE9pxcQmjUIAg37y42UCTVLj/7LagEhZ+48WmOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaamMHhUfiPOksRWkyeVc2VzFVPGz7V6sf1hd4GkEISHdWfyna51zC7pNrkKLBrDUcnsbG3YmSSXHAKYEfap1WsPyKWWusBj32+wr4rQEyLe0CoIaB1VQOzMMKePONj0QFViLW4dpLX/SpF7Ih/DMytIdyCCHgaZ6ktFh6Gg3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jirCdixN; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E37CA207A4;
	Thu, 11 Jul 2024 12:00:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xeHmUabFlEFo; Thu, 11 Jul 2024 12:00:34 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AA0D02083E;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AA0D02083E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720692032;
	bh=jKWkEPqUai1p45mDFTdxaeo1JnNazLiv4uPxQ7LJl+o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=jirCdixNVPERo1y5D7L2Q6cu2/sJlu604cQ1rSbFGgD+CNph+8XyGgz2Mlk0TNVFw
	 zs+YCLh7+EtYaAFv2eu+8e3fytjzzqardTHhNSlyqCNWrXPQw8E+PVz1sQ+ZbvH7R7
	 cwQZjaKnun9fG5Ym6wzA8m1wr2SMKYUjdBFT9K8vE52QKigXooqJWLwATyryen9Ghb
	 gtB24QtBUXbfuDNy3bSZ+CJM7MwWK/QN8a/Ujhpeo1hJ4X3XQFk9kTJjuEBX+1Yi9m
	 shnly1W+8X8pf8JMEAfYj7D+fDHkv9yhy05rzfh37/MHU/YZT+eeerQeircH5MmAV1
	 Gntx7YDeruLPA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 9D63180004A;
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
	id 139C53182ECD; Thu, 11 Jul 2024 12:00:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/7] xfrm: Export symbol xfrm_dev_state_delete.
Date: Thu, 11 Jul 2024 12:00:23 +0200
Message-ID: <20240711100025.1949454-6-steffen.klassert@secunet.com>
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

This fixes a build failure if xfrm_user is build as a module.

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Reported-by: Mark Brown <broonie@kernel.org>
Tested-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d531d2a1fae2..936f9348e5f6 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -698,6 +698,7 @@ void xfrm_dev_state_delete(struct xfrm_state *x)
 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
 	}
 }
+EXPORT_SYMBOL_GPL(xfrm_dev_state_delete);
 
 void xfrm_dev_state_free(struct xfrm_state *x)
 {
-- 
2.34.1


