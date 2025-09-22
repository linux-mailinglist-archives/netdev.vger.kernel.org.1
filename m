Return-Path: <netdev+bounces-225241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7D9B90590
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1BF189C90C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F82F9DBE;
	Mon, 22 Sep 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hNbBnfE4"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-20.consmr.mail.ne1.yahoo.com (sonic306-20.consmr.mail.ne1.yahoo.com [66.163.189.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A92FFFB4
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540465; cv=none; b=KbZ3RSWwSvO2YcUkDRkdzu4iAyudmX3mpFaJxbn/7kCxUu2RWWIlyjFyaSPU0RtpIIl44XEv/5cTQxSD4Cr3IrzLHRT/lvW4oCK2hAQ03ti2FBs28tTSfYhWzjzrqVOIebV7iI8ZlOr8hrqOhbszrHweDx/cvp8suUehTq2/raw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540465; c=relaxed/simple;
	bh=lylbYjSxdrfB/hzI0gTNADAt6atDuGVNziLIzlpwO9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LitA9mxGnYxrL7orAQ2hlWlIZQjuPZEnyWDTUDt83qrp9nHMvIJ6rXiBatRwUEgOgcGg6/XTwBcDxl53nI0hs4l+7WltTAXJziite0kdV8R27sx6rn0ZKH+aLz4QGGakM4lqNiR90MRzCgoBv5Iiz8cx6mgmYUvnvCdI/5rE+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hNbBnfE4; arc=none smtp.client-ip=66.163.189.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758540463; bh=hM0Deb59IC+cO6gRLu6B7UyScwoIMYSKWqYo/8GeKRU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hNbBnfE467YQNriWaie8nKHiEZpew1nPdihrd6dFCjNAio5uxxuZAzzE35A6fjHVQHYxqxeeRX+4x6Lbg6EDBTAWWbtSLvtXYw+dvv6noYb8rOxRyhl89C+shTRJN5uMt7iQR5JPceN9brHhf/DXbmWmvrO7GVaFOCoqDQT4FIjf1pe8sjZI3Pv+AIaX/RaqFzNFcT+7InIsft3kMWOb7z0h3bhSuMLQ27OtlR/IpLW8Cwr7A4XpL6nKg//3l1a+kA9up8wl78Q3d0R+CYZ3zKnR0rvowMeI3Zc2NxrnGPV4tPdxRpJ6VUuBUi516nHhEcGeu6IoZ2p8hFUALkDfKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758540463; bh=EHhM3ttOSBCuwnndjyDwHI5R08AL1MZ4EFLergOiEpw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=M0jNvhonUJNF9X2GJz9DhTB5om4OI7sZ+AvFpk0lAEnBE9B5uHkK2/LGTQb7vz8aYLG34wAIdolPXzNCbrqydyUammYyC4fuydDzx6RYy9C7DbuX9HBgTXoSNzB0Sfc4HYwaLSIyd1KDEknFKDorDmbWpr08XhbF+8bSrgs/HRw0pYNnGWIEBlI7Ff8lZdxPyTwrUmWm81j5DpgAbEU86ppAND/1pNgtk0pCV78Suzgdw3Nj9NYW7HjW8ALZh/+ScaT72XPtog8HaD/7aBA9NSP8Gl0QBAyZwCbvbw9rV8kiX/JkTy1j2/3Vls31gW+7czEWpxr82UykWdkOHLrYvw==
