Return-Path: <netdev+bounces-172313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF3FA542D6
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 07:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5348016BE8D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 06:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B119D090;
	Thu,  6 Mar 2025 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzBWRg34"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A9F1A316C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242939; cv=none; b=J9cgB0uP2QoRA5ZqhhHUB3Xy9uZPVcHGOIVi5LH6AcPsb67shj2rMtx0Eh0ILYWy4Do0Jy48FSI/RDjoe0o4R9w2mYOPuCKBIaNv6hlePS2E4aGL6uz+w8uX3oo3Y+yHL04mte6+WAEgfOHJAc5bMNbJrowTc++YoilOZ4ebFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242939; c=relaxed/simple;
	bh=B1lV5nnwjdReOEiHfta00wKy1bEHJK8pLeCj0VZMdeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bw5gDAQy40oxpILsUB8MAuGC5V9t8E5mc7dtbBP/vc4pjED5wyKAiGAp5sXWcZR+AZSJAELnlVcydYJiyq3IDfxcN7zJQ2Nkts9WkhU3pjX3ydRI6PWaDCbjB/o4vsErS+HMeV2oCE6Ps2BtSTLMasJhgvmFR01+7e78jI7bijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzBWRg34; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d2acdea3acso1021675ab.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 22:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741242937; x=1741847737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kvjXZXuBlW/9na7SM1nS2HCH8NDJ4ifhH5UtNaP4H8=;
        b=HzBWRg34lWSzjkys8l0EdSO4/XmTkBO4ydyusdvGCgpmOuVimlqy+z1gQVjglTFIHm
         dd1jJt/MCTiG7ezXRptW5E7tS1+nZkYz2Gt3qDUOO7y2E5heALy3tYfDC9lZuanQyXDa
         7xKZ0xu/8QwFvyourdxejf4uRC0C4XjiPy6XvnYpzCWOfUJROGHbfwYRC8MFjdXmCh3I
         DKnlRFEJVIVur0OI1kdcVv9GG5OYUrn1ccMzd+L4sEfh3OSUjiyemERLCbCOc7RiCp3R
         /8NZyRfcYRI14h8BNdNYJ3NoNsUu15JgEpMAEXXW7+xK/m0w4qvhXPY7hmkGWdXnTi7l
         IacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741242937; x=1741847737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kvjXZXuBlW/9na7SM1nS2HCH8NDJ4ifhH5UtNaP4H8=;
        b=tqooRTH5N1blQfgU7o7SZ3JWmLoSjV9Y0sUBArHuXZbywRpPnpF1VlRbmaXawxwAB2
         xwhFwz08SkZCBym+2imyttYup0WZXfqZVXcpFw01wUnzfvvdPkM5NNhVXKQI+A3BEkbz
         sfIZHsfHRNwVtbUrI8csz83IeNduh3dauL2y1QERt+M+nyMKts7Lm4Mi8s7nGqwo2gLb
         FII9ioAFPQ1zOJRa4u+N9NAFvGvMZ2NGmz0ZdtuW0a+cWYVgNAcOXGgI9hJ0M1bq0Svz
         tqPot9OQZkk11nVRAoR2RbgFlCdweKwZfz9g9K7MOmbt8mtAY92vf5bDZLKrBksxqfLk
         H7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUid+oiEmZkTik4ydwtsikoHbVfZ+qgWa+5b5qTKORb92pIlFSKy88ZwK6tZ6Xk3oLife7sXDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2VbxeksvaUIFuDuX53okBGsqo9Gbft0xYfJn2E2Wwu9mT6oi
	Q7ctGOKGnvRhGkNbh4suXy9QI6JvbViWWpo10HAvBe9Pz+xj7LtSruDWgy5GFoqIU63+FkLV+hP
	KH6EY32KiQTHm7IAra7dfD9LBJro=
X-Gm-Gg: ASbGncvf8nplvzC50dQZrTLH00wUDK8kT7+/ZBPpgyaWaaQUhRgKmhpQ+SaEaqjBbWp
	e6LZNvyghlS97RhiAMvMLrQ6k/9vArqqSn+E6KbB7MUx6WPtaUnB59OC86OC59oid/iyduXw0jC
	d5wLVKSsiUzfZ0fR5wpkKWdZAASA==
X-Google-Smtp-Source: AGHT+IF4NtHLUSIP22x//OvfGDhjj9BhzWgZy5cyVMx2YBazdzjozSveC8Qair4FDpgtPG0ba4/AwV5GkbC9dfkwNMg=
X-Received: by 2002:a05:6e02:184a:b0:3d3:f520:b7e0 with SMTP id
 e9e14a558f8ab-3d42b8a3bdbmr72186345ab.6.1741242936910; Wed, 05 Mar 2025
 22:35:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDFSSdMXGyUeR+3nqdyVpjsky7y4ZaCB-n1coR_x_Vhfw@mail.gmail.com>
 <20250306062218.85962-1-kuniyu@amazon.com>
