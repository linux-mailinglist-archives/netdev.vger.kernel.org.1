Return-Path: <netdev+bounces-172329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642ACA543A5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5A21894A17
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 07:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B591A76DE;
	Thu,  6 Mar 2025 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bvolEH2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524217C98
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245970; cv=none; b=ThboTZeJNngdp36hj1zrqksLX0FmzXFcCovwdrXH5v1pHXWmQsp4ksKbh3/p9GJWhWjJrTbl6URMU2mXshswzjP5Wufg4n8JZ1DVUpPI4S/Rr7H1vwt8bvvnVq7Mh25OozWsK7MlEa+5VEecNTKQwvD8PyCivC9TdVtLi2gAX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245970; c=relaxed/simple;
	bh=6UXSJghHZkE2Mood6VmBGeZAOZpSPkS5mT4MQz0iFXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+XuWnyoGJLWyEVkw9ilr4aEJkyXGDJW7plZRDwZuAqji8C4vhKgICqCcQRsDb+Xlsj3eITNGFQZJ5OahRbp06GvocyWyFQdS1740ppCliz2fhzne28kZDCSDKyhqtZPqDQFah4Jr0/6K78zj4xnNPkP588XRElO2VAY8WwWzwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bvolEH2; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-474f8d2f21aso3475751cf.1
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 23:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741245967; x=1741850767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvDdcxXKrFz1j794M8wHP6xmw4SDyW5t9pAKNcmZaUA=;
        b=3bvolEH2rHpH8w9SUM+BVU7uWTNSd0bv/+NlCVlV3nhiWFr+ZJpVTmqjNCFufVIOrT
         +EEc1SuKWz/KvT3lNbUTkjVmIeNexrnqKLOAspiemQ8acUR+Dy83a3/Uz82gP2IMl8Ck
         rVvQBMp+vu98l72FuTdmPFJgTPSppbka4xUrCv/mBedvig1gn5N3iQ1pcCNgrXmkrk0r
         T4ssY7yQC1iA3qt1OsvzgLTSrrCaWNF8XqTEv6fi7pBJV6lASVMRGNrbOlJ8Z4AIdLag
         3raVSjoas9xvk4hw2tx4UDe+8dCp+sOkYVU6lLwaI8w0Hs38ajEv925XGvYEQ8ukLIS7
         RdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741245967; x=1741850767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvDdcxXKrFz1j794M8wHP6xmw4SDyW5t9pAKNcmZaUA=;
        b=wGgvk6itxR4xSwSylYaf5vwA35ctMsM6JU4A2uofjHz7k1XXRyzkLTwDj9rZAVGeGh
         REOBs62DjXb1poYKhgagVF4p5Xfm3E1mHl8tOklIn5KplQHGxG/i0Ry7W7lAh+GulZAH
         MCPYBJ5n+0AX0n8hh0z0kxn9lwzU+/bballEFjlfZJ7HIUGPt2GHL4Zkqx3eYtPUagNX
         IhiCEhBeBx+UNrR7PpNDrxUnruobXeRUAqqgHiD4zni3tKinfuWEm4IPnGKZ+BE9VKza
         L6M97YH7QVnm4n+PKWT/YqBrnax+ZCxIEI7eP8GLXIVvqdQbz6VlIHy9hk2sd4b6nB6v
         DR6w==
X-Forwarded-Encrypted: i=1; AJvYcCUs7RrzpZbuoEeZkwL3dq2A02VM7JLG5nXP568TQaINr/UnqKQJhCjy7AIg6PYL3rLqY7xO49Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlebgaBUcGh6OX3TK/tHjooZDkYU8fy/HiDwOUkhrTrikhvxsJ
	QGtmqrc7lPnyNkPaA/GHqLAZgLF1fn06WUufkwayIr6pEMXtxBVtaWdn1MCvpEkmTlp3cc1JfFB
	tDX4xcTAXFeT2hk4rGODReBFJSyFEM+kT5CMl
X-Gm-Gg: ASbGncvSeV3tjpTz1wGEogmlPJdh7FRqVfDtCTPvAiZzHoEEAjXJT0SfniBl5fTmXJw
	ZDjGZHon+hO3a78JxHcGHpRBJ2d6bp2vXyZQwelEe8nZ3t+PvB98PBnroGfz98+nCrP4d97jap8
	rtEEqpN4Ubnlxun96MHiKQAtzcfw==
