Return-Path: <netdev+bounces-192962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A645CAC1DFF
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD82D7B64FA
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F645286425;
	Fri, 23 May 2025 07:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F2284B5A
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986989; cv=none; b=MxVCgCAqCDAzmg5ncMCrcPhhSP1XRT8i/6+KPh/8OXMqEmxgih1671KMRfpFMLN+Qs1JvhFZ0o84j3w5RBz3fzJkQFxwgj/TY+54QbSc1PohwVp2EoVYIWC90oO+g0gC1hCIbIi7VW4BES1BP+36yVLd8DPK5X3Cw1Ly3xjaeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986989; c=relaxed/simple;
	bh=jimd/VTrwl+KG9BCJHvKwWZ8N58TKQ+RphX7nRthJ5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5ZrNTr+ZeZjX/ztKpO4ZxcTHDkDEjkLeEYvJfi5N41YPiL4/LoztP5HrVoFyH9YRRTaQDRTayXkkQwDCeDTVg33QM6Lrsvv2ebKArfBpDLStxl2d4P8qXP1N+ttv7aVRy473AEplZv5Dl0uSvKCRwhaGVBFE91jqWYFWnMlTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D69D320748;
	Fri, 23 May 2025 09:56:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ByJjur3sqILz; Fri, 23 May 2025 09:56:19 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3587120891;
	Fri, 23 May 2025 09:56:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3587120891
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 09:56:18 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 09:56:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 17B7331810AC; Fri, 23 May 2025 09:56:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/12] xfrm: Remove unnecessary strscpy_pad() size arguments
Date: Fri, 23 May 2025 09:56:00 +0200
Message-ID: <20250523075611.3723340-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523075611.3723340-1-steffen.klassert@secunet.com>
References: <20250523075611.3723340-1-steffen.klassert@secunet.com>
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

From: Thorsten Blum <thorsten.blum@linux.dev>

If the destination buffer has a fixed length, strscpy_pad()
automatically determines its size using sizeof() when the argument is
omitted. This makes the explicit sizeof() calls unnecessary - remove
them.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 784a2d124749..0a3d3f3ae5a3 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1173,7 +1173,7 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 	if (!nla)
 		return -EMSGSIZE;
 	algo = nla_data(nla);
-	strscpy_pad(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
+	strscpy_pad(algo->alg_name, auth->alg_name);
 
 	if (redact_secret && auth->alg_key_len)
 		memset(algo->alg_key, 0, (auth->alg_key_len + 7) / 8);
@@ -1186,7 +1186,7 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 	if (!nla)
 		return -EMSGSIZE;
 	ap = nla_data(nla);
-	strscpy_pad(ap->alg_name, auth->alg_name, sizeof(ap->alg_name));
+	strscpy_pad(ap->alg_name, auth->alg_name);
 	ap->alg_key_len = auth->alg_key_len;
 	ap->alg_trunc_len = auth->alg_trunc_len;
 	if (redact_secret && auth->alg_key_len)
@@ -1207,7 +1207,7 @@ static int copy_to_user_aead(struct xfrm_algo_aead *aead, struct sk_buff *skb)
 		return -EMSGSIZE;
 
 	ap = nla_data(nla);
-	strscpy_pad(ap->alg_name, aead->alg_name, sizeof(ap->alg_name));
+	strscpy_pad(ap->alg_name, aead->alg_name);
 	ap->alg_key_len = aead->alg_key_len;
 	ap->alg_icv_len = aead->alg_icv_len;
 
@@ -1229,7 +1229,7 @@ static int copy_to_user_ealg(struct xfrm_algo *ealg, struct sk_buff *skb)
 		return -EMSGSIZE;
 
 	ap = nla_data(nla);
-	strscpy_pad(ap->alg_name, ealg->alg_name, sizeof(ap->alg_name));
+	strscpy_pad(ap->alg_name, ealg->alg_name);
 	ap->alg_key_len = ealg->alg_key_len;
 
 	if (redact_secret && ealg->alg_key_len)
@@ -1250,7 +1250,7 @@ static int copy_to_user_calg(struct xfrm_algo *calg, struct sk_buff *skb)
 		return -EMSGSIZE;
 
 	ap = nla_data(nla);
-	strscpy_pad(ap->alg_name, calg->alg_name, sizeof(ap->alg_name));
+	strscpy_pad(ap->alg_name, calg->alg_name);
 	ap->alg_key_len = 0;
 
 	return 0;
-- 
2.34.1


