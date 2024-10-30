Return-Path: <netdev+bounces-140448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF09B6851
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B866284714
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD62921314E;
	Wed, 30 Oct 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="sn8dV+UY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BCC1F4FA0
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303362; cv=none; b=sQ35sjHGahhErubIX6yiNDJghWetxvmacKS9YLdBQBoZRQ/Ar8prwyoAJrBMMAAPDm4RtlpkeHneeLK8OGZ0/C3Z9qfUKp7JpUSA1Hsa+PzO9SElZsdETe09iULPIbenctVQZ4jE6jLoVY9DbhV0MDcCbqsU083FjCHszjjwaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303362; c=relaxed/simple;
	bh=Io2tbWowQ68Dz1VugryNaBaD3Rn05LkZLQ/yiL5HTJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sd0rmNWenf7Up0l+/HjooplaDsd4WCoFbBBPFEQ69KgqPF990VMpC4dD616Ho8/bTxC6T9ZNNNQWE0h7HyznO4sZpWCBaPc58uFVwO41Xiwyv+tnLLVNWZr1D78fKjusuPPgH6T3X7HwbbhyQAM5Z2WeaVw6kZOCFdJmCtFsBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=sn8dV+UY; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Io2tbWowQ68Dz1VugryNaBaD3Rn05LkZLQ/yiL5HTJE=; t=1730303360; x=1731167360; 
	b=sn8dV+UYXgVI7E04dpLNTZ4g66UBiHu5cgYg02ubK1tgMTM+B8NmoK1ufFaZr7F6YpalOkx/Ouc
	MK61GxTR9uDmQRe6AZcH8RRzr378kr8ee18rtBSdMh+waUASo/BPmfY/98OGtGsRPkiY5nLcDGvlb
	5O9u20GVbOhKTzG4jOQkujAng/Id30LP//D42NJ+20QrZ39PwRhThggW63EpmmV+WrrhKTQDrm7Qe
	QfpJ7mOAlZEaTD1AhDxrU7gAFZy4YslLNDTgybH7uinBGBhLf0vigxI2C95zsczy8lFBRqYJMV2Y2
	tiHUkJVMelEDFQAKkVVa4wdKHVcz6ztEdM1g==;
Received: from mail-oi1-f170.google.com ([209.85.167.170]:42089)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t6Awf-0006ic-HP
	for netdev@vger.kernel.org; Wed, 30 Oct 2024 08:49:18 -0700
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e63e5c0c50so4760b6e.0
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:49:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw2q07aY7/1W0vJSh2Vmor5wLkV7bI8zSAjzg5JC2PeYYN0XkGl
	m24cvua1TLoSYNtVXCi5xZueeQO7t37z5E2RMAf6qWXDaZuEYqP3hni53aw4/55upTVSKECYybH
	M9legUSruZOlB1qIFTlYN5S5BRcM=
X-Google-Smtp-Source: AGHT+IE0KbI8bXwoomr7XCOCyqAcSix9INgL+vfjQehma6S5NxvRb+zFZgQYhmpTLOhSq/Kzvhidw4zOIyx6FWD1rx8=
X-Received: by 2002:a05:6808:2f0e:b0:3e6:5347:8e52 with SMTP id
 5614622812f47-3e653478f31mr3309496b6e.11.1730303357058; Wed, 30 Oct 2024
 08:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-5-ouster@cs.stanford.edu>
 <dfadfd49-a7ce-4327-94bd-a1a24cbdd5a3@lunn.ch> <CAGXJAmycKLobQxYF6Wm9RLgTFCJkhcW1-4Gzwb1Kzh7RDnt6Zg@mail.gmail.com>
 <67c42f72-4448-4fab-aa5d-c26dd47da74f@lunn.ch>
In-Reply-To: <67c42f72-4448-4fab-aa5d-c26dd47da74f@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 30 Oct 2024 08:48:41 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyOAEC+d6aM1VQ=w2EYZXB+s4RwuD6TeDiyWpo1bnGE4w@mail.gmail.com>
Message-ID: <CAGXJAmyOAEC+d6aM1VQ=w2EYZXB+s4RwuD6TeDiyWpo1bnGE4w@mail.gmail.com>
Subject: Re: [PATCH net-next 04/12] net: homa: create homa_pool.h and homa_pool.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: d568c20fab0e2ccae07d583947984559

(resending... forgot to cc netdev in the original response)

On Wed, Oct 30, 2024 at 5:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:

> > I think this is a different problem from what page pools solve. Rather
> > than the application providing a buffer each time it calls recvmsg, it
> > provides a large region of memory in its virtual address space in
> > advance;
>
> Ah, O.K. Yes, page pool is for kernel memory. However, is the virtual
> address space mapped to pages and pinned? Or do you allocate pages
> into that VM range as you need them? And then free them once the
> application says it has completed? If you are allocating and freeing
> pages, the page pool might be useful for these allocations.

Homa doesn't allocate or free pages for this: the application mmap's a
region and passes the virtual address range to Homa. Homa doesn't need
to pin the pages. This memory is used in a fashion similar to how a
buffer passed to recvmsg would be used, except that Homa maintains
access to the region for the lifetime of the associated socket. When
the application finishes processing an incoming message, it notifies
Homa so that Homa can reuse the message's buffer space for future
messages; there's no page allocation or freeing in this process.

> Taking a step back here, the kernel already has a number of allocators
> and ideally we don't want to add yet another one unless it is really
> required. So it would be good to get some reviews from the MM people.

I'm happy to do that if you still think it's necessary; how do I do that?

-John-

