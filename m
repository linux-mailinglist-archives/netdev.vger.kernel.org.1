Return-Path: <netdev+bounces-200779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63248AE6D4E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE203B145D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B74F26CE0D;
	Tue, 24 Jun 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay3g6O5U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481A229B2E
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784980; cv=none; b=aJS946YyVvkrfll2sQrwtNzfE+q6qU15gbSQ5qbjSXbo+9W8LpmTobIcgH1ANdMoC9sd/T0iTJs/GFxN4XmLOvvLp0iNIFvCVxdoZH+C4ZY5xT6dX/3aruQpS/9tYmvRAkBjR7n49LOl+Zf/aj+WQbNozDYLt/EpK7mzx8DaUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784980; c=relaxed/simple;
	bh=OYpUD+nr8EzCbabO/puLiWYHoeQeSNMLcEVUvsxKQWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/hmZC4qUUQjef4Pi8B7W424oSnwF6W4psVw2Wf7Tua9o37EyIHTeqMJ8Y/+NrxZzFAXJTNDPktpxxQXBix/AiW/VXtRVCfi+llrezf77/SiJtfdvK0Ly3jlXlWeL+5i+GBBYK4iTt1UMyyB2SOML354qCPh/RpraOgMLQAwd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay3g6O5U; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2c4476d381so132047a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750784976; x=1751389776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH8wzFzU5kp/atSvIhqvEIcmATXa8xJ+xH7wvbYzSJU=;
        b=Ay3g6O5UUOFKGzb1NkoYMnnR4ghLeKiaaPBLrul2oW2NmX3eOPvHucRrRIDjaB65cq
         p443KlIIxEAp/OhY7T/gu3pddwm3YI92WEKQjI1wBbYGYF3TrpYjxPuMLyjQLy5aQy9M
         XxtcUvZPa5Zw7p1WMkq6nzqJut4q5keOBDlSckjPrE4rIraomDQNekM9DcaXB7i3x19e
         db5O18KW1+F8XWc2yg4B5lyAEQJ6FO7eHpCUMwcFkyoNOs/NV33fCgBlPtjWKcyWQRjT
         xT/zr6oP8ioOESatQbJQvjQ0puxGqF7mcvugkYWJMlxl2MaRwWjjzGGEHOxnwzuzYoSc
         RRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784976; x=1751389776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH8wzFzU5kp/atSvIhqvEIcmATXa8xJ+xH7wvbYzSJU=;
        b=ucUX5JCOpxO7pDJwlQujFhBNGc6FnHse7ae9R0Fdm59IDdMypjYaBWCC/95+TJGPvn
         LY3e34h9SZ3NfuOY0iYjPOLmrzHPm/CYJRn17yGe6yyNRPU9HnvsVjbXH79w0SgxjKTf
         JTWT7JHlN2+npy0tMCGowXqWCNlXz0t2mHwFJfVSpewkRaPvJbnyMO6D818kEF7+/OsY
         I59dlfpbhA7J1Yifm94VwBMfqCmdY7TLhYrNBU8+7kDhQPw7guSfzcdKCfqCDuR847XZ
         nz58tXMaVYb4FmBqQmBABGVwOng1TjxGmZByAty3fO7sfU8XSPJMMDmhO9wqE51bKxJK
         ipmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUinGXJ/9jK0O+c+Ml39TOW7NY/mhXWRiTXNXh2FMKMhkBK6QtcalCJi9AcJzxnpq5UOVfSRNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYazpkQMq2/ISvPk5k0ieIAOptZsfjhLxS2r/M1Ical6omRvO
	1gDth3bzHuXcbW92+oruiqUSE7IHDEjcSwABKSQSOKueyZ0ew+Mi39iiHVlk/hTeaVKj
X-Gm-Gg: ASbGnctwYiN0Z6F8uAusqug/yhkG4NXhfUwKMK6MkOKYgW90cJHoufrUkgHky7Xlt/U
	J1zWYrCpUC/f46xs4jueFciT6yTxWchIK5ge42o413ojeuM0OhMwWMmLsBBri8uhYPslQaiApT+
	OSXfyNHEKNH1PjdZ+WuRhAFYIZxP4xcvZ7OtOhcntXUVcugfNcDZHqoUYCQebIjb87pvdjGyeTp
	Os7Ype0VFD4hY2swyUU7E1ZjOSKqBZNEViVlSDs8SkVcUGEcfMf9vtxlV+eEuxv0lKCXdL3w5uj
	Ej8qJ5qCgOoTsu7o8xFnORlaoBmbZN03Fd1JLkk=
X-Google-Smtp-Source: AGHT+IHlD1jJMX3+tvEAgQUmH5wYPhF52HMVsCxUCdiJtQZuOER0wCx/u7FjeW3+QciV9gZGoAG+NQ==
X-Received: by 2002:a05:6a00:21cf:b0:748:e289:6bc with SMTP id d2e1a72fcca58-74955b64e13mr5418144b3a.1.1750784975720;
        Tue, 24 Jun 2025 10:09:35 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8835595sm2331441b3a.103.2025.06.24.10.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 10:09:35 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jbaron@akamai.com,
	kuni1840@gmail.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 3/3] netlink: Fix wraparound of sk->sk_rmem_alloc
