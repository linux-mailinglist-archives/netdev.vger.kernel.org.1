Return-Path: <netdev+bounces-221075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FF7B4A233
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 08:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECC1177099
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 06:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D853019CE;
	Tue,  9 Sep 2025 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="irRX7J4K"
X-Original-To: netdev@vger.kernel.org
Received: from sonic303-47.consmr.mail.ne1.yahoo.com (sonic303-47.consmr.mail.ne1.yahoo.com [66.163.188.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15682FFDEC
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399195; cv=none; b=ABzG/IxKq6gIcGFO41Ff3FFHle5/sgmESvJSDn0PoEb4Num5j9xywZXSQXv25YnyqoNcf6KI2Oe8vC4tfPjxi+1GpVGWajd5xZi4C1Sq1TbnT92qbosrVRTx9ZgiqRJ/4cwXXBNJauzR3NWsJuy/azvyxxOKkn6iBVKQhMQ+T3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399195; c=relaxed/simple;
	bh=BCrI98Al6V2cDpjg7srxnjtqmIHUr7yeTPPXCOtUi8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBQTSIAPs0ab8s4XsiTEYiyfSCUrCKd47b4ivkSLi9I3e9u+ENpPqs1rXQUluqcm+S0pPKKZFOziWrtzXBbGB2bFS/liYDuWEX33OneclonTJeT4p4+xQQC7Fcny3apf0n69VlkC1wGWSM1/mc7pcj5wvR1t0sx0RCOefvmIjKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=irRX7J4K; arc=none smtp.client-ip=66.163.188.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757399192; bh=Hh5AiVRRSIVLYHx6HYBkWSOaq+Uu8yBYs+KbtiesYKE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=irRX7J4KVp7/2BmLwBNtKH9WBOJw2G5X0u0gJx7wQ5g281aWyLAlLvOo905DbO/DkooODb+yXWtclhD34FnAm1bUXy0KHDnsXlV2yn/MQ4pN7VTe4+2q2OXUgMKQVmaVTHiUeq7wBTgEZotoF0dPq/N4G8++G1XX4ziwNdEYV1M2vEc98QLS2+n1jmMRCaJrgTpCV4WozN5FcGIEWaJ/smoviSJ0fgGKMyQGzkmaapGT089WTmiWUTM1/Cl1aShcEF3sxojVIRYcbsm3TZceHMyczDt3XnRuXYqCxkA25cgr2Qq3MLObpbfADvIMp7tvDNp0hay0yjOVFh3wzSb+2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757399192; bh=NOF91vvXCQf8kZV3ptxCEzUDtqoZMCZMzBPdkRUMTFq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RkokZVuado5HMx9oO9f1Si4GyLSXU1pPavvc/KmjLLgbzvp2v/ey8jNIffH4k8aMq5Y9t6h6V01LO8L2YvRhx91s3CzeDhUgAM6lAUEX3kyaGtDha1qHLHyr7+zE2jvnEE4ST1iaF84rlDWhCeQeBV0U+nWz9pR37TR6J6JuP7OCvEOav8hFw6CUwKnMPi4IASfejI2dxJbeJga4BxldJmflYtfu+lhyPqpQTzvYGI25+5mNC8nbtPjqs9SXnTBcOuU7WPBwnj7upftOiBx+U8PosuBQi62M9YysmwPPjkaCZj7ypIqhL1PwARduRaf4EZC+XTyojViS23qrv60dMw==
X-YMail-OSG: EGG58r8VM1li7aQMej_RUIYy77GGBC_90ZdcAMVXMtajbytXwoiCxzxv53LH.Ve
 917_QksSAvEHGdxvkGFfRHLTGFcMgf52Vwk.mlpCpTCAqPMjv3R2Fq2oXRuYSA5oZkbV5DRPN_EV
 njn88PoCtAetiuSxwFy7f7zziVj28aB0USk.CF0gnrRjoBtXv1okg7EWmOgFUl.jnkO6.QK99Qj9
 DvrTOyrZee9dPbm3jZde4vqQobiAoQtLA2QVhvPdkc23_ivlNfE8dCdJrhR9NoAtECi1r_LXD99Q
 .Fe5YCX61DNLO62mf6r_hxUvp94vOD58lBEXfvyo.HsYeFczOUV8Gk74eQOGdK8WgONIHOuncIrN
 gtvy1I.Pw4yA_WTrWy6H6SdSQLMKNrH6qHLMUVWRgLdOs01G8EpFjk3TnrcoaBhPuFAT3HfVsduC
 lI_m5y1RO17RqRJ3kAHmVZK6vWizu7MNAUV6VU.HQAH83Y4vii8EVR1g5vODoLeeAwm7sL_o_ZdN
 OYDm7NquxIuQ3Nh.JHeL.NwIZJ34sVUQpesTJd9e78Be1Qr_4QK5KuBlnGJMfP4L.AfhfGRvtBOa
 2ySBo_R5tT3OLV8rCntb7nf.Yq2qtYJWmtFwMv5Fv.H5oj0VoLtWumSJHVdMH8RvjlbDKtFRR9yu
 w1EVMwTGAt8XpOwPAoAmiP3FTbkkDZgsbYum1vGJkjL.zCgz0dPh1c5smCHM78Jdxi9iCVG2JZIY
 Yg2PKnl6XMjo6PBB3vxoh1Rc2C5XEbaHuX10weZ9nhETLa_UtNK4Z6WC6n8YOK7uedWTsgfwatt6
 8Cxhf1M3Pn2FFjOdVrQSlShaAAspPsLB6H5HmtXLP118ivasq0zQsVQ72W63.uZCIY_uVAODVuiO
 U_ndynVT1.kn38s2smONfXzIG6g1U_CTWqX4XG2m2pB0iCqlse9ak.JDsqsbZls3rz9_2PNlthsI
 p6O8OWQy9sQJgRv4GSyKiQ0tUjYQfBLLN2yWRntAeG.Khw0riq8eQQD3UcuJPOXZC8QCTw04ura9
 SUwQwbmDgMfCbC4xD56ddWtZ0dsaoY2O_t3Q2sU3XcpPZdhqvLNDy6E.hxgMCst7tWuSJ0DLjNGp
 noHPOAPiqzYHgIUNhuFX6ChEOArt5kcj19KZVoBD7qrcdf706LTalUgz1GMipVZts3eXWAeKBkW7
 buc8xWAV_twV.WS80wlNyH0cajfPyy.eQLwjv78jDvcS0gpce5VEy5JppdGoCITumrP4Ll9ezjML
 iutiGSOLTpmsJPffuARcbPRPXQB98zdLi1Wl7izdQfczKKIavfGNTs8W7VBpclPUoFFQOq7Vr..I
 8KZ4B2GeJa_zAxGpAvOHWaCX0.ROfRR23WSfiwXbsO8rFYB8ltNKSdw28QCHJlXZtKl7a4iHgiSJ
 7bEMacg5lQnu5rh87v7aL5bcWFQ8a0LrFM.Q4MW4_dg6nc0KScRbE5v7Jb8.Er8dHJsHBQv9wuxH
 bUMQUHmiG4WCo2vXQVAWiOuBgebeebTReBl8HDchqa4m13y_Z7ht9LtKB7_dAYacV_XrGoZBfWIO
 BQ2YJQwRdamyOXpWEAB5usVtXdoFtc9XGzp1X4ffV3dbQvt0AMKa1hpR46gZOaqjzxrezxZa4AhC
 sTDkEh51r1xWrG2RljACPpf2UK1Mhe5BSk_dbP.qWDkA5e3NxZiWYo1_2X3ZMA.LmoNbArfVzohR
 GxFxYZrygSqpvIIlAobkwVOT65ltvUPDHKee7YliWGIQesDSbf_olwPi4N5lA5Em_lLT0ksU9yQW
 BaXCUX7gfgDKfnEAGEMmEVAVvR7M4e1Jh835xpgIEj3IS4j7RRj.9pGcM1Y_JAJS3Z_wgcWkDyzm
 e0DiMvYep22ZNWWWxKxYrIA8VxDvP6mho0dy.nH8n8prKitT5ovIUx2g0GZeJyzcQW99LSkAhNYP
 .obE9Eqv71_Zo.wtagIuXLdWji7WIQmVmW6ZOqOQmcJwH6Q7bYrPNpYzIV5.cT1T63PiU_Z88mwE
 yueIGSTouAX654o6tg309X7.pZLToUAF.M3ktbGXPJD2Q9nRQmb0JZFqei74EQuj8jFivfDiODtp
 VQ1MMph6XN_dLSET3h5DC.jlx8F6J30.tQe_E5Tu5efZHu0nbxkSQKesitzvwYRAVuPBsQbvq46p
 2too.qWX9tzJ0mUbHsyeJis7rB.8jK0mZY2tG4ursRNpxhD1Yj_gI2IHiffzaHffcnko24.6Ji_p
 fHioFf52KBDh76x_wGGEsHaqTAJdRjQ--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 0bad9165-9f6c-4e0a-a3c3-20481bca6e45
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Sep 2025 06:26:32 +0000
Received: by hermes--production-ir2-7d8c9489f-9tl65 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 06aa482699b918a59f317ba4e6d13960;
          Tue, 09 Sep 2025 05:43:56 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	antonio@openvpn.net
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next 1/3] net: dst_cache: implement RCU variants for dst_cache helpers
Date: Tue,  9 Sep 2025 07:43:31 +0200
Message-ID: <20250909054333.12572-2-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909054333.12572-1-mmietus97@yahoo.com>
References: <20250909054333.12572-1-mmietus97@yahoo.com>
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
 include/net/dst_cache.h | 22 ++++++++++++
 net/core/dst_cache.c    | 78 +++++++++++++++++++++++++++++++++++------
 2 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index 1961699598e2..e94f6c15bed9 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -32,6 +32,17 @@ struct dst_entry *dst_cache_get(struct dst_cache *dst_cache);
  */
 struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr);
 
+/**
+ *	dst_cache_get_ip4_rcu - perform cache lookup and fetch ipv4 source
+ *	address without taking a reference on the dst
+ *	@dst_cache: the cache
+ *	@saddr: return value for the retrieved source address
+ *
+ *	Must be called with local BH disabled, and within an rcu read side
+ *	critical section
+ */
+struct rtable *dst_cache_get_ip4_rcu(struct dst_cache *dst_cache, __be32 *saddr);
+
 /**
  *	dst_cache_set_ip4 - store the ipv4 dst into the cache
  *	@dst_cache: the cache
@@ -43,6 +54,17 @@ struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr);
 void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
 		       __be32 saddr);
 
+/**
+ *	dst_cache_steal_ip4 - store the ipv4 dst into the cache and steal its
+ *	reference
+ *	@dst_cache: the cache
+ *	@dst: the entry to be cached whose reference will be stolen
+ *	@saddr: the source address to be stored inside the cache
+ *
+ *	local BH must be disabled
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


