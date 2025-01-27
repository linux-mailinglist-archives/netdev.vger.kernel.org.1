Return-Path: <netdev+bounces-161178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FBEA1DC8D
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B35161A35
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B4415FD13;
	Mon, 27 Jan 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="OsrI9Mp8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A0191F74
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005218; cv=none; b=OgYhyix7uJElckuD8cpXCG88k83Jh1ONW3YMZJuJL354XAawwnHv8kPW9lONaiXQwHznFUj1XXkgjQf0ANVosSnweKfe6wgTgcYfuqKRnjy8vF+pdxpVkn03HT81JboQv4pFaDo9jPVXmMwGTNd2QPwgl194ulpYxIirtDWEEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005218; c=relaxed/simple;
	bh=L6FNMOJ9qcvFHLP+01JMMuhWIXyhWCbqbr27FiG4LXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFcohCGwSlZTe2zOLMl/0haCwXXcKVA8v3hg3rsZYWqzdCB/QV2SmAueS/KzoAc8k0bI2fVPeKwwTo9KDvz+SBwXhwtJcnv96q14FYE/9VE3NJv7267h0tkD4s3c0Bh4Tqx3wveSSBcRr9FvQ3fevnbcF0/3gE1l63Y4NNT7Sdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=OsrI9Mp8; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L6FNMOJ9qcvFHLP+01JMMuhWIXyhWCbqbr27FiG4LXk=; t=1738005217; x=1738869217; 
	b=OsrI9Mp8mnOPsX2ImIBoUAhoQMsCGxzIbXpkCLUemp+aUKIEHRyEkCjwWmahKQ82a+fbF34Q2AA
	We/4NAkneaexDQ+aqcaeJgvWj2zRyXe69q4JcXZcsB+ZvU5IGfuxf5bfXf3jYA6mpP9nZEywrHm4j
	2EfxFuigAk+YeO7XpSJhGteU/aN+EVu86BSeikLODsALkMNXbQX1lbwjydqEX5e6gxgZK23FP7muf
	ahkGZZdhCEtJ+/Tl1sf/D1VeMn8nFOyAMb448ixYHg0Yx6bWxvTSFRd+ZXnlh/4qjkKZwCCpB2OIi
	WD78XYZ+kuYmH8SC2+/WQ3f6HUx83erfmyJw==;
Received: from mail-oi1-f176.google.com ([209.85.167.176]:61566)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tcUYB-00037y-V7
	for netdev@vger.kernel.org; Mon, 27 Jan 2025 11:13:36 -0800
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb9de518e2so2372927b6e.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 11:13:35 -0800 (PST)
X-Gm-Message-State: AOJu0YwrdzWkw6TV/kyuR6z8Ijwn8IL/80hNsOfPeqb/pX7ml1D5wdAv
	XSNioRytqejtv32nLHVJFOgKpz2b2yWX50DVE/UV8Uiric/R27ZJ3OizO9mnIDvG6BJ+rbp4hqH
	yrkU7cbwTjVjtFSKMzxqC/GtSTrY=
X-Google-Smtp-Source: AGHT+IE8Hteh0CbPEHtLqrDFZ2R698ASFL51+T8/PCDKLSxl01hR6Jt/UKek1S8mvGj9n6tgpVP2fF2apYLn7y81kK0=
X-Received: by 2002:a05:6870:ad93:b0:29e:4ba5:4ddc with SMTP id
 586e51a60fabf-2b1c0b4eb01mr21304570fac.24.1738005215428; Mon, 27 Jan 2025
 11:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-5-ouster@cs.stanford.edu>
 <a39c8c5c-4e39-42e6-8d8a-7bfdc6ace688@redhat.com> <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>
 <4e43078f-a41e-4953-9ee9-de579bd92914@redhat.com> <CAGXJAmxPzrnve-LKKhVNnHCpTeYV=MkuBu0qaAu_YmQP5CSXhg@mail.gmail.com>
 <595520fc-d456-4e62-9c39-947ccfb86d0d@redhat.com>
In-Reply-To: <595520fc-d456-4e62-9c39-947ccfb86d0d@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 27 Jan 2025 11:12:58 -0800
X-Gmail-Original-Message-ID: <CAGXJAmz6TL8C5Q2=__5nxCBudDd_+NbnaabnB6+Tt79A3HyK9g@mail.gmail.com>
X-Gm-Features: AWEUYZnLf0j4J8bexZUKzZYdpDQNxDc0WBZUqIWSuBFzjc8y3zmF8U2_cvenQyA
Message-ID: <CAGXJAmz6TL8C5Q2=__5nxCBudDd_+NbnaabnB6+Tt79A3HyK9g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/12] net: homa: create homa_pool.h and homa_pool.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 6b0537b5faa14548adc1759647fcb4de

On Mon, Jan 27, 2025 at 10:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 1/27/25 6:34 PM, John Ousterhout wrote:
> > On Mon, Jan 27, 2025 at 1:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> raw_* variants, alike __* ones, fall under the 'use at your own risk'
> >> category.
> >>
> >> In this specific case raw_smp_processor_id() is supposed to be used if
> >> you don't care the process being move on other cores while using the
> >> 'id' value.
> >>
> >> Using raw_smp_processor_id() and building with the CONFIG_DEBUG_PREEMP=
T
> >> knob, the generated code will miss run-time check for preemption being
> >> actually disabled at invocation time. Such check will be added while
> >> using smp_processor_id(), with no performance cost for non debug build=
.
> >
> > I'm pretty confident that the raw variant is safe. However, are you
> > saying that there is no performance advantage of the raw version in
> > production builds?
>
> Yes.
>
> > If so, then I might as well switch to the non-raw version.
>
> Please do. In fact using the raw variant when not needed will bring only
> shortcoming.

Will do. Just for my information, when is the raw variant "needed"?

-John-

