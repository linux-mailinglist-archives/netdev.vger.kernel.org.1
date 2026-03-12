Return-Path: <netdev+bounces-267159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMPBMSzosmljQwAAu9opvQ
	(envelope-from <netdev+bounces-267159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:22:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AA6275801
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E900C3009CF2
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5724539023A;
	Thu, 12 Mar 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i4Qhe4Hn"
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-9.consmr.mail.ne1.yahoo.com (sonic307-9.consmr.mail.ne1.yahoo.com [66.163.190.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A3390986
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332278; cv=none; b=ECealhNYl+a764hOg0M6+IMKoHPL8xqgxWeBIQWMQq1/dzJL7iK2WRoG4gnlXgqf6zSQff7MZgWJb/gMjR2cmXMXtqZrNBo2wqbs+TpoQBoHbcTR6FKvIHfUKhozaWWO7LcLKldV30yADOiDFmoW0oR2bqjZSEH4fzFRR4ANRa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332278; c=relaxed/simple;
	bh=mhG7CrQu7ep05VFtZ9SeYqN/ezpxdhKoE3LTppEdzG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/VOgTuKkNW/viYdaZslgIOJJSua4EgkEqMMFijjeg9KW50LEjXG4qK4RUeoNh5W7EjQ6/ysAHYb5AIBDzE3VKZ5gyGK5t8LjYX/P+yHfSMj2sHoisvaM8hEkqnzQGEfho8p9EUsE78Zqc0cFS3TnSbCKCxLtpM6guX0pEZtUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=i4Qhe4Hn; arc=none smtp.client-ip=66.163.190.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773332276; bh=6ZSkq8IV5deGE/7JN8rVgNXGG87eCkfpKhLb/uXHriI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=i4Qhe4HnHa+B4WhI3aA8btl0Oy0RsRLDKF2YdeBR9lx4V7uqdq85c9F87DsBuswyAlcNtQfihpHKVbY82k4HxybdvUyIrNwZsoFEZdVgZb11EAngaAFYVAFYk3SRCQhGv3tpQWj5+XLpPfi5DWg/NVDhDvAx6O+SH/l+cESAz+1DNA1rxXTGlpvJ7f7H4hXrMzJUBCNy+XOUch3q+qeDAkD6X6p7XBvdt1NJMKkHJP6DzxJSizvbCUC4Y4Uq4j0v4MJ759oE7ejxnvsnk1/McSGZgenvqIiScP9XzEaWmpkUdP/mZUUvuHS/YQDH/SK1KATrzaPMA3lFdZJnpONfwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773332276; bh=Cz1tS9geCOvwpsjyQfRF0oAtSHVGSUoKUqFbuOHDq04=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tjyB1BX56BxqB3JvPJD12GjIYO+rTAxTq0LKcy5ST/Q4HX/UrCRMmKj1lJY5xTMBfB0Uzv0fIOgO5AXm+AEKKd9e7sVjqrSADQznxWTH8GjbT0hqTvMG9liDOWwawkoHRcjQG0zw2I4i2xA1/k4Pr7A64YXbrWY4xWkjUXckkX3FqGKiiogALP+St1xVTteaDZSjoW7eeQ8eozenQRJl1LMF8jGniR46/s7Jgtj7QAhTQfMuiYlkzxkkNF4Mvg7LjYaIm9OWGDfWzWMckGe1dmowW6IbNM0HXfEXlK5JE30S2wsQlti9gt5xa4/1Y3teJcxdB80n204k4yEBUh8J5w==
X-YMail-OSG: ls1vALAVM1l3.jLb9H2IKMtULfQgy2nQA3V5qSgs9vX1SfaDQayAbN7uXFdcXDy
 hcKOA1rOUTOCa6YWnYDa0sePtcy_b22TdZ4IKnz7KEdQRVp6FXlL0wxZse5m2zQPyLq8eTrlRynO
 Xps14FfZiZ44N_NjDhdLNF6KmdEJiRl3tfe2stz08rvrreQ5juWLH.wnqw.YQkmLhMC8DZs2VPrC
 4xL2hvfblh42_XRAmNiN1zoFJrLH8wZa92gEpkJuf5nHzHmDh_.Jt9tHJm390AAyavhcXWWXxS8l
 X7RP2rAm6kdKOIQpVqhGZ8B_6AicF3r2OJYjtxOPT9UXn_Y.QPidKLiBG9VxnViIQXY3LR7RWJol
 XN0fqGC8lCCYs.U4LAMygd1KglQyab_.kYxtWvNrNV04YXGMUfokfFAmgzOnHXmy3gsS6IHNEqQd
 OLx_KBwUSEEe0DyhvV8JSSrfIOkM2BYQEiYQO5Q.ETgk6PecKp69errHddpddD_d39AKmFspXwFz
 zCpz0XhSTNAeP7XPMOUvvqvRgDIDgrDZDVbxku81SrobC0JEj.avb8mMrSKmtxslpw7BwEzvIDim
 w_6JJNprM7n4RgHAEG.vxFkNyoET5wkaVBnkIbRYySPhCwhEvFEgmPSBBmsnedKbk6bAUvEJG6uM
 yfpIRKQoBU3v.uZ7ziPMR0iKCU0IsqeWtUlNhMzatTvX9yvmdVL50UWbX3LZDSKaJ9lIGQH.TjKW
 GUA6MTZZd_fuouxKsSUmobTAIabF2b3CSWHNJJ21VCIpElGtsEAJZsAQdOsVxupPWejLyXici92c
 9hMkb6ycpQFR6Xl5KJaETJBkMBu99DGQqOCuwhv20O3jzcSz7tjG8ehTx8zseDO18j5ulXtUjkqZ
 VQhv6QTomu3uAopzdPZetuPQ3tV8ulem.q5_bhQzCpKPu0irL213bqKHLJ1J.PkzXOsyXpNEjMdJ
 bXzOM_I3I_tScXyt2qtc54XBmCkIO1VUY8WYHxHHGf77kbfM6hQxtdLFg6wTXi2x2q_eF5IubMrb
 0jRyWLLE90rxbfGuvXGhFtVYOBpLewJ4jY27RMFVBLYVRycjGH1qurR9uDXcWobbPmgkoBVbOwXP
 UkqB27ox7baLlDuxUZB6edNlQGX5GKHu6CtsH9MY_2kD1oJNW_9QwLNPOpVDqQdL9oD07Na86SsM
 zk3qc1fxTvBbdAdeIPafDqOXJJTWJ6ZPFR.LU.5EaWFkiWYY8OMj_sSXBJy8CscUDNFJ4fjzPQOK
 Hfq7vBpjRSawGH77BU.tXct9uj6kUPOT84XZOyId95aAszmNOiGGnLzpsdUfhSkGgcl1TKJZ8jZ.
 bSQE9o5Xmj0Jf.WsiO1jnVtYzcj5P3Kn.kt9TBOHdDvXti07EDQ_PVvYgco_ISYhKieznkNcUjXx
 NRveb6im4nZu.5KLcimTjGFPL1JlAg.EufeDcAhMJyg6n_gL5ag1Y0IeKl6ZzMIm4jL2uw37MzGF
 6rETUKdB5c6sTZM95uJ76KKCvQ705gf4oKUyXnXvbaJGjBmXc98eKuWniQv.f08FwW3a4Mv8z0PT
 DwwM5D_Fa9Rv5kymk1uJ_2ooIgeHdyk678doCyfm7mO1ZVcNZ5BnEIEW0pL10MjrS8Q1hGrta6wr
 HbwqX0u.q.iWVFjtONocaYyQnUhEvsa08WTkNeX6xYHpzcLy2moS29NcZKKjINk6ieRXDW1hCOXy
 MTvbRGxt0mOWCENlgL576uDFQW50NC2LR35jyKHJJYCbDt8LFfV4yl.Zv7L3Mw2FAn_UWtC3jrfU
 x0had1zHzDkwxf8T81MqBIu4B9mHpAxPfvzUH6NjXh0CDs6r8uxQWdal4Zgd3ZM.takN4kkBSjSi
 XeZ9m3p86J81Lw0cTcRmrIObMr.9hxlUaBmcadK4eopkMGPHfoMG_TYWTM5cFFFarQBedmlGu.ka
 szuSOk5KgLvympQUwoTe4w24E0iw487Nvluq7wRSLHZFAHferFlKE5OuOKNF9d33gLryToderrMd
 lQEen_Qul_YI_JZPJKRJb3aTp2C4HcdwutIdSWl1lg7DoQ9CSjXOf_fuEZ5M_hgr5RwzSuTjanZY
 LRtEV4_ZOmURT9P_QlUMhGp2Dj1rG.iat44p5UfA2sZH1gVOHnxxoAIPhup0scY98tybE3D.s1O4
 19sw2LQBcsAXRzLGE5a8fDuCRdeZZ_2wdhISIwYnpMwdPbih5sH_ZUMw-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: c5a266c3-0f61-4354-8ea5-4592aafeb473
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 16:17:56 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 15:57:33 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 01/11] net: dst_cache: add noref versions for dst_cache
Date: Thu, 12 Mar 2026 16:56:47 +0100
Message-ID: <20260312155657.25676-2-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312155657.25676-1-mmietus97@yahoo.com>
References: <20260312155657.25676-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 30AA6275801
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement noref variants for existing dst_cache helpers
interacting with dst_entry. This is required for implementing
noref flows, which avoid redundant atomic operations.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 include/net/dst_cache.h |  71 +++++++++++++++++++++
 net/core/dst_cache.c    | 133 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 194 insertions(+), 10 deletions(-)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index 1961699598e2..8d425cd75fd3 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -23,6 +23,23 @@ struct dst_cache {
  */
 struct dst_entry *dst_cache_get(struct dst_cache *dst_cache);
 
+/**
+ * dst_cache_get_rcu - perform cache lookup under RCU
+ * @dst_cache: the cache
+ *
+ * Perform cache lookup without taking a reference on the dst.
+ * Must be called with local BH disabled, and within an rcu read side
+ * critical section.
+ *
+ * The caller should use dst_cache_get_ip4_rcu() if it need to retrieve the
+ * source address to be used when xmitting to the cached dst.
+ * local BH must be disabled.
+ *
+ * Return: Pointer to retrieved rtable if cache is initialized and
+ * cached dst is valid, NULL otherwise.
+ */
+struct dst_entry *dst_cache_get_rcu(struct dst_cache *dst_cache);
+
 /**
  *	dst_cache_get_ip4 - perform cache lookup and fetch ipv4 source address
  *	@dst_cache: the cache
@@ -32,6 +49,21 @@ struct dst_entry *dst_cache_get(struct dst_cache *dst_cache);
  */
 struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr);
 
+/**
+ * dst_cache_get_ip4_rcu - lookup cache and ipv4 source under RCU
+ * @dst_cache: the cache
+ * @saddr: return value for the retrieved source address
+ *
+ * Perform cache lookup and fetch ipv4 source without taking a
+ * reference on the dst.
+ * Must be called with local BH disabled, and within an rcu read side
+ * critical section.
+ *
+ * Return: Pointer to retrieved rtable if cache is initialized and
+ * cached dst is valid, NULL otherwise.
+ */
+struct rtable *dst_cache_get_ip4_rcu(struct dst_cache *dst_cache, __be32 *saddr);
+
 /**
  *	dst_cache_set_ip4 - store the ipv4 dst into the cache
  *	@dst_cache: the cache
@@ -43,6 +75,17 @@ struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr);
 void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
 		       __be32 saddr);
 
+/**
+ * dst_cache_steal_ip4 - store the ipv4 dst into the cache and steal its
+ * reference
+ * @dst_cache: the cache
+ * @dst: the entry to be cached whose reference will be stolen
+ * @saddr: the source address to be stored inside the cache
+ *
+ * local BH must be disabled
+ */
+void dst_cache_steal_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
+			 __be32 saddr);
 #if IS_ENABLED(CONFIG_IPV6)
 
 /**
@@ -56,6 +99,18 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
 void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
 		       const struct in6_addr *saddr);
 
+/**
+ * dst_cache_steal_ip6 - store the ipv6 dst into the cache and steal its
+ * reference
+ * @dst_cache: the cache
+ * @dst: the entry to be cached whose reference will be stolen
+ * @saddr: the source address to be stored inside the cache
+ *
+ * local BH must be disabled
+ */
+void dst_cache_steal_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
+			 const struct in6_addr *saddr);
+
 /**
  *	dst_cache_get_ip6 - perform cache lookup and fetch ipv6 source address
  *	@dst_cache: the cache
@@ -65,6 +120,22 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
  */
 struct dst_entry *dst_cache_get_ip6(struct dst_cache *dst_cache,
 				    struct in6_addr *saddr);
