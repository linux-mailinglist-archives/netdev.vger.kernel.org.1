Return-Path: <netdev+bounces-224694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92EFB8870A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5907D56589D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04133064A6;
	Fri, 19 Sep 2025 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFb+Gcya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A092FF644
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271032; cv=none; b=RWq7yN1+ztZnbP0Qdu0WUMCEcDs1CiCsM96xvzyWyBB8/1Hm+EwjJwiu05E0k/G8Vy/UlHwxMqicU7HM58hTQcDRetN+JhDN+T1WXdAQ2qtYW9US4pQBEfeEqQqz7kVe3pYuDeeK5kwDQkZgn7zrXD4chuNJAdsK+Zf39JWXOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271032; c=relaxed/simple;
	bh=XoG8CJMxjTJsNCIT+645M7J3S4c+A/mogWwetFXX9gA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OKzBVQlffH2hjv49brphy+eLMrm2zGdNLX5xycAitIdP2N7AKbcyYh4QNnc+3DS6aAcoyJ/hBqpbvNfLNo44KUbtTr7LqnQ6esTl+T0CwuVIFNvrgbXFFVibWT+pzV7nGhUqUqrvACavHlsJQr4Wan2xUVqoZocWcG6FhCXBuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFb+Gcya; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4f86568434so1450477a12.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758271030; x=1758875830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQPOpM+1WLMZ+lRjfRT8eingnbPC3/U6PJMW5M0vWPo=;
        b=SFb+Gcya6KH7/FUdQF/JcBDL5E7YH9gUiIbVePueFFSXo9xpUryev+8h+Ele24rGT0
         L8bmzbpD7EiK+d8zWNFgNWzls/jolsWNq8ydIcTmLGWPwfwgM7L8KPlSHVC/+tLtwtsb
         dD/24oZ8EtIiNK7bdhqjTiCo/oZH1zDpe0fOO1J2dbLsYjDA4uLdHmcvMVuGgiqqDSFo
         Sy532lrN7lOMXFM3YgsKl0SnE/PaY+Mte4eE664q2n+/ODDe8jRXVFVsIT2n7t3kz6mA
         M2EdRo6UO4ckzq71ihguqg766Ti4YwK4HPxiWtnSXoDdqw8uwtLEzSeTasi2jyY79oiL
         FRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758271030; x=1758875830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQPOpM+1WLMZ+lRjfRT8eingnbPC3/U6PJMW5M0vWPo=;
        b=QDypLdn8Vjcnn/IzRRD83W35WBS2ESE2XrsG6AXnjIGXoX+0oUoQzPHUFnQnScN62Y
         xyZqheOPZ2iqPSfMBIsUB//pd6yOajOVI9xcAyOlZ5pv0qMw8N8Db5fe4wZWe4XWclOo
         jbyqLrNr6254L474QctuM/wOhgmdoVqJsVVEGfrWTaCFoSBybzWgKS/FEdNaOcaKFDmD
         vviszimmIHjQ05+vDBnjYHjtaHAVBIi8DQCcV35xhv3PhhaK8YPnn3Q91DacejgCb5qn
         fxj8rYG7DkdTTVKymDHUofl2tF0gZVl6WEsBCAdqrggzh6f36AgdVK23xLW0krl4Then
         KItg==
X-Forwarded-Encrypted: i=1; AJvYcCVfmqiOtt9fKEgZt7RNtP6GIXFO1qZzklaKKA0bM8rSixiVxE2sW/jCoKHaOaMwnJTSTCbdcrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQXHX//SCSz9Htt8+ZfPlPvCR6dBlbpI9nGOTiVW4ORu0k1qz
	A6UEIA/k+3/5NG58ZLuZwwN8bXRTGSJjRiWVzgD3be8tgME7VmpAQD4zqdAHpDmKEIVWXNj0ks0
	wC0IEkg==
X-Google-Smtp-Source: AGHT+IEhX8X7L3j0rh02Ttq2fA0qCPxwmMrbLB5oYCi8dqzfUTOQmeaPibblUOFOZ3aZNVl02Tyow6Tp15Q=
X-Received: from pfst22.prod.google.com ([2002:aa7:8f96:0:b0:77f:ad8:fbe9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a06:b0:263:b3:d8d4
 with SMTP id adf61e73a8af0-2925ca26fc5mr3843070637.12.1758271030410; Fri, 19
 Sep 2025 01:37:10 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:35:28 +0000
In-Reply-To: <20250919083706.1863217-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919083706.1863217-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919083706.1863217-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/3] tcp: Remove osk from __inet_hash() arg.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Xuanqiang Luo <xuanqiang.luo@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__inet_hash() is called from inet_hash() and inet6_hash with osk NULL.

Let's remove the 2nd arg from __inet_hash().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_hashtables.h | 2 +-
 net/ipv4/inet_hashtables.c    | 6 +++---
 net/ipv6/inet6_hashtables.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index a3b32241c2f2..64bc8870db88 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -289,7 +289,7 @@ int inet_hashinfo2_init_mod(struct inet_hashinfo *h);
 bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk);
 bool inet_ehash_nolisten(struct sock *sk, struct sock *osk,
 			 bool *found_dup_sk);
-int __inet_hash(struct sock *sk, struct sock *osk);
+int __inet_hash(struct sock *sk);
 int inet_hash(struct sock *sk);
 void inet_unhash(struct sock *sk);
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ef4ccfd46ff6..baee5c075e6c 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -739,7 +739,7 @@ static int inet_reuseport_add_sock(struct sock *sk,
 	return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
 }
 
-int __inet_hash(struct sock *sk, struct sock *osk)
+int __inet_hash(struct sock *sk)
 {
 	struct inet_hashinfo *hashinfo = tcp_get_hashinfo(sk);
 	struct inet_listen_hashbucket *ilb2;
@@ -747,7 +747,7 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 
 	if (sk->sk_state != TCP_LISTEN) {
 		local_bh_disable();
-		inet_ehash_nolisten(sk, osk, NULL);
+		inet_ehash_nolisten(sk, NULL, NULL);
 		local_bh_enable();
 		return 0;
 	}
@@ -779,7 +779,7 @@ int inet_hash(struct sock *sk)
 	int err = 0;
 
 	if (sk->sk_state != TCP_CLOSE)
-		err = __inet_hash(sk, NULL);
+		err = __inet_hash(sk);
 
 	return err;
 }
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index a3a9ea49fee2..64fcd7df0c9a 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -374,7 +374,7 @@ int inet6_hash(struct sock *sk)
 	int err = 0;
 
 	if (sk->sk_state != TCP_CLOSE)
-		err = __inet_hash(sk, NULL);
+		err = __inet_hash(sk);
 
 	return err;
 }
-- 
2.51.0.470.ga7dc726c21-goog


