Return-Path: <netdev+bounces-146234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FCC9D25F6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EE22856EB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69941C9EDD;
	Tue, 19 Nov 2024 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3JhlyXN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A91C2DB4
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019625; cv=none; b=AqLivKft0+hjfvGT1wiqKS3mEp2NLSN4iia5KRfxyh8Z2Qpp8s2k9s9Q3zYlPVmj29UIcOwQvTLL7EU6QnQmqxHmqR4ixotf+eC5oV7/av0R4xtp1/8ozAoTH2H0l1VwF4Q6Pw/tNd8QR+GoS6bJ0Qr7srVE9g2hbYibs5LK9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019625; c=relaxed/simple;
	bh=tcV5kUPMSpQ00LFvDBkOm4XFJ9ipktiuopd98uWbHVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRfqre55uWxZs03G3zkVV5XkRWRwQnk/CVbpdcoiYZlZdqFm5PdJZXvvN+hmd9yDiRuOsiuay0LtU1L27Js16fJ+TwsyQwWkaMgITJ8/9NxICS+sw1B1zzqp5LmycJyYQuffZbWwCPHRNFqaqCKxtp8JENNlxB7XTkAGIaeTSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3JhlyXN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732019622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Di1bsL14epjPOp0HZpC1pNm+0N/12e3pRCoRZBsNVY=;
	b=J3JhlyXNLaXkFP8aD0Zi0/0kNlCDZ/WOcUDdQegKsC4u6qPAcqJQe80atUH9sy2fois2Xq
	qXsZ0z3prDRo6WajKKkV9hFY0wYMAJNi7Dx8Gkty7h8ZPtithYj2g9CswCNTN2iw6rTbJO
	vI5ZuGIlPpZrcLQQKyccJSP/s6j97Kk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-B7op7yLkOK6Mg_HG_DCPbg-1; Tue, 19 Nov 2024 07:33:40 -0500
X-MC-Unique: B7op7yLkOK6Mg_HG_DCPbg-1
X-Mimecast-MFC-AGG-ID: B7op7yLkOK6Mg_HG_DCPbg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431604a3b47so6571965e9.3
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 04:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732019619; x=1732624419;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Di1bsL14epjPOp0HZpC1pNm+0N/12e3pRCoRZBsNVY=;
        b=sIeQMMt8WSFC7/M7I6MUXYojs9/X0mz9gp3/B9KIog/dWJo5BvGnRO71LPdeJ5JzaU
         i+FtsSOdLrRBMqP7epUmkqt6RqS5+ozAUQvQxgKNmA6MjYVdMBNYOlQFztH+pES3eL47
         QfDF5kTw4JYejQmRtzeKdjDmvjm+TzOca0aNRDPmtzuT39zBqhZlWjHeJQ1jNL/ikjAl
         wf/XOpBue7A/pNCnoZaIlgJxMRxFoQDimrHCrCO6HwS/z4LjCtsJDQsiZ3LQglKorVEe
         ugzyA9itT1pNXSzBZNT+UG2Vzln19AuO9EEKLPEnCj6leAR8SLW0DbydnPpiCu0ujsWI
         cHAw==
X-Forwarded-Encrypted: i=1; AJvYcCXsL/zkGtgNenkcofjeKMayFTpIhnc901GtGll1IdZ3mqCYEmrsFxEV6qL/959+375fUnhmZuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/ZclcsowPwV41mVc5cpQSOPPAFx+iKbo8sSRUeT0NJ7xcnS5
	ppQ/ANL9HGc1Fa/pEuQvNgV/pcCOFU7E9l112MDWt4Q5Yl7aWkOx40C28+TmtlvhD0niDjMaYk3
	ylve02qif0XJ2yx9rEk6AWQkZMUXxzP97eCYzb1AhC45ZCe/B1jVZgQ==
X-Received: by 2002:a05:600c:35d0:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-432df72aafdmr137299645e9.11.1732019619293;
        Tue, 19 Nov 2024 04:33:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmmPWRs/CABeeGyIV3EkkCq0kJE7hcGZAu/YXfiCZ6ftoJXSb8sTJbfJyrddpYXY/SbWVu9g==
X-Received: by 2002:a05:600c:35d0:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-432df72aafdmr137299455e9.11.1732019618970;
        Tue, 19 Nov 2024 04:33:38 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da244924sm194702715e9.7.2024.11.19.04.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 04:33:37 -0800 (PST)
Date: Tue, 19 Nov 2024 13:33:36 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, David Gibson
 <david@gibson.dropbear.id.au>, Ed Santiago <santiago@redhat.com>, Paul
 Holzinger <pholzing@redhat.com>, Mike Manning <mvrmanning@gmail.com>
Subject: Re: [PATCH RFC net 1/2] datagram: Rehash sockets only if local
 address changed for their family
Message-ID: <20241119133336.3e389752@elisabeth>
In-Reply-To: <20241115192342.73f5ea19@elisabeth>
References: <20241114215414.3357873-1-sbrivio@redhat.com>
	<20241114215414.3357873-2-sbrivio@redhat.com>
	<6737896d3b97b_3d5f2c29459@willemb.c.googlers.com.notmuch>
	<20241115191024.5bc07d74@elisabeth>
	<20241115192342.73f5ea19@elisabeth>
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

On Fri, 15 Nov 2024 19:23:42 +0100
Stefano Brivio <sbrivio@redhat.com> wrote:

> > On Fri, 15 Nov 2024 12:48:29 -0500
> > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> >   
> > > Stefano Brivio wrote:    
> > >
> > > [...]
> > >
> > > > diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
> > > > index cc6d0bd7b0a9..d52333e921f3 100644
> > > > --- a/net/ipv4/datagram.c
> > > > +++ b/net/ipv4/datagram.c
> > > > @@ -65,7 +65,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
> > > >  		inet->inet_saddr = fl4->saddr;	/* Update source address */
> > > >  	if (!inet->inet_rcv_saddr) {
> > > >  		inet->inet_rcv_saddr = fl4->saddr;
> > > > -		if (sk->sk_prot->rehash)
> > > > +		if (sk->sk_prot->rehash && sk->sk_family == AF_INET)
> > > >  			sk->sk_prot->rehash(sk);      
> > > 
> > > When is sk_family != AF_INET in __ip4_datagram_connect?    

So, this is the only "mismatching" case (by design) I can actually
reproduce. Long story short:

int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
			   int addr_len)
{

	[...]

	if (usin->sin6_family == AF_INET) {
		if (ipv6_only_sock(sk))
			return -EAFNOSUPPORT;
		err = __ip4_datagram_connect(sk, uaddr, addr_len);

		[...]

here we (intentionally) call __ip4_datagram_connect() on an AF_INET6
socket because we're connecting a dual-stack socket to an IPv4 address.

This happens for me with sshd (from OpenSSH) doing getaddrinfo() at
boot, it's some DNS stuff, but I didn't trace it all the way. You can
also reproduce it with:

  socat UDP6-LISTEN:1337,null-eof STDOUT & { sleep 1; : | socat STDIN UDP4:0:1337,shut-null; }

All in all, I would keep those checks. Even if this is the only case
we currently see, the assumptions __ip4_datagram_connect() <-> AF_INET
and __ip6_datagram_connect() <-> AF_INET6 don't hold in general.

Or do you find them exceedingly verbose / harmful for any other reason?

I would also make it clearer in the commit message why we need them
in the next patch (once net-next reopens).

-- 
Stefano


