Return-Path: <netdev+bounces-67240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EDF84270C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C64289A01
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3429B7C08F;
	Tue, 30 Jan 2024 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="f7xtyW14"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF87A731
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625672; cv=none; b=msOIDAnFeD+x7BdX2zAkwQwRjN785ZTJbPrTUd1BO2oBIPEVw8QgxOtqmJQNxSoRtlit9eaXSzJPjT8QtF/3ddWyFh5xY/JXy0IXBNf7kIk5fppyYk1sABgvq079ZhZAJKiO2CmHgm3TfYU+Kh56KQQ7gCozK146yYLFnXirTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625672; c=relaxed/simple;
	bh=XkGlKKkegS/FYdyZurgK/OeTCWEJS3oeA59ddaN2j6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m45T8dEf+JOOWakhFzlfhkBAKYzGeXWpSTG9E7kt8eaY4zdwc8+CldE12xhZaUDOCzyptm4topgrayWX7oUq6955ygiz07DZdMajmtTJSelFO0ryBt3+xAAzQ+w+OZlYfUPqoRbQfWWIl1jjc6YmLh+8AB5aRHezdnLMcOXAAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=f7xtyW14; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26fa294e56so511690366b.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 06:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1706625668; x=1707230468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAynv5cVorttQheb/jWTXVqh5/Na6Ki1paUTcjgakVM=;
        b=f7xtyW14LQQimjAc+yzpjNql+M9AW3GpsZ4VWCeT70LcTfHHyZOlWGVOY2jOk9w59R
         mbRICTYXtjG7YCiwFftza3RiG46KtP6duXZO3F2+UfJjFHA2JNDQT8QloaNhrj/fmpen
         fvIxCi5zrypjERqzM6tKalan3dKvubl+QfH/1SYkaoov5cQc0D5950F6RiQURmZB5tqH
         M/TiuSaGi16d5UHcYD2pY3RIq5FbRpeisbLKaO/ROCGMIbnQD/yWARtQV0mSPNozHeGv
         /0krV+RYiYTFO/GbvoPGm9GXMI3u77ez78raCu2JYbniP/CUSfvosww0fsKwcCyeOc7Y
         VOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706625668; x=1707230468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAynv5cVorttQheb/jWTXVqh5/Na6Ki1paUTcjgakVM=;
        b=uTjWpDvtUqYuGlFqvFVdhCiuZhHoJGa23jgm6JXQOVDc8/xezFpsoOqIKVxfHs+7YD
         Jj5Wt7ENmKT/nAmO0Y0jNJ7kYiuoniPdmqySR/dgIImmtmJYKwSj1132H7A8eoamQZus
         +7j8JLQ143BhkU/DiSVLLIsFK8ul6BndzQmW/by/t+3T1tne8wmG6XoQtOYvX7Nd8Vjw
         CYEySc5kuP+PlvAg3pPPLq+xAtPFh1efEl/FySJ3hP9PSLGFXjalWqJ3QfYnq8/6WCTL
         RmNlIYBLpRghVOJ7NQCdWZqJUJXcoABNpLq17AIzpA/yZYa+8X/kBqXzurdA5UPEmN/g
         RcBA==
X-Gm-Message-State: AOJu0YzJTMJq/FACqMdLCPROzar6KfIrXj71vuH/ACrMWg0tF7YSQee0
	oGu7UlcRXNDykKjdBoTP1hU5xZhCse+gWOPdB68lJsYSdPcx0ltAElYJ5GQezwBpt/wJdOkZumM
	SMrXvpJjeKTFzGl+dDg3T5Lbl3v19Q/hfG2z++tI+Lq6CfzVYPBU=
X-Google-Smtp-Source: AGHT+IG8qHDFkemayeNX3x7lU/99bj7XR7pIYc627WYxV349zrp+xe7QQ9FyAxwnx5H+WOwvVF/I4j4znLvRXlLZcMU=
X-Received: by 2002:a17:906:480f:b0:a35:91dd:b824 with SMTP id
 w15-20020a170906480f00b00a3591ddb824mr5446164ejq.56.1706625667803; Tue, 30
 Jan 2024 06:41:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
 <87y1cb28tg.fsf@toke.dk> <CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
 <20240126203916.1e5c2eee@kernel.org> <CAJEV1igqV-Yb3YvZEiMOBCGyZXRQ2KTS=yq483+xOVFehvgDAw@mail.gmail.com>
 <CAJEV1ij=K5Xi5LtpH7SHXLxve+JqMWhimdF50Ddy99G0E9dj_Q@mail.gmail.com>
 <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com> <87wmrqzyc9.fsf@toke.dk>
In-Reply-To: <87wmrqzyc9.fsf@toke.dk>
From: Pavel Vazharov <pavel@x3me.net>
Date: Tue, 30 Jan 2024 16:40:56 +0200
Message-ID: <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Magnus Karlsson <magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 4:32=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Pavel Vazharov <pavel@x3me.net> writes:
>
> >> On Sat, Jan 27, 2024 at 7:08=E2=80=AFAM Pavel Vazharov <pavel@x3me.net=
> wrote:
> >>>
> >>> On Sat, Jan 27, 2024 at 6:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> >>> >
> >>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> >>> > > > Well, it will be up to your application to ensure that it is no=
t. The
> >>> > > > XDP program will run before the stack sees the LACP management =
traffic,
> >>> > > > so you will have to take some measure to ensure that any such m=
anagement
> >>> > > > traffic gets routed to the stack instead of to the DPDK applica=
tion. My
> >>> > > > immediate guess would be that this is the cause of those warnin=
gs?
> >>> > >
> >>> > > Thank you for the response.
> >>> > > I already checked the XDP program.
> >>> > > It redirects particular pools of IPv4 (TCP or UDP) traffic to the=
 application.
> >>> > > Everything else is passed to the Linux kernel.
> >>> > > However, I'll check it again. Just to be sure.
> >>> >
> >>> > What device driver are you using, if you don't mind sharing?
> >>> > The pass thru code path may be much less well tested in AF_XDP
> >>> > drivers.
> >>> These are the kernel version and the drivers for the 3 ports in the
> >>> above bonding.
> >>> ~# uname -a
> >>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Linux
> >>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
> >>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> >>> SFI/SFP+ Network Connection (rev 01)
> >>>        ...
> >>>         Kernel driver in use: ixgbe
> >>> --
> >>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> >>> SFI/SFP+ Network Connection (rev 01)
> >>>         ...
> >>>         Kernel driver in use: ixgbe
> >>> --
> >>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> >>> SFI/SFP+ Network Connection (rev 01)
> >>>         ...
> >>>         Kernel driver in use: ixgbe
> >>>
> >>> I think they should be well supported, right?
> >>> So far, it seems that the present usage scenario should work and the
> >>> problem is somewhere in my code.
> >>> I'll double check it again and try to simplify everything in order to
> >>> pinpoint the problem.
> > I've managed to pinpoint that forcing the copying of the packets
> > between the kernel and the user space
> > (XDP_COPY) fixes the issue with the malformed LACPDUs and the not
> > working bonding.
>
> (+Magnus)
>
> Right, okay, that seems to suggest a bug in the internal kernel copying
> that happens on XDP_PASS in zero-copy mode. Which would be a driver bug;
> any chance you could test with a different driver and see if the same
> issue appears there?
>
> -Toke
No, sorry.
We have only servers with Intel 82599ES with ixgbe drivers.
And one lab machine with Intel 82540EM with igb driver but we can't
set up bonding there
and the problem is not reproducible there.

