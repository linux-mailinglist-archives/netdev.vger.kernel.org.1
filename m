Return-Path: <netdev+bounces-160861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CFCA1BDF5
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DA81612D6
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69161E9917;
	Fri, 24 Jan 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="gzH/9a/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071291E98ED
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754703; cv=none; b=nU62zVcHdMveky0d4Qo3C18A5eiNE8BBr+k+92mi+CVSel2BQl7xx49Q3E18A4QtXndb51pISMsNLHU1IF3/lZgL86uAdPKHzxx7/pBPc3sOdvVBTgA6IPIBvNVLnFQ7DjDUia/YRK0Xvh80EEdvDBHEocruIjZaIquS5BiX/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754703; c=relaxed/simple;
	bh=dSUEcI2CszeXa/YUSv7xQrrYhrK0pI0Cvk4UmxjCXSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYbch5aCwv7UIDJTGDT4c0wUk4yZRHGFq7f6uIT90jYVh8folg9j8szVXOj+ETL3/SE/ujB4nSP30Pv7/wqig8Qdf3VBsGk22d7rr/Scqi8iQ0jlOAsZbuUZmSQAew+ahwlU9O18e2utYESa41wNpk8Vyy11crmtMkGxKW0muEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=gzH/9a/W; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pdBEaRCSvyWvsIRlqORJ7WlPyopfS1jbm96449rlIh4=; t=1737754702; x=1738618702; 
	b=gzH/9a/WiO8OkMRTqNGaQ5kvkzN1v4bf7aAKc3i0bS3rWB9LFPr3nCDBJaO/ky1cXBjGnT/jYYe
	sXArrLcuHQflM3uUviqhvPfDT6zJs1aID0QACJT2MEnjvaCfPZr08CydpVsql+bQPTL3dPnRTZlnR
	Lkra9Toku7GLxR64GipFrmTk1Kx8XlWi5U5QaGHlGkE+QxtR1+JhHHn5C868bydSnGVvPpwB1ISlq
	ZueWgxKvqFRq5KY5ycp5sac7FU32ETM6cxZWkL5dvcfnYyACAp0kOoT8ZrZzpe5rEBzjbAlAKtesn
	FhoSvA44abCDl8hwJyjUT2RD5/eVQxRgjaOg==;
Received: from mail-oa1-f47.google.com ([209.85.160.47]:45222)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tbR88-0004OQ-Oq
	for netdev@vger.kernel.org; Fri, 24 Jan 2025 13:22:21 -0800
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2a3c075ddb6so1357525fac.2
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 13:22:20 -0800 (PST)
X-Gm-Message-State: AOJu0Yz40x+q2wr5h/GJ1KKjQERQxkW49ecLHt/ZZ8GI53J7b3geQWll
	f53EOs6dVHyB3FB3jt1X/KLslbf6pJBdfFn1y3f8d1697ssIyb6OrMjcw3pCwUD9m+LXnVuVNt5
	aSoHrj9iFJfbm9aYIKwbjPPbLox8=
X-Google-Smtp-Source: AGHT+IEMKGH2Ikj8XAt+E1qDsuhAm/QbG9QKISQbxfbNEAzix4lDaoB8WuGDVHrYleMsBRTXaV+H8NWflyPdurYo+Tc=
X-Received: by 2002:a05:6870:2f0d:b0:29e:5522:8eea with SMTP id
 586e51a60fabf-2b1c0b6cdc0mr19516054fac.38.1737753740167; Fri, 24 Jan 2025
 13:22:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-4-ouster@cs.stanford.edu>
 <08c42b4a-6eed-4814-8bf8-fad40de6f2ed@redhat.com>
In-Reply-To: <08c42b4a-6eed-4814-8bf8-fad40de6f2ed@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 24 Jan 2025 13:21:44 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzcifEeNthmE2J0epFYUhJYH=XxoJUSxQEqPCjkbhHdBw@mail.gmail.com>
X-Gm-Features: AWEUYZk3clALfpaUMRAlTCLktkAdFUtMo6S8ZsS46I0zTEx3NbvkwXiHF7IXWqk
Message-ID: <CAGXJAmzcifEeNthmE2J0epFYUhJYH=XxoJUSxQEqPCjkbhHdBw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 03/12] net: homa: create shared Homa header files
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: daeb03f1a6494d8fe08e106a714ef916

On Thu, Jan 23, 2025 at 3:01=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/15/25 7:59 PM, John Ousterhout wrote:
> [...]
> > +/**
> > + * union sockaddr_in_union - Holds either an IPv4 or IPv6 address (sma=
ller
> > + * and easier to use than sockaddr_storage).
> > + */
> > +union sockaddr_in_union {
> > +     /** @sa: Used to access as a generic sockaddr. */
> > +     struct sockaddr sa;
> > +
> > +     /** @in4: Used to access as IPv4 socket. */
> > +     struct sockaddr_in in4;
> > +
> > +     /** @in6: Used to access as IPv6 socket.  */
> > +     struct sockaddr_in6 in6;
> > +};
>
> There are other protocol using the same struct with a different name
> (sctp) or  a very similar struct (mptcp). It would be nice to move this
> in a shared header and allow re-use.

I would be happy to do this, but I suspect it should be done
separately from this patch series. It's not obvious to me where such a
definition should go; can you suggest an appropriate place for it?

> [...]
> > +     /**
> > +      * @core: Core on which @thread was executing when it registered
> > +      * its interest.  Used for load balancing (see balance.txt).
> > +      */
> > +     int core;
>
> I don't see a 'balance.txt' file in this submission, possibly stray
> reference?

This is a file in the GitHub repo that I hadn't (yet) been including
with the code being upstreamed. I've now added this file (and a couple
of other explanatory .txt files) to the manifest for upstreaming.

> [...]
> > +     /**
> > +      * @pacer_wake_time: time (in sched_clock units) when the pacer l=
ast
> > +      * woke up (if the pacer is running) or 0 if the pacer is sleepin=
g.
> > +      */
> > +     __u64 pacer_wake_time;
>
> why do you use the '__' variant here? this is not uapi, you should use
> the plain u64/u32 (more occurrences below).

Sorry, newbie mistake (I wasn't aware of the difference). I will fix everyw=
here.

> [...]
> > +     /**
> > +      * @prev_default_port: The most recent port number assigned from
> > +      * the range of default ports.
> > +      */
> > +     __u16 prev_default_port __aligned(L1_CACHE_BYTES);
>
> I think the idiomatic way to express the above is to use:
>
>         u16 prev_default_port ____cacheline_aligned;
>
> or
>
>         u16 prev_default_port ____cacheline_aligned_in_smp;
>
> more similar occourrences below.

I will fix everywhere.

Thanks for the comments.


-John-

