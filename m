Return-Path: <netdev+bounces-145359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4E9CF3A5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CD51F24DAA
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996051D8E07;
	Fri, 15 Nov 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JW597RSE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15121D63D7
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694232; cv=none; b=EQ8UkacSFDZ7CZ0oxwovvbw1CxLlBYtTRdat/4DgmrmIewIxnH69FjlT2SfkYDGR1gHVNOQQMneRvpH+Xos392URoU7sZikjVb40u/9A0EpplCyZN1URLijbSonGdANagASFpAHGtq4tbqR/GTFBxR0pPRTVfteYiqgfok7Pmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694232; c=relaxed/simple;
	bh=kK8wFMG1U7VQQKQ6oBTD5NPREtxr1x82dNoWmCAuGcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4RhEaQRNu9n2OWKc3OJyyu7RF8i7yP+xFMyrkSLwFpEJakfLoKC3ThZ3wr6CnYNwpZV/Lku8i7bAVZdCMNbV860C3gJwICRdIkdzU2E5n16rZ+9mr7hCd0qcTyNIrsOn9XANB1RilaJBfeFpNNFPtCvzgUHXQu+/BNwxZJh1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JW597RSE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731694229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opo/TNfQ7EdKXxJc9/apBcbHLhFWBVlSpvmA4GIvBrs=;
	b=JW597RSEGELqjpEtWx2LrDP9oPK/y7bu2egH0yia2gY8vbXe5+WQcR5bHiks29W49JEQ3m
	Uxhu4AVqA1KpVvbMFQQ2yI9Y+blrFfFr2utIDABRhiUjAc89mKsmdxURmn3jb+LakE2+rX
	Qs5IyOBkgH+IspDIFb7GPjCk5e34xik=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-IJPjlRf1NqeK-V9ZX7QYqg-1; Fri, 15 Nov 2024 13:10:28 -0500
X-MC-Unique: IJPjlRf1NqeK-V9ZX7QYqg-1
X-Mimecast-MFC-AGG-ID: IJPjlRf1NqeK-V9ZX7QYqg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso6610145e9.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 10:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731694227; x=1732299027;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opo/TNfQ7EdKXxJc9/apBcbHLhFWBVlSpvmA4GIvBrs=;
        b=Xa+g5Exc3gxI0HBvdVTbj8uC/UTzW5DdBJvr/FoVwIdhtI9ghfrX+vrvwhTHjF2U71
         oHiqyKnbxRlMW/XpPUCZTLXdduOSdnrPGosicL10RZ4C5fkuVUsJkDG79D2jnB5bV9ck
         k9cyYwjIFRs6jRmnv+rPOVVAC0S4+J0JiSG/x6k1eAKr+uQKxcyn2ydAZ2sWXEieqjOd
         k8mdTFfUwcdG7Xgdp6GtS1drmUtmi8a3IB69e+UbhoN+WkXl5xhI/whWu74RdihZ89U/
         E+lmxldFwROYTErTg5n3berpTx6CrZ7svGnN4KojiI7/1Xh8PRtZckP7vM1D7816VZus
         eKFw==
X-Forwarded-Encrypted: i=1; AJvYcCWCIvEBlmT+FTNrZWq7v4lQOwMRn/CYm3KG6gUoeyS7yDGTiQwDZZ8PfsS0QZ8SWN3z9yv04Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnaIpN3fWKVlvcGFLwCWEV0ZZxKW7yp4ZWIxOcbt3QvQiD+oL
	urAOOGSjay56+rWb5EKSbDAoU2sBjQjW42Yhkb+bSgTXo01a8vZ387t49nLYLfNyp/ggdqEqM4S
	Bt7MDwBKQ2UerNGIplEojwiQhyiRvJ0r/tbOjmUvgA3j3lozZMsPJUA==
X-Received: by 2002:a05:600c:1d1b:b0:431:5d4c:5eff with SMTP id 5b1f17b1804b1-432df71f82cmr33342445e9.2.1731694227069;
        Fri, 15 Nov 2024 10:10:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHySW++k6j8iceSM/t6ksKwoRFsTP/YTPt3q7l1dS3OqHn4+Owrs/uM7PQxFKVYcakwxajk6A==
