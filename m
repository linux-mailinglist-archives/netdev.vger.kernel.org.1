Return-Path: <netdev+bounces-72817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61E2859B78
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 05:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415731F22111
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6541CD0F;
	Mon, 19 Feb 2024 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBwFXXAv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A30257D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708318623; cv=none; b=Ib/Q/fFXGjWwp/Aac62uJJIHIkC+2WoQ2n7f6blXdJNwHNgHX3h3I7XtcZVjQiuPLYdgmUbAKlriPdNWx4PbIg56+dgWWGu+IMGDKJJWDrg8RyqKzRUctgS0Fak0aTreGJ0Y26gh4vur0C1fj7wpjxzA76CnB/UCjzl+5Siot/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708318623; c=relaxed/simple;
	bh=1Nzps5R4D8PytgSrziF3XorXt7blUH2Z7hYaceL9RwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlE0qFo7TfsyufMyaNYuqY8Zcn9+9owDjmkx6/vLWhJC4reRc26P7qTLsXg8WnabytUQS9VfR+U4YmQ3yNouotD3RPGf/idW07m3x33Y9ejDX6LdjLzSrWP5524dSauTC7fmEewmzTIuSlfSiqISX7TEr/fJIvbfYecIbdwtV6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBwFXXAv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso3529817a12.2
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 20:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708318620; x=1708923420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTXfu0cwtSnBbtNePiRNiaFlbycdA3nLaxp77WB7+1w=;
        b=iBwFXXAvNvbCLdbHu3peqNEhPmR7fzJx3l6hYOcKulbtMUaVwDocI8EEn4LCOT8A9M
         7AZLKWmIBr3o3RhIENmadc6BTRCrFaE2ROdNektVV2VsalZbHVOBjqOU5gfXyjqTCrxp
         MCH4wM1/3eqyTY8LqbiO5ZJJsbaKGn8vHlx3eFUQsquAfPex2GWRIHSQkJjPSXWiYIsA
         AsqUUR71bQ8NhGxcKGyFcfHVvMw8tzGJM/CqpIKzatG10P1ASeanSpRvKW1HV6nkujbi
         9FPba7i3uBk8exWwi2Ou/UMBN3DGDR1kBSFGl6gLD/YDM0QQbGT6Jmk62xYeN/w12W3m
         HYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708318620; x=1708923420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTXfu0cwtSnBbtNePiRNiaFlbycdA3nLaxp77WB7+1w=;
        b=EWKVo/hXQdCBnPy0qnZk7lk++NXmxOVAlFPy/2k3mLci1knMAxicNTsSeiZ7IOGTqg
         rp8mC7X2YfdBLErJwStGklpcrCoWqL1XtT8vHXoku1Qbqq7NunwQzHyZAif9oDkgm4+J
         ewbk3zxUPhrtejYfQsZ2R7i3U9i4cQkM3B6FA70B4QJLCeMLLFN7kT7xidKBWq91hYGU
         ozbKgp2H+LufRGd00DcEfaYWt046sE/c5QiEuEEEpadwo6r1HEF69HQN4i1qrDigpAGJ
         +xtI0UzW6c9h7yg0sYeo0kQrTPU/BkoL/Ogpfs0wmQUwtIOAx2dD8iqhcK8flv7UAjZv
         n3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWftzGBbRwXvSoYLYat31+w6xHkhjodemQ48NdGhEGv2c6+taSTn3zknb+GDE39Q2k15l33L3t+0b8E2UCz9G52BAvWLHxm
X-Gm-Message-State: AOJu0Yyj0FDj1vnRXupbc8Rtc/4tlqlBaajT4gNT34J49IqMSZrW+SBf
	lUTu/X7Kvu9mzsRIXR8HPuaTSC2IeJx2mMbBi9EmnB2RJugWe2p69andZF2FHnaUOk2UkOpOQwB
	4ktshGiVeA2Sf8WCi67IZsbpfG8DddbTe14c=
X-Google-Smtp-Source: AGHT+IEv+iYfaq7jtunNjEMLcD/wmx4JbQ06jxFdsXsTwNdT7bIjOXzmwIFrtcdiZjGWYg6w+jRFYBP4CfC5jcgy1m0=
X-Received: by 2002:a05:6402:3513:b0:564:151c:747a with SMTP id
 b19-20020a056402351300b00564151c747amr4126518edd.27.1708318620168; Sun, 18
 Feb 2024 20:57:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219032838.91723-2-kerneljasonxing@gmail.com> <20240219040630.94637-1-kuniyu@amazon.com>
In-Reply-To: <20240219040630.94637-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Feb 2024 12:56:23 +0800
Message-ID: <CAL+tcoC=zhoBFAO0dvU-ghQ3jCWq3Bpq_zPVY67B=D_uF3RZ5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/11] tcp: add a dropreason definitions and
 prepare for cookie check
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 12:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Mon, 19 Feb 2024 11:28:28 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Only add one drop reason to detect the condition of skb dropped
> > because of hook points in cookie check for later use.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > --
> > v6
> > Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amaz=
on.com/
> > 1. Modify the description NO_SOCKET to extend other two kinds of invali=
d
> > socket cases.
> > What I think about it is we can use it as a general indicator for three=
 kinds of
> > sockets which are invalid/NULL, like what we did to TCP_FLAGS.
> > Any better ideas/suggestions are welcome :)
> >
> > v5
> > Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=3DJkneEE=
M=3DnAj-28eNtcOCkwQjw@mail.gmail.com/
> > Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b=
6c@kernel.org/
> > 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one =
(Eric, David)
> > 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allo=
cation (Eric)
> > 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> > 4. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)
> > 5. adjust the title and description.
> >
> > v4
> > Link: https://lore.kernel.org/netdev/20240212172302.3f95e454@kernel.org=
/
> > 1. fix misspelled name in kdoc as Jakub said
> > ---
> >  include/net/dropreason-core.h | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index 6d3a20163260..3c867384dead 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -54,6 +54,7 @@
> >       FN(NEIGH_QUEUEFULL)             \
> >       FN(NEIGH_DEAD)                  \
> >       FN(TC_EGRESS)                   \
> > +     FN(SECURITY_HOOK)               \
> >       FN(QDISC_DROP)                  \
> >       FN(CPU_BACKLOG)                 \
> >       FN(XDP)                         \
> > @@ -105,7 +106,13 @@ enum skb_drop_reason {
> >       SKB_CONSUMED,
> >       /** @SKB_DROP_REASON_NOT_SPECIFIED: drop reason is not specified =
*/
> >       SKB_DROP_REASON_NOT_SPECIFIED,
> > -     /** @SKB_DROP_REASON_NO_SOCKET: socket not found */
> > +     /**
> > +      * @SKB_DROP_REASON_NO_SOCKET: no invalid socket that can be used=
.
>
> s/invalid/valid/
>
> Same for 2) and 3) below.

Thanks for your check. Will update it :)

>
>
> > +      * Reason could be one of three cases:
> > +      * 1) no established/listening socket found during lookup process
> > +      * 2) no invalid request socket during 3WHS process
> > +      * 3) no invalid child socket during 3WHS process
> > +      */
> >       SKB_DROP_REASON_NO_SOCKET,
> >       /** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
> >       SKB_DROP_REASON_PKT_TOO_SMALL,

