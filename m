Return-Path: <netdev+bounces-92953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017BC8B96CD
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEE91F23F2A
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9118D5025A;
	Thu,  2 May 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GRhM/rJi"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8AD46B9F
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639731; cv=none; b=g+vw3tiqf7caB1dofSFr/5cQRL6HKuPRgWmbtyPkRNkzHFPMv3iAaq/sujvlTLrcvPGfDRR/4XOOcbLWyxpIZbpNEJBZ8oHA3eJMk0sU16UNBtVnsNUxtZC9/jEICxEuFbzr2WIPjblvX/1syNMlYY3CvCF+ijLvqxPfc57DeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639731; c=relaxed/simple;
	bh=VYLxhcwRFksh82B/S6r/I1nAm8h2fIyTECS6n6ws074=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2nwT9g2fjz7nYSjalsZ2zMaP85zd5h9EGEyab/LUlXL8aHq3NDyRKzvfyEqoLbn/Nqkk3WNKwTf+PTu8ppDuWJsB4+F8FK1O5WUSe75JEC3sOfaYMj/cjpr4SARlyaMLMBTY7hNKytzmxSqr7t1nbnvVPE6BK+PE/J7zYPdaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GRhM/rJi; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E0FDF2076B;
	Thu,  2 May 2024 10:48:47 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LOxnFqnBMakI; Thu,  2 May 2024 10:48:46 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B341B207B2;
	Thu,  2 May 2024 10:48:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B341B207B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714639726;
	bh=cHgAG+/Rg+Kh7TsgmSwr5Vs7iBmEkrht4syCwaI4Eag=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=GRhM/rJigKMVyfHHP062hvmK24RoYrZKgks3xEIloI3sx2lgJXherafHsTGNpenOL
	 XrpNCA01ZB3obniO0WRImp50kAzApbrIKaqzcba4mY5iha6iJ1gxTIsN7dOrsxWsz/
	 IJ+NkCHCU+BGMmGg2povid0/51fdsY5Q7GDh8m1mEXXC0zLB3TNOFr6RFA/hwCi2d/
	 /HORwgWXsaDNXCmAxar+tDpI46K97oKfUy8poej898lMt13yYJssYDXeIa4/Jn7B8U
	 l83+I3Po7To/JRTflMvLYUwrZHXS9hkU1tohwQwuquSZ9gwbNFbf2fJJpUbQCOY1jJ
	 mss16AQhY+clg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id A797C80004A;
	Thu,  2 May 2024 10:48:46 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 2 May 2024 10:48:46 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 May
 2024 10:48:45 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A4B923180390; Thu,  2 May 2024 10:48:45 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/3] xfrm: fix possible derferencing in error path
Date: Thu, 2 May 2024 10:48:36 +0200
Message-ID: <20240502084838.2269355-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502084838.2269355-1-steffen.klassert@secunet.com>
References: <20240502084838.2269355-1-steffen.klassert@secunet.com>
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

From: Antony Antony <antony.antony@secunet.com>

Fix derferencing pointer when xfrm_policy_lookup_bytype returns an
 error.

Fixes: 63b21caba17e ("xfrm: introduce forwarding of ICMP Error messages")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/kernel-janitors/f6ef0d0d-96de-4e01-9dc3-c1b3a6338653@moroto.mountain/
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6affe5cd85d8..53d8fabfa685 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3593,6 +3593,8 @@ xfrm_policy *xfrm_in_fwd_icmp(struct sk_buff *skb,
 			return pol;
 
 		pol = xfrm_policy_lookup(net, &fl1, family, XFRM_POLICY_FWD, if_id);
+		if (IS_ERR(pol))
+			pol = NULL;
 	}
 
 	return pol;
-- 
2.34.1


