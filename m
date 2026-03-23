Return-Path: <netdev+bounces-270419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN+eL5P7wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:36:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E079A2EE51A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE8893010203
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C4381AE2;
	Mon, 23 Mar 2026 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="trIWBX/X"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071D37FF5D
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254911; cv=none; b=AkBM/lNWqDuUS5hbNcWWngeWrzuD62EeE/kxTIgRAtUlMfgA5Gnl124IhV++E0Tbsr55mZGP0mBngQnjpf6AKUlbKiuPd5gP8o3Ft+zxlhN9/Mn7eVDcEvQN/6bYxQ3Nazu0tl9ofRq5dQ6SPz6KpZcVIIB4grsahxgT+bvCDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254911; c=relaxed/simple;
	bh=5SLKuzIMqPr7QOUXKK5rgjEluKSyE3It67feRpZHclQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUFP/LG9SI08R1G3opBtgJS5yETvjlJm6yhv4aTA9GMUkDcvfDqztaAf8cMgK1vsz2IZvzIRR2Oy9Uo8kNlmvWRMQo3AqBT7PyXHfEVRGMgA/pnrMdHvdk0vjbdCkUZS4FAK9V+Tjr98TnMPgE+8kEbHnSfnSTKS34edOh7TxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=trIWBX/X; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id ACBD5207AC;
	Mon, 23 Mar 2026 09:35:08 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iz4W5gtUMzy5; Mon, 23 Mar 2026 09:35:08 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EBDAB20728;
	Mon, 23 Mar 2026 09:35:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EBDAB20728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254908;
	bh=Gv9Us7jzRQFWIC7I6vtbT3l0HLQCpnIgUIq+IJB6HGw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=trIWBX/X4wVwOoWsgL9TCRQ+zq3ICJL4ry/SjuFDpHDFI/MGKTxLcAHd3JWNWyYQa
	 n4+OgEh+VRNKf30bPnoCJCJHhRHYWZRlrJcAWNdbU9ZPJ8EjxwPSml8vxjGs7LsJDN
	 cROVvsrlMNPxzieisQYii/npFsISaOFwnbdEZyZzVWxSZ/e1ZG7Y0cJ3q1XYiqUCEs
	 xcbWBtQBF7tsqyG1OGMUDgCcJ7xd0wHKHl0u3rLVkrxV2h7ZpM1p6+gRAMGIr7wzRB
	 FBJJGKkf9u+IJgfjHnvBROlNUqOg6UVGywjY6ZFcs/emiteOpmGy3+8qdi3+hfV3kq
	 idUW8Su3VF4rw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:35:07 +0100
