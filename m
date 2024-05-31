Return-Path: <netdev+bounces-99744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C78D62FA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C98B26628
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFFC158DBA;
	Fri, 31 May 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJsXXPY4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4D158D78
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162009; cv=none; b=vC7lnDYNwrFJXSt+IgxQORveT99abiqOsMEPR54hETRCrymtYs8FZivbYEGKMtESVUL5xWxmRPnEScAwqNKMpna3tWpeyGJvGkCAjkZBIqX4ZKJw2qjM/CBr9ox4BosAyp8IWNn1SiV8bKqxqcRpVYHbojBWkZlPa7yBOACy82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162009; c=relaxed/simple;
	bh=5JX/hgkaAAFc5mPirvL1q/OEzQxWmoDIm+zvMGI7EfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sbwqtj20lYiJuvrf22BYMZ+ScMx2bN9lfRZCknfuw8IacIIQ7isSCi6baa/hoVXINpEjWAuAWsA2Y3JVuhtb0iai/OezKzkHfZAlj4jUuSThKXqtTYXiREg+/v/ZgdIQ/8TEH2cj/wLCZnjKoZ2/ZJ/NnRvKbY481CsvCg7fxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJsXXPY4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-629fe12b380so30418357b3.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717162007; x=1717766807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vfcI11qZU7qE+FpTMOhevSJYOshGXKcjG9WxwlWuDU=;
        b=pJsXXPY44R6Y3O1K/0mDGuOBU3onFHRkzwhjw7PANXtj4wL1zKOCvrn/Ig8eKLpEGU
         +BgJ4FGFIR+Xk/TB6HZHNf9j0UVuHW/KEZAV9MYauOZSkljI554sGcUNHngUngyMMXBJ
         b/K5RZFryj7Ya94KNYUR0wHiSVBdkW9oszAFzC9V2gvKSZjBBJbtWh0MXoAaIVHGF7e1
         kIBxrqTbYI7+EIz2bH/R/hPoSZlVD7PVlSUxDk06TPc4LzCAMtyfTTde2wmg0rloreX4
         w+SFAyIYs4rXzx9FGaZnWsygBhO6DDeErXoHwUMcxj2wC8fzfY8R0aRodOSffKigPFOx
         WE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162007; x=1717766807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vfcI11qZU7qE+FpTMOhevSJYOshGXKcjG9WxwlWuDU=;
        b=GgkdPbua+fvflQzXRpp0d5X20x8NR22DAITZ6rklPp/E+j9YxSa/rN3yfxltWAfpv0
         JwqggI1WAXT0rIb9fDHrEhI4XTVTWWo0QF7OPw1kX34DbJvMWurAfUfJGao8XpBrJ3VN
         y1Oj0mxbWrisCfvl4DpbyFFruG+YaMTnXnfe3UmTDPIheu3dde3T8QVT+1HVi5CMBoh/
         9HFqM90800hzXD7RiELVFl3rc5LeMnehD88XbmvmUPdTcZxwrgXsLeBpHLvvgP2AvCnF
         IMlc5y60VAESaNNPjhNfFygTNgnZ8BmQH8mZA+fJQD85Hkei0bTlgbXewn3eB5+lSbnK
         1pLQ==
X-Gm-Message-State: AOJu0YwyQbsHEQEo7fVIbIMIkwbrB7NTW8TEBhes4pkztYAXfsmPcDCj
	ofuSKkhXgsk4H2IIXCeckWNqTMW20OpRsxiyuq3LeS4nj63WXSxk+MRW/FD8hfar1fP3C+h9YI3
	1LN61UQfOeA==
X-Google-Smtp-Source: AGHT+IGoiO/2HfvRpHYu0ESN8gknNi7gHRuuQgyGn0D0ja5ORRie+gjEZK2b2v4MmONhZqghufGymr1F9c2KuQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2f4e:0:b0:dfa:57e8:a37 with SMTP id
 3f1490d57ef6-dfa7426ccf7mr95624276.13.1717162006909; Fri, 31 May 2024
 06:26:46 -0700 (PDT)
Date: Fri, 31 May 2024 13:26:34 +0000
In-Reply-To: <20240531132636.2637995-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240531132636.2637995-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531132636.2637995-4-edumazet@google.com>
Subject: [PATCH net 3/5] ipv6: sr: block BH in seg6_output_core() and seg6_input_core()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, David Lebrun <dlebrun@google.com>
Content-Type: text/plain; charset="UTF-8"

As explained in commit 1378817486d6 ("tipc: block BH
before using dst_cache"), net/core/dst_cache.c
helpers need to be called with BH disabled.

Disabling preemption in seg6_output_core() is not good enough,
because seg6_output_core() is called from process context,
lwtunnel_output() only uses rcu_read_lock().

We might be interrupted by a softirq, re-enter seg6_output_core()
and corrupt dst_cache data structures.

Fix the race by using local_bh_disable() instead of
preempt_disable().

Apply a similar change in seg6_input_core().

Fixes: fa79581ea66c ("ipv6: sr: fix several BUGs when preemption is enabled")
Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Lebrun <dlebrun@google.com>
---
 net/ipv6/seg6_iptunnel.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index a75df2ec8db0d369a4e3481576fc09f511a4dd36..098632adc9b5afa69e4b65439ee54c3fc0a8d668 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -464,23 +464,21 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
-	preempt_enable();
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
-			preempt_disable();
 			dst_cache_set_ip6(&slwt->cache, dst,
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
@@ -536,9 +534,9 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
-	preempt_enable();
+	local_bh_enable();
 
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -558,9 +556,9 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 			goto drop;
 		}
 
-		preempt_disable();
+		local_bh_disable();
 		dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
-		preempt_enable();
+		local_bh_enable();
 	}
 
 	skb_dst_drop(skb);
-- 
2.45.1.288.g0e0cd299f1-goog


