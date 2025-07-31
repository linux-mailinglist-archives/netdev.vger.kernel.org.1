Return-Path: <netdev+bounces-211271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C4FB176EB
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 22:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56637ACF68
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327D1FBC8E;
	Thu, 31 Jul 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfz6E81l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AE32F24
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992317; cv=none; b=tG2ypLKNVRnyLU8E5ZpnJ10WMlas5o/dQMZ62GqKJnGPAju2kU2xq6c7AO5vEW1e+/h/Glt2yaoZNcNkceBvan30xm7XKdUAQg+ljCR0fbGlN5bDCDEBO3nTyaTe8MhxJNSDJwCQtRTkZmn/8WhH8H/FYIiHMBlI18AtGbI6ISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992317; c=relaxed/simple;
	bh=8IbJar48/v9YPCSvc+Grz9jUhWVmzHy/BOA2VYHTIaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+VPhfy9Xpis0EpZWalDVOVT5dLHXBmKRfuI0QS6c1Y/rRaRoJvkjdXaAuYyhVeqIrasAuniNhDkFErbAtWD4zLDiO6DsN3i0kpA/NN88YMjgiYbYyJ/RrFXhd6dQMPdwWvR2rGqssy4J0bNrNzBv175c5e+qm6T/+VUxbASEeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfz6E81l; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24070ef9e2eso37735ad.0
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 13:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753992315; x=1754597115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgnJAQKGTS/8YGllFAHSXdVI3iH3SryFuJtNVFi559Q=;
        b=pfz6E81ls0r/P1aLoYfZUR5q1wuCGAXyAEwwDFYIViph7SHDCpFruB0HoBWEqYdebr
         lx7nAOyr91zlnt7cMGq+OpPmHLwAyrCvJjo1/4HThZ6m/c4tWmE7s37h+MStrBtyJdeu
         8BwXVTRO05JZw+a+WhCeYI32Ma14dpk1PmB0NJFzjKhqLaBNCXK9cYbeppfoziCIL0v2
         hnOogidu/jSqnPbxlzjWygSbVu5aioSmXk2WGhCNe+jLCZZFskIIU1HIcYlBrtjAEHfQ
         XQsOyBPHz4lxQaI1b3o+50vXlTYALE/7PRZG3LPpIsCni0GZeDtLLB4bLDUA47cTEtRn
         gNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753992315; x=1754597115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgnJAQKGTS/8YGllFAHSXdVI3iH3SryFuJtNVFi559Q=;
        b=gHkhzZTWmO3Mn8t2K7whGEI/d7DUaihSrdAg4z87LZN2tzyZjCmCC1f9vhpE4fmHQt
         /Lm/IG3XKCMB1UX9kZGfbjuRKxWslJbqOdOZYXJg7b59S67Uk5wMHCHEJSBsCM7Y5Cwv
         A3novkLFGsfQ9tMHVZqM1/VclbJJBumSIs1Pd2razohnpSUp9xLai0BL94bYHjAgCD8T
         nKbF/B5iuD9YbJTb5Myu450+oUqRRnazMh+963PhQ8L5vgaOMOmhsGRHkIsUFjA7BqLp
         MDaEs+LXIjs5RP09MqvFqCWcPxQ/oCApsuSB8YnXwlyKXKQxYVlV5SikOJdNDyv275Nx
         KD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlu8GT/w6sP/qZHUK6xxgOAVNBKmEkSbzXPgXcdPsz9s3BYAwfyZJ0UhE7ypV1qln3qRKEzRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pt0+GLJhyI7ABn4ii2W/7W0P/2lW5Of4K1Lu9wBeZY1QMB3v
	gUy5j9OEejQHLxQF7AXICBVZdVyPQ5PSy5kA7z9BjPBVaeafa15R9RuhMHdQWPEnjqLl2mQE7Xh
	w2FfnxDF6dduOOZgP/FguZsHzXLl2+kpWEyoWuWIr
