Return-Path: <netdev+bounces-126834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EDB9729DE
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EDE1C24014
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA76617E002;
	Tue, 10 Sep 2024 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="h/XCXpUc"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825617C7C2
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951329; cv=none; b=eoxZSOo6DCUVcL4JFLGBjepykxn8EQSOCCvVMq6QmxSJz+C5IXU5nmti9X7eQrX4cP4k1B90PoAS/G+NERe16C70W+6ES37U9kLoGhOp+WKQ3jWv1G2/rVenM7RNM0ZZopwglQJkOPUOJQ01J3AOH5MiqCJyAD9wLb0V6dzryN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951329; c=relaxed/simple;
	bh=o+mxtvuoEYe7IxCiOxq+4IDAUuc9qZ5NfLRRguOA30A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLW5hFlAkg+2nrq4GFGdJYde88fdeT56atQJSYLEwNAfXV5OwXn8/vxSsI5xpgSuPi5TWpcrThoAjDplUtGHwM3JnZ0kYiDDXCkVsUAa+1ie+LA0cdVG8fSEKxZjo/yuxmE0r5AHshaUvNci3SF63yGqNUu4kOTSkf1rLn2PQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=h/XCXpUc; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BC568208A3;
	Tue, 10 Sep 2024 08:55:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zJH7tK_hNm9W; Tue, 10 Sep 2024 08:55:24 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2C50020893;
	Tue, 10 Sep 2024 08:55:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2C50020893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951323;
	bh=8mPIfE8lEMmWMT/wY1yfBpIKylIzisJ1p7evUIA5jDc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=h/XCXpUcIWmH4EU4XwkrbHO5z/143lybZy2JSqDpDpH9PVwYtrvzJvzGNwJeFV6XH
	 GC8pFzVk/+ePlWGivANAYQmU/CYMp9xhs04ogNaF5v5PNzo+06TdKboC59onj8Mol8
	 WrWjAfnV93LtOae/Clh7kiIcict0vA1oZOeDBKClixX/7fXgHM49BsNHN+On2Zpa9+
	 sQIJV4K4nKguRUhkhT6VEyd2ToJTySkhKrjznVdsXjSGJ23lekr34zmpLNEgBpfAM3
	 tdrhQmuVQRxItTprHx8jt7C44tc5L5jHATgsDAgcYxFfI25NZdHerBYSp2Mp1ngogg
	 jGFGTmvO8ZfMg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:55:22 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:55:21 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8A7843184335; Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 12/13] xfrm: policy: fix null dereference
Date: Tue, 10 Sep 2024 08:55:06 +0200
Message-ID: <20240910065507.2436394-13-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065507.2436394-1-steffen.klassert@secunet.com>
References: <20240910065507.2436394-1-steffen.klassert@secunet.com>
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

From: Florian Westphal <fw@strlen.de>

Julian Wiedmann says:
> +     if (!xfrm_pol_hold_rcu(ret))

Coverity spotted that ^^^ needs a s/ret/pol fix-up:

> CID 1599386:  Null pointer dereferences  (FORWARD_NULL)
> Passing null pointer "ret" to "xfrm_pol_hold_rcu", which dereferences it.

Ditch the bogus 'ret' variable.

Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
Reported-by: Julian Wiedmann <jwiedmann.dev@gmail.com>
Closes: https://lore.kernel.org/netdev/06dc2499-c095-4bd4-aee3-a1d0e3ec87c4@gmail.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6336baa8a93c..31c14457fdaf 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4429,7 +4429,7 @@ EXPORT_SYMBOL_GPL(xfrm_audit_policy_delete);
 static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_selector *sel,
 						    u8 dir, u8 type, struct net *net, u32 if_id)
 {
-	struct xfrm_policy *pol, *ret = NULL;
+	struct xfrm_policy *pol;
 	struct flowi fl;
 
 	memset(&fl, 0, sizeof(fl));
@@ -4465,7 +4465,7 @@ static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_selector *
 	if (IS_ERR_OR_NULL(pol))
 		goto out_unlock;
 
-	if (!xfrm_pol_hold_rcu(ret))
+	if (!xfrm_pol_hold_rcu(pol))
 		pol = NULL;
 out_unlock:
 	rcu_read_unlock();
-- 
2.34.1


