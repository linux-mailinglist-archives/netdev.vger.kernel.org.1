Return-Path: <netdev+bounces-163382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44501A2A125
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9718A167CA7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791F22489A;
	Thu,  6 Feb 2025 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbTKch4B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1020B208
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824238; cv=none; b=mKAFwXuqZHhWMx6uFlE5K53md9Eluzxdq3rr+nLs1Hhlje1NU4c54wLb7/LJP27BK0f4C3SrsHftQQuFemd9HoGoH9Ce0fk61Pt9oEf4a19p8UaPwa2cNnRCS+2LQBX6yJRGDxSWmP4Ae1mge+G7oCM5AN1AyQqTDlrg8X5pYfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824238; c=relaxed/simple;
	bh=ZvbC5bl9Zgv+itPd8xbAgTouBghTIUeyzpyhP6nf5Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQBRm68/2cTNlgWUPBb3AcEjk0gFdshSpZjPLe9qd89u6XVmqasR93dCGoonXgdpehOvd/bE4AVXGQQt5UrOEg0RGNv1Wor9JovkJHtOfjd0oZ0c878Uc7LLikQwHJLFJUlFARsUlyVEgvzbWEmieq0wUBNgmPT7drOOIoEeoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbTKch4B; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso35205e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 22:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738824235; x=1739429035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmMqySQiSDWi7LoULmK0I+gXlpf75/iIkvdAuPPjMzU=;
        b=JbTKch4Bw7ZAzTquieOKfDnzB8Ed7b9oD7RDSRMUw/Qwhf41XK8458j1sgHHdKlRU2
         trXe7LwmjKMKwfhJg+8slRHbRSN13ns+N11mx3JeoYj/MeM3EnzLJQO82JzGwjm3odBA
         y34xkbay/ir53Sv3qNyQfscvg36YM8rsJpPtfPgZ5PRml+9FgSNU6pgFhok8zDjBKz9Z
         sOB1uvx8WMtyHKZ0q3H0l4/p2PqhNrBA6/wmaWptsKDbgYBq7jGZS99q4GK53ZegS+CM
         TQ9vmFINHyv6qiqo51QRPk+xsZHLpdK5wixvxtrBK2527Pu368slyQl5N6wgJHnFAm6a
         L60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738824235; x=1739429035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmMqySQiSDWi7LoULmK0I+gXlpf75/iIkvdAuPPjMzU=;
        b=IqsNtlanQVA9e37xPE5r0sqWxOcXUF5/HayOg5fPePH50Pq9QCy4oPmZAcSwP0A65E
         dGjMSvNzw87eUh37jDe2fmn7ZbU7i8yPQls6GfFu/Y3VI83xuybjYfR59lnIjUas4jeF
         dBrPxntdpQHMon+7Zq3jY++kglevZacQUcWpb99IbB2P83uSf7l4gCqfB3vS4clwUsxR
         d72GkrWxR9tilhENi7hUcBPp4IQ0JR49iySgnBlEubY1SHZEomMJv3OaFr67iP9ff06O
         50hPfj13Quow51G4VgolC3IpCQMzxDb2WJXuiqU4W/Ig17zKF+Uy0UWYKZrsESP92ogL
         caEg==
X-Forwarded-Encrypted: i=1; AJvYcCXoYwIydGDC2Yxd126ZcLOgwcU0trmoZZcEa4ZjWKxfGSjCuNaezZNfkSzpXDvFhVj+QwkcWQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9o+xo9Vag6RjSjR9enHSeNQR5SJj86cSxkki8EifSRU1kmTX
	hLuG+prd6lxee8kQzvC+vLFu8UQn4DZcaOgOy05coYJGv2Qkg6ILm56MDNAqdq9y2C/lg7/Abu0
	g0rBu8OyeO8Z+Y3/AQmnuYaLO7IWdGTYiuYv8
X-Gm-Gg: ASbGnctcgXr+EQSfrTg/H8Qt70XMn0rCoh5OKYtavXm8Wz4gJ57+b/MlNiDlfZqnGmS
	DH1BLSBtP+vqCvwY0k4ewhavrV9ajy8HI7he0H5W6l9PPpj3icX2XKWe1MnW771C5kJRi1dus5m
	RqpHglFXH5hpFhjkXVrSIc1EODXBJTHQ==
