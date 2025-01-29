Return-Path: <netdev+bounces-161562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C762A2257E
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 22:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FA11885D22
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 21:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F61A2C29;
	Wed, 29 Jan 2025 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="pIeaG4lN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A187081B
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184944; cv=none; b=JS37j46dzXo+MrE0G2OifUUHs9K5aHVL/avTWVZe98ISiCUX0JRU9R9Id0PYnTtjey+bM17U7Yz0lfhky5K79XNKpoG6XmBLH2ldKW002ql/6NOT3MN7rvHxab5xJqRAgKviAY1GG0SsEnB5UylcE8AfR4bLbpGS15TtICLVSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184944; c=relaxed/simple;
	bh=1Sqo37OhWPRlmoPqoREeQsbQn4FLSSquiaGFjUN8DnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0OpmekGe2K6B3kz/ZEqgdGUAZngnHndN3ci8N/+wPX6gyw2mvSQdMuu2KVgQ/2PUyzGnR/1NL578HS4IK4MHxYFtr/WJzFNVzOOOK5lzR9kGu+W6Muau9XbWPXjTYKw7b7kGZuuJUYixH55dEBGEdQQMQWfznjVTVCVbEs8JP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=pIeaG4lN; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LnDwjoIl0aaoV62Cpjq0jSv3fYlDj8lr0exZ7ybCiFw=; t=1738184942; x=1739048942; 
	b=pIeaG4lNIuOSE4Plx+19gCr+vzf7e1xFY8pGMslzAalMRi8Yy2ks98IJj/bmcT76db1i/y5mnad
	UZxmzlQYYSYHNHY98wVioMHwUOMrhnlBPoC4qGEJfVtAo7X5SWiZaHDVhIsN24sFg43myXvXX3s+V
	2yKIvQDpDmEPRyp6dJpvTpfsCDk67pINweIBiMNDlqZdlGoh1Yj3wdXn1WlTGo9OI2hSQEWQ9OuoX
	C9BWOQ/J0Oq4B9AoOtjlkhaGGdunA4AQmzZ0cpD/ww8dnIn+cBbOmM6xtqom+Pzc3K3CtBftsmFaG
	/xd/C4UhxgUDjXblrU3jLN4j+xzUci+DzePg==;
Received: from mail-oa1-f46.google.com ([209.85.160.46]:58829)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tdFIy-0007Gn-PL
	for netdev@vger.kernel.org; Wed, 29 Jan 2025 13:09:01 -0800
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29fad34bb62so48967fac.1
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:09:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/Himy+pT33xX6WFAbF4E4+ZWW3TcRCLB2FXTICeuxNZvG/YYzC+nLGcJVBusU0Ywz/JfJhuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSsuqP3IxplRNVf6Gtg8m/E2YrY0pXxW7GaLZG9fbC2PzeQNFn
	F2XySRiCY0isl+MKos8lNkoibjFQCZyiLw5897+aKvqISVNLTNJLRv29YA5RtWG+vvQdo0YWBcU
	4oPtU0i0EyySPO2LW4WW9U47ClTU=
X-Google-Smtp-Source: AGHT+IFbZQqa5FB9GfVotKsIAOI0DDBeVe06itKmiHVstG4cV3TZ8q29MJmUUGNGYwKIoQq2QOzMkQMhqCc4mlER4aw=
X-Received: by 2002:a05:6871:8802:b0:2a3:c59f:577b with SMTP id
 586e51a60fabf-2b32f280283mr2382874fac.24.1738184940238; Wed, 29 Jan 2025
 13:09:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-6-ouster@cs.stanford.edu>
 <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com> <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
 <2ace650b-5697-4fc4-91f9-4857fa64feea@redhat.com> <CAGXJAmxHDVhxKb3M0--rySAgewmLpmfJkAeRSBNRgZ=cQonDtg@mail.gmail.com>
 <9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com> <CAGXJAmyb8s5xu9W1dXxhwnQfeY4=P21FquBymonUseM_OpaU2w@mail.gmail.com>
 <13345e2a-849d-4bd8-a95e-9cd7f287c7df@redhat.com> <CAGXJAmweUSP8-eG--nOrcst4tv-qq9RKuE0arme4FJzXW67x3Q@mail.gmail.com>
 <CANn89iL2yRLEZsfuHOtZ8bgWiZVwy-=R5UVNFkc1QdYrSxF5Qg@mail.gmail.com>
 <CAGXJAmyKPdu5-JEQ4WOX9fPacO19wyBLOzzn0CwE5rjErcfNYw@mail.gmail.com>
 <CANn89iJmbefLpPW-jgJjFkx79yso3jUUzuH0voPaF+2Kz3EW2g@mail.gmail.com>
 <CAGXJAmz5=V2DmGHHh2XRHKQYynXmqYk_Nqw-y_QBWBQBMjbuag@mail.gmail.com> <CANn89iJ+mvp48F9tMmO=ttK3ai2WTVC7NNKy8YbV1d0wr-BD+Q@mail.gmail.com>
