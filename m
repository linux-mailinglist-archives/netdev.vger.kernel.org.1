Return-Path: <netdev+bounces-213838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B4CB2700C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F291BC283A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764B2260586;
	Thu, 14 Aug 2025 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XthCeYqR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9AC25F973
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202172; cv=none; b=E8PUGrYiaJ/GmqH4Qu6J+yVJpZZLWOwm8GDIOFM4VagOul2IGV8ewgQVadbeTKRmH5QuSM30Y5yE/it0PiWCvwhDiIWWLXD++Rcg2ue516bXXCT6C9e6iJlM98ZOSb3dNWGG5kQ8SsoxEPruE+6wZfNHReV/NKNL5bTGw9csDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202172; c=relaxed/simple;
	bh=uNJ0DbaVTgLxqMO9rrZlPFBGceNd4I5Fu6cwHhD2+Os=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BsDhEkgA1eXToxTbt0rf4UTbR8xHqTfIoyNdydSe4NnLR9n8u5tlDhNyFB4fAPd/c6B2leClUU3xZVzDkjJYuxjCVN2E3IcNv+IG2QoqbWu7ETIfAEp2zD1MCZw3KcFCN2/Yz7tEYUdz/xkXd3ad5OT8HihXN6o+PbsyU2bcT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XthCeYqR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581c62faso12866145ad.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202170; x=1755806970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UARZd9qLkSRlP8HijwL/4OYfjtGDpQLLXgE19FfQX14=;
        b=XthCeYqRBYs5V6GXNZHWb6I6MG33rkXQ63dsNy+v1cMOtDxtP+orieEIrF4shMSmxJ
         lSVrk0FuRNDs1rgGQrv3wDlJj/lgyTady7gpLuBKyhR43b+kdB3qATt5yrfijZKNzkrV
         7pJhsRU0FDYFsOrI7VMB45eykWqMGjCiNl66VJaw1EPe9ep0R7xQnWZVgGIzE4T9ypIB
         ffueWPuy51sPH3xkyAEKX6vCtWqPf0vDTguklRbMpDiJSLzpRb8mK5Gsng73iUTtbUVq
         SNQiP0ktRYRwOzlZDSqvcD1yOBHSI7l0NGsRMsHUHCbTdq1CdgvzUK6kd4jGEcnzjT8q
         ijsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202170; x=1755806970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UARZd9qLkSRlP8HijwL/4OYfjtGDpQLLXgE19FfQX14=;
        b=D1frZiz36EA0GicipfydKMQDshPwz65nKlt3vqQNO2kL/4mZxA4OIm1pncWUb1MAFI
         8FO7Ec0FknqOf7+pcL+lAYxuRNAu31jmcCUgATWnBlqqnPO0z3NtmWui3+/Po6ysQQAg
         JD5mrBPFMH+hZE7yQT4tcI2dqnOly9hVCGus9BfIFqFZXRmrSX+z59sYrXFmK9PGE+jT
         jBgd1Jxak6PU/mG6iWgw3qpNxlleHzqlCDhN5/kjybtqqBP5gGZwkWJv3A1EWl0VvbXY
         +rhI2+p9XR++MD4wTU5KbUpaxBIKJUxEGuRWiO6x4q2fnD9idbd4gERdXKUQ3XNIpo8+
         EdSA==
X-Forwarded-Encrypted: i=1; AJvYcCWo9x5OqQ83Ikoe/pKYXL+erqRKbNguwbgCllX8N25gbXmtn/HiqWJmHWzcSupcwsekcukpvQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1bCHTnCYawvigDlAA06LxiWkVubXaCawXWoCvzYlnR7L0tFK
	2HxmQ+9QuAOdvBqwTMNqx+4hPfUED/gyhU+vq3G2Dxs9YZggRefsqInA65yfgYU6fwVQtJPa9tY
	qUHv3WA==
X-Google-Smtp-Source: AGHT+IEr2KzFw5L5eoFv7qE7SLsTY7h0r30kka9wgKEfCc5e8mASPVpzRfuL9JgzHtqNiN7oenCLbFowFlo=
X-Received: from plbml5.prod.google.com ([2002:a17:903:34c5:b0:242:abac:216c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228b:b0:243:12d5:db43
 with SMTP id d9443c01a7336-2446a15730bmr3842755ad.0.1755202170389; Thu, 14
 Aug 2025 13:09:30 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:42 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-11-kuniyu@google.com>
Subject: [PATCH v4 net-next 10/10] net: Define sk_memcg under CONFIG_MEMCG.
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
2.51.0.rc1.163.g2494970778-goog


