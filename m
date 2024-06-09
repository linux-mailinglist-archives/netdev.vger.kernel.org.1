Return-Path: <netdev+bounces-102135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8974290180B
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 21:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CCFB20C39
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D46C433DF;
	Sun,  9 Jun 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="o+5R1nEE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840C14265
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717962823; cv=none; b=c/37LQSRJVbeaIdOSzdmrlLwEM88OhZp4bhXwi3EeiVQJExrLxiAEFO5bbTjFP+ly4rcemMblNz+OGjhy53Y0o2ke5pCOvBDF2RQMYmhcYGCBa/pZdE0vjOzCLLMjUxVB3ZopbflvCGeBIoeJtYYzngH5GVttd/hpDXycOKUgfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717962823; c=relaxed/simple;
	bh=53Z9S3ZhEoKC4PIWAWuCB0ij4LG/GJgSfeAkCujDgNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVJqeESibq1vCyuYMYIN88zIOw1TkQvErkO/KiYXR+kaTyvtZzh0yA/Evemi/Z6kbbQ++oy2OA6/x9PS+Cet4rpgV133rFEY+qo41+iXosKljdNcFBld+2iTxO9G35+WSsCUgivvdUIk0RAjyDQOtfh++HS00ZweXIGoZ5a+G1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=o+5R1nEE; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717962822; x=1749498822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+lFXalw01XM4FaAQapsZL/mVU0sfgGghfYNgGuBwWbA=;
  b=o+5R1nEEn0Oxc/UinorRM6lpQXgWX/JwMA+8DqFHxM3BvbzfnztlwcFp
   XR5MZKvZZYEtVeade1SgrgOrGijvhIthSF7E1hSjGRG7yWGFd6yVKj/vD
   kHjCXAHOXfVthzOXJEtzJZXO9pj+gXjTJwvlrv2xYSmaRz457kGrYZ74D
   g=;
X-IronPort-AV: E=Sophos;i="6.08,226,1712620800"; 
   d="scan'208";a="732320939"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 19:53:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:49099]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.106:2525] with esmtp (Farcaster)
 id 8c2a355f-f815-46c7-a729-2ef2347069bd; Sun, 9 Jun 2024 19:53:35 +0000 (UTC)
X-Farcaster-Flow-ID: 8c2a355f-f815-46c7-a729-2ef2347069bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 19:53:31 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 19:53:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <cong.wang@bytedance.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Sun, 9 Jun 2024 12:53:20 -0700
Message-ID: <20240609195320.95901-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ba5c50aa-1df4-40c2-ab33-a72022c5a32e@rbox.co>
References: <ba5c50aa-1df4-40c2-ab33-a72022c5a32e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Sun, 9 Jun 2024 13:28:34 +0200
> On 6/4/24 18:52, Kuniyuki Iwashima wrote:
> > When a SOCK_DGRAM socket connect()s to another socket, the both sockets'
> > sk->sk_state are changed to TCP_ESTABLISHED so that we can register them
> > to BPF SOCKMAP. (...)
> 
> Speaking of af_unix and sockmap, SOCK_STREAM has a tiny window for
> bpf(BPF_MAP_UPDATE_ELEM) and unix_stream_connect() to race: when
> sock_map_sk_state_allowed() passes (sk_state == TCP_ESTABLISHED), but
> unix_peer(sk) in unix_stream_bpf_update_proto() _still_ returns NULL:
> 
> 	T0 bpf				T1 connect
> 	======				==========
> 
> 				WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
> sock_map_sk_state_allowed(sk)
> ...
> sk_pair = unix_peer(sk)
> sock_hold(sk_pair)
> 				sock_hold(newsk)
> 				smp_mb__after_atomic()
> 				unix_peer(sk) = newsk
> 				unix_state_unlock(sk)
> 
> With mdelay(1) stuffed in unix_stream_connect():
> 
> [  902.277593] BUG: kernel NULL pointer dereference, address: 0000000000000080
> [  902.277633] #PF: supervisor write access in kernel mode
> [  902.277661] #PF: error_code(0x0002) - not-present page
> [  902.277688] PGD 107191067 P4D 107191067 PUD 10f63c067 PMD 0
> [  902.277716] Oops: Oops: 0002 [#23] PREEMPT SMP NOPTI
> [  902.277742] CPU: 2 PID: 1505 Comm: a.out Tainted: G      D            6.10.0-rc1+ #130
> [  902.277769] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [  902.277793] RIP: 0010:unix_stream_bpf_update_proto+0xa1/0x150
> 
> Setting TCP_ESTABLISHED _after_ unix_peer() fixes the issue, so how about
> something like
> 
> @@ -1631,12 +1631,13 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>         /* Set credentials */
>         copy_peercred(sk, other);
> 
> -       sock->state     = SS_CONNECTED;
> -       WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
>         sock_hold(newsk);
> +       smp_mb__after_atomic(); /* sock_hold() does an atomic_inc() */
> +       WRITE_ONCE(unix_peer(sk), newsk);
> +       smp_wmb(); /* ensure peer is set before sk_state */
> 
> -       smp_mb__after_atomic(); /* sock_hold() does an atomic_inc() */
> -       unix_peer(sk)   = newsk;
> +       sock->state = SS_CONNECTED;
> +       WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
> 
>         unix_state_unlock(sk);
> 
> @@ -180,7 +180,8 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
>          * be a single matching destroy operation.
>          */
>         if (!psock->sk_pair) {
> -               sk_pair = unix_peer(sk);
> +               smp_rmb();
> +               sk_pair = READ_ONCE(unix_peer(sk));
>                 sock_hold(sk_pair);
>                 psock->sk_pair = sk_pair;
>         }
> 
> This should keep things ordered and lockless... I hope.

sock_map_update_elem() assumes that the socket is protected
by lock_sock(), but AF_UNIX uses it only for the general path.

So, I think we should fix sock_map_sk_state_allowed() and
then use smp_store_release()/smp_load_acquire() rather than
smp_[rw]mb() for unix_peer(sk).

Could you test this with the mdelay(1) change ?

Note that we need not touch sock->state.  I have a patch for
net-next that removes sock->state uses completely from AF_UNIX
as we don't use it.  Even unix_seq_show() depends on sk->sk_state.

---8<---
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index d3dbb92153f2..67794d2c7498 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -549,7 +549,7 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 	if (sk_is_tcp(sk))
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
 	if (sk_is_stream_unix(sk))
-		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
+		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;
 	return true;
 }
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 80846279de9f..a558745c7d76 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1632,11 +1632,11 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	copy_peercred(sk, other);
 
 	sock->state	= SS_CONNECTED;
