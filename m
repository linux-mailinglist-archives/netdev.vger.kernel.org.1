Return-Path: <netdev+bounces-253723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DAdLktkeGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:07:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD8B9099E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 106F93051480
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCAD32C92B;
	Tue, 27 Jan 2026 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AUCiJNBf"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-10.consmr.mail.ne1.yahoo.com (sonic313-10.consmr.mail.ne1.yahoo.com [66.163.185.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3766266B67
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497598; cv=none; b=An74H8qABdrtKKQwMafs1EY2YAkQT2O/JG7gjr8vDSpZ/6qXaN7MS9cEFK7rjpc7KS6PYsZn0rm4oqsY6k2oqBcpL41OBnBYIgEgIksH56eMFBrx967SRzkLlXOlsmdb8VjvuW8zUyDqeG7lKtVbUYHS0o2RDv8s04I5lUQECPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497598; c=relaxed/simple;
	bh=mhG7CrQu7ep05VFtZ9SeYqN/ezpxdhKoE3LTppEdzG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyDZT6Goq0JYA5BdCp5TAiqP4bCvhHekz1gUu+cGFJ201IfcL5cnsCWb8ox2xAG9Hpo/JxMLpp0zFR0gFZCSV6ngj2F3Yevxwd1a2ktHquwbLhSRIcOL93sbyaAYOTm15GKrv5Wfnys1KQMt/9OTcvQ3AxUKfO6lqLpsMQnGSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AUCiJNBf; arc=none smtp.client-ip=66.163.185.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497595; bh=6ZSkq8IV5deGE/7JN8rVgNXGG87eCkfpKhLb/uXHriI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AUCiJNBfysMkUxm0W2IpFIfCMPX7EMNc4L7TLaesYiEG1JeQeb9TFbKQmlbs6plqtPube0++CURCLBLM3PnblpLnVhIrB5Qz7306SKVEOU8F/myxJWxLSKzQVfYsUFGmYN3eTJNchy2F9jDe3tSIQnJoVSN0+3mutzX8eqTqOqCbk29Sa/DIOrPUxcJWpWzVbPGtP6mr0xQHUcO7+osaOtpW4ZKFgDzmPN3fwwpKuPFsKWJ9CpT8xIGT/Ai9W6aAd+nWgYFVCgzVg1DAeHedkR/h5FSEX1d27aTR0lvuJ+jC7nyJNv7zCeEbdunG9qUHFwJHCXBLPDIKZd029S8ykA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497595; bh=T13o1X5sc3wcsTbzKBiLt5oklAyUYt4Dr/5h7fbDq4K=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=U/vMkRadpinTcj+KYBoFhT3jaTorWyO5HFvlkcIZowegFrNQqG5x2usf7gNqx0ItSvAsXW1WeUMksny+q0K6rKgiumCtvfXROIeaiAYBKJviyych+SBzA9oMR/jIkq01FogQ+QP1MUWqUu8x8wEAXVkAJl1wkttD/3D+qBwWw11GmjNOKoZPcL5tBhrdxLe1Y34PQffZ7hbodT7Z/93AOpHel4caMypYkN/DoA832KXBr8o/KRQa13Puxx2/YqY3/dPR26kXHRNTEv1QIgsbJFcVEuK66mIPoJwzxUnfKEKMC677qT3P3qSgPr0eI21lCK0Dp/MU5u1vgSYrtBDsZA==
