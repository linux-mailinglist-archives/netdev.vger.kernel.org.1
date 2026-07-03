Return-Path: <netdev+bounces-304625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z23+KYPsR2q2hgAAu9opvQ
	(envelope-from <netdev+bounces-304625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:08:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC357048B5
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 19:08:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b="s8DEf/8f";
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304625-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304625-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B9830210E9
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 17:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C19330ACE3;
	Fri,  3 Jul 2026 17:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4120284693;
	Fri,  3 Jul 2026 17:08:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098483; cv=none; b=oCdC/UmIlJpQy+irR09vsB8HC8JumQf6Vprbga0Rn26Z6nOnO/m5H45hQ0p4GovV6i5W60aH3f4Gk44GGK6cqiTR9xsetHsm8fuAUyZGLasJvLMFTw3cchiz1DHr6J3PI0Y/XFjFa60Ejnpl3l2Urc1zApEocAO2sOz6M3+4T34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098483; c=relaxed/simple;
	bh=J3igiEbV3KEx6voxs4xRIMgkyu5KFuebdfd5CHM7nLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMSDdMI6jvJisbHcg92nRIMyZghzfhfiGohblrnpH9kHWwLw2jFQxC2564S/hL1EKRpN+5AhNiFCry1CbQr8TNQ1HWl42f39ok9NqiBuTFC6LCIXkR+3OA1h+HtYAKpM7vSqTs3FuzIMSSrwpjxWuIDrIPR5l6meYVBY9nJyfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=s8DEf/8f; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6CB0120758;
	Fri,  3 Jul 2026 19:07:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M39QVIGzHfUp; Fri,  3 Jul 2026 19:07:58 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AA20A20612;
	Fri,  3 Jul 2026 19:07:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AA20A20612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783098478;
	bh=WA43NGR7HNtVKpWbckRUcJPfniSRs7TtAz50BGBroys=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=s8DEf/8fDcMELZmOgSyjMRR+GQtP9iI1j8NvycGJId49msxN/Nigr/YqXHKvy9GGR
	 jilD2AhxCykeGKJy7jptWHaMdU04e3hpDCcDmxJ6sAd3THbEuLkygf3IJRLnEmnY56
	 WdV7uGIrMUs4UFKalqm2cJH9lEIV0TOi10gong0WJGydW5GSHUyIDL6r4AEkmJ5dU8
	 V4DDouluAtR6gbg1mryDnUvLPFGgJAur57lSkV4p8RTLrauNVEd2KLG4yuyhZbUO62
	 KqyQE+C/xIJfZBZz1Pgb3S6AjdLxsSbm5nbcMsF3P7CfQBYlZ58NL7rbhywNOOiooj
	 yeAT6qtPRFouQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 19:07:57 +0200
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
Subject: [PATCH ipsec 2/8] xfrm: state: exact mark/mask match for by-address control-plane SA lookups
Date: Fri, 3 Jul 2026 19:07:49 +0200
Message-ID: <migrate-state-fixes-v0-2-a69e8637ba3b@secunet.com>
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
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-304625-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 4EC357048B5

Add mark/mask/exact parameters directly to __xfrm_state_lookup_byaddr(),
reusing the SPI-keyed lookup's comparison.

Use __xfrm_state_locate_exact()'s by-address branch UPDSA
and xfrm_user_state_lookup()'s by-address branch
(DELSA/GETSA for non-SPI-keyed lookups).

Fixes: 3d6acfa7641f ("xfrm: SA lookups with mark")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/xfrm.h     |  2 +-
 net/ipv6/xfrm6_input.c |  2 +-
 net/xfrm/xfrm_state.c  | 21 +++++++++++----------
 net/xfrm/xfrm_user.c   |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index f6ed590cb2ff..ebe514376254 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1741,7 +1741,7 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 					   const xfrm_address_t *daddr,
 					   __be32 spi, u8 proto,
 					   unsigned short family);
