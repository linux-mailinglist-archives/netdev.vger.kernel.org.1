Return-Path: <netdev+bounces-103704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1471C90929C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E61C239DB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5691A01B6;
	Fri, 14 Jun 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UGlhPJzd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49DE19FA84
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391248; cv=none; b=Qja0YW0Gs7su43SFJkYhSuxqn+XS3I+zmlGS7W/A8jmWBPhQI90KHergVNOYM8wC1ToQ1by5X6ro2yyWg3z+z3oxxRE8If53C4EXk87N+IiIxrr2W6r+4dEmhYjefhgTtHwNmvnHqA9GAdZPentku6/3YiKJSumT1bCm+hZ8wPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391248; c=relaxed/simple;
	bh=HhIsXiDxpEuDDyMGb6pbLDztWrdGf6hwOMds7hjJZT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R94kz3TLmLaGtYLc6tYVZsJprSFJKIuS63SL/Ox7JZUecpBQxTZLjfiuJJk6BPfiAhVplNg3V2fpTrbBT2js6fKOYrtDuMg2Cwojx5nUstVdDVnW613gWyDhJUmLvunJrVVb5lKgxCiKkGuvDuTvT+F9aUl7wNfW0HqyPAwK19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UGlhPJzd; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718391246; x=1749927246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aX9bHXvMnQxRyudjWQkvNDOy51IBugLj23hRJDfi2pk=;
  b=UGlhPJzd+sLftmMsDSwCYp/snP3G36fZh+yNqXuYaOLJUxxawq5dya47
   prBZfu5m6KzzT7XlrSaeESfq4Nr7V13Z6p4j0jrH8uyWkFzaKYfMx4wtO
   bR4a+EDLjrAp6uSUfuwfal2gOcJA46Zs/3X+ihpxiGaoBGeyrbdfy4JX6
   g=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="96904874"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 18:54:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:26246]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.198:2525] with esmtp (Farcaster)
 id 53f94cfc-2e43-48ee-ac1d-03c592289973; Fri, 14 Jun 2024 18:54:04 +0000 (UTC)
