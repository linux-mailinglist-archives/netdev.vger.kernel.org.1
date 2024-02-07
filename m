Return-Path: <netdev+bounces-69875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B707184CE62
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5594D1F228FE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B67FBD8;
	Wed,  7 Feb 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="WBhSTNNs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601F7FBBD
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321002; cv=none; b=Okhp/rNsk4pXUsdUbbPehumJO8C2rMt0ogoTBBl/ieUx97gUEZNSBu+OibfHUbhiS3x9ooMfqOkN5Ked7HPqmCRrFjOj/AbDZkSfGVK802GxPdwHCrDYy80xQQn5VX+jimiIlk61QKVQom72arP7tPE4KLQm1Gcpk3aJ+Nn7MXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321002; c=relaxed/simple;
	bh=PuxOPI9GtQTqVKb/cEBu7U5amm0xWWglEeQw1w6E09A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6vDoy1qhZIghP3KoNRM1mPt8mUCfqJAiUtZwoBIUyspDf8Hx8mRGEI7wQsowgJCYCYpPIM84mmU20OpDv5Ecihf8478QV70Lb4fok6rdO18RndxI4rG0gzWfFqP54EAYVnRJgznQtCroNlotuZATqk26BTqqtpy/FM0prIQRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=WBhSTNNs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3884b1a441so76522766b.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1707320998; x=1707925798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KihyLuehBPaOluvkUjJsmeEWlla7MFhjTkYXQedupOk=;
        b=WBhSTNNspQocj2J5UF7VP9uFQAkuX3hMG/lg2AlfixE92EnzvuRY5dogA4eMJpYK05
         9+19bz7k0Cw3826SfGIoH/PalAtLFsBIx8cMfjWc6xHSUlkdAxP9bHDL8PNdoi2yqlFy
         la8R+nCOKk2ilnsIGLVHLQvbsp1vyZGVDbDVzv+pv/pMBIoRHL85ysdqNeJufnVmjUnK
         LI/XBWuuyOazqiYRY/8+U048dVxzg3gLFdUiLzTPvI2LVgFXPcKub3QcTiOoxWAIPL0n
         jqYvEV9Mlol2gh0Cerl9FPgNEWlEQR2HFDVB3A6xLZMGWx+VuXF/8dGyclwdxvLh1Zdt
         2/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320998; x=1707925798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KihyLuehBPaOluvkUjJsmeEWlla7MFhjTkYXQedupOk=;
        b=dvWTrHEpNiI3oPjqNroTFtS5Z57OnI718LUpcer60+58AFVT507YDEmKecCyI31bX8
         6BM84sVZgUZAsqGWM/mpTlAdpeVHYA44vZwoyGO3GjYYoetXFCQq8F8TcDGoqUiJJDkH
         yUzpF7pVg2b+HYKCn+DnucY5unN9gE0muVfyX5xW/BJK6f9nvadsGXaaZreXow54oxQ9
         4FmuXtCcj1kyAUPLWCcypJLrg281rIg8+L4Y2KcFKgjo2Fg9rE9qJuNmQKV9jUT/AfQ/
         dA/YUCWE6Hq1fT9Wjcv/+8kRDqKFOxcS2nFl+tx/j7hS9lBR+FUXWGcudbRN53q2ErAZ
         o3WA==
X-Forwarded-Encrypted: i=1; AJvYcCXwDqqX+8HSGTf8ORWQg1QXouf+6mykKVRUuL0K2oSKMDAZZVUngAMBB8L99R1YMQNYHqoBTF+vBuxHUMAIlhhU+pOGX5Sd
X-Gm-Message-State: AOJu0YxQ1VdRme8Cs4hebbCLgKtjkYfFTQMWwC1CpSbS20C21DWBLHpP
	X8/0yGbzHvuK+pny5NyYbw1LMFSBnhRLxse+DNbG4+FadejwgPWSSude6YL4sW6QlddqnsvyXO+
	LNNr0GPJaS1yBKKtLh6KsoKClMT1bceoMk7CuHg==
