Return-Path: <netdev+bounces-171008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC7A4B19B
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 13:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B99D188F938
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D01E47A9;
	Sun,  2 Mar 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQxydo7l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED2189BB0
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740919362; cv=none; b=ZZOA66eU+VWlgJag1iezXIVQ0dv6OVhNBQqiy5L+AcVFaLJYK55Ccb4o4UH4+kyeYY8H/U1BZzGr/C17LQoSeuIhAj/wYUsqt0mAmR9a+RjonbvVs0gGPRiIaxzxA9gJPZZNSLDnSCmI0i9sLSRBiVVcslGVfWPEJAe4CGH78ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740919362; c=relaxed/simple;
	bh=mu8fr4NZwnln/8Dj8PQO9wWaoxOrMuLXb1ng7HtG/Xw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DjVMttHMIWP7R9N33RTVLET4zGO9irDLKNFkt2FBpJlvFKS8Bky++p09+k25/DxPNMt1JIJz5PgZ8lJuqzWsT/+T7Ex/hSP348ufYQcr2LQrPlbXC3xkqdks8htyfJ923pBfXxL8jrFLcGmPB/N1qImUspuy60kk07lFrNZ+rcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQxydo7l; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e8c8641ad6so6477466d6.3
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740919360; x=1741524160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj9rZcr8i8dq43YUEnSl7PBqvKsMqeBhFWze2LAWP6k=;
        b=sQxydo7lGlmd8AVb6OG1CIqcPbwI3HbFD+chgNUWWBNl/mKflKWd/NsvPdyXu62zor
         7+qbZrfopX6FNHq2ChUv6baqYbmRrVAsbJ+NNbfIbibX4z6HHOawqIWxLaJF/QNP/txr
         763/PfQF2wM2zKE7b1ZPEmt/AVgIU4qv1iuH0y/am8jjPkyMBfp9X0ott96YqeryKuoW
         rwP85y7gS13qSBMtIJJNUYhcOakRkBWlJDlqait80Y7Ww1e5nwrOAGOdoGQIFo5Vo8BF
         bjuTL7wng/o9vdyIIoU5akny1iweV/wrTw4nJ0Apw36oEseVJF9ZRmxWxIpK9/Hec4eF
         HRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740919360; x=1741524160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj9rZcr8i8dq43YUEnSl7PBqvKsMqeBhFWze2LAWP6k=;
        b=gmWue7stQFLQY0KFkBvBwpw1oXVesyMFOLVLtOg2bIOq8iHlBjot6SR5WmXYhWgKrb
         l7CwRZRJ/Uv3mP8mIxRxX2cH8nvN/9ZhQUUwUwwo/JLvbc/WYsJl08VtjXzYnkRtVfCf
         2VotDUf7zt+/ALXsq+gk5cUoPJ7oOB7r8nv4NHN2ennV+p/x3M4aYZByZtTIvFOFTJha
         LTdprWVzGzE34r0P6O2yFylnxqhDUzxpAz4Dt11oVXoc+qEBeVqqcZ01hMhNAAqlc/v3
         AnfXoTGSJmA2ZP0wJywbqhWE8crOigO+SdzMSczXdxd0+eFUQ5N9wvo7yX4ZHneZ0D9p
         Jsfw==
X-Forwarded-Encrypted: i=1; AJvYcCXk0/aIQYZPoWYOM/sh/2XZmpOn9Ab7pVOEbyn5viFqDrwD3KKCaCGhWNviZzNgt8URzCx3Sr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9N845D1dJlKEdpRGlv2qISQ+d8bQzzc25IER3bNzy1GvdHP40
	1Vae2pQAkJh82CO0hcRszHprr8x0ebCCsREPCJh7MF+w8/aRmj1clUldG7rS6gW8wWsMCLfN+OV
	I5x21MHUeQQ==
