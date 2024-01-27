Return-Path: <netdev+bounces-66371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D622083EB2C
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 06:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D171C22F43
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 05:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3F13ADC;
	Sat, 27 Jan 2024 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="AfxXDYvD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD18BED
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706332122; cv=none; b=dNmbDFixlqzC9PPovHn8nohYtxihgJMGZjJ4CNMSNNtZ3sSQBTzDFGyvV7B7N9zgq7ui9ZjV/JY7mzTeNPdqjT2prbId6mv7CYQkfI5lkMckM4hx+e/cWmBoWguMZ4A4W9dcBJv0UfQG+xZQXvvbygwA86j9FF9l5apINoGjX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706332122; c=relaxed/simple;
	bh=98FaEEmGT0HKUrd40izkSXDPUhFBhTjfr1E6B/PWz+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sfec8E3RMHZMpcj3PkEB2eq4yA426Yfeo5Coa3UmuZJzEfDU64sYo00W/RczIF6h4NL6RgDU1vShnKPyqRIupSSuTf/IW+wDL6O8GhHuCu/5xK68E9jaPUQsnGzvSVoKR7J8Qi8gOe4HjoUDnwHiRnlUE3610k2l9d4Rm3gdxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=AfxXDYvD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40eccf4a91dso16051145e9.2
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 21:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1706332119; x=1706936919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4lT+P0pelm+2+u+nsAYj3pO5zGQ9ZxCjilMJEMacnQ=;
        b=AfxXDYvD8tDYZ2NRHxaCfbo4A29KDrIRvVgpfHA2BXUOvuqWCtPy707Um1zFH3otqZ
         5giDQ8KiXkIGJF9sV+sqfcrj+qmCU3iJ1+j2l0ug3sZ0GfOLBR/TDH/2BYsKnB3Mp8yR
         WmEi4sGwwGx2VI+NLGHGnlkPDkq01R7liGXw56w4Baoq2HW0ZPcFVz6sxoYqBVzxqLKf
         AOk92yY5Jr15RaOtf5ywyMqotEFSwk4dStIMUxlL/bjmNVv3kGAQui3+nzB2dqA4J2Cu
         OYqXwXHuwxL/L/RcN275b89g79UHI5ThUFDRLPBDxZNh4igq0P1ZkOsy+QZ8tj9upP25
         IW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706332119; x=1706936919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4lT+P0pelm+2+u+nsAYj3pO5zGQ9ZxCjilMJEMacnQ=;
        b=sCq+ir+FC+OF+BjkX9a8ZN4mNmYKgN3fVfdp2gRLXv0XSvzs6GAfnh9IiJJUaALhtz
         +8BA4lL0n7q2jl1pA4dYRg//pebe/9N//zyCHTNsFVPnoVrC5lkGdrPuUBwipPMThcA1
         1HODwu2c+tdZGfftF2eg44/7RR1DsBJMAwiXI27sDh8a2ResCY0LSMEIP8hT7234C0Gc
         4MDOo9VKAOxXr27K22OKz4NAJdT7gmRUoqh9G158clyZhgQdEHN1Bym8R6lxtA7Gk236
         Z46/+pEYO0jXfL6MHu56RDhXWgOkY3EvDzq0frjpn81H9UGa4tEzWHsf7z8X+sPbQMCJ
         3Gvw==
X-Gm-Message-State: AOJu0Yx2j5nUNTXQ7tMqBsMToMhnwV0/POBvllifwMjKlD65y2fILgCV
	U1A82FMCLXZOsqhWB4LUE2D4O2skkBSYaQ95L9g074JNCAtrrTBWuJCrVX6yHPRSRKMrqnyA01l
	z6PHdACqh3K3tBk8Se3VW5gRGJyylT3wYexUTAXR4D6QnR752dvw=
X-Google-Smtp-Source: AGHT+IHR5y5HIYnbUpMdpPVZrSdLeUYgZ8Snd2Z0VSFsFi98NTKq4VlKXupqXUJswRsk07bKyswypDO7snJ9tCp8udg=
X-Received: by 2002:a05:600c:5013:b0:40e:c80e:dfda with SMTP id
 n19-20020a05600c501300b0040ec80edfdamr563365wmr.135.1706332118753; Fri, 26
 Jan 2024 21:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
 <87y1cb28tg.fsf@toke.dk> <CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
 <20240126203916.1e5c2eee@kernel.org>
In-Reply-To: <20240126203916.1e5c2eee@kernel.org>
From: Pavel Vazharov <pavel@x3me.net>
Date: Sat, 27 Jan 2024 07:08:27 +0200
Message-ID: <CAJEV1igqV-Yb3YvZEiMOBCGyZXRQ2KTS=yq483+xOVFehvgDAw@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 6:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> > > Well, it will be up to your application to ensure that it is not. The
> > > XDP program will run before the stack sees the LACP management traffi=
c,
> > > so you will have to take some measure to ensure that any such managem=
ent
> > > traffic gets routed to the stack instead of to the DPDK application. =
My
> > > immediate guess would be that this is the cause of those warnings?
> >
> > Thank you for the response.
> > I already checked the XDP program.
> > It redirects particular pools of IPv4 (TCP or UDP) traffic to the appli=
cation.
> > Everything else is passed to the Linux kernel.
> > However, I'll check it again. Just to be sure.
>
> What device driver are you using, if you don't mind sharing?
> The pass thru code path may be much less well tested in AF_XDP
> drivers.
These are the kernel version and the drivers for the 3 ports in the
above bonding.
~# uname -a
Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Linux
~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
SFI/SFP+ Network Connection (rev 01)
       ...
        Kernel driver in use: ixgbe
--
3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
SFI/SFP+ Network Connection (rev 01)
        ...
        Kernel driver in use: ixgbe
--
5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
SFI/SFP+ Network Connection (rev 01)
        ...
        Kernel driver in use: ixgbe

I think they should be well supported, right?
So far, it seems that the present usage scenario should work and the
problem is somewhere in my code.
I'll double check it again and try to simplify everything in order to
pinpoint the problem.