X-Google-Smtp-Source: AGHT+IEgBR8gGvAxLaP970qvbN+LJGI7VBrCWdFTzZE4NiIoM3Z2qdA4CD8xtYFvHABXYRieXqoUX0BIDPptCI/wrqw=
X-Received: by 2002:a17:906:314a:b0:a38:35c5:76f0 with SMTP id
 e10-20020a170906314a00b00a3835c576f0mr3823751eje.11.1707320998494; Wed, 07
 Feb 2024 07:49:58 -0800 (PST)
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
In-Reply-To: <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
From: Pavel Vazharov <pavel@x3me.net>
Date: Wed, 7 Feb 2024 17:49:47 +0200
Message-ID: <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 9:07=E2=80=AFAM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> On Tue, 30 Jan 2024 at 15:54, Toke H=C3=B8iland-J=C3=B8rgensen <toke@kern=
el.org> wrote:
> >
> > Pavel Vazharov <pavel@x3me.net> writes:
> >
> > > On Tue, Jan 30, 2024 at 4:32=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@kernel.org> wrote:
> > >>
> > >> Pavel Vazharov <pavel@x3me.net> writes:
> > >>
> > >> >> On Sat, Jan 27, 2024 at 7:08=E2=80=AFAM Pavel Vazharov <pavel@x3m=
e.net> wrote:
> > >> >>>
> > >> >>> On Sat, Jan 27, 2024 at 6:39=E2=80=AFAM Jakub Kicinski <kuba@ker=
nel.org> wrote:
> > >> >>> >
> > >> >>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
> > >> >>> > > > Well, it will be up to your application to ensure that it =
is not. The
> > >> >>> > > > XDP program will run before the stack sees the LACP manage=
ment traffic,
> > >> >>> > > > so you will have to take some measure to ensure that any s=
uch management
> > >> >>> > > > traffic gets routed to the stack instead of to the DPDK ap=
plication. My
> > >> >>> > > > immediate guess would be that this is the cause of those w=
arnings?
> > >> >>> > >
> > >> >>> > > Thank you for the response.
> > >> >>> > > I already checked the XDP program.
> > >> >>> > > It redirects particular pools of IPv4 (TCP or UDP) traffic t=
o the application.
> > >> >>> > > Everything else is passed to the Linux kernel.
> > >> >>> > > However, I'll check it again. Just to be sure.
> > >> >>> >
> > >> >>> > What device driver are you using, if you don't mind sharing?
> > >> >>> > The pass thru code path may be much less well tested in AF_XDP
> > >> >>> > drivers.
> > >> >>> These are the kernel version and the drivers for the 3 ports in =
the
> > >> >>> above bonding.
> > >> >>> ~# uname -a
> > >> >>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Linux
> > >> >>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
> > >> >>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabi=
t
> > >> >>> SFI/SFP+ Network Connection (rev 01)
> > >> >>>        ...
> > >> >>>         Kernel driver in use: ixgbe
> > >> >>> --
> > >> >>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabi=
t
> > >> >>> SFI/SFP+ Network Connection (rev 01)
> > >> >>>         ...
> > >> >>>         Kernel driver in use: ixgbe
> > >> >>> --
> > >> >>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabi=
t
> > >> >>> SFI/SFP+ Network Connection (rev 01)
> > >> >>>         ...
> > >> >>>         Kernel driver in use: ixgbe
> > >> >>>
> > >> >>> I think they should be well supported, right?
> > >> >>> So far, it seems that the present usage scenario should work and=
 the
> > >> >>> problem is somewhere in my code.
> > >> >>> I'll double check it again and try to simplify everything in ord=
er to
> > >> >>> pinpoint the problem.
> > >> > I've managed to pinpoint that forcing the copying of the packets
> > >> > between the kernel and the user space
> > >> > (XDP_COPY) fixes the issue with the malformed LACPDUs and the not
> > >> > working bonding.
> > >>
> > >> (+Magnus)
> > >>
> > >> Right, okay, that seems to suggest a bug in the internal kernel copy=
ing
> > >> that happens on XDP_PASS in zero-copy mode. Which would be a driver =
bug;
> > >> any chance you could test with a different driver and see if the sam=
e
> > >> issue appears there?
> > >>
> > >> -Toke
> > > No, sorry.
> > > We have only servers with Intel 82599ES with ixgbe drivers.
> > > And one lab machine with Intel 82540EM with igb driver but we can't
> > > set up bonding there
> > > and the problem is not reproducible there.
> >
> > Right, okay. Another thing that may be of some use is to try to capture
> > the packets on the physical devices using tcpdump. That should (I think=
)
> > show you the LACDPU packets as they come in, before they hit the bondin=
g
> > device, but after they are copied from the XDP frame. If it's a packet
> > corruption issue, that should be visible in the captured packet; you ca=
n
> > compare with an xdpdump capture to see if there are any differences...
>
> Pavel,
>
> Sounds like an issue with the driver in zero-copy mode as it works
> fine in copy mode. Maciej and I will take a look at it.
>
> > -Toke
> >

First I want to apologize for not responding for such a long time.
I had different tasks the previous week and this week went back to this iss=
ue.
I had to modify the code of the af_xdp driver inside the DPDK so that it lo=
ads
the XDP program in a way which is compatible with the xdp-dispatcher.
Finally, I was able to run our application with the XDP sockets and the xdp=
dump
at the same time.

Back to the issue.
I just want to say again that we are not binding the XDP sockets to
the bonding device.
We are binding the sockets to the queues of the physical interfaces
"below" the bonding device.
My further observation this time is that when the issue happens and
the remote device reports
the LACP error there is no incoming LACP traffic on the corresponding
local port,
as seen by the xdump.
The tcpdump at the same time sees only outgoing LACP packets and
nothing incoming.
For example:
Remote device
                          Local Server
TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/12 <---> eth0
TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/13 <---> eth2
TrunkName=3DEth-Trunk20, PortName=3DXGigabitEthernet0/0/14 <---> eth4
And when the remote device reports "received an abnormal LACPDU"
for PortName=3DXGigabitEthernet0/0/14 I can see via xdpdump that there
is no incoming LACP traffic
on eth4 but there is incoming LACP traffic on eth0 and eth2.
At the same time, according to the dmesg the kernel sees all of the
interfaces as
"link status definitely up, 10000 Mbps full duplex".
The issue goes aways if I stop the application even without removing
the XDP programs
from the interfaces - the running xdpdump starts showing the incoming
LACP traffic immediately.
The issue also goes away if I do "ip link set down eth4 && ip link set up e=
th4".
However, I'm not sure what happens with the bound XDP sockets in this case
because I haven't tested further.

It seems to me that something racy happens when the interfaces go down
and back up
(visible in the dmesg) when the XDP sockets are bound to their queues.
I mean, I'm not sure why the interfaces go down and up but setting
only the XDP programs
on the interfaces doesn't cause this behavior. So, I assume it's
caused by the binding of the XDP sockets.
It could be that the issue is not related to the XDP sockets but just
to the down/up actions of the interfaces.
On the other hand, I'm not sure why the issue is easily reproducible
when the zero copy mode is enabled
(4 out of 5 tests reproduced the issue).
However, when the zero copy is disabled this issue doesn't happen
(I tried 10 times in a row and it doesn't happen).

Pavel.

