Return-Path: <netdev+bounces-298502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CfpqHFq6K2ppDQQAu9opvQ
	(envelope-from <netdev+bounces-298502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:50:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 671286776EE
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:50:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=R56zB0kx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298502-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298502-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B15CA30208E9
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F262D3E121B;
	Fri, 12 Jun 2026 07:48:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945D370D4F
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250499; cv=none; b=YPKo/Qu9T0jpd2RpFhFTewvKtThUtUY8+t1QQUvw8cRqQ5eV475JpxFZkPKML8Edn20dk1FzdUzh8WkJI620DZImVdHC2tK0r/3/1x5bU5c56jiMs1krUf01Ldbe7yC9L+bKpFfF4wAhH8lQWyfLSfDEOFvS5cRrwvmhe79Qq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250499; c=relaxed/simple;
	bh=sdeei0aUezDKpXai34zM0um+iBG7tac9Y8asMKlmi2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSG4dLtMgDeCIIDk7yO52alDBKS0C1IzoI6w2jhU1kP9NJqAct4kR5OI/uULFCZlj5ttYc2iLF1Yc++hi3wF2oFZSejVQn0CRbrduWF+oPtISnuVLozEQ8uJB4JK0kO+P6rzqQpOwDOZKV7YwCvMeQAfJuWtMFvkqMzpfh3R8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=R56zB0kx; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D25FB206E9;
	Fri, 12 Jun 2026 09:48:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E3Qxaee6WxzC; Fri, 12 Jun 2026 09:48:16 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 14D43206D2;
	Fri, 12 Jun 2026 09:48:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 14D43206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250496;
	bh=ZAc/pRK5zqa0xWxtd79DkF6aO+hWzMnJVUFuXuJrkso=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=R56zB0kxBu+rlnZgnMk+Fa6TpzLv1hhMN2amoTo/bgIKdro8/2AGcyax6W3O2EFQ3
	 uAzTfvuykDBqK8yyCjrUj1UgXpeaVmzqPJ8+XXakfbwF1iztYcJ8cPCzv6wsroX2gL
	 kJjqqi7JzmJaPyzaCPhRCzhj0eOcYjai38y9tWh7P3xeDTqBL9F4s1/57+9e/i2Fru
	 RdX08wyuX8NCR9Ikanel/odB3oPzZdIz9n0dfIEj4ElmLLfimrkTk5XrfMT5k8/Onq
	 k7wFG4GIpdQW1D0O5yPqJ3FnXCkZN4I6NYQ8Vv40iNC+8ZleCSDmC3k872H1PNxQ1s
	 x2ggKUU7AcMkg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:48:15 +0200
Received: (nullmailer pid 1768299 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 12/18] xfrm: move encap and xuo into struct xfrm_migrate
Date: Fri, 12 Jun 2026 09:46:28 +0200
Message-ID: <20260612074725.1760473-13-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612074725.1760473-1-steffen.klassert@secunet.com>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298502-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,queasysnail.net:email,secunet.com:dkim,secunet.com:email,secunet.com:mid,secunet.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 671286776EE

From: Antony Antony <antony.antony@secunet.com>

In preparation for an upcoming patch, move the xfrm_encap_tmpl and
xfrm_user_offload pointers from separate parameters into struct
xfrm_migrate, reducing the parameter count of
xfrm_state_migrate_create(), xfrm_state_migrate_install()
and xfrm_state_migrate()

The fields are placed after the four xfrm_address_t members where
the struct is naturally 8-byte aligned, avoiding padding.

No functional change.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     |  7 ++-----
 net/xfrm/xfrm_policy.c |  4 +++-
 net/xfrm/xfrm_state.c  | 20 +++++++-------------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index be22c26e4661..4b29ab92c2a7 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -682,6 +682,8 @@ struct xfrm_migrate {
 	xfrm_address_t		old_saddr;
 	xfrm_address_t		new_daddr;
 	xfrm_address_t		new_saddr;
+	struct xfrm_encap_tmpl *encap;
+	struct xfrm_user_offload *xuo;
 	u8			proto;
 	u8			mode;
 	u16			reserved;
@@ -1897,20 +1899,15 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 						u32 if_id);
 struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 					     const struct xfrm_migrate *m,
-					     const struct xfrm_encap_tmpl *encap,
 					     struct net *net,
-					     struct xfrm_user_offload *xuo,
 					     struct netlink_ext_ack *extack);
 int xfrm_state_migrate_install(const struct xfrm_state *x,
 			       struct xfrm_state *xc,
 			       const struct xfrm_migrate *m,
-			       struct xfrm_user_offload *xuo,
 			       struct netlink_ext_ack *extack);
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap,
 				      struct net *net,
