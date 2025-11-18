Return-Path: <netdev+bounces-239441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D575C68640
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D59772AB4A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79F304975;
	Tue, 18 Nov 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="kL7sLmBd"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4150310768
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456104; cv=none; b=CKj3Id7oRjuGkqzh9oAJBu1UjBT9zMBNQbttSG8TnFmJ5uGwkWobSIsorZtzLE5NhoeEFWpDQtt17NOlTrVgv2ZzIRy4YIcOAe60qzXTnK6Ue6/cojxxOcKwuxkDWi/6OFXlvAjLdIXwPhekLPN2Z41B2Vjj32y2sP0VSwmFtMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456104; c=relaxed/simple;
	bh=FmE0JsE1db3gWDl9Q+a9q78ahhxX1Ml52P13gMbUvDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDK67KgBp5tB0WABi1QYBx2bTrMeFDehj3e/qBbyvofktdoUO7QA1ifdrzrvzYogb2dLUrzhXWk9y8EeKOhfNz/bvV9jVYdiVG0r8ds9+or8ii6xJr+xY9vcyLTJ8IzSEcV8qYjDjojWPoHiLnO0TGGEgGTo1O/ZxlBA2IQwpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kL7sLmBd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9E8DE20853;
	Tue, 18 Nov 2025 09:54:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LAt2IA2Wymp0; Tue, 18 Nov 2025 09:54:58 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CA6542084C;
	Tue, 18 Nov 2025 09:54:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CA6542084C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763456098;
	bh=ANYh+/HBYVgbZ01zfzmE1j0vsfzagGKSMyZwulVzPy0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=kL7sLmBdLM/ujfVmZcztJuYicKgq7h9DiN7yzc7TfqLwLf/MqvMlsPGVeWErQHGYg
	 u2lM9lqo0vXitaYSAoOaYCYWYlKUAVTgy4EKsmtF9w07iAnWsG2FMph1u1SG20Ycfd
	 Dc5EOXoCPWvRsgXfRdy/iHjiq2/IeUgqPomkm6BjTpTdvkV9FjgKm139wJDjXN2J5G
	 Hc/NTp/Ljs7che57jP4rbpI+TlMmkW3AH61oiIsHreYHWMWX9gMvfvt8jQrM8sxWlD
	 +90h3Dlyeewe8qpO23gDYqO9Nfn2YIpyO9DRbMcJu0jhlefhj3X/dh75uxsIrwpMw/
	 fSNd77uEdqqmA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 09:54:58 +0100
Received: (nullmailer pid 2200681 invoked by uid 1000);
	Tue, 18 Nov 2025 08:53:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/10] xfrm: fix memory leak in xfrm_add_acquire()
Date: Tue, 18 Nov 2025 09:52:43 +0100
Message-ID: <20251118085344.2199815-11-steffen.klassert@secunet.com>
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

From: Zilin Guan <zilin@seu.edu.cn>

The xfrm_add_acquire() function constructs an xfrm policy by calling
xfrm_policy_construct(). This allocates the policy structure and
potentially associates a security context and a device policy with it.

However, at the end of the function, the policy object is freed using
only kfree() . This skips the necessary cleanup for the security context
and device policy, leading to a memory leak.

To fix this, invoke the proper cleanup functions xfrm_dev_policy_delete(),
xfrm_dev_policy_free(), and security_xfrm_policy_free() before freeing the
policy object. This approach mirrors the error handling path in
xfrm_add_policy(), ensuring that all associated resources are correctly
released.

Fixes: 980ebd25794f ("[IPSEC]: Sync series - acquire insert")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 9d98cc9daa37..403b5ecac2c5 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3038,6 +3038,9 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	xfrm_state_free(x);
+	xfrm_dev_policy_delete(xp);
+	xfrm_dev_policy_free(xp);
+	security_xfrm_policy_free(xp->security);
 	kfree(xp);
 
 	return 0;
-- 
2.43.0


