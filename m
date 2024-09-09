Return-Path: <netdev+bounces-126485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA4F9714B9
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180441C2179E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C11B5325;
	Mon,  9 Sep 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="iTNZQ9rw"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38CB1B3F21
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876223; cv=none; b=g72FXjTuOzslhPGaWXtF06Yjg7TvV5Z5VngHtEBtDXSVzMuorXcJB0r5aFtCNYD0AdJ2zdFwgi6KjwvgkEXMGkbQeDfg3asAbSgr/NCqw91ONdLXBLTtZxwTVjSb/yQc9Gv3PzVUNAZHN9KqHmhdJRkm6jDr6fIFJHkFnY+xfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876223; c=relaxed/simple;
	bh=Bi0NMSlf6zlssucmrCb/QC0rm0UiTgkYPcN00FHDo9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYInNtDfuTY07hZ3ZRp60ckiZ9YsmvNyMhWW568bmhE18bKkB4jlK5vgIWXdsFWn/CkH6DQHHHHq4bnnHIMbNsbQaomIsuxqAXqaimIJC+NBYQR7TwR5mlg6C/OwdQyUMCWWxZR8YY+e5uebzc/7zjDrztzUHa98PNknQi+w5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=iTNZQ9rw; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 34EBD2084C;
	Mon,  9 Sep 2024 12:03:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jVNuvHHEZMWm; Mon,  9 Sep 2024 12:03:36 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E23DD2083E;
	Mon,  9 Sep 2024 12:03:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E23DD2083E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725876215;
	bh=bGQ+4xuS0cvDaxcLzjHoz2pwl86J785OV6C4+40GuPk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=iTNZQ9rwjn5r/DpHJRzB2OdkSwf4oqZvlhV18ia/cE7HQf51tODxNtcANDaadlsZd
	 9LwF0Ah/VS2GWd4huv+yjfd4lU4t+xJXFHab+ruprxaJ2hF9Sp8hM9PjL9mfgvnnPV
	 xHmq2QVM9JXRpvodPul0yUq6k1SvZZVY5CO26aoeN7JrvRnbgjRACwKE3WEqtWDMmO
	 WEhWJGHwxwXhXuqbqJLUdm+t+lLHV7vXLf0tMtxjrHhJGB/bLay3tCuz6osG4OYFk1
	 qs0ZW2iEuEGwes0TazagbXswwdD5JQQG2/DksCSJGxV2YhhAABpfImld1lOjJlryTG
	 OXtrciJGyoTbg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:03:35 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 12:03:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 54D3B3184758; Mon,  9 Sep 2024 12:03:34 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/11] xfrm: policy: use recently added helper in more places
Date: Mon, 9 Sep 2024 12:03:26 +0200
Message-ID: <20240909100328.1838963-10-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909100328.1838963-1-steffen.klassert@secunet.com>
References: <20240909100328.1838963-1-steffen.klassert@secunet.com>
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


