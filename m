Return-Path: <netdev+bounces-97593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6558CC393
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034E82814E3
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9721CD16;
	Wed, 22 May 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gqv+jWF2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97E18645
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389609; cv=none; b=Xsu9ihrA9TfVDw78L4Ucex5ify/od7j/h3rfdR760y+vVMFFkmcLUx+xELU3MkC4cusIzjpsGrj0juuHGTVNnQy/hv+GtCxqH3neexHtYt0cqXCLcEiEEj2n7yb+wQAn9veT5h4OOJ/MePy/DztbtXahMZbw73NVx/r3A7wi4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389609; c=relaxed/simple;
	bh=aOGxFH+6nyPi7nJ7BqkXsmKGX5qYEWCNNSRQAF20bak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8+SrxprMkw3Y9QGODyyLXOC1Pl79XtxT7bewa0orcLiYKAmQY+4ggHmnytWw3WwgC30kYB18/Yey18LnrnLVDYRWMd7ieBqnOhmjWQmsyomljYQm6hkj+uSqibB5uTlrKvfpup7IKbF9YoUrvGKnrZ9F4U/ByvvXCnbLU6lLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Gqv+jWF2; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1716389608; x=1747925608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SgRSyqCqMHmxrxmT9lz/LMiB14np5R4uzyb1tWGIkDw=;
  b=Gqv+jWF2Gb/M+Yd4vE+/BYhfbYW2p8yj0QLyrlz9Xfq/Su8pYv4pFI19
   X6jYzAp+asp5Txzfzl+6R1/F7x6y9BCPMAj5ZNA2f4CCbSFv5e0RWmPEE
   zjDWo22d37Kivsbyla15LHXAfHangFglnyIvEwleRkq1aTODinBhJ7EWT
   I=;
X-IronPort-AV: E=Sophos;i="6.08,181,1712620800"; 
   d="scan'208";a="296816174"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 14:53:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:41267]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.50:2525] with esmtp (Farcaster)
 id cae9aef9-08a5-4217-afe6-5a0347d643f4; Wed, 22 May 2024 14:53:23 +0000 (UTC)
X-Farcaster-Flow-ID: cae9aef9-08a5-4217-afe6-5a0347d643f4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 22 May 2024 14:53:23 +0000
Received: from 88665a182662.ant.amazon.com (10.143.93.121) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 22 May 2024 14:53:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net] af_unix: Annotate data-race around unix_sk(sk)->addr.
Date: Wed, 22 May 2024 23:53:09 +0900
Message-ID: <20240522145309.74255-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <6a187b65c4b2e487461e5d3b2270670586841d84.camel@redhat.com>
References: <6a187b65c4b2e487461e5d3b2270670586841d84.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 22 May 2024 10:52:19 +0200
> On Sat, 2024-05-18 at 09:01 +0900, Kuniyuki Iwashima wrote:
> > Once unix_sk(sk)->addr is assigned under net->unx.table.locks,
> > *(unix_sk(sk)->addr) and unix_sk(sk)->path are fully set up, and
> > unix_sk(sk)->addr is never changed.
> > 
> > unix_getname() and unix_copy_addr() access the two fields locklessly,
> > and commit ae3b564179bf ("missing barriers in some of unix_sock ->addr
> > and ->path accesses") added smp_store_release() and smp_load_acquire()
> > pairs.
> > 
> > In other functions, we still read unix_sk(sk)->addr locklessly to check
> > if the socket is bound, and KCSAN complains about it.  [0]
> > 
> > Given these functions have no dependency for *(unix_sk(sk)->addr) and
> > unix_sk(sk)->path, READ_ONCE() is enough to annotate the data-race.
> > 
> > [0]:
> > BUG: KCSAN: data-race in unix_bind / unix_listen
> > 
> > write (marked) to 0xffff88805f8d1840 of 8 bytes by task 13723 on cpu 0:
> >  __unix_set_addr_hash net/unix/af_unix.c:329 [inline]
> >  unix_bind_bsd net/unix/af_unix.c:1241 [inline]
> >  unix_bind+0x881/0x1000 net/unix/af_unix.c:1319
> >  __sys_bind+0x194/0x1e0 net/socket.c:1847
> >  __do_sys_bind net/socket.c:1858 [inline]
> >  __se_sys_bind net/socket.c:1856 [inline]
> >  __x64_sys_bind+0x40/0x50 net/socket.c:1856
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> > 
> > read to 0xffff88805f8d1840 of 8 bytes by task 13724 on cpu 1:
> >  unix_listen+0x72/0x180 net/unix/af_unix.c:734
> >  __sys_listen+0xdc/0x160 net/socket.c:1881
> >  __do_sys_listen net/socket.c:1890 [inline]
> >  __se_sys_listen net/socket.c:1888 [inline]
> >  __x64_sys_listen+0x2e/0x40 net/socket.c:1888
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> > 
> > value changed: 0x0000000000000000 -> 0xffff88807b5b1b40
> > 
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 13724 Comm: syz-executor.4 Not tainted 6.8.0-12822-gcd51db110a7e #12
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/af_unix.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index ca101690e740..92a88ac070ca 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -731,7 +731,7 @@ static int unix_listen(struct socket *sock, int backlog)
> >  	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET)
> >  		goto out;	/* Only stream/seqpacket sockets accept */
> >  	err = -EINVAL;
> > -	if (!u->addr)
> > +	if (!READ_ONCE(u->addr))
> >  		goto out;	/* No listens on an unbound socket */
> >  	unix_state_lock(sk);
> >  	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN)
> > @@ -1369,7 +1369,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
> >  
> >  		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> >  		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> > -		    !unix_sk(sk)->addr) {
> > +		    !READ_ONCE(unix_sk(sk)->addr)) {
> >  			err = unix_autobind(sk);
> >  			if (err)
> >  				goto out;
> > @@ -1481,7 +1481,8 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> >  		goto out;
> >  
> >  	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> > -	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
> > +	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> > +	    !READ_ONCE(u->addr)) {
> >  		err = unix_autobind(sk);
> >  		if (err)
> >  			goto out;
> > @@ -1951,7 +1952,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> >  	}
> >  
> >  	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
> > -	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
> > +	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
> > +	    !READ_ONCE(u->addr)) {
> >  		err = unix_autobind(sk);
> >  		if (err)
> >  			goto out;
> 
> There are a few other places where ->addr is accessed lockless (under
> the bindlock, but prior to acquiring the table spinlock, e.g.
> unix_bind_* and unix_autobind. The latter is suspect as it's called
> right after the touched code. Why are such spots not relevant here?

When u->addr is set, bindlock and the hash table lock are held.
unix_bind_(abstract|bsd)() and unix_autobind() are all serialised
by bindlock, so ->addr check after acquiring bindlock is not
lockless actually.


> 
> Also the  newu->addr/otheru->addr handling in unix_stream_connect()
> looks suspect.

u->addr is set before the socket is put into the hash table, and
it never changes after bind().

otheru is found by unix_find_other() from the hash table, and then
we access ->addr in unix_stream_connect().  So, there is no race.

Also, newu is a child socket created by connect() and does not exist
in the hash table but has ->addr set.  At this moment, no one can
read its ->addr, and smp_store_release() publishes it for the later
->getname() in case the child socket is accept()ed.

Thanks!

