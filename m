Return-Path: <netdev+bounces-229166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276D9BD8C84
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C13C1923432
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4602F7AB1;
	Tue, 14 Oct 2025 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utz2bd//"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545112F7AD6
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438361; cv=none; b=aNtwrQpny75raLvJcEctzbeNmUSimhWE5s2/UxfozlryakXfomsSkxoNaCja3VvW04hwXzyatYO2hw70PfrH1+3l9iU9Rt9o3HD7lLAxqtgw3+RoDIyqA1oAF6iYZbVX9DaKbauhwnEK6IAEGEyDv9oLUh7L3n1QSePlAD+Rsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438361; c=relaxed/simple;
	bh=q9P0PZo6cOuJ7XhtTvcQVZCsmpjkgC3FXXL1ZL3FWEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCOaSdWkO2Qp3pTJ+4YLrwaWL4J+NibxsEF2Ty3OerrAR8eBw/jlnQYKfCMfs7SwAkpelbcPHutNaQYpu4HwekUMqGpGWyB+gwJVFlyFF6e7GQARbKN1533Ybvcy7BCMSGNpCG5I4nWqnKEbWrOmmm+DwDFhNywP7Ri8Lt/gGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utz2bd//; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-84827ef386aso486690785a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760438359; x=1761043159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i8HbdVZPfionD4pRoeQJ/6YsnBufC3F7NgJEHPSzVE=;
        b=utz2bd//LCgSaXSDGqKeiciqIpkP6tI+Dub1kST75Ar63td5RhjZn1LRHLph1ddm0o
         W3WmFyGkBnLnL7YpmQiRw2jddQOs7rjCJuLFO0hyJuVQmIDuqyjtWYUO8Z3vKP5yTntx
         Mb2/ByOmHYXtDRDunQDEalMcJ1Z6lk7aZWSVBv374gfDw1mQsd4qlcb+l3fTh55fBwQP
         ZtCmjg2Ad6mLufGgehVeLuglw7VbhXtW1NBvqdLWwIWTIAFBy77RoeeZlGmQHc4Hi5Vg
         ZU2guXOswWdCXlJHfaSaGsLuWYUOmPvB3rvnA63We7uJmzbOjBs62xXm8d0BZ7CccGf6
         jSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760438359; x=1761043159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8i8HbdVZPfionD4pRoeQJ/6YsnBufC3F7NgJEHPSzVE=;
        b=VujdhZC5ophvGaIK1z00KjBk5UGlihM/juZkkZvu9GPLkbRtQwILC6kjGnOB1vwt/y
         tyI2JVlT4hoge/83edPgjuoQFJZGYVuIarOWKjVquTI9u6m3RHz7ct82Mkv30tL/oxLT
         9XCfWiqYPypzPE/uka6mLOSkUX91nW171TeLcFytQxj2LaFjkSvDZiG/yzBqyIwoUHci
         038W3105nTY32wUD2DngTmw6SvL2RyMkn2wGMfT8+KFjF3jIQ4ffhIYZRsduqFRjpBvY
         JIBe7ez7DXgtVBpmCcydTTBb0hS8ZJuMv8kOZSoSknidmt5sRK6Z6mcckb8ZzijJQF+M
         O8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1zmpdUGK2vhPaCZT5eNx+A5WNny3uunzbRTKPNX4RDTvAPQgdV598eFPTDZIWfReG6BjQ7js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKU9MbO7iS8XUMzn+aN3e664f4LQkqKLXNMfP01ACDxYRkd8Yn
	yTTt0y8SQJGBE0+lS8jJIuN3JHvirvfv3mQs1bOQPCL8ovTB+sXQhpLy8ewEMjYjLUpmEowWOT/
	chASTVF4kZEKBsLFkyl76sIlCIXztN90wuFUzDz5BQ3cBrOkXm6a5wsrsmlg=
