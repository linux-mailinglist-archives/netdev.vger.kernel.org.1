Return-Path: <netdev+bounces-239436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A75C68630
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 853CF4EE3BA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A182932E6A9;
	Tue, 18 Nov 2025 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="NPDLsmzU"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378832D45E
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456045; cv=none; b=NrjDV7TEJIGOe+T9m+j/s6ozt7NZo3QD0QE/ldWd+GPDHefmaQMZBwEcgOneVpviTvyZ4Bo4Tb0pDSysqzUy8tpjDSBaKXrg/xhhxx9lpRbCz2pb/OB4mGaWrFq0XI3RzxAHAc1hgvQeBe8mJqIicRVkWX+ZxW5QeX1x5t61Oos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456045; c=relaxed/simple;
	bh=prWCmXNfXu+x6LZQmdpVqohUuWyUCZIJvE+EI50jBUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps2Z+sMtGAdEw71ehLh7he/dXpqhuqTooel9oJ1U3XY38j5I7FWL2aXxR2bKoCBvc+icNlnwJsUO3nNMmeEV4JXpYUjn1P4oxnPslL+ot6tRI9bpZUx+fq7X2TgXcp26m6mAAb1VceKtLye7qIWpefZxxH2yuNXpWw6Gb/LH4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=NPDLsmzU; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 79D652083B;
	Tue, 18 Nov 2025 09:53:54 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k2CDcwA8JIYM; Tue, 18 Nov 2025 09:53:54 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E7ABC2080B;
	Tue, 18 Nov 2025 09:53:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E7ABC2080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763456033;
	bh=XsyvaBu4bQmda/DX7xm7CnYAajthkks81aItF44GzMY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=NPDLsmzUaHqyvBDGqjwpDij56IiLkRmL+zVwbWxhgU4UnJM65B0arUKgFSj8M/5Nr
	 wYHdm5VEwiOAvWK3sXwRA+m9n6ypl6NmC+ORKgWJRQixLdCsZh7kAIryMSgtH8iUn3
	 HFGfUfDO3Q88cj8rbdn1wF2L7dPuoZpfYWeyIZLBC0CHZCQup6LPxHJQRQaa5masP9
	 dwlJPA9DJs/PhbkUXHEzgftghUknxd9RK07Phoc0Fvtm/fawe2CFwqSpxHK0tet8pL
	 M50d/SSrvfFdfY2nUZ/okHCYACFpDMvSVusRBTdzKN5gIqheIa2vEwVLHakouqJX2a
	 BlX7nrER9R8rQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 09:53:53 +0100
Received: (nullmailer pid 2200656 invoked by uid 1000);
	Tue, 18 Nov 2025 08:53:48 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 04/10] xfrm: call xfrm_dev_state_delete when xfrm_state_migrate fails to add the state
Date: Tue, 18 Nov 2025 09:52:37 +0100
Message-ID: <20251118085344.2199815-5-steffen.klassert@secunet.com>
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

In case xfrm_state_migrate fails after calling xfrm_dev_state_add, we
directly release the last reference and destroy the new state, without
calling xfrm_dev_state_delete (this only happens in
__xfrm_state_delete, which we're not calling on this path, since the
state was never added).

Call xfrm_dev_state_delete on error when an offload configuration was
provided.

Fixes: ab244a394c7f ("xfrm: Migrate offload configuration")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1ab19ca007de..c3518d1498cd 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2159,10 +2159,13 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 		xfrm_state_insert(xc);
 	} else {
 		if (xfrm_state_add(xc) < 0)
-			goto error;
+			goto error_add;
 	}
 
 	return xc;
+error_add:
+	if (xuo)
+		xfrm_dev_state_delete(xc);
 error:
 	xc->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(xc);
-- 
2.43.0


