Return-Path: <netdev+bounces-193489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F401AC438B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 19:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAFB1893FEC
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573923E34C;
	Mon, 26 May 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGqDu9wk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692B7E9
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748281902; cv=none; b=QdH9dGSmXEjQMWHLiSZ3aLthp/adiOc7EGqxs4IgmmzLhWXrYWaYCLfp2Wq7uWcohD46Ih4iIu/Yx1uclHplcgxWKXPMzxqKSYIO246BVHY1xValTDewBqQyofjfSsN1KntDjJMOHQrvssx5buK9y6Od94UhtP341Jkt1iWkmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748281902; c=relaxed/simple;
	bh=6DLePd+PP4uNkX6tcilWPj79dtNl6QyGIaJcJPJoclE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFWR40bbbB+1wQQWQq3c3AFU8GcDIXQWzyJEEbVbh0jAA5z46AkjSg7u1Lk6Rp4GVtOU2pfYsmwDEK6untdN79aHW0BBiqUpHSdjHc3g99QSu6Z5I4E7XOMTUv7+eTNR8jxYxfTL4H0pKFYNMAiCklJ1paI/HlG1RE4gmkDZsbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGqDu9wk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2349068ebc7so47265ad.0
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748281900; x=1748886700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6FocSUFbWGC4UbXQHwbO+J5QjuVS7G5DVoCQNhcZX0=;
        b=oGqDu9wkAtk+TewpQCWTjaFxjm1zA1DET98QseuB4hWRC9vXzbLyrj761leVANLT2E
         GKbznCeM1//F49R2igdgo7akvmNS5bNhzhlGIYMnRQCXZDc/l1Yj+FzavZZXAWexoMpr
         gZRofDeePHx5OL3UVDTINUhsA/hVsMr3d0YSW9n9LnbIhsJAh4WxNaFFvsMloQUAmM71
         ocDl0DVY6AqasIC3+UXCpTnRe4mmYSpWoj9FkPYCarikVFXrXQdGWdgDUZ+LEdbvVsXd
         d/Fs4DuJCUnPP1I7XpQqd8hcEYU+fbQz8DwLhshh7YDwHwOhyw9vNBrCFC/t+rCn/FoV
         MM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748281900; x=1748886700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6FocSUFbWGC4UbXQHwbO+J5QjuVS7G5DVoCQNhcZX0=;
        b=TM6OFF0LG/s2/tEgie8cWwUMET/t2kzEGp/0AHtl6347usrMpLA15CM6pyvOyLWjxB
         zwhRqGhS4kBT4ewS/Rh8jKnTzPaF2+9drBhib60M5aNvW4c9lX68kENovTtohpB+PWG9
         R9l3/tbn7aqo4sOf+ty7OgBviLaB2+6jSExg81BNQWgibyO6WIkthi9/ZbOQ8zef/hpk
         BKPtCRIs7P+U1X0MqGZBHm71e+ZQFVWFoDeGvWWRhYxODVA5HK4wnV9GMolpmD4WQ6PR
         sC6yCGv3CjWL3lXZFWLAdQgVMG8weyXm+YsnkvhrGeVlIwtrPPqnOrvENLBO4KuHvsFk
         URZw==
X-Forwarded-Encrypted: i=1; AJvYcCWH41mZ/DCix8RKj1D/toSqJ9ytOPwFy67DZ7+Ca9tTFDQjqvLNWg7+vN1tTkGIL3jxIyq6r8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YygLra77uxAuj/yI0JZdDPQiiKfBRXXCBkuHJefCMLRXExNcYgq
	P4uqDG31UmuFRgs1NOsfIU9HOGWMOeqA8iXYtFTv2RQDXhjfWkT87p4Q6/n1mJgJfJ9KClFaOPa
	RgN5aS1uWI5Z6Thj+3VBMPcWb5MuAmf24edYYnBNF
X-Gm-Gg: ASbGncu7NUKN53hTndf6gNrlSxOmZmfZAc61JIEIfV4r+aU7neKOSPkEuODuQ2ROT6z
	JabBoem5ykw2R08gxmbJMJZjNSzzPU1cEka6wz1PYCrulckEFjJ1a9MHlrOUJU1zHEEta6AsCCp
	+T+PCRGtiM30ko1w6Ur9ke3Z5QRL9Dt6C9vta3QCkUxqdS
X-Google-Smtp-Source: AGHT+IHxw5kFD97qu6/S6TmfiDU0cDQb33odUZGDT5ciTtFyA8/W5y/Ppc1tRpCaVQHp6ijmqTOE4Cz6czANaXkuDQw=
X-Received: by 2002:a17:903:46ce:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-2341807dceamr4601285ad.8.1748281899944; Mon, 26 May 2025
 10:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523064524.3035067-1-dongchenchen2@huawei.com>
 <a5cc7765-0de2-47ca-99c4-a48aaf6384d2@huawei.com> <CAHS8izP=AuPbV6N=c05J2kJLJ16-AmRzu983khXaR91Pti=cNw@mail.gmail.com>
 <5305c0d1-c7eb-4c79-96ae-67375f6248f1@huawei.com>