X-YMail-OSG: 5ckDFmcVM1nmgUYDaNjMK1DWoHcLk1TnNRJhqaQKo65TDF4.SAL8NyEEIuTt205
 XOd3FFbtQizbLfQuYWnXLoRv2b.OQJE_KrOHKXTdJK9EahskUpYfWRKkVL2qhlpaG8lqWp.WoSsg
 qqcV5Jdgs.tEx97ubI0io0UvbpmBv3KGpoO.ubnT8oLGLAkWc38P_AsHw8OMQHHLRquyuXhuYWmT
 Ctp1efDKbNKVY822SNY9s6ouEjQNJouotwG1CIPXsUEnP8ltMHhYi8tBXP1zxPRWyVp8z6lcgSJm
 n.telsWsn7IhNfH6H.JqNPk9FjdsL8F4xe7vQviYCeYRFuzi1BHyEbKyPupjh6l_IKwGm8PvSnsb
 gEa7gEDDtCrv8fOY9C.blVwZFAmPcVHtT77DgaICXXEvTaELfBFpuuU.ueGQ5n.KUtfXJPvqf9tf
 99BexTxyjQBGk4ixNC1aEDMddC199lO4JhDsGknskwUUAKR55OZuxoE93St3UJMNKwvn1mCt.GYu
 x9pNJd.tzdx1tb8neAdB8lKGjrv5I4BprkGgEykSDyi7ux28T_sgyR3fnWGwJv4iT03Va0I4MaU7
 OXZmoEbVOcpEl5LFa73IrMqorR5KoDiBYwRkYtaWUy1PPlvC5dNQr6YBASQ18LU2bwQwA8n8O3xS
 MXujvTpK5N6WrMHNYG.yUexx6rIEKKftAzpeUHtfnRkUmRDuzBu6bIF0Y7cleM25nwemANTiseNp
 F8Qc3BjhFoZunx1_K1Y3TaKgoi9_DdWv7DEz2lexfdOnLhYyYXiPQryjf3lNc1i4ab2K9XaJs.ph
 MfM5FuNCMCq42rOpJozVrpW0ldmn1Mgoxn8.xnDsiguf4UghDrFkpUyIL7Zfd_plTSt8XDoDBb3S
 loferawPLHgvOb1rcitsD.bNbMLR2gKxFCgzhrscmbjSIWCcYtBuyxpyJ4wiEfp18Ijq9tf6kklz
 CB6Kz7BnN4SgH2jvkSy7bQhJQRbdhoCB1MVzeu2aDrXdydkxrpNgOxv7Jo2XBUbrDLr55UQ_fKzq
 neH9H_faWVmwh0FkuouINglmW3RTsl0p2Pl4SyqmhbFalAIGpkiKG_wGcaBWP0mFkrQT7Wz0kch5
 8yUpTcNIaU4hmzdT.rCL34JCklNRwzOUQppgYrLYAri2GxhOxbnCuuCReMGukqyOUl5uto2t71_F
 7.4ptfadVVSa1W7LeBCnXWdDDbT0LGGn_LhuQ._mmNENNPTb.ESIHdQvkGZPcIA8LRVXv5mNlUtM
 uSCcKRK3wpQ.V01MSDB8mRYtBinZtQq3EkIyD6eK3jD.iCu8.txpYEv5rHvv1goLunEo8ZATyg3k
 Ywoln2S6gdNQz45cN7_mm2py_LaJFk_Z0b0i4k3t9h9AWlLXvjGSH0j03pCmeS7lv0V8WfiI4aK3
 Q.gKyWr7vmhUlHeVgacfAIVOFjwML1v_wiYBfepMpsHwWJ_KkCRp6YghjF35B0ua8fPpsF5tGG5o
 BqrufJnvTzuMfHo4Ehjcd_NXTTLh1xj1HQp85ZqBXs3VA.ShdtoBVqe3LNbqUO.FNxVUlv2V4VZF
 pwWFyjh4GabwgMNF4ZiYACkq4XkzljxV7U7yxPLWIecNbrI.n6WhtTrBlniJtPv5LLADW7JYhukl
 lyxFeU6DS1wbHcYlTgBOJNjlOUezWs_..Jy8vfxPnAQxr8FkF3Chtrc8KbmZRDx586x.h2c0lOnI
 VX1ARIhuLyEEX4SvQXF8l1Ya_rJtQ_6Ooyt3GbmDIjk30Jsl_AylWVVcgBllKjvkqlUXf6uNDcx7
 fJk8WvtxO9JwkMAti4NjsdBh5mWsds8XvARZg6m2nIzbPgiMZJFtqVk.qS65ylMy5vK.OXpAfq0f
 1xkO3f9iXX5HNIVrIG9IX7LIkZlo7F_rkHJFDgkH3fi3GAJ86VutduOecFbHb4eCiFxVswvf4d_v
 .4g.YqN66IV6TW2Cx9hZGuSNlVotQKxiK1gteBMfTW844tsD6OYMf.PZt861y93uFUnsWvZ8YHhc
 GVVEWAFgqepleXkSDpQENuo6zZZTNRmQhWfQz2M7a3rhS7e3OUKhb6M9TEtQTQ3P7a82VSWBiNE.
 Cao5m8UoAG64w8J7W5QUMI3FzzXhGVRhMYNUHZf1by2USwl_Kgq04oCfZba84JTIsZyYZYqJMqYV
 UZGTxjwRaipAMu.1yV7wQt5Nc1F8xfaXgGHO6Fw--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 5fa90074-ded1-4410-8784-8513f3e17d13
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:06:35 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:06:16 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 01/11] net: dst_cache: add noref versions for dst_cache
Date: Tue, 27 Jan 2026 08:04:42 +0100
Message-ID: <20260127070452.6581-2-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127070452.6581-1-mmietus97@yahoo.com>
References: <20260127070452.6581-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-253723-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CD8B9099E
X-Rspamd-Action: no action

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


