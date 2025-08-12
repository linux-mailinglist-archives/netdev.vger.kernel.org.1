Return-Path: <netdev+bounces-213067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C6B23130
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0134C1898DDE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDE02FFDFA;
	Tue, 12 Aug 2025 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6fSTA3o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5682FFDF7
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021552; cv=none; b=nw1sRO8iyYLbuiExKP5E4uoXkzwLGPHTH7jHRB3df6C56CGpf+frMjgGh+Ii9md12mUbHCLe7aPdCoqDLGRCyqmytGw4F+1swM/td4CBcE3oLzT7/XzzhjhmtpeFb63CXK4qsUw+oKi5g+LZh4b5sAmZJGOS+BoNUZJy6vkJ308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021552; c=relaxed/simple;
	bh=6MrgQrtYS9YcOgA8JGsGDbYNAfgLSAk+AgWzk7gDK6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q1qOeSRZFzPGMndqlb1o+KmrwCKKwMhEMxOaPfBKxZmj97KPsH9YCtPuBHvsVMoPJgUU75nM5oVLk5izjKpHh5j8q6EdSLe+/h32ZQCVvX8HHfI6qRykLCbOOEUWIExV62jn3bQYuegzLt671gQ7ZeYF6ONT80LFi7WwMHKK2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6fSTA3o; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76be7fe3d65so11445572b3a.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021551; x=1755626351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KhRu3fyzeIM1cEVseI3UE0mtgEXOJWM2aq0opP5CZE=;
        b=h6fSTA3oQgb9XSyWSPoLMfV0VRdX9HXdqi4iluakej0itF23EpSXMeZFzNbscR4ar2
         snPJm/kimTh70Id8L2byIAct9/lai+Qyxz9hmFFnQi+7RUnTDx8kPoasIFbYurA1KYlg
         YgMcgKVtbTdw/qCiDPUVlAWQEX2DP5eKAhDUhSZ7tXZy2JcKQvR9E0tTJrLqf/EMms2N
         5vMXiRcnsREZ6ijLwXm5swA39IpZnww/yBzTzPY3nt0skCWvLLC9XK2vXUMHlGN4L/FB
         JqyTIdOhh/Ur2e5IWV/fEtbaXc2H7MEVimfDFFFTUA71GweX6avonOOH+VOOKg6wzu4n
         ZShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021551; x=1755626351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KhRu3fyzeIM1cEVseI3UE0mtgEXOJWM2aq0opP5CZE=;
        b=jrDAskk4vdm1z+Z28u1MPuzGNVdeOwgtrEIMQp1qmQqAIEw77omYM7L1upl8+idDrQ
         BPKxKjQPzRZDDgR2gZEawc6uWj+d90uY0STUsylVWiEsMvdD1dKkU2fFKLIwg5CmNaVF
         r8fJ2IvsuTUdmSTDf3lvZ7c1yYXeyX284D0svFjPk3QeD813YLSpdC9LdiBNac4h5ClW
         /ZEen3p7JSNTuGUL9u9dWHB5ZAFL1Glq8sSGhN3MC4x7cRshGXUhArN74YgyD37voW7H
         fWXMhnnsonE1WFqyqhGrk0RmVLF/FCV8Ij05vS9YGdbgruKKyqA3c4KxUCu6O5+9YiMf
         GLlw==
X-Forwarded-Encrypted: i=1; AJvYcCUox8HUXzRh8jedlSVSkfwlU+lAy7CkxZf9IZCczSllqw5KZTxEOla7VYAWleUF7Slny/UZfuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzydMBkl60Ew2ICh1NamcKooA7QIGMSsixn/ZizhlOEDygqHGZw
	cBVJD6eoFFcaVAhoyDtcpYUQbGyIffkYEIQEOP3J8f99LbJNCvXoLgstptzLSYRimwryXOwyUaa
	EthPIng==
X-Google-Smtp-Source: AGHT+IF63iH6Z4gy1nQZqVIq3G/a8abCEtoljmxhNBcGHE63GfGOSxTYCt4U1CIor9EBnSEyEuEehfcKfyo=
X-Received: from pfblu26.prod.google.com ([2002:a05:6a00:749a:b0:76b:ca57:9538])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:66d6:b0:746:24c9:c92e
 with SMTP id d2e1a72fcca58-76e20e2515emr199538b3a.8.1755021550862; Tue, 12
 Aug 2025 10:59:10 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:28 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-11-kuniyu@google.com>
Subject: [PATCH v3 net-next 10/12] net: Define sk_memcg under CONFIG_MEMCG.
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
2.51.0.rc0.205.g4a044479a3-goog


