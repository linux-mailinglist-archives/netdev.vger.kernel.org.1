Return-Path: <netdev+bounces-230485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F153BE8F1F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 829C335CD32
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B72F6936;
	Fri, 17 Oct 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPQ2rgH9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D672F6931
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708237; cv=none; b=emnm5OzRyoXH7R4h/aMS6qrMidL6NE6R82B6/V7kL59aPFZ+I306jvC5lvL4B5HkTRAv57a1uhRSNSrIKDosOj2M176HYnRvgazMrP0Tkqrz8AahTlbUedlsdaz6fjqkq1YaquV4HYBrbf2CAx7oWInNBKO0o7ipFc6pFv46GJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708237; c=relaxed/simple;
	bh=OBU/VQLNWAjO0jz3aAQCIrhwvwrAj6kYYsDzTR4Oobw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zfekk+LCO8NUcuJoEddglOebdNbcyMYVZ0M9mKAUJP2BSI5Sq7W1iJHoidKy+Zr81tk1PNwGstryBs8Nw5WmW3hw/fSE0H1wBFcp9lTfdea4Etmi0Xdl9Bopdt9XVtsm0cWtDzqhPBXuSBuJRy26mFDnK6YZAixnxprX/PkDnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rPQ2rgH9; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-88e2656b196so2050285a.2
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760708234; x=1761313034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RgupyzykSctqh7Wr2atIqDtxk7+1x3xo0PwLw0IrMJ0=;
        b=rPQ2rgH9W69O+NDK2KsG0HpTjBEDm3gZlALHYR1DMQINWKsDBFQKADqPNyiEH8U61U
         Jix7JZKG/mILSDVYqLqQLxJ8VFrhW8uM5LC+fjsELAA2R6MCfk9xYV/I9AVzLIGJ7FUJ
         MMfSydtW+aIZU0XmvCZRO3FsNVeHSc/f+UTSi4Qm0HpUCdKWTEcx0yPzvTASpO73f35h
         7Hv/h/cVjBEDgkjy/Ud/yfEEWMoAnUdK/opZs4QbA2817/pKYNIZLodLFgVVCzHODmUS
         XxO/5nchJUi7SUAeuLQyD+frjBYNd3xfy+Byx/e1cQq60Q7nskBUwg3XpyrPlUeI22P3
         0Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760708234; x=1761313034;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgupyzykSctqh7Wr2atIqDtxk7+1x3xo0PwLw0IrMJ0=;
        b=LjawvP7azDT993jkWPajknYnXgycwXC9dG0xyh7+PZhrdKj+aGz0P3KC9dbfwV1kwM
         Las7mW6GaKZa7LE5+HCZg5yeTJHB9kTVWeTsO0Rj4zjjBq8WnFQ4C7rgiq9CrFnSzC/q
         cYPi4JP9Wu6P5K7/KTO7rQkY89myLBokxpQ2Veih8lsLa8ROeDHZhanlPmKiLQ21GSsL
         ggNYRocAaKQN7ZMSkZpSsRcHYerxxtwMAvLKyuFk29FI8fj8ws0wXm0DKwUUMuLhr22C
         YrKDSlyIhu7YJlxZab/K3hzC4rFr3qxyXr4aozURBzjpW1KJhIGsUKzNunH6UAKRhTjl
         l0fg==
X-Forwarded-Encrypted: i=1; AJvYcCXrlrC9Vd0kZXbQCIaPUp6cgJHCdH9GVEJOJDBrNUdBCueVGUNb/2n40i9XFq3DRhb5PsgQUpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcn5jQIosCA7ihN5y/U36PnABLNMA08pHp0UBewOw6cuHE9kA
	UMySdufILoBdtTdeyXQ3q9Yz6j8ZCSfQcu+WyItZvAA082m5WKSNKq0kltEM5LHP238pAeqX6/J
	dYIANwvY5GSEsTg==
