Return-Path: <netdev+bounces-204008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF9AF8766
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67956586676
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 05:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19531F4C83;
	Fri,  4 Jul 2025 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBOZ1Nzm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2BCBE65
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751608145; cv=none; b=a54fEYce4uOyUCOeMGqkCAC+DXhrJSEUcYniXpaXWYdf8TPSpEO0npQCbUX3XJnw/up9FOlYWmABsR+bppD67cJlBmucaa45Ufxa5BBbetWJsg7BWTeMqUhw/vUaMAyJitV7PjU7SHx8KQ7eGp9aQQohkTl72QQDql/8tldGGZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751608145; c=relaxed/simple;
	bh=dLQ0I++oMsQfuP7cl0/y1n9onLevjwsYXCn4YZ0ygCc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZQu39F+FtUTz8N0/ICKqmoS7ejevAUoAsQt53gWsrF31wUuVgk63oGWDl72vfGDSVibBveM3HIEUYcIoDVlhpbiLRxBRqXPi0mAMDYDd6/ORQznxyuCTKy/ejEG0m0a7KCEg3KxZB3JxcQT5x/oJcJuHDwn2SX4HEG91oc24DZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBOZ1Nzm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31f112c90aso423060a12.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 22:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751608143; x=1752212943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2LoRkUJFqHCmPcvNF0h7FQwolyfFv2zgcK878cX0WZ4=;
        b=QBOZ1NzmuLmhcr4vUop0VCWwoVS7ystU4unof1RDqHzO6YRxoJmj0kmM7nugTmMK35
         EaR+k3Erw+k9t1ndhCp1UsPB3ZEpFf9kQV5K+5RQOdoty0+Qq5hzsvZW/fvi6QgyY0qn
         57B18d5HgVSCZVyw1f9k6S7fA7wjZyhfZf7k/+MhX63o5S2Hegqdck1tO9F56FsYpdzI
         9Ww29hKY1WMRdJXCkmsvLjwagdLKXyK9iNco0Gw1koWziFz0OIkjrThWgaWlCqpLIiER
         OeE2xnJBNNp1wAbVmkcH1/nhqc8EhkyqJyxTkOt+TSqNM/2VKjkmEcZKdOmax5+3aSAr
         +tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751608143; x=1752212943;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LoRkUJFqHCmPcvNF0h7FQwolyfFv2zgcK878cX0WZ4=;
        b=BrvDjMraopdcxYrJHBr99d+20HPOZ4ZlT7Hewri7QqjSBLbgDMOAirHdDxChBCeCNp
         jqQnxB9DUU+3hsuHS4DyYt4wYFv0ap1hKrcbAzGFe3vzW1Yby0Pvn73b4dVicEWvrvqv
         i8ssGhqmV5yIeEgA8Ile4UHUHfWkS4OU2G34YAG1U/iOSiyFHDSu20Rb1kiZXRHOrTgT
         6f92sMHjd8yh36hi4UFBvUQ0/saGnHOeRC9uR/ZECkW2s0kCmr4MWg+B3dGDtUUImehA
         Bru6pwtM9N9eegvzxLjb6UfxUH+yAIWFj3LJKMqp/DyflaxVh5wVLjj8oJGzVFyn/PL4
         caLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg29hBBtoE/Y6/YDR0G5DphXWldPntCjjqR/WeEWMWTC40Y4CCf8cSKWK8JSvB5lbr9Jh8JbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzse4OG5kSNWtZrqYT4r4YJFZhQg4fFII3ChmeXdQAm7wcHxwTN
	O3EowFHv0mMaWLj6dIPT+q3ft0tAzF0f0ufUp9doIL5/mEt+vBzgpslyz5LMIh1IxZN38BURjgv
	VMlt6ww==
X-Google-Smtp-Source: AGHT+IEQjv5xk3F1NNRPz8AkCb+qo/WZmwKrtXChCUZbzNSUDVF1vj8ee8w17r4+6J5tA4DWC+AObbbApAw=
X-Received: from pgbda5.prod.google.com ([2002:a05:6a02:2385:b0:b2e:beba:356])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:439f:b0:21c:fa68:9da6
 with SMTP id adf61e73a8af0-225adc8f4eemr2744532637.8.1751608143521; Thu, 03
 Jul 2025 22:49:03 -0700 (PDT)
Date: Fri,  4 Jul 2025 05:48:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704054824.1580222-1-kuniyu@google.com>
Subject: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Jason Baron <jbaron@akamai.com>
Content-Type: text/plain; charset="UTF-8"

Netlink has this pattern in some places

  if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
  	atomic_add(skb->truesize, &sk->sk_rmem_alloc);