In-Reply-To: <5305c0d1-c7eb-4c79-96ae-67375f6248f1@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 26 May 2025 10:51:26 -0700
X-Gm-Features: AX0GCFvICH5Qjo3M4gJa_hQ9VbxiimhOklMmvepPin5U8PBr-TSru9AVogsH9hc
Message-ID: <CAHS8izPY9BYWzAVR9LNdSP4+-0TsgOoMXvD658i22VFWHZfvfA@mail.gmail.com>
Subject: Re: [PATCH net] page_pool: Fix use-after-free in page_pool_recycle_in_ring
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangchangzhong@huawei.com, 
	syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

)

On Mon, May 26, 2025 at 7:47=E2=80=AFAM dongchenchen (A)
<dongchenchen2@huawei.com> wrote:
>
>
> > On Fri, May 23, 2025 at 1:31=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >> On 2025/5/23 14:45, Dong Chenchen wrote:
> >>
> >>>   static bool page_pool_recycle_in_ring(struct page_pool *pool, netme=
m_ref netmem)
> >>>   {
> >>> +     bool in_softirq;
> >>>        int ret;
> >> int -> bool?
> >>
> >>>        /* BH protection not needed if current is softirq */
> >>> -     if (in_softirq())
> >>> -             ret =3D ptr_ring_produce(&pool->ring, (__force void *)n=
etmem);
> >>> -     else
> >>> -             ret =3D ptr_ring_produce_bh(&pool->ring, (__force void =
*)netmem);
> >>> -
> >>> -     if (!ret) {
> >>> +     in_softirq =3D page_pool_producer_lock(pool);
> >>> +     ret =3D !__ptr_ring_produce(&pool->ring, (__force void *)netmem=
);
> >>> +     if (ret)
> >>>                recycle_stat_inc(pool, ring);
> >>> -             return true;
> >>> -     }
> >>> +     page_pool_producer_unlock(pool, in_softirq);
> >>>
> >>> -     return false;
> >>> +     return ret;
> >>>   }
> >>>
> >>>   /* Only allow direct recycling in special circumstances, into the
> >>> @@ -1091,10 +1088,14 @@ static void page_pool_scrub(struct page_pool =
*pool)
> >>>
> >>>   static int page_pool_release(struct page_pool *pool)
> >>>   {
> >>> +     bool in_softirq;
> >>>        int inflight;
> >>>
> >>>        page_pool_scrub(pool);
> >>>        inflight =3D page_pool_inflight(pool, true);
> >>> +     /* Acquire producer lock to make sure producers have exited. */
> >>> +     in_softirq =3D page_pool_producer_lock(pool);
> >>> +     page_pool_producer_unlock(pool, in_softirq);
> >> Is a compiler barrier needed to ensure compiler doesn't optimize away
> >> the above code?
> >>
> > I don't want to derail this conversation too much, and I suggested a
> > similar fix to this initially, but now I'm not sure I understand why
> > it works.
> >
> > Why is the existing barrier not working and acquiring/releasing the
> > producer lock fixes this issue instead? The existing barrier is the
> > producer thread incrementing pool->pages_state_release_cnt, and
> > page_pool_release() is supposed to block the freeing of the page_pool
> > until it sees the
> > `atomic_inc_return_relaxed(&pool->pages_state_release_cnt);` from the
> > producer thread. Any idea why this barrier is not working? AFAIU it
> > should do the exact same thing as acquiring/dropping the producer
> > lock.
>
> Hi, Mina
> As previously mentioned:
> page_pool_recycle_in_ring
>    ptr_ring_produce
>      spin_lock(&r->producer_lock);
>      WRITE_ONCE(r->queue[r->producer++], ptr)
>        //recycle last page to pool, producer + release_cnt =3D hold_cnt

This is not right. release_cnt !=3D hold_cnt at this point.

Release_cnt is only incremented by the producer _after_ the
spin_unlock and the recycle_stat_inc have been done. The full call
stack on the producer thread:

page_pool_put_unrefed_netmem
    page_pool_recycle_in_ring
        ptr_ring_produce(&pool->ring, (__force void *)netmem);
             spin_lock(&r->producer_lock);
             __ptr_ring_produce(r, ptr);
             spin_unlock(&r->producer_lock);
        recycle_stat_inc(pool, ring);
    recycle_stat_inc(pool, ring_full);
    page_pool_return_page
        atomic_inc_return_relaxed(&pool->pages_state_release_cnt);

The atomic_inc_return_relaxed happens after all the lines that could
cause UAF are already executed. Is it because we're using the _relaxed
version of the atomic operation, that the compiler can reorder it to
happen before the spin_unlock(&r->producer_lock) and before the
recycle_stat_inc...?

--=20
Thanks,
Mina

