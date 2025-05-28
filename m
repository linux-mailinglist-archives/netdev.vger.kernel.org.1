Return-Path: <netdev+bounces-194049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B51BAC71B9
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D0B3B095E
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 19:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E7E221F14;
	Wed, 28 May 2025 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orMDSJ5+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07002220F25
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461602; cv=none; b=jnqaKfPCaVR6gwrad4vwA4xGF5js5eVwr+kKg1khhVKvZgTJXuoPa0C175QqZ9svckI8aDmgeOTLAMYANpRCB7XljHyf/LiZGc+cwCJAkHuMs7HlMEPODQEyA1XnPoG7YSC1aPGoKVk49kzKrjpzotu2rNDQaaF3PtckCR7pqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461602; c=relaxed/simple;
	bh=+uNg2ZNM9774GNllUWRARlObsSVU4a3QOAeIWqn6Zs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OisLRoMyqvoqX25UY5y7KJ7mgwGXCMsvbNTyrp2nmdYsZCK3WS5By2vnpXi+DAcbX1g8NQ9cDxWyTBRnh/HGLT49dZFabB9JHif2pOi+EGvzHYjlotDKNvmtGyHoYOJPJJbZlm5mZzriG9HXEVIp4fQppU4xhqxULvPMquRhQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=orMDSJ5+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349068ebc7so44385ad.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748461599; x=1749066399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uNg2ZNM9774GNllUWRARlObsSVU4a3QOAeIWqn6Zs4=;
        b=orMDSJ5+ynn2T7LSl6Kkf7/LT1+JSI8vU1sRQ90H5PNnK3cB83I9Zw+lbiN3m4InKA
         K25QKoZZyKBZ1oA/6KbC1OT+N1LhWNzGEDgGSVzIKHvAVM9IKa6uzY7dWnQ1G3o+4O+w
         DnaBjklgNnO/1pZtAE+/wUj9cMk55pVxxjH4MelnaZ/FyZfqN/UOOGh2Ej245brU0pwv
         yRchogI+Bdk7QTSFiay9qZ9Vh5u/W5rOm0ipjS+P9TEa3Ay6XrenNAteqDSeR8GFbnua
         zn1fQSfxAe4VIJ8bFEajBcOHNAWw4vsIwIehja2poA/2znaImouWqkPriFO22JmzQ/Tt
         j78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748461599; x=1749066399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uNg2ZNM9774GNllUWRARlObsSVU4a3QOAeIWqn6Zs4=;
        b=JYRZnw+O+qEsUUTthxn6UDB5zeTdU/lkb5tPCw2SPNous1BJWtU8moHR6zp7Y+rpIj
         jTDYNKryAFxINZJFnX1WB5wAIStEw48qgdI2/aLvHwPyUl2+gdLKYXIDQKHhluhzhuu+
         srEVIEYP4Dn3iQao7NN2gOkpWj3zLzwqwLtnQEvK1ofuWmc6KEZDGSHsJ30wxYVs3fUt
         aarMjgsB7RkhLhRdFnpXTe1ZwmVovgKun6TeKZKXGUvgrSdVWzHTWLJ/TTFuYIU0M8Q8
         LJPNa9THzbmokr5HGWL5/mMVZs0rd085V7w7jfzScIpkslKSmWqknuH7/+aBmHfZckYM
         d2dg==
X-Gm-Message-State: AOJu0YwVFyftusNZcfI7tAgU9JLmAF0/v9mdMQXaPyBXpqXLt+bhKyTl
	tSjYFEetOWZJnyvgilWaI7ufL0IDl4wUlMhnm/Z5BPUL+h+mcnTeiBGWri5St03/zxyqAFmNOgF
	BSwp77Nvo7yY0J3sxComeYWvnzAGqE/hsoWA8BEej
X-Gm-Gg: ASbGnctiqSc+5Tu0iaM+Dpy74nhzHAD37jH1CpSdsEpWll3syBYbdHXq73Dl2dfHr0L
	+e/0PpKPU+Ad3cPwyWrS9BlY3V7YiqcgDKgo3rk6UwOZNb0sVBQQ8pMyjJBtGRX2qmBtr5a1HoK
	VPN0K4RNrSJ3IQbfKVWFkwFwSWVYRpqebQfkIGfI7zWhqx8Gdb7wcBfHx4D27/mLy0kn7XKMsJ5
	g==
