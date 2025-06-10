Return-Path: <netdev+bounces-195967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59DFAD2F0C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B7B1893734
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B85280000;
	Tue, 10 Jun 2025 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/u3LFbk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966827F4D9
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749541349; cv=none; b=okRDa2JMEY5yRrmll3MZIev9JvW3ULlZybi/3tTGZNcH+nNrct4WdihzNd4RBOF5g+GegaL0mUwouBvLfdke6SpZ8ph/f0sJ0/OzZT+OklzR3Mai2VwHHNBTCAPU/XwyNUbFna/BKLO9cluWBgfUcdGpVPmLmvN0WM3yudTWUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749541349; c=relaxed/simple;
	bh=EbdbfLgQbLkrRokFtKXxYH2fnts+fkm1Gq0c7pjZtt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gphiGsceAYakFaZsqshMeORgySMjcyaxGP2ii4Iqe+fJcw9lkRNH98KbgWqGUznfFlP8SRHQS1P+noq3kF5Wcw6/cBfiWZbSyPv/Cb0Dkk++h7a5VHBscP7tAfOKS1TSLM0jlrwkQ+pTl427XaV87XZ21T4YYxNbjIETULO0C9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o/u3LFbk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70b4e497d96so47105687b3.2
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749541345; x=1750146145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1sqOFteMdzAQhE7i6OGh7PWlcXLm6OEN0dYnQGH1fE=;
        b=o/u3LFbkrHob9hbsp4AG2yQxgcVoH8TpptyC3HJXZPtXq8pAKQvYTN3StSrdG+GqWU
         MIGRzSwfVtt8a39J4N3EhyjDJoM6co8VvuABBNLjM0WbZy0SXBEzWH7GRGs9n/vpFI9i
         UsG2QXwO/SZYvMD8HxaDM69EamMxU04w2USZPJEeNGcsGWuyZkmPp56z0D+kVpEuGA+v
         5kBWE5wtoH7vK+z5sp/Fj/VOBa+Oiofrg5bc0+lJJFvDtSaqfFadQHgNdgAnqNeZg+/d
         R0JbyWZuE3XQdOGc1qjNaEwNm2Mtbeq8G2Vw1E3xkxtmUoFgaf8jqCF60kdNFlOeFMfF
         0q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749541345; x=1750146145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1sqOFteMdzAQhE7i6OGh7PWlcXLm6OEN0dYnQGH1fE=;
        b=v5lgZ6gIsttq3LhhuD2MJgufPvksuWWgzPqew5Exn+DNZtmXJp+yoZBrq5AjG6EopC
         CziIx7JADVdE4owoil1BNw6Yxdjwv3KdDGq7BaBRrQKYaPA+32inWUaqRFNpPwe6Dikh
         TZjMzQkJyreyat0Ma/K02ShvX6+8gBFFZGt6f5VE7yUG4yxKnQIjo+fFcopu9SjU/+Gt
         mlgDLLU2O+0eRIOnufqdKC9/K1KfTYhMr1dcTuAIkkAIZTiq3VGICGd4K5hojtEZwuQV
         MZ10WNmWedZzTC8vfqvboHGEn8G8912TAM9pcqglMBNV5gLxpVnqSlPo6oGouQxFJ9wH
         vE3A==
X-Forwarded-Encrypted: i=1; AJvYcCUjbA4CKyf8d3QKq2u+u5ozXw8rRsNoHd6idCgW/7w52rvj9QQxnBDsKG14YD6vwINYkXI1PoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxla9XEUa1ambgcSrefoqDorhrgoaLrXi50hy6Ra9l5dQBdcMNo
	5N7BHdGv83gQjgElVmX/ZeviZLnDta11vLP6tK1iWYrcBHTXAmnbKmzP66aVP5CE8IpQ2Ah+sbx
	jmvdNiFGaxrnBx0qTbkvEuX5UoKtPE1hse15hKeb3lg==
X-Gm-Gg: ASbGncvebgjIthnKx/KQPZw5BvKQPu0qVYCxcIekE98O903hh5SJAf1gi4hZbZkb4iV
	YD5M/gdcpGaAtNrzUuE7IPx9MmFhlXYMaaW5gix2oTeMzxcmk8hKD90VnVWhR8bje9eSTgjBEYH
	5oj9MMC4ahAS+6cNqVcF2DShbH6EL+lh8bT9wq5PO80Ot+BBE3nStRhfM=
X-Google-Smtp-Source: AGHT+IGon8O+GRDhvuqyBqd4Ump/1M1/7v+rGo0leM9ll6SEx3n3xo4huVHlRoEcubKcEmvVaSisGm30IGZkmyDl70k=
X-Received: by 2002:a05:690c:660f:b0:70e:923:2173 with SMTP id
 00721157ae682-710f76300fcmr204645487b3.5.1749541345418; Tue, 10 Jun 2025
 00:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525034354.258247-1-almasrymina@google.com>
 <87iklna61r.fsf@toke.dk> <CAHS8izOSW8dZpqgKT=ZxqpctVE3Y9AyR8qXyBGvdW0E8KFgonA@mail.gmail.com>
 <87h615m6cp.fsf@toke.dk> <CAHS8izNDSTkmC32aRA9R=phqRfZUyz06Psc=swOpfVW5SW4R_w@mail.gmail.com>
 <6fd8b288-2719-424b-92d2-3dcfe03bbaef@kernel.org>
