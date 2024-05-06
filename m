Return-Path: <netdev+bounces-93887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894C88BD84A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135421F23DFA
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783E15E1E8;
	Mon,  6 May 2024 23:53:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA6F15D5DF
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039590; cv=none; b=ipehcjJxYV+i5r9ObYADTnUpJe0QA3vi8s/zdpb+KVh0Y7+k/aIYHq4o5SoLWOlh6o9aNolaJbYsHIO+C0gkqK7Vp4wVkykxdoW33BVSlUuD7IMFwg92JXOlIJR5CHO6DlHsGL0CMcjAiXM9HxYV8z60AEU3oIVTgpftfa8Tf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039590; c=relaxed/simple;
	bh=0WEMreeAJJcUhK3/37tUH20TTv+8i17aBpj6I3ieeDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bn/9v38HwUQuU3pOMQR2sMoovDpn4f24Al0RBXJrj9JhyiVnKTk75ARMgPKQk3wRHKztoYU7EgZ7L8JqoIB0sRmP+1QNr6K3aUcio2jSwaHdLkdPOYFGF7gQLZjkK2qCKIx4dRDtum2JYvYZboRtrW/wQXeVRqNvvvCuu4TL958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	horms@kernel.org
Subject: [PATCH net-next,v3 05/12] gtp: use IPv6 address /64 prefix for UE/MS
Date: Tue,  7 May 2024 01:52:44 +0200
Message-Id: <20240506235251.3968262-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506235251.3968262-1-pablo@netfilter.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Harald Welte reports that according to 3GPP TS 29.060:

    PDN Connection: the association between a MS represented by one IPv4
address and/or one IPv6 prefix and a PDN represented by an APN.

this clearly states that IPv4 is a single address while IPv6 is a single prefix.

Then, 3GPP TS 29.061, Section 11.2.1.3:

    For APNs that are configured for IPv6 address allocation, the GGSN/P-GW
shall only use the Prefix part of the IPv6 address for forwarding of mobile
terminated IP packets. The size of the prefix shall be according to the maximum
prefix length for a global IPv6 address as specified in the IPv6 Addressing
Architecture, see RFC 4291 [82].

RFC 4291 section 2.5.4 states

    All Global Unicast addresses other than those that start with binary 000
have a 64-bit interface ID field (i.e., n + m = 64) ...

3GPP TS 29.61 Section 11.2.1.3.2a:

    In the procedure in the cases of using GTP-based S5/S8, P-GW acts as an
access router, and allocates to a UE a globally unique /64 IPv6 prefix if the
PLMN allocates the prefix.

Therefore, compare IPv6 address /64 prefix only since MS/UE is not a single
address like in the IPv4 case.

Reject IPv6 address with EADDRNOTAVAIL if it lower 64 bits of the IPv6 address
from the control plane are set.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 52 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 84ff502a38bc..8e861778c4e9 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -136,7 +136,8 @@ static inline u32 ipv4_hashfn(__be32 ip)
 
 static u32 ipv6_hashfn(const struct in6_addr *ip6)
 {
-	return jhash(ip6, sizeof(*ip6), gtp_h_initval);
+	return jhash_2words((__force u32)ip6->s6_addr32[0],
+			    (__force u32)ip6->s6_addr32[1], gtp_h_initval);
 }
 
 /* Resolve a PDP context structure based on the 64bit TID. */
@@ -188,6 +189,24 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
 	return NULL;
 }
 