X-Gm-Gg: ASbGncuwSFKQROT6k7Y0kdVd/11EgXRyAHbqE0d3g2vP9T+P6fMgUAtfXbNvJuGJ37s
	bBihHjql1+3/Rm9KCzUkeZWEcE8HZxFuj3wRzC/wEE40owAg1vMpr6xIsM7Vz2P28Qea8+WbE+X
	9jXPMj+otw6oil5Tb41WsLK78AVOV2UpKX33lwNUrfojciJFPaowu03Xi7MoRWM0Y8LMryL7dLq
	b3rwLDH5dzyhqHiRgFFcHW9LZnmPRR2
X-Google-Smtp-Source: AGHT+IEFzNXw/v6xZVTk0phPdvVBFB9EdAErZ6ksdm/dcjAu+K9F+ebHYFJ1AyXwmjljbbFPU7Tg80KyboEacHc3cFc=
X-Received: by 2002:ac8:5d05:0:b0:4e4:2006:b009 with SMTP id
 d75a77b69052e-4e6eaccc55cmr307481031cf.17.1760438358741; Tue, 14 Oct 2025
 03:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
 <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
 <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com>
 <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com> <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 03:39:07 -0700
X-Gm-Features: AS18NWC6tSD-2fPgi67vs3tdqcGs5ZT4phYwNUo9MOM_IOY7jeMq3pOnwQALTO4
Message-ID: <CANn89iKC_y6Fae9E5ETOE46y-RCqD6cLHnp=7GynL_=sh3noKg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 3:19=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> > >
> > > >
> > > > I think you are missing something to control how much memory  can b=
e
> > > > pushed on each TCP socket ?
> > > >
> > > > What is tcp_wmem on your phones ? What about tcp_mem ?
> > > >
> > > > Have you looked at /proc/sys/net/ipv4/tcp_notsent_lowat
> > >
> > > # cat /proc/sys/net/ipv4/tcp_wmem
> > > 524288  1048576 6710886
> >
> > Ouch. That is insane tcp_wmem[0] .
> >
> > Please stick to 4096, or risk OOM of various sorts.
> >
> > >
> > > # cat /proc/sys/net/ipv4/tcp_notsent_lowat
> > > 4294967295
> > >
> > > Any thoughts on these settings?
> >
> > Please look at
> > https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> >
> > tcp_notsent_lowat - UNSIGNED INTEGER
> > A TCP socket can control the amount of unsent bytes in its write queue,
> > thanks to TCP_NOTSENT_LOWAT socket option. poll()/select()/epoll()
> > reports POLLOUT events if the amount of unsent bytes is below a per
> > socket value, and if the write queue is not full. sendmsg() will
> > also not add new buffers if the limit is hit.
> >
> > This global variable controls the amount of unsent data for
> > sockets not using TCP_NOTSENT_LOWAT. For these sockets, a change
> > to the global variable has immediate effect.
> >
> >
> > Setting this sysctl to 2MB can effectively reduce the amount of memory
> > in TCP write queues by 66 %,
> > or allow you to increase tcp_wmem[2] so that only flows needing big
> > BDP can get it.
>
> We obtained these settings from our hardware vendors.

Tell them they are wrong.

>
> It might be worth exploring these settings further, but I can=E2=80=99t q=
uite see
> their connection to high-order allocations, since high-order allocations =
are
> kernel macros.
>
> #define SKB_FRAG_PAGE_ORDER     get_order(32768)
> #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
> #define PAGE_FRAG_CACHE_MAX_ORDER       get_order(PAGE_FRAG_CACHE_MAX_SIZ=
E)
>
> Is there anything I=E2=80=99m missing?

What is your question exactly ? You read these macros just fine. What
is your point ?

We had in the past something dynamic that we removed

commit d9b2938aabf757da2d40153489b251d4fc3fdd18
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Aug 27 20:49:34 2014 -0700

    net: attempt a single high order allocation

