Return-Path: <netdev+bounces-209239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F4B0EC93
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D207A49E3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9701B27932B;
	Wed, 23 Jul 2025 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Kiz27qWS"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A727702B
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257645; cv=none; b=j3FdvvlhtAvIFa7FcIcJtAS5jRuuFzFUt1zZtOkr1KEy16pIrMAzNDY19HiH2P5DIXZRlloRBJktoGyuPe+h+z0Zk3leKf0NvQUDrgly2Fn7kUbOlxOD9bpXDTRANGPznFl++shNEH+GyPvVmyuYYaldbFthNKor9Nmjc4OOAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257645; c=relaxed/simple;
	bh=SsM0Tmc5D3YyHScnpTcxwIKzuA/LkgwYvJ3XmOUbD00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdazCzMAi/+bSs99/9ZsNgoo4zgh2QPPGb4/WaRXDuQbpEHJgH/CbvFFmjuQb83cjVF29e60JXUTNnhxs1MJazmMH5m64GcxmVKIedcbn5Ojq8pcrR47D2QokiEWwTXAZH0KxKc7BX1vn0iiVYItUmDek8TGLCcpApKoCkhDYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Kiz27qWS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 299542088A;
	Wed, 23 Jul 2025 09:54:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VXvsNQr2gWUg; Wed, 23 Jul 2025 09:54:21 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AFFDF20892;
	Wed, 23 Jul 2025 09:54:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AFFDF20892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257260;
	bh=tpmchTW64S8TMwG019sobKSCAtLKi303KwyrjUdV5aM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Kiz27qWSeyo4SeuVatIuYcNmanc5VeUry9iMdetexPQl78KQVPrDk/pzut4TDVfD0
	 aEpdGAq5j8Aq5uE6M/mN1v2M2R2vVuXvz6LLnplFPXrrqgEw5dwEcu6B7o9eUpJfFI
	 5u9Dx6kNAcR2SNPSbc/aJoevFEcslp4zpD852Dr0Za59U6kWmxCZ1GHZqQgebfq20A
	 jrP3AMoYDfnI66IuGQQ0n+sYDV3+m/Hg+2vHOAt0Kx78S6sgVZjTwy96k7ICpbVY/n
	 t0UtVAXfOxnK7UqfL8ZyFWZTh/WfBGOP8CaJl9gU48SJU2zC3S2E98kYc/Sr5ezEO9
	 vcEu4yzTFyBng==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 09:54:19 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9B860318410C; Wed, 23 Jul 2025 09:54:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/8] xfrm: state: use a consistent pcpu_id in xfrm_state_find
Date: Wed, 23 Jul 2025 09:53:54 +0200
Message-ID: <20250723075417.3432644-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723075417.3432644-1-steffen.klassert@secunet.com>
References: <20250723075417.3432644-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

If we get preempted during xfrm_state_find, we could run
xfrm_state_look_at using a different pcpu_id than the one
xfrm_state_find saw. This could lead to ignoring states that should
have matched, and triggering acquires on a CPU that already has a pcpu
state.

    xfrm_state_find starts on CPU1
    pcpu_id = 1
    lookup starts
    <preemption, we're now on CPU2>
    xfrm_state_look_at pcpu_id = 2
       finds a state
found:
    best->pcpu_num != pcpu_id (2 != 1)
    if (!x && !error && !acquire_in_progress) {
        ...
        xfrm_state_alloc
        xfrm_init_tempstate
        ...

This can be avoided by passing the original pcpu_id down to all
xfrm_state_look_at() calls.

Also switch to raw_smp_processor_id, disabling preempting just to
re-enable it immediately doesn't really make sense.

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 2e2e95d2a06f..7e34fc94f668 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1307,14 +1307,8 @@ static void xfrm_hash_grow_check(struct net *net, int have_hash_collision)
 static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
 			       const struct flowi *fl, unsigned short family,
 			       struct xfrm_state **best, int *acq_in_progress,
-			       int *error)
+			       int *error, unsigned int pcpu_id)
 {
-	/* We need the cpu id just as a lookup key,
-	 * we don't require it to be stable.
-	 */
-	unsigned int pcpu_id = get_cpu();
-	put_cpu();
-
 	/* Resolution logic:
 	 * 1. There is a valid state with matching selector. Done.
 	 * 2. Valid state with inappropriate selector. Skip.
@@ -1381,8 +1375,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	/* We need the cpu id just as a lookup key,
 	 * we don't require it to be stable.
 	 */
-	pcpu_id = get_cpu();
-	put_cpu();
+	pcpu_id = raw_smp_processor_id();
 
 	to_put = NULL;
 
@@ -1402,7 +1395,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, encap_family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 	if (best)
@@ -1419,7 +1412,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 cached:
@@ -1460,7 +1453,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 	if (best || acquire_in_progress)
 		goto found;
@@ -1495,7 +1488,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 found:
-- 
2.43.0


