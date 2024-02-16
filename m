Return-Path: <netdev+bounces-72292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406B4857788
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038D02828B9
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098517BCD;
	Fri, 16 Feb 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PJzU433F"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E31C69E
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071581; cv=none; b=T2O7/NGkx3Rrgj+oZsJ9Vq0xYfitssPVK93pPY7n1EFkfQShj7r8yFsT5XBSMIzrhJGaUQhKRUwhV8ePX8AMeuz+nAJviZbCBLgUNOFOtK/dB6wXJdf+1eaVRYWbiNhUOOtx7/8aa+zWI5OGtI2dsuzlpVVV5U7VjwcU9sJJtS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071581; c=relaxed/simple;
	bh=QxJA+W974TgVF1c9OXnJPm1AJ1pY56/vmI5Nnwq361w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjD9sXAQgE76tHDdNZ/udxHB/Oon6m7RjEGhEj9vEmGfclYL/QlOYc99f3R+xe5Fv4pkmjke+ltAxpJGwg5Y0I/f8LDPlojiWU1LWRZoN8rzF7EH0VOxpvUI36YI4R81Ogdfv+vETO3OdXK/PafN7BavTOZu8LZdg1LS0CcqrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PJzU433F; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 261F6201FC; Fri, 16 Feb 2024 16:19:32 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708071572;
	bh=n4x5kGq7xgRBh+x41GHeGkfdbfDRvOyVWgtpyF6H9oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJzU433FZ9xpxQBIQ7HXQGv4uft8SciJYCRvPIngKvAVjKue9dpNZmVkposvk5jDd
	 yibwj7Cv27wRCzOuoPFp5py/hZc8Rt0F1yXHAUZ+dyhqSqEhl4wRJlxYiLU08wYmev
	 ym+PRTBw+EkN9NeVjGyJkqMnB7RQAEpps9iSO5Hf5Nqn0AhYmFTyysdFwo6CCplt2+
	 HLTXMWY1epzGI+HY/+Nopv7gx4/qIsNn+sd2ZaPlrMWyBOWAxoXGrSazJu+lXtt5vJ
	 lZp4UgnFMErCE2/JOMZ7VzGXKEZh6OpyCv6+JDe+yipenzndq2DzwlSJQ+BOYMdGfu
	 75Dp9O5T01yjQ==
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
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 01/11] net: mctp: avoid confusion over local/peer dest/source addresses
Date: Fri, 16 Feb 2024 16:19:11 +0800
Message-Id: <5ca7af1911fa9279e6ee5fc0f835c1489880664b.1708071380.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708071380.git.jk@codeconstruct.com.au>
References: <cover.1708071380.git.jk@codeconstruct.com.au>
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