X-Google-Smtp-Source: AGHT+IG5pJp+Ll9vBD2Ex9mtsA5ekYQjmYsVW8dgVZjb+a6ny2LQFZUjoGZtmZJcRrNBSbewuLItVb656yqYYibxVxo=
X-Received: by 2002:a17:903:46c3:b0:234:b441:4d4c with SMTP id
 d9443c01a7336-2350545f23fmr467515ad.5.1748461598995; Wed, 28 May 2025
 12:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525034354.258247-1-almasrymina@google.com>
 <87iklna61r.fsf@toke.dk> <CAHS8izOSW8dZpqgKT=ZxqpctVE3Y9AyR8qXyBGvdW0E8KFgonA@mail.gmail.com>
 <87h615m6cp.fsf@toke.dk>
In-Reply-To: <87h615m6cp.fsf@toke.dk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 28 May 2025 12:46:25 -0700
X-Gm-Features: AX0GCFu3OTeh8uk-NocaEzNOkLCNo2rSHU7frkp5goouJg3UdVULK6dSsjJSF88
Message-ID: <CAHS8izNDSTkmC32aRA9R=phqRfZUyz06Psc=swOpfVW5SW4R_w@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v2] page_pool: import Jesper's page_pool benchmark
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 2:28=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Mon, May 26, 2025 at 5:51=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >> > Fast path results:
> >> > no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.368 ns
> >> >
> >> > ptr_ring results:
> >> > no-softirq-page_pool02 Per elem: 527 cycles(tsc) 195.187 ns
> >> >
> >> > slow path results:
> >> > no-softirq-page_pool03 Per elem: 549 cycles(tsc) 203.466 ns
> >> > ```
> >> >
> >> > Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> >> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> > Cc: Jakub Kicinski <kuba@kernel.org>
> >> > Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> >> >
> >> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >>
> >> Back when you posted the first RFC, Jesper and I chatted about ways to
> >> avoid the ugly "load module and read the output from dmesg" interface =
to
> >> the test.
> >>
> >
> > I agree the existing interface is ugly.
> >
> >> One idea we came up with was to make the module include only the "inne=
r"
> >> functions for the benchmark, and expose those to BPF as kfuncs. Then t=
he
> >> test runner can be a BPF program that runs the tests, collects the dat=
a
> >> and passes it to userspace via maps or a ringbuffer or something. That=
's
> >> a nicer and more customisable interface than the printk output. And if
> >> they're small enough, maybe we could even include the functions into t=
he
> >> page_pool code itself, instead of in a separate benchmark module?
> >>
> >> WDYT of that idea? :)
> >
> > ...but this sounds like an enormous amount of effort, for something
> > that is a bit ugly but isn't THAT bad. Especially for me, I'm not that
> > much of an expert that I know how to implement what you're referring
> > to off the top of my head. I normally am open to spending time but
> > this is not that high on my todolist and I have limited bandwidth to
> > resolve this :(
> >
> > I also feel that this is something that could be improved post merge.
> > I think it's very beneficial to have this merged in some form that can
> > be improved later. Byungchul is making a lot of changes to these mm
> > things and it would be nice to have an easy way to run the benchmark
> > in tree and maybe even get automated results from nipa. If we could
> > agree on mvp that is appropriate to merge without too much scope creep
> > that would be ideal from my side at least.
>
> Right, fair. I guess we can merge it as-is, and then investigate whether
> we can move it to BPF-based (or maybe 'perf bench' - Cc acme) later :)

Thanks for the pliability. Reviewed-bys and comments welcome.

Additionally Signed-off-by from Jesper is needed I think. Since most
of this code is his, I retained his authorship. Jesper, whenever this
looks good to me, a signed-off-by would be good and I would carry it
to future versions. Changing authorship to me is also fine by me but I
would think you want to retain the credit.

--=20
Thanks,
Mina