X-Gm-Gg: ASbGncvxJiv6+0Tg8CrCeUo235kSKWnHw74u49I/8+6RFOCwTyP3V8XyANMdGGxwYf+
	fvTxIKhgFJvn4oKOYeRY0jvoLAXHvpabAVR2CSEzR7D6cG+hMfdxI+oMqyYghL2Qdr7ZI7B1m55
	iOFmSmiKJrYiyRNwNvCMvZouMTuTW6xXSose7QZOrKTeRjmfujGTl1QW4unvb2oaDpZ7B1nfgbs
	Z3G+C2wyDw9iF6JClQjhm8DxtKD6c7k+74G8KuNCkDRUg==
X-Google-Smtp-Source: AGHT+IHtMk59rcKq4sZ537GwBJiHPczIh1Z6Y8ntIk1eA4lZ+d5jz7uHfjW6thMGDt5c3wgPMZoT6iGNGHzAVTFooBA=
X-Received: by 2002:a17:902:e803:b0:240:4464:d486 with SMTP id
 d9443c01a7336-24227e38a05mr730945ad.13.1753992314749; Thu, 31 Jul 2025
 13:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753694913.git.asml.silence@gmail.com> <aIevvoYj7BcURD3F@mini-arch>
 <df74d6e8-41cc-4840-8aca-ad7e57d387ce@gmail.com> <aIfb1Zd3CSAM14nX@mini-arch>
 <0dbb74c0-fcd6-498f-8e1e-3a222985d443@gmail.com> <aIf0bXkt4bvA-0lC@mini-arch>
 <52597d29-6de4-4292-b3f0-743266a8dcff@gmail.com> <aIj3wEHU251DXu18@mini-arch>
 <46fabfb5-ee39-43a2-986e-30df2e4d13ab@gmail.com> <aIo_RMVBBWOJ7anV@mini-arch>
 <CAHS8izPYahW_GkPogatiVF-eZFRGV-zqH3MA=VNBjw4jfgCzug@mail.gmail.com> <364568c6-f93e-42e1-a13c-f55d7f912312@gmail.com>
In-Reply-To: <364568c6-f93e-42e1-a13c-f55d7f912312@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 31 Jul 2025 13:05:02 -0700
X-Gm-Features: Ac12FXw0R_eEKfeEnH2eLsDb7pVg6NmF4zcE39RVrbA5xRwceCNsOIksG4ktoBY
Message-ID: <CAHS8izM9238zKuFy1ifyigXmG8sbB8h=A=XqtLz-i0U2WM3vqw@mail.gmail.com>
Subject: Re: [RFC v1 00/22] Large rx buffer support for zcrx
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	io-uring@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, 
	horms@kernel.org, davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 12:56=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 7/31/25 20:34, Mina Almasry wrote:
