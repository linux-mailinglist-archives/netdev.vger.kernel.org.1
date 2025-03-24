Return-Path: <netdev+bounces-177016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326BA6D419
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 07:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DF916B600
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 06:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47223194AC7;
	Mon, 24 Mar 2025 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mGQwOcbn"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8E191F75
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797152; cv=none; b=DRHFSJze1ov22IzrNRIexAmDQu4VKFgN+O5tifSWVujT6Omv4rBXw7nJgC4L3Fs0cJZD4rTRg6fzI+98lFeH12nxSGD0YNcs6gUgOgYdJZpSMlkzBwtEJTSCUuZ2CDcsLAKX5syNrbGP4VWb6Wl9c+4epSqegFjq9wTvIchKRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797152; c=relaxed/simple;
	bh=XLSzQfS2Rcd/otv1pVZavoZHtBojKQsA5AhJ2FvaTfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiJVwp3864StI3JO4wZLBjAuWRsFj3+AewTIS4SUNrCse5ClQHqi+AXLeb7m7xU5eF/QS2/+UQr4dyBrSPASH6K9uOls4iGO9TYPIILwdBKKPWm7vY5yebVfokh5B8xR1QjzfvRxirk2tuRwrla7PAG9NmsuS0sV1IRNk6c4S04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mGQwOcbn; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4748E2076B;
	Mon, 24 Mar 2025 07:19:01 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VFtA59ojw02D; Mon, 24 Mar 2025 07:19:00 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 52002207D1;
	Mon, 24 Mar 2025 07:18:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 52002207D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742797139;
	bh=GAPeqGdRLwLyY1/zyUmvSnpTQ3Eh9TE9Ah+31zrEIJs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=mGQwOcbnQ65B2JxLyFwT8VUDNoA0olwy+GARUauxQCTIhyxUgxaESzqgmMQJGzZ6s
	 lgWG5Jspq0T/YEhO7tEwOjgFreJT9KFP1+EpePamOixFceq5JhdHMD467BWLZbHRLc
	 oVRWmKnPX2+NmPPrioJrIX0uhg3/o9RL++s8HVbuCWS+0fOui2TmctdZCyxQ3YdjFG
	 lZRZsK8L0mSS8+nHGXU6Xl7cv5Eg3M1VXkvRj+hXOH2FrhXW6MlC0sjtuYX+C8Cjff
	 UA4KM4RL6SGjx6BrO2Iib9yWDiFmvRHD3qqMrDwlWK4VAIto54l7d5bVlGvLGTCn1i
	 7zAsBRgNLEXXA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Mar 2025 07:18:59 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 07:18:58 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8DD483183C55; Mon, 24 Mar 2025 07:18:57 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 7/8] xfrm: state: make xfrm_state_lookup_byaddr lockless
Date: Mon, 24 Mar 2025 07:18:54 +0100
Message-ID: <20250324061855.4116819-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324061855.4116819-1-steffen.klassert@secunet.com>
References: <20250324061855.4116819-1-steffen.klassert@secunet.com>
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

From: Florian Westphal <fw@strlen.de>

This appears to be an oversight back when the state lookup
was converted to RCU, I see no reason why we need to hold the
state lock here.

__xfrm_state_lookup_byaddr already uses xfrm_state_hold_rcu
helper to obtain a reference, so just replace the state
lock with rcu.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 7b1028671144..07545944a536 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2313,12 +2313,12 @@ xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 	struct xfrm_hash_state_ptrs state_ptrs;
 	struct xfrm_state *x;
 
-	spin_lock_bh(&net->xfrm.xfrm_state_lock);
+	rcu_read_lock();
 
 	xfrm_hash_ptrs_get(net, &state_ptrs);
 
 	x = __xfrm_state_lookup_byaddr(&state_ptrs, mark, daddr, saddr, proto, family);
-	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+	rcu_read_unlock();
 	return x;
 }
 EXPORT_SYMBOL(xfrm_state_lookup_byaddr);
-- 
2.34.1