-struct xfrm_state *xfrm_state_lookup_byaddr(struct net *net, u32 mark,
+struct xfrm_state *xfrm_state_lookup_byaddr(struct net *net, u32 mark, u32 mask, bool exact,
 					    const xfrm_address_t *daddr,
 					    const xfrm_address_t *saddr,
 					    u8 proto,
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 89d0443b5307..2dd347fece52 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -272,7 +272,7 @@ int xfrm6_input_addr(struct sk_buff *skb, xfrm_address_t *daddr,
 			break;
 		}
 
-		x = xfrm_state_lookup_byaddr(net, skb->mark, dst, src, proto, AF_INET6);
+		x = xfrm_state_lookup_byaddr(net, skb->mark, 0, false, dst, src, proto, AF_INET6);
 		if (!x)
 			continue;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index df761ce1c290..d78cfe481f75 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1274,11 +1274,12 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 }
 EXPORT_SYMBOL(xfrm_input_state_lookup);
 
-static struct xfrm_state *__xfrm_state_lookup_byaddr(const struct xfrm_hash_state_ptrs *state_ptrs,
-						     u32 mark,
-						     const xfrm_address_t *daddr,
-						     const xfrm_address_t *saddr,
-						     u8 proto, unsigned short family)
+static struct xfrm_state *
+__xfrm_state_lookup_byaddr(const struct xfrm_hash_state_ptrs *state_ptrs,
+			   u32 mark, u32 mask, bool exact,
+			   const xfrm_address_t *daddr,
+			   const xfrm_address_t *saddr,
+			   u8 proto, unsigned short family)
 {
 	unsigned int h = __xfrm_src_hash(daddr, saddr, family, state_ptrs->hmask);
 	struct xfrm_state *x;
@@ -1290,7 +1291,7 @@ static struct xfrm_state *__xfrm_state_lookup_byaddr(const struct xfrm_hash_stat
 		    !xfrm_addr_equal(&x->props.saddr, saddr, family))
 			continue;
 
-		if ((mark & x->mark.m) != x->mark.v)
+		if (!xfrm_state_mark_matches(x, mark, mask, exact))
 			continue;
 		if (!xfrm_state_hold_rcu(x))
 			continue;
@@ -1313,7 +1314,7 @@ __xfrm_state_locate(struct xfrm_state *x, int use_spi, int family)
 		return __xfrm_state_lookup(&state_ptrs, mark, 0, false, &x->id.daddr,
 					   x->id.spi, x->id.proto, family);
 	else
-		return __xfrm_state_lookup_byaddr(&state_ptrs, mark,
+		return __xfrm_state_lookup_byaddr(&state_ptrs, mark, 0, false,
 						  &x->id.daddr,
 						  &x->props.saddr,
 						  x->id.proto, family);
@@ -1334,7 +1335,7 @@ __xfrm_state_locate_exact(struct xfrm_state *x, int use_spi, int family)
 		return __xfrm_state_lookup_exact(&state_ptrs, &x->mark, &x->id.daddr,
 						 x->id.spi, x->id.proto, family);
 	else
-		return __xfrm_state_lookup_byaddr(&state_ptrs, x->mark.v & x->mark.m,
+		return __xfrm_state_lookup_byaddr(&state_ptrs, x->mark.v, x->mark.m, true,
 						  &x->id.daddr,
 						  &x->props.saddr,
 						  x->id.proto, family);
@@ -2424,7 +2425,7 @@ xfrm_state_lookup(struct net *net, u32 mark, const xfrm_address_t *daddr, __be32
 EXPORT_SYMBOL(xfrm_state_lookup);
 
 struct xfrm_state *
-xfrm_state_lookup_byaddr(struct net *net, u32 mark,
+xfrm_state_lookup_byaddr(struct net *net, u32 mark, u32 mask, bool exact,
 			 const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			 u8 proto, unsigned short family)
 {
@@ -2435,7 +2436,7 @@ xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 
 	xfrm_hash_ptrs_get(net, &state_ptrs);
 
-	x = __xfrm_state_lookup_byaddr(&state_ptrs, mark, daddr, saddr, proto, family);
+	x = __xfrm_state_lookup_byaddr(&state_ptrs, mark, mask, exact, daddr, saddr, proto, family);
 	rcu_read_unlock();
 	return x;
 }
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index b56fca666b89..11ec3b14a42f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1105,7 +1105,7 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
 		}
 
 		err = -ESRCH;
-		x = xfrm_state_lookup_byaddr(net, m.v & m.m,
+		x = xfrm_state_lookup_byaddr(net, m.v, m.m, true,
 					     &p->daddr, saddr,
 					     p->proto, p->family);
 	}

-- 
2.47.3


