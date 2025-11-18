Return-Path: <netdev+bounces-239435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B04C68603
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 968552A616
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1BB32E12B;
	Tue, 18 Nov 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="baF/m4eG"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68332C33A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456043; cv=none; b=ZYrFOBVdpjeV9LH/WkYe3eVZohrq/So0iS+wK2g2+TDElfpWqb5Rjv/V5dlarNQsRWU70JiQ+pB/zIFmn/RtZUNW9Ifd/oYLNFzJCQ34gZYn+jLuJO5mOuImqDnB1mqj3jGESm9ZY8JP47WM/OGwog96fuVyVf/DwWX+fIerTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456043; c=relaxed/simple;
	bh=zm+TNKVn91ZW3ASao/wstRGHcKPQKEZ+XZpl1fqrK5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBLcvtlSpGKcok4Yo8mFejOIWM7zhHlGqB71hDaA5g9qmFvS/QoZEzcWv53+pK3t1PXZf+tCPsaIrvhJSg8CKC9chvayKqINHY+podmD8SlvtlSLw2oMyQwlCuIybCCjwT4HaeIgRgyrRrjoIl0FGXfGNg6mMlkRvWhawC6o+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=baF/m4eG; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A415220839;
	Tue, 18 Nov 2025 09:53:53 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AhSLELP7HJFw; Tue, 18 Nov 2025 09:53:53 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1E92D2080B;
	Tue, 18 Nov 2025 09:53:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1E92D2080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763456033;
	bh=C+TskNxsOQzS9iOT6P22vH+j8EqJRi3Dt8DqAccK+5I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=baF/m4eG9bsdQvdBxCUx81TxP9WlIaHuEW7VZfhzApxsyxHp3Jj1eopnefNso4OAC
	 qgP4nFh67+S6TYyXvjxlU550WU40Ynv22p3XAd8054qIKKHy/xuqLf/Sa4QVH6t1Q+
	 7bu85BW+5yfism3U8ENxo0JGvJrgdXbDibnL0+082MgzKKoWiPVqhl7TRZQ0IkP0xN
	 33m6ZZx7zojHvaDnP8YIemCIH8c4zZi+FfO34LYRQwV8AQpnqH+yvknp2QDishXbee
	 ZM3rQHkIvkMfbICMS9iDOULKZ01Wkq+AP9Y9WGndtCa+dsru6sTADHoTZEJmX0ojXe
	 M26wGwEFGmDZg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 09:53:52 +0100
Received: (nullmailer pid 2200646 invoked by uid 1000);
	Tue, 18 Nov 2025 08:53:48 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/10] xfrm: drop SA reference in xfrm_state_update if dir doesn't match
Date: Tue, 18 Nov 2025 09:52:34 +0100
Message-ID: <20251118085344.2199815-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118085344.2199815-1-steffen.klassert@secunet.com>
References: <20251118085344.2199815-1-steffen.klassert@secunet.com>
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

We're not updating x1, but we still need to put() it.

Fixes: a4a87fa4e96c ("xfrm: Add Direction to the SA in or out")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d213ca3653a8..e4736d1ebb44 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2191,14 +2191,18 @@ int xfrm_state_update(struct xfrm_state *x)
 	}
 
 	if (x1->km.state == XFRM_STATE_ACQ) {
-		if (x->dir && x1->dir != x->dir)
+		if (x->dir && x1->dir != x->dir) {
+			to_put = x1;
 			goto out;
+		}
 
 		__xfrm_state_insert(x);
 		x = NULL;
 	} else {
-		if (x1->dir != x->dir)
+		if (x1->dir != x->dir) {
+			to_put = x1;
 			goto out;
+		}
 	}
 	err = 0;
 
-- 
2.43.0