Received: (nullmailer pid 2741824 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/20] xfrm: state: fix sparse warnings around XFRM_STATE_INSERT
Date: Mon, 23 Mar 2026 09:33:50 +0100
Message-ID: <20260323083440.2741292-10-steffen.klassert@secunet.com>
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
	TAGGED_FROM(0.00)[bounces-270419-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:email,secunet.com:mid,queasysnail.net:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E079A2EE51A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

We're under xfrm_state_lock in all those cases, use
xfrm_state_deref_prot(state_by*) to avoid sparse warnings:

net/xfrm/xfrm_state.c:2597:25: warning: cast removes address space '__rcu' of expression
net/xfrm/xfrm_state.c:2597:25: warning: incorrect type in argument 2 (different address spaces)
net/xfrm/xfrm_state.c:2597:25:    expected struct hlist_head *h
net/xfrm/xfrm_state.c:2597:25:    got struct hlist_head [noderef] __rcu *

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index b81303cccc5e..34cf9f361683 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1563,23 +1563,23 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			list_add(&x->km.all, &net->xfrm.state_all);
 			h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
 			XFRM_STATE_INSERT(bydst, &x->bydst,
-					  net->xfrm.state_bydst + h,
+					  xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h,
 					  x->xso.type);
 			h = xfrm_src_hash(net, daddr, saddr, encap_family);
 			XFRM_STATE_INSERT(bysrc, &x->bysrc,
-					  net->xfrm.state_bysrc + h,
+					  xfrm_state_deref_prot(net->xfrm.state_bysrc, net) + h,
 					  x->xso.type);
 			INIT_HLIST_NODE(&x->state_cache);
 			if (x->id.spi) {
 				h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
 				XFRM_STATE_INSERT(byspi, &x->byspi,
-						  net->xfrm.state_byspi + h,
+						  xfrm_state_deref_prot(net->xfrm.state_byspi, net) + h,
 						  x->xso.type);
 			}
 			if (x->km.seq) {
 				h = xfrm_seq_hash(net, x->km.seq);
 				XFRM_STATE_INSERT(byseq, &x->byseq,
-						  net->xfrm.state_byseq + h,
+						  xfrm_state_deref_prot(net->xfrm.state_byseq, net) + h,
 						  x->xso.type);
 			}
 			x->lft.hard_add_expires_seconds = net->xfrm.sysctl_acq_expires;
@@ -1730,25 +1730,29 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 
 	h = xfrm_dst_hash(net, &x->id.daddr, &x->props.saddr,
 			  x->props.reqid, x->props.family);
-	XFRM_STATE_INSERT(bydst, &x->bydst, net->xfrm.state_bydst + h,
+	XFRM_STATE_INSERT(bydst, &x->bydst,
+			  xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h,
 			  x->xso.type);
 
 	h = xfrm_src_hash(net, &x->id.daddr, &x->props.saddr, x->props.family);
-	XFRM_STATE_INSERT(bysrc, &x->bysrc, net->xfrm.state_bysrc + h,
+	XFRM_STATE_INSERT(bysrc, &x->bysrc,
+			  xfrm_state_deref_prot(net->xfrm.state_bysrc, net) + h,
 			  x->xso.type);
 
 	if (x->id.spi) {
 		h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto,
 				  x->props.family);
 
-		XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h,
+		XFRM_STATE_INSERT(byspi, &x->byspi,
+				  xfrm_state_deref_prot(net->xfrm.state_byspi, net) + h,
 				  x->xso.type);
 	}
 
 	if (x->km.seq) {
 		h = xfrm_seq_hash(net, x->km.seq);
 
-		XFRM_STATE_INSERT(byseq, &x->byseq, net->xfrm.state_byseq + h,
+		XFRM_STATE_INSERT(byseq, &x->byseq,
+				  xfrm_state_deref_prot(net->xfrm.state_byseq, net) + h,
 				  x->xso.type);
 	}
 
@@ -1868,10 +1872,12 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 			      ktime_set(net->xfrm.sysctl_acq_expires, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		list_add(&x->km.all, &net->xfrm.state_all);
-		XFRM_STATE_INSERT(bydst, &x->bydst, net->xfrm.state_bydst + h,
+		XFRM_STATE_INSERT(bydst, &x->bydst,
+				  xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h,
 				  x->xso.type);
 		h = xfrm_src_hash(net, daddr, saddr, family);
-		XFRM_STATE_INSERT(bysrc, &x->bysrc, net->xfrm.state_bysrc + h,
+		XFRM_STATE_INSERT(bysrc, &x->bysrc,
+				  xfrm_state_deref_prot(net->xfrm.state_bysrc, net) + h,
 				  x->xso.type);
 
 		net->xfrm.state_num++;
@@ -2603,7 +2609,9 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 		if (!x0) {
 			x->id.spi = newspi;
 			h = xfrm_spi_hash(net, &x->id.daddr, newspi, x->id.proto, x->props.family);
-			XFRM_STATE_INSERT(byspi, &x->byspi, net->xfrm.state_byspi + h, x->xso.type);
+			XFRM_STATE_INSERT(byspi, &x->byspi,
+					  xfrm_state_deref_prot(net->xfrm.state_byspi, net) + h,
+					  x->xso.type);
 			spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 			err = 0;
 			goto unlock;
-- 
2.43.0


