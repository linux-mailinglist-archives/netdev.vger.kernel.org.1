Return-Path: <netdev+bounces-231891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B965CBFE479
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 23:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A26744E7C45
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF4A30506C;
	Wed, 22 Oct 2025 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35wtN9Nx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C630498F
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167858; cv=none; b=fYogiq1f+cGkoM7b1cJrnZHHMfH8ZCc7y5hUoFA0SsaG4CfXm5jmGKJ3saF35sy4VRTm08tVfHKYXxPKO5vJaOWadXPYjTRzPQh3/c9zRxSqT2DTkt/TALt8ovp7LopmO7poMGScOY05QXH58gD94AwlCmIYz0hy3B5TtDfM+a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167858; c=relaxed/simple;
	bh=94oPPR6j8XJDUBcIOmM4FOx5NYGkPGp67wkFMpNdaAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E01R1JwNhYV+Z7CslYV9f9fNcupxJAj+jE/B2dJsnNRVcunT/3fdpXy48m0kt4LAVXx5pSxiv0FDuK1PUiMNIljwBu6CFLA+DSx/QY4tx/flBX1blt/adrIAwkKw9qhqEWmLXuffYf1rAVM79vA6/Ef+2kA6OMSMIs1B5lHFLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35wtN9Nx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so16763a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761167856; x=1761772656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWnuvmQggcdfzRsZeAyhSgKT8b5Sb3veCMTMEEsBwTM=;
        b=35wtN9NxcSyankx+7s/qi5MSQ9bIkapHMlbGTBRuFYmy3K2lI3JnOFIMBowr2u/XeN
         JmH1NLJksJnhCtN1XKle4U3fSC9m4fAvdIKP/9LXxoZB3TSGpEwUXM5TQ4iM986D/iKc
         vaGJFV1LX2zso+XqwLvhrlAgYEnnpG2JJOkWFiFkAYn4lN0w00iP5uNoqoS+8sV0IXwh
         qaLeB7iZ98rP4tnIvTJFvUTDUv9xmVAB+H7TiiHyiIAmaw7SL+O76AtIleAWBhYl4cKH
         aD3QHMOOiCA9+u9yrmXKUT0grk3lFDoZ6MApIeu5HwYpjnetr8UzB1uVh2K/JzPc9U9v
         /R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167856; x=1761772656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWnuvmQggcdfzRsZeAyhSgKT8b5Sb3veCMTMEEsBwTM=;
        b=nKXNweLf/MTFncUHA1Z9g26WVPwUlLxO4bD+P82V6a1R9HBoBEUhM2mW2tGbWkoP7p
         fIO/yLt96lq8drokbAgVEKup+bDeuz8/miNsJeCKtah+aPNIGyk/wqLxgvD2ZOqOI++D
         LJ3LqCAbm3QqtKR6eWmEE4N/omPylavj5D6rK04D7UtLzc7F4b8JPGGmvfML+RBcFBLZ
         KL0oU089eDVNc8IO5zb+xZ3A4BE/NGaxXJW2F1sc+LnfojRIA57oM9wepy1as2PAzt1L
         7cA+lYfvUU2QvXEH6M59bCCmmN02tXGEl96EABSygWDZl6YkAb/ljkTq/Ok5ul2MWr0F
         lzJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEuQj0MjAFt7UyK0UQX1AZ0XgEFTa8FQQWObPQdjgYh690iUqoIsJe3ngZwLrhmE1yeEZvIDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKin+sUQmYA6Ize0ytpoE2ybjD+DJ2S9j69J8TX4njqUubWa7S
	G2WQk+QOJ70PvJBVzmf0qddGizFZKqKR07bIrUrJT6dUyrzDoPLeUGpR59eTQjczbWyG29cqitQ
	8T9G6tQ==
X-Google-Smtp-Source: AGHT+IEU7upSI8+leASGORUDN3mIn6HuFluFtTZBzg6SlifC7mJhAyscTtTj3MfHdVD7nWWAcc2aBmyFofg=
X-Received: from pjbgv18.prod.google.com ([2002:a17:90b:11d2:b0:33d:d0a9:ff0b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e212:b0:301:5784:8ccc
 with SMTP id adf61e73a8af0-334a8536990mr30341896637.14.1761167856341; Wed, 22
 Oct 2025 14:17:36 -0700 (PDT)
Date: Wed, 22 Oct 2025 21:17:08 +0000
In-Reply-To: <20251022211722.2819414-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022211722.2819414-9-kuniyu@google.com>
Subject: [PATCH v2 net-next 8/8] sctp: Remove sctp_copy_sock() and sctp_copy_descendant().
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
index b6ec08072533..ac1c75975908 100644
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
index e96d1bd087f6..bb4b80c12541 100644
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
index 60d3e340dfed..ac737e60829b 100644
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
2.51.1.814.gb8fa24458f-goog


