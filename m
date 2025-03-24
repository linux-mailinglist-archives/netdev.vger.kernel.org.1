Return-Path: <netdev+bounces-177011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DFA6D416
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 07:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041CB16B64D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 06:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D2D18DB3D;
	Mon, 24 Mar 2025 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="fT8ukGTb"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03A84037
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797149; cv=none; b=SyfsP5rqpchnbcFC0pauVWFprVqCKcaYw6nCrzVgQvtwusD6Az4gxm1b7srZiGfPkdR49XeiMes7JxLAYpyPvU8ZhLuqD8SVQXfrMKxujxhKBhU6i9YNlqWb01TYvI1Kus3sNT38agj21sPkNygsuJ+plJIXYqRPXu1LSSQhap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797149; c=relaxed/simple;
	bh=J1ihKVg29vha1REgeYEK9STd6fEIw8twnr0BcDz9GK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uecRZiLDnXx9DZSYDRlVfaBhDcYqHi8jXTkK2D0JOMLECyQzs51uozr7tiBIQcLA5axQp1REdJszxdkRHj7B/5A6jbPaTpPltAwVBS9k9BO+ofDY+ESBqwNBj4t0TJ8d7LS40IVXeDGal2rDOF2K4N9otfDNIPotS1T6Urs2fFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fT8ukGTb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3EB1C207AC;
	Mon, 24 Mar 2025 07:19:00 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mDJ_Xa8GRoU1; Mon, 24 Mar 2025 07:18:59 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CB941207B2;
	Mon, 24 Mar 2025 07:18:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CB941207B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742797138;
	bh=tV6ljVpGC+yw/IXeNh2TziFLI50t1aDlk0H7wBbnrIU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=fT8ukGTbStIeCndSRPAHzokebQo/9ufnYTeiSE6Pu3mntdF0Glc9yKcizJCMXlT2G
	 +au79aMthgZ3MqkEdiDfLRSdY2ogpls6R2Y9gjNDQ7p0IuITykrEK1JjdFI3astocU
	 QRrmJghX4JvObAypP3uc8sFSTCGJ1po6ubkmPMKOWuWFu5DnBSCZbscD0HWAFwRa9O
	 A4/6utSMMLQAP7BSK2tkgfp7ED9wQXTAK+b5TOJNJPhrQaDcOpTFTyRlwSvMZwQXaJ
	 38Vm7glw95p5aAEAzL0KBifhn1iAQbQb4axZ2UWsggPTyUo9vrorGCHf45Up/xdx8V
	 uQfdHtbtAQmGA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Mar 2025 07:18:58 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 07:18:57 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 82BC93182BD9; Mon, 24 Mar 2025 07:18:57 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/8] xfrm: rely on XFRM offload
Date: Mon, 24 Mar 2025 07:18:51 +0100
Message-ID: <20250324061855.4116819-5-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Leon Romanovsky <leonro@nvidia.com>

After change of initialization of x->type_offload pointer to be valid
only for offloaded SAs. There is no need to rely on both x->type_offload
and x->xso.type to determine if SA is offloaded or not.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 97c8030cc417..8d24f4743107 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -419,13 +419,11 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload ||
-	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
+	if (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-	    ((!dev || (dev == xfrm_dst_path(dst)->dev)) &&
-	     !xdst->child->xfrm)) {
+	    ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm)) {
 		mtu = xfrm_state_mtu(x, xdst->child_mtu_cached);
 		if (skb->len <= mtu)
 			goto ok;
@@ -437,8 +435,8 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	return false;
 
 ok:
-	if (dev && dev->xfrmdev_ops && dev->xfrmdev_ops->xdo_dev_offload_ok)
-		return x->xso.dev->xfrmdev_ops->xdo_dev_offload_ok(skb, x);
+	if (dev->xfrmdev_ops->xdo_dev_offload_ok)
+		return dev->xfrmdev_ops->xdo_dev_offload_ok(skb, x);
 
 	return true;
 }
-- 
2.34.1


