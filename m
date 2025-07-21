Return-Path: <netdev+bounces-208686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AA0B0CBF3
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 22:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC097A8F4B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D491023F26B;
	Mon, 21 Jul 2025 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwcpDCEt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667772405E4
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130196; cv=none; b=c5NFmkZ3Wcqo2U4Xk36E3AISM+uW5DRBLlTE/DHTpXrQFOBRE4mgsmMO/0wg3A9prJF74SLumHyRsOfMr3xBEUxZlOJXJgPpS2Lkk0NdAzE3WYZAdLls7eULvxjFvGdYnE54DKxwOAFHKrzF5ssHNcgkN6FdFf9MlGVenf+8ISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130196; c=relaxed/simple;
	bh=x6W9fSLS0sdD6u16GfcO5OEeoEdgWbD5AwJHjH26y4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FIqq/EN4TTl/yZ8pKceDRZ+d6yMNJgcsdxH8tyPmGp/9I5d5R7WWjRK8s4kFtFfpfqESKEnSDiP12hes5ESB5P1x8cCwM/TDh5BnPZf7hs5E9FWrOWN4bCQPx4CjqdMKXTHZnfd/dMq9M5aXNHMDaLOU/GM50q213XpX/dK5HyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hwcpDCEt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-756a4884dfcso4489847b3a.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130195; x=1753734995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I175s6NxGih3nP7OcDsLqMOyvojLdjw63UOF+xheMJ4=;
        b=hwcpDCEtClqZWlpuM5v0so8CaBaMj/tWZTtFturxpJR7wnSjez0ijBKatjsTeTxdAQ
         saY5JxVUGRcFAAkieCO6Jvhr5VvD3BobcgjOlpFnBc3DGnn7iuzKSlK0GkLLTa5G+rZf
         r2FEMeSDnUC/IDenc8o221Lvq8YztMA6/rwMVyDEN4a5g2Pt3cI2et7FwA65uwUpqPzj
         RmBGeRznJzjbp0hhAoKeMJ++S56Kt/yyZqF+5oWI3ajpuDpOUcPWmjS1lU3kx3oA0CkZ
         yXz9+KB/PCspQ3lmE3du6bUIhuXL6Oszhrp4h7M/alUGMnClEjA1bHrazxPF1s8qsuiQ
         BCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130195; x=1753734995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I175s6NxGih3nP7OcDsLqMOyvojLdjw63UOF+xheMJ4=;
        b=eVVXCmh+CXzr0VfFOOm8NOwVUukY9uLki35laThuYlmAix4+OexzgeqqfTkZOk47sP
         YSWGek3VvPg+i9nlgXtYjLYHUiFD2uvrdWEQDcCltT0dIp40i9GYBvMZN/p3LbJ9CMhd
         49z0LgaMj53oIgakaH/jnlHwlkkx+aeR+9566VHMj9Zke1K84LHQghlbG4Y9OeoY1ysU
         UWafhnAO7o1o42yTPwXgAhRsrPwWtVODY6HZm2gd2zjjpEyGTgfvzWbrkBgusSxecbIQ
         XPkT7Uhcu6TRxZ2wrqy6xkQi8Dms16ATniMf2gv8p4eir1/VSFY0s5QFwZ91JIltq7Du
         269g==
X-Forwarded-Encrypted: i=1; AJvYcCVRVoujXNFKEUWNQ3X+R9tKAnZwasLwuHVCDBTBbzWM3rmB8/lcGwOHCz6vYnHzYoWQJ/CHb04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkc3Y75/0qWr9VWsFFC8e7/oSXHQjMAdXqKUz4jxUVf8DCbaS
	Zy6rfp1TPXnP/1MAKWFY7naFX5rBrPnPgq7dyeCbq9sNAYmNX3mbNvFVDsSR7VPxOJLnJ3HPq7g
	H9KJtBw==
X-Google-Smtp-Source: AGHT+IFv6U7uHL2iBa9yupFYshgEXju3eOkU6QMVmKj+fMe7znAZlxzbdQTya4Ql3pAJYEeoSFGsqqqmF3U=
X-Received: from pfay32.prod.google.com ([2002:a05:6a00:1820:b0:74b:54a2:ff33])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f86:b0:730:75b1:7219
 with SMTP id d2e1a72fcca58-7572466bee2mr28714696b3a.12.1753130194603; Mon, 21
 Jul 2025 13:36:34 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:24 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/13] net: Clean up __sk_mem_raise_allocated().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

In __sk_mem_raise_allocated(), charged is initialised as true due
to the weird condition removed in the previous patch.

It makes the variable unreliable by itself, so we have to check
another variable, memcg, in advance.

Also, we will factorise the common check below for memcg later.

    if (mem_cgroup_sockets_enabled && sk->sk_memcg)

As a prep, let's initialise charged as false and memcg as NULL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/sock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 380bc1aa69829..000940ecf360e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3263,15 +3263,16 @@ EXPORT_SYMBOL(sk_wait_data);
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
-	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
 	struct proto *prot = sk->sk_prot;
-	bool charged = true;
+	struct mem_cgroup *memcg = NULL;
+	bool charged = false;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
-	if (memcg) {
+	if (mem_cgroup_sockets_enabled && sk->sk_memcg) {
+		memcg = sk->sk_memcg;
 		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
 		if (!charged)
 			goto suppress_allocation;
@@ -3358,7 +3359,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg && charged)
+	if (charged)
 		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
-- 
2.50.0.727.gbf7dc18ff4-goog


