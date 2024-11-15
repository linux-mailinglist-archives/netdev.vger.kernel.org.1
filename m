Return-Path: <netdev+bounces-145361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB909CF3DC
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CE42841A7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E151E0E06;
	Fri, 15 Nov 2024 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhCl21Dw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019E1865E2
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695032; cv=none; b=DOHOjMn+bU4XjZE6pZ5kFGn9vs34HU3GYGIDVwhuXaQERQWZgyp24JK09XUGVfKPE7CiNFa8rwugt/Kom26G4qkesTK+qPxoOjIW9WwCK42tRQMxk63ZTfBH48mT0UEczC7S0AoLeVI2WyLT86e/3WDkawh5r0C9vmelqZ4yVWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695032; c=relaxed/simple;
	bh=9FGAdXAqL3tRlhr/Ed3Oghk0d3JFyddF27TXIHMRgu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOo8CFtGNYnFKTrEZAAY5bYsFOxmefL6ZlCPyIpQwam5YkZ8ml8Z88YQEtItzSw/yM7eMy7SjF+1byDhTefLRAtbuEwwy6sCEKaEE2ijNfnEu24gIeuz0ChtP/xi7aHwMa2KygAwKR2YNRsigOEGXyk3gZtdg/ceGixAcT9T+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhCl21Dw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731695029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12XOeRbIzl4SWvHzZYvbyJytTycc4MnVZ6SjT72m2ck=;
	b=dhCl21DwmNt8Y8zLRPvWpgDnw8QTRPm/XZxbWNS8l1f7JK4haZku44pxJjS+LzJ30tWAo2
	PouYJu28yvX94Rb7AzHlqUNmKI9943oXaG8gbC6ntjjsiT7d4EA50SYM4+7pNSjwjLWxth
	92elvAK+7NwuW7zaDm0BSPMWMO16Sy4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-3B_1bOVFMVOICwfe8nvbrw-1; Fri, 15 Nov 2024 13:23:47 -0500
X-MC-Unique: 3B_1bOVFMVOICwfe8nvbrw-1
X-Mimecast-MFC-AGG-ID: 3B_1bOVFMVOICwfe8nvbrw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316300bb15so14649125e9.2
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 10:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731695026; x=1732299826;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12XOeRbIzl4SWvHzZYvbyJytTycc4MnVZ6SjT72m2ck=;
        b=f6nKN1BkFXONCADH6yN3the7TMUf8WIhmDFlt8qVtNw0YgDTU2FHLUkfrbxgNiPxrX
         kTJ7RX/4TORZQxlK4IZ/g45vHB+HwsvxoclEHmp+Yvj5G30DjHBhW+i7OszzMroX5F7k
         BRE9o3AYGqLzXehbSWqKl6jU7x7pjKNOcP1dnUjj9W4w0OocSB2N/lpN3ZS6gKlVR+9h
         /nwpus4LPJ8t4BVu2wd/1vcbZpTTwuExQd8JOZyb7wifldTFaZpYHXjJ9IAwFK16m2mb
         XuaS8eXYDChEsLMwJjw7XwUY50C4ixaqRNKDEPiv2ye4O8ldTa+nEfY+px2OH/fsCeID
         qz1g==
X-Forwarded-Encrypted: i=1; AJvYcCVO0pNlT8rQo60JMaQM/CpQY0ca4BMJkN481deEeq7oChImnyHT2TGrieq9SScgLGlHsA8jiQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nEhA/3rtQVeU1An5ud2fLdhtR62U3rMpHfuTR+uyjcLXGpgF
	iEZNppa9BvRPyxTTLgurRbTCTxFnXYU1pMI7hEN51uNBHZVYVQAm5tCaCQVNgXxL/pMOy0Zj2qv
	1jSJ/CZHlCLYTbOwO7rIGqtf6YI4fPxxq6H9hldphkic6pxvpr/SlxQ==
