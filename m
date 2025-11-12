Return-Path: <netdev+bounces-237870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3740DC50FBD
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821973AA397
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5B2DC32B;
	Wed, 12 Nov 2025 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FA3V0NfC"
X-Original-To: netdev@vger.kernel.org
Received: from sonic311-50.consmr.mail.ne1.yahoo.com (sonic311-50.consmr.mail.ne1.yahoo.com [66.163.188.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EAC2D8DC4
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933241; cv=none; b=FfyvjYr+subDlB6hI/MCJ/IntjSixc/Htqpaf8BcmU4sxPKDFiVfLB85ATTiOatjqSBvWsKVbXSD+KSaJpBJZo3npmdNcTgagr+w+yYc1Q1U2HihakIlslvE9RdFdTk2fy2X8n4BSD5dP33KFD/V91xUZssMABtJiMvIETRvHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933241; c=relaxed/simple;
	bh=Rx8pX50o09H0cLJVG1CRLQGeFBVSH/6cg3y0NY8jkbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrplKov67vLmXg8Lg7vSbAc8drMhYdvS4cVV0wT+l5mfY1x1WQpp827exoiQBrJb8NWPUUNdg5RBgG6MalFpgt6zTjQygarlJUMrtVv5oI8q04K34wDVm2+GdvpRUbjU8NjJWNmbYfCJQ6OMlrMrzgcqHKJxB9tM/R7tHudetn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FA3V0NfC; arc=none smtp.client-ip=66.163.188.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933238; bh=/sZea7JRuwpoKAvhfJGAG3YJWd3rWRXa/QQ8IB9e5BA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FA3V0NfC1gVg+qxa/3uMqJhcAdjl3Sb2+VW5VyLhHJGokKjGlVZewgH8zYMdHUusq3LrpMFSZF7QptvfFJ1CpAH1XPH8cIvgsROPFzZr0xhTpXhwqyHE3l5B75d0psMbLjvkQ8UD+rlKEaampXHJ50elVGDhpGspDG3D4X0NbrPRzTY3sXnrI4yxae0BpvKDoTRcdu2OqVRZtBBveJQrP/AcqXKWubcAkMQR/VhCRwQxWjw6gkMIRH9Dz5j6UbdOB+vVTIwjpLG8ixK22CsebMdLdZhhxjhCHM6cN83CiKmTVp/jwJ/YKH80Gwp6nvBxQ1xVHbxvincm23RUgQJGuQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933238; bh=7WH2+Pxp6Nyj8VJBwuOhFA6XVqsuoiLmR61kwVXHAYa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ELLQ8XCjnT+DLsWk3Vi33a6JokvHnAjrArBySWu9mfUjU0HWzrHtfUCR5cdi9/HrEg18TzK4hNAAOXZLBF3k9VECq/I/nuu7rk+o8kCldQPR+l/c5AVSAQh45ggUmJsug+hTi56Bcn/neN3F/el/M6b8+cxpzH59Byxdoxe+EoEN9M1RPgTEtwmMHcIiYj2M326AeR8x9kuPQ+6BrHIaWLzGAKe1wynrsVogV9FGBXK4k317BfUC4IubNbywR074GAcQ53cd/bBVGoWycxQWRgy9b/jCHRwvahnk0eHWgGG4JULWGg/y4fn40Px3Ffhc/RTPOCqAt6iRptHe+AB7ng==
X-YMail-OSG: xXxWdoEVM1keK9ThnJLmON9W6qqKd_9ZgHjDBzJ2DTNdKM5LvCSOdkUJiDYCxPc
 oskwLbfTT8Rq7lROOAQiJgc1N6IUBxUhRqKiaqy8ZMOHWntKz3m24WpOWAkLiN.Im3vujmsuBoe1
 2hi.CqJE79raavNDK.a6zLWkp0eRq.Hc6caGs1C9OM2t7VtZUDm1J3UkXUpUZO3XX3RGWDbtWmDe
 1FvkYyMF0iI5pBu2NIBA_DvPCrP2SSb8EAshXsP5VONWPVfpx5iWe3H05MglVsGjRYWJ1lx2VIKD
 p75dej.MM4KI9oJeVc2IbBR3vr7wrXZuUSezUy.pvZx5JZbIW01RAtm6LeVHoJi1i.Woa8IOBvqE
 3AsAt1jfbZk.khkGv.da5cNWeUb9CNGD0T6_MchQVmLMB_7ltH5GJVyK94HRnhrMcatVxeHA4R2n
 0Vr6afgu0IwFzeGu0oLYjhp081hlpd.1boZsU1nNNgko8IH52c1.SAILz.1TfAJyI7q1QYSZNXLZ
 yuGPqObAo5e1E4ezDi4kaKNp9GJg6GWS933hQJuMxRos2qfQT_sKgXPQLu3MDfeGXmiBGiXFTaL_
 IsuXhumVYjWpfq6kDk6dwfD2miWI0Bu0GLqhwyfXsWyXvTOFpUEAo70ANZwmnuuBpGgJeTTEyy9y
 nbLbr.s3oYyzWMNQWkN3XBRqQQvK9aJdvUmxtpCBehDPJaWjWYL4SDTSmqArPrdKsbr7cdXbtnab
 h2sneYK9B_vpIJa98qWzJFElNo9B95nU1dLbjJ41.T9u0kjM3_dPdyK4L3Yh_y1IFZXNqagcJeSJ
 RukUa0ZMRny9qZE7mxmhmj_KKAr2dnCee42ggUDjth2C8UYc3L0NmAYY7qBTGVC6syk5AGna6NqK
 9aCkIkrrBN6Fa0P1F85XPLxgwfOY7ijXZG0aJ2pjPFTt7qcAQZx27FhSWlihv8aLYWlKQzdCccdz
 tW9JouHbqDXKpyS8Wkm8Nl0dJrhKSP7x6SsUOHSiH8coLcIJOT5iE6eTTQSUwUqtYxrdhtSh60uh
 kq2VgghD6QgEJFO2iiSoU6EvnuIVC7EzMCpyy2n7MucoAAAfuxKwzisdvdi_eYjgJ_KgRSCGt3tT
 5EuE8ksfwLwmiMofZNFuV5284m4kB5815oL76t40l5A7jPPRWFQHoxA1gZLSnkPBJLJXak3..8Es
 om072ItFTtal_lfvBidoQDgQKh5YMdrAAy.SaQaca1BjFzho298MEsuDhQVQYICgujEz8GUk9Zut
 OMIFA.oiROGgIcX.39HJhpm5KZK_A.MmZADsF.TgGxlm2oobK4RcovvThSUzZRes0jsfwzLjs4C.
 wSI3TUaDn79f0eDVJO8QZvomgQp1zEOelsUC0eovajkKWeaBVfCRU1EBQgnNBxnQ.2Y0N1FV5e6Q
 wOHBY_kZD0iNgjz70ofvJttOcucUgQzyPlsd.Ib6FdNLArvGE5.Z5UBNiJ8HS0PFHwGPBX7283vK
 wC1GnG906nOtKDAMt3qrK4TNH..e_KftFgBEADRUXOWorVDfETQf4zA7VRTy_wzloC8WgGdyO7uY
 HK.bV72Cei5eiN4AxoSz1siOeI0s..2RPJFXF8bC1sKmFO2dijbJE9lm_IKEw.gvk4lRhekY0j_P
 sNtFAekIBMseZmXkRTBlkd3gxPZf4igvVffyeP.IC8_Xtn0B6xlSh_SmdVOfdiWNFxpQl1JKeXQO
 0C6JJf3gUS_DIiNdmda_rNlhFYYm88zSYVmk6HjV0C0Ubl1.z2I7r7ldjDlgNnS_chA.wpN4WELm
 kB63bzGezSSZLVCUeZl88pynOtDpQdYBt0zAZn1R303ylXcMlN1FnDxidZu93qmHLL6JGtyuezGU
 XJ.19G3A4BI4zx01PBLyTR_cSAqdhzWKgVPE2t.DlP5UxaXnwIUBm.iiLtnalH9VhF_JGNSagmBN
 9syze1TPNUMyOUF5Ye1ywU.fI7sNCvi4J3zJFmTrxebiW5uDtGSyxh_M2p2fUXy9mvPjDuzjAYv2
 ACnNHr0vP8MFCayf0besafk1_MUqT9fgSjteAD_PC6sXjWXvAD7RaCdR8IfEw7JYfQvt74PlqlhP
 h07ZnfvF8lMRbLr3uJ0OMNBRQPiHqW9Nvco_cMY_XI0Bwyr1QzNbKKEeyIAsBYqngJxIE0tR_h5C
 SE5H7uYSBbCwKpDerz5qNKjuerIN2IimVOBWJrSPINSR0SRZ1WqXFQS50KbeXDombqUsz1D7zXQM
 SW2IThA--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 7d0d6621-7108-4167-91f6-83db589ba9e7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:40:38 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-2cnbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce2e5d13638178c4daec60c4681fbbb6;
          Wed, 12 Nov 2025 07:28:26 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 04/14] net: dst_cache: add noref versions for dst_cache
Date: Wed, 12 Nov 2025 08:27:10 +0100
Message-ID: <20251112072720.5076-5-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112072720.5076-1-mmietus97@yahoo.com>
References: <20251112072720.5076-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement noref variants for existing dst_cache helpers
interacting with dst_entry. This is required for implementing
noref flows, which avoid redundant atomic operations.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 include/net/dst_cache.h |  71 +++++++++++++++++++++
 net/core/dst_cache.c    | 133 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 194 insertions(+), 10 deletions(-)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index 1961699598e2..3ee387a8db45 100644
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
+ * The caller should use dst_cache_get_ip4() if it need to retrieve the
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


