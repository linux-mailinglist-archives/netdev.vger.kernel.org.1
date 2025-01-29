Return-Path: <netdev+bounces-161560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8386FA22534
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 21:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB62016365D
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD9B1E22EF;
	Wed, 29 Jan 2025 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1FsyLopJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF621E1A18
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738183271; cv=none; b=hfVgTooSPBDcChkUF711pyiO32DIw6MDWvfeAbUNwqnodedvnIfXBGJ8Qm8rCkYsTYP2iCwghvtPwm7ueMw+80xi/RxxJyAwI8KHINHbRbryHPv5LWZTwRcYKj5iiHViMmKbP20/S09DhmMgv/bugv6LFWkT3JN+gc8iUn3h428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738183271; c=relaxed/simple;
	bh=Eiz5M+NpEXk8SWS+FOXhRyVW/0Uxq97UqUvlC37k+8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snMGX1WqczQy41eHyALWESrLAXAXpkrZpufhju9M71Z0Pzz1R+aQn9xKXfNbINKHbObSZ2YwrGsYHmz9E4dA3GSfnK5L4GfWDAqELCsDJVXP3yOAJxnN+cugoJVezRopm9zcBGTSKQfEArY3vWBuH+mcVgaZE/hZ0k4Os22UjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1FsyLopJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso2243519a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 12:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738183268; x=1738788068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fYdl94OTYwJL+A4AghBjX/T+LFFWP9BbOOW0E8dzOA=;
        b=1FsyLopJKYQUExjf6rtX+6T83pBASPJpV40RJs/aXlPqFavraLuIO7ebIHZ6mxXzns
         VlFHJ+j1gekOyqtBfE3j77O5gHMFUcfR/nQ1jrQsytS4ZKGMExRoqbENA83Gdy1g1F4S
         Yt9NruWGzgTTrbEd4l8Te3OcIn1GA1ppB8eosgegzE+M8bXphRlTp9PUVn8n01ruATsG
         O4pNMgeoez+meW5omBwQjtr5m/RNhrPxFALFVjSbXWcQBTt4QLGMLFczkuliSkfvnnpb
         UDRqyON36Rr6ldHixD23il6ysGK7geV7CrJHngQK+/0H2FQAmyBhNPj/teJ/db7yVNKk
         Y+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738183268; x=1738788068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fYdl94OTYwJL+A4AghBjX/T+LFFWP9BbOOW0E8dzOA=;
        b=dyXdSDhIlxgxyeEu3LO5uCHj4OViftdyIUo6/L4qm+83hd0VEuXhbeAF53Bt874Pqa
         su8E+t8xp+HiAsZhdxTnjsn9L2kECThLzmNWusDLNoDAwcTe3hvTA85nqB66L1czhfvB
         U6ky+v90sniLk7vA5SbX/qg86reLO8DpXVX3PZM19dqc54b6f5lfodIGx4qq2ATpg3IQ
         /JPyW67O+azqBg3THMtKFxEr34UsfJjEVx4HpzR5T7A0JI5yXe0x1ugBdkc0GWXGPetz
         EnrqOk5xG01d5LbbsfYtoxCwywdClPx1smTWcROqmiHzu773sn7rD6+ZA/mEI8JZduNP
         B9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWwFHSBMupuLo2dWxXuZUZVjMxn8W1WgSVd1HI8iNW1ph+uOGW11nnNpm0W/olNfYwkh2G8iFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2epJ452Cnmidw46AhIjliKdaFwQIot25DmQ3EsJAFRrfYPheD
	3pAgy0uQGgtEfyPTHeagPbPUQUT7Lungx7XswVEJE3lHbcrU18Miu5/cpaXvuDzzW2yFGGrBTlG
	OZQSFUusywKkT7Q6FPkZ93s0/5R96NzS5Oead
