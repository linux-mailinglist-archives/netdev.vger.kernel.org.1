Return-Path: <netdev+bounces-214252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F55B28A31
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3021D00207
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706B1C5496;
	Sat, 16 Aug 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWxeg+D5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EC91922FA
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314110; cv=none; b=rCx3BjGD0yLYosGXT2Bpy+AApezjoGswzcE5Sj0mJjaYh0jEpGbGQ8Ph4qOqKT4rK/LD2QpdoHojrEwmr1tUPwAxvyH3ZtTI7mVv55OgW+izYBBP2HcD5gQglG1KKxTePHYpz/pwzqWPi2w4p0z7ZHkjhiWS0HhtLFCDpHTJOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314110; c=relaxed/simple;
	bh=awV4nnsaiF5bdpInrhPcD1YDb0lAF7LUGc2rc6u3Im0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDHXbd4/OjWZiqvF2N5UgzDRLyswAIpLz72kiD5uQXHfYHnJFIYYVBp3RHNlIvfcXD+2pIyjAJY/dZtUW54oNeVDeraDbPgj7Eoi5brVh82WiW2DLOSwz2XRb8kNXdEBKxRhp5UkFNOuvpNJSFJfnbWEpMGckzj9/kfhtXqg1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWxeg+D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D863C4CEF7;
	Sat, 16 Aug 2025 03:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314110;
	bh=awV4nnsaiF5bdpInrhPcD1YDb0lAF7LUGc2rc6u3Im0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWxeg+D5PzBVxsV5FHD9qNttt2I8Fxsk68zdZe2SmvyUlN5rQYLODnxnh13L0a03j
	 IPOOuRD6GvPov8L5ZOri739g68KaicnlS42NMeY10weGyCRlCjN/+SM4lSdELmz4ZF
	 /q+imVxs1OSyCrwoXQI9wpCC1EEEwhM5p4qe8LfKgPMsDme/oCCCrjxTIrZeT94nkp
	 yzwuYXU7TUc35CjI9fqKCjADOQUmlEaLlEy7jb5gsB2SxJAEEf1iB8ZEz0rnBO60bG
	 s18S3o3ekn7+zsMsrjzYYOf2NQrDzB93mnjKQh8tCGHrG886ydXEz2xGsnY+CtxRkF
	 9B8JxJnTaN8Ig==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org,
	Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: David Lebrun <dlebrun@google.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next 2/3] ipv6: sr: Use HMAC-SHA1 and HMAC-SHA256 library functions
Date: Fri, 15 Aug 2025 20:11:35 -0700
Message-ID: <20250816031136.482400-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816031136.482400-1-ebiggers@kernel.org>
References: <20250816031136.482400-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the HMAC-SHA1 and HMAC-SHA256 library functions instead of
crypto_shash.  This is simpler and faster.  Pre-allocating per-CPU hash
transformation objects and descriptors is no longer needed, and a
microbenchmark on x86_64 shows seg6_hmac_compute() (with HMAC-SHA256)
dropping from ~2494 cycles to ~1978 cycles, a 20% improvement.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/net/seg6_hmac.h |  12 ---
 net/ipv6/Kconfig        |   7 +-
 net/ipv6/seg6.c         |   7 --
 net/ipv6/seg6_hmac.c    | 200 +++++-----------------------------------
 4 files changed, 24 insertions(+), 202 deletions(-)

diff --git a/include/net/seg6_hmac.h b/include/net/seg6_hmac.h
index 24f733b3e3fe9..3fe4123dbbf0a 100644
--- a/include/net/seg6_hmac.h
+++ b/include/net/seg6_hmac.h
@@ -17,11 +17,10 @@
 #include <linux/route.h>
 #include <net/seg6.h>
 #include <linux/seg6_hmac.h>
 #include <linux/rhashtable-types.h>
 