X-Google-Smtp-Source: AGHT+IGCzGffZO0ilrEMYCJhnFWutX+ApMUqjo2tb9Y4t24hIAq21u3xa5TlLKpLgjX2u8QvpPIe8gJF7areMzxYbE0=
X-Received: by 2002:a05:622a:1a97:b0:471:fc73:b656 with SMTP id
 d75a77b69052e-4751a5632b7mr32430111cf.12.1741245967399; Wed, 05 Mar 2025
 23:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDFSSdMXGyUeR+3nqdyVpjsky7y4ZaCB-n1coR_x_Vhfw@mail.gmail.com>
 <20250306062218.85962-1-kuniyu@amazon.com> <CAL+tcoAEPkyyvzULua_MUNQb=up_8Qqg+w3Oq6B9C1JS9gvdrQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAEPkyyvzULua_MUNQb=up_8Qqg+w3Oq6B9C1JS9gvdrQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 08:25:56 +0100
X-Gm-Features: AQ5f1JqA_t9R3xwmuBRD0BdNqqe98uIbeDRXsXfeWUgMNR4hAPhFuXTrCj-sFKI
Message-ID: <CANn89iL_sT7a+49HNDLjsP5qnREPKpx6yEu8USMZPxW1vP+skg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, eric.dumazet@gmail.com, 
	horms@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 7:35=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Mar 6, 2025 at 2:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
