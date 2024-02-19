Return-Path: <netdev+bounces-72876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C388985A04B
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3900E1F22BC0
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923F1288A7;
	Mon, 19 Feb 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fmPqewsc"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8ED25635
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336441; cv=none; b=OzWlG60C0nwa/tNjX8bCPjJPYOMk9ToeMAYM5wrJzYpRtilHslcSffFTfL2W/CpEj7w4p6+IVgYSXnDiZcEDvc+CDsWc9xbCKhv4/irK8KSsI6wVBst2hB9CA859PXY52omL08J51lAdAc8H4uIQB0LyqtIVvzCMKLf0m5IHW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336441; c=relaxed/simple;
	bh=upSTk/IgB5yPaKfb93EDdWf09RZR8fHTUjs40wkI8Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mu+zePuEhy+sTmsB5yN+Hpht+GRPpRnqtb6AR5qTQMw7iSYH32el2WhBVmQz1q/WE0eQ7hO0aFgQWQTNxW4lOu2VHoJdjBRY0sxXVxqrFsM/QxQOLY9R/RA8kUO5bVDjPstvletgRjtpX0W4vsXkG0OP4ad5crSgVCpYCdOIPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fmPqewsc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 2DEAC20488; Mon, 19 Feb 2024 17:53:55 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708336435;
	bh=+LNQfavPp84FAgR7C+jGNCjsdhY5u00Ay37IbOkKbtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fmPqewsc0Df7cxdHNOnAizz/FSUBiNJft4vm5zXYirA5QMCTSxIlU5TTcNSlx4KhG
	 Vmsaz0cDru0qfltozRQ+lPUNnhiCApJmU18oRGdUfZbJF28oXKH8Az4ZoXnh+t1axf
	 NcYkOvGvYBBtxvataaUf0fqPpc32z/wiNXep9TlXcyAsH0E6J9xqwC8M5V2lIVnXpd
	 +NUCTUM8yF+iYh9ljFOdY1rs33eYB21ZlzBNeH1CtR17QegDLSW8S0ju8HUqjBS3nW
	 0pHR4HxoHAX6glly1E+WA9XuZA5pbIoxuBVMBXYfdmYdAHDm65TunfA0DT3750T7CX
	 1IUc/4zySApnw==
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
Subject: [PATCH net-next v2 05/11] net: mctp: separate key correlation across nets
Date: Mon, 19 Feb 2024 17:51:50 +0800
Message-Id: <3b97a721f979a1a1d6056745c11ad29a50055022.1708335994.git.jk@codeconstruct.com.au>
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

Currently, we lookup sk_keys from the entire struct net_namespace, which
may contain multiple MCTP net IDs. In those cases we want to distinguish
between endpoints with the same EID but different net ID.

Add the net ID data to the struct mctp_sk_key, populate on add and
filter on this during route lookup.