X-Received: by 2002:a05:6000:2d83:b0:382:222b:1307 with SMTP id ffacd0b85a97d-382258ee853mr2284187f8f.8.1731695026487;
        Fri, 15 Nov 2024 10:23:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeOiAThnZ81gVMCCBuceENRO/oQ++eppPH6NQpCdhd6A/h/ZPDGiAwH4pf78zVgozFskCzVg==
X-Received: by 2002:a05:6000:2d83:b0:382:222b:1307 with SMTP id ffacd0b85a97d-382258ee853mr2284177f8f.8.1731695026144;
        Fri, 15 Nov 2024 10:23:46 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae160fdsm5111004f8f.84.2024.11.15.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 10:23:45 -0800 (PST)
Date: Fri, 15 Nov 2024 19:23:42 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, David Gibson
 <david@gibson.dropbear.id.au>, Ed Santiago <santiago@redhat.com>, Paul
 Holzinger <pholzing@redhat.com>, Mike Manning <mvrmanning@gmail.com>
Subject: Re: [PATCH RFC net 1/2] datagram: Rehash sockets only if local
 address changed for their family
Message-ID: <20241115192342.73f5ea19@elisabeth>
In-Reply-To: <20241115191024.5bc07d74@elisabeth>
References: <20241114215414.3357873-1-sbrivio@redhat.com>
	<20241114215414.3357873-2-sbrivio@redhat.com>
	<6737896d3b97b_3d5f2c29459@willemb.c.googlers.com.notmuch>
	<20241115191024.5bc07d74@elisabeth>
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

On Fri, 15 Nov 2024 19:10:24 +0100
Stefano Brivio <sbrivio@redhat.com> wrote:

> [Updated Mike Manning's address in Cc:]
> 
> On Fri, 15 Nov 2024 12:48:29 -0500
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Stefano Brivio wrote:  
> > > It makes no sense to rehash an IPv4 socket when we change
> > > sk_v6_rcv_saddr, or to rehash an IPv6 socket as inet_rcv_saddr is set:
> > > the secondary hash (including the local address) won't change, because
> > > ipv4_portaddr_hash() and ipv6_portaddr_hash() only take the address
> > > matching the socket family.    
> > 
> > Even if this is correct, it sounds like an optimization.  
> 
> It is, see the cover letter.
> 
> > If so, it belongs in net-next.  
> 
> Well, it makes the fix smaller.
> 
> > Avoid making a fix (to net and eventually stable kernels) conditional
> > on optimizations that are not suitable for stable cherry-picks.  
> 
> Given that the fix is for an issue that existed for 15 years, I don't
> think it's stable material.
> 
> Whether it's 'net' material is also debatable, if it looks too big to
> you it probably isn't, let's go for net-next even if it's a fix.
> 
> > > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> > > ---
> > >  net/ipv4/datagram.c | 2 +-
> > >  net/ipv6/datagram.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
> > > index cc6d0bd7b0a9..d52333e921f3 100644
> > > --- a/net/ipv4/datagram.c
> > > +++ b/net/ipv4/datagram.c
> > > @@ -65,7 +65,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
> > >  		inet->inet_saddr = fl4->saddr;	/* Update source address */
> > >  	if (!inet->inet_rcv_saddr) {
> > >  		inet->inet_rcv_saddr = fl4->saddr;
> > > -		if (sk->sk_prot->rehash)
> > > +		if (sk->sk_prot->rehash && sk->sk_family == AF_INET)
> > >  			sk->sk_prot->rehash(sk);    
> > 
> > When is sk_family != AF_INET in __ip4_datagram_connect?  
> 
> This happens with dual-stack sockets, that is, IPv6 sockets that don't
> have IPV6_V6ONLY set, on which you connect() using an IPv4 address.
> 
> I haven't checked whether this makes sense in the bigger picture,
> because trying to avoid this case is definitely beyond the scope of this
> patch, but you can make it happen quite easily by simply starting a
> recent Debian or Fedora with OpenSSH listening on both families
> (default settings).

Ah, sorry, it's the other way around: the v4 rehash is called on a
AF_INET6 socket in that case.

I can have a look at what I can reproduce with several combinations,
even though I wonder if it isn't just more robust this way (given 2/2).

-- 
Stefano


