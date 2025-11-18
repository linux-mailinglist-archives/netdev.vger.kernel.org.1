Return-Path: <netdev+bounces-239437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DAEC68646
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 314EF36800A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F330F543;
	Tue, 18 Nov 2025 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="W49lb63A"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D132C956
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456045; cv=none; b=ONDGm/LqovQzk8X60J/Cb/DqOIKpBog85BhRReXYvk6E2U0d4RVZZy1C2cxB+v2GNh8rlb5uZopdPyvd3FtNsKLcG/f2U59K903xvNoEGAPfksNg2KUwQzRtIc4BwLAhJLRHdnoAr03tp4FQEFe3e2dz96zjNsJN4NX9GAfcNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456045; c=relaxed/simple;
	bh=Zb0ObcrPtXtT8SS9VpZHslp4JwBzFVOonQjBJvP61lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eknQ0ZqECT0tr75n80HbXM4wGUqPXR9CtiSMLR18gFZSqCDN87bprOu50avwoXj5Bzy/wsNFf2hefWoiAOhCDLIHqyTH++aRNDLlYgAj4rIG2/3W1RSsetYvmPTW/q3dhg+gHoRl1CAA+00blc6yfWogDFy9Qfm84hm48lx1RAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=W49lb63A; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 19D8C20851;
	Tue, 18 Nov 2025 09:53:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8KqJaDMNIcei; Tue, 18 Nov 2025 09:53:55 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 89C7B2080B;
	Tue, 18 Nov 2025 09:53:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 89C7B2080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763456035;
	bh=jPJlK/seOKpH+DUoUgwHbOKPbUZX+FnT74FFU5Bm4VE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=W49lb63ALsnYh7I3ZzGhoYH4VJEBRlvONhUI+SoefrfqWAlj4P/cYjdBhOSPkXxXJ
	 P8HKEF2hhoTuu9yYnlTEmqGylctmQLOnWD3IDbJ/rwqwCR8ai+z8DPdKjuQSClKxfb
	 jTrVzdzJDwFUMWSYPhxGkqgQ7mataNb4sQuoWle0dqLUY8ytpZYshTgGi/fMmJRnwI
	 R0qrtrwvyu4KBMjKwrdnK6zczWqEtqXG1h2PM7yfmhmIsiV0pf9ayR4pgLLKyW9yRQ
	 ik6NBccJkPAHZNwwQk53hhGqWLby0FMSl1BE5kwNIQX34A98lqy+VYnE9ypkySSnF/
	 sHDxPvfveYCtw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 09:53:55 +0100
Received: (nullmailer pid 2200659 invoked by uid 1000);
	Tue, 18 Nov 2025 08:53:48 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 05/10] xfrm: set err and extack on failure to create pcpu SA
Date: Tue, 18 Nov 2025 09:52:38 +0100
Message-ID: <20251118085344.2199815-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118085344.2199815-1-steffen.klassert@secunet.com>
References: <20251118085344.2199815-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

xfrm_state_construct can fail without setting an error if the
requested pcpu_num value is too big. Set err and add an extack message
to avoid confusing userspace.

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 010c9e6638c0..9d98cc9daa37 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -947,8 +947,11 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 
 	if (attrs[XFRMA_SA_PCPU]) {
 		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
-		if (x->pcpu_num >= num_possible_cpus())
+		if (x->pcpu_num >= num_possible_cpus()) {
+			err = -ERANGE;
+			NL_SET_ERR_MSG(extack, "pCPU number too big");
 			goto error;
+		}
 	}
 
 	err = __xfrm_init_state(x, extack);
-- 
2.43.0