X-Received: by 2002:a05:600c:1d1b:b0:431:5d4c:5eff with SMTP id 5b1f17b1804b1-432df71f82cmr33342265e9.2.1731694226715;
        Fri, 15 Nov 2024 10:10:26 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78918sm60369885e9.17.2024.11.15.10.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 10:10:25 -0800 (PST)
Date: Fri, 15 Nov 2024 19:10:24 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, David Gibson
 <david@gibson.dropbear.id.au>, Ed Santiago <santiago@redhat.com>, Paul
 Holzinger <pholzing@redhat.com>, Mike Manning <mvrmanning@gmail.com>
Subject: Re: [PATCH RFC net 1/2] datagram: Rehash sockets only if local
 address changed for their family
Message-ID: <20241115191024.5bc07d74@elisabeth>
In-Reply-To: <6737896d3b97b_3d5f2c29459@willemb.c.googlers.com.notmuch>
References: <20241114215414.3357873-1-sbrivio@redhat.com>
	<20241114215414.3357873-2-sbrivio@redhat.com>
	<6737896d3b97b_3d5f2c29459@willemb.c.googlers.com.notmuch>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[Updated Mike Manning's address in Cc:]

On Fri, 15 Nov 2024 12:48:29 -0500
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Stefano Brivio wrote:
> > It makes no sense to rehash an IPv4 socket when we change
> > sk_v6_rcv_saddr, or to rehash an IPv6 socket as inet_rcv_saddr is set:
> > the secondary hash (including the local address) won't change, because
> > ipv4_portaddr_hash() and ipv6_portaddr_hash() only take the address
> > matching the socket family.  
> 
> Even if this is correct, it sounds like an optimization.

It is, see the cover letter.

> If so, it belongs in net-next.

Well, it makes the fix smaller.

> Avoid making a fix (to net and eventually stable kernels) conditional
> on optimizations that are not suitable for stable cherry-picks.

Given that the fix is for an issue that existed for 15 years, I don't
think it's stable material.

Whether it's 'net' material is also debatable, if it looks too big to
you it probably isn't, let's go for net-next even if it's a fix.

> > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> > ---
> >  net/ipv4/datagram.c | 2 +-
> >  net/ipv6/datagram.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
> > index cc6d0bd7b0a9..d52333e921f3 100644
> > --- a/net/ipv4/datagram.c
> > +++ b/net/ipv4/datagram.c
> > @@ -65,7 +65,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
> >  		inet->inet_saddr = fl4->saddr;	/* Update source address */
> >  	if (!inet->inet_rcv_saddr) {
> >  		inet->inet_rcv_saddr = fl4->saddr;
> > -		if (sk->sk_prot->rehash)
> > +		if (sk->sk_prot->rehash && sk->sk_family == AF_INET)
> >  			sk->sk_prot->rehash(sk);  
> 
> When is sk_family != AF_INET in __ip4_datagram_connect?

This happens with dual-stack sockets, that is, IPv6 sockets that don't
have IPV6_V6ONLY set, on which you connect() using an IPv4 address.

I haven't checked whether this makes sense in the bigger picture,
because trying to avoid this case is definitely beyond the scope of this
patch, but you can make it happen quite easily by simply starting a
recent Debian or Fedora with OpenSSH listening on both families
(default settings).

> 
> >  	}
> >  	inet->inet_daddr = fl4->daddr;
> > diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> > index fff78496803d..5c28a11128c7 100644
> > --- a/net/ipv6/datagram.c
> > +++ b/net/ipv6/datagram.c
> > @@ -211,7 +211,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
> >  		    ipv6_mapped_addr_any(&sk->sk_v6_rcv_saddr)) {
> >  			ipv6_addr_set_v4mapped(inet->inet_rcv_saddr,
> >  					       &sk->sk_v6_rcv_saddr);
> > -			if (sk->sk_prot->rehash)
> > +			if (sk->sk_prot->rehash && sk->sk_family == AF_INET6)
> >  				sk->sk_prot->rehash(sk);  
> 
> Even if this is a v4mappedv6 address, sk_family will be AF_INET6.

I think we could have a case that's symmetric to the one above, even
though I haven't reproduced this one (but I didn't try hard).

-- 
Stefano


