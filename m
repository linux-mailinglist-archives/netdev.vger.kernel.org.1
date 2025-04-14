Return-Path: <netdev+bounces-182323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319DFA887FE
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6867178D68
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BDD2820B7;
	Mon, 14 Apr 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="APLsmAAw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XMhYnJ+A"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21ED27FD71
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646892; cv=none; b=TBDXiOJutXCmTIi3ofOfsTTNVONLpfa4GDGYaqTnFfPi36o1rUcmkSOYP9ULPU1E6Boz3F/jEPfQZH7weiy4lLXIhZYAQ0RBgezn9edvfW8HPcmWwD9gaxTx2wzl7z5g/ZZch+UlxPFhCygXLIrYLpe1MfAI8s3nO67jtfq41ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646892; c=relaxed/simple;
	bh=XWftqXhechyFy7eHzL/4ue0k9l4oznl65kDA+H0lqT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TomjGVH5VMdwWLGBheaaa47NVr4ORoCjxQtNW4nt9SBMsCYMecs8/UgxEdGUm4jhljg912rZUaJP7G5r7vKixwbIAVr6uj/GPuwuh7VJMRXgFhxd23KqWrjdS2eFfol9KEij51zbmLTZ7wOYP6QWxllKbV6spSRNQ1OD4ZWtxeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=APLsmAAw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XMhYnJ+A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744646889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B69lYX6STHY9Dm6pSCO/tU0P9tsCz5ZZVCvx63c8o3s=;
	b=APLsmAAwTXPHVxPhzM4a7A6ZW6EMRi2+H0W2+cwb7IMi43FhUzOFMatWh62QQ92wp5jxFO
	/jivyuFBcnh0qkUko1ryNCBT32gJhDNUBNd32TswWZ5Daw+9hRidMEU0W3oXV/P81SGiKX
	6vY9xFAAxaaSisTGBoFBUqEGZSaYFtkC2JKVcTRXsCmwj9Sq9OvDXDV4XjC6x/UJ9r5zGR
	+9jvsosB4ujzKx4xqKExjh4ETQ6XHxH4X20vpmpS98Lr8anMVPdP09+rZ3880ugAFIvgie
	UvWCFZ9RiMYHKr2FnT1RnNbQZNfgGDWh0j9CaZlfnEpvYP4Q5uzOA9/Utzyzyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744646889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B69lYX6STHY9Dm6pSCO/tU0P9tsCz5ZZVCvx63c8o3s=;
	b=XMhYnJ+AOt7pKiLKEJqE6wfeqpAaYn8jvED78ZAF3f9pSxk2Qc9IkKu/a7rP1Wwus5XdX+
	svILFBwkcVaX8eAQ==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v2 02/18] net: dst_cache: Use nested-BH locking for dst_cache::cache
Date: Mon, 14 Apr 2025 18:07:38 +0200
Message-ID: <20250414160754.503321-3-bigeasy@linutronix.de>
In-Reply-To: <20250414160754.503321-1-bigeasy@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

dst_cache::cache is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Add a local_lock_t to the data structure and use
local_lock_nested_bh() for locking. This change adds only lockdep
coverage and does not alter the functional behaviour for !PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dst_cache.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 70c634b9e7b02..93a04d18e5054 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -17,6 +17,7 @@
 struct dst_cache_pcpu {
 	unsigned long refresh_ts;
 	struct dst_entry *dst;
+	local_lock_t bh_lock;
 	u32 cookie;
 	union {
 		struct in_addr in_saddr;
@@ -65,10 +66,15 @@ static struct dst_entry *dst_cache_per_cpu_get(struct d=
st_cache *dst_cache,
=20
 struct dst_entry *dst_cache_get(struct dst_cache *dst_cache)
 {
+	struct dst_entry *dst;
+
 	if (!dst_cache->cache)
 		return NULL;
=20
-	return dst_cache_per_cpu_get(dst_cache, this_cpu_ptr(dst_cache->cache));
+	local_lock_nested_bh(&dst_cache->cache->bh_lock);
+	dst =3D dst_cache_per_cpu_get(dst_cache, this_cpu_ptr(dst_cache->cache));
+	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
+	return dst;
 }
 EXPORT_SYMBOL_GPL(dst_cache_get);
=20
@@ -80,12 +86,16 @@ struct rtable *dst_cache_get_ip4(struct dst_cache *dst_=
cache, __be32 *saddr)
 	if (!dst_cache->cache)
 		return NULL;
=20
+	local_lock_nested_bh(&dst_cache->cache->bh_lock);
 	idst =3D this_cpu_ptr(dst_cache->cache);
 	dst =3D dst_cache_per_cpu_get(dst_cache, idst);
-	if (!dst)
+	if (!dst) {
+		local_unlock_nested_bh(&dst_cache->cache->bh_lock);
 		return NULL;
+	}
=20
 	*saddr =3D idst->in_saddr.s_addr;
+	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
 	return dst_rtable(dst);
 }
 EXPORT_SYMBOL_GPL(dst_cache_get_ip4);
@@ -98,9 +108,11 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, str=
uct dst_entry *dst,
 	if (!dst_cache->cache)
 		return;
=20
+	local_lock_nested_bh(&dst_cache->cache->bh_lock);
 	idst =3D this_cpu_ptr(dst_cache->cache);
 	dst_cache_per_cpu_dst_set(idst, dst, 0);
 	idst->in_saddr.s_addr =3D saddr;
+	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
 }
 EXPORT_SYMBOL_GPL(dst_cache_set_ip4);
=20
@@ -113,10 +125,13 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, s=
truct dst_entry *dst,
 	if (!dst_cache->cache)
 		return;
=20
+	local_lock_nested_bh(&dst_cache->cache->bh_lock);
+
 	idst =3D this_cpu_ptr(dst_cache->cache);
 	dst_cache_per_cpu_dst_set(idst, dst,
 				  rt6_get_cookie(dst_rt6_info(dst)));
 	idst->in6_saddr =3D *saddr;
+	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
 }
 EXPORT_SYMBOL_GPL(dst_cache_set_ip6);
=20
@@ -129,12 +144,17 @@ struct dst_entry *dst_cache_get_ip6(struct dst_cache =
*dst_cache,
 	if (!dst_cache->cache)
 		return NULL;
=20
+	local_lock_nested_bh(&dst_cache->cache->bh_lock);
+
 	idst =3D this_cpu_ptr(dst_cache->cache);
 	dst =3D dst_cache_per_cpu_get(dst_cache, idst);
-	if (!dst)
+	if (!dst) {
+		local_unlock_nested_bh(&dst_cache->cache->bh_lock);
 		return NULL;
+	}
=20
 	*saddr =3D idst->in6_saddr;
+	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
 	return dst;
 }
 EXPORT_SYMBOL_GPL(dst_cache_get_ip6);
@@ -142,10 +162,14 @@ EXPORT_SYMBOL_GPL(dst_cache_get_ip6);
=20
 int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp)
 {
+	unsigned int i;
+
 	dst_cache->cache =3D alloc_percpu_gfp(struct dst_cache_pcpu,
 					    gfp | __GFP_ZERO);
 	if (!dst_cache->cache)
 		return -ENOMEM;
+	for_each_possible_cpu(i)
+		local_lock_init(&per_cpu_ptr(dst_cache->cache, i)->bh_lock);
=20
 	dst_cache_reset(dst_cache);
 	return 0;
--=20
2.49.0


