Return-Path: <netdev+bounces-172344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED393A5447F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C681716E2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681BC1FCCF3;
	Thu,  6 Mar 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iel/XXeo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4C1FC113
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249085; cv=none; b=BiLObU9XnMA4ePtcofzWsRP2Z7wTeahZ9cTVjhEnV0en6Hldq4BxPcm2md8Mav4MQU8Xyugn5eqK1sORS1KsuebF3+rP36/nqvHhxUfkdvHRAvf5ptxSmHPQYNbctcCBR2LCkUxT3maWJf9kHxPnnNmZOfVBWOyC+Yz91DdkLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249085; c=relaxed/simple;
	bh=/P5zk0v48AiBqDcnzsRKi7pIhbWi1rtE+N4jUvyl6cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6B5Sv4/Vfj4m6PPDziUJya0g0pjMWPY8yV817rIrRAm5ccBf556PmJy1IQ3zVOWTfEoYLxeZwmK7zk2mGQDHhR6GFypdVHkg/iiMPKSwVsCS76DECuKzcWjkDcdv9kblKg1Xb1P/v0BzL+SHX6OQQj2wenPcDfkL/iOE9GrlSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iel/XXeo; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4751f8c0122so2357991cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 00:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741249082; x=1741853882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUSvKb+WKl4YPu8GTYfy1/dVTK005i3ksa6lgJjiJFs=;
        b=Iel/XXeoRZ1WrKoHPA2n4hGqP9LVU7DURNp8Ti5Ends1WL0NAVM3ebMZMMtRVBlv8c
         Yo5bax7BBunD6T5mCvVqCdmZbIyDlgcfVXhShxwU/rKTI2VsmhMHh9N1RPLq9mSRzIhn
         uOqv/VHSJiKB/GHXy8qxLkxE8hwZVXr6miN8gz6ZqvJGAQscRRZTBiXgTX28QG8ivg2n
         G9WOTBYAOGiPG17/IG1v5iOau0+zJeokr8n+6jfDrRMd1HIZZuRONsBIwWnhjKDYj0ky
         zXvlkBo6MJuBXnS7iOmTfydKDe0PLdQL1V93/89Ojr2RRYqqOz0vmd/ziNOlukMM+A3m
         Sxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249082; x=1741853882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUSvKb+WKl4YPu8GTYfy1/dVTK005i3ksa6lgJjiJFs=;
        b=wehglATTrvtaZqjrJOGc8HEvRT/SdpPfp/AZZNPULq2x4UeDlbzvWa+LgNDD0j1c+B
         p4kN3FpwK69if/caQMF2/QGurIW4DejY5WoYNN4H9JtdCGxlEoMcz8KTbh0/9840BmWE
         l4lBWB6tFXvhVQlnXR8iIJQQgX7rFVpGyeORahWTda76Tq/sPPuF66OOMqlgBjzKh8q6
         b50Zy5Y2yRMJ449/wBRhPkGUA5ZSrK5lXfB2WpGpgcm94tvGYy5u1u8lGgfaixO2/tXY
         Ds3ci92HM4sF7tZbREEyRZkWWiptg2FX6C4lPUQEQKlhZUpNAXjFniOklNwXo+js4ZQO
         tekg==
X-Forwarded-Encrypted: i=1; AJvYcCVSRSIkKOKakLsl+z7JQ48F38IVlfS7t22rQ0YryxkhXEiLz9wc/JUrzqsl0Cm/PWKNEWX3wLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/run9Ywy824wII9qDTgfzsFpGJbygTEGvxlUjBZBXe1nUiwVN
	BHxD34xrmBxnjXNa+7HLwOSRcFLajy1bUs+4ZWP+wwRMjb4II+fU31kMOSK23DtDyn3Di6IwJUk
	Ebj7UIGqb2NexXOEqz+g3D1r2a+18lHDlJaPs
X-Gm-Gg: ASbGnctM9hgNIWKEfR6atLSDiJRJ9xp3q5EdGhVQSGolXNKf6yrP3zar0Z2xHl3yDBA
	QL/vEKj61/K3pW6OrxRqZD0d09nLrErXIVgHM+JfJHqmcEz8msJF2QNNf35kwJvRyS/VMWLRjj9
	mT8xVlb7ZLhlQdA6lMtrTQXjkx8Q==
X-Google-Smtp-Source: AGHT+IF3jb/892E53JWTHWoQgyD6qqJxUUx+ZqzfgYiwMMLXMezRD5dU9py5rmKEQ7wLffHTvihdOxVcRfErQWPtbGM=
X-Received: by 2002:ac8:7d56:0:b0:475:812:d4ca with SMTP id
 d75a77b69052e-4750b24fbcamr90997551cf.18.1741249081927; Thu, 06 Mar 2025
 00:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDFSSdMXGyUeR+3nqdyVpjsky7y4ZaCB-n1coR_x_Vhfw@mail.gmail.com>
 <20250306062218.85962-1-kuniyu@amazon.com> <CAL+tcoAEPkyyvzULua_MUNQb=up_8Qqg+w3Oq6B9C1JS9gvdrQ@mail.gmail.com>
 <CANn89iL_sT7a+49HNDLjsP5qnREPKpx6yEu8USMZPxW1vP+skg@mail.gmail.com> <CAL+tcoBpUxfMo6Assb6gU9JaJctS4Gt7G889GNmJsRFQeaxHJA@mail.gmail.com>
