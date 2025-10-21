Return-Path: <netdev+bounces-231412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6E2BF8FB4
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87CF19C41B5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7912C15A9;
	Tue, 21 Oct 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjxxOQ28"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9042C11E1
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083080; cv=none; b=JNqAHpFqeOBd7MbgDMsCURLp3YJEchxx04NAjzW5SapO3aBn09+69dJql7AUrM99gPcXRFs3mqoAnJlq2mhIi/EUiSdd3JuHr+kRPlW/VKfz7kutCGXw+tmAo1/f11eQpx11AWQW0LSD/AxiS6aQpVk69Kk0zyK334VoSg4Gufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083080; c=relaxed/simple;
	bh=8twnqjA6u/DmLB2rAmcKa9exqo+s48cqtsRY+/HCy+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bO9O4kMRPwJjOckzoL0E7XWsEXV9Y0Qv7QtMez5klW8WTZc//amfHwbo4lp3DIFmimRsw+BwaOmviURd/q559/PElCFggbveSMQp5db3qMIGKoXRKMC9/SF7EuvUlMT4QBvZJOmn8ZHHJmEvP/KEMXQ91x7CU2nCx3En0enDkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjxxOQ28; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33baf262850so6036303a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083077; x=1761687877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRc2mo1MwDHIitSS98b+3ZDEjn8PULSjMhSMRbZeiIQ=;
        b=KjxxOQ28AYlSB+RexEK/+hOUjRMPZJB8LP/R4c1jJfFaxE03bdeV+7/4gGSQjOphfO
         5QnUChGv7JIFFWmxfEEehDeda+LQBv9RhsBWdqP2bf/84EPPz7pbj7X2/IDCp9NRItnT
         suC11LM22/RIeGQ0xw4jcJha8kL91Hgv3gcWw9pSclq4HluJa+bpy2r/zINPCUvB/rPD
         /1JqRLMQTEeBuITXV11pO8cDpiXeBgcf15mFVeHrqByNddtR1HL1I2KGHJpmBkaTD2Yb
         FyW4IWe00FTNennvTGBhrOhzHgPKuDCJ/cPlPZoBiBJuVz8XuezC69F/SU5hCa3MmRyE
         ktjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083077; x=1761687877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRc2mo1MwDHIitSS98b+3ZDEjn8PULSjMhSMRbZeiIQ=;
        b=SzTknBy4wLuoEwLn8vV19P7aGlgsZtlWGIoo6iPmrDSnD1fFlySLH0SB5fcNX6JASj
         y9M7VCRgsOS1cdDwzUQEwAyBEdsahhNLeYYez1U40dmzqrbRhRxXvclwshdVaYY36tY5
         RiqkbjLnzFiNRofQqE+AkkvoNnXRMPl5VdnkU9z37e4AAkpo661a+x9cA5PBniulqE/M
         Yin6P/+Fqx9CSZ3hrURlU6/B37tcP4a2ahLjGtO3KQii305bPh2nRsdtXmIQiACHBa59
         5gqsCHXOiYvY5C0iATkso/WOPe9JMED2MEg2QMjjXJHpd8PWOGT3ZX4YMO/vcVpaSrv0
         4wTA==
X-Forwarded-Encrypted: i=1; AJvYcCUqShYSf7EGcBM8gqV5ZBwd/kijBU9ho0dBcrvXMN7HZlpolVNs609DOmLIZ1ALWBcWDHwDKos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8botd4Wn8F7b7i5ELc2v5nDFKxrStEoxEsgZMAL1KRROzi7W
	Trpaoo+Z7Jp8GHBlf3R9POl5TiAEBtB4QFv0i8mJDGN8d1kMWbt3yI2/LoO6HKYORUCCBtSK/GM
	MkOwUzQ==
