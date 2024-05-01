Return-Path: <netdev+bounces-92801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215CF8B8E8A
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 18:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1461F21932
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4716EF9FE;
	Wed,  1 May 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FX2Fsw+1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C78F6D
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582372; cv=none; b=ucEoUGuHWphZX8v8k6RxnWNrcaYfsMjNnyBR325K91uENdz0Owtjb08I9Rk2QF0ZNLxFvcH0f+2OFC/ZqD18J2xod6eMdnIQomJCuZ1pUmiTHEn3lupZEsiAGDLqxUaD7CjV1LShKAoc8NoR9rNEw6jrgl0Tjpf6uywWKapTIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582372; c=relaxed/simple;
	bh=S04fZjyneDJce/2QZdg8QeuAR4tA/wdhOqS5LeslyEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjZM9LMYk6UNmLirhptFZUoFWTywRrXvaT9N2s3BRvp5sUpZFpTV1yUeTbQUbvqARQyFyTf7eqYYWZ0fpL6Vc0WB6FkXJmD/ulVXohAtN2Hx1yoOcdXDeqk20ISKGtKrQSBoxwBpTTwQKpDvLYJxwDbyWU5yq97qLohVML3Y5HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FX2Fsw+1; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714582371; x=1746118371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6B4prwjx9+Bb4U+zZEM1sbVLh5fbXznfDQsi0glBveA=;
  b=FX2Fsw+1tszTbTixIa4goikEG87ZpIH6n9Ix/TZjr3CbSJMlqdVD+/lL
   lfYc8bWyT8clI4XFXQspYrmxPGk5qgNVNfXd1TxYin8Agp5IHrHFdUNuG
   nvKCkyOMuBGtgL7aBi59ecYxaytl7QVzoiRr6qhJxMM5vhNB7+fYNARTV
   8=;
X-IronPort-AV: E=Sophos;i="6.07,245,1708387200"; 
   d="scan'208";a="398413857"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 16:52:47 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:3609]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.127:2525] with esmtp (Farcaster)
 id 509c11da-c8ab-4bee-8d34-b6798d150786; Wed, 1 May 2024 16:52:46 +0000 (UTC)
X-Farcaster-Flow-ID: 509c11da-c8ab-4bee-8d34-b6798d150786
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 1 May 2024 16:52:44 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 1 May 2024 16:52:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <anderson@allelesecurity.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: use-after-free warnings in tcp_v4_connect() due to inet_twsk_hashdance() inserting the object into ehash table without initializing its reference counter
Date: Wed, 1 May 2024 09:52:33 -0700
Message-ID: <20240501165233.24657-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJk5RJR=ex6t3-hzpo=08_+RMQJD5NL3-RzTyK_FutAMQ@mail.gmail.com>
References: <CANn89iJk5RJR=ex6t3-hzpo=08_+RMQJD5NL3-RzTyK_FutAMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 May 2024 08:56:51 +0200
> On Wed, May 1, 2024 at 2:22 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > +cc Eric
> >
> > From: Anderson Nascimento <anderson@allelesecurity.com>
> > Date: Tue, 30 Apr 2024 19:00:34 -0300
> > > Hello,
> >
> > Hi,
> >
> > Thanks for the detailed report.
> >
> > >
> > > There is a bug in inet_twsk_hashdance(). This function inserts a
> > > time-wait socket in the established hash table without initializing the
> > > object's reference counter, as seen below. The reference counter
> > > initialization is done after the object is added to the established hash
> > > table and the lock is released. Because of this, a sock_hold() in
> > > tcp_twsk_unique() and other operations on the object trigger warnings
> > > from the reference counter saturation mechanism. The warnings can also
> > > be seen below. They were triggered on Fedora 39 Linux kernel v6.8.
> > >
> > > The bug is triggered via a connect() system call on a TCP socket,
> > > reaching __inet_check_established() and then passing the time-wait
> > > socket to tcp_twsk_unique(). Other operations are also performed on the
> > > time-wait socket in __inet_check_established() before its reference
> > > counter is initialized correctly by inet_twsk_hashdance(). The fix seems
> > > to be to move the reference counter initialization inside the lock,
> >
> > or use refcount_inc_not_zero() and give up on reusing the port
> > under the race ?
> >
> > ---8<---
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 0427deca3e0e..637f4965326d 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -175,8 +175,13 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
> >                         tp->rx_opt.ts_recent       = tcptw->tw_ts_recent;
> >                         tp->rx_opt.ts_recent_stamp = tcptw->tw_ts_recent_stamp;
> >                 }
> > -               sock_hold(sktw);
> > -               return 1;
> > +
> > +               /* Here, sk_refcnt could be 0 because inet_twsk_hashdance() puts
> > +                * twsk into ehash and releases the bucket lock *before* setting
> > +                * sk_refcnt.  Then, give up on reusing the port.
> > +                */
> > +               if (likely(refcount_inc_not_zero(&sktw->sk_refcnt)))
> > +                       return 1;
> >         }
> >
> 
> Thanks for CC me.
> 
> Nice analysis from Anderson ! Have you found this with a fuzzer ?
> 
> This patch would avoid the refcount splat, but would leave side
> effects on tp, I am too lazy to double check them.

Ah exactly :)

> 
> Incidentally, I think we have to annotate data-races on
> tcptw->tw_ts_recent and  tcptw->tw_ts_recent_stamp
> 
> Perhaps something like this instead ?

This looks good to me.

> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 0427deca3e0eb9239558aa124a41a1525df62a04..f1e3707d0b33180a270e6d3662d4cf17a4f72bb8
> 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -155,6 +155,10 @@ int tcp_twsk_unique(struct sock *sk, struct sock
> *sktw, void *twp)
>         if (tcptw->tw_ts_recent_stamp &&
>             (!twp || (reuse && time_after32(ktime_get_seconds(),
>                                             tcptw->tw_ts_recent_stamp)))) {
> +
> +               if (!refcount_inc_not_zero(&sktw->sk_refcnt))
> +                       return 0;
> +
>                 /* In case of repair and re-using TIME-WAIT sockets we still
>                  * want to be sure that it is safe as above but honor the
>                  * sequence numbers and time stamps set as part of the repair
> @@ -175,7 +179,6 @@ int tcp_twsk_unique(struct sock *sk, struct sock
> *sktw, void *twp)
>                         tp->rx_opt.ts_recent       = tcptw->tw_ts_recent;
>                         tp->rx_opt.ts_recent_stamp = tcptw->tw_ts_recent_stamp;
>                 }
> -               sock_hold(sktw);
>                 return 1;
>         }
> 

