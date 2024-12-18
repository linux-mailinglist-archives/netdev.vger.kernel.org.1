Return-Path: <netdev+bounces-153058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8694B9F6AF1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9088167217
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4A1E9B14;
	Wed, 18 Dec 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUZ++V3k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27B5FEE6
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538879; cv=none; b=SALu5JanrsibBDcwpABu3tja4gwzdiU5X8OlljKMuhF6VatK5lcyJz0hMwH+vZfj/VoPpuhidvuGE+pgxd9ytHIIjUGf8xYN8IagBM1NIlHUCsslWDqgkw1j0+t4RWgIq9hbPSt8zqy+O4lxqCLHYrY42gL+msDvtZq4Nr7Tuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538879; c=relaxed/simple;
	bh=JLmN0pSDOEJFAWE+c0dhwn6SQ+kazlCv+kZtXgT1YfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUdlXU7Hdh2O2a0yr4KAOhggriKTDdZ1O2FwnRI4g4HqRNvI6PdD+ffSdcgG48wa5MJnX5AlDSrQzwnpJmzeYljUvtZ/wAVsfK+Rlq7sdLmWFHVokXt3ZHOrgXC2X6s8p8AjvfHrQifKbg3+gBKx48Kf+Nfewn8ML7Ma0eYgLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUZ++V3k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734538875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wgeUIFAvTYWVq1TJqyDmPUgZ3yFEsvFUnWjDKaDGA0=;
	b=KUZ++V3kcXatP04UVLJ25xX4h6/XyfY20o4ADxUW18gvRr+aXwu806+m+nlsv8QoSOjfwB
	8NXNOtl4F5YWQY9e5GfkeM2qXu0SGizaSEeWvqI+5IQhLxkLKaCl+hgPzWWq/GHu1IHSLk
	rOBor8vYtl+Xlw6fP4MlKylpaAyWHP4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-sO8GudSINoGczT1dFR_aPw-1; Wed, 18 Dec 2024 11:21:14 -0500
X-MC-Unique: sO8GudSINoGczT1dFR_aPw-1
X-Mimecast-MFC-AGG-ID: sO8GudSINoGczT1dFR_aPw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so31109815e9.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 08:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734538873; x=1735143673;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wgeUIFAvTYWVq1TJqyDmPUgZ3yFEsvFUnWjDKaDGA0=;
        b=RV4bBBwRMGmD4naT2gkice+R8qu/w38NFM7c1jvfRo+BX2wGROCMcblnuwSxzkJW0U
         z8gp4Rcw0A8D1DWzridYYGCRMr5RSiWaS1kw3d+kG16+4Jx6Dlai/Z73NFTCZKpuYeQ7
         O2aos0yYDBwpl/5yn++gJR7XFfxIxoeMcjQjCNbdAUCJ7x8g7lZSx4utUuB78zZxEyFT
         e3JX2mWyLA1ceWoZ5azn4mb8I1V06Ssa+xb+34QEyPZgr5nVIMcQBp+w9ypT7+shuUAm
         1XiCu89I1y6hztDk9PyNmBnM/uqDbKZRQ7xuM0OaZ+6E8lFILH/iYlMXnbNYc1acTkZ9
         k+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVqqt3wA3h7QHmD5GMUES9VVpPe6AJ7f6L5zNIbeDT04UKck4LZ9rAvFJHEnV7GmprEKarjSfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPF08un2asuyKNyqgamjqq7qEaatixvIpeLJ2MFgcKNCJ+lI4
	Yf8WY8jOifW5N+TaIM1OiIhZqxCgKRxoSnQewGsWnjbJd4KWwgplxH08ugAhZa+OUUBNDR7ZdaB
	WLATdwliXGAAoxmP9nizhuGRckK+4XmWegBF+CaQhhmZfe5FQCsQ2mg==
