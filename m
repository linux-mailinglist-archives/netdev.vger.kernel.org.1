Return-Path: <netdev+bounces-197603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A02FFAD9488
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48BF1BC19BB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDF022DFB5;
	Fri, 13 Jun 2025 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="PpSUmukT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53722A1E1
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839830; cv=none; b=T+hAA1MjeQAGWSa9C2vqOxop8oJXVvZbPmtRSKI/X9XBqeF0ND1/MCY72/xlqjMehrL/GAiv2AN7qOcLuFBUCWJqUooabeXsry1qcHOiFXSjQb1wSLzZwQIqUNUI0XwGIdEOzmfJZU8HRetqjVOtgI6q6MjIZ7A08t5IqIw43qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839830; c=relaxed/simple;
	bh=1HBJGXDI4M4cw9OXCFzP5Hi4dxvSY7Zle8mPebJlCKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3rygHE+gNDOc4Dh0Ruof667Ou2KXIZ/7Y1zcTXtglyJ7vQ0MaDbgnHf1QjD4F+SF6Czy23pOfIw00oRrER1CBjMxwqyaxo2wz1yPHcECC5vJ+lqJPPpd6OykZ1cwc/ki/FZ+xqVDbRpIRe4COfToykpuSwiB5nirqLzllFP8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=PpSUmukT; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8QbhIwNGDRGMDTxa51mRdhtAhvJdkk/9NBiHEVxzQdg=; t=1749839829; x=1750703829; 
	b=PpSUmukT8I0BvrhzEt6N0nj3OlcOMS0tbE0iXcnX5oxPEr7X6GfoSOjBGJkchkX2K/8Uh68dIhq
	mE277t0YxkEPTrvzIRNKUpsZ+7FZhJHjaKogj6ePmbvogDZHxzF6BBhmr+YksRHkP2MdZKgB0D8aF
	c5TfyE4Rb0YNKJn3K2CcG6NhOdVl2ijpUaI0Hn1Y8LMYE9g/rOl0JDMQ6MFJMShYtI2wemwBUI9An
	p+lnXE2gPmqxD4Mc4i8rCNOEZD2AHefxose7uisu4+kvoY8lHRisNK0ANcCjFTb2wD2CAdDsjxrnl
	P77G4Kk5VnNa6XFtkEvgLNPfi15MIR3xqBZw==;
Received: from mail-oa1-f47.google.com ([209.85.160.47]:43253)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uQ9H2-0000Rk-4r
	for netdev@vger.kernel.org; Fri, 13 Jun 2025 11:37:08 -0700
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so2043736fac.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 11:37:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YzQ9R0A7QvPlT3+66ukF02tu9CZ34q5wYAujCrCzDCQsGOZZQ9p
	KOJX9IH6idXQSYr4u/ZeIvxUftS3Bo7ev9J+6wTkJVDhnmLd+1tpDbsz0/kwKlb6aOhiNJW5p7Y
	XPBJcTcaIfNqSv/k3eUjIH+wY/s7bynw=
X-Google-Smtp-Source: AGHT+IFiAIoDJ+6BAxtxbSVUX6Gpxl4/EqMkQQP7Vcszl3KKVN3U8cwAwxFc3krbouL097FiPblzOMap86HmoqPIEmg=
X-Received: by 2002:a05:6870:219e:b0:2e9:42a9:be4a with SMTP id
 586e51a60fabf-2eaf070b91emr488353fac.2.1749839827495; Fri, 13 Jun 2025
 11:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609154051.1319-1-ouster@cs.stanford.edu> <20250609154051.1319-4-ouster@cs.stanford.edu>
 <20250613144055.GI414686@horms.kernel.org>
In-Reply-To: <20250613144055.GI414686@horms.kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 13 Jun 2025 11:36:18 -0700
X-Gmail-Original-Message-ID: <CAGXJAmx61NFmvwDeUqi1x+sSetZwtNF_EvbYCgBoNDODXEp7jg@mail.gmail.com>
X-Gm-Features: AX0GCFs-qYkgMdxwLB80dEX3DmIQDeCmlNBvIR-iRLYXB65aGah302iT8ogkbCs
Message-ID: <CAGXJAmx61NFmvwDeUqi1x+sSetZwtNF_EvbYCgBoNDODXEp7jg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 03/15] net: homa: create shared Homa header files
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 127ff6e1eac6b45a32dc112250ed777d

On Fri, Jun 13, 2025 at 7:41=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> > +#ifdef __CHECKER__
> > +#define __context__(x, y, z) __attribute__((context(x, y, z)))
> > +#else
> > +#define __context__(...)
> > +#endif /* __CHECKER__ */
>
> I am unclear on the intent of this. But it does seem to be an
> unusual approach within the Kernel (I couldn't find any other similar
> code in-tree. And, with other patches in this series, it does seem
> to lead to Sparse and Smatch flagging the following (and other similar
> warnings):
>
>  .../rhashtable.h:411:9: error: macro "__context__" requires 3 arguments,=
 but only 2 given
>  .../rhashtable.h:411:27: error: Expected ( after __context__ statement
>  .../rhashtable.h:411:27: error: got ;
>
> I suspect it's best to remove the above.

If I remove those lines then Homa doesn't compile. I have struggled to
figure out how to use sparse in a meaningful way, so I'm probably
doing things wrong;  if you have suggestions I'd be delighted to hear
them.

The code above is required because I use __context__ for Homa's RPC
locks. I'm not sure this was the right thing to do, but I did it for
two reasons:

* The locks for homa_rpc objects are kept outside the objects (in the
hash table buckets used to look them up). Sometimes they are accessed
via the rpc object (rpc->bucket->lock) and sometimes directly from the
bucket (bucket->lock). I was concerned that sparse would not be able
to figure out that these are actually the same lock.

* Functions such as homa_rpc_find_server in homa_rpc.c return an RPC
in locked state, so they need an __acquires annotation (actually,
__cond_acquires for homa_rpc_find_server). But I couldn't figure out
how to specify the acquired lock, since there is no variable in the
API that represents the returned RPC.

Defining an "rpc_bucket_lock" context for the lock (see homa_sock.h)
seemed to provide the expressive power to solve both these problems,
but it led to compilation errors without the additional code above.

Is there a different and better way I should be doing things?

-John-

