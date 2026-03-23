Return-Path: <netdev+bounces-270417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GkfHYz7wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:36:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE982EE50B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06227301683B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A8537FF67;
	Mon, 23 Mar 2026 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="CURZ22pN"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED773803F5
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254909; cv=none; b=b4gKuTd419n16L3vxVGg2bMfrOdGmqxzgSiGvviBwZv+QSM0giTS6qPvPd6uNVgQejJA8fspsQBFNnNE3mpV2h1cbuZIm26456Oi1n+kv/+8l623ISgmB7LvgkeSmODwvSxl2sjjnU+HVzexDE7kRWUel7nU3o0TzpIGMLZPSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254909; c=relaxed/simple;
	bh=DdFJEiXrLlv4Q/DcCuYOBcDw8zwQrucBKtW70zGWbd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTw3UkixoCXp7zVFvvaJUXqwRwhyi1NqQc6En5CrJBC7vTXFY6hFw+/oJZgLHP89C6WzgG1/Yp65u+nLBr/4diAs3bo2Ysc3jwWMMRk2c/6yTx6gFM5Xg1x2Kuu8CVMGy3SZtL1SGdk0iBcBsBdiR5G7FlUNUaky57R62x0IOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=CURZ22pN; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2D0D5206DF;
	Mon, 23 Mar 2026 09:35:05 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OQAMcRPZufUH; Mon, 23 Mar 2026 09:35:04 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 874DA20728;
	Mon, 23 Mar 2026 09:35:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 874DA20728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254904;
	bh=mfDHUpwo574i0EfvuISn7xqu2z36NBWOVKlF11SvxbI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=CURZ22pNZg4aX8lXgZ4de7vuVnTgwBSbHyjT9H1Z29xj2m77ESMWSG6eaBG5cF4W0
	 bdB/N7wMSkQyNRkF/6zAtdjARwI4FQWAXneGgpWjYQIe0/zyxVURgl+Mu3Id5tfkQG
	 9nVQWTFBEV7bqxvxUtMb7KsqObEvwYrGuXpM3J9cNcvyus6JM0rwIvb2vDL7vaEwZ3
	 Tdd+1HyQYMzzoXTkN3dRTPrDCM0lbn+d04QOlcJ3sJX2AujXekfdJw1/al5Dig9iGL
	 AP6QZpTIAXaTl/is+87BfPkSWiywi7WZvEOlefNoDqSMT2svBzKpevjNIaV9zHohIZ
	 wTZwzYSwRdQbA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:35:04 +0100
Received: (nullmailer pid 2741836 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 13/20] xfrm: policy: fix sparse warnings in xfrm_policy_{init,fini}
Date: Mon, 23 Mar 2026 09:33:54 +0100
Message-ID: <20260323083440.2741292-14-steffen.klassert@secunet.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270417-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2DE982EE50B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

In xfrm_policy_init:
add rcu_assign_pointer to fix warning:
net/xfrm/xfrm_policy.c:4238:29: warning: incorrect type in assignment (different address spaces)
net/xfrm/xfrm_policy.c:4238:29:    expected struct hlist_head [noderef] __rcu *table
net/xfrm/xfrm_policy.c:4238:29:    got struct hlist_head *

add rcu_dereference_protected to silence warning:
net/xfrm/xfrm_policy.c:4265:36: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_policy.c:4265:36:    expected struct hlist_head *n
net/xfrm/xfrm_policy.c:4265:36:    got struct hlist_head [noderef] __rcu *table

The netns is being created, no concurrent access is possible yet.

In xfrm_policy_fini, net is going away, there shouldn't be any
concurrent changes to the hashtables, so we can use
rcu_dereference_protected to silence warnings:
net/xfrm/xfrm_policy.c:4291:17: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_policy.c:4291:17:    expected struct hlist_head const *h
net/xfrm/xfrm_policy.c:4291:17:    got struct hlist_head [noderef] __rcu *table
net/xfrm/xfrm_policy.c:4292:36: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_policy.c:4292:36:    expected struct hlist_head *n
net/xfrm/xfrm_policy.c:4292:36:    got struct hlist_head [noderef] __rcu *table

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 5428185196a1..49de5a6f4b85 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4242,7 +4242,7 @@ static int __net_init xfrm_policy_init(struct net *net)
 		net->xfrm.policy_count[XFRM_POLICY_MAX + dir] = 0;
 
 		htab = &net->xfrm.policy_bydst[dir];
-		htab->table = xfrm_hash_alloc(sz);
+		rcu_assign_pointer(htab->table, xfrm_hash_alloc(sz));
 		if (!htab->table)
 			goto out_bydst;
 		htab->hmask = hmask;
@@ -4269,7 +4269,7 @@ static int __net_init xfrm_policy_init(struct net *net)
 		struct xfrm_policy_hash *htab;
 
 		htab = &net->xfrm.policy_bydst[dir];
-		xfrm_hash_free(htab->table, sz);
+		xfrm_hash_free(rcu_dereference_protected(htab->table, true), sz);
 	}
 	xfrm_hash_free(net->xfrm.policy_byidx, sz);
 out_byidx:
@@ -4295,8 +4295,8 @@ static void xfrm_policy_fini(struct net *net)
 
 		htab = &net->xfrm.policy_bydst[dir];
 		sz = (htab->hmask + 1) * sizeof(struct hlist_head);
-		WARN_ON(!hlist_empty(htab->table));
-		xfrm_hash_free(htab->table, sz);
+		WARN_ON(!hlist_empty(rcu_dereference_protected(htab->table, true)));
+		xfrm_hash_free(rcu_dereference_protected(htab->table, true), sz);
 	}
 
 	sz = (net->xfrm.policy_idx_hmask + 1) * sizeof(struct hlist_head);
-- 
2.43.0