X-Google-Smtp-Source: AGHT+IF0+KIfwAvj5s940/ynCmLdKtOxsr25I8sQdPNQ5jfi5CxTZckRmtzudvhBzPuKkCbGi6UhdBlLDK3bUQ==
X-Received: from qvxf30.prod.google.com ([2002:ad4:559e:0:b0:6e4:6d4f:eb58])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:e88:b0:6e2:4d70:1fbd with SMTP id 6a1803df08f44-6e8a0c8221bmr151205666d6.6.1740919360143;
 Sun, 02 Mar 2025 04:42:40 -0800 (PST)
Date: Sun,  2 Mar 2025 12:42:34 +0000
In-Reply-To: <20250302124237.3913746-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250302124237.3913746-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250302124237.3913746-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] tcp: use RCU in __inet{6}_check_established()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When __inet_hash_connect() has to try many 4-tuples before
finding an available one, we see a high spinlock cost from
__inet_check_established() and/or __inet6_check_established().

This patch adds an RCU lookup to avoid the spinlock
acquisition when the 4-tuple is found in the hash table.

Note that there are still spin_lock_bh() calls in
__inet_hash_connect() to protect inet_bind_hashbucket,
this will be fixed later in this series.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/ipv4/inet_hashtables.c  | 19 ++++++++++++++++---
 net/ipv6/inet6_hashtables.c | 19 ++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9bfcfd016e18275fb50fea8d77adc8a64fb12494..46d39aa2199ec3a405b50e8e85130e990d2c26b7 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -551,11 +551,24 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 	unsigned int hash = inet_ehashfn(net, daddr, lport,
 					 saddr, inet->inet_dport);
 	struct inet_ehash_bucket *head = inet_ehash_bucket(hinfo, hash);
-	spinlock_t *lock = inet_ehash_lockp(hinfo, hash);
-	struct sock *sk2;
-	const struct hlist_nulls_node *node;
 	struct inet_timewait_sock *tw = NULL;
+	const struct hlist_nulls_node *node;
+	struct sock *sk2;
+	spinlock_t *lock;
+
+	rcu_read_lock();
+	sk_nulls_for_each(sk2, node, &head->chain) {
+		if (sk2->sk_hash != hash ||
+		    !inet_match(net, sk2, acookie, ports, dif, sdif))
+			continue;
+		if (sk2->sk_state == TCP_TIME_WAIT)
+			break;
+		rcu_read_unlock();
+		return -EADDRNOTAVAIL;
+	}
+	rcu_read_unlock();
 
+	lock = inet_ehash_lockp(hinfo, hash);
 	spin_lock(lock);
 
 	sk_nulls_for_each(sk2, node, &head->chain) {
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 9ec05e354baa69d14e88da37f5a9fce11e874e35..3604a5cae5d29a25d24f9513308334ff8e64b083 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -276,11 +276,24 @@ static int __inet6_check_established(struct inet_timewait_death_row *death_row,
 	const unsigned int hash = inet6_ehashfn(net, daddr, lport, saddr,
 						inet->inet_dport);
 	struct inet_ehash_bucket *head = inet_ehash_bucket(hinfo, hash);
-	spinlock_t *lock = inet_ehash_lockp(hinfo, hash);
-	struct sock *sk2;
-	const struct hlist_nulls_node *node;
 	struct inet_timewait_sock *tw = NULL;
+	const struct hlist_nulls_node *node;
+	struct sock *sk2;
+	spinlock_t *lock;
+
+	rcu_read_lock();
+	sk_nulls_for_each(sk2, node, &head->chain) {
+		if (sk2->sk_hash != hash ||
+		    !inet6_match(net, sk2, saddr, daddr, ports, dif, sdif))
+			continue;
+		if (sk2->sk_state == TCP_TIME_WAIT)
+			break;
+		rcu_read_unlock();
+		return -EADDRNOTAVAIL;
+	}
+	rcu_read_unlock();
 
+	lock = inet_ehash_lockp(hinfo, hash);
 	spin_lock(lock);
 
 	sk_nulls_for_each(sk2, node, &head->chain) {
-- 
2.48.1.711.g2feabab25a-goog


