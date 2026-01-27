Return-Path: <netdev+bounces-253807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLoEGDCYeGkWrQEAu9opvQ
	(envelope-from <netdev+bounces-253807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:49:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F256D93244
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48866304138B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9823A34321C;
	Tue, 27 Jan 2026 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GStVtCRc"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144C33BBAB;
	Tue, 27 Jan 2026 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510606; cv=none; b=p9tctZ++Vauc3SQCVaawnRIgn27V//hMeTX1aKMzUXFcWCoi972p5fRELPBlTVmkCSkY2a3Zdf1EhodRhIfkTsainueAcEQVF2qutuUbxhPBPWT3U6IzKuZM0jYGtXQL8Lqm4bIAdpup8O7Svdvn+N7GxMDa4uzT0G0r/7+Akf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510606; c=relaxed/simple;
	bh=9YumfEYvgLJahczTOTH1w3tBkHUblnkyZnC5CqmCnAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t40JuchwevuK7SYQ0h725SBRFQoyiMvKUMxGGsh7Dc4XjFMCHa2JRn/Z2qxY82C4aolInoHYOiX+qyY84GmvOqlSRbJW+bT+HONeXRP0sX0IxZWQmIAsjcSboQ/0MuQYScwcsKlJVwlVSGMZfCVdIzLcGduB2NCB7XEp2L9QKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GStVtCRc; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A4C48206E9;
	Tue, 27 Jan 2026 11:43:23 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f2GMjmhnFov3; Tue, 27 Jan 2026 11:43:22 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CF0E62006C;
	Tue, 27 Jan 2026 11:43:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CF0E62006C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769510602;
	bh=L+NfgA2t9+/mgVu8sJuQjFwQzK7rs71DKp1LqnBeQp4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=GStVtCRc8bmIQjiW/Hi8LYJL5Dk/qtUMjGzNDKTPyoxQt4LoZrPP5XLXx22ETmY04
	 LPr47Y1lbTfeOFDX64vV3+oSiZsxTwGNx1XU5kjqiL4torm9skv2kaslgY3jz6lAs6
	 ZwrZ7OW6EKoTV6rOd8eHq5rI7bEk6gEjR13pfkM+oee7bOXZ4Kti+CbXxvjxFNFuua
	 723k/CW7rb/rxMJouhylB54UZwPSE75EzWoSnZ40ZyX6xrdveSdEskrrlJhUYm2d75
	 wdyb3M6yrEHGrxjyuCteVjhGN2tI83fFVx72XzPzUy5uap1OkRbVTj1YRmeHHJ9uFS
	 3sPrMf05bZN2g==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 11:43:21 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v5 5/8] xfrm: split xfrm_state_migrate into create and install functions
Date: Tue, 27 Jan 2026 11:43:09 +0100
Message-ID: <959d2091e5a0c3492a477cc9d5d971d1d8c88400.1769509131.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1769509130.git.antony.antony@secunet.com>
References: <cover.1769509130.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253807-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:email,secunet.com:dkim,secunet.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F256D93244
X-Rspamd-Action: no action

To prepare for subsequent patches, split
xfrm_state_migrate() into two functions:
- xfrm_state_migrate_create(): creates the migrated state
- xfrm_state_migrate_install(): installs it into the state table

splitting will help to avoid SN/IV reuse when migrating AEAD SA.

And add const whenever possible.
No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v4->v5: - added this patch
---
 include/net/xfrm.h    | 11 +++++++
 net/xfrm/xfrm_state.c | 73 +++++++++++++++++++++++++++++++------------
 2 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 05fa0552523d..a920d64d8cfa 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1895,6 +1895,17 @@ int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_encap_tmpl *encap);
 struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *net,
 						u32 if_id);
+struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
+					     const struct xfrm_migrate *m,
+					     const struct xfrm_encap_tmpl *encap,
+					     struct net *net,
+					     struct xfrm_user_offload *xuo,
+					     struct netlink_ext_ack *extack);
+int xfrm_state_migrate_install(const struct xfrm_state *x,
+			       struct xfrm_state *xc,
+			       const struct xfrm_migrate *m,
+			       struct xfrm_user_offload *xuo,
+			       struct netlink_ext_ack *extack);
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
 				      struct xfrm_encap_tmpl *encap,
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index bbdb0dba16b9..35c82926665a 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1966,8 +1966,8 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
 }

 static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
-					   struct xfrm_encap_tmpl *encap,
-					   struct xfrm_migrate *m)
+					   const struct xfrm_encap_tmpl *encap,
+					   const struct xfrm_migrate *m)
 {
 	struct net *net = xs_net(orig);
 	struct xfrm_state *x = xfrm_state_alloc(net);
@@ -2124,12 +2124,12 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 }
 EXPORT_SYMBOL(xfrm_migrate_state_find);

-struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
-				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap,
-				      struct net *net,
-				      struct xfrm_user_offload *xuo,
-				      struct netlink_ext_ack *extack)
+struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
+					     const struct xfrm_migrate *m,
+					     const struct xfrm_encap_tmpl *encap,
+					     struct net *net,
+					     struct xfrm_user_offload *xuo,
+					     struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;

@@ -2144,24 +2144,57 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
 		goto error;

-	/* add state */
+	return xc;
+error:
+	xc->km.state = XFRM_STATE_DEAD;
+	xfrm_state_put(xc);
+	return NULL;
+}
+EXPORT_SYMBOL(xfrm_state_migrate_create);
+
+int xfrm_state_migrate_install(const struct xfrm_state *x,
+			       struct xfrm_state *xc,
+			       const struct xfrm_migrate *m,
+			       struct xfrm_user_offload *xuo,
+			       struct netlink_ext_ack *extack)
+{
 	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
-		/* a care is needed when the destination address of the
-		   state is to be updated as it is a part of triplet */
+		/*
+		 * Care is needed when the destination address
+		 * of the state is to be updated as it is a part of triplet.
+		 */
 		xfrm_state_insert(xc);
 	} else {
-		if (xfrm_state_add(xc) < 0)
-			goto error_add;
+		if (xfrm_state_add(xc) < 0) {
+			if (xuo)
+				xfrm_dev_state_delete(xc);
+			xc->km.state = XFRM_STATE_DEAD;
+			xfrm_state_put(xc);
+			return -EEXIST;
+		}
 	}

+	return 0;
+}
+EXPORT_SYMBOL(xfrm_state_migrate_install);
+
+struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
+				      struct xfrm_migrate *m,
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack)
+{
+	struct xfrm_state *xc;
+
+	xc = xfrm_state_migrate_create(x, m, encap, net, xuo, extack);
+	if (!xc)
+		return NULL;
+
+	if (xfrm_state_migrate_install(x, xc, m, xuo, extack) < 0)
+		return NULL;
+
 	return xc;
-error_add:
-	if (xuo)
-		xfrm_dev_state_delete(xc);
-error:
-	xc->km.state = XFRM_STATE_DEAD;
-	xfrm_state_put(xc);
-	return NULL;
 }
 EXPORT_SYMBOL(xfrm_state_migrate);
 #endif
--
2.39.5