In-Reply-To: <CAL+tcoBpUxfMo6Assb6gU9JaJctS4Gt7G889GNmJsRFQeaxHJA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 09:17:50 +0100
X-Gm-Features: AQ5f1JqKM3DOZ2Z01KB92F-eAPSz0QZKXJKH1OHcNy49yNoTJuK3N8263EZQj6c
Message-ID: <CANn89iKwCPfHmEkjUn7Xedz+=maFArk5Nx8cNS_fDKgWZ4_Nvw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, eric.dumazet@gmail.com, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 9:04=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Mar 6, 2025 at 3:26=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Mar 6, 2025 at 7:35=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Thu, Mar 6, 2025 at 2:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amaz=
on.com> wrote:
> > > >
> > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > Date: Thu, 6 Mar 2025 12:59:03 +0800
> > > > > On Thu, Mar 6, 2025 at 12:12=E2=80=AFPM Kuniyuki Iwashima <kuniyu=
@amazon.com> wrote:
> > > > > >
> > > > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > > > Date: Thu, 6 Mar 2025 11:35:27 +0800
> > > > > > > On Wed, Mar 5, 2025 at 9:06=E2=80=AFPM Eric Dumazet <edumazet=
@google.com> wrote:
> > > > > > > >
> > > > > > > > We have platforms with 6 NUMA nodes and 480 cpus.
> > > > > > > >
> > > > > > > > inet_ehash_locks_alloc() currently allocates a single 64KB =
page
> > > > > > > > to hold all ehash spinlocks. This adds more pressure on a s=
ingle node.
> > > > > > > >
> > > > > > > > Change inet_ehash_locks_alloc() to use vmalloc() to spread
> > > > > > > > the spinlocks on all online nodes, driven by NUMA policies.
> > > > > > > >
> > > > > > > > At boot time, NUMA policy is interleave=3Dall, meaning that
> > > > > > > > tcp_hashinfo.ehash_locks gets hash dispersion on all nodes.
> > > > > > > >
> > > > > > > > Tested:
> > > > > > > >
> > > > > > > > lack5:~# grep inet_ehash_locks_alloc /proc/vmallocinfo
> > > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_lo=
cks_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 =
N5=3D2
> > > > > > > >
> > > > > > > > lack5:~# echo 8192 >/proc/sys/net/ipv4/tcp_child_ehash_entr=
ies
> > > > > > > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "gre=
p inet_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > > > 0x000000004e99d30c-0x00000000763f3279   36864 inet_ehash_lo=
cks_alloc+0x90/0x100 pages=3D8 vmalloc N0=3D1 N1=3D2 N2=3D2 N3=3D1 N4=3D1 N=
5=3D1
> > > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_lo=
cks_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 =
N5=3D2
> > > > > > > >
> > > > > > > > lack5:~# numactl --interleave=3D0,5 unshare -n bash -c "gre=
p inet_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > > > 0x00000000fd73a33e-0x0000000004b9a177   36864 inet_ehash_lo=
cks_alloc+0x90/0x100 pages=3D8 vmalloc N0=3D4 N5=3D4
> > > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_lo=
cks_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 =
N5=3D2
> > > > > > > >
> > > > > > > > lack5:~# echo 1024 >/proc/sys/net/ipv4/tcp_child_ehash_entr=
ies
> > > > > > > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "gre=
p inet_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > > > 0x00000000db07d7a2-0x00000000ad697d29    8192 inet_ehash_lo=
cks_alloc+0x90/0x100 pages=3D1 vmalloc N2=3D1
> > > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_lo=
cks_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 =
N5=3D2
> > > > > > > >
> > > > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > > >
> > > > > > > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > > >
> > > > > > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > >  net/ipv4/inet_hashtables.c | 37 ++++++++++++++++++++++++++=
-----------
> > > > > > > >  1 file changed, 26 insertions(+), 11 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_has=
htables.c
> > > > > > > > index 9bfcfd016e18275fb50fea8d77adc8a64fb12494..2b4a5882476=
39e0c7b2e70d1fc9b3b9b60256ef7 100644
> > > > > > > > --- a/net/ipv4/inet_hashtables.c
> > > > > > > > +++ b/net/ipv4/inet_hashtables.c
> > > > > > > > @@ -1230,22 +1230,37 @@ int inet_ehash_locks_alloc(struct i=
net_hashinfo *hashinfo)
> > > > > > > >  {
> > > > > > > >         unsigned int locksz =3D sizeof(spinlock_t);
> > > > > > > >         unsigned int i, nblocks =3D 1;
> > > > > > > > +       spinlock_t *ptr =3D NULL;
> > > > > > > >
> > > > > > > > -       if (locksz !=3D 0) {
> > > > > > > > -               /* allocate 2 cache lines or at least one s=
pinlock per cpu */
> > > > > > > > -               nblocks =3D max(2U * L1_CACHE_BYTES / locks=
z, 1U);
> > > > > > > > -               nblocks =3D roundup_pow_of_two(nblocks * nu=
m_possible_cpus());
> > > > > > > > +       if (locksz =3D=3D 0)
> > > > > > > > +               goto set_mask;
> > > > > > > >
> > > > > > > > -               /* no more locks than number of hash bucket=
s */
> > > > > > > > -               nblocks =3D min(nblocks, hashinfo->ehash_ma=
sk + 1);
> > > > > > > > +       /* Allocate 2 cache lines or at least one spinlock =
per cpu. */
> > > > > > > > +       nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1U) *=
 num_possible_cpus();
> > > > > > > >
> > > > > > > > -               hashinfo->ehash_locks =3D kvmalloc_array(nb=
locks, locksz, GFP_KERNEL);
> > > > > > > > -               if (!hashinfo->ehash_locks)
> > > > > > > > -                       return -ENOMEM;
> > > > > > > > +       /* At least one page per NUMA node. */
> > > > > > > > +       nblocks =3D max(nblocks, num_online_nodes() * PAGE_=
SIZE / locksz);
> > > > > > > > +
> > > > > > > > +       nblocks =3D roundup_pow_of_two(nblocks);
> > > > > > > > +
> > > > > > > > +       /* No more locks than number of hash buckets. */
> > > > > > > > +       nblocks =3D min(nblocks, hashinfo->ehash_mask + 1);
> > > > > > > >
> > > > > > > > -               for (i =3D 0; i < nblocks; i++)
> > > > > > > > -                       spin_lock_init(&hashinfo->ehash_loc=
ks[i]);
> > > > > > > > +       if (num_online_nodes() > 1) {
> > > > > > > > +               /* Use vmalloc() to allow NUMA policy to sp=
read pages
> > > > > > > > +                * on all available nodes if desired.
> > > > > > > > +                */
> > > > > > > > +               ptr =3D vmalloc_array(nblocks, locksz);
> > > > > > >
> > > > > > > I wonder if at this point the memory shortage occurs, is it n=
ecessary
> > > > > > > to fall back to kvmalloc() later
> > > > > >
> > > > > > If ptr is NULL here, kvmalloc_array() is called below.
> > > > >
> > > > > My point is why not return with -ENOMEM directly? Or else It look=
s meaningless.
> > > > >
> > > >
> > > > Ah, I misread.  I'm not sure how likely such a case happens, but I
> > > > think vmalloc() and kmalloc() failure do not always correlate, the
> > > > former uses node_alloc() and the latter use the page allocator.
> > >
> > > Sure, it is unlikely to happen.
> > >
> > > As to memory allocation, we usually try kmalloc() for less than page
> > > size memory allocation while vmalloc() for larger one. The same logic
> > > can be seen in kvmalloc(): try kmalloc() first, then fall back to
> > > vmalloc(). Since we fail to allocate non-contiguous memory, there is
> > > no need to try kvmalloc() (which will call kmalloc and vmalloc one
> > > more round).
> >
> > I chose to not add code, because:
> >
> >        if (num_online_nodes() > 1) {
> >                /* Use vmalloc() to allow NUMA policy to spread pages
> >                 * on all available nodes if desired.
> >                 */
> >                ptr =3D vmalloc_array(nblocks, locksz);
> >
> > << adding here a test is pointless, we already have correct code if
> > ptr =3D=3D NULLL >>
> >
> >        }
> >        if (!ptr) {
> >                ptr =3D kvmalloc_array(nblocks, locksz, GFP_KERNEL);
> >                if (!ptr)
> >                        return -ENOMEM;
> >         }
> >
> >
> > Sure, this could be written in a different way, but ultimately it is a
> > matter of taste.
>
> Sorry that I didn't make myself clear enough. I mean if
> vmalloc_array() fails, then it will fall back to kvmalloc_array()
> which will call kmalloc() or even vmalloc() to allocate memory again.
> My intention is to return with an error code when the first time
> allocation fails.
>
> Code like this on top of your patch:
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 3edbe2dad8ba..d026918319d2 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1282,12 +1282,12 @@ int inet_ehash_locks_alloc(struct
> inet_hashinfo *hashinfo)
>                  * on all available nodes if desired.
>                  */
>                 ptr =3D vmalloc_array(nblocks, locksz);
> -       }
> -       if (!ptr) {
> +       } else {
>                 ptr =3D kvmalloc_array(nblocks, locksz, GFP_KERNEL);
> -               if (!ptr)
> -                       return -ENOMEM;
>         }
> +       if (!ptr)
> +               return -ENOMEM;
> +

I think I understood pretty well, and said it was a matter of taste.

I wish we could move on to more interesting stuff, like the main ehash
table, which currently
uses 2 huge pages, they can all land into one physical socket.

