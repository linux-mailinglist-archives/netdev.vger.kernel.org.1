Return-Path: <netdev+bounces-67237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBB38426F7
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD509291D2B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1233429CF8;
	Tue, 30 Jan 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVUEc4YW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD9846B
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625130; cv=none; b=dGgqkTN0R0E+GHgs6P1XOPFfjsM2jYp0c3DwaTNPTT7cJ4AEhkR/p76CWPjDgnA9357rZbiVDw71jQ3cf/SjB0zX5Zks46tklNu86E4EzB8zrZ5E3D2yfx9uxi3BwxZskCQ9GWIgK2FlzAc9Ej61v+p7QRA0ui/4sh7yMYopGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625130; c=relaxed/simple;
	bh=WUrzSm4gKCsOCglX4nyKiHvqjKuRTU0PNd7T8RnR+iQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BASrgd2doSzH77C9JOxvP/PURmD0+UW9+mb52+E+2jtH+MKQOs2ttSly/FTgbAOikFyIJVlYxggcm9l6WSiN08L2xZGHhlATRKGPnP3W95Dj5uRoZbgLlki/tDCT2YO8TX72Hi13j+ak821w4Zxv8QYHj41/WMEZ8r7ZXQVbCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVUEc4YW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B75DC433F1;
	Tue, 30 Jan 2024 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706625129;
	bh=WUrzSm4gKCsOCglX4nyKiHvqjKuRTU0PNd7T8RnR+iQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dVUEc4YW60k5IqhDu7eIsV6JWz+54XO/RTQKp8txHG0lYK8zTAr556kB7EBU6hT8p
	 7/D5BmkYFKZac3UqzXfGigrk7gTZi+jrhXes/C79UoNUdGd85vhhiohpFwcGHM5uZB
	 iOsI+nEzJUDUjF4T9E160BXrubvKZoPMEpWLWQrqvUh84k08x+VRwaFOGhxCfvxVo+
	 +t4z7C/Hbc4xYA/OJ1h3xYcOWMKJ68e3JkFaU9OpDdRoUfUvmxKD2zh5m5y7yC14me
	 yYFvKdtwyfQWuLI/PlCqeyfow2kqDoZvol8cADqx7OtwPTs38PrF9U3NtlFwGsvqcj
	 ceu2XlkHWECRQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 94EB8108A226; Tue, 30 Jan 2024 15:32:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Pavel Vazharov <pavel@x3me.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind
 a Linux bonding device
In-Reply-To: <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
References: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
 <87y1cb28tg.fsf@toke.dk>
 <CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
 <20240126203916.1e5c2eee@kernel.org>
 <CAJEV1igqV-Yb3YvZEiMOBCGyZXRQ2KTS=yq483+xOVFehvgDAw@mail.gmail.com>
 <CAJEV1ij=K5Xi5LtpH7SHXLxve+JqMWhimdF50Ddy99G0E9dj_Q@mail.gmail.com>
 <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 30 Jan 2024 15:32:06 +0100
Message-ID: <87wmrqzyc9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pavel Vazharov <pavel@x3me.net> writes:

>> On Sat, Jan 27, 2024 at 7:08=E2=80=AFAM Pavel Vazharov <pavel@x3me.net> =
wrote:
>>>
>>> On Sat, Jan 27, 2024 at 6:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
>>> >
>>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
>>> > > > Well, it will be up to your application to ensure that it is not.=
 The
>>> > > > XDP program will run before the stack sees the LACP management tr=
affic,
>>> > > > so you will have to take some measure to ensure that any such man=
agement
>>> > > > traffic gets routed to the stack instead of to the DPDK applicati=
on. My
>>> > > > immediate guess would be that this is the cause of those warnings?
>>> > >
>>> > > Thank you for the response.
>>> > > I already checked the XDP program.
>>> > > It redirects particular pools of IPv4 (TCP or UDP) traffic to the a=
pplication.
>>> > > Everything else is passed to the Linux kernel.
>>> > > However, I'll check it again. Just to be sure.
>>> >
>>> > What device driver are you using, if you don't mind sharing?
>>> > The pass thru code path may be much less well tested in AF_XDP
>>> > drivers.
>>> These are the kernel version and the drivers for the 3 ports in the
>>> above bonding.
>>> ~# uname -a
>>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Linux
>>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
>>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
>>> SFI/SFP+ Network Connection (rev 01)
>>>        ...
>>>         Kernel driver in use: ixgbe
>>> --
>>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
>>> SFI/SFP+ Network Connection (rev 01)
>>>         ...
>>>         Kernel driver in use: ixgbe
>>> --
>>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
>>> SFI/SFP+ Network Connection (rev 01)
>>>         ...
>>>         Kernel driver in use: ixgbe
>>>
>>> I think they should be well supported, right?
>>> So far, it seems that the present usage scenario should work and the
>>> problem is somewhere in my code.
>>> I'll double check it again and try to simplify everything in order to
>>> pinpoint the problem.
> I've managed to pinpoint that forcing the copying of the packets
> between the kernel and the user space
> (XDP_COPY) fixes the issue with the malformed LACPDUs and the not
> working bonding.

(+Magnus)

Right, okay, that seems to suggest a bug in the internal kernel copying
that happens on XDP_PASS in zero-copy mode. Which would be a driver bug;
any chance you could test with a different driver and see if the same
issue appears there?

-Toke

