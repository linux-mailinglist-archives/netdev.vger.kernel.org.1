Return-Path: <netdev+bounces-145206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A209CDAA2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26164B23FB2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99B318FDAA;
	Fri, 15 Nov 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XAL2lIEp"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F718F2CF
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659641; cv=none; b=fRjsO5mIvJxXC6bO74mNuA5neuI8s0tfAjqAKW/fM6thaQtnRNnVTCfJ3nEwAZtttTYJMpbgRL0iSlRZ9LoVuNr5iYMhtsTvLnhN+Rj2ubglXV4gewpBQ11hH5cUGZ+tyUBtC6/8ZxuJJiHJ36GLNWohiSqlOB1aw8EsGfLToqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659641; c=relaxed/simple;
	bh=sJoyAqxIyI/Rcv0+dWftZWsk+Os8GSbM8/hdE4r/sZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5YkNRwP7PGzwKpGhA146f/uYdoVB0WJuKSHlwiwRE7VKc7XNMxSIWgv+4xGoHm3MH7Or2Aiy7q5Z9COfxPy1MR16HC84uMulraYk467oItaaD2dINnC62nPslLMT29gCA5fpyer7YXcEujDHapwHyqHj8amHavnXAWNewIIt3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XAL2lIEp; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DECC22084E;
	Fri, 15 Nov 2024 09:33:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nMtqeyuYRPXD; Fri, 15 Nov 2024 09:33:56 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C39A52087B;
	Fri, 15 Nov 2024 09:33:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C39A52087B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731659634;
	bh=FGARKLvUpHLyBjRimmkWlk/8LFcsN/TytdxMHNs/7Fw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=XAL2lIEp0wMYrAXLY4Z2Krp3Q+CSiKVcsA73oBOZut+ZrJ4xjonOymbCOZ+HlRs/w
	 31Fy8AAu97+UHJZ6OLqDdx4F+n89G69sAp4yVSSEeYv3UnqWOU9te4xhuADU5GJoIO
	 KBS4NR6ycH1UrpvId4dWj77qaa3hS0c+4DrAaEHef20B3ShUK5qZqhhnM9FZ/QagFF
	 12dQ/TZQmLQm1RnSgDP5gwXTb8uiWF13uphgvB/0fav6s7Oi3Ce2fnPLwuVJVz3Gu2
	 mzZbfXenok1fnMe6JtUi/NzCd5tfXFTWnrhcxj8cK0gOEP360yg+kHvgRKn8q9kPzX
	 uSU/Ro6Ic02HA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:33:54 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:33:53 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id BBFA631843FF; Fri, 15 Nov 2024 09:33:52 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 05/11] xfrm: Convert xfrm_get_tos() to dscp_t.
Date: Fri, 15 Nov 2024 09:33:37 +0100
Message-ID: <20241115083343.2340827-6-steffen.klassert@secunet.com>
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

Return a dscp_t variable to prepare for the future conversion of
xfrm_bundle_create() to dscp_t.

While there, rename the function "xfrm_get_dscp", to align its name
with the new return type.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 8a1b83191a6c..51a071a79016 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2587,10 +2587,10 @@ xfrm_tmpl_resolve(struct xfrm_policy **pols, int npols, const struct flowi *fl,
 
 }
 
-static int xfrm_get_tos(const struct flowi *fl, int family)
+static dscp_t xfrm_get_dscp(const struct flowi *fl, int family)
 {
 	if (family == AF_INET)
-		return fl->u.ip4.flowi4_tos & INET_DSCP_MASK;
+		return inet_dsfield_to_dscp(fl->u.ip4.flowi4_tos);
 
 	return 0;
 }
@@ -2684,7 +2684,7 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 
 	xfrm_flowi_addr_get(fl, &saddr, &daddr, family);
 
-	tos = xfrm_get_tos(fl, family);
+	tos = inet_dscp_to_dsfield(xfrm_get_dscp(fl, family));
 
 	dst_hold(dst);
 
-- 
2.34.1