-	WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
 	sock_hold(newsk);
 
 	smp_mb__after_atomic();	/* sock_hold() does an atomic_inc() */
-	unix_peer(sk)	= newsk;
+	smp_store_release(&unix_peer(sk), newsk);
+	WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
 
 	unix_state_unlock(sk);
 
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index bd84785bf8d6..6d9ae8e63901 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -180,7 +180,7 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
 	 * be a single matching destroy operation.
 	 */
 	if (!psock->sk_pair) {
-		sk_pair = unix_peer(sk);
+		sk_pair = smp_load_acquire(&unix_peer(sk));
 		sock_hold(sk_pair);
 		psock->sk_pair = sk_pair;
 	}
---8<---


> 
> Alternatively, maybe it would be better just to make BPF respect the unix
> state lock?
> 
> @@ -180,6 +180,8 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
>  	 * be a single matching destroy operation.
>  	 */
>  	if (!psock->sk_pair) {
> +               unix_state_lock(sk);
>                 sk_pair = unix_peer(sk);
> +               unix_state_unlock(sk);
>  		sock_hold(sk_pair);
>  		psock->sk_pair = sk_pair;
> 
> What do you think?

If we'd go this way, I'd change like this:

---8<---
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index bd84785bf8d6..1db42cfee70d 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -159,8 +159,6 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
 
 int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
-	struct sock *sk_pair;
-
 	/* Restore does not decrement the sk_pair reference yet because we must
 	 * keep the a reference to the socket until after an RCU grace period
 	 * and any pending sends have completed.
@@ -180,9 +178,9 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
 	 * be a single matching destroy operation.
 	 */
 	if (!psock->sk_pair) {
-		sk_pair = unix_peer(sk);
-		sock_hold(sk_pair);
-		psock->sk_pair = sk_pair;
+		psock->sk_pair = unix_peer_get(sk);
+		if (WARN_ON_ONCE(!psock->sk_pair))
+			return -EINVAL;
 	}
 
 	unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
---8<---


And the _last_ option would be..., no :)

---8<---
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index b6eedf7650da..c7e31bc3e95e 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -94,8 +94,8 @@ struct unix_sock {
 #define unix_sk(ptr) container_of_const(ptr, struct unix_sock, sk)
 #define unix_peer(sk) (unix_sk(sk)->peer)
 
-#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
-#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
+#define unix_state_lock(s)	lock_sock(s)
+#define unix_state_unlock(s)	release_sock(s)
 enum unix_socket_lock_class {
 	U_LOCK_NORMAL,
 	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
@@ -108,7 +108,7 @@ enum unix_socket_lock_class {
 static inline void unix_state_lock_nested(struct sock *sk,
 				   enum unix_socket_lock_class subclass)
 {
-	spin_lock_nested(&unix_sk(sk)->lock, subclass);
+	lock_sock_nested(sk, subclass);
 }
 
 #define peer_wait peer_wq.wait
---8<---

