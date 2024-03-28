Return-Path: <netdev+bounces-82902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3092B89021C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886032973BE
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC912BEAA;
	Thu, 28 Mar 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o74ZV9CL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDA12D76A
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636843; cv=none; b=k9XulxDeTIJx76Mimz5zMkbnJJOaCJj7+n0etnu855YyHaB4mLhalkLEKuJhI5No0BsJE9V0vn3l3sqAT2o5orbmEs+0sO9JG0GHSpTmCquZ5U0P4BvuxRLOhTxsMzGymNhklur6WKB19pyVmONgzNz1OiERM+QpEdSCI4tyqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636843; c=relaxed/simple;
	bh=hH1R9nucTJno3soiryv3o2FiSWCSXHP2hnOZDfZ9SDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uzc9b/H3CPSQzz/BZi88VWWfL5dtFBZgMNTqQjvH/7O/vHEHQBC5Yxu/K7wuzy3rCZPTp8So7Iq522goETGFBOx1rjxIplm0Un81THa2hP7H0tn9wBS0zepjtMV5h1ZhcNyaQ9Wyv0EVGEFGXngHVVhy9mBPjT/vQfMj7PNh08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o74ZV9CL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a2386e932so18714547b3.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711636840; x=1712241640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+p86SvCRADRmCtp38fnFrKEhLTcYAFsdvzNjPMNeyI=;
        b=o74ZV9CL5rsPPLbp/70E3aWmJ+eIyeUTqVcaczUmNhPNpWWKPRqC5IyXBoCLEQ3Dvg
         +Qa9ZUfMDgoA+GcFnQ4ZVVpwTDoLbpKmU5oju/f0ThWYvtd4dDIb/ZTE0tbVZyiWk0mx
         Zfx4InbRHSbTLtaO4b3+leRjc0OGslkFtg94/M+KHBKyzYr16MIZtOH28lvLd60ExgbF
         PrnQHCp5AVzGMqF5nkMhkB84KG10Vl1+LmHG/RQlR9/K30GGHFvDG/w/PL/8JPXo8JUK
         tU6xlPgR5vXmopbNZOUqYGdfn+rus+k/6+egG+kjoRnyegykSeBlCC/6QXTswKpxMwDN
         Ysjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636840; x=1712241640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+p86SvCRADRmCtp38fnFrKEhLTcYAFsdvzNjPMNeyI=;
        b=jcQuejLrIhuWDky7jmEqyF6Lb4i1CDPXWm5UKDBBlWBIlw2bmq2wPXRuGQGowT10AY
         CxYARrmYzlgVJ4T5ASO/AQK9RVEULie773OANg+wdwZ+SjfaxCuJ6DHbBfvAr86TvnAZ
         5oR71RUZeAyakZuarDtyAIJyv8Go/A3xlwlfsf6zXJN3BztTlxed8GlpcjyDD94N0/NX
         pqhGXIVZHBLnH2d6OCYjubgnY104Rzl/KqnA3lC6Husp308TsQmrbF5w13Qz8HJMGASP
         AD/cMT/HSHHn9PkWGvit78eVFnxky89Rr9Om2FDNdeKsYAX+X7g6lsPROG0ExIBII0NR
         YXww==
X-Forwarded-Encrypted: i=1; AJvYcCU1bleE2sFWzb4gqXHu6SMVcMOs7yTDjPe3rO3eT4dCMLr7sc+GBlA3lvH57pQkI+yyuoalISYdlh77AnaCF+IaHpcKmHsq
X-Gm-Message-State: AOJu0YwTrJkRodgZQOXjFRcCZMrfuZ8zvDKYWBIrmdrT5UQHPyzq8yGg
	XyxtjdiO4Pr4CTMY1MaulRUm2AzMoUPVVMHTasGhQZ4Mco10po/ZBFE/ewJSli0HnsRxVMwwZAi
	BwiwYqOACKA==
X-Google-Smtp-Source: AGHT+IEZYqHCpZDNMX/jR49tpTDjJmDcGTDoFb+s++TOGcFIZ05XLf5y0WOMTjdIn0OXgCkQ9ZRNv3RF6WoCCw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:64ca:b0:611:1f1c:1287 with SMTP
 id ht10-20020a05690c64ca00b006111f1c1287mr650924ywb.3.1711636840478; Thu, 28
 Mar 2024 07:40:40 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:40:32 +0000
