Return-Path: <netdev+bounces-229115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E7BD8542
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 296EF4EB5A3
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E32DF706;
	Tue, 14 Oct 2025 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtXN8YGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB28C29ACF0
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432337; cv=none; b=iIqqu5s9cdbz+f0WxoS3Ehx0Zf93qXjKslXUul3WXnHK4gwscOQoaoGF27FEtBZP8bcK8i5C+CcGMBhCfPvEN4gIUDgQzdKUgFiFv57YzWVuie5LKgew5NE1PeHXHc+bkfOTs9DCfiXyjnDGkjVlLbQNVaxBBkwF8o2UAh7ft9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432337; c=relaxed/simple;
	bh=k7HmEga+OGGjtgmIR/2QroLQNi9uv52kHnYxNBFHLV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMO/lvyuOHX4OP4pUdvo2AlEdroiPi5n2QB/JY3H+VvmMBuAzFo1KzT8Lk66XFW9zheuUdZV/y8dSO5l3UDUW9HbgApuNmSDjLuwbYhsuMeYVzj6in22i7c4iw0g5QG0P+903etPvPMokNNuKbPpUmElnM7Ox/ExfBmmws/yS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtXN8YGD; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-930c4cd6ccbso2360895241.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760432335; x=1761037135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLYcGa961yhxxYkbsF/rLk6YVjYontQ0KHKihOwI8T4=;
        b=mtXN8YGDM0aISxB1DFvAzepVL1SlQTXIBH/eXYSynkkF62flVL0bcfSFF4YgFvOE2Z
         VDZ+HZjn6sMYNJus6FjEkZ3JKqpk577g14t6Ap5QU2EZzHfn7PbH8tuL1/+8Bxpe8a1W
         mfeQvTRWaXHGTsMcUE4KHla8XG6jkqEDdvmiyP8sYQyOtJUrKYVUfMxcqsGDP7l6eXU7
         jgrAztgdpiFtHXrQd1eDz0dCaeAAEpaOq9mPhm1fEbbtOosJeiKm8U27IyoQ4NFA47YZ
         DEj2P1BxTsuQsxF5hwByvDFU5D5Y2Bz+jB5vvMCT3wj2fRo5rv/jn0chWIYmoNifgLNS
         9Xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432335; x=1761037135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLYcGa961yhxxYkbsF/rLk6YVjYontQ0KHKihOwI8T4=;
        b=LDuKS+TUoZlG4QquiKxBD7Rd65JM4rxNUjqjjBqaQsU8V0SzOgDmBiuKImG79sU7OM
         jnGbrryhyptvoA5YQKZhlNfEzjVgLqI3GRjDDJhooFAzChWn+d5GoFzkcvxiWSOAyZAB
         OWE183gjjHo7qfGZiS3efNEm47xRvSjXwNHrOOJwgVrOto4wJQJaCEk6PCHeGrb0AGK7
         KZdLWCMonX2eI0dvOqngsPvSm5WDBXzIKmgQrVGbdA/VV00ryH7XuUw1Rumecf44Qogs
         OiqV1stgMg0QegGnYykPOXmgH8wrgPMEzNWqOAeyLhFUOct6FchZ/roN1rAy6ktD9umy
         SWrg==
X-Forwarded-Encrypted: i=1; AJvYcCUyW6y8/vEnw3KaO/wnNzU3WRsPpXx9mSrsuyj5rdu+Bvz3k3zChCjVIOF9ijH1+1YbIX6zUfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cBUTr1e1gg43V2ftSjmRKuW6AvIPClOqjlbaPJroe8xczBHC
	xcxtRwppPh+VnJE3TfXgkepMwHPUoKHfWUwheqwrrv6Y8QXltxw/5xH4B3da3TzaLnrxoA4Y84W
	48u/COlu2N0+TPJjo8jZYDXHv7uCH1/A=
X-Gm-Gg: ASbGnctSJUkgtXlrexHzHLM03oXhFbmVolM8RT8f2eCI0n5qnOhT63FWWkTz+iZWG46
	dZmkApikh7lO1k2w9aPekYmSBE0/jcinkgjfawpFejIXTLSrL2Q9WyrDDUMitFXR1lGkZab69Kx
	8Ggbc7hXXw1dG5SOz2ceZgxzyO6OkbF4EByR5IgcdQ50K08xC5b7JycV8Y77fFBdQzuJEN3Dcvq
	XgrjCkRdsYcnHM/u9j0aajYSs+etMJEHdI6BKtzNp/VuXheD1XTdzm4mA==
X-Google-Smtp-Source: AGHT+IGX4PksrMyWa5G15wFPdlRrAfYAlpyBh8eq+zBl1laEShj5dhtzQCGqBWE2Cgx+teji5G7o41ixrF4TOb83K1Q=
X-Received: by 2002:a05:6102:3e14:b0:529:e9a5:c216 with SMTP id
 ada2fe7eead31-5d5e22127b3mr9320305137.4.1760432334547; Tue, 14 Oct 2025
 01:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com> <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
In-Reply-To: <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 14 Oct 2025 16:58:43 +0800
X-Gm-Features: AS18NWBgpajHqeXyjq2SfshUK90UReXA3HYugsOOoYy5fZXYwfWha3ufAj0-PzY
Message-ID: <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Eric Dumazet <edumazet@google.com>
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

On Tue, Oct 14, 2025 at 1:04=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Oct 13, 2025 at 9:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Tue, Oct 14, 2025 at 5:56=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Mon, Oct 13, 2025 at 06:16:36PM +0800, Barry Song wrote:
> > > > On phones, we have observed significant phone heating when running =
apps
> > > > with high network bandwidth. This is caused by the network stack fr=
equently
> > > > waking kswapd for order-3 allocations. As a result, memory reclamat=
ion becomes
> > > > constantly active, even though plenty of memory is still available =
for network
> > > > allocations which can fall back to order-0.
> > >
> > > I think we need to understand what's going on here a whole lot more t=
han
> > > this!
> > >
> > > So, we try to do an order-3 allocation.  kswapd runs and ... succeeds=
 in
> > > creating order-3 pages?  Or fails to?
> > >
> >
> > Our team observed that most of the time we successfully obtain order-3
> > memory, but the cost is excessive memory reclamation, since we end up
> > over-reclaiming order-0 pages that could have remained in memory.
> >
> > > If it fails, that's something we need to sort out.
> > >
> > > If it succeeds, now we have several order-3 pages, great.  But where =
do
> > > they all go that we need to run kswapd again?
> >
> > The network app keeps running and continues to issue new order-3 alloca=
tion
> > requests, so those few order-3 pages won=E2=80=99t be enough to satisfy=
 the
> > continuous demand.
>
> These pages are freed as order-3 pages, and should replenish the buddy
> as if nothing happened.

Ideally, that would be the case if the workload were simple. However, the
system may have many other processes and kernel drivers running
simultaneously, also consuming memory from the buddy allocator and possibly
taking the replenished pages. As a result, we can still observe multiple
kswapd wakeups and instances of over-reclamation caused by the network
stack=E2=80=99s high-order allocations.

>
> I think you are missing something to control how much memory  can be
> pushed on each TCP socket ?
>
> What is tcp_wmem on your phones ? What about tcp_mem ?
>
> Have you looked at /proc/sys/net/ipv4/tcp_notsent_lowat

# cat /proc/sys/net/ipv4/tcp_wmem
524288  1048576 6710886

# cat /proc/sys/net/ipv4/tcp_mem
131220  174961  262440

# cat /proc/sys/net/ipv4/tcp_notsent_lowat
4294967295

Any thoughts on these settings?

Thanks
Barry

