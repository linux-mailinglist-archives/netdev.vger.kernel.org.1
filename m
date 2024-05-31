Return-Path: <netdev+bounces-99745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6A38D62FB
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2341C25EB3
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78FD158D78;
	Fri, 31 May 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQgvjYmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F58158DB3
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162010; cv=none; b=WVT0NuxHC2GGFXZSsuhM8TjSky95/qmIh0sAC2wuJO8XRzeUot7M/tDl/aGmmLaOiu5KTDl+KDuDxcaWXjpDmqefbV2pRR3YrXl3XNFN+u1V8BE1HwlQo2OdEFTE1TBd/LWFJpwfaYoajk1lst3gB7ct7zG7yuKMlcwyaFpIc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162010; c=relaxed/simple;
	bh=KNlTnkDBsV8nziMJssQejEN4CWcO3HAPYGm6FmYv+mQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=od/qUhhq6cH7R2DMkz54EKzY3Hjcx6nJ1+sLpQvcN18lUom/hkWbnic6rdZTIcs/hZy+cs2UdiC0ARi+6m9ZlAB95kWzLQFabul36EZDWdELMEtdoSwWTfL8c2t7I+em/rd6SDyRDVmgR9WzI4iNgl7NAXozkcy/Vg9l/eSYyMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQgvjYmB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df78ea30f83so2736079276.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717162008; x=1717766808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzFv+SY48LLgj1OhmZZl89i+z/6akG2XkDSwK7PQQZw=;
        b=sQgvjYmBjBqKmdIBZ1MlUcEMzEkIxohoMH9+3UDNpSToLHmv1lk+pgoqzRJHdSOUk7
         Ox/DPWlCum8gSmCl8cogKuYbsL8usjx60FkbsF9t6UdMz8ak8IS32NXP/SnOZYazW0ed
         XDFbxOdg5/lUzEkVuOQPkC/npLotPuSN6Sj8BVQTvXblft0Cm8GqZdzI6SwiaYfTwMNN
         /PVUkMkxfPYg2oX2IhDKvJUO8sRP+b3UlsPopj5qIQZ8EO37vxbCrWuSZyWqfNZ1Zowi
         WIyRMAEZYVGk3FHxsVz548dq9xVHUfT8FIi6RNdcHrYvzUh6KYzpW9c9eu2Bc0Q7rmlN
         a39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162008; x=1717766808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzFv+SY48LLgj1OhmZZl89i+z/6akG2XkDSwK7PQQZw=;
        b=IiRh6qOuchBFxFN0+bAuQdkTpgddceDqws6+Bk1GaV8+d4BWEAqHcZvlitqvtzUiqf
         FGcI+x86a4MEM1bP92bDUViFb3rYIN42pn9Z4p1f86svkVkGynL8Xze330ebOE4qTIKo
         29j88jBguzL6yeMvkq4dcTnE0aGl3nn98t6I4vj/JSkjBdhnM9LnKZw5Fg3Do3SY3J+p
         o+Mni/OrM7ePjdBAgQFE9VoS+7tkawYMcSU67thWE6zq13l4CpQocl0ZM/nYGiWVyQZr
         +LNp9+wDcxqRNGx6Ux37wnYh3TGlgw8MesQcfWnJVhqjFBmh5ZuMMjxySJhpINpUQU5A
         x3BA==
X-Gm-Message-State: AOJu0Yye1ow7met0CqHuX/fO2uEkbxP3JlLomsAa/sTokPgZDRRoPl2M
	KkPQjAUgzm30UorQ7cP4I+qiTHKqVf61BB/zfnUFtzRcdmF507k3sXqkK8XaCvw6nObqbKL1iOK
	tobLy4ED2/g==
X-Google-Smtp-Source: AGHT+IFalLzplnnJL52I7m1bChpSBsJ/77O2b9YIWRnTCvpatWW5AsMR+gMyLoou/J/0NQF414B7AN4rAgIieA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:7493:0:b0:dfa:79ab:d5b6 with SMTP id
 3f1490d57ef6-dfa79abd71fmr242435276.1.1717162008298; Fri, 31 May 2024
 06:26:48 -0700 (PDT)
Date: Fri, 31 May 2024 13:26:35 +0000
In-Reply-To: <20240531132636.2637995-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240531132636.2637995-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531132636.2637995-5-edumazet@google.com>
Subject: [PATCH net 4/5] ila: block BH in ila_output()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

As explained in commit 1378817486d6 ("tipc: block BH
before using dst_cache"), net/core/dst_cache.c
helpers need to be called with BH disabled.

ila_output() is called from lwtunnel_output()
possibly from process context, and under rcu_read_lock().

We might be interrupted by a softirq, re-enter ila_output()
and corrupt dst_cache data structures.

Fix the race by using local_bh_disable().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ila/ila_lwt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 0601bad798221389fe83318fbb17f192cec880d4..ff7e734e335b06f03c4c8815163a706136e42a3e 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -58,7 +58,9 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		return orig_dst->lwtstate->orig_output(net, sk, skb);
 	}
 
+	local_bh_disable();
 	dst = dst_cache_get(&ilwt->dst_cache);
+	local_bh_enable();
 	if (unlikely(!dst)) {
 		struct ipv6hdr *ip6h = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -86,8 +88,11 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		if (ilwt->connected)
+		if (ilwt->connected) {
+			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->dst_cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
 	}
 
 	skb_dst_set(skb, dst);
-- 
2.45.1.288.g0e0cd299f1-goog


