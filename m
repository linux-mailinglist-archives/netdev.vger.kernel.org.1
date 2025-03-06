Return-Path: <netdev+bounces-172302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE4A541DB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 05:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A053AD3DA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 04:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1D71993A3;
	Thu,  6 Mar 2025 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAxusT3R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD409D2FF
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 04:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741237182; cv=none; b=Q4jIQXFAPxmygEZr+0quEnzstjVRfBP9OyKQf6xhEJHDqD+fuT9C6C0ctPAfAZQjtSeLs7dtKV67lKJFAE8ADgjz//emhMWhJgb5pWLjSl6qUBxGhdA7PEEgn87uwUBY7vuYpbISQwSL8OdH0upfrrWvjPB+/aRcdSxV0eowMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741237182; c=relaxed/simple;
	bh=En6Rg6CGwOGruWHmfQqBJLV7sHmttfe5HQzmd0VaBUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja8M+nzIz/hgBj7k1pYlAd+6wLDNgy2iIUMlq8SCRjcv22R75zKBVulu7xIUcdk//wcf535tP09r+irjXQHX5SCX/xkMteW3I+NcR6euszzzpPb3Drh7GHudkRCo/592LhVdms9Byj0EEpdX7x9Wzhd7F+PK8zTWgdWvoTPZoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAxusT3R; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso1072895ab.1
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 20:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741237180; x=1741841980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/4rBd/X2k89VFri4Ig2RUQjpylQynKn8wTktuUci5Q=;
        b=NAxusT3RK4Er8rYyQBr6U6l9YtdWPbtFpOg7PkQFj2pz+FpdIcMyDK6RdOshpsN77a
         kN1ZQUk7axC1bcaoWmb02EtJYoKH4W3uEcgGGOG9lnwy8bFyIko1XGEm9YlQlFiuE5hN
         IgRwHgkBZLufhf+vdBaFK2lI33+TSQipjyNTqZM2aYunkc2eVOA0nKIA/BiuXSiRO92Z
         8bvJuGHEMXBM8yofAAe4PBgh3F03dO1PYwmTEv9bw5ZMjEBxocd0zmWg+YSVvanpkKHg
         XUsKQdIDHFRJJy0WNHqRQmrg+kMHn4tD+ZbQjaVm23TzIT9yUlrWIJNnX7TngnTj0zLF
         doKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741237180; x=1741841980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/4rBd/X2k89VFri4Ig2RUQjpylQynKn8wTktuUci5Q=;
        b=wAjIRRl1wArE7KXYTbzSTChIqCWPM+EMHVTfDqaPgH08ndgW7/0w7TpibNp7uddOU7
         ry1yUEBRuaCo2zGqnWA6KBxHvMdyyK6KNsExqFewWUNyFIcOiWMXr5Xom1dc9DBRHkNz
         66VJDlVfLyXJOzBermS6Dmt0LvhzoVs/eKE2xrTfpApj+p38HHmUJQwNRQnNsDo58fSZ
         mfZZMjBRSP7ik50gQPr3U+aj0xS8kKgJCkvCFK/kIlyJsbSv1L9KD7yJ9iNRUOFd0T9e
         MG11F4iDBcCWoCjnkneflAmsAIBXv6XG0pmDEkkuKqIJxS4n2MmDAjm/VRzMarSVrGIS
         aqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTMbLT3jD7LUylR9Y1/8MfVfC9hC7+pyi2j4HjYbob2Yz0jQAtXSFWFX2I8tRlTY9NRMrecmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0pXSC2ay1CF3NSzVn6EhaK+wlcGRqLuHGiiuSRkxybM2aLEx
	3JqUcfPdap1lPwpOjzlM+j4auL0bReZC2HrKZoOV5VUNilgAtlnQc9ghJ8PBx6l24q/zw953W6+
	5r08jPodG/HH1xopmK24uuTCXh/4=
X-Gm-Gg: ASbGnct4OTkiOsuJK99a4AAVW1VUt2FKlN7Rkr7PmOQmShly/GQsjezm+FTOHYZw1v3
	gol1iyQ7EPqhGooW3TztZfVUhtj5XdryuZtopAs/jG2xaNQbBjaf9sF/LBfoIelLV88XaQnnrEH
	s4z+GgfajYsCmA5GN1ZXaBUoD1
X-Google-Smtp-Source: AGHT+IHJBzUv/1ztW2aIkSCVBbOfUagNwCkB5R0EGdjoubEsMiDcoLJOLlVq37R3Oyf6QeChoyaOVpUDsaE4q8XjenU=
X-Received: by 2002:a92:cdaa:0:b0:3d3:deee:de2f with SMTP id
 e9e14a558f8ab-3d42b89cf86mr71322685ab.7.1741237179513; Wed, 05 Mar 2025
 20:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoBvzg=+3i=pGbkP0o3RkH6Yy8-FUTdN4tMMM+BdBUv1oQ@mail.gmail.com>
 <20250306041221.68626-1-kuniyu@amazon.com>
