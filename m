Return-Path: <netdev+bounces-270408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOBtIUL7wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:35:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CD2EE4C1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CCC73007A5D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074433803E7;
	Mon, 23 Mar 2026 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="MDTEdH2+"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B0237F8D0
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254902; cv=none; b=ID6HIB6UnSdx+htR2VUbb0wTCx1+NHpI6FIfjaATcJKnPaLWhoSk5ByOUKonSbPaE7r3Y0XWg/OBmSmWUwFOqCbUbTeBk8AobvO9Tok58hLprcRd9FbBzihf7nVTwaKXEPaih7gFn6bjebcoJKzL5hBrSINFyg+k/nek62/Kp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254902; c=relaxed/simple;
	bh=+iSMUXyvhfDgah4J6pL3Vs5YSafNuIDIgdgS1Izidik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzBGd6ebMt9q1dTMWZOH3pYBhYihUi71lOqbArxLWmFoIuGRZmSzVlsovoLlMfyzbuS54p+gMCwNd4oUAwRmhzGsJXOtH+687Z+SLNakHy6QnO8aj27or7fYee7Cxd7PPNpDxPjNTaUOLxrr7xfKDva4fbb6sQCmhIL2PCwJ1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=MDTEdH2+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D448720728;
	Mon, 23 Mar 2026 09:34:53 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rAkRSgyBGDkR; Mon, 23 Mar 2026 09:34:53 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 42AE6205ED;
	Mon, 23 Mar 2026 09:34:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 42AE6205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254893;
	bh=rItz8FQfx37ANB9Hi8uWshNm2jZ1MLGDEtA0MTf0aRU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=MDTEdH2+mCAL1HsY1MC4Wu7Gu1pImo4YRmmd3IH74Wc2KcmBcmRbgzpgTx+1yxP3f
	 vU/P9fCZRQrtEWXl74yEUcR85dRPFYVo8Pk+CUMt0QQ3LgvQiIDZKHCIzLQevJ8NYH
	 b4v9hbnJwmPDXWvL2w+BRvTKgxRvyxtBenu32875gDSLr8SRj6EVcktfDt8DUbG0Ea
	 5o/XoFJQfgQuQcZunR+3+s/BrgdtnJW4Wdc8ayC9hLe0xSJMfrTTKYpkObJdMOHrH8
	 osdeRarQZCpNkfTHJtSDQVmTlv39faUJNX6thRRj/K0qon6w2h3XC1pwVd+1D/1AJa
	 0XGCIctX7bFfQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:34:52 +0100
Received: (nullmailer pid 2741821 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/20] xfrm: state: fix sparse warnings in xfrm_state_init
Date: Mon, 23 Mar 2026 09:33:49 +0100
Message-ID: <20260323083440.2741292-9-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270408-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8E8CD2EE4C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

Use rcu_assign_pointer, and tmp variables for freeing on the error
path without accessing net->xfrm.state_by*.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ad32085267a5..b81303cccc5e 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3259,6 +3259,7 @@ EXPORT_SYMBOL(xfrm_init_state);
 
 int __net_init xfrm_state_init(struct net *net)
 {
+	struct hlist_head *ndst, *nsrc, *nspi, *nseq;
 	unsigned int sz;
 
 	if (net_eq(net, &init_net))
@@ -3269,18 +3270,25 @@ int __net_init xfrm_state_init(struct net *net)
 
 	sz = sizeof(struct hlist_head) * 8;
 
-	net->xfrm.state_bydst = xfrm_hash_alloc(sz);
-	if (!net->xfrm.state_bydst)
+	ndst = xfrm_hash_alloc(sz);
+	if (!ndst)
 		goto out_bydst;
-	net->xfrm.state_bysrc = xfrm_hash_alloc(sz);
-	if (!net->xfrm.state_bysrc)
+	rcu_assign_pointer(net->xfrm.state_bydst, ndst);
+
+	nsrc = xfrm_hash_alloc(sz);
+	if (!nsrc)
 		goto out_bysrc;
-	net->xfrm.state_byspi = xfrm_hash_alloc(sz);
-	if (!net->xfrm.state_byspi)
+	rcu_assign_pointer(net->xfrm.state_bysrc, nsrc);
+
+	nspi = xfrm_hash_alloc(sz);
+	if (!nspi)
 		goto out_byspi;
-	net->xfrm.state_byseq = xfrm_hash_alloc(sz);
-	if (!net->xfrm.state_byseq)
+	rcu_assign_pointer(net->xfrm.state_byspi, nspi);
+
+	nseq = xfrm_hash_alloc(sz);
+	if (!nseq)
 		goto out_byseq;
+	rcu_assign_pointer(net->xfrm.state_byseq, nseq);
 
 	net->xfrm.state_cache_input = alloc_percpu(struct hlist_head);
 	if (!net->xfrm.state_cache_input)
@@ -3296,13 +3304,13 @@ int __net_init xfrm_state_init(struct net *net)
 	return 0;
 
 out_state_cache_input:
-	xfrm_hash_free(net->xfrm.state_byseq, sz);
+	xfrm_hash_free(nseq, sz);
 out_byseq:
-	xfrm_hash_free(net->xfrm.state_byspi, sz);
+	xfrm_hash_free(nspi, sz);
 out_byspi:
-	xfrm_hash_free(net->xfrm.state_bysrc, sz);
+	xfrm_hash_free(nsrc, sz);
 out_bysrc:
-	xfrm_hash_free(net->xfrm.state_bydst, sz);
+	xfrm_hash_free(ndst, sz);
 out_bydst:
 	return -ENOMEM;
 }
-- 
2.43.0


