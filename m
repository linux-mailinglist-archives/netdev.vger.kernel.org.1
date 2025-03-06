Return-Path: <netdev+bounces-172356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07615A54555
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E67A9530
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935F1FF7CC;
	Thu,  6 Mar 2025 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ7RBKtT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958292E3369
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251039; cv=none; b=eXyXiGgf5Tc7XFxjoHNUVKo8jUSvYKeAmGx8g6TSQT//Wbgk/kmYAvmMGnBMSAs8ZTj2nWIv5KF719C9jfcgNwYjsCVy6f5+S1jKw0rFOMjudgmxtJkSwfm79B5Q5vUAVAdLNHNbRloB44KIm6ZVqNjuNrE8QtJGHgsGxX9KwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251039; c=relaxed/simple;
	bh=9TqfMFTJndzkXWLjTqaQ/zZPKzLwulcfZy+rIHknwvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmVb4a8+PJq3Y2Huhhx1BhP2EWvtQctFHrXnUgOsAuCSLworuV/J0rwtlFIFKChieBF3R37TKHe8PYk+cMb1P/HFJW+9FdimSLSZz05BVsrJHKGxVGTxpWC4gDXaHJrTYR6mYongmWOTjWTkJQVpVCY72TAW+zwuBFHx54JEFbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ7RBKtT; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d43bb5727fso882755ab.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 00:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741251036; x=1741855836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBNnWb4h0P3DkIcfcNbfaVgVkKvOmxVfLMp6Ps9ecds=;
        b=CZ7RBKtTySWNKzdqvWHTZbDD3poBWB/55qCHHaYb6cOVvAYG8Ah8VgMOJ5Mn2CnzFH
         lxq6ndj9cHHFQRIigH166djSL4QxtWbQyqHthLHMejKkkMFxm0lqHpzO36ILbmKcn10k
         vNVR+WCszlSjm6N0aSUZx99Jjbmx+nImFTwwoOwJXqXu6hvxLghlIFrfhqFn9qnv5KP3
         WN6JhCimKpgEoOJP3JLu9Q7Z8tPMPXBBgD9RldG+WJUw4KFSX+iWx+T1O6UI2qLZmBY7
         dfhg8n9BW9jLcWTajGHKLy3YhKGUJhJF5QKrXn0GTj8nhcampUt8QhMZ/vh3SdoooLlc
         MWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251036; x=1741855836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBNnWb4h0P3DkIcfcNbfaVgVkKvOmxVfLMp6Ps9ecds=;
        b=pzEpZn1aWWOmpTOmEsCfNMXXL4T/pbTSnsMn7ctKZ/zx3HoZ1m36vLnu+0z0ZwjP1o
         UXI7G8qSGG8cj8cyNylUqn6yopKrp2RIbet64nSa/CTBpWz+LqNRDyr876ErUWf7Umpp
         hi5pOpL5X4nfEKu880EoIbltcxju6slodcTofalltGuZ2e5gY4AsBIkrEINC57q/P4ej
         BGxdVTXm1cFdpooVEuih7CUnsGeVzbP3d7dImrIX/DiTHIDvM4715oipnU8XxQnKHfMI
         sgMCER62aJgZcWJNgELoV98z6kqepA/WXrsYXPXxKnnJq4ovp84mCbuaDdZwe5RX1A/7
         fSKA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+sZmdHJwBvlK515xWEPbFf1RoEbpyRt7UyiWxxik1yCj3SiRfDlFDb2NVhCGdwTVUW5Ho7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95hylb/FI+JJsCJKm4U5GSnCYnpwztF83k+BaCYxwi/jajC7Z
	p6bg10G+5djOTDC97qSG5bzXnBoMJaZHt7uLNCsVprixfcTdSanV6vZ307Nt9+Uec4YmcCI0daW
	/1+p0qaWRoqERBK+FtWaDgxH+H44=
