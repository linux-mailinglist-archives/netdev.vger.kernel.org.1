Return-Path: <netdev+bounces-190863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F8BAB923C
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC7E4E6AC8
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343961F2BAD;
	Thu, 15 May 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="BC3lhfhl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAA3D3B8
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747347470; cv=none; b=TmMkBCktF3ax0pWBP6q+q6y6L6O1moJsC7vb8Fq4rs1RQ/JcbfyiojI1jpRO7ptkCXRvqMFIXKdR6VW5Wn7SUQuxvgMf+C1yMhr/f9Xcnv1c/HOCzEiaIJjakPkkRPqfPC5Wf4ahg2D6ridR9jXxYAxb2XBBVgPQ51i+rqEu8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747347470; c=relaxed/simple;
	bh=gqr3KMINEwVhjKFyPmIMmG+ZAsRWjvMvDgE0NYaZHQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPn48DZDdwofi652AAm40sVycH/RfhVH43OU+PqC2HwZRg+EuOYfI2LOmpLzTGSU0HH4fl0G1zmn7sY7zVqls/eFX06xitOsIiFn9qVr6vFANEsPiorTnhQsVfX1xUYI67R9oO3/27KLB4DiFeYbekufSHHhDvVCWy+ezmtpOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=BC3lhfhl; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747347468; x=1778883468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BKItQcfXvSMAezeXx2l6C7MuiCih6JqNbvfaZYGQIcM=;
  b=BC3lhfhlJgmeVl9qGxyWLN+ZG6lC7lxAiG6uyudY6k/HA1sXe1fR3QCP
   nOKZ+ZDJXhSOjYR0U2qa12AAE6dfxVWwo3Yo1g/qfmGy6tQkt25Fz9hE7
   GJrS5XLHGutrmT9QCIwCfa3zEzcJjFfiZOvG4SMDX08f5RzXk6uuh5NFi
   IfZ5pbOcSSb0B6l6Fny/4G+jumtjsRLkEu8U+IkSqmAY188naiL+K6Vcv
   plDI93phwcf8+QqSpwnjF8FXD8DGh0UyVtkM5kgsKkwrTYJ5zxYhb39Bj
   Tip9knK7hTHGKUVJkeu+oAWKFpp7MkTUNSJMUQLa5vfdkbNiTzG70cqe5
   A==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="723232986"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:17:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:3658]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.193:2525] with esmtp (Farcaster)
 id 578c316f-d39b-47b5-a333-2eacbe370891; Thu, 15 May 2025 22:17:44 +0000 (UTC)
X-Farcaster-Flow-ID: 578c316f-d39b-47b5-a333-2eacbe370891
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:17:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:17:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v3 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
Date: Thu, 15 May 2025 15:15:02 -0700
Message-ID: <20250515221733.166-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <682665bf7cebc_26df0c294aa@willemb.c.googlers.com.notmuch>
References: <682665bf7cebc_26df0c294aa@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 15 May 2025 18:07:59 -0400
> Kuniyuki Iwashima wrote:
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Date: Thu, 15 May 2025 14:44:14 -0400
> > > Kuniyuki Iwashima wrote:
> > > > As explained in the next patch, SO_PASSRIGHTS would have a problem
> > > > if we assigned a corresponding bit to socket->flags, so it must be
> > > > managed in struct sock.
> > > > 
> > > > Mixing socket->flags and sk->sk_flags for similar options will look
> > > > confusing, and sk->sk_flags does not have enough space on 32bit system.
> > > > 
> > > > Also, as mentioned in commit 16e572626961 ("af_unix: dont send
> > > > SCM_CREDENTIALS by default"), SOCK_PASSCRED and SOCK_PASSPID handling
> > > > is known to be slow, and managing the flags in struct socket cannot
> > > > avoid that for embryo sockets.
> > > > 
> > > > Let's move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> > > > 
> > > > While at it, other SOCK_XXX flags in net.h are grouped as enum.
> > > > 
> > > > Note that assign_bit() was atomic, so the writer side is moved down
> > > > after lock_sock() in setsockopt(), but the bit is only read once
> > > > in sendmsg() and recvmsg(), so lock_sock() is not needed there.
> > > 
> > > Because the socket lock is already held there?
> > 
> > No, for example, scm_recv_unix() is called without lock_sock(),
> > but it's okay because reading a single bit is always a matter
> > of timing, when to snapshot the flag, (unless there is another
> > dependency or the bit is read more than once).
> > 
> > With this, write happens before/after the if block:
> > 
> >                                <-- write could happen here
> >   lock_sock()
> >   if (sk->sk_scm_credentials) {
> >     do something
> >   }
> >   lock_unlock()
> >                                <-- or here (not related to logic)
> > 
> > but this is same without lock_sock() if the bit is read only
> > once:
> > 
> >                                <-- write could happen here
> >   if (sk->sk_scm_credentials) {
> >     do something               <-- or here (not related to logic)
> >   }
> >                                <-- or here (not related to logic)
> > 
> > So for SOCK_PASSXXX bits, lock_sock() prevents data-race
> > between writers as you pointed out, but it does nothing
> > for readers.
> 
> Essentially you're saying that a single bit read is a natural
> word read, so atomic anyway? I.e., yes this is a data race, safe.

Yes, even there is load-tearing on the word read, bit is
never torn and is alwyas atomic.


> Will KCSAN report on the race regardless?

Not sure, but given we can't use READ_ONCE() for a bit field,
I guess/hope no ?


> 
> All other single bit cases in sk_getsockopt use sk_flags
> and sock_flag, so are not a good existing example. But the single
> bit reads in do_tcp_getsockopt do the same. So I guess it's fine.
> Indeed constant_test_bit does nothing special either.
> 
> Sounds good, thanks.

Thanks for checking!

