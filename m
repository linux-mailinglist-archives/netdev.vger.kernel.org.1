Return-Path: <netdev+bounces-153756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB19F991C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2A37A429E
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41475220694;
	Fri, 20 Dec 2024 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="aQ7aFsuu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F8219A6E
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717638; cv=none; b=Fa1wCPTBMOvLgrsURhPOtfR/n+9epsQIzCcQH1tlG+Gb5J01SKcFE2WsjXp/iKBGgMnDfEsa7XcGmlpVImouTz5W0mZS2sYK/bV+JVlmeY1czpcOrrherdx1Vb/O/64b2xNtL0ELdSQuJZlHOS29/Zsedpkn7bBbPJMVZydruFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717638; c=relaxed/simple;
	bh=A6LCKva4VTRvxuTUWokFc6SK9dEtgQHGD34yJmgs5Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzGZNCfpQ2WbNMqH5Dquh+09Hd0+4r3cN7bpdhYTZoOB4TXOeS34ooFOn0RL1KfK4UpM8S8Ix/EuzzKwM9LyeJSTZkKLkz9rwHPo3UjcdoCO2wjBkIitClsHJVMFJ1rWV8lXqAKNqviMQ4gzCizngTN8P9W3UO9otTcVvgOdkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=aQ7aFsuu; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CpmmNqkNZCL1dWRONRNCTvQI6DJYb79eUI9KQGez/Yo=; t=1734717636; x=1735581636; 
	b=aQ7aFsuu3LJ4+klFkmBvfdJYlAbayDhF/WWSUywBLzz310x7MiIZHddcCtXGPJzQBBCQ2PGGrCl
	CvAYFoeWwcL/xiP7+/7v1lfjoNdnQsDmqT7Z/XZH/SrXFl8WFSu9UFIBiDCNv6izIKSYXK9huM1ti
	iSYXoYReDGF6ONy1xz9tdeeMBOlRAYn45eqVQLXU7wMnqcl+UEWUsyN5rb2nVuR2/nn72MIyQoJYK
	0CfAM6mc1ivV7cl+1t62tc2ckGIyOxFD0SC+/Ad7CqMFy3SAtYZFqHaoXNJdnsvl3I+rXe5XBOdXr
	fSzU7B8I9vs3lb/M45bxljGQQzqjJoBDAIzQ==;
Received: from mail-oa1-f52.google.com ([209.85.160.52]:59800)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tOhIb-0004g1-Bx
	for netdev@vger.kernel.org; Fri, 20 Dec 2024 10:00:30 -0800
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e5c0c46c3so1157875fac.3
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 10:00:29 -0800 (PST)
X-Gm-Message-State: AOJu0YzulwyB5yULT0KdeGIo3NcZpzYlR21aJgg0PJ94NfVyVqff3syc
	q9BR9leEnZZwHEZv4rQvTsDpDy2TKyvTtmM2Blj39PrrH6nbcBahYtPFIgYRUmfRt+IFPj5URM3
	3H1cWX6wgBAhpK5hwxBPUdmoTlqI=
X-Google-Smtp-Source: AGHT+IFUTbzqSTHTGCvaPkcSl1xyHGUfdWqiEpNUimgSDfIxYmzpqYmK6D82c6ZCifcNGXi3HXB2BX87CZU21YeRG2A=
X-Received: by 2002:a05:6871:d114:b0:27c:a414:b907 with SMTP id
 586e51a60fabf-2a7fb4d0065mr2089610fac.33.1734717628809; Fri, 20 Dec 2024
 10:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217000626.2958-1-ouster@cs.stanford.edu> <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org> <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
 <20241219174109.198f7094@kernel.org>
In-Reply-To: <20241219174109.198f7094@kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 20 Dec 2024 09:59:53 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>
Message-ID: <CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API for Homa
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 6890477ab20817755420d5b1edd0addc

On Thu, Dec 19, 2024 at 5:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> > Any suggestions on how to make the header file work with C++ files
> > without the #ifdef __cplusplus?
>
> With the little C++ understanding I have, I _think_ the include site
> can wrap:
>
> extern "C" {
> #include "<linux/homa.h>"
> }

I have done this now. I was hesitant to do that because it seemed like
it was creating unnecessary extra work for anyone who uses homa.h in a
C++ program, but since this seems to be the convention I have
conformed to it.

> > > > +/** define SO_HOMA_RCVBUF - setsockopt option for specifying buffe=
r region. */
> > > > +#define SO_HOMA_RCVBUF 10
> > > > +
> > > > +/** struct homa_rcvbuf_args - setsockopt argument for SO_HOMA_RCVB=
UF. */
> > > > +struct homa_rcvbuf_args {
> > > > +     /** @start: First byte of buffer region. */
> > > > +     void *start;
> > >
> > > I'm not sure if pointers are legal in uAPI.
> > > I *think* we are supposed to use __aligned_u64, because pointers
> > > will be different size for 32b binaries running in compat mode
> > > on 64b kernels, or some such.
> >
> > I see that "void *" is used in the declaration for struct msghdr
> > (along with some other pointer types as well) and struct msghdr is
> > part of several uAPI interfaces, no?
>
> Off the top off my head this use is a source of major pain, grep around
> for compat_msghdr.

How should I go about confirming that this __aligned_u64 is indeed the
expected convention (sounds like you aren't certain)? Also, any idea
why it needs to be aligned rather than just __u64?

> My recommendation is to use normal comments where kdoc just repeats
> obvious stuff. All these warnings sooner or later will result in some
> semi-automated and often poor quality patch submissions to "fix" it.
> Which is just work for maintainers to deal with :(

I have done this now. I had assumed that kdoc would also complain if
there was a declaration without official kdoc documentation, but now
that I see that it won't, I'll use that approach for places where kdoc
style is awkward. Personally I'm agnostic about whether to use kdoc; I
assumed that I should use it since it exists.

-John-

