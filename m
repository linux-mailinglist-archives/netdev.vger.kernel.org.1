Return-Path: <netdev+bounces-111771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C404193282E
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 16:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD591C20B43
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E791D19B5AF;
	Tue, 16 Jul 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gkoPsGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93D19B3F2
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139693; cv=none; b=Ki9U4PisWA+ZjImc5K32WvvpDVWPiIcKeYHCjjC0HKTk/rwthzZ7Z4/0cvp9Lu9H/obko9AwHR+sNxqoZpxcjckXb+3hKooHWsr5YiEyZjDM1RIfch/FIKFXk2r3XQO7PcEbUf2iGQ0/wWxhrQ/g2klsxAFwScyOlgOuc/du8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139693; c=relaxed/simple;
	bh=oxMq7DEBuasbBaf1RlzcWWjQJ/Y0/vdKv8fMbYTJGoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFiRrCwSD+HIew+OJSSXYv1RTpb+kpJ8MQ4iYZIBxwYkEQwqBZ79xfV+Fcr3Wbq2T2GMJHPpD42nQq2TCMmoOV/o76R0ABgdcD5gRMMYoRTRxhlo4HyALUSuExxPLhWJJt7TjWfdwWGce+pG1Fx7Wn9cs+yaFKeHQYC35+U/fHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gkoPsGk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so18202a12.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721139690; x=1721744490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQVzCcz7J1HpR/I/Dt8TqFJ/lkiZdEHf635S5Ka1HPg=;
        b=2gkoPsGkwLaFynAMwu7IiJGz5XcW2qHsT4STUCm07wm1wqnE1zqaCSuqdxF1tOo2T+
         8LwhhY07Xz92quwAlD73PjoHVnPDU64t7WF4l6Yzz986NESFqyVE01rOQsLVcKkV7pSj
         ltsEL8TxZF6mJCybczLK5zdDnhjYflqSk9/sAEWjjOcWJUVaViXhgpzwF2WF4oOYbS/J
         jrhjgs3jOehjLvdMM0mrCna3saVbJ8kTYBsmW9ie9CHB2RSJYex57cjTNvsIXUZpXavf
         Y/tVUMCedhr9zgTIYjoHDER9RJcbAl5eg6knhna2fEjJ+KHY7G1VD3X5SLwJqTrjX170
         3MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721139690; x=1721744490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQVzCcz7J1HpR/I/Dt8TqFJ/lkiZdEHf635S5Ka1HPg=;
        b=xJKfm83Nyoy4FQsRvlOO/D9/93RSu+mhYKLjbyk5eCJXoupRBmd/JLWx6ihmyux8IP
         MhEIHl2+Xz+cmoHnk1cqRiYDEt9XQ651Fau7hHVWQdg642wXDMjG1FKb5C2vRnH8An2m
         PtRGZZtADaYgKpMkvYgDh3ipvantovVNdUpqAxF8m1LCGxmkqGRuw7AdcSWw8Fr0ObVt
         t3EQnjyCBStgfrSbr0/HB57IizrjdgCVhtFDq3BS3Ocr9dTnwSXUO0qj6XSXS+UJPbeY
         NMUy9L1nYfURpAY9muSoLbgSJXok/3lxxeTaosBr6EMQ1lrZwH6YyjEUMW0x/f8EIhW7
         a9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWayOpMO2529wpCvA51xxb0RlmVzwEE7S9bmLGoovFBf8uDFjQ8k1zdWZL6DG1hgig/1AyslEgM+iptr/E9CCiMjhtlsdqY
X-Gm-Message-State: AOJu0Yw0xx1Dj6aFZ3AAXRAkPZLIDYNeEPXHxj4Ffr+Bwg7j/c0WE9EL
	hRhmRTsZxtFMR08kLJkrFzBOSs0zDPPmrzx0e/eN0NfcbycoppEnNMux+886RtGSI+nWgNuy3wm
	dXB0DJrgJd8Uks66nalAlH/OE0UTnXDbyQZE0
