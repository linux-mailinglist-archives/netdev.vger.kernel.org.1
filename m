Return-Path: <netdev+bounces-192155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81839ABEB6D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419A44E16EE
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4516F231830;
	Wed, 21 May 2025 05:43:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA64221573
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806237; cv=none; b=HaeIdPb4Zmmg/Hh205/5nCyyfYJZ2iTyxLrC1nakdnt+g8PA9lhiA1gfFPk9CLr+E24iXmzckFvhnCztTJqRiCIB2RBm9Jsvbzmxt81p360uX9iF5Ku+TQheNMa3gc5AJSU4hjJ26ebHnRocxAWbUhRQHQpAR22XEdhEf6z824U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806237; c=relaxed/simple;
	bh=YKWaBzmUfdz9r0u/6/kHnRRmLPkrd+jOq+VY6DRhtEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVEkIXysmczVf8pWKDQhxoDUg+pTV4ZsLC5Eff4MHhqYoL2396Z84A6h2qmVumop2/HyxbQFQ4mr6FS7ryXwMp08mTzJ29IcQ3j/SHOpcHgyLUGjjr4+UpVixne3r9NyNEdiJDXzKcs9LoLoqaNpZBTPA/jMKgM/IHoR+42RZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A78592082E;
	Wed, 21 May 2025 07:43:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WCnr1455LH1t; Wed, 21 May 2025 07:43:53 +0200 (CEST)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E304D20748;
	Wed, 21 May 2025 07:43:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E304D20748
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 21 May
 2025 07:43:52 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 07:43:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2515B31840CC; Wed, 21 May 2025 07:43:51 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/5] xfrm: Sanitize marks before insert
Date: Wed, 21 May 2025 07:43:48 +0200
Message-ID: <20250521054348.4057269-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521054348.4057269-1-steffen.klassert@secunet.com>
References: <20250521054348.4057269-1-steffen.klassert@secunet.com>
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

From: Paul Chaignon <paul.chaignon@gmail.com>

Prior to this patch, the mark is sanitized (applying the state's mask to
the state's value) only on inserts when checking if a conflicting XFRM
state or policy exists.

We discovered in Cilium that this same sanitization does not occur
in the hot-path __xfrm_state_lookup. In the hot-path, the sk_buff's mark
is simply compared to the state's value:

    if ((mark & x->mark.m) != x->mark.v)
        continue;

Therefore, users can define unsanitized marks (ex. 0xf42/0xf00) which will
never match any packet.

This commit updates __xfrm_state_insert and xfrm_policy_insert to store
the sanitized marks, thus removing this footgun.

This has the side effect of changing the ip output, as the
returned mark will have the mask applied to it when printed.

Fixes: 3d6acfa7641f ("xfrm: SA lookups with mark")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Louis DeLosSantos <louis.delos.devel@gmail.com>
Co-developed-by: Louis DeLosSantos <louis.delos.devel@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 3 +++
 net/xfrm/xfrm_state.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 143ac3aa7537..f4bad8c895d6 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1581,6 +1581,9 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 	struct xfrm_policy *delpol;
 	struct hlist_head *chain;
 
+	/* Sanitize mark before store */
+	policy->mark.v &= policy->mark.m;
+
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
 	chain = policy_hash_bysel(net, &policy->selector, policy->family, dir);
 	if (chain)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 2f57dabcc70b..07fe8e5daa32 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1718,6 +1718,9 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 
 	list_add(&x->km.all, &net->xfrm.state_all);
 
+	/* Sanitize mark before store */
+	x->mark.v &= x->mark.m;
+
 	h = xfrm_dst_hash(net, &x->id.daddr, &x->props.saddr,
 			  x->props.reqid, x->props.family);
 	XFRM_STATE_INSERT(bydst, &x->bydst, net->xfrm.state_bydst + h,
-- 
2.34.1


