Return-Path: <netdev+bounces-146263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E39D28A1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFDEB21D27
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CDB1CC174;
	Tue, 19 Nov 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0aQc86u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C843179
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028052; cv=none; b=r81DUse0u11HorMRDJ7Mkot7xak72dWmnblqlCBTLYaahN6uwaaHcbrzOCjKAFs5Q2jLjO8qYTZ1SYdAjgFahCc02fQqlu6PFQxG2xWXJ21vVTuo0i1b1iH14Zwt/nvBnNDHyG8ydxkgMkEmVnUvCo/q7qQgIeO3MW56Fxz/lEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028052; c=relaxed/simple;
	bh=lInCZp2xKgUZhAB/044xKlF58GdtVm2BUsygsBtHeB4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NOFGVkde+n0KlKfCAEP8dpF0yO6aF6W+dxtjvYdFfDWQ0nCArDGRZ763ijwwAtNQx3EoaR/Y3L+e0poCWbqYiBH/EvGv31BOhthnlm1VfUf+q1Et2tlMxxSYyFC1KRD44KCuYSgObamEJvKOuNl7gQDThXt6wLVjtpzFA+HKjCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0aQc86u; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ee354637b4so565710eaf.3
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 06:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732028050; x=1732632850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaqUrT8Kzq3UMcB3TNf5QwaQzz6MIqNclugaH7J2qa8=;
        b=P0aQc86uSyK873nKwBbJfMpPiRhDNL4CtJKypaMezLRt9QU6oW6ooV7LSuDm+aDFwY
         4Wot4Bm2g9JwxvVNYEZTUH8mPQ4iPV69ty4WtAn/8XDoHuVThCvt9QMHoW3mF+VjP4+2
         LbMaaK2siJSSIY0zUHdNHQlM9t85KnRuW6y/aJIf7wIAZ4mXXrCgeN8UD4nt/zL9i2oM
         IMeXFl1CPW9iwVKw0TGx3DcYKcngNjWTR98iOk3xFVrJTs8Er/4Q8j9ZItUg33GGxDWL
         n2etnI+s6X9IPVwXgucg/l8c8LDIxd+HHDXeu2UEipqhJzvZHqJbFALVNUF0Ub28WA7E
         fndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028050; x=1732632850;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NaqUrT8Kzq3UMcB3TNf5QwaQzz6MIqNclugaH7J2qa8=;
        b=YjRPSPpAFv8SQAJfy0U74m4A1Qust6cuWv7+8eZYd+r1uIHxS7KX+oe88LCgp5kDl3
         L937nZbojq2GLvfw+PYZPP4b8W7RZK+YWUPCsry37DOSawJte4N+28Wr4QKRIMthg6lh
         VZI1QA3QrGiyF8cUGUeexTGAkX3whEXjnL5xHY6FrX08p/soD+V2NYUUYe71X4S45kUU
         PzOES19p2PUrMze+ydb2znJGxaD7pH3DyXfQIwHd+++Sj27bxPLO/QxJboKGG9l86szL
         Urd27pWgGFhg7NgbGMk8jlM9NxiRJ7TXIOmopLkLOf04NkP1eqIzLmSy0w+4GKmGf3Lb
         bhzA==
X-Forwarded-Encrypted: i=1; AJvYcCWd5d4daq4Q5gL43INWWwJkPH4Y1stLcX593qJCgivB3aIPNauxaeGue3ee4N8dZLJ9jDa6MFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOO/BlpCur0rD6a59Rb6OQcPjIM5PKs0xjQwpEzZAc2zwEv6yE
	YfQ9UYa+9m/TSn0FHGhpqEeOApE07JEUaF1fsKzr2cnDV2bSq24e
X-Google-Smtp-Source: AGHT+IGICjymsJKPKl6NOyIMIYXWvGmbp+D/Z9wfWLoDwKHaHW0FfKcrlwD8buwlxkb1rJjliGsM7A==
X-Received: by 2002:a05:6358:2193:b0:1bc:573a:401a with SMTP id e5c5f4694b2df-1c6cd1fe0bfmr619665655d.5.1732028049964;
        Tue, 19 Nov 2024 06:54:09 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a89fac6sm98476785a.108.2024.11.19.06.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:54:09 -0800 (PST)
Date: Tue, 19 Nov 2024 09:54:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stefano Brivio <sbrivio@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, 
 netdev@vger.kernel.org, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Ed Santiago <santiago@redhat.com>, 
 Paul Holzinger <pholzing@redhat.com>, 
 Mike Manning <mvrmanning@gmail.com>
Message-ID: <673ca6911817c_2a097e29430@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241119133336.3e389752@elisabeth>
References: <20241114215414.3357873-1-sbrivio@redhat.com>
 <20241114215414.3357873-2-sbrivio@redhat.com>
 <6737896d3b97b_3d5f2c29459@willemb.c.googlers.com.notmuch>
 <20241115191024.5bc07d74@elisabeth>
 <20241115192342.73f5ea19@elisabeth>
 <20241119133336.3e389752@elisabeth>
Subject: Re: [PATCH RFC net 1/2] datagram: Rehash sockets only if local
 address changed for their family
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stefano Brivio wrote:
> On Fri, 15 Nov 2024 19:23:42 +0100
> Stefano Brivio <sbrivio@redhat.com> wrote:
> 
> > > On Fri, 15 Nov 2024 12:48:29 -0500
> > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > >   
> > > > Stefano Brivio wrote:    
> > > >
> > > > [...]
> > > >
> > > > > diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
> > > > > index cc6d0bd7b0a9..d52333e921f3 100644
> > > > > --- a/net/ipv4/datagram.c
> > > > > +++ b/net/ipv4/datagram.c
> > > > > @@ -65,7 +65,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
> > > > >  		inet->inet_saddr = fl4->saddr;	/* Update source address */
> > > > >  	if (!inet->inet_rcv_saddr) {
> > > > >  		inet->inet_rcv_saddr = fl4->saddr;
> > > > > -		if (sk->sk_prot->rehash)
> > > > > +		if (sk->sk_prot->rehash && sk->sk_family == AF_INET)
> > > > >  			sk->sk_prot->rehash(sk);      
> > > > 
> > > > When is sk_family != AF_INET in __ip4_datagram_connect?    
> 
> So, this is the only "mismatching" case (by design) I can actually
> reproduce. Long story short:
> 
> int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
> 			   int addr_len)
> {
> 
> 	[...]
> 
> 	if (usin->sin6_family == AF_INET) {
> 		if (ipv6_only_sock(sk))
> 			return -EAFNOSUPPORT;
> 		err = __ip4_datagram_connect(sk, uaddr, addr_len);
> 
> 		[...]
> 
> here we (intentionally) call __ip4_datagram_connect() on an AF_INET6
> socket because we're connecting a dual-stack socket to an IPv4 address.
> 
> This happens for me with sshd (from OpenSSH) doing getaddrinfo() at
> boot, it's some DNS stuff, but I didn't trace it all the way. You can
> also reproduce it with:
> 
>   socat UDP6-LISTEN:1337,null-eof STDOUT & { sleep 1; : | socat STDIN UDP4:0:1337,shut-null; }
> 
> All in all, I would keep those checks. Even if this is the only case
> we currently see, the assumptions __ip4_datagram_connect() <-> AF_INET
> and __ip6_datagram_connect() <-> AF_INET6 don't hold in general.
> 
> Or do you find them exceedingly verbose / harmful for any other reason?
> 
> I would also make it clearer in the commit message why we need them
> in the next patch (once net-next reopens).

Thanks for that context. Sounds good to me.