X-Gm-Gg: ASbGncvOuCG9irdHA4YQbd8SVkFhLMErS4LS4MbFfQzqK6l30puaFEQiWX8hfWsZLYm
	KsC335RYA4GxCBct03D1zGk16Rzj7RK5uZcwMStwIWy3PURRAqs7TeVcYkw4XZjbUM/DLH2a9mF
	s24uQF3B8z36NvlXDIQgKtXNRY37efIFieqWrRfrFhsfVvq/f7O1PLd5D6dQZhYo7e0lBdOdTlZ
	RCvNNvgeI7Y+26MhOpmYom3LHO9JqG+OfQF+1svUXdi46rwxAVkoBwWd46BHyU+Wmr2Nz6NVH7X
	gIEi+WhEyw==
X-Received: by 2002:a05:600c:1c8f:b0:435:136:75f6 with SMTP id 5b1f17b1804b1-436550af37dmr36639565e9.0.1734538872965;
        Wed, 18 Dec 2024 08:21:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/7qiloQ0PAWFSJ1dD+dpG5/JLEDDKg7imZ+ugysNfk2kTokWr9dYq2CoIhNwaG7vNCzVQWA==
X-Received: by 2002:a05:600c:1c8f:b0:435:136:75f6 with SMTP id 5b1f17b1804b1-436550af37dmr36639205e9.0.1734538872605;
        Wed, 18 Dec 2024 08:21:12 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801612esm14624344f8f.40.2024.12.18.08.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 08:21:11 -0800 (PST)
Date: Wed, 18 Dec 2024 17:21:10 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Mike Manning <mvrmanning@gmail.com>, David Gibson
 <david@gibson.dropbear.id.au>, Paul Holzinger <pholzing@redhat.com>, Philo
 Lu <lulie@linux.alibaba.com>, Cambda Zhu <cambda@linux.alibaba.com>, Fred
 Chen <fred.cc@alibaba-inc.com>, Yubing Qiu
 <yubing.qiuyubing@alibaba-inc.com>
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and
 rehash socket atomically against lookup
Message-ID: <20241218172110.12c4016a@elisabeth>
In-Reply-To: <20241206143535.3e095320@elisabeth>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
	<20241204221254.3537932-3-sbrivio@redhat.com>
	<fa941e0d-2359-4d06-8e61-de40b3d570cb@redhat.com>
	<20241205165830.64da6fd7@elisabeth>
	<c1601a03-0643-41ec-a91c-4eac5d26e693@redhat.com>
	<20241206115042.4e98ff8b@elisabeth>
	<e02911ae-3561-48be-af92-c3580091015f@redhat.com>
	<20241206143535.3e095320@elisabeth>
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

On Fri, 6 Dec 2024 14:35:35 +0100
Stefano Brivio <sbrivio@redhat.com> wrote:

