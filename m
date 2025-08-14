Return-Path: <netdev+bounces-213833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E1B26FFD
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60B17BC553
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C25259CB2;
	Thu, 14 Aug 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZutnoSJ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C02580FB
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202164; cv=none; b=O3IAjCvNvPtcbihWtHOiiqANDdKHqzQ3FRoOgKbLOUuNEq++Bip1Z9Rae6bTydlkjK+GjizUstl42ZwtuThQv2wnzQx4Joh7W9zAa8zXIF1oiBI8iH0EMb6/zlAZfAryPffRTZk0GhQmBtkq+0qblTzbEcZDgWIYASY9nM1G8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202164; c=relaxed/simple;
	bh=49AUVqRZ9QX0gApoGVu2lLYolROcKxAhbfDoW1MZFwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ksNnaDKU48cTTky3fYxtAofOg3qh807TQCsG7UK0sBLDbBgqHESy3+LSyG3QA2Q7EpzWlrWFZQsg1zZkLQGhMt6XKhodBjl8nHk5usd/c/LcF7Q4Lx3BNR3/Po2o+2vyS2/jWKbsFMtf2k1thUDPrpJV1YBNQA3Ucw5ux7RBFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZutnoSJ/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323267858edso1387466a91.1
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202162; x=1755806962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLtDPiqLV2EwRjVXqP4rO8+jmE13TnvcBQt499JidQE=;
        b=ZutnoSJ//j5oPGzwwJqhvyGJzAe4lHkOMeSNcHIn82MOgnj0X78gWTXB6KAkAzVZpv
         ZKsG+sPgbDPacbI0pUy7VtLEgBenLmuu9DcPxM54ibPgwrwA+8Sw8HyXNd7A/LuBjwdZ
         CwPozYWIlC/SeFLC2KOPev9DrfTCaY1CQuyEncw5c2tV9jPeTJHsRYWFbNvWdlmkURaK
         /DEy0XnJvxpRcxTg/j4H4o0KSVl8uvcnXXfqmWmDGowcn4jYjrlohz43wupiBivdwqSo
         fH8CakeU2Pdy/Lhy9fkmm8yFrLdiJL/4wpJQkyJr8IzjlKdFal3Y+EdYA1q6pw9lpd0I
         coUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202162; x=1755806962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLtDPiqLV2EwRjVXqP4rO8+jmE13TnvcBQt499JidQE=;
        b=E8vwUZ8nb740EsVvTn6NgDGS1amHiXpv0XrKfIUW3G4QD+O6zs7mjw9y2KiwAZXKba
         +ju7g0tMOl5pFoeOl3KfOa38yg0KJyie9bmBcgQOq1BoCMpH0Pc54JpzX+pfycynQVv0
         u20H/23ZbCEnYH+VK1m71MmakUhSSx4gpiZW0SRFoVTYOLvWkPdARSwSKObR907G+ZDp
         LUISuzyE5XGtDj5Qx81fC59i5QoYbqXC6UZ8srodgFO4x6TyZIcU0v4IIQBtI5gM9UXQ
         wJsvTDglYDVPfdQ+ZxI6kkfQLrAUVGZTr5bLIc+AARxLo72h9XNk+Q1tAmZsalPiONha
         Aeeg==
X-Forwarded-Encrypted: i=1; AJvYcCVfwdlm46Ul/AZ9h6ERMlskYEkNNSkP9jaLObKG1yumQ/gc82LmtxW2CjVQKTdqbWHXbMoLQZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylW3pWxG/EUVh0T6Z5m1/S/Yn6Z/gKiwPFzkqPK49QLijqVMhV
	CM9C2JjTwgn7pOna0Sxo1Wmn+bPzHNjp5gxCEAnr3pS2m8vKs/N1yt1PFVQ3UL1bPeLRq6fFAvV
	8ITRX+Q==
X-Google-Smtp-Source: AGHT+IEnzVgsHouLcYJ3DbTYMYM7D5PJ04rrOa932tYqe/x5EOD8K/0yHeBrLPiiLhvGRF5AWh06+mbah1w=
X-Received: from pjzz12.prod.google.com ([2002:a17:90b:58ec:b0:321:ab51:e32a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5246:b0:31e:d4e3:4015
 with SMTP id 98e67ed59e1d1-323279a165cmr7184331a91.8.1755202162465; Thu, 14
 Aug 2025 13:09:22 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:37 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-6-kuniyu@google.com>
Subject: [PATCH v4 net-next 05/10] net: Clean up __sk_mem_raise_allocated().
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
2.51.0.rc1.163.g2494970778-goog


