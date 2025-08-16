Return-Path: <netdev+bounces-214253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576DB28A2F
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 05:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9304AC688F
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9861C5D4B;
	Sat, 16 Aug 2025 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxFygN02"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01391C5D44
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314111; cv=none; b=aXv3VhvjT0tFHzf1EUvP+Q+5gCV0a8mPq7GKKKh+CWz3d0BxsaRTkcibxFpBvHSZnPRsuoS6NjqrSQcmwvmoBHTxKg8zXreJUECv6LAkPucvawMmVEtd8NZ1OTwt0c0YhZhYDE89qYZ5cD8DFU3yOSlKVqqXm1gMiMJfLByCYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314111; c=relaxed/simple;
	bh=kpc/AaV/MXVEkt4nZDRozJphvXj2D/MYH8vhHJ9f38Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgtGrB9nAUUHMsjlsgagJJry1qSI4ivfr8K3PsMkYN2FvbIS+NIixLOlB630Fx9Q69tQOor6I6aluODBTLQ+jRfRED7yS1of30UGc7HxL9buu9w2f0iPdR0v4l6pDC4JQ65LLXKv+JDT/lSsUi3DJFVLQsRAN0DPMJLv/OX2TzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxFygN02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712D2C4CEF5;
	Sat, 16 Aug 2025 03:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314110;
	bh=kpc/AaV/MXVEkt4nZDRozJphvXj2D/MYH8vhHJ9f38Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxFygN02YgFdKB1JL9YYGKoKToEK1D3pTFBKV42sBGH87ZufG6E2170ji1+Zmyxl/
	 RNTM1j+i8479kaAQioEfUIlMECgckGJoJN5bf7JKmb9VP93R9aWwFZf6DxBwSDltYt
	 0uY6z3CVwVsXoDQwHWZCRrRSR2UvxyNJrMj0EQDaGHgF+mFuQNFrNwjSaC9959Jst4
	 4SYpJjn0PLAz+IDtDHmMz/IOUyN2FmDnXsge3KK1tPo4WEXL2oLZGBz1zpHNVUavi5
	 8EwsTL4xkS3wHYDGm/zEjJdbrf2tlmkzt68AzIasraQPQPoXyuWma1FbPp1lMpmVqn
	 uwk/YzZcRG8DA==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org,
	Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: David Lebrun <dlebrun@google.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next 3/3] ipv6: sr: Prepare HMAC key ahead of time
Date: Fri, 15 Aug 2025 20:11:36 -0700
Message-ID: <20250816031136.482400-4-ebiggers@kernel.org>
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

Prepare the HMAC key when it is added to the kernel, instead of
preparing it implicitly for every packet.  This significantly improves
the performance of seg6_hmac_compute().  A microbenchmark on x86_64
shows seg6_hmac_compute() (with HMAC-SHA256) dropping from ~1978 cycles
to ~1419 cycles, a 28% improvement.

The size of 'struct seg6_hmac_info' increases by 128 bytes, but that
should be fine, since there should not be a massive number of keys.

As a side effect, invalid values for SEG6_ATTR_ALGID (i.e., values other
than SEG6_HMAC_ALGO_SHA1 and SEG6_HMAC_ALGO_SHA256) now cause an error
immediately when the key is added, rather than later when computing a
HMAC value is attempted.  This seems like the expected behavior anyway.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/net/seg6_hmac.h |  8 ++++++++
 net/ipv6/seg6.c         | 13 +++++++++++++
 net/ipv6/seg6_hmac.c    |  9 ++++-----
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/seg6_hmac.h b/include/net/seg6_hmac.h
index 3fe4123dbbf0a..e9f41725933e4 100644
--- a/include/net/seg6_hmac.h
+++ b/include/net/seg6_hmac.h
@@ -7,10 +7,12 @@
  */
 
 #ifndef _NET_SEG6_HMAC_H
 #define _NET_SEG6_HMAC_H
 
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
 #include <net/flow.h>
 #include <net/ip6_fib.h>
 #include <net/sock.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
@@ -24,13 +26,19 @@
 struct seg6_hmac_info {
 	struct rhash_head node;
 	struct rcu_head rcu;
 
 	u32 hmackeyid;
+	/* The raw key, kept only so it can be returned back to userspace */
 	char secret[SEG6_HMAC_SECRET_LEN];
 	u8 slen;
 	u8 alg_id;
+	/* The prepared key, which the calculations actually use */
+	union {
+		struct hmac_sha1_key sha1;
+		struct hmac_sha256_key sha256;
+	} key;
 };
 
 extern int seg6_hmac_compute(struct seg6_hmac_info *hinfo,
 			     struct ipv6_sr_hdr *hdr, struct in6_addr *saddr,
 			     u8 *output);
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index a5c4c629b788c..313acdf1b2158 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -211,10 +211,23 @@ static int seg6_genl_sethmac(struct sk_buff *skb, struct genl_info *info)
 	memcpy(hinfo->secret, secret, slen);
 	hinfo->slen = slen;
 	hinfo->alg_id = algid;
 	hinfo->hmackeyid = hmackeyid;
 
+	switch (algid) {
+	case SEG6_HMAC_ALGO_SHA1:
+		hmac_sha1_preparekey(&hinfo->key.sha1, secret, slen);
+		break;
+	case SEG6_HMAC_ALGO_SHA256:
+		hmac_sha256_preparekey(&hinfo->key.sha256, secret, slen);
+		break;
+	default:
+		kfree(hinfo);
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
 	err = seg6_hmac_info_add(net, hmackeyid, hinfo);
 	if (err)
 		kfree(hinfo);
 
 out_unlock:
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 816aef69e0cea..5cdcb3011cb3e 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -146,23 +146,22 @@ int seg6_hmac_compute(struct seg6_hmac_info *hinfo, struct ipv6_sr_hdr *hdr,
 		off += 16;
 	}
 
 	switch (hinfo->alg_id) {
 	case SEG6_HMAC_ALGO_SHA1:
-		hmac_sha1_usingrawkey(hinfo->secret, hinfo->slen, ring, plen,
-				      output);
+		hmac_sha1(&hinfo->key.sha1, ring, plen, output);
 		static_assert(SEG6_HMAC_FIELD_LEN > SHA1_DIGEST_SIZE);
 		memset(&output[SHA1_DIGEST_SIZE], 0,
 		       SEG6_HMAC_FIELD_LEN - SHA1_DIGEST_SIZE);
 		break;
 	case SEG6_HMAC_ALGO_SHA256:
-		hmac_sha256_usingrawkey(hinfo->secret, hinfo->slen, ring, plen,
-					output);
+		hmac_sha256(&hinfo->key.sha256, ring, plen, output);
 		static_assert(SEG6_HMAC_FIELD_LEN == SHA256_DIGEST_SIZE);
 		break;
 	default:
-		ret = -ENOENT;
+		WARN_ON_ONCE(1);
+		ret = -EINVAL;
 		break;
 	}
 	local_unlock_nested_bh(&hmac_storage.bh_lock);
 	local_bh_enable();
 	return ret;
-- 
2.50.1


