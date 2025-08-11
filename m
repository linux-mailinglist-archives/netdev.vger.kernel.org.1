Return-Path: <netdev+bounces-212558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBB7B21343
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032AE1A21E4D
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBDF2E03E8;
	Mon, 11 Aug 2025 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYEbcU6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800A2D47E1
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933508; cv=none; b=T1mhciJKRfelMqmleMkT6MPimr1nGT+8GUFH8BfnBsaPHLk92U5sx4GOWfUWZXDBQOMydi9vSGUZIjzcfpIULi8B4Hs5bRSytmAKGumDVvbduUbgBWYeK1T1PpkifCiAiVfHdYrfJnbU/niureD3LCPXKQZPAZUdeTh+LTq7rKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933508; c=relaxed/simple;
	bh=YWgmeeUhSBtdIU2IYL8FWGMjBkXvcKxfNS9et8o2ZvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2jj9wCuv0a3/M77v7P9wX6m/7SCXAn0tIn/yjjH6Kj5ZgUD6d6IPzb/TKrgIku6YfQyiAIIEgE0M2VF9sDhqsYliiMtOcZvV7QSd51DIMAcsqgjTTzf0lghZPGyGK6TTn/8kr4fW490W/WMNVaufPKC98BdKUgCtTUEiEAriQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYEbcU6l; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b46e381d458so1969888a12.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933506; x=1755538306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmnhomKCr3e2ahj1QMW8pKbPe/+04IGBoELpRw2IfXA=;
        b=hYEbcU6lLM6cBawJBbbY/3abZ7r4xEn2nwCF3xju44xlGVJh9BcmZEKrhfuErfLYry
         BdKS9WEWWtdIeufVmnH91Zz7IbiVOI4nAbaRCRCzy8FP4QxXARi7UjiSNidbVKu/ewrE
         sUWmoNhrt8yr3UhBQav8PgmDyklCZuW2RIo7YCuFu7+p3Fz1HXJqEHezyyJ2VtA23Z/x
         jFG6Q/znJTc0IsabOkUsiIreQnXrEn0k691FN1B2KgX9SwbciG/CVk9qDoTaDebH3dEv
         u1ulhrKCp8yCrlx43COq+3R48nm9OcvDboputYEHT9n/rZ3T4ad54uMV4+v+LcmG5K/j
         pZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933506; x=1755538306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmnhomKCr3e2ahj1QMW8pKbPe/+04IGBoELpRw2IfXA=;
        b=LPbyWcclEClQTW5ZZaCeVqFC47JPE73Zs/oRbmzU510eHNiLngeoMjJ8zkuohzquwF
         4xhWO+iOrJ/MmZIyytNQ9WNgvzZO1lwLjgeAE0wwd+7unWEbCr+N1MUzGYbx6+h2HfTe
         ePjsraaHfKE+rXWpbKaRC/3XgnAHab2cLVb06uW5ftqqdn4uLqbP3xLDMe7LBAw5QjpI
         MezsNbuThrg0DkyKIFabpGGspQXQ9C8bOjZ0HU/zacL2XGLZeO6CK/I4Hm55ifHnUw+3
         uwZABOCZYgYA5F8QvSeF72t+u4S9RMe5Xhq3cP7wBpj7J/OTS1r49s1WsBtxG5Mg5pKe
         Pzng==
X-Forwarded-Encrypted: i=1; AJvYcCV8K99TaTl0Dlu3zywKr5sB3y4vlXT97McfPF+Xlzflmk2GEp92f+2dDlnFvBwCNsnDT5uDOkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HfdU8d5SECRQeSL4HPfnJnMcdIBFX8mRcMLL3lu/UP/E+GOj
	H5tc16tXqSzRUieZHqwnyjcVUjRQJMRrsIzuKn/VC3FI0icc8Zh9IpgXnjsbgazZpBlMuR9I0/c
	GaK+Azg==
X-Google-Smtp-Source: AGHT+IEbQbPObtr4lDb3C6IUSrTWzurWfQ/uCHMXicVSCI8UFHPyb3Vp4pwMwBuWD+yHcnEb6yN4kCs20/w=
X-Received: from pjsa15.prod.google.com ([2002:a17:90a:be0f:b0:31f:26b:cc66])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ace:b0:234:b123:b4ff
 with SMTP id d9443c01a7336-242c2011167mr203387105ad.21.1754933506388; Mon, 11
 Aug 2025 10:31:46 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:38 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-11-kuniyu@google.com>
Subject: [PATCH v2 net-next 10/12] net: Define sk_memcg under CONFIG_MEMCG.
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

Except for sk_clone_lock(), all accesses to sk->sk_memcg
is done under CONFIG_MEMCG.

As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 2 ++
 net/core/sock.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 3bc4d566f7d0..1c49ea13af4a 100644
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
index 5537ca263858..ab6953d295df 100644
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
2.51.0.rc0.155.g4a0f42376b-goog


