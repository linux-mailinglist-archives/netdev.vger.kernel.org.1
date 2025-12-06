Return-Path: <netdev+bounces-243894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A4CAA2F6
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 09:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 030BE305309C
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474032367AC;
	Sat,  6 Dec 2025 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTEB9xG6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680721FF46
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765010315; cv=none; b=gxJ+o8R4CivOGAKGPWpogbWojh5OLFMMtENjgwaHsFa7E8p2vci3AlrFYKAAXnlIFABMn/Q4Km8TRqWrd8VhDwqz0SbGYSyJpabhT1/ByBZdQArkCMwyFA9g3Gv10ynjfNGJUeJ5zsIPtUq504M0+Fo3fp7fajtS6zLTgL2wki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765010315; c=relaxed/simple;
	bh=Gwa4FW/HF6dVnO8PL32pmwPWh+CCm+aVOn2ctJfUxXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/CEJpU1nAAo80iSTTs4ON57f7bRJGVjS+6KZ2X53Kpq5psGscrYLNOr4psqpThRkyHMhuRpKTx9dohaSN8iKERY8Nkqw0iei8ipW9vxZCl1jXm/cCXbTm07JbhxWBIRy9DzYpPt8qyhM/UgefpKiiaVoLM8zseU70E4Had2x+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTEB9xG6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29808a9a96aso30314255ad.1
        for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 00:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765010313; x=1765615113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=prycVSRPOk07rpwpu9tCdC8skh9cM21gBKGRU0XWKEQ=;
        b=fTEB9xG6NVQ8CZ5n1ARehRV9WHM/VE+y7NT+2trj5OZnLFyriPyBmDM45jSPrfcoxm
         dpy+GV/oSQCw2RmtHLtouT8gqfSLxbTOnneRZbbA0wf4Mimgo+qYwrMLVrDj9RBylPfh
         df3W7OMt8ixKBlwA3a3LyB9MfFtBhsDKDFxeg0ak0B+uJrDs0hFH8J7qF9mQuR/MYWQK
         zmgb1h7YLJ0DmguF5XM7ZcC4vqrfHEemL2NXc7ZPfHgOO3yzgMwmYuPJBks3jFNKgGl+
         KpLn3iGiDDEgIHCdYNjZh45kCsqiaXUNkBpLuJ4ZtpraSn9B2dG9dqtJ+goq19XRRn1a
         y5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765010313; x=1765615113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prycVSRPOk07rpwpu9tCdC8skh9cM21gBKGRU0XWKEQ=;
        b=aPlv5DlqT7XFIad339o/cse0t6CpxeMfOnL3I9KG6iACMEf2S6/FbLcTsSOL7pQgmb
         U8HXHl5fPGQmM/z3KA9FkcdIXaN847Pz31+TwFMB8d6rY794OKqb9wC3mRho9qm0tEo+
         75saVOft1c4LbhC1qTxmJ0NTqirAvoiIaMpGjIF8SkPqnnRKqGR854xe7jARmTqSvkit
         lPUDHQB0SZ/GWp4FTZLDSljN4dUEvAdTUn6TbCapzKwoKkqcek1m2o/u1FZ1a5lwBF2h
         KVHg0XSZDRiMyONDs6huZlBvxdD600eLCsIJ4ZRuVBfnpZGOQgvrqlypjn0O8CO2Tuqg
         r7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN38dSqSwn9mCS7W2xhVzmm1AF7ME04N5LH6XQRKJPP0jowwoc9roEGpY0320MEZeHK0SaiI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/39R2F8Q3f77lp76v8itI8WX/0/V0cpkiQ77oZo4emeVstQg5
	1FPqjarrqIndVkfO8u3rAwyH80wG8F18Xf++Pg8GYG7H0wioziSrTNbH
X-Gm-Gg: ASbGnct3+g2HSfRKBjCuFQWTZLBaV0rjuMB9xxKG9BTcj/oIc2yM4aovDkBRkgTv3Ku
	ziDk9Rfwg2/DSGPyG7XhZAGPz4UzGmULBINMZs+ZCEI86m7qHJ6uD6FjaVSLTwQYtGFVTInvNsY
	YEVYxZ1baPMHnK9+5ctoXRBQySnjPvlO1Lxl+z9AqTQ08is+AI5e+dNRfrUNNdHQO0KuV6gpX3X
	4+4QrelTgAQdJflFtDj74vJ8lnyoNcFpoTms1lYcEyPJMY5NFYGaMeBK/c+6ta1+7kqVFuw9H8Q
	njiKIq6JguMRPbu/AHyNDpcZVKRlXZlN3XwyYa/pddcN1VZFwUxMlimfo+s7nCF396oQbBcXJqB
	qpIG88aGqLpN6PS3FcKHLrbc9JgwzzPE8OR9kEl55y9bolPu61sVTCpdw8W6yDIGNQRqNMFs/Zq
	+EZX3Ey8l9ksYE
X-Google-Smtp-Source: AGHT+IHKcTubNpp//XKbNtvzZsY9GNFbXVUHT6icYP+A+7ynbahWDBjnLZ6Mh0QvhvT3OxZ280hfBQ==
X-Received: by 2002:a17:902:e752:b0:295:98a1:7ddb with SMTP id d9443c01a7336-29df6326100mr15811075ad.61.1765010312599;
        Sat, 06 Dec 2025 00:38:32 -0800 (PST)
Received: from fedora ([110.224.242.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf9c3sm68834905ad.26.2025.12.06.00.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 00:38:32 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	i.shihao.999@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pablo@netfilter.org,
	steffen.klassert@secunet.com
Subject: [PATCH v2] net: ipv6: fix spelling typos in comments
Date: Sat,  6 Dec 2025 14:08:13 +0530
Message-ID: <20251206083813.240710-1-i.shihao.999@gmail.com>
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

changes v2:
- Rebased on net-next
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

