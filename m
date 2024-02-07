Return-Path: <netdev+bounces-69888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C0684CE9A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9286928BD03
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BE5811F4;
	Wed,  7 Feb 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="bBop/lQK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69C80BEF
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322057; cv=none; b=tmhPLF92fg+DYDQamDqJc8bDTNH9eTTKVzteikfYByM8vqRgqFy20J5Q5UxrD6M9vVkF28nSbSS7D9Pg4A+SNqZQ1hnMoNko2nzWfKHOu43d7Zr39cuqRL9H+EA0jzxzjUaY5CfpjMd+F9NJW+NwaYKYvUaSkOMmr/Xf6JVuMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322057; c=relaxed/simple;
	bh=Xi9vkY3FucQy/ZUeWlMY4/hABM8R3qHw0/wXihxDvUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDwHiyj6Q2NkbdngGpKqmmzuM6VDjtMKCxWIriD5sQyH4SDdK4npLIgxB4I2aYufNzqHQFm4yN4wn84dfG4npnkuGTw9a6z5A3fG10ssN62rLPIBI0dy/dWQh859zR3A/ijSFhTm1sdPJF02GKegLbmbhT1HOgaepp5MM2Acqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=bBop/lQK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so155484166b.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1707322053; x=1707926853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiJmcwrzLDdgx3+XHkCG3hEo4hl/SjDl3dmkyY3ZL+Q=;
        b=bBop/lQKq1aAFymj0tJbsNt+KcwgWwVkYKbJZqDt9aH2U6ObsjzBXFfq7TWq89OXrK
         iymRhd7T0xemWVaVJOQPhUyWJlm8EVHK3fBgCoFxU+NUAyrJeArLJ8vXZpwJWUWDtJ8d
         a+TL/HDnjSnd9iF+rqGAFx1s3pHGpVjYvAkkDZmAWsBvHv9ehcVzVcwQ/wU72Nk4ZQdD
         0gbVvEwHqIurhJoYSzWvtBh+HlChTCYyF/VyKfPiRANS5rX4D/53o4/aEkjeRJ9DBVhg
         zlcd3Wi6mNaxB6xnJfpF7gePMFP906vpSmXK0GjGMlUivsHNc0THPDBaehfT9XyqipRT
         y8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707322053; x=1707926853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiJmcwrzLDdgx3+XHkCG3hEo4hl/SjDl3dmkyY3ZL+Q=;
        b=kgvOmbSMLVdiu6iGti+k6ab+mjLyhLDQFSXI8tLMIbMkOEB17bN2gFe5Z52rm89H/d
         kvF1YQUooXnpgrPIGf+mmldK/g8xI1L4ZNUNOP0fXPYIEp/274SfUWFUTjS6dzYoyepB
         bNbBe7hNBxE7g8eaG7F/Sq61zvmUWlpA5c3uemrl2b/p3P6MSC2SUc1lpjEGaz0DSsvY
         m6CTZ9DDDgRAQj/mn5MkPy7I1RYyGKkyAWabW4P5NayymHqmHvc+A2ileSMXJHkDKe/i
         cZUix0zhWMYNs2DueW8uM274l80PBDbmDEWpP1h6UweTmG2GikFJ13H3F3nv/ux1f6Ot
         potw==
X-Gm-Message-State: AOJu0YxWoClpOb1i2DVaFtY+u75c4B+JmTbta5CHk9dNgzCanUQT76qV
	THbGNshqMUZkugVCpD1D/pYZyHUob1I1ZXhiAb69s4rUEjab46kX2aLDqPgDGd5iBO6FvReG+xu
	4gbuzkbUje7NkUdUj82dXPk3l3EYuRr/335nkCw==
