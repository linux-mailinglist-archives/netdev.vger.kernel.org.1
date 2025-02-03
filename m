Return-Path: <netdev+bounces-162196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA351A26186
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 18:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281C316648C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29120A5EA;
	Mon,  3 Feb 2025 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="YemeYtzJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1A3A8CB
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738604084; cv=none; b=gZyjXDAqM5jJqzbBJz85mnU6IllSd3kH2X4TtC0vM+lyxknKi48TsXtNlqpnCDm36r04TFr65Reo44rz5Szk5hqTDyql1sF8t8kbu2Esh1ewcxpeGHZrQOQ+h5yiqblsUxxMFrYMJP5vT96W4b2VzSvNRe6a/xEAIi4Jow3J4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738604084; c=relaxed/simple;
	bh=O/Pf0NLLE/MM5KEJWOmjEHZ9l5nWd44h+ljMqiofAm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDxWJcFgHnTpl0pfNOvY9xYnmOZpWim0CgQZyFN3ElV1nbpsdtN6vg1bs3QAUMnrTZ1STtFa4H31vjmTfpl0MeH5J8nuhacO2jXLU0w+1dAoZqGyqpwY/mCobF68J5slA2GTLAj1D9rxHnfQ4XcrDKmG+zIBGUSOugsjkQmGe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=YemeYtzJ; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iOYsq5nv6fzK48jEXvEuXNfqOw+ogfzooH908x/Y4j0=; t=1738604082; x=1739468082; 
	b=YemeYtzJFWWsCokA95Mxht4oxH3gMlmnTDhJwIY9tFAHmyl4b3+tsKMZPNnIKeEiLgoCcAh0unX
	MmzMS90DjLlHNsuX1H8SKkvyliqmSUZKITvTaIXmuHDYTfFSxZEJNp7ZnQU/+RxFnfMSW2WH4frMt
	IJ7ENk7oEC9bLmWVSqMmJ9VBvLKgByesx+08WoE2C5uQDYwIpg7mtMJXshP6DRA52ZO0jtkI2bP0Q
	OJeTJCsL0FAD5EiHGzCyvdWokAVcMQw/HyoW79XfLRBEFDzgB6WG6HU1NxeBJIXbUle1XLm4zaIVP
	/2HxGniUBTPdwTdoCQ+dJQSgDuWWyPtOERtw==;
Received: from mail-oa1-f53.google.com ([209.85.160.53]:55313)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tf0LD-0001WR-I6
	for netdev@vger.kernel.org; Mon, 03 Feb 2025 09:34:36 -0800
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29fcbf3d709so1447745fac.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 09:34:35 -0800 (PST)
X-Gm-Message-State: AOJu0YyxTOb5s/2AgMvCxNkf7im61juTMA54ddxvg6I+SKyvIbtZaXER
	apB4EH/DlzxgVbnkhEbEzs9eZct5k+HOP9cQ9+oFFuCHzH+qVRMM37tn6SaQKGfeGeaw/L62oyF
	lwifAa2cqhTNhIXmG2YGFmN61G6w=
X-Google-Smtp-Source: AGHT+IHQgbFhbDjV7BGwpXzHwKExCmQ5X4qruddyv/1L4klWtSpyC4mMsjLQYIa0SFKlmqRywvYHeCw/Dj2Cwl7s1V4=
X-Received: by 2002:a05:6870:2f01:b0:297:c04:9191 with SMTP id
 586e51a60fabf-2b32efdc084mr13641053fac.3.1738604074844; Mon, 03 Feb 2025
 09:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-9-ouster@cs.stanford.edu>
 <9083adf9-4e3f-47d9-8a79-d8fb052f99b5@redhat.com> <CAGXJAmxWOmPi-khSUugzOOjMSgVpWnn7QZ28jORK4sL9=vrA9A@mail.gmail.com>
 <82cdba95-83cb-4902-bb2a-a2ab880797a8@redhat.com> <CAGXJAmxLqnjnWr8sjooJRRyQ2-5BqPCQL8gnn0gzYoZ0MMoBSw@mail.gmail.com>
 <e7cdcca6-d0b2-4b59-a2ef-17834a8ffca3@redhat.com>
In-Reply-To: <e7cdcca6-d0b2-4b59-a2ef-17834a8ffca3@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 3 Feb 2025 09:33:59 -0800
X-Gmail-Original-Message-ID: <CAGXJAmx7ojpBmR7RiKm3umZ7QDaA8r-hgBTnxay11UCv42xWdA@mail.gmail.com>
X-Gm-Features: AWEUYZmYLM3e5XmOaplZm-O0N3M5qZ8_P5lzdKtL61JSDdZuJcfnxZ995Wbwaok
Message-ID: <CAGXJAmx7ojpBmR7RiKm3umZ7QDaA8r-hgBTnxay11UCv42xWdA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 5c460fe7d3aaafaf78d72307c0bc7e10

On Mon, Feb 3, 2025 at 1:17=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 1/31/25 11:35 PM, John Ousterhout wrote:
> > On Thu, Jan 30, 2025 at 1:57=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 1/30/25 1:48 AM, John Ousterhout wrote:
> >>> On Mon, Jan 27, 2025 at 2:19=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>>
> >>>> On 1/15/25 7:59 PM, John Ousterhout wrote:
> >>>>> +     /* Each iteration through the following loop processes one
> >> packet. */
> >>>>> +     for (; skb; skb =3D next) {
> >>>>> +             h =3D (struct homa_data_hdr *)skb->data;
> >>>>> +             next =3D skb->next;
> >>>>> +
> >>>>> +             /* Relinquish the RPC lock temporarily if it's needed
> >>>>> +              * elsewhere.
> >>>>> +              */
> >>>>> +             if (rpc) {
> >>>>> +                     int flags =3D atomic_read(&rpc->flags);
> >>>>> +
> >>>>> +                     if (flags & APP_NEEDS_LOCK) {
> >>>>> +                             homa_rpc_unlock(rpc);
> >>>>> +                             homa_spin(200);
> >>>>
> >>>> Why spinning on the current CPU here? This is completely unexpected,=
 and
> >>>> usually tolerated only to deal with H/W imposed delay while programm=
ing
> >>>> some device registers.
> >>>
> >>> This is done to pass the RPC lock off to another thread (the
> >>> application); the spin is there to allow the other thread to acquire
> >>> the lock before this thread tries to acquire it again (almost
> >>> immediately). There's no performance impact from the spin because thi=
s
> >>> thread is going to turn around and try to acquire the RPC lock again
> >>> (at which point it will spin until the other thread releases the
> >>> lock). Thus it's either spin here or spin there. I've added a comment
> >>> to explain this.
> >>
> >> What if another process is spinning on the RPC lock without setting
> >> APP_NEEDS_LOCK? AFAICS incoming packets targeting the same RPC could
> >> land on different RX queues.
> >>
> >
> > If that happens then it could grab the lock instead of the desired
> > application, which would defeat the performance optimization and delay =
the
> > application a bit. This would be no worse than if the APP_NEEDS_LOCK
> > mechanism were not present.
>
> Then I suggest using plain unlock/lock() with no additional spinning in
> between.

My concern here is that the unlock/lock sequence will happen so fast
that the other thread never actually has a chance to get the lock. I
will do some measurements to see what actually happens; if lock
ownership is successfully transferred in the common case without a
spin, then I'll remove it.


-John-