> > On Wed, Jul 30, 2025 at 8:50=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> >>
> >> On 07/30, Pavel Begunkov wrote:
> >>> On 7/29/25 17:33, Stanislav Fomichev wrote:
> >>>> On 07/28, Pavel Begunkov wrote:
> >>>>> On 7/28/25 23:06, Stanislav Fomichev wrote:
> >>>>>> On 07/28, Pavel Begunkov wrote:
> >>>>>>> On 7/28/25 21:21, Stanislav Fomichev wrote:
> >>>>>>>> On 07/28, Pavel Begunkov wrote:
> >>>>>>>>> On 7/28/25 18:13, Stanislav Fomichev wrote:
> >>>>>>> ...>>> Supporting big buffers is the right direction, but I have =
the same
> >>>>>>>>>> feedback:
> >>>>>>>>>
> >>>>>>>>> Let me actually check the feedback for the queue config RFC...
> >>>>>>>>>
> >>>>>>>>> it would be nice to fit a cohesive story for the devmem as well=
.
> >>>>>>>>>
> >>>>>>>>> Only the last patch is zcrx specific, the rest is agnostic,
> >>>>>>>>> devmem can absolutely reuse that. I don't think there are any
> >>>>>>>>> issues wiring up devmem?
> >>>>>>>>
> >>>>>>>> Right, but the patch number 2 exposes per-queue rx-buf-len which
> >>>>>>>> I'm not sure is the right fit for devmem, see below. If all you
> >>>>>>>
> >>>>>>> I guess you're talking about uapi setting it, because as an
> >>>>>>> internal per queue parameter IMHO it does make sense for devmem.
> >>>>>>>
> >>>>>>>> care is exposing it via io_uring, maybe don't expose it from net=
link for
> >>>>>>>
> >>>>>>> Sure, I can remove the set operation.
> >>>>>>>
> >>>>>>>> now? Although I'm not sure I understand why you're also passing
> >>>>>>>> this per-queue value via io_uring. Can you not inherit it from t=
he
> >>>>>>>> queue config?
> >>>>>>>
> >>>>>>> It's not a great option. It complicates user space with netlink.
> >>>>>>> And there are convenience configuration features in the future
> >>>>>>> that requires io_uring to parse memory first. E.g. instead of
> >>>>>>> user specifying a particular size, it can say "choose the largest
> >>>>>>> length under 32K that the backing memory allows".
> >>>>>>
> >>>>>> Don't you already need a bunch of netlink to setup rss and flow
> >>>>>
> >>>>> Could be needed, but there are cases where configuration and
> >>>>> virtual queue selection is done outside the program. I'll need
> >>>>> to ask which option we currently use.
> >>>>
> >>>> If the setup is done outside, you can also setup rx-buf-len outside,=
 no?
> >>>
> >>> You can't do it without assuming the memory layout, and that's
> >>> the application's role to allocate buffers. Not to mention that
> >>> often the app won't know about all specifics either and it'd be
> >>> resolved on zcrx registration.
> >>
> >> I think, fundamentally, we need to distinguish:
> >>
> >> 1. chunk size of the memory pool (page pool order, niov size)
> >> 2. chunk size of the rx queue entries (this is what this series calls
> >>     rx-buf-len), mostly influenced by MTU?
> >>
> >> For devmem (and same for iou?), we want an option to derive (2) from (=
1):
> >> page pools with larger chunks need to generate larger rx entries.
> >
> > To be honest I'm not following. #1 and #2 seem the same to me.
> > rx-buf-len is just the size of each rx buffer posted to the NIC.
> >
> > With pp_params.order =3D 0 (most common configuration today), rx-buf-le=
n
> > =3D=3D 4K. Regardless of MTU. With pp_params.order=3D1, I'm guessing 8K
> > then, again regardless of MTU.
>
> There are drivers that fragment the buffer they get from a page
> pool and give smaller chunks to the hw. It's surely a good idea to
> be more explicit on what's what, but from the whole setup and uapi
> perspective I'm not too concerned.
>
> The parameter the user passes to zcrx must controls 1. As for 2.
> I'd expect the driver to use the passed size directly or fail
> validation, but even if that's not the case, zcrx / devmem would
> just continue to work without any change in uapi, so we have
> the freedom to patch up the nuances later on if anything sticks
> out.
>

I indeed forgot about driver-fragmenting. That does complicate things
quite a bit.

So AFAIU the intended behavior is that rx-buf-len refers to the memory
size allocated by the driver (and thun memory provider), but not
necessarily the one posted by the driver if it's fragmenting that
piece of memory? If so, that sounds good to me. Although I wonder if
that could cause some unexpected behavior... Someone may configure
rx-buf-len to 8K on one driver and get actual 8K packets, but then
configure rx-buf-len on another driver and get 4K packets because the
driver fragmented each buffer into 2...

I guess in the future there may be a knob that controls how much
fragmentation the driver does?

--=20
Thanks,
Mina