X-Google-Smtp-Source: AGHT+IFAaZSKWkR9bLcMjhO5M+JwRqD01X7Ytd43Ys/SF3mO/MxlH1rzMd5k7nHoTRjbY77hlo6J408Gsrf8vWnw1lQ=
X-Received: by 2002:a17:907:7759:b0:a38:1711:ee61 with SMTP id
 kx25-20020a170907775900b00a381711ee61mr6448648ejc.19.1707322052920; Wed, 07
 Feb 2024 08:07:32 -0800 (PST)
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
 <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
 <87wmrqzyc9.fsf@toke.dk> <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
 <87r0hyzxbd.fsf@toke.dk> <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
 <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
In-Reply-To: <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
From: Pavel Vazharov <pavel@x3me.net>
Date: Wed, 7 Feb 2024 18:07:21 +0200
Message-ID: <CAJEV1ijyteQ9BxS1xtythC3O0y5+mdostL7-RKQhnkCf93iufg@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:49=E2=80=AFPM Pavel Vazharov <pavel@x3me.net> wrot=
e:
>
> On Mon, Feb 5, 2024 at 9:07=E2=80=AFAM Magnus Karlsson
> <magnus.karlsson@gmail.com> wrote:
> >
> > On Tue, 30 Jan 2024 at 15:54, Toke H=C3=B8iland-J=C3=B8rgensen <toke@ke=
rnel.org> wrote:
> > >
> > > Pavel Vazharov <pavel@x3me.net> writes:
> > >
> > > > On Tue, Jan 30, 2024 at 4:32=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rg=
ensen <toke@kernel.org> wrote:
> > > >>
> > > >> Pavel Vazharov <pavel@x3me.net> writes:
> > > >>
> > > >> >> On Sat, Jan 27, 2024 at 7:08=E2=80=AFAM Pavel Vazharov <pavel@x=
3me.net> wrote:
> > > >> >>>
> > > >> >>> On Sat, Jan 27, 2024 at 6:39=E2=80=AFAM Jakub Kicinski <kuba@k=
ernel.org> wrote:
> > > >> >>> >
> > > >> >>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> > > >> >>> > > > Well, it will be up to your application to ensure that i=
t is not. The
> > > >> >>> > > > XDP program will run before the stack sees the LACP mana=
gement traffic,
> > > >> >>> > > > so you will have to take some measure to ensure that any=
 such management
> > > >> >>> > > > traffic gets routed to the stack instead of to the DPDK =
application. My
> > > >> >>> > > > immediate guess would be that this is the cause of those=
 warnings?
> > > >> >>> > >
> > > >> >>> > > Thank you for the response.
> > > >> >>> > > I already checked the XDP program.
> > > >> >>> > > It redirects particular pools of IPv4 (TCP or UDP) traffic=
 to the application.
