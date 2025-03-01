Return-Path: <netdev+bounces-170957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA3AA4AD8F
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5627B16FBD2
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAFE1E8329;
	Sat,  1 Mar 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzaFCumA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE71E8333
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740858389; cv=none; b=WHlPqi226nMWZOSFWaNSI9DHo5W2MMNZttgU5ZFo89lXnn2/o8OVExR1n/4FMaiAE3O7qTFr70ImwrOY3EsLKvCzR7jLksKpyX4fTVFxc8Y6ovq/c8gs5laKi6H3ZwaBPigSITOxRv38PkDfmIp9sJUANgITAUKPxd5lmP9USWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740858389; c=relaxed/simple;
	bh=tkdiEldvXOyA7ipZGRvlXuF9ulzbGWHdNp/W0YLPLFs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MGqZb2M2HIVXm6kK2l+Dg4h7sJPmxh/gs1z78/X/wWCaqg2/tAF+Xi2iu1dn7gXtzLa+ZjrIh/TP2we6cfMvzYdFfohNHJcAUnl/4A4PIerAjqUm9Ah2RaKNUU3R6HmBZN4NallsBem816ngPtg4RVFsm41j/mX4Xb97r1LVr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzaFCumA; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e2378169a4so69134486d6.2
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 11:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740858386; x=1741463186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gX/TEQS76nXpjRb3WE7jv27PC007iJTttrxYRHly5Kg=;
        b=lzaFCumAvF2xKACm08nWOfYy3EEdmaApgSFrBVC9WIu2pmXcNeuCQ6IJza4Ot0KHnf
         44kHG6Eta8wlRkwVDNcFKWN158OOpwa/gca4foQQqJ/AJ/bQ5VAn73kIJOd352UeaNBb
         lwvIlB6f1gxC2deSnwigj6zGRx1r1v5wrm3k0HayPoEZd9dgcAU8rmXuog7v8/feDGlC
         EGkYk6v5629uJpOFrm6+cBU4KTUXZ/3OpvpHRov7ixD9TPSel+qtOrQ6KY4W9z0RnYoM
         /TC9O31CcO2hYoB+iGLznecm4MHwHKHzKizw9RgRNu2Tk35D9vl3dl4MOQpqUpFGT34d
         shfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740858386; x=1741463186;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gX/TEQS76nXpjRb3WE7jv27PC007iJTttrxYRHly5Kg=;
        b=Zxpuz4SqJ3BDKJoRNY151g9z+F6FTqvhMOqFpRGYi9qGiJz0TtMWmvqoiRybK6YSby
         IzShafnKb3y0C8T3m+MLjHi6kKVXkOQCXUopr7CFsbyD+SDw9VqaRhCDkL0PmJNvgECm
         k6Z+K7w8ohlvfTdI4IGvyLhw/lJccVfP1Ux+DVsi/4b+ZWLviJbuKsDBb3xs/+gaMN8y
         k2FhXCSFl7SxovIS4ToUPeWbJgsz73HdNFdxJFSEimkTs472o/1T3IBTFcceA72s89ra
         4qF13mCEJgzW6lDAbRULjsc/+UYncWa18WYgeHvPV1g5pKb9tk9dLoZbaZOTYSp693n6
         n1lw==
X-Forwarded-Encrypted: i=1; AJvYcCUghlrunvS7UXeC0eL+STXz2vlg+1fbfsE8Wu3J0Y9jg+vjI1kXLRe8rV28x670EazewxvHi4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/2MLmrdWNS/HxMvmiomN35Vx7sijVhsGZkNY7N8nshKNIBal
	IQtD/6+RTU6exJ2L0VcjDTqFgmpGLq7diBiUuRgxzvK1X838O2Y74S2UtRyeuqCMz+XYLl3wvwo
	t9FKKEcCW3A==
X-Google-Smtp-Source: AGHT+IFwV4auTz7L6SyL8unoRYH9/sDtGzVYVH/aYiSRqnx1w2eKkmD6rGQu2R9bWXoCV0KBw8pNTy0e2rK8Bg==
X-Received: from qvnt13.prod.google.com ([2002:a0c:f98d:0:b0:6e4:8bd6:5ce0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:226b:b0:6e6:61f1:457f with SMTP id 6a1803df08f44-6e8a0d00641mr137541336d6.18.1740858386528;
 Sat, 01 Mar 2025 11:46:26 -0800 (PST)
Date: Sat,  1 Mar 2025 19:46:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250301194624.1879919-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: use RCU in __inet{6}_check_established()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When __inet_hash_connect() has to try many 4-tuples before
finding an available one, we see a high spinlock cost from
__inet_check_established() and/or __inet6_check_established().

This patch adds an RCU lookup to avoid the spinlock
acquisition if the 4-tuple is found in the hash table.

Note that there are still spin_lock_bh() calls in
__inet_hash_connect() to protect inet_bind_hashbucket,
this will be fixed in a future patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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