X-Gm-Gg: ASbGncuuYowGN+i2ecHXHw4OE8ODzbqkXwLdmAgQN0DNU6nEfHGjhHMu0r5Nmfe0pLc
	jBxWis6JwfS4J2zXTKiQ5DDoNOVur0wJljwF30W3szMdNZES8QXkNydMNSddZO2T+lRrYRpeiiv
	GZRkGTeijQunCOzpvM2n4LdA3Clg==
X-Google-Smtp-Source: AGHT+IHJL1tFTyYpBdIeyg/HO1gLTV/01YsZ8vyUsLNZ2r0CYlOQ05RWg8Xsc83hfUx68egP/tYGDk83sC1ewckxK/c=
X-Received: by 2002:a05:6e02:18ca:b0:3d3:e11a:39d with SMTP id
 e9e14a558f8ab-3d42b8d397amr56706805ab.13.1741251036513; Thu, 06 Mar 2025
 00:50:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDFSSdMXGyUeR+3nqdyVpjsky7y4ZaCB-n1coR_x_Vhfw@mail.gmail.com>
 <20250306062218.85962-1-kuniyu@amazon.com> <CAL+tcoAEPkyyvzULua_MUNQb=up_8Qqg+w3Oq6B9C1JS9gvdrQ@mail.gmail.com>
 <CANn89iL_sT7a+49HNDLjsP5qnREPKpx6yEu8USMZPxW1vP+skg@mail.gmail.com>
 <CAL+tcoBpUxfMo6Assb6gU9JaJctS4Gt7G889GNmJsRFQeaxHJA@mail.gmail.com> <CANn89iKwCPfHmEkjUn7Xedz+=maFArk5Nx8cNS_fDKgWZ4_Nvw@mail.gmail.com>
In-Reply-To: <CANn89iKwCPfHmEkjUn7Xedz+=maFArk5Nx8cNS_fDKgWZ4_Nvw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 16:50:00 +0800
X-Gm-Features: AQ5f1Jqze17hqbMGuVOOQXedv66c3RPN48NbxsAUiLEjsIxG9MEhNPdo5U8nIdY
Message-ID: <CAL+tcoBh4LrTqp6KA2DqwamP5e863vQfnTA8KrZ15+mBnPS7dQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, eric.dumazet@gmail.com, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 4:18=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Mar 6, 2025 at 9:04=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Thu, Mar 6, 2025 at 3:26=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Thu, Mar 6, 2025 at 7:35=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > >
> > > > On Thu, Mar 6, 2025 at 2:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@am=
azon.com> wrote:
> > > > >
> > > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > > Date: Thu, 6 Mar 2025 12:59:03 +0800
> > > > > > On Thu, Mar 6, 2025 at 12:12=E2=80=AFPM Kuniyuki Iwashima <kuni=
yu@amazon.com> wrote:
> > > > > > >
> > > > > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > > > > Date: Thu, 6 Mar 2025 11:35:27 +0800
> > > > > > > > On Wed, Mar 5, 2025 at 9:06=E2=80=AFPM Eric Dumazet <edumaz=
et@google.com> wrote:
> > > > > > > > >
> > > > > > > > > We have platforms with 6 NUMA nodes and 480 cpus.
> > > > > > > > >
> > > > > > > > > inet_ehash_locks_alloc() currently allocates a single 64K=
B page
> > > > > > > > > to hold all ehash spinlocks. This adds more pressure on a=
 single node.
> > > > > > > > >
> > > > > > > > > Change inet_ehash_locks_alloc() to use vmalloc() to sprea=
d
> > > > > > > > > the spinlocks on all online nodes, driven by NUMA policie=
s.
> > > > > > > > >
> > > > > > > > > At boot time, NUMA policy is interleave=3Dall, meaning th=
at
> > > > > > > > > tcp_hashinfo.ehash_locks gets hash dispersion on all node=
s.
> > > > > > > > >
> > > > > > > > > Tested:
> > > > > > > > >
> > > > > > > > > lack5:~# grep inet_ehash_locks_alloc /proc/vmallocinfo
> > > > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_=
locks_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D=
3 N5=3D2
> > > > > > > > >
> > > > > > > > > lack5:~# echo 8192 >/proc/sys/net/ipv4/tcp_child_ehash_en=
tries
> > > > > > > > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "g=
rep inet_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > > > > 0x000000004e99d30c-0x00000000763f3279   36864 inet_ehash_=
locks_alloc+0x90/0x100 pages=3D8 vmalloc N0=3D1 N1=3D2 N2=3D2 N3=3D1 N4=3D1=
 N5=3D1
> > > > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_=
locks_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D=
3 N5=3D2
> > > > > > > > >
> > > > > > > > > lack5:~# numactl --interleave=3D0,5 unshare -n bash -c "g=
rep inet_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > > > > 0x00000000fd73a33e-0x0000000004b9a177   36864 inet_ehash_=
locks_alloc+0x90/0x100 pages=3D8 vmalloc N0=3D4 N5=3D4
> > > > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_=
locks_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D=
3 N5=3D2
> > > > > > > > >
> > > > > > > > > lack5:~# echo 1024 >/proc/sys/net/ipv4/tcp_child_ehash_en=
tries
> > > > > > > > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "g=
rep inet_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > > > > 0x00000000db07d7a2-0x00000000ad697d29    8192 inet_ehash_=
locks_alloc+0x90/0x100 pages=3D1 vmalloc N2=3D1
> > > > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_=
locks_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D=
3 N5=3D2
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > > > >
> > > > > > > > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > > >
> > > > > > > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > >  net/ipv4/inet_hashtables.c | 37 ++++++++++++++++++++++++=
++-----------
> > > > > > > > >  1 file changed, 26 insertions(+), 11 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_h=
ashtables.c
> > > > > > > > > index 9bfcfd016e18275fb50fea8d77adc8a64fb12494..2b4a58824=
7639e0c7b2e70d1fc9b3b9b60256ef7 100644
> > > > > > > > > --- a/net/ipv4/inet_hashtables.c
> > > > > > > > > +++ b/net/ipv4/inet_hashtables.c
> > > > > > > > > @@ -1230,22 +1230,37 @@ int inet_ehash_locks_alloc(struct=
 inet_hashinfo *hashinfo)
