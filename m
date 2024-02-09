Return-Path: <netdev+bounces-70493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477F884F3B5
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23811F2A158
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D524B2F;
	Fri,  9 Feb 2024 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHtWmmjy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3525286B2
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475605; cv=none; b=UYKiy+g2zq9fSz37ZCWNx9V88w8/xCCH0aMf4jTkE5JYpAqx6GvtorS595A1aWW6g61T0eF6e3iwis2TSzoZnr93KCKFPTxZ+jOWl4UgURZa5OLjflz8QZxaYavlzl4Ueca8j5Hr+duMgGq7XJEihWLqGsV0glqSAlZxdeDnpDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475605; c=relaxed/simple;
	bh=4ScdQDkhQmFgtdXjZ+Wf2ylfDmGGNzxYdvZM2HRHZjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pasBQr5pV8DKFvYUb8f1UOljTvBPVjlLtCY49p2X0RvOgKTSHfCWWUNZqprmxjhPcBz4IEJWfHUmoxQMpw1WZwHfuNYn4tmtYGSlCFujRqJqDeEzXnz9QsxPKpwfE/CNHeMeLO7gNOAwy+9DXlXmUCEf/iReEbPSF3zmJOc5b5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHtWmmjy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso1353630a12.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 02:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707475602; x=1708080402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M19XqpmmmEIhaJkkCewuMc7S2cm+jMIk0BczRPFBNq0=;
        b=AHtWmmjyTN95/Q9okI8ZgQsbcNOhlMSkw+4pflVQ2BQBd/xTpFcqJN9My8rkfpX8hk
         /zANsxYywu5MeBIM5zt89T6H+B6ojsYu7JSJ9vivWAn8mW5MmRpfaHJu4/nvBziX9AYF
         LMipWJN4HaZduivgn+6uKpKpbbDNtm+N/evDpF+CzgBgLXkKEFezfgAYikOEPRDoV4/3
         F7kRiAnBvagQ2atP/mDAs2EV4jTK+dQerzzDWvgm7XMCg+Pou/oeWWTfryaiCQ3bAYlv
         xKhbWvf+xX+eEgVM+E5xlVQznQJO/VnZ6OTxLjRwKRSGjbYdpEfgzBLX9+7gprRAn1K2
         gtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475602; x=1708080402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M19XqpmmmEIhaJkkCewuMc7S2cm+jMIk0BczRPFBNq0=;
        b=AEebenfqLzoWYwWCKuH0xPZTKPkPV4zEgsz/Pit3yAUevtvfqtd8c0qIoRajIOfvMV
         8qrxM8c0hg7s3VTNXqNAvtQ3NvFC4x9WNJQsKX1N9iMCsw51RPHLT1Wu2T1R9CBra5bL
         /qiEA2XHL4X+FmSnKMCqi9EFX5qIlWzDU9xt9S7MZUkrg6AC4TPGJ9pXgrCfcR1veyCu
         KXIoCQYRuhLKP2gL/1tEq91kJVcP/tTtTQP5ThhKH1Zr70MP/LPvoNB/uA5tQLhTuoJD
         1FTmSaHMu4uRcwpjSMCHho7DCtBoBwf0evOLE+96aSnPB4SsfHg/WcRQB05Bq0vYX97N
         icsQ==
X-Gm-Message-State: AOJu0Ywj4+aoiD+wwYZCvU/w/u2+vTZ5m2iwunDRRenDpw5HjDdrS7Lf
	OBb+s8+z/QHkU3oEKtsjWWnqj2fvKGJgnqVijSu++alco+ektpTu1sSD7PsIXs7G2uD8GPF0ImI
	unjpHb1/dxmiOsnj6wNtsL4NNleY=
X-Google-Smtp-Source: AGHT+IGril9qrawkxky+j5uIPpM0kj3BDfiEPZCglOyo5tL5AWs7/z8Ge8dGM5+uHQCWA7braaMERZbtcCxCToTqAM0=
X-Received: by 2002:aa7:d495:0:b0:560:e51e:bea0 with SMTP id
 b21-20020aa7d495000000b00560e51ebea0mr789603edr.40.1707475602038; Fri, 09 Feb
 2024 02:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209061213.72152-3-kerneljasonxing@gmail.com> <20240209091454.32323-1-kuniyu@amazon.com>
In-Reply-To: <20240209091454.32323-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 9 Feb 2024 18:46:05 +0800
Message-ID: <CAL+tcoDoUXfVHSkVjMfsb=vGJ30Fa=ucakWHOVhhPNVRpV6m2w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] tcp: add more DROP REASONs in receive process
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:15=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Fri,  9 Feb 2024 14:12:13 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > As the title said, add more reasons to narrow down the range about
> > why the skb should be dropped.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/dropreason-core.h | 11 ++++++++++-
> >  include/net/tcp.h             |  4 ++--
> >  net/ipv4/tcp_input.c          | 26 +++++++++++++++++---------
> >  net/ipv4/tcp_ipv4.c           | 19 ++++++++++++-------
> >  net/ipv4/tcp_minisocks.c      | 10 +++++-----
> >  net/ipv6/tcp_ipv6.c           | 19 ++++++++++++-------
> >  6 files changed, 58 insertions(+), 31 deletions(-)
> >
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index efbc5dfd9e84..9a7643be9d07 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -31,6 +31,8 @@
> >       FN(TCP_AOFAILURE)               \
> >       FN(SOCKET_BACKLOG)              \
> >       FN(TCP_FLAGS)                   \
> > +     FN(TCP_CONNREQNOTACCEPTABLE)    \
> > +     FN(TCP_ABORTONDATA)             \
> >       FN(TCP_ZEROWINDOW)              \
> >       FN(TCP_OLD_DATA)                \
> >       FN(TCP_OVERWINDOW)              \
> [...]
> > @@ -6654,7 +6657,7 @@ int tcp_rcv_state_process(struct sock *sk, struct=
 sk_buff *skb)
> >                       rcu_read_unlock();
> >
> >                       if (!acceptable)
> > -                             return 1;
> > +                             return SKB_DROP_REASON_TCP_CONNREQNOTACCE=
PTABLE;
>
> This sounds a bit ambiguous, and I think it can be more specific
> if tcp_conn_request() returns the drop reason and we change the
> acceptable evaluation.

Sure, are you suggesting adding more reasons into .conn_request
callback functions, like tcp_v4_conn_request(), right?

If you don't mind, I can do it next time because it involves more
effort which could be put into a seperate patch or patchset.

Thanks,
Jason

>
>   acceptable =3D icsk->icsk_af_ops->conn_request(sk, skb) >=3D 0;
>
>
> >                       consume_skb(skb);
> >                       return 0;
> >               }

