Return-Path: <netdev+bounces-171011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D94AA4B19E
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 13:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FA016DA85
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 12:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE21E5716;
	Sun,  2 Mar 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="heFFxyzk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268BB1E3DE5
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740919366; cv=none; b=DHcQdVB70reWyM8SFOxKcbG/Wk+/7ezcQ+YTFOQHXB+1CDRtKW92ejU3vyd+vVsR1uXHuadKWPTPqbm4eDNk5irF1A8fCvuj49nK1jkuGaFu51pPvR3Eo3l4Whf9uFVDpEbmKuSpUHgQAYe/XPjk6Ctg6+97W7wWhVZoZIjc83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740919366; c=relaxed/simple;
	bh=ItXP/zyRAh+/67PmK7Z+y9460lXos/4E+fsmUnOBZBA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+muPrvc5msZpCwt00rQ1cSNCBEwyNlD1aLQPz9qe+7y/dr7MbAfCP54ci4UgWepibJ7GFcPMG5vqFaYqy4kp2wkUbwbRumxrmzr7JR2jQK+Ofv6TWvVo0qiyQMWTv07UL3EGE6NHHKLn6CZl2UV0f3+hDUPHOq7xzMWzPe3tBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=heFFxyzk; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-471ec7f1969so92485911cf.1
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 04:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740919364; x=1741524164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bIbXbn1qyNwXG/XGNxdRDEuAyo93hNv8FKSURSQEbM4=;
        b=heFFxyzkco9dM3swFNshNCfwIIGaQfk/VQihNIyjTgRgFJIqbCRrDDDscndB8BOudQ
         7fA2ywGdrx2vAsdkl84LW4Jd06huEFaZ0cbqZvSQG8Dt/WSpuGQlEzQ2qZgkJyoJoKGV
         8Pf3EiQ/W0uUITZtUhOAr1YdmBpNoN+1erDcRws/bpbgIEgkv+oVyb+KFfW1XbjuY6zA
         4S5rT9cxTGDkzR45o42/fVCE9IlpXYjU+Rqa7MFJLBMi92l0zGcJFlNnj8X4jT/hGUK6
         RG970mrjxXCK7xLDjVGA+ayssHAMDiiC9XJ62Hse8uBKvP+Nf9Oyf3pMEi42I2ZW48Hm
         GHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740919364; x=1741524164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIbXbn1qyNwXG/XGNxdRDEuAyo93hNv8FKSURSQEbM4=;
        b=S9fuVkKZAwcpCuf3EB00pfkq3+Ng+Jp7PTKtU6EeGEYKmasR4rOuxq4Glf53bE9xn+
         uQ52TPnvbuqQnsYwc2mUOYbQczGF8xrAzspC4YqInxYAX16RYMedgtAKFpOXraeyaJIp
         p1NZdK6ZMq0fgPUbylNztAWOYfRQIKj9DW+7R2bQjFrk/0dJvDqS50OtRZq1y3Vvh//S
         G3vaqyNvlDub8+UkaGuTkqrgU1yY1BL1oxfseRWsiSncam7O7IotpHKmYA0Vcs9Jdz3C
         DOQQO5Ll5pACSlOrG3/yw0HLASuDdwSdVPatSss3q09M0UAT64rY+LMWcg07qejzbpuV
         zKNw==
X-Forwarded-Encrypted: i=1; AJvYcCVxP2C6KPYnM66UGsAvkGvd5HWJ7PIP8N3+ttQqq/XxKXJypXRsCvIsVgVXUI273gPnXWAESn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOUmAPM9gl51Tq5UK2QBnA2piX2lFvDUGFhKesnwjjF7mYG5xu
	TEQpvZUUXbbp4VYlYwom+U2O6i4YGj5HdSRUUExuFb9BuV1rrJcnA9z2BmD7O0RTvw6cl9NGJwg
	HUU1fPJS/JQ==