X-Google-Smtp-Source: AGHT+IFglZmax5yyeu1g8/89BIOmL4rdWHYYLT+JR6NIlnOoBgVJuu5kyU0x1j5SSS6GNOO4f9vBQlhiJIKuhg==
X-Received: from qvab28.prod.google.com ([2002:a05:6214:611c:b0:87b:eaab:61d6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5993:0:b0:4e8:a6ca:8cc4 with SMTP id d75a77b69052e-4e8a6ca8ea4mr13471141cf.36.1760708234242;
 Fri, 17 Oct 2025 06:37:14 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:37:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017133712.2842665-1-edumazet@google.com>
Subject: [PATCH net-next] net: avoid extra acces to sk->sk_wmem_alloc in sock_wfree()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

UDP TX packets destructor is sock_wfree().

It suffers from a cache line bouncing in sock_def_write_space_wfree().

Instead of reading sk->sk_wmem_alloc after we just did an atomic RMW
on it, use __refcount_sub_and_test() to get the old value for free,
and pass the new value to sock_def_write_space_wfree().

Add __sock_writeable() helper.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h |  6 +++++-
 net/core/sock.c    | 14 ++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 30ac2eb4ef9bf73743e3dc9e66c6c3059f34964e..7d9bfaaff913d3bce8d0a12df8987db96ee2bad6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2591,12 +2591,16 @@ static inline struct page_frag *sk_page_frag(struct sock *sk)
 
 bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag);
 
+static inline bool __sock_writeable(const struct sock *sk, int wmem_alloc)
+{
+	return wmem_alloc < (READ_ONCE(sk->sk_sndbuf) >> 1);
+}
 /*
  *	Default write policy as shown to user space via poll/select/SIGIO
  */
 static inline bool sock_writeable(const struct sock *sk)
 {
-	return refcount_read(&sk->sk_wmem_alloc) < (READ_ONCE(sk->sk_sndbuf) >> 1);
+	return __sock_writeable(sk, refcount_read(&sk->sk_wmem_alloc));
 }
 
 static inline gfp_t gfp_any(void)
diff --git a/net/core/sock.c b/net/core/sock.c
index 08ae20069b6d287745800710192396f76c8781b4..0ca3566cff83a8e6ee37e60a37a5a6f533203d0f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -155,7 +155,7 @@
 static DEFINE_MUTEX(proto_list_mutex);
 static LIST_HEAD(proto_list);
 
-static void sock_def_write_space_wfree(struct sock *sk);
+static void sock_def_write_space_wfree(struct sock *sk, int wmem_alloc);
 static void sock_def_write_space(struct sock *sk);
 
 /**
@@ -2648,16 +2648,18 @@ EXPORT_SYMBOL_GPL(sk_setup_caps);
  */
 void sock_wfree(struct sk_buff *skb)
 {
-	struct sock *sk = skb->sk;
 	unsigned int len = skb->truesize;
+	struct sock *sk = skb->sk;
 	bool free;
+	int old;
 
 	if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE)) {
 		if (sock_flag(sk, SOCK_RCU_FREE) &&
 		    sk->sk_write_space == sock_def_write_space) {
 			rcu_read_lock();
-			free = refcount_sub_and_test(len, &sk->sk_wmem_alloc);
-			sock_def_write_space_wfree(sk);
+			free = __refcount_sub_and_test(len, &sk->sk_wmem_alloc,
+						       &old);
+			sock_def_write_space_wfree(sk, old - len);
 			rcu_read_unlock();
 			if (unlikely(free))
 				__sk_free(sk);
@@ -3589,12 +3591,12 @@ static void sock_def_write_space(struct sock *sk)
  * for SOCK_RCU_FREE sockets under RCU read section and after putting
  * ->sk_wmem_alloc.
  */
-static void sock_def_write_space_wfree(struct sock *sk)
+static void sock_def_write_space_wfree(struct sock *sk, int wmem_alloc)
 {
 	/* Do not wake up a writer until he can make "significant"
 	 * progress.  --DaveM
 	 */
-	if (sock_writeable(sk)) {
+	if (__sock_writeable(sk, wmem_alloc)) {
 		struct socket_wq *wq = rcu_dereference(sk->sk_wq);
 
 		/* rely on refcount_sub from sock_wfree() */
-- 
2.51.0.858.gf9c4a03a3a-goog


