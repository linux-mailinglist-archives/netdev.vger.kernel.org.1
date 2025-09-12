Return-Path: <netdev+bounces-222515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9B1B54B0F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C609C3A46E7
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E442FDC2C;
	Fri, 12 Sep 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m21+TIdO"
X-Original-To: netdev@vger.kernel.org
Received: from sonic303-21.consmr.mail.ne1.yahoo.com (sonic303-21.consmr.mail.ne1.yahoo.com [66.163.188.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169ED2F531B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676906; cv=none; b=DPfM085laBQ45aGZobUzfRpN0C7AmuSo9xBACCtjPwl30lA0+fJVTxxitUfK4q0G1RN/cLi3b5e4zTbVPPo/y+Y5eiSiJ2OKzS2nv0B8M9iK7dmODhVEklprnSfLj5F9ACvSniIKNqDBAkc3oHt9T+15dlm9074y9Vn30mAneKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676906; c=relaxed/simple;
	bh=/D4ZsHmPotH4bpkYrgVoQfL3zC2wBli73f92oQH7skE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuX9R57h74cm5o0EtcP/0HCluMbGhQLsyMo/jvZgIYN416wPNjmx7HmHWpvre33geje6nC3bcYHAmPmTs5FhWkYRNVNSLJAMwFhfIdwpUbP5L+dFmeSzBftaSgUiO5h+A2T3GHCv5KIyLh+sMwXoVTP7H8VxjS9ka6cZUvJOD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=m21+TIdO; arc=none smtp.client-ip=66.163.188.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757676897; bh=kQN6ns9dR4cKsHVgmniWSuQnXl22gTgXJWUVwRX4GN8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=m21+TIdOH9jWQeqYpiB71U7foBUC6uXtilbnBTBJnJyocBSya7T2YDFrfDvQPcpIqXOSyqpW+lYV7NybaApmLGpq4yeuBGV1EzQHuUwxrxb663StLWOIDV3dNZtnw0p+X9qAXcq2IwMakqZL3n99M9iLK6+HfImYmn/btChN887cfNg0Ucj7m1Fc8pAQx2IsH7zAFGGe34DruV6bURSSPDkEvN0kyGH0W4T6zG/GoPTkkIkrXWn8Rol9CTG8G6+yZ2lWr4Da1iNTv+3YWTdJIXOi8W7bkusP1QzU19rFro/+a4hFwh5yxQswZDXRNzsDN1/mfXla5kk/TglaFDid9A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757676897; bh=R/v30VJvyxYL/dYxfEdkT/MNYEZ9ZBrh3wSmYg2hOON=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YkQ401uY3xwOe3b6wNdBM1FqZwSTiVMi1PRgjBnrI4qm31OpWWgz6zR//1HLQIZ+SdgukCrVxjX3bahGuWNFY+D/5CXPPXoFFjlWjTAR15SPwrr0z1HM+AA+ujxaB02t7NmR8CvOm1rIdWB9WtPq5xXkApUUTXXA+iPv7mbNsdfe4EuV4rXM5VlKzvWfIpnejs/iTsnVG2sRHHs6rIcAbEpYo474G+taEfeAx1gUtv30oZc+HWqG1HOW0fIvBhIJt+ceuVxe0aOeR4OnJiFV2d0kMNkG318AmMqjxcG9Qtf1C9wWFxcdQRo5qNDDfaCaQwfGMwyPxaylOTzvXY6Azw==
X-YMail-OSG: nIivqLoVM1lOivMbtDPvpmVJfGn.seRimOY8e4j1gEF5t8ny7vMsefNhWR7kTic
 LGXQv8a8i6bYw3iC06YVurKxglvzWWZquCh4ouBGzlx086GBVnN8XdbybFzVuwYMhZZ.RrpN3som
 HRNGHWhl2VlPDXESXu9YIfavdaBX1DhYZeLAeUrQaBehQ0v4yNU66iV6MDhKPkrGkFZEFmFPvcia
 XaDkCdkPcxxy44znKRDK1whR4usN2b8POSLQWVABPaNIiomf1wdet2aS5V6Si3mnRUcMdqv5mW4Z
 LOHdGDxeLHFsUtWlq7TsTWjX_lNHyAlQ4bvb11TOO8n9k65MIqj4Q.5KOkooJKzhsZZLss.aAgfI
 bTiZY0aGbmytIFqa1KlMN8egoVt8iSL2MYCgI9zuDpv1eX3G6w_DRCk3BteZNgjz18GMYqcbeWUS
 S0Mp6QxyNuDkJdJKnqToIUvpBTsXFeox16pLnVviXhV.GSSzVFOfRHdGxMM50bOQUIbNEoqQZNSy
 dFr.czXFxDXYMfrvTJJGVFQh0IMlA.L_fY0N1b.c1BmOImsUt9sHPqMfIRQ99E7fqyWKMz25Oka5
 su41Jq1VZKy6lZht2WXEasFtUHnSQ5vWCcPr0VvNbkWUJY3kxNfXrEeWyMrn60ckqf2wE54ZtiXX
 0BkLsJ246oU56yp9FrfsJSwJ6glHXwRoFmww9jT86nW2UxqV2A_g1y7t6t.0vyNomOf_S8tczNq9
 b5ZMvMIWk7UtBKyydik0KV3P.B.M5yCTHdmkxJOyuEKYiFFdOa2uDqDsoEZPgh21X5CezpwqAxE9
 8.l7g40BqNxajUnOrJkHxRB.rCATrpBK3iPV_mTA6lAq1hU253rAkya2tHuvs7ddZizauhyXNH1.
 vRSsion8a7RJu9PxRqE7tZ5a3zBXZHfofVm1.FW7LenLr_GJOYL5AMhjkLaElOQuox1TiDo7WAWK
 3Kf_EYObsnq_nWKss8k6l_8udYZXO5dDGlNaBkzHdHg3Rq53mrjSk7nrQf5L2ihrZtuLKd_Sd6ay
 NQdAIueqDxjhuld7lihPHBaf096UQFqZhcXuSxKJZyQ_k7POtgUKXPnK2tFVENuWlfAwtbXOJ.cX
 RDf637coHkJH5BxL4ddrcaq_n6PQp3C5W_O5HhYVElymYU4ZTwgXYri6oiOSPYH81NMcYWKrTSB3
 Wp.Rs0GpN.V9RY5chv71gyrMJeqHaZjSdqmbyYpg7y1GhB2hGnXrovFDGBkllwkWT5M21dazayzB
 WUy93.3BddMhlSFnNsX9wgibjfXUHS0K5CuApR.C1Acsf8..AagdyXqx0sp8YhacmvwIH0VytSR8
 Nu0PZRwS0BWHGNpWFgXuMTVHWv.fET.vNasB3H3fEbc1sG.d1nydKBjzENVQsdUoHJFv2tUtT2vF
 hc7.JIz2MntDy01aSjgXaMAJsRo5br67TDLt9xhblYwxgEBDAL_.E6wwMEt418BvjTHU5IxziC_i
 DjtoR2HKqz_gMIscrfZf5R7bJzD.eiPTtSakkMJvEf4q2tmLkg2to7x7iSgu8W..aGUu9CnsnhEU
 7qRXNZa6AhEqdulEHqSDOAS3v934_L5Yr2a_aKdqGq85cuFFkaVlllsHnh0tMxcVKHbGvzHzUyDJ
 g_hHkuxcxeeuEOWBdoy8KVoKsLe9X1Nhrej2FzjDaVAFg_ZLvzGW9embB8_v8VhdeWM3EC2oRQMH
 iaZ79E1AHbqJzA693IiLcdUGJWNI83_vA86uQhc4ruKNVNpKaZFpAh78Z_F4gJsf8zsl2t1ZtQEL
 VfcaDu2dzhqK2mo9asTjiwnwVpKZm.aBExAOmC7oSPeZQFBEI.dGKz2rmzgS0dj686EcZTgBj4X4
 kQ9TaigjSlbhixqolDyBY4AJnoV6wKgyiTdWqZCl03B_r0a0RA9tVZZjr74N8Vdfv2L_Kst_S8RN
 GBL5bZyFkXwAi6EOqWXlizDAc.VpFuuJEwQcvjj_hwUhdkv5ySoEEa66wrh27EXb39afWYPI0vVV
 vkreolMg5i9I9tt61aFor2N4l2FeX8S4r_6x9P7xnggrzy_QtdAoQsbCB9FmC5OcVO9aZsDL5pza
 gcmpu5ht8n4siBGpBfMXxZhXGqJz3IcL5G8q52_kEUi2q3NyxB2MzObs7rTC4Yj8VREtTVqFQ9cK
 bTGrrC3Cl0PugKox0niQQ8FA5Sg9qsx8p7N1VZ12HOXNjVw--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: c405784a-adb1-4de2-9ec4-31216b83b70e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 12 Sep 2025 11:34:57 +0000
Received: by hermes--production-ir2-7d8c9489f-pnggd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 93cda13a9625b3ea865113cded111022;
          Fri, 12 Sep 2025 11:24:49 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	antonio@openvpn.net,
	kuba@kernel.org
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v2 1/3] net: dst_cache: implement RCU variants for dst_cache helpers
Date: Fri, 12 Sep 2025 13:24:18 +0200
Message-ID: <20250912112420.4394-2-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912112420.4394-1-mmietus97@yahoo.com>
References: <20250912112420.4394-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement RCU variants for existing dst_cache helpers interacting with
dst_entry.

The new helpers avoid referencing the dst_entry, sparing some unnecessary
atomic operations. They should only be used in flows that are already
guaranteed to be inside a RCU read-side critical context.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 include/net/dst_cache.h | 26 ++++++++++++++
 net/core/dst_cache.c    | 78 +++++++++++++++++++++++++++++++++++------
 2 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index 1961699598e2..d3bf616a6e6f 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -32,6 +32,21 @@ struct dst_entry *dst_cache_get(struct dst_cache *dst_cache);
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
@@ -43,6 +58,17 @@ struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr);
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
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 9ab4902324e1..f1e3992d8171 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -25,20 +25,30 @@ struct dst_cache_pcpu {
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
+	if (dst == dst_cache->dst && cookie == dst_cache->cookie)
+		return;
+
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
 
@@ -47,14 +57,10 @@ static struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
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
@@ -64,6 +70,18 @@ static struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
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
@@ -100,6 +118,28 @@ struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr)
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
@@ -116,6 +156,24 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
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
-- 
2.51.0