, which has the same problem fixed by commit 5a465a0da13e ("udp:
Fix multiple wraparounds of sk->sk_rmem_alloc.").

For example, if we set INT_MAX to SO_RCVBUFFORCE, the condition
is always false as the two operands are of int.

Then, a single socket can eat as many skb as possible until OOM
happens, and we can see multiple wraparounds of sk->sk_rmem_alloc.

Let's fix it by using atomic_add_return() and comparing the two
variables as unsigned int.

Before:
  [root@fedora ~]# ss -f netlink
  Recv-Q      Send-Q Local Address:Port                Peer Address:Port
  -1668710080 0               rtnl:nl_wraparound/293               *

After:
  [root@fedora ~]# ss -f netlink
  Recv-Q     Send-Q Local Address:Port                Peer Address:Port
  2147483072 0               rtnl:nl_wraparound/290               *
  ^
  `--- INT_MAX - 576

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Jason Baron <jbaron@akamai.com>
Closes: https://lore.kernel.org/netdev/cover.1750285100.git.jbaron@akamai.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/netlink/af_netlink.c | 81 ++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e8972a857e51..79fbaf7333ce 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -387,7 +387,6 @@ static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 	WARN_ON(skb->sk != NULL);
 	skb->sk = sk;
 	skb->destructor = netlink_skb_destructor;
-	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 	sk_mem_charge(sk, skb->truesize);
 }
 
@@ -1212,41 +1211,48 @@ struct sk_buff *netlink_alloc_large_skb(unsigned int size, int broadcast)
 int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 		      long *timeo, struct sock *ssk)
 {
+	DECLARE_WAITQUEUE(wait, current);
 	struct netlink_sock *nlk;
+	unsigned int rmem;
 
 	nlk = nlk_sk(sk);
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 
-	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
-		DECLARE_WAITQUEUE(wait, current);
-		if (!*timeo) {
-			if (!ssk || netlink_is_kernel(ssk))
-				netlink_overrun(sk);
-			sock_put(sk);
-			kfree_skb(skb);
-			return -EAGAIN;
-		}
-
-		__set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&nlk->wait, &wait);
+	if ((rmem == skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)) &&
+	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
+		netlink_skb_set_owner_r(skb, sk);
+		return 0;
+	}
 
-		if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-		     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
-		    !sock_flag(sk, SOCK_DEAD))
-			*timeo = schedule_timeout(*timeo);
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 
-		__set_current_state(TASK_RUNNING);
-		remove_wait_queue(&nlk->wait, &wait);
+	if (!*timeo) {
+		if (!ssk || netlink_is_kernel(ssk))
+			netlink_overrun(sk);
 		sock_put(sk);
+		kfree_skb(skb);
+		return -EAGAIN;
+	}
 
-		if (signal_pending(current)) {
-			kfree_skb(skb);
-			return sock_intr_errno(*timeo);
-		}
-		return 1;
+	__set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue(&nlk->wait, &wait);
+	rmem = atomic_read(&sk->sk_rmem_alloc);
+
+	if (((rmem && rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf)) ||
+	     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
+	    !sock_flag(sk, SOCK_DEAD))
+		*timeo = schedule_timeout(*timeo);
+
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&nlk->wait, &wait);
+	sock_put(sk);
+
+	if (signal_pending(current)) {
+		kfree_skb(skb);
+		return sock_intr_errno(*timeo);
 	}
-	netlink_skb_set_owner_r(skb, sk);
-	return 0;
+
+	return 1;
 }
 
 static int __netlink_sendskb(struct sock *sk, struct sk_buff *skb)
@@ -1307,6 +1313,7 @@ static int netlink_unicast_kernel(struct sock *sk, struct sk_buff *skb,
 	ret = -ECONNREFUSED;
 	if (nlk->netlink_rcv != NULL) {
 		ret = skb->len;
+		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 		netlink_skb_set_owner_r(skb, sk);
 		NETLINK_CB(skb).sk = ssk;
 		netlink_deliver_tap_kernel(sk, ssk, skb);
@@ -1383,13 +1390,19 @@ EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 static int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
+	unsigned int rmem, rcvbuf;
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+
+	if ((rmem != skb->truesize || rmem <= rcvbuf) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		__netlink_sendskb(sk, skb);
-		return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
+		return rmem > (rcvbuf >> 1);
 	}
+
+	atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 	return -1;
 }
 
@@ -2249,6 +2262,7 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	struct module *module;
 	int err = -ENOBUFS;
 	int alloc_min_size;
+	unsigned int rmem;
 	int alloc_size;
 
 	if (!lock_taken)
@@ -2258,9 +2272,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 		goto errout_skb;
 	}
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
-		goto errout_skb;
-
 	/* NLMSG_GOODSIZE is small to avoid high order allocations being
 	 * required, but it makes sense to _attempt_ a 32KiB allocation
 	 * to reduce number of system calls on dump operations, if user
@@ -2283,6 +2294,12 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	if (!skb)
 		goto errout_skb;
 
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	if (rmem >= READ_ONCE(sk->sk_rcvbuf)) {
+		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
+		goto errout_skb;
+	}
+
 	/* Trim skb to allocated size. User is expected to provide buffer as
 	 * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
 	 * netlink_recvmsg())). dump will pack as many smaller messages as
-- 
2.50.0.727.gbf7dc18ff4-goog