+
+/**
+ * dst_cache_get_ip6_rcu - lookup cache and ipv6 source under RCU
+ * @dst_cache: the cache
+ * @saddr: return value for the retrieved source address
+ *
+ * Perform cache lookup and fetch ipv6 source without taking a
+ * reference on the dst.
+ * Must be called with local BH disabled, and within an rcu read side
+ * critical section.
+ *
+ * Return: Pointer to retrieved dst_entry if cache is initialized and
+ * cached dst is valid, NULL otherwise.
+ */
+struct dst_entry *dst_cache_get_ip6_rcu(struct dst_cache *dst_cache,
+					struct in6_addr *saddr);
 #endif
 
 /**
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 9ab4902324e1..52418cfb9b8a 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -25,20 +25,27 @@ struct dst_cache_pcpu {
 	};
 };
 
-static void dst_cache_per_cpu_dst_set(struct dst_cache_pcpu *dst_cache,
-				      struct dst_entry *dst, u32 cookie)
+static void __dst_cache_per_cpu_dst_set(struct dst_cache_pcpu *dst_cache,
+					struct dst_entry *dst, u32 cookie)
 {
 	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
 	dst_release(dst_cache->dst);
-	if (dst)
-		dst_hold(dst);
 
 	dst_cache->cookie = cookie;
 	dst_cache->dst = dst;
 }
 
-static struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
-					       struct dst_cache_pcpu *idst)
+static void dst_cache_per_cpu_dst_set(struct dst_cache_pcpu *dst_cache,
+				      struct dst_entry *dst, u32 cookie)
+{
+	if (dst)
+		dst_hold(dst);
+
+	__dst_cache_per_cpu_dst_set(dst_cache, dst, cookie);
+}
+
+static struct dst_entry *__dst_cache_per_cpu_get(struct dst_cache *dst_cache,
+						 struct dst_cache_pcpu *idst)
 {
 	struct dst_entry *dst;
 
@@ -47,14 +54,10 @@ static struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
 	if (!dst)
 		goto fail;
 
-	/* the cache already hold a dst reference; it can't go away */
-	dst_hold(dst);
-
 	if (unlikely(!time_after(idst->refresh_ts,
 				 READ_ONCE(dst_cache->reset_ts)) ||
 		     (READ_ONCE(dst->obsolete) && !dst->ops->check(dst, idst->cookie)))) {
 		dst_cache_per_cpu_dst_set(idst, NULL, 0);
-		dst_release(dst);
 		goto fail;
 	}
 	return dst;
