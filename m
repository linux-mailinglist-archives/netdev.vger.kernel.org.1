Return-Path: <netdev+bounces-147760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD679DB9B0
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C563281D9E
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4C1AA7AF;
	Thu, 28 Nov 2024 14:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E95D8F0
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804407; cv=none; b=PXmONuQS/EUCzvRfrtouITvOxADni2KjSP4gQENlJ0Rvp5Lo2GKH6BEYfGifW/7qAHa+L/nEjm0VdaeDqrwgPtizMnmwbsRLkjgdzzqR+8Zzsb5rVNzAIG6z4V4WZvXVj4VHjGV+cvRDEgShf2OQcrsFfOZdcV36CQN+AdLdOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804407; c=relaxed/simple;
	bh=VW9V4RqoNEhWev8GKkjKjfnHFnB8wjaN+lvNKphW+lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fASj5lQTToVZYBj5lFJUFtmz/C8N+8foB30sA8qOurKJASODITtPQqN6KI1nQm1Lgk9KOecqMwi9b6kvNiLKJul+zCqokiQVm1NWIbBW2zguWzGRQ/hFZSewq2q+Cvd4T4sE6dDIym+OOFkNCfdHrCUBfgio3xfZoOdHAZpkakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1tGfZy-00006N-MV; Thu, 28 Nov 2024 15:33:14 +0100
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dvyukov@google.com,
	Florian Westphal <fw@strlen.de>,
	syzbot+5f9f31cb7d985f584d8e@syzkaller.appspotmail.com
Subject: [PATCH ipsec] xfrm: state: fix out-of-bounds read during lookup
Date: Thu, 28 Nov 2024 15:26:25 +0100
Message-ID: <20241128142640.26848-1-fw@strlen.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <6745e035.050a0220.1286eb.001b.GAE@google.com>
References: <6745e035.050a0220.1286eb.001b.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lookup and resize can run in parallel.

The xfrm_state_hash_generation seqlock ensures a retry, but the hash
functions can observe a hmask value that is too large for the new hlist
array.

rehash does:
  rcu_assign_pointer(net->xfrm.state_bydst, ndst) [..]
  net->xfrm.state_hmask = nhashmask;

