Return-Path: <netdev+bounces-241958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1145C8B031
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A267F4E07B6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC9A305E3A;
	Wed, 26 Nov 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKFUTTM9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353F1E231E
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175267; cv=none; b=WZWXxfumg8Z09TLSYuh2Psv5YiGeUeYMKw9S7Rsb/zfFyeyn582ulcaJKVZnFfDrJixAbW4DkHoIsvBI/ht8lr8iaBtdeA9/aC+Gt7tu7zOVg01d6XXATIVqWn9TsfhW5OKDBSmYC98KUfLopz06NQiiHrtkdXMXjqebf2m2t5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175267; c=relaxed/simple;
	bh=7y8w7roHw5EJwptKzj/Wjr8IIzz48+8xCHCYaeqQTZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHRgKSrPF97cJTSwIOKGtnHN2QizF4VRJjE8dN3yp57YydRgczW0dCCpm+In+iBP+d+N18Wy+SJrgqpR3fEmLQ4e4+CiR9HDndb5iySIL8WcbFqesjL0435JF4zg7tYtuHib6RMQinv89Lt9HxOi4+F57MyNaS/9R/0P9htr4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKFUTTM9; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so132841cf.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764175263; x=1764780063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/VkGz7XFczAsn+ARq43qsAHt4ICuHhMnklqVguGxkw=;
        b=vKFUTTM9CiyDsejh4CFFQvN6oFxjWd2mnBAE7a97KEn7g5hT8CI1E/OwCVP6irJYk5
         8vQUCD0UdyLIw6qzeMCRjcBr9Uxy7yKL8qDviIDCQvdSnLJ13OEuRuPSgj7TvFnrqXLQ
         yAyL0un8GhzfkvPYV+vPJ59GP5o1tSumP0UTOI65i+jrt/XUQDhg8rsX36lc2AUvG0bo
         uhdKeUj3bZBQLAwLVKJi/ZtRSbs3dKrfZh/vw9wbaVoxMzGzVn6MfEVz7lSa0Br6jQ4e
         lT/RkFj5XUbgExNbb8YKllpbF8yXnayXFqc75dP73kTkpdTRzO2W+a3RbA1PTaPSMpoP
         RUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764175263; x=1764780063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z/VkGz7XFczAsn+ARq43qsAHt4ICuHhMnklqVguGxkw=;
        b=b1wRYwgwhUUfckWnsAmvEs3svBly1sIcMvHh4bt7SyGZNVDALVTFFVZ8dDCLn2GoaN
         KYgZtmuy66HcLVN8aLU5dik1HEH/kKBl2EplsnBPgV1U7Igrv2x8THyYBcHKSYDofonf
         EYWTexV24G1UCwv+qsxpBB94rxKsL2IYI+whZKg3M8Be5SE0XhEMaygcPwUABoATO5Qd
         PMlbWr/keMbulvtbEn3LS0D8z4GJ4w7SMstduxUp5XXBvls/U+jlYrRqDnXoded7t47+
         Yg7YT/z2BGg2AGJ/lri9pMIRVfnruFuiPEGO+UQcLfEP8J+BWSr36jnWoaeSVp4JafUp
         J47g==
X-Forwarded-Encrypted: i=1; AJvYcCWOrSKEbOXdbUBQWRP+2fgtvnRzMAMLVrc/uiDnpId778Rntb6Be2WDyGO+4nHovgEGrFWEgfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguEVkwybSqUKtUoE6YocRKphLWH+PPkDHa5s0FK4T97ukc4WE
	tRBySRiEQyky3qwvetZQOh/QWaLVPKZqxIA7segLDcWd+9WZVK16jj0XrOzqP9p59/JOQy9GqOq
	PuBRFnI+42K3QvdALpTKlUbqrTJI48ubh9b2K4PMc
X-Gm-Gg: ASbGncutlOs6NX7t+Km3yVNKBViyj3W4kr5lm3bQ/BrDULvMZhdJ2968mqm3+BPmU/+
	2KL9e/MftP3lrnoRtH8rk2JxHirKL1N7USH+AnE+6LJ7aNa/FOstWMPnWz6cWF0PpYGI5sd/Na0
	laV9ZAX+/tXeiL3F8L5Usq0OgaxvISbmM7qxZSK3HkVhJRQlNJVFvXYprHNnEKIktnfkA3lHiQQ
	GrgxOsu2oe3Ppuqev0b5wRYcjI0RYoxboGlebN2B/vHUyywmraQExWRFFF7NuezBR/00kc=
