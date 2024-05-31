Return-Path: <netdev+bounces-99743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2101A8D62F9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75AEDB21FCA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ACB158DAD;
	Fri, 31 May 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBv6STtM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22089158DA6
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162008; cv=none; b=LH5KzCwWvbagyomYlo5uOTBljJU2lXPmG6OcX7ogAP0UP3BMWIykBKUG91P7XKgU0NjkvmM7NMqB7jbcgQPo4DjQYmj6pcY9dTTySSwXm5N+Urins//EQbDg/2kQHUo6eaVZ+2OU2ueDpXOFpb4RJY46U2R7Z60qqBguLv924aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162008; c=relaxed/simple;
	bh=9xG7G/guWrc8yW/F6IygmvmognkE0pf3MKz8308UCng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kmL50JUAdD9gbcBBHBP17Ry2HVERaSGdz7uGJgudam8CLWebwOCAxPjcpJCAHiTKLx32ct7EWpoaq/W35oi4Er9ig+0r7qji3i9f/Nyfpm/jDQEO663K5myyCMhRt81mfB9rSQdBiMtjDMrb9nSKzd1+jHcb/rQbLsXSg2FGzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBv6STtM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a0827391aso37827767b3.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717162005; x=1717766805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTb2XObsRXRaPUKTzwO4Gw8CcICzGmzukLxVkK7LUFU=;
        b=fBv6STtM+/mxXLpRBvdDRIypLtOP/s19WwEcpGlhEvEghldoZB7K/smkJtayA0C/We
         MHMOr0RtN5BOrX8RwfIyNnkh+GUev3rLAep20qIAuTabNSdmzF238YCcFYVkVTA3TmQD
         R0mhEAVszZCM94g+Yzmdm2lnXzxNAXX1KcrRWRyduECpWhRkOaSvMrB/AkqDdkjfdhuM
         j7aLqBLZuJBIUPEJWvdhneREVcFXEG7Cneu7tCxu7yasAWGKMPpYRSnNQ073Y/aImAbR
         ZGwDPnWLwv8obdM+pc+9Td7fR5DUjLdeXz7d80OkGZJsg/aIdozQXlR0qhBInEOjQjed
         JI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162005; x=1717766805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTb2XObsRXRaPUKTzwO4Gw8CcICzGmzukLxVkK7LUFU=;
        b=UqpLVIIeeQzOLkmoWF1CjjMDmkTNHeskHNVPPrq43I+j5EMwYp8KZa6WrnrQHQC1Zm
         iN8PRYWPTjBIGElWVXfxKBNlHHWFP4chGDgVGwnxYIgbFwcHbQ6B/DfhWIWGWhFNteWf
         rQGoW8ofnZj2uSAMOlfSnWg58CAYakru6Cy+k/mf4zNGeBa4/l76vMBqik0q2dDCJkLo
         htpW1KQIgfvgVOVymMOJlGbHU41bB+kdqj0DRhljx5+Aumc8H4a1N88aerYjw54R8VqL
         nHzxaBs29I4+R0kcxU7noNJhsw25a9vjYdHvOPwimMyTFKzlCpeMFFIVxn4Z2zxS0DwU
         ZnHw==
X-Gm-Message-State: AOJu0YzJtB0lpDaYfenzupxKyvlaHMTGDlBVqgmhOrck7TB8PKw1T7rB
	0gWFO9dI0CMGHHnG+Pg1PCgJo+6kYL5luZcnfAU5yodNYBV9tw5H/zuOUjtkvs1cgm3GtbqulFX
	NvqHcGzcFJg==
X-Google-Smtp-Source: AGHT+IEI8GfmXyFTRNqV22Hr3NSPETpVaf28aCbqtRi7LVIzVKSVIdDRnuagf3feJV42kp3XqMWdXLgs+ETcQw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:f0f:b0:627:a787:abf4 with SMTP
 id 00721157ae682-62c7964587cmr4680587b3.3.1717162005114; Fri, 31 May 2024
 06:26:45 -0700 (PDT)
Date: Fri, 31 May 2024 13:26:33 +0000
In-Reply-To: <20240531132636.2637995-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240531132636.2637995-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531132636.2637995-3-edumazet@google.com>
Subject: [PATCH net 2/5] net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Alexander Aring <aahringo@redhat.com>
Content-Type: text/plain; charset="UTF-8"

As explained in commit 1378817486d6 ("tipc: block BH
before using dst_cache"), net/core/dst_cache.c
helpers need to be called with BH disabled.

Disabling preemption in rpl_output() is not good enough,
because rpl_output() is called from process context,
lwtunnel_output() only uses rcu_read_lock().

We might be interrupted by a softirq, re-enter rpl_output()
and corrupt dst_cache data structures.

Fix the race by using local_bh_disable() instead of
preempt_disable().

Apply a similar change in rpl_input().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Alexander Aring <aahringo@redhat.com>
---
 net/ipv6/rpl_iptunnel.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index a013b92cbb860aa36a23f50d3d5c5963857d601c..2c83b7586422ddd2ae877f98e47698410e47b233 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -212,9 +212,9 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
-	preempt_enable();
+	local_bh_enable();
 
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -234,9 +234,9 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		preempt_disable();
+		local_bh_disable();
 		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
-		preempt_enable();
+		local_bh_enable();
 	}
 
 	skb_dst_drop(skb);
@@ -268,23 +268,21 @@ static int rpl_input(struct sk_buff *skb)
 		return err;
 	}
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
-	preempt_enable();
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
-			preempt_disable();
 			dst_cache_set_ip6(&rlwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
-			preempt_enable();
 		}
 	} else {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	}
+	local_bh_enable();
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
-- 
2.45.1.288.g0e0cd299f1-goog


