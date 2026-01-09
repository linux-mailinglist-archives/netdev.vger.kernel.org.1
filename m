Return-Path: <netdev+bounces-248511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7188D0A774
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38FA4305CD36
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C42248B3;
	Fri,  9 Jan 2026 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hLRAo+V/"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273932BF21
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965877; cv=none; b=cLP1+apefp3oQTCqHgOYzOfoTeVRrdH7OKWIExPJOPLLyNjkuPQ2ux8qTXYuikuzu2csVjYYw+R3NltfFmq/6xtwGYUJuBKaYe637VppnHgrVEd7ET1SCCu6Y9GV72FaZK/WS6s/+ea2PzhU6s/FdKXKGM3BA1PMUymxfOQf1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965877; c=relaxed/simple;
	bh=fNeawLUz5CfL7Yxh4fHU431c19SFGsiYsZ/9hme8RWs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AttjZfc6XthjGo+tUV1WOrBAnV8hZD4K0IXFkS3vs+Ac5NFMq4Xf8XOoqlwCungSL4IxmqvxGziAjUt5SM0umFMKB/TpcXwSLOHB+veqhe7Sh6EDipDaOupIHrnWdm7aFa6MKEiT4pY3ZXiVcwBIlJWEaONUOMQr257dHAhAico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hLRAo+V/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9A5E3207BE;
	Fri,  9 Jan 2026 14:37:54 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0K3qBJLClulk; Fri,  9 Jan 2026 14:37:54 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F0E8C206B0;
	Fri,  9 Jan 2026 14:37:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F0E8C206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1767965874;
	bh=MA8fmP6b1yEM/gHcrCOpLqOHliJmDHXPRK5U4RLoE+s=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=hLRAo+V/hASKSaWGo33JGuExRtZLMeVUAJ4tMLsNYTjkf4EQ9niBwm/7x0mz7upuF
	 cNVeWX77kSbzLLpF1T85zwzn9oVPb20AOWdr05yJ/bW4owr89tvZ7I7p0YLBX93CIS
	 FhbYCxozYqAAayC1rNc5KlAqeNHEuA8JT6jBao0UfUJx765Yag8eouhinjzcsZxN31
	 sFoG2z5X1PQDFWeDahbydhu8Sb10OcanprCnFuIhbwIFiPequajPS40xmndNr8PFE6
	 EJTlb2cKW4047EqMJtjZBTa2ZTPJ+4s9lyg1KbIntiRCq9MnRfq3qNLs/iVSzpdLml
	 JGGd4bmJXC94g==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 14:37:53 +0100
Date: Fri, 9 Jan 2026 14:37:46 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next 3/6] xfrm: rename reqid in xfrm_migrate
Message-ID: <da4ea53d024b31d7d365294a4a44ca6cde83cd8d.1767964254.git.antony@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <cover.1767964254.git.antony@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1767964254.git.antony@moon.secunet.de>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)

