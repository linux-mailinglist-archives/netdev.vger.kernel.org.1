Return-Path: <netdev+bounces-192159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C449ABEB73
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BFF175502
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB85233D85;
	Wed, 21 May 2025 05:44:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE62D515
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806240; cv=none; b=CrJQggwcqPhyuFXDdhHPsm34OkIja13ymnqiLpCQpsUpIjT/4+upStthPc7QNWSCDee2P2CPE4/BtcWC7C2TuzqPLEAEeYAIHtCJwlInK8DdlevkcWha6pFebCXTCTje8RwKd+cvc1MoRs8sICP8XAF4PoOLUe4GMi9tE6dRjmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806240; c=relaxed/simple;
	bh=GBEDRMuOut7qxWBdLLh3FL5MkzMYp/0RUmAR2MPXbQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpPYKl4N+F9+Q+Yxox/dYCRqjzza/eSBwFj1Opedmbw4s3a7CS3LF9zw7CvJqcQZnAfhjfw35/CgCoEah0zdv6hBcOrEF3m56t3ZrSb3J94o1Hi5gKN44C6evwVdgR7QSV7cq2h6lZ8f86TKP43db2RoOP+AMcw0CKwgAqQP8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2DDB7207F4;
	Wed, 21 May 2025 07:43:54 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nMFHI_GLXMRo; Wed, 21 May 2025 07:43:53 +0200 (CEST)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6DEB8207BE;
	Wed, 21 May 2025 07:43:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6DEB8207BE
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 21 May
 2025 07:43:53 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 07:43:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2A42C3184172; Wed, 21 May 2025 07:43:50 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/5] xfrm: ipcomp: fix truesize computation on receive
Date: Wed, 21 May 2025 07:43:47 +0200
Message-ID: <20250521054348.4057269-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521054348.4057269-1-steffen.klassert@secunet.com>
References: <20250521054348.4057269-1-steffen.klassert@secunet.com>
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

From: Sabrina Dubroca <sd@queasysnail.net>

ipcomp_post_acomp currently drops all frags (via pskb_trim_unique(skb,
0)), and then subtracts the old skb->data_len from truesize. This
adjustment has already be done during trimming (in skb_condense), so
we don't need to do it again.

This shows up for example when running fragmented traffic over ipcomp,
we end up hitting the WARN_ON_ONCE in skb_try_coalesce.

Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_ipcomp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 0c1420534394..907c3ccb440d 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -48,7 +48,6 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 {
 	struct acomp_req *req = ipcomp_cb(skb)->req;
 	struct ipcomp_req_extra *extra;
-	const int plen = skb->data_len;
 	struct scatterlist *dsg;
 	int len, dlen;
 
@@ -64,7 +63,7 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 
 	/* Only update truesize on input. */
 	if (!hlen)
-		skb->truesize += dlen - plen;
+		skb->truesize += dlen;
 	skb->data_len = dlen;
 	skb->len += dlen;
 
-- 
2.34.1


