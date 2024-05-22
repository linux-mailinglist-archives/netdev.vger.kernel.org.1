Return-Path: <netdev+bounces-97598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D468CC411
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12F2280E87
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD15731B;
	Wed, 22 May 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H6Ta5U8F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FAB1CD16
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391704; cv=none; b=AvmY9nrcI0jScfxaMiCWNJQOlzXtHeo2wUR0hKoYusZEqH9/w1JvIM9YqanUF5rifIIhNQO9d8L2rWcypJbwQB8JbdGNkjb5yQkh1xCM2MT//rzDzaFkL++0wZ7xZW9wbLaOiNvGriCVQWna1YqbilaJlib8hhiG23jmqUViH5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391704; c=relaxed/simple;
	bh=juFYdxH3y7Svf9guPQrIGIts9Cu1PWXW7V9jq3BQwF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2EE/pEGe70Gf773R5VaRDv4gM0ztBhLa81psdTb/wKmLOHkbcn3TEwJMO/1zcyAehdWRRZcN9Cz1A12R6uBifhFcgB4LwgSIO2ySOGBLmf26NCOgUd/YrQNI8Pg+vSLLObcR3iETZcuFdlyVF+D80K/ZCfY8BA9+uNrydH6HeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H6Ta5U8F; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1716391702; x=1747927702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IBBDqZ/1Gt7oHWNsjQETSFrORFBWXPPcX2UX/lM6LJs=;
  b=H6Ta5U8FxHp2jmNwE9S+xA4y3XzH2wQbssNaDP9JuW4VxVGS5/iOpEF2
   aFA/6wfufNemgZQxT8lSekhsDkgN3Kjx1EmUWjnMg9P4aslJrrHpWbFGJ
   7WsbyRqKrzsp8rKv/6cFt1QzyxnW/EiTsvNLEjrCi4dSIR7vwSah0De4i
   E=;
X-IronPort-AV: E=Sophos;i="6.08,181,1712620800"; 
   d="scan'208";a="296825792"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 15:28:20 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:7189]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.178:2525] with esmtp (Farcaster)
 id d6100fe9-87d3-4418-b99e-1c573ce83146; Wed, 22 May 2024 15:28:20 +0000 (UTC)