In-Reply-To: <CANn89iJ+mvp48F9tMmO=ttK3ai2WTVC7NNKy8YbV1d0wr-BD+Q@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 29 Jan 2025 13:08:24 -0800
X-Gmail-Original-Message-ID: <CAGXJAmx0WXfUg-D77vDMg-R6Bw74gX4c==xqTzF4XoyetrhHcw@mail.gmail.com>
X-Gm-Features: AWEUYZmx1fidhUuG7UOQbvxeTQ_xZPzBQXjZNkXb3DD2JdF6gzAThrkGTJ2jINM
Message-ID: <CAGXJAmx0WXfUg-D77vDMg-R6Bw74gX4c==xqTzF4XoyetrhHcw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and homa_rpc.c
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: b05cf9a5276a81ca133e41a937654b06

Thanks for the additional information; very helpful.

-John-

On Wed, Jan 29, 2025 at 12:41=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Jan 29, 2025 at 9:27=E2=80=AFPM John Ousterhout <ouster@cs.stanfo=
rd.edu> wrote:
> >
> > On Wed, Jan 29, 2025 at 9:04=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Jan 29, 2025 at 5:55=E2=80=AFPM John Ousterhout <ouster@cs.st=
anford.edu> wrote:
> > > >
> > > > On Wed, Jan 29, 2025 at 8:50=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > On Wed, Jan 29, 2025 at 5:44=E2=80=AFPM John Ousterhout <ouster@c=
s.stanford.edu> wrote:
> > > > > >
> > > > > > GRO is implemented in the "full" Homa (and essential for decent
> > > > > > performance); I left it out of this initial patch series to red=
uce the
> > > > > > size of the patch. But that doesn't affect the cost of freeing =
skbs.
> > > > > > GRO aggregates skb's into batches for more efficient processing=
, but
> > > > > > the same number of skb's ends up being freed in the end.
> > > > >
> > > > > Not at all, unless GRO is forced to use shinfo->frag_list.
> > > > >
> > > > > GRO fast path cooks a single skb for a large payload, usually add=
ing
> > > > > as many page fragments as possible.
> > > >
> > > > Are you referring to hardware GRO or software GRO? I was referring =
to
> > > > software GRO, which is what Homa currently implements. With softwar=
e
> > > > GRO there is a stream of skb's coming up from the driver; regardles=
s
> > > > of how GRO re-arranges them, each skb eventually has to be freed, n=
o?
> > >
> > > I am referring to software GRO.
> > > We do not allocate/free skbs for each aggregated segment.
> > > napi_get_frags() & napi_reuse_skb() for details.
> >
> >  YATIDNK (Yet Another Thing I Did Not Know); thanks for the information=
.
> >
> > So it sounds like GRO moves the page frags into another skb and
> > returns the skb shell to napi for reuse, eliminating an
> > alloc_skb/kfree_skb pair? Nice.
> >
> > The skb that receives all of the page frags: does that eventually get
> > kfree_skb'ed, or is there an optimization for that that I'm also not
> > aware of?
>
> This fat skb is going to be stored into a socket receive queue,
> so that its content can be copied or given to the user application.
>
> TCP then gives back the fat skb to the cpu which allocated the pages,
> so that kfree_skb() is very cheap. Fast NIC have page pools.
>
> tcp_eat_recv_skb()
>
> With BIG TCP, we typically store 180 KB of payload per sk_buff

