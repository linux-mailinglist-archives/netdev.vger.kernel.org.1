Return-Path: <netdev+bounces-172337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939DA54423
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78613AE90D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC651FBC9F;
	Thu,  6 Mar 2025 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz+G6t6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93B1F8BD6
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248254; cv=none; b=Qd1Lwpic1e1z/hqAHrHZ8a6YYUuZiejQRuQRVd/AH/2aHjq6dm1hCb9ioT+iXC5P/FJ8sPFWy+boI2DDjO7lFHYUbsLkJt5i3YGzRs40gDB0Ha+YbGyRH8K4B1xndd5VG8FV/E5RUZcjNNDQ3xUCvcQPaL8EmK3iL1+I6dreO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248254; c=relaxed/simple;
	bh=m2xqvtA8wuVTjbbihdbE7B3lD7dPnEgCpk/FmPcG7KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqHR7pahPwSUk4HKLBcXFvuSrgWWUl6xZVzWe+lh6M+srZmzHzMkhCwDJUr/sbVa1bJj3APaodQRX8fDuGQw4Lay5gGnd9moPrOzdxyMXE+4jYuediZqYDi/C/ETSVlXM46PU6pdaK4gM+Kafy02M/GbNHrIZ3a47wzpbd4ZzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz+G6t6g; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce868498d3so1205565ab.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 00:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741248252; x=1741853052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBM15w5m4MRbYG9kBYKoEqOtfhQE0UDg6LnRhSweRC0=;
        b=Gz+G6t6g5nK8i0zlhxNZ80MCm/U5quXDBKtVk1G9AfRlZe8V+bZsX2Mb6GJsUIJBFF
         UUhYAgwE2VXxzyDe6urGEBNEw8u9Ygs9FvjMOQWIYYAgT9KYdW7RjVjNzNZd2lspEILR
         ArhTcbl6uIZkU4R9iGovQl9wUS84p1fk4G4aN0gyfaXrQskzyOiOmauxUkOZpJ/ICq16
         r0fmU4y1iYgHcaw5mFwwE//sY9dfede+vMHhc/BpCllG40Ar1MUduxt8REHIqLoBKaEl
         nqlUrKE3OkJTulWLJDUtWPgw48cZlZrF1QBY0iAODoeDDdaumOPRbMAKDb4JV4BWmcr5
         h/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741248252; x=1741853052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBM15w5m4MRbYG9kBYKoEqOtfhQE0UDg6LnRhSweRC0=;
        b=UkH5DSonKViGuOu2hTpc5yhivuswZXesEAHSsbfYcYVhh88ST9LVa1u5qooY3V0a2i
         If4b89HVWnli71fNGusdt5RfA8ZqyUksGe2mvPysNsbwbWuqr+GHFa3+ydURaD2yq6Ap
         0qnKcG8L7l69JTEp0bkYmxTyucAujtBTghCItMPao8tuiXDhPOkiXUsf9k2+jZ4GVnT+
         HiWGScDS4iV1q0q8I1s3HHHWK3HPfdyJ7v0jx7Y/AQREf2vjnfpCJ7h87QxtRNcU9ots
         dy7zQ7uUsyYftpWLur9tvOLE6K0pRai3W7q0uYQ2jfuh5sdpALIlz5tYcujbVBkrcdSG
         dZhA==
X-Forwarded-Encrypted: i=1; AJvYcCW5VzHpe/BJ5H6E7W3SsfqWpkncA8NyzB9rdI5XSBmjBXO+ylTrQEDeNz75zPeWePmCmSMpAYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgnvWuYBzyEBPvZV/ecGTZprgnKxlJe6J5PixfmXlWLwnyrI0z
	trwpWt4ymtbmRpaQpeCXsyLbkULcek1Qkhzj4PDjpX58L0qOsHgQ6Iad2dXL9Fhuo/5BSbnwAkx
	/1mn9XtOwvoZugTWa4VyehDVl0gA=
X-Gm-Gg: ASbGncsz9Dd4rmOpR8lvWAPwvnx35qtFjQP1KTl0JIC2/GacXIb51yW+ODPHm6a4U8A
	sPjbzjUvyxgBbaOyBiNFj2xLboWdebHyCBAuX27QafWOtFa6IP8X+RpMBIke6YgYhRYT1ggT38d
	Ha/yQkD0CYmqmJoArZao8eZdQwMQ==
X-Google-Smtp-Source: AGHT+IEGhihG+wrM11wGwAgX+z7XTCGMteAItphOUcclK0J1+fHb/GhgqUisELsn6GIKvBdcvnPbtl32Yc+PmnmkI3g=
X-Received: by 2002:a05:6e02:18ca:b0:3d3:e11a:39d with SMTP id
 e9e14a558f8ab-3d42b8d397amr55808315ab.13.1741248251615; Thu, 06 Mar 2025
 00:04:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDFSSdMXGyUeR+3nqdyVpjsky7y4ZaCB-n1coR_x_Vhfw@mail.gmail.com>
 <20250306062218.85962-1-kuniyu@amazon.com> <CAL+tcoAEPkyyvzULua_MUNQb=up_8Qqg+w3Oq6B9C1JS9gvdrQ@mail.gmail.com>
 <CANn89iL_sT7a+49HNDLjsP5qnREPKpx6yEu8USMZPxW1vP+skg@mail.gmail.com>
