Return-Path: <netdev+bounces-201806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16355AEB1B0
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986431BC6EF7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D1280CC1;
	Fri, 27 Jun 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UFCs0sbQ"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A926B2A9
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014370; cv=none; b=MJKu9QKhOOAHA/rsdLEiZr/WpNiC8LvwZQs54N10hIz3wusSSsBj1gQsy2fSFBon0uyf+Ee4Kiula0MXujmmyNfPcCbOXIIh/dDusWwAm8EfFX1Mocn6MZSbum+n2HQvCvMxCoCh4qZf+5gIodS7Jkujt36uSRlwknA2TNiPglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014370; c=relaxed/simple;
	bh=R1EorFGpttL/oma2ZdUveAmXTKz98KDTbicg/g0mghw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q012BoV0x5x2rJ29iGDpgU10Mi15Ap+SW35mpLVtUXV84D69OdnvzBqvMTSyg4sjgTI2SHDpTbE0eO/HSNrEQrPPGmJUJBGlN5uE68y0hslW3vnzIcWMWgGRPYW04/xHW5Azg6ySpUoImBMsWldvudkgmSU9gMdIMvoHQiy8yLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UFCs0sbQ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751014366;
	bh=MHnk7K8gBZJkEXEz77Hu1/hzJtsNR2OvJFZq/TlpHxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UFCs0sbQ6g1jC78bSAPvjoH7SxLZjFSKfyxTFLDVaOJ+JJTalVKHcCJmAxYNpZ2z/
	 qjLNgWrf4/6fo1MFLfm80JoaQ0Ngj2dfwy1/g1MxdmuVWnXnUy8RxM014JgjanKMpb
	 IvGkXQc7FYjKmuTbaCb2MPqvSv4X8COUMj9UpMWYsWeBjTyZ3HEPYaAlF47O6Pes3s
	 jPpzaycJNzyZS1WoIA5lGo4E4/lvVKhJUARZFtvcR4ICGQ1Oc7M8bfC9JWA0ud7f1a
	 VvwHMtChmBAZkUjgzD/Bb+/Z1CUZMdH/0doG1eqdnX8dWlEj+f+mYj9ezZtc/nXyZo
	 K39xFbY5pmJfw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id BDB6C69E1E; Fri, 27 Jun 2025 16:52:46 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 27 Jun 2025 16:52:20 +0800
Subject: [PATCH net-next v4 04/14] net: mctp: separate cb from
 direct-addressing routing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-dev-forwarding-v4-4-72bb3cabc97c@codeconstruct.com.au>
References: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
In-Reply-To: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
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
 net/mctp/af_mctp.c |  3 +--
 net/mctp/route.c   | 21 +++++----------------
 3 files changed, 8 insertions(+), 20 deletions(-)

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
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index ca66521435b10c2299b82ed64718ddc98f1f07f3..1141a4e33aaaabef4b58a5942dbe2847f2b7fcdd 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -134,8 +134,7 @@ static int mctp_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		DECLARE_SOCKADDR(struct sockaddr_mctp_ext *,
 				 extaddr, msg->msg_name);
 
-		if (!mctp_sockaddr_ext_is_ok(extaddr) ||
-		    extaddr->smctp_halen > sizeof(cb->haddr)) {
+		if (!mctp_sockaddr_ext_is_ok(extaddr)) {
 			rc = -EINVAL;
 			goto err_free;
 		}
diff --git a/net/mctp/route.c b/net/mctp/route.c
index e11bf1c1e383cc251c5b6e2852d3756f706956c7..42d80a9f21d6a054375156e3de21be72a187c6fc 100644
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
@@ -1004,7 +997,6 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 		      struct sk_buff *skb, mctp_eid_t daddr, u8 req_tag)
 {
 	struct mctp_sock *msk = container_of(sk, struct mctp_sock, sk);
-	struct mctp_skb_cb *cb = mctp_cb(skb);
 	struct mctp_sk_key *key;
 	struct mctp_hdr *hdr;
 	unsigned long flags;
@@ -1059,9 +1051,6 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
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


