Return-Path: <netdev+bounces-140532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE29B6D75
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679FC281040
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8261CBEA3;
	Wed, 30 Oct 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="PSNASotn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAFF1BD9D3
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319519; cv=none; b=PxW0SsrBY8kalFizku6asd0Vcqy8YpvvLDRn1ljI0zzC9SrgFpaB8WKvYZ3Q0NjI2nvGEDXql9a72bnijWKCsudfClOZRE9oOPCNpd/8uDcg2RUEcaXYd+FoU7Z+SWxBIu7H9VQHMIgmjybjjX+rWczFfyxfCkbQmty8G8nrSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319519; c=relaxed/simple;
	bh=+8XlIW95mCY7KqxUWWki5O47OghksSLkyg3LExDSlRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6B90b30zhfGRmBoO+EDIJ/4j4FLntAw/SVFwu4u5j/e4p+jUPf8j6JHLyTeoOAbxJTQRXBosHT4IS2kRw7gWQMMvbZr1GryGqJ/2g6SJKPUwIlLtUUJMe5vUPU9o65AIJ2/4FazrltOfSNlnfBA3XGB0Wat+4BGkh51tXVDGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=PSNASotn; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ai77ZZWpAmodUo38tmrDoTy/0AdviV1tFOhHnyi3e5U=; t=1730319517; x=1731183517; 
	b=PSNASotnxD25FZrQc9XMLFO1Xz/PoD6HeRxg3UZtSwxyCfFBDyu9hkF3H/55cNgDLJ4VS2+qtF8
	WIVvBW8GlRZnf72ZTEDg3BaNppU6ky/VlaAh4SJ8YwDZhrPKGr5XheBwNUVqZiuqO7aEBsYsf9nfj
	yW9Qz50xO3lSaVQUOKSYGz8SHLuDM3T1gnYZUVD/vJQxU3iGHiHs42TmdFGEW7Liv4idt6IcCXBCB
	Gt63WU/lHJUchI4j7GyY44y6JF/kQXbCW4ow7G/f4ainF8JBTI2sfa8yMLFbUgrqMqmjUTHNxtNrv
	Th4HEkSbGptbztPGPuBK3XxQpThL82rv372w==;
Received: from mail-oo1-f42.google.com ([209.85.161.42]:50202)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t6F9I-00012P-GH
	for netdev@vger.kernel.org; Wed, 30 Oct 2024 13:18:37 -0700
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc9bda8c8so176286eaf.0
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 13:18:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YyEqRUC0D+syW1oN/Qq7CRlQ+6aclhJf7KOdVkbA6bT/lWqOali
	cPXY1rgmDcXBqMu6hztmPY+Fxjet12+ziQFeSCI1ScHgxPtGPHQcwBSZN3DodE8NEGBiDnrF8JP
	saj/HUKR7XytTE+NAtoW8fNpEoJU=
X-Google-Smtp-Source: AGHT+IE7zdzlAcXdS8RM8GFFTSU5yKffF4Q1n/8Hf6UmTZZ2HGXMlopgFAp4LfsTmbQRbXlvMSOVyyt/+Y6iO4pi5W0=
X-Received: by 2002:a05:6820:2290:b0:5eb:5bc9:da6c with SMTP id
 006d021491bc7-5ec23950b62mr12109119eaf.3.1730319515898; Wed, 30 Oct 2024
 13:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-5-ouster@cs.stanford.edu>
 <dfadfd49-a7ce-4327-94bd-a1a24cbdd5a3@lunn.ch> <CAGXJAmycKLobQxYF6Wm9RLgTFCJkhcW1-4Gzwb1Kzh7RDnt6Zg@mail.gmail.com>
 <67c42f72-4448-4fab-aa5d-c26dd47da74f@lunn.ch> <CAGXJAmyLsx9DPGdhZwPxn0wXjFAFV3dqjhFHpaBLtKZ1mtYBSQ@mail.gmail.com>
 <16f2e9cc-9b5e-4325-b5c7-fe7fd72600a8@lunn.ch>
In-Reply-To: <16f2e9cc-9b5e-4325-b5c7-fe7fd72600a8@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 30 Oct 2024 13:17:59 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyNuzX9DpZFvaWFbY95_sAC0gy9AfOT7gToYamnU0RZRQ@mail.gmail.com>
Message-ID: <CAGXJAmyNuzX9DpZFvaWFbY95_sAC0gy9AfOT7gToYamnU0RZRQ@mail.gmail.com>
Subject: Re: [PATCH net-next 04/12] net: homa: create homa_pool.h and homa_pool.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: b0d2d5ababd8fe43140185de29a9e1cb

On Wed, Oct 30, 2024 at 9:03=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Oct 30, 2024 at 08:46:33AM -0700, John Ousterhout wrote:
> > On Wed, Oct 30, 2024 at 5:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > > > I think this is a different problem from what page pools solve. Rat=
her
> > > > than the application providing a buffer each time it calls recvmsg,=
 it
> > > > provides a large region of memory in its virtual address space in
> > > > advance;
> > >
> > > Ah, O.K. Yes, page pool is for kernel memory. However, is the virtual
> > > address space mapped to pages and pinned? Or do you allocate pages
> > > into that VM range as you need them? And then free them once the
> > > application says it has completed? If you are allocating and freeing
> > > pages, the page pool might be useful for these allocations.
> >
> > Homa doesn't allocate or free pages for this: the application mmap's a
> > region and passes the virtual address range to Homa. Homa doesn't need
> > to pin the pages. This memory is used in a fashion similar to how a
> > buffer passed to recvmsg would be used, except that Homa maintains
> > access to the region for the lifetime of the associated socket. When
> > the application finishes processing an incoming message, it notifies
> > Homa so that Homa can reuse the message's buffer space for future
> > messages; there's no page allocation or freeing in this process.
>
> I clearly don't know enough about memory management! I would of
> expected the kernel to do lazy allocation of pages to VM addresses as
> needed. Maybe it is, and when you actually access one of these missing
> pages, you get a page fault and the MM code is kicking in to put an
> actual page there? This could all be hidden inside the copy_to_user()
> call.

Yes, this is all correct.  MM code gets called during copy_to_user to
allocate pages as needed (I should have been more clear: Homa doesn't
allocate or free pages directly). Homa tries to be clever about using
the buffer region to minimize the number of physical pages that
actually need to be allocated (it tries to allocate at the beginning
of the region, only using higher addresses when the lower addresses
are in use).

> > > Taking a step back here, the kernel already has a number of allocator=
s
> > > and ideally we don't want to add yet another one unless it is really
> > > required. So it would be good to get some reviews from the MM people.
> >
> > I'm happy to do that if you still think it's necessary; how do I do tha=
t?
>
> Reach out to Andrew Morton <akpm@linux-foundation.org>, the main
> Memory Management Maintainer. Ask who a good person would be to review
> this code.

I have started this process in a separate email.

-John-