In-Reply-To: <CANn89iL_sT7a+49HNDLjsP5qnREPKpx6yEu8USMZPxW1vP+skg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 16:03:35 +0800
X-Gm-Features: AQ5f1JqDjmmbflvPe26W39MOFhZ9WmPV4bU3bhkFbSX8y77T6GNNdDbYEqGXWPc
Message-ID: <CAL+tcoBpUxfMo6Assb6gU9JaJctS4Gt7G889GNmJsRFQeaxHJA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, eric.dumazet@gmail.com, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 3:26=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Mar 6, 2025 at 7:35=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Thu, Mar 6, 2025 at 2:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Thu, 6 Mar 2025 12:59:03 +0800
> > > > On Thu, Mar 6, 2025 at 12:12=E2=80=AFPM Kuniyuki Iwashima <kuniyu@a=
mazon.com> wrote:
> > > > >
> > > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > > Date: Thu, 6 Mar 2025 11:35:27 +0800
> > > > > > On Wed, Mar 5, 2025 at 9:06=E2=80=AFPM Eric Dumazet <edumazet@g=
oogle.com> wrote:
> > > > > > >
> > > > > > > We have platforms with 6 NUMA nodes and 480 cpus.
> > > > > > >
> > > > > > > inet_ehash_locks_alloc() currently allocates a single 64KB pa=
ge
> > > > > > > to hold all ehash spinlocks. This adds more pressure on a sin=
gle node.
> > > > > > >
> > > > > > > Change inet_ehash_locks_alloc() to use vmalloc() to spread
> > > > > > > the spinlocks on all online nodes, driven by NUMA policies.
> > > > > > >
> > > > > > > At boot time, NUMA policy is interleave=3Dall, meaning that
> > > > > > > tcp_hashinfo.ehash_locks gets hash dispersion on all nodes.
> > > > > > >
> > > > > > > Tested:
> > > > > > >
> > > > > > > lack5:~# grep inet_ehash_locks_alloc /proc/vmallocinfo
> > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_lock=
s_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=
=3D2
> > > > > > >
> > > > > > > lack5:~# echo 8192 >/proc/sys/net/ipv4/tcp_child_ehash_entrie=
s
> > > > > > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "grep =
inet_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > > 0x000000004e99d30c-0x00000000763f3279   36864 inet_ehash_lock=
s_alloc+0x90/0x100 pages=3D8 vmalloc N0=3D1 N1=3D2 N2=3D2 N3=3D1 N4=3D1 N5=
=3D1
> > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_lock=
s_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=
=3D2
> > > > > > >
> > > > > > > lack5:~# numactl --interleave=3D0,5 unshare -n bash -c "grep =
inet_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > > 0x00000000fd73a33e-0x0000000004b9a177   36864 inet_ehash_lock=
s_alloc+0x90/0x100 pages=3D8 vmalloc N0=3D4 N5=3D4
> > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_lock=
s_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=
=3D2
> > > > > > >
> > > > > > > lack5:~# echo 1024 >/proc/sys/net/ipv4/tcp_child_ehash_entrie=
s
> > > > > > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "grep =
inet_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > > 0x00000000db07d7a2-0x00000000ad697d29    8192 inet_ehash_lock=
s_alloc+0x90/0x100 pages=3D1 vmalloc N2=3D1
> > > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_lock=
s_alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=
=3D2
> > > > > > >
> > > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > >
> > > > > > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > >
> > > > > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > >
> > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  net/ipv4/inet_hashtables.c | 37 ++++++++++++++++++++++++++--=
---------
> > > > > > >  1 file changed, 26 insertions(+), 11 deletions(-)
> > > > > > >
> > > > > > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hasht=
ables.c
> > > > > > > index 9bfcfd016e18275fb50fea8d77adc8a64fb12494..2b4a588247639=
e0c7b2e70d1fc9b3b9b60256ef7 100644
> > > > > > > --- a/net/ipv4/inet_hashtables.c
> > > > > > > +++ b/net/ipv4/inet_hashtables.c
> > > > > > > @@ -1230,22 +1230,37 @@ int inet_ehash_locks_alloc(struct ine=
t_hashinfo *hashinfo)
> > > > > > >  {
> > > > > > >         unsigned int locksz =3D sizeof(spinlock_t);
> > > > > > >         unsigned int i, nblocks =3D 1;
> > > > > > > +       spinlock_t *ptr =3D NULL;
> > > > > > >
> > > > > > > -       if (locksz !=3D 0) {
> > > > > > > -               /* allocate 2 cache lines or at least one spi=
nlock per cpu */
> > > > > > > -               nblocks =3D max(2U * L1_CACHE_BYTES / locksz,=
 1U);
> > > > > > > -               nblocks =3D roundup_pow_of_two(nblocks * num_=
possible_cpus());
> > > > > > > +       if (locksz =3D=3D 0)
> > > > > > > +               goto set_mask;
> > > > > > >
> > > > > > > -               /* no more locks than number of hash buckets =
*/
> > > > > > > -               nblocks =3D min(nblocks, hashinfo->ehash_mask=
 + 1);
> > > > > > > +       /* Allocate 2 cache lines or at least one spinlock pe=
r cpu. */
> > > > > > > +       nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1U) * n=
um_possible_cpus();
> > > > > > >
> > > > > > > -               hashinfo->ehash_locks =3D kvmalloc_array(nblo=
cks, locksz, GFP_KERNEL);
> > > > > > > -               if (!hashinfo->ehash_locks)
> > > > > > > -                       return -ENOMEM;
> > > > > > > +       /* At least one page per NUMA node. */
> > > > > > > +       nblocks =3D max(nblocks, num_online_nodes() * PAGE_SI=
ZE / locksz);
> > > > > > > +
> > > > > > > +       nblocks =3D roundup_pow_of_two(nblocks);
> > > > > > > +
> > > > > > > +       /* No more locks than number of hash buckets. */
> > > > > > > +       nblocks =3D min(nblocks, hashinfo->ehash_mask + 1);
> > > > > > >
> > > > > > > -               for (i =3D 0; i < nblocks; i++)
> > > > > > > -                       spin_lock_init(&hashinfo->ehash_locks=
[i]);
> > > > > > > +       if (num_online_nodes() > 1) {
> > > > > > > +               /* Use vmalloc() to allow NUMA policy to spre=
ad pages
> > > > > > > +                * on all available nodes if desired.
> > > > > > > +                */
> > > > > > > +               ptr =3D vmalloc_array(nblocks, locksz);
> > > > > >
> > > > > > I wonder if at this point the memory shortage occurs, is it nec=
essary
> > > > > > to fall back to kvmalloc() later
> > > > >
> > > > > If ptr is NULL here, kvmalloc_array() is called below.
> > > >
> > > > My point is why not return with -ENOMEM directly? Or else It looks =
meaningless.
> > > >
> > >
> > > Ah, I misread.  I'm not sure how likely such a case happens, but I
> > > think vmalloc() and kmalloc() failure do not always correlate, the
> > > former uses node_alloc() and the latter use the page allocator.
> >
> > Sure, it is unlikely to happen.
> >
> > As to memory allocation, we usually try kmalloc() for less than page
> > size memory allocation while vmalloc() for larger one. The same logic
> > can be seen in kvmalloc(): try kmalloc() first, then fall back to
> > vmalloc(). Since we fail to allocate non-contiguous memory, there is
> > no need to try kvmalloc() (which will call kmalloc and vmalloc one
> > more round).
>
> I chose to not add code, because:
>
>        if (num_online_nodes() > 1) {
>                /* Use vmalloc() to allow NUMA policy to spread pages
>                 * on all available nodes if desired.
>                 */
>                ptr =3D vmalloc_array(nblocks, locksz);
>
> << adding here a test is pointless, we already have correct code if
> ptr =3D=3D NULLL >>
>
>        }
>        if (!ptr) {
>                ptr =3D kvmalloc_array(nblocks, locksz, GFP_KERNEL);
>                if (!ptr)
>                        return -ENOMEM;
>         }
>
>
> Sure, this could be written in a different way, but ultimately it is a
> matter of taste.

Sorry that I didn't make myself clear enough. I mean if
vmalloc_array() fails, then it will fall back to kvmalloc_array()
which will call kmalloc() or even vmalloc() to allocate memory again.
My intention is to return with an error code when the first time
allocation fails.

Code like this on top of your patch:
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 3edbe2dad8ba..d026918319d2 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1282,12 +1282,12 @@ int inet_ehash_locks_alloc(struct
inet_hashinfo *hashinfo)
                 * on all available nodes if desired.
                 */
                ptr =3D vmalloc_array(nblocks, locksz);
-       }
-       if (!ptr) {
+       } else {
                ptr =3D kvmalloc_array(nblocks, locksz, GFP_KERNEL);
-               if (!ptr)
-                       return -ENOMEM;
        }
+       if (!ptr)
+               return -ENOMEM;
+
        for (i =3D 0; i < nblocks; i++)
                spin_lock_init(&ptr[i]);
        hashinfo->ehash_locks =3D ptr;

Sure, it's not a big deal at all. Just try more rounds to allocate memory..=
.

Thanks,
jason

