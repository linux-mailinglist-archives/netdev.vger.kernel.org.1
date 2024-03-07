Return-Path: <netdev+bounces-78248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D252874824
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 07:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AD72823A3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 06:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38DF171A4;
	Thu,  7 Mar 2024 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+3ZQcOI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32731BF50
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792677; cv=none; b=Zp3tMSFKizU2HkIgfcBtF8PIezACY0u5yssPYyqPfw8zbwLw4nQ8/IP5Bn6JG1GLeHlojBubp5sxtb3Rv9frjEcAthPmToZBBrVHCK3PP+imStrfMIL3vPPlj2kw/STR25pPkhOOUx8fqPpIEnw4gOaE107K37BxUyhS9LBdDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792677; c=relaxed/simple;
	bh=r5D+bwCtub+aQo6ifbWfAjuF/TmfCkpQT2jnl1GBRwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQo11H8diGuSkJSckuZFWY4o1hR6Sn1W3fPddl9TJnBpS5ERMxLUtuurd4F5ANbjC6xVid/2yW3BiDnUYmtjQpRNQA6uv+yOUsglyfc9KovpYzRkRylPV2/wt21YONw05GBHxDvJBNQoqNbnG+tUxRFYrGr5ut0M9Jib7cm9ZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+3ZQcOI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso5981a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 22:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709792674; x=1710397474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/hYj2vTMLQuyjzzLGPsqdla9MsF89NYgNXHd8cHOWc=;
        b=b+3ZQcOI9fwzXHcz1eQrbK5RUN//+Uw+qFQ4v/P8KpaRAASlXabtAh5jKoL9jgCDon
         e4DWhlfaI2I041QPykE3ri+6pnXaH5szU2Y0T5atC/RHAPKfS7nFf5bbRZd4JttkJha5
         o5pxXA21eIgfUxeuUrtEjIC2/vNMc7U8Ityy0jXNuEQVneJ2L6P4aMZgfKuH52hdvxJ0
         an7ikouHgteKY8SV/FpcW//kQ86lN82x1w8qNqpNe5XfQevx+MnYwzi8hY8+h+M7nshQ
         QTVyBcUlmtjvBQ1EexaBEDZTlzpOUIm2rc7ndkU07vIFoRE6knOGOIOVKil2YTpzWFT5
         f74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709792674; x=1710397474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/hYj2vTMLQuyjzzLGPsqdla9MsF89NYgNXHd8cHOWc=;
        b=YTHJY9SZcneNklyGCWfT7KZmwtqLWVvFHNsykT4qm2AKUT6B986zOIQH3JA407Mn6X
         euNOnHz6FyJn3MznzSDArMZ6/6vICcKO5N8Ii+pLfKJ9j12L8lLG+w/etGppmzxUSvBQ
         91gluHMwpZd6YLA4vuq0wqt6yvnA32dYIcOFkWv8n1669Acgs8/nxlRCmSSOA7GRHKou
         npf/vPkBb+gFm0rSW9Yl9VuxwnUbCRWUCNskxbhrMl0tPpmB6z43LTuoObimfbDLQCrE
         jbhQHDBoz7B3yV1CoW3lZkCYXOkWgbehCIfE7du7RZhrsSButlADRzTwqSCUy29g0SdD
         9vzA==
X-Forwarded-Encrypted: i=1; AJvYcCUUNXg9QkGG9ep4pBusXt4DNsZuoSvlRKDneVEVD0pX5Z4ylAuIjMTSvJOVyPLEgAOXKiA05BFGoZ3K44n9vRDq7OZFUuKn
X-Gm-Message-State: AOJu0YwI+6GY84AFhtBsH6AVBcLaGh4CzVlMU/fwXcqSKNn63WV/wMgZ
	Fw7uN58Wvd6ePUDldkK+uXjDwNTsqkC1yfCJ57BvM6XkBQHdXD084IoF4RnZnyzQkjhmqA9/O20
	ixZdzXknryb3JHxiBSHwzGoIoA5hUQ+lp9nri
X-Google-Smtp-Source: AGHT+IFBPdfjKf5GwXmE9xEJjCNJBxe6EcklZcBtoMXke4asujSXe/C6QV6VIwwTgpBNofxQywhCPs6q8UOqt55jEe4=
X-Received: by 2002:a05:6402:298:b0:566:e8fc:8f83 with SMTP id
 l24-20020a056402029800b00566e8fc8f83mr105839edv.7.1709792673988; Wed, 06 Mar
 2024 22:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306155144.870421-1-edumazet@google.com> <20240306155144.870421-2-edumazet@google.com>
 <f4bcf5fd-b1b0-47a8-9eb3-5aae2c5171b7@kernel.org>
In-Reply-To: <f4bcf5fd-b1b0-47a8-9eb3-5aae2c5171b7@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 07:24:20 +0100
Message-ID: <CANn89iJDfhJRPta063ujaASOvgvZ_imeBytm0OWsJ_7oKC4txg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] ipv6: make inet6_fill_ifaddr() lockless
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:38=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 3/6/24 8:51 AM, Eric Dumazet wrote:
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index 2f84e6ecf19f48602cadb47bc378c9b5a1cdbf65..480a1f9492b590bb13008ce=
de5ea7dc9c422af67 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -2730,7 +2730,7 @@ int addrconf_prefix_rcv_add_addr(struct net *net,=
 struct net_device *dev,
> >               if (update_lft) {
> >                       ifp->valid_lft =3D valid_lft;
> >                       ifp->prefered_lft =3D prefered_lft;
> > -                     ifp->tstamp =3D now;
> > +                     WRITE_ONCE(ifp->tstamp, now);
>
> There are a lot of instances of ifp->tstamp not annotated with READ_ONCE
> or WRITE_ONCE. Most of them before this function seem to be updated or
> read under rtnl. What's the general mode of operation for this patch?
> e.g., there are tstamp references just above this one in this function
> not modified. Commit message does not describe why some are updated and
> others not.


Writes on objects that are not yet visible to other threads/cpu do not
need a WRITE_ONCE()

ipv6_add_addr() allocates a fresh object, so

ifa->cstamp =3D ifa->tstamp =3D jiffies;  // do not need any WRITE_ONCE()


Reads while we own ifa->lock do no need a READ_ONCE()

So check_cleanup_prefix_route() :

  if (time_before(*expires, ifa->tstamp + lifetime * HZ))  // no need
       *expires =3D ifa->tstamp + lifetime * HZ;   // no need

In ipv6_create_tempaddr()

  age =3D (now - ifp->tstamp) / HZ; // no need because we hold ifp->lock;

In ipv6_create_tempaddr()

  age =3D (now - ifp->tstamp) / HZ; // no need, we hold ifp->lock;

  tmp_tstamp =3D ifp->tstamp; // no need, we hold ifp->lock;

 addrconf_prefix_rcv_add_addr()
  The reads are done under ifp->lock
  The write uses WRITE_ONCE()

I did a full audit and I think I did not miss any READ_ONCE()/WRITE_ONCE()

Of course, this is extra precaution anyway, the race has no impact
other than KCSAN and/or would require a dumb compiler in the first
place.

If I had to explain this in the changelog, I guess I would not do all
these changes, this would be too time consuming.

Thanks !

