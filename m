Return-Path: <netdev+bounces-249508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91BD1A511
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD0FE3090840
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179630ACE5;
	Tue, 13 Jan 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HCNW38rY"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-48.consmr.mail.ne1.yahoo.com (sonic304-48.consmr.mail.ne1.yahoo.com [66.163.191.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FDD30AAC2
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321957; cv=none; b=kMVDWYL9CsnMUknO2jz/Kt3YAkoISUvka1J8WTR9T8c6X42knJddO9Pk1ctEycciVE4qRWeCV6/pzyeIiiZ8V5G0llcUqJ5t5SHDmP1SJUNZGbvnV5YXSVDNwb19hE9i1FfQiR/rUU62qQnQXicZYTH2ZAiDHxqRZolE8UKF4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321957; c=relaxed/simple;
	bh=mhG7CrQu7ep05VFtZ9SeYqN/ezpxdhKoE3LTppEdzG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=of1qWjJfMZARMqYa0jkSobzAJ04Qi0YgA+LcVvDgLwaqjwTBrW+nUV/zRwkxqfXVulneeTE41kiMj2DtD0IBfJbo1jVchPsq1fpzAyhDjWwXTf42nD4XjqGzDl0ueO0Rkk9stIQ3gZqfp/XO1aHR+1iwWQqg4B6wsgRc+47AvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HCNW38rY; arc=none smtp.client-ip=66.163.191.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768321954; bh=6ZSkq8IV5deGE/7JN8rVgNXGG87eCkfpKhLb/uXHriI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HCNW38rYrqLs7y4AwqsD5l0AMD9NO3JR3zCzAWBFy9JqmC6X99ntekcBg7uajBQjP/fY3/LF6idtYJhKmKMuzTF4HgbZ51aE8wWdvwbjUH73eNMW72kRGwIFefXR/ujjKNRlo+2CBN3eRemHOsiSJSJhIV5Oc1as6qyRmMBDTuKTrpuynUKb5ZTCLT7hH8d4CvMDqj84Xqnc7begn1wLNQLASAfkHkepEuh9aN0sATMnZp5tyeaTJ3aetXC1oO5sE8BGgSHjf/4aXdu1gQqDZEguyFziGHFK2gtxXo1SiseOKQQVzGAOvV2Afav33ZZcjpSLYH2spzra7en8bT8DVw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768321954; bh=WRcINHS9iN162WFgucVMCHzpmULTbwzSKsKgO808xOZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JiZ02oKDnZdLif2NZpAdFK3jRG2HbpL50620rMn2Yhm+LEPtA76CtjDM8n5x/23Ki2n5qhzTt+nwppsPtNYRQE8/rg/kvbottCJW3zo7qkWGn41RII2aD2YmbaWIoSeqSRT2zvCsAS0VOgG0MovjS5h504cdJbi/9FL7TIqlvaaLlWQ5chQdfjQa8kUECucZ6+KjBQTYq0/Gw0rOeEwIvABMv8OSvsY6NbY0xU1bnVifkmWvt3Rfb7tlPr5T35yb4wtD9toqbewzDwfDBfZYFG2dx6pVBb21NzBwqZ19fg7O9Xdnb2UuR3rwXSlSNyw+CJVBn3bGwRsg5RCwr7K7sQ==