X-Gm-Gg: ASbGncv/nESOrR9QoMwz9tsakR5p7BJhRCFrMw1YzAOZozqNaZei9vs/m4qml6VRI6S
	cVYRK22DWlxKtUGqXvy8jTLulWC7A05TycGvqk7NZ0W+EXUNCtieyWhZSmQaZROutvemg4dTUfw
	==
X-Google-Smtp-Source: AGHT+IFwsi5XM5RDmNrMJCaUmL8I+ZKZKIm2b8LFV1andQ6hlDic/J8OPfnnpaSrViZrJ8NqR107UZAio3vUbvNciIs=
X-Received: by 2002:a05:6402:320a:b0:5d0:d06b:cdc4 with SMTP id
 4fb4d7f45d1cf-5dc6f619ea5mr568943a12.15.1738183267754; Wed, 29 Jan 2025
 12:41:07 -0800 (PST)
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
 <CANn89iJmbefLpPW-jgJjFkx79yso3jUUzuH0voPaF+2Kz3EW2g@mail.gmail.com> <CAGXJAmz5=V2DmGHHh2XRHKQYynXmqYk_Nqw-y_QBWBQBMjbuag@mail.gmail.com>
In-Reply-To: <CAGXJAmz5=V2DmGHHh2XRHKQYynXmqYk_Nqw-y_QBWBQBMjbuag@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Jan 2025 21:40:56 +0100
X-Gm-Features: AWEUYZnKOP9qppbbitQIgUbdzMNVeNIeBisEpzLX8_0LwO66rLLjpaaJtaQd-r4
Message-ID: <CANn89iJ+mvp48F9tMmO=ttK3ai2WTVC7NNKy8YbV1d0wr-BD+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and homa_rpc.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 9:27=E2=80=AFPM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> On Wed, Jan 29, 2025 at 9:04=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Jan 29, 2025 at 5:55=E2=80=AFPM John Ousterhout <ouster@cs.stan=
ford.edu> wrote:
> > >
> > > On Wed, Jan 29, 2025 at 8:50=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Wed, Jan 29, 2025 at 5:44=E2=80=AFPM John Ousterhout <ouster@cs.=
stanford.edu> wrote:
> > > > >
> > > > > GRO is implemented in the "full" Homa (and essential for decent
> > > > > performance); I left it out of this initial patch series to reduc=
e the
> > > > > size of the patch. But that doesn't affect the cost of freeing sk=
bs.
> > > > > GRO aggregates skb's into batches for more efficient processing, =
but
> > > > > the same number of skb's ends up being freed in the end.
> > > >
> > > > Not at all, unless GRO is forced to use shinfo->frag_list.
> > > >
> > > > GRO fast path cooks a single skb for a large payload, usually addin=
g
> > > > as many page fragments as possible.
> > >
> > > Are you referring to hardware GRO or software GRO? I was referring to
> > > software GRO, which is what Homa currently implements. With software
> > > GRO there is a stream of skb's coming up from the driver; regardless
> > > of how GRO re-arranges them, each skb eventually has to be freed, no?
> >
> > I am referring to software GRO.
> > We do not allocate/free skbs for each aggregated segment.
> > napi_get_frags() & napi_reuse_skb() for details.
>
>  YATIDNK (Yet Another Thing I Did Not Know); thanks for the information.
>
> So it sounds like GRO moves the page frags into another skb and
> returns the skb shell to napi for reuse, eliminating an
> alloc_skb/kfree_skb pair? Nice.
>
> The skb that receives all of the page frags: does that eventually get
> kfree_skb'ed, or is there an optimization for that that I'm also not
> aware of?

This fat skb is going to be stored into a socket receive queue,
so that its content can be copied or given to the user application.

TCP then gives back the fat skb to the cpu which allocated the pages,
so that kfree_skb() is very cheap. Fast NIC have page pools.

tcp_eat_recv_skb()

With BIG TCP, we typically store 180 KB of payload per sk_buff