While state lookup does:
  h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
  hlist_for_each_entry_rcu(x, net->xfrm.state_bydst + h, bydst) {

This is only safe in case the update to state_bydst is larger than
net->xfrm.xfrm_state_hmask (or if the lookup function gets
serialized via state spinlock again).

Fix this by prefetching state_hmask and the associated pointers.
The xfrm_state_hash_generation seqlock retry will ensure that the pointer
and the hmask will be consistent.

The existing helpers, like xfrm_dst_hash(), are now unsafe for RCU side,
add lockdep assertions to document that they are only safe for insert
side.

xfrm_state_lookup_byaddr() uses the spinlock rather than RCU.
AFAICS this is an oversight from back when state lookup was converted to
RCU, this lock should be replaced with RCU in a future patch.

Reported-by: syzbot+5f9f31cb7d985f584d8e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/CACT4Y+azwfrE3uz6A5ZErov5YN2LYBN5KrsymBerT36VU8qzBA@mail.gmail.com/
Diagnosed-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: c2f672fc9464 ("xfrm: state lookup can be lockless")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/xfrm/xfrm_state.c | 89 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 19 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 67ca7ac955a3..1781728ca428 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -34,6 +34,8 @@
 
 #define xfrm_state_deref_prot(table, net) \
 	rcu_dereference_protected((table), lockdep_is_held(&(net)->xfrm.xfrm_state_lock))
+#define xfrm_state_deref_check(table, net) \
+	rcu_dereference_check((table), lockdep_is_held(&(net)->xfrm.xfrm_state_lock))
 
 static void xfrm_state_gc_task(struct work_struct *work);
 
@@ -62,6 +64,8 @@ static inline unsigned int xfrm_dst_hash(struct net *net,
 					 u32 reqid,
 					 unsigned short family)
 {
+	lockdep_assert_held(&net->xfrm.xfrm_state_lock);
+
 	return __xfrm_dst_hash(daddr, saddr, reqid, family, net->xfrm.state_hmask);
 }
 
@@ -70,6 +74,8 @@ static inline unsigned int xfrm_src_hash(struct net *net,
 					 const xfrm_address_t *saddr,
 					 unsigned short family)
 {
+	lockdep_assert_held(&net->xfrm.xfrm_state_lock);
+
 	return __xfrm_src_hash(daddr, saddr, family, net->xfrm.state_hmask);
 }
 
@@ -77,11 +83,15 @@ static inline unsigned int
 xfrm_spi_hash(struct net *net, const xfrm_address_t *daddr,
 	      __be32 spi, u8 proto, unsigned short family)
 {
+	lockdep_assert_held(&net->xfrm.xfrm_state_lock);
+
 	return __xfrm_spi_hash(daddr, spi, proto, family, net->xfrm.state_hmask);
 }
 
 static unsigned int xfrm_seq_hash(struct net *net, u32 seq)
 {
+	lockdep_assert_held(&net->xfrm.xfrm_state_lock);
+
 	return __xfrm_seq_hash(seq, net->xfrm.state_hmask);
 }
 
@@ -1041,16 +1051,38 @@ xfrm_init_tempstate(struct xfrm_state *x, const struct flowi *fl,
 	x->props.family = tmpl->encap_family;
 }
 
-static struct xfrm_state *__xfrm_state_lookup_all(struct net *net, u32 mark,
+struct xfrm_hash_state_ptrs {
+	const struct hlist_head *bydst;
+	const struct hlist_head *bysrc;
+	const struct hlist_head *byspi;
+	unsigned int hmask;
+};
+
+static void xfrm_hash_ptrs_get(const struct net *net, struct xfrm_hash_state_ptrs *ptrs)
+{
+	unsigned int sequence;
+
+	do {
+		sequence = read_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
+
+		ptrs->bydst = xfrm_state_deref_check(net->xfrm.state_bydst, net);
+		ptrs->bysrc = xfrm_state_deref_check(net->xfrm.state_bysrc, net);
+		ptrs->byspi = xfrm_state_deref_check(net->xfrm.state_byspi, net);
+		ptrs->hmask = net->xfrm.state_hmask;
+	} while (read_seqcount_retry(&net->xfrm.xfrm_state_hash_generation, sequence));
+}
+
+static struct xfrm_state *__xfrm_state_lookup_all(const struct xfrm_hash_state_ptrs *state_ptrs,
+						  u32 mark,
 						  const xfrm_address_t *daddr,
 						  __be32 spi, u8 proto,
 						  unsigned short family,
 						  struct xfrm_dev_offload *xdo)
 {
-	unsigned int h = xfrm_spi_hash(net, daddr, spi, proto, family);
+	unsigned int h = __xfrm_spi_hash(daddr, spi, proto, family, state_ptrs->hmask);
 	struct xfrm_state *x;
 
-	hlist_for_each_entry_rcu(x, net->xfrm.state_byspi + h, byspi) {
+	hlist_for_each_entry_rcu(x, state_ptrs->byspi + h, byspi) {
 #ifdef CONFIG_XFRM_OFFLOAD
 		if (xdo->type == XFRM_DEV_OFFLOAD_PACKET) {
 			if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
@@ -1084,15 +1116,16 @@ static struct xfrm_state *__xfrm_state_lookup_all(struct net *net, u32 mark,
 	return NULL;
 }
 
-static struct xfrm_state *__xfrm_state_lookup(struct net *net, u32 mark,
+static struct xfrm_state *__xfrm_state_lookup(const struct xfrm_hash_state_ptrs *state_ptrs,
+					      u32 mark,
 					      const xfrm_address_t *daddr,
 					      __be32 spi, u8 proto,
 					      unsigned short family)
 {
-	unsigned int h = xfrm_spi_hash(net, daddr, spi, proto, family);
+	unsigned int h = __xfrm_spi_hash(daddr, spi, proto, family, state_ptrs->hmask);
 	struct xfrm_state *x;
 
-	hlist_for_each_entry_rcu(x, net->xfrm.state_byspi + h, byspi) {
+	hlist_for_each_entry_rcu(x, state_ptrs->byspi + h, byspi) {
 		if (x->props.family != family ||
 		    x->id.spi       != spi ||
 		    x->id.proto     != proto ||
@@ -1114,6 +1147,7 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 					   __be32 spi, u8 proto,
 					   unsigned short family)
 {
+	struct xfrm_hash_state_ptrs state_ptrs;
 	struct hlist_head *state_cache_input;
 	struct xfrm_state *x = NULL;
 	int cpu = get_cpu();
@@ -1135,7 +1169,9 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 		goto out;
 	}
 
-	x = __xfrm_state_lookup(net, mark, daddr, spi, proto, family);
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	x = __xfrm_state_lookup(&state_ptrs, mark, daddr, spi, proto, family);
 
 	if (x && x->km.state == XFRM_STATE_VALID) {
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
@@ -1155,15 +1191,16 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 }
 EXPORT_SYMBOL(xfrm_input_state_lookup);
 
-static struct xfrm_state *__xfrm_state_lookup_byaddr(struct net *net, u32 mark,
+static struct xfrm_state *__xfrm_state_lookup_byaddr(const struct xfrm_hash_state_ptrs *state_ptrs,
+						     u32 mark,
 						     const xfrm_address_t *daddr,
 						     const xfrm_address_t *saddr,
 						     u8 proto, unsigned short family)
 {
-	unsigned int h = xfrm_src_hash(net, daddr, saddr, family);
+	unsigned int h = __xfrm_src_hash(daddr, saddr, family, state_ptrs->hmask);
 	struct xfrm_state *x;
 
-	hlist_for_each_entry_rcu(x, net->xfrm.state_bysrc + h, bysrc) {
+	hlist_for_each_entry_rcu(x, state_ptrs->bysrc + h, bysrc) {
 		if (x->props.family != family ||
 		    x->id.proto     != proto ||
 		    !xfrm_addr_equal(&x->id.daddr, daddr, family) ||
@@ -1183,14 +1220,17 @@ static struct xfrm_state *__xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 static inline struct xfrm_state *
 __xfrm_state_locate(struct xfrm_state *x, int use_spi, int family)
 {
+	struct xfrm_hash_state_ptrs state_ptrs;
 	struct net *net = xs_net(x);
 	u32 mark = x->mark.v & x->mark.m;
 
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
 	if (use_spi)
-		return __xfrm_state_lookup(net, mark, &x->id.daddr,
+		return __xfrm_state_lookup(&state_ptrs, mark, &x->id.daddr,
 					   x->id.spi, x->id.proto, family);
 	else
-		return __xfrm_state_lookup_byaddr(net, mark,
+		return __xfrm_state_lookup_byaddr(&state_ptrs, mark,
 						  &x->id.daddr,
 						  &x->props.saddr,
 						  x->id.proto, family);
@@ -1264,6 +1304,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		unsigned short family, u32 if_id)
 {
 	static xfrm_address_t saddr_wildcard = { };
+	struct xfrm_hash_state_ptrs state_ptrs;
 	struct net *net = xp_net(pol);
 	unsigned int h, h_wildcard;
 	struct xfrm_state *x, *x0, *to_put;
@@ -1328,8 +1369,10 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	else if (acquire_in_progress) /* XXX: acquire_in_progress should not happen */
 		WARN_ON(1);
 
-	h = xfrm_dst_hash(net, daddr, saddr, tmpl->reqid, encap_family);
-	hlist_for_each_entry_rcu(x, net->xfrm.state_bydst + h, bydst) {
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	h = __xfrm_dst_hash(daddr, saddr, tmpl->reqid, encap_family, state_ptrs.hmask);
+	hlist_for_each_entry_rcu(x, state_ptrs.bydst + h, bydst) {
 #ifdef CONFIG_XFRM_OFFLOAD
 		if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET) {
 			if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
@@ -1362,8 +1405,9 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	if (best || acquire_in_progress)
 		goto found;
 
-	h_wildcard = xfrm_dst_hash(net, daddr, &saddr_wildcard, tmpl->reqid, encap_family);
-	hlist_for_each_entry_rcu(x, net->xfrm.state_bydst + h_wildcard, bydst) {
+	h_wildcard = __xfrm_dst_hash(daddr, &saddr_wildcard, tmpl->reqid,
+				     encap_family, state_ptrs.hmask);
+	hlist_for_each_entry_rcu(x, state_ptrs.bydst + h_wildcard, bydst) {
 #ifdef CONFIG_XFRM_OFFLOAD
 		if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET) {
 			if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
@@ -1401,7 +1445,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 
 	if (!x && !error && !acquire_in_progress) {
 		if (tmpl->id.spi &&
-		    (x0 = __xfrm_state_lookup_all(net, mark, daddr,
+		    (x0 = __xfrm_state_lookup_all(&state_ptrs, mark, daddr,
 						  tmpl->id.spi, tmpl->id.proto,
 						  encap_family,
 						  &pol->xdo)) != NULL) {
@@ -2180,10 +2224,13 @@ struct xfrm_state *
 xfrm_state_lookup(struct net *net, u32 mark, const xfrm_address_t *daddr, __be32 spi,
 		  u8 proto, unsigned short family)
 {
+	struct xfrm_hash_state_ptrs state_ptrs;
 	struct xfrm_state *x;
 
 	rcu_read_lock();
-	x = __xfrm_state_lookup(net, mark, daddr, spi, proto, family);
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	x = __xfrm_state_lookup(&state_ptrs, mark, daddr, spi, proto, family);
 	rcu_read_unlock();
 	return x;
 }
@@ -2194,10 +2241,14 @@ xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 			 const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			 u8 proto, unsigned short family)
 {
+	struct xfrm_hash_state_ptrs state_ptrs;
 	struct xfrm_state *x;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
-	x = __xfrm_state_lookup_byaddr(net, mark, daddr, saddr, proto, family);
+
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	x = __xfrm_state_lookup_byaddr(&state_ptrs, mark, daddr, saddr, proto, family);
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 	return x;
 }
-- 
2.45.2


