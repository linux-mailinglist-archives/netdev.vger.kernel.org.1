Return-Path: <netdev+bounces-251552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KITNKw23b2nHMAAAu9opvQ
	(envelope-from <netdev+bounces-251552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:10:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D564850E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9F4466DA19
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BED426D20;
	Tue, 20 Jan 2026 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ThmeiTen"
X-Original-To: netdev@vger.kernel.org
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7903191CA
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926964; cv=none; b=tMpr5Y9E0R32Zxxzdr87x3KLwPq3023YoefhJsqmOKfs95o0jSjQ8/olCvMaUlvJIsP+6UkOB3tgJcchbDabNKrMPT1lMGy/t45Eg3htk1oHBFeZXL3QakamsiUsHceb9HJ/J6bpymkHVZG7KoVcW/x70NbmL10SC98fHdD+lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926964; c=relaxed/simple;
	bh=mhG7CrQu7ep05VFtZ9SeYqN/ezpxdhKoE3LTppEdzG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPFsdM8pDHxDL4ec+Roj9EB1+Mm68X2ddDr3S47yKt95rifwoeA2u902L+eGJZy5DG0aj1v/RtPLhorZPhce72nLUI4COdYVotlz0yZ08Xeo6yLQL7o0D5bm5LLsfsZ2GmbH5bHGDC+k1roOSPly75xIWYr9Iqs2Po5TzakCrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ThmeiTen; arc=none smtp.client-ip=66.163.184.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926961; bh=6ZSkq8IV5deGE/7JN8rVgNXGG87eCkfpKhLb/uXHriI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ThmeiTenogo5LfqjigNBD3mWuwLQTRoBxZPkR6i60RCLo3Hvji2owaU71+IFjlcPDtTI1zQrGJvA+KuAcb5F63/AbjPHCDiyZ3RvQu236uubHVvrSrIpoqGmDw5eZ10+wqm/L1g5bsfyf9i7n5SBTTXSePYlgLDvjJUXZ/mW6syisZXj2cIASwdbdbVZtEgS7eORrc0ftdwpkOngO/vMBuHriptQbgh2hP0UPICCUV1nOyz0ftmrXyzZhwJ0W/TTBtq3xVd5S2nBI2Q6mTEm7KR5ortgypRJz0N19EHElu3GcRgkKiDjs0W6PKGYuHPT2ANbR1F0/pSB4tGQAnD4Pw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926961; bh=N7A3B59ey3SYGKYYFk+qBdD7sxKegXjrLbwAtz+fGrc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=f2Jbnn4OZ09bDbSw1MIM8JP79oAfV8dTc+EJ2MsqkMeryJe2H8N6X0QFmpIs2Vi9kqF81jRxzzkDHBtWwh6dqQO8HFfWwdhieShJ8npzAcDGh70TN8VS8SM8LZaRrmOYKAlMVs2ASBzqxz67mQWHIQSev+f+OvtVipLr3C/79vKuo6GAtbbk/P2UYjZnx2z4IZg3OQ7J9HxGdhZ+HMZWmhwOwb3FOTXGv63hzaGscqPAFEKuo61e697PkR2fdke/iXqv5lAcv06QxFtQInge79wdxVPdC1gCi8KozKmXQ1DcWkJyoOn+4mQlOUgrokVmDM8KIwiaC7VeHVbWIixFGA==
X-YMail-OSG: bCUapH0VM1nItyFtqo6CAcF91uqIR_u5DncqZHJnVMmZFJa5H_VzfGRpB395lW6
 dJEFXg01Meq_GKhqzNaHeVAO1i.Qf6VTJYJd20eVNKhYSOTtDoQOtPcUyI5Xi17cDs0aNonx4Jy.
 xAXQWMiGwdAVuZqW.NL9dsQ1Vtq46YzVf6RFLYPdO6T434gCyepuaSamHDX7NLdYj2tFCp4SJ2pr
 .wzNo_SEjmsJ8n1nDP0g6u5hy9vDl2ZatMuOb5ncEAhj0Zbzj0nRgy8jYa1J7UXQUhoTASHCY3xe
 BDTSwueoMDVW59mfotCCXCZfxdTx3LA.FONWLAnT8P4J5lLYZvZ6DG5yhRQmYhLNeoJ_hSjbseRY
 n4JhbgoEelMWyhQi35XOIGnIjW6PnsIhPwKce3JlyUMW32fZV.Y6AuGPrxiWPmmi2cETM31OoEXM
 YveeB7SfRbf9xWjT0AmecBhfCGmcXC_C5J76O3d8wiAIAr2rNpvgbFL.r8DEsGDLHd_rYZITXNLe
 mHsp7FdKh_OflZ_OLBohGC9nTzXcddwsq5b6dFAGdLbsLf3H8vxN9k6zfPg0XwPYmyJFpNg3ZCp_
 VXXrX6gEnk22U0QOUE_V7Gmv2YFvZzjv2uwdBDfcEpL7JAFeiTUoI7z._N9jiuTJ5gl9jhuICbhO
 QDQ.5Je95U8suOAW6wtAUyRoUcG3_g1hVY19cYoR2u7TSwPgdIv_nJjWJXlWk1pyswcaFMKVfu2P
 pmkPskxZRorGzMGNN65FdCuoQlzeYpl7EMmCIj0gSNDrrHlkzlP45qPM2KTDj_Lj.wcR5P_omKVX
 YxfRCAIH96lqCNrsGs7JCR8faLPchXb2SiWWxv8O9WD_H7ZYNnipLkeXLlaFHg9__XPLkFi.10Ro
 CoQzWkl6ngCMXjARGALQXsoaGDsxxozl61VMuAmDS_ZyTXAw57pzUjN2erHSZNkzA1xeD6I9bUUM
 E9jvev1K.dkRROv2rq3D6IVT6rI2CYff1rCn46bAscYwsHDzN0lYgZZc28s.ebLYrh5.t1NBhrNS
 ebgjhwcCgKOhLrYiZ_UtmJj2Ulf8EY8IsIHt_81UYWph0OTC4ELPJ0ozqWEuFq.3Nx_EdaMHi4GR
 jTAj7ZqlW672ZpRi.i1yIB0eS0NnxjwGUzJptkWzq5oBIELyilBXEri0UGOqwbhl7.NBAQRomq3d
 q6zWpvJ32TwD9ePmt8M5rU30qYRkI0rgnFFMZI6BoWgZ3NkZ22OHfa87OOXN5YHDYNY4GUuIcRy_
 sXulReZXFr.akVLjNTHQxsnOamklKhJ2GnI3SO.8Cfvb65Xv79smZ9HwJRt2xxk4TsRUNmGrP2As
 Iek6jmVA2_MbPA2VsIfkoXr6ZKzzdflqWGcWJbyBv9TkmWPzSt1GSZ1PmBYNFkZK8cK2eyoqpPLw
 hqujEHvVJnO.Q1cK0G7DB6gEpmnYaHk09cE6JeALNnv8Bno9IFJUDL5QPcdxFdg1WOFSI87yHgjr
 vzw04SbvHgYPb7KzraFFts4bAttogFpPTNe1IYM.OcQ1NkzQv5a63tQYAji0ZlMl2j7MRU4ugNu7
 bUG6QlfAmNMKxXqzlCfi7MTvH6VGxRDBKDOgyD1MICCZnwj5ldio_vl_BCuCzaDIk9cmP6k.LYnW
 lM.9hBwiJZeNG2yzSiRzoTrxHjlx6HFGJBPuJDMrIVkvIJy9I5.x.dBjtyRm5ivLvcISoNAYZvOV
 76D9lCno8TotwbrPZkAiFe7nqjRmo8FgglWbV4K.LbYTlGwDGuqeIQ25S9NRW6XmeJZtBWYTP8Op
 IMxC5wahJmG7_RtIYL4YL4.MKmj0I5hC8bRiSOO506ee2zDMZE1JZ1BUTroqgdlg8zx9gGvcTbZU
 SxmOvHjrLip6YxEy.QFztBos5slphCkuzMsiXv4DrMXC.ARK4jj8A35.yEW6pxi8LPQFkfySSMAP
 6pqHZ8oFq8PDKYkxkVG5nwb5Z3jd.x.T8o8eTbPIx_ZELGPk2T1jPwmVkL7FWRdjO9OHkadD4Q3b
 PC49ZjSolkn_JPkhzxmvWgGvCjgOKu.Gt_i9_6b4ozIUcKNDi9mEqwhdMu798XV8Wp95LbYvo1PZ
 2.c1XAwzZv8O6LzEZy54jI1F7BK7iS7lfAA_Sry3Aa4jWb.ca3z.DitTO4q2JR8B.N1sKObXz8KE
 z4spd6UIsuV52eIwXrExp_A41LzOSxw_DCyeK5zDWD6K_pw--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 3593aa8d-1f81-4424-b943-61e9d10cb35a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:36:01 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:25:51 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 01/11] net: dst_cache: add noref versions for dst_cache
Date: Tue, 20 Jan 2026 17:24:41 +0100
Message-ID: <20260120162451.23512-2-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120162451.23512-1-mmietus97@yahoo.com>
References: <20260120162451.23512-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-251552-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[yahoo.com,reject];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 53D564850E
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


