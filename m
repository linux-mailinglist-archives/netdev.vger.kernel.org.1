Return-Path: <netdev+bounces-276167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMTFExh21WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:24:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA93B5018
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D12B30D0F33
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4907F228CB8;
	Tue,  7 Apr 2026 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3AoyUAM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFD37C901
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596812; cv=none; b=J8WbQU3cvCzr/u28kXwalrlRMeZe4+OvDVbb3OpoNO4vN4E8liMMMnXxtL/29jJ5Jg4+0T5KodrgeNZyGzKrHFyPcvg8At9w6VBEI/s8DVEKn+yo+qqUvH7oUQde2amOIyyjBdQzbAlJSo8Fc02M4pxOVmdp/bX7ZOKLXjneLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596812; c=relaxed/simple;
	bh=OnNXsCvdfGP3CW8mzGxCHreqb4RpCpVTiut1U1FA/O8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eyclJefbYuBu2QGt+HxoRtMXAQMnQRNuor0twnGTVGrslilO2jFKUoqmbT/L1OyNpk9HCS4UP2xiy6py5umGk1oIOiC31jMgzjEjOZkxptfC57bF/9aM8ubpbwd2b/n3ryC5oEqYGaAwwpQjXCyHqutcFYM9k2KKP84oq3r+n6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3AoyUAM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35d90c7ec5aso13633903a91.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596810; x=1776201610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYTzHZVM/p0UecbIsK9CvAI4GetYhz+rDIfIimaFq5U=;
        b=H3AoyUAMk3hbIBIUGxTXfDldTN+P8E/PjiGxEb3MxE96evipSxblWtBVcIknS/Anxw
         LRzzPBI1RmCUIsZgLzffhGEu0KkpXGivZKyBr41nD1VvZyD3C8AGhY7WmofjqjVWfD79
         M9XCgUzacpZRT8hKvYDiYlQx3LVg7znTyljh2JVlWi3XgtpVEahnXyGXUj8mrpAcUr2b
         BqRAIICi7iBzhZ99/DBo60OXj118Hyum/PmkjmrdLVxMb5YE0j0evIkVYhxUeoBoPgOJ
         5Zd8KJNpzughnzXWh/vAky6venLRMXtnT45YOOkNV7Przp7ABRteHc5BLZsrNC8qPYUM
         KO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596810; x=1776201610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYTzHZVM/p0UecbIsK9CvAI4GetYhz+rDIfIimaFq5U=;
        b=FxTsnS+QuTC31yzCTd5M5idSQNZX+hy5L2+GSp6JYRwaDDduv5xrfb7g3TqLs6eqHF
         642w52fZzAzr2SZgoNE89Sw4plw/0u80uUmMjyaedBEVRO6EvwDElhgSNPuz+5LR8j8G
         FQpaADusxpT4CYE6FswC1uDCtgrcjoTfQaDp4r2Yi44phcJe6vm+xYf+hHeUgnQWMbar
         LqBwoGBETi0pATSZybvnfkTGRueii3vOb0L14vc0Vn2n9ZX44hG2C4RIvLfFrxbJQeoN
         IVg+DOSdROkiNO3FR1E1Rtnc2twfRghsacCKls/RV1Vfa/4eo3DM02NVhIFDjKnaBlhy
         jAbw==
X-Forwarded-Encrypted: i=1; AJvYcCX7hv7VBx84/9D2xnruMA+sxo8fsG0OZZMRmpZlxVKGIn7GzZ1WBxSdJK1xtv/Nu9uLiSeN0DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkJnciSUwSi7az+EotR7v2GjPHajcLT9lKRu4TzKmVLjRCT6B
	IBF7IHc0EXvIkC//vnUjpSspzYb8RlNJeIZZlNdUuwy2BKihQmATY1ao9g55JnMbv9h27BIn70S
	zRgNtxw==
X-Received: from pgbcr11.prod.google.com ([2002:a05:6a02:410b:b0:c76:b086:d9f6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d10:b0:35d:a9bb:1e33
 with SMTP id 98e67ed59e1d1-35de685ecf3mr18956033a91.11.1775596810224; Tue, 07
 Apr 2026 14:20:10 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:37 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-5-kuniyu@google.com>
Subject: [PATCH v3 net-next 04/15] ip6mr: Use MAXMIFS in mr6_msgsize().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276167-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0DA93B5018
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mr6_msgsize() calculates skb size needed for ip6mr_fill_mroute().

The size differs based on mrt->maxvif.

We will drop RTNL for ip6mr_rtm_getroute() and mrt->maxvif may
change under RCU.

To avoid -EMSGSIZE, let's calculate the size with the maximum
value of mrt->maxvif, MAXMIFS.

struct rtnexthop is 8 bytes and MAXMIFS is 32, so the maximum delta
is 256 bytes, which is small enough.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 5d368ee39b28..4d78041276c1 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2542,7 +2542,7 @@ static int _ip6mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 				 cmd, flags);
 }
 
-static int mr6_msgsize(bool unresolved, int maxvif)
+static int mr6_msgsize(bool unresolved)
 {
 	size_t len =
 		NLMSG_ALIGN(sizeof(struct rtmsg))
@@ -2555,7 +2555,7 @@ static int mr6_msgsize(bool unresolved, int maxvif)
 		len = len
 		      + nla_total_size(4)	/* RTA_IIF */
 		      + nla_total_size(0)	/* RTA_MULTIPATH */
-		      + maxvif * NLA_ALIGN(sizeof(struct rtnexthop))
+		      + MAXMIFS * NLA_ALIGN(sizeof(struct rtnexthop))
 						/* RTA_MFC_STATS */
 		      + nla_total_size_64bit(sizeof(struct rta_mfc_stats))
 		;
@@ -2570,8 +2570,7 @@ static void mr6_netlink_event(struct mr_table *mrt, struct mfc6_cache *mfc,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(mr6_msgsize(mfc->_c.mfc_parent >= MAXMIFS, mrt->maxvif),
-			GFP_ATOMIC);
+	skb = nlmsg_new(mr6_msgsize(mfc->_c.mfc_parent >= MAXMIFS), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
@@ -2727,7 +2726,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		return -ENOENT;
 	}
 
-	skb = nlmsg_new(mr6_msgsize(false, mrt->maxvif), GFP_KERNEL);
+	skb = nlmsg_new(mr6_msgsize(false), GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
-- 
2.53.0.1213.gd9a14994de-goog