In-Reply-To: <6fd8b288-2719-424b-92d2-3dcfe03bbaef@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 10:41:49 +0300
X-Gm-Features: AX0GCFuptTN7rW2JH_tCQODkOv0v52_-cLOf2n8vjiQpW1qB9YrCGf5hMVaDiLA
Message-ID: <CAC_iWjJcC7sK+71GVZHrXzPL=e3N_uFnKPnhSEi=PJkPwUywsA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v2] page_pool: import Jesper's page_pool benchmark
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jesper,

On Wed, 4 Jun 2025 at 11:39, Jesper Dangaard Brouer <hawk@kernel.org> wrote=
:
>
>
>
> On 28/05/2025 21.46, Mina Almasry wrote:
> > On Wed, May 28, 2025 at 2:28=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >>
> >> Mina Almasry <almasrymina@google.com> writes:
> >>
> >>> On Mon, May 26, 2025 at 5:51=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
> >>>>> Fast path results:
> >>>>> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.368 ns
> >>>>>
> >>>>> ptr_ring results:
> >>>>> no-softirq-page_pool02 Per elem: 527 cycles(tsc) 195.187 ns
> >>>>>
> >>>>> slow path results:
> >>>>> no-softirq-page_pool03 Per elem: 549 cycles(tsc) 203.466 ns
> >>>>> ```
> >>>>>
> >>>>> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> >>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>>> Cc: Jakub Kicinski <kuba@kernel.org>
> >>>>> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> >>>>>
> >>>>> Signed-off-by: Mina Almasry <almasrymina@google.com>
> >>>>
> >>>> Back when you posted the first RFC, Jesper and I chatted about ways =
to
> >>>> avoid the ugly "load module and read the output from dmesg" interfac=
e to
> >>>> the test.
> >>>>
> >>>
> >>> I agree the existing interface is ugly.
> >>>
> >>>> One idea we came up with was to make the module include only the "in=
ner"
> >>>> functions for the benchmark, and expose those to BPF as kfuncs. Then=
 the
> >>>> test runner can be a BPF program that runs the tests, collects the d=
ata
> >>>> and passes it to userspace via maps or a ringbuffer or something. Th=
at's
> >>>> a nicer and more customisable interface than the printk output. And =
if
> >>>> they're small enough, maybe we could even include the functions into=
 the
> >>>> page_pool code itself, instead of in a separate benchmark module?
> >>>>
> >>>> WDYT of that idea? :)
> >>>
> >>> ...but this sounds like an enormous amount of effort, for something
> >>> that is a bit ugly but isn't THAT bad. Especially for me, I'm not tha=
t
> >>> much of an expert that I know how to implement what you're referring
> >>> to off the top of my head. I normally am open to spending time but
> >>> this is not that high on my todolist and I have limited bandwidth to
> >>> resolve this :(
> >>>
> >>> I also feel that this is something that could be improved post merge.
> >>> I think it's very beneficial to have this merged in some form that ca=
n
> >>> be improved later. Byungchul is making a lot of changes to these mm
> >>> things and it would be nice to have an easy way to run the benchmark
> >>> in tree and maybe even get automated results from nipa. If we could
> >>> agree on mvp that is appropriate to merge without too much scope cree=
p
> >>> that would be ideal from my side at least.
> >>
> >> Right, fair. I guess we can merge it as-is, and then investigate wheth=
er
> >> we can move it to BPF-based (or maybe 'perf bench' - Cc acme) later :)
> >
> > Thanks for the pliability. Reviewed-bys and comments welcome.
> >
> > Additionally Signed-off-by from Jesper is needed I think. Since most
> > of this code is his, I retained his authorship. Jesper, whenever this
> > looks good to me, a signed-off-by would be good and I would carry it
> > to future versions. Changing authorship to me is also fine by me but I
> > would think you want to retain the credit.
>
> Okay, I think Ilias'es comment[1] and ACK convinced me, let us merge
> this as-is.  We have been asking people to run it over several years
> before accepting patches. We shouldn't be pointing people to use
> out-of-tree tests for accepting patches.
>
> It is not perfect, but it have served us well for benchmarking in the
> last approx 10 years (5 years for page_pool test).  It is isolated as a
> selftest under (tools/testing/selftests/net/bench/page_pool/).
>
> Realistically we are all too busy inventing a new "perfect" benchmark
> for page_pool. That said, I do encourage others with free cycles to
> integrated a better benchmark test into `perf bench`.  Then we can just
> remove this module again.

I'll spend some time looking at acme comments. They seem to be moving
towards the right direction

Thanks
/Ilias
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>
>   [1]
> https://lore.kernel.org/all/CAC_iWjLmO4XZ_+PBaCNxpVCTmGKNBsLGyeeKS2ptRrep=
n1u0SQ@mail.gmail.com/
>
> Thanks Mina for pushing this forward,
> --Jesper

