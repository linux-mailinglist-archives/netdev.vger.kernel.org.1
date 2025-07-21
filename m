Return-Path: <netdev+bounces-208653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB11B0C918
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45103A3730
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3222CBE9;
	Mon, 21 Jul 2025 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEJrbgoE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D542E18B0F
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116629; cv=none; b=ot+CGxaBXsryo6txkAVm6VOzJZ5n8RxXmuMYlam6tR9px+c8vHNG4YIkDAN6yFdq3MtukwlinGN7vewG76qx/6jXBYNArgn6fBnmmLaTjCQomfUmbEYogHCz3UnH8uN8F3ncuxab2r1dmRZdlLSytKR7iOJaDfoiLocbeJl1vSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116629; c=relaxed/simple;
	bh=X1n8EZA/Xfx5TYAT5I3Hx2xgd5/uebdbQHWVKupcyR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUSSqQK2Rg++UcaoZJBfSRDDZHyWfb7u6Kk4+330eltcExOYKQnp/LFrvKhR64i/fKB9n5JM8w6Cb9l71/VzdvkHYCzjLc8ZKsFSauQdwiXXX/5sESa4rBdz1mgY8gbtIrThHNBgngLjB3QLeZWhDMZjFoe/7qrD/7S6fHV0l7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CEJrbgoE; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4aaaf1a63c1so34954001cf.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753116627; x=1753721427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1n8EZA/Xfx5TYAT5I3Hx2xgd5/uebdbQHWVKupcyR8=;
        b=CEJrbgoEuET0sKFSRZgpa9IVeciIuZyTcp8LZmgzNV1DnLS007mBNGSx99Km5o6mrE
         tW2BdIxOB0pn43LcAhpryLBjo+PfWSPEM93mvh73112QTSwVIQ50kdUq7Qsh6Ipx0xoM
         qFAVEfPWaC/gu0HdW4QP/WArFBD9dZFKOeD53r1cWq7v+qZO4yQwqh0U3PURCd5rN5hV
         s+C8X6HCIhNrnRMzncjUQyKdS63mppZ912/QxiNFQpkHB/kbGklsENDv3eUg0DaAk1vr
         yhtDO87z+L6kUjgCdYka91Hsz6j8uRK46bcFAGsWqpIgIyFgQS//24TosO/PoDKJ/rNJ
         v1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753116627; x=1753721427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1n8EZA/Xfx5TYAT5I3Hx2xgd5/uebdbQHWVKupcyR8=;
        b=fc3B/kyLTx/BKDswGLDy6kar1qhY9DA8dVfAbX+LSjySOgWNJy657hhyU7Eg9GgcFv
         vnBFJMDQJ45C6LGSn6QrHfVX/ByvdMkT1LJlw3f0UEFaygIhaBWqejonX42X0TJIYqnG
         TVZG6IbvJkX7uOIFD/FwI1WmLBIl6WjVCPAjT09VU1pZtM/AGs5V5TY5mVmZAfytCdqU
         RQXla6pFJsrsdwHqL5kAUHYW0PVapUcGgxRaZDMJ5VulioScr3LJU8zOwj7Z2kHnOt0K
         m6OqhlDn8wUN5p3524zzlUZKsqmRNF+Vel12NeQ11N06/8/oOcuEleGHaModnqfWb1yS
         Es4g==
X-Forwarded-Encrypted: i=1; AJvYcCVLz4/+6vv97HEgi/Fui2ewHVMQMYMr4315TQdgyYumsUN0s7MaWPzGvrxbZT79xoOfPWlx6N0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KyhfzNabSaP/9tkQCFj+F3Snm49vN3JtUo9SJxuKhREirLJO
	h2+dJvzU4IVBn3sgqHoz5M08fQYWBIk3nbbkyJL5gby3LeSzae2VKLFkQTcc2WvVRzR666r39QZ
	P6GRDHTeMV7x6UIDbreB151hDK5PzxJ9B+ioApDOAXw9+rWA9LLU/8mjB
