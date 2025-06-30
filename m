Return-Path: <netdev+bounces-202411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C9AEDC95
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C6E16FA0F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B134289E32;
	Mon, 30 Jun 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbp00D/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A937A27F001
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285985; cv=none; b=gSEluHBXOOWC9IEfyXAeDgZ0DhRwe5s5MBF11MDmnxu671uaUrpwrpoar8kI8KK4NBo1fkyzlYa8EGfCU1gggvoDcYPmFx8+4YEEOw9rho5wMCGsObCyGvf/59+AMPFAJVbbTZ2Y+zL5yYleGeu2TQodpRZcSRMyS3ITOTSYrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285985; c=relaxed/simple;
	bh=jWcCbyyxZKmqTwORyozv8AgAthQ+BRHFm3WlqQHqoBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lCeQ/QzQ9+wSCpynb1vAgCy4WUyK4e92V29dir2YvvRYO4OMZ9DbklJsiE9l+X23mQAgtPNlR4xEcGI/bABIu4X0oDkWwoTdLZsHP/PdjhmcOqJSrtDmTzRtthOTioVKoPsWl95XpidE40j5iIHrzSzG4LjIAyLoTya0Vb86uck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbp00D/Q; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d099c1779dso275626785a.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751285982; x=1751890782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8F0IbT3+KYCuPKOHbgx4EmJrLeEBlyPd4IwkNzvRo4=;
        b=fbp00D/QskMA+QCNHQeV3LkjYUCsNDRkIJ1EUNWs+/jetd0+n8WiFuY/FOvafMTD0p
         UVWjN7hHrrQ1pVXFoV8OsrBY0FNVN+FHLic3YRZJLLpEinPoLBsp3XiARb1Yanp8p4Gn
         z50o9H1rg1y0OPyHE7Ia0xpgmtI1LHprXxGxWKItEyGYo05rJDrX7yxPStHCR+hYucXi
         fU34m3Lredz+bza58oFngc9UuszLBJ+xkLHOwWAjsiq+IvFRRA6LTK17okLzIA1fP/gr
         +00nCAy2r2DhPSmYjA08lRmdvAbzF4sPlUdkzo2IG7uVZrpZhgcUuhheQt0gMupMWX9b
         Yilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285982; x=1751890782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8F0IbT3+KYCuPKOHbgx4EmJrLeEBlyPd4IwkNzvRo4=;
        b=CqosR73D42B6VrB1YZbgg5J4zOof9Ci709DeYxxW87aNUQnNLbaStED4gH06aWwkJN
         shU5Q4C4aBkCjPblFdabvd74a92AyFn6sh4dxW1bd/stGRiw5QvV+fp+7Ti5c1zma89j
         vUlN0hG+OMNUI8gGDc4McwjpNPRxY5lbvojeb2jqeMrBzEPkVhV2JX5eyw3Fv9OTmBKZ
         xgpZa3Hdr0CjcGjw0IoPVeY/RQy3GcDozvA05mlWjojdIUoeNTFI19FDrDR5PQ7cbDdw
         x5uLmV3ITEYew+RgE2YE3w8Ho4DwpcExRYp0Wj3tI8TOXg4va03ghB8SwvegVmHrM+aj
         FRzw==
X-Forwarded-Encrypted: i=1; AJvYcCVaeU5rm0/8pYdReIrlByDXhmKA4GEdPiZqUB+prb9g4yQWz9o1zIRFbays4fq5J9tyK86eJ7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlAEK8kTqdqLEcxi5A8GJCuPnjLV2BnRXT4VEOP6/7aC+DLBWJ
	PvGOxqYyAta7+/ikCW26T28Zdmv7nA8o1ob6CP1/rxWF/joBoA0cjV1QRkYB9evxXWtP8FL2P0A
	vwlBvBtPdHQH1Tw==
X-Google-Smtp-Source: AGHT+IE0Cr54MaHft2K9uG64LU262XBS5IeycGbLVqQlEJnQsgWfThjVMV3icDNqBIJtleIQ2PrKZIcSNszLSg==
X-Received: from qknsu4.prod.google.com ([2002:a05:620a:4b44:b0:7d3:ed4d:4fc1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:468c:b0:7ca:dac1:a2d9 with SMTP id af79cd13be357-7d443994f6emr1803104285a.28.1751285982514;
 Mon, 30 Jun 2025 05:19:42 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:19:28 +0000
In-Reply-To: <20250630121934.3399505-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630121934.3399505-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630121934.3399505-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/10] net: dst: annotate data-races around dst->input
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dst_dev_put() can overwrite dst->input while other
cpus might read this field (for instance from dst_input())

Add READ_ONCE()/WRITE_ONCE() annotations to suppress
potential issues.

We will likely need full RCU protection later.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/dst.h      | 2 +-
 include/net/lwtunnel.h | 4 ++--
 net/core/dst.c         | 2 +-
 net/ipv4/route.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index bef2f41c7220437b3cb177ea8c85b81b3f89e8f8..c0f8b6d8e70746fe09a68037f14d6e5bf1d1c57e 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -468,7 +468,7 @@ INDIRECT_CALLABLE_DECLARE(int ip_local_deliver(struct sk_buff *));
 /* Input packet from network to transport.  */
 static inline int dst_input(struct sk_buff *skb)
 {
-	return INDIRECT_CALL_INET(skb_dst(skb)->input,
+	return INDIRECT_CALL_INET(READ_ONCE(skb_dst(skb)->input),
 				  ip6_input, ip_local_deliver, skb);
 }
 
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index c306ebe379a0b37ecc5ce54c864824c91aaea273..eaac07d505959e263e479e0fe288424371945f5d 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -142,8 +142,8 @@ static inline void lwtunnel_set_redirect(struct dst_entry *dst)
 		dst->output = lwtunnel_output;
 	}
 	if (lwtunnel_input_redirect(dst->lwtstate)) {
-		dst->lwtstate->orig_input = dst->input;
-		dst->input = lwtunnel_input;
+		dst->lwtstate->orig_input = READ_ONCE(dst->input);
+		WRITE_ONCE(dst->input, lwtunnel_input);
 	}
 }
 #else
diff --git a/net/core/dst.c b/net/core/dst.c
index 8f2a3138d60c7e94f24ab8bc9063d470a825eeb5..13c629dc7123da1eaeb07e4546ae6c3f38265af1 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -148,7 +148,7 @@ void dst_dev_put(struct dst_entry *dst)
 	WRITE_ONCE(dst->obsolete, DST_OBSOLETE_DEAD);
 	if (dst->ops->ifdown)
 		dst->ops->ifdown(dst, dev);
-	dst->input = dst_discard;
+	WRITE_ONCE(dst->input, dst_discard);
 	dst->output = dst_discard_out;
 	dst->dev = blackhole_netdev;
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d7a534a5f1ff8bdaa81a14096f70ef3a83a1ab05..75a1f9eabd6b6350b1ebc9d7dc8166b3d9364a03 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1687,7 +1687,7 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 		else if (rt->rt_gw_family == AF_INET6)
 			new_rt->rt_gw6 = rt->rt_gw6;
 
-		new_rt->dst.input = rt->dst.input;
+		new_rt->dst.input = READ_ONCE(rt->dst.input);
 		new_rt->dst.output = rt->dst.output;
 		new_rt->dst.error = rt->dst.error;
 		new_rt->dst.lastuse = jiffies;
-- 
2.50.0.727.gbf7dc18ff4-goog