Date: Tue, 24 Jun 2025 10:08:41 -0700
Message-ID: <20250624170933.419907-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624071157.3cbb1265@kernel.org>
References: <20250624071157.3cbb1265@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Date: Tue, 24 Jun 2025 07:11:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
> On Tue, 24 Jun 2025 09:55:15 +0200 Paolo Abeni wrote:
> > > To be clear -- are you saying we should fix this differently?
> > > Or perhaps that the problem doesn't exist? The change doesn't
> > > seem very intrusive..  
> > 
> > AFAICS the race is possible even with netlink as netlink_unicast() runs
> > without the socket lock, too.
> > 
> > The point is that for UDP the scenario with multiple threads enqueuing a
> > packet into the same socket is a critical path, optimizing for
> > performances and allowing some memory accounting inaccuracy makes sense.
> > 
> > For netlink socket, that scenario looks a patological one and I think we
> > should prefer accuracy instead of optimization.
> 
> Could you ELI5 what you mean? Are you suggesting a lock around every
> sk_rmem write for netlink sockets? 
> If we think this is an attack vector the attacker can simply use a UDP
> socket instead. Or do you think it'd lead to simpler code?

I was wondering if atomic_add_return() is expensive for netlink,
and if not, we could use it like below.  I'm also not sure we want
to keep the allow-at-least-one-skb rule for netlink though, which
comes from the first condition in __sock_queue_rcv_skb() for UDP
in the past, IIRC.

untested:

---8<---
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e8972a857e51..e1a9ae7ff521 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -387,7 +387,6 @@ static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 	WARN_ON(skb->sk != NULL);
 	skb->sk = sk;
 	skb->destructor = netlink_skb_destructor;
-	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 	sk_mem_charge(sk, skb->truesize);
 }
 
@@ -1212,41 +1211,45 @@ struct sk_buff *netlink_alloc_large_skb(unsigned int size, int broadcast)
 int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 		      long *timeo, struct sock *ssk)
 {
+	unsigned long rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	DECLARE_WAITQUEUE(wait, current);
 	struct netlink_sock *nlk;
 
 	nlk = nlk_sk(sk);
 
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
+	if (rmem == skb->truesize ||
+	    (rmem < sk->sk_rcvbuf && !test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
+		netlink_skb_set_owner_r(skb, sk);
+		return 0;
+	}
 
-		if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-		     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
-		    !sock_flag(sk, SOCK_DEAD))
-			*timeo = schedule_timeout(*timeo);
+	atomic_dec(skb->truesize, &sk->sk_rmem_alloc);
 
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
+
+	if ((atomic_read(&sk->sk_rmem_alloc) + skb->truesize > sk->sk_rcvbuf ||
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
+	return 1;
 }
 
 static int __netlink_sendskb(struct sock *sk, struct sk_buff *skb)
@@ -1307,6 +1310,7 @@ static int netlink_unicast_kernel(struct sock *sk, struct sk_buff *skb,
 	ret = -ECONNREFUSED;
 	if (nlk->netlink_rcv != NULL) {
 		ret = skb->len;
+		atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 		netlink_skb_set_owner_r(skb, sk);
 		NETLINK_CB(skb).sk = ssk;
 		netlink_deliver_tap_kernel(sk, ssk, skb);
@@ -1382,14 +1386,18 @@ EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 
 static int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
 {
+	unsigned long rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	unsigned int rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	struct netlink_sock *nlk = nlk_sk(sk);
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
-	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
+	if (rmem == skb->truesize ||
+	    (size <= rcvbuf && !test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
 		netlink_skb_set_owner_r(skb, sk);
 		__netlink_sendskb(sk, skb);
-		return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
+		return size > (rcvbuf >> 1);
 	}
+
+	atomic_dec(skb->truesize, &sk->sk_rmem_alloc);
 	return -1;
 }
 
@@ -2249,6 +2257,7 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	struct module *module;
 	int err = -ENOBUFS;
 	int alloc_min_size;
+	unsigned int rmem;
 	int alloc_size;
 
 	if (!lock_taken)
@@ -2258,9 +2267,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 		goto errout_skb;
 	}
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
-		goto errout_skb;
-
 	/* NLMSG_GOODSIZE is small to avoid high order allocations being
 	 * required, but it makes sense to _attempt_ a 32KiB allocation
 	 * to reduce number of system calls on dump operations, if user
@@ -2283,6 +2289,12 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	if (!skb)
 		goto errout_skb;
 
+	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
+	if (rmem != skb->truesize && rmem >= sk->sk_rcvbuf) {
+		atomic_dec(skb->truesize, &sk->sk_rmem_alloc);
+		goto errout_skb;
+	}
+
 	/* Trim skb to allocated size. User is expected to provide buffer as
 	 * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
 	 * netlink_recvmsg())). dump will pack as many smaller messages as
---8<---

