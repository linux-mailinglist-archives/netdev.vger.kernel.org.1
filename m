Return-Path: <netdev+bounces-126838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F55B972A28
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82471F2581F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D8E17BEA4;
	Tue, 10 Sep 2024 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="tvhwhcLK"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335E17BB1A
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951824; cv=none; b=Ck+CBj/X2UWKzrKoIESPQuUZj+oS/U8wFlg36+YNA3ZWkJUG64gDoZBDqUF3NsmhJ5Cst6K/IXY+z/Pvgs4+U2sdo4UVZcRibhlqCkGDybE6TXjwfD35d/Qncmz2dnrJGe9Mqhg26FsLe34RcE5y+wxrk2j+N7RM+Shm8RoUgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951824; c=relaxed/simple;
	bh=eD9zwrp3FBb4Bn/H//ewP27Nixi906eUjV1POHPlr08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdXOZUOeLjyH+fLIAPtfr8a7Xf4c/UxTp4bv5JkTQbgnekbG8tftQQaCg4TsA2DZDllCE9zvrSfecDwuFvU3CO1HJUtzKX6IbMWVqWHMTma0a/kZZFa5mPU48nFGYCzHRwTESFRrXhhgwdqGWMFueQ71jemP/ub7s7McYrvmsfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=tvhwhcLK; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9BBF4207D1;
	Tue, 10 Sep 2024 09:03:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Us6JRL9fKQmh; Tue, 10 Sep 2024 09:03:39 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 162D620799;
	Tue, 10 Sep 2024 09:03:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 162D620799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951819;
	bh=pptXSAW1jGMA4twPxCr0BaJ5AvPPtsqVG4VFxC7hPj4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=tvhwhcLKybQifVivx9DCPpF8eSNRiUnTPAq2YmSXnEhnFwGy6wmmNlkWghw5bhsw4
	 jEeemZVy6nTUlYEQvg9ZAEeyrQ3JcTH6MldpI3KSD5SMf3O0ByvDsGb3JpqSFsDxay
	 i5Ts/ZaF+zwNb65qs1hO+mNQ++huv3+LidXxxKKnAa4jBgKhrG3caYkmyLU3zuz6rF
	 vp6mRY5O/G3x59JBbQVHUiJl2gMwB0CeRptWuhusGQdgoqpOQX3r/BbNwvaPQa2Y2w
	 9BZser1b65SZce5Y0cWOktNcvOholtfJhCqDNtnMEk1AlkI9W3wMLkT0PF1vxRXAwP
	 X6HWBAIxVabbg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 09:03:38 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 09:03:37 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9931F31843BF; Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 13/13] xfrm: policy: Restore dir assignments in xfrm_hash_rebuild()
Date: Tue, 10 Sep 2024 08:55:07 +0200
Message-ID: <20240910065507.2436394-14-steffen.klassert@secunet.com>
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

From: Nathan Chancellor <nathan@kernel.org>

Clang warns (or errors with CONFIG_WERROR):

  net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is uninitialized when used here [-Werror,-Wuninitialized]
   1286 |                 if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
        |                      ^~~
  net/xfrm/xfrm_policy.c:1257:9: note: initialize the variable 'dir' to silence this warning
   1257 |         int dir;
        |                ^
        |                 = 0
  1 error generated.

A recent refactoring removed some assignments to dir because
xfrm_policy_is_dead_or_sk() has a dir assignment in it. However, dir is
used elsewhere in xfrm_hash_rebuild(), including within loops where it
needs to be reloaded for each policy. Restore the assignments before the
first use of dir to fix the warning and ensure dir is properly
initialized throughout the function.

Fixes: 08c2182cf0b4 ("xfrm: policy: use recently added helper in more places")
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 31c14457fdaf..428ee83fe298 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1283,6 +1283,7 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 		if (xfrm_policy_is_dead_or_sk(policy))
 			continue;
 
+		dir = xfrm_policy_id2dir(policy->index);
 		if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
 			if (policy->family == AF_INET) {
 				dbits = rbits4;
@@ -1337,6 +1338,7 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 		hlist_del_rcu(&policy->bydst);
 
 		newpos = NULL;
+		dir = xfrm_policy_id2dir(policy->index);
 		chain = policy_hash_bysel(net, &policy->selector,
 					  policy->family, dir);
 
-- 
2.34.1