In-Reply-To: <20240328144032.1864988-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328144032.1864988-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328144032.1864988-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] net: add sk_wake_async_rcu() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While looking at UDP receive performance, I saw sk_wake_async()
was no longer inlined.

This matters at least on AMD Zen1-4 platforms (see SRSO)

This might be because rcu_read_lock() and rcu_read_unlock()
are no longer nops in recent kernels ?

Add sk_wake_async_rcu() variant, which must be called from
contexts already holding rcu lock.

As SOCK_FASYNC is deprecated in modern days, use unlikely()
to give a hint to the compiler.

sk_wake_async_rcu() is properly inlined from
__udp_enqueue_schedule_skb() and sock_def_readable().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 crypto/af_alg.c      | 4 ++--
 include/net/sock.h   | 6 ++++++
 net/atm/common.c     | 2 +-
 net/core/sock.c      | 8 ++++----
 net/dccp/output.c    | 2 +-
 net/ipv4/udp.c       | 2 +-
 net/iucv/af_iucv.c   | 2 +-
 net/rxrpc/af_rxrpc.c | 2 +-
 net/sctp/socket.c    | 2 +-
 net/smc/smc_rx.c     | 4 ++--
 net/unix/af_unix.c   | 2 +-
 11 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 68cc9290cabe9a9f8a264908466897f2f93e039d..5bc6d0fa7498df30fdf002ec7bcfb46ed4344e8c 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -847,7 +847,7 @@ void af_alg_wmem_wakeup(struct sock *sk)
 		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN |
 							   EPOLLRDNORM |
 							   EPOLLRDBAND);
-	sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+	sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(af_alg_wmem_wakeup);
@@ -914,7 +914,7 @@ static void af_alg_data_wakeup(struct sock *sk)
 		wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
 							   EPOLLRDNORM |
 							   EPOLLRDBAND);
-	sk_wake_async(sk, SOCK_WAKE_SPACE, POLL_OUT);
+	sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
 	rcu_read_unlock();
 }
 
diff --git a/include/net/sock.h b/include/net/sock.h
index b5e00702acc1f037df7eb8ad085d00e0b18079a8..38adc3970500f4ae1b8d5ade343c5fbe1d04e085 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2506,6 +2506,12 @@ static inline void sk_wake_async(const struct sock *sk, int how, int band)
 	}
 }
 
+static inline void sk_wake_async_rcu(const struct sock *sk, int how, int band)
+{
+	if (unlikely(sock_flag(sk, SOCK_FASYNC)))
+		sock_wake_async(rcu_dereference(sk->sk_wq), how, band);
+}
+
 /* Since sk_{r,w}mem_alloc sums skb->truesize, even a small frame might
  * need sizeof(sk_buff) + MTU + padding, unless net driver perform copybreak.
  * Note: for send buffers, TCP works better if we can build two skbs at
diff --git a/net/atm/common.c b/net/atm/common.c
index 2a1ec014e901d6549732e7bce35bce6a9eb467e0..9b75699992ff9244470c143433f444fb9d46c3b2 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -116,7 +116,7 @@ static void vcc_write_space(struct sock *sk)
 		if (skwq_has_sleeper(wq))
 			wake_up_interruptible(&wq->wait);
 
-		sk_wake_async(sk, SOCK_WAKE_SPACE, POLL_OUT);
+		sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
 	}
 
 	rcu_read_unlock();
diff --git a/net/core/sock.c b/net/core/sock.c
index 43bf3818c19e829b47d3989d36e2e1b3bf985438..b9203fccaf1e29ba8e5f48b44987abb79f28fc60 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3338,7 +3338,7 @@ static void sock_def_error_report(struct sock *sk)
 	wq = rcu_dereference(sk->sk_wq);
 	if (skwq_has_sleeper(wq))
 		wake_up_interruptible_poll(&wq->wait, EPOLLERR);
-	sk_wake_async(sk, SOCK_WAKE_IO, POLL_ERR);
+	sk_wake_async_rcu(sk, SOCK_WAKE_IO, POLL_ERR);
 	rcu_read_unlock();
 }
 
@@ -3353,7 +3353,7 @@ void sock_def_readable(struct sock *sk)
 	if (skwq_has_sleeper(wq))
 		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOLLPRI |
 						EPOLLRDNORM | EPOLLRDBAND);
-	sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+	sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
 	rcu_read_unlock();
 }
 
@@ -3373,7 +3373,7 @@ static void sock_def_write_space(struct sock *sk)
 						EPOLLWRNORM | EPOLLWRBAND);
 
 		/* Should agree with poll, otherwise some programs break */
