Return-Path: <netdev+bounces-171915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A41CA4F590
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 04:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8176016FFB9
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283EF190063;
	Wed,  5 Mar 2025 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2CiTJhM2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773718EFD4
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146355; cv=none; b=puxzO5FAKURbFKxO0uuJCwprWyQWKVrDsFYojopmjkg9rEAt2APDMkr48+pHO5V14q4ZmcDPvSnGSEspK1Wicd0DaglWs27WPFqMSE7QTTPQP/t5kR5F1jbr6jOgDajGMHDtYDRDOXyWorh3hlmzreIqEGwU16XH0GkqnxYBjWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146355; c=relaxed/simple;
	bh=G/fvg+jx3iR7EcHQaE+sOeqvUjV4kr3Cq7sLo8jEKDI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EAdQ8Rne1Aw7xYPN++poSDSYHrACNzIfugsyaS6AGU4DDX7wb9+Bl9/sUic+1iBI6POjzzLbtQOmithqOr8GMFJfL+lghugFrxUsMkzYTft0HdDUw1sDlCeVATsW+zMRaloUWqaxsdnMaAQY2OlzoPsYvUJTTwFNRYUqbmVAYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2CiTJhM2; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c09f73873fso1112594385a.1
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 19:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741146353; x=1741751153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlBu93t4Ta6KhR4Wp2+D8xZ6ttgHwoEr3gVrWDzyRc0=;
        b=2CiTJhM2yD6Oi3yN8fQSNLBJjPwNE2TtXvC6i6M6tapDGQoSmTfvW2FJXV4YAMlJCj
         pRunoekMevtQPaDgiudlOOdAncNDZ+tsRMnW+OcTlEMCuDi/KKLY65/5YgQCW5DBxa1l
         I00QXSaJwAeoibl0y1yUACanVyy+n1aFyvfWxw89XqqV8fJtvklxhlBgNMvB9OcjnM9T
         +wIOmQqnGlWf50HibdM+7nrrBra271QW2fOuXCMs9vuULKz2C4d+bPIX3e2x3aBgnPA2
         Vu1LIEVRUUMbryFUFarv5SPMSjbgVekFXxk/DHz/mXlJHo5ZSQEjp1Spd6MW+ldL3bOx
         k1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741146353; x=1741751153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlBu93t4Ta6KhR4Wp2+D8xZ6ttgHwoEr3gVrWDzyRc0=;
        b=JJHmneaVKl5G+i86wQPa74yrXQyZ/gKzUSz5a6py6jZtAWvXKs7sEH3jSmGxAK+Re1
         wiFu+3jkg7ZyrpazyuSHfEZ43GMlt4esUytnaX3VLhC8mmWJv9f7Y3db9YQRCcaCq96o
         CeekJGnj0S2gcNj7XsPv+wJdIaTBcejpqbHkDKl5bblBG/Hj09BSZvZ6JyWC4nWhEQ+M
         ZESz9painpnpTlJa0XaeGf/yipOrcIQFZAmKhKlMd6wfgKYP6hAcuwZ5GA3EJ3DyyrRZ
         Urmy5XyJuFj3CMoR4cd7i1WVMgyzN/noOGyL7WP3kptPnTVTb5xcPb9haP4ztQZIqNVA
         OXHA==
X-Forwarded-Encrypted: i=1; AJvYcCXda4vFmo3PxXFnATnDKOPqNwXetWv4IlZmYJthwUCxYfoq9aYSk2+6Ewdhs2HUCJ+YqYABSoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0f+YaPI8oU2fsbYugywusJRTyzHSDQ+pTzx7z1zQWzc63fZb
	4Ck8F+NYbjxDY0B6B6tUF+xy4uEhMRcJaSeNDaM3x7desFmc1aHolXs9I6KV4XSYueu5eLDXQQk
	r8+OHIS6rFg==
X-Google-Smtp-Source: AGHT+IEIdCRJFhk92tY0z1kvUT8q0ou97CEZVYO/DSjaZTpRsSQo0IRAO68fyhe9C2h4aBGVTXFxkGktpXI2fA==
X-Received: from qknov3.prod.google.com ([2002:a05:620a:6283:b0:7c3:d5c7:6372])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a03:b0:7c3:dc4c:7789 with SMTP id af79cd13be357-7c3dc4c7a6fmr21901885a.42.1741146353174;
 Tue, 04 Mar 2025 19:45:53 -0800 (PST)
