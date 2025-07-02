Return-Path: <netdev+bounces-203191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49483AF0B7C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A043BEE9F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD7621FF50;
	Wed,  2 Jul 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="I60nAe8G"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47620219A72
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437219; cv=none; b=M7UMX6vxspnCh+bT8VxlWyxWBrX2B8JQ+TvrnQLBq2FWmpD0B7cbEfajZOGk95kdZpGBLezFSTkRCdPMw4XXVP5s5qp5c+CetELIkR5e0cUoZPf28f668391pl+f2ux07/CBuqMb9Gd2ZCZfZIOX0+vBeuAU4zBHF3Ah0vJz33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437219; c=relaxed/simple;
	bh=a/1+M1jC0kd4WZVP3rylR7/RjqZyKIah73CwCMn/7L8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABBXyBk0pnWQ525EOSW2O4X9bTK4Ek3anG/KMDOGhtV3+rZ4bap7k1CrjU3MMdRJR6UHzM8ejJ06YtydZ+HW5Msf5kU5ZHLT7tjUI2mzYOLHVFvdK8OBthAzG4r6Wp8Garcmc6PbAi20COivx1pe0r81jQa1EReLoRt6X7kRuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=I60nAe8G; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751437216;
	bh=avIH7c+QO/p4RJ0P5hNXZGZpemhtMcYp/AFYmdsQTCw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I60nAe8GPtzAUiJ7twTuuPP3xasNJ6Gw7pDy7NueSTUHMbMP0TP7gxOc6mc/ly4Dl
	 66o3gfxZKSop7+myoArtnes9CYV9Z6dHRCr8opxLKRO7rA7q75OrHgpVXST3MLfQEa
	 kVEtqllIYnM7sTXQRNkiYqOqUHeMFZSmL5PGqbzxb+L16nP2GhBD+2WFvsZU6wUMNa
	 bNxWqak2hNR8PPbAsMAvN0zjNtASNd35rRXFpmmPRams7Jj1EAUXHX4gdkqVENwI3h
	 O+MWfd5ax2l/YPtOpXkoFygF8wqHP3ubtEM1yTSsjQjLWDO6//2qTB5UFPYOXhHDFk
	 0EjV4Zw0I0ggQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 341A86A70B; Wed,  2 Jul 2025 14:20:16 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 02 Jul 2025 14:20:04 +0800
Subject: [PATCH net-next v5 04/14] net: mctp: separate cb from
 direct-addressing routing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-dev-forwarding-v5-4-1468191da8a4@codeconstruct.com.au>
References: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
In-Reply-To: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Now that we have the dst->haddr populated by sendmsg (when extended
addressing is in use), we no longer need to stash the link-layer address
in the skb->cb.

Instead, only use skb->cb for incoming lladdr data.

While we're at it: remove cb->src, as was never used.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 include/net/mctp.h |  4 ++--
 net/mctp/route.c   | 21 +++++----------------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index 6c9c5c48f59a1bf45f9c9d274a3ca2b633e96c75..b3af0690f60749a9bf9f489c7118c82cfd9d577e 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -183,8 +183,8 @@ struct mctp_sk_key {
 struct mctp_skb_cb {
 	unsigned int	magic;
 	unsigned int	net;
-	int		ifindex; /* extended/direct addressing if set */
-	mctp_eid_t	src;
+	/* fields below provide extended addressing for ingress to recvmsg() */
+	int		ifindex;
 	unsigned char	halen;
 	unsigned char	haddr[MAX_ADDR_LEN];
 };
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 3985388a6035377c04c4e4f183c4fceca8111917..23f339b4364316817b90b4fb2952c9eac445dd24 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -561,35 +561,28 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 
 static int mctp_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 {
-	struct mctp_skb_cb *cb = mctp_cb(skb);
 	struct mctp_hdr *hdr = mctp_hdr(skb);
 	char daddr_buf[MAX_ADDR_LEN];
 	char *daddr = NULL;
 	int rc;
 
 	skb->protocol = htons(ETH_P_MCTP);
+	skb->pkt_type = PACKET_OUTGOING;
 
 	if (skb->len > dst->mtu) {
 		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
 
-	/* If we're forwarding, we don't want to use the input path's cb,
-	 * as it holds the *source* hardware addressing information.
-	 *
-	 * We will have a PACKET_HOST skb from the dev, or PACKET_OUTGOING
-	 * from a socket; only use cb in the latter case.
-	 */
-	if (skb->pkt_type == PACKET_OUTGOING && cb->ifindex) {
-		/* direct route; use the hwaddr we stashed in sendmsg */
-		if (cb->halen != skb->dev->addr_len) {
+	/* direct route; use the hwaddr we stashed in sendmsg */
+	if (dst->halen) {
+		if (dst->halen != skb->dev->addr_len) {
 			/* sanity check, sendmsg should have already caught this */
 			kfree_skb(skb);
 			return -EMSGSIZE;
 		}
-		daddr = cb->haddr;
+		daddr = dst->haddr;
 	} else {
-		skb->pkt_type = PACKET_OUTGOING;
 		/* If lookup fails let the device handle daddr==NULL */
 		if (mctp_neigh_lookup(dst->dev, hdr->dest, daddr_buf) == 0)
 			daddr = daddr_buf;
@@ -1009,7 +1002,6 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 		      struct sk_buff *skb, mctp_eid_t daddr, u8 req_tag)
 {
 	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
-	struct mctp_skb_cb *cb = mctp_cb(skb);
 	struct mctp_sk_key *key;
 	struct mctp_hdr *hdr;
 	unsigned long flags;
@@ -1064,9 +1056,6 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 	skb_reset_network_header(skb);
 	skb->dev = dst->dev->dev;
 
-	/* cb->net will have been set on initial ingress */
-	cb->src = saddr;
-
 	/* set up common header fields */
 	hdr = mctp_hdr(skb);
 	hdr->ver = 1;

-- 
2.39.5


