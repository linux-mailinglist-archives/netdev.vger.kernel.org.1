Return-Path: <netdev+bounces-91273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F48B1FAF
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF376B241C7
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290D3A1B0;
	Thu, 25 Apr 2024 10:51:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2DF376E6
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042316; cv=none; b=Yj+yDUlPzxWMNxMQCKoAOnH/GWJQmw+cM43Tx0GLbXYSkW3siPN4lZTbzMIOVgxA4dvyOZ+Yujcy9/FPhx92A898fG0KL2jeh2rxz/7envjR6Xl3sBFRFnKrL1R+oEHRJ6gmkWsCz3Zt3zr1f84oTybW3Lrszjg2x8T3JNU5dCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042316; c=relaxed/simple;
	bh=JydQiVphvhEZt1vHZCc+TOBgaFOfd7+3/jKnGevvKQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3Qu9sRnbMBiz9d8kxS1TaSuRF3ArWmodvS7yDSEFbbzBgB7pSNV/ftJk5JpU+8fsgktWmJgplrE8cwEmkFDNjYdzgM7kAxxal+2/1yMj0gDjhgW+zsHnKtL8FAu0AjpbsIFGqmwxT7D/V9ZtKAXGMbWnjJke15yN/TH/n6vZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 12/12] gtp: identify tunnel via GTP device + GTP version + TEID + family
Date: Thu, 25 Apr 2024 12:51:38 +0200
Message-Id: <20240425105138.1361098-13-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240425105138.1361098-1-pablo@netfilter.org>
References: <20240425105138.1361098-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows to define a GTP tunnel for dual stack MS/UE with both IPv4
and IPv6 addresses while using the same TEID via two PDP context
objects.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 85 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 22 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 586de5f013b5..9880f7d5c56c 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -141,7 +141,7 @@ static inline u32 ipv6_hashfn(const struct in6_addr *ip6)
 }
 
 /* Resolve a PDP context structure based on the 64bit TID. */
-static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid)
+static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid, u16 family)
 {
 	struct hlist_head *head;
 	struct pdp_ctx *pdp;
@@ -149,7 +149,8 @@ static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid)
 	head = &gtp->tid_hash[gtp0_hashfn(tid) % gtp->hash_size];
 
 	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
-		if (pdp->gtp_version == GTP_V0 &&
+		if (pdp->af == family &&
+		    pdp->gtp_version == GTP_V0 &&
 		    pdp->u.v0.tid == tid)
 			return pdp;
 	}
@@ -157,7 +158,7 @@ static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid)
 }
 
 /* Resolve a PDP context structure based on the 32bit TEI. */
-static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid)
+static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid, u16 family)
 {
 	struct hlist_head *head;
 	struct pdp_ctx *pdp;
@@ -165,7 +166,8 @@ static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid)
 	head = &gtp->tid_hash[gtp1u_hashfn(tid) % gtp->hash_size];
 
 	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
-		if (pdp->gtp_version == GTP_V1 &&
+		if (pdp->af == family &&
+		    pdp->gtp_version == GTP_V1 &&
 		    pdp->u.v1.i_tei == tid)
 			return pdp;
 	}