X-Google-Smtp-Source: AGHT+IF5bzxW2FzqN1TZI01FgSItvfDz+oHbuRSrJSipYvcXA2wJyAcCz7RammDfytiSKhTj4jKWj5puTcz97CRMf3U=
X-Received: by 2002:a05:6402:268c:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-59f9f599f49mr116329a12.4.1721139689800; Tue, 16 Jul 2024
 07:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716015401.2365503-5-edumazet@google.com> <20240716111012.143748-1-ojeda@kernel.org>
 <CAL+tcoDVJK_J+ZGs=b94=A+3ci0uD4foZ4JQRmVa8+44udeUxA@mail.gmail.com>
 <2024071651-resonate-decompose-b1ab@gregkh> <2024071610-rebalance-deserve-ca41@gregkh>
 <2024071610-cascade-recall-ef1f@gregkh>
In-Reply-To: <2024071610-cascade-recall-ef1f@gregkh>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jul 2024 07:21:17 -0700
Message-ID: <CANn89iLE9Out6wYhLGeRmq7fFycHD1D1NtfqY-hkZmL9v+Ab0A@mail.gmail.com>
Subject: Re: [PATCH stable-5.4 4/4] tcp: avoid too many retransmit packets
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, davem@davemloft.net, 
	eric.dumazet@gmail.com, jmaxwell37@gmail.com, kuba@kernel.org, 
	kuniyu@amazon.com, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 6:03=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Jul 16, 2024 at 02:56:28PM +0200, Greg KH wrote:
> > On Tue, Jul 16, 2024 at 02:53:12PM +0200, Greg KH wrote:
> > > On Tue, Jul 16, 2024 at 08:40:40PM +0800, Jason Xing wrote:
> > > > On Tue, Jul 16, 2024 at 7:10=E2=80=AFPM Miguel Ojeda <ojeda@kernel.=
org> wrote:
> > > > >
> > > > > Hi Greg, Eric, all,
> > > > >
> > > > > I noticed this in stable-rc/queue and stable-rc/linux- for 6.1 an=
d 6.6:
> > > > >
> > > > >     net/ipv4/tcp_timer.c:472:7: error: variable 'rtx_delta' is un=
initialized when used here [-Werror,-Wuninitialized]
> > > > >                     if (rtx_delta > user_timeout)
> > > > >                         ^~~~~~~~~
> > > > >     net/ipv4/tcp_timer.c:464:15: note: initialize the variable 'r=
tx_delta' to silence this warning
> > > > >             u32 rtx_delta;
> > > > >                         ^
> > > > >                         =3D 0
> > > > >
> > > > > I hope that helps!
> > > >
> > > > Thanks for the report!
> > > >
> > > > I think it missed one small snippet of code from [1] compared to th=
e
> > > > latest kernel. We can init this part before using it, something lik=
e
> > > > this:
> > > >
> > > > +       rtx_delta =3D (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
> > > > +                       (tp->retrans_stamp ?: tcp_skb_timestamp(skb=
)));
> > > >
> > > > Note: fully untested.
> > > >
> > > > Since Eric is very busy, I decided to check and provide some useful
> > > > information here.
> > >
> > > Thanks all, this was probably due to my manual backporting here, let =
me
> > > go check what went wrong...
> >
> > Yeah, this is my fault, due to 614e8316aa4c ("tcp: add support for usec
> > resolution in TCP TS values") not being in the tree, let me go rework
> > things...
>
> Ok, backporting that commit is not going to happen, that's crazy...

Absolutely right, this is not stable material.

>
> Anyway, the diff below is what I made on top of the existing one, which
> should be doing the right thing.  But ideally someone can test this,
> somehow...  I'll push out -rc releases later today so that people can
> pound on it easier.
>
> thanks for the review!
>
> greg k-h
>
>
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -464,6 +464,9 @@ static bool tcp_rtx_probe0_timed_out(con
>         u32 rtx_delta;
>         s32 rcv_delta;
>
> +       rtx_delta =3D (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
> +                       (tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
> +
>         if (user_timeout) {
>                 /* If user application specified a TCP_USER_TIMEOUT,
>                  * it does not want win 0 packets to 'reset the timer'
> @@ -482,9 +485,6 @@ static bool tcp_rtx_probe0_timed_out(con
>         if (rcv_delta <=3D timeout)
>                 return false;
>
> -       rtx_delta =3D (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
> -                       (tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
> -
>         return rtx_delta > timeout;
>  }
>

Hi Greg, this looks great to me, thanks for taking care of this.