X-Farcaster-Flow-ID: 53f94cfc-2e43-48ee-ac1d-03c592289973
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 18:54:04 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 18:54:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kent.overstreet@linux.dev>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 03/11] af_unix: Don't retry after unix_state_lock_nested() in unix_stream_connect().
Date: Fri, 14 Jun 2024 11:53:52 -0700
Message-ID: <20240614185352.85977-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9cb5259943f767d8107df2f004e1d364f9a0076e.camel@redhat.com>
References: <9cb5259943f767d8107df2f004e1d364f9a0076e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 14 Jun 2024 12:49:35 +0200
> On Tue, 2024-06-11 at 15:28 -0700, Kuniyuki Iwashima wrote:
> > When a SOCK_(STREAM|SEQPACKET) socket connect()s to another one, we need
> > to lock the two sockets to check their states in unix_stream_connect().
> > 
> > We use unix_state_lock() for the server and unix_state_lock_nested() for
> > client with tricky sk->sk_state check to avoid deadlock.
> > 
> > The possible deadlock scenario are the following:
> > 
> >   1) Self connect()
> >   2) Simultaneous connect()
> > 
> > The former is simple, attempt to grab the same lock, and the latter is
> > AB-BA deadlock.
> > 
> > After the server's unix_state_lock(), we check the server socket's state,
> > and if it's not TCP_LISTEN, connect() fails with -EINVAL.
> > 
> > Then, we avoid the former deadlock by checking the client's state before
> > unix_state_lock_nested().  If its state is not TCP_LISTEN, we can make
> > sure that the client and the server are not identical based on the state.
> > 
> > Also, the latter deadlock can be avoided in the same way.  Due to the
> > server sk->sk_state requirement, AB-BA deadlock could happen only with
> > TCP_LISTEN sockets.  So, if the client's state is TCP_LISTEN, we can
> > give up the second lock to avoid the deadlock.
> > 
> >   CPU 1                 CPU 2                  CPU 3
> >   connect(A -> B)       connect(B -> A)        listen(A)
> >   ---                   ---                    ---
> >   unix_state_lock(B)
> >   B->sk_state == TCP_LISTEN
> >   READ_ONCE(A->sk_state) == TCP_CLOSE
> >                             ^^^^^^^^^
> >                             ok, will lock A    unix_state_lock(A)
> >              .--------------'                  WRITE_ONCE(A->sk_state, TCP_LISTEN)
> >              |                                 unix_state_unlock(A)
> >              |
> >              |          unix_state_lock(A)
> >              |          A->sk_sk_state == TCP_LISTEN
> >              |          READ_ONCE(B->sk_state) == TCP_LISTEN
> >              v                                    ^^^^^^^^^^
> >   unix_state_lock_nested(A)                       Don't lock B !!
> > 
> > Currently, while checking the client's state, we also check if it's
> > TCP_ESTABLISHED, but this is unlikely and can be checked after we know
> > the state is not TCP_CLOSE.
> > 
> > Moreover, if it happens after the second lock, we now jump to the restart
> > label, but it's unlikely that the server is not found during the retry,
> > so the jump is mostly to revist the client state check.
> > 
> > Let's remove the retry logic and check the state against TCP_CLOSE first.
> > 
> > Note that sk->sk_state does not change once it's changed from TCP_CLOSE,
> > so READ_ONCE() is not needed in the second state read in the first check.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/af_unix.c | 34 ++++++++--------------------------
> >  1 file changed, 8 insertions(+), 26 deletions(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index c09bf2b03582..a6dc8bb360ca 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1546,7 +1546,6 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> >  		goto out;
> >  	}
> >  
> > -	/* Latch state of peer */
> >  	unix_state_lock(other);
> >  
> >  	/* Apparently VFS overslept socket death. Retry. */
> > @@ -1576,37 +1575,20 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> >  		goto restart;
> >  	}
> >  
> > -	/* Latch our state.
> > -
> > -	   It is tricky place. We need to grab our state lock and cannot
> > -	   drop lock on peer. It is dangerous because deadlock is
> > -	   possible. Connect to self case and simultaneous
> > -	   attempt to connect are eliminated by checking socket
> > -	   state. other is TCP_LISTEN, if sk is TCP_LISTEN we
> > -	   check this before attempt to grab lock.
> > -
> > -	   Well, and we have to recheck the state after socket locked.
> > +	/* self connect and simultaneous connect are eliminated
> > +	 * by rejecting TCP_LISTEN socket to avoid deadlock.
> >  	 */
> > -	switch (READ_ONCE(sk->sk_state)) {
> > -	case TCP_CLOSE:
> > -		/* This is ok... continue with connect */
> > -		break;
> > -	case TCP_ESTABLISHED:
> > -		/* Socket is already connected */
> > -		err = -EISCONN;
> > -		goto out_unlock;
> > -	default:
> > -		err = -EINVAL;
> > +	if (unlikely(READ_ONCE(sk->sk_state) != TCP_CLOSE)) {
> > +		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
> 
> I find the mixed READ_ONCE()/plain read confusing. What about using a
> single READ_ONCE() caching the return value?

Will use cached sk_state.

> 
> >  		goto out_unlock;
> >  	}
> >  
> >  	unix_state_lock_nested(sk, U_LOCK_SECOND);
> >  
> > -	if (sk->sk_state != TCP_CLOSE) {
> > -		unix_state_unlock(sk);
> > -		unix_state_unlock(other);
> > -		sock_put(other);
> > -		goto restart;
> > +	if (unlikely(sk->sk_state != TCP_CLOSE)) {
> > +		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
> > +		unix_state_lock(sk);
> 
> Should likely be:
> 		unix_state_unlock(sk)
> ?

Oops, will fix it.

Thanks!

