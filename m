Return-Path: <netdev+bounces-202412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDF1AEDC9A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C046A7A4B28
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A784F289E25;
	Mon, 30 Jun 2025 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khXRIRtV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A5289E2B
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285986; cv=none; b=aaHPdcYyBDLXPb8+88gQ3Lua6dwfi8bjKgriGnEdMZQU5GICR6jdMKcLe/z89BOxwsjqDo4ch9gnF7SVg7OdQ2fkyVnZ5fQTgsFHEsNB5BBOoxF+TeA32vdvtJuWbuhpCqIpBKoiH5nz7lT+mpO4+IPvAVG6Lv8V8UxV+vB115k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285986; c=relaxed/simple;
	bh=jVOtupnncUcLeYHkOyrWDmN8tmYz5kLhbO3F4Ya3HWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lwl03o6VmorHEHcLHPRF0zE9qqRh4X8sp7VoR4dviMnyERo9gHY3+AIivoJubeMVIakQgyZz3tCZQ3YuAZGb/J2AcVxjXhKltL9SoiOGthXrROOVScFqaPwAuNwJfSf7fV6s1rvmEmnHCFVjqOVxKLmckE8G1A4Z6xMojeF51ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khXRIRtV; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a587c85a60so106852801cf.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751285984; x=1751890784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7e//4iY21RFp1mBVe6qmyNKf+GS8wkg6rCxJn+x5Bq8=;
        b=khXRIRtVMukC+spO5OI/o1Vt9TGekgjw1DLOYp38qNNiV2pBhNGcoxFpkbp13fUBUh
         UJP3lU23e8z/mNpr3tvMDsw2OA8dpGVnTVGCTiyXNNUkyhFyRWrYN8QvYGgoPE6nfTk/
         xL0UYQ46ZmTqcE4KBDeENb85L6ZBHfT6m5TMbaTym5qlOSCFbO/t2TtLpHIrzVfoXOS5
         hLgg8KzJGcVQTjQjL8xWeaeMjEVkzv1/I4goa8l3W0Ec8oqY9bj04LXh1LC4SNzUy8SC
         Q1hwY+RELYXSXDWSSIrd3pxjcdVQtrdjQipfX7elDlPpEZMactyED/hsIXSX/GgFGF4d
         vixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285984; x=1751890784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e//4iY21RFp1mBVe6qmyNKf+GS8wkg6rCxJn+x5Bq8=;
        b=rOBKuH5SeGuUvdjy4ZWbNprDakjhAW4VaagS2YxkZ/bTgYvmHvsrDSuTOwAbs0ISO4
         VykBYguhsNC2SjkYjlbw66qzPo4ndxsqFWERc7x3h1TszsnB8IJUEeeeokYIPyMedlks
         Kr/AaGjRwWCsG4c9UARHY/6vnRPyGh5OqPnlki62FELJqAHSTD5d7fGfnCO8kCyv7EzX
         Fjec5kdVpGfDAmgKOmd+MEj8UxB8yQYgu9c9yNvNZZv07BNUiw91K3e6TuAiOefx5hep
         zMackoWcdnkrm+YMMNzEb766Mzs7LybhgwpNuD431PBos6sTbeaOotzdti9CFD3FsE7+
         cLbg==
X-Forwarded-Encrypted: i=1; AJvYcCXAfr3PPH81GxY51Nj0xb7CnFQ7KqyNml61f3ovwpJ2v6cHcb3v3GtQAAYnj2mFVS09F1/8qZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyjXA4AZBfReK89PL8Xy7DnzkbavtIWtgXCmUc1bBirInEefdW
	dTjk0Yh9r5UTHmBX46gFEtqLitsM+dbvgpbZa11dAspVq5DdPt2mtvrmZM5smJtA2fo4ZMY9yQz
	U8UvMyCu5kOg/QQ==
X-Google-Smtp-Source: AGHT+IFE5HMqqYnSvkfjzG8oOwyQbBynpWe4DpQNPKSmg8E2gxLTLk0bM8PKESBywXE323fIW6TTtteqxlUxRQ==
X-Received: from qtbhh2.prod.google.com ([2002:a05:622a:6182:b0:4a7:852a:f584])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:34c:b0:476:8a27:6b01 with SMTP id d75a77b69052e-4a7fce1c431mr214456591cf.47.1751285983940;
 Mon, 30 Jun 2025 05:19:43 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:19:29 +0000
In-Reply-To: <20250630121934.3399505-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630121934.3399505-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630121934.3399505-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/10] net: dst: annotate data-races around dst->output
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dst_dev_put() can overwrite dst->output while other
cpus might read this field (for instance from dst_output())

Add READ_ONCE()/WRITE_ONCE() annotations to suppress
potential issues.

We will likely need RCU protection in the future.

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
index c0f8b6d8e70746fe09a68037f14d6e5bf1d1c57e..b6acfde7d587c40489aaf869f715479478f548ca 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -458,7 +458,7 @@ INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
 /* Output packet to network from transport.  */
 static inline int dst_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	return INDIRECT_CALL_INET(skb_dst(skb)->output,
+	return INDIRECT_CALL_INET(READ_ONCE(skb_dst(skb)->output),
 				  ip6_output, ip_output,
 				  net, sk, skb);
 }
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index eaac07d505959e263e479e0fe288424371945f5d..26232f603e33c9c7a1499a0dd2f69c0ba10cc381 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -138,8 +138,8 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len,
 static inline void lwtunnel_set_redirect(struct dst_entry *dst)
 {
 	if (lwtunnel_output_redirect(dst->lwtstate)) {
-		dst->lwtstate->orig_output = dst->output;
-		dst->output = lwtunnel_output;
+		dst->lwtstate->orig_output = READ_ONCE(dst->output);
+		WRITE_ONCE(dst->output, lwtunnel_output);
 	}
 	if (lwtunnel_input_redirect(dst->lwtstate)) {
 		dst->lwtstate->orig_input = READ_ONCE(dst->input);
diff --git a/net/core/dst.c b/net/core/dst.c
index 13c629dc7123da1eaeb07e4546ae6c3f38265af1..52e824e57c1755a39008fede0d97c7ed7be56855 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -149,7 +149,7 @@ void dst_dev_put(struct dst_entry *dst)
 	if (dst->ops->ifdown)
 		dst->ops->ifdown(dst, dev);
 	WRITE_ONCE(dst->input, dst_discard);
-	dst->output = dst_discard_out;
+	WRITE_ONCE(dst->output, dst_discard_out);
 	dst->dev = blackhole_netdev;
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 75a1f9eabd6b6350b1ebc9d7dc8166b3d9364a03..ce6aba4f01ff25a8f9238271a7ae2295f7c7bb93 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1688,7 +1688,7 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 			new_rt->rt_gw6 = rt->rt_gw6;
 
 		new_rt->dst.input = READ_ONCE(rt->dst.input);
-		new_rt->dst.output = rt->dst.output;
+		new_rt->dst.output = READ_ONCE(rt->dst.output);
 		new_rt->dst.error = rt->dst.error;
 		new_rt->dst.lastuse = jiffies;
 		new_rt->dst.lwtstate = lwtstate_get(rt->dst.lwtstate);
-- 
2.50.0.727.gbf7dc18ff4-goog


