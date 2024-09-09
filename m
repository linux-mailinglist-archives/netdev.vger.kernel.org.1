Return-Path: <netdev+bounces-126476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D19714AD
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6EB281840
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BAF1B3B22;
	Mon,  9 Sep 2024 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="LcQEGuSi"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787371B373F
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876219; cv=none; b=KavaCrhMn42b+6Jh7ldaL+5+bna2eyDfsaLG58rtO/szAjleL/COuj+1x9kTR4e420Xg6RwOOEmHU2n/yBqi6AtlUBY5TUAGhLcHQEmrre1l8JPUr4b1P/1Age0bw06ROKmok5fa6p0AXuHTrRhwmQTzFYXirehlVdhp6/ZhKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876219; c=relaxed/simple;
	bh=RJdxDspsIkMexFz8u6rSIAX8xha9ppNa4YIYohlVjx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8wzLMVt5wWxWYNoh3ex4sPKBXbUDViIB/LO05FTeyl2EQrGIVkLI73rSxeDGpbUtcvR5vilmEYfjwjTGqJqCH2Xg9pqd/nJkyn/0LvtOenYfH0lk4za/ar+pyR2CwLh+cqSe4G/9ZR1BZj4n8zPxd0OYFyjVcZ/qwwIo7VsJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=LcQEGuSi; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2D6A120870;
	Mon,  9 Sep 2024 12:03:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MOMCvhPo3U6x; Mon,  9 Sep 2024 12:03:35 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4BE8E206E9;
	Mon,  9 Sep 2024 12:03:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4BE8E206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725876215;
	bh=IRztqup5ks2ZMtLrfzn4qHW/9FuWOjd4TSiMvDaUn5w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=LcQEGuSivk/5O0UDe5M3fcgsfyJhyvegGiheY1DASQFrSfKk7SJmLwOJpym5aJv9j
	 Pk4CE+Ab0tY1dT1v/1z+h9/2F4R039pYO/N0UP9LHHELDZtZvhLOt1ZpV7Eltvt/zl
	 Zn4EQebx6ei5uZFuWrpwYtO2BFWDLFMCPRTUQTli1algkWSThTDl1c130e2ze2w1yX
	 KxsdEeRb7+9WCMRo63/cE1o7HxrF+5MRRxFm+zNxWFMPzFXhGMEMp6+176EQn9Y53I
	 +ur29Dr+cGxJ0j40Go845Kuczhh/KPpNMP8Lfq2j6qRNZn1EVJft6ZicJCO0b8/qsd
	 YZgSMxUdxobQA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:03:35 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 12:03:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2580231829F0; Mon,  9 Sep 2024 12:03:34 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/11] xfrm: Remove documentation WARN_ON to limit return values for offloaded SA
Date: Mon, 9 Sep 2024 12:03:18 +0200
Message-ID: <20240909100328.1838963-2-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Patrisious Haddad <phaddad@nvidia.com>

The original idea to put WARN_ON() on return value from driver code was
to make sure that packet offload doesn't have silent fallback to
SW implementation, like crypto offload has.

In reality, this is not needed as all *swan implementations followed
this request and used explicit configuration style to make sure that
"users will get what they ask".
So instead of forcing drivers to make sure that even their internal flows
don't return -EOPNOTSUPP, let's remove this WARN_ON.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 9a44d363ba62..f123b7c9ec82 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -328,12 +328,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		/* User explicitly requested packet offload mode and configured
 		 * policy in addition to the XFRM state. So be civil to users,
 		 * and return an error instead of taking fallback path.
-		 *
-		 * This WARN_ON() can be seen as a documentation for driver
-		 * authors to do not return -EOPNOTSUPP in packet offload mode.
 		 */
-		WARN_ON(err == -EOPNOTSUPP && is_packet_offload);
-		if (err != -EOPNOTSUPP || is_packet_offload) {
+		if ((err != -EOPNOTSUPP && !is_packet_offload) || is_packet_offload) {
 			NL_SET_ERR_MSG_WEAK(extack, "Device failed to offload this state");
 			return err;
 		}
-- 
2.34.1


