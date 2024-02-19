Return-Path: <netdev+bounces-72870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170285A043
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079091F22A74
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072124B5B;
	Mon, 19 Feb 2024 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Hq7bUGEw"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0528DA6
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336437; cv=none; b=coVW7rLcECLHdnuDpOgEwwjCeKARe/Dp3U/+A4RMTaqGKqE70DzKYls2fspMwvsdogB+EccPtQhIqMQgsUN7zaF0bJ4K+O9ktqCOaRAATK8f9PJViIGUwVwyoHQdjtJlvzxlX9gzxPWSVui6qVF3tBZCXRdMqf4Kj2KJx8h1TC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336437; c=relaxed/simple;
	bh=QxJA+W974TgVF1c9OXnJPm1AJ1pY56/vmI5Nnwq361w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=noFOv2RqwpOgxZsjZVPspegVRQJfrY02asqhl0QSjUnoY0g8NscXzfeobkdtmk734ajZhS7Uzc4yDeUs3rOI9su4Nav/vPKygfISUi9m0QiZS2CVSPj/5x3CPZQY2P7rDE1GU+092nYkdAcvRRdDB2luF6uy7jo6upgs+Q8wtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Hq7bUGEw; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id E00A920239; Mon, 19 Feb 2024 17:53:53 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708336433;
	bh=n4x5kGq7xgRBh+x41GHeGkfdbfDRvOyVWgtpyF6H9oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hq7bUGEw9iR268lRZnJ1TIutifrpmoEwo2pkNGsOG+LCDQbWM0ASlQRLwGul/UHcS
	 Sm81unrK7zyeGtuVP6SA6NZlF/m5rD4HMS7m0/ICQuAxUDk19tsOCh8zdNLRQ0+/Ci
	 yOjML/DDuGonaDdNENa2aVZCUodxdyrM4luac+mRkyBKhRZjhMPz2sxaQ0XUfBOe25
	 KBfhg5NFzfndk6mrZ4o5k8URLTbA7EaFLq8CfJEUF/Hf199Q13a/j9PR+yItiaA58P
	 fCUX5TptcEFrzIxsk/iVExP6PML4UhltpYp8zKWfbdxaoIEQ/muiyP1vABvR/cuw7S
	 CqXrUueRAaEtA==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v2 01/11] net: mctp: avoid confusion over local/peer dest/source addresses
Date: Mon, 19 Feb 2024 17:51:46 +0800
Message-Id: <5ca7af1911fa9279e6ee5fc0f835c1489880664b.1708335994.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708335994.git.jk@codeconstruct.com.au>
References: <cover.1708335994.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a double-swap of local and peer addresses in
mctp_alloc_local_tag; the arguments in both call sites are swapped, but
there is also a swap in the implementation of alloc_local_tag. This is
opaque because we're using source/dest address references, which don't
match the local/peer semantics.

Avoid this confusion by naming the arguments as 'local' and 'peer', and
remove the double swap. The calling order now matches mctp_key_alloc.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 include/net/mctp.h |  4 ++--
 net/mctp/af_mctp.c |  2 +-
 net/mctp/route.c   | 16 ++++++++--------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index 2bff5f47ce82..81d31b31aa6f 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -87,7 +87,7 @@ struct mctp_sock {
 };
 
 /* Key for matching incoming packets to sockets or reassembly contexts.
- * Packets are matched on (src,dest,tag).
+ * Packets are matched on (peer EID, local EID, tag).
  *
  * Lifetime / locking requirements:
  *
@@ -255,7 +255,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 
 void mctp_key_unref(struct mctp_sk_key *key);
 struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
-					 mctp_eid_t daddr, mctp_eid_t saddr,
+					 mctp_eid_t local, mctp_eid_t peer,
 					 bool manual, u8 *tagp);
 
 /* routing <--> device interface */
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index f6be58b68c6f..d8197e9e233b 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -367,7 +367,7 @@ static int mctp_ioctl_alloctag(struct mctp_sock *msk, unsigned long arg)
 	if (ctl.flags)
 		return -EINVAL;
 
-	key = mctp_alloc_local_tag(msk, ctl.peer_addr, MCTP_ADDR_ANY,
+	key = mctp_alloc_local_tag(msk, MCTP_ADDR_ANY, ctl.peer_addr,
 				   true, &tag);
 	if (IS_ERR(key))
 		return PTR_ERR(key);
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 8594bf256e7d..37c5c3dd16f6 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -596,11 +596,11 @@ static void mctp_reserve_tag(struct net *net, struct mctp_sk_key *key,
 	refcount_inc(&key->refs);
 }
 
-/* Allocate a locally-owned tag value for (saddr, daddr), and reserve
+/* Allocate a locally-owned tag value for (local, peer), and reserve
  * it for the socket msk
  */
 struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
-					 mctp_eid_t daddr, mctp_eid_t saddr,
+					 mctp_eid_t local, mctp_eid_t peer,
 					 bool manual, u8 *tagp)
 {
 	struct net *net = sock_net(&msk->sk);
@@ -610,11 +610,11 @@ struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
 	u8 tagbits;
 
 	/* for NULL destination EIDs, we may get a response from any peer */
-	if (daddr == MCTP_ADDR_NULL)
-		daddr = MCTP_ADDR_ANY;
+	if (peer == MCTP_ADDR_NULL)
+		peer = MCTP_ADDR_ANY;
 
 	/* be optimistic, alloc now */
-	key = mctp_key_alloc(msk, saddr, daddr, 0, GFP_KERNEL);
+	key = mctp_key_alloc(msk, local, peer, 0, GFP_KERNEL);
 	if (!key)
 		return ERR_PTR(-ENOMEM);
 
@@ -635,8 +635,8 @@ struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
 		if (tmp->tag & MCTP_HDR_FLAG_TO)
 			continue;
 
-		if (!(mctp_address_matches(tmp->peer_addr, daddr) &&
-		      mctp_address_matches(tmp->local_addr, saddr)))
+		if (!(mctp_address_matches(tmp->peer_addr, peer) &&
+		      mctp_address_matches(tmp->local_addr, local)))
 			continue;
 
 		spin_lock(&tmp->lock);
@@ -924,7 +924,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 			key = mctp_lookup_prealloc_tag(msk, daddr,
 						       req_tag, &tag);
 		else
-			key = mctp_alloc_local_tag(msk, daddr, saddr,
+			key = mctp_alloc_local_tag(msk, saddr, daddr,
 						   false, &tag);
 
 		if (IS_ERR(key)) {
-- 
2.39.2


