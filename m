Return-Path: <netdev+bounces-126831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5169729DA
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D879D1F25602
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6340B17C7D4;
	Tue, 10 Sep 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="JUJh2ZBr"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F517ADF1
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951328; cv=none; b=HfMMTitT/rWsVdCS81EjbssC1mWznVxblh1bBVSysj22CUVto4bITHjMsFx5n5CfAqLEOA4v62Wy1xxdo8KMjSAue1GxZZNBquQMiutHUVARlgC0UgxQBtbbXTM0IQFhSbIuSELScGKlLfiru/4iPXq2kSSE4yJK97WAxsoLwhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951328; c=relaxed/simple;
	bh=Bi0NMSlf6zlssucmrCb/QC0rm0UiTgkYPcN00FHDo9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeV9zWWKl1icgLddJKTR/DFB+4HdPd3lgNhiNccazwr0ifIck2mxJOhFrKizej4x+yESDmE98HaQcXxuH+wcPYW/9WkmwN5FOSjfSNpGcNIK++LJ2zbYMgMOcEEUaTF0jY3j76JV8vNDrC29vKIuZUwR31NwIavr2kU3RpwBifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=JUJh2ZBr; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 065A52089F;
	Tue, 10 Sep 2024 08:55:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bYlZC1GMTHvJ; Tue, 10 Sep 2024 08:55:23 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D7514207D1;
	Tue, 10 Sep 2024 08:55:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D7514207D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951322;
	bh=bGQ+4xuS0cvDaxcLzjHoz2pwl86J785OV6C4+40GuPk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=JUJh2ZBr8gcItXaWbN4hDuIF6v+lxFo0H7EwE4QEU5drNg9HjSsSjbXpStKUNPOj8
	 efv2mRi8yu1NtSFiZkszV+xl3EfFXYtWQOoTAijo0s6HbZGYvoq3NmuOMImARF4o/V
	 Ejkj4wHkm3hKB4qZZF8PzvZt4Y5Czx8RSzVqnKgSGpfuiF1MwlEVZQ+LxuaX+gxopn
	 FgBsbO+wnNSp/9C1FRGDehnlD5zuGddo6peFF+NYrpD8lPqgHS58YtX+L9765LxpeM
	 xwQ9BWXk+gInvStMXc+jT5is++0/s2UY2KKDDjiY/0fG8PM02COIIjNS6BTEL1ONzw
	 HsPx90cugBS7w==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:55:22 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:55:21 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6DA173184319; Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/13] xfrm: policy: use recently added helper in more places
Date: Tue, 10 Sep 2024 08:55:03 +0200
Message-ID: <20240910065507.2436394-10-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Florian Westphal <fw@strlen.de>

No logical change intended.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index b79ac453ea37..94859b2182ec 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1276,11 +1276,7 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 		struct xfrm_pol_inexact_bin *bin;
 		u8 dbits, sbits;
 
-		if (policy->walk.dead)
-			continue;
-
-		dir = xfrm_policy_id2dir(policy->index);
-		if (dir >= XFRM_POLICY_MAX)
+		if (xfrm_policy_is_dead_or_sk(policy))
 			continue;
 
 		if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
@@ -1331,13 +1327,8 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 
 	/* re-insert all policies by order of creation */
 	list_for_each_entry_reverse(policy, &net->xfrm.policy_all, walk.all) {
-		if (policy->walk.dead)
-			continue;
-		dir = xfrm_policy_id2dir(policy->index);
-		if (dir >= XFRM_POLICY_MAX) {
-			/* skip socket policies */
+		if (xfrm_policy_is_dead_or_sk(policy))
 			continue;
-		}
 
 		hlist_del_rcu(&policy->bydst);
 
-- 
2.34.1