In-Reply-To: <20250306062218.85962-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 14:35:00 +0800
X-Gm-Features: AQ5f1JroClO_rOfFTqdcY3FELzurTr_HfcvRr4LgaX_xag5DL0PqFwspZoQM5Jw
Message-ID: <CAL+tcoAEPkyyvzULua_MUNQb=up_8Qqg+w3Oq6B9C1JS9gvdrQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 2:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 6 Mar 2025 12:59:03 +0800
> > On Thu, Mar 6, 2025 at 12:12=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > Date: Thu, 6 Mar 2025 11:35:27 +0800
> > > > On Wed, Mar 5, 2025 at 9:06=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > > >
> > > > > We have platforms with 6 NUMA nodes and 480 cpus.
> > > > >
> > > > > inet_ehash_locks_alloc() currently allocates a single 64KB page
> > > > > to hold all ehash spinlocks. This adds more pressure on a single =
node.
> > > > >
> > > > > Change inet_ehash_locks_alloc() to use vmalloc() to spread
> > > > > the spinlocks on all online nodes, driven by NUMA policies.
> > > > >
> > > > > At boot time, NUMA policy is interleave=3Dall, meaning that
> > > > > tcp_hashinfo.ehash_locks gets hash dispersion on all nodes.
> > > > >
> > > > > Tested:
> > > > >
> > > > > lack5:~# grep inet_ehash_locks_alloc /proc/vmallocinfo
> > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_al=
loc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
> > > > >
> > > > > lack5:~# echo 8192 >/proc/sys/net/ipv4/tcp_child_ehash_entries
> > > > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "grep inet=
_ehash_locks_alloc /proc/vmallocinfo"
> > > > > 0x000000004e99d30c-0x00000000763f3279   36864 inet_ehash_locks_al=
loc+0x90/0x100 pages=3D8 vmalloc N0=3D1 N1=3D2 N2=3D2 N3=3D1 N4=3D1 N5=3D1
> > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_al=
loc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
> > > > >
> > > > > lack5:~# numactl --interleave=3D0,5 unshare -n bash -c "grep inet=
_ehash_locks_alloc /proc/vmallocinfo"
> > > > > 0x00000000fd73a33e-0x0000000004b9a177   36864 inet_ehash_locks_al=
loc+0x90/0x100 pages=3D8 vmalloc N0=3D4 N5=3D4
> > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_al=
loc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
> > > > >
> > > > > lack5:~# echo 1024 >/proc/sys/net/ipv4/tcp_child_ehash_entries
> > > > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "grep inet=
_ehash_locks_alloc /proc/vmallocinfo"
> > > > > 0x00000000db07d7a2-0x00000000ad697d29    8192 inet_ehash_locks_al=
loc+0x90/0x100 pages=3D1 vmalloc N2=3D1
> > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_al=
loc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
> > > > >
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >
> > > > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > >
> > > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > >
> > >
> > > >
> > > > > ---
> > > > >  net/ipv4/inet_hashtables.c | 37 ++++++++++++++++++++++++++------=
-----
> > > > >  1 file changed, 26 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtable=
s.c
> > > > > index 9bfcfd016e18275fb50fea8d77adc8a64fb12494..2b4a588247639e0c7=
b2e70d1fc9b3b9b60256ef7 100644
> > > > > --- a/net/ipv4/inet_hashtables.c
> > > > > +++ b/net/ipv4/inet_hashtables.c
> > > > > @@ -1230,22 +1230,37 @@ int inet_ehash_locks_alloc(struct inet_ha=
shinfo *hashinfo)
> > > > >  {
> > > > >         unsigned int locksz =3D sizeof(spinlock_t);
> > > > >         unsigned int i, nblocks =3D 1;
> > > > > +       spinlock_t *ptr =3D NULL;
> > > > >
> > > > > -       if (locksz !=3D 0) {
> > > > > -               /* allocate 2 cache lines or at least one spinloc=
k per cpu */
> > > > > -               nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1U)=
;
> > > > > -               nblocks =3D roundup_pow_of_two(nblocks * num_poss=
ible_cpus());
> > > > > +       if (locksz =3D=3D 0)
> > > > > +               goto set_mask;
> > > > >
> > > > > -               /* no more locks than number of hash buckets */
> > > > > -               nblocks =3D min(nblocks, hashinfo->ehash_mask + 1=
);
> > > > > +       /* Allocate 2 cache lines or at least one spinlock per cp=
u. */
> > > > > +       nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1U) * num_p=
ossible_cpus();
> > > > >
> > > > > -               hashinfo->ehash_locks =3D kvmalloc_array(nblocks,=
 locksz, GFP_KERNEL);
> > > > > -               if (!hashinfo->ehash_locks)
> > > > > -                       return -ENOMEM;
> > > > > +       /* At least one page per NUMA node. */
> > > > > +       nblocks =3D max(nblocks, num_online_nodes() * PAGE_SIZE /=
 locksz);
> > > > > +
> > > > > +       nblocks =3D roundup_pow_of_two(nblocks);
> > > > > +
> > > > > +       /* No more locks than number of hash buckets. */
> > > > > +       nblocks =3D min(nblocks, hashinfo->ehash_mask + 1);
> > > > >
> > > > > -               for (i =3D 0; i < nblocks; i++)
> > > > > -                       spin_lock_init(&hashinfo->ehash_locks[i])=
;
> > > > > +       if (num_online_nodes() > 1) {
> > > > > +               /* Use vmalloc() to allow NUMA policy to spread p=
ages
> > > > > +                * on all available nodes if desired.
> > > > > +                */
> > > > > +               ptr =3D vmalloc_array(nblocks, locksz);
> > > >
> > > > I wonder if at this point the memory shortage occurs, is it necessa=
ry
> > > > to fall back to kvmalloc() later
> > >
> > > If ptr is NULL here, kvmalloc_array() is called below.
> >
> > My point is why not return with -ENOMEM directly? Or else It looks mean=
ingless.
> >
>
> Ah, I misread.  I'm not sure how likely such a case happens, but I
> think vmalloc() and kmalloc() failure do not always correlate, the
> former uses node_alloc() and the latter use the page allocator.

Sure, it is unlikely to happen.

As to memory allocation, we usually try kmalloc() for less than page
size memory allocation while vmalloc() for larger one. The same logic
can be seen in kvmalloc(): try kmalloc() first, then fall back to
vmalloc(). Since we fail to allocate non-contiguous memory, there is
no need to try kvmalloc() (which will call kmalloc and vmalloc one
more round).

Thanks,
Jason