> >
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Date: Thu, 6 Mar 2025 12:59:03 +0800
> > > On Thu, Mar 6, 2025 at 12:12=E2=80=AFPM Kuniyuki Iwashima <kuniyu@ama=
zon.com> wrote:
> > > >
> > > > From: Jason Xing <kerneljasonxing@gmail.com>
> > > > Date: Thu, 6 Mar 2025 11:35:27 +0800
> > > > > On Wed, Mar 5, 2025 at 9:06=E2=80=AFPM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > > >
> > > > > > We have platforms with 6 NUMA nodes and 480 cpus.
> > > > > >
> > > > > > inet_ehash_locks_alloc() currently allocates a single 64KB page
> > > > > > to hold all ehash spinlocks. This adds more pressure on a singl=
e node.
> > > > > >
> > > > > > Change inet_ehash_locks_alloc() to use vmalloc() to spread
> > > > > > the spinlocks on all online nodes, driven by NUMA policies.
> > > > > >
> > > > > > At boot time, NUMA policy is interleave=3Dall, meaning that
> > > > > > tcp_hashinfo.ehash_locks gets hash dispersion on all nodes.
> > > > > >
> > > > > > Tested:
> > > > > >
> > > > > > lack5:~# grep inet_ehash_locks_alloc /proc/vmallocinfo
> > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_=
alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=
=3D2
> > > > > >
> > > > > > lack5:~# echo 8192 >/proc/sys/net/ipv4/tcp_child_ehash_entries
> > > > > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "grep in=
et_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > 0x000000004e99d30c-0x00000000763f3279   36864 inet_ehash_locks_=
alloc+0x90/0x100 pages=3D8 vmalloc N0=3D1 N1=3D2 N2=3D2 N3=3D1 N4=3D1 N5=3D=
1
> > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_=
alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=
=3D2
> > > > > >
> > > > > > lack5:~# numactl --interleave=3D0,5 unshare -n bash -c "grep in=
et_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > 0x00000000fd73a33e-0x0000000004b9a177   36864 inet_ehash_locks_=
alloc+0x90/0x100 pages=3D8 vmalloc N0=3D4 N5=3D4
> > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_=
alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=
=3D2
> > > > > >
> > > > > > lack5:~# echo 1024 >/proc/sys/net/ipv4/tcp_child_ehash_entries
> > > > > > lack5:~# numactl --interleave=3Dall unshare -n bash -c "grep in=
et_ehash_locks_alloc /proc/vmallocinfo"
> > > > > > 0x00000000db07d7a2-0x00000000ad697d29    8192 inet_ehash_locks_=
alloc+0x90/0x100 pages=3D1 vmalloc N2=3D1
> > > > > > 0x00000000d9aec4d1-0x00000000a828b652   69632 inet_ehash_locks_=
alloc+0x90/0x100 pages=3D16 vmalloc N0=3D2 N1=3D3 N2=3D3 N3=3D3 N4=3D3 N5=
=3D2
> > > > > >
> > > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > >
> > > > > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > > >
> > > > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > >
> > > >
> > > > >
> > > > > > ---
> > > > > >  net/ipv4/inet_hashtables.c | 37 ++++++++++++++++++++++++++----=
-------
> > > > > >  1 file changed, 26 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtab=
les.c
> > > > > > index 9bfcfd016e18275fb50fea8d77adc8a64fb12494..2b4a588247639e0=
c7b2e70d1fc9b3b9b60256ef7 100644
> > > > > > --- a/net/ipv4/inet_hashtables.c
> > > > > > +++ b/net/ipv4/inet_hashtables.c
> > > > > > @@ -1230,22 +1230,37 @@ int inet_ehash_locks_alloc(struct inet_=
hashinfo *hashinfo)
> > > > > >  {
> > > > > >         unsigned int locksz =3D sizeof(spinlock_t);
> > > > > >         unsigned int i, nblocks =3D 1;
> > > > > > +       spinlock_t *ptr =3D NULL;
> > > > > >
> > > > > > -       if (locksz !=3D 0) {
> > > > > > -               /* allocate 2 cache lines or at least one spinl=
ock per cpu */
> > > > > > -               nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1=
U);
> > > > > > -               nblocks =3D roundup_pow_of_two(nblocks * num_po=
ssible_cpus());
> > > > > > +       if (locksz =3D=3D 0)
> > > > > > +               goto set_mask;
> > > > > >
> > > > > > -               /* no more locks than number of hash buckets */
> > > > > > -               nblocks =3D min(nblocks, hashinfo->ehash_mask +=
 1);
> > > > > > +       /* Allocate 2 cache lines or at least one spinlock per =
cpu. */
> > > > > > +       nblocks =3D max(2U * L1_CACHE_BYTES / locksz, 1U) * num=
_possible_cpus();
> > > > > >
> > > > > > -               hashinfo->ehash_locks =3D kvmalloc_array(nblock=
s, locksz, GFP_KERNEL);
> > > > > > -               if (!hashinfo->ehash_locks)
> > > > > > -                       return -ENOMEM;
> > > > > > +       /* At least one page per NUMA node. */
> > > > > > +       nblocks =3D max(nblocks, num_online_nodes() * PAGE_SIZE=
 / locksz);
> > > > > > +
> > > > > > +       nblocks =3D roundup_pow_of_two(nblocks);
> > > > > > +
> > > > > > +       /* No more locks than number of hash buckets. */
> > > > > > +       nblocks =3D min(nblocks, hashinfo->ehash_mask + 1);
> > > > > >
> > > > > > -               for (i =3D 0; i < nblocks; i++)
> > > > > > -                       spin_lock_init(&hashinfo->ehash_locks[i=
]);
> > > > > > +       if (num_online_nodes() > 1) {
> > > > > > +               /* Use vmalloc() to allow NUMA policy to spread=
 pages
> > > > > > +                * on all available nodes if desired.
> > > > > > +                */
> > > > > > +               ptr =3D vmalloc_array(nblocks, locksz);
> > > > >
> > > > > I wonder if at this point the memory shortage occurs, is it neces=
sary
> > > > > to fall back to kvmalloc() later
> > > >
> > > > If ptr is NULL here, kvmalloc_array() is called below.
> > >
> > > My point is why not return with -ENOMEM directly? Or else It looks me=
aningless.
> > >
> >
> > Ah, I misread.  I'm not sure how likely such a case happens, but I
> > think vmalloc() and kmalloc() failure do not always correlate, the
> > former uses node_alloc() and the latter use the page allocator.
>
> Sure, it is unlikely to happen.
>
> As to memory allocation, we usually try kmalloc() for less than page
> size memory allocation while vmalloc() for larger one. The same logic
> can be seen in kvmalloc(): try kmalloc() first, then fall back to
> vmalloc(). Since we fail to allocate non-contiguous memory, there is
> no need to try kvmalloc() (which will call kmalloc and vmalloc one
> more round).

I chose to not add code, because:

       if (num_online_nodes() > 1) {
               /* Use vmalloc() to allow NUMA policy to spread pages
                * on all available nodes if desired.
                */
               ptr =3D vmalloc_array(nblocks, locksz);

<< adding here a test is pointless, we already have correct code if
ptr =3D=3D NULLL >>

       }
       if (!ptr) {
               ptr =3D kvmalloc_array(nblocks, locksz, GFP_KERNEL);
               if (!ptr)
                       return -ENOMEM;
        }


Sure, this could be written in a different way, but ultimately it is a
matter of taste.