-#define SEG6_HMAC_MAX_DIGESTSIZE	160
 #define SEG6_HMAC_RING_SIZE		256
 
 struct seg6_hmac_info {
 	struct rhash_head node;
 	struct rcu_head rcu;
@@ -30,17 +29,10 @@ struct seg6_hmac_info {
 	char secret[SEG6_HMAC_SECRET_LEN];
 	u8 slen;
 	u8 alg_id;
 };
 
-struct seg6_hmac_algo {
-	u8 alg_id;
-	char name[64];
-	struct crypto_shash * __percpu *tfms;
-	struct shash_desc * __percpu *shashs;
-};
-
 extern int seg6_hmac_compute(struct seg6_hmac_info *hinfo,
 			     struct ipv6_sr_hdr *hdr, struct in6_addr *saddr,
 			     u8 *output);
 extern struct seg6_hmac_info *seg6_hmac_info_lookup(struct net *net, u32 key);
 extern int seg6_hmac_info_add(struct net *net, u32 key,
@@ -48,17 +40,13 @@ extern int seg6_hmac_info_add(struct net *net, u32 key,
 extern int seg6_hmac_info_del(struct net *net, u32 key);
 extern int seg6_push_hmac(struct net *net, struct in6_addr *saddr,
 			  struct ipv6_sr_hdr *srh);
 extern bool seg6_hmac_validate_skb(struct sk_buff *skb);
 #ifdef CONFIG_IPV6_SEG6_HMAC
-extern int seg6_hmac_init(void);
-extern void seg6_hmac_exit(void);
 extern int seg6_hmac_net_init(struct net *net);
 extern void seg6_hmac_net_exit(struct net *net);
 #else
-static inline int seg6_hmac_init(void) { return 0; }
-static inline void seg6_hmac_exit(void) {}
 static inline int seg6_hmac_net_init(struct net *net) { return 0; }
 static inline void seg6_hmac_net_exit(struct net *net) {}
 #endif
 
 #endif
diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 1c9c686d9522f..b8f9a8c0302ee 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -302,14 +302,13 @@ config IPV6_SEG6_LWTUNNEL
 	  If unsure, say N.
 
 config IPV6_SEG6_HMAC
 	bool "IPv6: Segment Routing HMAC support"
 	depends on IPV6
-	select CRYPTO
-	select CRYPTO_HMAC
-	select CRYPTO_SHA1
-	select CRYPTO_SHA256
+	select CRYPTO_LIB_SHA1
+	select CRYPTO_LIB_SHA256
+	select CRYPTO_LIB_UTILS
 	help
 	  Support for HMAC signature generation and verification
 	  of SR-enabled packets.
 
 	  If unsure, say N.
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 180da19c148c1..a5c4c629b788c 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -520,20 +520,14 @@ int __init seg6_init(void)
 
 	err = seg6_local_init();
 	if (err)
 		goto out_unregister_iptun;
 
-	err = seg6_hmac_init();
-	if (err)
-		goto out_unregister_seg6;
-
 	pr_info("Segment Routing with IPv6\n");
 
 out:
 	return err;
-out_unregister_seg6:
-	seg6_local_exit();
 out_unregister_iptun:
 	seg6_iptunnel_exit();
 out_unregister_genl:
 	genl_unregister_family(&seg6_genl_family);
 out_unregister_pernet:
@@ -541,11 +535,10 @@ int __init seg6_init(void)
 	goto out;
 }
 
 void seg6_exit(void)
 {
-	seg6_hmac_exit();
 	seg6_local_exit();
 	seg6_iptunnel_exit();
 	genl_unregister_family(&seg6_genl_family);
 	unregister_pernet_subsys(&ip6_segments_ops);
 }
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 5dae892bbc73b..816aef69e0cea 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -14,11 +14,10 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/in6.h>
 #include <linux/icmpv6.h>
 #include <linux/mroute6.h>
-#include <linux/slab.h>
 #include <linux/rhashtable.h>
 
 #include <linux/netfilter.h>
 #include <linux/netfilter_ipv6.h>
 
@@ -32,11 +31,12 @@
 #include <net/ndisc.h>
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
 #include <net/xfrm.h>
 
-#include <crypto/hash.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
 #include <crypto/utils.h>
 #include <net/seg6.h>
 #include <net/genetlink.h>
 #include <net/seg6_hmac.h>
 #include <linux/random.h>
@@ -76,21 +76,10 @@ static const struct rhashtable_params rht_params = {
 	.key_len		= sizeof(u32),
 	.automatic_shrinking	= true,
 	.obj_cmpfn		= seg6_hmac_cmpfn,
 };
 
-static struct seg6_hmac_algo hmac_algos[] = {
-	{
-		.alg_id = SEG6_HMAC_ALGO_SHA1,
-		.name = "hmac(sha1)",
-	},
-	{
-		.alg_id = SEG6_HMAC_ALGO_SHA256,
-		.name = "hmac(sha256)",
-	},
-};
-
 static struct sr6_tlv_hmac *seg6_get_tlv_hmac(struct ipv6_sr_hdr *srh)
 {
 	struct sr6_tlv_hmac *tlv;
 
 	if (srh->hdrlen < (srh->first_segment + 1) * 2 + 5)
@@ -106,79 +95,17 @@ static struct sr6_tlv_hmac *seg6_get_tlv_hmac(struct ipv6_sr_hdr *srh)
 		return NULL;
 
 	return tlv;
 }
 
-static struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
-{
-	struct seg6_hmac_algo *algo;
-	int i, alg_count;
-
-	alg_count = ARRAY_SIZE(hmac_algos);
-	for (i = 0; i < alg_count; i++) {
-		algo = &hmac_algos[i];
-		if (algo->alg_id == alg_id)
-			return algo;
-	}
-
-	return NULL;
-}
-
-static int __do_hmac(struct seg6_hmac_info *hinfo, const char *text, u8 psize,
-		     u8 *output, int outlen)
-{
-	struct seg6_hmac_algo *algo;
-	struct crypto_shash *tfm;
-	struct shash_desc *shash;
-	int ret, dgsize;
-
-	algo = __hmac_get_algo(hinfo->alg_id);
-	if (!algo)
-		return -ENOENT;
-
-	tfm = *this_cpu_ptr(algo->tfms);
-
-	dgsize = crypto_shash_digestsize(tfm);
-	if (dgsize > outlen) {
-		pr_debug("sr-ipv6: __do_hmac: digest size too big (%d / %d)\n",
-			 dgsize, outlen);
-		return -ENOMEM;
-	}
-
-	ret = crypto_shash_setkey(tfm, hinfo->secret, hinfo->slen);
-	if (ret < 0) {
-		pr_debug("sr-ipv6: crypto_shash_setkey failed: err %d\n", ret);
-		goto failed;
-	}
-
-	shash = *this_cpu_ptr(algo->shashs);
-	shash->tfm = tfm;
-
-	ret = crypto_shash_digest(shash, text, psize, output);
-	if (ret < 0) {
-		pr_debug("sr-ipv6: crypto_shash_digest failed: err %d\n", ret);
-		goto failed;
-	}
-
-	return dgsize;
-
-failed:
-	return ret;
-}
-
 int seg6_hmac_compute(struct seg6_hmac_info *hinfo, struct ipv6_sr_hdr *hdr,
 		      struct in6_addr *saddr, u8 *output)
 {
 	__be32 hmackeyid = cpu_to_be32(hinfo->hmackeyid);
-	u8 tmp_out[SEG6_HMAC_MAX_DIGESTSIZE];
-	int plen, i, dgsize, wrsize;
+	int plen, i, ret = 0;
 	char *ring, *off;
 
-	/* a 160-byte buffer for digest output allows to store highest known
-	 * hash function (RadioGatun) with up to 1216 bits
-	 */
-
 	/* saddr(16) + first_seg(1) + flags(1) + keyid(4) + seglist(16n) */
 	plen = 16 + 1 + 1 + 4 + (hdr->first_segment + 1) * 16;
 
 	/* this limit allows for 14 segments */
 	if (plen >= SEG6_HMAC_RING_SIZE)
@@ -217,26 +144,30 @@ int seg6_hmac_compute(struct seg6_hmac_info *hinfo, struct ipv6_sr_hdr *hdr,
 	for (i = 0; i < hdr->first_segment + 1; i++) {
 		memcpy(off, hdr->segments + i, 16);
 		off += 16;
 	}
 
-	dgsize = __do_hmac(hinfo, ring, plen, tmp_out,
-			   SEG6_HMAC_MAX_DIGESTSIZE);
+	switch (hinfo->alg_id) {
+	case SEG6_HMAC_ALGO_SHA1:
+		hmac_sha1_usingrawkey(hinfo->secret, hinfo->slen, ring, plen,
+				      output);
+		static_assert(SEG6_HMAC_FIELD_LEN > SHA1_DIGEST_SIZE);
+		memset(&output[SHA1_DIGEST_SIZE], 0,
+		       SEG6_HMAC_FIELD_LEN - SHA1_DIGEST_SIZE);
+		break;
+	case SEG6_HMAC_ALGO_SHA256:
+		hmac_sha256_usingrawkey(hinfo->secret, hinfo->slen, ring, plen,
+					output);
+		static_assert(SEG6_HMAC_FIELD_LEN == SHA256_DIGEST_SIZE);
+		break;
+	default:
+		ret = -ENOENT;
+		break;
+	}
 	local_unlock_nested_bh(&hmac_storage.bh_lock);
 	local_bh_enable();
-
-	if (dgsize < 0)
-		return dgsize;
-
-	wrsize = SEG6_HMAC_FIELD_LEN;
-	if (wrsize > dgsize)
-		wrsize = dgsize;
-
-	memset(output, 0, SEG6_HMAC_FIELD_LEN);
-	memcpy(output, tmp_out, wrsize);
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(seg6_hmac_compute);
 
 /* checks if an incoming SR-enabled packet's HMAC status matches
  * the incoming policy.
@@ -358,106 +289,17 @@ int seg6_push_hmac(struct net *net, struct in6_addr *saddr,
 	rcu_read_unlock();
 	return err;
 }
 EXPORT_SYMBOL(seg6_push_hmac);
 
-static int seg6_hmac_init_algo(void)
-{
-	struct seg6_hmac_algo *algo;
-	struct crypto_shash *tfm;
-	struct shash_desc *shash;
-	int i, alg_count, cpu;
-	int ret = -ENOMEM;
-
-	alg_count = ARRAY_SIZE(hmac_algos);
-
-	for (i = 0; i < alg_count; i++) {
-		struct crypto_shash **p_tfm;
-		int shsize;
-
-		algo = &hmac_algos[i];
-		algo->tfms = alloc_percpu(struct crypto_shash *);
-		if (!algo->tfms)
-			goto error_out;
-
-		for_each_possible_cpu(cpu) {
-			tfm = crypto_alloc_shash(algo->name, 0, 0);
-			if (IS_ERR(tfm)) {
-				ret = PTR_ERR(tfm);
-				goto error_out;
-			}
-			p_tfm = per_cpu_ptr(algo->tfms, cpu);
-			*p_tfm = tfm;
-		}
-
-		p_tfm = raw_cpu_ptr(algo->tfms);
-		tfm = *p_tfm;
-
-		shsize = sizeof(*shash) + crypto_shash_descsize(tfm);
-
-		algo->shashs = alloc_percpu(struct shash_desc *);
-		if (!algo->shashs)
-			goto error_out;
-
-		for_each_possible_cpu(cpu) {
-			shash = kzalloc_node(shsize, GFP_KERNEL,
-					     cpu_to_node(cpu));
-			if (!shash)
-				goto error_out;
-			*per_cpu_ptr(algo->shashs, cpu) = shash;
-		}
-	}
-
-	return 0;
-
-error_out:
-	seg6_hmac_exit();
-	return ret;
-}
-
-int __init seg6_hmac_init(void)
-{
-	return seg6_hmac_init_algo();
-}
-
 int __net_init seg6_hmac_net_init(struct net *net)
 {
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
 
 	return rhashtable_init(&sdata->hmac_infos, &rht_params);
 }
 
-void seg6_hmac_exit(void)
-{
-	struct seg6_hmac_algo *algo = NULL;
-	struct crypto_shash *tfm;
-	struct shash_desc *shash;
-	int i, alg_count, cpu;
-
-	alg_count = ARRAY_SIZE(hmac_algos);
-	for (i = 0; i < alg_count; i++) {
-		algo = &hmac_algos[i];
-
-		if (algo->shashs) {
-			for_each_possible_cpu(cpu) {
-				shash = *per_cpu_ptr(algo->shashs, cpu);
-				kfree(shash);
-			}
-			free_percpu(algo->shashs);
-		}
-
-		if (algo->tfms) {
-			for_each_possible_cpu(cpu) {
-				tfm = *per_cpu_ptr(algo->tfms, cpu);
-				crypto_free_shash(tfm);
-			}
-			free_percpu(algo->tfms);
-		}
-	}
-}
-EXPORT_SYMBOL(seg6_hmac_exit);
-
 void __net_exit seg6_hmac_net_exit(struct net *net)
 {
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
 
 	rhashtable_free_and_destroy(&sdata->hmac_infos, seg6_free_hi, NULL);
-- 
2.50.1