-		sk_wake_async(sk, SOCK_WAKE_SPACE, POLL_OUT);
+		sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
 	}
 
 	rcu_read_unlock();
@@ -3398,7 +3398,7 @@ static void sock_def_write_space_wfree(struct sock *sk)
 						EPOLLWRNORM | EPOLLWRBAND);
 
 		/* Should agree with poll, otherwise some programs break */
-		sk_wake_async(sk, SOCK_WAKE_SPACE, POLL_OUT);
+		sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
 	}
 }
 
diff --git a/net/dccp/output.c b/net/dccp/output.c
index fd2eb148d24de4d1b9e40c6721577ed7f11b5a6c..5c2e24f3c39b7ff4ee1d5d96d5e406c96609a022 100644
--- a/net/dccp/output.c
+++ b/net/dccp/output.c
@@ -204,7 +204,7 @@ void dccp_write_space(struct sock *sk)
 		wake_up_interruptible(&wq->wait);
 	/* Should agree with poll, otherwise some programs break */
 	if (sock_writeable(sk))
-		sk_wake_async(sk, SOCK_WAKE_SPACE, POLL_OUT);
+		sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
 
 	rcu_read_unlock();
 }
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5dfbe4499c0f89f94af9ee1fb64559dd672c1439..4119e74fee02b3930075fe5b00c0fc753a620149 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1544,7 +1544,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 			INDIRECT_CALL_1(sk->sk_data_ready,
 					sock_def_readable, sk);
 		else
-			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+			sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
 	}
 	busylock_release(busy);
 	return 0;
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 7c8c3adcac6e94379360ef6e609c48e3b396ceaa..c951bb9cc2e044249ff7e4f86470b4035d60aeaa 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -184,7 +184,7 @@ static void iucv_sock_wake_msglim(struct sock *sk)
 	wq = rcu_dereference(sk->sk_wq);
 	if (skwq_has_sleeper(wq))
 		wake_up_interruptible_all(&wq->wait);
-	sk_wake_async(sk, SOCK_WAKE_SPACE, POLL_OUT);
+	sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
 	rcu_read_unlock();
 }
 
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 5222bc97d192e05e2169dcf5f548fdeb98e6b07b..f4844683e12039d636253cb06f622468593487eb 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -65,7 +65,7 @@ static void rxrpc_write_space(struct sock *sk)
 
 		if (skwq_has_sleeper(wq))
 			wake_up_interruptible(&wq->wait);
-		sk_wake_async(sk, SOCK_WAKE_SPACE, POLL_OUT);
+		sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
 	}
 	rcu_read_unlock();
 }
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c67679a41044fc8e801d175b235249f2c8b99dc0..e416b6d3d2705286d3e5af18b2314bceacfb98b1 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9276,7 +9276,7 @@ void sctp_data_ready(struct sock *sk)
 	if (skwq_has_sleeper(wq))
 		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN |
 						EPOLLRDNORM | EPOLLRDBAND);
-	sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+	sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
 	rcu_read_unlock();
 }
 
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 9a2f3638d161d2ff7d7261835a5b13be63b11701..f0cbe77a80b44046b880e5a7107f535507c76c7c 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -42,10 +42,10 @@ static void smc_rx_wake_up(struct sock *sk)
 	if (skwq_has_sleeper(wq))
 		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOLLPRI |
 						EPOLLRDNORM | EPOLLRDBAND);
-	sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
+	sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
 	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
 	    (sk->sk_state == SMC_CLOSED))
-		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
+		sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_HUP);
 	rcu_read_unlock();
 }
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5b41e2321209ae0a17ac97d7214eefd252ec0180..ee382cf55f2016d19e600b6fde75da12b53bea09 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -546,7 +546,7 @@ static void unix_write_space(struct sock *sk)
 		if (skwq_has_sleeper(wq))
 			wake_up_interruptible_sync_poll(&wq->wait,
 				EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND);
-		sk_wake_async(sk, SOCK_WAKE_SPACE, POLL_OUT);
+		sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
 	}
 	rcu_read_unlock();
 }
-- 
2.44.0.396.g6e790dbe36-goog


