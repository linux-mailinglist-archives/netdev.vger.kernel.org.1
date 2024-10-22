Return-Path: <netdev+bounces-137809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D1E9A9E68
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8833AB21EB1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160A7199397;
	Tue, 22 Oct 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DZRSopOP"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65B198E7F
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588993; cv=none; b=hxP649j1kO+x2Q1SqsamRwf8ztilxrMZbwwjW0Vo08rHm5hPGfHmz2mc2Owoi8a/6kiikKeO1Xtipw5/JtAJyPQFZIa34RyzxfDobVKIgYoGUSFDylrYFnIz1KT55fBGZqbQOVbvyjmiaU0hMLwsEU1ge/sFKUe24ryDzTcJnvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588993; c=relaxed/simple;
	bh=6znsmhzwh6e7MlAq9Wxy0PJMTVtErNF8GYdF6MqSJKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IczJPsD2tPcDR+GD5Cqb1kC8ovoZFMJItvQGg4Hb5dAZwPPo2eHYA1IR9I2UEvX1eTuLpGO/2mLL68h1tfSuPj1MnPb51bwSOnRxl37TzWh988jz4qk4bEHwCTbEJlje3X7g26nD6SV9RFndpXWlbSs8r37XKnsks3wHu38mu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DZRSopOP; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 245192083E;
	Tue, 22 Oct 2024 11:23:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C6xCeFFX1KIu; Tue, 22 Oct 2024 11:23:03 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 45DCF20854;
	Tue, 22 Oct 2024 11:23:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 45DCF20854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729588980;
	bh=/aA/+mh/r9OgorN1bMy7oy/qQWBWPXLdcD9cXNdSqpA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=DZRSopOPfGRTk16Yo5Q6c2XS+M/5kGANPl3FW94Jh77NBqlFictGF6pQdUxFpHo7w
	 wsaUHjpwHxbYhchw3NO6kPjnA6mggk2TSg9sBlgt3H5nP8DJV+Iem4eiw0on1r1uXu
	 8v838zeDO93+6EYusImYrRfD2sOmimux+EKdYo+ihQKVBxfJbCRFwvNa3qzRAdR/tG
	 +aAWP2v6o0HNZPJHKgjbad5CWWRloRkRHiIMX3eOPWrpCwrUUna5KhpElQHfhIBfm1
	 lH+utbUZAPrl9N5n3UapcstfjkmMLyQeo8y/c+WHN3e3oYsvy9nE9PuuFj1HRXGbYG
	 qRanTK+M5fNXw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 11:22:30 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 11:22:29 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 152813184C15; Tue, 22 Oct 2024 11:22:29 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/5] xfrm: policy: remove last remnants of pernet inexact list
Date: Tue, 22 Oct 2024 11:22:24 +0200
Message-ID: <20241022092226.654370-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022092226.654370-1-steffen.klassert@secunet.com>
References: <20241022092226.654370-1-steffen.klassert@secunet.com>
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

xfrm_net still contained the no-longer-used inexact policy list heads,
remove them.

Fixes: a54ad727f745 ("xfrm: policy: remove remaining use of inexact list")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/netns/xfrm.h | 1 -
 net/xfrm/xfrm_policy.c   | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index d489d9250bff..ae60d6664095 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -51,7 +51,6 @@ struct netns_xfrm {
 	struct hlist_head	*policy_byidx;
 	unsigned int		policy_idx_hmask;
 	unsigned int		idx_generator;
-	struct hlist_head	policy_inexact[XFRM_POLICY_MAX];
 	struct xfrm_policy_hash	policy_bydst[XFRM_POLICY_MAX];
 	unsigned int		policy_count[XFRM_POLICY_MAX * 2];
 	struct work_struct	policy_hash_work;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 55cc9f4cb42b..a2ea9dbac90b 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4206,7 +4206,6 @@ static int __net_init xfrm_policy_init(struct net *net)
 
 		net->xfrm.policy_count[dir] = 0;
 		net->xfrm.policy_count[XFRM_POLICY_MAX + dir] = 0;
-		INIT_HLIST_HEAD(&net->xfrm.policy_inexact[dir]);
 
 		htab = &net->xfrm.policy_bydst[dir];
 		htab->table = xfrm_hash_alloc(sz);
@@ -4260,8 +4259,6 @@ static void xfrm_policy_fini(struct net *net)
 	for (dir = 0; dir < XFRM_POLICY_MAX; dir++) {
 		struct xfrm_policy_hash *htab;
 
-		WARN_ON(!hlist_empty(&net->xfrm.policy_inexact[dir]));
-
 		htab = &net->xfrm.policy_bydst[dir];
 		sz = (htab->hmask + 1) * sizeof(struct hlist_head);
 		WARN_ON(!hlist_empty(htab->table));
-- 
2.34.1


