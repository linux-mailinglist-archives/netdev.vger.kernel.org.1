Return-Path: <netdev+bounces-62628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A48CB828412
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36435B23CB8
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4EF29429;
	Tue,  9 Jan 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/ggn+2G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39236AE0
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e70d8273fso2242e87.0
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 02:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704796587; x=1705401387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFiUdXf8vHhzdvbyI+OvN6fbW+HoEuehMXu+ZRwGX5g=;
        b=C/ggn+2GpalwmYGG+xrrlCqsqzD8Bf4qTUczoWeuBFYR2UW2S//kmm0IeOVXqvJ7cs
         sO4BhP5kMRPSWXCtffIwSyTK91EFIABQcWGuptPM5XzXIWSEIXHV2aya0RSMyOoV6CqA
         2HbSIuOUI0Vt43nz/l8QNSNJAQ3XbLZslyzVQI5ynlw1ng0iSFahRMwDgCCh0+kJdJWf
         fLSKE0JhEnVz3ZzRb72pTFMNGceMDOiDq0MvFvCjPp4Ykv9wRkOIQf9qY738e3/D0p5f
         iCbZX9d4Z67snVBA5hIIejN4FwmYqabokUWYnzcXOsFQowCsTfxFEZW+JIU6YD1KPZw8
         Yv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704796587; x=1705401387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFiUdXf8vHhzdvbyI+OvN6fbW+HoEuehMXu+ZRwGX5g=;
        b=wYLfvn8krjaIQwhikQGlEz7sXxvuaZcmLYXqogyDwZNqSohnaCVCA/cP4nqEzf7rzX
         fdxT8LieTFAhFF4+UT1uf/Sko5/nnAhiDQltD3WyKVNJj2+ccVspVUYu9gfbi/fnSESv
         j5V4U+rWpU2VV1bGypn6uuNI59c7a6aWwaoYyvbDJPv7IHtUMAEjXz2opFne3ka7lQTv
         /NRx/rMzFc1sBI8GZoLredmgiOM2rDE05HmcPKyNAWkqxpd7/vShzIg7jPx9+AS57dPa
         Ppu+XOSxca+sGLWnEQdfU0Y44vicsspjukQlZyX71NGa67cgix8T42yAG9aIyORJIe2P
         w2ww==
X-Gm-Message-State: AOJu0Yw2Tp5/mRjf1qmNS+gmVRewkvaAAKkQ1OqnXupoxNETRhThu1Bx
	WRFp6SzX24OmpVOCP545muW9UCPpWvAv/YvjIK6J+x5mMzSK
X-Google-Smtp-Source: AGHT+IEH4jGo/TLqpCVChaY31QPuYk3lWs0ygVVSfmvfa7bEKThBor6u45Qp3U2qxbzvzltasUdEptbxMRuE5XRtUsI=
X-Received: by 2002:a05:6512:ac8:b0:50e:ca18:917 with SMTP id
 n8-20020a0565120ac800b0050eca180917mr42802lfu.7.1704796586807; Tue, 09 Jan
 2024 02:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108231349.9919-1-jmaxwell37@gmail.com> <72f54aa95c3fad328b00b8196ca7f878c5d0a627.camel@redhat.com>
In-Reply-To: <72f54aa95c3fad328b00b8196ca7f878c5d0a627.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jan 2024 11:36:13 +0100
Message-ID: <CANn89iLn0VK2kfq2m56kcaLGE6U-=p5eOr8=EFUqTr5bkONDiA@mail.gmail.com>
Subject: Re: [net-next] tcp: Avoid sending an erroneous RST due to RCU race
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 8:24=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Tue, 2024-01-09 at 10:13 +1100, Jon Maxwell wrote:
> > There are 2 cases where a socket lookup races due to RCU and finds a
> > LISTEN socket instead of an ESTABLISHED or a TIME-WAIT socket. As the A=
CK flag
> > is set this will generate an erroneous RST.
> >
> > There are 2 scenarios, one where 2 ACKs (one for the 3 way handshake an=
d
> > another with the same sequence number carrying data) are sent with a ve=
ry
> > small time interval between them. In this case the 2 ACKs can race whil=
e being
> > processed on different CPUs and the latter may find the LISTEN socket i=
nstead
> > of the ESTABLISHED socket. That will make the one end of the TCP connec=
tion
> > out of sync with the other and cause a break in communications. The oth=
er
> > scenario is a "FIN ACK" racing with an ACK which may also find the LIST=
EN
> > socket instead of the TIME_WAIT socket. Instead of getting ignored that
> > generates an invalid RST.
> >
> > Instead of the next connection attempt succeeding. The client then gets=
 an
> > ECONNREFUSED error on the next connection attempt when it finds a socke=
t in
> > the FIN_WAIT_2 state as discussed here:
> >
> > https://lore.kernel.org/netdev/20230606064306.9192-1-duanmuquan@baidu.c=
om/
> >
> > Modeled on Erics idea, introduce __inet_lookup_skb_locked() and
> > __inet6_lookup_skb_locked()  to fix this by doing a locked lookup only =
for
> > these rare cases to avoid finding the LISTEN socket.
>
> I think Eric's idea was to keep the bucket lock held after such lookup,
> to avoid possibly re-acquiring it for time-wait sockets.

Yes, I think a real fix needs more work/refactoring, I can work on
this in the next cycle.

