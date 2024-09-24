Return-Path: <netdev+bounces-129561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B029847CA
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17F41F21071
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6571AAE16;
	Tue, 24 Sep 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3kAShbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8C154C07
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188616; cv=none; b=gySdg2Pzox5revyPDKgbOlNZMFFewDZnI9QENgKCBBA503qGCwxhXaREKQnLZ0CpTSlhyb2Y4TeGhmQHAKHSidgPiCW7tAdMlOEpz2pZO3084+EgiSd2LpcGDvHKfw0vuCA8GlX1Asx6h8Ef75PiAFx3uddlU4I/J+Zg/t3EN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188616; c=relaxed/simple;
	bh=6HaoCiskAzk80yHHYDIVzKdhiJjCfUZOCJ+LxyD3AqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5rf3EvZi/U0sPWtj8X3kt8YWb5GP+mX5AxeDK/e+H6WC6mJ74w2bQV877nICefqWve3DFP1ELb68QnbHKDZjqIDBgL/5yzrGE8syxYVa2uwwYZoVmmyIdkgkmhh5CVWxtyd0QkJnog8EqZyPFyw+hRetzSnA4yHPdfDOE0BBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3kAShbj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso754309666b.3
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727188613; x=1727793413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HaoCiskAzk80yHHYDIVzKdhiJjCfUZOCJ+LxyD3AqI=;
        b=T3kAShbjwtdJGPS20Vq+UtdrpQ+fybR01rZYNKsVhPy52DwdF2Q4Gi6HBGIEosNqNo
         Jc/VdhptTCfjOdbjG9LYdV3bVmKrS6u6vq3QpuzQyuDFP5pb2qzOvO78Gs4i75FSVquE
         +gusQMmkMtE2gqQjGwVTXdh+db6nf8/ZJnopScQ+wD59dEAkTf/mIT5sxPfe1TRuWmVR
         UpvTK0/WDkE1yc8P+c6DodqLRsQwk/3LHOVwHrjz5141+xZrv8kEgPbfZzOyNnCYbTV/
         mYX6yGTyNekhKgt4+8fAz07AIbsoqTlt1mQP4aVvTS82qwXB8TZE8kkjeCvgje0f+eDS
         vWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727188613; x=1727793413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HaoCiskAzk80yHHYDIVzKdhiJjCfUZOCJ+LxyD3AqI=;
        b=Yf1TReW+XWywNoc59N3LoxfGJrFG8EpQFizZH/9dHH7vkN+GbUj6/Flnx9cNcpNEpl
         XWh/U0PlfQnlkZYmFgtYfxbO2LO97F6z69Rkwki/iG47ld9Xq6T1LY46x9aYmFyBArFx
         iNWGtkZ9CRcGn3wYD4gDuWq1zPUg5siML07U41WzFzlTGtZFeIrvu/TeB6cRaqvpTTD8
         RYsCTXAPBcNaxv8ZZbalSCBopITEwMs1Buyq2f8rxAJsQzk4gKraWiTRFOEr7WJtBK4x
         SAfer3UCV2tR16q/RccxEHigAaxrFnYFb14hAcveE/psKm8QZRzNYXuc4p6w9Wjuz/BK
         v5/A==
X-Forwarded-Encrypted: i=1; AJvYcCVrzJMmsEl/WwfXqDnFo6jm5RyX0mnV6xFcIdd2tpGr4U5r+WiWSKnnjOJlfH0j0VOzxbqId34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwL0sQ4JKTTVGiUs/7yGW6Ka+mNjJS/rjQ62R7+2EVWgx01bR
	Z3if5dkH/JummmqWLR38NPg9+B1+HlFzmb/xM73b/QdsyjojN91D8BKzAbA1uxQROmm/N9ffyBg
	W/96kWXmVuOghn42NlQq/q5IuuPocHXXm4kkh
X-Google-Smtp-Source: AGHT+IEqkOkdyTava7cReTyIuBZrE3WxtjmV0dnTp8BAP3a+qGGes4OzGLz4j/2ZXD30XPzQWQ84DLV2Q9NWcWv3dEI=
X-Received: by 2002:a17:907:7f23:b0:a7a:9a78:4b5a with SMTP id
 a640c23a62f3a-a90d5127241mr1663238266b.52.1727188613134; Tue, 24 Sep 2024
 07:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com> <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com> <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
 <c739f928-86a2-46f8-b92e-86366758bb82@orange.com>
In-Reply-To: <c739f928-86a2-46f8-b92e-86366758bb82@orange.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Sep 2024 16:36:39 +0200
Message-ID: <CANn89i+nMyTsY8+KcoYXZPor8Y3r+rbt5LvZe1sC3yZq1wqGeQ@mail.gmail.com>
Subject: Re: Massive hash collisions on FIB
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 4:06=E2=80=AFPM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> On 17/09/2024 08:59, Eric Dumazet wrote:
> >
> >> What do you think ?
> >
> > I do not see any blocker for making things more scalable.
> >
> > It is only a matter of time and interest. I think that 99.99 % of
> > linux hosts around the world
> > have less than 10 netns.
> >
> > RTNL removal is a little bit harder (and we hit RTNL contention even
> > with less than 10 netns around)
>
> Given this encouragement, I'm proceeding towards the the "million-tunnel =
baby".
> And knowing where the current road bumps are, workarounds are possible: i=
nstead
> of a direct 1M fanout of (netns+interface), I'm doing 10k netns with 100
> interfaces each, which works like a charm.
>
> But doing this I met an entirely new kind of bottleneck: the single FIB
> hashtable, shared by all netns, lends itself to massive collision if many=
 netns
> contain the same local address.
>
> Indeed, in this situation, the fib_inetaddr_notifier ends up inserting a =
local
> route for the address, and the only "moving part" in the hash input is th=
e
> address itself.
>
> As an example, after creating 7000 veth pairs and moving their "right hal=
f" to
> 7000 namespaces, an "ip addr add 192.168.1.2/32 dev $D" on one of them hi=
ts a
> bucket of depth 7000.

Shocking

>
> To solve this, I'd naively inject a few bits of entropy from the netns it=
self
> (inode number, middle bits of (struct net *) address, etc.), by XORing th=
em to
> the hash value. Unless I'm mistaken, the netns is always unambiguous when=
 a FIB
> decision is made, be it for a packet or for some interface configuration =
task.
>
> Would that be acceptable ?

Sure, but please use the standard way : net_hash_mix(net)