X-Google-Smtp-Source: AGHT+IFx2exTdpaq/AIpiMO57NODoQSSS8A6MANskIx8RqVjJFUdQCQzv4ZnYPQLauR8QPnsQRbBrSRJxVo=
X-Received: from pjuv6.prod.google.com ([2002:a17:90a:d586:b0:33b:51fe:1a7e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc6:b0:32e:87fa:d975
 with SMTP id 98e67ed59e1d1-33bcf918e81mr24251928a91.34.1761083077078; Tue, 21
 Oct 2025 14:44:37 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:25 +0000
In-Reply-To: <20251021214422.1941691-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 8/8] sctp: Remove sctp_copy_sock() and sctp_copy_descendant().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now, sctp_accept() and sctp_do_peeloff() use sk_clone(), and
we no longer need sctp_copy_sock() and sctp_copy_descendant().

Let's remove them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_sock.h |  8 -----
 include/net/sctp/sctp.h |  3 +-
 net/sctp/socket.c       | 71 -----------------------------------------
 3 files changed, 1 insertion(+), 81 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index b6ec08072533a..ac1c75975908a 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -355,14 +355,6 @@ static inline struct sock *skb_to_full_sk(const struct sk_buff *skb)
 
 #define inet_sk(ptr) container_of_const(ptr, struct inet_sock, sk)
 
-static inline void __inet_sk_copy_descendant(struct sock *sk_to,
-					     const struct sock *sk_from,
-					     const int ancestor_size)
-{
-	memcpy(inet_sk(sk_to) + 1, inet_sk(sk_from) + 1,
-	       sk_from->sk_prot->obj_size - ancestor_size);
-}
-
 int inet_sk_rebuild_header(struct sock *sk);
 
 /**
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index e96d1bd087f62..bb4b80c12541a 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -94,8 +94,7 @@ void sctp_data_ready(struct sock *sk);
 __poll_t sctp_poll(struct file *file, struct socket *sock,
 		poll_table *wait);
 void sctp_sock_rfree(struct sk_buff *skb);
-void sctp_copy_sock(struct sock *newsk, struct sock *sk,
-		    struct sctp_association *asoc);
+
 extern struct percpu_counter sctp_sockets_allocated;
 int sctp_asconf_mgmt(struct sctp_sock *, struct sctp_sockaddr_entry *);
 struct sk_buff *sctp_skb_recv_datagram(struct sock *, int, int *);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 60d3e340dfeda..ac737e60829b9 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9491,72 +9491,6 @@ static void sctp_skb_set_owner_r_frag(struct sk_buff *skb, struct sock *sk)
 	sctp_skb_set_owner_r(skb, sk);
 }
 
-void sctp_copy_sock(struct sock *newsk, struct sock *sk,
-		    struct sctp_association *asoc)
-{
-	struct inet_sock *inet = inet_sk(sk);
-	struct inet_sock *newinet;
-	struct sctp_sock *sp = sctp_sk(sk);
-
-	newsk->sk_type = sk->sk_type;
-	newsk->sk_bound_dev_if = sk->sk_bound_dev_if;
-	newsk->sk_flags = sk->sk_flags;
-	newsk->sk_tsflags = sk->sk_tsflags;
-	newsk->sk_no_check_tx = sk->sk_no_check_tx;
-	newsk->sk_no_check_rx = sk->sk_no_check_rx;
-	newsk->sk_reuse = sk->sk_reuse;
-	sctp_sk(newsk)->reuse = sp->reuse;
-
-	newsk->sk_shutdown = sk->sk_shutdown;
-	newsk->sk_destruct = sk->sk_destruct;
-	newsk->sk_family = sk->sk_family;
-	newsk->sk_protocol = IPPROTO_SCTP;
-	newsk->sk_backlog_rcv = sk->sk_prot->backlog_rcv;
-	newsk->sk_sndbuf = sk->sk_sndbuf;
-	newsk->sk_rcvbuf = sk->sk_rcvbuf;
-	newsk->sk_lingertime = sk->sk_lingertime;
-	newsk->sk_rcvtimeo = READ_ONCE(sk->sk_rcvtimeo);
-	newsk->sk_sndtimeo = READ_ONCE(sk->sk_sndtimeo);
-	newsk->sk_rxhash = sk->sk_rxhash;
-	newsk->sk_gso_type = sk->sk_gso_type;
-
-	newinet = inet_sk(newsk);
-
-	/* Initialize sk's sport, dport, rcv_saddr and daddr for
-	 * getsockname() and getpeername()
-	 */
-	newinet->inet_sport = inet->inet_sport;
-	newinet->inet_saddr = inet->inet_saddr;
-	newinet->inet_rcv_saddr = inet->inet_rcv_saddr;
-	newinet->inet_dport = htons(asoc->peer.port);
-	newinet->pmtudisc = inet->pmtudisc;
-	atomic_set(&newinet->inet_id, get_random_u16());
-
-	newinet->uc_ttl = inet->uc_ttl;
-	inet_set_bit(MC_LOOP, newsk);
-	newinet->mc_ttl = 1;
-	newinet->mc_index = 0;
-	newinet->mc_list = NULL;
-
-	if (newsk->sk_flags & SK_FLAGS_TIMESTAMP)
-		net_enable_timestamp();
-
-	/* Set newsk security attributes from original sk and connection
-	 * security attribute from asoc.
-	 */
-	security_sctp_sk_clone(asoc, sk, newsk);
-}
-
-static inline void sctp_copy_descendant(struct sock *sk_to,
-					const struct sock *sk_from)
-{
-	size_t ancestor_size = sizeof(struct inet_sock);
-
-	ancestor_size += sk_from->sk_prot->obj_size;
-	ancestor_size -= offsetof(struct sctp_sock, pd_lobby);
-	__inet_sk_copy_descendant(sk_to, sk_from, ancestor_size);
-}
-
 /* Populate the fields of the newsk from the oldsk and migrate the assoc
  * and its messages to the newsk.
  */
@@ -9573,11 +9507,6 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	struct sctp_bind_hashbucket *head;
 	int err;
 
-	/* Migrate all the socket level options to the new socket.
-	 * Brute force copy old sctp opt.
-	 */
-	sctp_copy_descendant(newsk, oldsk);
-
 	/* Restore the ep value that was overwritten with the above structure
 	 * copy.
 	 */
-- 
2.51.0.915.g61a8936c21-goog