@@ -64,6 +67,18 @@ static struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
 	return NULL;
 }
 
+static struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
+					       struct dst_cache_pcpu *idst)
+{
+	struct dst_entry *dst;
+
+	dst = __dst_cache_per_cpu_get(dst_cache, idst);
+	if (dst)
+		/* the cache already hold a dst reference; it can't go away */
+		dst_hold(dst);
+	return dst;
+}
+
 struct dst_entry *dst_cache_get(struct dst_cache *dst_cache)
 {
 	struct dst_entry *dst;
@@ -78,6 +93,20 @@ struct dst_entry *dst_cache_get(struct dst_cache *dst_cache)
 }
 EXPORT_SYMBOL_GPL(dst_cache_get);
 
+struct dst_entry *dst_cache_get_rcu(struct dst_cache *dst_cache)
+{
+	struct dst_entry *dst;
+
+	if (!dst_cache->cache)
+		return NULL;
+
+	local_lock_nested_bh(&dst_cache->cache->bh_lock);
+	dst = __dst_cache_per_cpu_get(dst_cache, this_cpu_ptr(dst_cache->cache));
+	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
+	return dst;
+}
+EXPORT_SYMBOL_GPL(dst_cache_get_rcu);
+
 struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr)
 {
 	struct dst_cache_pcpu *idst;
@@ -100,6 +129,28 @@ struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr)
 }
 EXPORT_SYMBOL_GPL(dst_cache_get_ip4);
 
