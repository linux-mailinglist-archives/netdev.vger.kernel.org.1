Return-Path: <netdev+bounces-217088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D35B37549
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4271BA1BE3
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480EB2FF651;
	Tue, 26 Aug 2025 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="mPq3ATGY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3292FF156
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249901; cv=none; b=M3VyePQfA2DvHAdlWpIhHdEw0CCfWsreDTk+bOoa926mcA3463e68ACmkBFvtp/KFDVJJ8rgHDuBO8II9gBD20GQrX++tp7IuHRLkBISBZfxpIIe0H9GWyz7pFJc1JTYVzWXR1yIJEQauCYDsmDA0ixrCaFdZV0RIlmAnbROljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249901; c=relaxed/simple;
	bh=d/6uoJcd0GTeWBkTbh9ReB5QVofD0aDlNw+P3BMgWUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOJ96b5pJFejKLr2n80/Fc3IFqNquAA/zyAqg4nwQJpQdOy797AkcwNA/Vn9NVz6RQH6GZrx2pyxq9+1kFm+6Yq6uaT/n2hJv9wrLXoi4ssjTL4WI5y6lNY+Tp6gV6DkWWv7ls477EFqdpp7Bu89yLgju0WnRbsKDHOvyXWYZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=mPq3ATGY; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1V564k9JkcWRKmFZSiKO06HvP3r1tcKBW0U7yaKVoX0=; t=1756249899; x=1757113899; 
	b=mPq3ATGY45p6FI/jKIdZRb7W+rnOaGheszBBzPBqrc0FK7YevR49zL/uZ5zIL5+8ZLgolTbjc67
	Zn2HjDcVUjdfdSkXkLTGBR1sLhZ4GMbCbmIBS12vVuOEcJ3SKOZtwrfoSdkyvrBWJL3LLko4HJP36
	TcEaSMfT1wnfAK7NbZheBCo23/VXEJSBRFmiEKHG/FO8orVRXrulX6gW7CJyt2jrkVy9AtjV3wwmO
	cuMiVtMcnxrdLvx93afy02FwquiRdJJnGCMYcyjv2vw2C7NHWOBl9ALKOLom8UxDYqmEsv514DUoB
	n+GGzF6YO9kVtX9JUZLyr8LBXQPnTm4S+zhw==;
Received: from mail-oo1-f41.google.com ([209.85.161.41]:59675)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1ur2pB-0000q5-3A
	for netdev@vger.kernel.org; Tue, 26 Aug 2025 16:11:33 -0700
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61dc56dcd2dso2074489eaf.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:11:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YxscFpCIw6IHNWKleP6mCTQmvxf3DZfDvS10ryxmMOLrhLWC74E
	lps/kqtwQvGGu0I1ogrLDQRYocO2s65ESCBHF0mpcTOCgrI/4jbw6PkTlN2rTeEr+1YwhEm5Ovq
	Zsmpxl0jC/eijF1Kgco4eipVjtRvMSM4=
X-Google-Smtp-Source: AGHT+IHW466pG/3xP0KDvD8MMThHj+GfNGUbNbaSJF8VV4211niYdVVmqwWJvVXejeeqb783zhIHCQvpzICipoAT8z8=
X-Received: by 2002:a05:6808:1522:b0:3f3:e9d5:7790 with SMTP id
 5614622812f47-437851dc9e7mr7703463b6e.6.1756249892536; Tue, 26 Aug 2025
 16:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-4-ouster@cs.stanford.edu>
 <ce4f62a8-1114-47b9-af08-51656e08c2b5@redhat.com>
In-Reply-To: <ce4f62a8-1114-47b9-af08-51656e08c2b5@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 26 Aug 2025 16:10:56 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzwk87WCjxrxQbTn3bM8nemKcnzHzOeFTBJiKWABRf+Nw@mail.gmail.com>
X-Gm-Features: Ac12FXzJK53jSro4FyPy95RDtv73KCZ50jMesuhw4vt7CWb8pKED8XcaQS4lLAA
Message-ID: <CAGXJAmzwk87WCjxrxQbTn3bM8nemKcnzHzOeFTBJiKWABRf+Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/15] net: homa: create shared Homa header files
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 882c50607b8592e4560fe9069cd502a5

On Tue, Aug 26, 2025 at 2:06=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/18/25 10:55 PM, John Ousterhout wrote:
> > +/**
> > + * struct homa_net - Contains Homa information that is specific to a
> > + * particular network namespace.
> > + */
> > +struct homa_net {
> > +     /** @net: Network namespace corresponding to this structure. */
> > +     struct net *net;
> > +
> > +     /** @homa: Global Homa information. */
> > +     struct homa *homa;
>
> It's not clear why the above 2 fields are needed. You could access
> directly the global struct homa instance, and 'struct net' is usually
> available when struct home_net is avail.

I have eliminated net but would like to retain homa. I have tried very
hard to avoid global variables in Homa, both for general pedagogical
reasons and because it simplifies unit testing. Right now there is no
need for a global homa except a couple of places in homa_plumbing.c,
and I'd like to maintain that encapsulation.

> > +/**
> > + * homa_clock() - Return a fine-grain clock value that is monotonic an=
d
> > + * consistent across cores.
> > + * Return: see above.
> > + */
> > +static inline u64 homa_clock(void)
> > +{
> > +     /* As of May 2025 there does not appear to be a portable API that
> > +      * meets Homa's needs:
> > +      * - The Intel X86 TSC works well but is not portable.
> > +      * - sched_clock() does not guarantee monotonicity or consistency=
.
> > +      * - ktime_get_mono_fast_ns and ktime_get_raw_fast_ns are very sl=
ow
> > +      *   (27 ns to read, vs 8 ns for TSC)
> > +      * Thus we use a hybrid approach that uses TSC (via get_cycles) w=
here
> > +      * available (which should be just about everywhere Homa runs).
> > +      */
> > +#ifdef CONFIG_X86_TSC
> > +     return get_cycles();
> > +#else
> > +     return ktime_get_mono_fast_ns();
> > +#endif /* CONFIG_X86_TSC */
> > +}
>
> ktime_get*() variant are fast enough to allow e.g. pktgen deals with
> millions of packets x seconds. Both tsc() and ktime_get_mono_fast_ns()
> suffer of various inconsistencies which will cause the most unexpected
> issues in the most dangerous situation. I strongly advice against this
> early optimization.

Which ktime_get variant do you recommend instead of ktime_get_mono_fast_ns?

I feel pretty strongly about retaining the use of TSC on Intel
platforms. As I have said before, Homa is attempting to operate in a
much more aggressive latency domain than Linux is used to, and
nanoseconds matter. I have been using TSC on Intel and AMD platforms
for more than 15 years and I have never had any problems. Is there a
specific inconsistency you know of that will cause "unexpected issues
in the most dangerous situations"? If not, I would prefer to retain
the use of TSC until someone can identify a real problem. Note that
the choice of clock is now well encapsulated, so if a change should
become necessary it will be very easy to make.

For all of your comments that I have not responded to explicitly
above, I have implemented the changes you recommended.

-John-