In prepreation for the following patch rename s/reqid/old_reqid/.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/xfrm.h     |  2 +-
 net/key/af_key.c       | 10 +++++-----
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  |  6 +++---
 net/xfrm/xfrm_user.c   |  4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 0a14daaa5dd4..05fa0552523d 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -685,7 +685,7 @@ struct xfrm_migrate {
 	u8			proto;
 	u8			mode;
 	u16			reserved;
-	u32			reqid;
+	u32			old_reqid;
 	u16			old_family;
 	u16			new_family;
 };
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 571200433aa9..7d5cf386654c 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2538,7 +2538,7 @@ static int ipsecrequests_to_migrate(struct sadb_x_ipsecrequest *rq1, int len,
 	if ((mode = pfkey_mode_to_xfrm(rq1->sadb_x_ipsecrequest_mode)) < 0)
 		return -EINVAL;
 	m->mode = mode;
-	m->reqid = rq1->sadb_x_ipsecrequest_reqid;
+	m->old_reqid = rq1->sadb_x_ipsecrequest_reqid;
 
 	return ((int)(rq1->sadb_x_ipsecrequest_len +
 		      rq2->sadb_x_ipsecrequest_len));
@@ -3634,15 +3634,15 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		if (mode < 0)
 			goto err;
 		if (set_ipsecrequest(skb, mp->proto, mode,
-				     (mp->reqid ?  IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
-				     mp->reqid, mp->old_family,
+				     (mp->old_reqid ?  IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
+				     mp->old_reqid, mp->old_family,
 				     &mp->old_saddr, &mp->old_daddr) < 0)
 			goto err;
 
 		/* new ipsecrequest */
 		if (set_ipsecrequest(skb, mp->proto, mode,
-				     (mp->reqid ? IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
-				     mp->reqid, mp->new_family,
+				     (mp->old_reqid ? IPSEC_LEVEL_UNIQUE : IPSEC_LEVEL_REQUIRE),
+				     mp->old_reqid, mp->new_family,
 				     &mp->new_saddr, &mp->new_daddr) < 0)
 			goto err;
 	}
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..854dfc16ed55 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4530,7 +4530,7 @@ static int migrate_tmpl_match(const struct xfrm_migrate *m, const struct xfrm_tm
 	int match = 0;
 
 	if (t->mode == m->mode && t->id.proto == m->proto &&
-	    (m->reqid == 0 || t->reqid == m->reqid)) {
+	    (m->old_reqid == 0 || t->reqid == m->old_reqid)) {
 		switch (t->mode) {
 		case XFRM_MODE_TUNNEL:
 		case XFRM_MODE_BEET:
@@ -4624,7 +4624,7 @@ static int xfrm_migrate_check(const struct xfrm_migrate *m, int num_migrate,
 				    sizeof(m[i].old_saddr)) &&
 			    m[i].proto == m[j].proto &&
 			    m[i].mode == m[j].mode &&
-			    m[i].reqid == m[j].reqid &&
+			    m[i].old_reqid == m[j].old_reqid &&
 			    m[i].old_family == m[j].old_family) {
 				NL_SET_ERR_MSG(extack, "Entries in the MIGRATE attribute's list must be unique");
 				return -EINVAL;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e5e8342a4e0a..ef832ce477b6 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2081,14 +2081,14 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 
-	if (m->reqid) {
+	if (m->old_reqid) {
 		h = xfrm_dst_hash(net, &m->old_daddr, &m->old_saddr,
-				  m->reqid, m->old_family);
+				  m->old_reqid, m->old_family);
 		hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
 			if (x->props.mode != m->mode ||
 			    x->id.proto != m->proto)
 				continue;
-			if (m->reqid && x->props.reqid != m->reqid)
+			if (m->old_reqid && x->props.reqid != m->old_reqid)
 				continue;
 			if (if_id != 0 && x->if_id != if_id)
 				continue;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac2c5..26b82d94acc1 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3087,7 +3087,7 @@ static int copy_from_user_migrate(struct xfrm_migrate *ma,
 
 		ma->proto = um->proto;
 		ma->mode = um->mode;
-		ma->reqid = um->reqid;
+		ma->old_reqid = um->reqid;
 
 		ma->old_family = um->old_family;
 		ma->new_family = um->new_family;
@@ -3170,7 +3170,7 @@ static int copy_to_user_migrate(const struct xfrm_migrate *m, struct sk_buff *sk
 	memset(&um, 0, sizeof(um));
 	um.proto = m->proto;
 	um.mode = m->mode;
-	um.reqid = m->reqid;
+	um.reqid = m->old_reqid;
 	um.old_family = m->old_family;
 	memcpy(&um.old_daddr, &m->old_daddr, sizeof(um.old_daddr));
 	memcpy(&um.old_saddr, &m->old_saddr, sizeof(um.old_saddr));
-- 
2.39.5


