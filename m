Return-Path: <netdev+bounces-168619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1651FA3FB30
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BA516E058
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDDD1F1535;
	Fri, 21 Feb 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZANyd6fi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95A1F12EC;
	Fri, 21 Feb 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154863; cv=none; b=l7wrkr5F1g4wzqn3fc9GN6zMfOQkTsxW71YoWctV5t1p/OLGXFwNoz6qGumJdxiis1dagQKKHGQAYH28Djx3e2s80HncxuMyI7cRSvjfAC+aFp1CJPBpYJ+ou5EoOgazLIVXyq4JaaKA2YOwH8qKGJ/ZSp/7GV1vlFHbJkuPP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154863; c=relaxed/simple;
	bh=JupzvUkcz9lij7FMLeO8tMHaN2BmcJV2dSPgnA9ECyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czV5eGyp0kcFVVNvVBp6ggxGvTTB4anEnT4ZSIKD3bJ9z79zC0pmvIkb4/PWY5s0LMxDQIKGGJtsTK1kgobMXRbmR5UBPQg4sSqCWlOmyXbAXeYABbnvp0Fc8+KbUfbSCLXSihV9trIoJNPO4kuruClbI77lBL+nrWX3mBVf2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZANyd6fi; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307bc125e2eso21771511fa.3;
        Fri, 21 Feb 2025 08:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740154860; x=1740759660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbh68tJwGTQhCBEmpp6DPT0uUoYU18GRnhX5rX6s8ME=;
        b=ZANyd6fiS6yPVXbMjKkIfiuscgILJBR+YvgdTwy1RudmSreAOwJ/o/eE3UbqutcMUK
         HPmO6IZaF3z03e3Vpp57ttVyGgLmbXtQ4ZjuPILAY1+piBv7nHUKDiJ4RdykWRiI7lEP
         5qz08OKVRewyjLLq/RJWC/PIpYWr4hZhbHU0BEJsdgyqX41yBxfIPh27GEtmo/EBBdTo
         q7/Zi+32jUUkUWMCJY2NtrzCZ6BJ87lv3t+gGkq476dUEc5Kjb4wYahVHKf17KknU6GQ
         vJ+1pg119RTmwdXkObos+0v7Jqo7/v/7Xc2UlPrfLufddFSt90FaMMNZ1zE/K+PW9fkj
         kfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740154860; x=1740759660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbh68tJwGTQhCBEmpp6DPT0uUoYU18GRnhX5rX6s8ME=;
        b=rNdBGjup3/8o4EuUCZcp3efr4RXhWF8VJBwyuJoF4jLdIDoGB9cPGlz5a0587IkvsG
         967dgp8RPSrkHIMsJnIbfSH5d466fPYHXlv70irfgz8EZ/XtX20iQyr4Wpd/CueHPynj
         tfw2/dIZyCZ77tI6QTKZ9bygIm61C23j/HoRSkvgTdwvcbvnew2+FBUsVtRkSL2Mj6v3
         JB97Htx+ABJVIYK+6LKe6domMit6BlizWKhBUaTgQezW9/8L2jjgFL8GZVKvnRwFEaMu
         FqcfstZiSaDPZAtxBSZ23OSf3D44NmkEW5Nk76dUvN/KsTCp/BPdXoH1t1OjXg+U/Q+3
         OKfw==
X-Forwarded-Encrypted: i=1; AJvYcCU9+4KJyymCrk/tiDqmK9Ind15COQJUoQwE9DVIhlurM1foqB8cqZK3sAqAI8UyO2TcXrsiUg7p@vger.kernel.org, AJvYcCXty2HFa+G2FsST4gIl1q6/NScCJ4lwBko7rFSDMStyRLtZW1H3+wx+eRtzePVSxdk8T83gjExH0eDnkXHj@vger.kernel.org, AJvYcCXyJMxzK0LGPU47GBbioSst+QtdrNhsSUxEGqU2As1jBXJKvUHzbh+kmowDUHgy6qdgx9sQiRUpT99DH4PsQfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0iC5D9vZwL+QMGIwL9rgnClF3rk34u3cDls4S0GTh8EgEImDv
	tJ5ca1hchf9beHyLepq9awNSMjhtSQEzWNCTu9MJ1ZQli8NR2luZjA0Kus1gr++LMsJDNxGD7eg
	R5NzX2Zgef3OiWTfSOuQEmcjLU0SEV5Eowao=
X-Gm-Gg: ASbGncv1WWR5H9i84Zt9hMpMfZxyjkdLOmeyTfHDSq5FN51vZVzlo8/4Wa6n7TIJ/OJ
	G40TH3UYu4z6ruTnmDuPF6F5hCOF4itMpxjxEBr8f3jiPCWputEzhrrkBDtwWHi+4zX4RR2BaSC
	p8lq44KHBN
X-Google-Smtp-Source: AGHT+IGP8VKTcYPVs7TcsZa6QmJ8EakJt2B8Dakv/lyg9X2mFJKJ+xm6sKl7YgNkDp6IEuaf3X3X8jsA/93V3FIxnl8=
X-Received: by 2002:a2e:b005:0:b0:308:e9ae:b5aa with SMTP id
 38308e7fff4ca-30a5984d942mr12670281fa.8.1740154859656; Fri, 21 Feb 2025
 08:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <CADg1FFfCjXupCu3VaGprdVtQd3HFn3+rEANBCaJhSZQVkm9e4g@mail.gmail.com>
 <2025022100-garbage-cymbal-1cf2@gregkh> <CADg1FFc=U0JqQKTieNfxdnKQyF29Ox_2UdUUcnVXx6iDfwVvfg@mail.gmail.com>
In-Reply-To: <CADg1FFc=U0JqQKTieNfxdnKQyF29Ox_2UdUUcnVXx6iDfwVvfg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Feb 2025 11:20:47 -0500
X-Gm-Features: AWEUYZmR9lRtiledqjDfO03Vf7TqDmtxpp5wJnDHYdrAGlHmKhfz4FBRwMh6IHg
Message-ID: <CABBYNZ+63EdbEcB7-XD9jN79urmk5CtUZ6iBzphO3HuCMukQoA@mail.gmail.com>
Subject: Re: [PATCH v7] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: Hsin-chen Chuang <chharry@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Fri, Feb 21, 2025 at 12:57=E2=80=AFAM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> On Fri, Feb 21, 2025 at 1:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Fri, Feb 21, 2025 at 09:42:16AM +0800, Hsin-chen Chuang wrote:
> > > On Wed, Feb 19, 2025 at 10:03=E2=80=AFPM Hsin-chen Chuang <chharry@go=
ogle.com> wrote:
> >
> > <snip>
> >
> > > Hi Luiz and Greg,
> > >
> > > Friendly ping for review, thanks.
> >
> > A review in less than 2 days?  Please be reasonable here, remember, man=
y
> > of us get 1000+ emails a day to deal with.
> >
> > To help reduce our load, take the time and review other patches on the
> > mailing lists.  You are doing that, right?  If not, why not?
> >
> > patience please.
> >
> > greg k-h
>
> Got it. Take your time and thank you

So it is not really possible to change the alt-setting any other way?
I'm really at odds with adding something to sysfs that only one distro
cares about, at very least that shall be put behind a Kconfig or as a
module parameter, or perhaps we start to intercept the likes of
HCI_EV_SYNC_CONN_COMPLETE when USER_CHANNEL and then check if
alt_setting needs to be changed based on the air mode, how about that?

--=20
Luiz Augusto von Dentz

