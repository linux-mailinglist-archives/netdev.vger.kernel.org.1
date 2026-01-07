Return-Path: <netdev+bounces-247691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 396DDCFDA58
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B90830094A7
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E872830B512;
	Wed,  7 Jan 2026 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b973SbL1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EDB1EC01B
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788311; cv=none; b=qYYzF3OSPYbKz9wQf6tMC4wYG2TBynHMFMIbvr8noEBjH8/7Z4MZhTNwzoYI97ktz0TfQR7ZzDSLgSJzhUgz0rFY31qI42ZjcO/WQguOGEYaJCeWEOH6P+YxL9xSVCZ3Tb65ymYWKzQrYcglSssaIe9RzPFWkJ1c4TNaTPVbE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788311; c=relaxed/simple;
	bh=U6Y9FPJi6T3NvRGYldqxHltA4ZqTIEv+NP1KSmN9oho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M24V6JHfdW1vfAUkrLnu+QRKR3cC1han5yMbaQG+6RsnvgMgZHrYYwMtqfn2xXf7lpRUjUuTF31DwDIBMiKMX7XQO30hyCD5SlEn9lolIbWrVqcfYpatA+mlm4VDWX0WShGMjB4HD5BlPtVfmkIae+m9I8+t1SN1MFE/u0M67Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b973SbL1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso1744900b3a.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788310; x=1768393110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp1Xhf/12m+pUthcYvg3YicdMqsMY9ThbK3LGU2x3ss=;
        b=b973SbL1Y+ZFhRuBlYdxm6D1qj1KtXp7oa82bqjHDN1JwbYY+rq+XHHAlNFHi2+gSK
         eZnzi3z55KtImI0VTHhkJDqBuvjeixgwPM7vxs11sAEbDIh6fXfacCD47b6N3TzdMXP5
         5J71XcyevQonXn8GqlcphqbrszJpA0nuSyVskywVXtPZzCkyNFDWUQ44gNubLi8U8MTJ
         aJb3bXPWZiZmVooLhtdBHFxzprcUWt6VbcFRSQzNIDtquMozZjZEXo01GHmzGMxcXOvG
         XWQS1+AvEn6mnVESnDb3alkXqujyStE6oUzXJTi5bPdsF0uMXFqPiFAptWe/157NfqEM
         x2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788310; x=1768393110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp1Xhf/12m+pUthcYvg3YicdMqsMY9ThbK3LGU2x3ss=;
        b=U/6yY6AdsOS4qbthrHz6f8uqNk20zUR79hPACyfV4/z/KzgLAgwK9LpEGrAihwqSgo
         3BhoqDa+oUkHtjZuZS7k8U+r0SlFikIRdrDhh7l2+5IhjJV4tJkUrUUbL6i9wzSvQp65
         xP/sLTRu12yGD9fWGuY2IXSnJqWTgIrTz1p6OpDy5iYfZV8uho7lEBYxxR4mTIFWOYsq
         pPVdxIov3nm71ODwfg/Nk/TUukgnegCH8fQUPiyhCull2myZBoajxK/defCqpYYT1aQS
         882oFcgOfCqqdLXAfplg5cXl/YPGhLZ65hsQ4RMTTRKRDdQOtaMluVUryG9vuzmudfY/
         jPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4y2AdT8YJWRjJpWiE0bJIdjN9H2ZWFq/8NY6ZFelIzg6EfpDiOqmyudKu1IBZKKVEgcjUHgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0eX09+dBcrpUfIeYt8PsCu2vVE/j0t0Emmq4SGJbfe0SJnsB
	f9mYmCBmhManNdORIy8zmqBEwj95AzW/JmELkt6XGFp90NH/5TOz0OzW
X-Gm-Gg: AY/fxX4dnVsEXGLyo7stzcGANxeOTqsVrfM+l/sPaj5UMPj5iP3RV0ShV/riS1sZTIv
	vSZ4cQdAXiY3QNTCT2h1QIZdqVgdkLpPrKGzMFYbDqZiW2PsLeseZDTTcESGgtoeNP54CUFakLC
	YkXH457JpcTtDDZsdr1jpgqLFL66m0Cu534ZOin/7N/9iVGHrv2971ng07Y1BMUggZYSLQfrI+c
	41fUSbdyCjrmVKNKUvQWhnzQNHKYk7BRXAfhWBRT04SLruEuBqntfeT3rfeo9jdHkeTqtfdd6Tl
	Dq1rsQlFgnji6N1zcyB2ZUVrrMsZNiexpe+RMDrLSMr8Wa+m8RezcGQ13rjBdCU/wIZcZRdE8TY
	xvh5depjynycWHgVQRfkdHe0PhAIavwa5w3Wbi6sjrZt/iU+m32AHCo9T5SOIVqFo0wSg9xWNED
	k+2aiFXKKeeAw=
