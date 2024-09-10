Return-Path: <netdev+bounces-126836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295CB9729DF
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFD61C2405F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92BB17C20F;
	Tue, 10 Sep 2024 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="S6OZlice"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9817C7C9
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951329; cv=none; b=Is99hhT6ItrVxFfWXGaW5EfDT4N2mdh+7juz3u08xFYtZICLjamds7/84DrbAhMU332bHeMrW7JFX/l37nHVLNiPbQHHoUUqodNXNs+PcmH4oH4hgO06Ogok9YvH3vrBvRaBFMTmiNYWCsJDKVxOmdDqtSq4F9SX4DHCF9EnNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951329; c=relaxed/simple;
	bh=SIPd6Z5aL3Lp3FYnctyiQ1dGGqnXaoxXXLIn+8qspZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjBX2+PRLZIki1bLy912QPE1a/4d5zIUI2JmG/mSFL9hMhvUEiA4kFX3k+IUJDEZWa16ernsplWcojjg5jCQHpGM55E/+ea1SOd7TyMlS3PmKCpaOKUXl/mz1ZR0eL5BV9zQaqduDEkOfnRhfU5DvVSMmqBXh0TLqRvdAVqqtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=S6OZlice; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 59F7C207D1;
	Tue, 10 Sep 2024 08:55:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h0-QUMzQNRnX; Tue, 10 Sep 2024 08:55:23 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 03E6A208A4;
	Tue, 10 Sep 2024 08:55:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 03E6A208A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951323;
	bh=tMEEwy5Cmg7N/evH9gbiuV98BtUYHX/bTp8srDZmoB4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=S6OZlicey80vbyOZzT+PInzfZTmc/jB6/t3oIw1Ft9Bey0d76LuV3/ud7gOw+7Jh3
	 pAWGWeWiybqF2Byr7NpqUlhEvbaCZgYdgsZP8snTvlc//rvTKNuh2hdgaktrFWfyjn
	 AoXhD694730t6JgK0YHTNrrQ4vv0rxrf4r1hN8zUgm3CBOZ+YT7NYgbYq1J97KV6s2
	 0Gs+tvQO2mYbkk+lmvXiEP0YUO89cZqVRRpEH86sKXqjA5dTrgy//R7jj93mylUT3s
	 XFoiNVyNjpavlTlnzjldnWf4tTZGQWNaRdnIuQ7nHTM3w5SwNWSAeJt8wSHeYcz4d5
	 8mpugCOc4v6yQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:55:22 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:55:21 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 78B303184084; Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 11/13] Revert "xfrm: add SA information to the offloaded packet"
Date: Tue, 10 Sep 2024 08:55:05 +0200
Message-ID: <20240910065507.2436394-12-steffen.klassert@secunet.com>
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

This reverts commit e7cd191f83fd899c233dfbe7dc6d96ef703dcbbd.

While supporting xfrm interfaces in the packet offload API
is needed, this patch does not do the right thing. There are
more things to do to really support xfrm interfaces, so revert
it for now.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_output.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index a12588e7b060..e5722c95b8bb 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -706,8 +706,6 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
 	int family;
 	int err;
-	struct xfrm_offload *xo;
-	struct sec_path *sp;
 
 	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
 		: skb_dst(skb)->ops->family;
@@ -730,25 +728,6 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			kfree_skb(skb);
 			return -EHOSTUNREACH;
 		}
-		sp = secpath_set(skb);
-		if (!sp) {
-			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
-			kfree_skb(skb);
-			return -ENOMEM;
-		}
-
-		sp->olen++;
-		sp->xvec[sp->len++] = x;
-		xfrm_state_hold(x);
-
-		xo = xfrm_offload(skb);
-		if (!xo) {
-			secpath_reset(skb);
-			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
-			kfree_skb(skb);
-			return -EINVAL;
-		}
-		xo->flags |= XFRM_XMIT;
 
 		return xfrm_output_resume(sk, skb, 0);
 	}
-- 
2.34.1