@@ -305,15 +307,8 @@ static int gtp_inner_proto(struct sk_buff *skb, unsigned int hdrlen,
 }
 
 static int gtp_rx(struct pdp_ctx *pctx, struct sk_buff *skb,
-		  unsigned int hdrlen, unsigned int role)
+		  unsigned int hdrlen, unsigned int role, __u16 inner_proto)
 {
-	__u16 inner_proto;
-
-	if (gtp_inner_proto(skb, hdrlen, &inner_proto) < 0) {
-		netdev_dbg(pctx->dev, "GTP packet does not encapsulate an IP packet\n");
-		return -1;
-	}
-
 	if (!gtp_check_ms(skb, pctx, hdrlen, role, inner_proto)) {
 		netdev_dbg(pctx->dev, "No PDP ctx for this MS\n");
 		return 1;
@@ -562,6 +557,21 @@ static int gtp0_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 				       msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
 }
 
+static int gtp_proto_to_family(__u16 proto)
+{
+	switch (proto) {
+	case ETH_P_IP:
+		return AF_INET;
+	case ETH_P_IPV6:
+		return AF_INET6;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+
+	return AF_UNSPEC;
+}
+
 /* 1 means pass up to the stack, -1 means drop and 0 means decapsulated. */
 static int gtp0_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 {
@@ -569,6 +579,7 @@ static int gtp0_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 			      sizeof(struct gtp0_header);
 	struct gtp0_header *gtp0;
 	struct pdp_ctx *pctx;
+	__u16 inner_proto;
 
 	if (!pskb_may_pull(skb, hdrlen))
 		return -1;
@@ -591,13 +602,19 @@ static int gtp0_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 	if (gtp0->type != GTP_TPDU)
 		return 1;
 
-	pctx = gtp0_pdp_find(gtp, be64_to_cpu(gtp0->tid));
+	if (gtp_inner_proto(skb, hdrlen, &inner_proto) < 0) {
+		netdev_dbg(pctx->dev, "GTP packet does not encapsulate an IP packet\n");
+		return -1;
+	}
+
+	pctx = gtp0_pdp_find(gtp, be64_to_cpu(gtp0->tid),
+			     gtp_proto_to_family(inner_proto));
 	if (!pctx) {
 		netdev_dbg(gtp->dev, "No PDP ctx to decap skb=%p\n", skb);
 		return 1;
 	}
 
-	return gtp_rx(pctx, skb, hdrlen, gtp->role);
+	return gtp_rx(pctx, skb, hdrlen, gtp->role, inner_proto);
 }
 
 /* msg_type has to be GTP_ECHO_REQ or GTP_ECHO_RSP */
@@ -768,6 +785,7 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 			      sizeof(struct gtp1_header);
 	struct gtp1_header *gtp1;
 	struct pdp_ctx *pctx;
+	__u16 inner_proto;
 
 	if (!pskb_may_pull(skb, hdrlen))
 		return -1;
@@ -803,9 +821,15 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 	if (!pskb_may_pull(skb, hdrlen))
 		return -1;
 
+	if (gtp_inner_proto(skb, hdrlen, &inner_proto) < 0) {
+		netdev_dbg(pctx->dev, "GTP packet does not encapsulate an IP packet\n");
+		return -1;
+	}
+
 	gtp1 = (struct gtp1_header *)(skb->data + sizeof(struct udphdr));
 
-	pctx = gtp1_pdp_find(gtp, ntohl(gtp1->tid));
+	pctx = gtp1_pdp_find(gtp, ntohl(gtp1->tid),
+			     gtp_proto_to_family(inner_proto));
 	if (!pctx) {
 		netdev_dbg(gtp->dev, "No PDP ctx to decap skb=%p\n", skb);
 		return 1;
@@ -815,7 +839,7 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
 		return -1;
 
-	return gtp_rx(pctx, skb, hdrlen, gtp->role);
+	return gtp_rx(pctx, skb, hdrlen, gtp->role, inner_proto);
 }
 
 static void __gtp_encap_destroy(struct sock *sk)
@@ -1842,10 +1866,12 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 		found = true;
 	if (version == GTP_V0)
 		pctx_tid = gtp0_pdp_find(gtp,
-					 nla_get_u64(info->attrs[GTPA_TID]));
+					 nla_get_u64(info->attrs[GTPA_TID]),
+					 family);
 	else if (version == GTP_V1)
 		pctx_tid = gtp1_pdp_find(gtp,
-					 nla_get_u32(info->attrs[GTPA_I_TEI]));
+					 nla_get_u32(info->attrs[GTPA_I_TEI]),
+					 family);
 	if (pctx_tid)
 		found = true;
 
@@ -2024,6 +2050,12 @@ static struct pdp_ctx *gtp_find_pdp_by_link(struct net *net,
 					    struct nlattr *nla[])
 {
 	struct gtp_dev *gtp;
+	int family;
+
+	if (nla[GTPA_FAMILY])
+		family = nla_get_u8(nla[GTPA_FAMILY]);
+	else
+		family = AF_INET;
 
 	gtp = gtp_find_dev(net, nla);
 	if (!gtp)
@@ -2032,10 +2064,16 @@ static struct pdp_ctx *gtp_find_pdp_by_link(struct net *net,
 	if (nla[GTPA_MS_ADDRESS]) {
 		__be32 ip = nla_get_be32(nla[GTPA_MS_ADDRESS]);
 
+		if (family != AF_INET)
+			return ERR_PTR(-EINVAL);
+
 		return ipv4_pdp_find(gtp, ip);
 	} else if (nla[GTPA_MS_ADDR6]) {
 		struct in6_addr addr = nla_get_in6_addr(nla[GTPA_MS_ADDR6]);
 
+		if (family != AF_INET6)
+			return ERR_PTR(-EINVAL);
+
 		if (addr.s6_addr32[2] ||
 		    addr.s6_addr32[3])
 			return ERR_PTR(-EADDRNOTAVAIL);
@@ -2044,10 +2082,13 @@ static struct pdp_ctx *gtp_find_pdp_by_link(struct net *net,
 	} else if (nla[GTPA_VERSION]) {
 		u32 gtp_version = nla_get_u32(nla[GTPA_VERSION]);
 
-		if (gtp_version == GTP_V0 && nla[GTPA_TID])
-			return gtp0_pdp_find(gtp, nla_get_u64(nla[GTPA_TID]));
-		else if (gtp_version == GTP_V1 && nla[GTPA_I_TEI])
-			return gtp1_pdp_find(gtp, nla_get_u32(nla[GTPA_I_TEI]));
+		if (gtp_version == GTP_V0 && nla[GTPA_TID]) {
+			return gtp0_pdp_find(gtp, nla_get_u64(nla[GTPA_TID]),
+					     family);
+		} else if (gtp_version == GTP_V1 && nla[GTPA_I_TEI]) {
+			return gtp1_pdp_find(gtp, nla_get_u32(nla[GTPA_I_TEI]),
+					     family);
+		}
 	}
 
 	return ERR_PTR(-EINVAL);
-- 
2.30.2