X-Google-Smtp-Source: AGHT+IG2uY12CkJWptt8xIWc0I9Mha4k79Ga9Bn8sgLpN3z5zoXOgSCI2bF+TsCsUa/Mb+iXjiIOKBRJusvdGlfkoUg=
X-Received: by 2002:ac8:5fce:0:b0:4ee:483:3123 with SMTP id
 d75a77b69052e-4efbdaf2d1cmr99415171cf.67.1764175262427; Wed, 26 Nov 2025
 08:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124200825.241037-1-jhs@mojatatu.com> <20251124145115.30c01882@kernel.org>
 <CAM0EoM=jDt_CeCop82aH=Fch+4M9QawX4aQdKdiUCsdFzuC2rQ@mail.gmail.com> <CAM0EoM=Rci1sfLFzenP9KyGhWNuLsprRZu0jS5pg2Wh35--4wg@mail.gmail.com>
In-Reply-To: <CAM0EoM=Rci1sfLFzenP9KyGhWNuLsprRZu0jS5pg2Wh35--4wg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Nov 2025 08:40:51 -0800
X-Gm-Features: AWmQ_bmsEKBtjkDxLqvI2o2s_wDW3H2Yw11SobtOtN28wUAJ429mDuZW-cQFp2g
Message-ID: <CANn89iJiapfb3OULLv8FxQET4e-c7Kei_wyx2EYb7Wt_0qaAtw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 8:26=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Nov 25, 2025 at 11:20=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Mon, Nov 24, 2025 at 5:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Mon, 24 Nov 2025 15:08:24 -0500 Jamal Hadi Salim wrote:
> > > > When doing multiport mirroring we dont detect infinite loops.
> > > >
> > > > Example (see the first accompanying tdc test):
> > > > packet showing up on port0 ingress mirred redirect --> port1 egress
> > > > packet showing up on port1 egress mirred redirect --> port0 ingress
> > > >
> > > > Example 2 (see the second accompanying tdc test)
> > > > port0 egress --> port1 ingress --> port0 egress
> > > >
> > > > Fix this by remembering the source dev where mirred ran as opposed =
to
> > > > destination/target dev
> > > >
> > > > Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > >
> > > Hm, this breaks net/fib_tests.sh:
> > >
> > > # 23.80 [+0.00] IPv4 rp_filter tests
> > > # 25.63 [+1.84]     TEST: rp_filter passes local packets             =
                   [FAIL]
> > > # 26.65 [+1.02]     TEST: rp_filter passes loopback packets          =
                   [FAIL]
> > >
> > > https://netdev-3.bots.linux.dev/vmksft-net/results/400301/10-fib-test=
s-sh/stdout
> > >
> > > Not making a statement on whether the fix itself is acceptable
> > > but if it is we gotta fix that test too..
> >
> > Sigh. I will look into it later.
> > Note: Fixing this (and the netem loop issue) would have been trivial
> > if we had those two skb ttl fields that were taken away.
> > The human hours spent trying to detect and prevent infinite loops!
> >
>
> Ok, I spent time on this and frankly cant find a way to fix the
> infinite loop that avoids adding _a lot more_ complexity.
> We need loop state to be associated with the skb. I will restore the
> two skb bits and test. From inspection, i see one bit free but i may
> be able to steal a bit from somewhere. I will post an RFC and at
> minimal that will start a discussion and maybe someone will come up
> with a better way of solving this.
>
> Eric, there's another issue as well involving example
> port0:egress->port0:egress  - I have a patch but will post it later
> after some testing.

Adding bits for mirred in skb would be quite unfortunate.
Argument of 'we have available space, let's use/waste it' is not very appea=
ling.

Do we really need to accept more than one mirred ?

What is a legitimate/realistic use for MIRRED_NEST_LIMIT =3D=3D 4 ?