X-YMail-OSG: Cyuz5zgVM1khd8cRn7tFlNFRHv79IrVGSjnmcRbgXtIwa93JRgLsss7FwxvxW1g
 LD36uhmGO1YmoAfUebLfT0ufYzwCh.iC73bk0J.DpBQui0dIYVc8u77dqDhKj4tydEA3.4qT7p8K
 U7MB6Hoi_i1MN8PACPwuZH5WSQAAA4polZH9uphklJuaefkvarcJAQhqbPO20SEjcBpAmPwyG3yS
 1Q5DCZgDOH2diKLcZq9_KAjcv6nnEpPXGCJtk6b8KglxxJl370zk4K27auEGQZngNuxiHiOJQG.7
 udbUoqN20wVZJBQo9MedKz4LQAxyZ1J5UvzrwLPxXkBN29c0jCLFyGiQDNdiOG7xKxiqArxHnWDg
 gwu1kbHx4jtDubfx64FBp4u8QqZ4uVH0jpnv.kmbXcJM_RLZwrfcyh9jVNSyoiSiI3mxp6Hyhswv
 7vnQZERSejPM2e.k4xdRfxVa3uxJxw4tVfS7I5Pss7nfX5KIi3EiNvs_Lai5IDJpdeBQGeMF_XY2
 H.Y9RRuDzu6KBZxOPgri1ERlomocyYUPS4PPDHTtkFm2OzfLgZoLspUPrmKZtrsvYlEP33G_ysMF
 h9TlXMbV5iieD34XyafUsoj4pj9o.XRMK7lOaAi3J9aEVU.9cQLHyN8.NIJ0WMql_Nk4HDu4jusd
 3xn9okIQ2eoRCd4Lfjt6DWB5t8jqNBWaszrPKWjbm3BlZDzY69F16NMaiT1ksXc87pl.ZUB_I_tX
 MW0gon22szab1vo_ju05.VoB1Y.7YilCxx1ta_lQWIa8Lq2e6FCT234p4WHlE3Km96lAPf1U9MQj
 GbJ2hbpZHY2aPk0YDn_fc0kW92nWQmCwhmH8zFMDjdlPSFrkhnLa9_4bhFZJ4QIoMqv_8a8eYnba
 bFiNNGde5ZAB.rtK2BpFPGizzu9dT17D0MwHCRuChFJvwWQ0ScV2FDDs.KnAzcme.c2t9mhCYIbE
 nqaZsr3J0FMjn9tMdGuBvKHzay4WWadvHy6yG9.gsqrhOfxayqeE7q7NIXgYOW.6YFL6z3zT.yxJ
 08LYX3nxPfgHK.4qC.VKnjW_MMNx8R8p9qpC8ctV_RwUG87XBYQfwZKS212X2am9LtdgFBIaZrX5
 VWsRS8grhTIX8r8lqUR3S3wFm6848ULDyEgpmZvH1xaHuNwgihB6.AjtXO6pQKuxQjtJZk0cyJHP
 LwWT7tXNolinKqhb_Qk7oJV.2lHaJaqjXDdvnz47VZIH1ZB5Uyjdyf9Z3zpRHt5Gv3mZNOr0hXlB
 tN6OTR0F1lmM7O_b1G7mHE9Rwed64Zd7GGTTLGwNbjqf5lw5Wxznrau1vjJxU54sg_fEXcHjbrXF
 x0.8.5nr6.ucXBRDqVmdVQQmMhgTl9NhJuCWBoDeUHBkOPQS.Lh2RxYxS35vutDmURUsAF9MuBnC
 SbuPVIwdJ5Q1_AOzksdbhwOE5dSomNYIuf1pxH_oDwnWzd3wZRc0oBl4fZEbV7Yy.j5.xEAmt9aD
 aZVqZdFa7LVxbUx1AJ421k4yU8BJsILiSIhI2bvRlwPt9mXGpowKxiTR5Q70gAavfiO0UN8l1ip7
 xGD5wENpZg2OQs.AriyS_aJrgG2vMeBIGsubbDkBtgQrnhb8O72pfsjVZUZEo4_bKzxsBcw_DlzS
 ZrSwIRR6bp7Dd751e3BmURcfh1Zq38_ICl12GVxBzKWRcoza6HJNy.gJ87sOMV3_i4zI9SeUYCpQ
 RDSa1.oIdaLrPImRZrtJcG7rI.udecRD9KRaTYU832B7PchxMhK0mVWaQJC5.JYtvfrUtDN1SPzi
 0CnJeZlxVHvVi91B8CSi5ssHSJ0F.9yX4rnsR9BybQwc.nLzdrLH6T9Soj8rTy7vgSdUOAJy7mBY
 Q_nzUYqwTppRYNXuHmb7S0hJKTvRq.JwofjryCjwokt3M7JDjFQsiavO5dl1h_wXe9VXxO1PbwY.
 UoqO_iRutk8Oa9XYDBBBwYH4oSPd3e9u42vMeOX400tk9ZSHmRrm4rpz0S5xp5FaIYmB1HzDFxao
 JUilPCDdM3IDF49CL5JYC1BE_svYGiLmK7IBTdZTLqJvdb9eDIyN9mjDLi4V9PLYe9oG3O2u2kHO
 xmvA_oDj6ERXR3rGFTnsEaaBRAmgyZbymVDDGF3RFJcvSP3Pgf09jk3I4b7cWC0vvW42OSZ.juvv
 MCrWTKNI.XeKWOmx559biw4kcZJznoEYJuN9_ZaXYCk9VmL6e8VFYxS0chSfCcqNnKVPlKWYnd7Y
 PxFEM0Ld1f5_4bqF9MA--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 48839d0b-b0c2-4db2-9a0f-3970b4cfc957
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:32:34 +0000
Received: by hermes--production-ir2-6fcf857f6f-7nlzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 11e96f127f9288c2e2174b22f2ee0351;
          Tue, 13 Jan 2026 16:30:31 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 01/11] net: dst_cache: add noref versions for dst_cache
Date: Tue, 13 Jan 2026 17:29:44 +0100
Message-ID: <20260113162954.5948-2-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113162954.5948-1-mmietus97@yahoo.com>
References: <20260113162954.5948-1-mmietus97@yahoo.com>
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


