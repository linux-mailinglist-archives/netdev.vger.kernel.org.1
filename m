Return-Path: <netdev+bounces-188787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46190AAED50
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 22:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767D51BC3392
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880F428BA9F;
	Wed,  7 May 2025 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="qRlLrf17"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E95A79B
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650835; cv=none; b=XJ+um+CWWWgggdOW8lcXiObQxWK2l9IrF7k94d5j7EsGz38fMgjOREMaq2U40v9lcXm1ZKICrrnQTR3WRGhAaNaZcSpXdwm3b/8e8gR3NuZ/6DezPIqzeFVDbvw5zF/X/uxcn3JEpZFzKjnE8uS4Tsshxq36IhSIUJ6YllgSZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650835; c=relaxed/simple;
	bh=4MuzkUrWxZlQU3gtT5Jnjj61gRkWxGHJIu/GV5m4U/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6h20t1VIGPuH0zZlJDg0BwF/Zl48/KkHBjd++MsJ+iwsvAOWFgrT+6bABMOrP+9eLWbojg4P34idUpML1oeW0PvBtBdYlBQ5AyhHLJEP2zJhI0P8LpaqVVS8xBN/OEedB7y6ycRE9T6Zh6voH2cJ7nZjbkTKMzJsd4fqz1VTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=qRlLrf17; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=prrxQt8KnoX9OKhyw4WA1kYq8kHzRyfXyW47RICFr7c=; t=1746650834; x=1747514834; 
	b=qRlLrf17ScMjr1aa53qJjIXz9reO9e58mfGZaf0xNGxTCUlay+EzfgvVbmBBF9ysWXRzSLskh+Q
	dFInpD/eWXmq2DRBGjdBLmZSz20hT4Zekvx550Me/CEVI4g5T2e8MLbtT0jApwK7ll8PIqjjYJzSI
	7dPmWkZsgvR7LD4roRlLaZZcUeeRnS05FqlJQTD8K4TEzHZxfKPzFFMeDdlfmckZ0LA6HFqYoOUn7
	zGTLYlYHjKBUAH7XFTuyY0AMCBHSSnDxUuUd9ovM74llkHdfPVws1ZkNVxH21Jz3gEt4JCDMOvfMb
	2ynIHXL9XscJ8STKBLy107aD516/RGHJy06Q==;
Received: from mail-oi1-f178.google.com ([209.85.167.178]:53370)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uClfc-0006E0-K7
	for netdev@vger.kernel.org; Wed, 07 May 2025 13:47:13 -0700
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3fefbbc7dd4so261335b6e.2
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 13:47:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9znXeSy0XmTLCxDguLNS4c2acGEryotMdQ+fHx/RP43i97GcywFgMQUmKPpBafvGTyywoLYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvB8Zu6IIm0tYeO5tSOdvPF0X+YV8Xqc86tCicbEbIffscFQNx
	d8nVPB+LrqCPYIBhGecETWbp0q4OjA9bPCu36vjdyxSqseV8cb1oHE9hn0OkIplQrgMHKzvwZ80
	k7NVQUJhUeM0mFJa2Q7FQkhAt7Nc=
X-Google-Smtp-Source: AGHT+IHn3ixUNXJt23x8dzs+jAll9ks9Jah2BuNb1pcmQTs1mq6+dz8fGt5BxTnPJlEMp1rhhqPw5l4whrkISNdbawQ=
X-Received: by 2002:a05:6808:3197:b0:401:e8a2:76e8 with SMTP id
 5614622812f47-4036f090c04mr3178694b6e.18.1746650832072; Wed, 07 May 2025
 13:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-9-ouster@cs.stanford.edu> <a6b82986-52df-4d51-b854-a2eb5842a574@redhat.com>
 <CAGXJAmxbtj7x78KYNBWoZaCHbOf39ekeHQUX2bMZsipXUCau_Q@mail.gmail.com> <7e177e94-24cb-4090-81b9-d82b0c43a37d@lunn.ch>
In-Reply-To: <7e177e94-24cb-4090-81b9-d82b0c43a37d@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 7 May 2025 13:46:36 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzfRJWv7tsw8jq-jR0ax3noQ9jMJEAkdtF8uki6DVDMzQ@mail.gmail.com>
X-Gm-Features: ATxdqUEH4pEDi10fhumwCtIWkkwkEqEGDQ6VsJvH0gxNy1rkSstdUq2ohXdoJVM
Message-ID: <CAGXJAmzfRJWv7tsw8jq-jR0ax3noQ9jMJEAkdtF8uki6DVDMzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 08/15] net: homa: create homa_pacer.h and homa_pacer.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 127ff6e1eac6b45a32dc112250ed777d

get_link_ksettings is what I was thinking of. Some of the issues you
mentioned, such as switch egress contention, are explicitly handled by
Homa, so those needn't (and shouldn't) be factored into the link
"speed". And don't pretty much all modern datacenter switches allow
all of their links to operate at full speed?

-John-

On Wed, May 7, 2025 at 1:31=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, May 07, 2025 at 11:55:23AM -0700, John Ousterhout wrote:
> > In Tue, May 6, 2025 at 7:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > >
> > > On 5/3/25 1:37 AM, John Ousterhout wrote:
> > > > +     /**
> > > > +      * @link_mbps: The raw bandwidth of the network uplink, in
> > > > +      * units of 1e06 bits per second.  Set externally via sysctl.
> > > > +      */
> > > > +     int link_mbps;
> > >
> > > This is will be extremely problematic. In practice nobody will set th=
is
> > > correctly and in some cases the info is not even available (VM) or wi=
ll
> > > change dynamically due to policing/shaping.
> > >
> > > I think you need to build your own estimator of the available B/W. I'=
m
> > > unsure/I don't think you can re-use bql info here.
> >
> > I agree about the issues, but I'd like to defer addressing them. I
> > have begun working on a new Homa-specific qdisc, which will improve
> > performance when there is concurrent TCP and Homa traffic. It
> > retrieves link speed from the net_device, which will eliminate the
> > need for the link_mbps configuration option.
>
> I would be sceptical of the link speed, if you mean to use ethtool
> get_link_ksettings(). Not all switches have sufficient core bandwidth
> to allow all their ports to operate at line rate at the same
> time. There could be pause frames being sent back to slow the link
> down. And there could be FEC reducing the actual bandwidth you can get
> over the media. You also need to consider congestion on switch egress,
> when multiple sources are sending to one sink etc.
>
> BQL gives you a better idea of what the link is actually capable of,
> over the last few seconds, to the first switch. But after that,
> further hops across the network, it does not help.
>
>         Andrew