X-Google-Smtp-Source: AGHT+IG77c+U//F1+0vhyAbTtmU3bbj1lfQCGEbSQu54WF8osaHPNx7REJaN9ZCeYHu1EAz1wZVHF55HQZx3Ptrxt0o=
X-Received: by 2002:a05:600c:1d14:b0:434:a0fd:95d9 with SMTP id
 5b1f17b1804b1-4391a84fb20mr454305e9.5.1738824235155; Wed, 05 Feb 2025
 22:43:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com> <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
 <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>
 <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2> <b2c7d2dc-595f-4cae-ab00-61b89243fc9e@uwaterloo.ca>
 <CAAywjhS69zRTBM7ZLNR08kL+anYuffppzU5ZuNORxKGQgo7_TA@mail.gmail.com> <6eeb6128-cf12-4997-a820-54c56eb93656@uwaterloo.ca>
In-Reply-To: <6eeb6128-cf12-4997-a820-54c56eb93656@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 5 Feb 2025 22:43:43 -0800
X-Gm-Features: AWEUYZkEqZBsp6z7wVjlR771uufuMGCrKUelB4eD9EqdlmaIk2t_zsZSeV8Uq9U
Message-ID: <CAAywjhRmtf36KHo9iV91KS4C+40d3Yks0rHBmKETvV_XUvCAxA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:50=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.c=
a> wrote:
>
> On 2025-02-05 23:43, Samiullah Khawaja wrote:
> > On Wed, Feb 5, 2025 at 5:15=E2=80=AFPM Martin Karsten <mkarsten@uwaterl=
oo.ca> wrote:
> >>
> >> On 2025-02-05 17:06, Joe Damato wrote:
> >>> On Wed, Feb 05, 2025 at 12:35:00PM -0800, Samiullah Khawaja wrote:
> >>>> On Tue, Feb 4, 2025 at 5:32=E2=80=AFPM Martin Karsten <mkarsten@uwat=
erloo.ca> wrote:
> >>>>>
> >>>>> On 2025-02-04 19:10, Samiullah Khawaja wrote:
> >>
> >> [snip]
> >>
> >>>>> Note that I don't dismiss the approach out of hand. I just think it=
's
> >>>>> important to properly understand the purported performance improvem=
ents.
> >>>> I think the performance improvements are apparent with the data I
> >>>> provided, I purposefully used more sockets to show the real
> >>>> differences in tail latency with this revision.
> >>>
> >>> Respectfully, I don't agree that the improvements are "apparent." I
> >>> think my comments and Martin's comments both suggest that the cover
> >>> letter does not make the improvements apparent.
> >>>
> >>>> Also one thing that you are probably missing here is that the change
> >>>> here also has an API aspect, that is it allows a user to drive napi
> >>>> independent of the user API or protocol being used.
> >>>
> >>> I'm not missing that part; I'll let Martin speak for himself but I
> >>> suspect he also follows that part.
> >>
> >> Yes, the API aspect is quite interesting. In fact, Joe has given you
> >> pointers how to split this patch into multiple incremental steps, the
> >> first of which should be uncontroversial.
> >>
> >> I also just read your subsequent response to Joe. He has captured the
> >> relevant concerns very well and I don't understand why you refuse to
> >> document your complete experiment setup for transparency and
> >> reproducibility. This shouldn't be hard.
> > I think I have provided all the setup details and pointers to
> > components. I appreciate that you want to reproduce the results and If
> > you really really want to set it up then start by setting up onload on
> > your platform. I cannot provide a generic installer script for onload
> > that _claims_ to set it up on an arbitrary platform (with arbitrary
> > NIC and environment). If it works on your platform (on top of AF_XDP)
> > then from that point you can certainly build neper and run it using
> > the command I shared.
>
> This is not what I have asked. Installing onload and neper is a given.
> At least, I need the irq routing and potential thread affinity settings
> at the server. Providing a full experiment script would be appreciated,
> but at least the server configuration needs to be specified.
- There is only 1 rx/tx queue and IRQs are deferred as mentioned in
the cover letter. I have listed the following command for you to
configure your netdev with 1 queue pair.
```
sudo ethtool -L eth0 rx 1 tx 1
```
- There is no special interrupt routing, there is only 1 queue pair
and IDPF shares the same IRQ for both queues. The results remain the
same whatever core I pin this IRQ to, I tested with core 2, 3 and 23
(random) on my machine. This is mostly irrelevant since interrupts are
deferred in both tests. I don't know how your NIC uses IRQs and
whether the tx and rx are combined, so you might have to figure that
part out. Sorry about that.
- I moved my napi polling thread to core 2 and as you can see in the
command I shared I run neper on core 3-10. I enable threaded napi at
device level for ease of use as I have only 1 queue pair and they both
share a single NAPI on idpf. Probably different for your platform. I
use following command,
```
  echo 2 | sudo tee /sys/class/net/eth0/threaded
  NAPI_T=3D$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
  sudo chrt -o  -p 0 $NAPI_T
  sudo taskset -pc 2 $NAPI_T
```
>
> Thanks,
> Martin
>

