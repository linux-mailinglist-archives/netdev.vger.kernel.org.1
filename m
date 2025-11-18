Return-Path: <netdev+bounces-239449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C90C68848
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FED0368A4E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83790315D5A;
	Tue, 18 Nov 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWXL9y66"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996E311C2E
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457797; cv=none; b=kSvN1yKzWqsVAhPmFV3h+AhzTJ16UeCwJ7HGjjjccFWDYURF3+4bACOHh6oZr0ck1qQ2wGrY17aeb6sghrgd5Chi4cCrUmDcd6x8vPf7pTwyA1h8TfKGNBMm35RtSdecyqQ4cKdWeg5gjv6WZWgW4VXojScVcsWPBnrGfvxMt4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457797; c=relaxed/simple;
	bh=U5TuDAvrj5r8pBKhj1sNLwuZdW4sFnFaM7z/1ZDS3iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+EpPrk+AmNf0uleXj5VLSO+7bP3qkVNYpUnijvFjkeBA0u37GA/yQYdScZNLS3HoGAhftODVVDakP7/VtEtFhQkQ7ZIo349gID4CXkrQVeD8agujkIeJg1Z6BFiCx+++rLo6/m2myCuCq2mh/ASUD1hCFXdP/GShEhwqg1FZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWXL9y66; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4330d78f935so36011445ab.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763457794; x=1764062594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5TuDAvrj5r8pBKhj1sNLwuZdW4sFnFaM7z/1ZDS3iU=;
        b=IWXL9y66ECqrfe6MYQeniw9OzCre6cFRma7NPZjE6YbUqqCZsHe0xvJHzmBumpXca8
         nLYGl3miJp1nNFZB5QHEsfoHyhtFot5F8GhBQo+ABfkpgwaXyBDMofI+UMA2g3ZjtDNL
         N68zhyP5kzbRAuznt2WaaplY3+5XM3tE0AmK1ODQ0NN6b+bZdCSWe51C6jhAD9ANTKO6
         b2GQM8/syoDrE2l7gKSJNH/nvi3YEImWPS7N5Lzo1a/e6xLGEN7ODTiWNTH41any2L1I
         7aDz10RMIB7QFV/qjFtVz8vQHrh1dwVEAkS49zRcNK2O989cy8j4MjfgaHRJUUA4aLBh
         9yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763457794; x=1764062594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5TuDAvrj5r8pBKhj1sNLwuZdW4sFnFaM7z/1ZDS3iU=;
        b=NjJFVfw5sxdQSgxryJnmTuMRw+Ko4N+bmvqzsmax3q4gDfjXb4ui9PUrOjIlHtubZR
         Pg31exjb7nZ6URmnLVrjJGwTEPP4Szk1NJXIdp4QB6sXzrZ/KU2Y98o04uKul49eoqXp
         kdIn43y0ybQrZUFwAVlhL2UUEqu/cPggIT5Mqbu3st2j3XR+W7CqHzbHzEPyJCSJVOg5
         RyMScPeAJWULpHhf53koRFXIVqV3zjq/ye9nXOXTTh8Bf/4YAr3cFeRR/ybWmJQvXHJk
         OPlmnmiswpQ66EQLqkkv7KZ+qpPmGbLDlf0mBSdX8j0QqlNCxmlx4Tap1YIkz/Av61z4
         iAog==
X-Forwarded-Encrypted: i=1; AJvYcCXo9gqXbEBxOXnBfzpYTGLe4iPzfTtVWhIkL6m7RL95w9CoGWjw2rCpEnccAYcxJ01r1Cx1Khw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvSGfQVehOoNlT4pbKjbU50CSErws7psi0hE4oxgk4CwhSGe9
	hc44xau+by6aPKUdxtHmHta7kr2ePDH6EimMdywYGzZ08vgTpcskZ5/nNi6GcFucEI+BFG3k1RG
	apXhScJqtjZMRKrm9gEtLBP6+HN8y7lFtiNnL
X-Gm-Gg: ASbGnctevawfOSjNopPsBOpCqjlt432XvgLQmJRzS71cjHA/zNW3XgeQW6ZPCrYsGMt
	adaifsYFjBEuIckfXjvNVwiBc69Vt/WuD//Ba1UvmT5J6N2M7ohJAzVI5FzATznMj9yAoz6ipsS
	vytM7sNkZoJCu6sVTniXgGZmDjP4OnrvKm4/Qnho3+c8+VtEYwCicSeygAeFpouD8nn1Hp/p1KH
	vO5DTLUl5ZKpbjG2KkxsuXV6A+Sgqea7p2UkwwMr+8xZSY2KnDQ3RSjYQpd
X-Google-Smtp-Source: AGHT+IGIvyNzpe6s6AnxwjuT2Fjp6uHG+IxlS8W3TkWb2cnhQhvDgoecXAHWUZWC+uZweLSPtk6Rps4YeYvu6i9+y3k=
X-Received: by 2002:a92:cda5:0:b0:433:7c86:74e7 with SMTP id
 e9e14a558f8ab-4348c942cc1mr180582195ab.19.1763457793849; Tue, 18 Nov 2025
 01:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-4-edumazet@google.com>
 <CAL+tcoD3-qtq4Kcmo9eb4mw6bdSYCCjxzNB3qov5LDYoe_gtkw@mail.gmail.com>
 <CAL+tcoBpUg=ggf6nQpYeZyAcMbXobuJtyUdN98G1HpcuUqFZ+w@mail.gmail.com>
 <CANn89iJb8hLw7Mx1+Td_BK7gGm5guRaUe6zdhqRqtfdw_0gLzA@mail.gmail.com>
 <CAL+tcoBeEXmyugUrqxct9VuYrSErVDA61nZ1Y62w8-NSwgdxjw@mail.gmail.com>
 <CANn89iJec+7ssKpAp0Um5pNecfzxohRJBKQybSYS=e-9pQjqag@mail.gmail.com>
 <CAL+tcoAJR3Du1ZsJC5KU=pNB7G9FP+qYVe8314GXu8xv7-PC3g@mail.gmail.com>
 <CAL+tcoC8v9QpTxRJWA17ciu=sB-RAZJ_eWNZZTVFYwUXEQHtbA@mail.gmail.com> <CANn89iLhd2Y0Htwx_kO7RixXPrPviBngZxngeMgN5n2zBTNG-w@mail.gmail.com>
In-Reply-To: <CANn89iLhd2Y0Htwx_kO7RixXPrPviBngZxngeMgN5n2zBTNG-w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 18 Nov 2025 17:22:36 +0800
X-Gm-Features: AWmQ_bkYv5xbcrauQH4tpuGoEoo5PBF0k70AYdOT8E0W_jbXR76wo9cI8eFeNEs
Message-ID: <CAL+tcoA8Ve2zy7UDLsksdsKP1cQokWQD1h41UBjPoXWqQ-DU7A@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 4:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Nov 17, 2025 at 6:07=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Mon, Nov 17, 2025 at 10:31=E2=80=AFPM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 5:48=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
>
> > >
> > > >
> > > > We can add a static key to enable/disable the behaviors that are mo=
st
> > > > suited to a particular workload.
> > >
> > > Are we going to introduce a new knob to control this snippet in
> > > napi_consume_skb()?
> >
> > That's it. For single flow in xsk scenarios, adding something like a
> > static key to avoid 1) using napi_skb_cache_get() in this patch, 2)
> > deferring free in commit [3] can contribute to a higher performance
> > back to more than 1,900,000 pps. I have no clue if adding a new sysctl
> > is acceptable.
>
> I will add one as soon as this series is merged.

Great! Thanks!

