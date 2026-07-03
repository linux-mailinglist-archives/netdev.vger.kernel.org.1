Return-Path: <netdev+bounces-304624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id llDYAnXsR2qwhgAAu9opvQ
	(envelope-from <netdev+bounces-304624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:08:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B03A704898
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:08:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=LMuPNf6P;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304624-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304624-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 642483019509
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE42BEFEE;
	Fri,  3 Jul 2026 17:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F4433E92;
	Fri,  3 Jul 2026 17:07:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098482; cv=none; b=qRD7SE+ZVOb4jQtQtF4+VJuYiR4YNM+OkN2XwEO6Zr4GuZDuuuSlN5OEokWXUCz1ew2Js78hk8KgEy0sMFVVdy7siXbYXAHRsaiOvNz6/srcAGH/njQhDvVq6JekPjJAbcph1ZEJ9Vx3mkj/uYZ8DfYUDkHcdSl267QdByOr584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098482; c=relaxed/simple;
	bh=PMiOeVqxr5FlSVi/VMmRMEA6bAxsr47i0e2W+DkOtHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZ6FxkAzx6Plea1M1jCa4bl+sQN5408UKQ5zGoTA2kwjaFMnE0FVysfrDdhhQGGc4crltdNPV7u6WCbf66OSfUILZ5IMtx6N2HLAZU7ecGq2nP3pJTZIEd5wUutMQtLeoWquqWItlD8Bae3Qzxq3LuQq/PPS1r4BgNP6vRym9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=LMuPNf6P; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C65C1206D2;
	Fri,  3 Jul 2026 19:07:50 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yEFN8pRTWpjr; Fri,  3 Jul 2026 19:07:49 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D009920612;
	Fri,  3 Jul 2026 19:07:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D009920612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783098469;
	bh=XK6tcWJtHkBmnDkcInoIAHg4SGs9356CMyKVHhkn7GY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=LMuPNf6PKknxhZSsKRkzxhb+lzrxTOxFAguCwXjfGzmfZIXsDZdbRngfVG68/nbJa
	 sXxOnyF/l9t2EApIBPesl/9sJ7BKT4ptFo+UrSKqkCRA7Ik39B4kc0Xgi7Hel+8if1
	 ThdrOivxcG0EbHrAT0wrRamqnCs8WQolH7FjcPZ0WVC6o7aS09nqmevfru3WJQWH6x
	 3cF8CIECq72TuTl/h4+uq1LlPYxc2F0A8Cdw1pYwGZ1C7BAcmckh6pg4NkQaNBgvbW
	 ARHtgFSEMBu/eyWQQ1iOVZklYqiODxA56efPBFlXPUQXU+teGgEiTDW1YMxM6oIQF4
	 BgHtIwW1CBNSQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 19:07:49 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH ipsec 1/8] xfrm: state: exact mark/mask match for SPI-keyed control-plane SA lookups
Date: Fri, 3 Jul 2026 19:07:34 +0200
Message-ID: <migrate-state-fixes-v0-1-a69e8637ba3b@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v0-0-a69e8637ba3b@secunet.com>
References: <migrate-state-fixes-v0-0-a69e8637ba3b@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:antony.antony@secunet.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:hadi@cyberus.ca,m:shuah@kernel.org,m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:evitayan@google.com,m:tobias@strongswan.org,m:fw@strlen.de,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304624-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B03A704898

Add __xfrm_state_lookup_exact(), an identity-match like
__xfrm_state_lookup().

Wire it into every SPI-keyed control-plane path: DELSA/GETSA, UPDSA,
GETAE/NEWAE, EXPIRE, MIGRATE_STATE.

xfrm_state_add()'s duplicate-detect keeps the wildcard
__xfrm_state_locate() - unrelated, unchanged.

Fixes: 3d6acfa7641f ("xfrm: SA lookups with mark")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/xfrm.h    |  3 ++
 net/xfrm/xfrm_state.c | 80 ++++++++++++++++++++++++++++++++++++++++++++-------
 net/xfrm/xfrm_user.c  | 29 ++++++++++---------
 3 files changed, 88 insertions(+), 24 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 519a0156a05c..f6ed590cb2ff 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1746,6 +1746,9 @@ struct xfrm_state *xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 					    const xfrm_address_t *saddr,
 					    u8 proto,
 					    unsigned short family);
+struct xfrm_state *xfrm_state_lookup_exact(struct net *net, const struct xfrm_mark *mark,
+					   const xfrm_address_t *daddr, __be32 spi,
+					   u8 proto, unsigned short family);
 #ifdef CONFIG_XFRM_SUB_POLICY
 void xfrm_tmpl_sort(struct xfrm_tmpl **dst, struct xfrm_tmpl **src, int n,
 		    unsigned short family);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c58cd024e3c6..df761ce1c290 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1172,11 +1172,22 @@ static struct xfrm_state *__xfrm_state_lookup_all(const struct xfrm_hash_state_p
 	return NULL;
 }
 
