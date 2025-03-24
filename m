Return-Path: <netdev+bounces-177015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEB0A6D41B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 07:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB2B7A59DB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 06:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2491A194A59;
	Mon, 24 Mar 2025 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="dJtilWl4"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD7191F91
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797152; cv=none; b=nURAR4VcCTGL0O55TeCePjCuT6vuU6mY0YCjRiatuFvyRqzbBdn7rtBLKUdqc5NE+GVZrJ2OG0WF5+f2+Tl4SLpIqgnlSTk8MntD5iU5CVYdOsXvTsxMaj7w0uoEKavwCVDlH8F74K9IQngxluyTgyKJQMCObYrP4BA/dqH4ZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797152; c=relaxed/simple;
	bh=ZORXetLAv3Pu50j8KqGNskN+PEJrY1tX6LhTilyN/So=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reyBmkRl4jCwead8YreN5vF30JW0mm1z4sxGN0/0k2qwPACtoKIQnGCGFaIq+Agfix8VHWjgHwDTjdORzqeupposKcx/Da4DSkPhi9K/XIvC00sxvHWWHsvmDtidfQVqa5RO/70WKpTXS5Z/RzML4zGNxF0uRVDNBRXCiPeyPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=dJtilWl4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B5F5520764;
	Mon, 24 Mar 2025 07:19:00 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0AReqygrZSZy; Mon, 24 Mar 2025 07:19:00 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F0DA9207BB;
	Mon, 24 Mar 2025 07:18:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F0DA9207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742797139;
	bh=r3sLdMxNlW+yZKmEZI7ZektX8tJ1YwQixiNg40VVu9w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=dJtilWl4ueKtNlGJuSRm/kuUgJv1jAJUiIMmcPhJ5OLcxoroXuxwOUuz1ZmLcdlOM
	 azsV40ZxMYApV0Qh8/OayRjcRQI6Aua6DoOKj3cvt/m2mDr+fDC4SORHP1ds80nsJ2
	 lkHkhlX5U4bkQ0tCMctBC9+DIOytRJeiuzHhAHTiK0R9geEUT/r/oBW8kZBwsRRLb4
	 ctCCt/+gmhUJwZbqgjguaD3MKTz/B2RRpT16bKrcoCiXpzGNeQt4mINPiTg/75v66n
	 YazwhFgHMyIKDieeeEXkEoG1oBxqLxSKbl57OInPOSwoscka5GLfhjBHq0FWXSZpX7
	 i/uxTyNPXy2Iw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Mar 2025 07:18:58 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 07:18:58 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 916563183E89; Mon, 24 Mar 2025 07:18:57 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 8/8] xfrm: Remove unnecessary NULL check in xfrm_lookup_with_ifid()
Date: Mon, 24 Mar 2025 07:18:55 +0100
Message-ID: <20250324061855.4116819-9-steffen.klassert@secunet.com>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

This NULL check is unnecessary and can be removed.  It confuses
Smatch static analysis tool because it makes Smatch think that
xfrm_lookup_with_ifid() can return a mix of NULL pointers and errors so
it creates a lot of false positives.  Remove it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6551e588fe52..30970d40a454 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3294,7 +3294,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 
 ok:
 	xfrm_pols_put(pols, drop_pols);
-	if (dst && dst->xfrm &&
+	if (dst->xfrm &&
 	    (dst->xfrm->props.mode == XFRM_MODE_TUNNEL ||
 	     dst->xfrm->props.mode == XFRM_MODE_IPTFS))
 		dst->flags |= DST_XFRM_TUNNEL;
-- 
2.34.1


