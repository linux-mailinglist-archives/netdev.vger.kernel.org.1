Return-Path: <netdev+bounces-177014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FF4A6D417
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 07:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED853A829F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224A18FDD8;
	Mon, 24 Mar 2025 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="cHDEr3ki"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8309139FD9
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 06:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797150; cv=none; b=ozXWjgYcyz8Xiyn92xezcJfotktZNSU3dR/gdTJfQ+0m4NB+ligQRsIFds5LCEU3cOADr7mfqkTqzLB2yfPszgUWawxWUly9dDuqmFKI5SbQDAw5WdtQfNBTGP/6/6gjYaCP71yKnMGH28hp++vwx8IZYI8MwXcuDiQDw9VyQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797150; c=relaxed/simple;
	bh=iL6foIisTntDK6QknFM3dj6IIJErInRpBCeouo0ZmQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTcNSGHlGVpUyHXIiAq7BVGAo6Hb5UtIMKrjwiSr3sAuVh1g5QejjaGTcpWjRJIO7US/xsi5mxhBNiljMUK9y2CQsAblcrxiZOIx4v52JnmPpbnbuhlN7NBpkhZKMG/dSEWMuRk+jCk60HsA3eP7k0v8JArJ5mRh1BKg7GlXDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=cHDEr3ki; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0D408207BE;
	Mon, 24 Mar 2025 07:18:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ZfWop_fVMfa; Mon, 24 Mar 2025 07:18:58 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4068720539;
	Mon, 24 Mar 2025 07:18:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4068720539
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742797138;
	bh=5nZEdkFPKIuIQ4O9yxtyW50TbMOi/nQMUdlZXoiYfbc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=cHDEr3ki4l+VA/vCgUnFvbl0QH2OatdrUARwJbeZG082k479VKcj00ofdTm6qBOpi
	 pSCbChhwBpB70yRq9AAIpFUqvtqSf8j3pAoMxx2YIU6opJWKz7UzHXmkgEXEHtW6fB
	 jo5Y/ZBAo4FZp38Sw0wGcDjVIuMCUEcSF4j47wjdDs0iyVuufkHUMb3J+NziWSm1zI
	 RHYouIRwG7gbwNm7WCxh6RnIJXJZPdPIvhdfhmhe/dhBpIbAodeeRw7UVoBZDde7bd
	 wmfg0+8NQCi3I+7pBRqOZJVDxidOwrSsD4cevA1kOa1Uc4MOngONQBVdDcwkKJlze7
	 +01w7e23tJ+iA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Mar 2025 07:18:58 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 07:18:57 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7DAD0318295A; Mon, 24 Mar 2025 07:18:57 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/8] xfrm: simplify SA initialization routine
Date: Mon, 24 Mar 2025 07:18:50 +0100
Message-ID: <20250324061855.4116819-4-steffen.klassert@secunet.com>
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

From: Leon Romanovsky <leonro@nvidia.com>

SA replay mode is initialized differently for user-space and
kernel-space users, but the call to xfrm_init_replay() existed in
common path with boolean protection. That caused to situation where
we have two different function orders.

So let's rewrite the SA initialization flow to have same order for
both in-kernel and user-space callers.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h    |  3 +--
 net/xfrm/xfrm_state.c | 22 ++++++++++------------
 net/xfrm/xfrm_user.c  |  2 +-
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index e1eed5d47d07..15997374a594 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1769,8 +1769,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
 u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
 int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
-		      struct netlink_ext_ack *extack);
+int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
 int xfrm_init_state(struct xfrm_state *x);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
 int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 69af5964c886..7b1028671144 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3120,8 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
-		      struct netlink_ext_ack *extack)
+int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 {
 	const struct xfrm_mode *inner_mode;
 	const struct xfrm_mode *outer_mode;
@@ -3188,12 +3187,6 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
 	}
 
 	x->outer_mode = *outer_mode;
-	if (init_replay) {
-		err = xfrm_init_replay(x, extack);
-		if (err)
-			goto error;
-	}
-
 	if (x->nat_keepalive_interval) {
 		if (x->dir != XFRM_SA_DIR_OUT) {
 			NL_SET_ERR_MSG(extack, "NAT keepalive is only supported for outbound SAs");
@@ -3225,11 +3218,16 @@ int xfrm_init_state(struct xfrm_state *x)
 {
 	int err;
 
-	err = __xfrm_init_state(x, true, NULL);
-	if (!err)
-		x->km.state = XFRM_STATE_VALID;
+	err = __xfrm_init_state(x, NULL);
+	if (err)
+		return err;
 
-	return err;
+	err = xfrm_init_replay(x, NULL);
+	if (err)
+		return err;
+
+	x->km.state = XFRM_STATE_VALID;
+	return 0;
 }
 
 EXPORT_SYMBOL(xfrm_init_state);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index b5266e0848e8..784a2d124749 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -919,7 +919,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 			goto error;
 	}
 
-	err = __xfrm_init_state(x, false, extack);
+	err = __xfrm_init_state(x, extack);
 	if (err)
 		goto error;
 
-- 
2.34.1


