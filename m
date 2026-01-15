Return-Path: <netdev+bounces-250075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD4D23B77
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7716D3111A1C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1867C35CBDF;
	Thu, 15 Jan 2026 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTp67Mm7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B575C35B12F
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470112; cv=none; b=oTTadajaJibzfaL4EJ0oEkhKIgC3iG0OYxgJn5iTliYI8gh2niHiYCBZds7ulY+SJMOTl4Ik0ssT1FN9a52Zh1pDGnN3Ym8t/8CXpLpMZ4qQwuKlX/GUwSB7sua8J960UHxQnSU/c7gUQ4O8optuJWlpxs5E9lO70Hqnp0bAXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470112; c=relaxed/simple;
	bh=Me7QBe4Poa1fvRvVaD12IVmgp4N4I+1yyMJNzi+1BGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D4pfizHTXEGhaon/OJ4/loDd9Z2PCwr09l26dXiN8GgNjqwUG7vGsKcUbwH2WilbKqLz7ylz7ZH/w9l9S5grJBdJVcVEIoPsWHPnAZrmA3PiHwgnFOozev4V+Y5fDxFvbK7CHqUi5USSOHo9pxPjbkvUnfwedfXAvjHrIgjFDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uTp67Mm7; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c5329ed28bso183151485a.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768470110; x=1769074910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmdgyn1Vyxvpwo30BDLXQKLVHbwbJfuhxkraa+dbSLs=;
        b=uTp67Mm70YScH7ulYZ/ppPICiOZS4879luseP7EOE0YMosuVdnuFCt+2cBFPOIxfKU
         ZWkXvjW/OrB9Jwet4AiqaHgDJq4OCAdNRFnqQHXW3wdwo2MK6eDuBFDdpcEg7BL48tBr
         MMwEzNG6TYhXYv0it05Ji1BfbRBRa7O80MqgIZQiSD14sjbL4Ru3UpC8RQddLVoZvV6e
         OhtbBaZOqoyVcRjPZcMsVaC0O2+4XN9MEaYlm3Lq9I9ampoiJeUMJKy1Ro5btt06Eizd
         jOzMSStvuNsBcIlCdI7IR2doSLfy/adpNWFlXpJYCJyRHLd9uOesxmYjpEP9uVOkX8v+
         2Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470110; x=1769074910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmdgyn1Vyxvpwo30BDLXQKLVHbwbJfuhxkraa+dbSLs=;
        b=CdsqPN02K6JfTaOLtpy4bGCcPa1AEwIq/N3c5Ckcdz100f64oSJHIeNIP5GcnbGfUK
         3sIeqObXOIqmYn9IgSn9GZWK+nBZE3dwtjmXhMJJwI9uiP4qc5APQOas1GE92UTZYsCI
         DTMGPQx1iVoXFTqE+griI43kwB/we8hlmcAiKlvp4MImuJXTP40Eae1sW3tvmf36Y1fp
         FGXz2vMEsSYPq+Xq+GRaPtex70V118isHryFzqv9mo76ipL2aGHEMEnALyagJfD9aAKy
         dZhjGQtsP2L6dux+ucKhCOS1dVPvwBv1I+jPbSidazzcGh8BmgGiB+cuYc8GeTSfrLpr
         J8lg==
X-Forwarded-Encrypted: i=1; AJvYcCXpIpokv6xoBFkBgygrDtaxytoIFLNqbBEYBIQkS7zZ6AuYyDnDQ08w9k4SG6I90oRKs7UMtzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VkHzMTLH80nYRLlNktvc7FhappuithSCF/aq3ZPTtiXp2Air
	ssX7NqzWeBy/GhtAFfq72Znm3A7WLcQpkQ8W41WcmGnZuWvQd6xyqcv7iaYymXw0LHsV4IzXzfX
	10gOoFqAY23j9Mg==
X-Received: from qkkb20.prod.google.com ([2002:a05:620a:1194:b0:8b9:fa88:4c1b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4548:b0:8c5:2dbc:623e with SMTP id af79cd13be357-8c5317f3569mr703732385a.50.1768470109786;
 Thu, 15 Jan 2026 01:41:49 -0800 (PST)
Date: Thu, 15 Jan 2026 09:41:36 +0000
In-Reply-To: <20260115094141.3124990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115094141.3124990-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115094141.3124990-4-edumazet@google.com>
Subject: [PATCH net-next 3/8] ipv6: annotate date-race in ipv6_can_nonlocal_bind()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a missing READ_ONCE(), and add const qualifiers to the two parameters.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ipv6.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 7873b34181d9bbf18cc61522967e6db5d646813c..f39cd85e89123a06f7660868ef42c8050d693fbf 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -931,10 +931,10 @@ static inline void iph_to_flow_copy_v6addrs(struct flow_keys *flow,
 
 #if IS_ENABLED(CONFIG_IPV6)
 
-static inline bool ipv6_can_nonlocal_bind(struct net *net,
-					  struct inet_sock *inet)
+static inline bool ipv6_can_nonlocal_bind(const struct net *net,
+					  const struct inet_sock *inet)
 {
-	return net->ipv6.sysctl.ip_nonlocal_bind ||
+	return READ_ONCE(net->ipv6.sysctl.ip_nonlocal_bind) ||
 		test_bit(INET_FLAGS_FREEBIND, &inet->inet_flags) ||
 		test_bit(INET_FLAGS_TRANSPARENT, &inet->inet_flags);
 }
-- 
2.52.0.457.g6b5491de43-goog


