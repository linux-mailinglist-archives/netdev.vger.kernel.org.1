Return-Path: <netdev+bounces-146235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FAC9D25F7
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A60285120
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD21C4A02;
	Tue, 19 Nov 2024 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XG4tsfQG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962E1C1F2A
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019634; cv=none; b=sQM9/n50NmfheIjacg47eRiK3ws+4fBJa6rQnUwF6OXSLVxMIocA+jxZ04JjP+7B8Hvu/cXtndcnwqzx1pR/2s1mT1pgj916lYcXUeDW5KUx+yAIcPSNH4wqJpLzBLI6uBk8S4GaA9pu2fwhRwvYXuiAerAV2vngCWa1SGFE/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019634; c=relaxed/simple;
	bh=c1e1Qs+pwG7qmFpwU9w/EjTnsITiQOv9+JyUIyY75us=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ghdhb/OmKegZnr4Y1ed+1befnFWE1uUbCPABzJiYOjEc+7w+a042dtfEBy8/YS9YcewzhmXz3SMjrs2iwfENbBsrllhLDxyGuYXQtu3p7ea7dsHcSGQQWDq8XLROyknM897Bq1jN57s2GTZJsHLM309YB1Dx4qLdu8Bg1+No8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XG4tsfQG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732019631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHY8cNAULL6nwEhSzQ81nIrFVWo9z99WTgK10ZuYieM=;
	b=XG4tsfQGGGYhRnsiKPsTUdI7kGPFSSgXbNijNqSCR3lyX56kGswJoLufdDyYDLttE12YCt
	4GXOFNgfoO7l3HuaktQNZyDqe2+yB2WmGc23AbTbgJkWAE6SuJ4ZU0MAHGl6wZKm27X2vp
	ZrOrhUr1SVk8H3gGAFE1OwwgVcZ9r/U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-JK_TIyfGOl6fwNpLHs-Q4A-1; Tue, 19 Nov 2024 07:33:50 -0500
X-MC-Unique: JK_TIyfGOl6fwNpLHs-Q4A-1
X-Mimecast-MFC-AGG-ID: JK_TIyfGOl6fwNpLHs-Q4A
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-382412f3e62so1340014f8f.3
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 04:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732019629; x=1732624429;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHY8cNAULL6nwEhSzQ81nIrFVWo9z99WTgK10ZuYieM=;
        b=Uu9nMg1SZPwq/2i6/jkCXjdhazffcWppSlZy9eZ2lPCWu/0kXnYd4JvjySSzkN0weg
         QfG5+MqFTAYVZmQ7y9XPxvs/i3gxTG6Xoy2KHSerBhDyTFtrXaXfzrL5iPybFVeZoBU6
         s0xq+uiG8S9MFegjRzPreE/JtkzPJaNt5O5/isQSBfzx9U40zgxt/pzX7++v1LPQbhdN
         vBB4K/MgVKPlrDzEORSIk3LtZhjzS5u/zQ806kfsgoZ115oWmlRm5zz9E4u+YrmI8fJZ
         8YIcimLoRDklar8kCR/KeuReQW8cGgWFLZQOR4Koxejl1pRaswbT0amSZSzoDK4EYaCB
         CdWw==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZDzm7OjHM3zb9AJeqCjSi6iI9c1QKoIvQAqRDkpcsFNnm3SAzvjQEksoMN12A9i/hhAgGZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPniadtJkT639x3KILKThz33P7vKYbNcLHx2U6Mg3Fbxc/9fv
	oDDJPjIEPCZsNA5OvvPOVedfASJ+jgXFTViZ/KPA6pXmSKhLwGox4qMwWChgbnZzR7UUkgOeXIb
	Cs7woMAyMUGmTTLaJ0c1n2gr9Rb2wR4zi0lcHtHwCvi3ljVOSCeOZog==
X-Received: by 2002:a05:6000:1569:b0:382:22f4:7773 with SMTP id ffacd0b85a97d-382255e5e91mr13960782f8f.0.1732019629158;
        Tue, 19 Nov 2024 04:33:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC45lmvC5efantYK5e8Qm5zfGjaaEjrptqcPVdJ96z6cndDLBzRub/HVzfy8hPr7swyHASgg==