> On Fri, 6 Dec 2024 13:36:47 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > On 12/6/24 11:50, Stefano Brivio wrote:  
> > > On Thu, 5 Dec 2024 17:53:33 +0100 Paolo Abeni <pabeni@redhat.com> wrote:    
> > >> I'm wondering if the issue could be solved (almost) entirely in the
> > >> rehash callback?!? if the rehash happens on connect and the the socket
> > >> does not have hash4 yet (it's not a reconnect) do the l4 hashing before
> > >> everything else.    
> > > 
> > > So, yes, that's actually the first thing I tried: do the hashing (any
> > > hash) before setting the address (I guess that's what you mean by
> > > "everything else").
> > > 
> > > If you take this series, and drop the changes in __udp4_lib_lookup(), I
> > > guess that would match what you suggest.    
> > 
> > I mean something slightly different. Just to explain the idea something
> > alike the following (completely untested):
> > 
> > ---
> > diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
> > index cc6d0bd7b0a9..e9cc6edbcdc6 100644
> > --- a/net/ipv4/datagram.c
> > +++ b/net/ipv4/datagram.c
> > @@ -61,6 +61,10 @@ int __ip4_datagram_connect(struct sock *sk, struct
> > sockaddr *uaddr, int addr_len
> >  		err = -EACCES;
> >  		goto out;
> >  	}
> > +
> > +	sk->sk_state = TCP_ESTABLISHED;
> > +	inet->inet_daddr = fl4->daddr;
> > +	inet->inet_dport = usin->sin_port;
> >  	if (!inet->inet_saddr)
> >  		inet->inet_saddr = fl4->saddr;	/* Update source address */
> >  	if (!inet->inet_rcv_saddr) {
> > @@ -68,10 +72,7 @@ int __ip4_datagram_connect(struct sock *sk, struct
> > sockaddr *uaddr, int addr_len
> >  		if (sk->sk_prot->rehash)
> >  			sk->sk_prot->rehash(sk);
> >  	}
> > -	inet->inet_daddr = fl4->daddr;
> > -	inet->inet_dport = usin->sin_port;
> >  	reuseport_has_conns_set(sk);
> > -	sk->sk_state = TCP_ESTABLISHED;
> >  	sk_set_txhash(sk);
> >  	atomic_set(&inet->inet_id, get_random_u16());
> > 
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 6a01905d379f..c6c58b0a6b7b 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -2194,6 +2194,21 @@ void udp_lib_rehash(struct sock *sk, u16 newhash,
> > u16 newhash4)
> >  			if (rcu_access_pointer(sk->sk_reuseport_cb))
> >  				reuseport_detach_sock(sk);
> > 
> > +			if (sk->sk_state == TCP_ESTABLISHED && !udp_hashed4(sk)) {
> > +				struct udp_hslot * hslot4 = udp_hashslot4(udptable, newhash4);
> > +
> > +				udp_sk(sk)->udp_lrpa_hash = newhash4;
> > +				spin_lock(&hslot4->lock);
> > +				hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_lrpa_node,
> > +							 &hslot4->nulls_head);
> > +				hslot4->count++;
> > +				spin_unlock(&hslot4->lock);
> > +
> > +				spin_lock(&hslot2->lock);
> > +				udp_hash4_inc(hslot2);
> > +				spin_unlock(&hslot2->lock);
> > +			}
> > +
> >  			if (hslot2 != nhslot2) {
> >  				spin_lock(&hslot2->lock);
> >  				hlist_del_init_rcu(&udp_sk(sk)->udp_portaddr_node);
> > ---
> > 
> > Basically the idea is to leverage the hash4 - which should be not yet
> > initialized when rehash is invoked due to connect().  
> 
> That assumption seems to be correct from my tests.

...but that doesn't help in a general case, because we don't have a
wildcard lookup for four-tuple hashes, more on that below.

> > In such a case, before touching hash{,2}, do hash4.  
> 
> Brilliant, thanks. I'll give that a try.

It sounded like a nice idea and I actually tried quite hard, but it
can't work (so I'm posting a different/simpler fix), mostly for three
reasons (plus a bunch that would require sparse but doable changes):

1. we can't use four-tuple hashes on CONFIG_BASE_SMALL=y, and it would
   be rather weird to leave it unfixed in that case (and, worse, to have
   substantially different behaviours depending on CONFIG_BASE_SMALL).

   At the same time, I see your point about it (from review to v4 of
   the four-tuple hash series), and I don't feel like it's worth adding
   it back also for CONFIG_BASE_SMALL.

   I tried adding some special handling based on a similar concept that
   wouldn't make struct udp_table bigger, but it's strictly more
   complicated than the other fix I'm posting.

2. hash4_cnt is stored in the secondary hash slot, and I see why, but
   that means that if the secondary hash doesn't match, we'll also fail
   the lookup based on four-tuple hash.

   We could introduce a special case in the lookup, perhaps as fallback
   only, ignoring the result of udp_has_hash4(), but it looks rather
   convoluted (especially compared to the fix I'm posting)

3. we would need another version of udp{4,6}_lib_lookup4() (or a branch
   inside it), handling wildcard lookups like udp{4,6}_lib_lookup2()
   does, and then call udp{4,6}_lib_lookup4() a second time with
   INADDR_ANY / &in6addr_any, because we don't know if the receive
   address changed yet, as we're performing the lookup.

So, instead, I'm resorting to the primary hash, as fallback only. If
what we need is a hash that doesn't include the address, such as an
"uninitialised" four-tuple hash, we can as well use the original hash
that doesn't include addresses by design.

-- 
Stefano