Date: Wed,  5 Mar 2025 03:45:49 +0000
In-Reply-To: <20250305034550.879255-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250305034550.879255-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250305034550.879255-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] inet: change lport contribution to
 inet_ehashfn() and inet6_ehashfn()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to speedup __inet_hash_connect(), we want to ensure hash values
for <source address, port X, destination address, destination port>
are not randomly spread, but monotonically increasing.

Goal is to allow __inet_hash_connect() to derive the hash value
of a candidate 4-tuple with a single addition in the following
patch in the series.

Given :
  hash_0 = inet_ehashfn(saddr, 0, daddr, dport)
  hash_sport = inet_ehashfn(saddr, sport, daddr, dport)

Then (hash_sport == hash_0 + sport) for all sport values.

As far as I know, there is no security implication with this change.

After this patch, when __inet_hash_connect() has to try XXXX candidates,
the hash table buckets are contiguous and packed, allowing
a better use of cpu caches and hardware prefetchers.

Tested:

Server: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
Client: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H server

Before this patch:

  utime_start=0.271607
  utime_end=3.847111
  stime_start=18.407684
  stime_end=1997.485557
  num_transactions=1350742
  latency_min=0.014131929
  latency_max=17.895073144
  latency_mean=0.505675853
  latency_stddev=2.125164772
  num_samples=307884
  throughput=139866.80

perf top on client:

 56.86%  [kernel]       [k] __inet6_check_established
 17.96%  [kernel]       [k] __inet_hash_connect
 13.88%  [kernel]       [k] inet6_ehashfn
  2.52%  [kernel]       [k] rcu_all_qs
  2.01%  [kernel]       [k] __cond_resched
  0.41%  [kernel]       [k] _raw_spin_lock

After this patch:

  utime_start=0.286131
  utime_end=4.378886
  stime_start=11.952556
  stime_end=1991.655533
  num_transactions=1446830
  latency_min=0.001061085
  latency_max=12.075275028
  latency_mean=0.376375302
  latency_stddev=1.361969596
  num_samples=306383
  throughput=151866.56

perf top:

 50.01%  [kernel]       [k] __inet6_check_established
 20.65%  [kernel]       [k] __inet_hash_connect
 15.81%  [kernel]       [k] inet6_ehashfn
  2.92%  [kernel]       [k] rcu_all_qs
  2.34%  [kernel]       [k] __cond_resched
  0.50%  [kernel]       [k] _raw_spin_lock
  0.34%  [kernel]       [k] sched_balance_trigger
  0.24%  [kernel]       [k] queued_spin_lock_slowpath

There is indeed an increase of throughput and reduction of latency.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_hashtables.c  | 4 ++--
 net/ipv6/inet6_hashtables.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index d1b5f45ee718410fdf3e78c113c7ebd4a1ddba40..3025d2b708852acd9744709a897fca17564523d5 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -35,8 +35,8 @@ u32 inet_ehashfn(const struct net *net, const __be32 laddr,
 {
 	net_get_random_once(&inet_ehash_secret, sizeof(inet_ehash_secret));
 
-	return __inet_ehashfn(laddr, lport, faddr, fport,
-			      inet_ehash_secret + net_hash_mix(net));
+	return lport + __inet_ehashfn(laddr, 0, faddr, fport,
+				      inet_ehash_secret + net_hash_mix(net));
 }
 EXPORT_SYMBOL_GPL(inet_ehashfn);
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 9be315496459fcb391123a07ac887e2f59d27360..3d95f1e75a118ff8027d4ec0f33910d23b6af832 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -35,8 +35,8 @@ u32 inet6_ehashfn(const struct net *net,
 	lhash = (__force u32)laddr->s6_addr32[3];
 	fhash = __ipv6_addr_jhash(faddr, tcp_ipv6_hash_secret);
 
-	return __inet6_ehashfn(lhash, lport, fhash, fport,
-			       inet6_ehash_secret + net_hash_mix(net));
+	return lport + __inet6_ehashfn(lhash, 0, fhash, fport,
+				       inet6_ehash_secret + net_hash_mix(net));
 }
 EXPORT_SYMBOL_GPL(inet6_ehashfn);
 
-- 
2.48.1.711.g2feabab25a-goog