X-Google-Smtp-Source: AGHT+IHof4z7aGHpuS92kAvQXiZc6abSJZ/Z16oiPqjR33sve5qy+MbHUoXtRbDD/TQ8hkxyarz6mnFTA2T4ng==
X-Received: from qtbfi5.prod.google.com ([2002:a05:622a:58c5:b0:472:3db:8d3c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f07:0:b0:471:fa00:fb9b with SMTP id d75a77b69052e-473d8f99c26mr199701181cf.7.1740919364071;
 Sun, 02 Mar 2025 04:42:44 -0800 (PST)
Date: Sun,  2 Mar 2025 12:42:37 +0000
In-Reply-To: <20250302124237.3913746-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250302124237.3913746-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250302124237.3913746-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] tcp: use RCU lookup in __inet_hash_connect()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When __inet_hash_connect() has to try many 4-tuples before
finding an available one, we see a high spinlock cost from
the many spin_lock_bh(&head->lock) performed in its loop.

This patch adds an RCU lookup to avoid the spinlock cost.

check_established() gets a new @rcu_lookup argument.
First reason is to not make any changes while head->lock
is not held.
Second reason is to not make this RCU lookup a second time
after the spinlock has been acquired.

Tested:

Server:

ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog

Client:

ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H server

Before series:

  utime_start=0.288582
  utime_end=1.548707
  stime_start=20.637138
  stime_end=2002.489845
  num_transactions=484453
  latency_min=0.156279245
  latency_max=20.922042756
  latency_mean=1.546521274
  latency_stddev=3.936005194
  num_samples=312537
  throughput=47426.00

perf top on the client:

 49.54%  [kernel]       [k] _raw_spin_lock
 25.87%  [kernel]       [k] _raw_spin_lock_bh
  5.97%  [kernel]       [k] queued_spin_lock_slowpath
  5.67%  [kernel]       [k] __inet_hash_connect
  3.53%  [kernel]       [k] __inet6_check_established
  3.48%  [kernel]       [k] inet6_ehashfn
  0.64%  [kernel]       [k] rcu_all_qs

After this series:

  utime_start=0.271607
  utime_end=3.847111
  stime_start=18.407684
  stime_end=1997.485557
  num_transactions=1350742
  latency_min=0.014131929
  latency_max=17.895073144
  latency_mean=0.505675853  # Nice reduction of latency metrics
  latency_stddev=2.125164772
  num_samples=307884
  throughput=139866.80      # 190 % increase

perf top on client:

 56.86%  [kernel]       [k] __inet6_check_established
 17.96%  [kernel]       [k] __inet_hash_connect
 13.88%  [kernel]       [k] inet6_ehashfn
  2.52%  [kernel]       [k] rcu_all_qs
  2.01%  [kernel]       [k] __cond_resched
  0.41%  [kernel]       [k] _raw_spin_lock

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_hashtables.h |  3 +-
 net/ipv4/inet_hashtables.c    | 52 +++++++++++++++++++++++------------
 net/ipv6/inet6_hashtables.c   | 24 ++++++++--------
 3 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 73c0e4087fd1a6d0d2a40ab0394165e07b08ed6d..b12797f13c9a3d66fab99c877d059f9c29c30d11 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -529,7 +529,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 			struct sock *sk, u64 port_offset,
 			int (*check_established)(struct inet_timewait_death_row *,
 						 struct sock *, __u16,
-						 struct inet_timewait_sock **));
+						 struct inet_timewait_sock **,
+						 bool rcu_lookup));
 
 int inet_hash_connect(struct inet_timewait_death_row *death_row,
 		      struct sock *sk);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index b737e13f8459c53428980221355344327c4bc8dd..d1b5f45ee718410fdf3e78c113c7ebd4a1ddba40 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -537,7 +537,8 @@ EXPORT_SYMBOL_GPL(__inet_lookup_established);
 /* called with local bh disabled */
 static int __inet_check_established(struct inet_timewait_death_row *death_row,
 				    struct sock *sk, __u16 lport,
-				    struct inet_timewait_sock **twp)
+				    struct inet_timewait_sock **twp,
+				    bool rcu_lookup)
 {
 	struct inet_hashinfo *hinfo = death_row->hashinfo;
 	struct inet_sock *inet = inet_sk(sk);
@@ -556,17 +557,17 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 	struct sock *sk2;
 	spinlock_t *lock;
 
-	rcu_read_lock();
-	sk_nulls_for_each(sk2, node, &head->chain) {
-		if (sk2->sk_hash != hash ||
-		    !inet_match(net, sk2, acookie, ports, dif, sdif))
-			continue;
-		if (sk2->sk_state == TCP_TIME_WAIT)
-			break;
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+	if (rcu_lookup) {
+		sk_nulls_for_each(sk2, node, &head->chain) {
+			if (sk2->sk_hash != hash ||
+			    !inet_match(net, sk2, acookie, ports, dif, sdif))
+				continue;
+			if (sk2->sk_state == TCP_TIME_WAIT)
+				break;
+			return -EADDRNOTAVAIL;
+		}
+		return 0;
 	}
-	rcu_read_unlock();
 
 	lock = inet_ehash_lockp(hinfo, hash);
 	spin_lock(lock);
@@ -1007,7 +1008,8 @@ static u32 *table_perturb;
 int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		struct sock *sk, u64 port_offset,
 		int (*check_established)(struct inet_timewait_death_row *,
-			struct sock *, __u16, struct inet_timewait_sock **))
+			struct sock *, __u16, struct inet_timewait_sock **,
+			bool rcu_lookup))
 {
 	struct inet_hashinfo *hinfo = death_row->hashinfo;
 	struct inet_bind_hashbucket *head, *head2;
@@ -1025,7 +1027,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	if (port) {
 		local_bh_disable();
-		ret = check_established(death_row, sk, port, NULL);
+		ret = check_established(death_row, sk, port, NULL, false);
 		local_bh_enable();
 		return ret;
 	}
@@ -1061,6 +1063,21 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 			continue;
 		head = &hinfo->bhash[inet_bhashfn(net, port,
 						  hinfo->bhash_size)];
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(tb, &head->chain, node) {
+			if (!inet_bind_bucket_match(tb, net, port, l3mdev))
+				continue;
+			if (tb->fastreuse >= 0 || tb->fastreuseport >= 0) {
+				rcu_read_unlock();
+				goto next_port;
+			}
+			if (!check_established(death_row, sk, port, &tw, true))
+				break;
+			rcu_read_unlock();
+			goto next_port;
+		}
+		rcu_read_unlock();
+
 		spin_lock_bh(&head->lock);
 
 		/* Does not bother with rcv_saddr checks, because
@@ -1070,12 +1087,12 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 			if (inet_bind_bucket_match(tb, net, port, l3mdev)) {
 				if (tb->fastreuse >= 0 ||
 				    tb->fastreuseport >= 0)
-					goto next_port;
+					goto next_port_unlock;
 				WARN_ON(hlist_empty(&tb->bhash2));
 				if (!check_established(death_row, sk,
-						       port, &tw))
+						       port, &tw, false))
 					goto ok;
-				goto next_port;
+				goto next_port_unlock;
 			}
 		}
 
@@ -1089,8 +1106,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		tb->fastreuse = -1;
 		tb->fastreuseport = -1;
 		goto ok;
-next_port:
+next_port_unlock:
 		spin_unlock_bh(&head->lock);
+next_port:
 		cond_resched();
 	}
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 3604a5cae5d29a25d24f9513308334ff8e64b083..9be315496459fcb391123a07ac887e2f59d27360 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -263,7 +263,8 @@ EXPORT_SYMBOL_GPL(inet6_lookup);
 
 static int __inet6_check_established(struct inet_timewait_death_row *death_row,
 				     struct sock *sk, const __u16 lport,
-				     struct inet_timewait_sock **twp)
+				     struct inet_timewait_sock **twp,
+				     bool rcu_lookup)
 {
 	struct inet_hashinfo *hinfo = death_row->hashinfo;
 	struct inet_sock *inet = inet_sk(sk);
@@ -281,17 +282,18 @@ static int __inet6_check_established(struct inet_timewait_death_row *death_row,
 	struct sock *sk2;
 	spinlock_t *lock;
 
-	rcu_read_lock();
-	sk_nulls_for_each(sk2, node, &head->chain) {
-		if (sk2->sk_hash != hash ||
-		    !inet6_match(net, sk2, saddr, daddr, ports, dif, sdif))
-			continue;
-		if (sk2->sk_state == TCP_TIME_WAIT)
-			break;
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+	if (rcu_lookup) {
+		sk_nulls_for_each(sk2, node, &head->chain) {
+			if (sk2->sk_hash != hash ||
+			    !inet6_match(net, sk2, saddr, daddr,
+					 ports, dif, sdif))
+				continue;
+			if (sk2->sk_state == TCP_TIME_WAIT)
+				break;
+			return -EADDRNOTAVAIL;
+		}
+		return 0;
 	}
-	rcu_read_unlock();
 
 	lock = inet_ehash_lockp(hinfo, hash);
 	spin_lock(lock);
-- 
2.48.1.711.g2feabab25a-goog


