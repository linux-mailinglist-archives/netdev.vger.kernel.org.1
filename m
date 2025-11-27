Return-Path: <netdev+bounces-242227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 300BEC8DC3D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 999ED34F1B7
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA0C329C61;
	Thu, 27 Nov 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pfsrm3ku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D67328B5C
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239513; cv=none; b=M1nnLGzaYeIx5o6PBTyzO5AX2tZUWgTSZ2sgqRCAf5rE8eRltsXKWgBVogEjp8VUXYx55ee4ns0TPDi4OyFUigFRPm/OS2+WRW/szssqL2OrGrYAili2kUlBnovYJ521d7b713TPWsiFLpCADIU7SYXTqMXVEhjFTdSHU7ESDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239513; c=relaxed/simple;
	bh=wPMF67PBVsW07eZrD/qkyVEHI55YnQXGvt5AQnxxiLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGcnlbIMRHYnU2/VVsFMfqEq7vYbxA2hdPdObhVzr847PwSvd5IlfzwPdLYkq7L1F4Z2eP2L5El7EjoonUFZBdM/7yMnBxw0R94lVA9hRIuDmcC4icShUbMBy1ddfDM95w6arWAM3xKcRFUXxG2FBMqKTBbe3UDvPhgH+1NBBZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pfsrm3ku; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so663974b3a.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 02:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764239511; x=1764844311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/y3+R6McLvevFwMiXcYaP+xoPXKgNY8Y8TzRKeSGco=;
        b=Pfsrm3kuk9xIPcQlyYUaaf/YZW7UGzRm0M+gl1qDmpBDHKSHgsQ9yLplgNI+KvPG70
         1Qf2BmTiqNHliEEQDpg0no/nK9jczcqWmZWJgpbuxuzYawp9OrHVlKqdVycULwk4bhXe
         R0AbRkFU76otzW3hroh2B5yWb0+lDn27UUwavfdd0zMj3y5qnwizdcylLAjmFbWruiga
         DotHLPG6yVbGbVr2Ynk4FF2o79tD+dIjeTX97zqPA3/uPPo5FHeRtSNRALKE++KJtEMI
         SnlA/AyTHTUkwzKusPQecJ5X6sBgBXMnvVdWm7MDrj13Gp+9r8nIU+6W2Mpv/EtakFXS
         UlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239511; x=1764844311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/y3+R6McLvevFwMiXcYaP+xoPXKgNY8Y8TzRKeSGco=;
        b=xQNT4VU88s7NIcv8C/9Mtrym8mfu+oSfL+sQ9GJgmftIgUWb4ToxY0JjtcSBaS2FcC
         xOQ+bRg6jq8Fu/i4yqyP/WxcyMokPQXuB+fdoqKbgaO4ZKmDz1OD5vJeFfg1a6Z0495e
         1FUkvFSotfVnJ+gxDrrKY0j6aKLTEN08ErXcWYaMKrL8aLOMZ8zcXQIiq2U981KczjtD
         3m9/Eqbjk89bOQbfXOEDPoAmDaJu4Y+G2drRKiPh9Xuh61xG93AnZjxUOzaxYjSSd8ws
         oM2OVmgA6OyxBP4w8MUjZEFn5jbmm8lE2kSAVRlpUBu86cRphTwk1pZFxcEDXDNt2qUs
         opPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY6bc1zEa1AsAL6d0OVlhDm1/T4PwuBJNZoFkMtfckgmpITx7g9yVlPQdFGDj5jp3tWOpk+ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YywS1RrfK202fRhhxgbGWBb6eN/C8fJKmKE99HniNFf/Z/U1t2f
	tncqpO/WmPRyTfOGHfI+XprAiC5dTFxr5bkKSPFITTBtrqlj6GLw8wSN
X-Gm-Gg: ASbGncsQn4izaRvCCN07tekKfzSLrXlZ6CHXMm6+uDr2vnWrSef/33oKiPkcdbEoA5y
	dkDy/LMxooQAVwHLdAVPF93OzWvrIhkRtVo7OAGoplO+xjhy3jYtSKU2D4j/kWhXk3+M/Q3+86K
	mSxEnDi11PzbyoCq0kp4kXGohmrnrULVql5xQ1ClSeT8wrxbxxbuOp1eUZcn63MJr0XovN1rd20
	mOMenswraqTnufs06Nb75Wwdw0h71BUdGiPETGwUwS9QcdF+ECpGKM82eIwzXcc80alMit668J3
	nsdsLkQZy2b1w/8VMMojEZoxSzpw/P2klMr2sThtfYR1s+WtfbBTo2Z/YnqlIAKOPJzuBLZOjXr
	KXNjgh3sSE/6UE/+OM70r8oo27MoKigEFg3sUz7s9pJXYTbT8mI3dtNoiXV47zk7BqOVq5TKHTR
	uyjyTS/Q+mi0fG
X-Google-Smtp-Source: AGHT+IHWy14rAgpDHSkBsJKOgMOuI4OpxvrXfMvCXc8tz0XBRrL3w8UnqxX1rJlMEiIQez4zUl95Ag==
X-Received: by 2002:a05:6a00:2e87:b0:7b8:77ec:e7cd with SMTP id d2e1a72fcca58-7c58eaf25bemr23585637b3a.29.1764239511375;
        Thu, 27 Nov 2025 02:31:51 -0800 (PST)
Received: from fedora ([2401:4900:1c6a:475e:766e:c133:e5b8:8502])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fcfd0b6sm1487799b3a.64.2025.11.27.02.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:31:51 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	i.shihao.999@gmail.com,
	pablo@netfilter.org
Subject: [PATCH] net: ipv6: fix spelling typos in comments
Date: Thu, 27 Nov 2025 16:01:33 +0530
Message-ID: <20251127103133.13877-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct misspelled typos in comments

- informations -> information
- wont -> won't
- upto -> up to
- destionation -> destination

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
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
index df1986973430..220dd432c5bd 100644
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
index 02c16909f618..19eefd48e744 100644
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

