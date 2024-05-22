Return-Path: <netdev+bounces-97596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E498CC3DF
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4BB280F17
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1725E249FE;
	Wed, 22 May 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VysHxPV6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBC23768
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390678; cv=none; b=CAbd9j+Mjd35qmzR+M1aB2XVLH0CmUaxxHbj6abpTOsGri6SwRUHcQRhY9NlMTmfid7k8fk0+rJwBLQOJ2RF3W1+6uTSQjsTq67oLAc/K1A67OZFEpiqDSNeJzw++MM8tAvLoYt2MSydra8a7HlrQXBX02xj4q29b0VBs59a2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390678; c=relaxed/simple;
	bh=EmIRiHThmkVrRgYODY84CtJsL9Znsd2JBN/EiNngz+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWwI8F5UTxgWDhdrikSXWqJ8U6hjvT2nuRH42PmJ1gH8Zpwf91gqzHDVDajC4UlHt/Fq3xHHLiSSFhhVMtxTpdeJSNCRZnUZ9k6TLy8LiIUbAuvJwBC6rMQ7mR1wsRvXEsQthK7pyNtyDP5OnBtCzFTbTmcJNok59EkxCTOHcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VysHxPV6; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1716390677; x=1747926677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rGtSrhuSPgZTC2fFY6wrxBF5EvYrLBsQUS5w0qS6tlQ=;
  b=VysHxPV63odC/jqgka1cheqzUxzKECfOWGL8IO9EGwn0jsXXxF+JAcmu
   afw7yzC2nZGRmhyFRIQ3Cw/brZLv2Xf1WpvvTpLmAnA4B07qRBi5l88/L
   8Y0S7A1r7kVcjqsMczgsyVW6kM6RWwRs6CKeINb5W7CLCYzBZNjAH8TPu
   k=;
X-IronPort-AV: E=Sophos;i="6.08,181,1712620800"; 
   d="scan'208";a="398302146"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 15:11:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:52063]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.178:2525] with esmtp (Farcaster)
 id 16ac8b13-cb37-4d32-ab36-eed181c34b89; Wed, 22 May 2024 15:11:12 +0000 (UTC)
