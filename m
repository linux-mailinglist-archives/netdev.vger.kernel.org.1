Return-Path: <netdev+bounces-238663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D652FC5D0C4
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F0324E3A29
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60099314A75;
	Fri, 14 Nov 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enitSlkJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03783128AB
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122369; cv=none; b=n3w3ILrGtMsl1CxE5bwLqSdEkMNiEN4MTl6k5HfJ5eqXRLk520fxtIphdlhBSL9KlZyPbXbRdVZH0wgYg/5lXEwvn1lolzsmqI1LKNP6kdE1u/8FHmP0HtRcolaIw1qkKR8YNj0qDuby7/tlgSiIXjg0OKrK/yhf9Rt1gAsOy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122369; c=relaxed/simple;
	bh=jmhFeM7KUC5lXHxTzGXScPXnvmD60BjarMDkJUmePWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UOSbjiPkjqOypQJH0+Suh+gw30kj/5GaXtJ6AHqwYg4jSYNrKE1HQWnR8pqKig+yEFVcGXFJBKfb2+ONCmdXdj2HAP/b6OhXwPSyVwmP6IhRXhZvcx6TK+IBbVoqIIxkgNbQJJYQfOa/hnzVZnFzK9kCh0JOrFctcYO9Z4oV4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enitSlkJ; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b234bae2a7so590693685a.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 04:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763122366; x=1763727166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzd6Qe6zazmrenez7ejtbNEz2gDxYKs98VgwUaUAxSk=;
        b=enitSlkJO8VzEgWJdUE9v0X/AtM4oUj6g2Kk18jifWlfRF2b3gNJfXoQQEqamNPGf8
         45/xHnze3ftOssUPkyBi4nj2rUgJzeHT7/xAxciWP5B8A/KuLxwU3QYJit59zXXCTG5Z
         GBf7j23QYD1Cg66sL7JZzyxMWne4fVSgz9/ZXjfoC5LauWjdXb8MYDVehgy4EGcTggyU
         xupTm3DCpRkt9BXQe0Imfx0DUJlCLsQS0snO24WeXCKOF75jzQ5PiCeFEW6N+BzvHNq4
         NJJon6lJcMWQZ1K1wjL1elnnL6eDAi7JtiZIy2App6uhJ4NxWb08kTXH9C+MLKSBwJGx
         j5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122366; x=1763727166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzd6Qe6zazmrenez7ejtbNEz2gDxYKs98VgwUaUAxSk=;
        b=vM96TbdS+3HdRd7+67I3es0PCvPXBDi3AyRjgpVC+75P4l0gjAOPLuI1dqg1Dczupk
         LtGsR1Ax2UGfs8bXH9Z9tvg8w30dZwJKsMQkoxF6tXBdKpVsCgOXRgF2q/ccx+g8fBmN
         22KGh2ORfcECxwXqh3M/d3WpvQiEHSHyKsQQOKtdIBV3/3M7lFcaMdgONLegzb/JtiNC
         m6RmlpPmWTb6wZYb93dUF4TJY8QotFFYuPglDX24nss9LLcgQ7dfB2xvmBXEyIcJKXOS
         iXrCVWCbFcQqjQPm1k+UFWjoKrjuC7hjV9CHBXiXrGPcf2QVyp96PZ16R/rZOCxvpOIO
         wOOw==
X-Forwarded-Encrypted: i=1; AJvYcCXlj+HBHrS0tEhQwo/rm/3J9zIDFFE5OFs7BKBJk9dzJM+DIh1r+rta/C1efON8lVKi/K92P7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTt/o88zLOtAjn1xfzA07vaTIxZZnwW8q3DOoajUEKKowAa8+o
	yhubequYDOyCurrUyik4++v/B3wwqmGtg+kz16E1adKSXf4l9YLaA9W7oaTA5I+JmOc4mQopxNN
	uhuKOBypWx8znQw==
X-Google-Smtp-Source: AGHT+IHn8olPctvDwcgr8KpCx2EWdiXlNk5YMkmgY0J9vRHEttzBbiHruf+hUcZ/mhSFWv557K/3PDJf68CG+w==
X-Received: from qknpq4.prod.google.com ([2002:a05:620a:84c4:b0:877:a2bc:ae2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4156:b0:8b2:59f0:d161 with SMTP id af79cd13be357-8b2c31d272emr305534085a.89.1763122366493;
 Fri, 14 Nov 2025 04:12:46 -0800 (PST)
Date: Fri, 14 Nov 2025 12:12:41 +0000
In-Reply-To: <20251114121243.3519133-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114121243.3519133-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114121243.3519133-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] net: add a new @alloc parameter to napi_skb_cache_get()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to be able in the series last patch to get an skb from
napi_skb_cache from process context, if there is one available.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f34372666e67cee5329d3ba1d3c86f8622facac3..88b5530f9c460d86e12c98e410774444367e0404 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -280,17 +280,18 @@ EXPORT_SYMBOL(__netdev_alloc_frag_align);
  */
 static u32 skbuff_cache_size __read_mostly;
 
-static struct sk_buff *napi_skb_cache_get(void)
+static struct sk_buff *napi_skb_cache_get(bool alloc)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 	struct sk_buff *skb;
 
 	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 	if (unlikely(!nc->skb_count)) {
-		nc->skb_count = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
-						      GFP_ATOMIC | __GFP_NOWARN,
-						      NAPI_SKB_CACHE_BULK,
-						      nc->skb_cache);
+		if (alloc)
+			nc->skb_count = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
+						GFP_ATOMIC | __GFP_NOWARN,
+						NAPI_SKB_CACHE_BULK,
+						nc->skb_cache);
 		if (unlikely(!nc->skb_count)) {
 			local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 			return NULL;
@@ -530,7 +531,7 @@ static struct sk_buff *__napi_build_skb(void *data, unsigned int frag_size)
 {
 	struct sk_buff *skb;
 
-	skb = napi_skb_cache_get();
+	skb = napi_skb_cache_get(true);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -659,7 +660,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	/* Get the HEAD */
 	if ((flags & (SKB_ALLOC_FCLONE | SKB_ALLOC_NAPI)) == SKB_ALLOC_NAPI &&
 	    likely(node == NUMA_NO_NODE || node == numa_mem_id()))
-		skb = napi_skb_cache_get();
+		skb = napi_skb_cache_get(true);
 	else
 		skb = kmem_cache_alloc_node(cache, gfp_mask & ~GFP_DMA, node);
 	if (unlikely(!skb))
-- 
2.52.0.rc1.455.g30608eb744-goog