-				      struct xfrm_user_offload *xuo,
 				      struct netlink_ext_ack *extack);
 int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_bundles,
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index fd505adf080e..cf05d778e2dd 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4680,7 +4680,9 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
 			x_cur[nx_cur] = x;
 			nx_cur++;
-			xc = xfrm_state_migrate(x, mp, encap, net, xuo, extack);
+			mp->encap = encap;
+			mp->xuo = xuo;
+			xc = xfrm_state_migrate(x, mp, net, extack);
 			if (xc) {
 				x_new[nx_new] = xc;
 				nx_new++;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1db48ecda80d..043e573c4f32 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1966,7 +1966,6 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
 }
 
 static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
-					   const struct xfrm_encap_tmpl *encap,
 					   const struct xfrm_migrate *m)
 {
 	struct net *net = xs_net(orig);
@@ -2008,8 +2007,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	}
 	x->props.calgo = orig->props.calgo;
 
-	if (encap) {
-		x->encap = kmemdup(encap, sizeof(*x->encap), GFP_KERNEL);
+	if (m->encap) {
+		x->encap = kmemdup(m->encap, sizeof(*x->encap), GFP_KERNEL);
 		if (!x->encap)
 			goto error;
 		x->mapping_maxage = orig->mapping_maxage;
@@ -2122,14 +2121,12 @@ EXPORT_SYMBOL(xfrm_migrate_state_find);
 
 struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 					     const struct xfrm_migrate *m,
-					     const struct xfrm_encap_tmpl *encap,
 					     struct net *net,
-					     struct xfrm_user_offload *xuo,
 					     struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;
 
-	xc = xfrm_state_clone_and_setup(x, encap, m);
+	xc = xfrm_state_clone_and_setup(x, m);
 	if (!xc) {
 		NL_SET_ERR_MSG(extack, "Failed to clone and setup state");
 		return NULL;
@@ -2141,7 +2138,7 @@ struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
 	}
 
 	/* configure the hardware if offload is requested */
-	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
+	if (m->xuo && xfrm_dev_state_add(net, xc, m->xuo, extack))
 		goto error;
 
 	return xc;
@@ -2155,7 +2152,6 @@ EXPORT_SYMBOL(xfrm_state_migrate_create);
 int xfrm_state_migrate_install(const struct xfrm_state *x,
 			       struct xfrm_state *xc,
 			       const struct xfrm_migrate *m,
-			       struct xfrm_user_offload *xuo,
 			       struct netlink_ext_ack *extack)
 {
 	if (m->new_family == m->old_family &&
@@ -2168,7 +2164,7 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 	} else {
 		if (xfrm_state_add(xc) < 0) {
 			NL_SET_ERR_MSG(extack, "Failed to add migrated state");
-			if (xuo)
+			if (m->xuo)
 				xfrm_dev_state_delete(xc);
 			xc->km.state = XFRM_STATE_DEAD;
 			xfrm_state_put(xc);
@@ -2182,20 +2178,18 @@ EXPORT_SYMBOL(xfrm_state_migrate_install);
 
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap,
 				      struct net *net,
-				      struct xfrm_user_offload *xuo,
 				      struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;
 
-	xc = xfrm_state_migrate_create(x, m, encap, net, xuo, extack);
+	xc = xfrm_state_migrate_create(x, m, net, extack);
 	if (!xc)
 		return NULL;
 
 	xfrm_migrate_sync(xc, x);
 
-	if (xfrm_state_migrate_install(x, xc, m, xuo, extack) < 0)
+	if (xfrm_state_migrate_install(x, xc, m, extack) < 0)
 		return NULL;
 
 	return xc;
-- 
2.43.0