+struct rtable *dst_cache_get_ip4_rcu(struct dst_cache *dst_cache, __be32 *saddr)
+{
+	struct dst_cache_pcpu *idst;
+	struct dst_entry *dst;
+
+	if (!dst_cache->cache)
+		return NULL;
+
+	local_lock_nested_bh(&dst_cache->cache->bh_lock);
+	idst = this_cpu_ptr(dst_cache->cache);
+	dst = __dst_cache_per_cpu_get(dst_cache, idst);
+	if (!dst) {
+		local_unlock_nested_bh(&dst_cache->cache->bh_lock);
+		return NULL;
+	}
+
+	*saddr = idst->in_saddr.s_addr;
+	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
+	return dst_rtable(dst);
+}
+EXPORT_SYMBOL_GPL(dst_cache_get_ip4_rcu);
+
 void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
 		       __be32 saddr)
 {
@@ -116,6 +167,24 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
 }
 EXPORT_SYMBOL_GPL(dst_cache_set_ip4);
 
+void dst_cache_steal_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
+			 __be32 saddr)
+{
+	struct dst_cache_pcpu *idst;
+
+	if (!dst_cache->cache) {
+		dst_release(dst);
+		return;
+	}
+
+	local_lock_nested_bh(&dst_cache->cache->bh_lock);
+	idst = this_cpu_ptr(dst_cache->cache);
+	__dst_cache_per_cpu_dst_set(idst, dst, 0);
+	idst->in_saddr.s_addr = saddr;
+	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
+}
+EXPORT_SYMBOL_GPL(dst_cache_steal_ip4);
+
 #if IS_ENABLED(CONFIG_IPV6)
 void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
 		       const struct in6_addr *saddr)
