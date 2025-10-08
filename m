Return-Path: <netdev+bounces-228194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB9BC46C3
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 12:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851CC188C938
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C7F2F6170;
	Wed,  8 Oct 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="um8o6pPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E32F25E1
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920379; cv=none; b=VB5YXHBGIsmhYV7ytUtS23t/hgE9bhjUmjxyBo3NvyeCa/wub9ouHfH/eOn1egR3aGkYEA+UC91N8xKEiAqda1ph9tkfeMExBUCbSdqtXT4dCz835NofD7N/wJg1d5aYEXH+YZfT0AAgeJ7PvD53T4fMw2BIbPruIQiq/pBhWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920379; c=relaxed/simple;
	bh=uL1nKm16h/13QRhjXZswCf+ZrZAlieUHHPqRM3BmgM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CRz7BezVvBywkU/3KEyHBQRr25GoiLyOkiyMLqEXxRO4zLGgpKgK6lWMUu57udJqBCyYJMxC/IE2e6TNR7WLF/yc5Y4+/fAWX8xRkJsKu8GXHv//S8ACElwJTI2ySMs/fG7akGvedumE70l5dBqmvEXnrs0HZgxgEUY7lDF4i7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=um8o6pPU; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-828bd08624aso1464410285a.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759920377; x=1760525177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cQyr/6IF9bebDWxMFEumcOsw9xAJHaRiNGsula056U=;
        b=um8o6pPUYcbCs628lpdp1LdX5rbbGEkNQ9H3YQSZQdKUT4w0X87Lwqbya+Ji95t23A
         ToHcH+QNhgsvsLzzUVpGfujzhRAxDtpIQKmBkE2ZOBly2UTyuoBACp2hvSu3dQY3D+Zs
         lQZVn7Aa2kqjVuYXKRwrqhGJBt+vhTxULcPaoWRqEV/H3BYeyPmGXcksBnKf0FeKehLY
         RrqLHsY03UDMQl7U3QoPWj88oiipheAlEeHklcbGaXPRhFI9F6462yCRfbEmpc5vkqIB
         HA6b1/ikxnKDjNMPZsYIMbF9Qe7qOaY6RZ9fWbD5yRBWK2Fl2mwS2K6VwnrFHDD02VNT
         X2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920377; x=1760525177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cQyr/6IF9bebDWxMFEumcOsw9xAJHaRiNGsula056U=;
        b=GPWw9klZyKo1zACQs7vUMoy+2fy4kXSqJv7XnnwVbJQnGXU3huSu0KimMFRy70Yo7J
         onUcV2yAY5985OAh0viStE2aRoqaEH2VLmmjZi4OaHK8vUNSwZX4C8v269wOSGhehqoQ
         vBLhe1uZ+R8spOYt8FEoaV4PZ89keQICvA9hR2Ev6xYYVfWnYEGJDDSE+HCdOfvnG9vm
         Gut/0T1nT5nEkmB6fQqRCH4XnHvxAK3ZAA8G/38hyNh9M3csfgHlBU0xz9SVbIit+LsA
         dukF5+SIL+o0VmYKTTkosnGrQfAlNwblmN8bR4A/qxYYmS+41v3iZ4yt7XANpEhPpkMe
         vuIg==
X-Forwarded-Encrypted: i=1; AJvYcCVJcAvYxG6Dc9Qk4B9gD6K8WQfQyQIRiJ7Az7/GbGJscLtOlbokYKh3KJjhvO+UpcwloYU1CyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywdg1o7PECeNTWENpYrzK1QN0A0U7OIxDU3ANE6JUN42wYowaI
	iT7pWekOexdTE63rM5hFdo0Yw/1K6309Fv3HfWzJYaZDhIeJO/TCYxjEMAgMgyR/V0Sr6zCgWzL
	TK//2HssDWJ7cpA==
X-Google-Smtp-Source: AGHT+IHOQUuuGxXNHHRFkuZhg8jEjwVr0Zmp/s1HRVOSvEhYa7UIakqAJElVqUpholeoPMx1aOwphRwWvBYhQw==
X-Received: from qkay19.prod.google.com ([2002:a05:620a:a093:b0:850:c05c:f7d4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7103:b0:856:b388:7e84 with SMTP id af79cd13be357-8834ff8e2abmr386225185a.12.1759920376984;
 Wed, 08 Oct 2025 03:46:16 -0700 (PDT)
Date: Wed,  8 Oct 2025 10:46:08 +0000
In-Reply-To: <20251008104612.1824200-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008104612.1824200-2-edumazet@google.com>
Subject: [PATCH RFC net-next 1/4] net: add SK_WMEM_ALLOC_BIAS constant
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sk->sk_wmem_alloc is initialized to 1, and sk_wmem_alloc_get()
takes care of this initial value.

Add SK_WMEM_ALLOC_BIAS define to not spread this magic value.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 3 ++-
 net/atm/common.c   | 2 +-
 net/core/sock.c    | 5 ++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 60bcb13f045c3144609908a36960528b33e4f71c..2794bc5c565424491a064049d3d76c3fb7ba1ed8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2303,6 +2303,7 @@ static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *fro
 	return 0;
 }
 
+#define SK_WMEM_ALLOC_BIAS 1
 /**
  * sk_wmem_alloc_get - returns write allocations
  * @sk: socket
@@ -2311,7 +2312,7 @@ static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *fro
  */
 static inline int sk_wmem_alloc_get(const struct sock *sk)
 {
-	return refcount_read(&sk->sk_wmem_alloc) - 1;
+	return refcount_read(&sk->sk_wmem_alloc) - SK_WMEM_ALLOC_BIAS;
 }
 
 /**
diff --git a/net/atm/common.c b/net/atm/common.c
index 881c7f259dbd46be35d71e558a73eb2f26223963..cecc71a8bee1176518a2d63b4613dbd243543695 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -157,7 +157,7 @@ int vcc_create(struct net *net, struct socket *sock, int protocol, int family, i
 	memset(&vcc->local, 0, sizeof(struct sockaddr_atmsvc));
 	memset(&vcc->remote, 0, sizeof(struct sockaddr_atmsvc));
 	vcc->qos.txtp.max_sdu = 1 << 16; /* for meta VCs */
-	refcount_set(&sk->sk_wmem_alloc, 1);
+	refcount_set(&sk->sk_wmem_alloc, SK_WMEM_ALLOC_BIAS);
 	atomic_set(&sk->sk_rmem_alloc, 0);
 	vcc->push = NULL;
 	vcc->pop = NULL;
diff --git a/net/core/sock.c b/net/core/sock.c
index dc03d4b5909a2a68aee84eb9a153b2c3970f6b32..542cfa16ee125f6c8487237c9040695d42794087 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2313,7 +2313,7 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		}
 
 		sock_net_set(sk, net);
-		refcount_set(&sk->sk_wmem_alloc, 1);
+		refcount_set(&sk->sk_wmem_alloc, SK_WMEM_ALLOC_BIAS);
 
 		mem_cgroup_sk_alloc(sk);
 		cgroup_sk_alloc(&sk->sk_cgrp_data);
@@ -2494,8 +2494,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 
 	atomic_set(&newsk->sk_rmem_alloc, 0);
 
-	/* sk_wmem_alloc set to one (see sk_free() and sock_wfree()) */
-	refcount_set(&newsk->sk_wmem_alloc, 1);
+	refcount_set(&newsk->sk_wmem_alloc, SK_WMEM_ALLOC_BIAS);
 
 	atomic_set(&newsk->sk_omem_alloc, 0);
 	sk_init_common(newsk);
-- 
2.51.0.710.ga91ca5db03-goog


