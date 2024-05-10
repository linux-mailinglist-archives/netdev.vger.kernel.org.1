Return-Path: <netdev+bounces-95369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE4E8C2079
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6C51C203B2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D016F90B;
	Fri, 10 May 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DFaLTl6q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958B161B53
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332316; cv=none; b=i1H2Fl11XZGCexAM5q189peCCAVPIi/+5GWxpQxiKsM77Bx9dpjJapgWeHNyiD+OQ17GE2h1sPzUGhaUE54m6NcBGAwZYmVjIeD8UjOsOJQjqMTxHLKgUbyxyR6ZDPupz27QvKVDxgPkb95kzA1VeI4AJPvi+h2cTwJemmODt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332316; c=relaxed/simple;
	bh=mEuwGvPRlJ+nPOP+vc/sGYYZSWGlxiHxtkZQUVggPzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezZbvoLKWApt19oC57HewIe450QiuZWlBejNMzUcALHLC8lxZ7YgH/5GF8ugPTHdqX2u2h40OXJ1VH6cJWLfOL9Y5tLYIsz+OdEazRTa/oYR52Ru+yWEeNH2DVBF/7EXspqmOHEOgmFmdTub6UwCUzje4LH6S8pBWDpatOKbjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DFaLTl6q; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715332315; x=1746868315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xbm/HHs0r6fric3N8R1Lk7E6b5ZwsQOeiyLgR+mS/fA=;
  b=DFaLTl6q82DZ3rc0jrDoeVSkkDkSz4cF83i5s/KqD5sL6wMEoBL3OTGo
   OfmBTxqqXdqoq999rZDikGYyhYutzfTWDglWxNEuv4dDBF23mCbanBCqD
   oktJmLb6oaIHToIzB+jo+ubEiomvhpeqNG8EUuNikCAKGBjO/eJ4xy0Ce
   U=;
X-IronPort-AV: E=Sophos;i="6.08,150,1712620800"; 
   d="scan'208";a="405965387"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 09:11:52 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:2529]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.186:2525] with esmtp (Farcaster)
 id 6d0c58a1-b6df-4fc9-9627-56cde9d586c5; Fri, 10 May 2024 09:11:51 +0000 (UTC)
X-Farcaster-Flow-ID: 6d0c58a1-b6df-4fc9-9627-56cde9d586c5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 09:11:51 +0000
Received: from 88665a182662.ant.amazon.com (10.119.9.22) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 10 May 2024 09:11:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <billy@starlabs.sg>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Fri, 10 May 2024 18:11:38 +0900
Message-ID: <20240510091138.23367-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <dc8e67fac99c7a1d2cb36bff2217515116bf58cf.camel@redhat.com>
References: <dc8e67fac99c7a1d2cb36bff2217515116bf58cf.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 10 May 2024 09:53:25 +0200
> On Fri, 2024-05-10 at 14:03 +0900, Kuniyuki Iwashima wrote:
> > From: Paolo Abeni <pabeni@redhat.com>
> > Date: Thu, 09 May 2024 11:12:38 +0200
> > > On Tue, 2024-05-07 at 10:00 -0700, Kuniyuki Iwashima wrote:
> > > > Billy Jheng Bing-Jhong reported a race between __unix_gc() and
> > > > queue_oob().
> > > > 
> > > > __unix_gc() tries to garbage-collect close()d inflight sockets,
> > > > and then if the socket has MSG_OOB in unix_sk(sk)->oob_skb, GC
> > > > will drop the reference and set NULL to it locklessly.
> > > > 
> > > > However, the peer socket still can send MSG_OOB message to the
> > > > GC candidate and queue_oob() can update unix_sk(sk)->oob_skb
> > > > concurrently, resulting in NULL pointer dereference. [0]
> > > > 
> > > > To avoid the race, let's update unix_sk(sk)->oob_skb under the
> > > > sk_receive_queue's lock.
> > > 
> > > I'm sorry to delay this fix but...
> > > 
> > > AFAICS every time AF_UNIX touches the ooo_skb, it's under the receiver
> > > unix_state_lock. The only exception is __unix_gc. What about just
> > > acquiring such lock there?
> > 
> > In the new GC, there is unix_state_lock -> gc_lock ordering, and
> > we need another fix then.
> > 
> > That's why I chose locking recvq for old GC too.
> > https://lore.kernel.org/netdev/20240507172606.85532-1-kuniyu@amazon.com/
> > 
> > Also, Linus says:
> > 
> >     I really get the feeling that 'sb->oob_skb' should actually be forced
> >     to always be in sync with the receive queue by always doing the
> >     accesses under the receive_queue lock.
> > 
> > ( That's in the security@ thread I added you, but I just noticed
> >   Linus replied to the previous mail.  I'll forward the mails to you. )
> > 
> > 
> > > Otherwise there are other chunk touching the ooo_skb is touched where
> > > this patch does not add the receive queue spin lock protection e.g. in
> > > unix_stream_recv_urg(), making the code a bit inconsistent.
> > 
> > Yes, now the receive path is protected by unix_state_lock() and the
> > send path is by unix_state_lock() and recvq lock.
> > 
> > Ideally, as Linus suggested, we should acquire recvq lock everywhere
> > touching oob_skb and remove the additional refcount by skb_get(), but
> > I thought it's too much as a fix and I would do that refactoring in
> > the next cycle.
> > 
> > What do you think ?
> 
> I missed/forgot the unix_state_lock -> gc_lock ordering on net-next.
> 
> What about using the receive queue lock, and acquiring that everywhere
> oob_skb is touched, without the additional refcount refactor?
> 
> Would be more consistent and reasonably small. It should work on the
> new CG, too.
> 
> The refcount refactor could later come on net-next, and will be less
> complex with the lock already in place.

yeah, sounds good.

will post v2 with additional recvq locks.

Thanks!


> 
> Incremental patch on top of yours, completely untested:
> ---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 9a6ad5974dff..a489f2aef29d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2614,8 +2614,10 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
>  
>  	mutex_lock(&u->iolock);
>  	unix_state_lock(sk);
> +	spin_lock(&sk->sk_receive_queue.lock);
>  
>  	if (sock_flag(sk, SOCK_URGINLINE) || !u->oob_skb) {
> +		spin_unlock(&sk->sk_receive_queue.lock);
>  		unix_state_unlock(sk);
>  		mutex_unlock(&u->iolock);
>  		return -EINVAL;
> @@ -2627,6 +2629,7 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
>  		WRITE_ONCE(u->oob_skb, NULL);
>  	else
>  		skb_get(oob_skb);
> +	spin_unlock(&sk->sk_receive_queue.lock);
>  	unix_state_unlock(sk);
>  
>  	chunk = state->recv_actor(oob_skb, 0, chunk, state);
> @@ -2655,6 +2658,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>  		consume_skb(skb);
>  		skb = NULL;
>  	} else {
> +		spin_lock(&sk->sk_receive_queue.lock);
>  		if (skb == u->oob_skb) {
>  			if (copied) {
>  				skb = NULL;
> @@ -2673,6 +2677,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>  				skb = skb_peek(&sk->sk_receive_queue);
>  			}
>  		}
> +		spin_unlock(&sk->sk_receive_queue.lock);
>  	}
>  	return skb;
>  }
> 