@@ -135,6 +204,26 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
 }
 EXPORT_SYMBOL_GPL(dst_cache_set_ip6);
 
+void dst_cache_steal_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
+			 const struct in6_addr *saddr)
+{
+	struct dst_cache_pcpu *idst;
+
+	if (!dst_cache->cache) {
+		dst_release(dst);
+		return;
+	}
+
+	local_lock_nested_bh(&dst_cache->cache->bh_lock);
+
+	idst = this_cpu_ptr(dst_cache->cache);
+	__dst_cache_per_cpu_dst_set(idst, dst,
+				    rt6_get_cookie(dst_rt6_info(dst)));
+	idst->in6_saddr = *saddr;
+	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
+}
+EXPORT_SYMBOL_GPL(dst_cache_steal_ip6);
+
 struct dst_entry *dst_cache_get_ip6(struct dst_cache *dst_cache,
 				    struct in6_addr *saddr)
 {
@@ -158,6 +247,30 @@ struct dst_entry *dst_cache_get_ip6(struct dst_cache *dst_cache,
 	return dst;
 }
 EXPORT_SYMBOL_GPL(dst_cache_get_ip6);
+
+struct dst_entry *dst_cache_get_ip6_rcu(struct dst_cache *dst_cache,
+					struct in6_addr *saddr)
+{
+	struct dst_cache_pcpu *idst;
+	struct dst_entry *dst;
+
+	if (!dst_cache->cache)
+		return NULL;
+
+	local_lock_nested_bh(&dst_cache->cache->bh_lock);
+
+	idst = this_cpu_ptr(dst_cache->cache);
+	dst = __dst_cache_per_cpu_get(dst_cache, idst);
+	if (!dst) {
+		local_unlock_nested_bh(&dst_cache->cache->bh_lock);
+		return NULL;
+	}
+
+	*saddr = idst->in6_saddr;
+	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
+	return dst;
+}
+EXPORT_SYMBOL_GPL(dst_cache_get_ip6_rcu);
 #endif
 
 int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp)
-- 
2.51.0


