Return-Path: <netdev+bounces-161162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04531A1DB5B
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA03A5596
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657881632EF;
	Mon, 27 Jan 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="A22l7C2w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A6291E
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999306; cv=none; b=A6Ny+Lx1U2SNMoKAk9ZuQs7egNngrcbtG7h3MjDuZm9Zmm3Wsu8n8Jxp1H3t19VtiQVgvT64DNLdT+ISKnXqj3+/zglAqQVD3fQnIogawBLOuih1V0DyVYS/wmFXtOooFgbApBL+b3krokPB2C0ynk5LpCM6klJhWaJaVgzNx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999306; c=relaxed/simple;
	bh=961HqXJwNVJZKPlt3cYKp7pfF3d8iqk8XxQqkImZ/sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHnyfJYHaB8A3pkWXFCyLPHsZdEsYxF6zE305YLRqKoTb9wiQBLmv9Xw+aOnVE2DX/6B/5Ph9wFvjkbuJYzXrfRmYoJD2dPNASo9Z/DlmXKEQQd11Ni2NnAHDImxLBiwUxieHoC/euXq4L5VW4F3HuHNNZ1RG7pBW9Bp5MBh/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=A22l7C2w; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sud94Ik0kSncgZa2W1KW8YLnXwJRzpqdIvSdf8ZhQG4=; t=1737999304; x=1738863304; 
	b=A22l7C2w8qwPXpDZ8iE80AmMbgm5W09IP4jgVqKIgFjY6Nv/jZFVm2gtVSRSLgWd31epI33HzmW
	dfLPFdm03jnrBl8GjHpw2rTkRaHC/86r/BgjTFLBSvS8BHUL8WMnBfZamRzXUY0PDTDqIbPFJ+KMG
	zkAGmcu27I/gHrDEhFzdHyVe5SOuyZapcX0yNwQGrZealE6UdocDAIWpn0tc2T19Bz2NFPTkFrtIC
	pJjYu8G0EghapNmGMx0i2iyoktAbO3zecZBsIf/iY8Cl40fcXopXupQN5NuGx2j85xt1iHruHc1Ny
	Z0v6i5XCvLhiO1RA0805Qq4bPKFD7H8Y2KPQ==;
Received: from mail-oa1-f51.google.com ([209.85.160.51]:45067)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tcT0p-00063m-K5
	for netdev@vger.kernel.org; Mon, 27 Jan 2025 09:35:04 -0800
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2a3c075ddb6so2443561fac.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 09:35:03 -0800 (PST)
X-Gm-Message-State: AOJu0YyYPrfFdyRUeTg5Yn/UC0QAx1rc+DEyZrx8an/Tts9eaGQo+/5f
	LeRuJHs/jOHa+GEwfoTJ9Djbl6fblYqZUDHni0zzYCxfmJtiujbNvXYWKlTfKhlMUGqUZrmKjvh
	3Sd/z9xhSaNG5O3D2FdsPXmuz4Wc=
X-Google-Smtp-Source: AGHT+IHX4AY8UTbGpvMBpUrUVR261HOtv/jLsPH2WLC8c/yOp/h9nY3i/ALTaGr9yOJh3pTyftw549WxXHL+PVQnzgs=
X-Received: by 2002:a05:6870:2f0d:b0:29e:5522:8eea with SMTP id
 586e51a60fabf-2b1c0b6cdc0mr25076534fac.38.1737999303069; Mon, 27 Jan 2025
 09:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-5-ouster@cs.stanford.edu>
 <a39c8c5c-4e39-42e6-8d8a-7bfdc6ace688@redhat.com> <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>
 <4e43078f-a41e-4953-9ee9-de579bd92914@redhat.com>
In-Reply-To: <4e43078f-a41e-4953-9ee9-de579bd92914@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 27 Jan 2025 09:34:27 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxPzrnve-LKKhVNnHCpTeYV=MkuBu0qaAu_YmQP5CSXhg@mail.gmail.com>
X-Gm-Features: AWEUYZmyVDG_E9BQGL3p3Bq1aUuaeUrT4-bBbT4bkZDbZuZnd9ibIFnXy11FM3A
Message-ID: <CAGXJAmxPzrnve-LKKhVNnHCpTeYV=MkuBu0qaAu_YmQP5CSXhg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/12] net: homa: create homa_pool.h and homa_pool.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: cb5916722246bf80bd9488153e8e2604

On Mon, Jan 27, 2025 at 1:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/25/25 12:53 AM, John Ousterhout wrote:
> > On Thu, Jan 23, 2025 at 4:06=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > ...
> >>> +     pool->descriptors =3D kmalloc_array(pool->num_bpages,
> >>> +                                       sizeof(struct homa_bpage),
> >>> +                                       GFP_ATOMIC);
> >>
> >> Possibly wort adding '| __GFP_ZERO' and avoid zeroing some fields late=
r.
> >
> > I prefer to do all the initialization explicitly (this makes it
> > totally clear that a zero value is intended, as opposed to accidental
> > omission of an initializer). If you still think I should use
> > __GFP_ZERO, let me know and I'll add it.
>
> Indeed the __GFP_ZERO flag is the preferred for such allocation, as it
> at very least reduce the generated code size.

OK, I have added __GFP_ZERO and removed explicit zero initializers,
both here and in similar situations elsewhere in the code.

> >>> +int homa_pool_get_pages(struct homa_pool *pool, int num_pages, __u32=
 *pages,
> >>> +                     int set_owner)
> >>> +{
> >>> +     int core_num =3D raw_smp_processor_id();
> >>
> >> Why the 'raw' variant? If this code is pre-emptible it means another
> >> process could be scheduled on the same core...
> >
> > My understanding is that raw_smp_processor_id is faster.
> > homa_pool_get_pages is invoked with a spinlock held, so there is no
> > risk of a core switch while it is executing. Is there some other
> > problem I have missed?
>
> raw_* variants, alike __* ones, fall under the 'use at your own risk'
> category.
>
> In this specific case raw_smp_processor_id() is supposed to be used if
> you don't care the process being move on other cores while using the
> 'id' value.
>
> Using raw_smp_processor_id() and building with the CONFIG_DEBUG_PREEMPT
> knob, the generated code will miss run-time check for preemption being
> actually disabled at invocation time. Such check will be added while
> using smp_processor_id(), with no performance cost for non debug build.

I'm pretty confident that the raw variant is safe. However, are you
saying that there is no performance advantage of the raw version in
production builds? If so, then I might as well switch to the non-raw
version.

> >> ____cacheline_aligned instead of inserting the struct into an union
> >> should suffice.
> >
> > Done (but now that alloc_percpu_gfp is being used I'm not sure this is
> > needed to ensure alignment?).
>
> Yep, cacheline alignment should not be needed for percpu data.

OK, I've removed the alignment directive for the percpu data.

-John-