+/* 3GPP TS 29.060: PDN Connection: the association between a MS represented by
+ * [...] one IPv6 *prefix* and a PDN represented by an APN.
+ *
+ * Then, 3GPP TS 29.061, Section 11.2.1.3 says: The size of the prefix shall be
+ * according to the maximum prefix length for a global IPv6 address as
+ * specified in the IPv6 Addressing Architecture, see RFC 4291.
+ *
+ * Finally, RFC 4291 section 2.5.4 states: All Global Unicast addresses other
+ * than those that start with binary 000 have a 64-bit interface ID field
+ * (i.e., n + m = 64).
+ */
+static bool ipv6_pdp_addr_equal(const struct in6_addr *a,
+				const struct in6_addr *b)
+{
+	return a->s6_addr32[0] == b->s6_addr32[0] &&
+	       a->s6_addr32[1] == b->s6_addr32[1];
+}
+
 static struct pdp_ctx *ipv6_pdp_find(struct gtp_dev *gtp,
 				     const struct in6_addr *ms_addr)
 {
@@ -198,7 +217,7 @@ static struct pdp_ctx *ipv6_pdp_find(struct gtp_dev *gtp,
 
 	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
 		if (pdp->af == AF_INET6 &&
-		    memcmp(&pdp->ms.addr6, ms_addr, sizeof(struct in6_addr)) == 0)
+		    ipv6_pdp_addr_equal(&pdp->ms.addr6, ms_addr))
 			return pdp;
 	}
 
@@ -233,14 +252,12 @@ static bool gtp_check_ms_ipv6(struct sk_buff *skb, struct pdp_ctx *pctx,
 	ip6h = (struct ipv6hdr *)(skb->data + hdrlen);
 
 	if (role == GTP_ROLE_SGSN) {
-		ret = memcmp(&ip6h->daddr, &pctx->ms.addr6,
-			     sizeof(struct in6_addr));
+		ret = ipv6_pdp_addr_equal(&ip6h->daddr, &pctx->ms.addr6);
 	} else {
-		ret = memcmp(&ip6h->saddr, &pctx->ms.addr6,
-			     sizeof(struct in6_addr));
+		ret = ipv6_pdp_addr_equal(&ip6h->saddr, &pctx->ms.addr6);
 	}
 
-	return ret == 0;
+	return ret;
 }
 
 /* Check if the inner IP address in this packet is assigned to any
@@ -1652,11 +1669,17 @@ static void ipv4_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
 	gtp_pdp_fill(pctx, info);
 }
 
-static void ipv6_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
+static bool ipv6_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
 {
 	pctx->peer.addr6 = nla_get_in6_addr(info->attrs[GTPA_PEER_ADDR6]);
 	pctx->ms.addr6 = nla_get_in6_addr(info->attrs[GTPA_MS_ADDR6]);
+	if (pctx->ms.addr6.s6_addr32[2] ||
+	    pctx->ms.addr6.s6_addr32[3])
+		return false;
+
 	gtp_pdp_fill(pctx, info);
+
+	return true;
 }
 
 static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
@@ -1742,7 +1765,8 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 			ipv4_pdp_fill(pctx, info);
 			break;
 		case AF_INET6:
-			ipv6_pdp_fill(pctx, info);
+			if (!ipv6_pdp_fill(pctx, info))
+				return ERR_PTR(-EADDRNOTAVAIL);
 			break;
 		}
 
@@ -1785,7 +1809,11 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 			return ERR_PTR(-EINVAL);
 		}
 
-		ipv6_pdp_fill(pctx, info);
+		if (!ipv6_pdp_fill(pctx, info)) {
+			sock_put(sk);
+			kfree(pctx);
+			return ERR_PTR(-EADDRNOTAVAIL);
+		}
 		break;
 	}
 	atomic_set(&pctx->tx_seq, 0);
@@ -1919,6 +1947,10 @@ static struct pdp_ctx *gtp_find_pdp_by_link(struct net *net,
 	} else if (nla[GTPA_MS_ADDR6]) {
 		struct in6_addr addr = nla_get_in6_addr(nla[GTPA_MS_ADDR6]);
 
+		if (addr.s6_addr32[2] ||
+		    addr.s6_addr32[3])
+			return ERR_PTR(-EADDRNOTAVAIL);
+
 		return ipv6_pdp_find(gtp, &addr);
 	} else if (nla[GTPA_VERSION]) {
 		u32 gtp_version = nla_get_u32(nla[GTPA_VERSION]);
-- 
2.30.2