X-Received: by 2002:a05:6000:1569:b0:382:22f4:7773 with SMTP id ffacd0b85a97d-382255e5e91mr13960755f8f.0.1732019628725;
        Tue, 19 Nov 2024 04:33:48 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382491e19bdsm5320244f8f.16.2024.11.19.04.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 04:33:48 -0800 (PST)
Date: Tue, 19 Nov 2024 13:33:45 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <david@gibson.dropbear.id.au>, <edumazet@google.com>, Mike Manning
 <mvrmanning@gmail.com>, <netdev@vger.kernel.org>, <pholzing@redhat.com>,
 <santiago@redhat.com>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC net 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
Message-ID: <20241119133345.650672cc@elisabeth>
In-Reply-To: <20241115195521.63675-1-kuniyu@amazon.com>
References: <20241114215414.3357873-3-sbrivio@redhat.com>
	<20241115195521.63675-1-kuniyu@amazon.com>
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

On Fri, 15 Nov 2024 11:55:21 -0800
Kuniyuki Iwashima <kuniyu@amazon.com> wrote:

> From: Stefano Brivio <sbrivio@redhat.com>
> Date: Thu, 14 Nov 2024 22:54:14 +0100
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index da50df485090..fcd2e2b89876 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -643,8 +643,17 @@ static int sock_bindtoindex_locked(struct sock *sk, int ifindex)
> >  	/* Paired with all READ_ONCE() done locklessly. */
> >  	WRITE_ONCE(sk->sk_bound_dev_if, ifindex);
> >  
> > -	if (sk->sk_prot->rehash)
> > -		sk->sk_prot->rehash(sk);
> > +	/* Force rehash if protocol needs it */
> > +	if (sk->sk_prot->set_rcv_saddr) {
> > +		if (IS_ENABLED(CONFIG_IPV6) && sk->sk_family == AF_INET6) {
> > +			sk->sk_prot->set_rcv_saddr(sk, &sk->sk_v6_rcv_saddr);  
> 
> sk_v6_rcv_saddr is not defined without CONFIG_IPV6 so I think the
> compiler will complain ?  see net/ipv4/inet_connection_sock.c

You're right, it breaks the build for CONFIG_IPV6=n, I should have
checked. Fixed in v1.

I'll post it for net-next when it reopens.

> > +		} else if (sk->sk_family == AF_INET) {
> > +			struct inet_sock *inet = inet_sk(sk);
> > +
> > +			sk->sk_prot->set_rcv_saddr(sk, &inet->inet_rcv_saddr);  
> 
> simply use &sk->sk_rcv_saddr.

Changed.

> > +		}
> > +	}
> > +
> >  	sk_dst_reset(sk);
> >  
> >  	ret = 0;  
> [...]
> > @@ -2034,20 +2052,32 @@ void udp_lib_rehash(struct sock *sk, u16 newhash)
> >  				nhslot2->count++;
> >  				spin_unlock(&nhslot2->lock);
> >  			}
> > -
> > -			spin_unlock_bh(&hslot->lock);
> >  		}
> >  	}
> > +
> > +	if (sk->sk_family == AF_INET)
> > +		sk->sk_rcv_saddr = *(__be32 *)addr;
> > +	else if (sk->sk_family == AF_INET6)
> > +		sk->sk_v6_rcv_saddr = *(struct in6_addr *)addr;  
> 
> inet_update_saddr() can be reused ?  at least we should
> use sk_rcv_saddr_set().

Ah, thanks, that's beautiful, I didn't know about inet_update_saddr().
Moved to headers and reused here.

It also updates sk_v6_rcv_saddr to the v4-mapped address if sk_family
is AF_INET, but that's correct anyway.

> Same for other places.

I think that makes sense but I guess it's beyond the scope of this
series, because it has the side effect of setting inet_saddr and
enabling further clean-ups. For example, in __ip4_datagram_connect(),
we could simplify all this:

	if (!inet->inet_saddr)
		inet->inet_saddr = fl4->saddr;	/* Update source address */
	if (!inet->inet_rcv_saddr) {
		inet->inet_rcv_saddr = fl4->saddr;
		if (sk->sk_prot->rehash)
			sk->sk_prot->rehash(sk);
	}

...let me do that as a follow-up patch. This series already looks big
enough.

-- 
Stefano


