Return-Path: <netdev+bounces-102138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6310901833
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 23:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71969281426
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 21:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CF5134B1;
	Sun,  9 Jun 2024 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NFKVWHp0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8218C22
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717967002; cv=none; b=XdpzSuBy/q1DR4tlnqePDMg0hXeWROvCcIi6t5bxK5gFKVJTmdtU5PFRUkcEs2SlkYpW2xGSdFMM42ZVybFMCLUCywvCn4Em0J8vLeOffy35UCtWEcKsA+nUVhcEOZlWtWq2i+vreZRrifrFq1cnXzXG/kc5FjJz+gokZk710Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717967002; c=relaxed/simple;
	bh=qE0HaZJtA8V3FYkoRgqg3VVBDeb0CfqWhdPcE1drZSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLyLlxffealkwdIzxihI7sY5Lkf4BBCiuD9O6yL60yQu9ol+FKLmxCrBD94/m5J5w03DvLDsUtiZohrQywMXmTvr4BEcIzG00xCRT6Ba2prnIyIPrHCRRB6SKR1A1WR+jkNDsDrO8hICmr7hmeFC6jVN6gJjNAlRT4TcLwjeiNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NFKVWHp0; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717967000; x=1749503000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FY8SpMb1Qsfaqt1AHawbl/VnqWxCfCjAuIZpAwsfuTc=;
  b=NFKVWHp0KmtYb+Vx+ME9QCq1dgxJvYvbAEAMklWLl5MdMsj054rHzzu3
   Dw0pA4TG0k47icftovNZ5zD4Cj+mBgmZ1sl3FuEWony+jk93SBiTUG8DY
   y3tDlCGjl9BRlG+Gc/Ue75a8dXA7pAGwlsWSbXejv3eXl1amtpGEyMAdT
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,226,1712620800"; 
   d="scan'208";a="95507074"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 21:03:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:10111]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.12:2525] with esmtp (Farcaster)
 id 93804839-85c7-4a1d-bc95-de208c83cc74; Sun, 9 Jun 2024 21:03:18 +0000 (UTC)
X-Farcaster-Flow-ID: 93804839-85c7-4a1d-bc95-de208c83cc74
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 21:03:18 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 21:03:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <cong.wang@bytedance.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <mhal@rbox.co>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Sun, 9 Jun 2024 14:03:07 -0700
Message-ID: <20240609210307.2919-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240609195320.95901-1-kuniyu@amazon.com>
References: <20240609195320.95901-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Sun, 9 Jun 2024 12:53:20 -0700
> From: Michal Luczaj <mhal@rbox.co>
> Date: Sun, 9 Jun 2024 13:28:34 +0200
> > On 6/4/24 18:52, Kuniyuki Iwashima wrote:
> > > When a SOCK_DGRAM socket connect()s to another socket, the both sockets'
> > > sk->sk_state are changed to TCP_ESTABLISHED so that we can register them
> > > to BPF SOCKMAP. (...)
> > 
> > Speaking of af_unix and sockmap, SOCK_STREAM has a tiny window for
> > bpf(BPF_MAP_UPDATE_ELEM) and unix_stream_connect() to race: when
> > sock_map_sk_state_allowed() passes (sk_state == TCP_ESTABLISHED), but
> > unix_peer(sk) in unix_stream_bpf_update_proto() _still_ returns NULL:
> > 
> > 	T0 bpf				T1 connect
> > 	======				==========
> > 
> > 				WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
> > sock_map_sk_state_allowed(sk)
> > ...
> > sk_pair = unix_peer(sk)
> > sock_hold(sk_pair)
> > 				sock_hold(newsk)
> > 				smp_mb__after_atomic()
> > 				unix_peer(sk) = newsk
> > 				unix_state_unlock(sk)
> > 
> > With mdelay(1) stuffed in unix_stream_connect():
> > 
> > [  902.277593] BUG: kernel NULL pointer dereference, address: 0000000000000080
> > [  902.277633] #PF: supervisor write access in kernel mode
> > [  902.277661] #PF: error_code(0x0002) - not-present page
> > [  902.277688] PGD 107191067 P4D 107191067 PUD 10f63c067 PMD 0
> > [  902.277716] Oops: Oops: 0002 [#23] PREEMPT SMP NOPTI
> > [  902.277742] CPU: 2 PID: 1505 Comm: a.out Tainted: G      D            6.10.0-rc1+ #130
> > [  902.277769] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> > [  902.277793] RIP: 0010:unix_stream_bpf_update_proto+0xa1/0x150
> > 
> > Setting TCP_ESTABLISHED _after_ unix_peer() fixes the issue, so how about
> > something like
> > 
> > @@ -1631,12 +1631,13 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> >         /* Set credentials */
> >         copy_peercred(sk, other);
> > 
> > -       sock->state     = SS_CONNECTED;
> > -       WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
> >         sock_hold(newsk);
> > +       smp_mb__after_atomic(); /* sock_hold() does an atomic_inc() */
> > +       WRITE_ONCE(unix_peer(sk), newsk);
> > +       smp_wmb(); /* ensure peer is set before sk_state */
> > 
> > -       smp_mb__after_atomic(); /* sock_hold() does an atomic_inc() */
> > -       unix_peer(sk)   = newsk;
> > +       sock->state = SS_CONNECTED;
> > +       WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
> > 
> >         unix_state_unlock(sk);
> > 
> > @@ -180,7 +180,8 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
> >          * be a single matching destroy operation.
> >          */
> >         if (!psock->sk_pair) {
> > -               sk_pair = unix_peer(sk);
> > +               smp_rmb();
> > +               sk_pair = READ_ONCE(unix_peer(sk));
> >                 sock_hold(sk_pair);
> >                 psock->sk_pair = sk_pair;
> >         }
> > 
> > This should keep things ordered and lockless... I hope.
> 
> sock_map_update_elem() assumes that the socket is protected
> by lock_sock(), but AF_UNIX uses it only for the general path.
> 
> So, I think we should fix sock_map_sk_state_allowed() and
> then use smp_store_release()/smp_load_acquire() rather than
> smp_[rw]mb() for unix_peer(sk).

Sorry, I think I was wrong and we can't use smp_store_release()
and smp_load_acquire(), and smp_[rw]mb() is needed.

Given we avoid adding code in the hotpath in the original fix
8866730aed510 [0], I prefer adding unix_state_lock() in the SOCKMAP
path again.

[0]: https://lore.kernel.org/bpf/6545bc9f7e443_3358c208ae@john.notmuch/

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