In-Reply-To: <20250306041221.68626-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 12:59:03 +0800
X-Gm-Features: AQ5f1JoVu8xy0s0ymAmPCrrtSwyW_nd5sv3uEmy1Vxw8J3A0odVAnpsBSNAzReA
Message-ID: <CAL+tcoDFSSdMXGyUeR+3nqdyVpjsky7y4ZaCB-n1coR_x_Vhfw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:12=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 6 Mar 2025 11:35:27 +0800
> > On Wed, Mar 5, 2025 at 9:06=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > We have platforms with 6 NUMA nodes and 480 cpus.
> > >
> > > inet_ehash_locks_alloc() currently allocates a single 64KB page
> > > to hold all ehash spinlocks. This adds more pressure on a single node=
.
> > >
> > > Change inet_ehash_locks_alloc() to use vmalloc() to spread
> > > the spinlocks on all online nodes, driven by NUMA policies.
> > >
> > > At boot time, NUMA policy is interleave=3Dall, meaning that
> > > tcp_hashinfo.ehash_locks gets hash dispersion on all nodes.
> > >
> > > Tested:
> > >
> > > lack5:~# grep inet_ehash_locks_alloc /proc/vmallocinfo
> > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+=
0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
> > >
> > > lack5:~# echo 8192 >/proc/sys/net/ipv4/tcp_child_ehash_entries
> > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "grep inet_eha=
sh_locks_alloc /proc/vmallocinfo"
> > > 0x000000004e99d30c-0x00000000763f3279   36864 inet_ehash_locks_alloc+=
0x90/0x100 pages=3D8 vmalloc N0=3D1 N1=3D2 N2=3D2 N3=3D1 N4=3D1 N5=3D1
> > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+=
0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
> > >
> > > lack5:~# numactl --interleave=3D0,5 unshare -n bash -c "grep inet_eha=
sh_locks_alloc /proc/vmallocinfo"
> > > 0x00000000fd73a33e-0x0000000004b9a177   36864 inet_ehash_locks_alloc+=
0x90/0x100 pages=3D8 vmalloc N0=3D4 N5=3D4
> > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+=
0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
> > >
> > > lack5:~# echo 1024 >/proc/sys/net/ipv4/tcp_child_ehash_entries
> > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "grep inet_eha=
sh_locks_alloc /proc/vmallocinfo"
> > > 0x00000000db07d7a2-0x00000000ad697d29    8192 inet_ehash_locks_alloc+=
0x90/0x100 pages=3D1 vmalloc N2=3D1
> > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_alloc+=
0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=3D2
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
>
> >
> > > ---
> > >  net/ipv4/inet_hashtables.c | 37 ++++++++++++++++++++++++++----------=
-
> > >  1 file changed, 26 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > > index 9bfcfd016e18275fb50fea8d77adc8a64fb12494..2b4a588247639e0c7b2e7=
0d1fc9b3b9b60256ef7 100644
> > > --- a/net/ipv4/inet_hashtables.c
> > > +++ b/net/ipv4/inet_hashtables.c
> > > @@ -1230,22 +1230,37 @@ int inet_ehash_locks_alloc(struct inet_hashin=
fo *hashinfo)
> > >  {
> > >         unsigned int locksz =3D sizeof(spinlock_t);
> > >         unsigned int i, nblocks =3D 1;
> > > +       spinlock_t *ptr =3D NULL;
> > >
> > > -       if (locksz !=3D 0) {
> > > -               /* allocate 2 cache lines or at least one spinlock pe=
r cpu */
> > > -               nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1U);
> > > -               nblocks =3D roundup_pow_of_two(nblocks * num_possible=
_cpus());
> > > +       if (locksz =3D=3D 0)
> > > +               goto set_mask;
> > >
> > > -               /* no more locks than number of hash buckets */
> > > -               nblocks =3D min(nblocks, hashinfo->ehash_mask + 1);
> > > +       /* Allocate 2 cache lines or at least one spinlock per cpu. *=
/
> > > +       nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possi=
ble_cpus();
> > >
> > > -               hashinfo->ehash_locks =3D kvmalloc_array(nblocks, loc=
ksz, GFP_KERNEL);
> > > -               if (!hashinfo->ehash_locks)
> > > -                       return -ENOMEM;
> > > +       /* At least one page per NUMA node. */
> > > +       nblocks =3D max(nblocks, num_online_nodes() * PAGE_SIZE / loc=
ksz);
> > > +
> > > +       nblocks =3D roundup_pow_of_two(nblocks);
> > > +
> > > +       /* No more locks than number of hash buckets. */
> > > +       nblocks =3D min(nblocks, hashinfo->ehash_mask + 1);
> > >
> > > -               for (i =3D 0; i < nblocks; i++)
> > > -                       spin_lock_init(&hashinfo->ehash_locks[i]);
> > > +       if (num_online_nodes() > 1) {
> > > +               /* Use vmalloc() to allow NUMA policy to spread pages
> > > +                * on all available nodes if desired.
> > > +                */
> > > +               ptr =3D vmalloc_array(nblocks, locksz);
> >
> > I wonder if at this point the memory shortage occurs, is it necessary
> > to fall back to kvmalloc() later
>
> If ptr is NULL here, kvmalloc_array() is called below.

My point is why not return with -ENOMEM directly? Or else It looks meaningl=
ess.

Thanks,
Jason

>
>
> > even when non-contiguous allocation
> > fails? Could we return with -ENOMEM directly here? If so, I can cook a
> > follow-up patch so that you don't need to revise this version:)
> >
> > Thanks,
> > Jason
> >
> > > +       }
> > > +       if (!ptr) {
> > > +               ptr =3D kvmalloc_array(nblocks, locksz, GFP_KERNEL);
> > > +               if (!ptr)
> > > +                       return -ENOMEM;
> > >         }
> > > +       for (i =3D 0; i < nblocks; i++)
> > > +               spin_lock_init(&ptr[i]);
> > > +       hashinfo->ehash_locks =3D ptr;
> > > +set_mask:
> > >         hashinfo->ehash_locks_mask =3D nblocks - 1;
> > >         return 0;
> > >  }
> > > --
> > > 2.48.1.711.g2feabab25a-goog

