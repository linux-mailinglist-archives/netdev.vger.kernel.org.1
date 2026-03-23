Return-Path: <netdev+bounces-270414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLiaGMf8wGmiPQQAu9opvQ
	(envelope-from <netdev+bounces-270414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:41:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC30A2EE631
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1D43066BF0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBAA37FF78;
	Mon, 23 Mar 2026 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="eNConC4S"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99463803C7
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254905; cv=none; b=OZyqo3AF7NhBxR77Mn55mpINVPs28DmC2OZ6LursCuOenpDQ1xe/O1VQd90HhWgQ8KslEP5vh4exVD8NyQ16YPMELwOL8GvV4p4KJrbwg38S4735EG0GhMK/5/ta/SeUGO3k4o1Q/dad0F5yVnuysRhfaNerCIoK/REwTrrqtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254905; c=relaxed/simple;
	bh=vstcVafmArs26mZEmRqhtIbkWVdT8Y+rSzIfQz4uvvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWX+zFb8k1eu3gTXXc/GNMgmdMLnS46Pfws9f0T3tyAT7XNM4M2WvNC3M6KkZzdpIJJsfHw8Ng1nJuzDHXRiDZ6Yz5smrS+ZoQV8kordpFSrST3V7ecC2L8x3y2aY3z0dppfwt1iwwbOXJAtRZXBgdmF01KqnTiWWvNwN07SMrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=eNConC4S; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AAA062082B;
	Mon, 23 Mar 2026 09:34:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vmY2slgrxE5t; Mon, 23 Mar 2026 09:34:59 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 259DA207AC;
	Mon, 23 Mar 2026 09:34:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 259DA207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254899;
	bh=FsSfq/kT+RcWfBSb/RmdJrCA5S+bjTsqgPLxHDU0kUQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=eNConC4SXidLKF8Pfpmiu4PKrXpu+IriDDnTOh8b9F8vQwO85IPmyLGvjFzktgXE0
	 vpiaWhvnxW2wP9L3rMiIGcP1sV0B/IxGLIxB7hbv22ypraVlQDmVdqnzsLGsDOGwMu
	 UACw3PJPs/9Z2dsYssRo2LPhbvXIpPRN8jb7aDgEiSq8ckmAhViuS6TuVu+hnotCBx
	 jq5+yTGZlofzDfZrCUnT7WbEuva8iSfy4cEwTzfB2OU1o0/nbjVyym560a6nopjyrO
	 uLwo8i5rxAPJpJvtUjqQ8P95CMWNPjl0pnWpxzsoDdIjhR6JkCTOap1yuAKlbPH1+B
	 D5zGFgelZ2ebA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:34:58 +0100
Received: (nullmailer pid 2741803 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 02/20] xfrm: fix the condition on x->pcpu_num in xfrm_sa_len
Date: Mon, 23 Mar 2026 09:33:43 +0100
Message-ID: <20260323083440.2741292-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323083440.2741292-1-steffen.klassert@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270414-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,secunet.com:dkim,secunet.com:email,secunet.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BC30A2EE631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

pcpu_num = 0 is a valid value. The marker for "unset pcpu_num" which
makes copy_to_user_state_extra not add the XFRMA_SA_PCPU attribute is
UINT_MAX.

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 3e6477c6082e..4dd8341225bc 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3676,7 +3676,7 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	}
 	if (x->if_id)
 		l += nla_total_size(sizeof(x->if_id));
-	if (x->pcpu_num)
+	if (x->pcpu_num != UINT_MAX)
 		l += nla_total_size(sizeof(x->pcpu_num));
 
 	/* Must count x->lastused as it may become non-zero behind our back. */
-- 
2.43.0


