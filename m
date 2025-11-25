Return-Path: <netdev+bounces-241472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09399C843A2
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A41D54E2883
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541FC2D5932;
	Tue, 25 Nov 2025 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="x40UTc+S"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D352D97A4
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062983; cv=none; b=Lau4F3hPvcZep9hMHRK4lqCmtxDNDZ5T0yk7chxM4CXbDSkOBYqtCvM5HFLQFlY7UvQNKbYaTWxZROfd5pxPcn1SAVVTmVWmmjj2ZGaA1lnHt9r66eJPoyOFBydZwfRwozq5zUk1RJ01OypEPs0ZxfA5CVRlClO/qiro+pZ4B0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062983; c=relaxed/simple;
	bh=ES8IASO6ChoZarEx/ye+ISjqmNmYQrK8XcDLLnFGggE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6QdKk9s0F6t12eAnV0IrPElQSkp8RICwS9A/9HpeXTpATp9n+SJiBnyQ8MtxE59gYhydwO2+3AxTMPjZly4QhpWMS6TKvFiM1esrydhAnZJtvZ0HE4kTHRKev/U2U2XJsU4yoVcTmmU8FWIOAlLB4T76O/RaUyshNiZZiWQheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=x40UTc+S; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9FFE32088F;
	Tue, 25 Nov 2025 10:29:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Ok9qo0GVjUi; Tue, 25 Nov 2025 10:29:39 +0100 (CET)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id DEFA320885;
	Tue, 25 Nov 2025 10:29:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com DEFA320885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764062978;
	bh=ePEz30IUrfWzczs50rDT0Lm06MJ5TvI+L+LRIk/3vqM=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=x40UTc+SNCCA9fWaf+FLuesQSVfN04LMzI89ZswbSNOHnHNoJPSZwB0ASnDqZy10N
	 3MzNeHu1VZ5LeLVlgeJGWcXv/ONzD4a2M57iOM1Bl16Uu29koAVoReS4Oip+Q2dJct
	 VtzP7YRLmOcIJ789x0Xl0r0xv/iI/68FT5arAEWPw1UXctaB6tw6fB7LQPq99WbJ1V
	 a0MMs2L9xnKOchr1iVXYDm+XSJr9GwqxCbIV2PPRmecteZP6ORt+iHqUkY2NZKoVIc
	 cHRil93u5zmMQZEuKlwJdYJHUysp2j8XcpME/CpzY0iN11rFk4qJcEtS4RBQxstsGi
	 ec9Ujv++GG1wA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 25 Nov
 2025 10:29:38 +0100
Date: Tue, 25 Nov 2025 10:29:30 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH RFC ipsec-next 2/5] xfrm: rename reqid in xfrm_migrate
Message-ID: <4fea66cdb792ea23526ccb4c6a7266e6497170b1.1764061159.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1764061158.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1764061158.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-02.secunet.de (10.32.0.172)

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
index f3014e4f54fc..ae35a0499168 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -684,7 +684,7 @@ struct xfrm_migrate {
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
index 1770b56c8587..62ccdf35cd0e 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2079,14 +2079,14 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 
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
index 010c9e6638c0..027e9ad10b45 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3081,7 +3081,7 @@ static int copy_from_user_migrate(struct xfrm_migrate *ma,
 
 		ma->proto = um->proto;
 		ma->mode = um->mode;
-		ma->reqid = um->reqid;
+		ma->old_reqid = um->reqid;
 
 		ma->old_family = um->old_family;
 		ma->new_family = um->new_family;
@@ -3164,7 +3164,7 @@ static int copy_to_user_migrate(const struct xfrm_migrate *m, struct sk_buff *sk
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


