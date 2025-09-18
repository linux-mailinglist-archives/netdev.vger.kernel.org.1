Return-Path: <netdev+bounces-213062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B28B2312B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC1D6874FC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5862FFDCC;
	Tue, 12 Aug 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f27eVGp3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA22FF17C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021545; cv=none; b=Xl38ptp3aZ3K+lUktT3QCnMohsgyJ7d0JKhand3bNPlxOsAEBlTQ6yIa9eZNvpfEG2ezLkx9Xbu2rcP5PvSl9DABj4SOLWhm1USmescy37YPA9I4B1YzXg07NquraCkfnNHC9/H1KlbOfGg6qLz8rCYd3+aH/J+46LTXnuKp4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021545; c=relaxed/simple;
	bh=Ax2UdSGe76cjX/U8fn+wOjQ7zXwBXHN69rzEWx84VMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QgR6ewU5FYqkfjPM3yj8q35LuexudsA4VopqNWpzhH0bCP+DMKRPaRAnNHzfGcOE/5cQ24JEkw7yWAjOvxNi0Jsuo3Qxf1XcOlBWkPYEuzsXthjXTDqiqMeplN9FBPy6kNYOLLewWXXw1hJfiEaCkE8q2SDo99wFICJp0mIkQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f27eVGp3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bf73032abso5804095b3a.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021543; x=1755626343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UE7+fyIYJB9pTP5Kh5RXBJc7LN9wQtEkFd8ieoqRGBc=;
        b=f27eVGp3wm4Ltlw7ThdLr/oPnGlyN+/NMO7Vx4CSjTZhc8i5Qa4ddpV4PiTOCVa2t7
         SdMiYr4UOUz02wY/dcmukbVs/bGPKAEnipIl38fwrOb7DHw4glcFHkDKob7aPc7celug
         /l1X66yPhftPdE+exG5TrvNT6LetIHwGNww5X+NbJceRwwH4nfpP6WoFKnU0VMy2npzi
         cc8EaDgXF3110UjKdB7qwx/FW+DyEyxI7L4re5t6qxiFVn2w5S+Fn3cevEnQRMl1uO2D
         +sFHDpMD1IgGfTfEys977XEfNoP0yqNMbCPCiiyP/o/Lu5389rkRuawhT1cMY6CL82oM
         j59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021543; x=1755626343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UE7+fyIYJB9pTP5Kh5RXBJc7LN9wQtEkFd8ieoqRGBc=;
        b=fiouP/VCwpPbB3j8hMGyfnQeNQfdl+pD3aLtfm22T2KzxBBI8yjSvD93gMHmZuduGI
         dZaFH3GJHC1wS/2IiTCkC495UmkZQy67kUX4YeEnrmMnfkMA0HB4sLXuauokVNurRcvZ
         lAEpEJmIhZJpcVsS9hZATGqW7ZIkdqkgXBJRCpUiO4tk0WuD9g+lYy2oLkI7pOHac/A/
         zQbaEWsATokbfClKVXoyt4DgMHkjXcaaSYeyeP68khliGrLZ31M5gp6M3zWw6NdTq/VN
         1OxG0ZL2ysXRu15gyBwTT5TVBsfhkg+jFCQXPOH+/Hq+UDOVOPspxyMKjM1jzNkWR0Gg
         XSag==
X-Forwarded-Encrypted: i=1; AJvYcCX30aWuPYyNt+isiuSgIwTgO4gCPqbqLQq2sHTdrEVyvFiGm8Jf9Jdkt3/8k1cwoFwo8wh0GAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypyTeXcXAFu52QcLn8w92ljI1F0CiqfcllgSElRRpq0zk4hhhA
	7FnREtLywPMSPQwbSbhgy/qdxOZTObmN+S+e3shkkYjp1hkTvJYR7ug1/w8Hu4kWZ6bFyR1P9tH
	M0VQVRw==
X-Google-Smtp-Source: AGHT+IFtBSrb2xrrpV4Km05LIJWdOq8vUPj5EVaB8QdNd7zmXRO48lhifltEO3FaesYyLeoc/sVTWfW8tqA=
X-Received: from pfmm1.prod.google.com ([2002:a05:6a00:2481:b0:768:7cb5:740a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1910:b0:742:a82b:abeb
 with SMTP id d2e1a72fcca58-76e20c9bc63mr181842b3a.2.1755021542861; Tue, 12
 Aug 2025 10:59:02 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:23 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 05/12] net: Clean up __sk_mem_raise_allocated().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

In __sk_mem_raise_allocated(), charged is initialised as true due
to the weird condition removed in the previous patch.

It makes the variable unreliable by itself, so we have to check
another variable, memcg, in advance.

Also, we will factorise the common check below for memcg later.

    if (mem_cgroup_sockets_enabled && sk->sk_memcg)

As a prep, let's initialise charged as false and memcg as NULL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 380bc1aa6982..000940ecf360 100644
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
2.51.0.rc0.205.g4a044479a3-goog


