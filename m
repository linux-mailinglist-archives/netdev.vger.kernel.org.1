Return-Path: <netdev+bounces-208691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88810B0CBFA
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 22:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9F51894ADF
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FAA243374;
	Mon, 21 Jul 2025 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bjjvvfSa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCB2242D78
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130203; cv=none; b=Pldeai+I8SNYN1IzB2bMYLhKNUP/40TzjYWh677JGft0mTgPMm0yloyfCLa+JJVg3ChJDU86acVKCpcW9eS6pttfgTg1JeYMGGdBhQ6bsHyAlA5DU2fhw0jjPZcD1tr8Xu8GUrANUWXEiHrOr8NWnDiPrhD/jYwfLPo5LLoZiMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130203; c=relaxed/simple;
	bh=i5GAzC5L1kuCCltZ38C9FzfkiUrjLYUlG5NNBN2V574=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QKNFNb8qgLPBt0oWwfcfP7kFLj6Izy3ixAY8TtIrsy3HgnwlQmQcgY84FDjxq5gZciHJ50QTr36lWWCTG1S54EBI/2Dh+50KiX5ueN9eFtsaBRhosoo3ak/YDV28JxQohfh2zZEA9miBjvh9Py/jdAjoz0+EgtkoSeBUV95e/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bjjvvfSa; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3f33295703so3788841a12.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130202; x=1753735002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssPdZm4XAVciTYPYdUcIXie5OXrS2r8M4cSNBMi+lG4=;
        b=bjjvvfSatUqpb9wFl+n3o5/Jy9tp5CPAir/lSp6e+cozjksV6PJIgfu6udmzLWWwQ9
         P3TaOWcIuO1hSzwDmgslXkJgGBpREaLGWlf5RdbgMK3xTLQEoxJonusNA1iQqeciqxRp
         MOBWMwKPj4QN9AI1z/Zq2CldJCL9ge+/RYt1fEhA1AZB22YSbMYRpwYY3c9mJCj5KyZt
         7tX/8o0KD+H895LMPwko5HtG5r/PXMH+TrqU5fcXsPYgf9nTH9tjWNnpOKZntFbIzdgf
         wsbacbBrOljw3GEj/CQc5WDJOCrYU3a20618JowSrU0/SFtEeHyn8n7jr+QJWwBurJXi
         ukiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130202; x=1753735002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssPdZm4XAVciTYPYdUcIXie5OXrS2r8M4cSNBMi+lG4=;
        b=k14kyBop8mWBP8nfsf5G2HP+3MRr+G7mej9XIZa23+b5tn+3JWgvIoFF/cTQnisclD
         w4OR4um5fLgEob8/4i4vTPSF+w3PKGU6K37JnFlvzrvnRHeLTcK8I/v2yLRMAdpjRdM0
         VzLhSe1X9arbWlfi4BkI7V9gc9iYk9WG3ljR18Pvkz5DTlXaiQ4mkDX4mYucabKwstMt
         A+peqSAc//r9rwfDlNlmpLpvr4sINYZjEJB80uYKHrp8m6cAzWgi9VOweSj8ldGzV2jf
         v6CTikSNJDsf+Tx6/Hep/v+3yBAd/2uqruZRbGHgZL/x3Pmkip/daTGV8F7OeOcguwm+
         M9zg==
X-Forwarded-Encrypted: i=1; AJvYcCWYG/TRMlbfU3lWaKMfo0YovDm25megWC0/UJ9w8jeQPdF5y5M7k0Ylt9zR3UWiqkg5Iehu3H0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01RvCaeUV2FRTKQsVN10ZXpPj/ybuQr4lZlZIXZXzvCiZdc2l
	isIUGHBJ8eEWWr0CovBWcIHsFVjUV8+MBTrsWSp5fOihi0p9LgKCgcYAtuMD41bIEqHPQsYhCaZ
	v49itCg==
X-Google-Smtp-Source: AGHT+IH0bPuHNRYQE3IBCaVT7B1b82DZOEQMUavwyW5ZrY7G02YZ/hUnE3IIWK5LKSPidRIy8Lw1sZSx8D4=
X-Received: from pfblj15.prod.google.com ([2002:a05:6a00:71cf:b0:746:18ec:d11a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9188:b0:233:f0c6:a8a4
 with SMTP id adf61e73a8af0-2390dc51bc4mr34981014637.31.1753130201882; Mon, 21
 Jul 2025 13:36:41 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:29 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/13] net: Define sk_memcg under CONFIG_MEMCG.
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

Except for sk_clone_lock(), all accesses to sk->sk_memcg
is done under CONFIG_MEMCG.

As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h | 2 ++
 net/core/sock.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index efb2f659236d4..16fe0e5afc587 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -443,7 +443,9 @@ struct sock {
 	__cacheline_group_begin(sock_read_rxtx);
 	int			sk_err;
 	struct socket		*sk_socket;
+#ifdef CONFIG_MEMCG
 	struct mem_cgroup	*sk_memcg;
+#endif
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
diff --git a/net/core/sock.c b/net/core/sock.c
index 5537ca2638588..ab6953d295dfa 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2512,8 +2512,10 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 
 	sock_reset_flag(newsk, SOCK_DONE);
 
+#ifdef CONFIG_MEMCG
 	/* sk->sk_memcg will be populated at accept() time */
 	newsk->sk_memcg = NULL;
+#endif
 
 	cgroup_sk_clone(&newsk->sk_cgrp_data);
 
@@ -4452,7 +4454,9 @@ static int __init sock_struct_check(void)
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_err);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_socket);
+#ifdef CONFIG_MEMCG
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_memcg);
+#endif
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_lock);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_reserved_mem);
-- 
2.50.0.727.gbf7dc18ff4-goog


