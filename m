Return-Path: <netdev+bounces-270410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI9tMnr8wGmiPQQAu9opvQ
	(envelope-from <netdev+bounces-270410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:40:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A242EE5D9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F380303F7FA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5837F8B8;
	Mon, 23 Mar 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="FOAxjoYp"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984B37F005
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254904; cv=none; b=gWbTbMcbgio4A8N+3qb/etk5YZAX5XgCk2Ac1gSVuxs6uVriRVbPpBdF09A8as1SGyQxxbccyEIIGh5xegDjXOUI2pCRJzA/r7w6loMAhV7qkF0QhLMo14W/QheMnxYVQ9lk3pxfe0TQCHL13HiiKCKm8kVIK+av7tMdCMVdsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254904; c=relaxed/simple;
	bh=NYZTM23gGrO7WxWhZuLeBfF2ioBjvBVxeEH/J5k3i4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DF60VLMCt7T0rwJjLrsAkIh9387YgkOdxLirqQxpxiON4HwwSNIZkg9hAlp1IYGqyICYBYzVGtwWpSZgTXk4YMYSAvP9ezSWVc98mCiAmMa5hiMswUwDhS5Jx3Ffy+OtYIilWC7YWfJz0RhgRMwW4v4he7J0J6qJzYITtub5+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=FOAxjoYp; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 19032207FB;
	Mon, 23 Mar 2026 09:34:58 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3SBEOzhI68cq; Mon, 23 Mar 2026 09:34:57 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 82DC9207AC;
	Mon, 23 Mar 2026 09:34:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 82DC9207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254897;
	bh=pjHypQnMfJznJsP9RnglA1Vba17RtmQJ3WTcJXHX+8c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=FOAxjoYp3nOG4Ifas+IQrDajCeQs1ck1weXUpLkatRxgAXcj3SyxaLNG0djGmlCQI
	 8mpX74a/dT2FbH0gImpPbDxVEIipP7MH6L3Wi9J3cjhdlcab/MyHztxZnmwyJ7tRF6
	 9JxIK5wz+sGvXXhwNTVMuxvTlkMRQOXq+Swp3silY+YdApg87wPWMEnKt3kUBHUYI1
	 qMUPp3G6GAicLvlwAfZKWOIj2ZPKwu1XRs0w5woYiGGPywf0S2yHcuYRzf6US9bWLM
	 YsujJVevfG47P8eFgD7rOm8Pzq0j+kQCuw40jkn/kxe8jkG2n6O0W9p60A/2n3J0kO
	 FDDMO0Z6F3LEA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:34:56 +0100
Received: (nullmailer pid 2741818 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 07/20] xfrm: state: fix sparse warnings on xfrm_state_hold_rcu
Date: Mon, 23 Mar 2026 09:33:48 +0100
Message-ID: <20260323083440.2741292-8-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 52A242EE5D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

In all callers, x is not an __rcu pointer. We can drop the annotation to
avoid sparse warnings:

net/xfrm/xfrm_state.c:58:39: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_state.c:58:39:    expected struct refcount_struct [usertype] *r
net/xfrm/xfrm_state.c:58:39:    got struct refcount_struct [noderef] __rcu *
net/xfrm/xfrm_state.c:1166:42: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_state.c:1166:42:    expected struct xfrm_state [noderef] __rcu *x
net/xfrm/xfrm_state.c:1166:42:    got struct xfrm_state *[assigned] x
(repeated for each caller)

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index a00c4fe1ab0c..ad32085267a5 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -53,7 +53,7 @@ static DECLARE_WORK(xfrm_state_gc_work, xfrm_state_gc_task);
 static HLIST_HEAD(xfrm_state_gc_list);
 static HLIST_HEAD(xfrm_state_dev_gc_list);
 
-static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
+static inline bool xfrm_state_hold_rcu(struct xfrm_state *x)
 {
 	return refcount_inc_not_zero(&x->refcnt);
 }
-- 
2.43.0