X-Farcaster-Flow-ID: d6100fe9-87d3-4418-b99e-1c573ce83146
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 22 May 2024 15:28:20 +0000
Received: from 88665a182662.ant.amazon.com (10.143.93.121) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 22 May 2024 15:28:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net] af_unix: Annotate data-race around unix_sk(sk)->addr.
Date: Thu, 23 May 2024 00:28:06 +0900
Message-ID: <20240522152806.77000-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <f39283e8d2395a994255617a78a30702a1cc4f00.camel@redhat.com>
References: <f39283e8d2395a994255617a78a30702a1cc4f00.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 22 May 2024 17:25:23 +0200
> On Wed, 2024-05-22 at 23:53 +0900, Kuniyuki Iwashima wrote:
> > From: Paolo Abeni <pabeni@redhat.com>
> > Date: Wed, 22 May 2024 10:52:19 +0200
> > > On Sat, 2024-05-18 at 09:01 +0900, Kuniyuki Iwashima wrote:
> > > > Once unix_sk(sk)->addr is assigned under net->unx.table.locks,
> > > > *(unix_sk(sk)->addr) and unix_sk(sk)->path are fully set up, and
> > > > unix_sk(sk)->addr is never changed.
> > > > 
> > > > unix_getname() and unix_copy_addr() access the two fields locklessly,
> > > > and commit ae3b564179bf ("missing barriers in some of unix_sock ->addr
> > > > and ->path accesses") added smp_store_release() and smp_load_acquire()
> > > > pairs.
> > > > 
> > > > In other functions, we still read unix_sk(sk)->addr locklessly to check
> > > > if the socket is bound, and KCSAN complains about it.  [0]
> > > > 
> > > > Given these functions have no dependency for *(unix_sk(sk)->addr) and
> > > > unix_sk(sk)->path, READ_ONCE() is enough to annotate the data-race.
> > > > 
> > > > [0]:
> > > > BUG: KCSAN: data-race in unix_bind / unix_listen
> > > > 
> > > > write (marked) to 0xffff88805f8d1840 of 8 bytes by task 13723 on cpu 0:
> > > >  __unix_set_addr_hash net/unix/af_unix.c:329 [inline]
> > > >  unix_bind_bsd net/unix/af_unix.c:1241 [inline]
> > > >  unix_bind+0x881/0x1000 net/unix/af_unix.c:1319
> > > >  __sys_bind+0x194/0x1e0 net/socket.c:1847
> > > >  __do_sys_bind net/socket.c:1858 [inline]
> > > >  __se_sys_bind net/socket.c:1856 [inline]
> > > >  __x64_sys_bind+0x40/0x50 net/socket.c:1856
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> > > > 
> > > > read to 0xffff88805f8d1840 of 8 bytes by task 13724 on cpu 1:
> > > >  unix_listen+0x72/0x180 net/unix/af_unix.c:734
> > > >  __sys_listen+0xdc/0x160 net/socket.c:1881
> > > >  __do_sys_listen net/socket.c:1890 [inline]
> > > >  __se_sys_listen net/socket.c:1888 [inline]
> > > >  __x64_sys_listen+0x2e/0x40 net/socket.c:1888
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> > > > 
> > > > value changed: 0x0000000000000000 -> 0xffff88807b5b1b40
> > > > 
> > > > Reported by Kernel Concurrency Sanitizer on:
> > > > CPU: 1 PID: 13724 Comm: syz-executor.4 Not tainted 6.8.0-12822-gcd51db110a7e #12
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > > 
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > ---
> > > >  net/unix/af_unix.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > > index ca101690e740..92a88ac070ca 100644
> > > > --- a/net/unix/af_unix.c
> > > > +++ b/net/unix/af_unix.c
> > > > @@ -731,7 +731,7 @@ static int unix_listen(struct socket *sock, int backlog)
> > > >  	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET)
> > > >  		goto out;	/* Only stream/seqpacket sockets accept */
> > > >  	err = -EINVAL;
> > > > -	if (!u->addr)
> > > > +	if (!READ_ONCE(u->addr))
> > > >  		goto out;	/* No listens on an unbound socket */
> > > >  	unix_state_lock(sk);
> > > >  	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN)
> > > > @@ -1369,7 +1369,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
> > > >  
> > > >  		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> > > >  		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> > > > -		    !unix_sk(sk)->addr) {
> > > > +		    !READ_ONCE(unix_sk(sk)->addr)) {
> > > >  			err = unix_autobind(sk);
> > > >  			if (err)
> > > >  				goto out;
> > > > @@ -1481,7 +1481,8 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> > > >  		goto out;
> > > >  
> > > >  	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> > > > -	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
> > > > +	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> > > > +	    !READ_ONCE(u->addr)) {
> > > >  		err = unix_autobind(sk);
> > > >  		if (err)
> > > >  			goto out;
> > > > @@ -1951,7 +1952,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> > > >  	}
> > > >  
> > > >  	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> > > > -	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
> > > > +	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> > > > +	    !READ_ONCE(u->addr)) {
> > > >  		err = unix_autobind(sk);
> > > >  		if (err)
> > > >  			goto out;
> > > 
> > > There are a few other places where ->addr is accessed lockless (under
> > > the bindlock, but prior to acquiring the table spinlock, e.g.
> > > unix_bind_* and unix_autobind. The latter is suspect as it's called
> > > right after the touched code. Why are such spots not relevant here?
> > 
> > When u->addr is set, bindlock and the hash table lock are held.
> > unix_bind_(abstract|bsd)() and unix_autobind() are all serialised
> > by bindlock, so ->addr check after acquiring bindlock is not
> > lockless actually.
> > 
> > 
> > > 
> > > Also the  newu->addr/otheru->addr handling in unix_stream_connect()
> > > looks suspect.
> > 
> > u->addr is set before the socket is put into the hash table, and
> > it never changes after bind().
> > 
> > otheru is found by unix_find_other() from the hash table, and then
> > we access ->addr in unix_stream_connect().  So, there is no race.
> 
> I see. 
> 
> I think the serialization chain is not trivial, I think it would help
> future memory to at least mention it in the commit message or in a code
> comment.

Will add more explanation in the commit message in v2.

Thanks!