> > > > > > > > >  {
> > > > > > > > >         unsigned int locksz =3D sizeof(spinlock_t);
> > > > > > > > >         unsigned int i, nblocks =3D 1;
> > > > > > > > > +       spinlock_t *ptr =3D NULL;
> > > > > > > > >
> > > > > > > > > -       if (locksz !=3D 0) {
> > > > > > > > > -               /* allocate 2 cache lines or at least one=
 spinlock per cpu */
> > > > > > > > > -               nblocks =3D max(2U * L1_CACHE_BYTES / loc=
ksz, 1U);
> > > > > > > > > -               nblocks =3D roundup_pow_of_two(nblocks * =
num_possible_cpus());
> > > > > > > > > +       if (locksz =3D=3D 0)
> > > > > > > > > +               goto set_mask;
> > > > > > > > >
> > > > > > > > > -               /* no more locks than number of hash buck=
ets */
> > > > > > > > > -               nblocks =3D min(nblocks, hashinfo->ehash_=
mask + 1);
> > > > > > > > > +       /* Allocate 2 cache lines or at least one spinloc=
k per cpu. */
> > > > > > > > > +       nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1U)=
 * num_possible_cpus();
> > > > > > > > >
> > > > > > > > > -               hashinfo->ehash_locks =3D kvmalloc_array(=
nblocks, locksz, GFP_KERNEL);
> > > > > > > > > -               if (!hashinfo->ehash_locks)
> > > > > > > > > -                       return -ENOMEM;
> > > > > > > > > +       /* At least one page per NUMA node. */
> > > > > > > > > +       nblocks =3D max(nblocks, num_online_nodes() * PAG=
E_SIZE / locksz);
> > > > > > > > > +
> > > > > > > > > +       nblocks =3D roundup_pow_of_two(nblocks);
> > > > > > > > > +
> > > > > > > > > +       /* No more locks than number of hash buckets. */
> > > > > > > > > +       nblocks =3D min(nblocks, hashinfo->ehash_mask + 1=
);
> > > > > > > > >
> > > > > > > > > -               for (i =3D 0; i < nblocks; i++)
> > > > > > > > > -                       spin_lock_init(&hashinfo->ehash_l=
ocks[i]);
> > > > > > > > > +       if (num_online_nodes() > 1) {
> > > > > > > > > +               /* Use vmalloc() to allow NUMA policy to =
spread pages
> > > > > > > > > +                * on all available nodes if desired.
> > > > > > > > > +                */
> > > > > > > > > +               ptr =3D vmalloc_array(nblocks, locksz);
> > > > > > > >
> > > > > > > > I wonder if at this point the memory shortage occurs, is it=
 necessary
> > > > > > > > to fall back to kvmalloc() later
> > > > > > >
> > > > > > > If ptr is NULL here, kvmalloc_array() is called below.
> > > > > >
> > > > > > My point is why not return with -ENOMEM directly? Or else It lo=
oks meaningless.
> > > > > >
> > > > >
> > > > > Ah, I misread.  I'm not sure how likely such a case happens, but =
I
> > > > > think vmalloc() and kmalloc() failure do not always correlate, th=
e
> > > > > former uses node_alloc() and the latter use the page allocator.
> > > >
> > > > Sure, it is unlikely to happen.
> > > >
> > > > As to memory allocation, we usually try kmalloc() for less than pag=
e
> > > > size memory allocation while vmalloc() for larger one. The same log=
ic
> > > > can be seen in kvmalloc(): try kmalloc() first, then fall back to
> > > > vmalloc(). Since we fail to allocate non-contiguous memory, there i=
s
> > > > no need to try kvmalloc() (which will call kmalloc and vmalloc one
> > > > more round).
> > >
> > > I chose to not add code, because:
> > >
> > >        if (num_online_nodes() > 1) {
> > >                /* Use vmalloc() to allow NUMA policy to spread pages
> > >                 * on all available nodes if desired.
> > >                 */
> > >                ptr =3D vmalloc_array(nblocks, locksz);
> > >
> > > << adding here a test is pointless, we already have correct code if
> > > ptr =3D=3D NULLL >>
> > >
> > >        }
> > >        if (!ptr) {
> > >                ptr =3D kvmalloc_array(nblocks, locksz, GFP_KERNEL);
> > >                if (!ptr)
> > >                        return -ENOMEM;
> > >         }
> > >
> > >
> > > Sure, this could be written in a different way, but ultimately it is =
a
> > > matter of taste.
> >
> > Sorry that I didn't make myself clear enough. I mean if
> > vmalloc_array() fails, then it will fall back to kvmalloc_array()
> > which will call kmalloc() or even vmalloc() to allocate memory again.
> > My intention is to return with an error code when the first time
> > allocation fails.
> >
> > Code like this on top of your patch:
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index 3edbe2dad8ba..d026918319d2 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -1282,12 +1282,12 @@ int inet_ehash_locks_alloc(struct
> > inet_hashinfo *hashinfo)
> >                  * on all available nodes if desired.
> >                  */
> >                 ptr =3D vmalloc_array(nblocks, locksz);
> > -       }
> > -       if (!ptr) {
> > +       } else {
> >                 ptr =3D kvmalloc_array(nblocks, locksz, GFP_KERNEL);
> > -               if (!ptr)
> > -                       return -ENOMEM;
> >         }
> > +       if (!ptr)
> > +               return -ENOMEM;
> > +
>
> I think I understood pretty well, and said it was a matter of taste.
>
> I wish we could move on to more interesting stuff, like the main ehash
> table, which currently
> uses 2 huge pages, they can all land into one physical socket.

Interesting. I will dig into it after next week because next week
netdev will take place :)

Before this, I tried to accelerate transmitting skbs with four numa
nodes like allocating skbs in local numa nodes or something like that,
but it didn't show good throughput. Glad to know you're doing various
challenging tests.

Thanks,
Jason