X-Farcaster-Flow-ID: 16ac8b13-cb37-4d32-ab36-eed181c34b89
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 22 May 2024 15:11:12 +0000
Received: from 88665a182662.ant.amazon.com (10.143.93.121) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 22 May 2024 15:11:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dvyukov@google.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net] af_unix: Annotate data-races around sk->sk_hash.
Date: Thu, 23 May 2024 00:10:56 +0900
Message-ID: <20240522151056.75649-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c60009edfc0e5f3bd389860ff9d0224b32e39ee0.camel@redhat.com>
References: <c60009edfc0e5f3bd389860ff9d0224b32e39ee0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 22 May 2024 11:13:37 +0200
> On Tue, 2024-05-21 at 06:16 +0200, Dmitry Vyukov wrote:
> > On Sat, 18 May 2024 at 03:14, 'Kuniyuki Iwashima' via syzkaller
> > <syzkaller@googlegroups.com> wrote:
> > > 
> > > syzkaller reported data-race of sk->sk_hash in unix_autobind() [0],
> > > and the same ones exist in unix_bind_bsd() and unix_bind_abstract().
> > > 
> > > The three bind() functions prefetch sk->sk_hash locklessly and
> > > use it later after validating that unix_sk(sk)->addr is NULL under
> > > unix_sk(sk)->bindlock.
> > > 
> > > The prefetched sk->sk_hash is the hash value of unbound socket set
> > > in unix_create1() and does not change until bind() completes.
> > > 
> > > There could be a chance that sk->sk_hash changes after the lockless
> > > read.  However, in such a case, non-NULL unix_sk(sk)->addr is visible
> > > under unix_sk(sk)->bindlock, and bind() returns -EINVAL without using
> > > the prefetched value.
> > > 
> > > The KCSAN splat is false-positive, but let's use WRITE_ONCE() and
> > > READ_ONCE() to silence it.
> > > 
> > > [0]:
> > > BUG: KCSAN: data-race in unix_autobind / unix_autobind
> > > 
> > > write to 0xffff888034a9fb88 of 4 bytes by task 4468 on cpu 0:
> > >  __unix_set_addr_hash net/unix/af_unix.c:331 [inline]
> > >  unix_autobind+0x47a/0x7d0 net/unix/af_unix.c:1185
> > >  unix_dgram_connect+0x7e3/0x890 net/unix/af_unix.c:1373
> > >  __sys_connect_file+0xd7/0xe0 net/socket.c:2048
> > >  __sys_connect+0x114/0x140 net/socket.c:2065
> > >  __do_sys_connect net/socket.c:2075 [inline]
> > >  __se_sys_connect net/socket.c:2072 [inline]
> > >  __x64_sys_connect+0x40/0x50 net/socket.c:2072
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> > > 
> > > read to 0xffff888034a9fb88 of 4 bytes by task 4465 on cpu 1:
> > >  unix_autobind+0x28/0x7d0 net/unix/af_unix.c:1134
> > >  unix_dgram_connect+0x7e3/0x890 net/unix/af_unix.c:1373
> > >  __sys_connect_file+0xd7/0xe0 net/socket.c:2048
> > >  __sys_connect+0x114/0x140 net/socket.c:2065
> > >  __do_sys_connect net/socket.c:2075 [inline]
> > >  __se_sys_connect net/socket.c:2072 [inline]
> > >  __x64_sys_connect+0x40/0x50 net/socket.c:2072
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> > > 
> > > value changed: 0x000000e4 -> 0x000001e3
> > > 
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 1 PID: 4465 Comm: syz-executor.0 Not tainted 6.8.0-12822-gcd51db110a7e #12
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > 
> > > Fixes: afd20b9290e1 ("af_unix: Replace the big lock with small locks.")
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/unix/af_unix.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index 92a88ac070ca..e92b45e21664 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -327,8 +327,7 @@ static void __unix_set_addr_hash(struct net *net, struct sock *sk,
> > >  {
> > >         __unix_remove_socket(sk);
> > >         smp_store_release(&unix_sk(sk)->addr, addr);
> > > -
> > > -       sk->sk_hash = hash;
> > > +       WRITE_ONCE(sk->sk_hash, hash);
> > >         __unix_insert_socket(net, sk);
> > >  }
> > > 
> > > @@ -1131,7 +1130,7 @@ static struct sock *unix_find_other(struct net *net,
> > > 
> > >  static int unix_autobind(struct sock *sk)
> > >  {
> > > -       unsigned int new_hash, old_hash = sk->sk_hash;
> > > +       unsigned int new_hash, old_hash = READ_ONCE(sk->sk_hash);
> > >         struct unix_sock *u = unix_sk(sk);
> > >         struct net *net = sock_net(sk);
> > >         struct unix_address *addr;
> > > @@ -1195,7 +1194,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
> > >  {
> > >         umode_t mode = S_IFSOCK |
> > >                (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
> > > -       unsigned int new_hash, old_hash = sk->sk_hash;
> > > +       unsigned int new_hash, old_hash = READ_ONCE(sk->sk_hash);
> > >         struct unix_sock *u = unix_sk(sk);
> > >         struct net *net = sock_net(sk);
> > >         struct mnt_idmap *idmap;
> > > @@ -1261,7 +1260,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
> > >  static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
> > >                               int addr_len)
> > >  {
> > > -       unsigned int new_hash, old_hash = sk->sk_hash;
> > > +       unsigned int new_hash, old_hash = READ_ONCE(sk->sk_hash);
> > >         struct unix_sock *u = unix_sk(sk);
> > >         struct net *net = sock_net(sk);
> > >         struct unix_address *addr;
> > 
> > 
> > 
> > Hi,
> > 
> > I don't know much about this code, but perhaps these accesses must be
> > protected by bindlock instead?
> > It shouldn't autobind twice, right? Perhaps the code just tried to
> > save a line of code and moved the reads to the variable declaration
> > section.
> 
> I also think that sk_hash is/should be under bindlock protection, and
> thus moving the read should be better.

I thought ->addr check after bindlock is enough but I don't have
strong preference.

Will move the read after bindlock.


> 
> Otherwise even the first sk->sk_hash in unix_insert_bsd_socket() would
> be 'lockless' - prior/outside to the table lock.

Once u->addr is set during bind(), it's fine to read sk_hash locklessly
without READ_ONCE().

Thanks!