> > > >> >>> > > Everything else is passed to the Linux kernel.
> > > >> >>> > > However, I'll check it again. Just to be sure.
> > > >> >>> >
> > > >> >>> > What device driver are you using, if you don't mind sharing?
> > > >> >>> > The pass thru code path may be much less well tested in AF_X=
DP
> > > >> >>> > drivers.
> > > >> >>> These are the kernel version and the drivers for the 3 ports i=
n the
> > > >> >>> above bonding.
> > > >> >>> ~# uname -a
> > > >> >>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Lin=
ux
> > > >> >>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
> > > >> >>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Giga=
bit
> > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > >> >>>        ...
> > > >> >>>         Kernel driver in use: ixgbe
> > > >> >>> --
> > > >> >>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Giga=
bit
> > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > >> >>>         ...
> > > >> >>>         Kernel driver in use: ixgbe
> > > >> >>> --
> > > >> >>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Giga=
bit
> > > >> >>> SFI/SFP+ Network Connection (rev 01)
> > > >> >>>         ...
> > > >> >>>         Kernel driver in use: ixgbe
> > > >> >>>
> > > >> >>> I think they should be well supported, right?
> > > >> >>> So far, it seems that the present usage scenario should work a=
nd the
> > > >> >>> problem is somewhere in my code.
> > > >> >>> I'll double check it again and try to simplify everything in o=
rder to
> > > >> >>> pinpoint the problem.
> > > >> > I've managed to pinpoint that forcing the copying of the packets
> > > >> > between the kernel and the user space
> > > >> > (XDP_COPY) fixes the issue with the malformed LACPDUs and the no=
t
> > > >> > working bonding.
> > > >>
> > > >> (+Magnus)
> > > >>
> > > >> Right, okay, that seems to suggest a bug in the internal kernel co=
pying
> > > >> that happens on XDP_PASS in zero-copy mode. Which would be a drive=
r bug;
> > > >> any chance you could test with a different driver and see if the s=
ame
> > > >> issue appears there?
> > > >>
> > > >> -Toke
> > > > No, sorry.
> > > > We have only servers with Intel 82599ES with ixgbe drivers.
> > > > And one lab machine with Intel 82540EM with igb driver but we can't
> > > > set up bonding there
> > > > and the problem is not reproducible there.
> > >
> > > Right, okay. Another thing that may be of some use is to try to captu=
re
> > > the packets on the physical devices using tcpdump. That should (I thi=
nk)
> > > show you the LACDPU packets as they come in, before they hit the bond=
ing
> > > device, but after they are copied from the XDP frame. If it's a packe=
t
> > > corruption issue, that should be visible in the captured packet; you =
can
> > > compare with an xdpdump capture to see if there are any differences..=
.
> >
> > Pavel,
> >
> > Sounds like an issue with the driver in zero-copy mode as it works
> > fine in copy mode. Maciej and I will take a look at it.
> >
> > > -Toke
> > >
>
> First I want to apologize for not responding for such a long time.
> I had different tasks the previous week and this week went back to this i=
ssue.
> I had to modify the code of the af_xdp driver inside the DPDK so that it =
loads
> the XDP program in a way which is compatible with the xdp-dispatcher.
> Finally, I was able to run our application with the XDP sockets and the x=
dpdump
> at the same time.
>
> Back to the issue.
> I just want to say again that we are not binding the XDP sockets to
> the bonding device.
> We are binding the sockets to the queues of the physical interfaces
> "below" the bonding device.
> My further observation this time is that when the issue happens and
> the remote device reports
> the LACP error there is no incoming LACP traffic on the corresponding
> local port,
> as seen by the xdump.
> The tcpdump at the same time sees only outgoing LACP packets and
> nothing incoming.
> For example:
> Remote device
>                           Local Server
> TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/12 <---> eth0
> TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/13 <---> eth2
> TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/14 <---> eth4
> And when the remote device reports "received an abnormal LACPDU"
> for PortName=3DXGigabitEthernet0/0/14 I can see via xdpdump that there
> is no incoming LACP traffic
> on eth4 but there is incoming LACP traffic on eth0 and eth2.
> At the same time, according to the dmesg the kernel sees all of the
> interfaces as
> "link status definitely up, 10000 Mbps full duplex".
> The issue goes aways if I stop the application even without removing
> the XDP programs
> from the interfaces - the running xdpdump starts showing the incoming
> LACP traffic immediately.
> The issue also goes away if I do "ip link set down eth4 && ip link set up=
 eth4".
> However, I'm not sure what happens with the bound XDP sockets in this cas=
e
> because I haven't tested further.
>
> It seems to me that something racy happens when the interfaces go down
> and back up
> (visible in the dmesg) when the XDP sockets are bound to their queues.
> I mean, I'm not sure why the interfaces go down and up but setting
> only the XDP programs
> on the interfaces doesn't cause this behavior. So, I assume it's
> caused by the binding of the XDP sockets.
> It could be that the issue is not related to the XDP sockets but just
> to the down/up actions of the interfaces.
> On the other hand, I'm not sure why the issue is easily reproducible
> when the zero copy mode is enabled
> (4 out of 5 tests reproduced the issue).
> However, when the zero copy is disabled this issue doesn't happen
> (I tried 10 times in a row and it doesn't happen).
>
> Pavel.

My thoughts at the end are not correct. I forgot that we tested with
traffic too.
Even when the bonding/LACP looked OK after the application start, it starte=
d
breaking later when the traffic is started for the case of zero copy mode.
However, it worked OK when the zero copy is disabled.

Pavel.