X-Google-Smtp-Source: AGHT+IG73PZ9Ur2uNR7sdzaq1IpxrpP08mJnukVQMVVUubDxzaUVhM2WKX32T2Z8GT1tngWh2BcQcg==
X-Received: by 2002:a05:6a20:2444:b0:366:14af:9bb9 with SMTP id adf61e73a8af0-3898fa09bd6mr2022199637.67.1767788309564;
        Wed, 07 Jan 2026 04:18:29 -0800 (PST)
Received: from fedora ([2401:4900:1f33:c0f:f9e4:5751:d29d:c2b9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f6cdsm5063337a12.6.2026.01.07.04.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:18:29 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: horms@kernel.org
Cc: i.shihao.999@gmail.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	dsahern@kernel.org,
	davem@davemloft.net
Subject: [PATCH net-next v3] net: ipv6: fix spelling typos in comments
Date: Wed,  7 Jan 2026 17:48:12 +0530
Message-ID: <20260107121812.40268-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix misspelled typos in comments

- destionation ->  destination
- wont -> won't
- upto -> up to
- informations -> information

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---

v3:
- Fix corrupt patch

v2: https://lore.kernel.org/all/aTZj_AFt6bR9_a2F@fedora/T/#m110f6623aeef100cdc6dad59f0851f6272e7371f
- Rebased on net-next

v1: https://lore.kernel.org/netdev/20251127103133.13877-1-i.shihao.999@gmail.com/T/#u
---
 net/ipv6/ah6.c                          | 2 +-
 net/ipv6/calipso.c                      | 4 ++--
 net/ipv6/ip6_fib.c                      | 2 +-
 net/ipv6/ip6_vti.c                      | 2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c | 2 +-
 net/ipv6/reassembly.c                   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 95372e0f1d21..92e1cf90a6be 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -169,7 +169,7 @@ static bool zero_out_mutable_opts(struct ipv6_opt_hdr *opthdr)
 /**
  *	ipv6_rearrange_destopt - rearrange IPv6 destination options header
  *	@iph: IPv6 header
- *	@destopt: destionation options header
+ *	@destopt: destination options header
  */
 static void ipv6_rearrange_destopt(struct ipv6hdr *iph, struct ipv6_opt_hdr *destopt)
 {
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index 21f6ed126253..2510a610a350 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -43,7 +43,7 @@
 #define CALIPSO_HDR_LEN (2 + 8)

 /* Maximum size of the calipso option including
- * the two-byte TLV header and upto 3 bytes of
+ * the two-byte TLV header and up to 3 bytes of
  * leading pad and 7 bytes of trailing pad.
  */
 #define CALIPSO_OPT_LEN_MAX_WITH_PAD (3 + CALIPSO_OPT_LEN_MAX + 7)
@@ -713,7 +713,7 @@ static int calipso_pad_write(unsigned char *buf, unsigned int offset,
  *
  * Description:
  * Generate a CALIPSO option using the DOI definition and security attributes
- * passed to the function. This also generates upto three bytes of leading
+ * passed to the function. This also generates up to three bytes of leading
  * padding that ensures that the option is 4n + 2 aligned.  It returns the
  * number of bytes written (including any initial padding).
  */
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 2111af022d94..bd1107eec89b 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1010,7 +1010,7 @@ static int fib6_nh_drop_pcpu_from(struct fib6_nh *nh, void *_arg)

 static void fib6_drop_pcpu_from(struct fib6_info *f6i)
 {
-	/* Make sure rt6_make_pcpu_route() wont add other percpu routes
+	/* Make sure rt6_make_pcpu_route() won't add other percpu routes
	 * while we are cleaning them here.
	 */
	f6i->fib6_destroying = 1;
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..cc8d0b142224 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -435,7 +435,7 @@ static bool vti6_state_check(const struct xfrm_state *x,
  * vti6_xmit - send a packet
  *   @skb: the outgoing socket buffer
  *   @dev: the outgoing tunnel device
- *   @fl: the flow informations for the xfrm_lookup
+ *   @fl: the flow information for the xfrm_lookup
  **/
 static int
 vti6_xmit(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 64ab23ff559b..fcb17308c7e7 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -251,7 +251,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,

	/* Note : skb->rbnode and skb->dev share the same location. */
	dev = skb->dev;
-	/* Makes sure compiler wont do silly aliasing games */
+	/* Makes sure compiler won't do silly aliasing games */
	barrier();

	prev = fq->q.fragments_tail;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 25ec8001898d..13540779a2c7 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -187,7 +187,7 @@ static int ip6_frag_queue(struct net *net,

	/* Note : skb->rbnode and skb->dev share the same location. */
	dev = skb->dev;
-	/* Makes sure compiler wont do silly aliasing games */
+	/* Makes sure compiler won't do silly aliasing games */
	barrier();

	prev_tail = fq->q.fragments_tail;
--
2.51.0