For the ioctl interface, we use a default net of
MCTP_INITIAL_DEFAULT_NET (ie., what will be in use for single-net
configurations), but we'll extend the ioctl interface to provide
net-specific tag allocation in an upcoming change.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 include/net/mctp.h         |  2 ++
 net/mctp/af_mctp.c         |  4 ++--
 net/mctp/route.c           | 43 +++++++++++++++++++++++++++-----------
 net/mctp/test/route-test.c |  7 +++++--
 4 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index 81d31b31aa6f..7b17c52e8ce2 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -133,6 +133,7 @@ struct mctp_sock {
  *    - through an expiry timeout, on a per-socket timer
  */
 struct mctp_sk_key {
+	unsigned int	net;
 	mctp_eid_t	peer_addr;
 	mctp_eid_t	local_addr; /* MCTP_ADDR_ANY for local owned tags */
 	__u8		tag; /* incoming tag match; invert TO for local */
@@ -255,6 +256,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 
 void mctp_key_unref(struct mctp_sk_key *key);
 struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
+					 unsigned int netid,
 					 mctp_eid_t local, mctp_eid_t peer,
 					 bool manual, u8 *tagp);
 
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index d8197e9e233b..05315a422ffb 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -367,8 +367,8 @@ static int mctp_ioctl_alloctag(struct mctp_sock *msk, unsigned long arg)
 	if (ctl.flags)
 		return -EINVAL;
 
-	key = mctp_alloc_local_tag(msk, MCTP_ADDR_ANY, ctl.peer_addr,
-				   true, &tag);
+	key = mctp_alloc_local_tag(msk, MCTP_INITIAL_DEFAULT_NET,
+				   MCTP_ADDR_ANY, ctl.peer_addr, true, &tag);
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
diff --git a/net/mctp/route.c b/net/mctp/route.c
index b7ec64cd8b40..edfde04a1652 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -107,9 +107,12 @@ static struct mctp_sock *mctp_lookup_bind(struct net *net, struct sk_buff *skb)
  * and peer addresses, or either being ANY.
  */
 
-static bool mctp_key_match(struct mctp_sk_key *key, mctp_eid_t local,
-			   mctp_eid_t peer, u8 tag)
+static bool mctp_key_match(struct mctp_sk_key *key, unsigned int net,
+			   mctp_eid_t local, mctp_eid_t peer, u8 tag)
 {
+	if (key->net != net)
+		return false;
+
 	if (!mctp_address_matches(key->local_addr, local))
 		return false;
 
@@ -126,7 +129,7 @@ static bool mctp_key_match(struct mctp_sk_key *key, mctp_eid_t local,
  * key exists.
  */
 static struct mctp_sk_key *mctp_lookup_key(struct net *net, struct sk_buff *skb,
-					   mctp_eid_t peer,
+					   unsigned int netid, mctp_eid_t peer,
 					   unsigned long *irqflags)
 	__acquires(&key->lock)
 {
@@ -142,7 +145,7 @@ static struct mctp_sk_key *mctp_lookup_key(struct net *net, struct sk_buff *skb,
 	spin_lock_irqsave(&net->mctp.keys_lock, flags);
 
 	hlist_for_each_entry(key, &net->mctp.keys, hlist) {
-		if (!mctp_key_match(key, mh->dest, peer, tag))
+		if (!mctp_key_match(key, netid, mh->dest, peer, tag))
 			continue;
 
 		spin_lock(&key->lock);
@@ -165,6 +168,7 @@ static struct mctp_sk_key *mctp_lookup_key(struct net *net, struct sk_buff *skb,
 }
 
 static struct mctp_sk_key *mctp_key_alloc(struct mctp_sock *msk,
+					  unsigned int net,
 					  mctp_eid_t local, mctp_eid_t peer,
 					  u8 tag, gfp_t gfp)
 {
@@ -174,6 +178,7 @@ static struct mctp_sk_key *mctp_key_alloc(struct mctp_sock *msk,
 	if (!key)
 		return NULL;
 
+	key->net = net;
 	key->peer_addr = peer;
 	key->local_addr = local;
 	key->tag = tag;
@@ -219,8 +224,8 @@ static int mctp_key_add(struct mctp_sk_key *key, struct mctp_sock *msk)
 	}
 
 	hlist_for_each_entry(tmp, &net->mctp.keys, hlist) {
-		if (mctp_key_match(tmp, key->local_addr, key->peer_addr,
-				   key->tag)) {
+		if (mctp_key_match(tmp, key->net, key->local_addr,
+				   key->peer_addr, key->tag)) {
 			spin_lock(&tmp->lock);
 			if (tmp->valid)
 				rc = -EEXIST;
@@ -361,6 +366,7 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	struct mctp_sock *msk;
 	struct mctp_hdr *mh;
+	unsigned int netid;
 	unsigned long f;
 	u8 tag, flags;
 	int rc;
@@ -379,6 +385,7 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 
 	/* grab header, advance data ptr */
 	mh = mctp_hdr(skb);
+	netid = mctp_cb(skb)->net;
 	skb_pull(skb, sizeof(struct mctp_hdr));
 
 	if (mh->ver != 1)
@@ -392,7 +399,7 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	/* lookup socket / reasm context, exactly matching (src,dest,tag).
 	 * we hold a ref on the key, and key->lock held.
 	 */
-	key = mctp_lookup_key(net, skb, mh->src, &f);
+	key = mctp_lookup_key(net, skb, netid, mh->src, &f);
 
 	if (flags & MCTP_HDR_FLAG_SOM) {
 		if (key) {
@@ -406,7 +413,8 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 			 * this lookup requires key->peer to be MCTP_ADDR_ANY,
 			 * it doesn't match just any key->peer.
 			 */
-			any_key = mctp_lookup_key(net, skb, MCTP_ADDR_ANY, &f);
+			any_key = mctp_lookup_key(net, skb, netid,
+						  MCTP_ADDR_ANY, &f);
 			if (any_key) {
 				msk = container_of(any_key->sk,
 						   struct mctp_sock, sk);
@@ -443,7 +451,7 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 		 * packets for this message
 		 */
 		if (!key) {
-			key = mctp_key_alloc(msk, mh->dest, mh->src,
+			key = mctp_key_alloc(msk, netid, mh->dest, mh->src,
 					     tag, GFP_ATOMIC);
 			if (!key) {
 				rc = -ENOMEM;
@@ -637,6 +645,7 @@ static void mctp_reserve_tag(struct net *net, struct mctp_sk_key *key,
  * it for the socket msk
  */
 struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
+					 unsigned int netid,
 					 mctp_eid_t local, mctp_eid_t peer,
 					 bool manual, u8 *tagp)
 {
@@ -651,7 +660,7 @@ struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
 		peer = MCTP_ADDR_ANY;
 
 	/* be optimistic, alloc now */
-	key = mctp_key_alloc(msk, local, peer, 0, GFP_KERNEL);
+	key = mctp_key_alloc(msk, netid, local, peer, 0, GFP_KERNEL);
 	if (!key)
 		return ERR_PTR(-ENOMEM);
 
@@ -668,6 +677,10 @@ struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
 		 * lock held, they don't change over the lifetime of the key.
 		 */
 
+		/* tags are net-specific */
+		if (tmp->net != netid)
+			continue;
+
 		/* if we don't own the tag, it can't conflict */
 		if (tmp->tag & MCTP_HDR_FLAG_TO)
 			continue;
@@ -716,6 +729,7 @@ struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
 }
 
 static struct mctp_sk_key *mctp_lookup_prealloc_tag(struct mctp_sock *msk,
+						    unsigned int netid,
 						    mctp_eid_t daddr,
 						    u8 req_tag, u8 *tagp)
 {
@@ -730,6 +744,9 @@ static struct mctp_sk_key *mctp_lookup_prealloc_tag(struct mctp_sock *msk,
 	spin_lock_irqsave(&mns->keys_lock, flags);
 
 	hlist_for_each_entry(tmp, &mns->keys, hlist) {
+		if (tmp->net != netid)
+			continue;
+
 		if (tmp->tag != req_tag)
 			continue;
 
@@ -910,6 +927,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 	struct mctp_sk_key *key;
 	struct mctp_hdr *hdr;
 	unsigned long flags;
+	unsigned int netid;
 	unsigned int mtu;
 	mctp_eid_t saddr;
 	bool ext_rt;
@@ -960,16 +978,17 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		rc = 0;
 	}
 	spin_unlock_irqrestore(&rt->dev->addrs_lock, flags);
+	netid = READ_ONCE(rt->dev->net);
 
 	if (rc)
 		goto out_release;
 
 	if (req_tag & MCTP_TAG_OWNER) {
 		if (req_tag & MCTP_TAG_PREALLOC)
-			key = mctp_lookup_prealloc_tag(msk, daddr,
+			key = mctp_lookup_prealloc_tag(msk, netid, daddr,
 						       req_tag, &tag);
 		else
-			key = mctp_alloc_local_tag(msk, saddr, daddr,
+			key = mctp_alloc_local_tag(msk, netid, saddr, daddr,
 						   false, &tag);
 
 		if (IS_ERR(key)) {
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 714e5ae47629..b3dbd3600d91 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -552,6 +552,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 	struct mctp_sock *msk;
 	struct socket *sock;
 	unsigned long flags;
+	unsigned int net;
 	int rc;
 	u8 c;
 
@@ -559,6 +560,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 
 	dev = mctp_test_create_dev();
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	net = READ_ONCE(dev->mdev->net);
 
 	rt = mctp_test_create_route(&init_net, dev->mdev, 8, 68);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
@@ -570,8 +572,9 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 	mns = &sock_net(sock->sk)->mctp;
 
 	/* set the incoming tag according to test params */
-	key = mctp_key_alloc(msk, params->key_local_addr, params->key_peer_addr,
-			     params->key_tag, GFP_KERNEL);
+	key = mctp_key_alloc(msk, net, params->key_local_addr,
+			     params->key_peer_addr, params->key_tag,
+			     GFP_KERNEL);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, key);
 
-- 
2.39.2


