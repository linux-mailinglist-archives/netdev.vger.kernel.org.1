Return-Path: <netdev+bounces-249826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8203D1EB31
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F3AD301D6BA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F93397AC0;
	Wed, 14 Jan 2026 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VpKLDLAm"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC8397ABC
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393112; cv=none; b=JfkZMWoJ415qtpj6sgx6uJEALudb3v/syAOOw8CT0rkCZRXlMENAbbkzZwlptcKpArqRuL34sL4q3LMHMQItncpkh9a5C1lvvs5LsH03yz4oEjM/Chh4H0NePyYQUHoCsIazAbE4KyQonc1dw9UU8vfhJgf9C6WV1puqWpxu9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393112; c=relaxed/simple;
	bh=3Hk+79DPx/CokHYCmuv7/0UqdX4ruuT5JJTzaGJvABk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3OegMUMM8gFXGrb4m/nfJZlq9c60UWUI82WREu274fx14qNIygqmNmybkltW7kRZT4XJI7+KI7MeHKqAv3ltbwdYDEFupOY/6K2LcTwwM8L4/lMtOiLgTMcvBYVILj4xznfwdoPmX1I+nvVck5PusGvbqm3zhD9k9b6p/NIs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VpKLDLAm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D8BE220842;
	Wed, 14 Jan 2026 13:18:23 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Ae4-jT89P_a; Wed, 14 Jan 2026 13:18:23 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 19E0C20839;
	Wed, 14 Jan 2026 13:18:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 19E0C20839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768393103;
	bh=0xafLna32Cmpab5sXdZ6M1Fo7QE9N0HdlZ332aHT5Tk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=VpKLDLAmpucY6Ckkx+18hKJHNJrqh+OekBNn5aon8TaMO0tbGWil/uBChtfoNocyV
	 eT6iM1uoyf9m4GH3jhkFUvjggmfb6KELIAwlEjpaN59ywA93gyAjt7Ln+HZbcut7Vm
	 9Bxh5gae8l8H7+kQzfQgN0ABXLxRhtA0pF3USEN6qh1z0EmuVsOs0QwYWqnDK0VK5e
	 PfyaWuuBwnrqaQHn8f82ef58c34Ma08oddaoPJgvX6RFFpwFXvGgOnkFEQE2cPI9YI
	 IMoTxwD1K+Llz5+OCUJdMGu6LW5cUIYt0XTtKKqohrh5zWgLJnCOeI5XiuAzIEKWr7
	 h6J+VME5jnWcQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 13:18:22 +0100
Received: (nullmailer pid 1106333 invoked by uid 1000);
	Wed, 14 Jan 2026 12:18:20 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/2] xfrm: set ipv4 no_pmtu_disc flag only on output sa when direction is set
Date: Wed, 14 Jan 2026 13:18:09 +0100
Message-ID: <20260114121817.1106134-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114121817.1106134-1-steffen.klassert@secunet.com>
References: <20260114121817.1106134-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

The XFRM_STATE_NOPMTUDISC flag is only meaningful for output SAs, but
it was being applied regardless of the SA direction when the sysctl
ip_no_pmtu_disc is enabled. This can unintentionally affect input SAs.

Limit setting XFRM_STATE_NOPMTUDISC to output SAs when the SA direction
is configured.

Closes: https://github.com/strongswan/strongswan/issues/2946
Fixes: a4a87fa4e96c ("xfrm: Add Direction to the SA in or out")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9e14e453b55c..98b362d51836 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3151,6 +3151,7 @@ int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 	int err;
 
 	if (family == AF_INET &&
+	    (!x->dir || x->dir == XFRM_SA_DIR_OUT) &&
 	    READ_ONCE(xs_net(x)->ipv4.sysctl_ip_no_pmtu_disc))
 		x->props.flags |= XFRM_STATE_NOPMTUDISC;
 
-- 
2.43.0