-static struct xfrm_state *__xfrm_state_lookup(const struct xfrm_hash_state_ptrs *state_ptrs,
-					      u32 mark,
-					      const xfrm_address_t *daddr,
-					      __be32 spi, u8 proto,
-					      unsigned short family)
+/* exact=false: data-plane wildcard match against x's mask. exact=true:
+ * control-plane identity match, mark and mask must both match exactly.
+ */
+static bool xfrm_state_mark_matches(const struct xfrm_state *x, u32 mark, u32 mask, bool exact)
+{
+	if (exact)
+		return x->mark.v == mark && x->mark.m == mask;
+	return (mark & x->mark.m) == x->mark.v;
+}
+
+static struct xfrm_state *
+__xfrm_state_lookup(const struct xfrm_hash_state_ptrs *state_ptrs,
+		    u32 mark, u32 mask, bool exact,
+		    const xfrm_address_t *daddr,
+		    __be32 spi, u8 proto,
+		    unsigned short family)
 {
 	unsigned int h = __xfrm_spi_hash(daddr, spi, proto, family, state_ptrs->hmask);
 	struct xfrm_state *x;
@@ -1188,7 +1199,7 @@ static struct xfrm_state *__xfrm_state_lookup(const struct xfrm_hash_state_ptrs
 		    !xfrm_addr_equal(&x->id.daddr, daddr, family))
 			continue;
 
-		if ((mark & x->mark.m) != x->mark.v)
+		if (!xfrm_state_mark_matches(x, mark, mask, exact))
 			continue;
 		if (!xfrm_state_hold_rcu(x))
 			continue;
@@ -1198,6 +1209,17 @@ static struct xfrm_state *__xfrm_state_lookup(const struct xfrm_hash_state_ptrs
 	return NULL;
 }
 
+static struct xfrm_state *
+__xfrm_state_lookup_exact(const struct xfrm_hash_state_ptrs *state_ptrs,
+			  const struct xfrm_mark *mark,
+			  const xfrm_address_t *daddr,
+			  __be32 spi, u8 proto,
+			  unsigned short family)
+{
+	return __xfrm_state_lookup(state_ptrs, mark->v, mark->m, true,
+				   daddr, spi, proto, family);
+}
+
 struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 					   const xfrm_address_t *daddr,
 					   __be32 spi, u8 proto,
@@ -1228,7 +1250,7 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 
 	xfrm_hash_ptrs_get(net, &state_ptrs);
 
-	x = __xfrm_state_lookup(&state_ptrs, mark, daddr, spi, proto, family);
+	x = __xfrm_state_lookup(&state_ptrs, mark, 0, false, daddr, spi, proto, family);
 	if (x) {
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		if (x->km.state != XFRM_STATE_VALID) {
@@ -1288,7 +1310,7 @@ __xfrm_state_locate(struct xfrm_state *x, int use_spi, int family)
 	xfrm_hash_ptrs_get(net, &state_ptrs);
 
 	if (use_spi)
-		return __xfrm_state_lookup(&state_ptrs, mark, &x->id.daddr,
+		return __xfrm_state_lookup(&state_ptrs, mark, 0, false, &x->id.daddr,
 					   x->id.spi, x->id.proto, family);
 	else
 		return __xfrm_state_lookup_byaddr(&state_ptrs, mark,
@@ -1297,6 +1319,27 @@ __xfrm_state_locate(struct xfrm_state *x, int use_spi, int family)
 						  x->id.proto, family);
 }
 
+/* Used by xfrm_state_update() only; xfrm_state_add()'s dup check keeps
+ * using the wildcard __xfrm_state_locate() above.
+ */
+static inline struct xfrm_state *
+__xfrm_state_locate_exact(struct xfrm_state *x, int use_spi, int family)
+{
+	struct xfrm_hash_state_ptrs state_ptrs;
+	struct net *net = xs_net(x);
+
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	if (use_spi)
+		return __xfrm_state_lookup_exact(&state_ptrs, &x->mark, &x->id.daddr,
+						 x->id.spi, x->id.proto, family);
+	else
+		return __xfrm_state_lookup_byaddr(&state_ptrs, x->mark.v & x->mark.m,
+						  &x->id.daddr,
+						  &x->props.saddr,
+						  x->id.proto, family);
+}
+
 static void xfrm_hash_grow_check(struct net *net, int have_hash_collision)
 {
 	if (have_hash_collision &&
@@ -2229,7 +2272,7 @@ int xfrm_state_update(struct xfrm_state *x)
 	to_put = NULL;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
-	x1 = __xfrm_state_locate(x, use_spi, x->props.family);
+	x1 = __xfrm_state_locate_exact(x, use_spi, x->props.family);
 
 	err = -ESRCH;
 	if (!x1)
@@ -2374,7 +2417,7 @@ xfrm_state_lookup(struct net *net, u32 mark, const xfrm_address_t *daddr, __be32
 	rcu_read_lock();
 	xfrm_hash_ptrs_get(net, &state_ptrs);
 
-	x = __xfrm_state_lookup(&state_ptrs, mark, daddr, spi, proto, family);
+	x = __xfrm_state_lookup(&state_ptrs, mark, 0, false, daddr, spi, proto, family);
 	rcu_read_unlock();
 	return x;
 }
@@ -2398,6 +2441,23 @@ xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 }
 EXPORT_SYMBOL(xfrm_state_lookup_byaddr);
 
+struct xfrm_state *
+xfrm_state_lookup_exact(struct net *net, const struct xfrm_mark *mark,
+			const xfrm_address_t *daddr, __be32 spi,
+			u8 proto, unsigned short family)
+{
+	struct xfrm_hash_state_ptrs state_ptrs;
+	struct xfrm_state *x;
+
+	rcu_read_lock();
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	x = __xfrm_state_lookup_exact(&state_ptrs, mark, daddr, spi, proto, family);
+	rcu_read_unlock();
+	return x;
+}
+EXPORT_SYMBOL(xfrm_state_lookup_exact);
+
 struct xfrm_state *
 xfrm_find_acq(struct net *net, const struct xfrm_mark *mark, u8 mode, u32 reqid,
 	      u32 if_id, u32 pcpu_num, u8 proto, const xfrm_address_t *daddr,
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 6384795ee6b2..b56fca666b89 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1089,11 +1089,12 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
 	struct xfrm_state *x = NULL;
 	struct xfrm_mark m;
 	int err;
-	u32 mark = xfrm_mark_get(attrs, &m);
+
+	xfrm_mark_get(attrs, &m);
 
 	if (xfrm_id_proto_match(p->proto, IPSEC_PROTO_ANY)) {
 		err = -ESRCH;
-		x = xfrm_state_lookup(net, mark, &p->daddr, p->spi, p->proto, p->family);
+		x = xfrm_state_lookup_exact(net, &m, &p->daddr, p->spi, p->proto, p->family);
 	} else {
 		xfrm_address_t *saddr = NULL;
 
@@ -1104,7 +1105,7 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
 		}
 
 		err = -ESRCH;
-		x = xfrm_state_lookup_byaddr(net, mark,
+		x = xfrm_state_lookup_byaddr(net, m.v & m.m,
 					     &p->daddr, saddr,
 					     p->proto, p->family);
 	}
@@ -2788,14 +2789,13 @@ static int xfrm_get_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct sk_buff *r_skb;
 	int err;
 	struct km_event c;
-	u32 mark;
 	struct xfrm_mark m;
 	struct xfrm_aevent_id *p = nlmsg_data(nlh);
 	struct xfrm_usersa_id *id = &p->sa_id;
 
-	mark = xfrm_mark_get(attrs, &m);
+	xfrm_mark_get(attrs, &m);
 
-	x = xfrm_state_lookup(net, mark, &id->daddr, id->spi, id->proto, id->family);
+	x = xfrm_state_lookup_exact(net, &m, &id->daddr, id->spi, id->proto, id->family);
 	if (x == NULL)
 		return -ESRCH;
 
@@ -2836,7 +2836,6 @@ static int xfrm_new_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_state *x;
 	struct km_event c;
 	int err = -EINVAL;
-	u32 mark = 0;
 	struct xfrm_mark m;
 	struct xfrm_aevent_id *p = nlmsg_data(nlh);
 	struct nlattr *rp = attrs[XFRMA_REPLAY_VAL];
@@ -2856,9 +2855,10 @@ static int xfrm_new_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return err;
 	}
 
-	mark = xfrm_mark_get(attrs, &m);
+	xfrm_mark_get(attrs, &m);
 
-	x = xfrm_state_lookup(net, mark, &p->sa_id.daddr, p->sa_id.spi, p->sa_id.proto, p->sa_id.family);
+	x = xfrm_state_lookup_exact(net, &m, &p->sa_id.daddr, p->sa_id.spi,
+				    p->sa_id.proto, p->sa_id.family);
 	if (x == NULL)
 		return -ESRCH;
 
@@ -2992,9 +2992,10 @@ static int xfrm_add_sa_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_user_expire *ue = nlmsg_data(nlh);
 	struct xfrm_usersa_info *p = &ue->state;
 	struct xfrm_mark m;
-	u32 mark = xfrm_mark_get(attrs, &m);
 
-	x = xfrm_state_lookup(net, mark, &p->id.daddr, p->id.spi, p->id.proto, p->family);
+	xfrm_mark_get(attrs, &m);
+
+	x = xfrm_state_lookup_exact(net, &m, &p->id.daddr, p->id.spi, p->id.proto, p->family);
 
 	err = -ENOENT;
 	if (x == NULL)
@@ -3361,9 +3362,9 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	copy_from_user_migrate_state(&m, um);
 
-	x = xfrm_state_lookup(net, m.old_mark.v & m.old_mark.m,
-			      &um->id.daddr, um->id.spi,
-			      um->id.proto, um->id.family);
+	x = xfrm_state_lookup_exact(net, &m.old_mark,
+				    &um->id.daddr, um->id.spi,
+				    um->id.proto, um->id.family);
 	if (!x) {
 		NL_SET_ERR_MSG(extack, "Can not find state");
 		return -ESRCH;

-- 
2.47.3