X-YMail-OSG: m69wDWgVM1nCp7ETJA.lsO9F7znnyHraAHOc5En_hIHveTpwy8BFU69K5QdRO9v
 iLsAsXfCh9YIkCNyUEfixPg4gkYIfABGxIirq.CrdbhOHqPVMP35c8D2vL_Qok.HvQkvtwmF_pnb
 fXflf2bPIljb.Zkml6eLa_WR8rn8yMMH6Uts4WMTJHHPNHY5T3EYnleZAIRO3KQICGWnn777_RPc
 9inBn5XfugmOrMMQZWlZA4E11TFmCYHzwrub6no1PVWYEOJjONdy1a2Yp9WuvZ_2RRkHLzEHEUWO
 KFAQ4yp9iMu0ruPQYKymMb3_HnIPORsrHzUogqwhTvk3Jp8AYjsnGBJ3denygvvsl8yC1YQsGQq3
 3dEzjwdevfi_rJcwpKzY6weALpS3GuPePiuq.HdkipHApB9Ia4liw3ozTVU7YEzhsnBMq39E9gc2
 ri6czUor6Q9vVUnjlP60vAmlWeDjQc4X.6m9bbuvgpUNZPKp50fyq.hBtp27egpmGbakMgv_6PAR
 T1ANJTEipx3CUyGB6kmdFPtPVFml3gymfmByEzZVQ.ddiJULMp.4ObQd3I9rmNybZBdUx1dYhljT
 NuXnkI2_f0957b.mwAgrW7PwYCB0Oj7OaQf.lfbmBbkYpBCxPv3qHB8ZWQ9WfoyvqNJKu6Ungmm.
 t2EifGVuv7xR8LrT_xFrr9L3pHtd0P36e4bVv7Sx8TLfCnAQe7g3J7ajOQKnLI7a6.iBw6E1nP_u
 mgj4m6I70PaSuMGfUTq9ZiRrfAO0NHOQQxfAPOEDcxxqChBgDCEzAoIXLgHTEd035tS0o5eDhyHB
 cWbs19FiCFcibljrduteBvS8s1G3y2oowJk8g7ncHea7EzQAp_tIwmLxD7Mc2MjmyY18esQtAJZV
 gTLKya4ZsacZLk6iTOfD2Ph6DMn9vhDkt5Heh5SxMtuU8gBpmKn19QPXSR8VKnFnAzjztVZHJXFp
 s3eKFlkLG.HpT30DR0XJ7f4Ln29kaJqztwubKrSN3qz3MNKtNuvNP.JvCTs051KnwdRBYnav4Zxg
 w2UlDOSu4W71wuOZxEr.R4CH5tu9mV5ycqR1baUi8PM4bjDKjMn9SAPpo66oqE0IL.V9QrUId.7I
 mC4WJi0CU.bQUVJMJIR.fynDa_bl29n810G61TfDG1G0eXGGXB.3vB7go4aQE92JzWvg.kFyvP_5
 vp4fJEC0LDNDC1UYzmr_kDUnzzUU__.x6u61DfW4aoxQ7jPlLciZTLgF5IigqgRDMv1IEC5mXAO1
 dlZWxtQ6E2GJRHUuF8Qq8w62vl25rvQtl70ZUeI5WouH_Y.qf9AIecQyIyZGaROSALvtpDJ.Hn5N
 iQcVUu4t_4pZo10fTdBIm5XK_PxcLeOv0VoOJyAKmVxsoVik6GuzOqkXDEY6Blq8glGjDWhkBuII
 D7DrHPC2F5tal27hRBYd_84wZtEoYozJBZMyL..6H2ZqJX_K4qt0o36R3dEPUHzqBYW7BW1u0Glc
 8IPbtG8nygZNlF3BPrWhzGlZxMD3pxe1DJQCzQ9Egw8raIlggbANq4lL3p0Jkx9MCJxTR1cc_02j
 gnVYmKU91ImhIET1DHuMaze_i6qdt80rKoKULbt5oj31LooAvoDNVQhhENp5lYG349Cgm0HOaOBr
 ONfiYf1kPk9d6el9UX.jSY2IB3mi5f5W.kOFYDahZvLEuasz2xKdEb8GNQOt38up1XquCjgZYlox
 byJY089bv20_QY161jMk.oAL7u6Od35m62AAD7W8rFM4BT9.sOGT9ekwz.3RdcnrgwlrH9LOKKtm
 h08AjPdMtsXoUv1.qsT8VTVzVKVK2O_JzySuTVrheYuKHv.2lQ0lL2hsbYomJIuIx7dOX2PHO3tJ
 evOs53LFBw.ZKlI6nDOCvmW1BISfXDVbRINiEoIEDs5eKjWernrtwA1_iCrw9wNdX3jn.Qs9Yyfg
 HCd8qsUBVTRFg3FSv8cHW0lunynoeNxJxgMBeCAEfShDx.BtCoNYubSwE4W_yvHOrjNeLtqp23kt
 z6ga_mvDbWra9eQgwvgPz1d8BMr4dab8MzzwNt0G387lCWWlEvJYsvj4u2BUDuaHLZXc7su.aqJE
 5dusDXkg_dli38x0be7gBuWZrCnYfcMlgCMxQsaOuTuKwCvKOfRb2U7.0KDH9eIrgqPDpVwJQ8LU
 xGnSkduVHIjd8E71uxq6s4Mib5W.9Zg.rHyFnkO5844s7lg--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 186ca35c-a907-4a8f-8d36-8f54763c1d8f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Sep 2025 11:27:43 +0000
Received: by hermes--production-ir2-74585cff4f-4sjhz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca5bfbd718d89396be3325d48d68935b;
          Mon, 22 Sep 2025 11:07:06 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	antonio@openvpn.net
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v3 1/3] net: dst_cache: implement RCU variants for dst_cache helpers
Date: Mon, 22 Sep 2025 13:06:20 +0200
Message-ID: <20250922110622.10368-2-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922110622.10368-1-mmietus97@yahoo.com>
References: <20250922110622.10368-1-mmietus97@yahoo.com>
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
 include/net/dst_cache.h |  54 ++++++++++++++++++
 net/core/dst_cache.c    | 119 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 163 insertions(+), 10 deletions(-)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index 1961699598e2..2c98451469ef 100644
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
@@ -56,6 +82,18 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
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
@@ -65,6 +103,22 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
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
index 9ab4902324e1..7d00745ac7d3 100644
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
@@ -100,6 +115,28 @@ struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr)
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
@@ -116,6 +153,24 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
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
@@ -135,6 +190,26 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
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
@@ -158,6 +233,30 @@ struct dst_entry *dst_cache_get_ip6(struct dst_cache *dst_cache,
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