X-Gm-Gg: ASbGncsF62yNLoQAiTUxVEne+dFt88/eztO2F0cHFa92Mf6Yp8hJvHL+1FBpHxLgGh0
	hDZJmAZDjiqIsCQb5omBB+ExUQxgHXN698v2jkLoPzOBM1gkHs61oogFqDMVkXjsXseJrOtIb/R
	o4O0jhov8tj8XHqAcWKfsYqbVs9T4gL4iN+0IEDk53fIw8plt5hU4EMQua/Kxe9syVj+jb2aD1x
	dUrz0SyQk3Qw6crdA==
X-Google-Smtp-Source: AGHT+IHE7ntNlhfdGZqyUllCr4kk6vmhns1YgUu9txL+eHcKjAzuYMDOaYsZl9Gtp8dK/iMR3xnOYdiqrTMCWAroiGM=
X-Received: by 2002:ac8:7d46:0:b0:4ab:3c02:c449 with SMTP id
 d75a77b69052e-4ab93c871d1mr395826461cf.17.1753116626323; Mon, 21 Jul 2025
 09:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752859383.git.pabeni@redhat.com> <3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
 <CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com>
 <f8178814-cf90-4021-a3e2-f2494dbf982a@redhat.com> <CANn89i+baSpvbJM6gcbSjZMmWVyvwsFotvH1czui9ARVRjS5Bw@mail.gmail.com>
 <ebc7890c-e239-4a64-99af-df5053245b28@redhat.com> <CANn89iJeXXJV-D5g3+hqStM1sH0UZ3jDeZmOu9mM_E_i9ZYaeA@mail.gmail.com>
 <1d78b781-5cca-440c-b9d0-bdf40a410a3d@redhat.com> <20250721082728.355745f2@kernel.org>
In-Reply-To: <20250721082728.355745f2@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 09:50:14 -0700
X-Gm-Features: Ac12FXxqwFE0rcOS2srYdJJUcJKoIShX3kX_S-_DS9ArHR9XQeO0PLgsqbeqzpY
Message-ID: <CANn89i+LYOmZXerPTfQDprSGo=AZNhuXt52qZ6vnXnNf6DyqJA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 8:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 21 Jul 2025 16:56:06 +0200 Paolo Abeni wrote:
> > >> I *think* that catching only the !sk_rmem_alloc case would avoid the
> > >> stall, but I think it's a bit 'late'.
> > >
> > > A packetdrill test here would help understanding your concern.
> >
> > I fear like a complete working script would take a lot of time, let me
> > try to sketch just the relevant part:
> >
> > # receiver state is:
> > # rmem=3D110592 rcvbuf=3D174650 scaling_ratio=3D253 rwin=3D63232
> > # no OoO data, no memory pressure,
> >
> > # the incoming packet is in sequence
> > +0 > P. 109297:172528(63232) ack 1
> >
> > With just the 0 rmem check in tcp_prune_queue(), such function will
> > still invoke tcp_clamp_window() that will shrink the receive buffer to
> > 110592.
> > tcp_collapse() can't make enough room and the incoming packet will be
> > dropped. I think we should instead accept such packet.
> >
> > Side note: the above data are taken from an actual reproduction of the =
issue
> >
> > Please LMK if the above clarifies a bit my doubt or if a full pktdrill
> > is needed.
>
> Not the first time we stumble on packetdrills for scaling ratio.
> Solving it is probably outside the scope of this discussion but
> I wonder what would be the best way to do it. My go to is to
> integrate packetdrill with netdevsim and have an option for netdevsim
> to inflate truesize on demand. But perhaps there's a clever way we can
> force something like tap to give us the ratio we desire. Other ideas?

Adding a TUN option (ioctl) to be able to increase skb->truesize by a
given amount / percentage is doable I think.

Then in packetdrill we could add the ability to use this option for a
given scenario or packet.

